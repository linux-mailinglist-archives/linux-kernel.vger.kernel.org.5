Return-Path: <linux-kernel+bounces-104288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE0A87CBA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B015B213C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EEC1A27E;
	Fri, 15 Mar 2024 10:54:40 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37218E02;
	Fri, 15 Mar 2024 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500079; cv=none; b=CUir1N4l9XE4YJWp+lIMcSJykzdIMlDX0W5dsjVtqKil8I9MpAd2aCvwofdUOpUBtaBJId65at8d2Pmi9l3w4OJm5PzNmExCjS824bi54o42s8M3Ex4jZhWknRUvc+94Ce5gvhzX5qpK3eKahWhOVi9LgHz1oETZiP3kf0keG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500079; c=relaxed/simple;
	bh=coEa7bpDdvUAxjenU2S6uAixXbXu/B7uaiwt/OfF2T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxJTT7xX1mD2bsb8cb93EcxhnU2+bj0BF+2d20udP9Lj7xh6O9OXql45eFZAjPKGF7CY/ETJyqdHdwgIHKPUKnayPDYcFFAWrAcBaiwqbiPNepXxPstpULWnq4SnhM98ymIdxBvAw7euEvVHbDBjKwaqZBYnSRzRBLdTOqfPsqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBX00DfKPRl1oq1Bg--.31652S2;
	Fri, 15 Mar 2024 18:54:23 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBHuUHUKPRlaIwAAA--.853S4;
	Fri, 15 Mar 2024 18:54:16 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: ira.weiny@intel.com,
	jonathan.cameron@huawei.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 1/1] cxl/mem: Fix for the index of Clear Event Record Handle
Date: Fri, 15 Mar 2024 18:53:36 +0800
Message-Id: <20240315105336.464156-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315105336.464156-1-wangyuquan1236@phytium.com.cn>
References: <20240315105336.464156-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBHuUHUKPRlaIwAAA--.853S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWXzUXsFBgAAs6
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7KryrZw4xuFWfKr1DAr4rAFb_yoW8uw1UpF
	W3uryIkr4kXa1a9wsxAas0g3y3Zay0grW3urWUt3s3G34avF98XF1fJ3yjyFsIkFyrXF1x
	Arn8Zr45GayjgF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

The dev_dbg info for Clear Event Records mailbox command would report
the handle of the next record to clear not the current one.

This was because the index 'i' had incremented before printing the
current handle value.

This fix also adjusts the index variable name from 'i' to 'clear_cnt'
which can be easier for developers to distinguish and understand.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 drivers/cxl/core/mbox.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9adda4795eb7..3ca2845ae6aa 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -881,7 +881,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	struct cxl_mbox_cmd mbox_cmd;
 	u16 cnt;
 	int rc = 0;
-	int i;
+	int clear_cnt;
 
 	/* Payload size may limit the max handles */
 	if (pl_size > mds->payload_size) {
@@ -908,28 +908,29 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	 * Clear Event Records uses u8 for the handle cnt while Get Event
 	 * Record can return up to 0xffff records.
 	 */
-	i = 0;
+	clear_cnt = 0;
 	for (cnt = 0; cnt < total; cnt++) {
 		struct cxl_event_record_raw *raw = &get_pl->records[cnt];
 		struct cxl_event_generic *gen = &raw->event.generic;
 
-		payload->handles[i++] = gen->hdr.handle;
+		payload->handles[clear_cnt] = gen->hdr.handle;
 		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
-			le16_to_cpu(payload->handles[i]));
+			le16_to_cpu(payload->handles[clear_cnt]));
 
-		if (i == max_handles) {
-			payload->nr_recs = i;
+		clear_cnt++;
+		if (clear_cnt == max_handles) {
+			payload->nr_recs = clear_cnt;
 			rc = cxl_internal_send_cmd(mds, &mbox_cmd);
 			if (rc)
 				goto free_pl;
-			i = 0;
+			clear_cnt = 0;
 		}
 	}
 
 	/* Clear what is left if any */
-	if (i) {
-		payload->nr_recs = i;
-		mbox_cmd.size_in = struct_size(payload, handles, i);
+	if (clear_cnt) {
+		payload->nr_recs = clear_cnt;
+		mbox_cmd.size_in = struct_size(payload, handles, clear_cnt);
 		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
 		if (rc)
 			goto free_pl;
-- 
2.34.1


