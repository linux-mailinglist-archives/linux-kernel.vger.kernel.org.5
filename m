Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD0479AFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349620AbjIKVeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbjIKRuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52370D8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694454549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=St0OIFMZR2EddndtcFLYyMwK3Fvt2qDifveALpwjgwM=;
        b=Sh7gc3lqeFUAC4XSQ4dy7QHqZqIYliLGIe3IJTXaHDsGtPSVdET/uh6B5DKbhl+68VHuFU
        GvE4oEckKwfl+ntgBWfLdKA5IWU1kz8RQSRy3dOa+vORirwtMrI0eqPGItLespq/KdWAS7
        P7tyEKCl4o8YEhWISOqbqqPsEmHvSi4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-K_HMr2tgPtaBprKz6gyYqg-1; Mon, 11 Sep 2023 13:49:07 -0400
X-MC-Unique: K_HMr2tgPtaBprKz6gyYqg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a348facbbso324380966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694454546; x=1695059346;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=St0OIFMZR2EddndtcFLYyMwK3Fvt2qDifveALpwjgwM=;
        b=knXmf/UovwehfFF9TNlebAWvlvwqIzJ/sg87+APCRBc6VFIytPxBNg6DF+BrpIgCND
         76JfoU7HfKTlfuTVF+OsdICbbPUOPm4eO/UeIoM6BYbNW4wrJxsl9CKF5J00qPbMrrYV
         C9OYBMgd7GGlq5BZmrcg5iM/TyXfxvQvjY8gC+5aQck2l9HrPnAP13tTJjL/srX58bwQ
         rrJSy8TSQw+sXdO7EQSS02MEWplg05GlePLI6lTpswvoS4ibMbZPQ1A81E5tmaHFqe+W
         mLMzuYaz/ioMZ6iE4PZrL1Zs/wnJioWi1bgiwBa/Qis4sa9CsWM3pywriiG5AR0gaeqk
         IncA==
X-Gm-Message-State: AOJu0YwvcE9PhmnF/UK/Gs5QhJO1BJhJZBN0BrPAa1NRBWV9qbyJ5b+W
        c3LVEWt/lxH+k5Jb5mgVECBslLGZI9LJl9rOoKMqO8I5yyqhAnrfJodEUBdXlpNIdwJ4GqjOSdd
        Rsmyep6oMZZrfSY8k7OgMXAuDGBGfuxET
X-Received: by 2002:a17:906:9713:b0:9a1:be5b:f4aa with SMTP id k19-20020a170906971300b009a1be5bf4aamr7888317ejx.0.1694454546461;
        Mon, 11 Sep 2023 10:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJT7jpbp9w+Jd4iB1jj177KBarF5tpW4Kb+y9RLOsrxNRVTCbPPhmW6pX+J4jSq1kcXfWr9Q==
X-Received: by 2002:a17:906:9713:b0:9a1:be5b:f4aa with SMTP id k19-20020a170906971300b009a1be5bf4aamr7888308ejx.0.1694454546201;
        Mon, 11 Sep 2023 10:49:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id u24-20020a170906b11800b0099c971ba285sm5685580ejy.5.2023.09.11.10.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 10:49:05 -0700 (PDT)
Message-ID: <06bbb49d-974f-e3bb-f844-1509313066cc@redhat.com>
Date:   Mon, 11 Sep 2023 19:49:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v3 5/7] drm/gpuvm: add an abstraction for a
 VM / BO combination
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230909153125.30032-1-dakr@redhat.com>
 <20230909153125.30032-6-dakr@redhat.com>
 <0a8799c3-1d4c-8d87-ebca-013f6541fbc4@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <0a8799c3-1d4c-8d87-ebca-013f6541fbc4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 9/11/23 19:19, Thomas Hellström wrote:
> Hi, Danilo
> 
> On 9/9/23 17:31, Danilo Krummrich wrote:
>> This patch adds an abstraction layer between the drm_gpuva mappings of
>> a particular drm_gem_object and this GEM object itself. The abstraction
>> represents a combination of a drm_gem_object and drm_gpuvm. The
>> drm_gem_object holds a list of drm_gpuvm_bo structures (the structure
>> representing this abstraction), while each drm_gpuvm_bo contains list of
>> mappings of this GEM object.
>>
>> This has multiple advantages:
>>
>> 1) We can use the drm_gpuvm_bo structure to attach it to various lists
>>     of the drm_gpuvm. This is useful for tracking external and evicted
>>     objects per VM, which is introduced in subsequent patches.
>>
>> 2) Finding mappings of a certain drm_gem_object mapped in a certain
>>     drm_gpuvm becomes much cheaper.
>>
>> 3) Drivers can derive and extend the structure to easily represent
>>     driver specific states of a BO for a certain GPUVM.
>>
>> The idea of this abstraction was taken from amdgpu, hence the credit for
>> this idea goes to the developers of amdgpu.
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> 
> Did you consider having the drivers embed the struct drm_gpuvm_bo in their own bo definition? I figure that would mean using the gem bo's refcounting and providing a helper to call from the driver's bo release. Looks like that could potentially save a lot of code? Or is there something that won't work with that approach?

There are drm_gpuvm_ops::vm_bo_alloc and drm_gpuvm_ops::vm_bo_free callback for drivers to register for that purpose.

- Danilo

> 
> Thanks,
> 
> Thomas
> 
> 

