Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DE07F6032
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbjKWN1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345464AbjKWN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:27:43 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D0F9A;
        Thu, 23 Nov 2023 05:27:49 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507b9408c61so1159580e87.0;
        Thu, 23 Nov 2023 05:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700746067; x=1701350867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kIaXLjCHkUTAIQFu51DPbKbv3RKHWgAAWQUBqR3AlJg=;
        b=SftnxtIJvMpOM2NOYta5KFSDGMuIdrgqte5PIYc1hqpo5Tz8HUs6tC6nmS39HSkg/d
         qu/llnIgm3lIx/DLvBTm0cA/HZepdIAc9AnDEmtaWfZFvPICBKIx8d5mbk2FFcsL1V4k
         orc7pUw2frDZtgWvRvFslZfiWUd2QJaK2KbG/Vo4f6/YXfwGBscqQR40aMp8KPnBmv93
         nEJXZXluV6P2jEGr8OXwGBNDh8W1KRfbq4nPswC7COa73Rtr4UWWfm7F7jkHVQrA4tzz
         SaP+LeWgqxTU51wTg1gg/0UHDVgjCU+GNJUdmI6hgbt0w7IYNKbk4b/IzpDkHNt5QTv4
         4QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746067; x=1701350867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIaXLjCHkUTAIQFu51DPbKbv3RKHWgAAWQUBqR3AlJg=;
        b=Ft2QwNk+D9FD4HfF1TFB36AYzr4Uzlm/4yxCxgke5jELuaIAkv8HmfAfGAr55o+WAE
         CZQCPWq/kL3TYQ+Tqzunqne39+UmupPkxENu+UPmCSTFJ/kat9a22k6Gsz3c/3DWOtYk
         hyJXDFWsChmEF7j3no0cg7fgUyaF8CR2ynXtZROdpIfHAZe5Ky51vS3eR34bRAAI4Utr
         jD6N/GA1pBYH1XvBtJd1pxXdaR4oXKxUyOZKcCOER4jKOgukw9RlJnuBA5fzxdZwOg6r
         nQKvsWGkgPpH3tWoqPvpsi86mFsHSW5EVMSw3RLayrrpT2CvGA1bGuFZ0Qs2BDnPMArV
         4Ecg==
X-Gm-Message-State: AOJu0Yyo6hyvkTWuYWBv1mWpRlB1KB/Frknj+bgyd/aY1u8ymqrD7d2u
        IH6iL9J2127lMz0eK+iV1Nn7pMTP5sKV6g==
X-Google-Smtp-Source: AGHT+IGoN/Woo6INI5guA4F/FORkWZ1i6cKKlQLnR1B29tIdXKUWXGoZy2x1ZJ8DAwqfvUKG4SuoGg==
X-Received: by 2002:a05:6512:3ca0:b0:509:4587:bdd0 with SMTP id h32-20020a0565123ca000b005094587bdd0mr5173837lfv.7.1700746067158;
        Thu, 23 Nov 2023 05:27:47 -0800 (PST)
Received: from threadripper.localdomain (89-186-112-232.pool.digikabel.hu. [89.186.112.232])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906594e00b009fc6ac28110sm783069ejr.20.2023.11.23.05.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:27:46 -0800 (PST)
From:   Heiko Schocher <heiko.schocher@gmail.com>
X-Google-Original-From: Heiko Schocher <hs@denx.de>
To:     netdev@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>, Clark Wang <xiaoning.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
Date:   Thu, 23 Nov 2023 14:27:43 +0100
Message-Id: <20231123132744.62519-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it is possible that fec1 is probed before fec0. On SoCs
with FEC_QUIRK_SINGLE_MDIO set (which means fec1 uses mii
from fec0) init of mii fails for fec1 when fec0 is not yet
probed, as fec0 setups mii bus. In this case fec_enet_mii_init
for fec1 returns with -ENODEV, and so fec1 never comes up.

Return here with -EPROBE_DEFER so interface gets later
probed again.

Found this on imx8qxp based board, using 2 ethernet interfaces,
and from time to time, fec1 interface came not up.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c3b7694a7485..d956f95e7a65 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2445,7 +2445,7 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 			mii_cnt++;
 			return 0;
 		}
-		return -ENOENT;
+		return -EPROBE_DEFER;
 	}
 
 	bus_freq = 2500000; /* 2.5MHz by default */
-- 
2.20.1

