Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806A1793800
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbjIFJWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjIFJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:22:43 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481BCE6C;
        Wed,  6 Sep 2023 02:22:28 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id ca18e2360f4ac-792973a659fso27950939f.0;
        Wed, 06 Sep 2023 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693992147; x=1694596947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lxgSeotXhtluM5Y7Gic0yIlmVnTTGRsI6a6z+f7glM=;
        b=hwAVjqKW3RvaKBeKuE0gQpgb+jTTdZ7lOdDebCI/FKrOVGyZLTJ7CY1MXOP25FMZU0
         gZdjLdcv2Dy8bgwbzwjWwldY/IJcuKI0F5XfipS74QDLgJpRMM7b2Ws33sDxS5RgR7Dn
         rU/LRw3ctn+6TVIxqY+ScM5k9YFXhRooWk4G2In+u8HF8bqr6lOAYq00cb6geqE23nXB
         HDXIgcRsJRZT6rJcFLA/OHDTZDdONKJ/ZUr3xt1hQhUszn+qcP3Z/4ByF/C9uCHK80a/
         aOdFXc+erR4Wd7+YYpLLzQw4C1qzEn7Zbhmb4XXaDqhiCDKpWgLwkaiamZZytTkfB9tY
         isTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992147; x=1694596947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lxgSeotXhtluM5Y7Gic0yIlmVnTTGRsI6a6z+f7glM=;
        b=Agy/tyWVIhwdGrHL39MqldYGeLg7wves7t2ZET/Q04tqakgU3pTH+3b12B5vj7G04u
         0ienxFX8rfnrzg3qrpQNWsd4egjoFYvSLndlPk9dr+/dktCkE0I/1EjILPVqlq2fOuJo
         P6ihgXvT2NXPW2ks5RMMEYeoRmJF5sX3uvH82jl2TqRjHZ+PtvOeDB91WrvRtWiS20mu
         z4Fwwt/cX/gUU6bqBKyGnkmyTJNc1+qzTS3JkLacDTp7WBgC5rcXpCH0McXJnM15V59T
         MTjlddxQfyVwFN2Y/mRdkcW5uUNqK53GKoLPO87a6fLzRhp8qWRveqXBdxXkgK+JScJ7
         LFJA==
X-Gm-Message-State: AOJu0YzES31jKT4bTK4eYkC0L+mKOHO3kKchWvcw5ZouscQ+VHwAUlUn
        YHw21Jvo8D+bEseui6xRgOc=
X-Google-Smtp-Source: AGHT+IHgtjBcMfcAVv0cvr5pcx0KRu57NHijg05g6vWK0eh4cHfhCe88XtFsAw8hxKpJW3dkgMFv5g==
X-Received: by 2002:a05:6e02:216c:b0:34f:3b12:799e with SMTP id s12-20020a056e02216c00b0034f3b12799emr284714ilv.0.1693992147534;
        Wed, 06 Sep 2023 02:22:27 -0700 (PDT)
Received: from hbh25y.mshome.net ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id ft15-20020a17090b0f8f00b002684b837d88sm10679242pjb.14.2023.09.06.02.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:22:26 -0700 (PDT)
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
Subject: [PATCH 3/3] net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()
Date:   Wed,  6 Sep 2023 17:21:07 +0800
Message-Id: <20230906092107.19063-4-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906092107.19063-1-hbh25y@gmail.com>
References: <20230906092107.19063-1-hbh25y@gmail.com>
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
rule_locs to avoid NULL pointer dereference.

Fixes: 7aab747e5563 ("net: ethernet: mediatek: add ethtool functions to configure RX flows of HW LRO")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 6ad42e3b488f..d91fc0483c50 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2994,6 +2994,10 @@ static int mtk_hwlro_get_fdir_all(struct net_device *dev,
 	int i;
 
 	for (i = 0; i < MTK_MAX_LRO_IP_CNT; i++) {
+		if (cnt == cmd->rule_cnt) {
+			return -EMSGSIZE;
+		}
+
 		if (mac->hwlro_ip[i]) {
 			rule_locs[cnt] = i;
 			cnt++;
-- 
2.34.1

