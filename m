Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3027F3372
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjKUQQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKUQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:16:18 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC22194
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:16:15 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9beb865a40so5379676276.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700583374; x=1701188174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7132CXfUB1dIK7Gmp7xy1yfmtHIvsYahpiV3MBz0a0=;
        b=GP/UPil69kydzqFR/hqtFscKDaQbzKReKFtFme1qlG2Yxy+1vPzF6cxPT40968hAn+
         Fsa9jfaRM0B7V0mYD1nQljQEW0DXDAgnvdeatlX4az6frMQdM026ofn9PF3GllanBx+o
         aqX8bTFJ8Qhnrp+37EN1S/XXzjpawnUPb6ldq5c6tU56Ku38wcLmPCWO9Wfyw6boGNTv
         jju4IOfTwPoeCqgwO39pQFE/HYubslzIHTs6MyZk2BOEIZB7JsCCa6UE60KLyKCl/RvV
         ALEF6E55HzSHasOBzAjnzehFyHrvjY9RZGH3BuzxvVXMHV4VKZYqfDSaNBsPUyiCEVC/
         gPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583374; x=1701188174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7132CXfUB1dIK7Gmp7xy1yfmtHIvsYahpiV3MBz0a0=;
        b=QuNN7g11PaU13YNpq+M+ZgRAevMDO9/7Qd60UCft/msN951JQVBN6QAEBPTMJeRg/4
         ztpO7p3f38MpXbpMNUvA6iHyXesMa2xRvbAJq1KomA25mXhtdlR8Yb4ow1aSNIYBzNMB
         W0RzG3GQqqfLLU/93G6u0XgmJy3epst42BE6xk2A1yKlQXsrb7YyjcmJu+NmpHsnd6uJ
         UobTlNC81CqhCYzhRr/hN2HxNFDOp8e73oa6MtOGdIqbdFjR6pvpDhSL5tgirwaXH+oA
         LPrSmkIGbdR04eFPTXQswRddldCLnLHbH98NzgQbtfidVGh/mHQILNOCJkYvmjVEoLsp
         2btQ==
X-Gm-Message-State: AOJu0Ywh47GoMevP4niJO8OcpwiqQB8zTSN19rqc4RUr8Vuhfyhyiw5E
        eDYiDO/PvkxBEJfHIyH43qd1oHWaFLV1bw==
X-Google-Smtp-Source: AGHT+IGi9uK16aYMAYQhI90N2Dt00CS1k9ov+suyCQkx5en9XvS7iOSQ5LAGauyh7JBmkqcgxMMsew==
X-Received: by 2002:a5b:351:0:b0:daf:686c:4919 with SMTP id q17-20020a5b0351000000b00daf686c4919mr10494867ybp.18.1700583374213;
        Tue, 21 Nov 2023 08:16:14 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e005:b808:45e:1b60])
        by smtp.gmail.com with ESMTPSA id j4-20020a258b84000000b00d9a3fe483cfsm773101ybl.23.2023.11.21.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:16:13 -0800 (PST)
Date:   Tue, 21 Nov 2023 08:16:13 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 07/34] perf/arm: optimize opencoded atomic find_bit() API
Message-ID: <ZVzXzbbQq2QEYtgs@yury-ThinkPad>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-8-yury.norov@gmail.com>
 <20231121155344.GB1938@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121155344.GB1938@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 03:53:44PM +0000, Will Deacon wrote:
> On Sat, Nov 18, 2023 at 07:50:38AM -0800, Yury Norov wrote:
> > Switch subsystem to use atomic find_bit() or atomic iterators as
> > appropriate.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  drivers/perf/arm-cci.c        | 23 +++++------------------
> >  drivers/perf/arm-ccn.c        | 10 ++--------
> >  drivers/perf/arm_dmc620_pmu.c |  9 ++-------
> >  drivers/perf/arm_pmuv3.c      |  8 ++------
> >  4 files changed, 11 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> > index 61de861eaf91..70fbf9d09d37 100644
> > --- a/drivers/perf/arm-cci.c
> > +++ b/drivers/perf/arm-cci.c
> > @@ -320,12 +320,8 @@ static int cci400_get_event_idx(struct cci_pmu *cci_pmu,
> >  		return CCI400_PMU_CYCLE_CNTR_IDX;
> >  	}
> >  
> > -	for (idx = CCI400_PMU_CNTR0_IDX; idx <= CCI_PMU_CNTR_LAST(cci_pmu); ++idx)
> > -		if (!test_and_set_bit(idx, hw->used_mask))
> > -			return idx;
> > -
> > -	/* No counters available */
> > -	return -EAGAIN;
> > +	idx = find_and_set_bit(hw->used_mask, CCI_PMU_CNTR_LAST(cci_pmu) + 1);
> 
> CCI400_PMU_CNTR0_IDX is defined as 1, so isn't this wrong?

You're right. Will fix in v2
 
> [...]
> 
> > diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> > index 30cea6859574..e41c84dabc3e 100644
> > --- a/drivers/perf/arm_dmc620_pmu.c
> > +++ b/drivers/perf/arm_dmc620_pmu.c
> > @@ -303,13 +303,8 @@ static int dmc620_get_event_idx(struct perf_event *event)
> >  		end_idx = DMC620_PMU_MAX_COUNTERS;
> >  	}
> >  
> > -	for (idx = start_idx; idx < end_idx; ++idx) {
> > -		if (!test_and_set_bit(idx, dmc620_pmu->used_mask))
> > -			return idx;
> > -	}
> > -
> > -	/* The counters are all in use. */
> > -	return -EAGAIN;
> > +	idx = find_and_set_next_bit(dmc620_pmu->used_mask, end_idx, start_idx);
> 
> It might just be me, but I'd find this a tonne easier to read if you swapped
> the last two arguments around so that the offset came before the limit in
> the new function.

I personally agree, but we already have find_next_*_bit(addr, nbits, offset)
functions, and having atomic versions of the same with different order
of arguments will make it even more messy...

Thanks,
        Yury
