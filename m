Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA9A7AB048
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjIVLNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjIVLNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:13:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A6D114;
        Fri, 22 Sep 2023 04:13:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4053db20d03so6060525e9.2;
        Fri, 22 Sep 2023 04:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695381189; x=1695985989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ijlwZ6JRdK1U0SnHerxGcEJGjK9VRf4PRp/VeOrzMQ=;
        b=Ui54MJAW4B/VxxzITX2OiWb98Jy5pJ7NHhxjB+lfMtvygA44FuyaWuBSmeiVF77qR+
         P8GX72ChlT8RsA454fmSjj9RH6PMLFVmRyYhWt3xKCpAFP/hrK06HigE1MnOQSyfaU9t
         ws9sQKJuegRYhQacMuFu9YMCfGtJGeQR68VO5X3tpiJmXljCJjxjftbhSmQ0/l5TDLeU
         yA5S54fyVyDpFWi7nveLTxOo0GrJ+l/dcuWBKHx+2D42Rp+5sibILDLV9Kcz1UoU2CPN
         DkCtMUhx9p1x11JFcx22kUOY1f8oUXTceZINFfn+sujZ5CtJU05vUIP4gZuSWVUfxDRC
         syqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695381189; x=1695985989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ijlwZ6JRdK1U0SnHerxGcEJGjK9VRf4PRp/VeOrzMQ=;
        b=ITlib30bkGKJfD9QCXCBPzA5k1zJpX0bBIgokw/NyT9DL6aeaY6Usoxr2uRfIoS2nC
         Bq26EMby0mlVHIJtzw6SbUF3LqdIdbvInJ0QbqPxqWxvlM/5yOZA5ydNpcy8F9LABOId
         +AkfmGwdjs/k9TCRPPxlqHrHs7fCr77PHfUqRAQeCS8p4chPahhWxl/n98cXFy+mkxA/
         astVIYobGCISOjkpekowgftVMD03EWPyh7gUWOaOEd4NOS4fQDAyd9fglUcsgwOVFz5T
         8nJTTye30tphF8VrqIIJgXf05ojh2551iO4I3urZhw5SUsX6Iz4ED8uQWVhWqgZAwANU
         JCkQ==
X-Gm-Message-State: AOJu0YymSZd3YVRkHwbCOraqFR4unpzJwNpp24GjwRTPMxMAzIf3ZuUJ
        +MgINd11X7CtYrlKnT5RKAw=
X-Google-Smtp-Source: AGHT+IHTzusDD1Vj12nFTAofcTh5ujgUoGMSUjxYvnBVt5FrCDDmYAOQS2TIjfWAp8W6AwxsKaiBCA==
X-Received: by 2002:a05:600c:152:b0:403:cc64:2dbf with SMTP id w18-20020a05600c015200b00403cc642dbfmr7548257wmm.27.1695381188563;
        Fri, 22 Sep 2023 04:13:08 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g10-20020adffc8a000000b003176c6e87b1sm4191765wrr.81.2023.09.22.04.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:13:07 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 3/3] net: stmmac: increase TX coalesce timer to 5ms
Date:   Fri, 22 Sep 2023 13:12:47 +0200
Message-Id: <20230922111247.497-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230922111247.497-1-ansuelsmth@gmail.com>
References: <20230922111247.497-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8fce33317023 ("net: stmmac: Rework coalesce timer and fix
multi-queue races") decreased the TX coalesce timer from 40ms to 1ms.

This caused some performance regression on some target (regression was
reported at least on ipq806x) in the order of 600mbps dropping from
gigabit handling to only 200mbps.

The problem was identified in the TX timer getting armed too much time.
While this was fixed and improved in another commit, performance can be
improved even further by increasing the timer delay a bit moving from
1ms to 5ms.

The value is a good balance between battery saving by prevending too
much interrupt to be generated and permitting good performance for
internet oriented devices.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 403cb397d4d3..2d9f895c2193 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -290,7 +290,7 @@ struct stmmac_safety_stats {
 #define MIN_DMA_RIWT		0x10
 #define DEF_DMA_RIWT		0xa0
 /* Tx coalesce parameters */
-#define STMMAC_COAL_TX_TIMER	1000
+#define STMMAC_COAL_TX_TIMER	5000
 #define STMMAC_MAX_COAL_TX_TICK	100000
 #define STMMAC_TX_MAX_FRAMES	256
 #define STMMAC_TX_FRAMES	25
-- 
2.40.1

