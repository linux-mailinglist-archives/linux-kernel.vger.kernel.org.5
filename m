Return-Path: <linux-kernel+bounces-127125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A99A89473B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC5A1F21BB0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0975646D;
	Mon,  1 Apr 2024 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DlJOexxB"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2091.outbound.protection.outlook.com [40.107.14.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852C1EB37;
	Mon,  1 Apr 2024 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010341; cv=fail; b=ttWNhqSP4spEPZsiAQdnkm3TUdHTQkAmCwSj0TWshdJ0ZBDKfMekhyLYHtJaJ+l8i4zclikUL185YWiQOjgmwWI6VfijkplnRFh2aPB3M1DkF8p6M8EcTSgV93NCZ2gkjCBertChIIbsSDWzliwUjH92KGzvgCVPo3Yxcfgfv4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010341; c=relaxed/simple;
	bh=/0aVOYdyGcvIQrQjnF+wasKNqxACUz8BewiqtDQqwXk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ukD1QAOe6LEhmojMzIObtf5dbzuxi39+2jidYCTPFNYmxAHF07FEuEPqIOIhB7WufmTyjrBwSaNp4Pvny5YWwqjXZrnNIhQWmBx1zsj6u+9wCSPFSEUEpL/ZBH8oQ1sr2yNuYB+1+Q63zZ3k337wIgFwdT1l4rfsLTW1wXys76I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DlJOexxB; arc=fail smtp.client-ip=40.107.14.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc/uG2jq1j4Onp+MtNKuSVyVuWclftHIiLd/C6SciMNz2e+YxfBDeka6W2d7EkAIrts1N95V9OK+pLXDwukiq7bcqbso4dCNsWrA5L47QhY7OC4pCtPkOOCR4KDEPWyR/gQrSso4L2ZfL263U4RIie+X11vvAxbPnKEy3rxDpfJ2gBbKrCDLUF3SEl7fj8V83O4iuTAANN1vSoU0FYbB4eZIgUIoW5M4ksoc9ZcWBIqd7WSnkhooKvC7fyEewMTRdTlhSo9ZBawnxckWlHBktzZg9fP97HURwukCO7eO0BAa50kwhkbBWf4UjY6A9fPNwqZgq53cQl4DrbZt0AzzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpAnHiqIO4RoL+almOYNKwg6fdBeaSCeU3bVIvMWALk=;
 b=Cybh+/rm8PuTE3R5YqYsj0T/n4wNi5X356Y+9tHxc0nLqQyco9v8+0ijf/qhykWKG4CegRcP+lZC7rW4kw+t+GmJ2K9Paz6uIUND2KG+8UA3hjsHDJwmrqLRXbTqTrCelZdT0S2Dmnv7MsGgcdWAfytXC2U+5i9WCGP3KSHhn3f+6DEb4r6QFGnXP83tjFEggy6QPu2LOGsJCtHDdxOPvbAb5UPKLimKZiS3Eb/N5ZRsd8UApfP802lZYKiRV8AnDHX7zBP+DbGqPvsoWVTGeYnlAQcq8prE0Pq21N0EV7j7LzAbPfPOoHOZ09j4vKdRRYowuevsWBTGezwqt3ca+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpAnHiqIO4RoL+almOYNKwg6fdBeaSCeU3bVIvMWALk=;
 b=DlJOexxBf3mGPhwk1/VMDjYKDvAtSkIMZn5/qO01Cvasf8/Lr5JgGOFjmX7H2U6aGraxMR8wY4CuqN+5GSSWTDvO1I//2wOr5cJlrMm+N4Tx+r41Z4uo8VTZdaitPG+RKmIRr9RwwtH1A/NUVm2zntbl4rSQyYyssdCf0y2wo6E=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 22:25:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 22:25:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/7] arm64: dts: imx8: fixed lpcg indices
Date: Mon, 01 Apr 2024 18:25:02 -0400
Message-Id: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD40C2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwND3ZSS4vi0zApd0yRTc5M0C2NDS0MLJaDqgqJUoDDYpOjY2loA/eV
 rmlkAAAA=
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Philippe Schenker <philippe.schenker@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712010330; l=1025;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/0aVOYdyGcvIQrQjnF+wasKNqxACUz8BewiqtDQqwXk=;
 b=+whKk230Y39+IVEnFSv6x9AxEO/Iheu6lyiwWquOheE3MTHvLLyO/E6gx0rOBsE7KLiZG3als
 BcrnQ6XH5XCDsJYBgMekezkHSbd843MrK1rCnKCBE+jCeCCLJd3t7EC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9976:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 Z/4UAdTuajQZR/CftmdH5DMlxlHTRDjizti38EKB+q5rsEY/jh10y8rr7F56pN7AqQ53MQm4fTLfob7lli7y/nCLV3whPGbZPXpRJLAxEcT4qWGxyXJLab9ecbcj8rj0TdoHXk1JC/TlE0a65pdxw0AEk/Khg+KfV9Fvq1hMrQkCYburkeWYDVBwRDtyCyMMhEcSHWZxpHAPuPg+g3NIS5HjcZhLedYo2EUE5+Ict/IIKIxRuLqAsqfbIeBzr2kMGdWDUTE9j5P3qtDQWOQ5oAFRl7XjdofJO/icfHe84ae/WcZDyLuLtOrUSgjXabzXSv4VzjomNRi/2vy8DtAZVfQd8c4tJVMYbvasdVrXckGHyXi6KguxcE9R4a6K9ITB2Nuf2WVyWycwQhJ6yvkM74cQ/Y76o+lM69KmnOfJnnmkB26QdW97ewIH9uOtujnE1zsFoMDM055T5G2gM4pW9ntA0jeVt4Os2UifxgL3UzJCsby+F0X82DSeyNtcNyuprW7ctZ0BYHEqO3yVdTHYAHu+UoDWFFfZzJxDyEj4feW5ARGsRyZfp4a6iXk7izenSpdl/vOuO6kLQrMi1TL/jgQHy5+BtQF1s+aTUZgPATM/cisFIlpLZ5yNfFDSb0hxGmYF6NhOC+5djBSIkZeTbUMWAwHYdKYr/cn3YIcH3rlCCJLaxARN58nnGahxRfy87HeQprKMW8urkwLkhqXKI/iCM9Fqq93G5UH6RgVShpY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MXNtTkhWQUxVZDdPZUtrQWVRSzg5UUNuVDhaYVI2UytYNFQwWldkZ3J4M3U2?=
 =?utf-8?B?eU5oMEt6cDhxZnJBVVl0dk9FQnMwOElhZWpQUGxIdmxTSStEVTNOQ2RqSlJD?=
 =?utf-8?B?Zi8vZElxUkNQUWcwUFROSXdiREt5STBycFJWU1NrUFVEdk9KeXdzTXNVOHJ1?=
 =?utf-8?B?dFo5dWNXb2E2U0dTT25ENGRJRWlDVGdWcFpWcXpoR09NT2pvOWJNSzMvOU1x?=
 =?utf-8?B?WFpPMk9GbllQUjU2bk9PYWdWK2xpL20xYVVkTy95cDlnVHhQV3g1RmhVQk9W?=
 =?utf-8?B?ckdxUjgySi81Q2lTd2IzSDhFUUora2JOY1BIeHZvNFV2U0NaOHZHZ0k0bTdL?=
 =?utf-8?B?WFY1ejArRHQyeCtsZjg4czNTVmNTTzM3SnJxMVVvT2V2blZKNUV1d25iTkFT?=
 =?utf-8?B?U1NLNGdBN3BBQUVsMkUvUlVFSEVudGxWYUtFd1Vqbk51eDJuV29PQWEwSURI?=
 =?utf-8?B?M1BiS1lzMWc5STVwNnY2N21hWnMxdmRKL0VySmtYWlVCd2YxZ2lyWEx6M2Q0?=
 =?utf-8?B?NzNZYVVwdWYwODlGVHZSYWR4OGRVUHZrZ3JkVVBDWm9WR3VhZjlGYW5wTjhO?=
 =?utf-8?B?dnRrdmFZREhNV1BiVFIrZzIzbjFnWWRDbHZabGNZZzdZVGtXdFZyakZuUkNW?=
 =?utf-8?B?eDRvNkNUdWVsU2xLZm9WVWhOYmNGVzhlMFZ6R1haL0NDaU9xWlF4b2luMk9o?=
 =?utf-8?B?ajRBK29sN1NXZzRZdHRnbG85SDIxTHc1a3pYeXZSTUFLaW5tWXhlSEcxZjkx?=
 =?utf-8?B?eWRrdXRKRnJ3M0g4ZWdxREJCWG1XU0EvczA3TmZtY0RqeUxuVEFOYkx4Vldr?=
 =?utf-8?B?dzZEVE82eU9GeWE4bEtSVTBEaVdDZU9zL0NsODZuM0txOXIrRXQyb1FkRkNq?=
 =?utf-8?B?U3NGc1VQNy9ST3pxMkdJK0QvZUtnRWU2UU1GelFBT0FVT3NlLzM1SCsvUXRW?=
 =?utf-8?B?OHNwL2RuRnhOOVpiQ1FXRUo3OGVKYTNuS1FhM2xDaWI3eXpVb2dPTzcxdWh5?=
 =?utf-8?B?Mm5yQlUvaHZrbjVLUkpYNFYvdWlmcXF0dG56RmZHVEdTVG9mOVFxelhvN0lH?=
 =?utf-8?B?OElkWTZlVkNWTFJNeWNyYTNzMURmUlFOVjA4dlVxZnNkV3JxK3hoTzJYa2Jn?=
 =?utf-8?B?R1NOdldCUnFZQ0V0MisrS2M4aGRDUVEwSDVCUjZmZW93SGNoRm9WTUQ0c2Jm?=
 =?utf-8?B?RDJXK1kvOVdYQXRCcTc5bVROZnFRVjNpYTFiRFRDS3Z1V3lsSVp6RFMvbkJm?=
 =?utf-8?B?alExNnhSUWxVME80ZUpvcTlHUjQyNWZqaXU2czVkd2RqRVBkTUI1dHVqbUE4?=
 =?utf-8?B?TkM5Mks3dmd1RmY4Y0ZYd0JaVkMrWnJlZXNYalVIMXZKUGxqLzZvalpnYTQ5?=
 =?utf-8?B?ME9kUHhldnd2bXYxNHQ4bXFhVjBJK21PWlFBRFJuQjcrVk1OVUtMNlQxODRh?=
 =?utf-8?B?V003aGZteDN4ZFNDd1cxYmw5aTFLT0NPZjlXVFg4ZU40K2J3RUZSQnU3TGEw?=
 =?utf-8?B?OGx2K0lnYks4MlJXbjZoYUhsVlg5UWNwd2laQ3JkUWxmRm56OEY5N2ZISTdB?=
 =?utf-8?B?UUhFbHBZdHRWb3VKMCt5bWRHSnBhSjRyYTBNNFZIQVR3UHF3NWdTUjFQQnNP?=
 =?utf-8?B?MzFjeTlZYXRxckd5YitZY3ZuZGE4MHRiYk9vOTZERElCUDJpZGJ2d0h3L2d3?=
 =?utf-8?B?Q3pISGdvZVBUOTR3YnErQnkxK2huZXN3WVBvT2p5cVpYOVhLOXlZTWNSQW9F?=
 =?utf-8?B?N3hRSW9rL0I4cmVmYmtQRFBzVHNjbG1DVms0RXlhZUExc3lhWm16UC9BNzBZ?=
 =?utf-8?B?S1U2WjdiQ1pDMFVnakVOaHE4ei91ajNvL3poTTk0eTczbWFVTlJpenFnQ3p2?=
 =?utf-8?B?T2o0ZEdKQktmekJ4UXZycXk2R3NLd2NNNlEzUGhVOWUwMVJUdDZXcTRUZklJ?=
 =?utf-8?B?NThsRHVKd3RIWGIxZDhnc2YwS0txRkZzQitjekZtOEg2a0FWdFNBM21PRDN0?=
 =?utf-8?B?eWlHR2JrbUw0RlpLN3lZeUZzRDVqL0pDU0YrMEFjSWlTVWlrR1ExbG1uVFRp?=
 =?utf-8?B?VHR0UDd2OGtZckh6YmxLbUNHQnhJb2xEbEowME1GVURlaFJheWNSK1BOUDhC?=
 =?utf-8?Q?CwY0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2926a6ec-4389-4caa-91e1-08dc529aa655
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 22:25:34.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSNdtiDodfNW4NoVEs7dVtdb0igwzsChpi6Hrz0s3L1fCJGcc2h9HI9neTul1oGFuT5j9dnLjUxNXh6yDS0Plw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

Arg0 for qxp lpcg should be indices. Many nodes use index as lpcg's arg0.
These patch fix this problem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (7):
      arm64: dts: imx8-ss-lsio: fix pwm lpcg indices
      arm64: dts: imx8-ss-conn: fix usb lpcg indices
      arm64: dts: imx8-ss-dma: fix spi lpcg indices
      arm64: dts: imx8-ss-dma: fix pwm lpcg indices
      arm64: dts: imx8-ss-dma: fix adc lpcg indices
      arm64: dts: imx8-ss-dma: fix can lpcg indices
      arm64: dts: imx8qm-ss-dma: fix can lpcg indices

 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi  |  4 +--
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi   | 40 ++++++++++++------------
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi  | 16 +++++-----
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi |  8 ++---
 4 files changed, 34 insertions(+), 34 deletions(-)
---
base-commit: 8d04a7e2ee3fd6aabb8096b00c64db0d735bc874
change-id: 20240401-dts_fix-5b574f831918

Best regards,
---
Frank Li <Frank.Li@nxp.com>


