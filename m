Return-Path: <linux-kernel+bounces-58269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E7484E3BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92291C23997
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DDC7B3C8;
	Thu,  8 Feb 2024 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlrB3k5z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC481768F7;
	Thu,  8 Feb 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405091; cv=none; b=eIM5yU9XJd2fG5AusnDPDe4qSPJzpYbNBtcH/1tNWizKIe86t+5qZEmKtgh9G/qLrprNvUqyq/RWgb0fxdYcsU54GNHpHBPIkR5BjSYl+nteoMx/s9DAmWUUTnHTBvBevRMnVgZbaJIPsasua7X3DoQTVXWVIlKWS3mhYgUpwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405091; c=relaxed/simple;
	bh=/E29gLn3iCL7gPLUbNGH1GmxyWYk0YmDRNTGoiudIu4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QgvreXVBg69lYLzjevS0TLx5sksHk2AVG7piG6P1VRbZOrh39xqEHeErQUBznSe0XWhlhPwCNnkTbkjrb50R/TPds+rFLM+Cd7g46SPkFdbODXxswpc393vBHZ9ZFgyM2cbrSlfs6xU0UYFy1I6JROvjpmusMERjKYxFLL8Kq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlrB3k5z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707405090; x=1738941090;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=/E29gLn3iCL7gPLUbNGH1GmxyWYk0YmDRNTGoiudIu4=;
  b=LlrB3k5zgLQaggfW0Zi4V3qM9r9BV6ihoMlho5fyE+xASxbImOpkhr64
   l3fQFsLUf9D+quJEhneaGbgseZn8VhasUo6exF+Ahhrw5nFVMZz9fpxmC
   Btub7rr7c469TfCaDAogbUSHvowhKRo02S1IWYXuQQKDvbEVTzvJvLMVz
   Kml74S1BOjvkpA/qRCdloGTUjRUCYPMEJRdfqURmkKSXwBMqGLhU0SAll
   81NLIW8gSdsMJc6wEh4xeh1eU9o84CC8Ggdd0S8Ai+FDtc7cXWifyKTZm
   2M1AFYBouWGRsqmN3aCfoJck0IDBRamoUewDjdUQu0JjWv5gSiOqQbcAC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="12602963"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="12602963"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 07:11:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1670115"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 07:11:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Feb 2024 17:11:23 +0200 (EET)
To: Vishnu Sankar <vishnuocv@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, vsankar@lenovo.com, 
    Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH] Fix to correct wrong temp reporting on some ThinkPads
In-Reply-To: <CABxCQKvtgwxS_DU2U-LNrPiqHF4+y2YPkMgP4-nS6U3ccp8M7w@mail.gmail.com>
Message-ID: <2f280707-7250-4bb2-460c-5f8a02208179@linux.intel.com>
References: <20240131180757.35044-1-vishnuocv@gmail.com> <901e1fb0-1e42-7bf7-113d-3d0bbb62f4da@linux.intel.com> <CABxCQKvtgwxS_DU2U-LNrPiqHF4+y2YPkMgP4-nS6U3ccp8M7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1463870039-1707404934=:1104"
Content-ID: <e13be5e2-d46e-5ad3-9d82-daa5f42af0a7@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1463870039-1707404934=:1104
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <70fd06fb-ff27-7c79-0c7b-d07f2c055c0d@linux.intel.com>

On Thu, 8 Feb 2024, Vishnu Sankar wrote:

> Thanks a lot for the review.
> And sorry for the delay in response.

Small improvements to my earlier version below now that I reread it.

> On Tue, Feb 6, 2024 at 8:03=E2=80=AFPM Ilpo J=C3=A4rvinen <ilpo.jarvinen@=
linux.intel.com> wrote:
>=20
> > @@ -6174,6 +6191,21 @@ static int thermal_get_sensor(int idx, s32 *valu=
e)
=2E..
>       A code reader would be served much better if this convoluted logic =
is
>       simplied to:
>=20
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 case TPACPI_THERMAL_TPEC_12:
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (idx >=
=3D 12)
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return -EINVAL;
>=20
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (idx <=
=3D 7)

if (idx < 8) =09<- to match idx - 8

>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ec_offset =3D TP_EC_THERMAL_TMP0_NS + idx;
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ec_offset =3D TP_EC_THERMAL_TMP8_NS + (idx - 8);
>=20
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!acpi_e=
c_read(ec_offset, &tmp))
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return -EIO;
>=20
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *value =3D =
tmp * 1000;

1000 should likely be something from linux/units.h.


--=20
 i.
--8323328-1463870039-1707404934=:1104--

