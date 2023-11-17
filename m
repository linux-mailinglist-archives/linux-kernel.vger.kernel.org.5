Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200667EECB1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjKQHel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjKQHej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:34:39 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FEB109
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:34:11 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc34c3420bso15213055ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700206451; x=1700811251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfKYY8OtNB3CHpmzLXf6dJoRO471vghEnpe2oT0xnQw=;
        b=dgHBoIdsUZJJnWlWRt21Y4YbMNMl1OxEr8URsztQP6hOn1TAbwJcuNMJxldYoslQvS
         546QKZ86rppxSArn+Jg/v7EVgP1VVUyOk/mYSM9HUTcmwtM958KrZBiKuAJRiJ8By1kC
         vJNVu4IicwgPFA/keA+LGMajrNC3A1uC7VjIFPDNjiKQwOKNAdOYYYMgIL3SxMaXDyFF
         2PJC56vKjPmf4vYYfCEUeysUMAVqXZCycPo2J23EHSYQVhUErvLr/yXnGDcfe/xy0jAR
         xNL7ruLyHR77oU3ZcVXO1iSqTa99fu7I7PwNAHBcWGb8pDAgEJR/ZhWHgCwAV5Miwi94
         dcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700206451; x=1700811251;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfKYY8OtNB3CHpmzLXf6dJoRO471vghEnpe2oT0xnQw=;
        b=r/0Eqkq84ZHcwMAPAgvkIKlLpfAHRp3js/Nqe7EV0Bb+5+vnZQEcH+beZPnTkQjXQe
         oKB/gz33f02moMX9/H/RPu7hmFe72bYw0HrPXbHcnaXg8l+O34qxwQHln3T19I7S0kk5
         3naprTxvEM3jrSbqqfHU+1Nbt8nQZXjSSFCzu3Gk8lkkK4zktbSDFMvjoXtN/J8TU8GX
         hDGnW9FY6qIkT9Ctaazk5d659fSmflSouZrayBeDcbzJtkLByhr+hiZJkJQ0EBYk6t2z
         zRdo1dsZ2sBISWGbOmChseTZsdUyQnVwt9TyLnlwgm4V11q75yVfXLyO7VOgnFgKVZDA
         y3pA==
X-Gm-Message-State: AOJu0YyQ2qjQOImIIMriEw5PVEGNeLyRBW4zkghVB9Q5YZFY03LEuGI7
        rZhvW7eeDmmEbAvLUUF+VR3+qg==
X-Google-Smtp-Source: AGHT+IFoUjEF+x95km5sGjutZnX/UwhTNZOEsSSL1pyCAYQb7dS1myyHo7oP8eWTRB3cJakwCDzZHw==
X-Received: by 2002:a17:902:74c3:b0:1cd:f94b:1823 with SMTP id f3-20020a17090274c300b001cdf94b1823mr10332060plt.64.1700206450781;
        Thu, 16 Nov 2023 23:34:10 -0800 (PST)
Received: from [10.254.46.51] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b001cc2c7a30f2sm782047plh.155.2023.11.16.23.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 23:34:10 -0800 (PST)
Message-ID: <96194f8a-4e3f-4563-83d0-c754e1d2abd3@bytedance.com>
Date:   Fri, 17 Nov 2023 15:34:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Update min_vruntime for reweight_entity()
 correctly
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Yiwei Lin <s921975628@gmail.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org
References: <20231116114217.90553-1-s921975628@gmail.com>
 <30fa2ed2-dfee-4dbf-bb44-1b0374877706@bytedance.com>
In-Reply-To: <30fa2ed2-dfee-4dbf-bb44-1b0374877706@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 7:52 PM, Abel Wu Wrote:
> Please add a Fix tag like this:
> 
> Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")

Can you resend this patch with this fix tag please?

> 
> On 11/16/23 7:42 PM, Yiwei Lin Wrote:
>> Since reweight_entity() may have chance to change the weight of
>> cfs_rq->curr entity, we should also update_min_vruntime() if
>> this is the case
>>
>> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
>> ---
>>   kernel/sched/fair.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 07f555857..6fb89f4a3 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3815,17 +3815,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>>       enqueue_load_avg(cfs_rq, se);
>>       if (se->on_rq) {
>>           update_load_add(&cfs_rq->load, se->load.weight);
>> -        if (!curr) {
>> -            /*
>> -             * The entity's vruntime has been adjusted, so let's check
>> -             * whether the rq-wide min_vruntime needs updated too. Since
>> -             * the calculations above require stable min_vruntime rather
>> -             * than up-to-date one, we do the update at the end of the
>> -             * reweight process.
>> -             */
>> +        if (!curr)
>>               __enqueue_entity(cfs_rq, se);
>> -            update_min_vruntime(cfs_rq);
>> -        }
>> +
>> +        /*
>> +         * The entity's vruntime has been adjusted, so let's check
>> +         * whether the rq-wide min_vruntime needs updated too. Since
>> +         * the calculations above require stable min_vruntime rather
>> +         * than up-to-date one, we do the update at the end of the
>> +         * reweight process.
>> +         */
>> +        update_min_vruntime(cfs_rq);
>>       }
>>   }
> 
> LGTM, thanks!
