Return-Path: <linux-kernel+bounces-86716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2971286C98A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD1E2885D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829837E0F0;
	Thu, 29 Feb 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MQ4HaOTu"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A73FB9D;
	Thu, 29 Feb 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211372; cv=none; b=j4F04NZ0B6FiSjeBiDTDfEDeDVPyLf3BR+DdisPSwtXFTAAIybcnL5pcgy/bT6Rnyq8G1mAT4vkXh6YRaoTJzXTtPXLEVv7YB5IJrUkY6aK+Uxb0CbpIiWdJ8BZex5yYxpPudwUnwHxiN4f1JDj2oNnBVvZjNaFK8E6otpJWnhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211372; c=relaxed/simple;
	bh=YP3VJ263/HyGboS/hEwMb/bOCJ54UXVL1CXQc5ItzaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS+e4TO63NE66MC/w/PDp2PHmi4MERrpautxk88RqB3fz0tZGY4ngm5yGVmleC8jW5IJ/ss+w2MVwhO1hvXB3FFBVa6SCBaoq4tsThRbm6doJvz8xOoewmHMlZdjMJAn6YoGV9rqEcrqKhkI/reyGDE7H8uKc8nCyMhGD/etats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MQ4HaOTu; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 457DAFF805;
	Thu, 29 Feb 2024 12:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709211367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yFgfKts7peO9Nva4G0PStusKwNhitcOIDLM2QDrk96U=;
	b=MQ4HaOTui8vfXdZ+ZvRDbuyYi6vSV+lfKsOePfRY+o0aPlihIKi5U54Y+tk5OQq4CdsWPl
	Zr50cTLFos3Pj/NB0cofKt4iAnyXsMDWOXFFV5l6O3tM7KoBKCAtNYL7767VA8sum5j6FP
	Iw92ZGNr6SU/hob4i2ZZoEQ9pEcMg6b+fVlG0Meb3sgaSD6unR7zIXWRnyfnh9iqLvx6TH
	fdD+hslgUX5LmwnGuHgDzJ6ZYDpj0xqhgMg7Y8cnQ7dMdOWFamAi49V4RubRxk1bsmMpyu
	MXdVshF+upQ10l4Vh3PDJLrkinmdSPK5AsUnxTjyrCkzIYMc/toTFNuDTuYZoQ==
Date: Thu, 29 Feb 2024 13:56:05 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 5/5] net: wan: fsl_qmc_hdlc: Add framer support
Message-ID: <20240229135605.6454052f@bootlin.com>
In-Reply-To: <ZddtFG4bvCX-lsn3@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
	<20240222142219.441767-6-herve.codina@bootlin.com>
	<ZddtFG4bvCX-lsn3@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andy,

On Thu, 22 Feb 2024 17:49:40 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Feb 22, 2024 at 03:22:18PM +0100, Herve Codina wrote:
> > Add framer support in the fsl_qmc_hdlc driver in order to be able to
> > signal carrier changes to the network stack based on the framer status
> > Also use this framer to provide information related to the E1/T1 line
> > interface on IF_GET_IFACE and configure the line interface according to
> > IF_IFACE_{E1,T1} information.  
> 
> ...
> 
> > +static int qmc_hdlc_framer_set_carrier(struct qmc_hdlc *qmc_hdlc)
> > +{
> > +	struct framer_status framer_status;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	if (!qmc_hdlc->framer)
> > +		return 0;  
> 
> > +	spin_lock_irqsave(&qmc_hdlc->carrier_lock, flags);  
> 
> cleanup.h ?
> 
> > +	ret = framer_get_status(qmc_hdlc->framer, &framer_status);
> > +	if (ret) {
> > +		dev_err(qmc_hdlc->dev, "get framer status failed (%d)\n", ret);
> > +		goto end;
> > +	}
> > +	if (framer_status.link_is_on)
> > +		netif_carrier_on(qmc_hdlc->netdev);
> > +	else
> > +		netif_carrier_off(qmc_hdlc->netdev);
> > +
> > +end:
> > +	spin_unlock_irqrestore(&qmc_hdlc->carrier_lock, flags);
> > +	return ret;
> > +}  
> 

I've got an issue with guard(spinlock_irqsave).

I changed this code to:
--- 8< ---
static int qmc_hdlc_framer_set_carrier(struct qmc_hdlc *qmc_hdlc)
{
	struct framer_status framer_status;
	int ret;

	if (!qmc_hdlc->framer)
		return 0;

	guard(spinlock_irqsave)(&qmc_hdlc->carrier_lock);

	ret = framer_get_status(qmc_hdlc->framer, &framer_status);
	if (ret) {
		dev_err(qmc_hdlc->dev, "get framer status failed (%d)\n", ret);
		return ret;
	}
	if (framer_status.link_is_on)
		netif_carrier_on(qmc_hdlc->netdev);
	else
		netif_carrier_off(qmc_hdlc->netdev);

	return 0;
}
--- 8< ---

I have the following warning (make C=1):
drivers/net/wan/fsl_qmc_hdlc.c:49:12: warning: context imbalance in 'qmc_hdlc_framer_set_carrier' - wrong count at exit

I also tried to call guard(spinlock_irqsave) before 'if (!qmc_hdlc->framer)'
but it does not change anything.

Did I miss something in the guard(spinlock_irqsave) usage ?

Best regards,
Hervé

