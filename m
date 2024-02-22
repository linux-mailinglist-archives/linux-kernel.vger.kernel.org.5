Return-Path: <linux-kernel+bounces-76812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135F485FCF3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3431C22784
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2B4150983;
	Thu, 22 Feb 2024 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5F/XIpi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D71914F9CF;
	Thu, 22 Feb 2024 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616865; cv=none; b=QFl+DAcOKcG+/qVYIR6VTlP5NVrjva0tivBaezTv6oUdEvlPc/mTY3OIJT6vb0bhCEqrvSczV/5uVLHh4nKTPKp4IAxRaFr/dD1y3la/nErqkE6qbKLmbw8N5cBE8G/raxYlf9SGVnAGYNRtIxZo+DRFfjinXlBn6i+Fwffx6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616865; c=relaxed/simple;
	bh=qNO63zIkGbx+1iQfTUn4yfr86/RWZAYZ7RtIlx0aB0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRpkuqOc8puvUYzPW4ImP1PNT0vpEMb2yPQtF4my47NmHWANJAAA3b0HlJUO+waWJwIZ2uc1i/c4CFBlooAE0rJTPu4alDJCPYhqzVltDHQ0PzvFRMOFbkde11xifZxGitUPY6IeFuDx9pnHHyXznxFCqjAGg0GTO0zCUgB70CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5F/XIpi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708616863; x=1740152863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qNO63zIkGbx+1iQfTUn4yfr86/RWZAYZ7RtIlx0aB0A=;
  b=I5F/XIpiFZaWge5uEF4T6e5YwleZuX3hmtUyiMnn35h+h+WMCrdg704h
   b0tj9IFNEiQ4Ab0eqIQI3CZTomamEuyqGzrXb52/244S4KufmRA6YwfCm
   LQ++olQqQMh5XSUd/jYJDHztUBa0h4I97UBBhQVjdPx8pevzplKlx1CNX
   x1wZpagItgybI8NCxC2tgGdktw9REDGcwbVFFcpv/1CEpI3EU23XY4RDc
   a5LNhhIxwgMy8zJGNpoyNVDascT0aQZ/+aMB9A9AznyafRNCmY5CqJE8q
   zWf0oxQyLDceMj9xAAzgIY6BenYVpUFYegsVnVkINeFH5h7jeKzt2O+Lw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2986570"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2986570"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:47:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913545306"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913545306"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:47:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdBIN-00000006fSw-0zPE;
	Thu, 22 Feb 2024 17:47:35 +0200
Date: Thu, 22 Feb 2024 17:47:34 +0200
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
Subject: Re: [PATCH v4 4/5] net: wan: fsl_qmc_hdlc: Add runtime timeslots
 changes support
Message-ID: <Zddslpw398MJ49SS@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
 <20240222142219.441767-5-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222142219.441767-5-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 03:22:17PM +0100, Herve Codina wrote:
> QMC channels support runtime timeslots changes but nothing is done at
> the QMC HDLC driver to handle these changes.
> 
> Use existing IFACE ioctl in order to configure the timeslots to use.

..

> +static int qmc_hdlc_xlate_slot_map(struct qmc_hdlc *qmc_hdlc,
> +				   u32 slot_map, struct qmc_chan_ts_info *ts_info)
> +{
> +	DECLARE_BITMAP(ts_mask_avail, 64);
> +	DECLARE_BITMAP(ts_mask, 64);
> +	DECLARE_BITMAP(map, 64);

Perhaps more 1:1 naming?

	DECLARE_BITMAP(rx_ts_mask_avail, 64);
	DECLARE_BITMAP(tx_ts_mask, 64);
	DECLARE_BITMAP(slot_map, 64);

> +	/* Tx and Rx available masks must be identical */
> +	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
> +		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
> +			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
> +		return -EINVAL;
> +	}
> +
> +	bitmap_from_u64(ts_mask_avail, ts_info->rx_ts_mask_avail);
> +	bitmap_from_u64(map, slot_map);
> +	bitmap_scatter(ts_mask, map, ts_mask_avail, 64);
> +
> +	if (bitmap_weight(ts_mask, 64) != bitmap_weight(map, 64)) {
> +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots %*pb -> (%*pb, %*pb)\n",
> +			64, map, 64, ts_mask_avail, 64, ts_mask);


You can save a bit of code and stack:

		dev_err(qmc_hdlc->dev, "Cannot translate timeslots %64pb -> (%64pb, %64pb)\n",
			slot_map, rx_ts_mask_avail, tx_ts_mask);

> +		return -EINVAL;
> +	}
> +
> +	bitmap_to_arr64(&ts_info->tx_ts_mask, ts_mask, 64);
> +	ts_info->rx_ts_mask = ts_info->tx_ts_mask;
> +	return 0;
> +}

..

> +static int qmc_hdlc_xlate_ts_info(struct qmc_hdlc *qmc_hdlc,
> +				  const struct qmc_chan_ts_info *ts_info, u32 *slot_map)

Similar comments apply as per above function.

..

> +	ret = qmc_chan_get_ts_info(qmc_hdlc->qmc_chan, &ts_info);
> +	if (ret) {
> +		dev_err(qmc_hdlc->dev, "get QMC channel ts info failed %d\n", ret);
> +		return ret;

		return dev_err_probe(...);

> +	}

-- 
With Best Regards,
Andy Shevchenko



