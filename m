Return-Path: <linux-kernel+bounces-120967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8246088E10D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3968E1F24FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4AD153BD3;
	Wed, 27 Mar 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5+IoVyL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344EE153817;
	Wed, 27 Mar 2024 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541721; cv=none; b=QZiHyLQ4bgNZxk7MtMy8j9WOXeKXKJWmTdDuWZQ62l9k3uZJGK+ds/btd5eGueC0nKgKZ6IYXxCHndF2SD3gs3LMpQrt9am6YWZH/MbWCtzxhVpPLdGOemGZTvtr90+dDg8P5m+NHEfeNFsUhUt9lJaj/eLFCcpRpfhRsEl4HKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541721; c=relaxed/simple;
	bh=l1FCJiDrafS1WbsKl/A/tt3LYg6Mw6bdZbLD376WIhk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ufylvMw7P5I/HkmEW6GeEO/S2nexrZKwBkS2e4X/UerGuOd9m83XsGM1pJgfRM0gPNITbBrmcb2HjyLCZ8DZKVOzK5cdN6apulJQXYx98G6YZqE8TWvDbHiAEuJrNU1ZDXyVPt9845XvZQqQTCH61AzXS3A5EdiXt0tp5ce+QXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5+IoVyL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711541719; x=1743077719;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l1FCJiDrafS1WbsKl/A/tt3LYg6Mw6bdZbLD376WIhk=;
  b=U5+IoVyLOHpKnXHwiw582lZArLIRIpCSPKLSJ5Ufd7Hp4jRfxhYDyO4v
   kN3/jBM4lnSzDrFrLMxK32gJghUKqEr6nyvWcNtLAtnvM2zIk6vo3dDzs
   MrqzQP+QNK8w0EB9VKQXaLdThngS8qeUc7ZNudfzBWwFlqs/5KsITR1iL
   O/HmKup4V01v1JIDmCF/MyRE6he6ODMGzGn1MaM9Asz8DK7Vb6OPtKfQO
   /6eTT44rSl24rYLYwYOUGF3BZd/O7CpOGSm+Xb4XMRPbEFRGpdB/RpUdj
   dtaXSfl9to9i3wwI/2Z7I4P28FxKwq3bNHOYohHo2X/4YyIfnQTGz2f07
   Q==;
X-CSE-ConnectionGUID: 2fg0gIkhRlugBhxZ70RkOg==
X-CSE-MsgGUID: v8jxIV6GSS29bUqLPR/FzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="18068663"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="18068663"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 05:15:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="53754611"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.21])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 05:15:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 27 Mar 2024 14:15:12 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: naveenkrishna.chatradhi@amd.com, LKML <linux-kernel@vger.kernel.org>, 
    Carlos Bilbao <carlos.bilbao@amd.com>, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86/amd/hsmp: switch to use
 device_add_groups()
In-Reply-To: <2024032732-thigh-smite-f5dd@gregkh>
Message-ID: <ee89e9ec-e0d2-96d5-fba1-6259146e5dca@linux.intel.com>
References: <2024032732-thigh-smite-f5dd@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1326726891-1711541712=:3296"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1326726891-1711541712=:3296
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 27 Mar 2024, Greg Kroah-Hartman wrote:

> devm_device_add_groups() is being removed from the kernel, so move the
> hsmp driver to use device_add_groups() instead.  The logic is identical,
> when the device is removed the driver core will properly clean up and
> remove the groups, and the memory used by the attribute groups will be
> freed because it was created with dev_* calls, so this is functionally
> identical overall.
>=20
> Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> Cc: Carlos Bilbao <carlos.bilbao@amd.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v3: change the changelog text to reflect that this change is identical
>     to the current code.  Rebase against 6.9-rc1
> v2: rebased against platform/for-next
>=20
>  drivers/platform/x86/amd/hsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/h=
smp.c
> index 1927be901108..d84ea66eecc6 100644
> --- a/drivers/platform/x86/amd/hsmp.c
> +++ b/drivers/platform/x86/amd/hsmp.c
> @@ -693,7 +693,7 @@ static int hsmp_create_non_acpi_sysfs_if(struct devic=
e *dev)
>  =09=09hsmp_create_attr_list(attr_grp, dev, i);
>  =09}
> =20
> -=09return devm_device_add_groups(dev, hsmp_attr_grps);
> +=09return device_add_groups(dev, hsmp_attr_grps);
>  }
> =20
>  static int hsmp_create_acpi_sysfs_if(struct device *dev)

Thanks for the update.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1326726891-1711541712=:3296--

