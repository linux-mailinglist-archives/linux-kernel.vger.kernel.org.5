Return-Path: <linux-kernel+bounces-37195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5730083AC78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1004729B125
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959A31272B9;
	Wed, 24 Jan 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PLi9BNiv"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863933CCA;
	Wed, 24 Jan 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107175; cv=none; b=JTo2VoItnG9H5zcNQxk86EZX4z25QQtZ2o9d4cGCIBZ+HgjKTarRsoN9g2BN/lEwKg2Tacgsfoqj+P4+QxsLwKbOiQcPLZFiPdcTUdGog66cxdAdQ6dHeIUhkkWNYspN071TlK36zUwgJMMHMbzTRLVT1xuZUTaLeFJY9nE/S3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107175; c=relaxed/simple;
	bh=c1x4jfQhGGeBjIpXjTtwx0BezuJXjsfMz9UJgm2t4eI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDhlWo5D0aHBapwza9zFuXYLQ8CazzD1IqcBlzDlKNWwFwW5ArEKlmMFuLGliQkh3FgB/lZVM/ey1yypfVMvHJ01lG+E81s7fIS21O/uDl0rQfYLdY/cVUgOwcnRX9ku18Br9HybGuiDzRIb+RYv5j/CQywUjxQodapGI+BMIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PLi9BNiv; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26458C000A;
	Wed, 24 Jan 2024 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706107171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+RHsh9TnhTPLnbjSPhtUEq2X2SMkZBbmcU+QGP4t3U=;
	b=PLi9BNiveB2FxZ5Kx251oO4epHEanAzAZi6a3RwROulee+FHoVP8qt4zusPQzxIoou3qPt
	XjebwPY3/axeHqsFudNEIKnVFgN3E83/svoI0vrJB9rUyMiB15J+R6NgbCAzWfCTze92up
	ab3hunpuURdxJofoQ7yly7K4JJ4HFOyOphiz868T8ySlLFfvnLvGrchuuHHSZeNXn37EG1
	yMUKU7eYp867QzbmHUd1W77/72zzF1HsHB0fMMo4N/N8dIIOG++H+jVMkQaf5+b14e3j1F
	vFg9T6rcSsYxUGX5jcRwaLaOV67Bj0FCVYbQq0KulDjG9IPblys8hZT9O8+lYA==
Date: Wed, 24 Jan 2024 15:39:27 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/4] net: wan: Add support for QMC HDLC
Message-ID: <20240124153927.174f5b7a@bootlin.com>
In-Reply-To: <7e7c5d46-001c-46db-85ca-eca013225a89@linux.dev>
References: <20240123164912.249540-1-herve.codina@bootlin.com>
	<20240123164912.249540-2-herve.codina@bootlin.com>
	<7e7c5d46-001c-46db-85ca-eca013225a89@linux.dev>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Vadim,

On Wed, 24 Jan 2024 10:03:45 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

[...]

> > +static void qmc_hcld_recv_complete(void *context, size_t length, unsigned int flags)
> > +{
> > +	struct qmc_hdlc_desc *desc = context;
> > +	struct net_device *netdev = desc->netdev;
> > +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(desc->netdev);  
> 
> a line above desc->netdev was stored in netdev. better to reuse it and 
> make declaration part consistent with qmc_hcld_xmit_complete

Yes.
Will updated in the next iteration.

[...]

> > +static netdev_tx_t qmc_hdlc_xmit(struct sk_buff *skb, struct net_device *netdev)
> > +{
> > +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> > +	struct qmc_hdlc_desc *desc;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&qmc_hdlc->tx_lock, flags);
> > +	desc = &qmc_hdlc->tx_descs[qmc_hdlc->tx_out];
> > +	if (desc->skb) {
> > +		/* Should never happen.
> > +		 * Previous xmit should have already stopped the queue.
> > +		 */  
> 
> according to the comment it's better to make if(unlikely(desc->skb)) or
> even WARN_ONCE()
> 

Indeed. I will use WARN_ONCE() in the next iteration.

Thanks for your review,
Hervé

