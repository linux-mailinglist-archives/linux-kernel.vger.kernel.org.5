Return-Path: <linux-kernel+bounces-153952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B388AD544
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1116283D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6775157A59;
	Mon, 22 Apr 2024 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YXuOUOxG"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B30157473;
	Mon, 22 Apr 2024 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815445; cv=fail; b=toGHIf41r7n1DZYLpla8yhmqWKc4DxORwziO2griA3kGF2kWiYFm7B5UBRRR10EXXu4p1spfmtwNoEiYdnfGSdcDJjRbz3PAyFZsuJWgLjap+Q7Ugyh0zb+Dl1Yj9sxhO2lYllXgAEY8flwYPMUGLi1/CwpPvKiECZFe/TFuFb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815445; c=relaxed/simple;
	bh=wsZtmo1X368uxHKKzJYqIGOBNQUZdp+gNhJ2pSukOZE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Uwl3X9gvM/UpXAp1gq0fYio3p17Aatz919WfsE9/a/DOJvqQ5XLPaz7NpZQWinmJTQD7+2vocz6oZBSSK0JLuvvB+t3a2eb3V4r9Odo9vV5fchezUG0C6KbalvlUHAkqRngx94uevod5BPAKMpblSKkIG63xa0SK5KePGhEvS38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YXuOUOxG; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf8i08K4wq2z2yW5wV/Ii5j3/gR3pu0ly+K9rzMx5+RkICDxGiakA8uyXJmz30Hnu9vm9fggMv/DotsCYNutdwdbbtyHZBJZCRM6/9K+ZR5cq5e8EK3US21+b0EOciiqgNiMA6izOoMVrg08A20w4PXnnw+nE0EKT03WDwZ8V4hhbRDWL7pGnkT6osbmpPtCP0STVB5iSuTBcstuiJQ2UU9kpqtBmQ04PHFiTHzZdeoW+SUvBXX4lIlqpE+nGmEsu3Zy6+U4r9tuFi2k0sOhOKw9MajQoCdZ8+ksIYjRqVqtQOQakFaeda6omVCQ+JLrq4sAMos8fYQVAUbVHnjoBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKcoadm/C24ImwafKopnSSAfmE0qzaPiRGSTjyPpqwA=;
 b=VLi16PeEpee3Aoa4kk/fXmLqAH6xrxP6MvNSPM+2N/E8d0lllN791DfmVbeVibHQ1fKG9nvpvnAmDhU3AT3gliwAxyckD9tlNq0NwGd6nVn6X32yjUDEA/DBrprZypfOO3QedDFjhwBf/xYGL7pdSpU0x/sgP45njFLIJzmIH8+al4K/71gw43pue49zX28ekZy/XHh1wcuImNa2BcMDEXSKsxmmoaOT1dxANui9MBEC4nHkuK+JPYyP5xChcDbbn7AlZTBlyTZi+j3nqtXvxiExR4H2BaxZPUpmGKSixAPCgJyngiMbMfJXK2v/EbS20bJ7sTNPjiu5nwepwzRtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKcoadm/C24ImwafKopnSSAfmE0qzaPiRGSTjyPpqwA=;
 b=YXuOUOxGbiWy66NWgi8JkcXDjSghwp1ZtGFyEfyNY4fLiJiHGH+e1DP8d6glt3xgDxSql0dONBjlvt9eMFk4cSnXnECynRs3Bme5GNBE1r6iE/7ziyzOc7rtaUpg4JlEsYaf6ibua4qRQLIYksXyawg9W+R8ZPNQ+6wDW5GM2AA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9734.eurprd04.prod.outlook.com (2603:10a6:150:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:50:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 19:50:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 15:50:12 -0400
Subject: [PATCH v3 10/10] arm64: dts: imx8qm-mek: add fec2 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-dts_8qm_audio-v3-10-680cee731ced@nxp.com>
References: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
In-Reply-To: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713815413; l=2428;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wsZtmo1X368uxHKKzJYqIGOBNQUZdp+gNhJ2pSukOZE=;
 b=tB6TGT4NpEWPL0QRi2Azna/jrLu/L5XnyJUOaWPm7rFnh+rkRY4nxJX1xaOMswQQ/XUReKhr7
 lXQLUmx91rnDqzUGa+E2Q1AdgKuPuc1AKXR8wyu/G5+eEs1xC/1noMm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9734:EE_
X-MS-Office365-Filtering-Correlation-Id: edf2dfbe-306b-4f32-8163-08dc63057a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3U5U3d3QzZmQ1FQNmJURVhLemlCOVdtcHNsMVJZNUZMRFBSMUNxbU5xaWZi?=
 =?utf-8?B?bVYzWlc3elpCU3BHZDlRTFdTYVhsaEhZMVJpUGpVVVJIOHFWTUF0QU40Nlpa?=
 =?utf-8?B?LysxZ1dialFxUjZRRC9nY3dsaFdCbFhXQVNML3YrUHVNRjNwZlkrSFBReGZG?=
 =?utf-8?B?L2RBWmJZZ3ZRVmI3TzM5SFpqQVVoelJiTEovNWdvampsdTJaOHhFSE9zTHVw?=
 =?utf-8?B?VXZScEZOQkpqOGU1amQrbEE5ckVycUc0TjFPL0x4NWxGSHBUZ2M5a1hjeEFj?=
 =?utf-8?B?Zkc0VmdtdVJpSDNuREoxMU1WRmhJTlN2bmM5emJwOThGQkQ0NjArcWtFNkc0?=
 =?utf-8?B?WkFTbXB0M3duMTdWUS9PMllDZXpGU005YWIrUUwycE5hOVNpZ2wrNnF6SUlh?=
 =?utf-8?B?aDBHdHovN1lKQ0hpcHJMUmRYakNvemhUTVcvbHVUZzR4a0doYWJ3QXJYZGJy?=
 =?utf-8?B?Tkw3UXhqZGVka0xUdElRRXoxVFlkdFVEeW4xeThOalBCUEJSMWplR3dLNnA3?=
 =?utf-8?B?K3c1RVlQUCtZNVFLZ0FPUTlyQXk3UWtUT1JoalQ1WDdMaklQWHBOSjY3cXd4?=
 =?utf-8?B?dmpYczArUTViSWRIL2NudVFLc2lERnlqY2Z4Y3VOWEc2SUIycWwybHpucEYy?=
 =?utf-8?B?ZmR4SXVaTG16ZGw5RVFMWE4xRE1CTXZ3Rk5CQzdPcjR0RU10M2loRjFJWGtH?=
 =?utf-8?B?L00xTzRMREhNT3BtM0xXdUpXS0tOZTR2MGk4cFZ5UVlydkJuM0JYT3pDL3J6?=
 =?utf-8?B?NDU1bktoNG5yVnNRZTZuS0dOcUJSUzJGeHFPVWdYSEt6cVJJZWRJVnZwNTdH?=
 =?utf-8?B?N0N0RFEyZ1F5MThLVi9KdS8wY1QrZHZ3WjJGQ1haeElpbWpVdCtxbHZ4SDNC?=
 =?utf-8?B?amVhUmc4YnFLM3hlRU9UdlNZdlRsaXlxNE1tWEM1REI1MEUybW5ERW9xcUNB?=
 =?utf-8?B?Y2FhSzJoYWxVaktPQSszWE1pUDRoQ3FheHFKMFhHTmQ2T0pqYnErQU9CYzNn?=
 =?utf-8?B?R2R0MVhnS0M5cHVydlJ1MURTeXBacCtEVjRiNmFraDh5ODI4TE0vaFNDSFBR?=
 =?utf-8?B?K0t3U0lCNFArUDJxemV5eTh2dndkL2lWQzRJZ3NiVjZWdlJTYnJHUC9QUDhX?=
 =?utf-8?B?Um9vZyt4d3VWOG84YzU0NWVGOVRicjVobnU1WVVleno5WWtkVCsweWlYUzRT?=
 =?utf-8?B?QkQ1ODRsdGJTbUJrNjFjQVBzUVYvcE9XVmJTWVI4UWFZczN2WGp3SDdkWE5P?=
 =?utf-8?B?WGRyY0x5NjVMelRWdUxrT2lCNHZDWEMrN3F4ZExiaVZkTnNHMVJKcTkrKzNn?=
 =?utf-8?B?cUYzMXo4dllZY0prT1ZraDVnQ1ZBNVZhZDhTUTROVlJqWDdKUVdSWFVpNHYr?=
 =?utf-8?B?WlM4aW5jbWgyMGx1U1RsNzM5N29PUlE2cWlxYm1KN0dPczhiSmVjbERVUU9M?=
 =?utf-8?B?dzhzR3pjV0sxNmtQTDhwQVNIWWhMcHBzeHRuMGRCd3J1K2hKa1pJS3I3MW9t?=
 =?utf-8?B?WE44WVgxZjZCWWVKQ2s3Z1pLOXpYRUZ6RzVNVWVxd2t6bm9xUDY5b1dQVENt?=
 =?utf-8?B?bStDMkw3ZWx3L0ZxeHR6VVFiRUJlQ2FtSktDL2xja2xxT0tYSGdtSHJ6bmRT?=
 =?utf-8?B?aWZwaFYrOFdveWpveHNNZFIzMnZncWk5Yy9iMittZk5iSmdvSmtFQlNFNFBp?=
 =?utf-8?B?cTJnNXJ5L2ZaMC9IRWtkcnd3eCttS0pETXl3dDN4TllWR2Q4aWJ3K2liMWJq?=
 =?utf-8?B?TlpoN1V4SnF2akNrTEtBOTRManNpOFVTeWcycjBoNzYzbDNjYjBmSUFCNktQ?=
 =?utf-8?B?OHpaSEZ0Mm02ZFVyQVlOUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0ZqWGVqMTh4VVJ3c3haSHVuU2haQWorOHoyZnptTXdobnNSMHZSdlFmbU9Z?=
 =?utf-8?B?QXhPbndUWENhNjUwZjNjQ05KTTlaR05qclFBVjJtUEVOTWNNem82aHYrMGpx?=
 =?utf-8?B?MVJySHdUREN3SndWM0pZNzNsa2s3NENqRE9FQ0NBbU1hS1hRcGk0azBoSnpI?=
 =?utf-8?B?OWpSVXhrMk03NU1Oek1hN2VXSzd5UFhjZGt2T1NLNzNhSGttSFBqUjhPRzBO?=
 =?utf-8?B?TzVOaEFwUkdqUktkRVU0d25sL3IwdlBIRXlZVk9WNHdCaTlRY1FaRWYrc3Yx?=
 =?utf-8?B?YjA4Rnd5eHJZV1hZZkY5ZUxHM29FVTl4MHpnZzFTY3h2a0k0YkRDdW9SQ0tm?=
 =?utf-8?B?dkxXMGxiZWlxanJVeENMMDA3UEtLNlF3Yy9JRk5HREY1bzc2V3JJTWNqTVNY?=
 =?utf-8?B?WUF0MWFUYUpWSnJiVnRnckROR2ZZUEwzcSt4WFNuUy9hVUxSNENmOUwrV2Fx?=
 =?utf-8?B?alNTNEtEemRxNG14R0NDWk5DYnVLR1owWmtWQmtWanRMMzZ1T3EwNlVJaFlG?=
 =?utf-8?B?RTF2YlE1YytpSnRTRDI1eDhNS3BYaVdpcWN0M0dUdUVFNEZqWkN3ZjJnQmx2?=
 =?utf-8?B?UWErTm43V0w3YWUra3p6QlBoYjk0UUhIVkFud20ydzFnK1hocnlOWmxHY1Fh?=
 =?utf-8?B?SFQxODB1NmdhMWl6bnJlSXlrd3RtWUcyYStYQ2taK2JSSER3MVp3VDdSZ210?=
 =?utf-8?B?MDRCUng1cHFEU1pzK0d6SFU4VkZsQ3dKNlVZREFWU1BGVUhhdzRRalFuSjRk?=
 =?utf-8?B?dFFFeWxVdXF6YVlNRkpITkpJb1hHc2VXYXo5U0hrWlN3cDVOMGNhSm56eFBZ?=
 =?utf-8?B?WFowaytGdi8yQTVFdHVBSEpHNUl2emg2cXhQcjliN0xKT2RlektYYU1pWDNh?=
 =?utf-8?B?SnpTaDB6QjlwZHpEWDBvQXdFVUZNRmRBZjB5UXdweU9DcFJFaG45TzhHMFZZ?=
 =?utf-8?B?MzU5ajRRMzFWa0oxUFpsaVZ5VlJRNDd5NjFoaGszWUloS1N1bFM1c1IyYjJP?=
 =?utf-8?B?OXFIODVEVno2S3paV3lrd21iTFdmZ1g1R0JMaEhUY2lhbTl6a2RKQ1hDQjJX?=
 =?utf-8?B?cjcxU1U4NG5DVHRrK3B6S0VqYlRvbThHRkRYWVZSbzdidlh0N2hDeFFXdVlm?=
 =?utf-8?B?azVXOVhlK1lCellmV1pUM0dhS2dqUGJ5OGNBZDN1WVgzTDFZM1ZJN1k1cFpp?=
 =?utf-8?B?ZmhKVVNvRHJxdGx3Y1dQclNOZ3p5bzlWTldEVTNKZlhMWlpuM2JPSi9nOWUv?=
 =?utf-8?B?RzBBQnplRmhKTXNLeUh5VVVaQVNtS0hqemJuNjF2RlppbytZUHE1Ni9zakdp?=
 =?utf-8?B?QVVmc29SeWE2MGNmYUhlY0xCZjU4TXU0cktybzM5ZndXYjh6R0FNbU1XYjBz?=
 =?utf-8?B?NXVLS1NWZE5IbW0rU012bGVHRXBRdXJwT1FnVFpLR3NudG1zOEFRQVpIWEZu?=
 =?utf-8?B?eXYrUi93OUVHRGY2TFF1K1hrditQQUk2b05Hc3Z4QTdoUjBhQlJlN2ZqM3Jk?=
 =?utf-8?B?OWZmV0dPdmlOMGhFelNXTjluZVlnbUFYL2xiR3huQVZja3JDQ05BQmhsN1NK?=
 =?utf-8?B?Y2JWdk9UN0c2dmFwMk9hYllzRWJWY2wyb0E3S3VjVjI0WjZFaHp3Z0VCRVZE?=
 =?utf-8?B?bEVaeThrMTR6MW15ak4vUHRsVzUvL0hxRWZkV1pZZDNjVi9FdGhRUWxtSmdz?=
 =?utf-8?B?b3VnblpheDFhcUYweDRmRGtmcXMrQVEwY3RlNGNiNW4yV05EWExBa2oxOXY5?=
 =?utf-8?B?akhmYkJaOFJ6cTVhVmJrTmhLekxTUGJsR0ZXSGZWN3RJc1EzSmNzeE9ucmRJ?=
 =?utf-8?B?Z2VlSkd4N3g0RnpiOS8wR0Frb0kzcUF0L2RYNXEwOFBDNHBVNzJRT2NiTHFZ?=
 =?utf-8?B?VzB5YVZGRklkVHJKWnJSelBpTDZPb24xS3JMRm44WFQ5TVBzZmdma0g5NnVw?=
 =?utf-8?B?U3dtRDdJOHFlUFNZTjAzY3VkTmZXWFpmODFDM0U3ZC8weWNVSXlxdHZyQkJH?=
 =?utf-8?B?MEl4YVlocFZkQVRlZ1N4TktyWW5nTnVTUVhadHhSWEdLZjRoa29VMnZxRkU0?=
 =?utf-8?B?RTdSNlBFVHJOM2x5dFVIZGx6UFJFelJoc1pyTVAyL0xObTNvSTV4Z0wrdmpp?=
 =?utf-8?Q?lqZ1hp7cQoPwo6G7/UScToAqO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf2dfbe-306b-4f32-8163-08dc63057a3f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:50:35.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aug1l3ee78Cgsrj5IYoq3j2lQcOZtWBHHCUAYlhPZFphUmtfb21rB3zE1yZdD6ozPDTsl/ffe4iKmaocYPkaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9734

Add fec2 support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index cef395e919395..570a9bf583132 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -40,6 +40,15 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		enable-active-high;
 	};
 
+	reg_fec2_supply: fec2_nvcc {
+		compatible = "regulator-fixed";
+		regulator-name = "fec2_nvcc";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&max7322 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_can01_en: regulator-can01-gen {
 		compatible = "regulator-fixed";
 		regulator-name = "can01-en";
@@ -381,6 +390,19 @@ ethphy1: ethernet-phy@1 {
 	};
 };
 
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec2>;
+	phy-mode = "rgmii-txid";
+	phy-handle = <&ethphy1>;
+	phy-supply = <&reg_fec2_supply>;
+	nvmem-cells = <&fec_mac1>;
+	nvmem-cell-names = "mac-address";
+	rx-internal-delay-ps = <2000>;
+	fsl,magic-packet;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -500,6 +522,24 @@ IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
 		>;
 	};
 
+	pinctrl_fec2: fec2grp {
+		fsl,pins = <
+			IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETA_PAD		0x000014a0
+			IMX8QM_ENET1_RGMII_TX_CTL_CONN_ENET1_RGMII_TX_CTL	0x00000060
+			IMX8QM_ENET1_RGMII_TXC_CONN_ENET1_RGMII_TXC		0x00000060
+			IMX8QM_ENET1_RGMII_TXD0_CONN_ENET1_RGMII_TXD0		0x00000060
+			IMX8QM_ENET1_RGMII_TXD1_CONN_ENET1_RGMII_TXD1		0x00000060
+			IMX8QM_ENET1_RGMII_TXD2_CONN_ENET1_RGMII_TXD2		0x00000060
+			IMX8QM_ENET1_RGMII_TXD3_CONN_ENET1_RGMII_TXD3		0x00000060
+			IMX8QM_ENET1_RGMII_RXC_CONN_ENET1_RGMII_RXC		0x00000060
+			IMX8QM_ENET1_RGMII_RX_CTL_CONN_ENET1_RGMII_RX_CTL	0x00000060
+			IMX8QM_ENET1_RGMII_RXD0_CONN_ENET1_RGMII_RXD0		0x00000060
+			IMX8QM_ENET1_RGMII_RXD1_CONN_ENET1_RGMII_RXD1		0x00000060
+			IMX8QM_ENET1_RGMII_RXD2_CONN_ENET1_RGMII_RXD2		0x00000060
+			IMX8QM_ENET1_RGMII_RXD3_CONN_ENET1_RGMII_RXD3		0x00000060
+		>;
+	};
+
 	pinctrl_flexcan1: flexcan0grp {
 		fsl,pins = <
 			IMX8QM_FLEXCAN0_TX_DMA_FLEXCAN0_TX			0x21

-- 
2.34.1


