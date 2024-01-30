Return-Path: <linux-kernel+bounces-44427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2328421EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCD21F21A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6467E7B;
	Tue, 30 Jan 2024 10:49:07 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15D6775A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611747; cv=none; b=ow5ZMU2ArZEokRptpClpl+ggJV0r+3rLYsSGrOpPHKcrTDsVtUW15p/dOY8JT/JXz3efyTmP9kPxKgj7eaCTiACEWccpUZ3qt+t864zMMvD7cItdpcrSMzVfE0jSzmmHyWkX91yAhb71oJXrz2OZEr8HZWXpXzar2BMzfOk4lTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611747; c=relaxed/simple;
	bh=GZufsPghWkdzEG2h/2SSA0buT7CGeIjQOid70c84efM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIGZRuu7KOa/FVFA4R177pqj92Y238hhbSxLOdvd+a5mrEXhHWgX36fVuXNsmRNy1hEz0LDwFxS8I5eYHltcGjxJH/ql0Z3NS+xV5TDZm+/LZ42kvSBEkmGDP7V46mLzWn6lPFRG/CUr/l0Pt1ufFTqDlT4rzWHiKedwNbEM7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost.localdomain (unknown [61.151.228.147])
	by smtp.qiye.163.com (Hmail) with ESMTPA id F0ECB7E013B;
	Tue, 30 Jan 2024 18:48:41 +0800 (CST)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH] mempolicy: add home_node info to mpol_to_str()
Date: Tue, 30 Jan 2024 05:48:39 -0500
Message-ID: <20240130104839.10270-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUxNVkMZQk1PGhlIQ0ofS1UTARMWGhIXJBQOD1
	lXWRgSC1lBWU1KVUpOSlVJSUNVSk9MWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8d59fc47ae03a2kunmf0ecb7e013b
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAw6KAw6LzMOCEpKSygSPzUU
	Dz0KCQpVSlVKTEtNTUpKTElJT09OVTMWGhIXVRcOFBgTDhUIEx4VHDsOCA8YVR4fDkVZV1kSC1lB
	WU1KVUpOSlVJSUNVSk9MWVdZCAFZQUlIT0s3Bg++

There is currently no userspace interface for obtaining home_node,
so we have added home_node to the mpol_to_str(). This allows us to
obtain the home_node from the /proc/pid/numa_map.

Shown below:
7fe356e00000 bind:0-1(1) file=/root/test

Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 mm/mempolicy.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 9282be2ae18e..7a8800036f88 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3033,6 +3033,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	nodemask_t nodes = NODE_MASK_NONE;
 	unsigned short mode = MPOL_DEFAULT;
 	unsigned short flags = 0;
+	int home_node = NUMA_NO_NODE;
 
 	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MORON)) {
 		mode = pol->mode;
@@ -3043,9 +3044,10 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	case MPOL_DEFAULT:
 	case MPOL_LOCAL:
 		break;
-	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
+		home_node = pol->home_node;
+	case MPOL_PREFERRED:
 	case MPOL_INTERLEAVE:
 		nodes = pol->nodes;
 		break;
@@ -3069,7 +3071,11 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 			p += snprintf(p, buffer + maxlen - p, "relative");
 	}
 
-	if (!nodes_empty(nodes))
+	if (!nodes_empty(nodes)) {
 		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
 			       nodemask_pr_args(&nodes));
+
+		if (home_node != NUMA_NO_NODE)
+			p += scnprintf(p, buffer + maxlen - p, "(%d)", home_node);
+	}
 }
-- 
2.43.0


