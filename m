Return-Path: <linux-kernel+bounces-37971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD8383B8FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093B71F24900
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB807CA50;
	Thu, 25 Jan 2024 05:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YVi/5tA5"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32D18826;
	Thu, 25 Jan 2024 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706159754; cv=fail; b=rruHmsodvJCk7G8uVbneCFkzDmdiyGKMxvDmoNFUWHccvByyU+ZQjoBmM5//Ldl1qUxZuApby//YkNfDh4f8EPZaF4jNbwaX8RpEJAXOOs3mJk5pWJQv4Mwh6LW1Kz/T16jboG+U31QIQxMd1QAnoVnHre3OACMB+XcLGgS7uUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706159754; c=relaxed/simple;
	bh=OHibuWiHW9joQ/i3oX5djNsOUMB+zEvP8Mx7g9EB5Kg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=SiQb05JLZy1qOJttjxShAkwy0w0lRvAGZpC4o9/dX1E/jJAFaks1U1pnpCHgdTs66mSYy5E0IwPlI/56dBcazodV9SbbCL66hsZRe440JuGva+PPLMlxkoYaBRygZBYUj9o49aV0BRjCJOnnulGq/PAuZO2gFuMh3KtWgi/Gz/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YVi/5tA5; arc=fail smtp.client-ip=40.107.249.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqpukSS3DKRHGjDSClO+CWRWXnD94IRHVZ1maGa4eHC5EJ6sN56F0plRdwMs3JA70YE0nrbR1wzRFekIIyZho5psqL+6Jc1ysImLK96/6Ko/IldK0ladqf4MMtUTprxOk4QZbc4WtQbrYVclyOHX1Y9ACLR8HA7mpdPmpMq0zv1xS0UJEFXYQpjvMPbT2EOkl01jVL/3NBJKfJ8cUj45CxXMqS9KERWEpE1I9W+dUfaWf7XNO53GbgucmeJmPN8U1jyfObfVTKP/WyRzQ6VZWcXeCtpZX0s0EwxEpN1awswkmVz0o2bmSkFNShREMhjS9URm5n+HXyXunxlmYCUD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b72l9oEfIvCqetEjTGO/heeBi4Rdohlhcylb3bLPmq8=;
 b=SfMm05rsAm/Guf4zf90LESVkq/7i+2Q5qBRj40raT2WEaqUFqH0rjbinF+W4hN00qMIyGdtZOYdYnPs5VfFyYzHVu2/mnszifmzMTl/M8Tll4w1rTI/LDDvKFKbHEoljtylFIjYxfhrHJs6FInaZBP+9+vDwoZtdCDblNQW79kENCGu3aPVT2Z77z0jlSW5W4VC8SYOY9J1jAGWy2Eg/jK7a9cev7YzY4c0cueE/zPyKKBLOG0v0KjjNjdrZ6eZQpl2wzW1VNWY97fmyrOBxNmm54m74ov9/y+FORyr0qetVk3WfJ1NfFRyzEvV3KyP1jAMyb/UnbPVmZgI5yuJn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b72l9oEfIvCqetEjTGO/heeBi4Rdohlhcylb3bLPmq8=;
 b=YVi/5tA5C1DxuQNCa9ORxuqOXpHODbER7TLiB1JVe4VBgE3Xoc9F7j3et5P6axyYCB1xYs5U1kfmjNNPd8Z6+XKbQxE2qGPJbjkJrjNFsZhxSqePw7RLJEPPf7q4RaH0OJZGrwYLXbFXWz1fgULmAXf9SULuqzvyXaeTnHySGCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 05:15:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 05:15:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v4 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
Date: Thu, 25 Jan 2024 13:20:02 +0800
Message-Id: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAILvsWUC/33MQQ6CMBCF4auYrq2ZzhQFV97DuKBQZBKhpDWkh
 nB3CxslMS7fS75/EsF6tkGcd5PwduTArk9D73eiasv+biXXaQsE1KAQJXdRdiU/jIsSNQGqWiE
 QiCQGbxuOa+16S7vl8HT+tcZHtby/O6OSIHOlFTXHLEMFlz4Oh8p1YqmM+EdikidDVQ5EZArcS
 vqWtJWUpK0LwkJnFkzzkfM8vwGbCLFDGAEAAA==
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706160018; l=1576;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=OHibuWiHW9joQ/i3oX5djNsOUMB+zEvP8Mx7g9EB5Kg=;
 b=UvQjsWXsf/l1ApsuopmRjbUz91YcqZ3G8BOCpI2iJvi/He68tOorlBJUipKNBhNYfDuy22H3c
 Vr65sJ1JmkkD6euyyWLZd5ffk9Dcoa5XEkalHPybF95ggE1Egj9xwqm
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: fb95577c-f13a-4713-57b5-08dc1d64b13b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SqHHmKqbEYwhf3yK34qooQCSMpAQeIWSAIv3cRZ16AjM0AiOhrnohayvJwqgs+qKu4BBL5+x5Zg+NJSQZDAJj4SaZYpzts5+jmpQHeTFsZgVXkDKe7vpjwJTiDb/VsLuBDcSQHgzp6dlwO5MyKi3JNjDh6wbIEmK4Kk2wJaqwCHIofFhqKjOCl6bsGBjdjf9kvXuE7bRCHlynjfn5ziwz0hktAqLmtqZQo7I8yrXv614p9stRSQlFwbKufzPYkPTGExr8Yy/95Hu0H1AC+G1MI5aRiMnvDhd5UaUPArsCXXVhq12y5LqOWYl0lfKRN6CqOJhnz6sPPD1oHeFgpLYazqyjj50IIYvayZOTqGl0FKwsR3yQy+iz3HYQI5B9Cit5mte6LXj+6EDWN3v9O4RWXCEj8gO/6o51WphjtlWXRRzoAh62/EdyQ8W6hulBK4APwhC+ZWoYp2X1DveJ0yWW0aD3PvSvUvw54+jcC7LaO9AgYM9wf62S9W67bng7hxMz7Ret1E8GQ37oSTTJu7lIYzUWCRu38PYoME/BfdCWw+Ryk7VlUUu08+LbwI+AtIGXAVWkl9kXKNOSz6uuy+MM1oJU/k/v6EVatR+JPBdH/ZV7SSlSzhmtIy+EWwupSh0jp7AsBlBePqSThpqovd8qHV9LUtTfh7kIb8eDlz5SPQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(921011)(41300700001)(26005)(966005)(38350700005)(36756003)(9686003)(52116002)(6512007)(6506007)(6666004)(478600001)(6486002)(83380400001)(38100700002)(316002)(5660300002)(66476007)(15650500001)(66556008)(66946007)(7416002)(86362001)(110136005)(2906002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWZqRWRyWUNjdWtOMDA2TWxNQjdpQmdTVVRmaG5yTlZVT0FpZG5VVTNJKy9v?=
 =?utf-8?B?WEJnRTZvQzhNNkltYUJncFB6dFlSc0FTaFhLZmNXOXRDeFhzQW4yZ1k0K1Vx?=
 =?utf-8?B?bjN5bFJ6MWYzeDIzbFQyOHJHcGFnVkEyaFA1ZWFiQWFUTVJrMUFxN3pnUG1t?=
 =?utf-8?B?ZGQ1bjdMSGtnZFFHTXZJVXVzQWJPS285d3NtcnpXa3N6eGtvK1dnTW92dEZY?=
 =?utf-8?B?ZTlQRkRNM3pFSTJZQnpvTUtDbXRCdDJjdmt0VWZ6VW9Bc2RScWpGbkdGaUhF?=
 =?utf-8?B?U3J5Wnl2MzBjdis4cUZQWWYrVGoxUC9OZEd4T2Y5QkluUDJua2RyWmRPTitL?=
 =?utf-8?B?b1FvdUpZUDZHV2tyV0xyOFVFWHVXUFNOVStsMDN5diswYld6UjkybzNDZUhC?=
 =?utf-8?B?b1JYT1ovUVdMSDMrZ3JtNU9rQlY5L2hBRm9MMVFkNm5QamliODQ5cll3dUNI?=
 =?utf-8?B?QWM2ZDdzb0RTUXNYSThka05FN3BndkROQ0pUV29MeVJyUEoveVd2cHhrN3l4?=
 =?utf-8?B?VjFTREdCdUZmSzE3dERpR0U3d2hJeWZpZDhTUVQydmczdUdUN1VVUDNWWEs2?=
 =?utf-8?B?c3Qyb01lc1hsSjNhZVpQTENXUFNMcGhlWE43VzQrWEFhMzZWVWVEN2tTWUxy?=
 =?utf-8?B?Wk92ek5ZTVB6V0tDVW52OHNOaWxKRTYrZmtDa3ZzaHhEU216M2YxWi9HVU90?=
 =?utf-8?B?aXJ5dmVUSmJtWHFNMUZZd2UyUmZtTmVld0VORi9ZWXh4UjlTZXo1M0NqTkxR?=
 =?utf-8?B?WnlhQjBtMm5oM0hoWWFZT1cyS2hZdjNhNUZyUk1odjM2UEEzbEpPVkFhNEF6?=
 =?utf-8?B?cG0rS2ZMSm1yNnpTamFtbys3dHQyQUk3UDhtdm01SFhXSTd3QlRxVWF5bWhT?=
 =?utf-8?B?dlVtb1V5UjRZYTE5cy9qNWFUN2NjYXh4WG81amlweVdiOWdDVDQrYXoxNmQx?=
 =?utf-8?B?RUJodXQ5ZGNGLzQrMnJrNXFLQzJQdWVzWmw5Rm4xcEtWakRqMDRBa28zeThq?=
 =?utf-8?B?dHFteFZhdnZUa0dvdDVwM2UvanhJK29QTnV0YWdsSVhuNmRBV2dXSlJocmZu?=
 =?utf-8?B?Z2lldmRBS1REbm5xbTVpS1dXYldaQ2Jwcm1jV1NjWTdMZUVQS2N1b1VvNVcz?=
 =?utf-8?B?S1RMeDdlVytTNFlHYXdNOGlGVCs1cFlQN2g4bTM3RXNIN2N6dWZDWHV5Ymho?=
 =?utf-8?B?RDNyN1ZHaXNYLzF2ZmdBUkFsUkh3Y01oeXlWTDl0cndKcElNMGJoNGF4Sjcy?=
 =?utf-8?B?MDNSOS9BaTVtYzZLa1R3dDhacjUvZGt4bWNGMTh5WWkzVS94eW9tZ1MzYndE?=
 =?utf-8?B?SVFrYUR0VHQweVdRYnRJdnBBY1BhVU5xSXNqanVhSmJmd01GdmRWdTdCcDgz?=
 =?utf-8?B?ZWJEYjN6U1M3YzVkYm12UjczYUdWT1ErbzBsY21HcWk1dFZxdlhBcllrYXo2?=
 =?utf-8?B?R2NOYlE1aGFqL1NpN2FKZG9tMlFQSE84TGFCWnh6M2duTUZPN0F1OEhXY2ts?=
 =?utf-8?B?QUMyUXozN3RPdEZSM3pyb1Q0ZjQxa1dONFlSOW5NakZMaWx2QzVuVkpaZlBX?=
 =?utf-8?B?Y2QwVjFCK3dkMTJ5V2NBTzZaWkJOd3JPT29xWkVTY2dXcmpOd1IyZXpjRWNH?=
 =?utf-8?B?bzN2Rkh5V1BMMGFCbmJZZXRkYUFIaEdFQTFDYWVJVHM2emxsbG9uWDRFQkVM?=
 =?utf-8?B?S09yemZuaUlDSnpsaWFId3JsUFZuSjNrWHpMNGthbEFueDhIM2FzSDhCd2Nt?=
 =?utf-8?B?ZmVZeDZRU0wrMTdrK2FVUHZsNVFLOGxHc0VFTkRGdjFYTmlKV3AwVitXSGl5?=
 =?utf-8?B?MUwyOXpodmpnWWJhbXhiSGJzaStrU1dNTXlIcWlYTEd6RmNES201b29KREM3?=
 =?utf-8?B?RVhCWk5sRHI3U3hUMDMzckVFQ0pxTWhlS3M1bkRJSitSRFJvT05XZmJTa0xi?=
 =?utf-8?B?ZjlBb2VZcEFVUW56VjhxWnlmMnIxUHBMemxyRk13bDNnMGhRZnR1TUIrMk5a?=
 =?utf-8?B?Z1dmZ0FhQXBXc1VQR3RMc0hUVU5IbkFrSDh1QUgrcU1SN0JoTlYrM1dUMy9S?=
 =?utf-8?B?cklPWWV6NERxb20wdTVyRHNaeWVkSW55RzJCcndCdjlLL1ZIejVaTjNRMGtJ?=
 =?utf-8?Q?PqPSlZ1GHpUG6X+xEAc/gqenp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb95577c-f13a-4713-57b5-08dc1d64b13b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 05:15:49.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m3Di8LP1fwuanV4mS2Pa6xh0ZHCUhT9TBTbdcqNUxsI4BupJrMSwXde9rrz5zMNTgfj8TFpXl9YKcpaM7SU9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

- Add dt-bindings
- i.MX95 ELE/V2X use same register layout as i.MX8ULP S4 MU, but
  the TR/RR num is different. To make code reusable and not add too much
  macros, add runtime detect number of TR and RR by reading PAR_OFF
  registers.
- Add i.MX95 ELE/V2X MU entry in driver

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
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

 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 52 ++++++++++++-
 drivers/mailbox/imx-mailbox.c                      | 87 ++++++++++++++++------
 2 files changed, 115 insertions(+), 24 deletions(-)
---
base-commit: ad5c60d66016e544c51ed98635a74073f761f45d
change-id: 20240122-imx-mailbox-243021d12030

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


