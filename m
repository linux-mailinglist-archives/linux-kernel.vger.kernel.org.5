Return-Path: <linux-kernel+bounces-127767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA188950A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3717E1F2236E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690645F873;
	Tue,  2 Apr 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maHAiFEF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4E39852;
	Tue,  2 Apr 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054835; cv=none; b=d6JSTt3+YbMioCjEBFfdHzmv5z9/1fg1mEefaO5qkx5jc8k/codKGUN7YMznwS+SbtwJnSRFF4om4jBd4HaGDnqn0+c5wlNSDF0AZL18x4cv3N1A8Y5yWa/bZmwJuQky1OMRokJSLW3fTHj0gQ0XnhkXe6wAICftqzobtHFafeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054835; c=relaxed/simple;
	bh=k022nX6/YPPR4BsOYglV2JlAfDksERSZMxLVjKjzuAU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qNXmF46radDhNaMkJzK7VwN/BaLjHnQLBmGJfOnqRcCn/EW/B+ZzfBik+Uvl6CZkmh+5lPlTGiYm3Yu9EP9WzcssGpRd0vbQNxbRnv3o7hZ2gimsk0mvQngj+hv73Iu+0oANZkj1aM0G7EnEwZ9wdutnb3iCZXagdhYU5+tO/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maHAiFEF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712054834; x=1743590834;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=k022nX6/YPPR4BsOYglV2JlAfDksERSZMxLVjKjzuAU=;
  b=maHAiFEFLN4zS7kEi2cO9UyJSfVFTnmzqUCiaFUj4Qc9ItKQKonVIWMC
   +TuLpoAvsnikacB7cgm0gCfcatawxS1bZ+rcHAkDovLLRWSUAZt6pswid
   Cuq8MiN6iRn+kN+2H0OOXfuGxZ62n8Qwazmu4wlf4tYufQXUcmYszfHoc
   sl7C0PoOfmDy8AA7PgOg1NZxh4WqyoPXh38/UfxjGJwlHqptx+lNQ8KW+
   3VS4PNWeJsRb91ADgitvtiI5qd2RNpfttD7cb0fE0LbtzHrOFUk8Z2D4F
   xnHPPVkRtdztix6pGAPdaGWj9cGSZHOrFCckwWlTfgdGahzKlUeUyaJzK
   A==;
X-CSE-ConnectionGUID: pOdqULfMQJu2HEFKRwA0GA==
X-CSE-MsgGUID: 02SfIspGS4CMQVu17wv7RQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7056453"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7056453"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17857033"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:47:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 13:47:08 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/9] platform/x86: asus-wmi: support toggling POST
 sound
In-Reply-To: <20240402022607.34625-5-luke@ljones.dev>
Message-ID: <0c8635b9-db16-9125-63bc-7761800e3e96@linux.intel.com>
References: <20240402022607.34625-1-luke@ljones.dev> <20240402022607.34625-5-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1894852132-1712054828=:1019"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1894852132-1712054828=:1019
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Apr 2024, Luke D. Jones wrote:

> Add support for toggling the BIOS POST sound on some ASUS laptops.
>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++++
>  drivers/platform/x86/asus-wmi.c               | 51 +++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h    |  3 ++
>  3 files changed, 63 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Document=
ation/ABI/testing/sysfs-platform-asus-wmi
> index ef1ac1a20a71..41b92e53e88a 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -194,3 +194,12 @@ Contact:=09"Luke Jones" <luke@ljones.dev>
>  Description:
>  =09=09Set the target temperature limit of the Nvidia dGPU:
>  =09=09=09* min=3D75, max=3D87
> +
> +What:=09=09/sys/devices/platform/<platform>/boot_sound
> +Date:=09=09Apr 2024
> +KernelVersion:=096.10
> +Contact:=09"Luke Jones" <luke@ljones.dev>
> +Description:
> +=09=09Set if the BIOS POST sound is played on boot.
> +=09=09=09* 0 - False,
> +=09=09=09* 1 - True
> \ No newline at end of file

Add the last newline please.

After fixing that, please add:

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.
--8323328-1894852132-1712054828=:1019--

