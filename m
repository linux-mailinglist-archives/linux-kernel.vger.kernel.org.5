Return-Path: <linux-kernel+bounces-117010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE43F88A619
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F71C3791D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1921448FF;
	Mon, 25 Mar 2024 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9Zlo0CI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0613F44B;
	Mon, 25 Mar 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370094; cv=none; b=T0TJgK9rLMkeGeKlEQ5i9S0kJLTkw5zzG6H54z302zOjHE1UB2fHN+bk9KjBIkDTyugMrXC0GradhjPdeCNHPO8vHKno8quP0/PJI6b3L6Cf6rhYFakR52kcmr138DZkTYjZyDpfFPg9fbiWx9jGdCqDFGkOJ7fbmcMssWEk0a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370094; c=relaxed/simple;
	bh=kOSHnnIN9sq3z7o0gS6aJTFnjb5+mMzfpmkgeSG5CvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOg12QDkOtd7bZql/JeGYZp2TN71ihums5U6x2Mb8zZWMWu8Ng+97DRi3GxYfntlC2JfPFrhMclR9f5hsq7EX1/duFjVTlVf5LP27+Jj1Jt/JoDYjOsehwWX2KI3NafpAQHqmjHUy0kZ08MRz/V/3zKQJ/qf94t8aE+o3E+zzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9Zlo0CI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370093; x=1742906093;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kOSHnnIN9sq3z7o0gS6aJTFnjb5+mMzfpmkgeSG5CvI=;
  b=K9Zlo0CI9P47fKna6r49i9r2nG7SC2Rbq8NAp1hyIbAOp5BA0++0RJOM
   T4aPg9KnsdtjI5EWeZE6nk0b+fZL8b+LtH9rnu1uzw2uh+GE/sUxW4/zX
   optgMB6h34gXPyLJcRfO9/c/QYvs+Jh7wXapAD1d4Bh5E/cseJsD4KVkO
   X1zqAE39HCtMxhgBBmnQZT6E3H0c2BdKGdqG51+FQrUlSfO+xm2SsIGUS
   ftB2fOslGit1dnOfKs4X3XExs/ZLrNtPoO1SUK3aG5halATHOaZTKVF2f
   GGdIg3Z19i+Pnm2J1rZlFNTUyDVTSPAs8GNf5DzudSvLe5iBH7hmBr0K9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6549688"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6549688"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070329"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070329"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:34:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9B8B2228; Mon, 25 Mar 2024 14:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 0/7] ACPI: scan: A few ad-hoc cleanups
Date: Mon, 25 Mar 2024 14:32:56 +0200
Message-ID: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While looking for something else in the scan.c I noticed the room
of improvement. Hence this series. Also bus.c patches, which some
how were related to my research, but I think are independent from
the scan.c improvements.

Andy Shevchenko (7):
  ACPI: bus: Make container_of() no-op where it makes sense
  ACPI: bus: Don't use "proxy" headers
  ACPI: scan: Replace infinite for-loop with finite while-loop
  ACPI: scan: Use list_first_entry_or_null() in acpi_device_hid()
  ACPI: scan: Move misleading comment to acpi_dma_configure_id()
  ACPI: scan: Use standard error checking pattern
  ACPI: scan: Introduce typedef:s for struct acpi_hotplug_context
    members

 drivers/acpi/dock.c     | 48 +++++++++++++++--------------------------
 drivers/acpi/scan.c     | 42 +++++++++++++++++-------------------
 include/acpi/acpi_bus.h | 28 +++++++++++++++---------
 3 files changed, 55 insertions(+), 63 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


