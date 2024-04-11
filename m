Return-Path: <linux-kernel+bounces-140121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5D78A0BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD59AB25B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCED140396;
	Thu, 11 Apr 2024 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HC7t/Vui"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793F140E3D;
	Thu, 11 Apr 2024 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825563; cv=none; b=LO5e7BeRnL+Eexx9veeb1OijRUCQk2rC9jB1P49fONlQEfBrAplTK9P45rWa9XfHnv/DOn6ArNCXMPAdjXtbbx/1dg2sAGctymKX0GRU24bcJO3Ma5JDzTTqjq3XjlSlETTpCycdEG+GRBxwlbClzczwigWqX4h855iXOFWzyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825563; c=relaxed/simple;
	bh=lgsUAxJHV2zDQUyE2DMtqw4s8VcunIdLQYHnZ02OboU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ALJ02baljdvzdmLK6/tsKKV5qsEtjcQ3yeMcnN9LEPOGMgZ+vuTMDBx6Zq6PWtwJ5T3Diwe/5ZyQqZ2wyDf+UEZErQhjjhmkcydTlO2W3tzv29K5vlsL0sr6fzXiNCw5Tq9u9VgmA6gHDRkH1cBnVLu5zxnXzInx85HfCbkeZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HC7t/Vui; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712825562; x=1744361562;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lgsUAxJHV2zDQUyE2DMtqw4s8VcunIdLQYHnZ02OboU=;
  b=HC7t/Vui8gDWbdjkOKW46kP+XXK/34rInWm4f27yzKt3lA1vkicfxv4M
   zsF4sIxLJ3l7Y5dtVPz0iZs0OH4nPcu+TiGRvCfqdtp3WI5wcWgVYkHBe
   FWoTMxj4bcMwmsEszoOB0hpuPDvADqNGcFLI/I34J0CAU31R1EtH4oEIx
   ymbF304x3b6mY3hKKeANY3qCjQRvHdR3GuMJM7dhwZ9GurUqZEGfyHhbw
   ij7rqabh1YSlWXB8fyiFkjIYE9GwAiU5825MKETpYk4awkS7RW6owQCuF
   k26dtcrG/tPaxEVNBAh5TVCpml/acAfkTz2p1JS4y1c/FUmnfXFGBl/3U
   Q==;
X-CSE-ConnectionGUID: OFzFjOzaT2WPyOV5LjA6LA==
X-CSE-MsgGUID: cSbxq1paQzSGmPmHwZc4cQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8351341"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8351341"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 01:52:41 -0700
X-CSE-ConnectionGUID: 7tZYcyBlQieaIAI7k8IGng==
X-CSE-MsgGUID: kvzRmrLYSpuAq+jdbg46dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="52022877"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 01:52:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Apr 2024 11:52:34 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH V4 7/9] tools/arch/x86/intel_sdsi: Fix meter_certificate
 decoding
In-Reply-To: <20240411025856.2782476-8-david.e.box@linux.intel.com>
Message-ID: <63c6ec75-324b-2370-94c3-fb95d4d8d754@linux.intel.com>
References: <20240411025856.2782476-1-david.e.box@linux.intel.com> <20240411025856.2782476-8-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-359966275-1712825554=:1017"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-359966275-1712825554=:1017
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 Apr 2024, David E. Box wrote:

> Fix errors in the calculation of the start position of the counters and i=
n
> the display loop. While here, use a #define for the bundle count and size=
=2E
>=20
> Fixes: 7fdc03a7370f ("tools/arch/x86: intel_sdsi: Add support for reading=
 meter certificates")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
=2Eintel.com>
> ---
> V4 - Use suggested struct bundle_encoding_counter cast
>=20
> V3 - Use macros for bundle size and count
>=20
> V2 - Split of V1 patch 7
>=20
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/inte=
l_sdsi/intel_sdsi.c
> index ae29214da102..ba2a6b6645ae 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -394,7 +394,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  =09printf("MMRC encoding:                %.4s\n", name);
> =20
>  =09printf("MMRC counter:                 %d\n", mc->mmrc_counter);
> -=09if (mc->bundle_length % 8) {
> +=09if (mc->bundle_length % METER_BUNDLE_SIZE) {
>  =09=09fprintf(stderr, "Invalid bundle length\n");
>  =09=09return -1;
>  =09}
> @@ -405,15 +405,16 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  =09=09return -1;
>  =09}
> =20
> -=09bec =3D (void *)(mc) + sizeof(mc);
> +=09bec =3D (struct bundle_encoding_counter *)(mc + 1);
> =20
>  =09printf("Number of Feature Counters:   %ld\n", BUNDLE_COUNT(mc->bundle=
_length));
> -=09while (count++ < mc->bundle_length / 8) {
> +=09while (count < BUNDLE_COUNT(mc->bundle_length)) {
>  =09=09char feature[5];
> =20
>  =09=09feature[4] =3D '\0';
>  =09=09get_feature(bec[count].encoding, feature);
>  =09=09printf("    %s:          %d\n", feature, bec[count].counter);
> +=09=09++count;
>  =09}
> =20
>  =09return 0;
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-359966275-1712825554=:1017--

