Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E74803824
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjLDPBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjLDPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:01:35 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1244019D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:01:17 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so2824586f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 07:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701702075; x=1702306875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rgPZ+DR5mOzYLGtfqsPsf+e7PodlJSuSHyTq0J18X8Y=;
        b=am3RUfuegii5eVDUogJSe9RmdsFDrDrl4YqMzob2mdguA2g3vpev/h3sdDeLuixDRv
         imYHr7d5rucfotQFobCmX97Dy09HypZ5bgU81R6AmeOIVlOb1wzlEgtQg8G270UZBiUQ
         Ub/zLZkotRp/BdITm7RAUYdS2GDFWbsKo96CLcEvraaAoxNXzafADZ1Cut9KIZgbj1gf
         fAxo5BcKDBT7lr/h1+bAjbW3HRC3WjnR++O7OuTfL98vLTkavyoJ3a8XsPhdw2jb7fbe
         m+5j60B30nlzbvR16/lDXrPohFsmKNyyxtzXo6JJuVMQfPGfqhxFV03msAWp7oT45sdX
         ZUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701702075; x=1702306875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgPZ+DR5mOzYLGtfqsPsf+e7PodlJSuSHyTq0J18X8Y=;
        b=EruxHaG1YHvJ3l2jf7644sIFnNTZZXyUE0CO90lpshonKuA9vUrtaKKa3CwE/fbOQo
         EcONTWzDT8/fkgvEVlT2Rj7OP0OMm6Wi5eXEUbY1V6WDeySqGKTtktT+sEJuJa1w1CIy
         /MvyA56UY+VkVB39LUoPh6fjADZkTy2pZWSSUF3mUTadMYMjIIGViTWYvBDHbkNguGG0
         hNBN58fsDh6pwp61hQHBHiFW4lOZp1DbCpFJdywCsmye7eZQhgc60+bc4UQN3W0mYjeB
         Fy2yTDDNYmM4g/hSfkqQCUIzhpED3KKlqRpt5DbNMhJaz3ZhidujEGf5+LL0P9S3ErYp
         hC2Q==
X-Gm-Message-State: AOJu0YwZXKk1eqYQ3c1vzo5t4UAOYJrLB0B5SURaYkCM+w08JtOlJp2W
        0kfwB36VQGJmaEc06PaO97MA7A==
X-Google-Smtp-Source: AGHT+IHndVOnjS3Y47LWvFlJNubIK9E7wyJATVUdtJdZPOwFT1dYTgdG9daJCwr143p89FRQ07EVSg==
X-Received: by 2002:adf:a4cf:0:b0:333:153f:3835 with SMTP id h15-20020adfa4cf000000b00333153f3835mr3278262wrb.7.1701702075390;
        Mon, 04 Dec 2023 07:01:15 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id cm4-20020a5d5f44000000b003334a0513dbsm2968326wrb.67.2023.12.04.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:01:14 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, adrian.hunter@intel.com, Avri.Altman@wdc.com,
        ulf.hansson@linaro.org, christian.loehle@arm.com
Cc:     jinpu.wang@ionos.com, axboe@kernel.dk, beanhuo@micron.com,
        yibin.ding@unisoc.com, victor.shih@genesyslogic.com.tw,
        asuk4.q@gmail.com, hkallweit1@gmail.com, yangyingliang@huawei.com,
        yebin10@huawei.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Date:   Mon,  4 Dec 2023 16:01:11 +0100
Message-Id: <20231204150111.3320071-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

