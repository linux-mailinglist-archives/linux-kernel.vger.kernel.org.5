Return-Path: <linux-kernel+bounces-113258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECE08882C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C281C1F22396
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090C113CAB3;
	Sun, 24 Mar 2024 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AND2Jkym"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88613CA95;
	Sun, 24 Mar 2024 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320058; cv=none; b=L5d4qDt1y5cD3OxeB+qrrRfHM4EcmoaCrCHPHr6r9TFKQXcFHMapBtaFNfUj4GtuPlmWUT4WHzpzhG9JWSnLcAzNcPsMF0KYk1Xs5dYJ/ugTChtL1GMc4QDRKCjekVsg0Zfgb5jV0V1snh/PcVl0MgMDTLwr9FbTdyDCORjMxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320058; c=relaxed/simple;
	bh=w1lzHvGXBX3ANXxLc/UUheMyGtodUzRmiK0aL41bvzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4VTwAF5TRk6MCNADBk1VTf6vp0LuWFSrAAxHSDypX5kxs/0p3Rimcm25yVb/DxuKsF8W/y+G7U945IhVOOE8DAvPTiDJTYb/UUCHA0tXIZZFMGsDwkd5EzzwhgLz4qqI/88nGDl+UhR+te/QM/5hR/frUMlBmFZckPc/OgJOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AND2Jkym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A38FC433B1;
	Sun, 24 Mar 2024 22:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320057;
	bh=w1lzHvGXBX3ANXxLc/UUheMyGtodUzRmiK0aL41bvzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AND2Jkym4RL0FL5PTFi6rjAGi+ft6Z+mFR/ehD2NM1dh/G1b2B+Kpln9pLAwsw5oF
	 yNFKkvqOTdLffvUxbpzBxt4OU2mgvkY3t0y48EJnEkuyZG/axo8AAsImXIhzy+xoTR
	 8Lxd+GC9jcJRBB4/8kSAp8vEqPuSZmA3/SmuDtICXWXbjDOelGbMW8EoufRI/HTYvc
	 NUNNUmEnnSN6TiBEtmiZkFy2h0PxlcqI//mfOTtKqN4Mz8JSZT6qevT/WOSOaUmDrJ
	 f75f1Uar19KypU3Ap7C6A9Jcv63PO+53rpxijILgWHzPpA579N1+9sHPS2YH32Zk4U
	 g9NH3cKQUhOpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 367/715] ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()
Date: Sun, 24 Mar 2024 18:29:06 -0400
Message-ID: <20240324223455.1342824-368-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 222be59e5eed1554119294edc743ee548c2371d0 ]

Driver uses kasprintf() to initialize fw_{code,data}_bin members of
struct acp_dev_data, but kfree() is never called to deallocate the
memory, which results in a memory leak.

Fix the issue by switching to devm_kasprintf(). Additionally, ensure the
allocation was successful by checking the pointer validity.

Fixes: f7da88003c53 ("ASoC: SOF: amd: Enable signed firmware image loading for Vangogh platform")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Link: https://msgid.link/r/20231219030728.2431640-6-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 07632ae6ccf5e..9aa9600c05d61 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -560,17 +560,27 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	adata->signed_fw_image = false;
 	dmi_id = dmi_first_match(acp_sof_quirk_table);
 	if (dmi_id && dmi_id->driver_data) {
-		adata->fw_code_bin = kasprintf(GFP_KERNEL, "%s/sof-%s-code.bin",
-					       plat_data->fw_filename_prefix,
-					       chip->name);
-		adata->fw_data_bin = kasprintf(GFP_KERNEL, "%s/sof-%s-data.bin",
-					       plat_data->fw_filename_prefix,
-					       chip->name);
-		adata->signed_fw_image = dmi_id->driver_data;
+		adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
+						    "%s/sof-%s-code.bin",
+						    plat_data->fw_filename_prefix,
+						    chip->name);
+		if (!adata->fw_code_bin) {
+			ret = -ENOMEM;
+			goto free_ipc_irq;
+		}
+
+		adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
+						    "%s/sof-%s-data.bin",
+						    plat_data->fw_filename_prefix,
+						    chip->name);
+		if (!adata->fw_data_bin) {
+			ret = -ENOMEM;
+			goto free_ipc_irq;
+		}
 
-		dev_dbg(sdev->dev, "fw_code_bin:%s, fw_data_bin:%s\n", adata->fw_code_bin,
-			adata->fw_data_bin);
+		adata->signed_fw_image = dmi_id->driver_data;
 	}
+
 	adata->enable_fw_debug = enable_fw_debug;
 	acp_memory_init(sdev);
 
-- 
2.43.0


