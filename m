Return-Path: <linux-kernel+bounces-39655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A40883D468
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FEE1C226F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25048125DD;
	Fri, 26 Jan 2024 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BynW9fB5"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A094C13D;
	Fri, 26 Jan 2024 06:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250303; cv=fail; b=Ab4lSjYc9XczUsrTlx7sI/IKNPuUCai37U7sazBWwcvbJMjZ7jfGAXP6PBmmiJX0ylwRFQZ4F4RHjU3wRKDcqtm2QMf3dW9zs6yUyyXBsLmU0VpbA9TIXhbCbmtMpJHqbhl2hMCZyqoJ0jnwJazvatVghuHBaFM/zynMhVAVOHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250303; c=relaxed/simple;
	bh=s2pPcBvvhviXXmcytUuv1TvGm8oXgfY/nwlILYNt62I=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=pGXps5iW0mJ+uov452CRV79RqW4C7yi5dariQkjHLWp4mDlcRCqXMF9tfwGAN6DVDfoPMhAFijsKHvj9yYQ6f84xrbq9QOnysdAf0dkv7T+tmnSdEPBHQkQfDVnWzCi6G+BcHZC1AlD4e6yU3dMI/23uko2O7q4L4houjTyhWHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BynW9fB5; arc=fail smtp.client-ip=40.107.105.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6THnEJ36Ge2UMqpJgmRFcQqzW+scv7gXRKfYD84D/TS1NCSoOTYOuaC/RaDORmDGBsjg+QSn0ukk20A6FLwyEfb0C9Hja6mF3DwEc8qSE8FjI0jkwcuxi0BYLXgOrAoqBat3iWdl0yz/d1Me0FUtAvsqFasKpj6ILv/gbAhfSuQfsCmwqxeAdQ+OY4HkCUGICNh79LPEyAQLRNx4G/UcaD040djvPnDTF7TJnAh9ai+U3fdzRTPI6rIv0QuBqjsuP3LDHs1cDV7ck7W6L2w4e9pItqrUY5z/4Uq9qNZ72ueF8Sf9GynOwsRai2CsPfDXtFLp6LdRZIKY68RrCBuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcgguXYFur4GnDCQ54EYG1SMe8kQ/hGD2bvUQc8Hid0=;
 b=HX+FP3P+IlVF/gJklj4e1A4HBCz7wBZP8OGEMDZFUyN0t7pK0//9fw9CU5qICM6u8heGpAG0n0loJ8A4vzTbiVempiqd7mfBV2NMrU0JvEFS+TK7EOQ+KDg/Y9YtLLIhgyRto24cowcOGlPmWkJOxexJhqDzBGK+enI0iQLT+3ldOcWyn/VoxSKzjiFD4/l6PG+sQsm/mO991ON5hmXNsn8ec2x+Zm3GKanmqeiOCe2rsEwnq0TVKVm2YhYYt/xMyin5MnsQG3gtuUYalIsG5lxrg+cI/8e9s2gSoByXmyuB+jmxs5W9ngrdlxu0lFKW8c0KmwssaxFL8znEfLNn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcgguXYFur4GnDCQ54EYG1SMe8kQ/hGD2bvUQc8Hid0=;
 b=BynW9fB51gtvdp/RUEVyi9LzLT1BMdBC2WCkfydCRvA5cY6eluhchUqAgNvMELAKP+vGiVn8D/RIVVsibcQIyDKce5JmwV+AKXqf5mlxO2Bts6gcoY8ZHagD+6/H9u6XBFyf2/P6+r7tJgvuocslV5nJsa69lqbU124JpElrm0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 06:24:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 06:24:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v5 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
Date: Fri, 26 Jan 2024 14:29:13 +0800
Message-Id: <20240126-imx-mailbox-v5-0-7ff3a3d53529@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADlRs2UC/33OQQ6CMBCF4auYrq2ZzrQKrryHcUGhyCRCSWsIh
 nB3CytIjMs3yfdnJhFdYBfF9TCJ4AaO7Ls0zPEgyqbonk5ylbZAQA0KUXI7yrbgl/WjRE2AqlI
 IBCKJPriax7V2f6TdcHz78Fnjg1quvzuDkiAzpRXVZ2NQwa0b+1PpW7FUBvwjMcmLpTIDIrI57
 iVtJe0lJemqnDDXxoGt91JvpdlLvXwLYJ2hjErcfDvP8xePg3arUgEAAA==
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706250566; l=1868;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=s2pPcBvvhviXXmcytUuv1TvGm8oXgfY/nwlILYNt62I=;
 b=Kzi4JiaUP8nnwzAnMSOJm2Ia6aMF22jhuqv7sTCWOew6yk9rQhrcxCYEjNe6VwNM5a9EdMGWH
 nQZ/9MnaCDpB46fDPh5pfhbj0fNgtgJ8BpxTj0/BI9VMDLbW1OSVctX
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4a5edb-b0a6-42a6-4905-08dc1e37842d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FITRBP2wRxnAVKHGMzfvlmyVasQL7p2OVeFhFch/0wTNvQ7Ls0+fTFOZ6/T5RL7TRBFtAJfVheXta8u8pHnNab3ZG2NgSJfQqI2ls3dceZ6n4eaOKmuP8WV6xEasKHcJW01s0TAd9osqxIvCnYX7C7nOKkzErPeo0MTsYcqny/sWzdt5P0pF7faI0VinTKh5tIvrMbBsD2y6Vnrgx4FMx7RWEwkw4L62J99Z4Yphs6L/2BGAM4bM49cRP3NHkK8qWh8FqNwq2OGtYguDudNLAMzEF0Em5amx+dkqEmWJFdxhpt8X5f4ATX7/qWm5tPg6tFnZmM4Or12ClqiVARdEAJmza2ZMFYdxXYgknNBjRSlkuOTfkmsJ/xMt1c5UE2Hu9kg/t+psBzuB/aH2DBykYAyC1KgNEiaMhaqBjwt4OnoFXTlxdTwDdtu6N69ggYlKdBaHMhgrP819ELN6q0IryqCbiDxW2+PM0hGrL/RKCHPEbgPjkT9jxykbRUZfHgngyNpd4XVKkI84Xg29mJgdE5+ZnUWRiWG7PLpO4jVuWgtJ46qrt5zP0LU53VaxDCfnNCCDcE7FjUVaRdbisclLVKAYXNl3U6xxArRHn/LYbm98fHDitEyMUHlpnDaqAJTj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(52116002)(921011)(38350700005)(478600001)(6486002)(966005)(36756003)(86362001)(26005)(83380400001)(38100700002)(110136005)(8936002)(6666004)(9686003)(4326008)(6512007)(15650500001)(8676002)(316002)(6506007)(2906002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dStUbFVvWVZLR0JDZ082SWR4VEk3YlIwSXp4WDJ6UzBhYTVOQjRkeFpGWEFa?=
 =?utf-8?B?OHJnc3ltUEk4TTBIWXNtcHhqeVBnajFseWJobWxMd0V5d0x4bFM4VFVlTVpN?=
 =?utf-8?B?RE0xTG51Z09HdkZQK05aN21BTmhzVGduemtJTTJmRHpPUVFUMEMyZzdiRlhT?=
 =?utf-8?B?T05GK3N1aVhLd1ZyUUQ3UVIxZ2pJT0tqcE5KTXZScmN1NkVJaklMSng5ejE4?=
 =?utf-8?B?S3JqTEM1bmZiOEZpbnA1K0lEdFV0NjZTdUkxZU5sd05VWE9OWHkraHB5aE9x?=
 =?utf-8?B?VEpiM3MwdEJLRURseGFKQis3MVdrejdyVG1KZ2N5R01uaWZOaTViRDI0YVRw?=
 =?utf-8?B?MnlJWnhQTUozWjYwR3BoV3Zsd0tsSlQ2RjVpZEU4RytBak9pdTY2clVNL0p1?=
 =?utf-8?B?dWd6dHplRmNDYytSTzkrMmVLREZockViRzcwSTdtWHBVNzBnTDB6dDJkN0Zo?=
 =?utf-8?B?di9obCsvbk04ZkVlVzEycUdKOUR6VnoxMWc4WkVVOVRnc3I5dzJEaENGMldJ?=
 =?utf-8?B?d0dTelAyT2dVK3ZTL1dkZ1FKVVJSSGhEcVJXSmd6NHJuS3crUVQ3Njh0cmVu?=
 =?utf-8?B?SVQ1VGhva3plS25nZnRvVzNOckRvbWJVN25RL3RzeXNlamtZUjhaSVVnamlo?=
 =?utf-8?B?STlVTEhTNDdESlZMYklnbTBvSTVkajlQUlZGRXJnODJsUUZVMU16cVhDNE5E?=
 =?utf-8?B?eDM5SS96WTZXS242SjFMU2VRSjc2MU9jQmVjL2RybzdzVUhMcEhTYnZSNXhE?=
 =?utf-8?B?eGtQSDJYUko4YzcrRmloUDBJV1NQMXpuYnpWUCtXTHZXdUpYQ1JONjVKdnlJ?=
 =?utf-8?B?cWYvQVlubllVM3lMTUR6UDdkc3ByVGdqT2dmdGs1TXVuSXVIVkIvV25Nb3Bp?=
 =?utf-8?B?ZTh3ckExa0lOeStzcE1KcUJiWkpuaVBJOUF3bHdCNjlpMkJIaTJvVUFSOTAy?=
 =?utf-8?B?NkU2ZmJ3MmR3QUNwRjlkQzJiMC9mVEJHdmdVZm1nT1pZZDhVNG1ZZXdvSXd3?=
 =?utf-8?B?T1dBNzFIeGQzU3FxbElRUXRJci9zM2d1YkJ0V0hVUGMzNmtCVVowSUliMGxs?=
 =?utf-8?B?bWwxT01HNDhkY2VETGdnU0hxRmVIQzZtQWxhTFpHblhla1BQRlkzZ3lQazlS?=
 =?utf-8?B?a2ZWdlR4M05sSXF3emdWaVpqTGtXaHVicEt3TC9KZFBTaGQ0MENCeHh4dEd4?=
 =?utf-8?B?ZmFFWks2VE5rMTV4Sit5ZU1jN1hWWUtXNWhjLzlBWmovaGJBTGo2K2MraFYr?=
 =?utf-8?B?cXowV0crdTg2R0dXNVRjMUcyZGJUaWNUOHQ0VTJZQ2h0V0t5Nk5Sd1NCeGVm?=
 =?utf-8?B?OUwyMzVDQUFVNngxOXV6K0JxVUhMZmFIQlllcTRDeTg4b1VaaUwveXZOdm9v?=
 =?utf-8?B?OTh5ckJKeWVpSHRybk9QK002NXIyYVBoTU11R2o3bTI5ZDIxZjd5cmVONGhq?=
 =?utf-8?B?NnpyUnNGcW16b2N0OGtNSUk2SWNScG85NzJoR29NVmRJeFdrUHg2bCtNOS9h?=
 =?utf-8?B?QmxUOEJiN2xxZkw3OUtNazN5RFBzdlhKTmVBcTFlU3NEdWN6ODMvRzhXeGlE?=
 =?utf-8?B?TnZkeitPeFR3bmp1R1A3NGVVR01HQklpWkx6OGhIWnZtNnlYU255RE1sOS93?=
 =?utf-8?B?R2xpaWJrcWVETlEvVWFrbmlnbmd0ei8rUVlxUlNMb3BOVWhFZWdxY2I0dFE3?=
 =?utf-8?B?TzRlM3AxV3dMcnZMenQ1ZFFaL0t5WVNUL3JZemp2NFRPcXp6RGs5emR5cFlV?=
 =?utf-8?B?eEdSeXgrbWdlWmhwcXMrVUI2ZVJoTkRVZnNJMndXN0NncmpyUDc3SmlUY1lQ?=
 =?utf-8?B?NzZaM094dlBzNVU4Tm1VVGxsekVsTkJNM0tLbGZON0pPVVNlYUp0N1BKWWd2?=
 =?utf-8?B?dWpxbG0rN012cHVSaG1HQnlZU2h3dXdTQXRvVi8zRk1zMkR6Z3ZIOThaanoy?=
 =?utf-8?B?YWprWFNwZGh2RWgrREh2cE43S1dIaE55a3RrUXhCS2gzSStmdWc3dGxUWkFV?=
 =?utf-8?B?ZkFIVSs3dHl0aXEyeUd1MDc5UE82enF6QTAyTmZ3Tk5wdVNucVRlWXlPdkIy?=
 =?utf-8?B?WFNsVDJXa3Jja3JTdjFCNFZHT3JoTTRTQkhUU2lhb3NIa2VFYTdUSjNPTEhw?=
 =?utf-8?Q?6ACOWolohP6l/Vgc8X5EO+aZ4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4a5edb-b0a6-42a6-4905-08dc1e37842d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 06:24:57.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9741LRat+ZIyUXU5SeIEbx3WJ5SLGyWIL8ZidCZrWL3GOSzhkynQ8y/EQef2STxgnL/ty4TfRJlMffmcCdrUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851

- Add dt-bindings
- i.MX95 ELE/V2X use same register layout as i.MX8ULP S4 MU, but
  the TR/RR num is different. To make code reusable and not add too much
  macros, add runtime detect number of TR and RR by reading PAR_OFF
  registers.
- Add i.MX95 ELE/V2X MU entry in driver

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v5:
- Per Conor, add restriction to sram property.
- Since i.MX95 MU has SRAM, we may not see it is compatible with
i.MX8ULP MU, so drop the fallback compatible
- Add R-b for patch 2&3
- Link to v4: https://lore.kernel.org/r/20240125-imx-mailbox-v4-0-800be5383c20@nxp.com

Changes in v4:
- Address dt-binding comments in V2 from Krzysztof
- Link to v3: https://lore.kernel.org/r/20240123-imx-mailbox-v3-0-ed932945e0bf@nxp.com

Changes in v3:
- Following dts coding style Per Krzysztof
- Add return type for init function, patch 2 is new
- Check return value when tr/rr is larger than 4 and return error.
- Link to v2: https://lore.kernel.org/r/20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com

Changes in v2:
- Support sram property and add example
- Populate the sram node in driver
- Link to v1: https://lore.kernel.org/r/20240122-imx-mailbox-v1-0-81413f655210@nxp.com

---
Peng Fan (4):
      dt-bindings: mailbox: fsl,mu: add i.MX95 Generic/ELE/V2X MU compatible
      mailbox: imx: support return value of init
      mailbox: imx: get RR/TR registers num from Parameter register
      mailbox: imx: support i.MX95 ELE/V2X MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 58 +++++++++++++-
 drivers/mailbox/imx-mailbox.c                      | 88 ++++++++++++++++------
 2 files changed, 123 insertions(+), 23 deletions(-)
---
base-commit: ad5c60d66016e544c51ed98635a74073f761f45d
change-id: 20240122-imx-mailbox-243021d12030

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


