Return-Path: <linux-kernel+bounces-58166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E8684E224
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B73C1C275EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74002768F3;
	Thu,  8 Feb 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F846Mvyb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B7763F4;
	Thu,  8 Feb 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399698; cv=none; b=Lrm0a8w9yomz/MOrMHgc738OrIJ3s1dmqYMCyOEwxfpXNrggrjlDAKCdnoCZPWfINwMABmfvdhn+NSmkkrVbT9uTBycGewWkLX5Ui7AvkMiJ8eB3sYqMr9ODFJxtNDPeNZrxftDvPCvCgsBTODyPebXY3+JUHQ2HKgIsZl5ihA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399698; c=relaxed/simple;
	bh=qrSI/kREa3yZP1NKtjRF9qEXDlbnGJ1y+I/iMwvn1BU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZAFhDvL1CfLHu/yNDJdbqooMq6lIMLeUfq3v8L7iKze/uuKjmvEoJh5yLKsWoMoOWKNCbp0InbdCJhI81dTRlJcxykDG2MgpkBI46DtUvve6gOo6XvVqmcC/Ugz2qogUZFfwq6xnDjms3bV5m2odz0r2/13CzR2SRXgjGi84RRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F846Mvyb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707399697; x=1738935697;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qrSI/kREa3yZP1NKtjRF9qEXDlbnGJ1y+I/iMwvn1BU=;
  b=F846MvybVb9hSTfCI0rAmcToaMoaJSaEt7bAfP4ycA8bPO1sl+lE4aCA
   a0/k5SihFzHxwLXUxdGRn+AFjRLjPlxmCztZtgm9cp/TRujVbC3NxN3g/
   AcY4RNj7xMczWOuo9av7hp3odgfi5QAjyKHwD7O0qjpyKvP4MfCJWageo
   kwmIsW+lGLArCGgEj3d3Dq/dRbLbNy0pun9nzra4XE0iTdJvgEf7iTYQD
   QihgrIp/Vu1mO33cI9l7Mc1X06kIWeNA9Gaq1s6VGWcti3nwH3be+p16G
   h55KhE3ZD+OBoONQbHVgPgD9PN8oJWDA2MuMkw3dEzJCsPZh21aSwoT4L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="4198770"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="4198770"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:41:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1641312"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:41:34 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Feb 2024 15:41:30 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Netdev <netdev@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 3/8] platform/x86/intel/sdsi: Add header file
In-Reply-To: <20240201010747.471141-4-david.e.box@linux.intel.com>
Message-ID: <271a61ec-1784-78c8-3c10-b58aef804abd@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com> <20240201010747.471141-4-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1983480225-1707399690=:1104"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1983480225-1707399690=:1104
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 31 Jan 2024, David E. Box wrote:

> In preparation for new source files, move common structures to a new
> header flie.
>=20
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  MAINTAINERS                       |  1 +
>  drivers/platform/x86/intel/sdsi.c | 23 +----------------------
>  drivers/platform/x86/intel/sdsi.h | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 22 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/sdsi.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..09ef8497e48a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11042,6 +11042,7 @@ INTEL SDSI DRIVER
>  M:=09David E. Box <david.e.box@linux.intel.com>
>  S:=09Supported
>  F:=09drivers/platform/x86/intel/sdsi.c
> +F:=09drivers/platform/x86/intel/sdsi.h

Use this instead:

drivers/platform/x86/intel/sdsi*

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1983480225-1707399690=:1104--

