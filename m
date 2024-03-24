Return-Path: <linux-kernel+bounces-116287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5292F889E00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38022A5920
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A83CC1D9;
	Mon, 25 Mar 2024 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMHyuCE9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64A181D0D;
	Sun, 24 Mar 2024 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324144; cv=none; b=o2CheFYH5kT9I/wVcohnu5pjvijsvL8IuBGwGHWIVZS7Jx+X+2k9Q0w0miUcqrocommNK7LASJKcBAjYVNDwLO6+mZl+wNv4DO9UDEQf4y4UIWhd1U5ye5t2yi2k/lDZz9kXFTaedYeMQ7CX4uSsxCtwI2eqexGU+GcKFkLIBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324144; c=relaxed/simple;
	bh=q0TseBmdD4j1bSZE8TyL8DKxdTzbsmqgxfwePlJzWqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkYT9AYDgmMZYZlHXXeplIIdErSdBZpO/+okis4Genn9XEK8T795HgVEFpDMan999ujAMH2CHSXxpJIC4gaSdc//QLOVbXqoMS3hho4jr99yi9H2lvjCCUiezK4ACpCn/hp6gcv/ertaK4aTOos/ziHG5ruX8HxpRd5n7ExZaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMHyuCE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17DDC43390;
	Sun, 24 Mar 2024 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324143;
	bh=q0TseBmdD4j1bSZE8TyL8DKxdTzbsmqgxfwePlJzWqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMHyuCE9ummo6DMLnq4SyDP9f9jC0xQXiRBKsBQHxd/ZzYEWdsYMYroImMgRM4K+o
	 zoFHY9CQ3LCtgC06OtlAlhm31oRbl02gAozgdZzBAOhuoeFQBKQB23T6r4Hi0oO7Ax
	 DLk3Agz22uJm9J3LhMMYbCxLe8HGfRZHZxBWU6OFlewKtZuelHPqEo7By4vV9/d7qp
	 yQ78vt7oMdCRQDQQYU5MWXi/X/aoy7eObQhHL8JtugpCAnpxjYq7DfWK/gu+6gUcv8
	 OImDQ4htBgD2Z7UWxFdF/e9BEuC/wJE/kvpHS6uecEQ47RjzZqadjJUNPV5gNFhdhv
	 AoQHuvFbNG2Sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 139/183] media: ttpci: fix two memleaks in budget_av_attach
Date: Sun, 24 Mar 2024 19:45:52 -0400
Message-ID: <20240324234638.1355609-140-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit d0b07f712bf61e1a3cf23c87c663791c42e50837 ]

When saa7146_register_device and saa7146_vv_init fails, budget_av_attach
should free the resources it allocates, like the error-handling of
ttpci_budget_init does. Besides, there are two fixme comment refers to
such deallocations.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ttpci/budget-av.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/ttpci/budget-av.c b/drivers/media/pci/ttpci/budget-av.c
index 38cac508bd728..3766c7aa96f44 100644
--- a/drivers/media/pci/ttpci/budget-av.c
+++ b/drivers/media/pci/ttpci/budget-av.c
@@ -1462,7 +1462,8 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		budget_av->has_saa7113 = 1;
 		err = saa7146_vv_init(dev, &vv_data);
 		if (err != 0) {
-			/* fixme: proper cleanup here */
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
 			ERR("cannot init vv subsystem\n");
 			return err;
 		}
@@ -1471,9 +1472,10 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
 
 		if ((err = saa7146_register_device(&budget_av->vd, dev, "knc1", VFL_TYPE_VIDEO))) {
-			/* fixme: proper cleanup here */
-			ERR("cannot register capture v4l2 device\n");
 			saa7146_vv_release(dev);
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
+			ERR("cannot register capture v4l2 device\n");
 			return err;
 		}
 
-- 
2.43.0


