Return-Path: <linux-kernel+bounces-101574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6526087A8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5556B22812
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C7F4437D;
	Wed, 13 Mar 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZhjkAgO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC043AD1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338355; cv=none; b=U456mV7gfgim7jv2fvz2pivUSZZ0hPMnkziIVmBJTY2mH1Mk+yUs08Vg2SYH5mcZoCYp2HnJvtpLySwewqecBmuL+Kgix0rbb2TtnfXLWzdRfdVGhGzp46AVg7Bhl7BgJv7yKFIuRQsl26NTg9nrD9kKMXacciMejdk4R994XK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338355; c=relaxed/simple;
	bh=ObhAjMMSUSjidRVrJtIshpIU3PRlAw7QTAnpjAyYG3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+qW95EfiZ1NO+31gQrVp9raS6SWNcbGEsOBHN7F07uLDSr6lnFRxKkqePiaqfXsS92NVDFDiocNxh9b6SQmCFyv2uJr6dgP/XsVak2TAunWRN6/p42LWdEWGHb2ZvgFDB9SXajCE47qPiW1Ru6qA/FokP/xQs0QSla1KxriduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZhjkAgO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710338354; x=1741874354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ObhAjMMSUSjidRVrJtIshpIU3PRlAw7QTAnpjAyYG3w=;
  b=UZhjkAgOwnO/RVllSfmwm0sVa2cfL3oVuy5odNT+0DnBXSFs+s26ljsz
   cy2Z/Z4zfYq50goa4KbIH4SsNeQ6j4AeaUE035xQPsdmKyVF5858bgA/Y
   wXyBEJpLOxUW9puiprNSVo2STu2Z2EDG78psWLI+nrUuvQGjQv/xcx/Sd
   7LzyGoaNu5NPNAJ7GSqyf+CVf+yi7ZqNO3TDID3U8l/nfBM4D66d2cH9E
   pHnaUI7wQ47czsFVVAJx+TREEKkWa9mIR7WDUPjG35qmtQlDHaf/VJZQd
   KnPH+/BIbYjFZ477cPvEezO4rODh6KGlH1/oVM40CfhB/vaE7vw/mkMam
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16253102"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16253102"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 06:59:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="11854200"
Received: from svigh-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.52.216])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 06:59:10 -0700
Date: Wed, 13 Mar 2024 15:59:02 +0200
From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] mtd: core: Don't fail mtd_device_parse_register() if
 OTP is unsupported
Message-ID: <lxl3zzgq4kgbgxkya2c6zyagcnrcyp2lzewu553mkmgdlooeca@m2wyltn7qpog>
References: <20240307130418.3131898-1-aapo.vienamo@linux.intel.com>
 <20240307130418.3131898-3-aapo.vienamo@linux.intel.com>
 <CZQZXAB2GOCY.12YVJ6CRGG26B@kernel.org>
 <xeqscncwirfaz77mtpcvkueo5xto7vis5khr3uwclcx4sfx6eb@35j3grcqrzo2>
 <CZSIHWU6IYXB.2DUCUUYFTAB2X@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZSIHWU6IYXB.2DUCUUYFTAB2X@kernel.org>

On Wed, Mar 13, 2024 at 10:24:13AM +0100, Michael Walle wrote:
> On Mon Mar 11, 2024 at 5:20 PM CET, Aapo Vienamo wrote:
> > On Mon, Mar 11, 2024 at 03:38:17PM +0100, Michael Walle wrote:
> > > Also, you'll print an error message for EOPNOTSUPP, although that is
> > > not really an error. Is that intended? 
> >
> > Well, when we hit this, the functionality of the SPI memory itself is
> > degraded in the sense that the OTP functionality is not available. What
> > would you suggest?
> 
> But it's not really an error, I mean, we are ignoring that one on
> purpose now :) I'd just guard it with "if (ret != -EOPNOTSUPP)".

To clarify, are you suggesting a modification like this to the code at
the end of mtd_otp_nvmem_add()?

err:
	nvmem_unregister(...);
	if (ret != EOPNOTSUPP)
		return dev_err_probe(...);
	return 0;

Best,
Aapo

