Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4488D75E62C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGXBPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGXBPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:15:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9328C10F6;
        Sun, 23 Jul 2023 18:15:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA5560F0A;
        Mon, 24 Jul 2023 01:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC69C433C8;
        Mon, 24 Jul 2023 01:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161308;
        bh=U1z3VtG0pGPvExFdvOAtlP5ooExECdMsVdDb35dBOsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xn3DDn/Caje5nwwGD7glM8v4wnJVReHguZQXHjCp+xXniTaIGleLoO8IetAYChgl2
         D13LW4/H9SoGPNwc4ReX4JGlFBu1DAfIsrE7forGTZFd2pPYzG02K3a7sBOX3AU5ug
         NELPmb+91VFAHFiZwH+lvYuQS3wVG1hDG1UDS9JsfD1WtyK0eiWL0jWhCKkTzCUmIM
         rsofGCL+hXarbaq4qIIQaw2QoUE/vl0eoQLMZBSL+DCW2zqZHY3owrVyNKZ+LKtsLj
         DDb7UDh9MnAWJZh3xvsbkha1VbmNOOmDqlkRoxxZfXSCL5CIxtlGJpBdRWlFzDPjP5
         nhlXKDfE5tUaw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 19/58] ASoC: amd: vangogh: Add check for acp config flags in vangogh platform
Date:   Sun, 23 Jul 2023 21:12:47 -0400
Message-Id: <20230724011338.2298062-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>

[ Upstream commit e89f45edb747ed88e97a5771dd6d3dd1eb517873 ]

We have SOF and generic ACP support enabled for Vangogh platform
on some machines. Since we have same PCI id used for probing,
add check for machine configuration flag to avoid conflict with
newer pci drivers. Such machine flag has been initialized via
dmi match on few Vangogh based machines. If no flag is
specified probe and register older platform device.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Link: https://lore.kernel.org/r/20230530110802.674939-1-venkataprasad.potturu@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/vangogh/acp5x.h     | 2 ++
 sound/soc/amd/vangogh/pci-acp5x.c | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index bd9f1c5684d17..ac1936a8c43ff 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -147,6 +147,8 @@ static inline void acp_writel(u32 val, void __iomem *base_addr)
 	writel(val, base_addr - ACP5x_PHY_BASE_ADDRESS);
 }
 
+int snd_amd_acp_find_config(struct pci_dev *pci);
+
 static inline u64 acp_get_byte_count(struct i2s_stream_instance *rtd,
 				     int direction)
 {
diff --git a/sound/soc/amd/vangogh/pci-acp5x.c b/sound/soc/amd/vangogh/pci-acp5x.c
index e0df17c88e8e0..c4634a8a17cdc 100644
--- a/sound/soc/amd/vangogh/pci-acp5x.c
+++ b/sound/soc/amd/vangogh/pci-acp5x.c
@@ -125,10 +125,15 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 {
 	struct acp5x_dev_data *adata;
 	struct platform_device_info pdevinfo[ACP5x_DEVS];
-	unsigned int irqflags;
+	unsigned int irqflags, flag;
 	int ret, i;
 	u32 addr, val;
 
+	/* Return if acp config flag is defined */
+	flag = snd_amd_acp_find_config(pci);
+	if (flag)
+		return -ENODEV;
+
 	irqflags = IRQF_SHARED;
 	if (pci->revision != 0x50)
 		return -ENODEV;
-- 
2.39.2

