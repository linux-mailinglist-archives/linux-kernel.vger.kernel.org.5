Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1FA77A925
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjHMQKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjHMQKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD6EE65;
        Sun, 13 Aug 2023 09:09:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 744BF639A9;
        Sun, 13 Aug 2023 16:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863A8C433C8;
        Sun, 13 Aug 2023 16:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942936;
        bh=/1qreqbnqCh2DLtfZLj8uyRF8WRY0FRiTTIpB7p2S+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAxmkm9byQCHIkTYJKfZdhrigGuTDk3K0pi3GHWRpHRuYwVf2NdHVyQwBVqhl0NTh
         DE2qkVtqJh2j3GvbUKIsRKcLXbPCsDJKIgJFRgmgVHwZTqQykvSySBSy148zBaPY9G
         E/g8cRg9Sjjhus3NYq92Te2G3x/4/twrvDWzKr/+XpRxAym097M5dWvc+jUin1zKuo
         R6rFpMSbTsyCOUEAWdGmuaDjYoWoCC5mmiBJ2mX4pNNzmdlk+aTjyHAky3Ha+LQfWw
         x2xhhFcw2wo8S8qxuX0QM+GBsVobhP8lIKI772zkhow0A1JK/ypRNz9ObVrqVlNhoA
         Ab5GN1G7+gRNw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Minjie Du <duminjie@vivo.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>, vireshk@kernel.org,
        linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 27/31] ata: pata_arasan_cf: Use dev_err_probe() instead dev_err() in data_xfer()
Date:   Sun, 13 Aug 2023 12:06:00 -0400
Message-Id: <20230813160605.1080385-27-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160605.1080385-1-sashal@kernel.org>
References: <20230813160605.1080385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.126
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minjie Du <duminjie@vivo.com>

[ Upstream commit 4139f992c49356391fb086c0c8ce51f66c26d623 ]

It is possible for dma_request_chan() to return EPROBE_DEFER, which
means acdev->host->dev is not ready yet. At this point dev_err() will
have no output. Use dev_err_probe() instead.

Signed-off-by: Minjie Du <duminjie@vivo.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/pata_arasan_cf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 63f39440a9b42..4ba02f082f962 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -528,7 +528,8 @@ static void data_xfer(struct work_struct *work)
 	/* dma_request_channel may sleep, so calling from process context */
 	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
 	if (IS_ERR(acdev->dma_chan)) {
-		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
+		dev_err_probe(acdev->host->dev, PTR_ERR(acdev->dma_chan),
+			      "Unable to get dma_chan\n");
 		acdev->dma_chan = NULL;
 		goto chan_request_fail;
 	}
-- 
2.40.1

