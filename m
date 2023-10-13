Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B307C8BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjJMQv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:51:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2540D95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:51:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9b70b9671so1845ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697215911; x=1697820711; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=opA5ekr/PL/39867RmHZYZSwyK7TejK/8oUw/N2yvZw=;
        b=3m0E+hrL81oZ30STDHGqw+gxEQQir0I2aCEr0WXlQyHaLmkpg/NlYxRMU8aD5R9+HE
         AF27xefwZLnlZ2U8TKZOfqYGzdjsNtE5GAy7XqyNvBpnzDLwOfYViYzDkv2A8RDTl2Xo
         fWAQ9svD/kpp7AUxIQfVy1s2pL49eP/+loEdZcfREOtvfz9fOvVe9Zks46y2faen66AG
         V4EiZCcIeCOqLqz9lCtBSAbm0AwscLxKBetOOaDkzlFHWIkxwV8dw5y/GYR2dG9wn8B+
         5/4TFoSrVsIefZBF1Yo7D6BNA6gCAySpLeNPjNx7znLkVuN4KfoOaCsFnEaOqKE0OhYl
         9ChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697215911; x=1697820711;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opA5ekr/PL/39867RmHZYZSwyK7TejK/8oUw/N2yvZw=;
        b=iRHcRWtEbnG0dw1vAdyIz30JKCv9q/W/nzVmAEa7P2W3PH1V2CMe0PqP7lwcDa6LvY
         HoyOv7CUuvRRsbxPVDw0kN5FWE3oRBds3PoxrDm/Phgh9ITTwe3nguPrHoSUk0z8Se4R
         6c0SdBgzI9yYMVdFy6/ePEIDNpz/DyywuGyZZV4hjH8T4Aet/qgGE/C/mLjKe8e749Ra
         qNk/NL1d7N6FEO0fqEwIErdqdeb2dhHaIg8oi9aZW8ZAOgxjwQzVfXgc+j9jEyg42q7z
         L/hK5+wTw/3JgNjTWEf/+U2setGnpxBoN3Gy4mteRgKqjD7athLnaK8/Bkh7Je2SbqBz
         NmZA==
X-Gm-Message-State: AOJu0YzadFKAxc1k/NJL6nOPAWa+Z5xJLGHRjF0XWM9fmTfJvgVg7S6j
        NC1S8zeR4KDrCovJPGWtL/ueoQ==
X-Google-Smtp-Source: AGHT+IF5khgGZGbOSagfW0YnUh8mBDK/Ecx1vxT656yULD8p5VPO0TXMO14dEmx9oS4qjdYBCOkKng==
X-Received: by 2002:a17:903:2a85:b0:1ca:42a:1771 with SMTP id lv5-20020a1709032a8500b001ca042a1771mr123012plb.24.1697215911409;
        Fri, 13 Oct 2023 09:51:51 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2a3:200:216e:4b3d:e8ab:f961])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902650200b001c73eace0fesm4182340plk.157.2023.10.13.09.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 09:51:50 -0700 (PDT)
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
In-Reply-To: <e2a42ff2-d0f9-4963-bed7-229224ee8287@bytedance.com> (Abel Wu's
        message of "Fri, 13 Oct 2023 11:46:24 +0800")
References: <20230531115839.089944915@infradead.org>
        <20230531124603.931005524@infradead.org>
        <xm261qego72d.fsf_-_@google.com>
        <6b606049-3412-437f-af25-a4c33139e2d8@bytedance.com>
        <xm26bkd4x5v4.fsf@bsegall-linux.svl.corp.google.com>
        <699cc8b1-f341-4af7-9c47-fee961c5c4b7@bytedance.com>
        <xm26pm1jhgpx.fsf@bsegall-linux.svl.corp.google.com>
        <e2a42ff2-d0f9-4963-bed7-229224ee8287@bytedance.com>
Date:   Fri, 13 Oct 2023 09:51:48 -0700
Message-ID: <xm26bkd2h3dn.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abel Wu <wuyun.abel@bytedance.com> writes:

> On 10/13/23 1:51 AM, Benjamin Segall Wrote:
>> Abel Wu <wuyun.abel@bytedance.com> writes:
>> 
>>> On 10/12/23 5:01 AM, Benjamin Segall Wrote:
>>>> Abel Wu <wuyun.abel@bytedance.com> writes:
>>>>
>>>>> On 9/30/23 8:09 AM, Benjamin Segall Wrote:
>>>>>> +	/*
>>>>>> +	 * Now best_left and all of its children are eligible, and we are just
>>>>>> +	 * looking for deadline == min_deadline
>>>>>> +	 */
>>>>>> +	node = &best_left->run_node;
>>>>>> +	while (node) {
>>>>>> +		struct sched_entity *se = __node_2_se(node);
>>>>>> +
>>>>>> +		/* min_deadline is the current node */
>>>>>> +		if (se->deadline == se->min_deadline)
>>>>>> +			return se;
>>>>>
>>>>> IMHO it would be better tiebreak on vruntime by moving this hunk to ..
>>>>>
>>>>>> +
>>>>>> +		/* min_deadline is in the left branch */
>>>>>>     		if (node->rb_left &&
>>>>>>     		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
>>>>>>     			node = node->rb_left;
>>>>>>     			continue;
>>>>>>     		}
>>>>>
>>>>> .. here, thoughts?
>>>> Yeah, that should work and be better on the tiebreak (and my test code
>>>> agrees). There's an argument that the tiebreak will never really come up
>>>> and it's better to avoid the potential one extra cache line from
>>>> "__node_2_se(node->rb_left)->min_deadline" though.
>>>
>>> I see. Then probably do the same thing in the first loop?
>>>
>> We effectively do that already sorta by accident almost always -
>> computing best and best_left via deadline_gt rather than gte prioritizes
>> earlier elements, which always have a better vruntime.
>
> Sorry for not clarifying clearly about the 'same thing'. What I meant
> was to avoid touch left if the node itself has the min deadline.
>
> @@ -894,6 +894,9 @@ static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
>                 if (!best || deadline_gt(deadline, best, se))
>                         best = se;
>
> +               if (se->deadline == se->min_deadline)
> +                       break;
> +
>                 /*
>                  * Every se in a left branch is eligible, keep track of the
>                  * branch with the best min_deadline
> @@ -913,10 +916,6 @@ static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
>                                 break;
>                 }
>
> -               /* min_deadline is at this node, no need to look right */
> -               if (se->deadline == se->min_deadline)
> -                       break;
> -
>                 /* else min_deadline is in the right branch. */
>                 node = node->rb_right;
>         }
>
> (But still thanks for the convincing explanation on fairness.)
>

Ah, yes, in terms of optimizing performance rather than marginal
fairness, that would help.
