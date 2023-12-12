Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC30480E3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjLLFVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLFVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:21:51 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2052.outbound.protection.outlook.com [40.107.117.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FF2CE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 21:21:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEmk3smr9E9TSSrDs6fHuVmVaClOlw2r6Tecu00Kp4+ylcav9bP9bVHQ6r8c0n1I29aoFtrbA5DuV9rEg4cL++VFFNOV0/tT3NKuQUCGRZcQjboHkII137oAX6tJj6FNWIH0R6yi9DRFtOyN3mHfuTyaOktPipyq4Np+Y6Y/JFlYL6TIG3K3eTqej6vcRtgSVvfXA9cHW2E44JFpsoRnqdmg2csjBk1BsfbyD/rusI8XbcypcDi25CbeYbHFcZBLHiOufTdbhH+xyIxUlLZVYVLVPAgI+mwjtKkufQbANwDKk7l8wNOqmRXVfjGs2o1j2/M1dD73WNtt4cPe9BcL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tN5mQgohRcObdgKvXt2Bo0WnbZmHK333tv7ud1IfbVA=;
 b=CfhMfMfphfE4IlQ6bPClRVGqz7DbgyIgXIMMI9IraaCqDuj0JuFibT+KpU+ViFSiSENV+zIYM3L/R0bt0BfM/3Q6Nk6kQlSp2yLR9YV+UceJug5T906CS9y9bqJCI0C41TgWPkZwwV8ZQFTHsadXR89ds9G+unnzUbLhP0SBI4CRsqUmx1New8d0sBaUeSy3+YbdEH3aEweWCfIlsE+/FTsNpHKynDe59mBNd30yjmyR+49w3+eM7CBOSHb03IPraWymizzFFCOswccJJGRKRnCss7Urc2pt792Kz9EAlQynwBi6s4vSCbPXvsdz//k5f0GQqNfNTB+0y6wR2kbYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR0601MB4354.apcprd06.prod.outlook.com (2603:1096:820:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 05:21:54 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 05:21:54 +0000
From:   joakim.zhang@cixtech.com
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        cix-kernel-upstream@cixtech.com,
        Joakim Zhang <joakim.zhang@cixtech.com>
Subject: [PATCH V1] dma-mapping: Set dma_mem pointer as NULL after it's freed
Date:   Tue, 12 Dec 2023 13:21:30 +0800
Message-Id: <20231212052130.2051333-1-joakim.zhang@cixtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR0601MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c339b5-ae0d-4914-842d-08dbfad2408f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2B+FXRMccSZsvfyjkupPf7LiUDd+Gv2CAVsk+pSFQCFm/eyqcnycQJESE8g4Zl9iZHvrao5rKJ5CA+Jf8XY2M1e+7bZ7m2W2djTr0NZZDCnPpfs2XVwDpXpfwhYpvjephJQ8c9MSp7yoNjBbQUoi9/oiQljILTMVlHay67Km/fbRUBwtRe8Eh4JdrCe/QW/TDFhJtgdTT8rt0UZKj9kruP5lEVPZerO+5R1NMN89rsE65WZ5bJ+R9PhWXVNn6yYhKdozVNUYxSrnpPRq5xAZ3Y74oBWA9DujGm47qlme58er8UiwqcObMGy6D7QEzuKWxY71/11VpZo6mnhZrEXcKAEWEb/mjM+lxB1RK2u3X/GX2kwqWT73SnIlMNR3k3l4Q5jB60GMPAPu7rAqyRFhbrHCScxW4fPVESnnUDbLubgX+wK+fjoUHdFnSj3hgkd7atqLZGJsNwGa3BSG00AlyTrk54uiKn2P0Oxiy/uNyQipjHWpaZBzrScFpL7Bf2xZOEcPuNlyZBG6uwPFKzoHUEVEd6k9CibVpaEk7XtyGw5m6AjN7A4kgmfaxboKIWRuiAxPVc5V/FCnD/brVWUmcNUDFcqIJQNv6QpM0Qs6wQudMkJzov54pEGlTm6jkE1Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39830400003)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66556008)(66476007)(316002)(66946007)(52116002)(6506007)(9686003)(6512007)(41300700001)(6666004)(26005)(36756003)(107886003)(2616005)(1076003)(38350700005)(38100700002)(86362001)(83380400001)(478600001)(6486002)(2906002)(5660300002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PviBQ0fu1X1Y0c94Z2HwI54RsogcMZO7AHrXWm42pB49Xvn5DB+zak4JgCNF?=
 =?us-ascii?Q?8/ZRu1T0/0v/qbJNYYfROM8vTtL2nWu5+u+rPvOk9iy65twaImEpmofGTn5G?=
 =?us-ascii?Q?Er0UgpWTNH7Sr5D52005LKO0/J94zA7F/saIFbf3DbdAiuf9U0U1/dZzqZdt?=
 =?us-ascii?Q?1O6C0w/HXZ2XGw+ANdb202nJADTGiHfEBQGshEvn7fKiDl81E0NIbLm4OJgC?=
 =?us-ascii?Q?KhG8JHS2QGZlTPiMfYPCzOql9+uW4qjLRd7wKOwrMnaLO7L2nE4TW56Z50wB?=
 =?us-ascii?Q?TEEUZgaNIAYEXrqdcgFdrdP7m1UyKeepkiHLSf2RBXHHpCtcgOlZYkou8j6Z?=
 =?us-ascii?Q?NosnDo64aHfha7RVIUbhkULbD4r+6nDssrfm4TfP2aSPeKDNau8SV7J25wRl?=
 =?us-ascii?Q?bQB30M0fjmkmqUU+x7/shaLs2mrSq84ElaoC3vIZEmXoQzPkdcCoSl0d8Euj?=
 =?us-ascii?Q?P/6v47AsSRq487G7YTNGcAP82FEwwYj2Moorncb9RpLTR112EnNfpw33VTCZ?=
 =?us-ascii?Q?tS8olFuj1C+ggRlEgILok19YB6JtGUDvLMWDAoQ2lDRW3rcJ5s15TFFPYI0Q?=
 =?us-ascii?Q?ZyR+5i2YV7xk72uiYdVgbkcYeBs/FaJbHx7Rt93IbUQFmpr+62VanP6/ISHu?=
 =?us-ascii?Q?/uXNVIy2+3iUvFgZXYXSA1fs6Ykf+47+2+KJ0wMRpZ1aoYtgHzslen5nEYIB?=
 =?us-ascii?Q?xnaBPnvkGSYnA/3Q/OMLEWmfQ25tLOLAnXKqdvdtulTCCs8ypYlx0d2HrJDP?=
 =?us-ascii?Q?N2+9IsPvsiPh2FdExLwMrs7fSG4p5YA5wTzQsUsSKw6kLQLdGoygmRAj0zje?=
 =?us-ascii?Q?bmrp6uVw9iS+NxkBkXiyAFz4nKF/FsiF/Nn3CpQr3DSpugfMIAkzGXMBYXHb?=
 =?us-ascii?Q?LgHov9ppua3CxQXTNznJ+IbPH3fKvMJgKnX+g8ZRFmiIQ5Cb+sUNpVLdsqqo?=
 =?us-ascii?Q?/0hurxIIw1qU/EEHAFaTDmRmds65vA5Qt0jlV3dc/9c0Ic4bq8Vz5hkyPHBn?=
 =?us-ascii?Q?r20Wdk9CnE7qjJgO4E+PaRFnpDBryVDcmQDqWF009hbSd46habIwDh0whVoI?=
 =?us-ascii?Q?b/nc0GPy1Y6Iv/KpohOoGq/G+lL2RldJueNHYvMo+q/w2uhh1ui8e1u6NOz8?=
 =?us-ascii?Q?7kZvjAByGl3bsNX4XOKQO9u5HT/ezzeQowlXYCZcfX/8P76yO2gyLjNSYwsV?=
 =?us-ascii?Q?RPsKv5k9fsBcCQ2rN+tOXQpC5FXmzcKw5k8fetMDXmwD9fIFxOnEfAd/rqJy?=
 =?us-ascii?Q?EF9nyFB/uQAEnEfrz0meQ5PqMYpMcrxplWLCYLagOw/Ip7UnCkgGy7eBdOMO?=
 =?us-ascii?Q?EpGHjUA0WDDCvTlm/ALNUIubRT5Eg694lpgPbxy8E/T+cKAaKoMTexz8+UAT?=
 =?us-ascii?Q?MwtT4BbyexkypaN6vAnGsw6sLqG950zX1/uV+g6aBqmTSQ51kc5+sLiEFRzD?=
 =?us-ascii?Q?UQI8yuxkm54/LNNfl2YaHqXW2XljSCt/UPbFuW+Y/xm5S+ubQjtN9U9wkSnL?=
 =?us-ascii?Q?mTg1SPFlUJjh52snabz+em32DDYvgoNLZFKDMUEJ3J11gRImHlV6n8g81IzB?=
 =?us-ascii?Q?khah6on4nAJ+QbBjjCA8l9xdRnUKWuDRgw+IhLTFn2lY4wGPFcIlNz7ysvCL?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c339b5-ae0d-4914-842d-08dbfad2408f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 05:21:53.9116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frxdQ8U3O6wuUFrolYIJUM32ULeNxaoloFV3s1QfGntfDATzYO+lalo4NLHNOEZtbHC4+nhvwT38pBy41M+mRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4354
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joakim Zhang <joakim.zhang@cixtech.com>

Reproduced with below sequence:
dma_declare_coherent_memory()->dma_release_coherent_memory()
->dma_declare_coherent_memory()->"return -EBUSY" error

It will return -EBUSY from the dma_assign_coherent_memory()
in dma_declare_coherent_memory(), the reason is that dev->dma_mem
pointer has not been set to NULL after it's freed.

Go through the driver, found there is a issue in
rmem_dma_device_release(), the reserved memory has not been
freed before "dev->dma_mem = NULL;". So if user call
of_reserved_mem_device_release(), will not free reserved mem
in fact.

Fixes: cf65a0f6f6ff ("dma-mapping: move all DMA mapping code to kernel/dma")
Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>
---
 kernel/dma/coherent.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index c21abc77c53e..602e055fc1bf 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -132,8 +132,10 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 
 void dma_release_coherent_memory(struct device *dev)
 {
-	if (dev)
+	if (dev) {
 		_dma_release_coherent_memory(dev->dma_mem);
+		dev->dma_mem = NULL;
+	}
 }
 
 static void *__dma_alloc_from_coherent(struct device *dev,
@@ -349,8 +351,10 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 static void rmem_dma_device_release(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-	if (dev)
+	if (dev) {
+		_dma_release_coherent_memory(rmem->priv);
 		dev->dma_mem = NULL;
+	}
 }
 
 static const struct reserved_mem_ops rmem_dma_ops = {
-- 
2.25.1

