Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EFA80AB56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574545AbjLHRzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574499AbjLHRzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:55:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7702FA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:55:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C37C433C8;
        Fri,  8 Dec 2023 17:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702058106;
        bh=JgZX3IUxr5QjMN2L4CfeQWIXpX0PnQ2euhMWDoEDapU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ffQMD2auV5w+fsPXOpLjjMdU1ohOWFKct2g6oLxTffd+jY0euyAOdzi/eqD61jlc+
         HQog2qKV7NuXXul2OZwYKSbvrILIZs0XzeLqtAvKUA4/XQKUYj0GCwO8BZEcxFJAZ4
         GLm3pcSpziEsxyQImevNBJZiHEQ8JkkB+a9n6UqqffPLT5eqXSY4Nx6h0P0+mdoyhV
         1yb+zJMYP0R8FKtdnus7PhqoTZwJkmDhleXYtnwpOHALRaHKPwGAKUXVLbVD89Ec0l
         fXneCel4rLSIqmz3W4sSAXZ8gZYi+HGbH/qhPlVwKwHjNEGwB5ADQloXnigiu+qOwX
         MSXnnWbvmdStw==
Message-ID: <dd47a2a4-cb80-4164-8855-045999931a8e@kernel.org>
Date:   Fri, 8 Dec 2023 10:55:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1 13/16] tcp: RX path for devmem TCP
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-14-almasrymina@google.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231208005250.2910004-14-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/23 5:52 PM, Mina Almasry wrote:
> In tcp_recvmsg_locked(), detect if the skb being received by the user
> is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVMEM
> flag - pass it to tcp_recvmsg_devmem() for custom handling.
> 
> tcp_recvmsg_devmem() copies any data in the skb header to the linear
> buffer, and returns a cmsg to the user indicating the number of bytes
> returned in the linear buffer.
> 
> tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
> and returns to the user a cmsg_devmem indicating the location of the
> data in the dmabuf device memory. cmsg_devmem contains this information:
> 
> 1. the offset into the dmabuf where the payload starts. 'frag_offset'.
> 2. the size of the frag. 'frag_size'.
> 3. an opaque token 'frag_token' to return to the kernel when the buffer
> is to be released.
> 
> The pages awaiting freeing are stored in the newly added
> sk->sk_user_pages, and each page passed to userspace is get_page()'d.
> This reference is dropped once the userspace indicates that it is
> done reading this page.  All pages are released when the socket is
> destroyed.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> Changes in v1:
> - Added dmabuf_id to dmabuf_cmsg (David/Stan).
> - Devmem -> dmabuf (David).
> - Change tcp_recvmsg_dmabuf() check to skb->dmabuf (Paolo).
> - Use __skb_frag_ref() & napi_pp_put_page() for refcounting (Yunsheng).
> 
> RFC v3:
> - Fixed issue with put_cmsg() failing silently.
> 

What happens if a retransmitted packet is received or an rx window is
closed and a probe is received where the kernel drops the skb - is the
iov reference(s) in the skb returned to the pool by the stack and ready
for use again?
