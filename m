Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BC3790866
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 17:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjIBPWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjIBPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:22:21 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF39E8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:22:18 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id cSRzqoXOCUaEwcSRzqaRzL; Sat, 02 Sep 2023 17:22:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693668136;
        bh=yjDI6etd+k4oOa2FG7xcDg5/IuMHAnQLiXRlOSm4IIo=;
        h=From:To:Cc:Subject:Date;
        b=L6KSI2Id8suQcDx8BCJvdaSOTHrmcA/V6FokPsR/KDUblTLpNEasdMOhZMotfdGzG
         J9yZTCOflaCm/lsUzAeVLcwvSNRTIE1vMcV+2fHEfVPDgFvA5QkK50NFoox9lysS/t
         iz4SOVG1VnXJyuy1i0tNimLk4uuO8OH+UCGVlpOlk8F4if0egol/sRZ/jRtzx6BmFh
         D8DougwFq+Tmvgz58J0yyEk+GBcbkfsVbbXlh408B80kBcjBzpIi2QETTTwNfqaPlO
         QIjgwPI6+35FmBW4VIFkdc0+r/wNYB0uWYwO1NNLH8eVGPkSPzYNmsw0s831ivbM9O
         8jrQz+2Or4VtQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Sep 2023 17:22:16 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, mperttunen@nvidia.com, airlied@gmail.com,
        daniel@ffwll.ch, jonathanh@nvidia.com, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/6] drm/tegra: Fix some error handling paths
Date:   Sat,  2 Sep 2023 17:22:07 +0200
Message-Id: <cover.1693667005.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the patches are retated to tegra_output_probe() and missing
tegra_output_remove(). Others are things spotted while writting the serie.


Patches 1, 3, 4 are verbose, but some functions called in the probe can
return -EPROBE_DEFER, so it is nice to correctly release resources.

Maybe moving the tegra_output_probe() call would minimize the changes, but I'm
always reluctant to move code, because of possible side-effects.


Christophe JAILLET (6):
  drm/tegra: dsi: Fix some error handling paths in tegra_dsi_probe()
  drm/tegra: dsi: Fix missing pm_runtime_disable() in the error handling
    path of tegra_dsi_probe()
  drm/tegra: dsi: Fix some error handling paths in tegra_hdmi_probe()
  drm/tegra: rgb: Fix some error handling paths in tegra_dc_rgb_probe()
  drm/tegra: rgb: Fix missing clk_put() in the error handling paths of
    tegra_dc_rgb_probe()
  drm/tegra: output: Fix missing i2c_put_adapter() in the error handling
    paths of tegra_output_probe()

 drivers/gpu/drm/tegra/dsi.c    | 55 ++++++++++++++++++++++------------
 drivers/gpu/drm/tegra/hdmi.c   | 20 ++++++++-----
 drivers/gpu/drm/tegra/output.c | 16 +++++++---
 drivers/gpu/drm/tegra/rgb.c    | 18 +++++++----
 4 files changed, 74 insertions(+), 35 deletions(-)

-- 
2.34.1

