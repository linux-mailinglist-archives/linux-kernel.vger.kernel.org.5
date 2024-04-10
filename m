Return-Path: <linux-kernel+bounces-138869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF9489FB75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B001C22572
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E032615EFBF;
	Wed, 10 Apr 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjZ2Bc+E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DDA16DECB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762741; cv=none; b=NuckSwRgdlpRakeF1L7HfCPwNLNrSa+UUttwHKX37Kjx+GFL4dqho8Jk/Hi/IvzCQk4e26MESPFuDreZtl5uQlvyTZWxQl5hSZb0L6fwLyyLYhPaUPq9bbTpu1x8uNKToAO9WwSD7iB13lS3DJRDSzlSY9j+lFUwiCKIqbPOI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762741; c=relaxed/simple;
	bh=Nqu+9dKEhjC9kwrawShWr3dtYD9VLYMStsi3if+IvzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SAp/aKoUmdCEINAKF9J5NmLQs05AO0jiH4ehtkbwPv/RTkZRvlaiWAvCZHTibg9ZVvBlElgkmJF0jfEz05FBs1b9LB9PhV/t55jRSdeVy1a2i8eK/v9dKA9xr0MS441lEkaUN3jb8h4ZVz5jzvAYIxf2UnHocwqETN3hvc0xXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjZ2Bc+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22978C43394;
	Wed, 10 Apr 2024 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712762740;
	bh=Nqu+9dKEhjC9kwrawShWr3dtYD9VLYMStsi3if+IvzE=;
	h=From:To:Cc:Subject:Date:From;
	b=gjZ2Bc+E4cT3wA8GAem+w6X9VRG7fkY20Q4/K0PkLiL02OIaisKhKe+Wi8eMTIJWc
	 Wr6sb3tUJxHK3ZlHalfgYtweIe4gLL8sJG7jNpvAG3/qxz8VdF12UmrLFIwrfeZyYQ
	 1K/GSM1ZAhbuHTNmM84M/+f3mx0vJXtda+mGQWuhlExj8AlmHC27xBYDrrEMI367yl
	 v3JiSCNeNP/+wAYreBOsx7442EXytLqS7mnbW4Y/QqWnu9C1lXRsGhfvQp01j7fmDw
	 UhgSCaOBwbZuc1rfWIoB9ZD99Wq8OGMIrNeNJv1sNzxgoYv1Q32/9G4sQAWnCHnsG+
	 yliVcTh1Q0JzQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] mailbox: mtk-cmdq-mailbox: fix module autoloading
Date: Wed, 10 Apr 2024 17:25:34 +0200
Message-Id: <20240410152534.190326-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so this module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index ead2200f39ba..080d091e28ac 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -765,6 +765,7 @@ static const struct of_device_id cmdq_of_ids[] = {
 	{.compatible = "mediatek,mt8195-gce", .data = (void *)&gce_plat_mt8195},
 	{}
 };
+MODULE_DEVICE_TABLE(of, cmdq_of_ids);
 
 static struct platform_driver cmdq_drv = {
 	.probe = cmdq_probe,
-- 
2.34.1


