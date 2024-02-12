Return-Path: <linux-kernel+bounces-61947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320128518D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C480B2161A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD9E3D3B4;
	Mon, 12 Feb 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HfXfffhr"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F43D0C6;
	Mon, 12 Feb 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754771; cv=fail; b=TjZiDqdnk1XCxrsgQT6qbVb4+QjhvKVshCRriJvinFB/h422ghaRxHJYvBdZg3h++a0nd0IPTFOL56a+fRDWjgNXBZcgcTQ1gu3E+odx+r1OSFHJ5X2Q29cKl6xblEP6QYMX+MwPc4Lu04o/39QWNhJx4S7PEzW6QllDtT8MJWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754771; c=relaxed/simple;
	bh=4AreUVs8qbJPazFYOwry+mqCqgNHwxJG1zEVSHH/bYQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=auSqujKPAlDJiK8CgWZYymECSbSP0HLuxaEpGYFlUfNImYQWTBEJzs2IAIS1d4+5HuOjySBTl21I6vn6kqWw0rc2JQado6nqjr/OjyT279ynkRmORKQ8ywOHQ7Gqm3i+RFFQPy3IBZKaBdEpQWw83SNhxsHkLrQzXf3Sgdr3XKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HfXfffhr; arc=fail smtp.client-ip=40.107.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnZN89JE9GZPeJUTebRhb+uGI6L2dPwPkSqUF+tbMQBKJtggeIq+7rgE2TfXgef+5wTQVciUsX3NZCKLx3VW9O3ZcSEZysy/YhYfhNxJYLvw7AMkaLNDlY7EGYw5eTvUMPGVCFdpsB9jZjDCM33rflfAfTAyFSxcfoH1xaYM8aWBQ0MesS1I9IrQLWQdzhfN8lBFSNTrFxTGPbmv+HXhPSHrgldwibwecaLtWPd+e3qH2dMUg0lOXi0i5rB60K83KbzfPwtxDkqP+PqriSCWKWi4yur7UuniHSyI0EYAKFng3MQOogRhTMASEAPbXRqrIYmErzfBBABIyYQG11eg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APn133vps1qZVgRAsZ+ekprpeynA9N2Q4ns6Q/jpOJI=;
 b=ScX9v//6Hy9CtMnYP7CscMskMnW2DdbaQB5swcH6YKE0ELtgjNTZcI86BHjj19pr4X1sc21mVg/ej+lYHbCDrPB4Psde90He6QBwGNDzSIuJPiroXwNAQRZntCwC94w3T2O9TWoaTGyE49Ts3dKM8vWB7idz1HDxrZ7ldiFXKk759a2DeggHh+JPFYzVsrY4YuA6hze1rxjWosmg65BVgF/D5rSVEKy06jC1TyDRhYAvOV80hKQdsVBoG8utFu31lj/DSzcrbg3Af4fo3efF04KH1PAZ6d033VttNL5eZQCu/2tJoDTxgJm6lJo0/i++nWfRvDzK3siepPACXPraVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APn133vps1qZVgRAsZ+ekprpeynA9N2Q4ns6Q/jpOJI=;
 b=HfXfffhrWE87pJeFKW0PJOo2Tvw5Ld+8DROVBKezHeqNuZX+4OyTvQn52PdzXaZzMopKGSQ4JSGzJv4pLPizeUaLmgwQ55C6Ws10hO4CumaDpSvbUk3wphAfOzpecyuOfquHHXGwARRDxdDxrJKS9V8niKddDNSF1QtH+mLySB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9049.eurprd04.prod.outlook.com (2603:10a6:10:2e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 16:19:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 16:19:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/2] usb: dwc3: drop 'snps,host-vbus-glitches-quirk'
Date: Mon, 12 Feb 2024 11:19:06 -0500
Message-Id: <20240212-vbus-glitch-v2-0-d71b73a82de1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPpEymUC/23MQQ6DIBRF0a2YPy4NUgLSkftoHCig/KQFA5bYG
 PZe6rjD+5J3Dkg2ok1wbw6INmPC4GuwSwPajX6xBE1tYJRxyqgkeXonsjxx044oOZsbp6YbhYD
 6WKOdcT+1x1DbYdpC/Jx4bn/rfye3hBI52U5SpbhoTe/39arDC4ZSyhe8BzimpAAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707754764; l=1420;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4AreUVs8qbJPazFYOwry+mqCqgNHwxJG1zEVSHH/bYQ=;
 b=fBqD+wOOusIHV3mCsqVjf525SLFsdDSgejychMLRnwHv2Sas7S6t9HCdMmednpaqtq0nbePpw
 /udk6V0gATgC5Xf9hrEK2/cKhWIJemmYaq+y6jNNP0dTv8Tj5TCWxND
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN4PR0501CA0001.namprd05.prod.outlook.com
 (2603:10b6:803:40::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 80574769-29a5-43fe-eb18-08dc2be661f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vls2WKklEyOIV4mMH93d0VDBadhBsxHg9Ys2YegY/W6+fMx9M1w0FPmpoR/jrDjJh1wPGgtkyyF09gM1On3GzdIHnFYlcI5heuYF9EbnAUs+FTVfrTP9sswhOPP0LD/OLABAMl1uVTDJEwiwpP5L780wdqcvXeLD560sWv6X8yb5XTGzi1miOyecj2Xnfgxn3WI7OrbFpAKnQzkblhp5bBuHurG5zKx3ZW+9w5m3cQJ6MnCzf7ZfKqH5cpJn0WBvkTRYYGwbIuVL6IoIP0Ln+dFVq4Gscl79faKyBE7rhqdJwRY563SZp7jf9UX3R029t6wPTI5wqpO3gyNzbbkPdMlXURnJHOzqD2zGAQXeX3i1YGY3IpCdA4sr22t/AgPyztFrBV28M64lAkz1LTTCwlrAI60XdqdwSGBc8IpIxN642tt3z+okjPvwkraRD3rncgcMH8QKnRcp1+BXd+rdWeY+tJdJ3EEYX3/cnjiE5fuc0GuYrXkHdXi+SSv5D4P+3+c8wwL2qGVUZ3cu7S3n5j97K8LpJ6cbLhYKLbGiTLYpdq7Td+qKAfLv8fc93S1a+RGPz9+CqBdEj9A1esrS2YMHpzfg1D+UtAmu1WPC1gs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(966005)(478600001)(6486002)(41300700001)(8676002)(8936002)(4326008)(7416002)(5660300002)(2906002)(110136005)(38350700005)(66476007)(6506007)(6666004)(316002)(52116002)(66946007)(66556008)(83380400001)(2616005)(86362001)(26005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE5yaGFsem05TGNkSTB2R3hWTkFwL252UzdMT3JOQ3FjcFM0YXZ0RUtnc1FB?=
 =?utf-8?B?c1RZMmVBSjlIQTlad3FDY0Juc21nMW9FbDhzNHBhMnZsSkduS3BMYjhkYWFi?=
 =?utf-8?B?UGppU2Q0UDBwQjQ1MGhqTXVGMWJ5Y0pJeVpNbG5mZjFqb0tSWnhNdk15NDRn?=
 =?utf-8?B?bnU2aDh2M2lBdTYrcmpvelljeG9aVE5WNUhzM0dEVVRiOEhSNlFoaCtqR0Fi?=
 =?utf-8?B?OUNFem8zN0M3cVcxN0FYNjF0YkxJOXVBaTZrRmpwVFJSVGVUY094Tnp5Nmp3?=
 =?utf-8?B?QjhqZG5sR0RmbG14dzNsVTVDblpCMzNROUk2T01peU5BMUVjalZNVnVQQm9t?=
 =?utf-8?B?ZzkzQVNTUEZnT1Zlalp5NHdLclo1L1hIWlNqbjEyM09Wek1mVm9KNURYbWg4?=
 =?utf-8?B?NlVlZk5iMXJrbEJqaWpFakZBeU1PTFBRRk93WGRZRG1DbThZWkZFdTBzbm96?=
 =?utf-8?B?ZE10WXI1ODdwRVN6K1FuUUNDb1QweldkS2RDNWdsZHBDV3c3RkhDVjhHazQw?=
 =?utf-8?B?YVRSaGMvYlVnN1BweEZmK08wQ1FlcEEyNC9IMVpCOG80U2sxT0VrdjBUV2d0?=
 =?utf-8?B?OVU2NmxBY3pKdTdvUHI3L3liVnJ0OWh3a1Z0YVFlMjhjUzlwZFpZZGZOV2dB?=
 =?utf-8?B?ek1oUEJ5ZkduYmgrRFJMNmNBb3hKcVd3Y3JWTm1iTUdMa2hJUUJUT0lha2dE?=
 =?utf-8?B?SW5YMGpSeWxwZ2N4b0pRMytjMS9JajVXRHh1ZnZ6a0tUOFlCSWpoQWxoMnB6?=
 =?utf-8?B?Z2tPU2pCdnhJdWRWN3c4SjI0bkg1RWVCd3dQSG1Ockc4QWxyRUZaR3NLOW01?=
 =?utf-8?B?OFowTVZRN1A2ajROWlp6NkxRanFIYnZLTFB3d1VBenJBNTltMGlXL2pDUlQy?=
 =?utf-8?B?ZjRPZEJMbWVNcEdJVXFnajFkNVpkc29yaGt2U2EydE5qT1drSStqWnJLb09L?=
 =?utf-8?B?YjhDNDMrNGw2aVZKeEk5UTJGN1cwSW9qSC9ZMXY4eHBSVzhqV0xIaVBIVmlj?=
 =?utf-8?B?TG1vWk9pSVBkU0UyM0RtYXJIMkJjT0tWOEJvVm5wVjhkdFI3T2xtdGMxZlJW?=
 =?utf-8?B?TXIyNjhkZ2dEN1dPZWRyU1RnaUJKS1lBRlJtczV1blFYM2hUS1VXRndVVTV6?=
 =?utf-8?B?dUc1NjhFeldpelFFR3YzZzllQ2d3MnNNZ1pwOGJWbU93d2p5TkVTc2M3YVQr?=
 =?utf-8?B?OUk4TFN5akZvT1dHdVYrZW0ySklVeStRTzh5M0tzd0tMUWJaUDVjcXlKZzI1?=
 =?utf-8?B?ckRnUHRTa1F2RjZmcnY0R1dhZGJXZHhWU0paRDFUTG15Z0dJZDYzQlRlZEMw?=
 =?utf-8?B?MkY2eFlzZ1BNcVJYUW1hRDc3MnYwVTlXck9sRC8xMk9rRndSeHdiZXNvZjk3?=
 =?utf-8?B?T3d0R1p2aDlEc3ZFdG9PRENrbkRLS1NFcUZ6QTVJUStQMTRhaVpKeTJWcHVj?=
 =?utf-8?B?Q0ZRREhHSnNTZ1FKQitxRXJHeTNNQ29CTWt0OXlHQlBBZDdnUmQ2NHNnbEFj?=
 =?utf-8?B?SkMrRzFFSWJxdUI1eExhbzdleFpUUjI2SjdGZWtTNy84M3J5ajV0S1ZsNC9r?=
 =?utf-8?B?bUZEM0lDMGtGT1ZvMVFHRk5sWVR4U0JZNGFuTWxtRFVkWG1SNTdQdjc4WHhx?=
 =?utf-8?B?RTkzanN5V0xiRmNHQUd5cXdsZzY1SW9wbUdoMHJ6VW5UcXRySU9LRkdUZjRh?=
 =?utf-8?B?RUNicldpMnhCNWJwd2JXUzd4OW8rNzRTZEhzb0N3UG5SbHpaVDdGNGFzc1NH?=
 =?utf-8?B?SkFPWURQRnYvaUEyaGljTENXY2xXSGhKLzFGTE1KQnc2NWtMUEorTjZXMnVL?=
 =?utf-8?B?NUhDN1FLeDFES2w0ZkxyVktURVF3a293WG1yNlh6RXQxK2czeW1tZ1JjNmV6?=
 =?utf-8?B?eG9xY1g0UFM5K1ZqT1hObFVwWllTSCt3ZUpzV3p6OElWTXhZWXczc3JSMUhj?=
 =?utf-8?B?QTFLS0Q3Mk1aZ2pUbG1GTlp3b3duU2ZQQ2d2RGdsa3YwbHM4L3BOdnRYRWdl?=
 =?utf-8?B?R3VsNFpYZHpJQ2I5QktsZXdNM21PdHdCZVQ1UU5sZ0Fwc0t1VU4rRWF3UHlr?=
 =?utf-8?B?cFVSMmtsbEVaYjFlZWtTc216dXBBSS81SlVhSnRWK0QzQVc1WGVzcTl0dzZO?=
 =?utf-8?Q?XuLY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80574769-29a5-43fe-eb18-08dc2be661f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:19:26.6405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNIfAoKJH7MQBgvlR/3CGKeGz0jbByZe32p/l7p3navU3rZeJg6QrBTeW1CZNGePd9y6w6PAIlDNDAv1YoVHpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9049

Since dt maintainer give comments at old thread
https://lore.kernel.org/linux-usb/20240119213130.3147517-1-Frank.Li@nxp.com/

The patch v4 already merged.
https://lore.kernel.org/linux-usb/20240124152525.3910311-1-Frank.Li@nxp.com/

In thread "dwc3: drop 'quirk' suffix at snps,host-vbus-glitches-quirk"
https://lore.kernel.org/imx/ZcVr05vAYsObrrRR@lizhi-Precision-Tower-5810/T/#t

DT maintainer and DWC maintainer think it is better to apply workaround
unconditionaly. 

Drop 'snps,host-vbus-glitches-quirk' and apply workaround unconditional.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- Drop 'snps,host-vbus-glitches-quirk' and apply workaround unconditional. 
- Link to v1: https://lore.kernel.org/r/20240207-vbus-glitch-v1-0-7be87099461d@nxp.com

---
Frank Li (2):
      dt-bindings: usb: dwc3: drop 'snps,host-vbus-glitches-quirk'
      usb: dwc3: apply snps,host-vbus-glitches workaround unconditionally

 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 -------
 drivers/usb/dwc3/core.c                              | 3 ---
 drivers/usb/dwc3/core.h                              | 2 --
 drivers/usb/dwc3/host.c                              | 3 +--
 4 files changed, 1 insertion(+), 14 deletions(-)
---
base-commit: b1d3a0e70c3881d2f8cf6692ccf7c2a4fb2d030d
change-id: 20240207-vbus-glitch-97fd340d8a66

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


