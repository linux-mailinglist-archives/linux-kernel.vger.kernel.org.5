Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4C577238E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjHGMP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjHGMPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:15:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59CE46
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:15:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb893e6365so27733395ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691410523; x=1692015323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLQYdihKrZnqzA8pyJFR0KmRfev22Y9Nk5IK1CsNWSQ=;
        b=bEAsqH3EjC2u0IGUnDABZVNA3fbPjqYFRA+b6OttdreALvj5DL7l7Ckx1qTRiEI13l
         /MNN1P3o3BUJAbMyJ5RZk7d1fAqiWmKhRsmLQRel5SV+JfC6akLzqW9B/w0QwXMG+Axx
         EbhFL6nmoNWKymjJleYouiGVXtulkdgMMReMJ48ag1EerhFmBMPRRxPb4+VYYK78FigG
         H8+2tCLHg7Q5ZF78UsXOv+7taDaXBCWTD0bY26hvadEh1o3oxyl8/xWhkUrT6uL19SQs
         ifTEX5J9eqOjtREpgVr+LfniIynboIEd/NlIcpVj3S468oO+PrfuwNV2Lw0N/Icu+Bif
         mfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410523; x=1692015323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLQYdihKrZnqzA8pyJFR0KmRfev22Y9Nk5IK1CsNWSQ=;
        b=ZbAhNDpjI/PV12Ky9SdIYnQaIZ2Sf3bn7etogrjLFuH44a8DRML636Dmm366svpAVP
         QTTDfv3kOtvZRjbFLYQ15OI9vS5GgKNvP7ENgI2QbUt3FHZvwfCWP8E8hKbhMcgohJBn
         N8pQmHTRHE50jEZUAPGVnGTYoyl5Sb8zkWXzHDe02992Pb8Vifw8xCZ/x9e6eoWaA0h/
         TydJqCUGG25SzrjfFE6ItsA7sHLIeJnskAeoMkaEh9P1oIMHW1sNaIO+NCOMEMVzndg1
         401NyAo7SayfYDqBdZocFRe4kkPRINmx6ruuGrHotG6sVv41L1/nsHk56zj64sqDbAxa
         ipTQ==
X-Gm-Message-State: AOJu0YxKYK8sVH3zotkwkGDqRN3LBpce8jbp1XGPYnc33hvfr7Z3WgC5
        PuiZAl66Kei9oK64VUibq6Fx9g==
X-Google-Smtp-Source: AGHT+IEFVp6KMtDbFDIQLBkpU/u99kKhhVeErfazpqq/dYJkpUEs2Le54iKKZ2BwOj5rl02nFUtamA==
X-Received: by 2002:a17:90b:3e88:b0:269:3771:7342 with SMTP id rj8-20020a17090b3e8800b0026937717342mr4621802pjb.18.1691410523675;
        Mon, 07 Aug 2023 05:15:23 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090ac68c00b00268320ab9f2sm8645761pjt.6.2023.08.07.05.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:15:23 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 Optimizing veth xsk performance 1/9] veth: Implement ethtool's get_ringparam() callback
Date:   Mon,  7 Aug 2023 20:15:10 +0800
Message-Id: <20230807121510.84113-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230807120434.83644-1-huangjie.albert@bytedance.com>
References: <20230807120434.83644-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

some xsk library calls get_ringparam() API to get the queue length
to init the xsk umem.

Implement that in veth so those scenarios can work properly.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..77e12d52ca2b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -255,6 +255,17 @@ static void veth_get_channels(struct net_device *dev,
 static int veth_set_channels(struct net_device *dev,
 			     struct ethtool_channels *ch);
 
+static void veth_get_ringparam(struct net_device *dev,
+			       struct ethtool_ringparam *ring,
+			     struct kernel_ethtool_ringparam *kernel_ring,
+			     struct netlink_ext_ack *extack)
+{
+	ring->rx_max_pending = VETH_RING_SIZE;
+	ring->tx_max_pending = VETH_RING_SIZE;
+	ring->rx_pending = VETH_RING_SIZE;
+	ring->tx_pending = VETH_RING_SIZE;
+}
+
 static const struct ethtool_ops veth_ethtool_ops = {
 	.get_drvinfo		= veth_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -265,6 +276,7 @@ static const struct ethtool_ops veth_ethtool_ops = {
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_channels		= veth_get_channels,
 	.set_channels		= veth_set_channels,
+	.get_ringparam		= veth_get_ringparam,
 };
 
 /* general routines */
-- 
2.20.1

