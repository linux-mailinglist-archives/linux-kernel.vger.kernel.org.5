Return-Path: <linux-kernel+bounces-103565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED0087C130
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A44A1C221B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2790D73529;
	Thu, 14 Mar 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="2h36S4Gq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="b42JF63e"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2107.outbound.protection.outlook.com [40.107.13.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376E399;
	Thu, 14 Mar 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.107
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433381; cv=fail; b=ZM1Ers0Htw5P7mFNgoFPyo3yj9sUwpo+z4ntOTGCFWUfb2+QBH38DMa+HeWNQetuFUBwK6ZoPidcKM7LcQvymhw4xygv1k+dvhesKjD7E8WPTWfJXMRSnmrOBgOfQPm3WTuTgP6L8ekQb1IxAOuXUreVrdHECHErXUgHInVkgh0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433381; c=relaxed/simple;
	bh=g3f2NaiyVuZr5Ph5BA2T+mGN5LVrfQTS4AfQWSLE9tk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dzBVOG7hH/IYVzwiwXE3mkkJfpB8fzHLaS1PNlZ8qgc9NkNm1l1le8fgbLvrJT5K3UITRbsxisBOcvHwlYXq4yToey8uBBOPQqkNvmkPQWFocuXf9aTAZm5xnG3n74sIiERpy+PnK56pip59pmAtsA+NavSf9II0Bsm1CHCfAdw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=2h36S4Gq; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=b42JF63e reason="signature verification failed"; arc=fail smtp.client-ip=40.107.13.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=BURxQny/cQW/xMmCAe1u8nqheQwQ8wDIF5c8liut+iazWFlsi7j2ZPF3YRkeLB7jHzak05WlkoWSf8e2+1rCR7kCtShq+m2KCozatSUiEuJqWqR3p0UrbaLxBuQ1ca2EefYUi1l5DCbU2kKIWCv/TMI74ZwM/Le6evDYkbD96LRx2m9GSN1zLk0o3LVtofObAa/rfYfWZ2WV46PVAX+EUdt/BKIPw8AMIE8wl2wA/xNpMtoQHmWvjhjgPtu4Hi59F4Di1mbpdaqZhxMobY1R0k3K+NQCJV4/y+3ZCkjxq1CGGWX8h0l/oZj15zn/zXZGTrNynOPL98YNYL/aHBAfXA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhYS9eW5hG89Yt6igIciCDh5/yIQXHAmOD3FOpUmuPs=;
 b=Zt70uL55dxnMzhiHRONDkw2UacTgg9IskBrdaOKwkGR7TxbzbgrMnX/h9KIt8L+chKB5IRD3S8AYNzfnEbuLGQD9n6JAemKCw0WkIhT6TWagkxOqGCKTuzc1itOdLc5P+OjrK3Fe63SI0TPxE6SjaahCqyceDQJDIYE9cNkOaBOGFj0C2ig9i31hQoQLSR6GyR0GV1srLbG10V+n+GP9HLrkrtk6oE1zfrX6qQJU9I6nlZtpQEPc+QlK5q4/EKUNHTg5o2hR6mY1CviPnPOAa3lpCT/QXcVy2NljGNCrwW+5Tfq3Cl7IMVLnnG1sGcImswaOhElfrx8Nv1IGUo6e4w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.83) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhYS9eW5hG89Yt6igIciCDh5/yIQXHAmOD3FOpUmuPs=;
 b=2h36S4GqrR/9ASFRREZSQlHzjXjV69NhcuayEE4IwSu95Xx3UXIVjGl3MhPz1IkNaxsuj9GGzcVvlkBsRs/+/pATMiI+wLHU1EGM1kAaJ21RA3O0Hgp/MYJhBmgbBd09V7HZ8dZyaRC5TrAZXEH1k/Hb62Ctz8TysYWGOVDXostkq3EVt1xqXJgoUExBqHPI9aNkbFPiRpzbkkT8nwa3IlObvasT/muYDIvQ5mEuX8BhyF5OUbG3k3CwSaweFnXQxz/xfFZy9XMH2iYS1Yhg/Rt/gKtPUFVy5LemH2e+NDA6bMWBulj5haM4cZk8KHAHOV7nJ3QI1FGHTEmIO2GsWQ==
Received: from DB7PR03CA0083.eurprd03.prod.outlook.com (2603:10a6:10:72::24)
 by DBBPR03MB10365.eurprd03.prod.outlook.com (2603:10a6:10:52a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 16:22:53 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:72:cafe::1c) by DB7PR03CA0083.outlook.office365.com
 (2603:10a6:10:72::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Thu, 14 Mar 2024 16:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.83)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.83; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.83) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 16:22:53 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id E44472008009E;
	Thu, 14 Mar 2024 16:22:52 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown [104.47.13.50])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 584D220080074;
	Thu, 14 Mar 2024 16:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHY32xXkhhO9/D+qGddWJnYHrLP/nPLQQfTgtalIpfr06zAjJnAQL6CHuszPR/9Ipxavm2sFig894K8CpmxV82OBiHOUUKtZUBB5Q1M8XWgkKV7/MrM9UKw2Ofhfuxkj+E9GPXC7HuRxiY+Sx9D/uikCZfOsQicX3TBOtI8EDd17fT0drOX/hgCCrVy5lt26h4lmNlNGQ3bcb6z/GG9BFlxAGh2aOrfb/sQk7L3AEytqECXoeOQDl5T4YT9OSfiVpJulVRsD3kJug+XlNvxwZNS/2b8I8AVO1QPEZ3zBprsX/UBgv8C8A/JKhqG5J5FhOtZ7vMsTgQdGpelHwL+PlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcsScjtATJLnNUfnsLVb/9f+kk/tGc2LdtwyXZWMuWI=;
 b=bd5j34VwKpzV9OP62ZyKjuaa3gCE9kuJdxlX680+Wz98vZTGq0wxEfoX03bYzA8CWBh8kBoTW98Vpyh43wFqp1pA1yK68j1tvUftE2bh8cUmm3jysofruX8w1QXuFlnMHvN3LkrcmgjyVptn46y3j8R8tzBifKTZlGzoYZZN/irbU/1nynwaI6uQG0qTx2RzeHBliTMj0OUhk6z4n+KVGAjRjyT3dG0REHevOdVRR8TCClGKxE76+RJbMKu+igiVO7qqdpLnqvuwGT16Nm1RIH0HDoHSWiagGR0mG6QbQPmQHZVRzaxhOMG1mTDNEnpqafd3xzXp7LfLzhpeC48EoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcsScjtATJLnNUfnsLVb/9f+kk/tGc2LdtwyXZWMuWI=;
 b=b42JF63e63xr0l64uWW8gvEwuMSBrKw0+E01Qxxypiv8Aba3KV7x2sVktflAZ9k1DROaYjEeDY8aOZJh7wC1V1gLgfuwrnjv36l6XXe2QNhIJtyK7LJr/WWeATlrKcVhDMLQRX7589fVZzr04NqSCBgbPi4M9qaJjgOLKdG1py/XHD+x/gksK3QE+Fi5WGREX0gTZDkO0BGiVh/13FpYkBAH1IRCcTZXkLFTBuM4MdE3ydmjWpShzh5ZXjHu8pNQMlzCEEVOJLQu7BHhG7g1qfQnkaO5YQwn5vYa341/HMxpz509TF0MuynWjoT1Jxm2YTAEq3XNXRM7rerugiaw4g==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB7533.eurprd03.prod.outlook.com (2603:10a6:10:2ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 16:22:49 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554%7]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 16:22:48 +0000
Message-ID: <9ac89506-a023-412c-9e7e-49aa515aee86@seco.com>
Date: Thu, 14 Mar 2024 12:22:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 usb-next] Revert "usb: phy: generic: Get the vbus
 supply"
Content-Language: en-US
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240314092628.1869414-1-alexander.stein@ew.tq-group.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240314092628.1869414-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|DB9PR03MB7533:EE_|DU6PEPF0000B622:EE_|DBBPR03MB10365:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d43de65-dcdc-46e6-6b71-08dc4442fff2
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 naCSPlPYq3HYfX4D2b4ULNK3wfNFNjKU8WgwPfew07qogBMzRgSPmLZG4oPAByBxhRv1cRkpwFnxq90bxKYYnfau9RIIlQ7ejTqr4Hr9Fp4nTae+/W+pB6c208lH9ae07vGTCdfcu9xa+6/FSArF170jz5NSc6QZqvIMevzDkw5yPoiQGDjSef1trcCFf66iXrzj6WOB5XTBb6DxGFZ9BkiO7a1MeXEl/Zb5DpHL/h8VlA6AGDH3+tvJMAnjMQsVpUwplOjcprtvVnT44RAIOaWMN/iUgwQ5V2vUPNcz/U8OWiOJyn9C+sk8h3tdJK1nLw5WGeAXpD4VDh9SwVRW1cbwovLvqzKccfu1RzxGWvQBx8yeXoYP4l2FSVOX2w31pNQs/XWOgUZhDVHGZ295US7tu6OmS4/sO27ufZIHk5bujXRR0mwY9ox7+KPnHlgS5I7Gb9yEjRHJTtF9wvzCidLhAuLb7/eejsIXuGEigMoRxKrprIwOrjfAiKyNQvAiuwUfKzaBuDGGRqs0sk6RLdLBRwfbRVE53F5J2w+bdqFPNanEfhBfrkHqwswd2BGEzl7dovQ4O9QFy/XZepXLG3edRmPyt3LPPY+/pY/j4c2B4O9F+QoTr/6Po1UiLcrY8YjArItcRJnoy3Iaoxw118OlW17QKe7x9dJBFr4jBWo=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7533
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9149dde1-8cec-40ed-2494-08dc4442fd3a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6+S0eIu+HaN030lx97ZTYfKLTAFQLeHMD45VCUy9QDuTp87zuYhUrlnGUMXX+37DmTC8IC4XrFBNyb58T2/Fgl0CVEJwRg4hrmFRvq6NFFNEPqJZk5mfxQN9AmUvwKCwo2BnCc3xqFgbl0mFKJEgn+wN38RUbVssmhUjYjorS3lAwKbDHyqgXRtH1QTNCW5Lniy9wfT+9t/Ga+t3i/5V3vK1Ck+cNj4fi5WIUrkdS7LKFO5+p91dzlzvHzRPTrdGt3VXUDvCLf/6zWMxbxvdAb5dB0uPxy98LBZRDa4A17CpA8cTK81sE94iGYnKohPC/JOgFnrIlVfjpeyyPWg2E0h78OAMc4xosP869cJzyY6vKXpE2FwZmI7mm5w8ECqz2j7tIq3cUzHavd4iO+sbUZxD6SsPtTVsxUz1OqTWbhIkk8chWckixiq4+ArPgNkZq2ao25cBpOSw8nyJlV9hBCRQv+sEeyoipo2pCh+VFWD8vWVP+YCjcfOM0KA8EFcpZvBTGj8a5LbWNpiUcUjFWTYYWG8rkIpMA2FAdgPJK6YFYTMm26ZEFJ7yGxuCq2qtUWVz2ilQO31h7fq+vtrLeYtrCreKuajGsVCI/1O4YDiUxbFzfPfGEcy/p5W/q+6RW8ptqVZ3UO9ix8NlyQnZ3bpfXIF07b7KkaCKZ0N7ggql0jgM2nDV7fizpv9/is4FbEiKLtwHp2Twgda55sDxjw==
X-Forefront-Antispam-Report:
	CIP:20.160.56.83;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 16:22:53.1750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d43de65-dcdc-46e6-6b71-08dc4442fff2
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.83];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB10365

On 3/14/24 05:26, Alexander Stein wrote:
> This reverts commit 75fd6485cccef269ac9eb3b71cf56753341195ef.
> This patch was applied twice by accident, causing probe failures.
> Revert the accident.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> See [1] for details. This applies only to usb-next.
>
> [1] https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?u=
rl=3Dhttps%3a%2f%2flore.kernel.org%2flinux%2dusb%2f3469745.QJadu78ljV%40ste=
ina%2dw%2f&umid=3D6ce55218-6f2d-4fef-81fd-77cdf23523ad&auth=3Dd807158c60b7d=
2502abde8a2fc01f40662980862-4b6d276f4d42a6c6c8fc7d375bba2e12c5da85fa
>
>  drivers/usb/phy/phy-generic.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.=
c
> index 8f735a86cd19..fdcffebf415c 100644
> --- a/drivers/usb/phy/phy-generic.c
> +++ b/drivers/usb/phy/phy-generic.c
> @@ -262,13 +262,6 @@ int usb_phy_gen_create_phy(struct device *dev, struc=
t usb_phy_generic *nop)
>               return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
>                                    "could not get vbus regulator\n");
>
> -     nop->vbus_draw =3D devm_regulator_get_exclusive(dev, "vbus");
> -     if (PTR_ERR(nop->vbus_draw) =3D=3D -ENODEV)
> -             nop->vbus_draw =3D NULL;
> -     if (IS_ERR(nop->vbus_draw))
> -             return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
> -                                  "could not get vbus regulator\n");
> -
>       nop->dev                =3D dev;
>       nop->phy.dev            =3D nop->dev;
>       nop->phy.label          =3D "nop-xceiv";

Reviewed-by: Sean Anderson <sean.anderson@seco.com>

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

