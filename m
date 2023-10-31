Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5F47DD20A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbjJaQbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345184AbjJaQbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7CDA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698769830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ZhQHCTzkEZ31VTZ/X3IiLaeSZVmrJWT2/+nvVM5uzA=;
        b=FLoB403a5eWah66LJNQEQWQWLLr5VyWZPqXUrzFOrrYRz9WyqxtVavx3qyntOItAprCRmm
        YeHhovCYWxlADOwc8oi2WPGv5kCNXaL4cu/DEIDh/TCZfakHqf0ii9cTeot00IUZoOHfNx
        e9S8dsoY08rC3fZSwEBqtFSuT/QJwhE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-XIVR2yclO1qiVqqc1MfxSA-1; Tue, 31 Oct 2023 12:30:28 -0400
X-MC-Unique: XIVR2yclO1qiVqqc1MfxSA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-542d910f34bso2552781a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698769827; x=1699374627;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZhQHCTzkEZ31VTZ/X3IiLaeSZVmrJWT2/+nvVM5uzA=;
        b=uvFb48TPSGME0tzQk0azEkWTuQGMfdAtArS9Sey4TtOCCLOr7vuZotQ5Q5zkRXBqQA
         NViuGGHM/x5uXjXXw4r5TUJ9bPvarxQVsoa+xQTzF8HTwx8nQyEnDMQ1g/cuV+te0GhP
         dpwBIpEC87HB6xYquqzXnTD75ROu1TlSLbQA/7EE044t4kYlqW+4+bQDn/tzCJ2M8S28
         CVnL42P/0cg/Rpf5a2xnVIiJI4bgYuFBHp2XdDLgkZQNqJwCDHVtsp15AFfFx/D3dXsX
         2zcruzK0edivoiBkfO22HAyUig+wEQh/qGwiTmClM7iR8rVqzLweUic+L76+aXPKG2Dr
         kRNg==
X-Gm-Message-State: AOJu0YyziuuDzhbzX66gPSxTTz3tckFm9AIEhWOt763raDv0dwRlmdxy
        IeV2noAHmDexIO4TYzITDZCY7kWw/7GcDmnkicFEYgfRXjBTLlZ0wcE0MItzFNJ6eQAWCEi/Kwn
        z1TKN/WDSWX3rzzM69HEaa/kY7R4gGF2b
X-Received: by 2002:a17:906:ef09:b0:9d5:ecf9:e6a0 with SMTP id f9-20020a170906ef0900b009d5ecf9e6a0mr1777713ejs.0.1698769827308;
        Tue, 31 Oct 2023 09:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX8dKBeAvhU51+CB8hLv9HVKwlXbjill4FYjvxDmNT9fu1enl1Wlr1U6yt6UOWcwxS2AqOQg==
X-Received: by 2002:a17:906:ef09:b0:9d5:ecf9:e6a0 with SMTP id f9-20020a170906ef0900b009d5ecf9e6a0mr1777688ejs.0.1698769826905;
        Tue, 31 Oct 2023 09:30:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id me7-20020a170906aec700b009c3f1b3e988sm1225376ejb.90.2023.10.31.09.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 09:30:26 -0700 (PDT)
Message-ID: <1e2acafb-fbc3-4256-b1e1-3fe6c47b1ef2@redhat.com>
Date:   Tue, 31 Oct 2023 17:30:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next v7 4/7] drm/gpuvm: add an abstraction for a
 VM / BO combination
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20231023201659.25332-1-dakr@redhat.com>
 <20231023201659.25332-5-dakr@redhat.com>
 <f00a4975cf32c3ae28124343a2c994acda083829.camel@linux.intel.com>
 <87zfzz3thp.fsf@intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <87zfzz3thp.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 12:45, Jani Nikula wrote:
> On Tue, 31 Oct 2023, Thomas Hellström <thomas.hellstrom@linux.intel.com> wrote:
>> On Mon, 2023-10-23 at 22:16 +0200, Danilo Krummrich wrote:
>>> + * Returns: a pointer to the &drm_gpuvm_bo on success, NULL on
>>
>> Still needs s/Returns:/Return:/g
> 
> FWIW, both work to accommodate the variance across the kernel, although
> I think only the latter is documented and recommended. It's also the
> most popular:
> 
>    10577 Return
>     3596 Returns

I'd like to keep "Returns", since that's what GPUVM uses already everywhere else.

>     1104 RETURN
>      568 return
>      367 returns
>      352 RETURNS
>        1 RETURNs
> 
> BR,
> Jani.
> 
> 

