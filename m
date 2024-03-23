Return-Path: <linux-kernel+bounces-112318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B9A887848
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A342AB21691
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809118659;
	Sat, 23 Mar 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KGbEWrlh"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E013FF2;
	Sat, 23 Mar 2024 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195653; cv=fail; b=pI/yjuXF15vSTD62WAr9TRwbnxmK33HI00hOJy+eP5Ma6kfVZ/5oI+4KPypdISPwJOykgqBUii3QqSTq6zHDMhzKZDuWH5SEC4H/OO7FNPUhRPK07GBLiohoC+HaxNORJkHjukaZDu9jxpRt+qeXxQJt08/QVCp4O/QdrrO9mjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195653; c=relaxed/simple;
	bh=TSzKEltLOaKyCBCRY/QGbycC88hGprc9tLM75PfAqEM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=XHo69u4u6fIimPxEKQ+/AqvbnrrNkWQQ4V1fixNixrtvAUc2Mqid3y8ts11YI2od2JPQ30tVQbd8A9SJCoccCbSO1EZlZwHxfmvOraV1uGujUSVIvFzg+/I5CJ6o62X32O/qO2BdLnmNEBw/z36ugRt8ro8qD5fVgApdwcmXJuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KGbEWrlh; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZtpYtsaWVsR8LDcdnSJWwr6tBeMeN7wijzy/A9Mw9M5AUymnVrfkIO5/MoG3lQMvn8yqmAardCLb6GKo0UIQiEi139/lqAaFsSfRS4f90A3rOV4RkJNpetgqGhefV/D6T/7he7TZ63FFenRQpgp03AbmO6/miWsh1vJ5uu0Di8l0TCIYwcKWqTeLvfW3S8P2p6iIXN9z5xQCWXsN8wZyT05k0y+8izBZRk56u7O0dLZDyYtKeBv1FAjFdUvHnYXMrXYb8dRvwBStgUWR3m7LMw0N6XyIHn2d4DSQqdyoEOR0OQ7m7z7mUSGVhU1/JGJtmnE972HBJfvh6M8DHj74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVX1wlTB41IfG8UK5LfReLbUfuPzJe2RAix478CDiak=;
 b=KVjkRrOdGmDWbNGNvAXFXu0SfujLSXruw/hXLD2e7kc8o7voRTXmSRyfVbGhNHqLhHrlRUnL4fIjzSMA3o+mf2dZ8A+ugtHh4lHB9t48Lmh8Ayr3HUtlyWnAGoq/4b0yC8GRA22X4GXXPO5Vmh+wIta4QQ8xtLWQKeYCI1P8mDhEmAw0JCaOgWBw929exfuX2uWsCrjHz/qf8eVnRhehphg0qS7/mUF6K8NWNhzh7Q6ws+9zt5JLig0k0z1FHNU1ZzRpj8xs0WRjwahCdElcquQ/KL4tIAmr+Hk1YhNprMn+kuZf5f/nNMBVWl7Mv1PzQv5Fcw5CXJzBC9VMmJN/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVX1wlTB41IfG8UK5LfReLbUfuPzJe2RAix478CDiak=;
 b=KGbEWrlhsENcGoJky1ZBneHFDDPxi8d2B6Gvg4E6/UrqU8fipV21Abk3Npp9m1V6WBN18nU7hrqUseJ/ItNfSM7+3qn+b1Pje5bWTCn7LN62dM+5GWH5PwbfmqlL0e5XVCqQK2/S3vZwd7C3U91xgmo51iuC3PRCgl6nIgP9B2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sat, 23 Mar
 2024 12:07:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Sat, 23 Mar 2024
 12:07:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v6 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Date: Sat, 23 Mar 2024 20:15:13 +0800
Message-Id: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANLH/mUC/3XO0WoDIRAF0F8JPtfijKOueep/lD6oq43Q7C4al
 pSw/14TKNsIfbwD5965sRpLjpUdDzdW4pprnqcW9MuBhZObPiPPY8sMBUpAUHzJU7iUL17DOXM
 KygtpKFHQrJGlxJSvj7r3j5ZPuV7m8v1oX+F+/adoBS64SFGqSBogmbfpuryG+czuNSv+UhIgq
 KPYqLN+HLTzyg30TOUfitBR2egwWvLO2DG44ZnSThFlR6lRELEtSmPRdKtqpxL6h1WjHqwyOip
 lEu5027YfpEB2npIBAAA=
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711196144; l=5474;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=TSzKEltLOaKyCBCRY/QGbycC88hGprc9tLM75PfAqEM=;
 b=kjq4mzLXfIZ0hlyeGlMAsrf3R2ZJmbQfg5xtjsXe12baFaPt92XRHuRu91AYTvhrv9+YT+H8s
 eRmxnRi1Th1Doph/V85tpmktpkLfvI1FTTKKTZmVHZNYok3D18TwuFP
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: cdcfb835-ec5a-4a2b-6c73-08dc4b31ce1b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bgT5JSxhkuZN5DKf6p0aIV8mfjaL7rS9WsoS2uXXOMZyBmr9ktCzitNxfPn/j0u9cT/wLFLM+4E3wwrIsCgEjen8Qv3lSD80L8gFVK73SnFa2iz8lHZ/SIz7jIMmuBceNHO+b7jo3+UEbN6WciDSPVteebAIIm8o5XgZyjieNKLHWyiWKDT5+8K4zT5ZJ2n3PtTm+7Jz+HiiWIqqaKSm8GrjwN0A3ZEpSZpYIH6oX6usVA+wfVn4IYPgPOww0EVA8GGcT2hZRb8h3sTn+zbSxbkOCZM6a/PJnqRIZlLMHTjIpdzKD+I7YAT/o1rG2m4Cx+FCeSWwBVp3uMgLlKG93R7VPKG+wyL0QutEXK27DtXjxb4YD9Ivtuxcs9oFYaik7XyCkZBxcLJGmdGMM+NrIXOZvFPihdAiDgzrFvB/X6hahU1N3v5PhfW0fiSXfw0tB1LOM42Fd130dyjFIyAgJUpPjOiB2Y8ELuuxC8JJ1XOEsNfEqo8U3TemBSIGMo7M7Gtyx0882poe3sQchxOCBsJ93aY6kCOveTfKsVkmvQ5K565c9D7gb/n7SC1kZDUXgAk2bGR+CSEaG6mQ8C5mTXsFd3hZDmZN0UOUZj2HFH1rG1eufyKlscejgRF+Bly2QXBTxhfyGcAj7z393862OZR+AGW/bq9DiCPr/CLFYMM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QS9oTGtobmcwazE4Qmcya1Z1SGRpYklUYW5mSDRDSjVvQlRUMkZyOERvUEtz?=
 =?utf-8?B?ZFFGMUZOSXlFa2plR0pUdEFoWmZQMVdwWkpGQ0lTVXpIcWVWa1FwUDRkeHZu?=
 =?utf-8?B?TjBqbTBldXBOWkthdWxUbmc5UlJxVFVCczI2eTBsT1g1ekphWFhvYWFLTUQ2?=
 =?utf-8?B?L0VET1VaNHlMeUtkZ0traW5ObzFZQm5pZzhteURHVmJDdlBvSTgyY1pMRFcr?=
 =?utf-8?B?SHJTNFg4dEdJbS9HMkhGSWlCSUdLN2xaWTBvM0UrbEhkUHp0bDVjMW8zR2Jv?=
 =?utf-8?B?MjVEaEdOQzQ0T1E1NHJEaUVtdlVva2p6V2I5U0N1aFFnTDEwMVUyZCthbER6?=
 =?utf-8?B?Yis4MHZlTGpYR2NYc3BhQUpVMWhwL2RxVWEyOHNTalpCNktoTVcwWUdxZ09B?=
 =?utf-8?B?R01BWnNuZVJsVVZ5TXpPQmpqblh3bk9WWWhZSEg0d0EwY3RDWUFza1F2RDQ5?=
 =?utf-8?B?R1JmdkNVd1JmV1IrWG00SXlPWUlrUkRQZWZQK0VFWTJ0SGl3QVJjYkF3clVi?=
 =?utf-8?B?U041bHNIRUd3NUw4cjAvYkM2Ym54VUVxMGJKRERqaHBmajhIMUFYRW82L0p2?=
 =?utf-8?B?NUp4bHRYZklZcVNxMk5OVHVWbExkY0szZElnTU1JeGdxODJaVHJ5VkhlN29u?=
 =?utf-8?B?TG5BaER4SDRvNElObjM4MERtVEtNdDBMN0JDTUNDenhoZ3Zid29pN1hDMTUx?=
 =?utf-8?B?YWpTSTVQL1MrZU5tQnp0UXo3d2pxN0ZSbW9LR2IwcjZVazhZOVJMRWpyS2Zm?=
 =?utf-8?B?cjJsbWRiR0VkR05iY0lta2kyRmNGOVArQXVNNVhIT01JUFlVUTFLMy9ocVZP?=
 =?utf-8?B?aWhYUGVMQVM1ZXAwWHZ0bG8xYWExNXZNMmUvdFVEemtuV2dQa25hZXQrQ0pG?=
 =?utf-8?B?bk51c2VpVDR5a2hKbngrYXN1N204dGFGWDNBOUlDM1pOR1NKYVJWUlBiaTJQ?=
 =?utf-8?B?VmxvL3VjZjE4MHBMQzg5Nmcvck5wV2xEWitOV3lvbElrdWxTSXJRaCsxcE9L?=
 =?utf-8?B?VU12MDFkVWFMc0h0SC9uTlFUK0JDckVnZmUzWlFhZFZiUUFJQzY0bHIrTFMv?=
 =?utf-8?B?dTRQTng0V1lvYkdmYW9BbUllZm5ydXZRSHJzWWtIK3dSTDRoUFBPZkJjcW05?=
 =?utf-8?B?QjE0WTVlQzZjazVxUGczbGhqT2dZSlFFa0VRU0crSmFtaFVjRHNKQm5Cakhz?=
 =?utf-8?B?U0JSQkxCdVUyci81MVpGN1U4MGNjL3AwNzJtOXJUOThQVUtNYlBUcDRmSnp5?=
 =?utf-8?B?bjlzYWU5VGh2ODJPNFNZVytrTW5tcjR1N0didm9BblVWM09adVJoSzhtZ1Js?=
 =?utf-8?B?dG0yV0VNWmg3SU91eUgwS1VKTExDWjlnaTVpN3FnUTFMNUloT042cjdsMWRy?=
 =?utf-8?B?b0VpZXpSRXY4aHlkN2hhTWxTbU1SKzB6R3VuSEdndE1XSlpuRjhLRDFaNjNV?=
 =?utf-8?B?VDJjbkZZNzlJTUlWRU1keklSWVc5UFhhclVlUGw5dVhFK05oMEFhZUVYdVMy?=
 =?utf-8?B?Y3dCdVJYaVVyR1pvS1QwZlM0MVFvTHVRZGUyZUhneEFXek1nSitMOHhZVjZQ?=
 =?utf-8?B?YVc2WEl1ZUl0SHBiTDM2TnNSc1dJbWd1K29oNFIyZUZCdVlSWGYya2FZOTVh?=
 =?utf-8?B?YWhlYkNMUVNKWXpOOXFLQ3NFOTNmMnJoazNBTUo3dGpzM2lXNzg4SkVUWkRj?=
 =?utf-8?B?YTFRRmNTRlE0LzkycXNVUXhISThNbjZjOUU2cllCdklrSm9jczFFZGp2c1dV?=
 =?utf-8?B?aTA5Y2pINUgrT3BxN0hvUnZTQTBCN0hKOG53NTd2OVpaQkljY0xFclBiN2RN?=
 =?utf-8?B?VlB5enBhNEVXMWxYRGIxaDM0TlFqYzROYzQwRHdqMkVoaXRCQUFNLzU5SnFu?=
 =?utf-8?B?anBaYWp2bXIzb2JKeFdsQ2M4aWdNZ09zRU80MDFzM1dUZUdoWHFpTDRCM3hy?=
 =?utf-8?B?eDAzcnhhditjbVRFVmlmUzE4T2xPcnNPN2U2c2FlSHFpdFd4Umh3cVZ1U0xP?=
 =?utf-8?B?WklKWHAxKzZ5THRRZEduY3VIeW1oY296eWxWUUtHMUkwc1IzQnVOTDAvUGF2?=
 =?utf-8?B?akIwZ21Vcm5QOXorMElPNjIxRENTOFhJeTNtQk8zaGdGbkcrNm9QSVR3N01t?=
 =?utf-8?Q?8LAm02ZBnct0Bx+O/gxEEaDLO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcfb835-ec5a-4a2b-6c73-08dc4b31ce1b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 12:07:26.5111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjTdS1Bov/YUN61eEdniW17nwxqMi6uwBOc9AcIh5xjSYsOah8K/6dC7sbwr//HDJBRCpaEYFzLhSJ+KEvPTEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

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
			IMX95_PAD_GPIO_IO12__TPM3_CH2(0x51e)
		>;
	};
};

This patchset has been tested on i.MX95-19x19-EVK board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v6:
- Update pinctrl driver following ARM SCMI 3.2 public release
- Addressed Dan's comments, and followed Dan's suggestions, thanks.
- Dropped R-b/T-b in patch 3/4 and patch 4/4,
- Link to v5: https://lore.kernel.org/r/20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com

Changes in v5:
- Rebased to linux-next next-20240313
- Link to v4: https://lore.kernel.org/r/20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com

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
Peng Fan (4):
      firmware: arm_scmi: introduce helper get_max_msg_size
      dt-bindings: firmware: arm,scmi: support pinctrl protocol
      firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
      pinctrl: Implementation of the generic scmi-pinctrl driver

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  50 ++
 MAINTAINERS                                        |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   1 +
 drivers/firmware/arm_scmi/driver.c                 |  17 +
 drivers/firmware/arm_scmi/pinctrl.c                | 922 +++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h              |   3 +
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-scmi.c                     | 564 +++++++++++++
 include/linux/scmi_protocol.h                      |  75 ++
 10 files changed, 1645 insertions(+)
---
base-commit: 70ca90deeca172d343bd18bf7fb2f992214c23c0
change-id: 20231215-pinctrl-scmi-4c5b0374f4c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


