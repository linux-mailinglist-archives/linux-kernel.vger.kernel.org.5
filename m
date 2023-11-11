Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6BE7E8BD7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 18:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjKKRTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 12:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKKRTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 12:19:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B763868
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 09:19:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C2DC433C8;
        Sat, 11 Nov 2023 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699723147;
        bh=NgpKnj5nzW/ae95+vZHVPjMxvDXA89DOUJ9HvG7wcRg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hFKFk+ZamKmhKyj7bEJVHKQQ1UL6rBZnH9b8IwFaQflQC0QDjGiR8TW+vR2jfuH5F
         cANfiI4eIvdmmyIUqoXiRpJC4s7BxEvWM9oh1SOwBP/kdL4Yk8j9+NfqVYlSQpB1hO
         6bFisDNKhGV9lGq/O7MZStKzfpUNVqOGTNikgZ4FBpwqvQ4PnXHgy15fcm3LnKdlka
         UqH4WHVRR44ISDNH0scX2ITCDFZz6qbUG/EkCkheyKe10W41KlEfTmvmDZlHGbr24R
         J5G6ziaMn6j191JLlKPmjSH9rz/sPK96QLPCJmT20V+qeocSSGy67LHqpy8m1tfc/X
         MAwiRifHVFSiQ==
Message-ID: <f59c200f-4659-4c71-8c83-4457d0b08fe1@kernel.org>
Date:   Sat, 11 Nov 2023 10:19:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
Content-Language: en-US
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Mina Almasry <almasrymina@google.com>,
        David Wei <dw@davidwei.uk>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-6-almasrymina@google.com>
 <3b0d612c-e33b-48aa-a861-fbb042572fc9@kernel.org>
 <CAHS8izOHYx+oYnzksUDrK1S0+6CdMJmirApntP5W862yFumezw@mail.gmail.com>
 <a5b95e6b-8716-4e2e-9183-959b754b5b5e@kernel.org>
 <CAHS8izMKDOw5_y2MLRfuJHs=ai+sZ6GF7Rg1NuR_JqONg-5u5Q@mail.gmail.com>
 <3687e70e-29e6-34af-c943-8c0830ff92b8@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <3687e70e-29e6-34af-c943-8c0830ff92b8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 7:26 AM, Pavel Begunkov wrote:
> On 11/7/23 23:03, Mina Almasry wrote:
>> On Tue, Nov 7, 2023 at 2:55 PM David Ahern <dsahern@kernel.org> wrote:
>>>
>>> On 11/7/23 3:10 PM, Mina Almasry wrote:
>>>> On Mon, Nov 6, 2023 at 3:44 PM David Ahern <dsahern@kernel.org> wrote:
>>>>>
>>>>> On 11/5/23 7:44 PM, Mina Almasry wrote:
>>>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>>>> index eeeda849115c..1c351c138a5b 100644
>>>>>> --- a/include/linux/netdevice.h
>>>>>> +++ b/include/linux/netdevice.h
>>>>>> @@ -843,6 +843,9 @@ struct netdev_dmabuf_binding {
>>>>>>   };
>>>>>>
>>>>>>   #ifdef CONFIG_DMA_SHARED_BUFFER
>>>>>> +struct page_pool_iov *
>>>>>> +netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
>>>>>> +void netdev_free_devmem(struct page_pool_iov *ppiov);
>>>>>
>>>>> netdev_{alloc,free}_dmabuf?
>>>>>
>>>>
>>>> Can do.
>>>>
>>>>> I say that because a dmabuf can be host memory, at least I am not
>>>>> aware
>>>>> of a restriction that a dmabuf is device memory.
>>>>>
>>>>
>>>> In my limited experience dma-buf is generally device memory, and
>>>> that's really its use case. CONFIG_UDMABUF is a driver that mocks
>>>> dma-buf with a memfd which I think is used for testing. But I can do
>>>> the rename, it's more clear anyway, I think.
>>>
>>> config UDMABUF
>>>          bool "userspace dmabuf misc driver"
>>>          default n
>>>          depends on DMA_SHARED_BUFFER
>>>          depends on MEMFD_CREATE || COMPILE_TEST
>>>          help
>>>            A driver to let userspace turn memfd regions into dma-bufs.
>>>            Qemu can use this to create host dmabufs for guest
>>> framebuffers.
>>>
>>>
>>> Qemu is just a userspace process; it is no way a special one.
>>>
>>> Treating host memory as a dmabuf should radically simplify the io_uring
>>> extension of this set.
>>
>> I agree actually, and I was about to make that comment to David Wei's
>> series once I have the time.
>>
>> David, your io_uring RX zerocopy proposal actually works with devmem
>> TCP, if you're inclined to do that instead, what you'd do roughly is
>> (I think):
> That would be a Frankenstein's monster api with no good reason for it.

It brings a consistent API from a networking perspective.

io_uring should not need to be in the page pool and memory management
business. Have you or David coded up the re-use of the socket APIs with
dmabuf to see how much smaller it makes the io_uring change - or even
walked through from a theoretical perspective?


