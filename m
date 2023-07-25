Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0064D76271A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGYW6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGYW6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC862681
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690325724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqtwPYmHGNsoP1pFuN8jF45AEQfTNG8g69I653X2PAs=;
        b=coIxTWlBFt7DxqhYdq6clg0eCa8bVmqNmUBfFmiNfW1Rp7LFZwyXmTsoMhaET5bII+wQJq
        zxcmM46Uk46Y1ynwe30+0imH1M9Di7Qsc0YmtOrQkwv81pYcl1Ht+/Haf3n4MxwDIC/VVP
        ThWiRpnZqyhYS12DaIY9gmFAPgO+bNE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-VmRFm4C_PnW2jw5yCArkmg-1; Tue, 25 Jul 2023 18:48:46 -0400
X-MC-Unique: VmRFm4C_PnW2jw5yCArkmg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-98e40d91fdfso350377166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690325325; x=1690930125;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqtwPYmHGNsoP1pFuN8jF45AEQfTNG8g69I653X2PAs=;
        b=f4S2MO1qvA4Q1cb3Co1Z4KH0O5vOQ18pCGRR8Scg9ia8hSA+UlB+ziSTveD12ujKZV
         iuIUXsSCOU7aSoOFmV5vwVvpZD4wC7YsSYZoCuQJPjQs86W59WBFOCqJFmlaUhL1cREE
         1swIfJpMjPv01A49uipCkSzvv5C7GaJhZl+NGphXFVQsmEApWMNV0s5xrZJmMWlJPYtK
         HnLtgWCnT47t3Z95Q5shJnNdIxGgmC1ByKNIXmVML4+cHse6vNBo5GkYgCEBZOrce5Ci
         qIWF9tCKF5uzOHA3wOTiiMaVQtobdE3zPcpoENP7Ty2u8N1bv99JusphQwVDKAgOv4Mj
         51DQ==
X-Gm-Message-State: ABy/qLYpaW9NVBpoR/3Ks9WreGh64DznRmqa85guGWGbybYC+/bLxlmL
        ay0rQ27nrKhyzdyVYdRHjfgx3j6fUDErqVtuqar2K/J31qvukA9ALCTiZHGavhxuwIZW+k1I3cU
        6G1Qs19J7UWbsKPnIyjR4Y4Rg
X-Received: by 2002:a17:907:2be9:b0:982:7545:efb6 with SMTP id gv41-20020a1709072be900b009827545efb6mr158286ejc.66.1690325324933;
        Tue, 25 Jul 2023 15:48:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFjV59E7oAEbgLcfuvqGzUWbSIkW/kHUTr3BMaofJ0Plmev7uMfuohC5/16L7eW3+4p7WZnVA==
X-Received: by 2002:a17:907:2be9:b0:982:7545:efb6 with SMTP id gv41-20020a1709072be900b009827545efb6mr158266ejc.66.1690325324597;
        Tue, 25 Jul 2023 15:48:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id lg23-20020a170906f89700b0098733a40bb7sm8814043ejb.155.2023.07.25.15.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 15:48:44 -0700 (PDT)
Message-ID: <21ea63fe-33d7-a075-7291-35dd1b2a9b64@redhat.com>
Date:   Tue, 25 Jul 2023 23:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH drm-misc-next v8 11/12] drm/nouveau: implement new VM_BIND
 uAPI
Content-Language: en-US
From:   Danilo Krummrich <dakr@redhat.com>
To:     Faith Ekstrand <faith@gfxstrand.net>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net,
        donald.robson@imgtec.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230720001443.2380-1-dakr@redhat.com>
 <20230720001443.2380-12-dakr@redhat.com>
 <CAOFGe945tp344=g-++=EAT89t0qJHZ=3yeW-k9OTbGNJodvwAg@mail.gmail.com>
 <542203c6-781a-dc44-6fa1-13cd20ab9e21@redhat.com>
 <CAOFGe94sG5==GM+spcTihcAtMCoj2xZYpN8NsYE6CEckdHJ8rQ@mail.gmail.com>
 <75c86224-6183-07fe-da04-6a2101615a50@redhat.com>
Organization: RedHat
In-Reply-To: <75c86224-6183-07fe-da04-6a2101615a50@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 18:43, Danilo Krummrich wrote:
> On 7/25/23 18:16, Faith Ekstrand wrote:
>> Thanks for the detailed write-up! That would definitely explain it. If 
>> I remember, I'll try to do a single-threaded run or two. If your 
>> theory is correct, there should be no real perf difference when 
>> running single-threaded. Those runs will take a long time, though, so 
>> I'll have to run them over night. I'll let you know in a few days once 
>> I have the results.
> 
> I can also push a separate branch where I just print out a warning 
> whenever we run into such a condition including the time we were waiting 
> for things to complete. I can probably push something later today.

https://gitlab.freedesktop.org/nouvelles/kernel/-/tree/new-uapi-drm-next-track-stalls

It prints out the duration of every wait as well as the total wait time 
since boot.

- Danilo

> 
>>
>> If this theory holds, then I'm not concerned about the performance of 
>> the API itself. It would still be good to see if we can find a way to 
>> reduce the cross-process drag in the implementation but that's a perf 
>> optimization we can do later.
> 
>  From the kernel side I think the only thing we could really do is to 
> temporarily run a secondary drm_gpu_scheduler instance, one for VM_BINDs 
> and one for EXECs until we got the new page table handling in place.
> 
> However, the UMD could avoid such conditions more effectively, since it 
> controls the address space. Namely, avoid re-using the same region of 
> the address space right away in certain cases. For instance, instead of 
> replacing a sparse region A[0x0, 0x4000000] with a larger sparse region 
> B[0x0, 0x8000000], replace it with B'[0x4000000, 0xC000000] if possible.
> 
> However, just mentioning this for completeness. The UMD surely shouldn't 
> probably even temporarily work around such a kernel limitation.
> 
> Anyway, before doing any of those, let's see if the theory holds and 
> we're actually running into such cases.
> 
>>
>> Does it actually matter? Yes, it kinda does. No, it probably doesn't 
>> matter for games because you're typically only running one game at a 
>> time. From a development PoV, however, if it makes CI take longer then 
>> that slows down development and that's not good for the users, either.
> 
> Fully agree.
> 
> - Danilo
> 
>>
>> ~Faith
>>
>>     - Danilo
>>
>>      >
>>      > ~Faith
>>      >
>>

