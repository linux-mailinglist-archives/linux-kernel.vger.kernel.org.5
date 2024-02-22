Return-Path: <linux-kernel+bounces-76775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC2285FC5E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C482E28BEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FEF14D43C;
	Thu, 22 Feb 2024 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cpUCkWx6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D341474D4;
	Thu, 22 Feb 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615757; cv=none; b=i/MnibTJF+cOQByoYXTNoM/bDMqVtWqTR193YizoCvu2XVwwUkgLi5nc+921oRXUwbLjFNjXiY2zj5uAmGAA177+fUkYDaFCSU/sCzTvdDEMhDW+XoEg0eKPnHGwa+9WPU4BaF0DbBA3fWgqHsmt0GdbasE0dfh7xnsbdmli/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615757; c=relaxed/simple;
	bh=UMGrEK87Ud+pMVRA+mW3KlN70QQqpXNjVjwMAipmIVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0w8ZC5V0wKsjgGD6wRzaVmjBdTk4p7evtEpxrGStC4lRK0yHvCI50TXS7zE0vU/zTeSHwLqigCDBhPN5mMzn5cjdZ7wq87z5CB4J/9fg8qqDyS+b+31WrQzCAK2fHXRtZg1fB1aQ3zUx9CwLHBl163MxR3ZP5EfpSMq9y1uRlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cpUCkWx6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708615756; x=1740151756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UMGrEK87Ud+pMVRA+mW3KlN70QQqpXNjVjwMAipmIVY=;
  b=cpUCkWx6lg09KbQUaZ4Dg1BfaKowsCZszc3i5KAm4nHFdOPEack4EwXp
   71AUQBxnnYaKRw9Oip8MhZfiD0eiaTY7BwrcXCUrS0tDpQ7qsv72MiPl8
   lK3dQ3w4srdmbuCwrvaAB5xJGI8qHi+fPnOFfOdBENPDYYDF1ucMhql7q
   Pcbbx4bdaQz1ZTD46mrXUCVVhsAU0QbDX2WNlydQNDWP7kLBu2JM7PzIC
   Xjv8vc0O5pcQM6HPf1IN5E+4deZotFoM0QbL8VL5m8D8TCm78wHO/CpCr
   nekXeBDveJHIS+8Uj0l/YsWx/rDFMbvu18oEJPVrWPS+ImZ3XuskE0pwE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2984394"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2984394"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:29:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913543141"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913543141"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:29:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdB0U-00000006fE8-0mA7;
	Thu, 22 Feb 2024 17:29:06 +0200
Date: Thu, 22 Feb 2024 17:29:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/5] net: wan: Add support for QMC HDLC
Message-ID: <ZddoQTg32unJJ_qP@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
 <20240222142219.441767-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222142219.441767-2-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 03:22:14PM +0100, Herve Codina wrote:
> The QMC HDLC driver provides support for HDLC using the QMC (QUICC
> Multichannel Controller) to transfer the HDLC data.

..

> +struct qmc_hdlc {
> +	struct device *dev;
> +	struct qmc_chan *qmc_chan;
> +	struct net_device *netdev;
> +	bool is_crc32;
> +	spinlock_t tx_lock; /* Protect tx descriptors */

Just wondering if above tx/rx descriptors should be aligned on a cacheline
for DMA?

> +	struct qmc_hdlc_desc tx_descs[8];
> +	unsigned int tx_out;
> +	struct qmc_hdlc_desc rx_descs[4];
> +};

..

> +#define QMC_HDLC_RX_ERROR_FLAGS (QMC_RX_FLAG_HDLC_OVF | \
> +				 QMC_RX_FLAG_HDLC_UNA | \
> +				 QMC_RX_FLAG_HDLC_ABORT | \
> +				 QMC_RX_FLAG_HDLC_CRC)

Wouldn't be slightly better to have it as

#define QMC_HDLC_RX_ERROR_FLAGS				\
	(QMC_RX_FLAG_HDLC_OVF | QMC_RX_FLAG_HDLC_UNA |	\
	 QMC_RX_FLAG_HDLC_CRC | QMC_RX_FLAG_HDLC_ABORT)

?

..

> +	ret = qmc_chan_write_submit(qmc_hdlc->qmc_chan, desc->dma_addr, desc->dma_size,
> +				    qmc_hdlc_xmit_complete, desc);
> +	if (ret) {

> +		dev_err(qmc_hdlc->dev, "qmc chan write returns %d\n", ret);
> +		dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size, DMA_TO_DEVICE);
> +		return ret;

I would do other way around, i.e. release resource followed up by printing
a message. Printing a message is a slow operation and may prevent the (soon
freed) resources to be re-used earlier.

> +	}

..

> +	spin_lock_irqsave(&qmc_hdlc->tx_lock, flags);

Why not using cleanup.h from day 1?

> +end:

This label, in particular, will not be needed with above in place.

> +	spin_unlock_irqrestore(&qmc_hdlc->tx_lock, flags);
> +	return ret;
> +}

..

> +	/* Queue as many recv descriptors as possible */
> +	for (i = 0; i < ARRAY_SIZE(qmc_hdlc->rx_descs); i++) {
> +		desc = &qmc_hdlc->rx_descs[i];
> +
> +		desc->netdev = netdev;
> +		ret = qmc_hdlc_recv_queue(qmc_hdlc, desc, chan_param.hdlc.max_rx_buf_size);

> +		if (ret) {
> +			if (ret == -EBUSY && i != 0)
> +				break; /* We use all the QMC chan capability */
> +			goto free_desc;
> +		}

Can be unfolded to

		if (ret == -EBUSY && i)
			break; /* We use all the QMC chan capability */
		if (ret)
			goto free_desc;

Easy to read and understand.

> +	}

..

> +static int qmc_hdlc_probe(struct platform_device *pdev)
> +{

With

	struct device *dev = &pdev->dev;

the below code will be neater (see other comments for the examples).

> +	struct device_node *np = pdev->dev.of_node;

It is used only once, drop it (see below).

> +	struct qmc_hdlc *qmc_hdlc;
> +	struct qmc_chan_info info;
> +	hdlc_device *hdlc;
> +	int ret;
> +
> +	qmc_hdlc = devm_kzalloc(&pdev->dev, sizeof(*qmc_hdlc), GFP_KERNEL);
> +	if (!qmc_hdlc)
> +		return -ENOMEM;
> +
> +	qmc_hdlc->dev = &pdev->dev;
> +	spin_lock_init(&qmc_hdlc->tx_lock);
> +
> +	qmc_hdlc->qmc_chan = devm_qmc_chan_get_bychild(qmc_hdlc->dev, np);

	qmc_hdlc->qmc_chan = devm_qmc_chan_get_bychild(dev, dev->of_node);

> +	if (IS_ERR(qmc_hdlc->qmc_chan)) {
> +		ret = PTR_ERR(qmc_hdlc->qmc_chan);
> +		return dev_err_probe(qmc_hdlc->dev, ret, "get QMC channel failed\n");

		return dev_err_probe(dev, PTR_ERR(qmc_hdlc->qmc_chan), "get QMC channel failed\n");

> +	}
> +
> +	ret = qmc_chan_get_info(qmc_hdlc->qmc_chan, &info);
> +	if (ret) {

> +		dev_err(qmc_hdlc->dev, "get QMC channel info failed %d\n", ret);
> +		return ret;

Why not using same message pattern everywhere, i.e. dev_err_probe()?

		return dev_err_probe(dev, ret, "get QMC channel info failed\n");

(and so on...)

> +	}
> +
> +	if (info.mode != QMC_HDLC) {
> +		dev_err(qmc_hdlc->dev, "QMC chan mode %d is not QMC_HDLC\n",
> +			info.mode);
> +		return -EINVAL;
> +	}
> +
> +	qmc_hdlc->netdev = alloc_hdlcdev(qmc_hdlc);
> +	if (!qmc_hdlc->netdev) {

> +		dev_err(qmc_hdlc->dev, "failed to alloc hdlc dev\n");
> +		return -ENOMEM;

We do not issue a message for -ENOMEM.

> +	}
> +
> +	hdlc = dev_to_hdlc(qmc_hdlc->netdev);
> +	hdlc->attach = qmc_hdlc_attach;
> +	hdlc->xmit = qmc_hdlc_xmit;
> +	SET_NETDEV_DEV(qmc_hdlc->netdev, qmc_hdlc->dev);
> +	qmc_hdlc->netdev->tx_queue_len = ARRAY_SIZE(qmc_hdlc->tx_descs);
> +	qmc_hdlc->netdev->netdev_ops = &qmc_hdlc_netdev_ops;
> +	ret = register_hdlc_device(qmc_hdlc->netdev);
> +	if (ret) {
> +		dev_err(qmc_hdlc->dev, "failed to register hdlc device (%d)\n", ret);
> +		goto free_netdev;
> +	}
> +
> +	platform_set_drvdata(pdev, qmc_hdlc);
> +
> +	return 0;
> +
> +free_netdev:
> +	free_netdev(qmc_hdlc->netdev);
> +	return ret;
> +}


-- 
With Best Regards,
Andy Shevchenko



