Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF017C751B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379634AbjJLRvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbjJLRv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:51:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F47AB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:51:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9b70b9671so13665ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133085; x=1697737885; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4c9PxVdvDkaT2ILkkxYtn5SSd3e0yFpozDooEzbzQY=;
        b=OpUpWRlfwa3dKx1B8Q6hV/FHslyyjw+Eojg0AT9cL3xVC7dQq8UR1sf7T4JwngUrq6
         7C7TwLaUQbtASACzIcoCNobmDatORNrFhbURPFEZkx02idKPWxfOGbDUsAhtTcCspYCF
         EMciRZ2BJr7jC0UR2NmDGpq8HDDznqTQSMeyKui8wgcM3rj0XskgCHGzTAZB3HlzJLXF
         UzYTPZvDVOsv/NEJRxmA10PZVFNJgTUKKB7Egx7EuMkZk0gFxqLmW6lv1LQht8KUSaSx
         aLgCWA6kafUd8Wr7ANshdSCunX+yogiE53oAlQ3McIcddJi+MVH6rTrMcnpq91Te45RT
         jZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133085; x=1697737885;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4c9PxVdvDkaT2ILkkxYtn5SSd3e0yFpozDooEzbzQY=;
        b=OdpKcHkRZz4lxP8uMuRoNtW8VLMWofaA9tcNtefRxejPd8URxFk2WScqS/Ex+NK41z
         rqctvJRU6ogzjfoeN07kxNYWKGSnqnplP8iftfijLvuLoS3U9PjOMBnLMhCbbn9UFRCc
         V1orZ0xsQL0L/2zniEa7reR6i4KnhOYtP66SuZKdZu20KuTRWa+32FwBf7/gO7cmbl60
         Bg43v8AXmqEXRSDA4ybgLvTRx/OC7o7NE+CrnsLWw8xxG6hWFUwBV0isvIrvwQDD8Xuq
         5Dopcv+4e7mS7uangAH2UBH9l0A79IoGCgm7Kddyvx/YHBiYCOrQQFF+fI8/hSh7K0HX
         J9xQ==
X-Gm-Message-State: AOJu0YyqE1VrIfFkdG0DEWDk4vuIFcIOAbMfqWiv8M67XDXmwFoNiXjM
        0gUehe4zR4h6YcM5kfUhL/1rLw==
X-Google-Smtp-Source: AGHT+IGziI3ZRQjkieu2xDnq5tLcnAJNtfsrYkJBrREaYVXFowVZIeCyzQFHfI05gEW13Z6AT5ZQQw==
X-Received: by 2002:a17:902:e952:b0:1c1:efe5:cce5 with SMTP id b18-20020a170902e95200b001c1efe5cce5mr3634pll.3.1697133085284;
        Thu, 12 Oct 2023 10:51:25 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2a3:200:5aa:bf1b:3872:9fec])
        by smtp.gmail.com with ESMTPSA id c4-20020a62e804000000b00690c9fda0fesm12045027pfi.169.2023.10.12.10.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:51:24 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
In-Reply-To: <699cc8b1-f341-4af7-9c47-fee961c5c4b7@bytedance.com> (Abel Wu's
        message of "Thu, 12 Oct 2023 18:25:06 +0800")
References: <20230531115839.089944915@infradead.org>
        <20230531124603.931005524@infradead.org>
        <xm261qego72d.fsf_-_@google.com>
        <6b606049-3412-437f-af25-a4c33139e2d8@bytedance.com>
        <xm26bkd4x5v4.fsf@bsegall-linux.svl.corp.google.com>
        <699cc8b1-f341-4af7-9c47-fee961c5c4b7@bytedance.com>
Date:   Thu, 12 Oct 2023 10:51:22 -0700
Message-ID: <xm26pm1jhgpx.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abel Wu <wuyun.abel@bytedance.com> writes:

> On 10/12/23 5:01 AM, Benjamin Segall Wrote:
>> Abel Wu <wuyun.abel@bytedance.com> writes:
>> 
>>> On 9/30/23 8:09 AM, Benjamin Segall Wrote:
>>>> +	/*
>>>> +	 * Now best_left and all of its children are eligible, and we are just
>>>> +	 * looking for deadline == min_deadline
>>>> +	 */
>>>> +	node = &best_left->run_node;
>>>> +	while (node) {
>>>> +		struct sched_entity *se = __node_2_se(node);
>>>> +
>>>> +		/* min_deadline is the current node */
>>>> +		if (se->deadline == se->min_deadline)
>>>> +			return se;
>>>
>>> IMHO it would be better tiebreak on vruntime by moving this hunk to ..
>>>
>>>> +
>>>> +		/* min_deadline is in the left branch */
>>>>    		if (node->rb_left &&
>>>>    		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
>>>>    			node = node->rb_left;
>>>>    			continue;
>>>>    		}
>>>
>>> .. here, thoughts?
>> Yeah, that should work and be better on the tiebreak (and my test code
>> agrees). There's an argument that the tiebreak will never really come up
>> and it's better to avoid the potential one extra cache line from
>> "__node_2_se(node->rb_left)->min_deadline" though.
>
> I see. Then probably do the same thing in the first loop?
>

We effectively do that already sorta by accident almost always -
computing best and best_left via deadline_gt rather than gte prioritizes
earlier elements, which always have a better vruntime.

Then when we do the best_left->min_deadline vs best->deadline
computation, we prioritize best_left, which is the one case it can be
wrong, we'd need an additional
"if (se->min_deadline == best->deadline &&
(s64)(se->vruntime - best->vruntime) > 0) return best;" check at the end
of the second loop.

(Though again I don't know how much this sort of never-going-to-happen
slight fairness improvement is worth compared to the extra bit of
overhead)
