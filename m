Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1C47937FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjIFJWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbjIFJWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:22:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD9CC2;
        Wed,  6 Sep 2023 02:22:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-27197b0b733so721187a91.1;
        Wed, 06 Sep 2023 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693992131; x=1694596931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn+jXRrDrAEw7CfX+G9Zj1hLr/gSQRyi9u7mHipUA4E=;
        b=N+fWz0yVbcdCXfxUkV91rUhqVvDmhv9OAVcAH6agg4p8UjcNFSLvxhMct/P4CEwm4x
         zLHPk+X6mQcGc7scY7AVi9ngd7niUJPPEYLAbd0xnVQzS3Iv8UMAFM23ujruLuXzTdBs
         mewFrIMZaClC5nRXygxuc4N+bP7snbC1P4kcN/Yt4cdi/cGq5mJSQoZ24NGaqwu53GVr
         4n0gWGK8wiUlfZaAeOSNRkLYNTnoQr+WWECnWQQZltUwXoLjppxiDO58g1Q4AGQRNPo+
         IuKH300DbhSFd6xOlu8g0MZcaqNXxEanGAGpcLrQMnMSEX5qRzCT1zxfOPPrgpe91XzM
         4snA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992131; x=1694596931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fn+jXRrDrAEw7CfX+G9Zj1hLr/gSQRyi9u7mHipUA4E=;
        b=IqkykrMqcqQPzdEFO/tgGPkmDMS1WmCGlz0+foyNWoVkaGxnWsd3ZJ6zYI9q6ZvQPH
         7bacnmlX/RlLkvE5lBzbNUPfjUiteL9qfy9AgXR4W+3494/zSOElgXZzHIQ4j4OjErSd
         KXk/Y4xVrOqkJr1iE/f6IM7TUeA4FY2CBhhFmhOzelXClAl4WTsO1fBxpscFh534tgCz
         xB+8pyku0YjQ0EFZhtjjnRVG4jby6ndt2njD4y9qp234wo43w+hhe8dExG9MqaoxeCud
         BBwqFgGUotMBZSTz98+dt2+VNhinMmSRB+rH8WXqXFGi1Ibs2VBdS/Sus/7pvAGNEyMs
         RlcA==
X-Gm-Message-State: AOJu0YyHivJ1rx8a3ZRjaBk51mXdk8UdskD4pZYUXwKNW3MX12vEbQ2D
        MtVkxC8KPsFl0yK9Pd9m2ns=
X-Google-Smtp-Source: AGHT+IFOd5uWXjG5sRVrnc1uN2B+x7New4jEPSE8eT/hxhjfSvF95rsX2Pmpq4DVWgFU4xsFEmIoJA==
X-Received: by 2002:a17:90a:4dc7:b0:263:2312:60c2 with SMTP id r7-20020a17090a4dc700b00263231260c2mr13836784pjl.3.1693992130736;
        Wed, 06 Sep 2023 02:22:10 -0700 (PDT)
Received: from hbh25y.mshome.net ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id ft15-20020a17090b0f8f00b002684b837d88sm10679242pjb.14.2023.09.06.02.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:22:10 -0700 (PDT)
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
Subject: [PATCH 1/3] net: ethernet: bcmasp: fix possible OOB write in bcmasp_netfilt_get_all_active()
Date:   Wed,  6 Sep 2023 17:21:05 +0800
Message-Id: <20230906092107.19063-2-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906092107.19063-1-hbh25y@gmail.com>
References: <20230906092107.19063-1-hbh25y@gmail.com>
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

rule_locs is allocated in ethtool_get_rxnfc and the size is determined by
rule_cnt from user space. So rule_cnt needs to be check before using
rule_locs to avoid OOB writing or NULL pointer dereference.

Fixes: c5d511c49587 ("net: bcmasp: Add support for wake on net filters")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index d63d321f3e7b..4df2ca871af8 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -535,6 +535,9 @@ void bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
 	int j = 0, i;
 
 	for (i = 0; i < NUM_NET_FILTERS; i++) {
+		if (j == *rule_cnt)
+			break;
+
 		if (!priv->net_filters[i].claimed ||
 		    priv->net_filters[i].port != intf->port)
 			continue;
-- 
2.34.1

