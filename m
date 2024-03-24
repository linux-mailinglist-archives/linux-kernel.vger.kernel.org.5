Return-Path: <linux-kernel+bounces-113814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64C88886C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B9629135B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09A1FDB25;
	Sun, 24 Mar 2024 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isYAnDzo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3C51E621C;
	Sun, 24 Mar 2024 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320841; cv=none; b=Rvs1KvB0RfRdeuBWfu/n7YEqEwnt/X+7H62OnKZW21guKkoGCOq1TaX/80pt5Ul1CZvcc+9xfqI3iyslLqXsWX0wjga43CkXRX5pQydFX1qAM6wF/Je04rMfXydZvMZGfqC6iIQN9d6iiMy4c+zwKqXrNXGYPwTrEgPHis8fuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320841; c=relaxed/simple;
	bh=uxy3V+RQwm6GDIBtMAfPP7EnSHK32Sx43UE/yYHa5U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqJmG01c/Yi3AQH5pciyBCFMrwM+qxXWzSIxbwyt7aXqnPQfgUHLWrHBgusVUmUvKEF/qIKYfwpCG6QM7E2lX/UAnbDqr1ZDCxomQnPNkUsfv7UhT4pnCgONkFFriFReXDWEh3oERHEEbwrMFeyck+gS/5N/4QTzYZe9fY46T+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isYAnDzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B145C433C7;
	Sun, 24 Mar 2024 22:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320840;
	bh=uxy3V+RQwm6GDIBtMAfPP7EnSHK32Sx43UE/yYHa5U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=isYAnDzoS+aQi2dUdbMHItYTCUxju21CumDa+YjGaFQo7hA9kIFSTIL9Klbm8PUS/
	 OiNUCx8auxbb/bPJwumROx79GHxqvrfyN9UfIVf9R22yw2yM68mb/KNlkYv0EFKMcW
	 e6R6mBCUJV/XZaFo33j3d18HSV9mYVpwkak7H8d5qgn9i/j0pIlfzbE2X753Kw8Uus
	 9JAZygTSKB4NnQT9ztnMSVb5pIQe/ouYYt+ebLYJsWM1YW5rDWC/3vDYtrcEZnRAd1
	 HBmXFlwDymRFElHgUXsKYGzRIId+9L7nB9h8Jvs/c+mSab2jAwGy8RgyTkZnX4N9Dj
	 7SupLDmTXvWmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 406/713] ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()
Date: Sun, 24 Mar 2024 18:42:12 -0400
Message-ID: <20240324224720.1345309-407-sashal@kernel.org>
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
index 603ea5fc0d0d4..c6f637f298476 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -547,17 +547,27 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
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


