Return-Path: <linux-kernel+bounces-135618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B9489C896
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640051C2403B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7625E1420B6;
	Mon,  8 Apr 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DP0GuPyg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768021419AD;
	Mon,  8 Apr 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590939; cv=none; b=Gsj2674PgAn8FJbTD0p8M154fwl62ycUkr+v5546utz+6B0a1558tIQfXxeF/DNrlvidNspzWc33Fd8xbJ4JxkFzFEnj75gr953jq1K2aEeJWLSNc1icJ4IRNeodExNnWUSp9HaV7qD0rLTjTTrL5KcdgIAv3Cq2Nrve3p6mlt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590939; c=relaxed/simple;
	bh=3AJSebzjsSWUSUNDEEWi2scDVJAYrLS9xuHrpPaGAzE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aIfj86A8PtrlWjizFUn8+3VxqJgJaGUjW+EVGu92MvUpY+8S2wTrvjRq7nt/vK4geJelAS9GL0ciQkG+hO0CdgUs68KRCW8AkFpeptT6HOJf8zTTSla1cBoYMows0SZOb8GN4T/fIXOUcq59XBwRJ8F9HeKz2pg1ZtBCTr4DX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DP0GuPyg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712590939; x=1744126939;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=3AJSebzjsSWUSUNDEEWi2scDVJAYrLS9xuHrpPaGAzE=;
  b=DP0GuPygt9c+U5W3AMNsgi0uLQZM5c5e0VjmO1fm7fcV2m3IsumDg5Ck
   FXp0JQVyHuNWdX8YMHjpbzOgp12wL2NggVIiXGK0tGU2ioH8GQjzcZDzQ
   O0RWqRGMl2LBVRi7V6mLNjFnWDW97a7b0H6bjb7luoF9n1V84GjH4xmgM
   bZIt+hy0JSK1NjCW1maEK3nddmKCyYiW1bNXLzk1ufbXgZPI2PBSPSmwT
   aM5xS/Q79LRgxSoUwdj3S7GoGaEzIJpIe7RVRNM9H08PLKdR2BksFK2JB
   b9s+Mxf/hOh7sYfgEs56yWBClcIcdKGPzDvSvfuVXVdzJaJLwits3324J
   g==;
X-CSE-ConnectionGUID: bD4h7Z4cRF2GCn5qfc7J6w==
X-CSE-MsgGUID: dg0E6ZIWT+eE6aYcW8JSXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19018785"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19018785"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:42:19 -0700
X-CSE-ConnectionGUID: QUNMDhjbSXqGOKj68kps+w==
X-CSE-MsgGUID: b/SuNznBRZGxWFe5OJYF2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="24622290"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:42:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: alexhung@gmail.com, hdegoede@redhat.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc: srinivas.pandruvada@linux.intel.com
In-Reply-To: <20240405122630.32154-1-sumeet.r.pawnikar@intel.com>
References: <20240405122630.32154-1-sumeet.r.pawnikar@intel.com>
Subject: Re: [PATCH] platform/x86/intel/hid: Add Lunar Lake and Arrow Lake
 support
Message-Id: <171259093040.17776.4173321595571990356.b4-ty@linux.intel.com>
Date: Mon, 08 Apr 2024 18:42:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 05 Apr 2024 17:56:30 +0530, Sumeet Pawnikar wrote:

> Add INTC107B for Lunar Lake and INTC10CB for Arrow Lake ACPI devices IDs.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/hid: Add Lunar Lake and Arrow Lake support
      commit: 79ce88064bb04ec62c4e9e4da4614d36906f8a04

--
 i.


