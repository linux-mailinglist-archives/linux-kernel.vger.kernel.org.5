Return-Path: <linux-kernel+bounces-114266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CFE88897E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077941C2802A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4973E25B332;
	Sun, 24 Mar 2024 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMQGdQ9b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6024139569;
	Sun, 24 Mar 2024 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321630; cv=none; b=cnYGBTK+YxoYDOHFOXXWQLldUYkFeMeV8OWxV5IR0mBoLLeIZYsTawyKkwLoEG3oAZZfR7JEP4C8WyBJZt4jsrdCBRIjtrSH5MffUp0Unw+RCiz76Bz3WPZmQK5DBiXw9aEV39oL5UbVZ7OF1jD0KvV7zIl52oG4J+bWQazrtAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321630; c=relaxed/simple;
	bh=iKyn4MWRRbH3n3TzPpKz0zXDvdScToqrDIXfhIunSDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oo41WIEUg1ROIwScQ53wyeA71woTQJYNBZ7g7s1aNVbCdyOhXeQVr/Zuj30L6Lm6U7y4apfHEjfHsjRXPwM47/T+3j0QRBlTDezBXVjvNUKOOyqf/Oan2UDtt9kv7o6b5mEVBjl9X5NBTT6AH9S421xJCDbyQFlQWW4uwzr9wuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMQGdQ9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD8DC43394;
	Sun, 24 Mar 2024 23:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321629;
	bh=iKyn4MWRRbH3n3TzPpKz0zXDvdScToqrDIXfhIunSDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMQGdQ9bViDNfSapgFokAdSMmwtUKzCdTCWXxJfnDaOOsYEZSXZBvg4FZrPJc83C6
	 8+DkwHAOB03JiazP/qpnweCfJX1VBx47cH1gCVytXtFif3OROAnQJ/QUwXQggeYN/W
	 wmfglhrGXh/cU4nCn8yeCB4aexmlg7ENUwOBJNN95GoAWqd3LHjcX1EgWDuv4RiLc4
	 PvrE38IS+QNMB3pSm0UdaLvxtdXwDHyFWW+rgT17i6+fcyG3P4CUHSCcRVsyaT+BQt
	 3kJKIUeg7rveCO/f1zEWxdgM/PDS/851pPrfrU62OOBsXHyELbU18D+xs7SLTZlCq2
	 A+EiayKkeqX9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 360/638] ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()
Date: Sun, 24 Mar 2024 18:56:37 -0400
Message-ID: <20240324230116.1348576-361-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 19a801908b56d..4c54ce212de6a 100644
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


