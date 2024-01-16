Return-Path: <linux-kernel+bounces-28014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E5182F917
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D39D28A22C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277ED28E1C;
	Tue, 16 Jan 2024 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8kolEji"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690695C604;
	Tue, 16 Jan 2024 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434838; cv=none; b=Ff2+zFn4Qi+HDyZ4uaC7X92IIQzNPhUjLNCnXKtMcDIZTjd982fCNgS1kVrN+lLvgHWvaMtEbk7HoaL5mB9dtXWYETOpXFPVlZ1Yv7zGG0LabQ3OgoGf0Ktwt0OLP+lpSseqXJ9C9ZGD/GDC6hQnkxU8YU8K2fdJjTggdslF+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434838; c=relaxed/simple;
	bh=jUHpHxhjYTN/68x+epj3CFaEsOY4Qf0DcyLchOF4UPs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=bA3RiE1Tox1N0UH00DuqOpX6Gm1OocjWOJuz9jIQKW36WSzRZcahGLC5PBhMPZtc6arXBo2WnB+ZwEGWvt+id9uo3tiBMxyL5PWIIM5yXeaHxas3ayR9Vu1v+EswYvX3+uovN4rCad32aYMkpKU6LDDf5m6pUlu4bz9dkpA7GKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8kolEji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C8EC433C7;
	Tue, 16 Jan 2024 19:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434837;
	bh=jUHpHxhjYTN/68x+epj3CFaEsOY4Qf0DcyLchOF4UPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8kolEjig76+RI975s02VQTl3spJewF6S6D34Awt+3MxTWWZ4YIYCDQMxhwaBaR0z
	 8DaDAiMm5ejXaTBH8JuE3BwzUB1GQAxZ4ZwvoVDbbBXL1xc72GeV1Zthf1+tlyvRKJ
	 RTusMDNuv5m2MqyToAqX4F992/gJ4l2U8smbtINFwlQMqhVWOOGGp9KhN+t5Tq4sYM
	 lfg381H4FfZqO97Kp5LvrQG1J2Czsc8rKMlx9Cr8U/w+HBjPpx5tVqIyKyxRSd2OaG
	 YI6BH+ejPQgR+iOEfycyjEzskIw45G5MqoloUbni9eJnfSAWPfW05I/aycMSlgktMX
	 MPxVEuFIFNQWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Suman Ghosh <sumang@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	jerinj@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 102/104] octeontx2-af: Fix max NPC MCAM entry check while validating ref_entry
Date: Tue, 16 Jan 2024 14:47:08 -0500
Message-ID: <20240116194908.253437-102-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Suman Ghosh <sumang@marvell.com>

[ Upstream commit 4ebb1f95e0c3c3e0eec5bb21aa43097580c4b6e4 ]

As of today, the last MCAM entry was not getting allocated because of
a <= check with the max_bmap count. This patch modifies that and if the
requested entry is greater than the available entries then set it to the
max value.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Link: https://lore.kernel.org/r/20240101145042.419697-1-sumang@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 0bcf3e559280..3784347b6fd8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2678,18 +2678,17 @@ int rvu_mbox_handler_npc_mcam_alloc_entry(struct rvu *rvu,
 	rsp->entry = NPC_MCAM_ENTRY_INVALID;
 	rsp->free_count = 0;
 
-	/* Check if ref_entry is within range */
-	if (req->priority && req->ref_entry >= mcam->bmap_entries) {
-		dev_err(rvu->dev, "%s: reference entry %d is out of range\n",
-			__func__, req->ref_entry);
-		return NPC_MCAM_INVALID_REQ;
-	}
+	/* Check if ref_entry is greater that the range
+	 * then set it to max value.
+	 */
+	if (req->ref_entry > mcam->bmap_entries)
+		req->ref_entry = mcam->bmap_entries;
 
 	/* ref_entry can't be '0' if requested priority is high.
 	 * Can't be last entry if requested priority is low.
 	 */
 	if ((!req->ref_entry && req->priority == NPC_MCAM_HIGHER_PRIO) ||
-	    ((req->ref_entry == (mcam->bmap_entries - 1)) &&
+	    ((req->ref_entry == mcam->bmap_entries) &&
 	     req->priority == NPC_MCAM_LOWER_PRIO))
 		return NPC_MCAM_INVALID_REQ;
 
-- 
2.43.0


