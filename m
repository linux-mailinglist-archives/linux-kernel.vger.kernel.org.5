Return-Path: <linux-kernel+bounces-102791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8CA87B756
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F8DB23522
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF10C15B;
	Thu, 14 Mar 2024 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfPlvvFD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D08DDA7;
	Thu, 14 Mar 2024 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710394911; cv=none; b=rG2KcGx1FyDOxcQJosnxUY1y5UENbaj+Sq7Urp2jkkyqKKH/sX4SX4moU98u48DKMr5+mk60d7PCzpkgxEJu0Wy/LNdZIhHQ4bBVMLx6EC+J3yqlnQsKNIOxu7ojKk9UBINJ7UwGYutDYU2EslQ+rbueJSGEGlZz4+2My4U10+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710394911; c=relaxed/simple;
	bh=YwFID4EBBHMtdrqO3+xJw7DhnfNbIClbammWskEzMkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIQT9HoFx5RUsImH/OLTyIfUFtxrRTRU4uuoudJ9hO/hm6VR4f8otM37PBzuMju71VDp5Q8E/wJKlPGghvSwWHvXDGaXxUjOQgZmkeJ9FwbImYY4kdOUGskL1GGyyw4ey58BttBCbxshvRcnrTcMsQG1u1nw25atRfp2lw72OOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfPlvvFD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710394910; x=1741930910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YwFID4EBBHMtdrqO3+xJw7DhnfNbIClbammWskEzMkA=;
  b=WfPlvvFDFC38ZP7QabJZdydqV2oQIUUOWN60LISiwxG8cdgrOCjNvJHj
   F52j4CC9SFLm/1k3FZFz6M751Jy1dK6EqJ+Jnibhv8jkUEyKZ62BnSzrC
   4yL90NfvEuktT2VK13brAxMYcowe3pijbCWTp85kOD9BQz7089NjdNTlg
   LdbybPz9WWkTtYMyaE2imwnrqW5QNJV+o60+YR3Bn1foZc/O/aZoWoner
   V3zwYAenqkYjryJv4+Ap1zY/CXUeUtFe7NjT8N7dyVjDxAqM+YrIIpLfW
   z0c3nnEWvFHVBtCjhmXAGoFOz2BTXmiQUtEmRoRI7aMOUiTEnaHkJGWLX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="16352345"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="16352345"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 22:41:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="937055356"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="937055356"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2024 22:41:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 94B9DFBD; Thu, 14 Mar 2024 07:41:45 +0200 (EET)
Date: Thu, 14 Mar 2024 07:41:45 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-spi@vger.kernel.org, Michael Walle <mwalle@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mark Brown <broonie@kernel.org>, Michael Walle <michael@walle.cc>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: Fix error code checking in spi_mem_exec_op()
Message-ID: <20240314054145.GM112498@black.fi.intel.com>
References: <20240313194530.3150446-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240313194530.3150446-1-florian.fainelli@broadcom.com>

On Wed, Mar 13, 2024 at 12:45:30PM -0700, Florian Fainelli wrote:
> After commit cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with
> -EOPNOTSUPP"), our SPI NOR flashes would stop probing with the following
> visible in the kernel log:
> 
> [    2.196300] brcmstb_qspi f0440920.qspi: using bspi-mspi mode
> [    2.210295] spi-nor: probe of spi1.0 failed with error -95
> 
> It turns out that the check in spi_mem_exec_op() was changed to check
> for -ENOTSUPP (old error code) or -EOPNOTSUPP (new error code), but this
> means that for drivers that were converted, the second condition is now
> true, and we stop falling through like we used to. Fix the error to
> check for neither error being neither -ENOTSUPP *nor* -EOPNOTSUPP.
> 
> Fixes: cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP")
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

