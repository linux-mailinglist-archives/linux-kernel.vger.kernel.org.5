Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259BF8133DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573630AbjLNPD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573628AbjLNPDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:03:52 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087D3121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:03:35 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d351848c9fso9090045ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702566214; x=1703171014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpQnNUGEK78CSlHK0BOK2Wt8OQGIkPegoGE2UWWfI/k=;
        b=lqAn/oRij59dJWcZebmsJY9kKASa7m+Kx3agkacSylEFltU3Gi0ThNFcYLud36oTtA
         /o1fljrvFsZD8YmR03tPl0xvbf+qPCJuWXcSMobMTUSkipbugFrn4r8U6SSiBwS7/QDs
         MfRJMNZf6pDxcRb3EaULc1fuC50BVo4zvmv6s70Et+hLaKCes83zRVjWKWji9KV3GJgm
         F3sZ905j8/UmFJCO+WD6Gio1+vH3axgZj93iLtux13sIukf+PJggylVz3Xx2CNSVoXbS
         EHY6MQhyjLzqtNXIRxC8jtfn1NqqfvDgHmsuK+T1ZENhQO7UTJ7VJqUPubeGTP9FgRX6
         yF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566214; x=1703171014;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpQnNUGEK78CSlHK0BOK2Wt8OQGIkPegoGE2UWWfI/k=;
        b=gyEj4Tkj6XBPJnIa5BPsoiHYwZMzXCV0gVZqxVT7wSktaiMQs79upa5sA/2Kyy7RFR
         bxt89PH8QLw4qiOibgCGolrjxON5sM2e5HABchWnkB6f05voAzRVTQjyMgd7xAFD5hi8
         hdqGwbcPn26qjvKiCdIyzYJKfUORzF7dR5LjMIqJ+7sEyMfPJ4pSGDoxH/4f88Qtg/qQ
         py0yIrKZ0qbZeV7CGcEQ+Ab97bu+o4K/aqU/A6+78bETGLOBy6079ajqZFA2pW8eHBTZ
         Bf5LeAXpOrbmTITknzk46P7Cn9OoTgoOU3XmQ6PFfCiO+hkOUiRBA7YC5I6k/wy8VsN2
         cZ9Q==
X-Gm-Message-State: AOJu0YyIz9cb2Jb2B3tdHtN4NCLEeyvb88YXk0U2vhOpuhfOsCiah0is
        PUctmVsgbkuSm4hl89/sy1Ufmg==
X-Google-Smtp-Source: AGHT+IGYz/2+L0p5SsOU/NDOJKQnVfxunA2s6iKI7KEfAi+/IkBVaiEd6ovyb3samZgQxOKpywWTAg==
X-Received: by 2002:a17:90b:890:b0:286:6cc0:b90b with SMTP id bj16-20020a17090b089000b002866cc0b90bmr3947002pjb.66.1702566214512;
        Thu, 14 Dec 2023 07:03:34 -0800 (PST)
Received: from ?IPV6:2409:8a28:e64:34f0:4525:57e4:217e:6e2c? ([2409:8a28:e64:34f0:4525:57e4:217e:6e2c])
        by smtp.gmail.com with ESMTPSA id sf3-20020a17090b51c300b0028a42f9d3ebsm12147138pjb.53.2023.12.14.07.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 07:03:34 -0800 (PST)
Message-ID: <7a0e3229-be63-4a24-a3fe-7e3ff517de10@bytedance.com>
Date:   Thu, 14 Dec 2023 23:03:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/zswap: change dstmem size to one page
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
 <7a8c77b0-c78c-427d-9545-2b328c7dc727@bytedance.com>
In-Reply-To: <7a8c77b0-c78c-427d-9545-2b328c7dc727@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/14 21:57, Chengming Zhou wrote:
> On 2023/12/14 21:37, Yosry Ahmed wrote:
>> On Thu, Dec 14, 2023 at 5:33 AM Chengming Zhou
>> <zhouchengming@bytedance.com> wrote:
>>>
>>> On 2023/12/14 08:18, Nhat Pham wrote:
>>>> On Wed, Dec 13, 2023 at 3:34 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>>>
>>>>> On Tue, Dec 12, 2023 at 8:18 PM Chengming Zhou
>>>>> <zhouchengming@bytedance.com> wrote:
>>>>>>
>>>>>> Change the dstmem size from 2 * PAGE_SIZE to only one page since
>>>>>> we only need at most one page when compress, and the "dlen" is also
>>>>>> PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_SIZE
>>>>>> we don't wanna store the output in zswap anyway.
>>>>>>
>>>>>> So change it to one page, and delete the stale comment.
>>>>>
>>>>> I couldn't find the history of why we needed 2 * PAGE_SIZE, it would
>>>>> be nice if someone has the context, perhaps one of the maintainers.
>>>>
>>>> It'd be very nice indeed.
>>>>
>>>>>
>>>>> One potential reason is that we used to store a zswap header
>>>>> containing the swap entry in the compressed page for writeback
>>>>> purposes, but we don't do that anymore. Maybe we wanted to be able to
>>>>> handle the case where an incompressible page would exceed PAGE_SIZE
>>>>> because of that?
>>>>
>>>> It could be hmm. I didn't study the old zswap architecture too much,
>>>> but it has been 2 * PAGE_SIZE since the time zswap was first merged
>>>> last I checked.
>>>> I'm not 100% comfortable ACK-ing the undoing of something that looks
>>>> so intentional, but FTR, AFAICT, this looks correct to me.
>>>
>>> Right, there is no any history about the reason why we needed 2 pages.
>>> But obviously only one page is needed from the current code and no any
>>> problem found in the kernel build stress testing.
>>
>> Could you try manually stressing the compression with data that
>> doesn't compress at all (i.e. dlen == PAGE_SIZE)? I want to make sure
>> that this case is specifically handled. I think using data from
>> /dev/random will do that but please double check that dlen ==
>> PAGE_SIZE.
> 
> I just did the same kernel build testing, indeed there are a few cases
> that output dlen == PAGE_SIZE.
> 
> bpftrace -e 'k:zpool_malloc {@[(uint32)arg1==4096]=count()}'
> 
> @[1]: 2
> @[0]: 12011430

I think we shouldn't put these poorly compressed output into zswap,
maybe it's better to early return in these cases when compress ratio
< threshold ratio, which can be tune by the user?

e.g. in the same kernel build testing:

bpftrace -e 'k:zpool_malloc {@[(uint32)arg1>2048]=count()}'

@[1]: 1597706
@[0]: 10886138

