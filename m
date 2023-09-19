Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFE07A6CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjISVJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjISVJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:09:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA9BB3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:08:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so66342525e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1695157735; x=1695762535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WzhzxUE4RjhFx1lU22v0y5b/j7ECD6xkYnOHdX2+flM=;
        b=xLiQzX93y8idYfXafZl2yo8MeBzUGg6z59lwrgEVg+zahpnPIrgi0N0vPrb5p2aD92
         m0yOjrdGuhh5i0bLnrNRYyndsjuWcww19p6CVCxWU0tZTI7b3ZIeUyYqqoa3e2LdhUF/
         15kgGtDcMQfDFygvyeL2K7SHcWYLoNt7vbgc4n89TrCQwDpjISwV+fGtS+Tkui2OBm5C
         gJb9Ei62PKHmFOGyT/D3bW48N8i7nfG8lkPzJPBYV0iNG+w9RIAD67xgeDNVEhiC4M7Q
         9jd2hjKoGqsWkmGwuyQTvMcaUnkF8WJg3IS/UILRA9d+M0wPjNeJnsXqCdsJQh2nedCH
         fIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695157735; x=1695762535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzhzxUE4RjhFx1lU22v0y5b/j7ECD6xkYnOHdX2+flM=;
        b=J+Cpl9qUFFD+jRbns1m3R6DUjdOTqFCRSrZkwW0Qp5uZJGLgBeq/bp6BDZnyt8neUW
         xsntWcTUfsZya/UbEXZxoOjY79a/1KTDsU+u5tVEDjYV80RkkA2zZ0/BNMKCYCEHnxlj
         mGjspQbMmnUAnChSPBbuuGuy8EzKGU0MqbwsNQrDE9VV3MHWDFs7p92LhI+EKCjKHkzL
         I/Sl9mb2HSa3++/0AmEfETJTZ2aWV9E5Byax1Napl9HubytdPKHPelid8qr0tUSuoiPs
         lhzqsbMbpYHPLHAdY6Z9eZi0GMKR3aekkjB3Em5TboQiKYJG6qqSQyIK9V1EyQ4W04XR
         BQXw==
X-Gm-Message-State: AOJu0Yze9paEn3gtPwuHvYG2s7Rd0KC7akYPrMBH7MRHAwn5BtJggWRX
        XKTUqjiClAPWUIzyLySndAGpmA==
X-Google-Smtp-Source: AGHT+IHq23x1W8CfzN2NbuUp+POBAVp2R0hM1C7qiQ3MoBoIsRf2PzzY8pts2B/3V0YKkNqZt/T0Qw==
X-Received: by 2002:a05:600c:ad6:b0:401:b1c6:97d8 with SMTP id c22-20020a05600c0ad600b00401b1c697d8mr726600wmr.35.1695157734256;
        Tue, 19 Sep 2023 14:08:54 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bcb99000000b003fee8793911sm60037wmi.44.2023.09.19.14.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 14:08:53 -0700 (PDT)
Date:   Tue, 19 Sep 2023 22:08:51 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Mike Galbraith <efault@gmx.de>
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        tglx@linutronix.de, daniel.m.jordan@oracle.com
Subject: Re: [PATCH 0/2] sched/eevdf: sched_attr::sched_runtime slice hint
Message-ID: <20230919210851.ktzi7ogxs3punger@airbuntu>
References: <20230915124354.416936110@noisy.programming.kicks-ass.net>
 <20230916213316.p36nhgnibsidoggt@airbuntu>
 <5bec3f08b4251c770545b59ede8fc4820c8d685b.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bec3f08b4251c770545b59ede8fc4820c8d685b.camel@gmx.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/23 05:43, Mike Galbraith wrote:
> On Sat, 2023-09-16 at 22:33 +0100, Qais Yousef wrote:
> >
> > Example of conflicting requirements that come across frequently:
> >
> >         1. Improve wake up latency without for SCHED_OTHER. Many tasks
> >            end up using SCHED_FIFO/SCHED_RR to compensate for this
> >            shortcoming. RT tasks lack power management and fairness and
> >            can be hard and error prone to use correctly and portably.
> 
> This bit appears to be dealt with about as nicely as it can be in a
> fair class by the latency nice patch set, and deals with both
> individual tasks and groups thereof, ie has cgroups support.

AFAIU the latency_nice is no longer going forward. But I could be mistaken.

> Its trade slice for latency fits EEVDF nicely IMHO.  As its name
> implies, the trade agreement language is relative niceness, which I
> find more appropriate than time units, use of which would put the deal
> squarely into the realm of RT, thus have no place in a fair class.

Nice (or latency nice) have global indication that can make sense within the
specific context tested on. Like RT priorities.

Abstract notion is fine if you have a better suggestion, but being global
relative is a problem IMO. The intended consumers are application writers; who
have no prior knowledge about the system they'll be running on. I think that
was the main point against latency_nice IIUC.

> I don't yet know how effective it is.  I dinged up schedtool to play
> with both it and $subject, but have yet to target any pet piglets or
> measured impact of shiny new lipstick cannon.
> 
> >         2. Prefer spreading vs prefer packing on wake up for a group of
> >            tasks. Geekbench-like workloads would benefit from
> >            parallelising on different CPUs. hackbench type of workloads
> >            can benefit from waking on up same CPUs or a CPU that is
> >            closer in the cache hierarchy.
> >
> >         3. Nice values for SCHED_OTHER are system wide and require
> >            privileges. Many workloads would like a way to set relative
> >            nice value so they can preempt each others, but not be
> >            impact or be impacted by other tasks belong to different
> >            workloads on the system.
> >
> >         4. Provide a way to tag some tasks as 'background' to keep them
> >            out of the way. SCHED_IDLE is too strong for some of these
> >            tasks but yet they can be computationally heavy. Example
> >            tasks are garbage collectors. Their work is both important
> >            and not important.
> 
> All three of those make my eyebrows twitch mightily even in their not
> well defined form: any notion of applying badges to identify groups of
> tasks would constitute creation of yet another cgroups.

cgroups require root privilege. And it is intended for sysadmins to split
system resources between apps. It doesn't help an app to describe the
relationship between its tasks. Nor any requirements for them to do their job
properly. But rather impose something on them regardless of what they want.


Cheers

--
Qais Yousef
