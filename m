Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C557753A97
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjGNMSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjGNMSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:18:43 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0800AA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=50OTjCdoe04eHZJMPt74za6C1P/cUdEzGRPeJlapH2Q=; b=MxX8/RLrkeair/1GtCYaQNguEu
        b1cjVO2v6bXacIX4QeE29DSl4kT5+V1LNYpETw3XujL7MzBtKeyxyocpfIrlBQf97IRJrJbCoxZP1
        eEe2nydPZFoA4OioPQOxOypfJPqTXPShLskR1OQurWfbeLfF1DMrlRg/Xm20U3pSmu1ncicVcihMj
        i3qwH5rNHg9Z/gZeMfL8U58/NM9qi/EgJpqj3hCQo09Ajere9NPbWw788uFWktRynSuCtPezp4KhO
        KAnllc7hfz2YeD3VcuFDXrWTPdz/zWZpqaHwKvl1jp7FQcFAB8Mcp1i96R/dlNOv+O3UYhQA6DmEa
        RuqEUjAQ==;
Received: from [187.74.70.209] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qKHkq-00EVJh-PB; Fri, 14 Jul 2023 14:18:37 +0200
Message-ID: <e4a29b97-2f82-f776-3898-98b0813fcaf0@igalia.com>
Date:   Fri, 14 Jul 2023 09:18:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/6] drm/amdgpu: Limit info in coredump for kernel
 threads
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, michel.daenzer@mailbox.org,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        alexander.deucher@amd.com, christian.koenig@amd.com
References: <20230713213242.680944-1-andrealmeid@igalia.com>
 <20230713213242.680944-5-andrealmeid@igalia.com>
 <72a40172-86a8-64c0-0c06-cbc670503370@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <72a40172-86a8-64c0-0c06-cbc670503370@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em 14/07/2023 04:52, Christian König escreveu:
> 
> 
> Am 13.07.23 um 23:32 schrieb André Almeida:
>> If a kernel thread caused the reset, the information available to be
>> logged will be limited, so return early in the dump function.
> 
> Why? The register values and vram lost state should still be valid.
> 

Fair enough, I was thinking about the new added information, such as 
ring and job, that won't be around for this type of thread. I'll drop 
this patch for the next version.

> Christian.
> 
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e80670420586..07546781b8b8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4988,10 +4988,14 @@ static ssize_t amdgpu_devcoredump_read(char 
>> *buffer, loff_t offset,
>>       drm_printf(&p, "kernel: " UTS_RELEASE "\n");
>>       drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>>       drm_printf(&p, "time: %lld.%09ld\n", 
>> coredump->reset_time.tv_sec, coredump->reset_time.tv_nsec);
>> -    if (coredump->reset_task_info.pid)
>> +    if (coredump->reset_task_info.pid) {
>>           drm_printf(&p, "process_name: %s PID: %d\n",
>>                  coredump->reset_task_info.process_name,
>>                  coredump->reset_task_info.pid);
>> +    } else {
>> +        drm_printf(&p, "GPU reset caused by a kernel thread\n");
>> +        return count - iter.remain;
>> +    }
>>       if (coredump->reset_vram_lost)
>>           drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> 
