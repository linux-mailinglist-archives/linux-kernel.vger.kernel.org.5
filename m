Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9A781324A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjLNN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjLNN5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:57:16 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B220A7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:57:23 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28b0cee2abaso434594a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702562242; x=1703167042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jpS4/YpWlHXphGbgZwi2ZTYcCMufm/oKHMDiir1pd4=;
        b=S2EAKUku5+jNe0+Ut5VugDrpq6RdLvGb9Gr7DOcRn0Kew6syWYigYeeCFfT22s8oCA
         Rt8w5fUPZb+5wpgSLbMiIU8fmUjHkXfncOLhxaHZ+KN7p4d5/+/ul71e2fRKX2Zxx3rj
         mco2RY+25eJy7qQUh2tj3kNNZ6K6n/pNkS/nAzK29/0AqCjmuH6s2IhW/WzS0+7u0OQ6
         p4ivpwEcFsDZosl7xdkiFtaD3ewaE5LU6aM0yC0wQNkgshUiMOxkD7BNPZE6RHXIo7DH
         ujX7y2BzBqX72w8m6S6r1KBa9OxkmNb8CQazvQCR+PPtGc8fXnsNH0bJRlEEcvqvSXj2
         Hu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562242; x=1703167042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jpS4/YpWlHXphGbgZwi2ZTYcCMufm/oKHMDiir1pd4=;
        b=PnOZi9msgVlNxDXk57akpiSV51DYATRw1SbODrjvia+Upa3HB3wKBCXaodr3ZeF+xZ
         u7OpelupgsKT8OaCvKzhCy2WqtTMDijlkL0yh6zg0TiZ+8AB22drR1aIYExHV4STKrZL
         Ty7qjAPiAQUd/W894q+JnRXRJtCePDuxoame9IzkYrLOT0J+oIbC51FLMh3Md+hU00VJ
         NxsQwL+BAqFGZAbQ+MANLvR0q0huf/lYhtlFoBGVPLiU2lh7z35JNKKTQORBubBL4xjU
         TnoNVjOcCSq6sjeDnXCPu8qPHt73bEDXIVfBzkJkWnaiK/oloDL/d4VxVxwpca/vIRDV
         GeRw==
X-Gm-Message-State: AOJu0YwFd92EXSoKFZro5iws54qYu2mZ0dT4avoM2oUnBT7495iJQckM
        Xik6Cv0ZEvaormUk0T8w7N2n6A==
X-Google-Smtp-Source: AGHT+IFCxZxoOervUq8eNwK3GyWYgLG1/QyB3b7O+HlUPJQTeudBq2nvDK6OJuRXpq6jqpzgBgLl9Q==
X-Received: by 2002:a17:90b:b93:b0:286:9e2f:475c with SMTP id bd19-20020a17090b0b9300b002869e2f475cmr7568315pjb.47.1702562242612;
        Thu, 14 Dec 2023 05:57:22 -0800 (PST)
Received: from ?IPV6:2409:8a28:e64:34f0:4525:57e4:217e:6e2c? ([2409:8a28:e64:34f0:4525:57e4:217e:6e2c])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090a348c00b00286f2b39a95sm14225348pjb.31.2023.12.14.05.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 05:57:22 -0800 (PST)
Message-ID: <7a8c77b0-c78c-427d-9545-2b328c7dc727@bytedance.com>
Date:   Thu, 14 Dec 2023 21:57:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/zswap: change dstmem size to one page
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-2-896763369d04@bytedance.com>
 <CAJD7tkZJRgf+502QU_ECVPey0w-5vw_e6HSL+Ay7unetq5gL0A@mail.gmail.com>
 <CAKEwX=P4=YbvoRCa5+BB+==f4YL_5-6AaUNUCdH3v2faTx-PYQ@mail.gmail.com>
 <cb558f85-4f9b-4eb9-b60c-9b609075920d@bytedance.com>
 <CAJD7tkY_fe9SeTxOSVmYHNgi2tKvZ+EoM15KifJihF_Zn_LqDg@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkY_fe9SeTxOSVmYHNgi2tKvZ+EoM15KifJihF_Zn_LqDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/14 21:37, Yosry Ahmed wrote:
> On Thu, Dec 14, 2023 at 5:33 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2023/12/14 08:18, Nhat Pham wrote:
>>> On Wed, Dec 13, 2023 at 3:34 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>>
>>>> On Tue, Dec 12, 2023 at 8:18 PM Chengming Zhou
>>>> <zhouchengming@bytedance.com> wrote:
>>>>>
>>>>> Change the dstmem size from 2 * PAGE_SIZE to only one page since
>>>>> we only need at most one page when compress, and the "dlen" is also
>>>>> PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_SIZE
>>>>> we don't wanna store the output in zswap anyway.
>>>>>
>>>>> So change it to one page, and delete the stale comment.
>>>>
>>>> I couldn't find the history of why we needed 2 * PAGE_SIZE, it would
>>>> be nice if someone has the context, perhaps one of the maintainers.
>>>
>>> It'd be very nice indeed.
>>>
>>>>
>>>> One potential reason is that we used to store a zswap header
>>>> containing the swap entry in the compressed page for writeback
>>>> purposes, but we don't do that anymore. Maybe we wanted to be able to
>>>> handle the case where an incompressible page would exceed PAGE_SIZE
>>>> because of that?
>>>
>>> It could be hmm. I didn't study the old zswap architecture too much,
>>> but it has been 2 * PAGE_SIZE since the time zswap was first merged
>>> last I checked.
>>> I'm not 100% comfortable ACK-ing the undoing of something that looks
>>> so intentional, but FTR, AFAICT, this looks correct to me.
>>
>> Right, there is no any history about the reason why we needed 2 pages.
>> But obviously only one page is needed from the current code and no any
>> problem found in the kernel build stress testing.
> 
> Could you try manually stressing the compression with data that
> doesn't compress at all (i.e. dlen == PAGE_SIZE)? I want to make sure
> that this case is specifically handled. I think using data from
> /dev/random will do that but please double check that dlen ==
> PAGE_SIZE.

I just did the same kernel build testing, indeed there are a few cases
that output dlen == PAGE_SIZE.

bpftrace -e 'k:zpool_malloc {@[(uint32)arg1==4096]=count()}'

@[1]: 2
@[0]: 12011430
