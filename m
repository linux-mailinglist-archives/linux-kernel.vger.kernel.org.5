Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873F5753715
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbjGNJua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjGNJuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:50:08 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358D930EF;
        Fri, 14 Jul 2023 02:49:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9CAD05BC37;
        Fri, 14 Jul 2023 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689328188;
        bh=PC7GXXNDk15CT3rU7hYCpLMfS9lNq6DXUxfJ9HZPrS8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IPcsl7xZXqCSToAEy5I5oBtveILmM0LY+CIKTH+8cdBXnHWwvnXsOO1cLA46v9EfB
         xKmn/5TjJe3mMVTePdJ6HnHIQ1iNSWbNCduyWSaxLJnQbJ3TQMrgDFxLZ8ki1p1y66
         DZwq3nqBRlNzHp+5kXs+g7FttPXb8lTbV3zR1lFc37QCtDh5vky4MOnIpeXd+jKwKM
         MCQ7P5+87K6HuPRVJ+J8GZAzfSkNyc9Cj6ZcHiqrK+gojmeo+T7mwV1i2hOxw/V+UG
         RX3Q+PiMLcg1aANo/TfYm8M7Fn7dBQr1KQOiTvfyZ4eNDnf/XFMQAY0ZjS9bdHWIVI
         yL2JF5gtnDbTA==
Message-ID: <de502b41-2864-db1e-16a0-8a5d5e0e4ad3@asahilina.net>
Date:   Fri, 14 Jul 2023 18:49:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] drm/scheduler: Fix UAF in
 drm_sched_fence_get_timeline_name
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     Faith Ekstrand <faith.ekstrand@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, asahi@lists.linux.dev
References: <20230714-drm-sched-fixes-v1-0-c567249709f7@asahilina.net>
 <20230714-drm-sched-fixes-v1-2-c567249709f7@asahilina.net>
 <bef7ef62-3cd9-6ceb-5eb4-5ae0c0236778@amd.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <bef7ef62-3cd9-6ceb-5eb4-5ae0c0236778@amd.com>
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

On 14/07/2023 17.43, Christian König wrote:
> Am 14.07.23 um 10:21 schrieb Asahi Lina:
>> A signaled scheduler fence can outlive its scheduler, since fences are
>> independencly reference counted. Therefore, we can't reference the
>> scheduler in the get_timeline_name() implementation.
>>
>> Fixes oopses on `cat /sys/kernel/debug/dma_buf/bufinfo` when shared
>> dma-bufs reference fences from GPU schedulers that no longer exist.
>>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
>>    drivers/gpu/drm/scheduler/sched_entity.c | 7 ++++++-
>>    drivers/gpu/drm/scheduler/sched_fence.c  | 4 +++-
>>    include/drm/gpu_scheduler.h              | 5 +++++
>>    3 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index b2bbc8a68b30..17f35b0b005a 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -389,7 +389,12 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
>>    
>>    		/*
>>    		 * Fence is from the same scheduler, only need to wait for
>> -		 * it to be scheduled
>> +		 * it to be scheduled.
>> +		 *
>> +		 * Note: s_fence->sched could have been freed and reallocated
>> +		 * as another scheduler. This false positive case is okay, as if
>> +		 * the old scheduler was freed all of its jobs must have
>> +		 * signaled their completion fences.
> 
> This is outright nonsense. As long as an entity for a scheduler exists
> it is not allowed to free up this scheduler.
> 
> So this function can't be called like this.

As I already explained, the fences can outlive their scheduler. That 
means *this* entity certainly exists for *this* scheduler, but the 
*dependency* fence might have come from a past scheduler that was 
already destroyed along with all of its entities, and its address reused.

Christian, I'm really getting tired of your tone. I don't appreciate 
being told my comments are "outright nonsense" when you don't even take 
the time to understand what the issue is and what I'm trying to 
do/document. If you aren't interested in working with me, I'm just going 
to give up on drm_sched, wait until Rust gets workqueue support, and 
reimplement it in Rust. You can keep your broken fence lifetime 
semantics and I'll do my own thing.

~~ Lina

