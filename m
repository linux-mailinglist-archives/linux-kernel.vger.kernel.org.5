Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A2778DB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjH3Sif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243735AbjH3Lh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:37:58 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99473D2;
        Wed, 30 Aug 2023 04:37:55 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37UBbiDi037424;
        Wed, 30 Aug 2023 06:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693395464;
        bh=+IuvtcMd1sFlLqqC+3ASlwRUxQpLaQqflNX7KZMmrkA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uvAODyNuwHJW4n5M9Fn27pz/oY00RoFsEA0sEpPNVLJVloB7Yhe+yg5V7oK6G8j+c
         IhaPzCVJSGA7vTxHqgL1kQhIOJmj+HIL6j9R+EIu0wLH9+NiM2QPCArzKd93zPsM9W
         QGj2MmhXul2rxTtuP/Dl8/2zomrW4WFd1tvND1Aw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37UBbiFV041851
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 06:37:44 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 06:37:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 06:37:44 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37UBbirI077275;
        Wed, 30 Aug 2023 06:37:44 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.35])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37UBbhHY001546;
        Wed, 30 Aug 2023 06:37:44 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next 2/2] net: ti: icssg-prueth: Add AM64x icssg support
Date:   Wed, 30 Aug 2023 17:07:24 +0530
Message-ID: <20230830113724.1228624-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830113724.1228624-1-danishanwar@ti.com>
References: <20230830113724.1228624-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AM64x ICSSG support which is similar to am65x SR2.0, but required:
- all ring configured in exposed ring mode
- always fill both original and buffer fields in cppi5 desc

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 3236af45aa4e..c2d1d0c7deb0 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2676,8 +2676,13 @@ static const struct prueth_pdata am654_icssg_pdata = {
 	.switch_mode = 1,
 };
 
+static const struct prueth_pdata am64x_icssg_pdata = {
+	.fdqring_mode = K3_RINGACC_RING_MODE_RING,
+};
+
 static const struct of_device_id prueth_dt_match[] = {
 	{ .compatible = "ti,am654-icssg-prueth", .data = &am654_icssg_pdata },
+	{ .compatible = "ti,am642-icssg-prueth", .data = &am64x_icssg_pdata },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, prueth_dt_match);
-- 
2.34.1

