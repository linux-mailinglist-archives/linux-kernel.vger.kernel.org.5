Return-Path: <linux-kernel+bounces-86516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56C086C66F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BDC1F220A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DD96350D;
	Thu, 29 Feb 2024 10:09:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F5C63408;
	Thu, 29 Feb 2024 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201358; cv=none; b=Im48sKjodaL6V2AwHS1zM5o63cNfaLH/uLD0v43BxqMJo+RDf7Fy4Xjj5GE+nGCyu7qssWOa9aM1aCsAT5TsiRzRIyKtIpkMJewLFacubbAU/k4XlCEQhhr2UhMzwXYoo0QUcFDoWWvZXOAeDox7jTsJa1I43iPY1+Y3FhNTgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201358; c=relaxed/simple;
	bh=8bR6PwZBq4qbVJA3nu9uxIqMtWjtSXCP92eEOytRYyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTWGWuy8glQWK24AoNQM28JA8FXgBNbditrvBGhSaraBVSeEmiHdKrJVXtRVWMfWv4pKPAQXfNwGrdTariEG8HsSGH+/+6bDlauyAh8x5ZlRfRp33KCJT2XmXbbwJ7UORXcjtAIU7e+fPnQsa4OL0KmKegvpv8Ae3OWrmdC9No8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9978D1FB;
	Thu, 29 Feb 2024 02:09:53 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F29D73F762;
	Thu, 29 Feb 2024 02:09:12 -0800 (PST)
Date: Thu, 29 Feb 2024 10:09:10 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
	Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 6/7] clk: scmi: Allocate CLK operations dynamically
Message-ID: <ZeBXxjKiDMT2YPtP@pluto>
References: <20240214183006.3403207-1-cristian.marussi@arm.com>
 <20240214183006.3403207-7-cristian.marussi@arm.com>
 <500e265eb7c6a03a40e0067c8806e059.sboyd@kernel.org>
 <ZdcFuV0KQDXTH8L8@pluto>
 <1d0baf6dbaa1c2ca6594f9a2bcade2c4.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d0baf6dbaa1c2ca6594f9a2bcade2c4.sboyd@kernel.org>

On Wed, Feb 28, 2024 at 06:20:34PM -0800, Stephen Boyd wrote:
> Quoting Cristian Marussi (2024-02-22 00:28:41)
> > On Wed, Feb 21, 2024 at 09:44:14PM -0800, Stephen Boyd wrote:
> > > 
> > > It's not great to move these function pointer structs out of RO memory
> > > to RW. I'm also not convinced that it's any better to construct them at
> > > runtime. Isn't there a constant set of possible clk configurations? Or
> > > why can't we simply add some failures to the clk_ops functions instead?
> > 
> > Well, the real clock devices managed by the SCMI server can be a of
> 
> SCMI is a server!? :)
> 

..well the platform fw act as a server in the client-server SCMI
model...so...I know these days it's cooler to be "serverless" but..hey...
..at least is not a BO2k server :P

> > varying nature and so the minimum set of possible clk configurations
> > to cover will amount to all the possible combinations of supported ops
> > regarding the specific clock properties (i.e. .set_parent / .set_rate /
> > .enable / .get/set_duty_cycle / atomic_capability ... for now)...we
> > simply cannot know in advance what the backend SCMI server is handling.
> > 
> > These seemed to me too much in number (and growing) to be pre-allocated
> > in all possible combinations. (and mostly wasted since you dont really
> > probably use all combinations all the time)
> > 
> > Moreover, SCMI latest spec now exposes some clock properties (or not) to
> > be able avoid even sending an actual SCMI message that we know will be
> > denied all the time; one option is that we return an error,, as you said,
> > but what is the point (I thought) to provide at all a clk-callback that
> > we know upfront will fail to be executed every time ? (and some consumer
> > drivers have been reported by partners not to be happy with these errors)
> > 
> > What I think could be optimized here instead, and I will try in the next
> > respin, it is that now I am allocating one set of custom ops for each clock
> > at the end, even if exactly the same ops are provided since the clock
> > capabilities are the same; I could instead allocate dynamically and fill only
> > one single set of ops for each distinct set of combinations, so as to avoid
> > useless duplication and use only the miminum strict amount of RW memory
> > needed.
> > 
> 
> Yes please don't allocate a clk_op per clk. And, please add these
> answers to the commit text so that we know why it's not possible to know
> all combinations or fail clk_ops calls.

Sure I posted this series a couple of days ago about this rework:

	https://lore.kernel.org/linux-arm-kernel/20240227194812.1209532-1-cristian.marussi@arm.com/

with a bit of context in the cover-letter and in the commit...but I can
add more commenting of course if needed.

Thanks for the review,
Cristian

