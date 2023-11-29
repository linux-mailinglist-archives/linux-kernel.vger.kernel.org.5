Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5437FD307
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjK2Jnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjK2Jnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:43:50 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3334A19BC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:43:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-33318b866a0so281244f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701251034; x=1701855834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T1IF4EMoKoPOUq5cjoQuzNxT+lqzjn3GFuQeZMTb2ac=;
        b=ae/Jy1QCozEnkfTFcJ4m5ochZuaWqgddKe5ppFGKZEIgk9Vl0cs055bMGF+xR0NbxV
         r/AQomU0l352/Og2YXVx0qW9HyjRJ4XfN0gucEQWzMoQnxaNuKWVfo4vlkBQhDH3lUHI
         VXn+19LSGpHkWElafq0rn+Xdq6sr5nmbasT2IUmlDqX52FZNQ9u5oW6fiW/DGAU4IuDH
         a5rCqs2yPckYwtQxh6UxciTf69OgHWgBcMssx4fbb3opsnoNQ3LlwpYse/OSXIa3Ig/t
         gRVTIGxGRGtBuLVHByHfe7fjb3IqQMRRiwRC7hcpwTLHDv0y4LZxN7CFjTNXWDymtA/l
         rhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251034; x=1701855834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1IF4EMoKoPOUq5cjoQuzNxT+lqzjn3GFuQeZMTb2ac=;
        b=t9T1K2OIhQZunhUpNwBOn2Am8iHWwL4Xv3n/LqjnAAtENifzbco74osFB0XqlBL545
         jL+RfYoCbJP4IGIc1ESx1DrfPhRXFGFqNcOj0S2TTsqlz9EQ0xvQB/AdauL51UPRQQyg
         U3Ck3bufyp0fzZl7vz5a8yUieH7pDTX6FABCzCX9mb+Ds8u4Yw79kvKSHCJzzuwE6MZA
         b9gad6HPXj3C7t2x1UfB0N3eS+TlU3xPFT0S/EJpap/mrUXGdMpXTfiGAQVkfMvlHs9Y
         1+ocimr/g96rWze2HV+ajdNuXx0NgJUla7oI1DL/3pmeKMPsv/+//Q82UjHdB3UnmXfr
         MtQg==
X-Gm-Message-State: AOJu0YxibO6vPhDxNOsLwCqHY8JiEWk5+KmeVlU5/hWUeKuDL9Rd7+sS
        JR/SwiPOQR5j2M3AnwGpg18Zkg==
X-Google-Smtp-Source: AGHT+IEyfuZ6mWdUot27iC+fcBeZyRod2bf2LhwQNEGtLEbgfndZhOaLny0Oi4ayeT8D1vZXBgMZOg==
X-Received: by 2002:a5d:47a4:0:b0:333:1775:76a6 with SMTP id 4-20020a5d47a4000000b00333177576a6mr1322942wrb.62.1701251034555;
        Wed, 29 Nov 2023 01:43:54 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d640c000000b00332cc7c3aaasm17494068wru.21.2023.11.29.01.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:43:53 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, CLoehle@hyperstone.com
Cc:     axboe@kernel.dk, jinpu.wang@ionos.com, beanhuo@micron.com,
        yibin.ding@unisoc.com, f.fainelli@gmail.com, asuk4.q@gmail.com,
        victor.shih@genesyslogic.com.tw, marex@denx.de,
        rafael.beims@toradex.com, robimarko@gmail.com, ricardo@foundries.io
Subject: [PATCH] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Date:   Wed, 29 Nov 2023 10:43:50 +0100
Message-Id: <20231129094350.2605322-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the eMMC SanDisk iNAND 7250 configured with HS200, requesting a
re-tune before switching to the RPMB partition would randomly cause
subsequent RPMB requests to fail with EILSEQ:
* data error -84, tigggered in __mmc_blk_ioctl_cmd()

This commit skips the retune when switching to RPMB.
Tested over several days with per minute RPMB reads.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 drivers/mmc/core/block.c  | 6 +++++-
 drivers/mmc/core/card.h   | 7 +++++++
 drivers/mmc/core/quirks.h | 7 +++++++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 152dfe593c43..9b7ba6562a3b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -860,6 +860,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				return ret;
 		}
 		mmc_retune_pause(card->host);
+
+		/* Do not force retune before RPMB switch */
+		if (mmc_can_retune(card->host) &&
+		    mmc_card_broken_rpmb_retune(card))
+			card->host->need_retune = 0;
 	}

 	return ret;
@@ -3143,4 +3148,3 @@ module_exit(mmc_blk_exit);

 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
-
diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index b7754a1b8d97..1e1555a15de9 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -85,6 +85,7 @@ struct mmc_fixup {
 #define CID_MANFID_MICRON       0x13
 #define CID_MANFID_SAMSUNG      0x15
 #define CID_MANFID_APACER       0x27
+#define CID_MANFID_SANDISK2     0x45
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
 #define CID_MANFID_KINGSTON_SD	0x9F
@@ -284,4 +285,10 @@ static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
 {
 	return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
 }
+
+static inline int mmc_card_broken_rpmb_retune(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_RPMB_RETUNE;
+}
+
 #endif
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index cca71867bc4a..35dfc8437d29 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -130,6 +130,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
 		  MMC_QUIRK_BROKEN_SD_DISCARD),

+	/*
+	 * SanDisk iNAND 7250 DDG4064, this quirk shall disable the retune
+	 * operation enforced by default when switching to RPMB.
+	 */
+	MMC_FIXUP("DG4064", CIF_MANFID_SANDISK2, 0x100, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_RPMB_RETUNE),
+
 	END_FIXUP
 };

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 7b12eebc5586..bd6986189e8b 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -296,6 +296,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD discard support */
 #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
+#define MMC_QUIRK_BROKEN_RPMB_RETUNE	(1<<17) /* Don't force a retune before switching to RPMB */

 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
--
2.34.1
