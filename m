Return-Path: <linux-kernel+bounces-36160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51486839C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAB71F27616
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2AB57877;
	Tue, 23 Jan 2024 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="S/66t+jD";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="S/66t+jD"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7645579C;
	Tue, 23 Jan 2024 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.83
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706050311; cv=fail; b=K7/2Rci1fJGCZND2VMn9GVFjYBHHP7j6KCG0zTEqP7O9A+DqsRLVLHtj3DBSzkJttY9pd9lOoCAYPz9+AdEgjDuMw4CflI/jvlcH9BDI7TgNiImX5DxcRzDgi1ihkb5xlMP7U7InLlkyN89INyeg0c7ZepQLd9ZA0YX5ZdMUtGE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706050311; c=relaxed/simple;
	bh=bBFNxyKCqMbbqEC3lQqJ7YpRcDP93E+zGlTTHc6lDWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sWQlTq/urp5h1aUntj7G6u+1hmUEWtx5RiIMyTmzD3+oBtaozR6G53ATkVaE6N+l1yNoIHHdE5Jy8nlgiQNBbM37zvb+RzGX29RDlPccROQ+ts9fcrcFTAbVq24/gMzLhAUYSll5Q9mp54rzHTbAsyi9jU7nIy7EJ+62AiomfYc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=S/66t+jD; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=S/66t+jD; arc=fail smtp.client-ip=40.107.6.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Fzf56AtHV3LcVSlrjVXPysQMMKOdBr+QJiOtPPjBGwV0Z9oSwVQOJ5K5i5+vvlZa1MXhD2bvuRcAykhHwnznzcnXE6fXEVZU3A+KNxhI71AyPBEE55obpYPA6FbsL7o0yQtsuWpFHmK0bBy1lXJCVrVaJk1BbF092R604mKQLvvZQydQF2Ok+Wpdva1VZMPdK/D9fzmxgpXr27iHCTBjbh82itEJETnoXAs3rBlB3kHMNVrBVnbGQaBsZ4swFIqdzQ4oq/ZB3G9l4R3n4jKxM/gRA/7Kru6d2k1CVLv990qIOSuXTSW5x/YFWnzyWkje5qMJrEzswMunGxqAD/+eZg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8sybV/71v3h0YGhOB/V1pRtcF6A37dYKfB0RiFZMNY=;
 b=FCA91st7k2ilBGipZeYpSvbVzYJAAn3Z/baEZDhLnIkzUt9Qo9NUXZ6Wvaq56zpCqiOmOF9msYza8BHonnqqI3d1bE1AkD9TC9s4XKM8uwFuGlJ4mldYdcjL1OZEQubTpIfnOVE3lqAnkR6mEeo/L+7Lj4t9RpwYRyZ7gRItG0HvrmQSzVfhAsRR0SfCJZYU9tRgy+dfwlRkkNg9iT6RuQI4YhTyKdqLnysTbfHWRuu1zIEDxFAqW6Qm/zZKKFIPHaDXGzcOcxXOPOJQ1zDbQqN+oR6drmVo1QEWVjzvhVYpu9ZMiILZhFlSsAqIBLgF88fmTkjz45hkbsg9cO3A9w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=free.fr smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8sybV/71v3h0YGhOB/V1pRtcF6A37dYKfB0RiFZMNY=;
 b=S/66t+jDjch9O7FuSTeA4PPGC6S70crhSZkCic52TqpOTuqE26CQstqfwZgf15xwj9GiIECHMYml7u4hDrDOEiypuKp2UKVh5LKovMxbVqS+ZJqTdE1QJq8vV0aSlokqlBCNU7T9d6rAO7/ui6FZenUWYdT6JABRYxfxf3KIaaRfnLRPGE1QUAxYL6c+IXoBSiJEeo3s9NSdM1eyxK0OJHdExbaROqP0B1BEMLTNazHUJMKeX047uOMoTBjMeabh0ql6rArtB8YE9xUgE9x2uZOnOGj9dgczA8hQCzI5z+K200apYLtklAtJxds03n9oCZYmkjCM4LuiJHfpBxU2pw==
Received: from AM0PR02CA0200.eurprd02.prod.outlook.com (2603:10a6:20b:28f::7)
 by VI1PR03MB10158.eurprd03.prod.outlook.com (2603:10a6:800:1c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 22:51:45 +0000
Received: from VI1EUR05FT021.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:28f:cafe::bc) by AM0PR02CA0200.outlook.office365.com
 (2603:10a6:20b:28f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Tue, 23 Jan 2024 22:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 VI1EUR05FT021.mail.protection.outlook.com (10.233.243.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.20 via Frontend Transport; Tue, 23 Jan 2024 22:51:44 +0000
Received: from outmta (unknown [192.168.82.132])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 4359320083980;
	Tue, 23 Jan 2024 22:51:44 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.168])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 0BB1A2008006E;
	Tue, 23 Jan 2024 22:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiibGJKqFUQeWSx4ApiE5zFsSNuLdiZ2W3zGF1dTb8AzMShfyTVINE5ZhGVGflEV2b9GMra4O8Mg9MbtOTEQR/MzmBpb6B5a1SvPYbuWWMUg1c4XaYkReQo1Y0s9EsIR4au351edhPmTtdnaEXMXlnBrCco89jcqquThHFr32Ti7547H0Kf+MtrZwFN1a8ZI0U2PAERARlQzZRwS/yPXlluS503B/yNWOz/p8sSayAsUVHUaMz+D8+chSh2qDQWweyOXqle5SYoqJZyO0TKLA6pYh6M6Umlzv8P3H4Nt/sdYXsCo0BbWcJTaONCvf8VKoJHze72iwaDpAW5+vskHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8sybV/71v3h0YGhOB/V1pRtcF6A37dYKfB0RiFZMNY=;
 b=EmkPBTi61wv8XKZ4HpxOAKYRabu2vfEWsNvh+RnAF834G/9QAHyvq5RWPxpKWyQZQ5MAUntwPOfvk+5ZLp21fe42Tzieu8OqCzpg5oPkj4WSpyyeHpLaNtWLwUKtZh5rfayTrU+21aghwYHWg05sO/nBX3Kyi5znDAdn1yEetG56COiWw//RNG7DLYtD8WO8/A8ECuGLpIaZArBsjoyy5t8PzWNsX85Lco66GVza8vNXqNC4GZK7NDV4agOwTYLrdv7K5/u6q8tOpZfm4ku8uvMuff9mqYCZIRLSVmBZx5SIgTYYfnpFPQBh8z2McS/DeA0Y7umPqj2TmOvMY/bBWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8sybV/71v3h0YGhOB/V1pRtcF6A37dYKfB0RiFZMNY=;
 b=S/66t+jDjch9O7FuSTeA4PPGC6S70crhSZkCic52TqpOTuqE26CQstqfwZgf15xwj9GiIECHMYml7u4hDrDOEiypuKp2UKVh5LKovMxbVqS+ZJqTdE1QJq8vV0aSlokqlBCNU7T9d6rAO7/ui6FZenUWYdT6JABRYxfxf3KIaaRfnLRPGE1QUAxYL6c+IXoBSiJEeo3s9NSdM1eyxK0OJHdExbaROqP0B1BEMLTNazHUJMKeX047uOMoTBjMeabh0ql6rArtB8YE9xUgE9x2uZOnOGj9dgczA8hQCzI5z+K200apYLtklAtJxds03n9oCZYmkjCM4LuiJHfpBxU2pw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS2PR03MB9792.eurprd03.prod.outlook.com (2603:10a6:20b:608::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 22:51:39 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 22:51:39 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: Robert Jarzmik <robert.jarzmik@free.fr>,
	Felipe Balbi <balbi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Jules Maselbas <jmaselbas@kalray.eu>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 4/4] usb: phy: generic: Disable vbus on removal
Date: Tue, 23 Jan 2024 17:51:11 -0500
Message-Id: <20240123225111.1629405-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20240123225111.1629405-1-sean.anderson@seco.com>
References: <20240123225111.1629405-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0069.prod.exchangelabs.com
 (2603:10b6:208:25::46) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AS2PR03MB9792:EE_|VI1EUR05FT021:EE_|VI1PR03MB10158:EE_
X-MS-Office365-Filtering-Correlation-Id: e1505d66-841c-434e-bfd6-08dc1c65df7c
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 jeiQAm9Cw22zxl4morB+b3v6v2pYKm4QDWgqKfM0JCj6JRdfdDirgzb1iBkWq4gaeYH44wMaiR4hpY49Bx95xGTD8EgjKrulqXlnBMqCRV5l7+5GQpDVlDbXJRaGOMR8U+RU5ofEyqqCHNwBptNtn4w6TZkhd4baELQRcWQM4JepQl0v7gvSlbzr4CqwYMorGW6ixdtJZwLvQHRWJEGmdTXVuRkq6haSaWDw/r0cByDijF6QyVTxDMydZsDA/VdWbfI4DKvbPJJbSLtqzPGA1cnRQaQWua524TyphvMc7hlGNO9flycYxZXK/7ds2HyO9m9y6i3Gzthfi37MzQ6K0Uu8R5Rktpd8okAj79hgkoIglfVhBDnQXLelsS9f6Tu8fKMaAbfUgMzxu4s/3w1yG53uumCl4hdFVfjOE+f2tmCooYFLRF3C/S/CLdDT/Lk9VcGfMkqBDi723meMbkDdUQhzXDspNfthwyGwEnIhNFNnoK8gm/xzbTaHgQR/bB+I/2AZmUyWZ2ksTNgkamocUnBcTWHiKSGB4Ak8fof+V4ZlmiO8ZSv1fkGnwZF0TAy77scJs+z5GvGWjlSPyowb5T65R4iy7kBNNkRHwJrowBcYtn1PBnfUjO/M/Pn/LQbb8ud1hR1MwzIavA17hhCVrMnVpJL/ay7wGg/UIRNAL48=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(38350700005)(66556008)(86362001)(66476007)(54906003)(107886003)(316002)(36756003)(2616005)(41300700001)(66946007)(6512007)(52116002)(4326008)(8936002)(38100700002)(1076003)(26005)(8676002)(2906002)(4744005)(5660300002)(6506007)(44832011)(478600001)(6486002)(41533002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9792
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 VI1EUR05FT021.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7cb7f4ee-d894-43d0-87ce-08dc1c65dc5f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NnWS9/ePXecFS9sRobzscrObhZnwx2gU36/+KanCQOVyGedAShvDjGeo+QWPjL+s/GlUXnxshHn5Os1y9zjpjyfxQqpm2DVdnRuAFuTb63A7w6V/TbLlAeWL5X0RlazFl06coNQ1Y5duO6mo3n8rYAbrwFOVi+9sA2T2Beui5jUFvTWaxiCLRWXGh7DBfjbE/oo6B+0lTK8NXvbcHRvw6sm9X5j0mwn/YzXLQrYcpRS+6cDw2Inj6pinBhJoeAiuponTDLYLiF5CRYSW30GdNvN8PK2kucGkZCmmYdxKYkfKOmUckiINNgbuiNOSFX5lMWsfKE6KYk8jfpvEPzjhJRACyfu3h3L/Cpq0motVHkS60Nu3Qvd3Q7zRCDRvLFxykf3NsfyTTJFPmm+4+4IZFj3VChEy0C+j9ujOBkpjiD03F3QIB4FY/5GuKc4yk15ZkLlib/YKzjTItOplpx2a49AUmNsHqwGTAAFxURSfFO/3oa9IyAij5dVpfs9PDTHKG6HK9RCW+7/EvYw4D2AYzqunHJxfuR7FqxEYNHI/TJeXmQwinkaMBDAtu4yIfqCTjV732j8evd58h1JbQaB2yD637e+xT1got7R77p0vd5ne83NyUFKGOu1uQSCvVoGCTYu3gk7+burjv7GMpKgemtpbV4hLpbGo5eW0STgZSisCgJtG8gWFqR+B3HfH08sJNoQlnJOGWcMkoR+CzsuMCWIdjAzztf3UlSucdm0D0jfQabTWIXxRN0H3RfJlmRxbajdnBLd6i4gkKV6h0lVKlw4iCZlWipAOXybbd/QMa5g=
X-Forefront-Antispam-Report:
	CIP:20.160.56.85;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(36840700001)(46966006)(40480700001)(2616005)(5660300002)(1076003)(8676002)(6486002)(4326008)(336012)(6512007)(44832011)(8936002)(47076005)(316002)(6666004)(6506007)(54906003)(70206006)(70586007)(478600001)(26005)(107886003)(34070700002)(36860700001)(356005)(7636003)(82740400003)(7596003)(4744005)(2906002)(36756003)(41300700001)(86362001)(41533002)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 22:51:44.5755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1505d66-841c-434e-bfd6-08dc1c65df7c
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.85];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT021.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB10158

If we enabled vbus, we need to balance that with a disable.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 drivers/usb/phy/phy-generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index f7db24b5ed5c..8f735a86cd19 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -337,6 +337,9 @@ static void usb_phy_generic_remove(struct platform_device *pdev)
 	struct usb_phy_generic *nop = platform_get_drvdata(pdev);
 
 	usb_remove_phy(&nop->phy);
+
+	if (nop->vbus_draw && nop->vbus_draw_enabled)
+		regulator_disable(nop->vbus_draw);
 }
 
 static const struct of_device_id nop_xceiv_dt_ids[] = {
-- 
2.35.1.1320.gc452695387.dirty


