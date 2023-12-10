Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE8280BE29
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 00:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjLJXT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJXTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:19:55 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5013EEB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:20:01 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso38895625e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702250400; x=1702855200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/DkVLa8r0eVoKVXH0/up1/++p+v5Fo1aaa5zaxGRQs=;
        b=wjF6e2VdmSN/ptiRWYouFzNgwX/33tIpV4JjN+TenSd4g0ooy7WbOEuWTs40duY3P2
         9xs0Gev5rO7yv7k3MnNdtR1bReF8Prb8pISyhJYjhgNQU4h0iBaLlL5oa9mbrXrJB4ek
         qDad28wMLkV24hFItkspmsfGBaJPpoF0UicPFM9q7iJIOXJgs6me/6vpPO/m/O6QR60P
         AKS/Gx4UZdBUGfJOs3zzlgLgKZRjpK4Zju+t2HoQ4Q47QLGJ052uW1f7427qkEpwOfXC
         CUcJ0pQyyJ3wxAjFJW5Ol5zn4H2BHgZFepSuqb/YKDs320GA8tunlSnu00H627iy7ik6
         zTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702250400; x=1702855200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/DkVLa8r0eVoKVXH0/up1/++p+v5Fo1aaa5zaxGRQs=;
        b=PUUQcZvdQ4WHVh+sR6RSKba1rMCwg0kVaL2oEXB6OY4333bOdHfOW2HN/eWozzQG4V
         3NrjF23sRrRgJTJ8b30weF5anYwVVSYOY4YVeJz2OVfn4pNL5dU9sn/02T/GGsvkIa81
         ayznNzg/NX5+ARZ6cThhHlhxvxFM0FB1LN6X3/ZvxD6H/WVjyLsSg/qoGh2gQKGUHLPR
         PfaYZlA1rQv4iGsJSIeTuwJF5Uu00Cd2S5USQszXT0xaGzIHPqLu4F+rwTh5j42CWYli
         UOIftEzqrUmwk7Chea08xRi93uKkGF4GNKGdsJZ2SHTbHKtAIyis4WjFANFr7GQrp1n8
         bcRQ==
X-Gm-Message-State: AOJu0YwbYSn7tP/s1AiVZlaz0bkF8+H6ep3BXIwqvzg3x1F+Ht+sdYgI
        E+QtIngIiio6uKJ7V7MxgL28aw==
X-Google-Smtp-Source: AGHT+IGnXdafJNqHJdGM3REGKQvDkTxqI5oDfAZTA4IBzI2lhNbScCtgyyaVHlvnImbIZSFoCdMoIQ==
X-Received: by 2002:a05:600c:319b:b0:40b:5e4a:40a5 with SMTP id s27-20020a05600c319b00b0040b5e4a40a5mr1476609wmp.197.1702250399662;
        Sun, 10 Dec 2023 15:19:59 -0800 (PST)
Received: from airbuntu (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040c4886f254sm1169967wmn.13.2023.12.10.15.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 15:19:59 -0800 (PST)
Date:   Sun, 10 Dec 2023 22:47:24 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de,
        daniel.m.jordan@oracle.com
Subject: Re: [PATCH 2/2] sched/eevdf: Use sched_attr::sched_runtime to set
 request/slice suggestion
Message-ID: <20231210224724.eteuahkempeeojfz@airbuntu>
References: <20230915124354.416936110@noisy.programming.kicks-ass.net>
 <20230915124822.956946622@noisy.programming.kicks-ass.net>
 <20230919220708.l2llt2f5xullxzzz@airbuntu>
 <20230919223704.GG424@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919223704.GG424@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/23 00:37, Peter Zijlstra wrote:
> On Tue, Sep 19, 2023 at 11:07:08PM +0100, Qais Yousef wrote:
> > On 09/15/23 14:43, peterz@infradead.org wrote:
> > > Allow applications to directly set a suggested request/slice length using
> > > sched_attr::sched_runtime.
> > 
> > I'm probably as eternally confused as ever, but is this going to be the latency
> > hint too? I find it hard to correlate runtime to latency if it is.
> 
> Yes. Think of it as if a task has to save up for it's slice. Shorter
> slice means a shorter time to save up for the time, means it can run
> sooner. Longer slice, you get to save up longer.
> 
> Some people really want longer slices to reduce cache trashing or
> held-lock-preemption like things. Oracle, Facebook, or virt thingies.
> 
> Other people just want very short activations but wants them quickly.

I did check with several folks around here in the Android world, and none of us
can see how in practice we can use this interface.

It is helpful for those who have a specific system and workload they want to
tune them together. But as a generic app developer interface it will be
impossible to use.

Is that sched-qos thingy worth trying to pursue as an alternative for app
developers? I think from their perspective they just can practically say I care
about running ASAP or not; so a boolean flag to trigger the desire for short
wake up latency. How to implement that, that'd be my pain. But do you see an
issue in principle in trying to go down that route and see how far I (we if
anyone else is interested) can get?

I think the two can co-exist each serving a different purpose.

Or is there something about this interface that makes it usable in this manner
but I couldn't get it?


Thanks!

--
Qais Yousef
