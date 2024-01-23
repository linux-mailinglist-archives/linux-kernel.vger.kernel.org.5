Return-Path: <linux-kernel+bounces-35453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E7F839175
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA771C269BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51D8487BC;
	Tue, 23 Jan 2024 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hZDOj0Vs"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2071.outbound.protection.outlook.com [40.107.13.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3641236;
	Tue, 23 Jan 2024 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020472; cv=fail; b=YY2bT4d4+h87UxLHr+cX5oOS9Cy4KfyPvqBvcFIhnYb1YooFCG64+nbLP7lL3mmUytKwXnN7k9JmvG/cp0XRmn+38mrMRf9w1GE87PMz4lExtu/83zpqgxBRX+5TDUn7ad3w5n4740n0CmRCMVGgHBzVttXNrytWw9igXoFFays=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020472; c=relaxed/simple;
	bh=rAbz7Ij2mD0X5mfmCdOlo2Q/cfiU+8tEdRF19Keas4s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=cgUz3eTSdtvz3ovZdUHUlChQsY6XhmTN4PUD9gxssof3MApmqZP7NiQd8q2UVl7ZKlgGVqghcbZ8RycfL0AMQ+T2KaV/Smqs1cE+yrqJCSQGGVsMHveDAsdIa8nu9oIfsquAZ8r9dpjSIRSJfPmaNQ92JaW//5RltCsy5VIGs7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hZDOj0Vs; arc=fail smtp.client-ip=40.107.13.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThZOpAiT34dDIxob+s3a2KsoM/o0uO/rCnjVOaIUi5yMZH3tMkCjWcc6jDQjWqNAXpeYdVKX3lI8p60G8q8OtZvexpqKA0r77zXThTxwXMRawr2ZK4zFxl+/30k7AWLqjmEf/VQI5S8BFYuxMaB/WlAlLd4X2U5oHrdR/atawRw226Kz5poHmFtX5aE3kBcRiARkWdPGaL8Fqx16kSpUFYRS4L8JzyLim7s9y8SpQ7PRwGJAk3fy3YxPhHVqCo6tFuEVGz2KyN/bUd7P7vV85e58cKi1D7PWRNfh3kBB3SyRHjeQmeaiUI/vbs+QOiWkNNs/kx6RJcRn/eygIg2myw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV6P0g2okQLMpCAh9dv/u80vsj4/KpZ8OzVy8+1VFzs=;
 b=M/gk+Mu6n+Lgu1UAoCYFIJTtsOF+qqiMyRVE8weoF6OG4NeMEFVX4IPczbDFaOZKuKDGTwSL429k5ks6QOw+Dx8IU4km9ngR6gkWMH/xJ2uBNefnVduAsFVrh6AsnFaTQBGPFYSwUvFGhwXrIsGWz8Je0wZyYKqJBWV1EJgiBWWke8ogtWrPNcKmWVLYdWojOnDk+PBDJ4a4gHBUECXIxRlXWZsXBLBipkr68FmVeTqrmh0hgphZ1SVmF9IMuBA1WOGDBQ9VXILEWzEr+0deHWoXuT7qx9xk5NNXMn1fM7+RqQF+FNtWVAil6abpwgPMuFAt+zJCKWFGHAEbWzaNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV6P0g2okQLMpCAh9dv/u80vsj4/KpZ8OzVy8+1VFzs=;
 b=hZDOj0VsDfTBjXEic+YVvGixpFsQBgADdg4wpctOg15O/IkaxRVPP4rEz4lrvvAwhCmCDbnwgksPWhR55UOYDg2VY2v02On+a1C5PAs4GaaAIbhf2pVV+ZTZLV+D3L5g4X1XRf632+L/tkp3Ts7GmeY9wroMIW/pE9Go9XBKOio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6979.eurprd04.prod.outlook.com (2603:10a6:208:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 14:34:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 14:34:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
Date: Tue, 23 Jan 2024 22:38:41 +0800
Message-Id: <20240123-imx-mailbox-v3-0-ed932945e0bf@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHPr2UC/32MSw6CMBQAr0K6tuZ9QJGV9zAu+BR5iVDSmqaGc
 HcLGzfG5UwysyhvnBivqmxRzgTxYqcEfMhUO9TTw2jpEisCygGJtIxRj7U8Gxs15QyEHRIwqFT
 MzvQS99vtnngQ/7Luvc8Dbvb3J6AGXWKO3J+KghCuU5yPrR3Vdgn0p6RUnhtuS2Dm5kLfcl3XD
 /3JPNDeAAAA
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706020734; l=1418;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=rAbz7Ij2mD0X5mfmCdOlo2Q/cfiU+8tEdRF19Keas4s=;
 b=5KDzwlTY9dvpfEfFP+8hJZdpW0y59KAG+Niao8q/cOxybPjp3AwvYtAJroV4Fkso8hx+EgUGf
 dRItebYKlLeBOvOcl2AX8pT2lG36s87/wByT1CvZfF9ysKlwAZXAs+k
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: e843b75a-e796-4fa2-728f-08dc1c20653e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xa3Lz1EvEvhCCWXUPTiKZyLPVbRsMWRSKwTW8O7Nhnnw1cZ3EF4dMaEuoHh38XJFZkARSbJ2PwQ8ORCMjTHwIHylt3TYousNzNUclvRG/gBnurnM6FGFWYMwVyzst3oeiVnYx67YFQq9TRuWRf6eLMl8VOL4FyYx0k5WCBl0i5v3k0M9WGOQnFycnsu0dpCLU7Y2z7Th+Tudz9lcK65FCqy2jiRNpDld2mhbDPEGdWaiAhek6vcmMmh6w/iRcGBkiLv7fFYsdrPz0D5yPcxRhB4LfX/ou8Pjz+izUkq6/Z+7JiWSMENnK6ADVRaUEdH4+fAUXo4ILZbuCUj+itm5uUgzDqfSgZmPsiZ1SbYVd+jrEIxnmFrdjIOaO9DAjB2ckKvkGKY50ERWoeM8B0Y2/iOsCzQX4e0Yo9X3dY4KJa8npnUzcOb3H9P6VvBzAfyqTYdaLg/cCBv53jcfaRiQsNXkKz/Ac5lPHzMBC0JXJ+8wUamQaEFYiob9RfgDKBuw0ytktPVTFLqhXdC7A7Jy+rSsE4FeaJxXm+PJj1MF9M0+401Q8OOgNmPf9f869qtrBfFpb0WZKg0FLKnCPO8VZrrYds4lnpYF1W0eAxkuwmxfybtikq+7g78fNFdAJgQdkp4Zsdc2wCtyqZdUiJUzIoXd0N+YFaSYejJ21I2e0W0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(52116002)(6666004)(7416002)(5660300002)(15650500001)(8676002)(6506007)(4326008)(8936002)(6486002)(26005)(478600001)(966005)(9686003)(6512007)(110136005)(66946007)(66476007)(66556008)(38100700002)(316002)(83380400001)(38350700005)(86362001)(2906002)(36756003)(41300700001)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm42bnpJTVZXMXB1Sk9Pa2FzVzdDTHYzeGFtSUxrQ3c3cm5WU2w0NWlwZGJW?=
 =?utf-8?B?U2NwK1pHVE5LSDZCYi9SWFd2OWxRMnc5VjR2eXltUWZ3QkVhOUFSUlZNUFh3?=
 =?utf-8?B?ajRBZjlMWEk5T1RBbzJ0UWlzcFZTSEJHRHhSeW1RdVMzK0lWb1FOMnh1SWVH?=
 =?utf-8?B?VWJxZWtpTGxPV1BJcERsSVdDSFQ3TDBzZFh5Sk5MMmNOV2s0Rmh1TUxveFM5?=
 =?utf-8?B?Mm44Q1dYQmhhN3JCdk9YcEJIWjVwZGJxc2ZWZjVpdGZ4SmF4aFVGblJ0SVd1?=
 =?utf-8?B?T09JT2w4RGlXTTJQVDBIeVNKZUh5ODdGZ0IycUhNU1ZGRmw0bkNSbk9CRmVT?=
 =?utf-8?B?Y05zWFJoUXhrVEVuTVh1UGlaTS9LNHhjdEVVSUpGeGJUbndtY1RTZGxjVTJz?=
 =?utf-8?B?K3k0VGozU1NZdDNmZUl6c09DWXB2eTl4diswWm00SWNFdjJUUW10WHVKdEZo?=
 =?utf-8?B?SGNGcmh3WC9URElGZkVOYzNkU2NCRlZWQmZHUmp1cjBUVHBLOGRzcGZNL3Vy?=
 =?utf-8?B?OXNSbEtqaUJIRUFVbGlOT2Z1WTR3VUNLckhEZ201UmtlamJFQzl1SldEd1F5?=
 =?utf-8?B?UjRmSElnQnFEcWtJVmpLdUtob2tyTW9HdFBQaUgrTjlFZ2hoNVQ4MHk1WWVQ?=
 =?utf-8?B?NE0zbDNUWDRJdFlHdUNUd1dOaHRJU2pZaUdvQThJRXhkNGxjTjFRQVlwek1I?=
 =?utf-8?B?ZVdXUDRNMmNncUJsZTl4REVkaVhjZnJ4R1NCd3M1QWpXd0pqR3F4Zit4aVBP?=
 =?utf-8?B?UDZVZU1ZZzZGTG9uUit1VlNiRlExTURnWk5idVhoMU53U2hNVzhHc1FKenJV?=
 =?utf-8?B?M0RlSjB2bzRpdW1NVEJxSFBENW1YSWFnMUpzVVZRUk9NUU54dlAzT3RVdTQz?=
 =?utf-8?B?LzdjRWMyK3RIMUVJZ29mNG1KWTJTdWdsWXF5V0dlUEV6dzN5eVlZVU43QmlU?=
 =?utf-8?B?TWd6VkRvMkNzVjRiU0daUEd1d3lCK1dDK0V1WDM5NldQenBLemJIOHR6a1Fq?=
 =?utf-8?B?Wm5LNGJwbEJycTVpcTRmV2hRbkZ5TW9qWXlScW5WUXNldDQyOVFnTk9KOER0?=
 =?utf-8?B?RHNUN0kwQ0ZVV2g5V2I0R2d6dnovekFOMmdiSitvNFFnVFFmZVlrbWMwVWEr?=
 =?utf-8?B?RzhlY05aN2U0L2xLcmZYTzFpQi8rNnlxYWtYa2R1LzlzbXBDaW1HWHpiS25N?=
 =?utf-8?B?QWNKa2hHUUpPQUNvU2VBMGYxR0ZoL00vOFFwK0lDektUeTd4clRYOVZRbDVI?=
 =?utf-8?B?WXBEc3FLSVlkRFdNOUx4ZDl4MkRWZTdHR1VUbjVGcHIwazdXcktQKy9uU3NJ?=
 =?utf-8?B?TDkyRS9lYTc2c2g3UXRYUWZIa240RnZ0b1R5dHRWYmVHVjNua1RndmxHZ0Ev?=
 =?utf-8?B?QWJwQlJ0QTdWWlVPMUhCTDNKN2dGOWhKZVc0amVpVDY5Vlc1NCthNENLMFZ4?=
 =?utf-8?B?T0NuMXF1RWxnRjBOZWFEUXNpNTlWTERLaFVHMWh6VExKWE5hNlY4dEV0Ujhw?=
 =?utf-8?B?aG94bWNrUXAwS09QODVsM2NORlN6c2wrbktEVlphRGdQWUNRNXRsVkIvUGN6?=
 =?utf-8?B?c3VzQWxObkVDaGVBY05jUXpaV3FaU3NtN2EwQ0NwY1BwRTM0cWlFUmNDeFZ0?=
 =?utf-8?B?SkJONEtrWGZ4ZkMrWjI2U0JRMDNrdEJSbG53NjRucFRaL2FhYXpaTVlQakg1?=
 =?utf-8?B?dkJkV0ZTdjdWN1lEdGxHMVBEZDRKbzJTU2ZweWdKUVBqZ05UQTdTcVJiS0kw?=
 =?utf-8?B?Ukx2WVAvUisrQUc2MjQyVGVUeVhlZmZtMVAxZC80NkxIaWlkWUJ1OEtOOXlz?=
 =?utf-8?B?UzI4SU04QklBRmNZLytZOG5nMko0L2pDeFJRcWNWTmhEMlA5YU1yWDVtQWZv?=
 =?utf-8?B?RnhYdWF0ZUxmYTlKUCttKzNCY3RMUlRqeFUvS2hMcXllZHY3bmtVUFFESjZW?=
 =?utf-8?B?OHRKV2xGSXBqVFBZV0tuSktZSEg3WkdlT3ZkS1NJT09JSDB6aGtaZUZ3ci9l?=
 =?utf-8?B?OVN3blE0by9wOVJXeU51dExMYlhKMTR5K2VVRzhFekh3TFNnTlJaRDNqYlU1?=
 =?utf-8?B?NDJYNTl5bmthelVpRFJmTCtRN3h0TFBoUzh2Y05ZM2NWNS93TjZkYjRpRE9J?=
 =?utf-8?Q?CYf66qjZgooeBFcc7J41y+Ntz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e843b75a-e796-4fa2-728f-08dc1c20653e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:34:24.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dgbD5iP7ICtGCvK61GcvRNGKxXKPHocb2EefMUkOP7Ap7eoro4vriiaQS0uoGTW7BQGy6XT1PTykIB4L8MgvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6979

- Add dt-bindings
- i.MX95 ELE/V2X use same register layout as i.MX8ULP S4 MU, but
  the TR/RR num is different. To make code reusable and not add too much
  macros, add runtime detect number of TR and RR by reading PAR_OFF
  registers.
- Add i.MX95 ELE/V2X MU entry in driver

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
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

 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 50 ++++++++++++-
 drivers/mailbox/imx-mailbox.c                      | 87 ++++++++++++++++------
 2 files changed, 113 insertions(+), 24 deletions(-)
---
base-commit: ad5c60d66016e544c51ed98635a74073f761f45d
change-id: 20240122-imx-mailbox-243021d12030

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


