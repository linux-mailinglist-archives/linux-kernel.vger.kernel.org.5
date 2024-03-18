Return-Path: <linux-kernel+bounces-105903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FD587E63A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EBA1C217E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A05E2C6BD;
	Mon, 18 Mar 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GYbt8S+m"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA62D044;
	Mon, 18 Mar 2024 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755331; cv=fail; b=g0svxsuYz9U5B1Lzw3JwuXZFcpKHpXwdfZzCn52Jvkp6/74muxvkjCEPc5YJKp7QaqREnmRKtY20jFuyFPRPbOpwDyaA4BYPLNMKkb5UAu4o9czDOigLLXaSy1vMZODt9g7Gy7ROpEfw9ox3i8jRYMxirucWArzkcS+RxD6DQSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755331; c=relaxed/simple;
	bh=Pqw6txsZ2rC3PcvL8JI9YJXr6Ow/ZJRt15XGgfedm08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vd/WIzWkXp2gcwiD7bS6744ok2CrDrIAe8AKmHl6YgHwyXV0rWsu7Li9vC9jcQ/fmaMutpMgI40u1a5neD+fUhxI1SSXye9YqhbUNWhyDgA8EDnLKuE4SvVQosT0Ei+2HdZt8dq2Os2VEWJGwXHTDdZFInSSUtqWEpxGR/DYU/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GYbt8S+m; arc=fail smtp.client-ip=40.107.13.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpIQbTFPPIn9VwNEje/DhUKLDitMjjpALvEad3S6V63xiXFu4sWA6PTzcFQfOwXqZwCeFhHC7hKOxPv0drhhhHcioQP1ONApn17xoNQgTxwa7s6fDW+Q2i2MYz3BV+7OA6pk2wuW2F8RfdCTkD9shNyyIlICQXYLr3iBPowU09VthmsZUwHdcjRyS/+ijhndha3qx/SAkF6jYcCLMhs0ZID6WUJF3CddyWwZST5VpfLpn3cbj9I/Epfm4/GJFX8gKO+On+xEgY7SHjWBsZ6EWHF7vdW30UR178L5sd+XVa050dJsvRuc0KxCxRC+IaZF/KIWnq1rV5xS/hS/RkoU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXa2yjlS4oIF90OZ1WhVXXURTSQfG8y5lbaLGgqfVcM=;
 b=dOUhhMrCGX4qZ7Dd1OOxeJ1zdXeLakpaHLmRfYGYcnMm67LWyuWk9OpWWo34Ja86UQtLItaa1y+gNu5hngMMZG84+0sMb6SrLxn9cJx0SpSYVj6bCQv9rdj2NbISwDnIkfUK0OdYnpKvTJ8jclNswiWKDid2mFmJ3l4KxjcMrwFudj4rZv9wGXjamKoejJ5FxS52/xcHLiRhF/t8eqVoYoXke3b81Js63Qp2HeB4xgic0WbXAZnyNFgjk2VMxcpCPdcJRCPe8N0ZnWeUWDGNApRKjklR0qg5eJW7h0Pb3kbVqrdUstNLIRlZ+Q7Xkuph+l90U4MApLdaD8WJq6qKpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXa2yjlS4oIF90OZ1WhVXXURTSQfG8y5lbaLGgqfVcM=;
 b=GYbt8S+myXtKUDdoNhORjfZwU7+mlTfGokEZJ6Lkh6g9Iq7S54KpBcaVFwM6I6yb1A2uS6FA3WzoZeow6fKDT7UlbrQT1cdmH693I2umJLaBkQUbC5pyMt9woiIIhRyaEn4oP9mFrs+MuhSfpoLx4HB/nuZimto7ML3fhkrvzeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 09:48:46 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded%5]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 09:48:46 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	ping.bai@nxp.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 1/3] regulator: dt-bindings: pca9450: add pca9451a support
Date: Mon, 18 Mar 2024 17:56:31 +0800
Message-Id: <20240318095633.4079027-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240318095633.4079027-1-joy.zou@nxp.com>
References: <20240318095633.4079027-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9367:EE_|AM9PR04MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 7199bba5-f701-40f4-c350-08dc47309ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9x7IwaSuDrLD/nopxGtAYoP3ejczaV5qdiFDt4vB/WvfPuphZkxjKfGG5EWmc0iQSDkGMUBzuszvlnr92qBKBN98pjON0qWzOf70d8PQTrGgt+6HJ9hMxSC4fAosnMEDjkK8Z229S0pVbnq/lErcqhFlBAB8WSG3NLG2LhpAQiNA8Th4W+Xv0aIdPPJjAIMUc5ULpoWsPjPToutgdmHw7h9LVO2hrnWUi2qb63Uz6PNnWh50V//qUKxHSlrW7s4a+N11KAnrtIC618TfFKAH+Yc0tILZC4AezK+D1E8S4mAf2xxNGBUofTw/HmSClaVtuq5lDhXVojdaPI12vvC/AKZhGX09JLy80/kVnj0yRymsFaCq1tK9pHk2XrveE64d9cdPN5H5QxJhP2+X82ukCAaF8+SN70giAIa4Tl2kRLLYsy5xKnGCA1SIyRqh7knaupEqKKXtRImVPY7A0y9QNfHEbylxmwArJiT0qRMprx2Ay7VAAkJDCxJ/hennS17XC3Jpv+pnX5dlvuo2TR8lL976DoBfuZW56Yiub9adWEp5YEEUZRZNOwMOf9M1U8WoxdC4Dys9rfDUxg7RAVMr0R1R7TZ7ulceHIWYfNon9DMgZMEUuYY56rYy9WXlrN3PgGko0T2tnl7cEScKXwM/EjkvtTACwhjfyaIOEg7BcFqV71FoLRR1EbpcfavQWMWJ1/D5s9sN25wufButtPX5CQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zk+rEL7fBlydRe+k16ZYokVfp1k3WhY2eQ0xaFjjB+u7w5TNA4Om/MdPcWQq?=
 =?us-ascii?Q?oUNFwCkL7HZ4uIX0dJTmv69psmxt0HUE5aoTm4xXVbcyObx+zFsY4aHer6Q0?=
 =?us-ascii?Q?aOARagIMZKAN/4pu1JthPLP3BwqCKGLZgxVH3NRpEVwZm/lrFuqwIDJ8YH1r?=
 =?us-ascii?Q?6OqeN2jyTeLWVNwkF9pmwN05bnl73lIo4tXXR7nbDFfowbxZZ+hHQcUtz0P/?=
 =?us-ascii?Q?OxyRUy+uX5HrQxdl323OntYM5tYQY6/hrgM+PfNQgSyByZmPjnSLJohrNQPJ?=
 =?us-ascii?Q?bspMcsDD6wPhj7c26TicuHt7qyh9Peq9cqRy59nqocLcLRgPLntZY7JP/TvU?=
 =?us-ascii?Q?JVrhhFumaQV+kTxOiVQcCSQkRg1HNmAw8/5TJ6ZuHb+Q3xiw86Dn8WHmdtni?=
 =?us-ascii?Q?MiEda0LZCjnlbJb0qCtKQh/J0OkckAvwx2J29TXbrlEYg0xCPIYB6NPywdZO?=
 =?us-ascii?Q?oCby/+IXdLZ/r1kbxe0I3i0VSpxnYuyoPCJ95rdJSLKmf/86AkUYoQjUiweT?=
 =?us-ascii?Q?Uloiuk2fhyiyV6xXLj94Caf+JSLdhCIaYU9vsNEhDVhSTvctdey0zJyFF748?=
 =?us-ascii?Q?OQLI2+lWki1AImW0KOga77JvFGaLi/Iafrx0+rShfXBy34cm5WNrwzZ799tp?=
 =?us-ascii?Q?oT7nYf/JdKjlXRGh2VtMVpYt/94eI9jzFszBlSx+AHH77NnTc0MpNSLIIgtd?=
 =?us-ascii?Q?VpNZR+3fK8xV5ILkj02E66XSvDKlcLzNlkpVk/+L5pX1i+aCKMCNl6B3yS02?=
 =?us-ascii?Q?4VO5+h9rsjvChrYPTeuRYlUfP502kRatqyzqAOcyHHxVRZ0Tx/twkEt2vXWg?=
 =?us-ascii?Q?fG7EgwXnRXdXuSfGQ443qybbigI/eerEbCEVjGGzPhwR+j/uTLvr6pt1BxFV?=
 =?us-ascii?Q?+THM1buVQ96phdygzdNbCzA6hhmOGgp8F6BKS1viEZ8U7Bzdo6wblk3zhEz0?=
 =?us-ascii?Q?or5qZcJh/xCm9dr/j9/JPUr51wB/PM+lQL/Tv9C1I11tv4xEYwRv3cpVvWoM?=
 =?us-ascii?Q?rH1b5docnWonhZgB8vrYMlKanFFD7oNnOS1Hs44Wwq8jJoYv9Tmw8AcSBOsm?=
 =?us-ascii?Q?oJK+cK7fnIQ7+c64qTM4NvJfmt8Z/S5eFpE2MX6jX7xq8WRXzn9YajWs+uz9?=
 =?us-ascii?Q?12Ba4RQwBCfuWFsOYJAbuJLmuCng13OOcDQllubfiUtp116QZJueWyFcg40r?=
 =?us-ascii?Q?L1UzGMIu/nkCB9zXvpUnPkp/rKuzYgt43Z0VUkbOl8yJ2vC9wN33g77QOP3m?=
 =?us-ascii?Q?b23kuHnndAjPcEmMXxQovoTADwC6/ff835i8+Ysp5f5DHKb/gH+9u9R76qph?=
 =?us-ascii?Q?t4UVoMuY6zq7ptDDzXN9GnDDJbZJyex4Oi1x2FS45DkS8SttQpfHcRaPwmik?=
 =?us-ascii?Q?UTRYP94eUL65TpaxD9Og7BTggl0gIox5pUXoLZgHXlg6ZkztR8u1JZKBEaOL?=
 =?us-ascii?Q?iiPnSpWXnm+avPc9SZfxgQWdWspQCuU7W3Q3sY4I594k7mxJ3estdAq127CB?=
 =?us-ascii?Q?Q/xAalr2rTdUyQdkT+G6cDE+Vw/cGbhYevncS3yznjQAUhvt0ZsAInTRj3Dk?=
 =?us-ascii?Q?3IEZl12pNfXcndg9wQIdPSe1masAeTARjk7InkFA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7199bba5-f701-40f4-c350-08dc47309ab4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:48:46.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeCCZAnwTzYcMJ22B1129YKEBe90gZVo/P+Tm9mzU8xPkI7vHfQ1CWCkCMyQY+Pt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8938

Update pca9450 bindings.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
changes in v3:
1. add Acked-by tag.

changes in v2:
1. adjust the subject prefix sequence.
---
 .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 3d469b8e9774..849bfa50bdba 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -28,6 +28,7 @@ properties:
       - nxp,pca9450a
       - nxp,pca9450b
       - nxp,pca9450c
+      - nxp,pca9451a
 
   reg:
     maxItems: 1
-- 
2.37.1


