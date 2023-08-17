Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AC077F80A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351329AbjHQNqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351539AbjHQNpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:45:45 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879C12710
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g4xw+ubZUdy5UCfJVzSceKn+nYjWPWMzqkt6LVuLyZU=; b=jsSE7qCf0hXSEtTbihtX57rFdW
        HGpMwMO9e17BkV8Ik2VRWEucHPtA/Ws/PTe/EqCJsGzC4NbG40DOdjzAHI9V/4mHJ3nXGzckHvs7X
        UV9/MrGXuGcss6BG0LMQ3eNzN/fIrBswgtKObEJa0mZF4EolCAt5bdKgxCNfCwCduUDzTEOxo09bw
        oB3WL5VUM+yXduWkYzkHpqmnKmmpqPLUB1Tkf7fqFkqafwUV5ctVWe+/jgyRpylEczugOZ+DMgYoO
        1aoy1k0RghFaYdUfMLSd21fy79KeOUCRxOH1YEJiSU8OaIJ8KAWe+epzyQGlFCbZRjtj7VKkqOEFl
        ybZEjnbg==;
Received: from [191.193.179.209] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qWdJe-001vzc-TX; Thu, 17 Aug 2023 15:45:35 +0200
Message-ID: <a6e90991-91bb-4da9-ab67-d0ec28a29680@igalia.com>
Date:   Thu, 17 Aug 2023 10:45:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] drm/amdgpu: Rework coredump to use memory
 dynamically
Content-Language: en-US
To:     Shashank Sharma <shashank.sharma@amd.com>
Cc:     pierre-eric.pelloux-prayer@amd.com, amd-gfx@lists.freedesktop.org,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230815195100.294458-1-andrealmeid@igalia.com>
 <20230815195100.294458-3-andrealmeid@igalia.com>
 <07ef59db-da17-15cf-789a-7f5d01b2c9c9@amd.com>
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <07ef59db-da17-15cf-789a-7f5d01b2c9c9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shashank,

Em 17/08/2023 03:41, Shashank Sharma escreveu:
> Hello Andre,
> 
> On 15/08/2023 21:50, André Almeida wrote:
>> Instead of storing coredump information inside amdgpu_device struct,
>> move if to a proper separated struct and allocate it dynamically. This
>> will make it easier to further expand the logged information.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> v4: change kmalloc to kzalloc
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 14 +++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 63 ++++++++++++++--------
>>   2 files changed, 49 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 9c6a332261ab..0d560b713948 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1088,11 +1088,6 @@ struct amdgpu_device {
>>       uint32_t                        *reset_dump_reg_list;
>>       uint32_t            *reset_dump_reg_value;
>>       int                             num_regs;
>> -#ifdef CONFIG_DEV_COREDUMP
>> -    struct amdgpu_task_info         reset_task_info;
>> -    bool                            reset_vram_lost;
>> -    struct timespec64               reset_time;
>> -#endif
>>       bool                            scpm_enabled;
>>       uint32_t                        scpm_status;
>> @@ -1105,6 +1100,15 @@ struct amdgpu_device {
>>       uint32_t            aid_mask;
>>   };
>> +#ifdef CONFIG_DEV_COREDUMP
>> +struct amdgpu_coredump_info {
>> +    struct amdgpu_device        *adev;
>> +    struct amdgpu_task_info         reset_task_info;
>> +    struct timespec64               reset_time;
>> +    bool                            reset_vram_lost;
>> +};
> 
> The patch looks good to me in general, but I would recommend slightly 
> different arrangement and segregation of GPU reset information.
> 
> Please consider a higher level structure adev->gpu_reset_info, and move 
> everything related to reset dump info into that, including this new 
> coredump_info structure, something like this:
> 
> struct amdgpu_reset_info {
> 
>      uint32_t *reset_dump_reg_list;
> 
>      uint32_t *reset_dump_reg_value;
> 
>      int num_regs;
> 

Right, I can encapsulate there reset_dump members,

> #ifdef CONFIG_DEV_COREDUMP
> 
>     struct amdgpu_coredump_info *coredump_info;/* keep this dynamic 
> allocation */

but we don't need a pointer for amdgpu_coredump_info inside 
amdgpu_device or inside of amdgpu_device->gpu_reset_info, right?

> 
> #endif
> 
> }
> 
> 
> This will make sure that all the relevant information is at the same place.
> 
> - Shashank
> 
        amdgpu_inc_vram_lost(tmp_adev);
