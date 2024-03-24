Return-Path: <linux-kernel+bounces-112610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A2E887BEC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 08:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311361F21975
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 07:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AB614F65;
	Sun, 24 Mar 2024 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y/8gvkSL"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DA14A99;
	Sun, 24 Mar 2024 07:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711266238; cv=fail; b=dF1L7WRFpvoSosaW5ZmTikm3wlZozdoWyF9tnWzkI8XA1mqGrJ7kEluPWrvCHJ0H5qAiaiRYHbBtdZ5QsYbVtqKzyEfb+5lrvehmr7VAmqNsA10M75r3pcv+OYgDizO51wJ2SWR12lPyejTMn4M70No9VTUe6tBVOyKq5uRkjRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711266238; c=relaxed/simple;
	bh=qAh1W0wuVwvNymC0GxVExwYXQOFSqFwsk3xX5sKMhEk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=C5pDUQ1z2iKLccnJm8sbY9UfJUM72sBhZoW7GEzeFCaZ9FngQR/bk26DR4gL9mmGRP1kKiSawdkjRtCBYc0gS7Mzm8Pea1aNeJ09MRzI8kpxo7hRt6wVnXEx8bPmmQfA8yXPh8D6bk3FYavCuX0VtYBVaf6bDuIQi/2gOf37Yto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y/8gvkSL; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCYDPWIkJbS3R90jIvnOlYn8yMetvP2dyRPK2fqrdhCFnhbhfBQZoEpqK4/mGsntnj3ZBrLdAn2mmG1kthAU6cnziVH/fABbB3+N8gn3ecbtVpx3QCIFQu0c1YIBxxmkYNzMsMZ3k4vpWkXzVjp+uFV7I4ql25W3L5koOcNCgoJP++8/Vv9KiP6dHLW9NjMH5PVpeNaPk3Np1dVZSo3VcGj6hSyPKqufhREOcWtEA11HxNaFkgxWoGoiBvfIb+w3ZJZ/+3d2W1aex2R/+VL8vjlbQ3ZVSnNDhZcL1tBeK5pFzVVI2KPs3B3rEZVg7GP+r7h8UaGH+UdueojCgEWzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBGXZEvav8N9nKGgvvBh1mDkm8WyY3yV+GNW3jQHXg8=;
 b=b+e2WYqG5V7QPbXW0wPMQx2T9QtM41KJXL3khk+8jEXSlIMwKkyYNRgJDVh0oMaYGR6zhfZ9rx1A+vIHOZlPvnYB/7jk5ylQhKE/Jt7iMavOJs1GM9Af9ctB9TJs3ae2lWcPUR0M0kM7HJ9JIi8A5QnvYlUHg/CcjGuP8IXDDkPGDNSVjIbQFndM23pSAGLrso2XD8cF9pErEFK3AsCx/m+Fjdq8sgm7szxBvf5yL081WusO7pLkpJkCtSUaYml8Tw46MzdMmlTQBFKwJXlXEJ7Tbc336ZvZOV4f7W1hJVpn0zPHIqbq/S7VjdQC8yXO+Ld8ppgLHOlyB819xLFqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBGXZEvav8N9nKGgvvBh1mDkm8WyY3yV+GNW3jQHXg8=;
 b=Y/8gvkSLoE/N+gb2bkanGaMPcnzFyP8vJiKi1vanjCORJohAoN7wPcLS5V0Y/MzldjteZc+tnJ1dEVW0qVung5ro95It/OWHcXl3KUMB1YwAWpVl8Qn7DKXyEimUoGmy7U5QTz+BOgev7Cahye2o2KuEMD6qrxmFe9XHPmayv4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 24 Mar
 2024 07:43:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 24 Mar 2024
 07:43:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v5 0/4] Add support i.MX95 BLK CTL module clock features
Date: Sun, 24 Mar 2024 15:51:59 +0800
Message-Id: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ/b/2UC/33MSw6CMBSF4a2Yjq1pbwuCI/dhHNDbW2nkFSAEQ
 9i7hQnBRIbnJN8/sY5aTx27nSbW0uA7X1dhROcTwzyrXsS9DZuBAC0AEu7LMY24Kd4c+4Kn5BK
 UDjUCsGCalpwf197jGXbuu75uP2t+kMv7rzRILnhqoowUSm0Tda/G5oJ1yZbOAIcWgnXOXImci
 S3avVWHVgWrBZLJhMxAyr3Vm1VS/1odrAVlCZSJnYPNzvP8BaO8eIlcAQAA
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711266729; l=1953;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=qAh1W0wuVwvNymC0GxVExwYXQOFSqFwsk3xX5sKMhEk=;
 b=9b5nAUjGeHl1phfJRrLQ+a6AE8xXtMreCcsBNhawFOnsm4R4lD35IcoNXztQ8fGOpNC/pxW0P
 7sWoMWrCr1vDT+K6v3EaLbmf40u/pLxXgU8ANjYf4s4j4VPYLZ1Z29h
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 463dd730-de78-43be-a6bf-08dc4bd62621
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FojsUuy0KcxpSOalY15XRz6OJ0ydRdZyKrOmNTfd3UNGLkW+ze1sXb2UTwwPzylNGWk+xSXOjqY41QBinUGk4h9ehfEjtqq4MFwtMqx0RwkscGb4X00ijqlne0Iw9BG/jVJq9PdPvsAqDpu2PNvpwOfu9vvMVIC7WB3T1aPi3NCoWKVNhEofoA3dxcKa4gQLbdiWC9QREoJw8CfXDrZmb3z5AsFI2iCkOw6nN6wvxuVkbJCRgtlphoiz8jD/hhorgbnWciyFbX4uFATwQDYKVL9Ej0D1F8MiF9ux5C7vGu5wOAzlbJ9EeHFcFpvM6XY3nyJvLhJZiBGM0tQKlaXRIzwroB0XywTDvMbWzdmx+qMAEDBoGaLZRHccV9cgj4poGYliWnfAMWV/XgXGXI2LpCN6crJUb8z7lxbxe+fwpVh3XuLiBDLCafvTUXObUpRI69uqg6eSSxGuQTCaG/xdDBY4Lcsvfx9sm+OVAwX2BHsXJNk8EjfBE76c8uHs8oHbGPwzNXXASCPkFw8Vou5r5A1dgQbfe6Ru8K3GxTPuQvI24ly20+h0UwHzR090MR7mfxz9Gp9Sh0GXH0d3Zi6p7gI/zNWfXA7BzearSlM3n5IwYKKL4j7AwvjenoakHXf0QzfwJTzSa+4OUMGGpUvrPDMArZ/I0VLfQYfPqlWuoyo7iPMm2WQv0g7k0xj/kU3P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnZnRVFQRUl6RXNvL1hBTEVSMHBFdURENFZmOTRVOEFFcVl5TWJCb2czQ1Vl?=
 =?utf-8?B?eUtnbVVuRDNYK0puV1k1ek8yTUI1U1NWQlBOWE9BV0tzemFGREtKUnE1VWxT?=
 =?utf-8?B?d3g4VGwxL0JhdFNyamI0Zzh3YTFybDRyMXNpY2pZWWdLNjhWMU5tNVFyOWxQ?=
 =?utf-8?B?amplU3lQZGMvYmxXSm11NnRFQXlpR2RrdWd3YzFNc0ltNGJaUVI5VEFiYi9X?=
 =?utf-8?B?WnZld1JEQjg5WjJKeE1sd2pjK3FMdVkxdWdGSXd2a3RWWEtvRDJnVmdad2NP?=
 =?utf-8?B?MTlZdGIwNy9WR1BxWERCM3VZRmt0WS8xaG1wTVNsME9Ya3d1L2hCM2ZySWtO?=
 =?utf-8?B?RzVYaWVFOExQd3l6V1JjSVNjUTNQYjdCWDVCUGtXOWo3UFJERzlCZUNhaHlq?=
 =?utf-8?B?TDh2cXhOSmtYS0luVXhZUzR4UzlNeUxXOXg5bW9IMitKcmdGYXM3MDJaL0lG?=
 =?utf-8?B?a1pwbmlYS1MzMmU2WTl1WW0vV1JPQkFVbW1pWkt6MmxNRmZIY2lwRGtnazFh?=
 =?utf-8?B?aVphb1Q2V25UUlNINDNtSU50SDBWeWVQMW95VVZXQ3RuSjQxZlJKSktycG03?=
 =?utf-8?B?YnZxTkhBOE40azZ1YVkxdkRzYXZmRm5vNHlTQ0F6cWRaRVNKN0c4UDNRa291?=
 =?utf-8?B?Q1J1NWRtNG04dEUvSm8wVzZ1eUQ2dnkrSWVKWXdzeVRCaXE3enJ1ZWlaYVRu?=
 =?utf-8?B?TG9lOTEwQklOYkxWL3NTQWt3OTlIUzBTM0RrY0VxRmtid3kzRXduT1lCS3ZH?=
 =?utf-8?B?MThBVkV3Qm5IYnJzZ0RlMnFwTVZQaFJlbjNXL05vUUlscEJRVHFoVC95c2Fh?=
 =?utf-8?B?NzV0cUhvTVRsSUVMZ1B2bkJ4Q2s3M0N4R3ZhanBsVlVNeksya2Mza21GUmV1?=
 =?utf-8?B?c25kWDRXcFBnNGIxNFJPaXk4THI5SXlVOFBjYmo0YjhzeHBYL2ZBMFNHdWJM?=
 =?utf-8?B?Qk9Uck94V1Arck5YdkZRbkdpN1FleWl6c25PSWlXR3pnK2x1NklqcEg4ZjUw?=
 =?utf-8?B?aFZ2K05vSHYxdlJIdG5CMTFKL3J3cXlMTFF4Z3BEL2FaUmFzaWlQS0VCNXhC?=
 =?utf-8?B?bG1WbWxXcllISmM0ZFVpeDM2THVvK3lBMW82TUVNVDdjWVpaNHI5N051M1M3?=
 =?utf-8?B?MFNJTDZUT1pqQmh3VTNoMnNvaFkyQnZ2TExPNzUrdzRDODUzdGlJRjNWWjhu?=
 =?utf-8?B?YnRjaWRENWNBL0NmZ1h4UEZCVTBLdVhVLzBZOUUwVU11bllCcHJ0d2dISzFY?=
 =?utf-8?B?RnRnVE1YYldRQ0NXbmQ3YVpleHlaQmtiVDY4cHpiN2VnQS9Kd1c1QVNWS1dv?=
 =?utf-8?B?NnYvYUtTQ01mR0ZzOFhDNHQ2MGJDU0plOFBCemR2eE9CV3AvQ3YvVWwvdTNq?=
 =?utf-8?B?cThMa3M3bE9wVWw0eldoVTlqeTdIVTVDS2ZkbUlPcEFXOHd3YktXY2cyMDlw?=
 =?utf-8?B?WVkvc2hVWm5tK0VJRExGN1hienJhem5mOWQzMjRYUHhWOElnSy9qbkh5Zy9h?=
 =?utf-8?B?b0hIR3hGd1VDYXRJM1hJeFB5VUlXb3VHNFFMT2lNZlM5YzNRb3Q1N2ErOVdt?=
 =?utf-8?B?ZU1JdUVmSDVha2d1ZnR5elN5aGczQlYvSVpna3ZKZ092YWdlZWQ4ancxendx?=
 =?utf-8?B?VHdFWlRIVVR5U29xRGxUNGV6NjBrNzRaeFR1dmZYQ1dteHY4T3lVbytnYVY2?=
 =?utf-8?B?WExiY2RzSFlUbllhbGI4VHU1VzFrZk84QUUzM1k3VnFIZnIwcU9nMzRtc1A4?=
 =?utf-8?B?SHIzWEdMajZBbEJaQXlmOXZOQjdPUGg2M0o0Qm41dkM1LzExdmtqU0toR3Fs?=
 =?utf-8?B?c01ZNVNFK2o3YXdJMWo5UGNuU01HbnBvZUxnSVp0UlkxS0lib0lLRnpvWXVx?=
 =?utf-8?B?b0dQbDROam9KMEpaV0RmY2h1VDBRZFp5RTdRWkxnTHk3SzVzWTZNM1ppYTJY?=
 =?utf-8?B?eHhyMTVqVDdHTGVjaDNDcC83N084c1pxTWRwRE1QM0VQMGI3YlpuU0JTNjRh?=
 =?utf-8?B?V1k5L01UdTVsMlBuKzJiaTJkVFB0dUZqcHFNcTZQNGJMQlFnZWRhZk1GOGVY?=
 =?utf-8?B?K2krWGRudC9PbjF4UDJ3NU9aN3hMM29EVkhYRjg0UG9HbVFkNU1penRwZWtk?=
 =?utf-8?Q?Ly0do7r3WI6iocPAO8ZJK8TTO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463dd730-de78-43be-a6bf-08dc4bd62621
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 07:43:51.7665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eerRJRuq3chGubcgxOsj1hzojWNsAQ5jkicRq8J4wNIxuJbsdZ8jQmwJczYLt7ae4P7SHzqJf12ywX2dkLvWgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

i.MX95's several MIXes has BLK CTL module which could be used for
clk settings, QoS settings, Misc settings for a MIX. This patchset
is to add the clk feature support, including dt-bindings

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v5:
- Merge bindings except the one has mux-controller
- Separate clock ID headers in a separate patch per Rob's comments
- Link to v4: https://lore.kernel.org/r/20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com

Changes in v4:
- Separate binding doc for each modules, I still keep the syscon as node
name, because the module is not just for clock
- Pass dt-schema check
- Update node compatibles
- Link to v3: https://lore.kernel.org/r/20240228-imx95-blk-ctl-v3-0-40ceba01a211@nxp.com

Changes in v3:
- Correct example node compatible string
- Pass "make ARCH=arm64 DT_CHECKER_FLAGS=-m -j32 dt_binding_check"
- Link to v2: https://lore.kernel.org/r/20240228-imx95-blk-ctl-v2-0-ffb7eefb6dcd@nxp.com

Changes in v2:
- Correct example node compatible string
- Link to v1: https://lore.kernel.org/r/20240228-imx95-blk-ctl-v1-0-9b5ae3c14d83@nxp.com

---
Peng Fan (4):
      dt-bindings: clock: support i.MX95 BLK CTL module
      dt-bindings: clock: support i.MX95 Display Master CSR module
      dt-bindings: clock: add i.MX95 clock header
      clk: imx: add i.MX95 BLK CTL clk driver

 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |  56 +++
 .../clock/nxp,imx95-display-master-csr.yaml        |  64 +++
 drivers/clk/imx/Kconfig                            |   7 +
 drivers/clk/imx/Makefile                           |   1 +
 drivers/clk/imx/clk-imx95-blk-ctl.c                | 438 +++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        |  32 ++
 6 files changed, 598 insertions(+)
---
base-commit: c9c32620af65fee2b1ac8390fe1349b33f9d0888
change-id: 20240228-imx95-blk-ctl-9ef8c1fc4c22

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


