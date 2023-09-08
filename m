Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF2798248
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjIHGVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbjIHGVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:21:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9FC1FCF;
        Thu,  7 Sep 2023 23:21:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1c0a4333e03so3965505ad.0;
        Thu, 07 Sep 2023 23:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694154102; x=1694758902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wpl/wrF03hm1k33VtCn3Pp91tnDEn9HNqN0mbE6woR8=;
        b=F1TGyEr2w5SCtlnmOCcZga4UJAxD9AvFqNe0j6CQjgzM0U3KVGnwVwVyKmDA7vEbbg
         qZv4yQkcnyT65wPdRilNY9dNGeWsR/53LCoL2nVMe8Wi59k6ngJ6EjV/4cQt/oR6OXwb
         UxabhuHYM/FkGCU3+ELBEmoZR77KLmJ+1Vd7kn//vgV73zbZ3msWJJIPbmMa0hbBFNtb
         U0IlX/CcA/SJY/PCNo8qtbTtunHuXqApRvBgWe68QehBNQ/ibMKcAAM+aZoJ+Ldirn7L
         s3V9Gt01uUf3EOIiklYnis5OyYjlWSyxc9TceQORaQv8ZLAVvwDkQ0XzlyR0xrhUiDzK
         i9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694154102; x=1694758902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wpl/wrF03hm1k33VtCn3Pp91tnDEn9HNqN0mbE6woR8=;
        b=Kg8/7x7K4Ngd+3qY7YplJSVvSrqlucuO6jN12oRU6hRNmSZGGEyYY3aP5K2ETszvfQ
         2fkzrMxGg/neDLOX1mK72+CTqZdaohEn2cuGXWM1HXvd/QUHTCOqQRtWJRaC5b51rj9f
         J76TjfYQBe2v6j2Niq9fAKuivh/3tDeKVyd6rgZlwA/LW7RznVvLknsagdS8wIakcSUP
         ZkwbCUjytBhJeZBB0kezvd9PbWClgMO/+Jluw74UzsJJbQU0RbB+8yS+Dn1SUMSbwpgS
         v228XNypltyGjxaOHgOZ281D2HnHm0AJNms44O7Kd1hke7yAIYwgVFQ5tImq6vdBFBAq
         KiSQ==
X-Gm-Message-State: AOJu0Yz/IA+EgzQsEdHL2eRSq8bzBPH9R3E9daw2ItVxSsLtgWHyuc5E
        0FsWifxYH3cyQcPoj+St2L8=
X-Google-Smtp-Source: AGHT+IEqN3LuOZvVGW/cDz1gygxDQXajdyrBxp5NvEo7QNyxpkquntuPCrDtubFkejvWG2NvFCobKg==
X-Received: by 2002:a17:902:e54b:b0:1bb:d7d4:e2b with SMTP id n11-20020a170902e54b00b001bbd7d40e2bmr1895592plf.0.1694154101997;
        Thu, 07 Sep 2023 23:21:41 -0700 (PDT)
Received: from hbh25y.mshome.net ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001b8c6890623sm768620plg.7.2023.09.07.23.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 23:21:41 -0700 (PDT)
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
Subject: [PATCH v2 3/3] net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()
Date:   Fri,  8 Sep 2023 14:19:50 +0800
Message-Id: <20230908061950.20287-4-hbh25y@gmail.com>
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
rule_locs to avoid NULL pointer dereference.

Fixes: 7aab747e5563 ("net: ethernet: mediatek: add ethtool functions to configure RX flows of HW LRO")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---

	v2: drop the brackets.

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 6ad42e3b488f..2372ce8c2580 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2994,6 +2994,9 @@ static int mtk_hwlro_get_fdir_all(struct net_device *dev,
 	int i;
 
 	for (i = 0; i < MTK_MAX_LRO_IP_CNT; i++) {
+		if (cnt == cmd->rule_cnt)
+			return -EMSGSIZE;
+
 		if (mac->hwlro_ip[i]) {
 			rule_locs[cnt] = i;
 			cnt++;
-- 
2.34.1

