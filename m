Return-Path: <linux-kernel+bounces-81482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD0C86767F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC5E1C29495
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87473128360;
	Mon, 26 Feb 2024 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2Tk/XC8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64380128812;
	Mon, 26 Feb 2024 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954063; cv=none; b=ECkai80vsHijtRCabHZKk5WmL2RV5ih6YrwTj/U2nY7zSGRF1sbBJotNOoIl+a+mQD5w6ufeYz4gpzEcI3obTFfvu9V4xjIOEU3S5Iyjp5gigrt9AKb1UKAlppSIb0oiEtHnsaA3iMzAyo3bQJqoKtJN7Wb7SEsGVjzlAMr0jXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954063; c=relaxed/simple;
	bh=Dxyoh09PfHjd9+QoVmmIPu/9OxF02YHNKUdvOQw8kXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WnJHfg0vOzhRUM5g7IVaIU7qMylb4AuZVIlnhQDUZ88G5dCuQ2dZQFXOXTDFKYueb+6LvwyhLRZ5kxRIp6E0qbHVMuYa6UOzGjZaLRIQ7XsgqGVHuOYWALbOAJ0XwsWal4OHvXBcOXTwqg6BIkjBZp7q9Samd4xO0N6Wl6QkZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2Tk/XC8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708954062; x=1740490062;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Dxyoh09PfHjd9+QoVmmIPu/9OxF02YHNKUdvOQw8kXo=;
  b=R2Tk/XC8h5HB/FuskfCIekD5yfmsxqfJuxmDUlbIwTtgVozfo66AXV1Q
   7ujkpSijwOfwZ3Cr/9i6lfiifb5UyVQH4OD9KNvbgUk1s9s/kZffz7/Ua
   szjHntSVMGLv46bt9VeHUsImd0yQkzywRyba0mA01Xe7RmZr78N0IauNz
   QREXmZ8WHXYTkuLhsuj3bVUYexPSH3fMGI4rNb+NiJDzElnxjx1mYrueT
   pDCDV/4cmRf7R8bq7WUOGOQdbinDFYdzkjsSrAuwcjlcKXFCMoxS2fZz+
   EOI/hkXAiNcxzy6OVaP3KcKI5mbxNWNXSZPYBStUVUd6qqM63Cl8hnM+X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="20781538"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="20781538"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:27:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11255391"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.12])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:27:32 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: shravankr@nvidia.com, Luiz Capitulino <luizcap@redhat.com>
Cc: davthompson@nvidia.com, ndalvi@redhat.com, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <cover.1708635408.git.luizcap@redhat.com>
References: <cover.1708635408.git.luizcap@redhat.com>
Subject: Re: [PATCH 0/2] platform/mellanox: mlxbf-pmc: Fix module loading
Message-Id: <170895404513.2243.14840310263795846559.b4-ty@linux.intel.com>
Date: Mon, 26 Feb 2024 15:27:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Thu, 22 Feb 2024 15:57:28 -0500, Luiz Capitulino wrote:

> The mlxbf-pmc driver fails to load when the firmware reports a new but not
> yet implemented performance block. I can reproduce this today with a
> Bluefield-3 card and UEFI version 4.6.0-18-g7d063bb-BId13035, since this
> reports the new clock_measure performance block.
> 
> This[1] patch from Shravan implements the clock_measure support and will
> solve the issue. But this series avoids the situation by ignoring and
> logging unsupported performance blocks.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/mellanox: mlxbf-pmc: mlxbf_pmc_event_list(): make size ptr optional
      commit: c5b649996ac63d43f1d4185de177c90d664b2230
[2/2] platform/mellanox: mlxbf-pmc: Ignore unsupported performance blocks
      commit: 4e39d7be4123f65adf78b0a466cbaf1169d7cedb

--
 i.


