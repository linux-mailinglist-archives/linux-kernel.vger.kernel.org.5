Return-Path: <linux-kernel+bounces-86982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E773A86CDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88672B2631A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF07134400;
	Thu, 29 Feb 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is480fk7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5F4AEF6;
	Thu, 29 Feb 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221801; cv=none; b=eITWlwfB4saq/u8C5v90bM75pBoTalneWlrnCXDX7DqK3iGTngOxQ2a06H//U0zW77wiuKnPHztgk3J6YnTzbUfWQI3R7TbXfPXCjzHgIT93vV/Kjgr7r8EhzECv+RDgOB2xLTGmdt0gZrAm7ky2UHpEvCSshg49xlJ8cZU0ayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221801; c=relaxed/simple;
	bh=/UDMCO+p3pTN0o3VKH882mj3piAL34bvPIkXm2pXWnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQqygGT3hsvSuEH1wq0zfUiziGwVKvgaXDjh9obNpqmq3Swxq9kume3eN7GNUYoekbEoW8XQ/dR5DoM+lAzSflgC6olgSNIezp5X6hWwqf18azFdzngx4Bl4ttAeAGay4YBRZmvNrlpH338TVu4nc2mZSgBS4xpPFj4K7cKvMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is480fk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34FBC43390;
	Thu, 29 Feb 2024 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221800;
	bh=/UDMCO+p3pTN0o3VKH882mj3piAL34bvPIkXm2pXWnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=is480fk7cNTOODF8vlmOac4m59R67O76roWs/+/tZpeFGsfJ27BAp+WYPSIpn59Kx
	 IWn0RkJFchZLocXALvn9ApAvGzeGHW4e5p5ZTLAYGAUiId9Iiyjjcy3maoy1tO/aEw
	 DFqtnF1LXPYxpAIWHLo+NybPL2e1Ld2Hv5CKAFpLfLDMtJ2seAzvsFlSx+dUxC0wLU
	 LtiHsshyazfti9nnjf06LTnl4smSp71J5sXAhYtdKrM6uB24W5hcWnfAPOjWruzWAy
	 l91PoUccSAXRDtWoUqv8D1XzFmc+0weVikZ7ta6RuyozJgqR9dJzdiztf1mkfqlssM
	 uSkjCVJF54dHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 07/21] perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1 (incorrect child count)
Date: Thu, 29 Feb 2024 10:49:27 -0500
Message-ID: <20240229154946.2850012-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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
index 6404b17d3aeb0..2c684e49a6fc7 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2301,6 +2301,17 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
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


