Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511697C6A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346972AbjJLKJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjJLKIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:08:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BE7C4;
        Thu, 12 Oct 2023 03:08:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-503f39d3236so1090854e87.0;
        Thu, 12 Oct 2023 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697105320; x=1697710120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSAhxNCccBDPfEaHOYwSm94ZHYVqbuNn4mUPNvHQg0g=;
        b=gTxX+HH9CD41EJ0vfZVq6sqXUh0V3cUca9TO/iJyBUV9oD14ZTfB47ESOAUohZm7hS
         Ji/IbmgF8DIdAqhvD+PggOT9vuvuIg8kNjJXKQRkDvY0SMu0jvR4ZjYiGE0a1esM54Cu
         24mFa8jNzsIH5TwmwM3QGtmA2vX3x2Q/THH/eleQ5uklZfuwq0agMFoDBnvYSkKE9Jty
         XgBsn1Fgi2vistLqiQIWgxE8BA7SdgVL4NlQecfXhu0MxUXIS3RPND9N1QhVEjZWpsPZ
         Sy81DB2ccz9wE/UJ/8RypUT768k4nSf5C6GwcFjCPDVo1/RJLoVNIxg20InJ8DydlcH9
         sBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697105320; x=1697710120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSAhxNCccBDPfEaHOYwSm94ZHYVqbuNn4mUPNvHQg0g=;
        b=nSh4CPaJnXb+EJ0QMZnJsE1iVTCQDa59hM7BWFJywuyCloS8sPtJKDgHw8qyrSTJJu
         UOnDiEIZL1jP0v4H1TMEddZxp7Lj5f9vs3enbJHEjuJYoKg07pCP8L44f9iT+iMMp/LR
         Fqwqpg03QcVkXDljMSzUBTs2KJUJ5U5TgrcVoKAIIEgMqGimDysFAXPHahN1LQQeTcgX
         31fhSFz90TYtWo3He+OD2szOYqYqdp2+P8TW95Q3B7M7NsVhuR3AORoK/GiArgXCfJzZ
         UyiPJEd1EzfffbPyyKs614/KIj/T8pmxC4NZQaTLiDI1bGPfjknuTB/1rht+a0U51MX1
         9lHQ==
X-Gm-Message-State: AOJu0YwF4BUBbg0xTrF3D3F1HxwFCup65xW/QLzfHShgiGe+pYKvnSe0
        tExw0gq3Kzeg2hHPy0vWbbO7Z9aIomA=
X-Google-Smtp-Source: AGHT+IFS5wYVsErszFbLHXbccvljCxec7tsdB2hdb2nVZS6k8/mqAnVjAi0sisagLq6W9E03Rccilg==
X-Received: by 2002:a05:6512:210c:b0:503:36cb:5436 with SMTP id q12-20020a056512210c00b0050336cb5436mr18333699lfr.9.1697105320566;
        Thu, 12 Oct 2023 03:08:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id dj16-20020a0560000b1000b003198a9d758dsm922737wrb.78.2023.10.12.03.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:08:40 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Raju Rangoju <rajur@chelsio.com>,
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
Subject: [net-next PATCH v2 4/4] net: stmmac: increase TX coalesce timer to 5ms
Date:   Thu, 12 Oct 2023 12:04:59 +0200
Message-Id: <20231012100459.6158-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231012100459.6158-1-ansuelsmth@gmail.com>
References: <20231012100459.6158-1-ansuelsmth@gmail.com>
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
index 1e996c29043d..e3f650e88f82 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -293,7 +293,7 @@ struct stmmac_safety_stats {
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

