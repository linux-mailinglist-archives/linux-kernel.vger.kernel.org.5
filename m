Return-Path: <linux-kernel+bounces-127126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD81689473E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D124E1C21269
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D36156B7F;
	Mon,  1 Apr 2024 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TMaUFGRf"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2091.outbound.protection.outlook.com [40.107.14.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E274D56450;
	Mon,  1 Apr 2024 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010344; cv=fail; b=rplbh4hPiAJhRboN0Or9VXNDdS+hV9QtnxPzLm2lbNShbqAkcfk3uee8VHKWc3+2oRkRLz87vmynHEGXdKyXFU8eBhMOExQFBrJLrAbBlc8cea2w/xhlCykZCn9QALTLdJRfwDFi53FqVtT0x/Rh39iMOx/ZFTaCsASFXjjHrBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010344; c=relaxed/simple;
	bh=x/POWQ0U8GrRyPnu2nIcIHKAzPh8JAVtPHA132rEFXk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K5RWccmyFd/fqmSIweWO8zs2ZutbSZ8UZ9szeFcnK6AgmZB9yU02Mb0m6xhG9KkUEEHmyCkONsYXVa3DEYORwc6pQqBAFLUIWCkifCkIdaAkzytoFLkEev35yn1mSyM/6z1dqNl4s30acFpyeiEIIoK9g7AwzeFbLR8wnowDsx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TMaUFGRf; arc=fail smtp.client-ip=40.107.14.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPsT9cS8Fx5z5udGF4N4FbvCCNV0FQg1oNDE8r7yxDJFp7GV6tqbkpipL+3alJ/ZM/0XBKbik2Thl2gqg9nk21rEMtZnIVZC+5Zfeu2N8/vmF0nU6Ujb7WqP9csTASH6MLct9wtgyx51DvDsgSR0IVa1GzHotGovPA7Qnh+k3vMyhLvqJoW/5G6dAA9hRWSOiTgQ960xS23S+tZM9ZiDrqF10cvsHgNVotzJXXWIlXmycdBbeI0XEXI249rAVH2fR7qor3LIQdfAUdiMIaDLiFmPwiHHYrYJ0MuYyzB+Ntv7ITdiAXj5Xk1eBJTDxXsIddbR+3zf/V1Z9aTfxM1bVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R53HfYRzJhX3GkT5gsG/BDOMnsWSRBgL276IoWfmll8=;
 b=l5AeCaLsa0Fpke3lI61oz8WJnnm/oAkzo3lV4AuNxq0dZYOUVf8fSAr6pyWPv8YFBLM9xYjLjpPwpKNXwiGR9zujlxKD/fOrRly/XXvqUuQAiyZBMiJhJwXW7OCjxvrbcFxGVri0WUkvNu2NSyPv8QrxQgwGoLWuxRRRANi7Y7zYVFZfyQlQsQimULfyK/7GzpGvhcjhiMtfNi2wX2jlUS8gtT7nQbddTzdiXyMCNHu++mV8u4Mpmqovl1Pb8YDiKZTddw6/vRJvtaf1/Ok/oWvCTB7SjOhwbdkEoNg1MklEGhq6OWk8QDraYtIy8mhTD3lHh/QCdefb+TQBzWH5hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R53HfYRzJhX3GkT5gsG/BDOMnsWSRBgL276IoWfmll8=;
 b=TMaUFGRfrGeQqmN8ln3q/TkfLIr8SO2T1eMERVhXxkAXqfcz8mFxqzV1FC8V+9o0usuWCau/oV9EBpUDL2ArvAy8l8ZYrdFN2ZIMPpSZuRuhw5yMBdLgsf9LUxU3THG1NqkeqKU9EyYUBDeoWOMdo5CrWEFS1N1vle6Yr3xwGhs=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 22:25:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 22:25:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Apr 2024 18:25:03 -0400
Subject: [PATCH 1/7] arm64: dts: imx8-ss-lsio: fix pwm lpcg indices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-dts_fix-v1-1-8c51ce52d411@nxp.com>
References: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
In-Reply-To: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712010330; l=3222;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=x/POWQ0U8GrRyPnu2nIcIHKAzPh8JAVtPHA132rEFXk=;
 b=AzmAY3DZfuLNjebMscfEXDcTc747tITTcwb6PKjovwlB6FEUmTl9R8dcnDfxoj1uscznH/Fu3
 R17n9BWyN5TA6ZTNPqO0B6Z1Bst+MGGaVWpcC1h/MO3vFW9imQTizVG
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
 1FQiqhhMhNjpN1Q7lqAjrgR3hiUJw/S8LXIw0EbbABOMJQzSehEdjm0TNkzyMiAUoSarPJcTKPiH+dA+qrSjp6a3IIdhN37Y90DAiuFzHEc41c/EtwBetirk2BdDo37jpaop9SeYhUoqToDqtGibS33IJJb4XkC0XKty1nXJQgX0U+cp7/az1RUMvoIhl/nHSzfzalvtvUKBwcvwHFTunsxVD3qhDt0WBE/26vuvt6S+KL9ruTt0YvFRDqgOWrIOD89zLkN6sS1cq1cD9di/UhOk8zKdfUBXVbgbhgOHfvwaEjcgNrQK732l29yFN4o1lSDUqJTQ8Z08HYlu39MEydJ4YKF4wytupT36W8BDjJCfPtVqDRKh73OROqLqIWHY9vIa+APxrGT1APrpafIz4ba8kLYs23TUvCNupolvP9FS4drmCSwK3ulfPf/ntui+1CRhKFHaUOwKj+X5fziI0YHWIr8k5QqpT/5jG3w2j37ASiQiRAFMA1wQegEiY/UBVBHEA8cwbJVJnyvPDg+9lx5FxXq1GvXcWZjQneb0WQwg7RvsI9IIIHJCgomh7Z1SQ6UuSj1WcWEhYbIdtKFZn+U8nBCc3fmiScK6aKLFNSEvOWX8pp0UwtVVgZ9MelatKSW1A5bPf2wP2/HIep3jyd+FE1gGvzzgaPWxt2D3w+xWLKWN4pYhXsRRUvUslTLQix6wgq2g0vwhHVkckGGQFJDfAeYzS6SKXvJRUWQSDjs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZXhBc1BqdjBudmhPUUtDbVRyU1BabVhRenJFNlBMN0FvV3YwSEFrR2lFZ0Q1?=
 =?utf-8?B?Zm4rdGRPM1pjVHZnQWg4Z3hjVVNRWDFESHp6VlRldFVxaHNOYXh3ZklaRUtJ?=
 =?utf-8?B?WElJUU00NWEzc1pickdQT0xmWHNvajdic050eDg2Q016VTkvakVhWVNMZU9Y?=
 =?utf-8?B?a3A5aXhTRGxRclFwS3FvdjNHTkgvLzQzTklEK3Nqd3FRcXJXZnM5SEF4Wmh3?=
 =?utf-8?B?MGxpS2FSMlpUT1VEQXNDV0NZbHgyMy8raWlXSjczQUpsRWIzdzVOYWRaV01a?=
 =?utf-8?B?OWVvaDhrb0F0RENLcE5EUXRvM050S1h5Z2NOeUFiRFhCOUI3bmx4aHNHZlht?=
 =?utf-8?B?czREL2lzL0pHTVpLUmNvRlF2Z1lvVHhiaHJFRzhyZlB3NWhYZUovTnoyT1Zl?=
 =?utf-8?B?dVU4WElFalR1WkI0MHZiOVltSWdqSFJQWC9Qc3V6QmRsSTdUREZVMTd5Uks3?=
 =?utf-8?B?VGlVcUpHQVE5WXduWGNEUjhoOTZSU09zbkxhQ3lYSjVrUkJyWGNSYU5JYkV5?=
 =?utf-8?B?SlVBUUFIRHlxZWZNYWVRTFF2VUpOei9EdG1wdjAwVlQ1WklES3BLT3Z0UHE0?=
 =?utf-8?B?S282NncyeFppVi96Wmd2b2VVY2tiZWFWTjVtaEFaUEYwd0owR2ZsQVlpZnRh?=
 =?utf-8?B?NmxIRHI1M0txVXRXOGJtdFRBYXA5U2VHMG9CcVFsQzI3eHMrNFVYTjVveVNS?=
 =?utf-8?B?eko3VURJM0hLMHhRQ3hPWU5FNlFkRkdQODRvMWFpL0JHajZIamVic0JZWEhS?=
 =?utf-8?B?SHZGU1l0ZUpPQSthM1BIMDlZOCtUZ3hXclRMcE5JbG9VUnpsSzNONUphL05E?=
 =?utf-8?B?RzFOdGh0YW1GQzhuQkw4L1ZtL0x6ai9YcFpqcmJhUUdxRW9QVHBpZWJOZU1U?=
 =?utf-8?B?elZSRlpQd3pYdUdlaXB2cU9TeG9RVWtWZmhXZlRhenBkR3JrUFRCdGtKckw1?=
 =?utf-8?B?dmZXeHNUbW8yVUNsUW1KM1M3c2FGVnFORWRlaHEySHgvZGszcE91Y2FoSU8z?=
 =?utf-8?B?aUttekFySHFNNGwzZVJIbkVSSmp0b2V4ZlN4UTUzbkR2dkNmekhGL2JXSEhz?=
 =?utf-8?B?UmhhNm5kT01OY3VveUZGTXo2eUdTZC9xYWU0cWhjcVVzS0g5dmFGOUJ3cSt0?=
 =?utf-8?B?MFdRUHo2anNuRVYvTkhidSs3Z2JmMkNENzZNVE9QWGxoYStMRllOakp6QXFw?=
 =?utf-8?B?ZWdyeENDbE9qRTc3VHh2SjBCbXd4a2lBYURDRTVDTVJzWjg5L2NLZ0UwK2FQ?=
 =?utf-8?B?anBETWdyMXZ5c2h6RVRYd0J1NldNN3pTZ1U3WmZWakFKQlUzZHcxRFVSbFZz?=
 =?utf-8?B?N2V5SHhNSXlYRU1OMFI3aFQydkdqTkVQVkNNT1dzTWJpL25DZWZoS3I3OFVt?=
 =?utf-8?B?Qk40aEN6Z2tvdlg3T3IwYXdXZ1BNZXk3ZWdiTHNwUm44K1h6Rk8xMHVHTENE?=
 =?utf-8?B?MnhmdGcreE52czRMcUpBVW1RZVFoeTQyU1g4WEZzVFRVR0dYaW5pTVFHTEZV?=
 =?utf-8?B?cVhSSmVlcFRMdnE2MlA4TUM0ek55RkYzRDE2dGRyYnlzblFkUTdvcnhYbUdL?=
 =?utf-8?B?NHBDRnp3NGlXTWIzMlN1b1B5bGZEVitDbFBTNk9iUlJsMUJUTDZuUDN6UU1J?=
 =?utf-8?B?bmZkc213YWNrYTRFbkdiNlBoZ2JpUWg2V3V5ZFZzSmdseFlJRXQzSjJJOTZQ?=
 =?utf-8?B?dWF3RXlQdmRTb2VXcWNrSXdWWjVxVWtjaHpBbHpUZFEvSW0wWWIvK1djcGo4?=
 =?utf-8?B?OW5zMkt2UnpSMDZyeENZREt6T2RReWJSWk4vVFhxdUxBNGdMZU9xc082eHBz?=
 =?utf-8?B?azhrWEt0MndGOVc3bHhzNG1Vak5PdHI5WUcrei9jR3lxSldiWmVzc2FpSzkx?=
 =?utf-8?B?d0pxM3puc2FQOW81cWhGVWRpcU1DUFdSOCtiUnNLV3pacFY3Z0NtSkpoZWR2?=
 =?utf-8?B?SGNYdGZqS05nTE1hcithWGVzb3pwWm9tOXNpUUU5NExBNXNqRzN2K3RnUFFj?=
 =?utf-8?B?TU84VTRQY2dIczZqVm9JYkJ6QWlrRmdBMG4ra2F2d1NOc0YvcGdMcGFNMlNK?=
 =?utf-8?B?NW9tRGE1WHdoekhqdE90V0RQVys1REVqZFY4dWJkS0RuZXFwM2VGVXJLaWtK?=
 =?utf-8?Q?o4SA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7c370d-2f9c-4679-e919-08dc529aa8e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 22:25:39.2519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iEz77DGTp4TIsNJ9TenXo8PBYZXuJDf1aIpALEPTLFd039q8Z5+9NrbBUbKZZWdFwJmnIEb2mcNPOdHrKDFEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

lpcg's arg0 should use clock indices instead of index.

pwm0_lpcg: clock-controller@5d400000 {
	...                                                // Col1  Col2
	clocks = <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 0     0
		 <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 1     1
		 <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 2     4
		 <&lsio_bus_clk>,                          // 3     5
		 <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>;  // 4     6
	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
			<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
			<IMX_LPCG_CLK_6>;
};

Col1: index, which exited dts try to get.
Col2: actual index in lpcg driver.

pwm1 {
	....
	clocks = <&pwm1_lpcg 4>, <&pwm1_lpcg 1>;
                             ^^              ^^
should be:

	clocks = <&pwm1_lpcg IMX_LPCG_CLK_6>, <&pwm1_lpcg IMX_LPCG_CLK_1>;
};

Arg0 is divided by 4 in lpcg driver, so index 0 and 1 will be get by pwm
driver, which are same as IMX_LPCG_CLK_6 and IMX_LPCG_CLK_1. Even it can
work, but code logic is wrong. Fixed it by use correct indices.

Cc: stable@vger.kernel.org
Fixes: 23fa99b205ea ("arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index 7e510b21bbac5..764c1a08e3b11 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -25,8 +25,8 @@ lsio_pwm0: pwm@5d000000 {
 		compatible = "fsl,imx27-pwm";
 		reg = <0x5d000000 0x10000>;
 		clock-names = "ipg", "per";
-		clocks = <&pwm0_lpcg 4>,
-			 <&pwm0_lpcg 1>;
+		clocks = <&pwm0_lpcg IMX_LPCG_CLK_6>,
+			 <&pwm0_lpcg IMX_LPCG_CLK_1>;
 		assigned-clocks = <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <24000000>;
 		#pwm-cells = <3>;
@@ -38,8 +38,8 @@ lsio_pwm1: pwm@5d010000 {
 		compatible = "fsl,imx27-pwm";
 		reg = <0x5d010000 0x10000>;
 		clock-names = "ipg", "per";
-		clocks = <&pwm1_lpcg 4>,
-			 <&pwm1_lpcg 1>;
+		clocks = <&pwm1_lpcg IMX_LPCG_CLK_6>,
+			 <&pwm1_lpcg IMX_LPCG_CLK_1>;
 		assigned-clocks = <&clk IMX_SC_R_PWM_1 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <24000000>;
 		#pwm-cells = <3>;
@@ -51,8 +51,8 @@ lsio_pwm2: pwm@5d020000 {
 		compatible = "fsl,imx27-pwm";
 		reg = <0x5d020000 0x10000>;
 		clock-names = "ipg", "per";
-		clocks = <&pwm2_lpcg 4>,
-			 <&pwm2_lpcg 1>;
+		clocks = <&pwm2_lpcg IMX_LPCG_CLK_6>,
+			 <&pwm2_lpcg IMX_LPCG_CLK_1>;
 		assigned-clocks = <&clk IMX_SC_R_PWM_2 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <24000000>;
 		#pwm-cells = <3>;
@@ -64,8 +64,8 @@ lsio_pwm3: pwm@5d030000 {
 		compatible = "fsl,imx27-pwm";
 		reg = <0x5d030000 0x10000>;
 		clock-names = "ipg", "per";
-		clocks = <&pwm3_lpcg 4>,
-			 <&pwm3_lpcg 1>;
+		clocks = <&pwm3_lpcg IMX_LPCG_CLK_6>,
+			 <&pwm3_lpcg IMX_LPCG_CLK_1>;
 		assigned-clocks = <&clk IMX_SC_R_PWM_3 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <24000000>;
 		#pwm-cells = <3>;

-- 
2.34.1


