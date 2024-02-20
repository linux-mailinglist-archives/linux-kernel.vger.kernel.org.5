Return-Path: <linux-kernel+bounces-72556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C996785B521
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052781C219E4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A048F5C618;
	Tue, 20 Feb 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBOlYvZw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44045C8E3;
	Tue, 20 Feb 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417702; cv=none; b=g32VrOaEAp7sJguIeQ4LaERopkKqVYY6Lp+Iy7q+b/Svh1VOKtRmVJi5ckHznuAPvd6Iul/5ZnaIK7nDd+UEN4QMNbU0N+4g/kgaHb0Ql6OFmR26N36Pxwd98fdJYC409Rk3YBe9flpg+/MQxLHlIe6ENVeHQmtJz7E6LHNRI7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417702; c=relaxed/simple;
	bh=oJi3V1tRMEwgDlhC520Ifp/R6zBTkiVQaqZyEkhfrVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpGFMQ9OXemzvspeFmVTJzJtcJA7c62YPdE6uol31F6uCDBBZOjIrMhEko3ocVncQfIAaiTeT6kCVJuT9jkx4J6QUegVkgIeSyhkW0rlruZDnmBKzjSK1lPi+GfrbPDDpp419R6DEdyFEyIkQxdnSiTYaYGgtHSDxvyA8hr7Hb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBOlYvZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52899C433C7;
	Tue, 20 Feb 2024 08:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708417702;
	bh=oJi3V1tRMEwgDlhC520Ifp/R6zBTkiVQaqZyEkhfrVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBOlYvZw2tJRck/Zg8EMtwh7APiUr/fhwwAHze2BPIm7NcUcbqGJse9WXmPoi0ksw
	 goQn52o3dXxiobRdcjtMGDPuPHsPoxGOkCWsIsPBb3Np/7WHHUtbGwtzvIxI2Kza8D
	 ++rmMriBysq3Z9RoB/nNQlkwEwiilLM7RxS5/ULt83c2yjJ4z8Hhplxqi/b4ib8kdf
	 xIFzdSy66602G9NdAlH5GY+NGK2BAZT7GsW+zUIzgDmS8NTqVUg1bwRJAnXfYLf2HB
	 tlBRlPh6wRKL0sbFMSZYpjC02+h0dAFtGfAdaL5zFcR+iACpKVa4WVypeNl/XZyjii
	 YRBdp0xU0g1GQ==
Date: Tue, 20 Feb 2024 08:28:16 +0000
From: Lee Jones <lee@kernel.org>
To: James Bottomley <jejb@linux.ibm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	drew@colorado.edu, Tnx to <Thomas_Roesch@m2.maus.de>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 03/10] scsi: NCR5380: Replace snprintf() with the safer
 scnprintf() variant
Message-ID: <20240220082816.GI10170@google.com>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-4-lee@kernel.org>
 <CAMuHMdX72mpGgb3Wp0WRX3V78nn+bWUqiYz25CjeMNPpWaPmxg@mail.gmail.com>
 <20240208102939.GF689448@google.com>
 <98bdd564c6bf1894717d060f3187c779e969fc5f.camel@linux.ibm.com>
 <20240219152312.GD10170@google.com>
 <f5bef33da6c50e5fd067577f16f460025fe9a601.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5bef33da6c50e5fd067577f16f460025fe9a601.camel@linux.ibm.com>

On Mon, 19 Feb 2024, James Bottomley wrote:

> On Mon, 2024-02-19 at 15:23 +0000, Lee Jones wrote:
> > On Sat, 10 Feb 2024, James Bottomley wrote:
> > 
> > > On Thu, 2024-02-08 at 10:29 +0000, Lee Jones wrote:
> > > > On Thu, 08 Feb 2024, Geert Uytterhoeven wrote:
> > > > 
> > > > > Hi Lee,
> > > > > 
> > > > > Thanks for your patch!
> > > > > 
> > > > > On Thu, Feb 8, 2024 at 9:48 AM Lee Jones <lee@kernel.org>
> > > > > wrote:
> > > > > > There is a general misunderstanding amongst engineers that
> > > > > > {v}snprintf() returns the length of the data *actually*
> > > > > > encoded into the destination array.  However, as per the C99
> > > > > > standard {v}snprintf() really returns the length of the data
> > > > > > that *would have been* written if there were enough space for
> > > > > > it.  This misunderstanding has led to buffer-overruns in the
> > > > > > past.  It's generally considered safer to use the
> > > > > > {v}scnprintf() variants in their place (or even sprintf() in
> > > > > > simple cases).  So let's do that.
> > > > > 
> > > > > Confused... The return value is not used at all?
> > > > 
> > > > Future proofing.  The idea of the effort is to rid the use
> > > > entirely.
> > > > 
> > > >  - Usage is inside a sysfs handler passing PAGE_SIZE as the size
> > > >    - s/snprintf/sysfs_emit/
> > > >  - Usage is inside a sysfs handler passing a bespoke value as the
> > > > size
> > > >    - s/snprintf/scnprintf/
> > > >  - Return value used, but does *not* care about overflow
> > > >    - s/snprintf/scnprintf/
> > > >  - Return value used, caller *does* care about overflow
> > > >    - s/snprintf/seq_buf/
> > > >  - Return value not used
> > > >    - s/snprintf/scnprintf/
> > > > 
> > > > This is the final case.
> > > 
> > > To re-ask Geert's question: the last case can't ever lead to a bug
> > > orproblem, what value does churning the kernel to change it
> > > provide? As Finn said, if we want to deprecate it as a future
> > > pattern, put it in checkpatch.
> > 
> > Adding this to checkpatch is a good idea.
> > 
> > What if we also take Kees's suggestion and hit all of these found in
> > SCSI in one patch to keep the churn down to a minimum?
> 
> That doesn't fix the churn problem because you're still changing the
> source.  For ancient drivers, we keep the changes to a minimum to avoid
> introducing inadvertent bugs which aren't discovered until months
> later.  If there's no actual bug in the driver, there's no reason to
> change the code.

Okay, no problem.  Would you like me to drop these from the set and
resubmit or are you happy to cherry-pick the remainder?

-- 
Lee Jones [李琼斯]

