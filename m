Return-Path: <linux-kernel+bounces-76814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF52585FCFD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A241328D3D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D1014E2DD;
	Thu, 22 Feb 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INcmqX2B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0B39FC7;
	Thu, 22 Feb 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616990; cv=none; b=oo6IJqsobVrl/JM4o0DNHpNJ62i1FwlS5DklCPHyIFIxFMkBsfQrDV+L+a0OJStO4W7yAVphYU+cceDzWiT1/jpiTunm6AMzFljY1EiBIyb7fKQATxqmTlSaQ1ogCgGo6A+ge0kPYE12yyJK29YIlbokEwGUd2za9tMvRySTN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616990; c=relaxed/simple;
	bh=V5q0olFZaHFjv75+8HL4XJGmUV94kfnMQJIuIkAcg7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozoHBp/fBj/+zlhiqbMmeNGHBDh+Go5d/H5CITDf9PCveDycuWdiLwFeiobTCP0Zai79sGXYW/rg42+SjWkdn0A1baAGDD3qDe//Qv5gqQVXg4/qr5orfbQmdLC5iuwQcj9frDQoqZXXet/qwsiMbY3g+9C2ZTNXas6qVOb5/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INcmqX2B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708616989; x=1740152989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V5q0olFZaHFjv75+8HL4XJGmUV94kfnMQJIuIkAcg7o=;
  b=INcmqX2BNO0druDaAJz4vXXpYezg9rR4L9rEkoRMZTz8kYNwxCePfHvt
   BQImlj06VLOtDDDzpu+R0KVxf88fB9mFDMy9K7dtD0VLZqUmVqN+DBcxu
   VIfaVtMbMm7B9kbff9z13bIlOe8pntCrNalmO9ih30Q040G90DiJMbPWW
   8RrvsRRkG+rfw7tjnOc8bKy4K7okXlSy8wumhcIIPr+B8Xh9AhvQ8+dVj
   6WXobJ+9gAjXwrUVMI1zScMZD7TOVonDQhGv5yUL5co3dDwsaVeMBMNJE
   L9xAsnWHcWzZ6FO1JImaP+43XOhCzW/yfDfnQxq5dVwbPHPUH3+DXAA+M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2986848"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2986848"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:49:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913545530"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913545530"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:49:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdBKO-00000006fUF-46u7;
	Thu, 22 Feb 2024 17:49:40 +0200
Date: Thu, 22 Feb 2024 17:49:40 +0200
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
Subject: Re: [PATCH v4 5/5] net: wan: fsl_qmc_hdlc: Add framer support
Message-ID: <ZddtFG4bvCX-lsn3@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
 <20240222142219.441767-6-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222142219.441767-6-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 03:22:18PM +0100, Herve Codina wrote:
> Add framer support in the fsl_qmc_hdlc driver in order to be able to
> signal carrier changes to the network stack based on the framer status
> Also use this framer to provide information related to the E1/T1 line
> interface on IF_GET_IFACE and configure the line interface according to
> IF_IFACE_{E1,T1} information.

..

> +static int qmc_hdlc_framer_set_carrier(struct qmc_hdlc *qmc_hdlc)
> +{
> +	struct framer_status framer_status;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!qmc_hdlc->framer)
> +		return 0;

> +	spin_lock_irqsave(&qmc_hdlc->carrier_lock, flags);

cleanup.h ?

> +	ret = framer_get_status(qmc_hdlc->framer, &framer_status);
> +	if (ret) {
> +		dev_err(qmc_hdlc->dev, "get framer status failed (%d)\n", ret);
> +		goto end;
> +	}
> +	if (framer_status.link_is_on)
> +		netif_carrier_on(qmc_hdlc->netdev);
> +	else
> +		netif_carrier_off(qmc_hdlc->netdev);
> +
> +end:
> +	spin_unlock_irqrestore(&qmc_hdlc->carrier_lock, flags);
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko



