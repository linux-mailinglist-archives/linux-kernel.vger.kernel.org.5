Return-Path: <linux-kernel+bounces-81481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B050786767D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F121C29204
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F44128386;
	Mon, 26 Feb 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZEXbvzG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA00127B61;
	Mon, 26 Feb 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954053; cv=none; b=ozgSdpJb7bao09CxudfDoL1IqQYGe0Hd3NYPXo2Qd+MYsflECpLuh+0UEs9ztx2dpcwRq3yioDpE2l4RW9EN9TuSBsdfQz1X7hUgMBXRHgtWc7O12rPFfVK+AXMXqeVt4Ln6mnEqsBJm3aBqvVO0X767jbGHqBY1wMemN/ilXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954053; c=relaxed/simple;
	bh=/pzbee++7gipWyKBJo8nIPzMwu9sYBmCTcdughsOT9Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eC/1+VnYCVtuCc1O+ajxSf0YLLRHF6mS/DDl9vWjsrs3SzkX0OkuqvpXYw2KB4tMyZYDUD65pCTe7jsBXxbGRpU9bWokXHNFo3lxGjwBokv4vcSPcAzdBCh6u0bx4lHmlZzdX+0qpExZ+1KHf6Osp8siZ9JtHqL9H+8mly7kWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZEXbvzG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708954052; x=1740490052;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=/pzbee++7gipWyKBJo8nIPzMwu9sYBmCTcdughsOT9Y=;
  b=IZEXbvzGJFjIxVqgsIqpvWkRZ4lSESnCm3Ki3ChpVaPkCyqKhsifgoJZ
   WXxfi2FSTVti/ps4r7fPV4lmBiD47vIYLvA20+BWOzHnVnvUIH14fZVwi
   L47Gp2fLTTpNVRpFcpHjLxYkFYkUby3gOFYLs3XmZtGpzRADtTzrhwz7z
   L0tHAncphrx7u/QSA+uHYElAlXBakuxb4AemXr0UYW8mf8ShJi829yi9M
   CzzI54n4pDvJeIt0IzSqMtHNX3AvXx5VFiiHJmXg/4npNI8Kt01OTgUH+
   bPRXwxYfSxsrw8mo/ABlmvj28AmWLx8CPJHJCi6E8gt5sYJhNJTt4mjbc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="20781525"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="20781525"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:27:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11255355"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.12])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:27:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, Armin Wolf <W_Armin@gmx.de>
Cc: Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240223162905.12416-1-W_Armin@gmx.de>
References: <20240223162905.12416-1-W_Armin@gmx.de>
Subject: Re: [PATCH] platform/x86: dell-privacy: Remove usage of
 wmi_has_guid()
Message-Id: <170895403712.2243.7938994758806690740.b4-ty@linux.intel.com>
Date: Mon, 26 Feb 2024 15:27:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Fri, 23 Feb 2024 17:29:05 +0100, Armin Wolf wrote:

> The WMI driver core already takes care that the WMI driver is
> only bound to WMI devices with a matching GUID.
> 
> Remove the unnecessary call to wmi_has_guid(), which will always
> be true when the driver probes.
> 
> Tested on a Dell Inspiron 3505.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: dell-privacy: Remove usage of wmi_has_guid()
      commit: 39849d8fa03c501305dd6fb814fbfbc768fcf96f

--
 i.


