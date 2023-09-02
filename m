Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D5E79086E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjIBPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjIBPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:22:32 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5567F100
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:22:29 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id cSRzqoXOCUaEwcSSBqaS0o; Sat, 02 Sep 2023 17:22:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693668148;
        bh=CcJIylx4XWMH4i7v7yeGHjUJhvGVgKvnNJDrOuGdvbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bV5n2JhbrP+dnNHvPqRj7xIc7xk8nYL0d3ORcvjfuJUcm/aJAnFjARdnxFau3J1LI
         apG7Baj8mgHspXAEcJHsT707PzwGGjS7C2XJcVIG9uIWCa7IoSjRwbD0k/lTU/4ZFf
         VKE1pOGrzh8ZGS+tOxjNur0CFosUloL6Do4Z6FgL99d3FjLxTPz6nVrw083gcUkVzC
         2HWW5JKLxuzvgcrrQ5OyyKTEtXmQbA72Zh/ABhjC8OohvC1KJmqg0Tu8zHA2Kc5Fb8
         v3aZ1zed/PlcHe8T20E1GQyx7MQDSIeLjTiLTjKOQsXLck9dQ6vlvNBWLCLZkq46MS
         8/YJ2NVIZY/mA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Sep 2023 17:22:28 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, mperttunen@nvidia.com, airlied@gmail.com,
        daniel@ffwll.ch, jonathanh@nvidia.com, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/6] drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling path of tegra_dsi_probe()
Date:   Sat,  2 Sep 2023 17:22:09 +0200
Message-Id: <ee4a15c9cd4b574a55cd67c30d2411239ba2cee9.1693667005.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693667005.git.christophe.jaillet@wanadoo.fr>
References: <cover.1693667005.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after calling pm_runtime_enable(), pm_runtime_disable()
should be called as already done in the remove function.

Fixes: ef8187d75265 ("drm/tegra: dsi: Implement runtime PM")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/tegra/dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 70a77c75bfe1..0cf379e20d89 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1672,6 +1672,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	return 0;
 
 unregister:
+	pm_runtime_disable(&pdev->dev);
 	mipi_dsi_host_unregister(&dsi->host);
 mipi_free:
 	tegra_mipi_free(dsi->mipi);
-- 
2.34.1

