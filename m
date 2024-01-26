Return-Path: <linux-kernel+bounces-40546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F237783E23F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5C82830AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E19A224C2;
	Fri, 26 Jan 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EKA4huXJ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A422325;
	Fri, 26 Jan 2024 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296326; cv=none; b=D5UcRKwMoM2fCk0m8JoDWeGEBiJUMG/GPZvPrtbs3tg4ZtXQjGccqgM+iVgjvb/jmjDZxcRdSGwyuCGf+58l3BqczWTjvR/HeqpJBGy/SZumcFImG3oxPY0CbF97lFxhc2ULnr3S/pjs7Qec6Y/TBMBwRkLI2m6qisVoCtzhfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296326; c=relaxed/simple;
	bh=jaWGrEsj0xwmcRjCiHwzMlbtXQX59mx8qmU2Ril8Zes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT/vof6rEcwf5xyYPT4B8X9EGVOC/lyWTk867FH+cfC/aK+AP3igYFhdJ41sYtLx5PucPMgpF81b8IeJ8MeR3EEyHpM2an8rUd6n8td9MAgS7W83tUqvLNNoouuXCMR59Y5o3wIp7LrcVw0Ge3apTUG0YwmCpAT5780bnTKA9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EKA4huXJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nLQg+CQf6So6B81oYM1uthbWkvTwAT/8VfETmBbVhLk=; b=EKA4huXJjKyU9u89eVV828ryMs
	p8M8Oyd9mUmnLSv7c09sq2DFnyWEnKbbh9+10/oDGQuL9wf1j8Eo/l32m6leaU4jv5M7QJp3votF4
	I0AcKS5IFmE+g41AqdjRtaGcsQp6UmltIhpRbwX0bIqWGuv8oHZT+t49feVbVj3WqWcgSCUVyK9Zg
	3FsdYYRX5tl6ajvzxe0r7XFeHVPtdelHVDjDgeikic99CUo2QhhnyexPLnxM9QChQer8NBEhR5cvE
	X2z2goHQ5Sv03wzB2X50+gHoYkNtX8MHktixAaVmEJdAVAqRqQlEfGYPCn1Q51jjgA82bo2RJ4zPm
	irAvqozA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTRcR-00000005AjI-1uSc;
	Fri, 26 Jan 2024 19:12:03 +0000
Date: Fri, 26 Jan 2024 11:12:03 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Daniel Gomez <da.gomez@samsung.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/2] test_xarray: add tests for advanced multi-index use
Message-ID: <ZbQEA6WIh0HrFTbP@bombadil.infradead.org>
References: <20231104005747.1389762-2-da.gomez@samsung.com>
 <202311152254.610174ff-oliver.sang@intel.com>
 <ZVfS8fiudvHADtoR@bombadil.infradead.org>
 <ZVfT3bs9+F0jqIAw@casper.infradead.org>
 <ZVfUnhzv4UDigZKa@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVfUnhzv4UDigZKa@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Nov 17, 2023 at 01:01:18PM -0800, Luis Chamberlain wrote:
> On Fri, Nov 17, 2023 at 08:58:05PM +0000, Matthew Wilcox wrote:
> > On Fri, Nov 17, 2023 at 12:54:09PM -0800, Luis Chamberlain wrote:
> > > +/*
> > > + * Can be used in contexts which busy loop on large number of entries but can
> > > + * sleep and timing is if no importance to test correctness.
> > > + */
> > > +#define XA_BUG_ON_RELAX(xa, x) do {				\
> > > +	if ((tests_run % 1000) == 0)				\
> > > +		schedule();					\
> > > +	XA_BUG_ON(xa, x);					\
> > > +} while (0)
> > 
> > That is awful.  Please don't do that.  You're mixing two completely
> > unrelated thing into the same macro, which makes no sense.  Not only
> > that, it's a macro which refers to something in the containing
> > environment that isn't a paramter to the macro.
> 
> I figured you'd puke. Would you prefer I just open code the check on the loop
> though? I'm sure another alternative is we *not care* about these
> overloaded systems running the test. What would you prefer?

OK without any particular preferences outlined this is what I have,
splitting the two contexts and making the busy loop fix clearer.

+#define XA_BUSY_LOOP_RELAX(xa, x) do {                         \
+       if ((i % 1000) == 0)                                    \
+               schedule();                                     \
+} while (0)
+
+/*
+ * Can be used in contexts which busy loop on large number of entries but can
+ * sleep and timing is if no importance to test correctness.
+ */
+#define XA_BUG_ON_RELAX(i, xa, x) do {                         \
+       XA_BUSY_LOOP_RELAX(i);                                  \
+       XA_BUG_ON(xa, x);                                       \
+} while (0)

Thoughts?

  Luis

