Return-Path: <linux-kernel+bounces-23647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B70B82AF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5CB28202A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84DE171BE;
	Thu, 11 Jan 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="oeNtzQCL"
Received: from outbound-ip24a.ess.barracuda.com (outbound-ip24a.ess.barracuda.com [209.222.82.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4660011733
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by mx-outbound10-23.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 11 Jan 2024 13:19:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwBgCse1Gc29bKdcRe4Dv4ZpqF1GKlSIqbHSuuTLJgI5+CqvdpzFDExEugktG5SVUqXHDY84guSCEbZRfgcYAvHeLSwPDZvYpXxpqCTCwZOOij+vLrdx0UZ0YTESx18zGsnUej89emEZqcyeb9rh8v6VSXRwB5vxvKo2pdCfLyMQWJ4FbNLkpHaKtqVYC3EOqVfgqVuUzCDC1uh3+ObrYqGWG9G7RdM9+r6Vrbd2DwHC6jJ5vW9ZeMPpcd69WgSv58lwaYQtMM0OJQnMje6ik+O8JG1V0jOJuuJMFc/5o6pEmrIMa+YsUNk5bYm0lUDcYPv6SXVc9NCEUXlEFj3Gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOCS0TpaUB8I9LuxUOYst7LI/CmB3TfZkzWRTp+9AMo=;
 b=A3XD3L10k2qFPOIqg1KtswTRzMGQuX8+B9Ot7rEbmRUQlt54/08RBK+304p9W95C5JK6LsTxGnmI7l83UNQxLR/+pGTtjXIRCTPIRid4iKK1tjsl0ns3HK3QE8m8OekdEAIUp02Be/smLM3wiAMUd7dEBjkKCd9Bo6mCyZlpbtmiM51rgLrWLvC83b10jo1Bi+HGskRym0PfaVzunIcTWkMAAg9VFIc74jj9QrWwcIPgXAab3WHIC6I5lY00gYUlOcq+VkZy1HK3cibK8epUFAseeprZLlf5YRBb4KPVYiprzYsq1MI2P33zxoxrMSqenm/HFGqt5Uh57z1Dr3qVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOCS0TpaUB8I9LuxUOYst7LI/CmB3TfZkzWRTp+9AMo=;
 b=oeNtzQCLQnGTfI1lVvqMYD9dXAiAEhZq0YpqPp5lKBNe6pOtvbSCPA1bakxFI51fJ9+KLSfvE7MH6vZWoZGLO2yh/aBXdagx9YamtkDZ/ZV181kfXmMEsIzF7SF9NADJv4O4TyGz8BuIA2qzAnh065D3RMWLR+d5Zh2iP9Yk5bmD08L1VYMcs9klGRlahQGV02OThGj3ww/u1KIaUTlTQ7lnnrS0HxIGolX3FecvaWy2nzQeeRn/8Hb4zedS4jjPb+k/+XmEou0Be7bWTkexuviGZTMWvWlXWkDOg8UsVz3W/YMXxR3Y7pbtxcKUVGq0kuoE3eMAoDaRokahQot6Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by CH0PR10MB5355.namprd10.prod.outlook.com (2603:10b6:610:c8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 13:19:37 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7%7]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 13:19:37 +0000
From: Hector Palacios <hector.palacios@digi.com>
To: bartosz.golaszewski@linaro.org,
	linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	haibo.chen@nxp.com,
	peng.fan@nxp.com,
	hector.palacios@digi.com
Subject: [PATCH 0/2] support i.MX93 truly available GPIO pins
Date: Thu, 11 Jan 2024 14:19:02 +0100
Message-Id: <20240111131904.1491496-1-hector.palacios@digi.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0231.eurprd07.prod.outlook.com
 (2603:10a6:802:58::34) To BY5PR10MB4370.namprd10.prod.outlook.com
 (2603:10b6:a03:20b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_|CH0PR10MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1b4633-9f56-40b9-f452-08dc12a7f5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f+I8hwbO94cH3Cr1NK0IpdOofr++vf5OvbntJiSsFEe/vd2GVbK5uEQKHWiz8qS+gNk4iDkGl+ypPv4Ivke6GCj3/Ws+s/2xSXcAKAbv8bylzQG7Ew1lRL3Z5DE2oiFtdDAXqQnHMHtE5rrZPD67h4KS8hvuCk2dcorHVs2a+oA1Bw9+iJqE5TyPwYTl3oo/IHxnZ8i4Yqw3mRZape2NV2/wWl4M+8hvyJ/pclEE0jxP4sne+Fuo11TKwA5NGLrdOhNXybIS6Bg4ooiYObeIIV+orropEuG+YVjVsey+tX922jQu7Z9G8a5lZicIrTvVadiaUpWO5P2y8PAUrz7ZdblLUdtz/kW8mP40/gUIgF5ebrzgZf7WfXYH1b07VtiDiZR6mrSawPe0pXxjsxFVYPO2bdwpcVjmsW5/QWcwIjRfGkBJstjO2PBeKl2w3tp6ncvXeub6Xnlw+QjZx28Nqoye27uzfUrSEjlI1kMUDcVbSLO9950iVkE4O3ZalMyPQ6ymttAgf8SwpoUO4BOCEegBdDNMWU4BGpn5WuLGYGDcRfT2C/oH3GuUx3PrdnF5ozEhA8aO1j7kzkOZhfeplJIZnMnPkuJYa324rnpclqTxaPG3fIeIdLEyZWcoz5L2U/QYjWyr5Z/wkKu7dMg9wA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(4326008)(8676002)(38100700002)(316002)(52116002)(5660300002)(6506007)(6512007)(2906002)(4744005)(6666004)(8936002)(66556008)(66476007)(66946007)(107886003)(26005)(44832011)(478600001)(6486002)(1076003)(2616005)(83380400001)(41300700001)(36756003)(86362001)(38350700005)(131093003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KFWXBG8U9hkO2Fo19FbQ5c3j43vDEnI8PZUUW/XvxYEfrTaCakcPUR4X6Diz?=
 =?us-ascii?Q?z6CWf7uRxmW7AelfUZMPkjmMrxYrK6hyqyL5HB10cCzNt6Duo8KPTL39p2fs?=
 =?us-ascii?Q?A0L01Md9LW2/j6eeBl7RB2RFZfnJwc2q/hFiZjc0I5jEySfdHR0Xr7Fgtfwy?=
 =?us-ascii?Q?SzRrZUQqxHlgTE5dPvLx/2KSNypp1NmbIRx3rEt8abxow7adPnJWsgNLd0bb?=
 =?us-ascii?Q?l6HCo0cDPWZ86xAS/yPIL0EYnsPBLCQrBaBNAOP2ZtclMA1C8/+ib4KMwwvl?=
 =?us-ascii?Q?EyYfMyMwgMHGWAMRW+5LaGiY8YYoFNtfUz9t0eYo75iZXlWamK1mZp32ADEz?=
 =?us-ascii?Q?7l8gWUC+3Ld/n3kK77gjxi/KePypg2a5u3MbME0TpFQHgLNWsfaOv5Dk9QRd?=
 =?us-ascii?Q?Yx7sVOU70P/aHooijBzVGwwtgsUhl+Tbih/XcADY7twRK8xReedcnLWhQjjD?=
 =?us-ascii?Q?K76L+PNdozLoSdBZiU3EjAF8YnqlBIU+WWdbm7MCcjrccTYGrP0OquW+IiBT?=
 =?us-ascii?Q?or99rX8xfWLPN/1X392RBnmWM/TDedobhH+oKAqYSkueiVemcT+Wp6qAw+3/?=
 =?us-ascii?Q?zx6e10IXI12ziZbpy3g22M9R2KFx3gqa1m5P2ZAkxtCG/nWYe9RnomXUi7cV?=
 =?us-ascii?Q?grz0Qvs4xalurWr1WDREbDC+bgnjVF898s+KaehKpcI43qdgEU8DayjZRmvM?=
 =?us-ascii?Q?BX2WrlgMV+iPH5ABHV9Fd+zYArVOpfuYXuSKCpFqfxLOGcIN1JHgSh2+SVZG?=
 =?us-ascii?Q?F/h7bjRQxWqWoO32uBC4Hf+9klMpkvdopVmc/E+SWsBoCTHuem3ICzXvvAGM?=
 =?us-ascii?Q?+O1fbKOMCoKmX2V3JYzlWnz6trK8+iImi6Xd6F/QKpZs4e72FBK3CJ4lRkH9?=
 =?us-ascii?Q?HuIXI1VkbxLsZh7IH4LRpcFe4iJjvm/pirm3W4ViqGgkARilq3KAUwAMCCnJ?=
 =?us-ascii?Q?elULfa79L5hopFbhZGBWcchcZ2ot+HR5BsIHOd5BGbt8lIG5W01Bj/SO5nrs?=
 =?us-ascii?Q?c5sn0lgW1jQ2o2TQg1UolydxIP6LB+s4AZwOJxwn9Ue9tC5QsvIhqWOahUAz?=
 =?us-ascii?Q?7GM+k4M7iwT6Od0QpMezWVCc95Zoc57Mpq0QIyoRvmKEKd9FqlSLyNPXRhZm?=
 =?us-ascii?Q?z0W1Y7fzFKdbUyX8GVGcvTv5b0V+Cjv9a36iGxxulXN7xFHkaTmd8FoUxRp3?=
 =?us-ascii?Q?7d3+nDmrSHZnHdBPz1M0yqUwE5DDd9J6GZEqEUa9LD0/kDWB3VpfxVf9FKY/?=
 =?us-ascii?Q?FPhhdGtn2SBePQb7VQD23Zy495ThPIWsluHO1Vj5Uz0hBNVnzBFazn+1wog1?=
 =?us-ascii?Q?62IAEB0IaKI8+6GoI1PiuSfB0OiE6PwZnropwNpsRdXXk8xdJellcKebdQ0Y?=
 =?us-ascii?Q?D8TNp/gqyjQf6+Rgcs328/iRcsr/Fv9gBLfPJP8D0Y1R2ksiUgygnCIMSXmN?=
 =?us-ascii?Q?tPk5uUjC6BXap3xEAf7UWiAFaQuCdg32KfaL5biod6cM8ANuHhuL/bou4ZCk?=
 =?us-ascii?Q?qvSW4b1rE0va03J2EF00TwJd87ObU8yaXg4BDsxpJySTxffuP5P5PuQmo//x?=
 =?us-ascii?Q?kUNepCBDvCGdsImbllxWOb/PaxSmTroKaUVkK2lX?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1b4633-9f56-40b9-f452-08dc12a7f5e0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 13:19:37.7282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMuABU9hQeRfK9K+HsZmI7y5tinSFKNw9+fX7oPZTWr1RylDwpSQ5JhKBaC8EjhYQxV459LPFyHeQ4M6WPb7bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5355
X-BESS-ID: 1704979180-102583-12474-13747-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.58.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViaWlkBGBlDMPNnIwjQlzcQsxd
	AkzcDU0CDJJCklOdki2dTQJNEs2UCpNhYAHdYdNUAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253449 [from 
	cloudscan8-97.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

All four GPIO ports of i.MX93 SoC show 32 pins available, but
not every port has 32 pins.
Add support on the GPIO driver to 'ngpios' property and set
the truly available pins on the SoC device tree.

Hector Palacios (2):
      gpio: vf610: add support to DT 'ngpios' property
      arm64: dts: imx93: specify available 'ngpios' per GPIO port

 arch/arm64/boot/dts/freescale/imx93.dtsi | 4 ++++
 drivers/gpio/gpio-vf610.c                | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)


