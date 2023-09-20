Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3447A8CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjITT3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjITT27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:28:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09217D9;
        Wed, 20 Sep 2023 12:28:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c012232792so2901491fa.0;
        Wed, 20 Sep 2023 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238127; x=1695842927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TA5e5G5EPvnnL49j/b8nNcZDnZYJMuuDQgONa21D59s=;
        b=HVTKD1PAZTSKPtyVTWjufOWJMa9K4lX7qwOMsIF7NIOSM8Detpe1AejJOFkMO2PWJ5
         fDIk4DQWjDKhP/JOrJrLjo/7ZQP7Mc9OICb1YVPdlBwXrB4WJ5EOmChD6TYL1nUxK2aT
         XtaLOPl6CT+P2FfG2vUAV9Uk6YyxRQvhHXxAiB999nvXMu0/+Q/YdiJ1jAb2vXFJPE4A
         Zob0Y+YndTxFSqzrVRDqFLHHg8OrGsrXAbvABAPaF8zt9/TenjN9WeFPj4DFLmwuCcRF
         hq66PcrB+aK0lEAYRkb9t6cqAoI0v4qKHjVtXQVeTtNROR0kA78eMAv/5r448V/VzzEu
         lv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238127; x=1695842927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TA5e5G5EPvnnL49j/b8nNcZDnZYJMuuDQgONa21D59s=;
        b=xHMW3lJcnzHhdkWYpyNdnip3H+FAvfOS/F4hTOcWYHFNER9E7m9MZx2KpX9eHwnjK6
         cIc2wy4kP7K23XEZb3LUB9roZrWW0whGyYB+YRV9J9mw8Pqjq5l/KiokYkoTIgZ+xhu3
         PkhzrSFgI1Jo9Um5snlHgzjFMW8WCK+f709ZmIVXjUPl3DqMX0mrzcIiHhMwiOC4Ydil
         hzr3j+3iUP3AM83H6KFWoXYReRnK2tGPghQswU0lWDzGnhIn+cd1794OVFVBYu26jf8U
         70yG9xVTV9yuZwhafFGHw4Vmy61SeoFVHtcjIfHpX26O9+rLyP5y4LXf7hBkpxTgzUXY
         gSeg==
X-Gm-Message-State: AOJu0Yx24Rc17SJFk11WQ9gArhgM/wBaDBm3yhhPnBDSFNH4B44rparI
        BoIUbh19KrIO/Z1J7E6fTss=
X-Google-Smtp-Source: AGHT+IFZDSF5zoq/W8jvFfDRKCF1KokOy7dJYucnqgvUrulEP8IaDlgpjwEqAHOhtU+vPGMtXh3DmA==
X-Received: by 2002:a05:6512:104f:b0:503:364e:96ce with SMTP id c15-20020a056512104f00b00503364e96cemr3532656lfb.29.1695238126987;
        Wed, 20 Sep 2023 12:28:46 -0700 (PDT)
Received: from localhost ([178.176.85.138])
        by smtp.gmail.com with ESMTPSA id j26-20020a19f51a000000b004ff973cb14esm739436lfb.108.2023.09.20.12.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:45 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/18] EDAC/synopsys: Parse ADDRMAP[0] CSR for multi-ranks case only
Date:   Wed, 20 Sep 2023 22:26:53 +0300
Message-ID: <20230920192806.29960-9-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADDRMAP[0] CSR contains the SDRAM Rank bits mapping (and memory
channel mapping but it's irrelevant in this case). Obviously they are
applicable for the multi-ranked memory only. If either the attached memory
isn't multi-ranked or the controller simply doesn't support the multi-rank
memory, parsing the ADDRMAP[0] CSR will be not just pointless, but in the
later case erroneous since the CSR fields will contain zeros which will be
perceived by the mapping detection procedure as a valid value. So the
mapping will get to be invalid. Thus make sure the ADDRMAP[0] register is
parsed only if a multi-ranked memory setup has been detected.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 5a06038aedcb..e6288e135480 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1146,9 +1146,12 @@ static void snps_setup_bg_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 
 static void snps_setup_rank_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
-	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
-				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
-				RANK_MAX_VAL_MASK) + RANK_B0_BASE);
+	/* Ranks mapping is unavailable for the single-ranked memory */
+	if (priv->info.ranks > 1) {
+		priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
+					RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
+					RANK_MAX_VAL_MASK) + RANK_B0_BASE);
+	}
 }
 
 /**
-- 
2.41.0

