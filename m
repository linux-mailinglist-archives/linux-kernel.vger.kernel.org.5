Return-Path: <linux-kernel+bounces-105656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED2487E223
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1EB2B21908
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2C71E533;
	Mon, 18 Mar 2024 02:30:01 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015771DA58;
	Mon, 18 Mar 2024 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710729001; cv=none; b=KzNNr+PXV9p9ZiCS6P7d8LXRtWDdRK42+RhHH0VurUx0CFviejRaGmK8cakeCC5ihFQnxn/dFmPXhy+UQXwtpMR+JgvEjiSFh0nGFuoBcMLRS9avKVaCU5sTghPEpd5SrWn6h+sFkyVZKlD3tCDEH78LGCpWn+f+2S1F0uovApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710729001; c=relaxed/simple;
	bh=Vzfj5o6D7Na/6aOu8CV74Zqtv20GrJloloDTpGKeZZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M5Y+nRrecjupZyiiP2t1IA4Xi2Cv39V75cwyuYb/AjAIV0JCUHg7RPTmhFBgZayrWkSqe+UTVFhr3Tfe5lKFb1hfhnjIFcNHLaTXk9tKiYfzIeTcJhBX1TlY1RjNyTBO3lBr6rNY5sFIxHA++5Qt4x0L64/hYgOr4eFsPzoE3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCHNwgbp_dlClvTBg--.42586S2;
	Mon, 18 Mar 2024 10:29:47 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDXXNEPp_dlAEUAAA--.183S4;
	Mon, 18 Mar 2024 10:29:39 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: ira.weiny@intel.com,
	jonathan.cameron@huawei.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH v2 1/1] cxl/mem: Fix for the index of Clear Event Record Handle
Date: Mon, 18 Mar 2024 10:29:28 +0800
Message-Id: <20240318022928.509130-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318022928.509130-1-wangyuquan1236@phytium.com.cn>
References: <20240318022928.509130-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDXXNEPp_dlAEUAAA--.183S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAIAWX3ReYBDQAAs1
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Jw1rXryDuFW7uFWfGF18uFg_yoWfAFb_CF
	10qF1xuw4YkFnak342krsYvrySvw1rWF4S9r1qqFW5J347Zw13JFZ09rnFyrnxXrWUAr17
	ZFy3XryFkrnxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

The dev_dbg info for Clear Event Records mailbox command would report
the handle of the next record to clear not the current one.

This was because the index 'i' had incremented before printing the
current handle value.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 drivers/cxl/core/mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9adda4795eb7..b810a6aa3010 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -915,7 +915,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 
 		payload->handles[i++] = gen->hdr.handle;
 		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
-			le16_to_cpu(payload->handles[i]));
+			le16_to_cpu(payload->handles[i-1]));
 
 		if (i == max_handles) {
 			payload->nr_recs = i;
-- 
2.34.1


