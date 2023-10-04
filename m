Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BEC7B7CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbjJDKGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242107AbjJDKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:06:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE4783
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 03:06:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-533c4d20b33so1665257a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 03:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696413993; x=1697018793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PM69tFgEPO7655wzYmJMaVk1yqJloza2q3J/vZtUffQ=;
        b=ghaF8cWMdHNwwcEesKLWa5lBY0QidrlFeKd0RRpV6USlYtYX+zQRwICxWFmFtOUVyB
         sKExHiA7gE5oEl6QxwZF69OuD8PvzVfCG1q+XsCTgZOHL8D64xBz1T4m/FIVYUy05mE1
         /J12Emms1xIB8UonRM8CW/6Ebl++5DWLR1U5A4d6Z/j739ZkWxwC3L9NBwU7DP0nd+wK
         yJ9AIYIQqBTw8Z2ClZE38aJnkujy5YrYOkhFKDChhgwfF9yfJk3UrmpECvMa2ghPJSar
         cFyGO4n6UXa72DlbtpAuGMoae+vP39kB0/X3qGn4zTvFzc53vOZ2gfKTvMMoWerxOC7R
         qgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696413993; x=1697018793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PM69tFgEPO7655wzYmJMaVk1yqJloza2q3J/vZtUffQ=;
        b=cZeRrSXCdDQvSu7y5X/0qdat0DwO6CxGcuqfVgETyHJ0o9HVAYDSx27s7ZZ74PiZDA
         P6aEwX3xJIj+hwLorB3CC0m+W7dDemLk4qis38BbygqveywAHOIMly84JRWd51thS4NY
         hUo1WmcZMmf+bVpD6ZeAcVeDz3Q/5Usc8VGbqTRQ8ya+FOJCgLwLBOUgp/ZBGzrYhoCO
         EEInVQ2Zt7sPhshNt+OzifAFit9Fm/d1RxMaAEljKJYw5t8IzFOMOblw4nG95Dp/7blK
         VZ6Vr14utlmiw7HEVUQYSdEAxoJsSkGJLcleVufzSyPVfo+qpgTGXctQvJkz/siwGX5V
         yXlg==
X-Gm-Message-State: AOJu0YxG9LphNrg4gpnVxlR4Fw/6p2usfRCklDXHJLpx9ZB4hp/ldva9
        EwGyXK31oaF2TqugQM5q6KI=
X-Google-Smtp-Source: AGHT+IGbAvGs/S9XG9MlO6xBzP7eFSrCrHQCxUL3VpAgIUtfQ9mKBBq1ARzZ4K0rkKG2RWeWJX3CAg==
X-Received: by 2002:a05:6402:330:b0:52f:86a1:3861 with SMTP id q16-20020a056402033000b0052f86a13861mr1641160edw.7.1696413992798;
        Wed, 04 Oct 2023 03:06:32 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id s22-20020aa7cb16000000b00532eba07773sm2153740edt.25.2023.10.04.03.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 03:06:32 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 12:06:29 +0200
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
Message-ID: <ZR05JXPgOXb4kuHl@gmail.com>
References: <20231003205735.2921964-1-longman@redhat.com>
 <20231004083648.GI27267@noisy.programming.kicks-ass.net>
 <ZR0vHXDeGi+iVogR@gmail.com>
 <20231004094330.GL1539@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004094330.GL1539@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 04, 2023 at 11:23:41AM +0200, Ingo Molnar wrote:
> 
> > >  	if (user_mask) {
> > > -		cpumask_copy(user_mask, in_mask);
> > > +		/*
> > > +		 * All-set user cpumask resets affinity and drops the explicit
> > > +		 * user mask.
> > > +		 */
> > > +		cpumask_and(user_mask, in_mask, cpu_possible_mask);
> > > +		if (cpumask_equal(user_mask, cpu_possible_mask)) {
> > > +			kfree(user_mask);
> > > +			user_mask = NULL;
> > > +		}
> > 
> > Question: is there any observable behavioral difference between current 
> > (old) all-set cpumask calls and the patched (new) one?
> 
> Very little I think -- the main difference is that we no longer carry
> the ->user_cpus_ptr mask around, and that saves a little masking.

So calling with a full mask would actually work fine on 'old' kernels too,
as it's a 'reset' event in essence. (With a bit of allocation & masking
overhead.)

This pretty unambiguously marks the full-mask solution as the superior ABI ...

Thanks,

	Ingo
