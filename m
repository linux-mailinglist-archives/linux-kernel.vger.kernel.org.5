Return-Path: <linux-kernel+bounces-128242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B878F895838
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A2B1C2279B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF5F133406;
	Tue,  2 Apr 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItUQrjQM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66B8131742;
	Tue,  2 Apr 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071802; cv=none; b=UgkXbMhH4Q94jQSQMmmtkICYzuRlW98KV1fPJzQ2RxGjPCJPekePddGpvDJJH+rw61xRr4WKBrbO8hLNHVNCmWAxAa/jbxBXh3aKQHE+bYIdmyDxy+JI+wxfINrLOEyGRhNMbTG+CIdaVLxAQ0/WFwFc/lxc2z7F8YS0syfJjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071802; c=relaxed/simple;
	bh=qNxMxkYPduUraOWMqdvWRvCXIU50LwSPxfIh8NcCJCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaNe1yfIKsjgWSflSjsejamw+374S5x7IlR+rqf7llWsF75gAsb9mVFqrWl4y5FCjOwNo2fPMMglmmtfyv6qbUxbr/Uok6n0aEYJwTKxfLjOYJdcSaNyzpdVVMFtMCpWWYYrItw3Elgk/EsQZd49T5x8a+BWaUBeMRMXwDDI/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItUQrjQM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712071801; x=1743607801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qNxMxkYPduUraOWMqdvWRvCXIU50LwSPxfIh8NcCJCk=;
  b=ItUQrjQMBF2JrfCL4bmSUbnh1gyaT8Wxe6QKPVCCqEsJIfK6XndxSXa+
   MRiSWqj89agBESMFa0NCcIFn2XIakGE+LcDSgHYqQMcX4GGiT4DioHvur
   WI5EItxEkWvutorHTIMBVf65+z7OrLlObok97RwNgl7axDnxnO+GqkvCl
   1Gg1dZD/G28ivDNGURJJXjiM831Km4XpsQ9rrBsGq7g1a7nNeLy23HbqD
   I4+frqzMKWOTehAjm2iMCOyVjodDRngXXz8TIz3cpRYkJNDsp2d4G1kJe
   VrD09Txj02rNxqncIAxLxnjUUPV6bdEGZfv2epX7iUmXLrQpsos/G6eEs
   A==;
X-CSE-ConnectionGUID: td27xlsYQr69Cl+/kjM7sA==
X-CSE-MsgGUID: iy7HqaNQRSmtuCROrSpNgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17867551"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17867551"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083612"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083612"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:29:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 299B3133; Tue,  2 Apr 2024 18:29:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] ACPI: LPSS: Remove nested ifdeffery for CONFIG_PM
Date: Tue,  2 Apr 2024 18:28:52 +0300
Message-ID: <20240402152952.3578659-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402152952.3578659-1-andriy.shevchenko@linux.intel.com>
References: <20240402152952.3578659-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to have the ifdef CONFIG_PM to be nested.
The second and so on will obviously become a no-op.

Remove redundant nested ifdeffery.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 04e273167e92..5b56f198d005 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -886,10 +886,8 @@ static int acpi_lpss_activate(struct device *dev)
 	if (pdata->dev_desc->flags & (LPSS_SAVE_CTX | LPSS_SAVE_CTX_ONCE))
 		lpss_deassert_reset(pdata);
 
-#ifdef CONFIG_PM
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX_ONCE)
 		acpi_lpss_save_ctx(dev, pdata);
-#endif
 
 	return 0;
 }
-- 
2.43.0.rc1.1.gbec44491f096


