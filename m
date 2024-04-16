Return-Path: <linux-kernel+bounces-147058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 940238A6EED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7C99B24AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603CA12F5A6;
	Tue, 16 Apr 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VI3YbCW4"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2082.outbound.protection.outlook.com [40.107.249.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E0312E1F0;
	Tue, 16 Apr 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278905; cv=fail; b=WCe0fdK6aYf74nug2jk0NtxEI2YbZIAaLZpIYmaWNskHmn413qk5i3wfWtn6oHw6ZYs8nszFdjHBUxHuu89e6SvKEQ0u4zluZaUL5z73u9WJhwa4jSavlgHpytxbQAJG3PZI3+UqcsI6Wjd3uBJPypLE0SUCFKfayqT3/feGVEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278905; c=relaxed/simple;
	bh=N8T4qiFW3b6+oiEKW6htHKgVcRfzanb3ZdIVse6cfrk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Qel1N3cMuJfdAfkLyPWTxMTwbstg8FDYpaYoCZTmoY43UNWEgElhSylFFu5EOfejHPBjf6UvTW6P/8raM21v6/0RlOyf+jUY/Zh1AyblHLQSLJRkchvfod6j/5i8G3ZPht0NB5uP4l80/VB7ScnxZ24UojkypwmsSOlWd8zAgCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VI3YbCW4; arc=fail smtp.client-ip=40.107.249.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy/pm1aZjm3f0LJ4psaqHj/XpDJKeS7unbVwImW57vFRiL7bIrV21LVUcwOMXbpNgjmhZ+7ayUhkBqwidTfN7QN1xHOR9uI/zwF23O2dzFC7Ojpa9zOhCqnrLS+jDt3qQZM7ZZRgGIjeWkt3VvwVprQWw2XwJBfCcEj8XwhW9CYI4YdP7zWymOVRl+BCGKjHPW3LPxj42I4yEM5j1RgalGUpyKwSZZMtQpuJ9Pi8gtSgUN3+eX0dsV9m8tfLzB0rh3KG7VlCChSvwKkOEoWQF6YJXociVd8WP0+Of/06zToPy3tAfG7UezUlaSfBqkvjyuSs0mnNZalEar6J5Cawmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7t87DCwruNdnD6SzwnokQWd/gsNBPmUyqbM/m6LM1AU=;
 b=aAxJ9EXtgBYjj7kGn5o/0yc/to/cl9Q9m+M/qqgZH/GSimskyXhWisNk2WIGFlFyKfEdwPFHSXbhFQYEyywYkiaS1OBE5RLy98ZO9/CAvc/TwH48VqtvRYoofcyXK8P+UT/ftjcUwYGER4s4Tgx06Q08Fd0ex+/RFsZy9Awxjwimdy9R1NVlultVsUn8jMKmX8lx9BfwKwX8hrvLGhN0+pYXwqO4cJRPUIxiWJz2QgAAA/Ca/+lDAWFdrer5/1nRdMt5c2fTdYJfYfk+lmxsRBFJkbUIeruqYKd1lQs9AnDpKfGGd963rJPB+D1PK3ewf1FplYJ3N6HG0d5PnrJ0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t87DCwruNdnD6SzwnokQWd/gsNBPmUyqbM/m6LM1AU=;
 b=VI3YbCW4hwFe8dnHF8zA6cHHOagGJz1e2k7mVgo6z/+SDdIHDBxdLg/Pec1/wLt82+56ufzjb7WlGmYIrrU4Iyu92UURvAQawfkFBgpziFNt4l4bgpbwFUY/oaeNW32hVZfM1K2sKW1qI+Vq0V4B8QH1kLUmocBKspQck+KBjSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:48:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:48:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/4] arm: dts: nxp: imx6: fix esai related dtb_check
 warning
Date: Tue, 16 Apr 2024 10:47:46 -0400
Message-Id: <20240416-esai_arm_dts_warning-v2-0-879e59c0c3b8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJKPHmYC/4WNQQ6CMBBFr0JmbU2LQK0r72EIKWWAWdCSDkEM4
 e5WLuDyveS/vwNjJGR4ZDtEXIkp+AT5JQM3Wj+goC4x5DIvZKGUQLbU2Dg13cLN20ZPfhD3Spc
 3ZXSvTQVpOkfsaTuzrzrxSLyE+DlfVvWzf4KrElKUqKx2ukXTmqff5qsLE9THcXwBquQfMbYAA
 AA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713278896; l=2333;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=N8T4qiFW3b6+oiEKW6htHKgVcRfzanb3ZdIVse6cfrk=;
 b=oMpGqyq5tdf6UyVjb0PGM1RglIS6tQWxyZ20Ouu7icLd2EIYCpJgtpSZdpEEd51j9K0GyxWXE
 EDwn/iUAfeABYISCbBjs/WKm21tPiPggfB+Kj+wZTiPu+14fd3/ezA3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: 072b2e88-5361-4e81-1022-08dc5e2441e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A7Hds4wvNivyA2uxCg5y7Svvy3ryvHo4+DxPiV12ypF1ROyN02gRqTYPFvvNNFXdeFOKWCetG65XOvL5Ws3PqahTU/DPlqeHFUxkRRwb6CwcretAfiGKunNV/l3d50hJDG5jXzbSNYosBC83bgyN5EOmGP+by2q5CC7FHN6IOYYSbo3X+k1nVta917yheOStC5krqIleu62DIdZ9ytwrPTqDw5sbV+pYWL7tRTsfQsdk//DI7Blzt/B+gd3J30eThquusbeGPc4IPQcht8jLeNKLkD1CrLhTYYuw24sY+8Jd0180ddmNMtEz9DM1LoZJVvS5PfE2gMbrCRANGHtB2Vcu1hwO8ob9K8zpayOmnpZAVXkInVJFaBgvA95oQntXAVEqckNbs43d40fhVrtGZ/YBk/RiBdy5bAJjzhd0kVVg9f8RHRnz6KYdIOeqy4VJJ1sYgM5I0CiCX3/BFmNueN8XuePBuMZyPJUFTZx9KR35UQnos38f72K6f4qsbuCIl3vmFyj50dytfeBs5zrg07XOx8CIvtlIsyNrtgKOohmJdgg0s0kHQ0kIbfhOU479woXt+fJStA92RQnJh5pM7E51vBeyite8/BgcGB4PjhrBwlvzWonqlp27g9cM1pt6guUp3U4HYyENAwIkvRNyTXMDGpZpF0LHtsScNB6YllTzrdfxGjMXv9rLT6rS2P9ZttTOH8ZanYEjn7noDAFb0j3BkMph8H18gUGpk+9DO8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXRmYTh0NUFmYzdjSUQ4by9ENHUvZXZLeHRCeUovYmhlTWdXbmRmRWQwenVX?=
 =?utf-8?B?bnFTUGZWWDZjTFVFdmpKVXdaQTNoNUZzTUxQMSs4WXJVaUY0dVExaHBXYkJh?=
 =?utf-8?B?RzhXQ1Yrb1NOREQzQzlsc1R4VCtJQUNtUkxMMUFYVE16eXAyQnJlRTMrejJ4?=
 =?utf-8?B?OWpWd1dpZVJQYjJaSGxENjRJRmtUSEhlYUhHQVozb1E4RlN3UkdmQmFaamRS?=
 =?utf-8?B?MDUvZUlwYjduZkc2TkVvUVNCVGNic1V3bDN4T0hhSHc2TVdNamRKbjQ4cVl4?=
 =?utf-8?B?Z1UyNmx2NkRUSTVCVCtxUkVzaUVxWEZzOHUyWkNMdnUxVDdNcmpiQlY3ak5Z?=
 =?utf-8?B?K3dkbWl5RWkwUHJyUmFTTzErV0gxNTAxcm0rYUtrdUY0YkVwekk2TGNZZ0ha?=
 =?utf-8?B?UjNDM1RxOWw5MmZrSVA1TDVzaTdjSVAva0V4QTlZUlkwS2wzRDh1Mk1wZmMv?=
 =?utf-8?B?UWV4UkhMdXpVdG1wd1htbmo3eWswN1NZcmdxRDlyL0hITTRGOGFkN0NGZk1v?=
 =?utf-8?B?RS96a3pwRmo3ZTJCYk9BQnRTMzlWcFFRTWVxM2xPMHJvUkZFM3QycW1iZk96?=
 =?utf-8?B?NXlxWjBkUUdkZ21Jek02QVR3dUR0T0U0bjh1c29DN3FkZjVMdU96VEtmNEFP?=
 =?utf-8?B?VVJZVHJscyt3TDBCajFpMDAzenhSTTd2TWFwcUxaNkE4TDdVK3NOaGxXdEpC?=
 =?utf-8?B?RktVaUl3QUd4ZVNRd0FucU02emcvNUZpZkZDRGpqN1JSWHVSTDlEQUZuY05U?=
 =?utf-8?B?RkdOcXZSMjJQNU10bEdoNWJaZERvS042YUdRUFVMSEhRS0ZHUEp2bUNNQlJG?=
 =?utf-8?B?SEZlYTJjUDhBSFFjcldxNEpZQ2IvUXlPeGZndnBqUFdlY0dtWmtMNUg2VE5L?=
 =?utf-8?B?d2ZoV1dEaTRNblhDRi81aER1UVBWU2d2YU52WjZOUlB6UUdYNXVZSkJ4UURH?=
 =?utf-8?B?WUwzZmUwcGJrZkluL29ra29XMUQrMnhFSEd4MnVETEFqUk1DbkE3K21tWXNq?=
 =?utf-8?B?SnNQVmoyRkhybTNXYThaN1ZJOGRGVVJxRWpINnFoby8rNmlqLzRoQWVMdTFr?=
 =?utf-8?B?VDU3d2FKTStDYXk4T0JNb21RSW8wdVorZ1ZRMytSdTQ1SE9QQkZscVZzRVNK?=
 =?utf-8?B?aU5jVzNzdXJUb25xalZXMG5hSTczQnE5dzhhbndibHc4YlVYUDd1by9xQXMz?=
 =?utf-8?B?L0NtZVhrOVdBZUVmTE5RTTBuTFBLbS9GZVZBSmloUnRjaXByVTRWR2lJbTZ6?=
 =?utf-8?B?amhPZkdrUDc2WHRZYkN6YjRPNE9vc1MyNkU0OTdkV2t3NnZrVmd3MmFaMXM1?=
 =?utf-8?B?dFpvM3hVVXY5cnQ1SXFPdUJUaml2WGdKSTBxUkNaUjdWSVRsK0lMZlE4TFJy?=
 =?utf-8?B?NVFTL21PZHpMemFkN1EwWk5BYUVDdUFwaUNmQ2xGOEhNcHF0emw3ZTA4K0FE?=
 =?utf-8?B?bzJxSUptdmlLSSsxWHEzU04zK2JuYnhITXZISXUzaW12ZDNnZlJpd1I4dEsx?=
 =?utf-8?B?TGhhazZhRFNjTnpYdVVLTWFTQjFrSzdMUUhpWGRTQk5FMjUzdXBOMENLcU9q?=
 =?utf-8?B?ZW55WGQ1TU01THpvOGUrbHNjaWhndjZhTnB1YWJKOXBEQWd2c0JpQWhaRWVJ?=
 =?utf-8?B?OTlxbDI2UXcwYU5HS3hDZk9wRHNybHpGUW1vZDdNb09WeFhvbVlVNGZocmtC?=
 =?utf-8?B?S0lTVnp4OXFodlNwOXcxUzY1V2pZUVVEd25CL0NQb0t2S3RFOTlnK3doNWt2?=
 =?utf-8?B?WXhEKzBDc3JhdnFYTjA0TDhLNkwvVHhYOWNMSnkzWmIyMFYwdDFJNk1jbU5z?=
 =?utf-8?B?NG01YjRuTGRRRnFTVnRGeEtBejdwa2NnRlU3OXZhR0Z5TFN5NEljczE0VzZo?=
 =?utf-8?B?OUoxa0VDRDV1VnBmQkljQjJNWlgzZGdISG5RMEF4TVh2Q0t1amVlbEJ4QVB1?=
 =?utf-8?B?cFZYU3FUVW1HekhjL1dxWFdoQjN6eTMyOEE3N2w4VWgrZTcwdGsrQUdmeEZ3?=
 =?utf-8?B?UlpmaFA5Z0tSeUdyVnB1NHUrc2dXNmtYVExoV2RoVm1GakxOMUtVWHpBMERE?=
 =?utf-8?B?M1QvbmhkZWoyZTFhNlVpSEFNOHhDNzZuQVNQamczQ0tZbkU3YUMzNUx1cHhs?=
 =?utf-8?Q?qGna34ZaPiokSUpt15YK8ZBjh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072b2e88-5361-4e81-1022-08dc5e2441e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:48:19.8741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZHJypK2/09Vs3VyEMtaLZczsr+qngVjLn3gKngNcRfJvIh+puoaFEIATVIyzu5Tfn4KM+QdCxUSe1Z9bUo8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

two patches update binding doc. two patches fix dts file.

dt_binding_check each patch.

git rebase -i aa8a0e0038936 --exec "make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml"
Executing: make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dtb
Executing: make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
  DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dts
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dtb
Executing: make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
Executing: make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
Successfully rebased and updated refs/heads/b4/esai_arm_dts_warning.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- Add rob's review tag at patch 2/4
- default: 64 at patch 1/4
- Link to v1: https://lore.kernel.org/r/20240411-esai_arm_dts_warning-v1-0-5e1a7c7be9b9@nxp.com

---
Frank Li (4):
      ASoC: dt-bindings: fsl-esai: Remove 'fsl,*' from required list
      ASoC: dt-bindings: fsl-esai: Add ref: dai-common.yaml
      arm: dts: nxp: imx6sx: fix esai related warning when do dtb_check
      arm: dts: nxp: imx6qdl: fix esai clock warning when do dtb_check

 Documentation/devicetree/bindings/sound/fsl,esai.yaml | 6 ++++--
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi                | 3 +--
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi                 | 5 ++---
 3 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: a053fd3ca5d1b927a8655f239c84b0d790218fda
change-id: 20240411-esai_arm_dts_warning-86753197f796

Best regards,
---
Frank Li <Frank.Li@nxp.com>


