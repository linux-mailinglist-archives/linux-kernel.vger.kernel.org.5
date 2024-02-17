Return-Path: <linux-kernel+bounces-69968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476B28590EB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C55B21B3D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881B67CF27;
	Sat, 17 Feb 2024 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgvXsaS1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5487C0A4;
	Sat, 17 Feb 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187256; cv=none; b=jnLp4roxueIUY/LPZ/5DqP9noP4WkpYcDj9EZxMXjEkajGw0OU+Igd/L4QjQRdAJ4PUR42LrurHDFQjwRwPQx3E2ePFehGnLX2jKAVwO5O3wsmjkDxy7Or2CTwsg1tNZ66THSgASVNXmuuZITPBeZYp5PdmQLJElxeMGH5l4GTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187256; c=relaxed/simple;
	bh=OxQUJIbmzj1GSzutcw5Ae7+lxbWZuacLVGzXpfA7VVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJmlGGPOLB2XxYZ+xUiDL+hrCt0bzaoLvTi7n4ScnAIpgLoM7ZtiNE0jKJUcAdB+AjA7XyT6GT4P9Uvqt0xcRlcj2GofdnyCOBdjArh2RnyPpnjoKSYdG8bCDNZ3ys1/jxPLBR/6Xc2Mc/i7dKdPLF0vZ4hgzbaFiHtFUUQjui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgvXsaS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD62C433C7;
	Sat, 17 Feb 2024 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708187256;
	bh=OxQUJIbmzj1GSzutcw5Ae7+lxbWZuacLVGzXpfA7VVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PgvXsaS1v8qai/8BwB0Dz7/3XyllpWX4krFIKs2Ct4c0wQnk0i751CtaXMqP7+BBA
	 DZXpfae8uBz2e9IL+CowZt3L9WuAJmd02uR0/+ge83Lb/TIwaXRM9wy8vXCDVjVp2f
	 Qp7VuW+vyAgg1tUTR584QRjvX8In1UEuzP0nfhjO+YUZpFEF0ftwnWah9ceaNPnZ2s
	 k1SblMCTJ3zwyjxlACWeC35Zl/92A/BU4wsnTK2h6cliFVIfGoRgTqnr7QOmJZ2Ngr
	 VZbqBoaaNjWQxgr05bINKWXJSeeCCOCVF8c69xeYCoDPAVxsDANrh/ehDboG0Pphx2
	 /K6rXv5azRBLQ==
Date: Sat, 17 Feb 2024 16:27:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-kernel@vger.kernel.org, David Laight <David.Laight@aculab.com>,
 linux-iio@vger.kernel.org
Subject: Re: [RESEND PATCH v2] iio: gts-helper: Fix division loop
Message-ID: <20240217162724.767f2ab6@jic23-huawei>
In-Reply-To: <dfe6e5da-b104-4acd-b323-4a7fa980de88@tweaklogic.com>
References: <Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
	<20240216135812.07c9b769@jic23-huawei>
	<dfe6e5da-b104-4acd-b323-4a7fa980de88@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Feb 2024 01:09:33 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 17/2/24 00:28, Jonathan Cameron wrote:
> > On Mon, 12 Feb 2024 13:20:09 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The loop based 64bit division may run for a long time when dividend is a
> >> lot bigger than the divider. Replace the division loop by the
> >> div64_u64() which implementation may be significantly faster.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> >>
> >> ---
> >> This is a resend. Only change is the base which is now the v6.8-rc4 and
> >> not the v6.8-rc1  
> > Given I'm not rushing this in, it is going via my togreg tree, so the
> > rebase wasn't really helpful (thankfully didn't stop it applying).
> > Would have been fine to send a ping response to the first posting of it.
> > 
> > I was leaving some time for David or Subhajit to have time to take
> > another look, but guess they are either happy with this or busy.
> > 
> > Applied to the togreg branch of iio.git and pushed out as testing for
> > all the normal reasons.
> > 
> > Jonathan
> >   
> >>
> >> This change was earlier applied and reverted as it confusingly lacked of
> >> the removal of the overflow check (which is only needed when we do
> >> looping "while (full > scale * (u64)tmp)". As this loop got removed, the
> >> check got also obsolete and leaving it to the code caused some
> >> confusion.
> >>
> >> So, I marked this as a v2, where v1 is the reverted change discussed
> >> here:
> >> https://lore.kernel.org/linux-iio/ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi/
> >>
> >> Revision history:
> >> v1 => v2:
> >>   - Drop the obsolete overflow check
> >>   - Rebased on top of the v6.8-rc4
> >>
> >> iio: gts: loop fix fix
> >> ---
> >>   drivers/iio/industrialio-gts-helper.c | 15 +--------------
> >>   1 file changed, 1 insertion(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> >> index 7653261d2dc2..b51eb6cb766f 100644
> >> --- a/drivers/iio/industrialio-gts-helper.c
> >> +++ b/drivers/iio/industrialio-gts-helper.c
> >> @@ -34,24 +34,11 @@
> >>   static int iio_gts_get_gain(const u64 max, const u64 scale)
> >>   {
> >>   	u64 full = max;
> >> -	int tmp = 1;
> >>   
> >>   	if (scale > full || !scale)
> >>   		return -EINVAL;
> >>   
> >> -	if (U64_MAX - full < scale) {
> >> -		/* Risk of overflow */
> >> -		if (full - scale < scale)
> >> -			return 1;
> >> -
> >> -		full -= scale;
> >> -		tmp++;
> >> -	}
> >> -
> >> -	while (full > scale * (u64)tmp)
> >> -		tmp++;
> >> -
> >> -	return tmp;
> >> +	return div64_u64(full, scale);
> >>   }
> >>   
> >>   /**  
> Hi Matti and Jonathan,
> 
> I somehow missed testing this patch earlier. The above patch works fine with apds9306 v7 driver(which work in progress!).
> There are no errors.
> My test script is simple:
> #!/bin/bash
> D=0
> S=`cat /sys/bus/iio/devices/iio:device${D}/in_illuminance_scale_available`
> 
> for s in $S; do
> 	echo $s
> 	echo $s > /sys/bus/iio/devices/iio:device${D}/in_illuminance_scale
> 	sleep 5
> done
> 
> One question - if I test a patch like this, do I put a "Tested-by" tag or just mention that I have tested it?
Both are useful - so thanks for this email.

Preference for a formal tag though as that goes in the git commit and we have
a convenient record that both says you tested it + that we should make sure
to cc you on related changes as you may well be in a position to test those
as well!

Thanks,

Jonathan

> 
> Regards,
> Subhajit Ghosh
> 
> >>
> >> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de  
> >   
> 


