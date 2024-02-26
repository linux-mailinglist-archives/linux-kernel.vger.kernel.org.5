Return-Path: <linux-kernel+bounces-81759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 850AE867B17
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059DEB37311
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3E0137C2D;
	Mon, 26 Feb 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjQDRDzC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641A12BE8B;
	Mon, 26 Feb 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959846; cv=none; b=sc4YAT30hIL4fxTiIHXmzt6cP6tftgt27x+duiYjclfVf7rEgY6nzVUDjhXZMJ63Gz9inWVF5xlRZB/A2VZGIk5QhGN/9OaiuXY+Vb1BhEJxaKKdRaneDQsXDIaigJ8EdJ2PrURWr/YwzTvElEg0L7k9Y4MeENGFar65lWaGlr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959846; c=relaxed/simple;
	bh=Y1dn+SpcK75B319GpqPxt1u71VQ1SpTsGj2ng1Kz0ug=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bNbBg9EAbi4WCM3jrC1b6wcm9cV+Z8t/Xam/zeUECOcp1UO9+zn1SXCR6mNYQlXDWG3Lvk5bL6zc9gbEXwEtpFncfD8LL2ytHrKL4e6BtjVTzDFDJjUxyBycO43hmZjprutCKqcrhN33sCWhdvqCUanV18y0rheoA4Y4sHLyGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjQDRDzC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708959845; x=1740495845;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Y1dn+SpcK75B319GpqPxt1u71VQ1SpTsGj2ng1Kz0ug=;
  b=AjQDRDzCEc1lPiX7/maX1x26eHSGFSLkcNQPMKLSZw/sr4twU8auUfK+
   EcF2FEMFppUd5usUrHCj4j4P+bauTUB3YTGZzzVGMGrJkHxX5FP0stetg
   FpTrIQ4Tnsjnki+AyBXZHhNsVX7m0IU83Som2x49MMSEsVXRPWiqypJLp
   MJVxXIB+TQVIJglaWqwUlDv2c/L1W2RI8dRA6VWa7BcYXhoL0Pv6ZA+iF
   ZyxmoNmunWpRw9QxkQsfvMdoHn3NtlfI59H1ajRZvppPQZUWl8z2wRr3T
   J/ug+8SuDY89BSWmxjSPfvkjYZ+meWTRiLM32haD+TUpzYx05ZOm9LuXq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14387214"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14387214"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 07:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7235748"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.12])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 07:04:02 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Feb 2024 17:03:57 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/3] platform/x86/intel/pmc/lnl: Remove SSRAM support
In-Reply-To: <20240221211204.515159-2-david.e.box@linux.intel.com>
Message-ID: <ec8ba06f-5284-e086-985b-ac9518b6869f@linux.intel.com>
References: <20240221211204.515159-1-david.e.box@linux.intel.com> <20240221211204.515159-2-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-755813935-1708959837=:1203"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-755813935-1708959837=:1203
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Feb 2024, David E. Box wrote:

> A recent PMC firmware change in Lunar Lake caused the pmc_core driver to
> fail to probe. This is due to a change in the GUID for PMC telemetry
> coming from the SSRAM device. We are told the current update may change
> again before a final release so we can't upstream a fix just yet. In the
> meantime, remove SSRAM support for Lunar Lake so the driver can load and
> provide some basic functionality.
>=20
> Fixes: 3748dfdae2a6 ("platform/x86/intel/pmc: Add Lunar Lake M support to=
 intel_pmc_core driver")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-755813935-1708959837=:1203--

