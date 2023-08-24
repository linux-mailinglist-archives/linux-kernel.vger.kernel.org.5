Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B431A786CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbjHXKmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239488AbjHXKmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:42:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B682A19A2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:41:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc83a96067so41421375ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692873719; x=1693478519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11OMDqVoPHj88ZJ2JJBotRCN1O2u/mKSOXzwJ5mYolk=;
        b=TLRyytcCKZ5pvPqDgKQrJygb5/3SMgG9GDYdNw6z2HnL81D20CEDAFstplAijFbP4k
         bxJu/nxU4QI51JcqgWn43/7+qNZd/RWjEAJgvnKSJyZDLYhX0C6TLk9CFt4gHcJiokv8
         /EnejQ+0+FfhONT74+rGUVytbINgjc8WfJPD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692873719; x=1693478519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11OMDqVoPHj88ZJ2JJBotRCN1O2u/mKSOXzwJ5mYolk=;
        b=DlLDrH2twFJenV3yJ139zvIgRE7G7w9TFf0YPN3Fhc3LvefOkPpCk5V3ddL7sGm825
         p8RrmWvrfS4TVVWUDwjseGUeHPCl92vVgDkcmxs8xc3wv2taF2wHtaRP04kPP5H7nD8H
         iAslXvfwiW5PQju7lHqOgbkm9rpUhufUZSxrZwbD2K2+k34ydrb6w2Zb9zTYDrmk4MWZ
         qPh6Gu/+KAL/22J22N738yyxYmKTs3HoQv4fE9FSlwLC+QrBvq2s5YuHlzQkwvS2VGL/
         +oO+ae1HhLLPuFNAMOAcrHzhw0jbJ3SDQgGwURVoxnGxZ+QbKe1Z3d5DgWoxWAnn2Aj6
         6hng==
X-Gm-Message-State: AOJu0YzV+F0po+vLsfoYaB6B+BYE89OyCHbKxlhem8vcpAU97LX2WoRG
        gPKSqbEXUI9WJDfQcVAivOSjuQ==
X-Google-Smtp-Source: AGHT+IEjXqoNHLwL9K3+kgYdZSexg1MmfuqiBw8xGh1DzEWiwriMgsY3wjC8rJhHLSB9/+0if9QOXA==
X-Received: by 2002:a17:903:1c4:b0:1bb:b91b:2b3c with SMTP id e4-20020a17090301c400b001bbb91b2b3cmr14732522plh.34.1692873719205;
        Thu, 24 Aug 2023 03:41:59 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:ed6d:42e3:a23:8316])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902dac200b001b5247cac3dsm12524645plx.110.2023.08.24.03.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:41:58 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, Fei Shao <fshao@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] spmi: mtk-pmif: Reorder driver remove sequence
Date:   Thu, 24 Aug 2023 18:40:10 +0800
Message-ID: <20230824104101.4083400-4-fshao@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824104101.4083400-1-fshao@chromium.org>
References: <20230824104101.4083400-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver enables clocks and then adds SPMI controller in probing, so
we expect the reversed sequence in removal.
Fix the order in the remove callback.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/spmi/spmi-mtk-pmif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index eb909a6e3b9e..2127bbd2f856 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -503,9 +503,9 @@ static void mtk_spmi_remove(struct platform_device *pdev)
 	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
 	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
 
+	spmi_controller_remove(ctrl);
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
 	clk_bulk_put(arb->nclks, arb->clks);
-	spmi_controller_remove(ctrl);
 }
 
 static const struct of_device_id mtk_spmi_match_table[] = {
-- 
2.42.0.rc1.204.g551eb34607-goog

