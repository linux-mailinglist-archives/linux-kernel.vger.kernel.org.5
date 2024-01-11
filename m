Return-Path: <linux-kernel+bounces-23033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB23E82A685
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF971C21C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7234ED6;
	Thu, 11 Jan 2024 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iI008k/x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C653EBC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704944043; x=1736480043;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HL60IJCbg51uCA/Ke8LM4u0ojnLTkmcbUqIywmQAX3Q=;
  b=iI008k/xNny23jcOq5NqlOJ0Bsvgv4Q0lz/+nrVM1DtMBntbUrXDxUPV
   eMFTl8Xdq3lE4w8ANtPjYTEyWL56ZET1tLVqLeaRCz9fcPzMyhohAgECr
   dvL7Ko9WLnitaJ5AhwOLQiOp1lvmYrDzsYaDlaiZnF6/zCp9cxWqaaIVA
   hdQSkr4jaWCO8FKbk7DaIvUSyzltl3i/wJSOohW6nF33lvdfDp7Djf8SW
   3/3Ba0MOvrGB0PL+PaQ2nTwz+5GyZJ+9ilrpEGnI64QHdE07cbO/23MW7
   sTg5FFBl31dctrsa3VAYEnBrteJhDjScSV6EuXvD0Pj7JmHVcsxUTW/eb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="20209902"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="20209902"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 19:34:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905794898"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="905794898"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 19:34:02 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [PATCH v2] virt: tdx-guest: Handle GetQuote request error code
Date: Thu, 11 Jan 2024 03:32:45 +0000
Message-Id: <20240111033245.2632484-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the TDX guest attestation process, TSM ConfigFS ABI is used by
the user attestation agent to get the signed VM measurement data (a.k.a
Quote), which can be used by a remote verifier to validate the
trustworthiness of the guest. When a user requests for the Quote data
via the ConfigFS ABI, the TDX Quote generation handler
(tdx_report_new()) forwards the request to VMM (or QE) via a hypercall,
and then shares the output with the user.

Currently, when handling the Quote generation request, tdx_report_new()
handler only checks whether the VMM successfully processed the request
and if it is true it returns success and shares the output to the user
without actually validating the output data. Since the VMM can return
error even after processing the Quote request, always returning success
for the processed requests is incorrect and will create confusion to
the user. Although for the failed request, output buffer length will
be zero and can also be used by the user to identify the failure case,
it will be more clear to return error for all failed cases.

Validate the Quote data output status and return error code for all
failed cases.

Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Closes: https://lore.kernel.org/linux-coco/6bdf569c-684a-4459-af7c-4430691804eb@linux.intel.com/T/#u
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Updated the commit log (Kirill)

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


