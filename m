Return-Path: <linux-kernel+bounces-129326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F51E8968ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B1BB220CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363AA129E75;
	Wed,  3 Apr 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ll5hSGia"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAFF6F524;
	Wed,  3 Apr 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132602; cv=none; b=t3vZ8E4RiOfH5A/OYveTFObZF8qFMSgWMO8+pPSZh6bX1Pv5GHYsnhZzB9LGt3ZGpAS+qI0Sma3yTNfmxW0cQ0pjgXX176TDZN1hGHCfRUwTwA4qKStCkFak9710EU2BQnNC5bf/XuLQF7aISlOJMD/a+c6JHn/0S81qGpt6Ce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132602; c=relaxed/simple;
	bh=3UEaKcNQCsquDKRqA9/0D7BIcxSP6v8eFK/FMp1INVc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nN+Mpk4ygjAHlBfDhA8IOMq76CNH+oHu0Oa1JomXrMIMRmd5bWgGiqeJTPCmm15U/U0jx1GvEVS0yMWhk9nCOKnzsBsXltUlIFrpthou/8kKIY7C0IYEyZXCMayPvGIs095v7FCdYBBVVqXmW5SYYUWYYkm2Dp6PT0vEbYFmowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ll5hSGia; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712132601; x=1743668601;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3UEaKcNQCsquDKRqA9/0D7BIcxSP6v8eFK/FMp1INVc=;
  b=Ll5hSGiaCKtHgmhOWru4tgNX0tRCcQqUmaosqH6MMhopDPlCVAqW7SOo
   BV/pHon2GpQILaY9JEK/2OdPVl8z39aanLGOAPz2pQhlN87pSjvmp1wep
   jNAAYnvnEggLHBA71aoIvRmUZTUvtryXvbt63Xo6JNu0iBwJtH48l9YNt
   1Ti9F3tlpDXG3X4cBZK4sdubVQmPXdj+K13uPuSlLq1kvd9eY5sytAtpT
   MAffuwpXS4FL6aF+bVagWsJRMgFMMpWh3pA2FYI5ApHnz4Sj3Sa68joVQ
   MUKtwWjK53m1gvLc9oOazVMIT7VpbFg37ZN/O6c6hIYNVy96UWXMzEeov
   Q==;
X-CSE-ConnectionGUID: iqaKRxWYSvi6gE/3dhz1KQ==
X-CSE-MsgGUID: AJXqprGVQcKNR+f1cLpHBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18791915"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18791915"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 01:23:21 -0700
X-CSE-ConnectionGUID: HYAhQ03pSvOjkl+4zUDbvA==
X-CSE-MsgGUID: GYBqKbDeTWyCFtZFS+SXSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="41492900"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.24])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 01:23:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 3 Apr 2024 11:23:14 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/9] platform/x86: asus-wmi: store a min default for
 ppt options
In-Reply-To: <20240403002917.2870959-6-luke@ljones.dev>
Message-ID: <e48c5226-9a25-ff24-45d8-5cc73d7d914e@linux.intel.com>
References: <20240403002917.2870959-1-luke@ljones.dev> <20240403002917.2870959-6-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1375749286-1712132594=:1449"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1375749286-1712132594=:1449
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 3 Apr 2024, Luke D. Jones wrote:

> Laptops with any of the ppt or nv tunables default to the minimum setting
> on boot so we can safely assume a stored value is correct.
>=20
> This patch adds storing of those values in the local struct, and enables
> reading of those values back. To prevent creating a series of byte holes
> in the struct the "<name>_available" bool is removed and
> `asus_sysfs_is_visible()` uses the `ASUS_WMI_DEVID_<name>` directly.
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

(I know it is already among the tags but I had not given it until now.)

--=20
 i.

--8323328-1375749286-1712132594=:1449--

