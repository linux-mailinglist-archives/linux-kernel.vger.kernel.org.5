Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C9D7EDB09
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbjKPFH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344719AbjKPFHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:07:55 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34E0130
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:07:27 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f0f160e293so229133fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700111247; x=1700716047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDtFNHWifzh6E6PZ2URvx5k5OrUkdcSzyx6lrGeB52g=;
        b=gIBbCC0a/o8HbUNPZiz6shZEEiFQmo7vYAgDLjL7K3SHWO9IXefVQR4T/hSYCX3596
         JrmTDysakN/tZXmWWmuSeAvCNRNFkM0tOMAN9XhTjm+pi1D31tjG8Xc48hdpuvVheK53
         eQ1rRDUiFBgdh5ZAL9LmLaJEjljjjf1LMvFUDp+omvKPYrlSo0KonzZ5iFsTGEnQ+UXK
         p9ZoB/TlCtmfDhQ+d1wIUeZx/SMm7XtGL5KSSy9MMAQC9/muJ/psfoiNp3oBPmKEydn6
         nJUMu8RA02svCGlC5sf3TPip78h/IIDAgG90vFABpxjXGZmNYcU1FMQGM6qYosJLuhDp
         bcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700111247; x=1700716047;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDtFNHWifzh6E6PZ2URvx5k5OrUkdcSzyx6lrGeB52g=;
        b=farEFT6sDF3H1wHwE6+uvpOg/iih5iIVqfC+zjdpiuVMgJEQrH8qonLq8eJL4vhN6o
         Bs3cBV4ioU/P8Ip5xmvhtCW1p86hRpR5zwKfr2Q+tuHFrFF1er2zxdOe4XesazTlaIcw
         hrNPSQc0BFddxc5jHSwdCHCTPB+vVPFE5aPAeSC+qk7VkybAsLkd98VVOGafA9pofyXZ
         5huOV9wja4kM9a98ssjMkEzUY3tjW7dpKZYY3NOhN9fYxyWVw3695qgviTb5pk8UTTug
         C8nl1y+JSGC9qMkkq+9oBZg46/rnK0YSSQXbVZM9rwlspj7fkhTGXwB+AtrwQovcLOEG
         6rDA==
X-Gm-Message-State: AOJu0YzR/V9nWa6GbYwLdrKbtjQQBxTtl5mMJxNg+flmQdwTS4OrVYoS
        tzRT2+J+YMu+o15kqSqpwzfmOQ==
X-Google-Smtp-Source: AGHT+IFS4TXjDDOgKc/vDJBD1KffOSjeHv+tf6KVG9Xobsjw05Et1F7iSlHmxAR7i+5Y4wnS/5pY3A==
X-Received: by 2002:a05:6870:819e:b0:1ea:30b2:3fcc with SMTP id k30-20020a056870819e00b001ea30b23fccmr19801235oae.31.1700111247264;
        Wed, 15 Nov 2023 21:07:27 -0800 (PST)
Received: from [10.254.46.51] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id n4-20020a056a0007c400b006c4d47a7668sm3652987pfu.127.2023.11.15.21.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 21:07:26 -0800 (PST)
Message-ID: <19c6accf-1cc0-489d-9c82-e0ddf982b098@bytedance.com>
Date:   Thu, 16 Nov 2023 13:07:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/eevdf: Fix vruntime adjustment on reweight
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Yiwei Lin <s921975628@gmail.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Benjamin Segall <bsegall@google.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Qais Yousef <qyousef@layalina.io>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20231107090510.71322-1-wuyun.abel@bytedance.com>
 <20231107090510.71322-2-wuyun.abel@bytedance.com>
 <da42f1d7-adfe-485e-987e-3e8dae78b4c2@gmail.com>
 <23cebdf8-1a51-481e-a8c2-e17021099e05@bytedance.com>
In-Reply-To: <23cebdf8-1a51-481e-a8c2-e17021099e05@bytedance.com>
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

On 11/16/23 12:48 PM, Abel Wu Wrote:
> On 11/15/23 11:36 PM, Yiwei Lin Wrote:
>>
>>> @@ -3712,8 +3811,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>>>       enqueue_load_avg(cfs_rq, se);
>>>       if (se->on_rq) {
>>>           update_load_add(&cfs_rq->load, se->load.weight);
>>> -        if (cfs_rq->curr != se)
>>> -            avg_vruntime_add(cfs_rq, se);
>>> +        if (!curr) {
>>> +            /*
>>> +             * The entity's vruntime has been adjusted, so let's check
>>> +             * whether the rq-wide min_vruntime needs updated too. Since
>>> +             * the calculations above require stable min_vruntime rather
>>> +             * than up-to-date one, we do the update at the end of the
>>> +             * reweight process.
>>> +             */
>>> +            __enqueue_entity(cfs_rq, se);
>>> +            update_min_vruntime(cfs_rq);
>>> +        }
>>>       }
>>>   }
>> Sorry if I am asking stupid question...... It looks like reweight_entity() may have chance to change the weight of cfs_rq->curr entity, but we'll never update_min_vruntime() when reweighting it. Is there any reason that we can skip the update_min_vruntime() for this case?
> 
> No, you are right!

I was intended to update_min_vruntime() if se->on_rq and no matter
it is curr or not, just as you suggested. But after a second thought
I wonder if it is necessary to update *NOW*, since we will always
update_curr() before making any change to cfs_rq. Thoughts?
