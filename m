Return-Path: <linux-kernel+bounces-52420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4727F8497E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2444282807
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5D717585;
	Mon,  5 Feb 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mtNr2JbX"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8817582;
	Mon,  5 Feb 2024 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129542; cv=none; b=mDxSa82882qsDUUVD1P1gZNTQBdVombtfpXV991j2fPtqx9PhyEr1LRRfsMNHAOegWjUdM5EewY66munHUrEA9+n4XJUligvpQO8+mVpgmywYBSllIQZA6Myde0y1ZEA3z4dR6Ith4czHsmlpGNKlnraDWCGI4Hgqm9u6p+kHVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129542; c=relaxed/simple;
	bh=w1Rys9QhQUJG0bUNB3q+49Xn99F6N/iqMqvwhFp7mvM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmU3q6/pv9SK/JK6z5GCSd9aCUBGI+RNdJXgH2SuZnkPK7b/cGG4kYBa2HfExxQOitfRnNR6x7eB8T3jhDcQOg2ZBNrXHOd98GghMMAZ9hHYfvv2DWoFA26H9pPX3YCvIX3ddgb/X6FWW6yT+cTKt1lVsvRlUrYH90gwAVY5fLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mtNr2JbX; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415AcqEf070227;
	Mon, 5 Feb 2024 04:38:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707129532;
	bh=K5Ng12oUmnpp14ds6NECpZP7IHAQBqyIaoCkBu7qXv4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=mtNr2JbXNrend9ymFKrlGjUOf9B6QQ8ScmDdyBzDoiQf2UX0Mi3ZC9sSvgiLrzKd+
	 VoNpdS8R20ShML4K/I+LFPbTVbDzJGHyi71AbnMdOuz4dAqrSZaQL1B5/MMeEYfzay
	 vFwT2ErlXwC2p7U3r4EuWgNQ/XONnql0sJK3XmXI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415Acqhq130341
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 04:38:52 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 04:38:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 04:38:52 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415Acp6d013084;
	Mon, 5 Feb 2024 04:38:52 -0600
Date: Mon, 5 Feb 2024 16:08:51 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
        Mark Brown
	<broonie@kernel.org>, Apurva Nandan <a-nandan@ti.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gregory CLEMENT
	<gregory.clement@bootlin.com>,
        Vladimir Kondratiev
	<vladimir.kondratiev@mobileye.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH] spi: cadence-qspi: stop calling system-wide PM helpers
 for runtime PM
Message-ID: <20240205103851.rnptahgykf3pgyss@dhruva>
References: <20240202-cdns-qspi-pm-fix-v1-1-3c8feb2bfdd8@bootlin.com>
 <20240205100312.6f0f40db@xps-13>
 <CYX260CKXOUN.2H1DC1TG1Q6TY@bootlin.com>
 <20240205111254.70d5a5c1@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205111254.70d5a5c1@xps-13>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

On Feb 05, 2024 at 11:12:54 +0100, Miquel Raynal wrote:
> Hi Théo,
> 
> > > > The fatal conclusion of this is a deadlock: we acquire a lock on each
> > > > operation but while running the operation, we might want to runtime
> > > > resume and acquire the same lock.
> > > > 
> > > > Anyway, those helpers (spi_controller_{suspend,resume}) are aimed at
> > > > system-wide suspend and resume and should NOT be called at runtime
> > > > suspend & resume.
> > > > 
> > > > Side note: the previous implementation had a second issue. It acquired a
> > > > pointer to both `struct cqspi_st` and `struct spi_controller` using
> > > > dev_get_drvdata(). Neither embed the other. This lead to memory

Oops, I seem to have overlooked this. I think it should've been
spi_controller_get_devdata()

> > > > corruption that was being hidden inside the big cqspi->f_pdata array on
> > > > my setup. It was working until I tried changing the array side to its
> > > > theorical max of 4, which lead to the discovery of this gnarly bug.
> > > > 
> > > > Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
> > > > Fixes: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implementations")  

Thanks for the fixes.

> > >
> > > Your commit log makes total sense but I believe the diff is gonna break
> > > again the suspend to RAM operation. This is only my understanding
> > > right after quickly going through the whole story, so maybe I'm
> > > totally off topic.  
> > 
> > The current ->runtime_suspend() implementation would indeed (probably)
> > work for suspend-to-RAM if it wasn't for the wrong pointers to cqspi
> > and spi_controller (see side note from commit message).
> 
> Yeah, this probably needs to be fixed aside.
> 
> > I've not found a moment where `struct cqspi_st` embed `struct
> > spi_controller` at its start, so I do not believe this has ever worked.

I don't know how it worked either, but I had definitely tested and
provided logs at the time of posting the series,

https://lore.kernel.org/all/20230417091027.966146-1-d-gole@ti.com/

> > It might be the result of a mistake while porting a patch from a branch
> > that included other changes.

Hmm, could be, not entirely sure now. But I did test it and now don't
know how it had worked with that wrong pointer now that I see that
mistake.

> > 
> > > What happened if I understand the two commits blamed above:
> > >
> > > - There were PM hooks.
> > > - Someone turned them into runtime PM hooks (breaking regular
> > >   suspend/resume).
> > > - Someone else added the "missing" suspend/resume logic inside the
> > >   runtime PM hooks to fix suspend and resume.
> > > - You are removing this logic because it leads to deadlocks.
> > >
> > > There was likely a misconception of what is expected in both cases
> > > (quick and small power savings vs. full power cycle/loosing the whole
> > > configuration).

The context was as follows,

The upstream cqspi driver prior to this:
https://lore.kernel.org/all/20230417091027.966146-1-d-gole@ti.com/
series had buggy suspend resume. That needed fixing hence I added the
first patch that introduced the buggy pointer but somehow still ended up
working after suspend resume.

After that, I also wanted the driver to support runtime_pm. I thought
that both system suspend and runtime pm would have similar requirements
from a driver POV since the IP essentially would turn off and from it's
view would need system suspend like suspend resume calls.

> > >
> > > I would propose instead to create two distinct set of functions:
> > > - One for runtime PM
> > > - One for suspend/resume
> > > This way the runtime PM no longer deadlocks and people using
> > > suspend/resume won't get affected? I don't know if your runtime hooks
> > > *will* always be called during a suspend/resume. I hope so, which would
> > > make the split quite easy and without any code duplication.  
> > 
> > That does indeed sound like the right approach. Runtime hooks can be
> > called from suspend/resume if needs be. Runtime PM then gets disabled
> > at the late stage.
> 
> Would make sense indeed.

Now that I look at it, perhaps it is best to have 2 seperate calls for
runtime and system pm.

> 
> > I do not believe currently system-wide suspend can be working.
> > spi_controller_{suspend,resume} are being called with a bogus pointer.
> > This makes me ask: should the system-wide suspend/resume part be
> > addressed with this patch or a follow-up? It feels like a separate
> > concern to me.
> 
> Probably two patches, yes.

Yes, I think it best that we add a proper system suspend and runtime pm
support for this driver.

Again, thanks for catching this bug and reporting a fix. I also have an
SK-AM62 handy which uses this ospi controller so let me see if I can
help test your patches with system and runtime pm as well whenever you
do post them.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

