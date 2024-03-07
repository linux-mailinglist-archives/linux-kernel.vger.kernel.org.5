Return-Path: <linux-kernel+bounces-95840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0745D8753CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2BEB236AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283BE12F380;
	Thu,  7 Mar 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="E+e5my4E"
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D277B1EEEA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.198.35.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827347; cv=none; b=suYJyhQMofOk7PY0nhq9uK93z2wpFO1qikKGayeo4A5yF6hygrI4hRlxDwVaYynS2OlIsDrFFHJIi6dm0xniynedcg5BKukk5awc6sEqmBDPOxdjpD/6RQn7LAiB51Unq3MExrqZu3L+T6JKoYyN2tZpAr648yEIJTchlKPwnQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827347; c=relaxed/simple;
	bh=KnOCTDumG/A9/5/SUytK/rT0ZUv7KFO9BrmC1LlkoEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To; b=A6Q8NDgOmJALsuKjyWrwgMGOy2tCQw/TAoQ6Kp7iXkTSLlQg8Py9DfgLa5t7MASSbL9aLM7wMzGBxPlk7xwMNsyN4iLfOflsRgp/ikl6/i/x0ycXqo72M3nKc6b874TVs5nMi5yDnw930UFL15F8i54IvZiSvPV/YlzUL1MmQNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=E+e5my4E; arc=none smtp.client-ip=92.198.35.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Date: Thu, 7 Mar 2024 17:02:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
	t=1709827335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=qNHy0ey9Rh5SkT/53hLFdIyIDdFiIk0IR0E13PdFioI=;
	b=E+e5my4E7F4awvZ2mTvJztGmw9kmA5Znr5n03/FWxR0jS5qXRXTTys4QY6IsLuVIFV26pM
	08Y/Nlif9P6prtPxiiXob2ffH7N7K/hXIi1+A1DuQOeslZivL4UoQuZ474fK4r7M5ptgeI
	fSvjhUYED8Or2XoRjIxvCA+KlIpIG6F3WlXAml3J7DxJhP39HSys5QDM4zVdybs5rmm3M7
	qMVnH7zzVgSsH2R0YWAKkv46TTFB3GDjgnOP5qtAgvzwKv04E1FNj4y2m7WF/+X9mAF1eV
	juvo/if/vvrMB6Tiz16qew6OgVwWqVbgTwtVeH7eA4PZ1eBjBGlZLoLnIjTrgA==
From: Alexander Dahl <ada@thorsis.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Dahl <ada@thorsis.com>, linux-mtd@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: mtd: nand: raw: Possible bug in nand_onfi_detect()?
Message-ID: <20240307-pantry-deceit-78ce20f47899@thorsis.com>
Mail-Followup-To: Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
References: <20240306-shaky-bunion-d28b65ea97d7@thorsis.com>
 <20240306164831.29eed907@xps-13>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306164831.29eed907@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello Miquel,

thanks for looking into this, see my remarks below.

Am Wed, Mar 06, 2024 at 04:48:31PM +0100 schrieb Miquel Raynal:
> Hi Alexander,
> 
> ada@thorsis.com wrote on Wed, 6 Mar 2024 15:36:04 +0100:
> 
> > Hello everyone,
> > 
> > I think I found a bug in nand_onfi_detect() which was introduced with
> > commit c27842e7e11f ("mtd: rawnand: onfi: Adapt the parameter page
> > read to constraint controllers") back in 2020.
> 
> Interesting. I don't think this patch did broke anything, as
> constrained controllers would just not support the read_data_op() call
> anyway.
> 
> That being said, I don't see why the atmel controller would
> refuse this operation, as it is supposed to support all
> operations without limitation. This is one of the three issues
> you have, that probably needs fixing.

I found a flaw in my debug messages hiding the underlying issue for
this.  I'm afraid this is another bug introduced by you with commit
9f820fc0651c ("mtd: rawnand: Check the data only read pattern only
once").  See this line in rawnand_check_data_only_read_support():

    if (!nand_read_data_op(chip, NULL, SZ_512, true, true))

This leads to nand_read_data_op() returning -EINVAL, because it checks
if its second argument is non-NULL.

I guess not only the atmel nand controller is affected here, but _all_
nand controllers?  The flag can never be set, and so use_datain is
false here?

> > Background on how I found this: I'm currently struggling getting raw
> > nand flash access to fly with an at91 sam9x60 SoC and a S34ML02G1
> > Spansion SLC raw NAND flash on a custom board.  The setup is
> > comparable to the sam9x60 curiosity board and can be reproduced with
> > that one.
> > 
> > NAND flash on sam9x60 curiosity board works fine with what is in
> > mainline Linux kernel.  However after removing the line 'rb-gpios =
> > <&pioD 5 GPIO_ACTIVE_HIGH>;' from at91-sam9x60_curiosity.dts all data
> > read from the flash appears to be zeros only.  (I did not add that
> > line to the dts of my custom board first, this is how I stumbled over
> > this.)
> > 
> > I have no explanation for that behaviour, it should work without R/B#
> > by reading the status register, maybe we investigate that
> > in depth later.
> 
> I don't see why at a first look. The default is "no RB" if no property
> is given in the DT so it should work.

Correct, nand_soft_waitrdy() is used in that case.

> Tracing the wait ready function calls might help.

Did that already.  On each call here the status register read contains
E0h and nand_soft_waitrdy() returns without error, because the
NAND_STATUS_READY flag is set.  It just looks fine, although it is
not afterwards.

> >  However those all zeros data reads happens when
> > reading the ONFI param page as well es data read from OOB/spare area
> > later and I bet it's the same with usual data.
> 
> Reading data without observing tWB + tR may lead to this.

I already suspected some timing issue.  Deeper investigation will have
to wait until we soldered some wires to the chip and connect a logic
analyzer however.  At least that's the plan, but this will have to
wait some days until after I finished some other tasks.

> > This read error reveals a bug in nand_onfi_detect().  After setting
> > up some things there's this for loop:
> > 
> >     for (i = 0; i < ONFI_PARAM_PAGES; i++) {
> > 
> > For i = 0 nand_read_param_page_op() is called and in my case all zeros
> > are returned and thus the CRC calculated does not match the all zeros
> > CRC read.  So the usual break on successful reading the first page is
> > skipped and for reading the second page nand_change_read_column_op()
> > is called.  I think that one always fails on this line:
> > 
> >     if (offset_in_page + len > mtd->writesize + mtd->oobsize) {
> > 
> > Those variables contain the following values:
> > 
> >     offset_in_page: 256
> >     len: 256
> >     mtd->writesize: 0
> >     mtd->oobsize: 0
> 
> Indeed. We probably need some kind of extra check that does not perform
> the if clause above if !mtd->writesize.
> 
> > The condition is true and nand_change_read_column_op() returns with
> > -EINVAL, because mtd->writesize and mtd->oobsize are not set yet in
> > that code path.  Those are probably initialized later, maybe with
> > parameters read from that ONFI param page?
> > 
> > Returning with error from nand_change_read_column_op() leads to
> > jumping out of nand_onfi_detect() early, and no ONFI param page is
> > evaluated at all, although the second or third page could be intact.
> > 
> > I guess this would also fail with any other reason for not matching
> > CRCs in the first page, but I have not faulty NAND flash chip to
> > confirm that.
> 
> Thanks for the whole report, it is interesting and should lead to fixes:
> - why does the controller refuses the datain op?

See above.

> - why nand_soft_waitrdy is not enough?

I don't know.  That's one reason I asked here.

> - changing the condition in nand_change_read_column_op()
> 
> Can you take care of these?

The last one probably after in depth reading of the code again, unsure
for the other two.

Greets
Alex


