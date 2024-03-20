Return-Path: <linux-kernel+bounces-108968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBBD8812A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763A5B21BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3008942070;
	Wed, 20 Mar 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NE/4A4uB"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2120.outbound.protection.outlook.com [40.107.22.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356353D54C;
	Wed, 20 Mar 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942550; cv=fail; b=WRUmw9VNB0qV/VXnyDhJzJqUeHAUjLZdS+m9xR0nbKRAeJTgOSQOvMRjlfKWYyXL1gkfvDzjj0/wNr260xgFaHdn4gZmbuhEjxuuEfApPucU18SLDyh4Hyb+evHgnYEKYDYShCe4kTCk5JVSZsLrv3F0ep1yO5rBWMdI7lK+cpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942550; c=relaxed/simple;
	bh=B+RIQPytx/JWG+eU4gRyoRAlqW1Wsd4Kk2ksvKdhIdM=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=NtSIdq0NoL/df9aud83OvYSPAOYw173+B+bNKBC4eBKQJaBAotbUplgJcVWtUpmt4mNN6pFVexv7xMfgz8Vei7SlCELjf0kVkcEhzq5ujVYn/dpHE1/4H/YsqhvS5kX5fA7deN85rQIxkEB4cjuymHR7/+a+1+7s8rR5aoEoRNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=NE/4A4uB; arc=fail smtp.client-ip=40.107.22.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyc0eOeUlLAokTPRvP5ykldr14AwGMX3TorW4fgU23LZ7QZuDrOqLWbqe44/Gxp8iqJ/gl2v/CaKS7yklwz3Wm9oyRdQSFo31GQsLikxs4dEI0ImuSvmKbHqnZMJOtdJYJvLNkfOz5wXHakWbwh8nAadDn80X8VL0swcSkahwMQB0LciINGRAGlF9YQURVhuSXXe4ivMHVS7MHBamMxGL6/7dGjsthzQkf7hUrOTD9wFsEDAsYlhB7bOu2BXRFmzPPrb2TPYFSjQhDkjByNRk36h5TLw0/NP8JRgipUt2j1bwfXH5o/HkFKh0FSrH4NjiWMl45QjyS28T/I9gqnX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D65vTd25yGuzGMP1mg33QcvuFPHoXwCZ2y2acfRmARY=;
 b=aLV2O+CB9Emw8u5Dxrg013PttQwccdQnAy8rZQIv4Gb2pCs43beyjI4EuRcu3qvFiCf68LHanwQTFqgpUgoH+Xs0mJRqcr5PkSmoaKiniKC3HVXCoQPrOhLKtqkOO2lMxjhzCgq294RHgnD9hJlfxfaYQ7nrBCi+/Xn+fA7WSXmzZILiDMuuG9lK8efTq+I0wQj8AiEkKoEYW5SEUZdRvr8ouf3hy9DSRKd8b26tGp39inOFkXgKBtWXj6hz42RbOTkNU1gzBsX/+OUdWBcYtySvYwKFLi4flfVn700wUDcR4+9oAtbqIO12zTyi+NCQKezGN7eMXrJ6j9jkCEguWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D65vTd25yGuzGMP1mg33QcvuFPHoXwCZ2y2acfRmARY=;
 b=NE/4A4uBAqJoquF6ZytTTNkpIWddJWknFJweogZ16ax/RENbeEdBjxwzMgE3XLhKWLfTH/9AdwoYWsZ5zFn6VY3mMEzGaKn0lxBvGsN30psw0VM+CGj8E6J6TpPIbaL7UnjesPg0O5nFg/BYQlOGl5pmP2QLNPHMEljJJ3KS1zQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GV1PR04MB9199.eurprd04.prod.outlook.com (2603:10a6:150:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 13:49:03 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 13:49:03 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 20 Mar 2024 14:48:55 +0100
Subject: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus id
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAEbp+mUC/x3MTQqAIBBA4avErBswE/u5SrTQnGoWWWiFEN09a
 fkt3nsgUmCK0BcPBLo58u4zqrKAaTV+IWSXDVJIJWopcLvblnRKCc9w+cmchPaK7LBWpnKy0Z2
 1M+T8CDRz+tfD+L4fe5gpVmoAAAA=
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|GV1PR04MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 73094d20-567d-4f15-63e3-08dc48e48090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	53RCeotlmZeaOuapYD/oqoFsFd8tcJ/rNzDFO16ITsS3EboyjQ5arZW7nhrf3ysV+ZWAfiWwzcVmIzCY6hBeiTuliG6vsD3MAMpNIQzoqHFdbsxEwKF1i773T6q7Xt3xiUhkuQczQ7ba6z1u9xnWWcNOhBouGyTrYEgVgvKXr7UTfxBOodTV0UTZlswfP0q7RoN07VqdZhblxl2yadEMeN3EdujftlOsU4efWbEdhQDH9k9vPRvSvf07dgoWe5WyehknISOEhotnWTeBrXPHkYRwClv4Uc1GSvzfbzVwwVfExALtX/8SYYQRjrbO15PzHJf54Q+YLx0Me/SdSpPwPeIa7BuUemc9AcX5OpmAULsuvINwlhNJFcZa2Nak3uY2S7KPbdjYgDfdl94O0qe3qUFv2dXXLoNsPDB0F/NqUilZmDhqzyqsz5LY0gEV5jyZFFC10asU/B3ILIzYERJS1grEEjyTKcsmwcL4Gu9/3l6ULpNe75+IDHTsbySQfeYm40ka14dOWpKjH8ML2lkMOYB/Bb2xOzY0dwSWzI2RkuDb+wru15bykAstdF+LNFxdhjT1oNJ3E+e/53/3LduafZeLozVebkcFiD+lU7rmgStaMv60UWmVAkJWIUFiwGekdZ7FlJoFYDB0TzhUmjQtP22YstZrOdCdhtDR9uQkOmlu7pcfXk91nT92+sis8TY9TxcfIhwbN8+LIi11h6TirMbpvV2pCOboUu7oGqugrik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkZWZzFJd3pGZ3hIcS9VOVpUa282UCs4NXZLcDd3V042WXQ4aEF2ZWZTdnNl?=
 =?utf-8?B?VnlWa1NURUd1WGZlTTBaZEI4SllKZUdIUmxsVVRBZFB4dTZZN3VITXo4cXI3?=
 =?utf-8?B?UGNNd2p6STd1ck1XNUxkenZsT2hHZCttM283Rk1BWldROFExdkxQUlpBdXR4?=
 =?utf-8?B?QWtzdlovZktTQm1BcVI3cEtpalpISy9vWkNhYmJrSS9ieWJaK2Z2ZURWNEVF?=
 =?utf-8?B?cTErTlpuQ1ozbWV3Q1Z3RVpRdjJpMVNGanRyUEhFWithYkZUbm5teEFQT0w4?=
 =?utf-8?B?WWVRZHpUcTdjNjg4VGxXNXpSY2VIRFNscm93TmRFY3MrMUxrc1hqTmlLMmNM?=
 =?utf-8?B?bXc2TTVhUXVjVEtQQTJDUzlCQ0NSYURaVlRWN0NEYWhnSWx2V01GSVBMNUlo?=
 =?utf-8?B?OXFrZlByZlVoZE1lWDg2c1JjVGNwT21Sa2h1c2hUc1lvaE5ORXlFd0Nya3Qz?=
 =?utf-8?B?UGtKSWlOVkU2eDBaTlhzcTB3SUtqUGxCSW13TEx3OXJFdHlBOStJSTMxc2pU?=
 =?utf-8?B?OXNuM1pKWFZhYkFqUE5DYTdjSTFTLzZIMTJyZVdSRk1RZVRIMjlNSDlubEYz?=
 =?utf-8?B?QnVzYjFUaXhzUk13WDZNZldlR2FYenpzQTJDcUFWVG9TQ3BDVisyMk9Icndq?=
 =?utf-8?B?a3dxSndzVGo1cUl4YXpQMXBVdE5ITmlZeTlBWmJWcWhnc2djZlRFY25pM2VX?=
 =?utf-8?B?N3RKdFVEb29kZ2JDajFTc3NBeTBOd1pLekRuZStCaWQxK1c0blpYYUpVK1VW?=
 =?utf-8?B?eWdjNzVwMHVMMElRRDFqRjh2VWxuMnFHakgybDE1QXdScGR4L2plTG5CbEty?=
 =?utf-8?B?eXZHSjE3TmtOZVBGTVJMTUc0aGxYQmJjS3NJcGdwdmp5cjJuSXFrS2dIcDFL?=
 =?utf-8?B?Mjd5emhtREdEK1A3K2xMcGlsY28rNWNBV05QS1lVWGlSdmFpYjVQem8vSWo2?=
 =?utf-8?B?V3FQMkYwbjl2clg3K3AxUU1MKzBudjluVGIvTTgyaFJGMmcrOUJ3ZzRSTFNZ?=
 =?utf-8?B?bGhRNS96dFdaYU9iVS9JY3pMM1lwdHNIYythN2RoQm1xZUhCeXdMT3l0RTUy?=
 =?utf-8?B?QkJkclNhcTJ5N2RZbzNMNEVYSkR1UTdJQkx4QlZ2RFRkRW8yaEhUZE5qeTZ3?=
 =?utf-8?B?UzM4aVJtRmx2OVV0a1UvK3B0L3RPK25pV3M2dmxzM1pIRnJBSHBqUkw5alo1?=
 =?utf-8?B?eXVSWlcyTUlPNzk5d2R4cWZwSXBseXZrWnczMjBpaVRXa0hReFpKc2sxeE5W?=
 =?utf-8?B?UzVFZkFicFBTS2RVVUpNVFJDQVRmSHhJSDFNYzQ3MVpzc01ibURGYUhlVG15?=
 =?utf-8?B?ZE9xN2xuVGVDT0tHdFYwRyttTFZOc00rMVM2S3kyUGdGWk9qK05qUG83MjFr?=
 =?utf-8?B?U1hVVHJsK3RkRUxmS2dYN29PRXdSZUsyWkxmZm5XckNmUmVuNVVhZ3dncnpC?=
 =?utf-8?B?R28xdVlnVUx4eXdaYTRxd2ZYSmhwdllqSCtLRCs5SzBjM0lVa3RYcnZJcEJj?=
 =?utf-8?B?LzhaSWk0bkxwRFBZdmhnejhVZHl4dW5PNXg2RFZzODNmWnk0TDlwVmg3dWVk?=
 =?utf-8?B?dzhNbEZoN0JYYzEyem4rUUF1ckthczdDak9vTFBndmlZRUR1MGI0S3l1VStz?=
 =?utf-8?B?azNxWnlmNWRVK09CREU3NVZNRngrL2dmUUhTTDNocDE0K2hHMHNOVWxBTmc2?=
 =?utf-8?B?ajZLZ2NkclFRaTZwSVowcXE0UHcwdjAyRFVWL25ka3V1ejM1TnY1bzdDUnhr?=
 =?utf-8?B?RTBjR3ZKSFJrejA2L0VLNXpwODZqcmFRcXFGQUwwZjVJd3F6cHZFcCtveEVR?=
 =?utf-8?B?dCtTcmw2Z3U5SlQ3WW1rRXdnL1dZeUs0b3Y0SnhXbWJLUzJHVzVabDh3THBh?=
 =?utf-8?B?aEFkdjkrMU1la2dqSEI5SENCNmlpUytyMHpYTUtwTDErb0tldTZodkhWS0dK?=
 =?utf-8?B?ME5qZlF0aWRFbWUxQkFERUxyQnd1UFBhTXBxYmpZL1lqRHlreWNhcE9MR2ZK?=
 =?utf-8?B?Rm40T29jYlNjc1ZtZEkxdkR1NWRxWjYrV3BGdU40M0JIblhWa0pkWUZiS2NY?=
 =?utf-8?B?d2g0VkYxSlhmMnJaaVl0MDY3cHpzN3l4WFJOSU1OUUtUQXB1bVk1VDcrSU10?=
 =?utf-8?Q?Agu2TtKysmrYF2EO2FH4tNxiQ?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73094d20-567d-4f15-63e3-08dc48e48090
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 13:49:03.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RsZzsXQVSX4Ql+v3i1Yru/VqsRiRnt4IWX1wM6Ry6HpXeBpUO26MpceyEhaPEeIdzM9H3RUatSCHi6XaF+VWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9199

mv88e6xxx supports multiple mdio buses as children, e.g. to model both
internal and external phys. If the child buses mdio ids are truncated,
they might collide which each other leading to an obscure error from
kobject_add.

The maximum length of bus id is currently defined as 61
(MII_BUS_ID_SIZE). Truncation can occur on platforms with long node
names and multiple levels before the parent bus on whiich the dsa switch
sits such as on CN9130 [1].

Test whether the return value of snprintf exceeds the maximum bus id
length and print a warning.

[1]
[    8.324631] mv88e6085 f212a200.mdio-mii:04: switch 0x1760 detected: Marvell 88E6176, revision 1
[    8.389516] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
[    8.592367] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
[    8.623593] sysfs: cannot create duplicate filename '/devices/platform/cp0/cp0:config-space@f2000000/f212a200.mdio/mdio_bus/f212a200.mdio-mii/f212a200.mdio-mii:04/mdio_bus/!cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi'
[    8.785480] kobject: kobject_add_internal failed for !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi with -EEXIST, don't try to register things with the same name in the same directory.
[    8.936514] libphy: mii_bus /cp0/config-space@f2000000/mdio@12a200/ethernet-switch@4/mdi failed to register
[    8.946300] mdio_bus !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi: __mdiobus_register: -22
[    8.956003] mv88e6085 f212a200.mdio-mii:04: Cannot register MDIO bus (-22)
[    8.965329] mv88e6085: probe of f212a200.mdio-mii:04 failed with error -22

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 614cabb5c1b0..1c40f7631ab1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3731,10 +3731,12 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
 
 	if (np) {
 		bus->name = np->full_name;
-		snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np);
+		if (snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np) >= MII_BUS_ID_SIZE)
+			dev_warn(chip->dev, "Truncated bus-id may collide.\n");
 	} else {
 		bus->name = "mv88e6xxx SMI";
-		snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++);
+		if (snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++) >= MII_BUS_ID_SIZE)
+			dev_warn(chip->dev, "Truncated bus-id may collide.\n");
 	}
 
 	bus->read = mv88e6xxx_mdio_read;

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240320-mv88e6xxx-truncate-busid-34a1d2769bbf

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


