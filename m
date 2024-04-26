Return-Path: <linux-kernel+bounces-160509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01E98B3E71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13F31C217E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD7415ECF6;
	Fri, 26 Apr 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJvu8cJg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8314D71D;
	Fri, 26 Apr 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714153147; cv=none; b=dn5bAEJBeNCC2XBwo0ZpxRJGPaCGyiPKoeJ/OpGeUIxuvND2ypdtTkLkfcnlhKjECPuPyO0igY+DjkGylB1ffCAYaSw+Ga5Wrbme3T98quxf8+VLRXps9xxRaVc1a72UM83P2M28qcvigMaBpinkhrjTXjcg5WZGqM1W1tKCXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714153147; c=relaxed/simple;
	bh=uSOsduM5wRVCMMD/AkIj/0wtY94jVo7lOxBH9kH4mRA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=b/0Ie00ReEUdfMQ9z/ORBvOR/gtlMXnR5gKH6ID0nXgc40yrdYpWiZA6iOe7Va3jpoTL1+2ur8X8lGtxiA7zNwNNgRIGHt6fbHyd8UJ0blAg2nNUdofRifKBW+z4Ar/0JJKEHF4zOFnnFSymucmVktiA4ACK4DdL/RWYxx3TmLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJvu8cJg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714153144; x=1745689144;
  h=message-id:date:mime-version:to:from:subject:cc:
   content-transfer-encoding;
  bh=uSOsduM5wRVCMMD/AkIj/0wtY94jVo7lOxBH9kH4mRA=;
  b=lJvu8cJg86TWL69PJ94HiztknfWVIt8gSD8Gps+oK1+cAT0UlHKzDhfX
   vZs1Zt4i0Z6eMwub0gtNV48Q/CBiGqRSJNIuFVift3BzTMJ5aXO65tIvp
   m0/mjMUBVen+4fmJ4Rf5G7TtSt6vxjzF8XohBYJ+dcR2Yqr5jpVlrt2ky
   2AUSwwNiyf4VEOnCupYpBY05r5ujjfIEDNUcpoIEoGHbPHCF2N7rntczo
   BbWfSwZJEQIACz0cHZLYmCQ9QtdaA9vvcwWZZMx0W61CsXZj5PsuCnahX
   e/6e06m2Hz3JPW/ZZQEAUB8IRJYk0rud5RZCXGPf41v8xgH/2qFSGPMTO
   w==;
X-CSE-ConnectionGUID: AiP1G3LNRyG81TeTaYlLxQ==
X-CSE-MsgGUID: WyEGHlx8S2mO9WMX0JZQTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="20509341"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="20509341"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 10:39:03 -0700
X-CSE-ConnectionGUID: 9pSmMFi/Q/GicW5WOhkFmQ==
X-CSE-MsgGUID: Kvje6/xSS9yFFYfiLE2gug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25369838"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.33.42]) ([10.212.33.42])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 10:39:02 -0700
Message-ID: <0ab5345e-3a73-45eb-af20-80b61f3de7e9@intel.com>
Date: Fri, 26 Apr 2024 10:39:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fix for 6.9-rc6
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from
  
  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.9-rc6

..to receive a fix for the CXL subsystem.

Fix addresses a potential mailbox payload size confusion in cxl_mem_get_poison().

This has build success notification from the kbuild-robot. It has been in the -next
for several days with no reported issues.

---

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.9-rc6

for you to fetch changes up to 4b759dd5765503bd466defac7d93aca14c23a15d:

  cxl/core: Fix potential payload size confusion in cxl_mem_get_poison() (2024-04-22 08:58:59 -0700)

----------------------------------------------------------------
cxl fixes for v6.9-rc6

- Fix potential payload size confusion in cxl_mem_get_poison()

----------------------------------------------------------------
Dan Williams (1):
      cxl/core: Fix potential payload size confusion in cxl_mem_get_poison()

 drivers/cxl/core/mbox.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

