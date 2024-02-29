Return-Path: <linux-kernel+bounces-86956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D661686CD86
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A6F287A30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B788154436;
	Thu, 29 Feb 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh0jzMTP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E9152DE8;
	Thu, 29 Feb 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221747; cv=none; b=eDemj1x9AgTuQo5m5GQtWT/UmVUJCFs+1wSF21/k150ZO4NLZ5eFyKNtE1Iy/jrfEAKihwSUuqSNLIms9ArVwqxqJ/2aPMa84v7AzLo6gKNAPlMdncXUnjH/wFLkouaipD1L6ZPIm8oVZcC2r5xDLtMLh1JZMGl1hjBDDt5laW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221747; c=relaxed/simple;
	bh=5F7XSSCngd7SJiSXtRGZSco15qRwSXu6/QNItN9LrzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLJbIAUD3aMkd9OwG5lSvfDCFmKld1tiK9+jnBsk7DEWK5zpfyH/T/hnq1YJFLVbs0FmzuYv1X6TtqDZi4nVXEH2Tm1nfT0mr+YVm5d/g52dvhFfni2GMzPni4lZ0ikx6thY1piVG5pv47Joaj23c/VnjSZJWDRaLgyZQFnbJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh0jzMTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BF3C433B2;
	Thu, 29 Feb 2024 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221747;
	bh=5F7XSSCngd7SJiSXtRGZSco15qRwSXu6/QNItN9LrzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hh0jzMTPDNE26Siqsw72UEzCT1KFlMBO++UDzbPTNiCq3cCyveUddsn7iYfBPe9mF
	 Krhig8htSj0gYLO1bRzRSOVFqdD4BIgG5ILM7Hk+kkAx3c9EAhTrklRFXtpXUbzZhe
	 fwY1XHiyEPW3Lz1+Dw9G1ZpQvrWbP74gM/C3A0C4CsH7aB1G4tcxuID2YKJ56gKZI+
	 otqU4abAs6izLVAIic0SvrvFNEVlrzniNQQgdXZTA05/myM/pQVHm7KS5WIMChpW2Z
	 PjDaptjCgWuGSYr0OcWEAxtjMU1yoeJcOlkp3TuuexTOWq5dcaIqyHOFk3ywUsuDhv
	 kLqwNHEg3mbtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 08/26] perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1 (incorrect child count)
Date: Thu, 29 Feb 2024 10:48:27 -0500
Message-ID: <20240229154851.2849367-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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


