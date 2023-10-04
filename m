Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1877B7BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjJDJXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjJDJXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:23:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FDB9E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:23:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b281a2aa94so337919066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696411425; x=1697016225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGJycS1XitgkoppU454BOwvs+F7fdIZ3djwExAyv22A=;
        b=NicWSEgsb8N7Fii/+5WNdoOWidBEz0RvaMAi/sqLmZQfmxtUsprz11U9gK38Lk127m
         TeNgKovQPTi4EIh1PbN5xMKk/killsXLvweWTLqsPDDpUGlWa2n2QBDVW7uhqZBPqlhP
         yv2oMoSN+00V+wRHXFILOZYjh7L8/OaQiG+ooYZEsRuim+SpcZSSimWW+krnhs39uZQF
         7qkO4t7cd4pnqZGjdOd5B6R0Kc7tr8pJRPgQ1mxUFc7bFaoMdFoeuUCpGFH3j1I3gGJg
         mM8mV0UzEfesIurZcBIKPDw+ZbYK0wppNGHBwkf8YMXuyrj2g5e5h+vNDPQiNjb9ZoHk
         IWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411425; x=1697016225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGJycS1XitgkoppU454BOwvs+F7fdIZ3djwExAyv22A=;
        b=jbC1hqxKrJSvghzA4BW771+zqMxkGYtmm4Uu1MjnaboWXlrGqPrxAXo2w4bYyPUk1h
         cRhm3sWylDGRbz2hEx1n2Sby5oEHp2VgQSMO8TZpD+zwPVNb5419hTBKVhJuaj79lg1M
         0FuJPv6qh0FN07AVbrJai4qGRELw5f9ipX5jztFCKfvrN78Jcz9UYqfdiujBXGaomhmN
         tuzU3ufebfmDIQCNIjDtp9sOX03lKR+rPRgMoz84m0ySM3XW2chAUPxNqqpfq0XrwExn
         PYlajIbeYJGq1RjM1FfKF1LMTafHL3i7ztXb/FjKmFHOphzrzoKDi54Z1B8XUI37t53j
         ZWqQ==
X-Gm-Message-State: AOJu0YxMcAsZdRpFkAdNfDkeafGOAHYRRnW1zsc8bn+P3hONqH1c3Nvg
        ejeabnH4RUdrZePZPXN0E8s=
X-Google-Smtp-Source: AGHT+IFGS0KTjzX+t/UIt9FERgLT/4IzkUy8lUDxb8C0SlUkizkkUNUoKRpE2a9G5mtyHO04wc3VdA==
X-Received: by 2002:a17:906:2253:b0:9b2:6db8:e108 with SMTP id 19-20020a170906225300b009b26db8e108mr1331086ejr.13.1696411425025;
        Wed, 04 Oct 2023 02:23:45 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id fu31-20020a170907b01f00b009b947aacb4bsm24077ejc.191.2023.10.04.02.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 02:23:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 11:23:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v4] sched/core: Use zero length to reset cpumasks in
 sched_setaffinity()
Message-ID: <ZR0vHXDeGi+iVogR@gmail.com>
References: <20231003205735.2921964-1-longman@redhat.com>
 <20231004083648.GI27267@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004083648.GI27267@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Oct 03, 2023 at 04:57:35PM -0400, Waiman Long wrote:
> > Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> > cpumask"), user provided CPU affinity via sched_setaffinity(2) is
> > perserved even if the task is being moved to a different cpuset. However,
> > that affinity is also being inherited by any subsequently created child
> > processes which may not want or be aware of that affinity.
> > 
> > One way to solve this problem is to provide a way to back off from that
> > user provided CPU affinity.  This patch implements such a scheme by
> > using an input cpumask length of 0 to signal a reset of the cpumasks
> > to the default as allowed by the current cpuset.  A non-NULL cpumask
> > should still be provided to avoid problem with older kernel.
> > 
> > If sched_setaffinity(2) has been called previously to set a user
> > supplied cpumask, a value of 0 will be returned to indicate success.
> > Otherwise, an error value of -EINVAL will be returned.
> > 
> > We may have to update the sched_setaffinity(2) manpage to document
> > this new side effect of passing in an input length of 0.
> 
> Bah.. so while this is less horrible than some of the previous hacks,
> but I still think an all set mask is the sanest option.
> 
> Adding FreeBSD's CPU_FILL() to glibc() isn't the hardest thing ever, but
> even without that, it's a single memset() away.
> 
> 
> Would not the below two patches, one kernel, one glibc, be all it takes?

I'd much prefer this ABI variant, it's a pretty natural extension of the 
existing ABI and principles:

>  	if (user_mask) {
> -		cpumask_copy(user_mask, in_mask);
> +		/*
> +		 * All-set user cpumask resets affinity and drops the explicit
> +		 * user mask.
> +		 */
> +		cpumask_and(user_mask, in_mask, cpu_possible_mask);
> +		if (cpumask_equal(user_mask, cpu_possible_mask)) {
> +			kfree(user_mask);
> +			user_mask = NULL;
> +		}

Question: is there any observable behavioral difference between current 
(old) all-set cpumask calls and the patched (new) one?

Thanks,

	Ingo
