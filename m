Return-Path: <linux-kernel+bounces-135810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1284B89CBA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2812808B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08971448E6;
	Mon,  8 Apr 2024 18:24:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFA91448C4;
	Mon,  8 Apr 2024 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600643; cv=none; b=qxd6orPogHn5tkid+QJ2vTkwsLqs8SV8o8lGt86qZC0TWTCCHxov57Me68+JDEXzwIbKsmXqyXoEyVYbgpqbhzD6+uQiR1MYH3hZ7Ab3WRnGC89JYrYV/UjCiCd4GwO1T5OG9k/PJCGg1xXp8HDCixVdJwQlh5vC3HtEydTpXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600643; c=relaxed/simple;
	bh=4SE1XiIqPsJ1L/kqgo8ct8w8uCtcg5bu7UGU+uxZsoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac5AzEHz884t47engb5D3k32HR4aCWmjXKFXcHYuPXwU+XhLKomEhgMK+/mu42SBm3AjnurduQnPIA6EEx5zp1NQkGX8X7hl+ylITUp2zYjOhbqwug8KV1ffx6EOpnLYMHXs3+5f64DBk1BNtUrNqYqZQVyqVjrj3gGQkHCxAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1391CDA7;
	Mon,  8 Apr 2024 11:24:31 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A25423F766;
	Mon,  8 Apr 2024 11:23:58 -0700 (PDT)
Date: Mon, 8 Apr 2024 19:23:55 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, peng.fan@oss.nxp.com,
	michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
	mturquette@baylibre.com
Subject: Re: [PATCH v2 1/5] clk: scmi: Allocate CLK operations dynamically
Message-ID: <ZhQ2Ow4vz1F9qBFl@pluto>
References: <20240325210025.1448717-1-cristian.marussi@arm.com>
 <20240325210025.1448717-2-cristian.marussi@arm.com>
 <7027a28723d2597d9f620f4e0e1da97e.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7027a28723d2597d9f620f4e0e1da97e.sboyd@kernel.org>

On Sun, Apr 07, 2024 at 09:38:46PM -0700, Stephen Boyd wrote:
> Quoting Cristian Marussi (2024-03-25 14:00:21)
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > index 8cbe24789c24..d5d369b052bd 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -16,6 +16,14 @@
> >  #define NOT_ATOMIC     false
> >  #define ATOMIC         true
> >  

Hi, 

thanks for the review.

> > +enum scmi_clk_feats {
> > +       SCMI_CLK_ATOMIC_SUPPORTED,
> > +       SCMI_CLK_MAX_FEATS
> > +};
> > +
> > +#define SCMI_MAX_CLK_OPS       (1 << SCMI_CLK_MAX_FEATS)
> > +
> > +static const struct clk_ops *clk_ops_db[SCMI_MAX_CLK_OPS];
> 
> Can it be 'scmi_clk_ops_db' for some name spacing?
> 

Yes.

> >  static const struct scmi_clk_proto_ops *scmi_proto_clk_ops;
> >  
> >  struct scmi_clk {
> > @@ -230,6 +202,106 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
> >         return ret;
> >  }
> >  
> > +/**
> > + * scmi_clk_ops_alloc() - Alloc and configure clock operations
> > + * @dev: A device reference for devres
> > + * @feats_key: A bitmap representing the desired clk_ops capabilities.
> 
> Drop the period please because it's not consistent with the previous
> argument descriptor.
>

Ok.
 
> > + *
> > + * Allocate and configure a proper set of clock operations depending on the
> > + * specifically required SCMI clock features.
> > + *
> > + * Return: A pointer to the allocated and configured clk_ops on Success,
> 
> Lowercase 'Success'.
>

Ok.
 
> > +
> > +/**
> > + * scmi_clk_ops_select() - Select a proper set of clock operations
> > + * @sclk: A reference to an SCMI clock descriptor
> > + * @atomic_capable: A flag to indicate if atomic mode is supported by the
> > + *                 transport
> > + * @atomic_threshold: Platform atomic threshold value
> 
> Is this in nanoseconds, microseconds, or ??? Maybe a better description is
> "clk_ops are atomic when clk enable_latency is less than X [time unit]" 
>

It is micro, I will comment better.

> > + *
> > + * After having built a bitmap descriptor to represent the set of features
> > + * needed by this SCMI clock, at first use it to lookup into the set of
> > + * previously allocated clk_ops to check if a suitable combination of clock
> > + * operations was already created; when no match is found allocate a brand new
> > + * set of clk_ops satisfying the required combination of features and save it
> > + * for future references.
> > + *
> > + * In this way only one set of clk_ops is ever created for each different
> > + * combination that is effectively needed.
> > + *
> > + * Return: A pointer to the allocated and configured clk_ops on Success, or
> 
> Lowercase 'Success'.
>

Ok.
 
> > + *        NULL otherwise.
> > + */
> > +static const struct clk_ops *
> > +scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
> > +                   unsigned int atomic_threshold)
> > +{
> > +       const struct scmi_clock_info *ci = sclk->info;
> > +       unsigned int feats_key = 0;
> > +       const struct clk_ops *ops;
> > +
> > +       /*
> > +        * Note that when transport is atomic but SCMI protocol did not
> > +        * specify (or support) an enable_latency associated with a
> > +        * clock, we default to use atomic operations mode.
> > +        */
> > +       if (atomic_capable && ci->enable_latency <= atomic_threshold)
> > +               feats_key |= BIT(SCMI_CLK_ATOMIC_SUPPORTED);
> > +
> 
> Can we have a static_assert() here that makes sure 'feats_key' isn't
> larger than the size of clk_ops_db?
> 
> 	static_assert(ARRAY_SIZE(clk_ops_db) >= feats_key);
> 

Ok.

> > +       /* Lookup previously allocated ops */
> > +       ops = clk_ops_db[feats_key];
> > +       if (!ops) {
> > +               ops = scmi_clk_ops_alloc(sclk->dev, feats_key);
> > +               if (!ops)
> > +                       return NULL;
> 
> This could be less nested if the first lookup is put in
> scmi_clk_ops_alloc() and the store below is folded in. Or an early
> return if found.
> 
> 	ops = clk_ops_db[feats_key];
> 	if (ops)
> 		return ops;
> 
> 	/* Didn't find one */
> 	ops = scmi_clk_ops_alloc(...)
> 	if (!ops)
> 		return NULL;
> 
> 	clk_ops_db[feats_key] = ops;
> 	return ops;
> 

ok.
		
> > +
> > +               /* Store new ops combinations */
> > +               clk_ops_db[feats_key] = ops;
> > +       }
> > +
> > +       return ops;
> > +}
> > +
> >  static int scmi_clocks_probe(struct scmi_device *sdev)
> >  {
> >         int idx, count, err;
> > @@ -285,16 +357,10 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
> >                 sclk->ph = ph;
> >                 sclk->dev = dev;
> >  
> > -               /*
> > -                * Note that when transport is atomic but SCMI protocol did not
> > -                * specify (or support) an enable_latency associated with a
> > -                * clock, we default to use atomic operations mode.
> > -                */
> > -               if (is_atomic &&
> > -                   sclk->info->enable_latency <= atomic_threshold)
> > -                       scmi_ops = &scmi_atomic_clk_ops;
> > -               else
> > -                       scmi_ops = &scmi_clk_ops;
> > +               scmi_ops = scmi_clk_ops_select(sclk, is_atomic,
> 
> 'is_atomic' should probably be 'transport_is_atomic' so this reads
> easier.
> 

Ok.

Thanks,
Cristian

