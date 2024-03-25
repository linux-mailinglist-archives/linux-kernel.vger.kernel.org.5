Return-Path: <linux-kernel+bounces-117242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C1088A905
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221E01C61BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E5312FF86;
	Mon, 25 Mar 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="i3KPKhb4"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD1782D9F;
	Mon, 25 Mar 2024 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376582; cv=fail; b=HBhOSKXFKPLoGHVzM5L5xzTuI7KV2+5YpyHj/dkrK8479zBgWdBjIiD8dJfqM3oKwsekXcyu88IR0jipBgHECcme0LZnghxAmp29dgwLGlXFBSLA+wg7Oli5PRQ/OPuG4hPR/XL1Dc4Uv/9tMopnxCsBsOj7szhTBm0hVN1U0I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376582; c=relaxed/simple;
	bh=14XeS81IEwT2lDX3Ti6yzZIqD6q2OPalmGc2i3dB8fY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QwCqgsLn2ZTd3SU+rn9v6n2tqPZ7I2piUalmD4ELxh8uktkFmM6S7F+QrzWKA6Qb0elnAAMZwl9CwtYXzeIRBhmzsnvgp5oT8zt49fn6v9lIbN3txTOwFyEuU2H0fX0QbNA6PPG7NYKVtiWpWCFBATTmxxQcXjnlFGwt6qpLP2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=i3KPKhb4; arc=fail smtp.client-ip=40.107.22.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loxK970/mUvqQgHU0ZLETpiyVA4kx4cX1h0ACf3g+BOluZHFl8ggdgzKsWiea7jMu2HVukAXE89HvoEXCcqZrnrjBjyWj91lw8fdGJSYJHQBLA7+bsPkPfbgt+i1JkarkgOJ9e2s4ANfdKtjZnxrcK/GtOE40YO72thIJ3q5jeCUfonsu3TcpN8mehkYghth3dqcam6BWfwYLSkAElnDO2r68u0CeCB0rSamymaeRcfywniUHJdxOx05a8OgJJvSgXWFmZdqAr44p3EPhHdSuSy/kaeR+eVO8XPtOs5gkXbIJRqpF5f5BsjaoPxe61jJbJi4ilFrMRU4TmU3I6gRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFau7IcGAqC/6wGUSOBYCKUbJkX3smo7MyZqVWlde1k=;
 b=UV8MDEDNYQEK+M9MqfmTOorm8a91ChDNDcM0EH7LTePhpkAGx/dOoKhyaDmw5Jk0plvoK4b6A2LXNi7TEVJN8s/dWIiK/X/axrmGcTeEVI/rRQBq/5zdWH8JFaVAEOUf5ETwRJwEqlljcZNoFln+//6WnrJV4Fk3Mcm+6zkyZlCG95X4uA8NvhbAjcuGPU6SpgIx8KB3mzzp4ey3ueLjnv5d0+Fllx51EokFBDG6SI+eycAklLypoo0LOiDX+5t6Wzj4V2EEAxGTSGYIL5OX9Fj+jtQKesDUe2HGBKOj0ab/LXkpOCFQ9FmQYbG8MREaw2JW6RSCB1Reu6piIOuAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFau7IcGAqC/6wGUSOBYCKUbJkX3smo7MyZqVWlde1k=;
 b=i3KPKhb4PyBRQJ+94N798Y+sOIagg55lDy9HFpJHHvFzDAoyta9AtcBpTDoqbu+rW77w7/A4lVxjTy7yekIa1JFnpya2EjIZAJKGFy31pzwgOsuMSDYEo0oGbAZLs3c57x56yi1FDKYDMvh+QKT/tHv6nBjDaWLD/Denl0O1AeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GV1PR08MB8258.eurprd08.prod.outlook.com (2603:10a6:150:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 14:22:55 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::e86a:6893:ac7:dad9]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::e86a:6893:ac7:dad9%5]) with mapi id 15.20.7409.026; Mon, 25 Mar 2024
 14:22:55 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 0/4] arm64: dts: rockchip: add wolfvision pf5 mainboard
Date: Mon, 25 Mar 2024 15:22:30 +0100
Message-Id: <20240325-feature-wolfvision-pf5-v1-0-5725445f792a@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKaIAWYC/yWMSQqAMBDAviJzdqB2AfUr4qHUqQ6ISusGxb9b9
 BhIkiBSYIrQFgkCnRx5XTJUZQFusstIyENmkEJqoaRBT3Y/AuG1zv7XcfMGjasaqZ1QdeMgx1s
 gz/c37vrneQFAyDQraAAAAA==
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711376575; l=1358;
 i=michael.riesch@wolfvision.net; s=20240305; h=from:subject:message-id;
 bh=14XeS81IEwT2lDX3Ti6yzZIqD6q2OPalmGc2i3dB8fY=;
 b=xjwLk/d5AD1QnU6yH8vA28JYMAarZf6FpLOh/XgGpNRwSVJG2rdpQJlYDt1A/uZyLbNuCyyY2
 Ja53nclNfbNAM4sEb4T7n6RAK8UhOswqP2Bt7YswMLMearOIrEkcBvX
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=vXktx+l75RJD3KAojVKL7503UCD9nnGRcgujrB9SRp4=
X-ClientProxiedBy: VI1PR06CA0127.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::20) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|GV1PR08MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9a060b-0e2e-4fc8-4456-08dc4cd7105b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TNlnqSGIcHO80F1mpiIM1vOJxMD2no755RpP+D5eP5+EG2/CiMBXiqPPT86mvlTyqmO5hqW/ppzU9qPlD7u1+LQTP23LvRtwOHAXsMW6I1lgxM27VgAcFFVSvh0IlHebzy4Qlt1tLeYfzMq3BS/NxL49QKwfTjUucm1A3DvOn1p8DsGCSyYPG3sxoAZX6nKMBAAhTJvUe8qTVRVKETd8CYFACrmRtyfnJpfdKCait/HVW6fgsmTOEVa7ozPSSze/UN0CptQ+YrxOS8RTMZdMpnHqGSbKp+ZBLmst4kTJ8hcKA1lZHGjqtR5wIE+PJXF+NAPaoz58Lusy+6yx+ffxjG4nd4t5x5eEGozlc7hdXd5xn5u9tqlKafskHFyGG4jfx8bDwZbzRrkMgrOQ2UMHQjicYm/q6lyL68q9TcVu5TJDfyfLxDZ2Vc+/txFVBQiaZHyogvC8cnvGSbK4Uh2D7I8Ji+Dbu0rVnnBU3XaPZ+27W3yW+WLlOI4DGhnihRSBtVktSUvJF8jBcph2rGyRullQ/FoWRqxtz9UtBx81LVJfF3z6z+EoKPWHhg8CGy4/1lQQu9Ii4wVEY+R3uob9fT16s0CJiyDVT5F2zD+Qz3S+hImaHOPHrvETqTur9t4CfahH520uM5k77N40uJ6eS4q/uNG9oYOJmJlOz84JCc6CE79/tzXUxVGqG3Au4eZGsT+1D3oC3Gw43wCOmERGZ1Ywx7EuVYD1JKsbUNOJzWM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTVzVE5FRDNvYU1CUkZQbzRWTE9DZjZDT3lQcDdtVklYdFFYcTlLSm9UUHdz?=
 =?utf-8?B?dnkrMEN5ekYvYTJmWjk4MU1tSDUxZFdVYlBtWVE1b2ZoSzlSYmtBU2hjQUN2?=
 =?utf-8?B?YVZIa2J6YW8veXNCQndIUXhaTTlmWnJoWjY3MDhXRDhBNUU5OURERWt5U09t?=
 =?utf-8?B?U0VJWklnVlF5SmRhTFJJNGI4RnJPbmpTODl6S0ZNSmRnZjFiNis1SXBvRHM0?=
 =?utf-8?B?TkJ1aGtubTk5b1BZbHBTUkgwZGZEU2tVSzNIR1dabVdIMUhHQUpDcng0WFQy?=
 =?utf-8?B?NzdSVzRpRmdzWXVjbjdreERCMzNadGhyWTdWUk1yR2tuRzJFQlZjS1NhdDA2?=
 =?utf-8?B?dFFZdUxMWlZ0bzcwdzY0cjJ3UEFSMUttMVNSWXpSRW1qMllLakxXRDFTR0ZH?=
 =?utf-8?B?d29VbnNsU2pNSjBPSjQ3RUhFS01yZVVWYktpaXg2bUltYWdNV3BnWkt2NE5V?=
 =?utf-8?B?QTVCZHR5RkpiSll6UXNqeFhncnFPRnprazN1UDl2dmNNUkVpU1h6YXlScGJs?=
 =?utf-8?B?c29TelA2R3crbThDemczM2JCY3ZmQlhPVmwzTExTWFgzai9hSFJsdlRvN21Y?=
 =?utf-8?B?ekQzdmFNY0JBNUYybTArUVVoYWJoT2pWU3BJT1lIVWMxMTdiaXZBOXlnSEwy?=
 =?utf-8?B?cVpoWUlHQ294Q1MwT2JUZTkzcG1KNWZqOWtxZlFValQ5RmFhTldFYzZGU29Y?=
 =?utf-8?B?bURSaCtOMDYxYlJ5amJBd1l0eGw1bDVNOTc5QkljZVpxOXF3aWlXR0FYWFVO?=
 =?utf-8?B?OHUxamNVS2V3bFJaV0htYWRXSEV3TUE1dVFKTEZHbk8rL0Q2L3hSR3hiRUVT?=
 =?utf-8?B?YnF2dDd3Vis3bjNNZEQzM0tYTFVoOHNJUHNVcjEvbVBkbjluSHRHU1Nsa05i?=
 =?utf-8?B?SSs5ZHQxQnpha09KSHZtVFlZKzgrbG9QMGJaendUZ0NyZVd2Skxhd2xlaGZE?=
 =?utf-8?B?bmtCd1ZBOExqU2V3Nlhza2luL3JRb3dXVGFrTWpMMWR1endQNENTZ3llNHJR?=
 =?utf-8?B?cHRtc2pxdEdwajhiTVF3TkJxVHNSUGVNV0FDMGN1b2VuVFdEeHlHNnlpSERk?=
 =?utf-8?B?VE9xYWRJL0VFRkVONW9HTmVLL0luVFNQWE5DblphaGJwQ3JnR1lXL2FNRGhX?=
 =?utf-8?B?UEM0WmUrVkZvQzhRNnM3THlhWE4wR3pJM3RxTVhoOXFycUFSWndTWGE1aWYw?=
 =?utf-8?B?U21KMmFhZWtpcjZWNWFzMnplazljUDFYZ1FYM3JtK2tFWmlLRHVCZnJ5bWxa?=
 =?utf-8?B?c0liNlJ0V2Z5Z3NtbmR4a3g3VmtGYk5GQnVyRENram1zNXRLM0R2cjZHNExK?=
 =?utf-8?B?OGFBZmwvUDNSRzM4L1JUaUZvTmU2SG5TVHkrT2FQeWQzUmJicTR5dmxBcVpy?=
 =?utf-8?B?U0Frc1BFS1RhK1BYRnVFK3psZTV2RHNqTnJYT01KdW5ZVFQrbWJDTW9adS9D?=
 =?utf-8?B?a3N2ZVoyUVZqaFR2T3R5V0RUZitGSGFCYkU3eUhpcmp5Nlc5Rkt1SitTbWxI?=
 =?utf-8?B?eGVzSXhxd2xnaWRRcTM3UzZpVkdmRzVkMmw0VXpWZisvU280UGg4R2dZZlZF?=
 =?utf-8?B?L1pUcEczajR0bWg1V2hmcjVCVDd6eVFxM3JobUoveUgyd1NTUWpBbHZpVlVE?=
 =?utf-8?B?U1F5bHE3NFYzcjBocjliRUViL0pKdHM1YmVxSVNqWlI5KzF5ZEZIZ25rcUhP?=
 =?utf-8?B?WTVDdjRuY0dJaXlXVVNCNndGSFdBL3VHUXdjQVdoUll3N1ovWkRJS3J0aWJm?=
 =?utf-8?B?cXBwUWlPTmc2czZoSklwK1YyZkpNeDJkd0d6NWx1QTY1MUV0Rlp5Um9SYmVn?=
 =?utf-8?B?dEtLdG9aUmhwSnZ2emdnNW9OeUhraDhlSHROenZsVlBBUGFDUWpWZ1JyR21K?=
 =?utf-8?B?eE51YWpSa0FhWUFDSFVBaWwwOTdpVWppcUMwNXlVV0srZCtzYW1WVkp1dmtu?=
 =?utf-8?B?NEVNTUFuRVhNbkRTMG1PcXpXTkNVTHdjUmpKbXp4L0toZXhma1hHbm1ac2o4?=
 =?utf-8?B?RkN3bmNCK2JUNGxkaGdWeEhxV012NzdnM1lJSlhDcElMMGIzbzluUlJqOWw0?=
 =?utf-8?B?TTFESE9YRGxmaXB0elRTR3dzbmdhYzJSUnhlVE1TaTlSRFNrMUQxMVlqOFl3?=
 =?utf-8?B?ejVuamlvY1pGL200TU1NaHZjVGZxYldtZHNRZTdJc3NoOGs2NDV3citJb3hF?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9a060b-0e2e-4fc8-4456-08dc4cd7105b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 14:22:55.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FH8otHQq/BDene/h5JlIYHQ4julq1cVvzxrX84U1E8dWzD2gTGdm5eAVPDCvoYXM0/6FIhjbRNR5Prs4U5wE35Qr2/vv8J2pn8+DAnELe44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8258

Habidere,

This series adds the device tree for the WolfVision PF5 mainboard, which
serves as base for recent WolfVision products. It features the Rockchip
RK3568 and can be extended with several different extension boards.

The WolfVision PF5 IO Expander is one example of such an extension board.
The corresponding device tree overlay is also included in this series.

May this be the beginning of a beautiful friendship :-)

Looking forward to your comments!

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
Michael Riesch (4):
      dt-bindings: add wolfvision vendor prefix
      dt-bindings: arm: rockchip: add wolfvision pf5 mainboard
      arm64: dts: rockchip: add wolfvision pf5 mainboard
      arm64: dts: rockchip: add wolfvision pf5 io expander board

 .../devicetree/bindings/arm/rockchip.yaml          |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/rockchip/Makefile              |   2 +
 .../rk3568-wolfvision-pf5-io-expander.dtso         | 137 ++++++
 .../boot/dts/rockchip/rk3568-wolfvision-pf5.dts    | 528 +++++++++++++++++++++
 5 files changed, 674 insertions(+)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240325-feature-wolfvision-pf5-5c1924c0389c

Best regards,
-- 
Michael Riesch <michael.riesch@wolfvision.net>


