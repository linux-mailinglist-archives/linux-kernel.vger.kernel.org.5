Return-Path: <linux-kernel+bounces-114502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CCF888ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2247C1C29011
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D21226189;
	Sun, 24 Mar 2024 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1k+WSrH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC302157A79;
	Sun, 24 Mar 2024 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321949; cv=none; b=TIqqVZFCXHjaPYCyWMg94ggzGDJo0HMNPCXOZOs3a0edQbfYKZrxMPHC3GJxJJkvpFKB1YJruidcH00CwCj+32k+l5fJXGFMvoNYWiEZMdvQB9izKZqFsoWakPJqUPriXwYg90uArTcP0bO725An92s/8wnRZEpLeYmjdSGuYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321949; c=relaxed/simple;
	bh=hvQacLUHv2CHEtBQWiQYdrGs6KhvmHzqYnpwsBmzmLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZmHeJfOyfrTXJFExaEkloDRTrLdwoEm5HFPme0Wn9w/KWo0Oy2SBiQIJIGrOPGYChARD5crChdW5fUAvYolsdvpcMDZZwTAslL1bmb5ZkUfKCzNEjv4lHSzWmCqcEuOJza73SarfyZBRJrofZQcCiakGTtQQfc7vmESPQsfw10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1k+WSrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112F2C433A6;
	Sun, 24 Mar 2024 23:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321948;
	bh=hvQacLUHv2CHEtBQWiQYdrGs6KhvmHzqYnpwsBmzmLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1k+WSrHfi0YNPxBgnKvrq2DwJHl1/8eSTmMnZyEBEnCJY9WCa1Z6CtvmSGvljX3l
	 CCcP9fn2XALYbcpoQ+pnSA5fXtcFE40v1kUjF8xlsvY/7NF3w1DhEUUX/nqv+2t4p6
	 ApLS8KiKfaSQgIbiVbLXIXdQIo0KqLtEcx1vlutpwdEybwQvUvSCoqWGOhJNQFb9WX
	 exiKO+pteB0yYmRBRKrvSnk7zmy40S1yQdf7q6GP0mAP+SzWJ6OFO13msWs/xJys73
	 G9kzVRE1TQ6lQ1kisqJKGYGqUyfEqaeXOVhEGjX1YlZBWrqzV3Z9EnoEpMN/QTdj/0
	 5iEe6GI+7pRKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 020/451] perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1 (incorrect child count)
Date: Sun, 24 Mar 2024 19:04:56 -0400
Message-ID: <20240324231207.1351418-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ilkka Koskinen <ilkka@os.amperecomputing.com>

[ Upstream commit 50572064ec7109b00eef8880e905f55861c8b3de ]

AmpereOneX mesh implementation has a bug in HN-P nodes that makes them
report incorrect child count. The failing crosspoints report 8 children
while they only have two.

When the driver tries to access the inexistent child nodes, it believes it
has reached an invalid node type and probing fails. The workaround is to
ignore those incorrect child nodes and continue normally.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
[ rm: rewrote simpler generalised version ]
Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/ce4b1442135fe03d0de41859b04b268c88c854a3.1707498577.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm-cmn.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 47e7c3206939f..899e4ed49905c 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2178,6 +2178,17 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 				dev_dbg(cmn->dev, "ignoring external node %llx\n", reg);
 				continue;
 			}
+			/*
+			 * AmpereOneX erratum AC04_MESH_1 makes some XPs report a bogus
+			 * child count larger than the number of valid child pointers.
+			 * A child offset of 0 can only occur on CMN-600; otherwise it
+			 * would imply the root node being its own grandchild, which
+			 * we can safely dismiss in general.
+			 */
+			if (reg == 0 && cmn->part != PART_CMN600) {
+				dev_dbg(cmn->dev, "bogus child pointer?\n");
+				continue;
+			}
 
 			arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
 
-- 
2.43.0


