Return-Path: <linux-kernel+bounces-104218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDD87CAD8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027381F22F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2773F17C6E;
	Fri, 15 Mar 2024 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="IfEVdjhO"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2617C69
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710495982; cv=none; b=WaxMuFq6bx5Ah1hUhdWwRl0es7MW2dqIBaHd5/5pFM7yPPJsAnL/JNHttmlTVlE8MPU4JqFudMAtfpfIWhSFmZb3M3wLwf51cwQjDHaP0s6HHJI00pCv5qLqz4nXAVh6gNMoRqyk0lhsPkDD5TGTj9YiiYxPRZvrEnhyE0d3IB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710495982; c=relaxed/simple;
	bh=ortQPoo4CXrjAd1i/8JC74kiBxm//LLr8F+RzH9tXw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VdDJDeXAul1leXBeqVj79Z//cqdWNAQCONeNRG3EkWbjKlq2/+TrGosfFnmqGjV4lyMFCE0gdiMPWTMogSKE38V/LF5JehwiKbhCnhO5IbL4pemwqmkyvBJBia5eTbAP+84nzE3TLNduxV9QfUvXcCfcJgAGb5wxLYTokGpJV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=IfEVdjhO; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1710495479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7oC6Mh1rcfq5r9Zbg+eK8jpikSImT7CV2r1Rsy2JX/o=;
	b=IfEVdjhOZiZO+cU1tvhtj3Zn4UrXqUF6vBMlvzScIIhuqo8lxeAMZM7Jg37ld7nOO4fYpG
	lGxqwzHKD8l6j5tp1nqXMeXDbtLz3Gq8LZORfciq+rFP1/40SuiCYZulFynhX0t8rvx/rT
	BP+gjwCmKwFYTGRVwiv5IjDZD2lNHHU=
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	trufanov@swemel.ru,
	vfh@swemel.ru
Subject: [PATCH] mtd: partitions: redboot: Added conversion of operands to a larger type
Date: Fri, 15 Mar 2024 12:37:58 +0300
Message-Id: <20240315093758.20790-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of an arithmetic expression directory * master->erasesize is
subject to overflow due to a failure to cast operands to a larger data
type before perfroming arithmetic

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/mtd/parsers/redboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index a16b42a88581..3b55b676ca6b 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -102,7 +102,7 @@ static int parse_redboot_partitions(struct mtd_info *master,
 			offset -= master->erasesize;
 		}
 	} else {
-		offset = directory * master->erasesize;
+		offset = (unsigned long) directory * master->erasesize;
 		while (mtd_block_isbad(master, offset)) {
 			offset += master->erasesize;
 			if (offset == master->size)
-- 
2.25.1


