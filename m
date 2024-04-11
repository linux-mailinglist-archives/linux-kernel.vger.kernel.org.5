Return-Path: <linux-kernel+bounces-141466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC5D8A1E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7E9293394
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCC41C292;
	Thu, 11 Apr 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="OBm/IvIA"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E20205E10;
	Thu, 11 Apr 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859443; cv=none; b=GApvptPDKdGaoNbF3wD5vaTU2FdehQGtcunVV4pSSsuPGgHrrOMMEBYerrqO+OaUo2U6LHrmPeyLNxMt9oz44qAec96d3CJ/8jDfqPJwkSroeyfIEg4V+kMWXJ551xKlSS1dj5iGrvDrtWGRdS/STCrIXgNqWRcl8Ud9E0pLH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859443; c=relaxed/simple;
	bh=0KueAoC6lfE18Y1P8iyEq+dqafDrCXz1cRkaf4+YsRQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q4FZqJ8KXJGcUWrGPvfNCgBmG+E+kV8ElVvJBe6/xMm14qIuSAuwRZkTgFeYjjBx8VavJkxO7ycdlMQsawhNkHSWXrHjBsKwSwcCok7aA11PgMdsWuGMfmKNEz2HZNbEiR8Uc9qT7uI6t0rIwqM0456NhRUEgioV2YEBfZiPe3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=OBm/IvIA; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZNuEndJkZfjPbFRoFgCLAAXA/x6b3DqbleZY6/SG5AI=;
  b=OBm/IvIAaywL54IdE34g4y+4ViOnzwVTz2xhNjDp+swLTzV1zGutqlT5
   eikJPaRUSruH8HiwOo3ptdur+GiWxdn0d6dok6DsIiWYLH+lLeEmDvoIJ
   KWmO6Ln2XhpGLB81m9RBgMaUJfkIIm0p2hs3+mvwtISMdypITSMpH2VY2
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,193,1708383600"; 
   d="scan'208";a="84509401"
Received: from unknown (HELO hadrien) ([89.207.171.139])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 20:17:11 +0200
Date: Thu, 11 Apr 2024 20:17:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Greg KH <gregkh@linuxfoundation.org>
cc: Roman Storozhenko <romeusmeister@gmail.com>, jirislaby@kernel.org, 
    skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] sysrq: Auto release device node using __free attribute
In-Reply-To: <2024041111-tummy-boil-a6aa@gregkh>
Message-ID: <b6b33aa-faef-6919-7125-c2db11e784ee@inria.fr>
References: <20240411180256.61001-1-romeusmeister@gmail.com> <2024041111-tummy-boil-a6aa@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 11 Apr 2024, Greg KH wrote:

> On Thu, Apr 11, 2024 at 08:02:56PM +0200, Roman Storozhenko wrote:
> > Add a cleanup function attribute '__free(device_node)' to the device node
> > pointer initialization statement and remove the pairing cleanup function
> > call of 'of_node_put' at the end of the function.
> > The '_free()' attrubute is introduced by scope-based resource management
> > in-kernel framework implemented in 'cleanup.h'. A pointer marked with
> > '__free()' attribute makes a compiler insert a cleanup function call
> > to the places where the pointer goes out of the scope. This feature
> > allows to get rid of manual cleanup function calls.
> >
> > Suggested-by: Julia.Lawall <Julia.Lawall@inria.fr>
> > Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> > ---
> > This patch targets the next tree:
> > tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > tag: next-20240411
> > ---
> >  drivers/tty/sysrq.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > index 02217e3c916b..1d1261f618c0 100644
> > --- a/drivers/tty/sysrq.c
> > +++ b/drivers/tty/sysrq.c
> > @@ -758,11 +758,12 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
> >  static void sysrq_of_get_keyreset_config(void)
> >  {
> >  	u32 key;
> > -	struct device_node *np;
> >  	struct property *prop;
> >  	const __be32 *p;
> >
> > -	np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > +	struct device_node *np __free(device_node) =
> > +		of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > +
> >  	if (!np) {
> >  		pr_debug("No sysrq node found");
> >  		return;
> > @@ -781,8 +782,6 @@ static void sysrq_of_get_keyreset_config(void)
> >
> >  	/* Get reset timeout if any. */
> >  	of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
> > -
> > -	of_node_put(np);
> >  }
> >  #else
> >  static void sysrq_of_get_keyreset_config(void)
>
> Also, this change really makes no sense at all, the pointer never goes
> out of scope except when the function is over, at the bottom.  So why
> make this complex change at all for no benefit?
>
> In other words, properly understand the change you are making and only
> make it if it actually makes sense.  It does not make any sense here,
> right?

Maybe it would be nice to get rid of of_node_puts in the general case?
Even though this one is not very annoying, there are some other functions
where there are many of_node_puts, and convoluted error handling code to
incorporate them on both the success and failure path.  So maybe it would
be better to avoid the situation of having them sometimes and not having
them other times?  But this is an opinion, and if the general consensus is
to only get rid of the cases that currently add complexity, then that is
possible too.

julia

