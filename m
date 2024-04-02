Return-Path: <linux-kernel+bounces-127532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4536894D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD4D2834E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2DB3FB14;
	Tue,  2 Apr 2024 08:14:22 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401933D552;
	Tue,  2 Apr 2024 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045662; cv=none; b=QYHEDwfiXnWDizkqKiNA15cwckAgEI3WfINj2KyK/unw50WSRrq1xCKcmqx87QzD7lzhurafKeiJ7AkkPGd+IFDAbn/AbSbbgzVZItbnJBE+Q/PPu1JYRshKTKBNHtAA/qrX5Y4GaGuTgRhCswzaoJHSifCiJ+KAacYFeTJKv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045662; c=relaxed/simple;
	bh=zFoKGVF+3N6sg6qvMpvexaatvVtPYRghID21GGzQsC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5TVEjVTW95nuobeJZrimN5SCzIbsm+R67g+Gt1QGn6IJOaOJkWql7TO+sHSKY/h3qISSfHH/cUl19O9fKcFEvq1KD+HDi/tI6WTtKKr2FjWrNVzVKVvLcqfhXIhMEYljR7A8r8iSKmP/bc5+FgOF48GhlpJUshaPQbc375K770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-62-660bbe500238
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
Subject: [PATCH v2 1/1] cxl/core: Fix initialization of mbox_cmd.size_out in get event
Date: Tue,  2 Apr 2024 17:14:03 +0900
Message-ID: <20240402081404.1106-2-kwangjin.ko@sk.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20240402081404.1106-1-kwangjin.ko@sk.com>
References: <20240402081404.1106-1-kwangjin.ko@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsXC9ZZnkW7APu40g9b1fBZ3H19gs5g+9QKj
	xYmbjWwWq2+uYbTY//Q5i8WqhdfYLM7POsVicXnXHDaLWxOOMTlwerQcecvqsXjPSyaPqbPr
	PT5vkgtgieKySUnNySxLLdK3S+DKOP55HlvBTu6K3Ru/MDcw9nJ2MXJySAiYSPz9dZcZxt70
	6CaYzSagJjHp2mG2LkYuDhGBnYwSt5etAUswC0RIbGnqZwKxhQXCJO7vnMMGYrMIqEosvXQf
	yObg4BUwkzi6zRhipqbE+1nfwVo5Bcwl2hd+ZQexhYBK+u8uYASxeQUEJU7OfMICMV5eonnr
	bGaQvRICC9gkdi+9ywoxSFLi4IobLBMY+Wch6ZmFpGcBI9MqRqHMvLLcxMwcE72MyrzMCr3k
	/NxNjMCwXVb7J3oH46cLwYcYBTgYlXh4b2zjShNiTSwrrsw9xCjBwawkwvvTmzNNiDclsbIq
	tSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA+PqTyXneJivST/pTVv9
	Vli/1pnp9J8XLov6zDM2sHhnpywQSlr/d1FG8Vum19XHpTNfNAZZO/zSFP300TW9ST9cfWam
	0PSwqRNu+2gKvo0p+PK+p4Kb/67TYVbe/49/PrTefj0+3tPOuzb2fYhAiADX3IAauSln5BZe
	9rdd93HhuY618nW1p5VYijMSDbWYi4oTAVWkrKxXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsXCNUPhiW7APu40g95+Jou7jy+wWUyfeoHR
	4sTNRjaL1TfXMFrsf/qcxWLVwmtsFofnnmS1OD/rFIvF5V1z2CxuTTjG5MDl0XLkLavH4j0v
	mTwWv/jA5DF1dr3H501yAaxRXDYpqTmZZalF+nYJXBnHP89jK9jJXbF74xfmBsZezi5GTg4J
	AROJTY9uMoPYbAJqEpOuHWbrYuTiEBHYyShxe9kasASzQITElqZ+JhBbWCBM4v7OOWwgNouA
	qsTSS/eBbA4OXgEziaPbjCFmakq8n/UdrJVTwFyifeFXdhBbCKik/+4CRhCbV0BQ4uTMJywQ
	4+UlmrfOZp7AyDMLSWoWktQCRqZVjCKZeWW5iZk5pnrF2RmVeZkVesn5uZsYgUG4rPbPxB2M
	Xy67H2IU4GBU4uG9sJ4rTYg1say4MvcQowQHs5II709vzjQh3pTEyqrUovz4otKc1OJDjNIc
	LErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGxuQ7G69yunt0m1z4c2hFwdG6z162M2KU+m5K
	a/PvddF/5b+pVfz8ZZfwwp598TXfLns1ZD+b+kj/0oaLJ6YUz/b0iT9p7tF/13erfN/HTofl
	21zMfSxP+9du3cB/a6dZ+elUp6wO7Xcv0pS6wi1fzKvcLHJzpRiDRE2ChFvVn1fqTxnfTe1j
	V2Ipzkg01GIuKk4EAAgrpqQ+AgAA
X-CFilter-Loop: Reflected

Since mbox_cmd.size_out is overwritten with the actual output size in
the function below, it needs to be initialized every time.

cxl_internal_send_cmd -> __cxl_pci_mbox_send_cmd

Problem scenario:

1) The size_out variable is initially set to the size of the mailbox.
2) Read an event.
   - size_out is set to 160 bytes(header 32B + one event 128B).
   - Two event are created while reading.
3) Read the new *two* events.
   - size_out is still set to 160 bytes.
   - Although the value of out_len is 288 bytes, only 160 bytes are
     copied from the mailbox register to the local variable.
   - record_count is set to 2.
   - Accessing records[1] will result in reading incorrect data.

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
-- 
2.34.1


