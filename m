Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2EF803B4F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjLDRWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjLDRWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:22:43 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36383FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:22:49 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso969145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701710568; x=1702315368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kejOp9HsUmKb2Fyg4pxUOoVogVQGrKdzlwKp1qf6raE=;
        b=CZVrPPHFDdh3EVxO7zoTwkEd0K1NCu5dHnWTNKNSteqIvjJtV4ks7IeeHQsANGlRfA
         MjRRwTgPU8ZNPLu4/l18Xld8nWEk/mYxraD9++u2g7KzastEmFANeQ3nthSuUoBdQSGS
         6ccpr+49O6WpXYq5vJLD5JhMtfK+mmEkvJKEYlfAp5YtQ1l5GNr/izulwACQ+iJe6Qql
         ySx7DZvedcKGO2+wgEZ+VGMatT9VJvOmIvPSHq8QO9CHSmYTihGinBVcVBrGQ2O72QkW
         u5L0J7zFsqoMIJXQ+tT/TCkJWx8AMPTsXy7tOwfOsWsPMWdupONoJp+Ei5VvX2tU54GX
         GQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710568; x=1702315368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kejOp9HsUmKb2Fyg4pxUOoVogVQGrKdzlwKp1qf6raE=;
        b=ZZX/a9KZA7q7EGGRBTlxo2e5dk60ayANlYrAHbqmladpoz3gYV3EQoqp5CFcbw5Xnv
         8iWQdocGfxCIauVxnNNAYELW4+A15XF+uJkA8Y6eA4gJ4TGm2rlt6Fu0dNfbWOvyaNR1
         dpvspK/JzNlXA+HgN1j6ti9Jx9bwqfW3E8rZ2KkOhwYPppzTrGwamEMJWpGBb82dGspk
         Tnu9KOHo+MaTAnlL7uANEk1xIzWNvLcQ+fyzo4T/DCLCOnDLnRK49piMiioVGtRF9xLI
         oxncjyBVf0PNr0z1nfaoVcCV64GB8As1MrZTZm1dpK22OXdX/2DPRu9b+XZ2lC/DkYcz
         ZSog==
X-Gm-Message-State: AOJu0YzxzfvCXAUVOO9lIz5WJuL3VWJZfzzcopWcGOTfgHE8FMiLyonQ
        UadKAXB3g9PO1V/znTGyTlbkWA==
X-Google-Smtp-Source: AGHT+IGMuQVV0cAIwEJ+sy2ZvuNt9ylDSo6Yq8nKLvASV7aHN9hZwQfRkMuEDdmnyprEAafKuNKKRg==
X-Received: by 2002:a05:600c:2301:b0:40b:5e59:c574 with SMTP id 1-20020a05600c230100b0040b5e59c574mr2704791wmo.158.1701710567535;
        Mon, 04 Dec 2023 09:22:47 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm19413454wmq.39.2023.12.04.09.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:22:47 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, Avri.Altman@wdc.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, christian.loehle@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Date:   Mon,  4 Dec 2023 18:22:43 +0100
Message-Id: <20231204172243.3382495-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requesting a retune before switching to the RPMB partition has been
observed to cause CRC errors on the RPMB reads (-EILSEQ).

Since RPMB reads can not be retried, the clients would be directly
affected by the errors.

This commit disables the request prior to RPMB switching while allowing
the pause interface to still request a retune before the pause for other
use cases.

This was verified with the sdhci-of-arasan driver (ZynqMP) configured
for HS200 using two separate eMMC cards (DG4064 and 064GB2). In both
cases, the error was easy to reproduce triggering every few tenths of
reads.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
Acked-by: Avri Altman <avri.altman@wdc.com>

---
 drivers/mmc/core/block.c | 2 +-
 drivers/mmc/core/host.c  | 7 ++++---
 drivers/mmc/core/host.h  | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f9a5cffa64b1..1d69078ad9b2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -859,7 +859,7 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 			if (ret)
 				return ret;
 		}
-		mmc_retune_pause(card->host);
+		mmc_retune_pause(card->host, false);
 	}

 	return ret;
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 096093f7be00..a9b95aaa2235 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -119,13 +119,14 @@ void mmc_retune_enable(struct mmc_host *host)

 /*
  * Pause re-tuning for a small set of operations.  The pause begins after the
- * next command and after first doing re-tuning.
+ * next command and, if retune is set, after first doing re-tuning.
  */
-void mmc_retune_pause(struct mmc_host *host)
+void mmc_retune_pause(struct mmc_host *host, bool retune)
 {
 	if (!host->retune_paused) {
 		host->retune_paused = 1;
-		mmc_retune_needed(host);
+		if (retune)
+			mmc_retune_needed(host);
 		mmc_retune_hold(host);
 	}
 }
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 48c4952512a5..321776b52270 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -18,7 +18,7 @@ void mmc_retune_disable(struct mmc_host *host);
 void mmc_retune_hold(struct mmc_host *host);
 void mmc_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
-void mmc_retune_pause(struct mmc_host *host);
+void mmc_retune_pause(struct mmc_host *host, bool retune);
 void mmc_retune_unpause(struct mmc_host *host);

 static inline void mmc_retune_clear(struct mmc_host *host)
--
2.34.1
