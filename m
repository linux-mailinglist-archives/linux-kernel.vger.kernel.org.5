Return-Path: <linux-kernel+bounces-52487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B1A8498DE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B12B25751
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5927F18E1F;
	Mon,  5 Feb 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IWofyPUF"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A31A58E;
	Mon,  5 Feb 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132610; cv=fail; b=gzjoAHB0MNLo1yFYgSDQwXbuauFhHemD1Hba0R3Hq7oxB2SijgHY6mY2lKb/A+KUFeL+JjTwZUPkv8nK5N6g6kOvw2vnxwa1gECPbk0w7ZjvhcDFUX1JDuVOcf1zHmCjhawViAsyFeqh9+QRtp1YT33u9S1LBEXh1u4nR5wqGSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132610; c=relaxed/simple;
	bh=iXEi/7VJ4PZ6/0WZl/Yuy3JKLQdNhZ1DWmBHlDjpa0s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BdzrA9JAACErMt+ax56VLvxSJlViu9uf0CbMJ5BE4MGT5AkUPHKNYpEsDxCoN3HRsqn8E4YR8NJDxWu0RJ+9KR1AATPuPiTgjbPHCzu9VXsg0UIVxum4b3quD3K150Re86VUhb2lj50jN6WfFVQEOSxcLrRGZXoJC6MDjTzsFiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IWofyPUF; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6Ac05o9FzRxkBlz9cRjuF5pIWphqzI+EcLTzcEF4MPLT1oNWoe0l2D0ne/Tlc9uADlUbO8qI1Z7n/cy9YyZUAdbU8rz9PaWwEmNwYwIMmTS3TdpfINho7/xwrWrrHzUIOLx9mMwj4dWAbUPLoHW5ewNsMaKmJqsS3KaU5L6BUOqp2cMnRLrLNLCZen7rQdMiC2tS7Qftvu2li1y+W117tKbYMHFBMJrpgRZid27kSyvwPlrn60g9E/90Cg/XiMAiwylgcUA9WEf6nZLrMSF9RrGoyN1gu5iDb1NfN2JHUmaIXFJ3O/jlP+KJxwEsVmQpMhEIEVJPNHtq5N8wu/LzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYDrcWLBhL1sh2abCPOqInagFGGCFDjNdaFZ/sM7Ti4=;
 b=HEsHetXWnvFuM00Q+uql1fUbo9paKV15B4cc1uhoDrkkjSSQx1HQjZq11Upm7UkCGsnXaUEa4o4xs1uUAsFHsZfjWctD529z1koooIdNL7+Evcrx3kvGQ+Y0HxlSqeHPLlBV0qOA7QNXD3k6D7zdAkL+5HiEhOL1Kh0ENac5M5lYpHmyoknaH6DL0ujhesYB2Z2D31qSvWnch7As8x8FPfipweUDykn0GB8XUW4xE1E3HB7TTbUgYdNNJiIW6RoqOWL05JdWtJS/U4t9AYmye8r+TD2tH4mOHsjZCCtZcC7k2aBrdD37JGzlq0EpGWmFXkAM8GGWM4adKmFHuAELFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYDrcWLBhL1sh2abCPOqInagFGGCFDjNdaFZ/sM7Ti4=;
 b=IWofyPUFsNWOjMLPpvpOWwg2nXeVuKx6uNWt/ag9zl1a/k30HV8A7Wmvqa0nuTkfNtlr38r+ZdZPpxGMa0Ikfqgb1yJj4ev9cF8GdP5IpD5TG29xkqYKEvfN3ELTvlAv0UMfrq7oQREAstV74ykaP38h8KPmdibAI3Q9B2oujMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB6PR04MB3190.eurprd04.prod.outlook.com (2603:10a6:6:5::31) by
 DB9PR04MB8265.eurprd04.prod.outlook.com (2603:10a6:10:24f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.34; Mon, 5 Feb 2024 11:30:04 +0000
Received: from DB6PR04MB3190.eurprd04.prod.outlook.com
 ([fe80::530c:5815:14e4:2c7c]) by DB6PR04MB3190.eurprd04.prod.outlook.com
 ([fe80::530c:5815:14e4:2c7c%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 11:30:04 +0000
From: Kshitiz Varshney <kshitiz.varshney@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Varun Sethi <V.Sethi@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Sahil Malhotra <sahil.malhotra@nxp.com>,
	Vabhav Sharma <vabhav.sharma@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Rahul Kumar Yadav <rahulkumar.yadav@nxp.com>,
	Nikhil Singla <nikhil.singla@nxp.com>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kshitiz Varshney <kshitiz.varshney@nxp.com>
Subject: [PATCH v2] Enable config for sm3, sm4, polyval, xctr cipher test as built in module.
Date: Mon,  5 Feb 2024 12:29:33 +0100
Message-Id: <20240205112933.3084766-1-kshitiz.varshney@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0047.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::27) To DB6PR04MB3190.eurprd04.prod.outlook.com
 (2603:10a6:6:5::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6PR04MB3190:EE_|DB9PR04MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b3ab74-d32d-4e2b-614b-08dc263dcc3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TMXiSc1J52Z7SucxM9IFiB/a/w1dQFQR1OhtyR+7YqKGnBLlKZigilpUqLUNawfVu6624Af7xlfOhVaE9706r8GQszoY3gwvRVdMmCun1LEzAl/iHH/YIgbFDqqGasWfNJyQTVWv4U0l1EclHRCdlWscQrxgqqrXqC/FL4BVQ1vbdCyDZ1DZiRbrsxj+cP+FM/5U8V5auVfCwJ0ZIHTGM9ZTXfs25r1PrdR3q8THbrxYkuDEr8whizYc8zQNXE83lzujPcFvqNB9hVKonl+4b2eKSrU54qrlLWs1mwv55EZzeclg8mpEXGbppJQ5CHXB7BWZz4I0Qo3hPutq6MIcHkRN4NYtC9k+5ChG25iUPkgOJbpbzCv/AN05Caw/2y0IU/yP15HGH7K+9typ1JWkiMB2j779XHqTXF6HYR2bKrg1GyUFAd0wXmLsOvHGulOpqEaII73u4oJZLg/Gm6RJ02Bs3DRiq9LdPUTZWQZqo8B+znK6h/rJncE2c8v34r3Suj1PqWeIQR6OFXTWFZE5O4OjM6DzMXpgMlseMvnFlhYc4EQ+5FBLb1Ljzv1rU/t3uKZyvQ3vm+lLTotVA7xFrnkicBKdtqRRX3ffUJT8twwQ746tV5uFKUylUmBSqw84WQZrKuQsuzJuH6vEZrPkcA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR04MB3190.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(86362001)(921011)(26005)(1076003)(2906002)(6512007)(6666004)(44832011)(52116002)(6506007)(36756003)(41300700001)(38350700005)(2616005)(83380400001)(6636002)(66556008)(316002)(66476007)(6486002)(66946007)(8936002)(4326008)(5660300002)(478600001)(110136005)(38100700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g6RUF50shrzfgYNAVCXAVPSFWbpqAetJhUjCQqjECu6xT0181w32l6JG0oe6?=
 =?us-ascii?Q?JkxceExbHgphVI484VFXNdcyAvEwhKJ1S4wZj5r8NHXjVNJnqL1kB/eKKPOv?=
 =?us-ascii?Q?dYNVX6cI9H5dWT9G+8VVaSLKTE7sWlu1Y+Tkj4eQkl394jNPrF2P98iOdcj8?=
 =?us-ascii?Q?C2vY3hD7sqWqxdX9NrMm4YepVe8D6665ROl9eJIRlhMUdAvqTgYMIo4XAMZI?=
 =?us-ascii?Q?f/mLhdTk2uPu1+BuDBA6IvNAlyb4mAbHZF8fmoPvwH0N7VJfcofkyDJETvYA?=
 =?us-ascii?Q?sE9Do9O+8XW7iCZ1ESpPfG5FB7GsfYU+Q3dDqWRpPgxTPtucN7AKdFsOttvg?=
 =?us-ascii?Q?HV6czwHsAoMtPrEN9UA4AYi4e1sTWi2KFucpLnJCA+IKN8ql/TMM6NDPrvDb?=
 =?us-ascii?Q?z6qtcPh2bVaEWqs6CFvHQFt8KsXvmEVI8E/yHmrj0CULz0uI+XicKYBJQJ7H?=
 =?us-ascii?Q?X/NVabcMghxCJoxD3i6SJWkiL7JNXB9xTwiwsczf2OGpzGfFMCEfgO7y5z4I?=
 =?us-ascii?Q?F7HhKifvFp4OHNYu44WJZ5+NEO0NqOulbXzE0zRt8od1eezoecF5xsREz2qZ?=
 =?us-ascii?Q?V2oqY4c1BN5f63gMZ8j9ZEiDELWDEpDDT8v97FDEOTTrYUt9szL1R27v3CxI?=
 =?us-ascii?Q?OPES7aQl3jjFhQUzvv0nhQmwMqcWhIrUsj0XQtQ+DKM7yegOkwKl4adoLssb?=
 =?us-ascii?Q?pINIRw1tycnF1nkrZVbF9ITcH8IceKATiPqmDAIPijqYKsvRP1F/3jVmfrDV?=
 =?us-ascii?Q?mPAogwVQ1jHDZSVUg/CU+0r6FKPAWo+QUadSOuU8Yc3V3u53knr5h6DSj1Pd?=
 =?us-ascii?Q?Q5tbPYJOwZEFxIDKRVF/IczVSkwuA2OzToVQmI2s/e/VuUa2OAkP1qe+iWZk?=
 =?us-ascii?Q?NGSkDCEDxo7Md9PHLBbGBYDa/vg6amjSnacm6esT/XA2/7/W8rTIREsMCo5T?=
 =?us-ascii?Q?ZkMLESNvBvGYsx9iwaW+t+pjbdkWkhY/94GAei6faSogVB85MxDQ6YUERkbI?=
 =?us-ascii?Q?WEUZKGer3S0Ji6x+ubAaizOn01TImDlKOWUgy0jgSshUuJHo/ARHuK5Opp5y?=
 =?us-ascii?Q?k/MOEUqCEKA74cX9REW5J6H/Q81u/22qA4tctmjmDP27uiYgPQ31RnbWTZbx?=
 =?us-ascii?Q?CpOricyUPdfwWdAujXzXSLnp4BOiqL8c6/Lz4BSx3JiVVZYDVvm1x4LjpeWW?=
 =?us-ascii?Q?bIwmU+TykoYWylYAiBTlFiLP5JrK8cenALijxo8Anua5vhmKAfvJXwbtuVnj?=
 =?us-ascii?Q?Pb8c5nwuhRtWm/3ZQLXQLQAgKPoA3SWKWhprzYVALkouHzdNJla9wVJfTHez?=
 =?us-ascii?Q?NiIB/ZlUubMcmmvRFVeyra8jgorPNes2CXP2UYfZrPpQ91HzCo1g6XRHtuYT?=
 =?us-ascii?Q?d72wJUjGParZk0f54U3BnODnHeIndzXjZudCbhuPIAUj917SHFVZ9tQ9DEBN?=
 =?us-ascii?Q?1LwE2FDGVXI5EQJGxQssReUvi7Jouxr12xa6NzemjEVbO45OO45/UYld0QuL?=
 =?us-ascii?Q?rRp3RRWxx+3RD6VX68HeQO1T0icjgM5Rxd2JTH61PbiSQG34qR+XOCCaMrI8?=
 =?us-ascii?Q?msIq/XFt9r065oBsIXgPnB8vs7D1ENJO2rdfOmiqFEF4fG1SLoKE01zcOkTp?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b3ab74-d32d-4e2b-614b-08dc263dcc3c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR04MB3190.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:30:04.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERieqGRgRX8MgYEefSwTNTNoEFi2g5i5sIr3DKm9FKjLYzMVqRdW4Je2nwjobADLQf9zJHlZDM9/yUcp2af+pYLXuYDBaYXKdaCVN2jOpY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8265

Issue:-
Multiple crypto tests like sm3, sm4 xctr and polyval failing.

skcipher: failed to allocate transform for xctr(aes): -2
alg: self-tests for xctr(aes) using xctr(aes) failed (rc=-2)
alg: self-tests for sm3 using sm3 failed (rc=-2)
tcrypt: failed to load transform for sm3: -2
alg: hash: failed to allocate transform for polyval: -2
alg: self-tests for polyval using polyval failed (rc=-2)

Resolution:-
Enabling CONFIG_CRYPTO_SM3_GENERIC, CONFIG_CRYPTO_SM4_GENERIC,
CONFIG_CRYPTO_HCTR2, CONFIG_CRYPTO_ARIA as module enables support of
sm3, sm4, aria, polyval & xctr.

Signed-off-by: Kshitiz Varshney <kshitiz.varshney@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0a90583f9f01..bc2bfc7c61b0 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -466,6 +466,10 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=y
 CONFIG_SECURITYFS=y
+CONFIG_CRYPTO_ARIA=m
+CONFIG_CRYPTO_SM4_GENERIC=m
+CONFIG_CRYPTO_HCTR2=m
+CONFIG_CRYPTO_SM3_GENERIC=m
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
 CONFIG_CRYPTO_DEV_SAHARA=y
 CONFIG_CRYPTO_DEV_MXS_DCP=y
-- 
2.25.1


