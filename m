Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0E57F0210
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjKRSpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjKRSpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:45:15 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7AB12B
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 10:45:12 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso2945799276.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 10:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700333111; x=1700937911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bW2tiTIrBWAXiy30jb0LKEp8e44RWdEZj57EYCLluIw=;
        b=V1BdXIOSvLYnHNmGSm+V/V5Z/2NskHGFj2jNBxdkdGHzU8KWpD7ePD5goAycmYNcI/
         xhUJcHiGwLySQeyjCjBRTRZikUFnvfOAwTjKwXqA9uJYNaJ/8sWDydZHPCaW70U/PGOI
         FVMU41+Zx4W9KzCiSF3ObqsgDQGcNWpzQ8zVeYb6HX4uYFZaoP5yqmFTBBEaCZX2TzWM
         WuAfzoFJiIyniU/64K01vhHhZx+CBWCsJY7F9kjf6LKpQyjAIoNfQ3d1qxfhc5XeFXmg
         dK76/lKr7OaSMD0Som35Y6a9r3BDMPMSR3gzFNn1D226HC6YtGyNbCGjzDQpbaZPunhk
         qzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700333111; x=1700937911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW2tiTIrBWAXiy30jb0LKEp8e44RWdEZj57EYCLluIw=;
        b=cVPZ64LAhEdZ5uwAR+4+KrEzMkjQa9p/lGy+P3crse3Qoh0dslQ1VwIN69xtuhWWGn
         1Ei8yJvFRjqqvvTf+BfdBL82qS1TYPwz5k/22nqUVxVLXyDzGVo+he26D4L2tzl4tSIs
         e0e/x/KZJXP2XW9cMko4+cPvAwCE512B7A5u1k1c5KzCq+eWXQewM/dRUNfFYj3wCSHQ
         j897Xmam4rYwmPiG9jTCEoryTH/d5gBVXokptV9h2+wRkSm/b2ddRJ8M/BM6OaZlEj/Q
         fFoGViprqBTGLAimROA1efJ9/ShgKkOwtFO0KWMmf1oLngCu1mco8YDmNbrO5FA7wRKJ
         IOug==
X-Gm-Message-State: AOJu0YxTA/LjcxFEMX3hm++cFmDowX2OUpnmO48c+M13eqZZ519uBhHX
        SrAP7fvhmHEpNFF7PTwYPnw=
X-Google-Smtp-Source: AGHT+IHiqNQImhu8dUqW/vDSumeQYp/EBUMQCRNHeIgCB3E0iPG/RuSSIO/uJ7jxZ62gFFvlGS1/tw==
X-Received: by 2002:a25:d091:0:b0:db0:1338:8a64 with SMTP id h139-20020a25d091000000b00db013388a64mr2719699ybg.57.1700333111258;
        Sat, 18 Nov 2023 10:45:11 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id b79-20020a253452000000b00da076458395sm1065426yba.43.2023.11.18.10.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 10:45:10 -0800 (PST)
Date:   Sat, 18 Nov 2023 10:45:10 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 31/34] drivers/perf: optimize m1_pmu_get_event_idx() by
 using find_bit() API
Message-ID: <ZVkGNhZyA3S4m8Os@yury-ThinkPad>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-32-yury.norov@gmail.com>
 <87cyw6ykes.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyw6ykes.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 06:40:43PM +0000, Marc Zyngier wrote:
> On Sat, 18 Nov 2023 15:51:02 +0000,
> Yury Norov <yury.norov@gmail.com> wrote:
> > 
> > The function searches used_mask for a bit in a for-loop bit by bit.
> > We can do it faster by using atomic find_and_set_bit().
> 
> Sure, let's do things fast. Correctness is overrated anyway.
> 
> > 
> > The comment to the function says that it searches for the first free
> > counter, but obviously for_each_set_bit() searches for the first set
> > counter.
> 
> No it doesn't. It iterates over the counters the event can count on.
> 
> > The following test_and_set_bit() tries to enable already set
> > bit, which is weird.
> 
> Maybe you could try to actually read the code?
> 
> > 
> > This patch, by using find_and_set_bit(), fixes this automatically.
> 
> This doesn't fix anything, but instead actively breaks the driver.
> 
> > 
> > Fixes: a639027a1be1 ("drivers/perf: Add Apple icestorm/firestorm CPU PMU driver")
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  drivers/perf/apple_m1_cpu_pmu.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
> > index cd2de44b61b9..2d50670ffb01 100644
> > --- a/drivers/perf/apple_m1_cpu_pmu.c
> > +++ b/drivers/perf/apple_m1_cpu_pmu.c
> > @@ -447,12 +447,8 @@ static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
> >  	 * counting on the PMU at any given time, and by placing the
> >  	 * most constraining events first.
> >  	 */
> > -	for_each_set_bit(idx, &affinity, M1_PMU_NR_COUNTERS) {
> > -		if (!test_and_set_bit(idx, cpuc->used_mask))
> > -			return idx;
> > -	}
> > -
> > -	return -EAGAIN;
> > +	idx = find_and_set_bit(cpuc->used_mask, M1_PMU_NR_COUNTERS);
> > +	return idx < M1_PMU_NR_COUNTERS ? idx : -EAGAIN;
> 
> So now you're picking any possible counter, irrespective of the
> possible affinity of the event. This is great.

Ok, I'll drop the patch. Sorry.
