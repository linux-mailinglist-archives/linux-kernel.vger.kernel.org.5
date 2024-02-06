Return-Path: <linux-kernel+bounces-54668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E5584B23E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20DF1F25349
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD3B12E1C0;
	Tue,  6 Feb 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="le8jkU1v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A1312DDBA;
	Tue,  6 Feb 2024 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214488; cv=none; b=IhrQvjyIxGXI8rQ8doD23iSx2LaYq/UnoIh3O23lqighD0LOhrFqUDEk7BaL1p9GrFkCar+wIS9vSXbQQr2HnRXLJSbwE3ty2qDeiyBaLoFucEXHoB00w+bhjf4T1vQiGbWKLjGPxaLESDMDvn8k/IfQyGyxNbb4ZUrnbCLKnvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214488; c=relaxed/simple;
	bh=Q0ggFx2GySVTGdW1LNwQa4NGiDBN1x+QcHbdLm5jsO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WwVzP61/BZDplqyeykesFjMCkV9OrZaZgvb6K1bkRUKO1IBClA1JsJnjwtQqxlnRwt0DjyoC5uUdjEI+9myeODgVFZ5atkzSGNmcEugc+05Jf+eDQoIamq4VnGZxcjaXjwH+ssiX+YspTUSdMgdkOIcPKbrX4DX5QtsNhjDLLSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=le8jkU1v; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707214487; x=1738750487;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Q0ggFx2GySVTGdW1LNwQa4NGiDBN1x+QcHbdLm5jsO4=;
  b=le8jkU1vdrn5zmBmcEEHZiIBUWt+0I2Ui04R6Dr2zZzmvZ2ueZ2rC1ZW
   jWTKr1V8OPpOTQaoZRJAT7VJA9nHcYBj0EvOvwP3BVUTPeXV6mIzcCXNg
   hNm4zoeagekk6eEWnxyY39s1QWd8xhGaL8r7DfjxHLnlqIpWGg/Rf6kTT
   ZrXIG/d7qHFXD35Y/lR4rnjxP474adYckrMsV6TTbWOVG98tJfx5U+ID5
   W0A67OCdeMIK5371kBwv/jJc4a0hdjGCAwjR90jfTt0GXrdp2d+vB66g2
   BYFGA8eR3df4LX45TRatJws7JPVMsYl9QX/DHn2PgvFDJjrV+N4Xrmru/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="597735"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="597735"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 02:14:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933418957"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="933418957"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 02:14:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240130221942.2770-1-W_Armin@gmx.de>
References: <20240130221942.2770-1-W_Armin@gmx.de>
Subject: Re: [PATCH v2] platform/x86: wmi: Stop using ACPI device class
Message-Id: <170721447803.2255.717062869261539461.b4-ty@linux.intel.com>
Date: Tue, 06 Feb 2024 12:14:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Tue, 30 Jan 2024 23:19:42 +0100, Armin Wolf wrote:

> When an ACPI netlink event is received by acpid, the ACPI device
> class is passed as its first argument. But since the class string
> is not initialized during probe, an empty string is being passed:
> 
> 	netlink:  PNP0C14:01 000000d0 00000000
> 
> Fix this by passing a static string instead.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: wmi: Stop using ACPI device class
      commit: 6468e64ee380514b331ccb743fa491b23cd8b4dd

--
 i.


