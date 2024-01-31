Return-Path: <linux-kernel+bounces-47364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2612844D16
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7171DB38131
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3013DB8B;
	Wed, 31 Jan 2024 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kvm5FbXh"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209A3FB0C;
	Wed, 31 Jan 2024 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743295; cv=fail; b=FhLWXvYosV9josu+HzBvoEz5GrfPEHTmtzHgMOak6+9jJKDbATQL5i0j0AOFEAyXdVixQKleV0zU8clJEZhlpJVucOXvxveVyPElaIcGywVdZaBpjC2XtuZ1FkVAIHtDEuXfO/AijSiMHn4euD1sFHHQvFiHuHhs4mMR/05Lezs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743295; c=relaxed/simple;
	bh=csF46TgBHjEdti18WLM4FgglPVIkczJ1JXAwvPG6m9w=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=MX4j0MR2rbAOWPZKY5cIgbmuUPH0ukfl4f6woDN1gP5GFWDfq6lE4kSdY8g6M8O5kOaEh9ee1PSX5sGxowEl8yNYdXjfQWP78BWvGtYQvWUcE/iRRD88HCp7dddv4AmlagdennafEo+GHQ4otdkJS0RIh6JTCGMg7Tv2OzYKnx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kvm5FbXh; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl6f2a1JGZ121n/xfSI+ItcSTwPIPNoe8K0kQ16nBuaPjZuY34SulPYPL6+DLyXkvoMWYZIROme+nUgQFg4iPFIu06saoJiucn2rZ3xzVkd3CMDI+rAVSMmK/JXUEuty0mCpXJ7+vuWc0LmHqoF3akU0/wUCpjPtlmUOnjrFJ/t/8zaM4dpkuVJUcV+W4ofnQ5a2wXZsVzXMOa/gW+rIf+0H/qyt15uSe8hjDfBOjFoCCRNJeEmkSX4i6lHNfJQSEB40ICAnpT+wpQMLQdrDELXky9v/DGD4Bp5/gtfVUCxvH5SXOk+nNNz3EwN3GMh8onq7tuFe3iKYczyB0qlBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsqOUrV6SZNqeo7k61pKFav7IzvPxvG0zuz2Sh44rcI=;
 b=JFh1LSO5yaIefY8DRxJYmfU5LvYyHpW4tOU2x95ywaO5NVSkYfZSP/ut43ZxXPu2/L+AWglLHW/PODDjXKfnOzWlpw7YKWNBNX8UiVKDjuIdMxAWDXYpoU/hEMKW2tSY13WdnjyPWOYjd4C2YnoPkcdEA/69d5AHcqO4qXfEjj4+VVT43c8Y5kZ7GoGBSgse/zmgMZohOAFYvVq1WEya+2Y+hXp5k+p8UoTlUPE6z6b1t6abLDPFE2Ag8CVgyOmKAeKK6AeHWcThq3RvYto9jAkQdzaf5vBYxdN0gb5ezqKJtfNh/bWbvSj4WauPkNmunqncBQzJc/uXSY4cBTKE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsqOUrV6SZNqeo7k61pKFav7IzvPxvG0zuz2Sh44rcI=;
 b=kvm5FbXhD+O3E1+yuUFdzP21UiOUD4zBUNKFfiAkf0qZKnAOPIlFAz77DtGcooKKr4+z7rUo5H8iZVB0F0kKnnX018c05grt4Sq27LzzNMxLUcrvy/jysc4iXDIHDsxg3wpW//qQaS0tcSNAlfJPd5gnoM8l6bV/SC4vcfu/U+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7396.eurprd04.prod.outlook.com (2603:10a6:20b:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 23:21:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 23:21:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v6 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
Date: Thu, 01 Feb 2024 07:25:36 +0800
Message-Id: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPDWumUC/33OzQ6CMBAE4FcxPVuz3e0iePI9jAcKrTaRn4AhG
 MK7W7hIjfE4k3yTmURvO297cdpNorOD731Th5Dsd6K45/XNSl+GLBBQg0KUvhpllfuHaUaJmgB
 VqRAIRBBtZ50f17XLNeS7759N91rHB7W0v3cGJUGmSityCTMqONdjeyiaSiwrA/6RGOTRUJECE
 ZkMY0lbSbGkIG2ZEWaaLRgXS72VHEu9vAUwlimlAr/e8lYmseTlrXOUU8nEmH3kPM9vzoyOUYw
 BAAA=
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706743555; l=2014;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=csF46TgBHjEdti18WLM4FgglPVIkczJ1JXAwvPG6m9w=;
 b=uIezKjpV4hykCi777dDlz4mRx/46sVDQdzQMKWBM7Gg5DMj3gTFsmadw1FkamzpNLNmx6M5zc
 sngrS7FUn12DoLD6iFHN0h88bodR/ZaK/9CevAZtqqDD3ppr+e0aC2c
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: aeaf5d48-b4ce-445d-f81b-08dc22b35980
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GwW4d6nLFGvGMbUyX6xbnuFD8W2u9AiAGgpREVup6F+Kk99cJ14QaEutPMSYKlaBrCyLcastM2RpQkbMyHxCFQWovqtR4kXHfhd1nKhlgq7/yYxICTb6VYH8PBpSWejP7ihO/0gJzIyqCQ7F4AAtS32eleokB4mTP9gROOqPu1YcC6tTdSaqNhsaaCzqk3kKbelKHLZP83PezIiMMH43bWzENLmbcsqFLNXwTwHXwQGIB+KQ7FLXblukK7gN/I9Eg4R2nbIbomud3dszMQQ64pZCpNm+AEM8/XPs3TJCtSZRYycAOtAMYIG50pyiftBy/gO65CHNS4R2WEBTEpi2Uo+ivsp1vp9WlTs5YoCCzfB2/gT9vW7f3hXK4f1YDsyinuC4bREysbXwSzXVN4N4bX8+GoX2CGxudJBBR41+kV4SM5n5F6f1wIHgnGQy8eP0Cg5Q6Ce3WIiiSL78obo2v1hbOq2Wy+wrmTcHt1uiD2JFrN93fRC2YGHe/7i2InHbPCUlMRgvpQbVSVFi/2AB8m5d3+YlcQN+vLOKO8ovuwGWJg9B0xa6+J01cXceP3r5eU78dQHA7KZPs1oEFeG/xfuUU7CgXEcsDsb/A/38LKPVK770C7VOLwG9/6qSyrsW9+Wir0gnjzLq+PAyLDb312yjfX72ZNqd+bS32ZX/SrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(921011)(26005)(41300700001)(54906003)(316002)(38350700005)(66556008)(478600001)(36756003)(966005)(6512007)(9686003)(6506007)(83380400001)(52116002)(6486002)(6666004)(66476007)(38100700002)(66946007)(5660300002)(2906002)(8936002)(15650500001)(86362001)(8676002)(110136005)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVdZcHJmK2lCendnTDlhYmFXVVlXdzI2Rzc5Sm5RdGlWRzF5cDM2UHYxMDBN?=
 =?utf-8?B?YlNiWDNac0VoRHpMT1grYkQ3NkNuRFZrVllYdXRCSnltdXEySkk1WU1weG9Q?=
 =?utf-8?B?ZG5vV3RqZ0hwY2pYQmpIaE5GaVBmY3Z3UWVTeUcwdEJBbW1QYVhoSGk1OVFS?=
 =?utf-8?B?REtRVVZYTEtVcGp6ZzVxV3BZY0VYMDNhbW9XRVRMSG5OLzJnQWE4eEtwUUhX?=
 =?utf-8?B?aStKRlVOelZoQm00cmlGaTV6NUI3U1pack96bjUyTThLN25sTHEwbFZaaGhH?=
 =?utf-8?B?dy9ia1VGSUlkK1RoNzV2RHpEK0NYMkcwUHk2c3hiVnR4SmlrTVcvd3hZUklB?=
 =?utf-8?B?WGt1Z010UHp0WHpUSXh3cmNVa3dvbzk0N1VhTlNmNnVjRmIxYVpEQ2JvYkMr?=
 =?utf-8?B?K2JPVW5nOUdGZzR0VndxNVY5d1Erd3MramdiNmh4UlhkQjRhN3BoSVltaHlM?=
 =?utf-8?B?clBiWlVuQStzMmQ5TjVkZC9MZ0VodDFDaXdKSTh1QlN6aUY5b2hzS2V2eG1T?=
 =?utf-8?B?WWZNY3VmSFVVSFBFU2VDdm0xamZXenZEZCtJMzdIakdFMi9INDN6NjdRU2xy?=
 =?utf-8?B?cmZKd3YrQVUySW5HUzNkWG9xczFIMjQvUUwxekYwTi9tZHo1ZnFzaDUyT0FX?=
 =?utf-8?B?N0MwZzIzZVlGSDdOSFc2ZUZYRlhiWXFrYm93dmNYbnlxVVgvZVRjU3VQemtK?=
 =?utf-8?B?dGRrVXRxZ2xJc21kbVFpNTIxNzlQS0hUajV5aXl2cEQ4RmhCOC9COXorclhM?=
 =?utf-8?B?b3FiKy9hTFdXUldSK2hNZGpOeVExbDUxWE5FZ28zZS84c3ZHN1VDM1kwcFFi?=
 =?utf-8?B?QWRhM2tFOHpiRkFYbkRaRXNESU90Zm9kNWtMUWhEZ3ZRdXM2NUNpY3Q0dS8z?=
 =?utf-8?B?ZWQzVCtUbVlmNVVweXZ5dG10MkFpeXV2SG41bTY3THQwM0t1aUd4QUV5OXVH?=
 =?utf-8?B?SjNRemlSaU9UditHYVV0MjR4ZlJ5TWVPUGJ5VjFnSDltVUUzSEtJdmZFblBI?=
 =?utf-8?B?eDFsVUF2NkF0NFY4N1lIYzBBQVZFbk9YNWd6Y0NWMkduTjgydkY4dVRkWXRG?=
 =?utf-8?B?ZWJuNSsxSzdnQUlDNGhYaUprajFwcEVUdWwvWFhTV2ZqTHhOMkVjdzNxYXNH?=
 =?utf-8?B?eXBIdVE4Wk9kaGZhbDRmRXN6bjdQRU95Z3I0WEpUMlpGa3BuYTVQbVNwQktj?=
 =?utf-8?B?TmlKV2tJajhFMFh3aldpRHdWaTZUa05QcG9CMU1GdXFFYmkxT1lTRVlkeWZ6?=
 =?utf-8?B?ZkVGNHQ1Rnc5UE9HWnhVU2l1SWh6QUZpamNoeG0yLzJ0Q3lrblc5empHcGZT?=
 =?utf-8?B?UmFFQWZ2VUFaaWtYV0FrQU1TU0ZiYzZFbmtNUXppRTMxWVZFb0gxWXR3cWhM?=
 =?utf-8?B?d0krUEh1c25UelRYWHpENW1RZkhFbTRsaTZ4VGdCdTduR2lzak1LRnVZU2RC?=
 =?utf-8?B?Y1JNY0tyZnJPR2U4dTlWUmxYSWp2UXl5U0FRcG9KK1pPaEczbWkyL2tiOEIr?=
 =?utf-8?B?Q3pqbFZBbGlIUEU3cGZhbU5VejI1UnJ3QnBRYXVxdG9QS3BLOGxHT1NjS1JF?=
 =?utf-8?B?MkhjKzlUWnVVU09OaDFIWHlTYlQ2bFNKRFpIeTZWOUdha1lrRjErZUhpSU8r?=
 =?utf-8?B?L0Jzc01aN0dEWGtDSTRWN2d4UFNSbExoRUdQcmpuNFhGZ3YvLzMvWFZhSmpv?=
 =?utf-8?B?MFJjRTZpcG5YQmZacnJ0MkxkNVlJNTFEYlhRamozdFhKOGtlVjRFV0hmTkM2?=
 =?utf-8?B?aitqOENnU0d3SjVRY2tIWFJSTmxUZXl1aHV0N0pxZmxmYXlwL3NYa1JGcGNx?=
 =?utf-8?B?RE1MNmYrTFBZMHQ5Vi9pUTlVekJsak85MFRtU0o4NjRxNFNEWW1GTDdGTVhK?=
 =?utf-8?B?ZEpPZ0cyblM0MWp4dW05ZCszLytwK3JlNE5HaTI3Sy9GYWlLUzZsdXloM0Yw?=
 =?utf-8?B?Vm1wc1B3alRKMkk3UzhuSFRLM0xMTEF3Q3NIN1NDQ2xwc0Z0eHFQUFpSeTJH?=
 =?utf-8?B?eFF4bzZGbjVoL1FjRGZWcFdvL00vaFpNTmJMR2RtQTJTMHF0eUFmYU5Vd3Jt?=
 =?utf-8?B?MzIzUnhIMktZYmNKbE5RT2ZDVWZQeGlucnhGQjZpY1I0Rk5EdXgzZG15TXUz?=
 =?utf-8?Q?ilDmphHanjgI8VLtYC1IKupjF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaf5d48-b4ce-445d-f81b-08dc22b35980
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:21:27.8396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7NXOm0uFCAUc6L0Y8Y6q6ATozBfBWKuDq90kkRccK5jHRrJAWRUlFRbUUiWKMQLHQUK4ObbtSjMdK1V8fu+TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7396

- Add dt-bindings
- i.MX95 ELE/V2X use same register layout as i.MX8ULP S4 MU, but
  the TR/RR num is different. To make code reusable and not add too much
  macros, add runtime detect number of TR and RR by reading PAR_OFF
  registers.
- Add i.MX95 ELE/V2X MU entry in driver

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v6:
- Drop node labels and add Conor's R-b
- Link to v5: https://lore.kernel.org/r/20240126-imx-mailbox-v5-0-7ff3a3d53529@nxp.com

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


