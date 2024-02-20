Return-Path: <linux-kernel+bounces-73801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E475485CBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D37B210F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1435015444C;
	Tue, 20 Feb 2024 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="x09GaIRU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="OZjtxPbi"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2129.outbound.protection.outlook.com [40.107.6.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B896BB28;
	Tue, 20 Feb 2024 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.129
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470375; cv=fail; b=DOOa2bYCTfsoh6VMA0eCGytHa+P+eOFMQrvDazvcXtaFdZdQ/eS5IQgWSKTovFEccnAs8opEsudKd+iLSX2BsY/n8GTk7Fkhj3TcgkIR62ZwrLYD3jlktjfHf568FV5x2KJSG270t1bLBpA5fDhpwQImBhJ72duB9GzgxgJnsxo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470375; c=relaxed/simple;
	bh=n/Z/umP0JMNRV7RaeTHrcaGmeulOnv3UluU9hzmxXYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d9zeC3CPoyLQRy3PIJnYLbgP7YYtGPP5Pq7IGaW9qzlPsDn0B7tGsCyjYYhyvm8nAEHwrgi9/SMfqimMbH4s1d31gy/va18Dn0G9PVU83sM1/ryrGoNKL3a22fJe7h84o6OEmgrlXjC04a67LNw9KeoiAdraI6ogo59ekDGd/QU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=x09GaIRU; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=OZjtxPbi reason="signature verification failed"; arc=fail smtp.client-ip=40.107.6.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=KdOUsGjGlz91vOehn3kOFsk2n4zTJU6HC0uicCv/aGJZf4mVB0ugBpDw0lyKYIcf8Q8T+zj2G5sMy0huDZuYpNdPesHp2RqQKISvz3gtxFUOaYwqXZIZOBcKpdDmJScvGnvhfhwueOzvhLNP3/VGRzcwaVw5H7n5zpcjdschzdT4dCQgK+CtPWEbGrmbbS7fB1WJxg/JrTo07JkpgmfMc6vUQBp3e84GdPAXihV/fRFkQB2bYhwzje+59uWJc7MJcebm51iqaQJkLk79g84up3HeObfe+Xn2GySe3WG2tLqmKYS6ixA3eFAguUAX3PQpE9um06LrBOKt7BRD7aECMg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w+4PuBnhrkuYrGHV41LHEash18tJvJnm/tWh1DHvMY=;
 b=TLvyt3IsNUjuIpFA8SmY+XvcAKaL7GlTdkQyA76m017Mm8/X9o3QP9uLz1DNR5jGWG1LhsrqEeIdfhVYqpqHUFG9Nk3QuFO8JZQKmnJd9pZ9Ly8o9aZJnWu654MJcHvuR/Q6l22dPgzlzhRejxRh5vgTQyKiQo2/A7pBoK6FlN4sUzDOv4Rt6lZ6UmpxqTCrUPx9ZzUyjIertKXktnlpMw70Jf0aFmkCVFgxxFXWTlA9dqDbHP3i2ToukPOUf/xvxIkO0ijoMkX6hf+p35wBo6iyRUeUycFX9OeEPlY1fyyQNMP+05fhlC2NluG6p7SDiQhRAfiz0bWLT2pOOun8pw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.82) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w+4PuBnhrkuYrGHV41LHEash18tJvJnm/tWh1DHvMY=;
 b=x09GaIRUeXw7QmuOpwLZu5jvW3oW2BDWFX9sOYIOJLz5U3Phv+oufExD4TIq+TwfDrP3tzhPtAitn0KlVIBaqciu9/zOcaV41Jdn8751ZbbmtdujZqJB/aF6tWVPaqUWM1Ms1paaTzhX9NfnwyU9gnwikuJa3s4p+tScc2k5heFpRoOplkiWG5WMtHpJyzsLNWVN0EQ4iwkDyEL2kiyoti5RfbpbqNBd7izZjnvoJMx27b6gLPMvfXM86p8oJXWTOQ95BZhFZdtgtfqLzy3zUiPf3SdqCD0Z2URpbLQeRCEfGoVMeCtYLX1ix6NAXJcnh9PCgN/aIikh0TXAsJW0Xg==
Received: from AS9PR06CA0537.eurprd06.prod.outlook.com (2603:10a6:20b:49d::34)
 by GV1PR03MB10456.eurprd03.prod.outlook.com (2603:10a6:150:16a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 23:06:08 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:20b:49d:cafe::81) by AS9PR06CA0537.outlook.office365.com
 (2603:10a6:20b:49d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41 via Frontend
 Transport; Tue, 20 Feb 2024 23:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.82)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.82 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.82; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.82) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 23:06:08 +0000
Received: from outmta (unknown [192.168.82.140])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 3636620080092;
	Tue, 20 Feb 2024 23:06:08 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (unknown [104.47.51.233])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id F122F2008006F;
	Tue, 20 Feb 2024 23:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdQ04GRLPCvYAw2vCkfx3H/KNcMsHIzYs8p9gv22carQHl3YI7S6QmnCHWYMDWz4e+k86Dxf6HOo9u5rkiItTNtEN95lJ6c7VjwN/Rd8EeBZGjdNJi52ur9N/eIXWZAX4mvq16RX9om6evOrTPT6k6CvK/eOksVVkPRmedesIdfNMJGnHAMINp1b4lwOBR1uR35mUgCrb7xTw+rLc0gRG+HddeRKvVu7s6D1G8Nuk3O9/ideslwQYp7V76Zt/QnPe1EnUughKpfM47rONzziMkj4gYiV/Tpd2I1W3P8z+vXVveqhpWGCcXFQe+50YevCeFF7GtKAH9DXmtynSX0wLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBZAWhqreUU7ZtP61ScN1aTztzJtRad7HJ0pFnqdviA=;
 b=DRiQZdc5akMU9c1MS/L4Frwzt6kDcj+8fJDl8S+Oat8/OmRE/owWpK+l+1rTS7HdW72kK/gSjviebEwc2/k2jYgnAa03EcLdB1sYjMOK3q4+FiVXpXxc66s87yl68lCNdM4O3RnEztC/mO8C9MhY84Q5iDU3LuH3nXwpH7VJM7MVk94FpCYfMbMp0yDEohkRqRmIAS/LosvoQFNZx8mJZRuR1xUEbDjPqGYeoB6Z7kheSt+BQrCmb+m1qtvO4YSH1yMEe9nr+2w2PPlQYv7wmxNGA064oC0vxk+fMWDwWyKTMCxMmVrE5bDgWMTap5eYIufkrqnRCj1+3j2Rf1eYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBZAWhqreUU7ZtP61ScN1aTztzJtRad7HJ0pFnqdviA=;
 b=OZjtxPbi2+E3n53WcuoI2MbmuzU9OmyUqKvJZyzXGqqdKxulQ2LHWhz9aVynsoznM/VhRiPXc96o6FJp1yVpWiMK+HzrtQs9fn9GfWLKahRdZ0NUaVWvEaC+dznDmCPgD0qpykK1Uw9Rx0s+ggDzKN5WQlov+wjEIxHVaIWsItTxYMVPk31PUggcBtNu3HGgj2hPtJLPomZ48oADb4pjTwNhWRbAhM77BbGmlU1wMYRkMK9oqnzOTRjQJVzcmOFa9MqUZa8s4k7V3KOTI2vO9pylJOT78qU2RL++8r1xvuwp+OKPAJ0ePDMNc6YUpuK63GSURgte0rIwF+6Tdd0pCg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM9PR03MB7153.eurprd03.prod.outlook.com (2603:10a6:20b:26b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 23:06:01 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 23:06:01 +0000
Message-ID: <8991d5d5-d0f2-449f-b70c-bdb82d9fc77e@seco.com>
Date: Tue, 20 Feb 2024 18:05:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dpaa: fman_memac: accept phy-interface-type =
 "10gbase-r" in the device tree
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Madalin Bucur <madalin.bucur@nxp.com>,
 Russell King <linux@armlinux.org.uk>,
 Zachary Goldstein <zachary.goldstein@concurrent-rt.com>,
 linux-kernel@vger.kernel.org
References: <20240220223442.1275946-1-vladimir.oltean@nxp.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240220223442.1275946-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR19CA0056.namprd19.prod.outlook.com
 (2603:10b6:208:19b::33) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AM9PR03MB7153:EE_|AMS0EPF0000019C:EE_|GV1PR03MB10456:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3c1596-4d03-48b3-90f6-08dc326885e4
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 JzbuN10EP3KGxqQ2DS2/mp5eCBDFCebhcNcdyp4q7ZCAm5bgap8QruPIQkAr4RJml1zBYCBMkaG3gXn9nUJ9Pnc3aKx3i4sKuiNza6upAKYkwBCiLWpYkPiCCFHNmMShFcTSRcgNGxr/+pEXNZkoJK8VRnh+o6e1SQk8unh7MDtKBK7ZSSX8LavoaWTsgdQ217mBqK5+Ht1ZzldCwFrvfPYacQaeszUV2jaeeFE9U4hk6c6ZjtmgTdRwjTWaMh0/MfRMTR8OJNgM1p0g8zIVke1WuOCFLZbAj0iztwLd8lQVHMVgLdSgQZK+XcU2oK6ZN4zCxeE+WZEESkCwOGrpt523cJCqZP5SVZQzob84q0jClzrYCINQamnkucmI+NAAj74LoV+tI6k3AALQS4UlsYDy7PaEpI5B3oV1hrDu2YupgO+XZTib7kWhpRiYNGSIUR3V6wamTPiuCig5Ne2G5/7yPhZbX7BhUjGE4NSXlnl7MgkSo1nuJ2GDetbJvbF9yo/suzOEAntsNmMsQgXWKRdJVOCpDHsr1C037bsqgj2ZTqtbZ/n20LY+nmEJdPaEeSS7xqmCOA45FcZNUa53HH1jAvn1KIPpaKrUGXTFhlM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7153
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fb4188f8-b4ed-46c0-0425-08dc32688176
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zl+e6dHTIT1cRJLNCoHmC1xKsAcQ06tbUUl+yRwl7m3Bs/oUlyLZWYoT3c+pLvVhKPU2Zbo8pdeAUJB/qpNSxd6T5RF+U9Wieh90zcZmqLF6F+rgHiWA387zyQa9Kej68vhpRmHFP4PW9cRKiwcdaIGXvxYppjldeJINXOuGMna5K+4gMVuYwy7fdtv679YO7KYaBB/q9dwk9b+UZ9A42EjZxJqVHn7D2lA2o+hb0/nt506EVxdzHrajPviTVKYIvz64LkFiaBbD0PiSsaBGP/VMudi8fNJzkfop7LTc4YlGeikcRHxEioT+2b6Q46csPxjs+UmoIp6PaKTJF7JKlOzfEJ5C3lKGdxjLP/CEGEdOVfq09qJ6HhzCM5qIC0MtUg2Z0B2/EIk7/16RhrM3WKancJcz4NAai6PUROxFIXNtnvo8wKMjoVIjoBW3NoACli2TV1VSF16nNUQdGjXAezqhrYGlfeV7pvNQuRqJmlnMQzWejyeF9PbZomaH64F8fKOqsApIZ8WKJzJrUdoYEWD7TWKp2tiI07i+/FQc8EN7B7qp6CTBDfYpjg/rqgJI7ZPf0Zjdx79Kf6RJ+FxIq+WMQTyXMKSsS1spWZtcgfOlS0yCBBYY4x/OfvgWllzb3qfpFEuXMaHhAySp0QZOpg==
X-Forefront-Antispam-Report:
	CIP:20.160.56.82;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 23:06:08.3635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3c1596-4d03-48b3-90f6-08dc326885e4
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.82];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10456

On 2/20/24 17:34, Vladimir Oltean wrote:
> Since commit 5d93cfcf7360 ("net: dpaa: Convert to phylink"), we support
> the "10gbase-r" phy-mode through a driver-based conversion of "xgmii",
> but we still don't actually support it when the device tree specifies
> "10gbase-r" proper.
>
> This is because boards such as LS1046A-RDB do not define pcs-handle-names
> (for whatever reason) in the ethernet@f0000 device tree node, and the
> code enters through this code path:
>
>       err =3D of_property_match_string(mac_node, "pcs-handle-names", "xfi=
");
>       // code takes neither branch and falls through
>       if (err >=3D 0) {
>               (...)
>       } else if (err !=3D -EINVAL && err !=3D -ENODATA) {
>               goto _return_fm_mac_free;
>       }
>
>       (...)
>
>       /* For compatibility, if pcs-handle-names is missing, we assume thi=
s
>        * phy is the first one in pcsphy-handle
>        */
>       err =3D of_property_match_string(mac_node, "pcs-handle-names", "sgm=
ii");
>       if (err =3D=3D -EINVAL || err =3D=3D -ENODATA)
>               pcs =3D memac_pcs_create(mac_node, 0); // code takes this b=
ranch
>       else if (err < 0)
>               goto _return_fm_mac_free;
>       else
>               pcs =3D memac_pcs_create(mac_node, err);
>
>       // A default PCS is created and saved in "pcs"
>
>       // This determination fails and mistakenly saves the default PCS
>       // memac->sgmii_pcs instead of memac->xfi_pcs, because at this
>       // stage, mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_10GBASER.
>       if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
>               memac->xfi_pcs =3D pcs;
>       else
>               memac->sgmii_pcs =3D pcs;
>
> In other words, in the absence of pcs-handle-names, the default
> xfi_pcs assignment logic only works when in the device tree we have
> PHY_INTERFACE_MODE_XGMII.
>
> By reversing the order between the fallback xfi_pcs assignment and the
> "xgmii" overwrite with "10gbase-r", we are able to support both values
> in the device tree, with identical behavior.
>
> Currently, it is impossible to make the s/xgmii/10gbase-r/ device tree
> conversion, because it would break forward compatibility (new device
> tree with old kernel). The only way to modify existing device trees to
> phy-interface-mode =3D "10gbase-r" is to fix stable kernels to accept thi=
s
> value and handle it properly.
>
> One reason why the conversion is desirable is because with pre-phylink
> kernels, the Aquantia PHY driver used to warn about the improper use
> of PHY_INTERFACE_MODE_XGMII [1]. It is best to have a single (latest)
> device tree that works with all supported stable kernel versions.
>
> Note that the blamed commit does not constitute a regression per se.
> Older stable kernels like 6.1 still do not work with "10gbase-r", but
> for a different reason. That is a battle for another time.
>
> [1] https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?u=
rl=3Dhttps%3a%2f%2flore.kernel.org%2fnetdev%2f20240214%2dls1046%2ddts%2duse=
%2d10gbase%2dr%2dv1%2d1%2d8c2d68547393%40concurrent%2drt.com%2f&umid=3D9e7e=
e942-44ce-4bdd-a3c5-0de04f0ee53f&auth=3Dd807158c60b7d2502abde8a2fc01f406629=
80862-d5a8b704cd04b796a2aa2a861dad36f29073bce5
>
> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../net/ethernet/freescale/fman/fman_memac.c   | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/n=
et/ethernet/freescale/fman/fman_memac.c
> index e30bf75b1d48..0996759907a8 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -1076,6 +1076,14 @@ int memac_initialization(struct mac_device *mac_de=
v,
>       unsigned long            capabilities;
>       unsigned long           *supported;
>
> +     /* The internal connection to the serdes is XGMII, but this isn't
> +      * really correct for the phy mode (which is the external connectio=
n).
> +      * However, this is how all older device trees say that they want
> +      * 10GBASE-R (aka XFI), so just convert it for them.
> +      */
> +     if (mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
> +             mac_dev->phy_if =3D PHY_INTERFACE_MODE_10GBASER;
> +
>       mac_dev->phylink_ops            =3D &memac_mac_ops;
>       mac_dev->set_promisc            =3D memac_set_promiscuous;
>       mac_dev->change_addr            =3D memac_modify_mac_address;
> @@ -1142,7 +1150,7 @@ int memac_initialization(struct mac_device *mac_dev=
,
>        * (and therefore that xfi_pcs cannot be set). If we are defaulting=
 to
>        * XGMII, assume this is for XFI. Otherwise, assume it is for SGMII=
.
>        */
> -     if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
> +     if (err && mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_10GBASER)
>               memac->xfi_pcs =3D pcs;
>       else
>               memac->sgmii_pcs =3D pcs;
> @@ -1156,14 +1164,6 @@ int memac_initialization(struct mac_device *mac_de=
v,
>               goto _return_fm_mac_free;
>       }
>
> -     /* The internal connection to the serdes is XGMII, but this isn't
> -      * really correct for the phy mode (which is the external connectio=
n).
> -      * However, this is how all older device trees say that they want
> -      * 10GBASE-R (aka XFI), so just convert it for them.
> -      */
> -     if (mac_dev->phy_if =3D=3D PHY_INTERFACE_MODE_XGMII)
> -             mac_dev->phy_if =3D PHY_INTERFACE_MODE_10GBASER;
> -
>       /* TODO: The following interface modes are supported by (some) hard=
ware
>        * but not by this driver:
>        * - 1000BASE-KX


Reviewed-by: Sean Anderson <sean.anderson@seco.com>

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

