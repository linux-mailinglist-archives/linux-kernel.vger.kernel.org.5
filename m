Return-Path: <linux-kernel+bounces-10262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D4C81D1E0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BF11F24371
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09CA9441;
	Sat, 23 Dec 2023 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxCyXO03"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC81866;
	Sat, 23 Dec 2023 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703301954; x=1734837954;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=alzPQBYryrPFIZRzgl+PRORM4Cg1XASznG83KJNWqwg=;
  b=lxCyXO0355d6cuBDNBjg0W1gXlJQtPk6xvYuKayMTKH3jggiGEK4CgN5
   XdfjSLKLq8Na1OlHU3e6ckZTtsWObqUwYGif28UdOUb0DudJkmET36ghk
   5QBn8z7VqrWgJiQeA84nuNQYJWp75tcB9aOW+L8MDvWAbOhPEYwGvrgYF
   YKwTT1Q6at9r9/rT6a9R7IXoVxEv2qDXK30RfNrKP82/glIqJJJbsuTyA
   CQZZYW701kz6Ix2jm2qdUzLpHVkTgIA1W2ZsJgIWiI9OoXHA+pX/kj8bq
   QK25di0MUa6vczvvbd41gTf8GUBFFMHpvVBSmJ+OXxcdRYATXjvpbhOd+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="462619294"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="462619294"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="811534585"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="811534585"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:52 -0800
Received: from debox1-desk4.intel.com (unknown [10.209.86.110])
	by linux.intel.com (Postfix) with ESMTP id 8FFAF580DCE;
	Fri, 22 Dec 2023 19:25:52 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] platform/x86/intel/pmc/lnl: Add GBE LTR ignore during suspend
Date: Fri, 22 Dec 2023 19:25:47 -0800
Message-Id: <20231223032548.1680738-8-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231223032548.1680738-1-david.e.box@linux.intel.com>
References: <20231223032548.1680738-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the GBE LTR ignore suspend time fix for Lunar Lake.

Fixes: 119652b855e6 ("platform/x86/intel/pmc: Add Lunar Lake M support to intel_pmc_core driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/lnl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index fe97ad09a1a6..eb350d64efdf 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -509,6 +509,8 @@ void lnl_d3_fixup(void)
 int lnl_resume(struct pmc_dev *pmcdev)
 {
 	lnl_d3_fixup();
+	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
+
 	return pmc_core_resume_common(pmcdev);
 }
 
@@ -521,6 +523,7 @@ int lnl_core_init(struct pmc_dev *pmcdev)
 
 	lnl_d3_fixup();
 
+	pmcdev->suspend = cnl_suspend;
 	pmcdev->resume = lnl_resume;
 	pmcdev->regmap_list = lnl_pmc_info_list;
 	ret = pmc_core_ssram_init(pmcdev, func);
-- 
2.34.1


