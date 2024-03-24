Return-Path: <linux-kernel+bounces-113888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B688188872B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70749293F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B6820D5F5;
	Sun, 24 Mar 2024 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFlW+Uf/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055C12B142;
	Sun, 24 Mar 2024 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320958; cv=none; b=Em2vvu3GMBnneSo2WWN63+OD3+1BL7Y5frmsL/8rhbQRb8z3IsrMl2bOcu251casGAfZbegecM/omIZrndzEAW9oxpWlu+A1LUK7Im6LdzPthf6NuL4Zm2c4c2fKep+jJ6z21kXk6J9i2Gw74sDoP2VcgyqWj9PqgzRc972bd0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320958; c=relaxed/simple;
	bh=bgLAqlsnttLg7kNlv60BvhVTkQQ/GGMhQj+OGhBRKN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lyz95O0v0y4sHdMTxp5WF3Whh+7uQmNALiMcxCqBG+9BKzyth6EXsxdFWmGHv7zafrtOlPqR/tNaZbxE7IHX6neAgwgA9pKp0s21f8n8t7YF8eGeMFqZoe4rosyhCzjXPLbCWiP0Sb8udua4uX8Q6TQOAhKXBRl8QY8KcRpH1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFlW+Uf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C467C43394;
	Sun, 24 Mar 2024 22:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320956;
	bh=bgLAqlsnttLg7kNlv60BvhVTkQQ/GGMhQj+OGhBRKN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFlW+Uf/MwaLyvysMe83sOwk3LYYsNp3knLHFP0I9R1NtmE0fqeJPcJpNSiV5yUAB
	 I+9UZY48YYhfbj5sGj2yxiqcq9FDZnXsTO7CbB6Da+MYP84qXfpoVzdAveB4IFFFOZ
	 edOy5eh6iUx4Saw730qSbzCt4gr48fg8YoSbvzyc6dk0KPnAkqFRpvbmyEj2VOvJlv
	 EeXuJ26xi5065WJlp0DwVUe3IyffF4zHminAmDJPHmMb6ieHv1RW1Q0ulLozS+EN0I
	 m7aNNkvuwMWbZDVr2oH43bQAYAqU8OoGxtUCoJBcQFI5pbY3guQ2Zp5qvYqhauwkAP
	 VVR4eQOJf84rA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 520/713] media: ttpci: fix two memleaks in budget_av_attach
Date: Sun, 24 Mar 2024 18:44:06 -0400
Message-ID: <20240324224720.1345309-521-sashal@kernel.org>
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
index 230b104a7cdf0..a47c5850ef875 100644
--- a/drivers/media/pci/ttpci/budget-av.c
+++ b/drivers/media/pci/ttpci/budget-av.c
@@ -1463,7 +1463,8 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		budget_av->has_saa7113 = 1;
 		err = saa7146_vv_init(dev, &vv_data);
 		if (err != 0) {
-			/* fixme: proper cleanup here */
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
 			ERR("cannot init vv subsystem\n");
 			return err;
 		}
@@ -1472,9 +1473,10 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
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


