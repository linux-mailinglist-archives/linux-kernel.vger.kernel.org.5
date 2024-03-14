Return-Path: <linux-kernel+bounces-103779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA5287C461
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322452832DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5365D763EE;
	Thu, 14 Mar 2024 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUBGYY02"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64EA74BF4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449083; cv=none; b=mxF8XMc4uvyJxEY2UxYJhGPgI7o1mw9Wlz/g2/Jt0cX01IvgRdVliblaJvoN6QS2+rpT14KItlsyoIntM/tD3Ras9JkzjbAP5zg6CVcP52dPINtpCYwEwtpwrfEibW8+Lb5Uo3lxHNZD188CvBosLrpiRQKkxO98rCOXmfVu24w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449083; c=relaxed/simple;
	bh=i2rDrm0Zgz1naDuEpMCfUyWS1aCirICQkO3HjTprWPM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ALjB1aXmFOXnaVB0yFaMB6EWzXiOr6cunK+FfZRHVsNwnyPnpEpcudHk49WA2JseyvB7M4vkoMfZRQojdK5U/TIjCS4ER5MgPVIMe7WjC2Za5N9pQNkcu7zLdRYF8GfwuJpf23tk7+0xioblBxVi5Q6Cr0981kFCSfi4vc3CaYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUBGYY02; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710449082; x=1741985082;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=i2rDrm0Zgz1naDuEpMCfUyWS1aCirICQkO3HjTprWPM=;
  b=TUBGYY02XXD5M9R/Lk1hOROP6GQBoD+Ed77pr8D+ICXOQHGuysybE3jT
   W9xVhJ9dU9Cq66JxcCz1bhVyiwevaOlB778MTvHcYdtK4/ZxfiPGzAzuH
   12oIzLgoNMDGkuIJWJ4jVLKoihZdyOxjxNpY1LiMvY+C8oc54BEihTENP
   Hys/8cDZR4iNIozOq6sflPl8BHTD4SeKK4b7G4x1mptoIAMLhUQc6LNf0
   ZPhWso8KFOYBwNP8QaaMIn58QtC8AJY6gKXeC4kQHVTAiYF6JF2qWEA0X
   G2GB3CGHOR6TeCjMXKPdZZoO2W92WU8jKOthQkfvVP8ob4/msktmZRf8J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5422975"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="5422975"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 13:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="16895578"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.168.70]) ([10.213.168.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 13:44:40 -0700
Message-ID: <6ea8ea30-9a6b-4ed1-bccc-96b0171a3dd2@intel.com>
Date: Thu, 14 Mar 2024 13:44:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] NVDIMM//DAX changes for 6.9
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.9

.. to get updates to the nvdimm tree. They are a number of updates to interfaces used by nvdimm/dax and a documentation fix.

Doc fixes:
	ACPI_NFIT Kconfig documetation fix

Updates:
	Make nvdimm_bus_type and dax_bus_type const
	Remove SLAB_MEM_SPREAD flag usage in DAX

They have all been in the -next for more than a week with no reported issues.

---

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.9

for you to fetch changes up to d9212b35da52109361247b66010802d43c6b1f0d:

  dax: remove SLAB_MEM_SPREAD flag usage (2024-03-04 09:10:37 -0700)

----------------------------------------------------------------
libnvdimm updates for v6.9

- ACPI_NFIT Kconfig documetation fix
- Make nvdimm_bus_type const
- Make dax_bus_type const
- remove SLAB_MEM_SPREAD flag usage in DAX

----------------------------------------------------------------
Chengming Zhou (1):
      dax: remove SLAB_MEM_SPREAD flag usage

Peter Robinson (1):
      libnvdimm: Fix ACPI_NFIT in BLK_DEV_PMEM help

Ricardo B. Marliere (2):
      nvdimm: make nvdimm_bus_type const
      device-dax: make dax_bus_type const

 drivers/dax/bus.c      | 2 +-
 drivers/dax/super.c    | 2 +-
 drivers/nvdimm/Kconfig | 2 +-
 drivers/nvdimm/bus.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

