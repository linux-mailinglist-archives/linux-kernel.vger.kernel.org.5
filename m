Return-Path: <linux-kernel+bounces-63447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247AA852FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D771F24EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F413F374F8;
	Tue, 13 Feb 2024 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmlKSDDD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535836B17;
	Tue, 13 Feb 2024 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824336; cv=none; b=frjGok3Zf0Jqmjquxq/sbLbDlOQESgkpj2oF43oARdl36mwU+Qe4VmhlFcEuGPaSxdUOK2I8juOSYG/qLHoRxNJKmvH43WKT8C7rLqg26XpbLABRrzdtSRJ38Pxov2eOC5eUX35gLxU5G37Lm3Qq0EP3Y/Ebi+5KeNaGgU4uR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824336; c=relaxed/simple;
	bh=5T1R2LaZ7/5RcBfjH8QnKHLDGAacAb4MmSubbGT5Mv0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tTMoh7NlFPgwl32MBuEWT6x+fe1bQ7IzSUyWnaOZOG6G7HaC8ZzvrsKWBE+vRxdIvYNx7A06DWXZS3esYsE+RgM5kYbpkLK/ZGX5e1PQIP8av504+FIJj/+0vUqP7IQKa8NKIdFTU/jrH9+esol7PZkD/7aD4eN0KIr60lZVeaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmlKSDDD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707824334; x=1739360334;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5T1R2LaZ7/5RcBfjH8QnKHLDGAacAb4MmSubbGT5Mv0=;
  b=UmlKSDDDbKInSd3V6t9USBBnMkmAsOIYm4q0jHZgLiowaa9NrRVxodI9
   lPTd0SAvwdTwJuNkgmJzvF6JjhcYJ9BTBO0jnOM4GsVXuwZ/p/VxJ1IE0
   QxoZDEv5uejLVB/nU+0Ol8QbAVkbihoNhlu9W+X9bWhohf1eUeK4SyEGO
   xlLFc2voCGVk3XH18iB/WuqHSd7vPX2VNkAzEe/IjBLXa3NcF3Zp6aGGp
   LgEJyNmm47b06MmuOPpGMsE8GI+2gOgl2kTvYOTqDq7wHkU+sLyNFS42f
   2WueYbXfZCT00GvXpZ2DBkRqGD6zXyrqitVEVAuTxdYD16ad4zfTCubHR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5658718"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="5658718"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 03:38:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="3218807"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.103])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 03:38:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 13 Feb 2024 13:38:47 +0200 (EET)
To: Shravan Kumar Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
In-Reply-To: <ce1140840b09df3fe2b85e3f87089f2e0d0877d0.1707808180.git.shravankr@nvidia.com>
Message-ID: <c256234b-b928-23b7-d57b-464d5bfb3703@linux.intel.com>
References: <cover.1707808180.git.shravankr@nvidia.com> <ce1140840b09df3fe2b85e3f87089f2e0d0877d0.1707808180.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

I've applied to first two type cleanup patches to review-ilpo.

I considered taking patch 3 and 4 already too but I'd like to see the 
sysfs documentation for the added sysfs files first.

On Tue, 13 Feb 2024, Shravan Kumar Ramani wrote:

> Add support for programming any counter to monitor the cycle count.
> Since counting of cycles using 32-bit ocunters would result in frequent

ocunters -> counters

> wraparounds, add the ability to combine 2 adjacent 32-bit counters to
> form 1 64-bit counter.
> Both these features are supported by BlueField-3 PMC hardware, hence

Please try to avoid paragraphs like this. Either make it a truly flowing 
paragraph or insert a newline in between the paragraphs.

> the required bit-fields are exposed by the driver via sysfs to allow
> the user to configure as needed.
> 
> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>

-- 
 i.


