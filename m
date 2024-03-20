Return-Path: <linux-kernel+bounces-108492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD62880B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0481C21F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A8F1B5B7;
	Wed, 20 Mar 2024 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g1uhdvtG"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970951EB25;
	Wed, 20 Mar 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915813; cv=fail; b=Bqz5xSdyM144OUe/3wPpn3r/k642Zr5t5mm/oKfAyqkcyJjgl8ynrQaPnBzKFKiL4pSoRVFlNTdbzV3E2TFGUAeYhsGaOEZ0AIam3kSrP4qCO6jfl6wDyspt99RT4wpy60U9cQ6+SBGqitkvArH/9VTJg8BUP6HA5jPzauSgEKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915813; c=relaxed/simple;
	bh=Pqw6txsZ2rC3PcvL8JI9YJXr6Ow/ZJRt15XGgfedm08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u8okdYKeHUX0/86F4OpXIohWBrBYDHEJTchVU4/0EMDr4mqcA5V1x0TpW6czKsmIEknmdh60o6ChJM4Eln1cKeYLnjSHcBWXQWY/H3ckRCzi8fj8KEr308N4aDk9beSyqBKTUm0EISNfnBweqbmSam4x/V6YMiVyXvB9IaKJ3+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g1uhdvtG; arc=fail smtp.client-ip=40.107.6.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvEz8Pkjxe20K4EXqRmylXgroBxtc9xUV3j+JGS4l9konu6ZMwc+9IQuvrmMVQPLMerJtH52huS5jbmZazZoThp+8kBGB+9XiTvZn0kZTBPmi7yXHafdapMMLBcFJQDV55GACfHw9AZ4b2ejxklFmeyIUQTWCuNreDU22q25TzHQQ/p3oxp8MjzM3YAp7ahHMtQQ8KWbC97iUVcqDQ3TJwZ1t0k45gzoJCrxD8Nki8atRfKJo9h7kafsX07nasBulS1xJQHpFqzqSX1BCfGEl7ur/qDj+TA5/wag2b0kVhI0ye7mDc2DMO22uu5YuWq4CA7U5NkF8w/TxeNThmXT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXa2yjlS4oIF90OZ1WhVXXURTSQfG8y5lbaLGgqfVcM=;
 b=ni6ZYPL+zxekCO2E2Xa3oZaJGjfTc3AFcSwog7GwbXbuDk56iHEp4e5y36ERWkWHG2MDaCk6sCUN2EJx27ZVzfdTPPomAn8jyNOl1q0jjbZmYDcMTOeHbYoz1v4PIYJDku4zyKu7b3LBWZbij60SarWp+5jYhYGeoHkMnaH+s5BLpi03HOb6ceHsmhDWSQM5t/5nNZAeDs3LVvdCcCbo+Vmm+zk/qcE8QD3Tg4q1NTS36XHohfNP3ej8s0MM1GwcF7ITf3+6kIEJhR0BN4YRMaFbA1hS87Jd253yrsgYnkVraD59Ea1LfdKLWgBdTIzkEpWdtNkjcFcrwQs7/HOeXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXa2yjlS4oIF90OZ1WhVXXURTSQfG8y5lbaLGgqfVcM=;
 b=g1uhdvtGDHi6+b+yDDNkSxmheaXqNGXkBMwt888yjgtpOe3WeNM1Hy8uof6D/t5O1pgcyZRWkMatLrKOEsmPjtbsfonMq25WxiakoJSjxSnPpWS6JOiG0jV9DAXH27GDj7drG7OGyYnD5atFZYN0wZy2kcsfjcY0ddOgTGl5X6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 06:23:28 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 06:23:28 +0000
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
Subject: [PATCH v6 1/3] regulator: dt-bindings: pca9450: add pca9451a support
Date: Wed, 20 Mar 2024 14:28:47 +0800
Message-Id: <20240320062849.1321423-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240320062849.1321423-1-joy.zou@nxp.com>
References: <20240320062849.1321423-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9367:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: fe510e49-366b-41c5-6858-08dc48a6415f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9OFHeClLSdnlRXNj934wupioDOu9xNHUjVPuSYkQs/7+zLMORhX8InXC+G7BVB+VkSL4Brv8AAdt43rldjZv4tqoL5YgWssYvglGisaOBVga6zXaeqZ5gyXPwlok0QidOkxVhbUobuaOKetnA1NcP0aOaoOHSDVlLs2u9v6oSZnLAIM5HlAxmBjbmdNAhXB1ryyEymbB9bJiYFpBijWmi8Ap93251Zy6we9fFlpssh+fgeslEriGUUXB0xH7D9AVOCAGYXd1vKxVP13tEJtYbfde6nsyzoENkvNAhQzgv1jvKZgyYDzv285Dt3Cg8i7hXrI0Rii+lfjfwliQ3xn36jNRcZABNDzKKkXPNRnC3eJ7BGCd77Kz2dKAAII3l0TaEhc0xiH1/enfc9fi3Eehll9c7wdOZwR9YzbrrGsAnrL86qw0Zqb4XgXuexHAIZbqWZgYJYS/crdj78T/6BoZEpppIzKsbvhDVUgHWXL7fso3CpO5B4LNXt0Jb29Aq2YgGPGXlObvZ4CpH/3l+2Borin8eyUXb2v3d3cNBVbT90zzJdLx5SkGNSA6EW6qFq/LU9Bdfosceq4eSa1k6vOPlJthXFbLogaBMim4Dd7kgKS/M6F+NFVGYpZKHAc+EvX84js/5JBEYqAlQ3J8wo/ORUKC2B+YpwTaS3+P3k9DJdx4k+Ppa8Z6Xx41YTcg2auIjsimmEQe25uuINa6qA3xxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iz506YtlX6/of2NWabSkWZjvS9PTb+YQtITZ9RtBreVHb44/GDJMrCCuSL3d?=
 =?us-ascii?Q?HvU4NdY+vVgerDo3RsW7WdoAwFrL5RKtL4p3L//QenvlCmb+Q3uvqQNI7Uny?=
 =?us-ascii?Q?yihNBM7amEo2u4E4gcyzfcBrFEjpl+Sr/g8JWfwgLJv9/8mfYf19Owj/vPTi?=
 =?us-ascii?Q?kymaZNN1yYz5GuYQHtw6fDBpitFPLfHZvk5AbY3yZ44knLp4YP3sTImu9g6F?=
 =?us-ascii?Q?KHMuGkayVUX1YLIhDpJ82cQW1zrI5qDG++qwcSxjHS5TnYdIcCP5/yrFF7bZ?=
 =?us-ascii?Q?x5RTW/GklDsOB9LEBj2qZnnsSOZI4W4jhF/+RK2j/GhassHSfrfk+t+e84b5?=
 =?us-ascii?Q?Jkzqt7d4uYgOjK/u3uUmpHJdnz7JUU8bpvJ4RQOvo3e4Tqik3wTBMPzxSq/y?=
 =?us-ascii?Q?cd69IRVZzqd3cwEf4O4Np/K3b+IrjDdI4o05G8ZrxjP+N1YoQJun9Lyb1gzN?=
 =?us-ascii?Q?FgHEfVlqAZWKj2mt4QTP7nW9zdxO421e7LcHx2iBAHINfHCHYJ7iJdfJ82Rq?=
 =?us-ascii?Q?V7VhWfw9Uje4tRb/ns2JQPj1uak9+nWCaNch+WusVHgFTLiRZNaH87KeN7Qe?=
 =?us-ascii?Q?BZ2HpqmwJY8LxiC3MlWc9RoBc8kUJhMab1s5n9mmtWGg8z/uc6EdJL3/Q2iW?=
 =?us-ascii?Q?IhrihewWu4M5UsQi34RCabDsixbSvZ+UEaEKSgamraDfB6mpGftUp/1Q/iKo?=
 =?us-ascii?Q?UNyDsikb8ObtemzsqjbgozQG6ymRBysXrvNGAMJhgoRKAblfJaIPpFnVR2/G?=
 =?us-ascii?Q?qM+wwLqenzWVDWzO8U8ddSn735zjn3sS6z7a5fwE808gVFvMRKMrs4oqniGU?=
 =?us-ascii?Q?+1SdTGwN6UGSyFofkO/wNNyf7CF7DZ9XAg2U3HhdWJKkg+nzYldRSYfQvH5b?=
 =?us-ascii?Q?+hycIYsd9pSS6jGviDaOqZfeOyQs/CKvTTFrVPrHinILAIfJ8i63laobxwpS?=
 =?us-ascii?Q?boeGGXk6IMhbStlWvd0Fhnh/hcrLpIS1qwzhqpVU+XnUAo376FPSV59bYGzN?=
 =?us-ascii?Q?RvYRHdvPYyi+U4bE9/uWpMKA0sgzCsF8nJWpbuQihV+j+oayUFw/UpevvGcP?=
 =?us-ascii?Q?h29b/AUSkeKerMkSsTKmX16uN5hnJj/2Q4juVNwaeqTNlWyulpb3XVrzd7ch?=
 =?us-ascii?Q?O3LA9mr+dT/Icuio3BiUdiF0yUcIasquaRVMgRRQw1hY0ALO1w9GNhj8R3j2?=
 =?us-ascii?Q?FM07KZx5OFGGLCETs6pX0CgIxb+m0HvHukpX68t8RNYW5IfARGdqItXoIB6y?=
 =?us-ascii?Q?Fn+OTPrpoQlgHa3mUwakF9ZphVbYV6XcB4qZKnDepdJjh+CCvtQBWhXBERQ3?=
 =?us-ascii?Q?kyTOE/Uokyq3FKwwwPb3vwUuJZ1EzogzGm2M9p475q9pfbiQyDhfxrthGzbW?=
 =?us-ascii?Q?5nNhUKSZhHMQQ7U9oF9Yg1qBrbFLnEo5wrFkZmWBGAajVNFXKGWj7cPMkm/Z?=
 =?us-ascii?Q?QrLGSvIOQbK0Qqp9rTipSfz8YVIUCKfcW3rtiIb8vrtUUk35xa2HgRfqy2AU?=
 =?us-ascii?Q?ekCZ66I+XmUqalwLRUdgLT1OJE4j8nj5o1HaqNlW4IBY7t68V3rapTdxbVRH?=
 =?us-ascii?Q?skcQljS6uAbJBxUKjaIBizbAvQFl4FB/TxmJFOMe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe510e49-366b-41c5-6858-08dc48a6415f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:23:28.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kL/N6P14Hf3KwdJ/kU4n4Qpz9r0LjZxhFlR3e8aKo03K8CRrxXrtcqJUbMap5UZ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879

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


