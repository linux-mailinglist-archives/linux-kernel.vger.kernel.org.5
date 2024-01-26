Return-Path: <linux-kernel+bounces-40783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C883E5A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99161F2523F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1042286B8;
	Fri, 26 Jan 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="xao/8eP4";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="xao/8eP4"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F90725578;
	Fri, 26 Jan 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.53
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308725; cv=fail; b=NjknK2ToqgZuNSaR1/BMNREzEcO03iQKhaf1gk1rmZvoO3TGU1Vympvk5C8dhyOPQRlEUCiHuuh5QnM3BTWrcEN65rf8DWqJQxYwMpOEuc3M8vwpB+8ktlPNNtRGkxfDWXCm4fjTD6XDBMWBFvzGxwvV4iJo8BHqm402M315LKU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308725; c=relaxed/simple;
	bh=1bJKzaNJS0w1mkVyAW8oL8w3odmA+aB5Gq32VLY04vU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HmhAUhvoTJuqcJvb9AUa+rBol3GOAkPHqUzZfe+kGINHU9Ofr9Gm54YGWCLt1sIMbaSLG1vQOpK5uhC6btuWWv+7ngGvsmbxcmmaEVzCK7H6QB5Eee1gFIpAvAkTURXzo1WTy8HGA9rKkAOLtG4RBCdGw5Cyiru90TYT0IrxgY4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=xao/8eP4; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=xao/8eP4; arc=fail smtp.client-ip=40.107.8.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ZdmgdV65sOFrBKRkPOScWVzUp6ilHC6Le/r/4TJ+C9CJznQ+gqLF2dt5TYNHQu04DSKOYj+iMvjkXsUl6RUE1xI+pMzUMnjRuTC6mudKfPrcBXOQJ+48Gos8ciXbOjbM2wyjtrE6qGPrL0YxmYHBEPTI2fdsS064Zbnxo7d/ZnTahxX5NATK0lDtZjIcE9bO6jvMCfdU1kFAZYBsf19uOG+qLQb0PfeQOSWuYsyPV1bxYHon+woAq0Fec0VQlMJ3y/fHXCUr7GOCUFMiJKrsJLPrFCepCtzjyCT554TRF1MglOhKlcJq10Kg4PP/1Zd+9N0oZtmYX7RI6Be7i3dzLg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqYKQo1O2qLaTicxBWm6ZJFs4mZbq7Esv6ooUQe6cIQ=;
 b=Iha8esjEel/qEJYWoKjuPDpxQ8p8noIarnlOq9fHCeinCffWZz2RXUuMy5RbOYQQvLALGzAe5LTsFG6XYFm79H6mpp2A0hFYdwvxXAS46JiLkDbGFnkiAEKZQQjmZ0YZt3Au0cjNFhCQVqq0kYZsc07l0o/pCX60oJgRzwpC504/76f+QOfiY2GDLTBMiPUNZ1KuUUx6zUE049afKCG5DFZGVxbb+jtx/zgnDL54+cD2Qz2V44jgY82vwdPfk0V0ACxhux7g0ieUYtw29Xg6epzGr/2iMj3hcG7Ta5pUh0T6V2YEXY6F3mutDVDBxEmw3IGBEd+J9TQtAS/E07m1Jg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqYKQo1O2qLaTicxBWm6ZJFs4mZbq7Esv6ooUQe6cIQ=;
 b=xao/8eP4jBUF4pn3/lqA0nBUZ3ipBwcz9vwqP7UO7lHi3Itj2VKWTloqKAHHb7Kig7mTcoFHPu/d9w2c3tEvZ/xG3NBix9X/Hr94yYFCoL9/cRALUM8a2Q/moUldH2NhaX/o+E97LSvXEMedygc1OspUQTpYFI42TWdNVe+Dl2Aq71+1Tw4JjNwUlBbUU5wBtkXSN+59zQ8iiWWVw+5PxY7bxt6xWkVb3qUZ87E5ffJAMi/zb/dQ+FfI/K8Ni/OI9OILrltO/VqSnmRp2TT02n3m4lNYx6oB5CxW503XxaOKQnPVryWd7Vq/4I4inlCUTc4guCdtanzjwd50+AM3Bw==
Received: from DB9PR06CA0003.eurprd06.prod.outlook.com (2603:10a6:10:1db::8)
 by AM9PR03MB7138.eurprd03.prod.outlook.com (2603:10a6:20b:2d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Fri, 26 Jan
 2024 22:38:26 +0000
Received: from DB8EUR05FT061.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::61) by DB9PR06CA0003.outlook.office365.com
 (2603:10a6:10:1db::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 22:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 DB8EUR05FT061.mail.protection.outlook.com (10.233.238.67) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7249.15 via
 Frontend Transport; Fri, 26 Jan 2024 22:38:26 +0000
Received: from outmta (unknown [192.168.82.132])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id B0C4920083980;
	Fri, 26 Jan 2024 22:38:25 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (unknown [104.47.1.51])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 2A19C2008006F;
	Fri, 26 Jan 2024 22:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KchaglORP0lW2C6AfFseE5ykWCsVWOown1HFRw1IkpXYdnZuoLCN66j3D+lECeTKHnZjkrAFs9Bt4sPSLTR8iDudk0fJb+6hE0YDYwZPLnrFgmoUGMkCx/Ikd3PaIz+mIUwx54QOvJgi8hvwKL7iMb6Q7BgdoOEpCkHYk+91IhH4Nf2DmF5EpG/wguzA875SPe/rZqWUeophGsClr6igIVFA3jJMUFgYTROwawd5M9wudbwoOQr1hAdMitlbOtKAFX+cfiesv7n6JQgJN1lz8AcX6u9lvQg4046gM/IhDb9ISBnJzbxAT+O8PF2KSMkBslmslD64JBsRFZL41EhPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqYKQo1O2qLaTicxBWm6ZJFs4mZbq7Esv6ooUQe6cIQ=;
 b=FDdAISGk4iJEkA+f9X/kkDU7DftY5uuM/zeiri39TkDsvAPVjWvdUP2oi7nq0E35uvrRO/16sWtklRK3y33c60klQTRCYdLdPa+pSfrpyI617Y/MkDdBULaSnRmakQK+gsenft44QUARRmf7I/jdtaC5uk9ZQ2WJylXxonaznYa/wvcFZ1zXy4wO/ed29fXaD8l0XUgaP1BqWE0qjsgrhLOeVL07/3eVKMk72NViLJje229x3Zls4ejauqQh/Lz6X2J7UF/fLR6ewu9cDhzSXbbDgNFDA0uFFByqeYknOwubnYue8S0lOtWxGw8FWVI07+kPjKaXR0LAGZUYSQtxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqYKQo1O2qLaTicxBWm6ZJFs4mZbq7Esv6ooUQe6cIQ=;
 b=xao/8eP4jBUF4pn3/lqA0nBUZ3ipBwcz9vwqP7UO7lHi3Itj2VKWTloqKAHHb7Kig7mTcoFHPu/d9w2c3tEvZ/xG3NBix9X/Hr94yYFCoL9/cRALUM8a2Q/moUldH2NhaX/o+E97LSvXEMedygc1OspUQTpYFI42TWdNVe+Dl2Aq71+1Tw4JjNwUlBbUU5wBtkXSN+59zQ8iiWWVw+5PxY7bxt6xWkVb3qUZ87E5ffJAMi/zb/dQ+FfI/K8Ni/OI9OILrltO/VqSnmRp2TT02n3m4lNYx6oB5CxW503XxaOKQnPVryWd7Vq/4I4inlCUTc4guCdtanzjwd50+AM3Bw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM9PR03MB7425.eurprd03.prod.outlook.com (2603:10a6:20b:260::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Fri, 26 Jan
 2024 22:38:14 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 22:38:14 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sean Anderson <sean.anderson@seco.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: ulpi: Fix debugfs directory leak
Date: Fri, 26 Jan 2024 17:38:00 -0500
Message-Id: <20240126223800.2864613-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0445.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::30) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AM9PR03MB7425:EE_|DB8EUR05FT061:EE_|AM9PR03MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b47a90-49bb-42cd-c81c-08dc1ebf82e2
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 YHHHImnzVxeQcuXI1jQ4/GSf/bEjoHQ8YptpxYD0L743zUBlWNO0/XukgHZCKTlwS5GdGwS8Kzim8hGzpnT2HPv8J3JCD4UOPq3hswPv0U+h7s+2Vi/+N0VkwdTZ26hY0Xg3ASPf3dPBC6HOHSuQbIuPNWonmrM/W8ouUumQm+EoC9uGwb+BPeLgf8vHM3WgIxzklPY0mnv7s4UzH1T2yiALfy07D3eKnyhdSJtAOhyERHUIX7i+xWKP7NUCC2Vtqxj6lGKjqMlK3LA3M4vAk0BbPAXP3nQ94Fjjs2bpW6k4MF1tZdtqz1IxfYYO79Lnx+LEUlVwGjAj3Aw5eKAXlpBG9JDi2kaZv4jr0GgtzWx4v2J7LhjOB2AtU1MNVItwcmkFhl0hnPRpQuN44LtVY7g9F6G8haWFbCTeJg7pe6qRUXgZEYS7vQpLOXQlEN3Ma2gihE3lag8wD78S3TJ46i+G9FOu7jO+4nf8OVWi5GadfIUwm0uFoKat9zSBH8K6lJMID5q2dU7PHjjZ048rZWsFvtc47gbhugcTtG7+QTYsOjYR66AuA7jHMXulLbfUpctugsKV0fVzZz+lVnSbiLdKC4lYMOteV20mlgeJhMacXr8hI0jRl2qbVMuDQOWX
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(376002)(346002)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(316002)(2616005)(83380400001)(6512007)(6506007)(66476007)(66946007)(54906003)(66556008)(44832011)(8936002)(8676002)(38100700002)(478600001)(6486002)(52116002)(26005)(1076003)(4326008)(6666004)(5660300002)(2906002)(38350700005)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7425
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB8EUR05FT061.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	721fcd4f-30b9-4358-820f-08dc1ebf7bca
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2l3PxEBGzJSabtaQJ5LiltkkKOZAxDwSjIzUXSWjcAAAfraPCi+QD7G6rgRuHAAa8l6/ULgl4RSFx7uVl7Ds+Tae4GC8K6Gbv8w2j3wSJEFI5czpkAdIGXBMfJ7QoXzt4oA+HtEIwibuNbWV7l5lLYraS8J7VQFYMC7I+oWuCOeuDfdjsSSKiQKuah6xC99w14mXpm6P7RW6DGB0YQhSfFACZJDVaw6/8S/7QAB1xkCjqWgSO9mw6ev0yAYjAg0SALZx0s7YoyoQCOmlbhVWGvw9UY13lCJmxqcMRRMPPcKQr06BcEhVuhqI6DNljVZM4Yu2mh2cd7TuoEUUfDxIEIQmK7vA7fd8+UgVRn6UyQZmcT1Lk95gs6xyQMlT+kRArXPEWU2phW6UjXQBgTeGVKu6j6XWNChmBAU6GbFRePE8iU9i+yEP8zPm250BY8giRmJQEtFaqkAhExxJuNx1OG2d7wPotHN4LehoWqdkKi72qFh6pm84FEb/ZAdblblNwUt5oPIvSR4rJVotpUFl+pfwg0Bomx8up4VXKFfFf0Yly18Oy/7jzBzzFInRaoO+DoIbvzGfXx989XshahV4X0soXrMSXVZDr7453VIEtn1uE1isQNZ1qYxmGI/mYztIt//6RNsdY9hu5VeVrvB5zGpQ1FgYYsN7NlrZLdLhOCUG39lVxoiFUuWOkhztL7TqX9vR/XCFcGm0sDiUpsYTHKXE8S7KviIfAI1CV4yt7kaF+zojhxjyE9LQtOHNKWa0Gz3YQsHv8qcgMYIclazDQg==
X-Forefront-Antispam-Report:
	CIP:20.160.56.80;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(2906002)(36756003)(41300700001)(86362001)(83380400001)(70206006)(70586007)(316002)(54906003)(47076005)(478600001)(6512007)(40480700001)(40460700003)(6486002)(6666004)(6506007)(336012)(2616005)(1076003)(26005)(44832011)(34070700002)(5660300002)(356005)(7596003)(7636003)(82740400003)(8676002)(36860700001)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:38:26.2473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b47a90-49bb-42cd-c81c-08dc1ebf82e2
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.80];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB8EUR05FT061.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7138

The ULPI per-device debugfs root is named after the ulpi device's
parent, but ulpi_unregister_interface tries to remove a debugfs
directory named after the ulpi device itself. This results in the
directory sticking around and preventing subsequent (deferred) probes
from succeeding. Change the directory name to match the ulpi device.

Fixes: bd0a0a024f2a ("usb: ulpi: Add debugfs support")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/usb/common/ulpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 84d91b1c1eed..0886b19d2e1c 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -301,7 +301,7 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 		return ret;
 	}
 
-	root = debugfs_create_dir(dev_name(dev), ulpi_root);
+	root = debugfs_create_dir(dev_name(&ulpi->dev), ulpi_root);
 	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_fops);
 
 	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
-- 
2.35.1.1320.gc452695387.dirty


