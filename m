Return-Path: <linux-kernel+bounces-93311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E09D872DF2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC691F25F7D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBB4175B7;
	Wed,  6 Mar 2024 04:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b="7INxlBqS"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2053.outbound.protection.outlook.com [40.107.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC49156C2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698579; cv=fail; b=JTM4TUtc64Yh7aqaQ813HyEKMVqLhUUXHqlUVDs3NHBH5RVjiAgL1FcE3ZFifEpKylMgbvL8IiBXFtaUCs4UXPPslOd3icjh7WI2FfPItB/DPubGP5nPyMBPbrUoIgM4xubiVhj3YqjUKSxW6ofzZD8la8x82LlkVefS3DpyybI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698579; c=relaxed/simple;
	bh=ZN7uzfhuRFY4uAhwjZgkRRirm2PyAMr2KM/ioseZQJY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ja2eUKSgSM3b2uBsA8krYnWgtpXhE4FLcDvXf779MXKo9qVDJxE4lHFxgRhTwRzqjFKIF4Pf9hKN1pgK4gNuj/1AHbk1SQWz1BFAAV93PTrZwNMg1blCMOP9jeb2CZaYeeccxQ1q757RIK6Ap67zKgp2xMDisUg2kmnIjIq2Vdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com; spf=pass smtp.mailfrom=skyhighmemory.com; dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b=7INxlBqS; arc=fail smtp.client-ip=40.107.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skyhighmemory.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvJwJxw51yNN3jFoOcyR/d1NZ7XE3dp+9g+XVWpnnkkgTmJms+IpG6iCdFSo3YpskHKtNt0YXqCSgB2mf4Rr78dV1oioc4Dyeb+x28LZEA9Fn/h5cpKsJ1xZ7tmVVXqJZ6h8BJLcf2Z9gDpCDKNRUoc1ZmoZ0emJ1z2AdS3t+pKv/Rft82jSt8hYa7EiupK6RRA1A5e75zMgCKNTpzyTDWj/hbFVRTyqt7MAesLGsIAykbdtqb0Ni2VJX08ay/6WpxVt9wKGFJDTaiROvfR7f6ddJshljwlDaqA5fDNuaLm4V12SKkitKs2zZQd+ajwGGLKMoWRdaNb7mkkeDZocxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89trl++5sIrUmtdjWJlt+98R0lOUKCJOxXi8QsSM5Qc=;
 b=gpu9nIs7Kb15debRxrMvqAPU7JDRTqr2Ze1aigGXS/q5Yu4DLxFsMNHOfqcgel36yRhTrODr0JaxPULtTa7jf3Wzg52ba5JCwZkJThfRCNcvq/BRBfDNHANeDBQxZ+FpHYpJTl+TknMpava+j67FNUsp2nSgWVgDr71xA4Lb18Zc4DsDaVUqpgZC3O1m3BAhHkKvTxvED5NYXcCoUY4zACzAeuyolfF717PvM2XFxIZwWk5Uywtgqq5oT9Xd3zdCW8fkT2aYjrSccHkT/Iya0Nj1buwGCCdj+r4qIBwW+lgA8PwbR811dNmQboztsn208otUuIlWS6/BmQKiIQ1HWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skyhighmemory.com; dmarc=pass action=none
 header.from=skyhighmemory.com; dkim=pass header.d=skyhighmemory.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=skyhighmemory.onmicrosoft.com; s=selector1-skyhighmemory-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89trl++5sIrUmtdjWJlt+98R0lOUKCJOxXi8QsSM5Qc=;
 b=7INxlBqS0/w3N0/C0JTB/ta+k5UR72liBGsa6Kkh/DADWvgAFpxhX8ygejKvd6mMxVGNJmVdkndNhCOXwuq6n3kR2Q7aE6uvXJMx8PvV4L0VanMS5IMwOf8a3GscTkqKU1Of+i1ewCTzfUfZQg2glSSW6K947v7a2Fnq41j41Uc0PpJ6nB4WDyVCtOUa6Sw/F597hNx+cYg0TFqJTxuyzh2t/K+rzwlzQBqYgkmz2/Ge42sGfdkWjtQXcKu/iHP6bRSU3arC8sqIEWkdqrpr8lcFGzPTkyM9Ol4hMn9/7ZkYpcy3klnmHhsJOo62iaWzMlCtDsEfSIu2syCIJMGXHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skyhighmemory.com;
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM (2603:1096:101:11b::5)
 by SE2P216MB1992.KORP216.PROD.OUTLOOK.COM (2603:1096:101:119::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 04:16:14 +0000
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::6bad:dd98:cdca:c48d]) by SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::6bad:dd98:cdca:c48d%3]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 04:16:14 +0000
From: KR Kim <kr.kim@skyhighmemory.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	mmkurbanov@salutedevices.com,
	ddrokosov@sberdevices.ru
Cc: kr.kim@skyhighmemory.com,
	gch981213@gmail.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	moh.sardi@skyhighmemory.com,
	changsub.shim@skyhighmemory.com
Subject: [PATCH 2/2] SPI Nand Patch code for SkyHigh Momory
Date: Wed,  6 Mar 2024 13:15:32 +0900
Message-Id: <20240306041532.16985-1-kr.kim@skyhighmemory.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0079.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::12) To SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:11b::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE2P216MB2102:EE_|SE2P216MB1992:EE_
X-MS-Office365-Filtering-Correlation-Id: ce872f17-71c5-415e-7e44-08dc3d9429de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	buRo6fCD+geAf6UMK/NXpvbUo2sT0/SXgtv7154C8j73P1F+zIcfbxv+ypJxEPIKfT0NcKiTLmkh7xqDDvnfltyT876SrxcSpwfB1wEPBQt9xw+21yYf2Ohc3fDUB/xQmcv/G493tYXsyvK8Ep7p0Xs2UCokKe1IP83wRuh25Z/c6cmoETGL7DF3vkgq6jkwbeJEgx23Ilr2C1xdzorWkVSg7LcMhHXLjZzpP8TJUFZI8azDJn/Y1ONiKzr7THt8z84Pe6Dc22oz2ses6UiCdBTpjG2vkQmP8tX0MfMru5sJEcp9gG4NRktUc8V/0hLYC9H26X2VpWfaGipAUpfpPjLx2462VyX4RbcQdZ3Ctg8vpe0vo9wNUH/YnSr0kwnff4m3PALJX0zvuL9xaKOgjt7KPjIyQ2ICCubOUk/PiMwKUlIs0ZdoVGkt2HQTzu+KC5HAJ6UA8CAINM3ojjt+PIioCr6DX2bv+IzQqLkK5XrEg7qC/TRAJXlb66AfOndxwoOMtuIqtMsge4OQHy3m+rVISZHguleBT4tKbIB54K4Xb0/HdJwvPBtCZDQ27RI5IQ+umjivv3mMpYRUDgjMbyjWDGUu0SmcP52j2iSUdqPHi6nakUBFJNhAhrP+l1ZC0qQrhTQiidWjs+Y6RqiEnSqzXqrCUexZpS3qnr+uFmHAQhh6UaazzzIsQDY+teWL7jRbJPeghigL4kjyWcDncw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE2P216MB2102.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/pMq6yMP7evG0k/FJffwywPYyCQPHMB2Lp7fLpbcIOKyhNsihRr1qGQgBK4G?=
 =?us-ascii?Q?9sF1doEAZ7wwbDrb7roUnl0oF66hbDEVb1w8pyoxdfTZ6uBCgIsDazexkffC?=
 =?us-ascii?Q?hpjqMXgoRPIF2s2pZ4A4Mfx7Onow11dg9t02sYi90ijkHOXYIIRuZIYnmqFz?=
 =?us-ascii?Q?ptLZDGYg7qSDCV47RIoudTw5RwfT5QHCF5LAKle8ea0I+86Y9cfSqvu6Szu4?=
 =?us-ascii?Q?ldNSStbsmyEzTYYvcyU9h4Y3BPwFi6GozrAabBqiRkTi4DGFgBQaZhNNUujx?=
 =?us-ascii?Q?O/vB71/6eAf0oUpbb9MiXPUcSHITAve8c8CQdEYisSe6csGxj6IHi4LNdxaQ?=
 =?us-ascii?Q?gOsOEZezkFIb3+g33MhXaTx27aXO1lX72E/3rd4dWnfO5KzPKVwrVmgAmmNd?=
 =?us-ascii?Q?YN2D0N+y/kAf0Kr2cy3MfPoDvqQ3RBeyk/X2BUkT0i4CYkthhxNh+mnDqzKD?=
 =?us-ascii?Q?9xIv39868FbCD0zQ6ImnP2HwhLBveoV5jW+X/WJ8TxPZQZMarjHUUgEK6A7L?=
 =?us-ascii?Q?UqOs21QoeHg/UFV89nuKndMRkH3+7tJ4Rn7FMelzAQrYgblOcdpoad8q6mMe?=
 =?us-ascii?Q?Tu5/uk+a1gEnvpoOfwEa2xAXVzGs3Tu0pUhJ2dEOEBosorYOWp+VaCoFhL//?=
 =?us-ascii?Q?0kQMxLpYeAVLLu1309DNAd00kMccXktLIOMBSQoY4K6UvBpn/xa+Tn9xR3/7?=
 =?us-ascii?Q?rqog3fv7ZwvYiOOAVsPgIXfsp/nmahgAb9RKNjihvUT4XkA5NUR4jqZ4NBaA?=
 =?us-ascii?Q?hMAOS97wKRirUhXO3tEPZmbqDGwHzU5hE8k7AgptgTkahBcRUK2JdcF6Wm/E?=
 =?us-ascii?Q?gMQPaRMW0kyXkc8VTktCncuqzQJoBuxLqZ2xUlmTZDNFCLKusDB1NglPxugd?=
 =?us-ascii?Q?NrTR5uRk2j0/qRgB4Tjag8NO36j/F0kHbNzjPct1pGue6LMgj174rmImcLpN?=
 =?us-ascii?Q?5OePDf2QdnRy6Ct5f73G++F2DKJNqgvVpf87l5o676XSkh/CoRVf6hmaPGnp?=
 =?us-ascii?Q?8v5c1vj9FtfeCFuT6GUqPCzNfq/rvDXNWsobpV9Lb3WFalyR+AhbMgVqzaq0?=
 =?us-ascii?Q?WtsReDVnq7/Ta/sPr8kBqwEmmAobYZWBOQhH/B5eYuMsO9huwFjyp+y5f/RO?=
 =?us-ascii?Q?fIVi+mqYDwsTi8Jrqo2/uehxCmA+SlgOIth6qPNyGMxeTNtSIdUVdLv8jmlf?=
 =?us-ascii?Q?2Bb/HgQcFUx/jDuo4Yq6WmdAqkal9o6dtGXPV/6JLn8Vh5QCIJmxnNzzrWtY?=
 =?us-ascii?Q?7Ay5eYTvuw62qiet6jt/1byQYnkhFIVxD0HMt5/td+qCEArENETbrl50vqpt?=
 =?us-ascii?Q?Eaofm7WIa/7chW4gubhdccJdRVeI3bDGN5TIjcDyOjpNbBUSyya5MSt7Orls?=
 =?us-ascii?Q?eN71OMLRJNVeFa889QfRG0AEeANwvrkL9C3ngeFk5LVhS1PL8PXoNsx502dD?=
 =?us-ascii?Q?JwpV/QFNpXJrtFJgQpeYXJWusk8ShwauUGf2N8AuFmH853m3qnslgzHiNDbj?=
 =?us-ascii?Q?UbTZCtz1dGxx/xiL1gWLLkQwC4fsMncnRtCiqIZBUGd78koj2u3H+1R38h7X?=
 =?us-ascii?Q?YdQboKaY0+ENsnN05OfF4xYgEiv2IXZ9H5Syj2lAShtFNXnx1U/aRB6iv94v?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: skyhighmemory.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce872f17-71c5-415e-7e44-08dc3d9429de
X-MS-Exchange-CrossTenant-AuthSource: SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 04:16:14.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 39b82b34-0966-49dc-81a7-5bcab7ea53c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ppHe1htDSHnpq1LYB9XQkAJwhXiB1Tl9H0ajAB945X0NAGy3W6H1O1Y4wLj8SWEVqp4tpDT8HkPPHN9QwmGIv4RYriAcwRg+/5FbsfsGo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1992

---
 drivers/mtd/nand/spi/Makefile  |  2 +-
 drivers/mtd/nand/spi/skyhigh.c | 57 ++++++----------------------------
 2 files changed, 11 insertions(+), 48 deletions(-)

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 48b429d90460..1e61ab21893a 100755
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
-spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o skyhigh.o
+spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
index 71de4fa34406..dd348849216d 100644
--- a/drivers/mtd/nand/spi/skyhigh.c
+++ b/drivers/mtd/nand/spi/skyhigh.c
@@ -12,8 +12,8 @@
 #define SPINAND_MFR_SKYHIGH		0x01
 
 #define SKYHIGH_STATUS_ECC_1TO2_BITFLIPS	(1 << 4)
-#define SKYHIGH_STATUS_ECC_3TO4_BITFLIPS	(2 << 4)
-#define SKYHIGH_STATUS_ECC_5TO6_BITFLIPS	(3 << 4)
+#define SKYHIGH_STATUS_ECC_3TO6_BITFLIPS	(2 << 4)
+#define SKYHIGH_STATUS_ECC_UNCOR_ERROR  	(3 << 4)
 
 #define SKYHIGH_CONFIG_PROTECT_EN	BIT(1)
 
@@ -62,49 +62,15 @@ static const struct mtd_ooblayout_ops skyhigh_spinand_ooblayout = {
 	.free = skyhigh_spinand_ooblayout_free,
 };
 
-#if 0
-bool skyhigh_spinand_isbad(struct spinand_device *spinand,
-			   const struct nand_pos *pos)
-{
-	u8 marker;
-	struct nand_page_io_req req = {
-		.pos = *pos,
-		.ooblen = 1,
-		.ooboffs = 0,
-		.oobbuf.in = &marker,
-		.mode = MTD_OPS_RAW,
-	};
-
-	req.pos.page = 0;
-	spinand_read_page(spinand, &req);
-	if (marker != 0xff)
-		return true;
-
-#if 0
-	req.pos.page = 1;
-	spinand_read_page(spinand, &req);
-	if (marker != 0xff)
-		return true;
-
-	req.pos.page = 63;
-	spinand_read_page(spinand, &req);
-	if (marker != 0xff)
-		return true;
-#endif
-
-	return false;
-}
-#endif
-
 static int skyhigh_spinand_ecc_get_status(struct spinand_device *spinand,
 				  u8 status)
 {
 	/* SHM
-	00 : No bit-flip
-	01 : 1-2 errors corrected
-	10 : 3-6 errors corrected         
-	11 : uncorrectable
-	*/
+	 * 00 : No bit-flip
+	 * 01 : 1-2 errors corrected
+	 * 10 : 3-6 errors corrected         
+	 * 11 : uncorrectable
+	 */
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -113,12 +79,10 @@ static int skyhigh_spinand_ecc_get_status(struct spinand_device *spinand,
 	case SKYHIGH_STATUS_ECC_1TO2_BITFLIPS:
 		return 2;
 
-	/* change from 4 to 6 */
-	case SKYHIGH_STATUS_ECC_3TO4_BITFLIPS:
+ 	case SKYHIGH_STATUS_ECC_3TO6_BITFLIPS:
 		return 6; 
 
-	/* uncorrectable for '11' */
-	case SKYHIGH_STATUS_ECC_5TO6_BITFLIPS:
+ 	case SKYHIGH_STATUS_ECC_UNCOR_ERROR:
 		return -EBADMSG;;
 
 	default:
@@ -179,8 +143,7 @@ static int skyhigh_spinand_init(struct spinand_device *spinand)
 
 static const struct spinand_manufacturer_ops skyhigh_spinand_manuf_ops = {
 	.init = skyhigh_spinand_init,
-/*	.isbad = skyhigh_spinand_isbad,*/
-};
+ };
 
 const struct spinand_manufacturer skyhigh_spinand_manufacturer = {
 	.id = SPINAND_MFR_SKYHIGH,
-- 
2.34.1


