Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340147EEF5B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbjKQJzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345792AbjKQJzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:55:45 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E7CAD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:55:40 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b2f2b9a176so1150972b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700214940; x=1700819740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVxZf23b1Ct7o+eXshFFzhsxx/lGHOCTi79IGHMkXx0=;
        b=HvjmH9YB1flnKNNecqmYkeKh651TGhD//rnTlS33lbAhZyK4T4v+9l/VHHCYsPLAzp
         wtKD836fo+IHMCMbCb5zAhgnUPpvfHYouplNL373KZycjPg2Nk3KOFI7+M9l/EwJloz0
         mQO6nkRGJ5C2wyvoM2INoijB0ZVWnUCUgx5m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700214940; x=1700819740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVxZf23b1Ct7o+eXshFFzhsxx/lGHOCTi79IGHMkXx0=;
        b=o+t1P6Na564xzi3CwOpWyEtudAMG1hq0J1mDI3f060BkOKaRBhXrbec57TPtNMSbER
         cqjz7bmzeJ1lHYjrh/RA4RGXz/nsR4WyGWygcsj0RgQRKuSyHlk1ffNzxsepYRIyTxxU
         Rsfgk6JT0DsnQCYv5z+fyqHtqzFU2fUr5kJ8b91n0RCH0E5rPFDl+2NBc55lvwkBONDe
         twmynvX4zpmEhDRYbGSqDG2jdot3n+tkxHdXTPC/aGqydvxQ4hpOOV7waRQNp+GD5KT+
         LS6xOCxmn8uxOn67rwQ0QKL9paqisk8bx0lz7rxIZiUwfoNZLhp/kM1YQjG2CQ+2XRzn
         e0aQ==
X-Gm-Message-State: AOJu0YzipIjP+hMOyUCH3ZXde27+7QazTtoRvf8PQmshhJRUcp7pYTl6
        z2uXCQhC+etGa6SJquqUlBylZw==
X-Google-Smtp-Source: AGHT+IGOoFsqpjvXqjYKjizRulc4FsjuAYO96rTyTzI2mMyXw6i0NLkFJfJqGRhBvGABhCMn+fGMVg==
X-Received: by 2002:a05:6808:1388:b0:3ad:fdfb:d384 with SMTP id c8-20020a056808138800b003adfdfbd384mr23689636oiw.53.1700214939883;
        Fri, 17 Nov 2023 01:55:39 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:900:4eaa:9148:bc32])
        by smtp.gmail.com with ESMTPSA id d18-20020a63ed12000000b005b458aa0541sm1038673pgi.15.2023.11.17.01.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:55:39 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        ot_shunxi.zhang@mediatek.corp-partner.google.com,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] mmc: mtk-sd: Increase the verbosity of msdc_track_cmd_data
Date:   Fri, 17 Nov 2023 17:55:04 +0800
Message-ID: <20231117095531.1693753-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This log message is necessary for debugging, so enable it by default to
debug issues that are hard to reproduce locally.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 97f7c3d4be6e..4469003f571e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1150,7 +1150,7 @@ static void msdc_recheck_sdio_irq(struct msdc_host *host)
 static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_command *cmd)
 {
 	if (host->error)
-		dev_dbg(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
+		dev_err(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
 			__func__, cmd->opcode, cmd->arg, host->error);
 }
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

