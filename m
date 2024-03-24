Return-Path: <linux-kernel+bounces-113616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929CC8885B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345B31F23838
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDAF1D2A98;
	Sun, 24 Mar 2024 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF8umtIt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7814A763FD;
	Sun, 24 Mar 2024 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320451; cv=none; b=gdgDNEjQq3HNRAm8Q5lXCMFs+NeXoftRa818Q0ly7rLCBAQCTegu28RaNetJWSsSjb3jb3V1rMTgNQWZqLKplo0U80hQi8iS/aHvm78TJOWHK/v6NZm6o+WZpmgFFBUrGlgYvMyQbC/vuu92sVKr2+whTyy7rLzcATdx9ZiIpzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320451; c=relaxed/simple;
	bh=5F7XSSCngd7SJiSXtRGZSco15qRwSXu6/QNItN9LrzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpmUyGLCt2fWu7oa0FtAEw+svn02jj2SXRLYQK2ygH5VRE/bgAmifZjXUtT310i0fQZWjplHfsvTKlPaDIePySPGqZ9nSd0HryVnqxKseX/xlOG3XQQV2KxSAceI4aS4XU7Y/th2AHkZw1LFdnZtSXpQyxenx7iKvH8SJcCIjAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF8umtIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5393EC43394;
	Sun, 24 Mar 2024 22:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320451;
	bh=5F7XSSCngd7SJiSXtRGZSco15qRwSXu6/QNItN9LrzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pF8umtItCrqEpHtsmJOL4IwiZZ+XEheSECokCt8nPvWD3ur1fs++twbvex+Mlf7D0
	 T7lPEpO/iDpvDmVb2GcOa0KSGEKKCLYk3VHxTXMEDizissrCbjZvpwpddG7WTz2TCj
	 RFy/5+/MTQw+84xQKAiEtkrpB4/hKiYIT7sKtyBqtmj1K1nYo5LIoMnaGFoH7widhu
	 nvCNDQ9soXH/TOjIJyiV6i7HxEe4PesKeMvVx8tA2qK/rH51QU7MOmCiZsV2+77fY9
	 RdZrmWl2gzDLhd3LJ9yd/38vvfk3/hReF5tKqXEPf5Hx1hkGl/AILfZyxVCp8GH35m
	 MCWg7DHdfM2AA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 009/713] perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1 (incorrect child count)
Date: Sun, 24 Mar 2024 18:35:35 -0400
Message-ID: <20240324224720.1345309-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index c584165b13bab..7e3aa7e2345fa 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2305,6 +2305,17 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
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


