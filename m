Return-Path: <linux-kernel+bounces-41694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B2883F694
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824B5282625
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548D4C618;
	Sun, 28 Jan 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMoeY4NG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785224C3BF;
	Sun, 28 Jan 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458313; cv=none; b=YXsxBoCmT+9Ya2MyNzo2aIRqUwqUEv74r9QX8PiN1TH6nZWD2kpe/pfDa3fgdD4Qa96VJ1PSIY/C923nVd7I2EcwHhWgCQzg+Ym/nAAwOru1G7AfZ8nuXtVqXkAAp+nun3sEbLSl/mbI8ehrlwr/afPMj9/ChE0qYg/m3ggZBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458313; c=relaxed/simple;
	bh=51cvES8B4cwsZRZH2wNWrxlvRklkeZm6la8scxzeXso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbOoBJnkuKvZ3CKj+tcobsjBILEG7qoave8c8yb0G1eRP4E0ae/yn+Ilm9gUAO4s5mqX4HdQHOSRn89zQqvpdksfjhbAGeWNKU9o2Wo/JCg8DHmZtYyQOun2haIQvI7qM2BU0DgNNcL92sGcASqvdG+iGy8u3u+ipdZBXv6yxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMoeY4NG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC0DC43399;
	Sun, 28 Jan 2024 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458313;
	bh=51cvES8B4cwsZRZH2wNWrxlvRklkeZm6la8scxzeXso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMoeY4NGzjEsGE5qX5o9Sr+1z6sFZ9ZCk82bqeSIz9PVS16ild8MvbfWqht5ruV3+
	 +4OrJMd1EMGO3HZMxUM0EoXbTBmSz8Ixzg/Yh9PHVC+bArdbsgEBp7Jdbu1jTzM++v
	 lR4MJ71OVrKKoDzVTZZqa6DBUxbiHTfN1IyvoRujQMpao5TTkr0468sfgg3G1GUbgV
	 CVl+olOnLce0Ff4d34paEj7rKDOSZGYhvUy1CdYUurV02czUrrV1RDIGV6M5i/rxIU
	 bH6TKyJCaZ6i/P3uOqRy6TD3bWfuCOXOayCDFUut8U0Lnwt3p+F7BieSSxIM/tZoXV
	 /Rt2HaitZwx0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu-Che Cheng <giver@chromium.org>,
	Fei Shao <fshao@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 12/39] spmi: mediatek: Fix UAF on device remove
Date: Sun, 28 Jan 2024 11:10:32 -0500
Message-ID: <20240128161130.200783-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Yu-Che Cheng <giver@chromium.org>

[ Upstream commit e821d50ab5b956ed0effa49faaf29912fd4106d9 ]

The pmif driver data that contains the clocks is allocated along with
spmi_controller.
On device remove, spmi_controller will be freed first, and then devres
, including the clocks, will be cleanup.
This leads to UAF because putting the clocks will access the clocks in
the pmif driver data, which is already freed along with spmi_controller.

This can be reproduced by enabling DEBUG_TEST_DRIVER_REMOVE and
building the kernel with KASAN.

Fix the UAF issue by using unmanaged clk_bulk_get() and putting the
clocks before freeing spmi_controller.

Reported-by: Fei Shao <fshao@chromium.org>
Signed-off-by: Yu-Che Cheng <giver@chromium.org>
Link: https://lore.kernel.org/r/20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid
Tested-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20231206231733.4031901-3-sboyd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spmi/spmi-mtk-pmif.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index b3c991e1ea40..74b73f9bc222 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -465,7 +465,7 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	for (i = 0; i < arb->nclks; i++)
 		arb->clks[i].id = pmif_clock_names[i];
 
-	err = devm_clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
+	err = clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to get clocks: %d\n", err);
 		goto err_put_ctrl;
@@ -474,7 +474,7 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	err = clk_bulk_prepare_enable(arb->nclks, arb->clks);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to enable clocks: %d\n", err);
-		goto err_put_ctrl;
+		goto err_put_clks;
 	}
 
 	ctrl->cmd = pmif_arb_cmd;
@@ -498,6 +498,8 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 
 err_domain_remove:
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
+err_put_clks:
+	clk_bulk_put(arb->nclks, arb->clks);
 err_put_ctrl:
 	spmi_controller_put(ctrl);
 	return err;
@@ -509,6 +511,7 @@ static void mtk_spmi_remove(struct platform_device *pdev)
 	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
 
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
+	clk_bulk_put(arb->nclks, arb->clks);
 	spmi_controller_remove(ctrl);
 	spmi_controller_put(ctrl);
 }
-- 
2.43.0


