Return-Path: <linux-kernel+bounces-126675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A508C893B51
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6331C20E4B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB0F3F9C2;
	Mon,  1 Apr 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SMpJwOog"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2106.outbound.protection.outlook.com [40.107.20.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222563F8E0;
	Mon,  1 Apr 2024 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977627; cv=fail; b=Wz6Nk0PZZYeCtkQ50yVGkoozgNBVuQf2PNLyTF1v2MxnffJ8yioeGf5i9sVGi1r//EduWejocWzvfCYPHmbUlBwaOrg9G/nSriUXf5jh1ACpmZj1rhTA1/2CB8pgThNeNInb4R283ku7bgxTeLM+7eXKMpGJ7AQMhNnMDewnckE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977627; c=relaxed/simple;
	bh=zRvvlCzPi4nMoCVAWGaamkxCdQsaKXFf5dq5f6ecC1E=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=OdSr+O2aSqqJlu8S6QgHHaRYKnKno3QxRkJoVDrvTv0f/4+iA7jguY8Dvg8N3fVESwNeo7BsfVvXfCV1/P+wnkwW70I/TtFkwR7dBsoDqPkC/z7Y1EeiaDjv4nhrbcDqBviZZCCetF+3xc+kDexn51uDnKfExBLwFQg4XdLgFkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SMpJwOog; arc=fail smtp.client-ip=40.107.20.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx8mMVhkI7sPtwNmQtWUTok+flkPMKBRJM/jnnSwmhR2vTySe/FcIp3QuDRC07+Fb/jtMMylCRhIaIpVC21Zegat56lTJBGtD2CUndddiTLZAOgqciGXbuPNbs9xdhe3OPxbjqGAuzkcxtwkJa6h1vrCEyaZHwbZsQ+L/sX2OtFzzbb7WG5gstaS9KikjAs64fTv4k/YeXwCelOAKuKSaI/N0dDtYwiTAwbh6iiU/hT4ZDcZHONhmu14cEH0UfFAxpSck2xY/v14QbbMYE9K5Lz9IlC5MRr2qcRJc7tMarjjSecEv6WRqok+8bfKxg/DwmFJmxW2kI+IKFuIgetN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLQiYNxlJqL05Axfp8TF1rTfrGFbedBwPn9lDinAXMg=;
 b=clfWNc8viLqDmAZjF/RfAP7g0NC8wIofg2fJ+RJ6VPjNvIf98LsDDIRA5osh4pNUItDvo7FR2RaBd2vQAi1EqtksK9dfu3SGhUdZdkdv9cwI/wNdNpXHHlL65l+EuIOMdHX2DUtEYddjvtiH7EtWyRr5353pTUYobAtMdt8PCkZ4aS3bBVWzjrmqyOPH/7eKKGzoH1Pcz3R8d/RcRoJV7GR+bk3Hp6xtJMn243URpTlvuDYBVJr+lpw2uSP4b6Qpkz0qDSDpPkTh4+vxhl0Ya/i+5q+GWHKonjcWjCcpHDqP2WWY+4XFqyElfPufmI6HrAneRfhEdVL1dXLy3xSbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLQiYNxlJqL05Axfp8TF1rTfrGFbedBwPn9lDinAXMg=;
 b=SMpJwOogOvUunfLhrW+MhcstoVNOrtTbCazbFc48tWZP9413/9KsdBsW1n0AFohC2VUwMUg21wQMnErdq4N/lHmfRspB/Rk8OCFaiAXOoVl4680cPDmOR2l/AN+5lmt298I42KDVOdPMEIBy/ChgvoefzsbOT9W7TdIMNWcypfs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8766.eurprd04.prod.outlook.com (2603:10a6:102:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 13:20:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Mon, 1 Apr 2024
 13:20:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v6 0/4] Add support i.MX95 BLK CTL module clock features
Date: Mon, 01 Apr 2024 21:28:14 +0800
Message-Id: <20240401-imx95-blk-ctl-v6-0-84d4eca1e759@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG62CmYC/33MwY6CMBSF4VcxXVvTe1souPI9jIv29nZsVCBgC
 Mbw7lY3ykzG5TnJ99/FwH3iQWxXd9HzmIbUNnmU65Wgo2t+WKaQt0CFRiFWMl2mupD+fJJ0Pcu
 aY0UQyRCiyKbrOabp1dsf8j6m4dr2t1d+hOf7X2kEqWTtC8eawIRK75qp21B7Ec/OiF8tZhujt
 8zRl4HC0uqvVmdrFLF3ChwCLK15Ww3mtzXZBtSBUfsyRlza4sPiH1tka51VJVijbOXedp7nB1n
 ceRKYAQAA
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711978117; l=2192;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=zRvvlCzPi4nMoCVAWGaamkxCdQsaKXFf5dq5f6ecC1E=;
 b=ZJ4B9HrI0bcDCtwspMFpx4CFtBy21+OrQ+ett3EXNgUGr8x+E9tbucNDwyEzjGb56VVVzBnUW
 G1Rp+63uHCZDDPTuuISxkXfrSPJnf1lUONi8HDy2TdLPhTt+idZbGP0
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8766:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Qr39J2jHNE4FWpMBuai2hHd31ba3Kf2K/EIsssJ+zmyzkyl4NaEXuUUF6lRa/wPck9aatW2xGFoiW8DU0lH1o4bP2zi2bJfr/ZmDs1kMiRwglBY1UXZH5ks/qmiP/frO3sBcGqdoIz5r6vaSmIQr1reK9i4qPn5GIKYV9jiDOg/VmUL+O5rKJ8nU0uRxvTLHeQznrbuLYzR/MxQGqcn9ZG1f5I6YgzNNtIT2brneRhrDi/2i2RokIQRX7l7deXnNnvmtgIwAl5XZKCwwymEoGwy/tJRdlgum+0MQLrQiB09k/B4cHjvIhXFSaelxmY9MA582nCAxaF5C6a6HIR4pE0kmawMadOh3nFf3UAfi764Zgomlkt+am7jy0nvQm+3rBCUlR+R8cBciQ43zzrQ0pqk4OoxbNAA1sABXZI6d4568HBUxyoaZcTQ9k4nle2asVoXvPIbXTxzOok0FadlUizljQrLLgvQJS4OXRhkeyPsVB0nS6ohtA2HFVrVFS1uPKzR2CxZP9X4HNhWHv987trsFlqsNKXx7oEBf+T/FoqQzkH111FSVjzdmIJGxGRtYXZtZ0f3SP/OhSzj2Qwaby0p0UFb+5V8+MnAckvmCrn4jlobtjL455mNC9KCMjjF99duYGuhOCLvJQ7aKMtDfna4tS+sjLkOpLCmmKc3onP2RUpwrxBP7r8+WwgNtiaO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlMzVFVpOXJmT3RDMDF0dlBha2ZBKzhnUVVub2psaHA3YkJkdGNxM2hTZVFE?=
 =?utf-8?B?Mk9mOGxkV1RJUXN0TEhEQm5WcEZQNHlkbVZiaU41UysrQlY1cHdhQlcvdDhH?=
 =?utf-8?B?ejIzNnlpQ2F5OUJheEllTmVDd2g3VmVZSmJIb1kyZGxKYWJmMGhycWZ1dWhU?=
 =?utf-8?B?U3NvUGprUnBueHdmOEY1SDBVdVZxeldUQ0t2R21mRldGdlR6aGl0K2N0WWJK?=
 =?utf-8?B?VXpleEMrZWxseUVqdnVDTXpKdDhTY04vd1ZqU0xWVTdESmNTc2lnUEhsOFd5?=
 =?utf-8?B?YUVPKy9RWGY0VnN4RjJRU2V0K3ovS0JQNTd1OXJUWDRLSEVManlVWTlhOVJZ?=
 =?utf-8?B?c09obFpNemxNbjZ1dlFTSW83MjZJSURYZDhEaDVpU0dlNkNzaTlUTnFZRGpk?=
 =?utf-8?B?OHdxUVRqRms2aTkxM2dlejFnTUxlN3BOUzdsd2N1RllsM3pKajBuaEs1alNz?=
 =?utf-8?B?ZkUvQ2xyTnhUYU8xVThrTmlMaGNWeXZwTXEybXpaTjhyQUlOajdla1llZjg2?=
 =?utf-8?B?d01KVUlxcHEyVnRvR0NlZ2l6QnovUURCblZxQnh3SzFTNlBMTnlwVE4zb0t0?=
 =?utf-8?B?dHQ3d1ZKSm9paERuYXBrNjVPMmI2N0Jld09DYTF2Z3oybTA3YzE4ekYvSUEz?=
 =?utf-8?B?QkIxWmoxR3hnbWJNeFRRa3V4K1lWK2sySkx1Q2JTQUUvWGJEdERTa0Q1VnRq?=
 =?utf-8?B?aEJkaFZka1pqUWkzSWNLbHpvVSs3T3I3djdFQi9ZMlJXWGpveWhia1A5eUxR?=
 =?utf-8?B?WDFXb01tNnhzdU5uN2J0bWwyZStkalh0ek1DaXVFREI4bWhWNDZGbmMvemkx?=
 =?utf-8?B?R3pjNThKYXkrNkx2RWxUQW5tbWYwN3hqMldVVkhrMXllUEIvVjluU1Fhc25w?=
 =?utf-8?B?NHFWUkJuSDZVS1ZKNUUwWlM3YUZlUExyNE5JMk0xMFNlTTlMNEppMlhwY09j?=
 =?utf-8?B?RGFTb3Urc09RYW4rSXVtN0wyVlhlTjFPTmhPclhvTXptQjFRdjZtMU5xVzgr?=
 =?utf-8?B?ZFdPRGNUSGpsRDRxMmQ5NlBjNzJRem8wQm01UnRrbldMa2RDSk5INkVBYXl1?=
 =?utf-8?B?S0VYak15WVRuWlJhTFl2bVh0ZFFtL1JEbDBIVTBuT3grNVdsdzhjRnZmSUF2?=
 =?utf-8?B?QWVJTEgrVnoyY3Zjbm9TR2RrT1dyanFkZ2hjVTVvRERhTkFTMXdweWdSeGdt?=
 =?utf-8?B?QXB6TmN6anZPd2R0RVZRKzI4U0hKWU9WK3JzcFhsQ2JuWnZoVkdkYXFxTzBF?=
 =?utf-8?B?Z0FWQ0p4MTdCSXBKTGNpYWswVU9zRUIxSXpXYWFieDNqK2VkKzNhaUNlZFU4?=
 =?utf-8?B?Q2dGdEdLNmxsVGVBOS84eTJIZFhMQjhkOW1KU282cDlOd0ZZYTV6dnk0cFQx?=
 =?utf-8?B?T1B4LzJvTnNlZ0tmTFVvdERleVl1eW5MNzFCV0tPSVFIYkN6VXVsdEZ6aDF3?=
 =?utf-8?B?M3FBOTh5N0JoUmxuTXVuNmg4aUFiWUZJWEZPVkRkb2Vmak5QV0gyWTRDMkg1?=
 =?utf-8?B?QjBKS3k4TUxOMUd1bVlycWlhc0wzKzhjY0xVc0V6aEZsR1pVeW9GZkNub09h?=
 =?utf-8?B?NDRwNXdvMk9nd2toeE5YWjlTa0t4UU9LWU52TUxlN1psbXB1d1RDUWJOUTlM?=
 =?utf-8?B?bm8vWTUySlVhMk5QcldFV0Fxd01wKzl1QXJaNUJlZThhUUxLMHlQY1M2dkpB?=
 =?utf-8?B?R2Jtb3V1b2hYU0JhUnlpOUZQS29tV3FCZXFHSHRyNGF2bkE3NVN2c3ZtYzdm?=
 =?utf-8?B?TmlheWxmaTk5UU1PVS92Y1JZYS91b2tUclZQelRacG9Yei9FK3Q4cEFodnoy?=
 =?utf-8?B?TkhoMWhRYWV2N2R0dXJQSWdLbmZZTG1Ld3Y3NTFUb0dpUFEyK3lReG1wSkht?=
 =?utf-8?B?MS9IWnJ1YmlmZGEvNXZxT1UyaXBxSkRkNTJPcFFSSnV5dStOYWRlc3cwaHFB?=
 =?utf-8?B?eHZQVDhkZUdDR3JBUjc1bVJzdllDSDNvWGJkcmlLK2F4NUhrcmd3WWlJYlFF?=
 =?utf-8?B?eVVHbEFDVlB4UGtCTUtDZWVCdzVXRU9DOC8yL2kyNkg2OHBsNnFERzA0RGJh?=
 =?utf-8?B?V3JCdzdCRUlhVnZ6Sis1Ymk4Rk5UbnhwK2diTEdqNjBKWGwyVENHOG9zRTB0?=
 =?utf-8?Q?APRCwxbayDopl6JXQL1Zalwjk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f82af1-18c8-4155-0d70-08dc524e7ba9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 13:20:21.9695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LP/6418rN3fmBkUSP+U9OxTo59zTx5HaxjW76ZFVg8+10UsDC3qscGgKmcK+FU+r2GsSpOZsP0Kn8kEYd+WP3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8766

i.MX95's several MIXes has BLK CTL module which could be used for
clk settings, QoS settings, Misc settings for a MIX. This patchset
is to add the clk feature support, including dt-bindings

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v6:
- Put the header as 1st patch, and drop the macro that counting the clks
- Add R-b for patch 2&3
- Drop of_match_ptr in patch 4
- Link to v5: https://lore.kernel.org/r/20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com

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
      dt-bindings: clock: add i.MX95 clock header
      dt-bindings: clock: support i.MX95 BLK CTL module
      dt-bindings: clock: support i.MX95 Display Master CSR module
      clk: imx: add i.MX95 BLK CTL clk driver

 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |  56 +++
 .../clock/nxp,imx95-display-master-csr.yaml        |  64 +++
 drivers/clk/imx/Kconfig                            |   7 +
 drivers/clk/imx/Makefile                           |   1 +
 drivers/clk/imx/clk-imx95-blk-ctl.c                | 438 +++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        |  28 ++
 6 files changed, 594 insertions(+)
---
base-commit: c9c32620af65fee2b1ac8390fe1349b33f9d0888
change-id: 20240228-imx95-blk-ctl-9ef8c1fc4c22

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


