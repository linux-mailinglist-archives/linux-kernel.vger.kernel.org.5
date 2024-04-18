Return-Path: <linux-kernel+bounces-150613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 471318AA1CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A67E1C21D89
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973816FF48;
	Thu, 18 Apr 2024 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XC0Rp+oI"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E516191A;
	Thu, 18 Apr 2024 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463784; cv=fail; b=rha5n3EEq04ah9ur1PBk07fNbwwiWWzOwzfg8EVePdXtB3o/a97i+uLWbRHuyz44LVY5OFp9pwzm9wbdb2G6wksUnQ3qRx/y68RQPf3zrb/0XfJr1XaKRNkDd/+9KZ8Ng5iV8vP4pcXfODylqymjYs+Enr5YGMMJNIT5zEzDRwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463784; c=relaxed/simple;
	bh=4jKHCL49kjHuCtkXiYKKNoZu6aGIslc4XTVMvfUruQU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bY7YZ6h1gNpbuACPB82VIR5ou6g+u7x+NwvddnlTkMUGA/avvOqco+3Y7998pt91g9+QPz7dv8rfb1CxBp9v+8GOZtmUYKegEkNrH8GgfGo7yJFLcNdH8RrQixuQgc0SIFvQiebS2wI4/NHgOE0N/RkqIij8xKUtZzWDpR0DVa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XC0Rp+oI; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwZ7p7Udzy7XJ0mevqJi/GU5VbkA6IVXcWgMPscDdQfMWj/AqwI1H7Yekdciw119CeGu3Ba2y15/FEc8H6JzG5BidVEJ9H6XoGHHNQ+XOU2yZOdXMOOMigwUA8GqF5/NIYrO3NWxO2Nl3tsENQ/7oK3id1lvbMw82ky/KCyy1hO/8yGTr5qnRL6kx8+3/kSPlo8D6riGrVI5q/kA5byCi0JU1Uwa7qVf+L11IsG2GttgxlABY3thXgW/BIzu+rJtph22nwtepnqzWtW89r6yIjel3HWdXAN6O9ZL5kE6zSau+5M2AqHUGmxOgWOzX3a46yEeljgqYop0Lx9zYcchfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YHJ1XiaYF7VY7pOxFd9rQZBal5sTT1cputEaDj6T2c=;
 b=FWmH3oDwJWZouecjO6Rmwatjrla60ZMUcLAks2gf9rlRhVojEu+azO+2NOjSNlqpbBIUUogszwAXgJ+lTyo70Ca0xoOVmzG81D9Gw32kctaOT2atrSq4ossNeOMpjex34QoSXyPGHwyB8GMt8mjwSCC+Mjogibf6gggB/GqTnh5cwToyP5dUskUo7QDeV09spIK4sj6N6Vk48T6yPPt/sTo2ragKU124W5r5MyezA0//Sv3dLYaT9ZkNQ1p/Y4x1m5OHDEIon6crW1PxB2utevYRKG+Uejp5wAE7iYpZpmv+LliWTmRIjp8W0ya5Jxh222klCX5cCHz/UCTMI/eldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YHJ1XiaYF7VY7pOxFd9rQZBal5sTT1cputEaDj6T2c=;
 b=XC0Rp+oIIaJLNALXFfLbjnJA00vQGUiDngZOJxf5hwaj2S3HQPW5l796JiGLpVqAqdRJgb38cy7i00OdqQVTt953V6flWijV3CL9tlD2Y4tSOnD+J35pRgihaO42MwPbZIR20wd+PBMd0fUzEnz/w2jXLb2kq0JkkKYBq6sqxkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Thu, 18 Apr
 2024 18:09:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 18:09:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/3] arm64: dts: imx8dxl: add audio support for imx8dxl
Date: Thu, 18 Apr 2024 14:09:27 -0400
Message-Id: <20240418-b4-dts_dxl_audio-v2-0-e4e2747b3a49@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdhIWYC/32NQQ6CMBBFr0Jmbc0wViGuuIchpKVVJlFKWmxqS
 O9u5QAu30v++xsE69kGuFYbeBs5sJsL0KGCcVLzwwo2hYGQJEokoaUwaxhMeg7qbdiJRmqFhCd
 UDUGZLd7eOe3JW1944rA6/9kfYv2zf2KxFigMXQyddSsVtt2cluPoXtDnnL/W4C9yrgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713463776; l=997;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4jKHCL49kjHuCtkXiYKKNoZu6aGIslc4XTVMvfUruQU=;
 b=7wz6+c1e5LHJpffSSooY4E8zTY8042K0kYgM2ZUH7rYNCcPJFTYV/+/0nN8aiXHbGPuhU8zTV
 7IDGSPhpQgEDCDT1nQWDOgU/KfAGwl6bWmSqpEY067Lz2h6+tkE/70Q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 998afd4f-3bc0-40b4-244d-08dc5fd2b6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AwXk2fULT86TXmHDh49QNPfFsS6qh/5atroYY3ErFAMlIdfE2Z7Duy5hIxJSXr6DBTx9x6JevVENuEWJ3xpWOFZgQAdsDisNKu/MliJ9x4yhDwY/YvlfyEQBkTJCtldbsqJwcpMrHMN+4zuAPOweeZ8FWzucOeQucsVDY/HdxcTjKqNyjMlpq1zPson/3m0qbuB+hIBTbF8tNA3O+tmr2zBXJhUTKefE1IC55vh6baw1+3O57LGe2hZGD/v5OfNu/R8yhnC7lOcMcG1AGggTaaezXRSN8QdESp4/CrDRiQPwgvfw5qWoFzQVYLA8JFT8MXcDdKKtiBWaKzgb338C+oMqaKpKGsTXnKrT4IXhOTXDrVfDwovycHQLaGasS8cJktAcxgsmIT5xm+t7s48SdISivyOANq+j7NTgQ8BT+tFjJFRYu9qh6lWxzyIHeG7UN+D2bBJjXCENCyckBCzejsBHWEH6mr83eQEls1A8iUSG54Ezet7/JhikXYp0pdSLVDTrApdq0MCt9XdhhK0pynPp2raIA+mZj668euParNpCeNBQHtR8+ZE8BjC4URAtBSpVyVxYJkFPFBzm8X7ahAYrxuJcxKGfGzpG4RrR+iTX5OvUb5vZdXrp3sYic7CuIiI6H6sjM4wec9NDAg/s9gZnmy5sJdzkE5dy6yTnAIZ/yb/66XYbdjP4cSZpm2WL7ZlA+JWLWcwN1YRAMTmLupmmjUBrtF/oJAAFH54pU90=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHlLUG5OcUovb0FOekRoYXAyNG1aM2VCMGJmU2l2L1dMSHA1dkVMSmpHcit3?=
 =?utf-8?B?U1FObTRzaG1oL09oZFlYU004OVBsZlViclVvMEgzRm9kdjlLRS9jM2kzZUdj?=
 =?utf-8?B?V01jK05hRFpWWEV5dUtzVnN1NW16Ky8rSnRtVHowT1pNRmsvL3ZtTHBkLzlp?=
 =?utf-8?B?MDNSVG02NmxZVUVYK284cmpCOEJzbm5tYU52bHE0OFZXdlhyaklnamtva0tI?=
 =?utf-8?B?QUhqSWcvQmpIOTBmTUVDNVo0RTBIWVNHREFrWW5VZ0QwZmdDUy9RVFo5ekpy?=
 =?utf-8?B?eDlobXAxeEJaM2JMM1ljOFZyTExrOGVQdnhDOTZabUZsRjhFYmNvU3p1SG9i?=
 =?utf-8?B?YmNmOHF6ZTc5ck5YdnkraExCNnlQTnNIL0JqSUtTV0thdHJNY3lqbFlCejF0?=
 =?utf-8?B?SjZrY25Xc0VDazB1K0Y0aUI1cEFWM0lwaXMwWnd1elVuRkRncHhjNWxXWTVX?=
 =?utf-8?B?Z3FNd0YvemFEeS90Tms2OWNYTVFrcmhJbXB4Z1NoK2V5RnJnYktQT1JGL3pF?=
 =?utf-8?B?Rmt3dm9HZTlpdGtRVVlGRi92Uzlob1lYRWJwVTdHK2J1c0p1T1F1S0txTyt3?=
 =?utf-8?B?clJ3SmRvMHBJaDV2cmpuUHJVSzZJWktjMEk4N0xyMUpuSUFHa3hBMWVySnFR?=
 =?utf-8?B?SjJZWmhmSVlMNUdwYmtuYnJYNGhYOEZXWFhCaTZxdmVnek5RU1h1VCtHVHJV?=
 =?utf-8?B?cCs3a3RtZ0xXTEdnYWNoWm4yR2lSMGg0bDZaYjhockVYOVlEOWo1ZGJ0dlpm?=
 =?utf-8?B?WlJOdlNUV2V5a0Y3ZTZxSzcrbThsSlErRFNaUWV1RE9HekZIUVRZc2hwcWZK?=
 =?utf-8?B?aXkxN3A4QmUwdGRWblQ3ZmF1MkcwNVpqWm43RDRlL2tEeVNUMFpnL0tRZm9m?=
 =?utf-8?B?amhCa3ltU2N5YkQ0akNqb1c4UDhnRVpFTGdoQ21rdm5seVlYQXFHRE5iWXJN?=
 =?utf-8?B?NkpMN2FVSDkyYTJVOVVQbHVlUDArQXVjeDQ4bEJoZlI2K2VwU3dHOGpwdkZr?=
 =?utf-8?B?WG1IUWo4a0tOWExiV1ZWb0d4clluay9QQW52RFhKY2ZaMzM0RC9IMS8waFNG?=
 =?utf-8?B?MjU1ZW9qMk1URjhEdTh0aDRDc212YkRwODlVcWRTRlBCNHdDMndqN2cvVDZQ?=
 =?utf-8?B?SXowWFg3TjhpT0ZRbGI5Z0FUVDhOekJSc0xrS3Q4eGtqcGdoUElIaTdWNkhw?=
 =?utf-8?B?U2I3UlRHcWc3T0U3YklsQjgyaVVhTlpqRGVpek4vSzBUM1FTTWV2dnV5Qy90?=
 =?utf-8?B?MW1qdkpUcDF2U1k3RzNOTldXVHRncWNFWFpubVREaTIyOEVrZmVYcHo0ZUpa?=
 =?utf-8?B?MzFKZDR6aW9ELzBoUXhKVGhlU3RYN0JvQ29IMW1XVWRNT2FxQk00NDd3a2RJ?=
 =?utf-8?B?MC9EOUhpaUQxSVIzNE8zSnZuNEs2V294Ujh4NTRBWkptVUpSL0hPa2ZleVdO?=
 =?utf-8?B?VGpxZ2NhN2RVeTVVanV4Y051K3JoK1d2WGtaYWhEVm54RlpVUkdGcU9rbzJk?=
 =?utf-8?B?WTVnUmYrTlRtb055bVdLaTErSExwMXB6SzJuWmRxQnBGMldlM3BvelIwS3Nu?=
 =?utf-8?B?ekxkemtwTlkyWnRXU09BNUQ0SmI0VFJTZUdtQWtTemtucytmTEtORmRMY29t?=
 =?utf-8?B?UFhRZ1hFY051UWZla1ZDcS93Tk5JRmNPbUxOU3pCK0tENW1VQnBqeFdnTGZr?=
 =?utf-8?B?R1NZd3FxdUdWVlpwQlpUYUZlbEdzV05hS3NPRWZUSUcrZFlTd25sNW9VQnZP?=
 =?utf-8?B?VlJzdmJwMWxiY0JmL2pEMkFoSFdFTXdvVFNUbGtJS01rMS92K2JVUzh3WUto?=
 =?utf-8?B?OGVoYXRKWm5xWFZlbFZXVzBTd3hKbVhINEtleXZwdVZqdGR2b3MycHFLRkJq?=
 =?utf-8?B?MDFSdzUyaXJjdGkzYjNDbTZDcG5RbTl2TkdHODVtdUdoOENRWWlUdDBkQXgy?=
 =?utf-8?B?RmpBWlg5ejh4eXRFY0R3L0xHY3JpYU5pdW5QdlJ6cEthMEw4ckRNNmRZbUYv?=
 =?utf-8?B?Nmw3L0JhQkJCRWZkaCs4VWZqVXA1MU95bVNNK3IwMU9jT1F4bjBGYkZJbzY0?=
 =?utf-8?B?bFBNZVgvOVhpSXY4RzJLVERUU0NXZ1QrVllnLytKQ3BTWlV3WU9DZDMyTGI5?=
 =?utf-8?Q?izATzoF5wRXBuZpVNJrH1wVJD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998afd4f-3bc0-40b4-244d-08dc5fd2b6a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 18:09:39.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nanctihFh/FtDgeVA7dkl4u5NW3awSLxTt0lFhJPLyXI1fwjH3HellpfQu2zWr2BTMCjMr/G127OOCIieocDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270

No new warning add
by make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  CHECK_DTBS=y freescale/imx8dxl-evk.dtb

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- use general name: audio-codec
- move vendor property to last
- remove undocument property 'capture-only', since linux-next/master merge
txt to yaml bind doc
- Link to v1: https://lore.kernel.org/r/20240402-b4-dts_dxl_audio-v1-0-d26d25b84a08@nxp.com

---
Frank Li (3):
      arm64: dts: imx8dxl-ss-adma: delete unused node
      arm64: dts: imx8dxl-ss-adma: update audio node power domains and IRQ number
      arm64: dts: imx8dxl-evk: add audio nodes

 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      | 232 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi |  78 +++++++
 2 files changed, 310 insertions(+)
---
base-commit: 2d13a7797c3970a4eea160844d8905c93065634f
change-id: 20240402-b4-dts_dxl_audio-74ba02030a72

Best regards,
---
Frank Li <Frank.Li@nxp.com>


