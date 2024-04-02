Return-Path: <linux-kernel+bounces-127765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049889509C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08FF1F241A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E94A5E093;
	Tue,  2 Apr 2024 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWTIfj+Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151EB58AB2;
	Tue,  2 Apr 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054712; cv=none; b=NvyN4ogtBze4Z0gI6wmUCQdOM40A1AdzbkwpPDD/pLpKiYRxb5TZIx/wl+/VnhT+pjcqVy8sWtlz42lE8M6fx5acOaKsvVz9TfaUDcvJvqAk3jphpHDuRHgalYxRrE5VH21iGnsLyU0/RIApxcehUuzCYYm3ybpqCC6q+9F5BVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054712; c=relaxed/simple;
	bh=nmEP0AE09XNX95HP/Uf/VCja/Fdc09ns1eyOIE7J7qQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BxkKFz/67Ylh2Jk6IW0OY7/Z2JzxTLiXtTcEULwN/d0WNHfpI/riTOdvAmfp7t8U2p/b8mRLP0PGFHDQ/OQxlM/iFQGTay02bt8Wvqhydu4F+K9quuTZL3agvSY5UCsKs1oBkeqapnZARvbwmB4J3Gsq4dBmoSwcLm2C9pmu3LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWTIfj+Y; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712054711; x=1743590711;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nmEP0AE09XNX95HP/Uf/VCja/Fdc09ns1eyOIE7J7qQ=;
  b=ZWTIfj+YH5vQcwG5kwVmYX3granEKDYOlE4/2Ybt0dhFPlk112scLo4C
   e9NWoT72fq+xhJEhgePS8C6lB6yHU3TehQR8EAPZ+yTGSD6Ul+1C4ASxv
   3sKQN+wkaCVvWYDsLdLwW3LnHr94KsnYNtG+MJiaI/E53xcOl9RHa3ogU
   M8ARPbsjCbk+Cgxc4kJts8UoX7XtGqZHGshgVsw71HR3XLzZxKceopZN3
   pK0jVVF76r4VDLCWSFpIOBunoad2xaKl3Uz/HEInvW+UeHMSETNy5vTHD
   zl4tJRhqEsIbjDiWrgZZX4Y7keXPMF0HfnQ+lTgRRJ8iqt/DKhx6ud+3f
   A==;
X-CSE-ConnectionGUID: UjcfWKe1RjmuhGsQUqOCPg==
X-CSE-MsgGUID: 1GLqn3GdTKuWsZlsI0Dfuw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29696452"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="29696452"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:45:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18625610"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:45:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 13:45:04 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] platform/x86: asus-wmi: add support variant of
 TUF RGB
In-Reply-To: <20240402022607.34625-4-luke@ljones.dev>
Message-ID: <481f5738-0667-70c2-5dfd-abad55e0d849@linux.intel.com>
References: <20240402022607.34625-1-luke@ljones.dev> <20240402022607.34625-4-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2057758290-1712054704=:1019"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2057758290-1712054704=:1019
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Apr 2024, Luke D. Jones wrote:

> Adds support for a second TUF RGB wmi call that some versions of the TUF
> laptop come with. Also adjusts existing support to select whichever is
> available.
>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-2057758290-1712054704=:1019--

