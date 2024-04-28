Return-Path: <linux-kernel+bounces-161259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B48B49B3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE44B2159E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDE38F7A;
	Sun, 28 Apr 2024 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ck/kXeNf"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE8FC08;
	Sun, 28 Apr 2024 05:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714280425; cv=fail; b=JJkE1bGWWp00bj8CN62KfvGmaxt82gr9ON0t/ZeL+eO3fULCo3o5jsHgZScb9FH9ZBYY9Wj4btX5Jau/NfUDAQb5J6N+k/xkDs9ans2vU/YVnAf7s+3qoqzRMhcRc9v2UoUjUkvp2MH3li0i6CJPqqufJD2KIuMH8/cRyhaxU5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714280425; c=relaxed/simple;
	bh=79FZFIm+UI/swyRovAdUaSRowcqXXxkfq39uBQ9wZ8w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uUKvpCS7Ec6V0IW3uT3PfIq1PpFd44pZMacCkiYg1uskK9BK1Qd3rZS+x3Wg9YmoKbnioHu2GuxMyVJMZ8BPQ/6oKEmUJWxOV7NABU6ayWizWIxO1F90KV5+uXqAKxHkrVBsdxTWypXuhpNh+Gv23g/Hrudpg8oxMrwCm89iGEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ck/kXeNf; arc=fail smtp.client-ip=40.107.6.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb1z16Gl+q4FP8f+/bJNdcQgpCqnV1sdXl1wPFjIOwQt+bzmKusbCZHpzerVU9AEy9btDLg68eUGoZBHwLUyLctwDyMT6VnLFs/t8Gx178Q5mYc9asO+KS/nwZGzYmBwXib1T59nQlE3BX1QFll8gnKg9/05GN/8I6XWVQnsZApOlk7Gz+RU14Cjt1ZDKwk+7zPqKK7uXr3daYq1wlocwSpsZ2NSu6ZM77mPB1MqpmCpEB2s1DWAijRX2wuNLtriH2nhlRhGAUnV38xvulMVZU1EcsAlrKqGuuUVCOfJG+zanMn2KO0/0+9UP3dX6rToP01ur93Sgs7WeOX5c3di3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vafZpEqtNaKDk6F/kMMvF8+XnITNUFDcv+gFv3/KQg8=;
 b=iMl4LGk9TmFUjeGPxboxs+Envob+PeFQloTtDfx2bQZmSveGbGAAkbEJ2XoN81ndQ6fCYQgGl5RxeARUeVBgydfwOsajiKTuoNWk2Sq9YQRG3P3FpKPinbnioJ5R7u9dg1s+1zzX82DMT98K1yp1ZxG57M9Chgaz9PwwJLO9IuqPhVLK5E6dWVQYXFrJWjL0LfS6I61QoEHfCcf9KdzlRLhoCft+kh4fAkacEUMgyINh+SYdeXiE7ZpUdNkCFefZraJxbyIsbLr+FxsrEHkHN/rgjFJjhEdu6XxPlB8yx5AIqbL9h0DkMDr17ChCAmOMeAMpCGPkiZZU9xA6HqYDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vafZpEqtNaKDk6F/kMMvF8+XnITNUFDcv+gFv3/KQg8=;
 b=Ck/kXeNfUXFti/a+cUbro4+7oZi2qh5TsRV/xKy0uvMddKPYW1ClSwsCjFt72XFyFCx9QvGSxwo1z9Her0b8JoYhyZgShFj1jzDa8rnxPWqIMgVWt367tVit5DCVZIUsTaG6kQehzFDM9qa4g9stOsGvcx3zVnIO3x44raj1jTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 05:00:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 05:00:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 28 Apr 2024 13:07:50 +0800
Subject: [PATCH v3 4/6] pinctrl: scmi: export pinctrl_scmi_get_pins
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-pinctrl-scmi-oem-v3-v3-4-eda341eb47ed@nxp.com>
References: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
In-Reply-To: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714280885; l=2903;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=kIt33zJPUCQ57EVxkObHnmfgwRn9lRtI9Vr48NhCXKg=;
 b=8SIjTFnkJgLdOExT92Fmcj4VEXYHbd2mZwP2gWdWk2JAtmmW7lqdMZAWAdJtLvgKZqVDVbNPB
 blqMudnlW1lDXFKKotRIHQGADNf1UdqyNES7nhgjzysUif71eZ7TGhd
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 909a55cd-ab9d-4a02-24bf-08dc67401aa8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c25wMTc4SnpNNUJldC9nYldsTnNoZ2lZbTlrYmc2UmZwSHhZVXBKUk1lNTI0?=
 =?utf-8?B?bW40TjM1VHh4WlpmcFhnZ1IySldjdlhMOHJ5Y2VzSytac0trT3pMc3FHc1ZD?=
 =?utf-8?B?dmxWR3MzclpzRUFKNTlFNDhCUzZzRlh4dUVMN0lKdThnZkdRS0tpSTNCenpH?=
 =?utf-8?B?QmpDdm15VFhHcXZTd2syVytNaFJMcnZMajFsdjE0eFM0Rit6czB5Ym04SjJU?=
 =?utf-8?B?cGNrZFJRdHpJeGRxcmMydWt1U3RtYkk0d1ZFU3hSM2k2VHhnZnRSL3dxZjc1?=
 =?utf-8?B?QklPU1FhQW9iMVJvUmpTWW8rNmdzVzBtODBiZm5yUVJsK2psZGlLalFnYmFm?=
 =?utf-8?B?cVU2OUJVMUdHTHFHdFZzVTArcXgrdElJU2JxK201NDN1VVkvK25wWWZOWlR6?=
 =?utf-8?B?SUROaDVYcjZqcmk4Tnp1R1hMY0pzdXRDOVlDKy85NXNXNHlWNzk4Y1lkOG1h?=
 =?utf-8?B?d0d1MWJ2NkE3cVZRNmNLTXFVN1hqOWpEN21IekpmclFNMnU5eEgzUWcvc2J4?=
 =?utf-8?B?cW40YUpUZUtWSE5PdnlIWWtHRFNaZmgvaHNDQmFpTWYvOCtGWjJBSDYzV2lV?=
 =?utf-8?B?U0I1QzVYMlRjODM0WGlGRFdzS2d1ODZqdk5zQzZIWHhwZlcrSzhjS0N5RlBB?=
 =?utf-8?B?SnVyTEJoR08ya3FBSjhNMFBjTnlmU1h6WklkelUvVGJzcDdKTEp5SlpuOFhr?=
 =?utf-8?B?c3JMT0NoaG95anp2c2RHUUJpZHBxaDkvdTN6T2JuVkp4QmVyc1VYWXoyS0RP?=
 =?utf-8?B?QWtsM3Z4OXNIU3FrRFRDM3JiMHd5dHU5S0JyNWszb0FhQ2RjZzJYOHNscjEr?=
 =?utf-8?B?MWF3SGhINEhpUWJtQ3hDMzA2MjBmUVMxb2JpUXllcmIzQ1pWZHc5Q0s5N2M1?=
 =?utf-8?B?eENlNmN2RFNHUHptOU9LUFYzclYrWFV0WWR1RnNOdzNuRWxxMDJnSEpyOHlz?=
 =?utf-8?B?czdOUlZEOGpRT29mTnMrOTNIa01XV2F6eGJBaSs0Q0lQNEFDUHlqaHlsYjJv?=
 =?utf-8?B?bEUwOFhDcXhmVTFhVE0vRnlpck5SYjVBaVdCVVAwMmZzTWk1S2tWVjd4V2p4?=
 =?utf-8?B?dzdld2R6dUcrblloZ1I0L25CUDZXL2dsUkIzS1ZDZjl1dlZxbjgrV2krYXll?=
 =?utf-8?B?Sk1zYmNscEJVUnlzT2NITjh6cDlwSkhTMzc1MDM0VVhJVmUxMjEyZG5IcC9J?=
 =?utf-8?B?YWRSUzlzNmhOaFc3K2t6QU90dkkzL2MxMndNYXN4aGRnTlRtQ09ZRG5UUEtu?=
 =?utf-8?B?a2VjTVNTNmFwMXMrbGUzR1JhYmNhWlR3U1d0Z2JFd1RsQ0tUNC8zVzFnekFu?=
 =?utf-8?B?MVN5eG1kdCtXNWE1YlhQcEpycFJiN3ZQU3hFaWxxTUhWNkU4Tnl1LzZWNGQ2?=
 =?utf-8?B?Qmp2OURLZmNPY0t0bWVyelh0djFDbG1xQmV3eEx3WG5CYVRzZVV4QVJuTmFN?=
 =?utf-8?B?SlVDU1Q3b0k3SHV3aWlQa2U3RGxhbVlEbEowUVF1WlBCQUdaQ3dKaUtVU0tE?=
 =?utf-8?B?WGZjb2ZmU1RwTlhhUjUwWmFYalhPQlJPcC9pUW9veGZ5TVNyQjBTVkI1d1Bm?=
 =?utf-8?B?SlhLdGJZeksrMUovMGxSRngzYS9oK1MwMkVOc2dEeGNsRW1NOTR0dXRMMnIw?=
 =?utf-8?B?ZGtlL29aNU84SGR4MVZvS1d5cmF6c3IvWVMvNG9YWFd4UzVIZzFmNGxNTmdl?=
 =?utf-8?B?QThXQUN3NzlDS2xjLzFES0FvOXFUQ1lMbHEvcWlqVEI5bjhldlBIRU1KRXBj?=
 =?utf-8?B?SFl5Z3ZzZUlhTytSUXNIUkxQZFkxeEdGNTQzd0tOQlZMY0cwQ1YyZk5kZHFZ?=
 =?utf-8?Q?VHChfL6QeYsOmCjNxlUWhK37cNYxba/CjrU1E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzIxWFFzSjd1OVMwbFZhaUVtU2xyM0dmSDk5cjJQbTdzckZiUkZiaWhQMDJB?=
 =?utf-8?B?QVFQYjkyRDhIMTZVb0NqaDhjNkFRRXBpOFNiNVUwMFB2QzRhYm5IUjJJdjJu?=
 =?utf-8?B?NG5lYjJaVXNmcU53M1daQU44Tk1oWDFVdGpaRWJGYk1KVDFxQm5WRGR1dUow?=
 =?utf-8?B?VmhsL3QyTnNOMDdLbWk1U292dFB2RWVla1pEMWpIZkJiaXJ6RHp2TGlSU3k1?=
 =?utf-8?B?RzhINmNURU1hcE94NXFTWldiY2I4Y3hiZ1RQOXBadzhXR3JReTZIcVhQNW1h?=
 =?utf-8?B?bGhubVJnZWJVLzUvZTNFVGpNOE96Z0VJUndsNFgrM1VDSkV5YklSa040a0tw?=
 =?utf-8?B?R29TeElJRjA1SHUxQVFGdUhZejhSdUZnSHJQWHNSRUtBR0wrSVh0TjF1TnY3?=
 =?utf-8?B?cER2UnF1U0xRaFgvaitrYjVtWU1WVUtib0JsY29zZ3c0a2FYUU8vVHU3Q3dX?=
 =?utf-8?B?bEYvYXFUSENpR2dMblNrdDFpY282eWJaR2VnMmNpUjRYTVJaelliblRtbTc5?=
 =?utf-8?B?Tk5Lb3RjNDJWaWdNRXZrTitxemkydjA0Rjd5alNkcmxhZngrNWExNnF2Yllx?=
 =?utf-8?B?NGNkbFpNeGRJVU5EblpFdW1uUmRvbS95MksxcS9ZMVMxM21ucmVCQnBUVU5G?=
 =?utf-8?B?WlF5OWt1WFlzMlVWSmJ6cVIxTnZ6OFU2ekNucm1FSmY2KzBOQm1NVlcvdGhm?=
 =?utf-8?B?YURYT0xEVnBaKzZvT1NOTTF0MS9OM05GcHZBY1lmVm0yenlwaGhTbzBIbERS?=
 =?utf-8?B?NXYyZkxlKzJqY3BJQkE3QURwYjlOMng0UEdpZWRZeWxONkY4Z1o3aHk4L1RG?=
 =?utf-8?B?Z1hLVnBzNEZWUENEZHl3aURQZnk1RWlxbTJMeTJiMFFHeGRvcURBdGd2OUt6?=
 =?utf-8?B?YWs2ZEFwUW55VHBnN2FZYUFucG1ndS9FdFl5TG5OK09WdFBRdHdHTXVEd3Zm?=
 =?utf-8?B?SG55Y3E3OEVxNlFjOE5DWlN4a2wyNU56ZjVFOXNnLzM2RzdFTDZIaDBzSTZh?=
 =?utf-8?B?cjg5YTJkOFNjL0RTZkIyZlBtZkJVRXo5cE1lb3FBdmUxdUpheWxGZXgyRnVS?=
 =?utf-8?B?WlJCRENsbDFRVTFtUGwyc3R1VndaK2svelBJMFVaSE5vYmxpaWRrdFM5RldP?=
 =?utf-8?B?bzlCNFRYOFkyeisyaGpvMWZpdjJZbXFyanlNSm1vSk54cnlrRy83ZUJJZnd4?=
 =?utf-8?B?OXhnb2UwWmFQaUcvT2l0VlBwRFlSZEkxbm5VYnRvbWpGQ0hZcGM4akNlVXcx?=
 =?utf-8?B?Q1I0VXh0d3UyM0l0VVNmY2NKUTFIazdROWxaMHNDOTIwcGRTZ0FpRFp6em1I?=
 =?utf-8?B?Wkl5S04xd1FrSE9PU3U5RnhOSlU5VTBtVWI2NkNDZjlpT1A1T1J4OEpiT0pp?=
 =?utf-8?B?aUhhOXB3YmxZVkcwNnhyTk5JcjdGWnJncklaVy9odTVIOEIwNVpPb21jdDBa?=
 =?utf-8?B?MEQwVUYwdFc5MVRCV0piWHhCa29aVGh6aGgyZjFzWGRDL1ZPNHBsR04xWGZr?=
 =?utf-8?B?L0dNTmNva0h3ckY2aTdHM1NxRllGNDNRUnllcFFEZG9YVU9SSG5ROTJZSlc2?=
 =?utf-8?B?VGpyb3Nta0xvZC90NFFrNGtOL210QmRzWGxHOGR3Z0s2a0tSSC80RkRKVENZ?=
 =?utf-8?B?OE1OcWZ1VG82NnJBbFlPbHk0d0FnNkNYNCtSdzVOdGJBcGZwVUhWV0FJR0Fp?=
 =?utf-8?B?VDdWRkFCbWtVQ2N2K2tIRDF0L05zTHl5OGNyQzA1ZnBMbDA3dC9oWG1lV2VP?=
 =?utf-8?B?M2wyTGNyYzRySGJoV2NmT1BtYlpyUXA2dVkrVzNBdWdXRmgvd1R2ZTR5RW5w?=
 =?utf-8?B?TmxwYmIrR2xINE1OaVltQUNlUXNsTmVGMU1BTXJRb1NMWFVBYVF1dERwVEZM?=
 =?utf-8?B?NU1jbCt2TnJ6ZmVGd3BrWTk5V1VPc0pYTElmWCtyckNEU1R3dUtzcnR2RGNE?=
 =?utf-8?B?TFhYbTBMNjBFM0hBekNwemZWajRPN3JYTmtHaTh3L05kbHpHWUhJSGw2MmRx?=
 =?utf-8?B?b3dIQnhlUG0rY05kNUxMdGlzKzRFdTV1VklteWR0SVRQa1JvTEFQZVk2alUz?=
 =?utf-8?B?ZHROQnZyQlZycmxndVRpdGJQdGh0RmFuQjRWR3N6akhHajlHcmJFSEM5Yi9I?=
 =?utf-8?Q?D1k3kMLXGj5qipXwpWV3q9WNf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909a55cd-ab9d-4a02-24bf-08dc67401aa8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 05:00:20.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LU/VB2lQg7PEOF2bu9tNZcn1aqduLxuHDQ4yfqbI1taoHgWRAHqYVPW3KWQxn/ViTKe151IOsbwk197jtmlyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

From: Peng Fan <peng.fan@nxp.com>

Add pinctrl-scmi.h to include the function prototype and 'struct
scmi_pinctrl' to export pinctrl_scmi_get_pins, so other drivers
could use it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-scmi.c | 17 +++--------------
 drivers/pinctrl/pinctrl-scmi.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index 682ff595c3c7..360b813072df 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -21,6 +21,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
+#include "pinctrl-scmi.h"
 #include "pinctrl-utils.h"
 #include "core.h"
 #include "pinconf.h"
@@ -30,18 +31,6 @@
 /* Define num configs, if not large than 4 use stack, else use kcalloc() */
 #define SCMI_NUM_CONFIGS	4
 
-struct scmi_pinctrl {
-	struct device *dev;
-	struct scmi_protocol_handle *ph;
-	struct pinctrl_dev *pctldev;
-	struct pinctrl_desc pctl_desc;
-	struct pinfunction *functions;
-	unsigned int nr_functions;
-	struct pinctrl_pin_desc *pins;
-	unsigned int nr_pins;
-	const struct scmi_pinctrl_proto_ops *ops;
-};
-
 static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
@@ -468,8 +457,7 @@ static const struct pinconf_ops pinctrl_scmi_pinconf_ops = {
 	.pin_config_config_dbg_show = pinconf_generic_dump_config,
 };
 
-static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
-				 struct pinctrl_desc *desc)
+int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx, struct pinctrl_desc *desc)
 {
 	struct pinctrl_pin_desc *pins;
 	unsigned int npins;
@@ -502,6 +490,7 @@ static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
 
 	return 0;
 }
+EXPORT_SYMBOL(pinctrl_scmi_get_pins);
 
 static int scmi_pinctrl_probe(struct scmi_device *sdev)
 {
diff --git a/drivers/pinctrl/pinctrl-scmi.h b/drivers/pinctrl/pinctrl-scmi.h
new file mode 100644
index 000000000000..ae9e0be7c89e
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __DRIVERS_PINCTRL_SCMI_H
+#define __DRIVERS_PINCTRL_SCMI_H
+
+#include <linux/device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/scmi_protocol.h>
+
+#include "core.h"
+
+struct scmi_pinctrl {
+	struct device *dev;
+	struct scmi_protocol_handle *ph;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_desc pctl_desc;
+	struct pinfunction *functions;
+	unsigned int nr_functions;
+	struct pinctrl_pin_desc *pins;
+	unsigned int nr_pins;
+	const struct scmi_pinctrl_proto_ops *ops;
+};
+
+int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx, struct pinctrl_desc *desc);
+
+#endif /* __DRIVERS_PINCTRL_SCMI_H */

-- 
2.37.1


