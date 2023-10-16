Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E6B7CB6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjJPXBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjJPXBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:01:12 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEAEE1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:01:04 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9a6399cf78so4325201276.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697497264; x=1698102064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2IYm2IJHgZqgLhrQSi41vFLt6AS98aZ4cbdFPTivNc=;
        b=nW0U2rnzzGhOKakpKdXG0aNsSwKl34/D3c0Pt1N0UC65832TFzgDqp5dnchRejVLKF
         iccDaD3U5bsqg8DNz3XIUx52fuGepN9TNBOApo9OphtfL4WpNntfGH5aT0m4KWmn4uZR
         0cd6HloELGbA2YM+K4GjchYAsHUge9Cgh+fiEMVQXs8vRSHzqetH9tbfjne5MzFz0QB5
         U5IvJUkGS/eecxq8mPGzdDlPWW9XycFZ7SnCNoTJQE/GiRquOZtG7jj+g2uWPwSZ2nzy
         O83KHJ+7s1tV9CiJtZ0wAOoAzMmwjtzctb+TNVuD19DIQh+vbsf05DKDYL66t7+QTDqT
         KBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697497264; x=1698102064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2IYm2IJHgZqgLhrQSi41vFLt6AS98aZ4cbdFPTivNc=;
        b=YyPuO+OS2RdfhR23n7EYsZDIGEmP4Eyty2W7MWYin/TgUScp3xORdRWyOHRPp9x4Pl
         3WBYqQowHmwTQLkbsRzY4oCF2v9GWIgYLZaUgDFjMDxWC6rDzsonv0yLwjVGN/u6cZxG
         gV11JftihvPaNDU2mPtkmCitFl66YsnGNRcX7n1SKLdJQgMt+t0v+sBhNv3Q7dn8k4Be
         nFFKrNOZxw3Lvz1Um4y4K12dEyuffFnVFqVkKac7jd8MAgU3cYpiCdB/IMF/NRGyXYke
         btw4OnfldB8Q7/4+mYBoryiXAfx0XXxOEZdFQZLyQ1O9/y1TmSkN0JPIWEOy60xziz1u
         i3FQ==
X-Gm-Message-State: AOJu0YxNYR1e/bcOfHU0ddLMiSWBvPyyw6oj7YbTWVW6qt3KjGT2vYIp
        mOfDFYfliZrlEfHq+XbQLTph/XOzate/pUObcfM=
X-Google-Smtp-Source: AGHT+IG4ayR7mON0S7ILkqhGHB6oE0NjhKErUM+Z2bQdBiIEjCzb3eKC3mvznAWPh9EghWnobNp3ew==
X-Received: by 2002:a25:9004:0:b0:d9a:45e7:c7f1 with SMTP id s4-20020a259004000000b00d9a45e7c7f1mr105065ybl.30.1697497263716;
        Mon, 16 Oct 2023 16:01:03 -0700 (PDT)
Received: from gilbert-PC ([105.112.31.148])
        by smtp.gmail.com with ESMTPSA id 5-20020a250905000000b00d9b33e0b952sm58047ybj.8.2023.10.16.16.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 16:01:03 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 3/4] staging: vt6655: Rename variable byCurPwr
Date:   Mon, 16 Oct 2023 23:58:56 +0100
Message-Id: <4c24962988ac990ae21c95e4a1754cfabfd2db8d.1697495598.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697495597.git.gilbertadikankwu@gmail.com>
References: <cover.1697495597.git.gilbertadikankwu@gmail.com>
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

Remove byte Type encoding "by" from variable name and replace camelcase
with snakecase

Mute checkpatch.pl error:

CHECK: Avoid CamelCase: <byCurPwr>

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/vt6655/channel.c     | 4 ++--
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 2 +-
 drivers/staging/vt6655/rf.c          | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index 7b864136a0a8..771c1364b0f0 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -118,9 +118,9 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 		/* set HW default power register */
 		VT6655_MAC_SELECT_PAGE1(priv->port_offset);
 		RFbSetPower(priv, RATE_1M, priv->current_ch);
-		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWRCCK);
+		iowrite8(priv->cur_pwr, priv->port_offset + MAC_REG_PWRCCK);
 		RFbSetPower(priv, RATE_6M, priv->current_ch);
-		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWROFDM);
+		iowrite8(priv->cur_pwr, priv->port_offset + MAC_REG_PWROFDM);
 		VT6655_MAC_SELECT_PAGE0(priv->port_offset);
 
 		spin_unlock_irqrestore(&priv->lock, flags);
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index b3ac6237010b..6df1694d556b 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -264,7 +264,7 @@ struct vnt_private {
 	/* For RF Power table */
 	unsigned char byCCKPwr;
 	unsigned char byOFDMPwrG;
-	unsigned char byCurPwr;
+	unsigned char cur_pwr;
 	char	 byCurPwrdBm;
 	unsigned char abyCCKPwrTbl[CB_MAX_CHANNEL_24G + 1];
 	unsigned char abyOFDMPwrTbl[CB_MAX_CHANNEL + 1];
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index b654fc24d725..2152c6850e61 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -359,7 +359,7 @@ static void device_init_registers(struct vnt_private *priv)
 	RFbInit(priv);
 
 	/* Get Desire Power Value */
-	priv->byCurPwr = 0xFF;
+	priv->cur_pwr = 0xFF;
 	priv->byCCKPwr = SROMbyReadEmbedded(priv->port_offset, EEP_OFS_PWR_CCK);
 	priv->byOFDMPwrG = SROMbyReadEmbedded(priv->port_offset,
 					      EEP_OFS_PWR_OFDMG);
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index bf9a10563b12..d319ec21c97b 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -438,12 +438,12 @@ bool RFbSetPower(struct vnt_private *priv, unsigned int rate, u16 uCH)
 		break;
 	}
 
-	if (priv->byCurPwr == byPwr)
+	if (priv->cur_pwr == byPwr)
 		return true;
 
 	ret = RFbRawSetPower(priv, byPwr, rate);
 	if (ret)
-		priv->byCurPwr = byPwr;
+		priv->cur_pwr = byPwr;
 
 	return ret;
 }
-- 
2.34.1

