Return-Path: <linux-kernel+bounces-81743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1E86799D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9A21F2DBFF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C9B134CE8;
	Mon, 26 Feb 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XcK3cI0j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B47FBAA;
	Mon, 26 Feb 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959284; cv=none; b=m/Pu/vY4dauu8wOsUSoUCqtL+zZ+gFa+iWYj0O8GUPrx4EbNtZnArjpwJ5HbZiYt3Bq9zZZ2xKCYDf4Vm50nHwDeYx7/yoMjmkfuXBS50sRZsTfJ4eI0WfHAktNs+Eb8h7TlhbvHSnStWATXdLOR4NGgLEMZP6keOybnnMGZfiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959284; c=relaxed/simple;
	bh=vI9IoCSZmqQXEbrURf2SoimV/L1fQOPbLjBXYzD8X9w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=et3WUxW+0rgZCi4409pZpJD1R/4Q230bwBMJJP8CbNukBm6g3BjTRSHIL3NiKZxGRZUq+1HNbt7EU4DovkxSuurHAY7LRflrnivbk66DZzVb3BRvCHQQEDsWcXtwg3nQk1j5FlkM8o3qcu29y8UivkQj66hTqLzlZp8w/93ECXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XcK3cI0j; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708959283; x=1740495283;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vI9IoCSZmqQXEbrURf2SoimV/L1fQOPbLjBXYzD8X9w=;
  b=XcK3cI0jR2CNZpudTeNbWk3RZf56+J2iie16bhE7YEGS3xptsZwXAwGZ
   omO2TUOLtrmkcg2r6UF9SRo61Pc0dtmPVW2jv83Yr0Zpzw/SPVelMNRO2
   oq1cE0f+0bQeP09x8J7WgnY6l7HfeOaYwJGMGTVCWRlnbmU0MSWXY47QF
   1qWQEQCNkf8QzahI8y36/4j26d+HY3VZRh9nAcAOdKjFfF0VzdFE69fIn
   +gQpcvHudNC0JEa6a5URYTo+qU5pBOnjB/U5cj/Edb8vD5JgAG9zu6arV
   Gy0fVH2/7rE/yzkgn+pMDKipmexz+dDxqRAgmZcdl/APWVE6oT4dCGiKp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3119085"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3119085"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:54:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="37481503"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.12])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:54:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Feb 2024 16:54:35 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] platform/x86/intel/vsec: Remove nuisance message
In-Reply-To: <20240221211204.515159-1-david.e.box@linux.intel.com>
Message-ID: <f10d8775-ce3f-d241-8d37-a2b1c5b1eb85@linux.intel.com>
References: <20240221211204.515159-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-890740348-1708959275=:1203"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-890740348-1708959275=:1203
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Feb 2024, David E. Box wrote:

> intel_vsec_walk_header() is used to configure features from devices that
> don't provide a PCI VSEC or DVSEC structure. Some of these features may
> be unsupported and fail to load. Ignore them silently as we do for
> unsupported features described by VSEC/DVSEC.
>=20
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/vsec.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/int=
el/vsec.c
> index 778eb0aa3479..0fdfaf3a4f5c 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -236,10 +236,7 @@ static bool intel_vsec_walk_header(struct pci_dev *p=
dev,
> =20
>  =09for ( ; *header; header++) {
>  =09=09ret =3D intel_vsec_add_dev(pdev, *header, info);
> -=09=09if (ret)
> -=09=09=09dev_info(&pdev->dev, "Could not add device for VSEC id %d\n",
> -=09=09=09=09 (*header)->id);
> -=09=09else
> +=09=09if (!ret)
>  =09=09=09have_devices =3D true;
>  =09}

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-890740348-1708959275=:1203--

