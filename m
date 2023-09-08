Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BBF798245
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbjIHGVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238621AbjIHGVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:21:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3486619AE;
        Thu,  7 Sep 2023 23:21:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1c0a4333e03so3964935ad.0;
        Thu, 07 Sep 2023 23:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694154085; x=1694758885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1CF4SZe+j+A2vmx7gVT8aOLdHeQoN2UL8CkT5LKTRQ=;
        b=PK0+LWJ2c7FX+dS9YSV2wcADaZuhgctmF9WZeLx+SiqaDJtraSkockHzZynuaGfvHk
         Ms7zuKLFYgDk4UOzEyB+JP5uBO/NdV13zeD5UPErXgEztXqa54qrYhWIn5FJqR/RgzfI
         ex0Nj5dt83gtAiXeoMnNgCrauEoLeJ/sCGKKLJeTBF9BzXsA/kb0ebLUdNKAJbcmN06K
         NnzeNCvNCiJ4RKCuN+lFNmV/e7np1Fnf3YyU0wAS2I/jqFbYiGIurhdFXi31sdwL4wwN
         xEmQLXNdhYc38amnJx34udGFKm4MhSJPoRDYElu6GHpratnoqrf+mgT3+gEzZmfQpk6j
         JC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694154085; x=1694758885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1CF4SZe+j+A2vmx7gVT8aOLdHeQoN2UL8CkT5LKTRQ=;
        b=S39XlKXEfr6K0iSnirrNoldUKPs2agTWrloUn+neo+HuRIWf4ywP5uFFPB0Vctx6wi
         HE51xO4jw5Jmbeoy8uC86a2yGfLb530Grd2SH6JmoK2xKCDUWavQsVQPTnnGPWPN2e+2
         3eTGLzfIEk7+ZEawapPu0idZkOesx5jf2x1/yYoab/qZsSw22N+yGVTwcGwRf0I7uL74
         g5dyl6Xs+I6YaYQwKe5Yzzjb+pfiD+Z1ZAaXSVPSe80hjN60LTPoC5uBf2mB+0IWpQYf
         cj2Gr0qE9/5z3r0MvMP/Jm/e1cIegkOCo2ub8wOry2fOwTfQasGF5zieQQSNSyk7Itt8
         Du5Q==
X-Gm-Message-State: AOJu0YxFParytoTSsOpKSY39KPf94oVsQrNt5L5Yvh32GuihjXfc4Sln
        s3JCT86LxhSp2Roia06eLZk=
X-Google-Smtp-Source: AGHT+IGST1hBLOHOHypmYgCJUMet9wuRE7B4sVnLN++DfxZqbuc1JkMedwhmLrS+9e0Rre5bDpEsow==
X-Received: by 2002:a17:902:e54b:b0:1bb:d7d4:e2b with SMTP id n11-20020a170902e54b00b001bbd7d40e2bmr1895198plf.0.1694154085658;
        Thu, 07 Sep 2023 23:21:25 -0700 (PDT)
Received: from hbh25y.mshome.net ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001b8c6890623sm768620plg.7.2023.09.07.23.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 23:21:24 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     justin.chen@broadcom.com, florian.fainelli@broadcom.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mw@semihalf.com, linux@armlinux.org.uk,
        nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        maxime.chevallier@bootlin.com, nelson.chang@mediatek.com
Cc:     bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2 1/3] net: ethernet: bcmasp: fix possible OOB write in bcmasp_netfilt_get_all_active()
Date:   Fri,  8 Sep 2023 14:19:48 +0800
Message-Id: <20230908061950.20287-2-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908061950.20287-1-hbh25y@gmail.com>
References: <20230908061950.20287-1-hbh25y@gmail.com>
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

rule_locs is allocated in ethtool_get_rxnfc and the size is determined by
rule_cnt from user space. So rule_cnt needs to be check before using
rule_locs to avoid OOB writing or NULL pointer dereference.

Fixes: c5d511c49587 ("net: bcmasp: Add support for wake on net filters")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---

	v2: use -EMSGSIZE instead of truncating the list sliently.

 drivers/net/ethernet/broadcom/asp2/bcmasp.c         | 9 +++++++--
 drivers/net/ethernet/broadcom/asp2/bcmasp.h         | 4 ++--
 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c | 2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index d63d321f3e7b..e45e0ae932cc 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -528,13 +528,16 @@ void bcmasp_netfilt_suspend(struct bcmasp_intf *intf)
 				  ASP_RX_FILTER_BLK_CTRL);
 }
 
-void bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
-				   u32 *rule_cnt)
+int bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
+				  u32 *rule_cnt)
 {
 	struct bcmasp_priv *priv = intf->parent;
 	int j = 0, i;
 
 	for (i = 0; i < NUM_NET_FILTERS; i++) {
+		if (j == *rule_cnt)
+			return -EMSGSIZE;
+
 		if (!priv->net_filters[i].claimed ||
 		    priv->net_filters[i].port != intf->port)
 			continue;
@@ -548,6 +551,8 @@ void bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
 	}
 
 	*rule_cnt = j;
+
+	return 0;
 }
 
 int bcmasp_netfilt_get_active(struct bcmasp_intf *intf)
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 5b512f7f5e94..ec90add6b03e 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -577,8 +577,8 @@ void bcmasp_netfilt_release(struct bcmasp_intf *intf,
 
 int bcmasp_netfilt_get_active(struct bcmasp_intf *intf);
 
-void bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
-				   u32 *rule_cnt);
+int bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
+				  u32 *rule_cnt);
 
 void bcmasp_netfilt_suspend(struct bcmasp_intf *intf);
 
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index c4f1604d5ab3..ce6a3d56fb23 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -335,7 +335,7 @@ static int bcmasp_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 		err = bcmasp_flow_get(intf, cmd);
 		break;
 	case ETHTOOL_GRXCLSRLALL:
-		bcmasp_netfilt_get_all_active(intf, rule_locs, &cmd->rule_cnt);
+		err = bcmasp_netfilt_get_all_active(intf, rule_locs, &cmd->rule_cnt);
 		cmd->data = NUM_NET_FILTERS;
 		break;
 	default:
-- 
2.34.1

