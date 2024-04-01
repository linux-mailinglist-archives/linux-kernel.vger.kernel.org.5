Return-Path: <linux-kernel+bounces-126542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE64B893946
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE0CB215F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E412107B2;
	Mon,  1 Apr 2024 09:11:15 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ACE10958;
	Mon,  1 Apr 2024 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962674; cv=none; b=n/h9xOqN8WvyNoyPFt0rO4x39IyPeVcOUUEbYmrBgPyKrvPKR+EgcuTX+KNi2mjrqrDK3V/G3mn+k7T3WWBXU5LlicNs009mHg6FzOEC1x9xV5WFdsetDhRFLGAtjrxGsMxwfTa3JQCrhnChTbD8qctA38hj9TRQP1IeA4J9J74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962674; c=relaxed/simple;
	bh=UJ3DmFI4BdwIPeJ2k4HFLksSKG/Bx0EHl4E/DqXAh9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEZVx7nhXVByF5AOl0jR7bOpgwYZz4tVMb9njSclh4RhYy92ifYJ3Kx7Xv3s2wlb8TyMa19/ZYJwW1zXIOWC6o8fM0QE5jGFH+x/q4IezD9YaAM/4X87nLETolvtMlUkAZjpHX/Lnp2kstu8VYcyBBedUEvAabzSTTmzek+7kmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-73-660a7a233692
From: Kwangjin Ko <kwangjin.ko@sk.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com
Subject: [PATCH 1/2] cxl/core: Fix initialization of mbox_cmd.size_out in get event
Date: Mon,  1 Apr 2024 18:10:55 +0900
Message-ID: <20240401091057.1044-1-kwangjin.ko@sk.com>
X-Mailer: git-send-email 2.44.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsXC9ZZnka5KFVeawaUNXBZ3H19gs5g+9QKj
	xYmbjWwWq2+uYbTY//Q5i8WqhdfYLM7POsVicXnXHDaLWxOOMTlwerQcecvqsXjPSyaPqbPr
	PT5vkgtgieKySUnNySxLLdK3S+DKOLTHo+A8d0XX2snMDYwLObsYOTkkBEwkdna8ZIex153+
	yQRiswmoSUy6dpiti5GLQ0RgJ6PE7WVrmEESzAIRElua+sGKhAWCJWZ+/w/WzCKgKvHkcRtY
	Da+AmcSCw9+YIIZqSryf9R0qLihxcuYTFog58hLNW2czgyyQEGhkk5i9r4kRokFS4uCKGywT
	GHlnIemZhaRnASPTKkahzLyy3MTMHBO9jMq8zAq95PzcTYzAMFxW+yd6B+OnC8GHGAU4GJV4
	eAPiONOEWBPLiitzDzFKcDArifD+9AYK8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCe
	WJKanZpakFoEk2Xi4JRqYGRSflnB9vFlX17+lfgSheLaiSz+C9M/Tf+3LP7h+udtWX9X+Hqf
	VnE7s6Qmb7eNtLEoZ9AhfpPNtz9M4BHUN+1i0NvmK7d33t0D0yKnuTL4tfX/uCKd5fTWSjDu
	is56Vg2d/SrrLrrlump4enD/8pLadiF/lrcQ58boxINfZU5ZHdC9rFW1XomlOCPRUIu5qDgR
	AArifpo/AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsXCNUPhia5yFVeaQcNOK4u7jy+wWUyfeoHR
	4sTNRjaL1TfXMFrsf/qcxWLVwmtsFofnnmS1OD/rFIvF5V1z2CxuTTjG5MDl0XLkLavH4j0v
	mTwWv/jA5DF1dr3H501yAaxRXDYpqTmZZalF+nYJXBmH9ngUnOeu6Fo7mbmBcSFnFyMnh4SA
	icS60z+ZQGw2ATWJSdcOs3UxcnGICOxklLi9bA0zSIJZIEJiS1M/WJGwQLDEzO//2UFsFgFV
	iSeP28BqeAXMJBYc/sYEMVRT4v2s71BxQYmTM5+wQMyRl2jeOpt5AiPXLCSpWUhSCxiZVjGK
	ZOaV5SZm5pjqFWdnVOZlVugl5+duYgQG1bLaPxN3MH657H6IUYCDUYmHNyCOM02INbGsuDL3
	EKMEB7OSCO9Pb6AQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w1AQhgfTEktTs1NSC1CKYLBMH
	p1QDI9+xFR+K36+LMK6+1OA8u/JUROvVC7FfPRok+d66iGZ55urOSecJeuEz4/GuPxv6px1W
	jDaK/nVu8Y7lm1f18Ie89JrL/3HfnnsbF2trrs+7vCy5uXRtwf/curMtSzwCF589xTWJR/rE
	zrUJW46oRkm9/sO1wehMmZm40+Q900x63l34nK8t5q3EUpyRaKjFXFScCACn0WpTJgIAAA==
X-CFilter-Loop: Reflected

Since mbox_cmd.size_out is overwritten with the actual output size in
the function below, it needs to be initialized every time.

cxl_internal_send_cmd -> __cxl_pci_mbox_send_cmd

Problem scenario:

1) The size_out variable is initially set to the size of the mailbox
2) Read an event
   - size_out is set to 160 bytes (header 32B + one event 128B)
   - Two event are created while read
3) Read two events
   - size_out is still set as 160 bytes
   - Although the value of out_len is 288 bytes, only 160 bytes are
     copied from the mailbox register to the local variable
   - record_count is set to 2
   - Acessing records[1] causes a buffer overflow

Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>
---
 drivers/cxl/core/mbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9adda4795eb7..a38531a055c8 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -958,13 +958,14 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 		.payload_in = &log_type,
 		.size_in = sizeof(log_type),
 		.payload_out = payload,
-		.size_out = mds->payload_size,
 		.min_out = struct_size(payload, records, 0),
 	};
 
 	do {
 		int rc, i;
 
+		mbox_cmd.size_out = mds->payload_size;
+
 		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
 		if (rc) {
 			dev_err_ratelimited(dev,

base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
-- 
2.34.1


