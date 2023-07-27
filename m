Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC217764795
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjG0HDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjG0HDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:03:11 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342CF3C32;
        Thu, 27 Jul 2023 00:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIUFxUoswohzQD8IyBKO0/M1vcoi+94kZtxt+6FZHCy892eOIdGseMj2rvHP7DB6/NpV7J+srNFrMAr+qZid0tx+cV6fF6QM9hfsWmQoUIrc1Yp+5K+oWHUMpPBAp7g7t9IGIWSCAFiSguyJ6rwHR8OSPRkdNgewjlKUyLEdlCaWobasU9On6/itM9f/aEjX6ZhEHCTHAgumVHjxQOiMlalhyo6/n4UNTp+ZKQpnNpq6F5tEaWQCvsxoeJuhNZRsUOTBtgTG6VSw6EAQsdluArj813n8HdvZPsvWrf4DUhCNR6AtO4stHT4nu9W6OLL6YhVSJwhCv7KswHZd4O5vDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsBYm0syPr7thxBEbMPEsbcgZPueQUhwrbcvN2FuDVM=;
 b=n/N6FNsOXad65QvOBoT1qVycXYwNBBP5a3UN2BRYW7/oPsyL4wWYr3OndcGtcm0MkChiEWAWjUh7myqBNQXVhRpXDouLV1el42uON/Ymz1R3Iu/muRGYQ5PEdXzeGsqMl8SDci+6ammQ5BP3HKze4YwqiutYl5jhM7jnbxsvp2XE5SWsbCpRPgxR3H+2n5mmbXN+KCcffevsEKMaQ4/3tQjtMu7BCvIoJpDsSvppJne0nUh/keM8mb3hQw0x/fQRd3b3MJEBKtOng6mP8a5VNNg6BAi/Zg7DcGlwadFnCsauM5Be+7lKBYMVYxzgR/E8ktBWf6JRcNq3VqCGV1Ak4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsBYm0syPr7thxBEbMPEsbcgZPueQUhwrbcvN2FuDVM=;
 b=G9l9ACKifca4p7xw1ME4pZtHKpyuu30S90kry/JhVpppWx7jvX0VHZT0zPLtvPiaks7Oy7QDRbtXm0bUbNHlq0BxVKvQe7yvSBanbiiAEHHEDVkt8mjNPoHzHgEMNOTcrfDWubbizvNdbxptIMOO1bocaxS3IPop6u0dErH3UuKd55W09VhMMfr0BE0wpuyklrxZA+6sRFd2RHwmivtYrM8tQeMq34Q/j+WQi2xjftBPaBrR61OzsKyoFTj6VMJRtvRyGTTjv/QwJR33HASiv1XG8SqdTZ46SZKyBHQepfjWa4pqGfi1tGUm3kWofn/+nf5ejTLBmWo0RcP79Swf2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/62] mmc: rtsx_pci: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:06 +0800
Message-Id: <20230727070051.17778-17-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230727070051.17778-1-frank.li@vivo.com>
References: <20230727070051.17778-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 2582d20b-098d-4ba7-9048-08db8e6f4da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iu4qch+4ZUDdp5su2LbUgomBcKqSRmPyZ98p4vcYYHca75TGAJWVwJruzsK/INa9hepmA0q3uRDs2lcJVRsoBcAx0HgrxxVCLdJGuLY0b1ehEaVwWGrOJBayW7+1l5KFppXQf8zB7QRnRkD5ct9z9JgSaA3MnNb0naOrGSOfdpr+OiVGYUfpMmGhrqCObeGxwZI7ERXFIhnTvpqMRfxcHdWfyyH84MESG03eaRZpjNyB76fIEaaLHwtxm18hSr8GWCgkOaheWyd9VxS7N9hNX+iCC4ATf11GxSVsqrwWZzBTv653+xauFS+Khcnn2qtsH/29aSinWczYI3imcAe7nCNBFugx7PLJ8diFBfFWDJDSRoQq8gQaH3O6IrA6aoQbslkL0siTO+BNYfomzLYdJ6rKTnvW6OuGqOlcUzP71nV1NHz1BV8VrR7arH+L4d9ajwiQWDwUkN6M1tg3hKlH172R4uIKTEYJU4uo5sRXvWDkxUc05Ab1aK2+nWxmUXByKCiTd75U90vvyjxn5avd1lsP86JmR6cjrru8ckYp34kx1iLYK4KCueWFA0xkWyxM8OXZI6To8sAd7QFwwVHcbKOpej2zEP9BF95Ll180YfJ7tu0+p80TvZAN1vRKFzUN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(6916009)(4326008)(316002)(54906003)(66476007)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnlmejVkMUhweTBrQnRHZE1QOXVyNGNJRHgvcDBrTG9XVEl6M1FwdzdCWWJj?=
 =?utf-8?B?U2R1bXVyOUFGVHVEVGw3ZDB2RENVMlN3UkFnSUdJdngra1p4T2hFZjMvT2Jt?=
 =?utf-8?B?bEN1aEllcTJUdzdudE9tVEFzNXB1ZEZRT1N4YVphSjE3ek1WR002WDNkSGtF?=
 =?utf-8?B?OVVnVGQzM09wSHp0VHBtTG8xTndiUnViZEhmWmhmbDNCWWRFK2syUDNHdmZX?=
 =?utf-8?B?QVBPMFk3bkVyUzJ0Ymh4K1lxUWJHWUVVWTRGY3JQOWJvOUtjM1g5N0NUdXpT?=
 =?utf-8?B?VG9COW1hMm8vN3ZWN1N5bk1mRmZOQnZhYVZsV1I1RDg0dHljMzBsekhQYzAy?=
 =?utf-8?B?YmhqQzBoMCtUY2ZPZjdhQVdISkhBaEltaWNaZmh0dFJsa1o3YWs3R21FcWxv?=
 =?utf-8?B?SStkak1QaHpucU5yV1dpcE1mQ011Nk51am1hYzh6YzRGKzBDQURzcU9RZCty?=
 =?utf-8?B?TTZWQUpwc25Hb2EvYzhTNTRremRBcnNsdEJUa1EzRWwvN1ZCanYvSGwyV3NR?=
 =?utf-8?B?d2pDUEROY2dTU3BYTTV4VTFpOGRZU0s4emhiRlBHVmpIdngrbnkvUXVpSlN4?=
 =?utf-8?B?TnB2ODFrOVBCUkN4OWliYlBYejBkS3hySXBTYysvZ1lsTmZTYnFNWVg3bHFw?=
 =?utf-8?B?dm5KTk4xM3dpQklybW5STG8vWWl6SVAyVWRCaXpNZjB3REdrVDEwUERXbXBE?=
 =?utf-8?B?YWRPaW1JNHU2b0JDRkpKd2FnRHhoZ3BVZVZEV3NFdk5aT1JvRWRydmE3ZG9Z?=
 =?utf-8?B?NjZaOWptWE9ScG1GWWRjUUQ3Y1NETG83UUdmUExOdGJlaTBsczV4Uzk1emVv?=
 =?utf-8?B?enA1SytpS3BjODdlbmRheVVESzdwWjRsY3ZsdU5XcnhONTFIQzV4RWMyNjZk?=
 =?utf-8?B?UC8rVjJla2g1dTUzL1BYTUNSZ21OZEZlbWozblR0ZlJCNXFlVXFjQ2tQY0RQ?=
 =?utf-8?B?WWVuYTlkUEpNUDloajFzWFdveE44M0xOR1FWMUx0S3E2QkxZTVA0a3dmeTc3?=
 =?utf-8?B?YUM1N3RHa1ZuQTNKV2s5Y0UrWXJ2dzB1ZHp4U3I5NE03T0MwK1BKbFJOZmp3?=
 =?utf-8?B?dys2Zm14RWg5K0trYVYwNCtzUFJXN0dtOUl2RDlnSGxERGRCSXJTMmhHSXMz?=
 =?utf-8?B?T1paUFZNMDFhQ096TjhtR0szSlE3TFFndHdrNGxqN25LbWVDMnB2TWtjTVNT?=
 =?utf-8?B?ZzVldnVkcFQ3Smhxa1JPbGM2VnFGNi9LaVZkc1dNdUh4OUtySmlrNmlHeEF6?=
 =?utf-8?B?aWpZS0ZIb25UWnVnOThlaGJUVXh2ZDR2emNlUkkrNnpRejNhTEdXd2hTaHJK?=
 =?utf-8?B?R25saFBOMnVsWHdWc0laSWVEVHc5QlNialQyNHIvSkJmdnNGRi9iQVhSZFRF?=
 =?utf-8?B?RzVQWUY0SkFmcWh4anhkbXFJd1l1bXd1ekxXa0Q5OVBockVFT2cyUDZrQ080?=
 =?utf-8?B?cmxFc2FKQ1EzeXZQOUx6UEdBd3ppMXlwWjJCZ0dxQVk1YXRmMnNLemhkKzdZ?=
 =?utf-8?B?dkk2enN4U05xd0cvalQzR3VscHdJQ3BJSVhSaUNMUWpuZTJwQlJPdFhDUGJM?=
 =?utf-8?B?Vm1jSjlpQVh5NlhMS1kvN1lJMVMxelBWeUMzNm1QVUh2SGZHVEFjMnRwd0ht?=
 =?utf-8?B?RUpVWExXZEhBdW1GUnJ3MUx5MHBMS0xaV3RjcEdRcWZDRTl3VEQzQU5LVmVs?=
 =?utf-8?B?Z0F6WDRadzZXUE1xOFVhSTI3S3JwMWJPcFh3bCtleEZqRWdVTGFpUGt1eWFz?=
 =?utf-8?B?OGtFK1d5UkNiV1RXeVVzS0laejJIOUxCd1dwZlVLUkFQNnQ3cnBUL1NhVkpX?=
 =?utf-8?B?MTZNZm05WFF6WS9nN3ArV0ROalFQRUcwcUJmdFQ2ZG1hYzI4dWljVTBWcnlr?=
 =?utf-8?B?Mk5RMTNBTzdFRXY5VUg4WU9ZTXFVd29uSjFUQUZXd05kRDlNNkU5bDhoOXVM?=
 =?utf-8?B?VFJETWR1Y3ZBdHZ6M0tDeUphVVkzMk9BRmkwcU1CZDhicG5mbisxTjJ0ZDd3?=
 =?utf-8?B?anJPTERQV2NKbzJjOVJ5Mld3WjhWWW9Hb3Y0cTBtaUFMRUtoNHFUL3hGUjJ0?=
 =?utf-8?B?bzJKNkFxUkRuZXBHWHlEWGt0OUJrUzR4cCtSbHNxa3BxQkoxN3dZTzBPSTFF?=
 =?utf-8?Q?zgi3J3+it3H3vLhe7ogW80W4/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2582d20b-098d-4ba7-9048-08db8e6f4da3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:29.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvJY1y+8QKzUuRxVPI+QrmAhQ2seikZ5OEE8uNzh1XmEtCHR7eZ/qhkBnHj1yPe5YfiE8touer3yEVEvvrbXSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 062d07c2ae5e..87d78432a1e0 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1523,7 +1523,7 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
+static void rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 {
 	struct realtek_pci_sdmmc *host = platform_get_drvdata(pdev);
 	struct rtsx_pcr *pcr;
@@ -1563,8 +1563,6 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 
 	dev_dbg(&(pdev->dev),
 		": Realtek PCI-E SDMMC controller has been removed\n");
-
-	return 0;
 }
 
 static const struct platform_device_id rtsx_pci_sdmmc_ids[] = {
@@ -1578,7 +1576,7 @@ MODULE_DEVICE_TABLE(platform, rtsx_pci_sdmmc_ids);
 
 static struct platform_driver rtsx_pci_sdmmc_driver = {
 	.probe		= rtsx_pci_sdmmc_drv_probe,
-	.remove		= rtsx_pci_sdmmc_drv_remove,
+	.remove_new	= rtsx_pci_sdmmc_drv_remove,
 	.id_table       = rtsx_pci_sdmmc_ids,
 	.driver		= {
 		.name	= DRV_NAME_RTSX_PCI_SDMMC,
-- 
2.39.0

