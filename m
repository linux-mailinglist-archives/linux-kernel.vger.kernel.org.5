Return-Path: <linux-kernel+bounces-20413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B2827E7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06FA1F2470A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699CA185D;
	Tue,  9 Jan 2024 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chQqrlOs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F7EB8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704779219; x=1736315219;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aGNHQNzRdrw4QB8auzJbZaFuYOreQI6Eh0B7R0TJOlA=;
  b=chQqrlOskyBLaX5E39ohFk/rJUPP5zLtQRb1CjN1etfKfdX/8ok+LwKK
   7KkoV/6rnBhE9n+SR1ZNXl9pIPlUWuAVVjLk3uswCl5GkqKuKXxm6PX+K
   /UnSQHyZsbIn7rjo4trVkseGDPsLF0tBSBSP0lGeWxvT6Ct5/qP5LTI1X
   bxMvEzkooo2GHV73rErJ8PAyLk/NG5u5NW7iuD5tN+HlK4GPZ8gkyCXrp
   GK10Sq9CQt+K3IjBht40mJ1nQ868DSHag00yDsh67eFELkSa8FIMccUa7
   r/4LVaTCThogT1BIDnyo3Hz1k0BQ6QT3Wg7fyQ5Ty6KB0X8LZ23LjI89r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5457594"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="5457594"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 21:46:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="905034325"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="905034325"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 21:46:57 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [PATCH v1] virt: tdx-guest: Handle GetQuote request error code
Date: Tue,  9 Jan 2024 05:46:04 +0000
Message-Id: <20240109054604.2562620-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when a user requests for the Quote generation, the Quote
generation handler (tdx_report_new()) only checks whether the VMM
successfully processes the Quote generation request (status !=
GET_QUOTE_IN_FLIGHT) and returns the output to the user without
validating the status of the output data. Since VMM can return error
even after processing the Quote request, returning success just after
successful processing will create confusion to the user. Although for
the failed request, output buffer length will be zero and can also be
used by the user to identify the failure case, it will be more clear to
return error for all failed cases. So validate the Quote output status
and return error code for all failed cases.

Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Closes: https://lore.kernel.org/linux-coco/6bdf569c-684a-4459-af7c-4430691804eb@linux.intel.com/T/#u
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 1253bf76b570..61368318fa39 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -228,6 +228,12 @@ static int tdx_report_new(struct tsm_report *report, void *data)
 		goto done;
 	}
 
+	if (quote_buf->status != GET_QUOTE_SUCCESS) {
+		pr_err("GetQuote request failed, ret %llx\n", quote_buf->status);
+		ret = -EIO;
+		goto done;
+	}
+
 	buf = kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
-- 
2.25.1


