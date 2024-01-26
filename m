Return-Path: <linux-kernel+bounces-40129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E4783DAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228B72830B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C341B954;
	Fri, 26 Jan 2024 13:23:04 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181A1B940
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706275384; cv=none; b=nXQBNXajGqLuMzdzI815GgBTXxnMo2WbL0qj7qyMTOwRoAgN1vr7065MXYj6rGD9BJCAxTvUjB9SDH9RtT0QgvxXa4dTuUiHucAtdpHAaJ5XfH6SGQ9KPtwyfM6MDC7FrDFXWS1D3M+F0M/BErTKubuPCs+PtRRQJ7PC9rIpxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706275384; c=relaxed/simple;
	bh=iHHNC/KB9/++EkjfGa817hv7W5M7/4V/utIeoP4fako=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tCVsQ7Aow3xACOBpCsal+5s5aX7kgKJaxMcf9dAthDaD94LglBvwyIAv4D8+3N9oBXQvnQmPzNyg3TrCa5+rQkJ9dmPm059u+MzhD5cMF4SQWr0ko6MPxNVXF4R3+JXRLdjTiGQZb8Lg7HPSGf+8xp8lp68s3T2koQ1Tjm2IZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost.localdomain (unknown [61.151.228.146])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 84CB97E011A;
	Fri, 26 Jan 2024 21:22:44 +0800 (CST)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH] mempolicy: check home_node is in the nodes of policy
Date: Fri, 26 Jan 2024 08:22:40 -0500
Message-ID: <20240126132240.24518-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQk0YVkpPShlMTE4YTUhOSFUTARMWGhIXJBQOD1
	lXWRgSC1lBWU1KVUpOSlVJSUNVSk9NWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8d45efdf7703a2kunm84cb97e011a
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mz46TBw5LjMKNg0QLREjHQ8V
	PzgaFEpVSlVKTEtNSUxOSE1OSk9LVTMWGhIXVRcOFBgTDhUIEx4VHDsOCA8YVR4fDkVZV1kSC1lB
	WU1KVUpOSlVJSUNVSk9NWVdZCAFZQUpPQkI3Bg++

set_mempolicy_home_node should be used after setting the memory
policy. If the home_node isn't in the nodes of policy, we should
return failure to avoid misunderstanding.

Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 mm/mempolicy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..9282be2ae18e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1536,6 +1536,12 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 			err = -EOPNOTSUPP;
 			break;
 		}
+
+		if (!node_isset(home_node, old->nodes)) {
+			err = -EINVAL;
+			break;
+		}
+
 		new = mpol_dup(old);
 		if (IS_ERR(new)) {
 			err = PTR_ERR(new);
-- 
2.43.0


