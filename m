Return-Path: <linux-kernel+bounces-77608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60499860809
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D898428235B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F904947B;
	Fri, 23 Feb 2024 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YqcwPi4C"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42567499;
	Fri, 23 Feb 2024 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650525; cv=fail; b=nk/8zBnZ3TrAW8qAXduLsMx9v8GKUHPLGaRx8NLYHZp9izpZi5xWNpHy89F77LQOyDqhjEGb6MMqCa+b/rMqOvvKYYCvk/TEYJ86z9rkXMcFqEXJW/Y2PR8fXuuDnh6mgDvKyVXJZsjy+saxb5bE/PjLYU88fzUpE2PJwwUG+/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650525; c=relaxed/simple;
	bh=YHkwtVh+esDQfZ1ExIdMXWgwOrS7JqItjZP+s9+y5fg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=qQDSujKLTxvmQTIAzsJuk/d/lWV04Chebutwjny/+NXy4eHxRM+247fmaA58CM/pgbVg7sMzc6voygDu+rUZcCRxJMRaCpV9jZIUfZv9ux4oIbValQaKetboJn9uZsypaxy86Foy/r/9iWA5FQZzbppf5PfrGM6/9x21y7dbBbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YqcwPi4C; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBkoZSrzwdbjclqrnhba8n02j1hKx1qSAy6DgXHJxrUCbt2AF3a3dMv1lhwnZt6+yQgRDykjPpEjD3hmqI348GMCvb+gftrbKOIQsRh3I+3cxsgR2Te2IbnlXYsICIMI6FP8KfhdD5BZ/rlMqj7kmMs3ZNjPUrG25P5E46DbueKY3To/kvGmLeF7ZANQd10boEwf32EJ78RY24/aYFSKyaAjISP+BlwQxhuRtSe4N9vgCkAYyz7XOH6LkzE+TsfkYHCMOm4w0AhxNmcX77n/xKGiQkouNlcSfL8XGd+qPjvk74HvgGAz/iIaWzbNpGOwROh/jwfvW7FRNh38RsGaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc9X5Ef4BsMQeAE5mYloiGCj4ZG5D8rMwgOtMkmGmw8=;
 b=JX+2dy6cLbcn2iM5Dxr1+HhS9b3QxQ3We+0wI1jUfMSzQCK40SMZrYC3faHN7r7kVaug0i58N/e/LPr9ISNJ6flWRvjxc7Ij1xkwxI+ga35bjK8xl3TQPCJN8Roy4T6U/kPhL7bJsnvrg4smGgRDHo5TmwYOuc4MW20TuRN2Q6PEL5GgZS3uEjpD/cds5CHmYZcbhL7pgIoHkfYSpr4uH5IAidZ4sa9Ar1QFBt78CByef39x60Rcb/DO71rHQKzkaX5k7BPwGYeLzFPNQ7myFIsnCz8PQ+gAbWuzkNA68rsPE8iNazzZyVonBYiNhEvgJQZGKnOYQ55MxLu1zZDpag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc9X5Ef4BsMQeAE5mYloiGCj4ZG5D8rMwgOtMkmGmw8=;
 b=YqcwPi4Ca97rQMtM7lPzclXl8qiUnh6O25/Pxfjod/fk6rkqhXj9rxo5gXm/uOmRR6bPBv+k1LPBQP4FrdgM+RDmTP/WlfmiurVyXtGxMuMtJH2F1XOy3DrkivBIs+g8uXpS4LJzlXOITMx4HEPV1JOn6RCCUmWtcv5hWw94jYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 01:08:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 01:08:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v4 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Date: Fri, 23 Feb 2024 09:16:37 +0800
Message-Id: <20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXx12UC/3XMyQrCMBSF4VeRrI1kuOngyvcQF2ma2At2ICmhU
 vrupgVRCy7Pge+fSbAebSDnw0y8jRiw79KA44GYRnd3S7FOmwgmJBdc0QE7M/oHDaZFCkZVTOb
 gwGQkkcFbh9OWu97SbjCMvX9u9cjX908ocsooc1YqCxnnLr9003AyfUvWTBRvCowz2FGRqC6ru
 sh0pXQBv1R+UcF3VCZa1CVUOi9ro4sPXZblBeeI+nccAQAA
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708651021; l=5069;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=YHkwtVh+esDQfZ1ExIdMXWgwOrS7JqItjZP+s9+y5fg=;
 b=YQk3XOJaLeMI2sNwSTJqmDYCN/gs4PQye0P7eISVgjV0Znug0oiXYK4SqL065KKo2gkeE1zLF
 OouBWMiC5x6Arj3cTn9++oy6w0o8IvUuI3B6d6gXrssMSYQYrJ3k7+M
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ced592d-4b3f-4570-a8f7-08dc340bf7c0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tO/RX9EOvHjZEDfFo2g55/6Eb5rs4KyERrIEFjIF02paoSCyxOF1L1Z4tlz0BLGO5OzFSy8P5x7tme8M5P1nt5dGaiydhCHrL58B1VlGvPqBqisvMsK/qZjkcvv/2/i65DjfPnXQ9VVBXa6tAEUyS7I/J+5av+U3b38sl1Qy4OH+hczfQboYJxH+ErAQulZumsGpFZW5uaAp/vCrDPSDSgzv9+4eTCPDZve50qu1YqK2urO3pbxb+2h3Kp6uiW/AdY8XbW0f6PYgjnpUDWgQiWfhdjacJkw1+zU6d+yrFtO4g04S8Gr6Td5rE9YaNFICEfQz7OFIlU7Zy2RawHi8qJNt3syg1zDNIOgTcARVy+rFvysfcRa37bynWwcrrkc2cqpSptyb7gj9pU/58VKwxVi8tRJfQSi9BA2nCUeN1E/I4iavLdQouJic3NO7XOZQlWACtYX9wr89q5JnMYuWs2o5J1EHZTQtEGc2kQGFPUX4JYCmWLQaEW4n/XEppeH2ZH0mv+gUJnrEHaMAJ04RPhDRQkBllASLjxKPzrCLexeTa5RfZ79mMkoOTGd8AV4dKSOjTTDCcsN2xx5gBh/jek6yTO3cdCEpsF//12aEjCUKS16nn9BF6RDYJNUvYswm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzlhTFdxSkNYcm1LWENtUXB3Q3hWZlZ4ckZwSGFSMjBBamx5emx3TGZaSGU1?=
 =?utf-8?B?Z0tJOUFEVWZzbVc3SysrWlpPclBWbkR6aUx0d3pmRnRSbWFJSmVpOG0zYVFi?=
 =?utf-8?B?ZFdvNUVTcFlwS25saEFhU0dOa2VzWVFSdXpKSjNoSXIxK2wzeno1WitMVjhl?=
 =?utf-8?B?WlR0S2QzWnNBNDBRemtDcUUzY204cWEzT3FmZlhaeXB0U1lDNGhPdlZzYkxM?=
 =?utf-8?B?Z2JKMGpKRWRxSnpSc29tZWo3Y0FOa3hQY2E2aTlTaXFWaHhmaFJyQjRISWY5?=
 =?utf-8?B?MFdIOHJvb3FFeFVNVDR3NFFocUdaOGxOb29TS3l6U3d5djRjZTJTb2UvU3BV?=
 =?utf-8?B?cm5pSURsTXdBYVJiR3lHWmxNZCtmVlRhdEhaVjNJRnJOY3JpTGRSbmdrVmRW?=
 =?utf-8?B?ZmdST2p2d1dzOVFHc0ROQkNtVDgxNjVhc0UxaUlnWHZpMVdxK0tNOXRQU2gw?=
 =?utf-8?B?ZGlzWkl4emV0L0hDaDJWZndaUDVRRjB5VEVWWHd6ekJleEdMTSs2cnlmTlJF?=
 =?utf-8?B?ZGFva2FjTjZLV1pwRkdVUjlPaFhLRE5LTTI4MXBZSW4waHJMNWdDV2NhVnZY?=
 =?utf-8?B?c2RxQlVSZERRNWh2VytnL0JCaGhPUVlaNmpzeDEwSzBBNVlGWkdWVWgzUW0z?=
 =?utf-8?B?VFh5WVZEbWk5VEx6L2Rma3lxNmhBZit4N0xEZitNSll1V1BWOWV0QS9RaXcz?=
 =?utf-8?B?eko4YjdjWGRjQXdpMkdLYmFvV0c0dHE4L0JvNlZEVnk1S2JldEZtK2pqV3dh?=
 =?utf-8?B?SUt4MkRpcktqc1d1Rk5KeWtnbjRick10UFh0T2tmellHZFZRQ25jT2ozWmJo?=
 =?utf-8?B?RzdQbm1hVTFoUFprUjFGTEcwd2VCb3FZR2VYc01iK0RVQUVoOHVhRDZ5Ylgw?=
 =?utf-8?B?RW5kbzMrbjd3dG1pVURqbHF2SzBHREtUZjc3V21ia1cxbXh5ald2MlpCU1Nt?=
 =?utf-8?B?eFlNS1RRS2I1ZVc3QzJKU3pBZ25tZW8rTXRvbVR0LzFJVmREWSszSTlDRG9U?=
 =?utf-8?B?L21RbGJ1cUs5MUlJKy81Z0xVU3kzOXhBRHlQbHloMlFwQWpNdUpOdWRSdjhl?=
 =?utf-8?B?RWJkNHYrZllUUGtvZkVhWlpOeU1KeEdmOE9ObGlRajI0UUVGbU13R3REQTRv?=
 =?utf-8?B?b2RmRWIyN1RIV1YvcE9OVWJzWXNDMjRxSTZpbWljWGh0QTVaTGgwRXVjeWMy?=
 =?utf-8?B?NU5aVWdDeFY2anlsaEhoTzBxc0todmV2ekFCT3ZxSzZPOUpWVjdWN3FHdldo?=
 =?utf-8?B?K3hCU0NiRFdjWXA0TEZUMXEwQWRBZWtuM0hma0NNOEEyNm1FT2xNMC83blFj?=
 =?utf-8?B?c2xqV0ZJK0dOUkFBTHZObmJiRmFudEFNUFNzWFY4ejNtdS8rSlVNWm1iZnA4?=
 =?utf-8?B?VHNYa09OMmVSbVFLMXZMa05uV005L0RxRzE1dFNtTzV0RSt4ZEtzR1VjcHF0?=
 =?utf-8?B?blNXU2VzdjZFaTBYcVBuZkd2dDZOVW5aalduVW9XclVaT0xJQU5TaW1GSnd1?=
 =?utf-8?B?WXFmTWE3bWxGd082Tk83QnJYMGJGdEk5d0cyMEcySEI4ay9mUHhOUGI3MGxF?=
 =?utf-8?B?blZISkxjMkNDZ3ZJZFFtTUYzY0VUYTB5aXlLcVY5NndrRDNJN0JZcFZ4cS9p?=
 =?utf-8?B?d3p5Y0NuUG9kQ0hPOFJFOFBtRUNpRXdwL3l2MGpUTzdiSFFzVWFYS2l6NGdm?=
 =?utf-8?B?ZzdQMC8zTkx6eWY2dk92RE1OZ0czN0ErWUx2d2Y3eXE0V1BnUURaZXlKYzhC?=
 =?utf-8?B?YzE2T0RBb2ZvSHFzbk9QUW0zekdrK1c5eXNLcVJXamNwYTFPT25QVkkyS0pY?=
 =?utf-8?B?UkNwR0p4Q0pOM0N0aEN5RVYwTDE1NVJTcFZUdXJyQ0NFRUdueWdQa1ZlY21o?=
 =?utf-8?B?R01WRWdYZ29LemlMTk9SWDRxbml5endYc2VDckQ1NkVmQXVJT2pydlM5VlNS?=
 =?utf-8?B?blZ2cTdBa2d0YUJHQW04bitHc2FSNnAvR1A2cjJlMEQ0WWhYZjZIRVUvRy8w?=
 =?utf-8?B?SmovYktybVR4RGhFS3hmeWVES2NNVHZTVWJnZ0xVSG9TMjJzR2JXYTlCQURB?=
 =?utf-8?B?WFlVWFQrbENiL3g2UW9JZDhic3pLYlp5QUpEK09Ld3JlT1NyUC83aDQ5S1hp?=
 =?utf-8?Q?befzuhpY5XH4bEdLAjL/BzZdz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ced592d-4b3f-4570-a8f7-08dc340bf7c0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 01:08:38.9134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1TQHBr4IAUvrOSVzwTbiz5FbPMAcxAwFtZk7I8HH9ZmQyAJTJfyRAcitfROShJLZfxiIVGVeyd2PunumGpoqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8418

This patchset is a rework from Oleksii's RFC v5 patchset
https://lore.kernel.org/all/cover.1698353854.git.oleksii_moisieiev@epam.com/

This patchset introduces some changes based on RFC v5:
- introduce helper get_max_msg_size
- support compatible string
- iterate the id_table
- Support multiple configs in one command
- Added i.MX support
- Patch 5 firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
  is almost same as RFCv5 expect multiple configs support.
- Patch 4 the dt-bindings includes compatible string to support i.MX
- Rebased on 2023-12-15 linux-next/master

If any comments from RFC v5 are missed, I am sorry in advance.

This PINCTRL Protocol is following Version 3.2 SCMI Spec Beta release.

On ARM-based systems, a separate Cortex-M based System Control Processor
(SCP) provides control on pins, as well as with power, clocks, reset
controllers. So implement the driver to support such cases.

The i.MX95 Example as below:

Configuration:
The scmi-pinctrl driver can be configured using DT bindings.
For example:
/ {
	sram0: sram@445b1000 {
		compatible = "mmio-sram";
		reg = <0x0 0x445b1000 0x0 0x400>;

		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x0 0x0 0x445b1000 0x400>;

		scmi_buf0: scmi-sram-section@0 {
			compatible = "arm,scmi-shmem";
			reg = <0x0 0x80>;
		};

		scmi_buf1: scmi-sram-section@80 {
			compatible = "arm,scmi-shmem";
			reg = <0x80 0x80>;
		};
	};

	firmware {
		scmi {
			compatible = "arm,scmi";
			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
			shmem = <&scmi_buf0>, <&scmi_buf1>;
			#address-cells = <1>;
			#size-cells = <0>;

			scmi_iomuxc: protocol@19 {
				compatible = "fsl,imx95-scmi-pinctrl";
				reg = <0x19>;
			};
		};
	};
};

&scmi_iomuxc {
	pinctrl_tpm3: tpm3grp {
		fsl,pins = <
			IMX95_PAD_GPIO_IO12__TPM3_CH2		0x51e
		>;
	};
};

This patchset has been tested on i.MX95-19x19-EVK board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v4:
- Rebased to next-20240222
- Drop pinctrl-scmi-imx and compatible patches in V3
- Add T-b and R-b collected from v3
- Link to v3: https://lore.kernel.org/r/20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com

Changes in v3:
- Add R-b for dt-binding patch
- Use 80 chars per line to align with other scmi drivers
- Add pinctrl_scmi_alloc_configs pinctrl_scmi_free_configs to replace
  driver global config_value and config_type array to avoid in parrell
  access issue. When num_configs is larger than 4, use alloc, else use
  stack.
- Drop the separate MAITAINERS entry for firmware scmi pinctrl
- Use enum type, not u8 when referring the scmi or generic pin conf type
- Drop scmi_pinctrl_config_get_all which is not used at all for now.
- Update copyright year to 2024
- Move the enum scmi_pinctrl_conf_type above pinctrl_proto_ops for consistency
- Link to v2: https://lore.kernel.org/r/20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com

Changes in v2:
 Added comments, and added R-b for Patch 1
 Moved the compatile string and i.MX patch to the end, marked NOT APPLY
 Patchset based on lore.kernel.org/all/20231221151129.325749-1-cristian.marussi@arm.com/
 Addressed the binding doc issue, dropped i.MX content.
 For the firmware pinctrl scmi driver, addressed the comments from Cristian
 For the pinctrl scmi driver, addressed comments from Cristian

 For the i.MX95 OEM stuff, I not have good idea, expect using compatbile
 string. Maybe the firmware public an protocol attribute to indicate it is
 VENDOR stuff or NXP use a new protocol id, not 0x19. But I think
 current pinctrl-scmi.c not able to support OEM config, should we extend
 it with some method? Anyway if patch 1-4 is good enough, they could
 be picked up first.

 Since I am only able to test the patch on i.MX95 which not support
 geneirc pinconf, only OEM configs are tested in my side.

---
Oleksii Moisieiev (1):
      firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support

Peng Fan (3):
      firmware: arm_scmi: introduce helper get_max_msg_size
      dt-bindings: firmware: arm,scmi: support pinctrl protocol
      pinctrl: Implementation of the generic scmi-pinctrl driver

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  50 ++
 MAINTAINERS                                        |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   1 +
 drivers/firmware/arm_scmi/driver.c                 |  17 +
 drivers/firmware/arm_scmi/pinctrl.c                | 908 +++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h              |   3 +
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-scmi.c                     | 593 ++++++++++++++
 include/linux/scmi_protocol.h                      |  75 ++
 10 files changed, 1660 insertions(+)
---
base-commit: e31185ce00a96232308300008db193416ceb9769
change-id: 20231215-pinctrl-scmi-4c5b0374f4c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


