Return-Path: <linux-kernel+bounces-43065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76C9840B24
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0E0287E57
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE0315696D;
	Mon, 29 Jan 2024 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="TfFovYNk";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="TfFovYNk"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC0155A56;
	Mon, 29 Jan 2024 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545116; cv=fail; b=bne1y3lNGjyuRT5TRI4rX0K1403QfgMDaqPbUH0tRNMt+JnWUkEl+E1IJA9fsgT7iCZntliXS3x4i8yYKefDbxL1qEQK97N1S6i0lt8Q2KFu7bt1cNgKbFEzWdxw3dYEreJVgioFaNXB/QjNz8A/LKGUWk7+JVWB4YeEUAdUcxM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545116; c=relaxed/simple;
	bh=ZhYfVJaj0bVNCYUOzSDDar254l9B2Y7mghmP48PXCJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P+XI48lexG1gjxw7D08dsofL2RMlFL7MenPhK+XZNaPFL26AbpRQmu6RZuAaq3IbWvXw5TOdNqosU5XcF96R3MQSWzvV0u3tLq3wUqGmjLb0GRQ/y3wPM+DcE7uCtTRTEuZxK3mVLJeP615i9RS637DnD/mj1ni7uYenfuJqOmk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=TfFovYNk; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=TfFovYNk; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=CMHANFknTmGy8vlC4xs5nLNQ8RgSODIGHiG2HF6xwNGUHndN6tzCk1IaOG171jE6wE56VVVainiq0t1tcuI0EDqzNmjZyqrpvSxdxtg7UUEecstFyQIiBPZNHq0LADAE6mRCVvs3N/zIPOYIVawmN7bnh+ckiYZEo5ZvaZSpky57c4CFGrxAsJArq/UkG1mQSXlkceBhGquY7e2bJkfkivqOoiyz15HdMmQg1stAmmqz+8r4M9G+uSySTnEtPQsboi7BN4T1LmYMwtV/PGt5pIju4EJlRYLT36+W34QAk44tm2Vhpg1KU972DvIfwgGgC3XFkolE57/S2eegucLlcg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFFH4KCMg9RpZ7zle6CGngr3ZER9IM289PQclcW1c9g=;
 b=I/YYAdBrMDGnnKSWHzqtQBf42HmOUUCM9RqLo9Nx9riWQXmA8obqx2RleNOOL4Fyrjv6mS0GhgvbjQg+NETM1CNgnUwKS1AsdFRO/J1L6DWb92jCRTYNmriqr8ELqiuGJzeQJgeMtWs2NQ1JaAaNnWr4AqcLmXHQK/NKhdwSYwadTdyMtwjJmSXla+vc2R8YcyAyc//5LiyrxlZj6YYfZrYKuM+GTVjSyRKDgY1/lQnBZwlGs2Uiiu1LUj4D8YQatFChsiE3NemPgdk6A+e9IFniYmB/hflT2OpKbv5cpd4R7bFiHm+LuyOhPYafIFD0369nl0Y/+XlaqWJozoeQEQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=free.fr smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFFH4KCMg9RpZ7zle6CGngr3ZER9IM289PQclcW1c9g=;
 b=TfFovYNkuLIF2XTxoR88WsByXCAVHd2zCNWwJ9tDD5dChCi5rlgmX81zFLoUfHoHkuXV8/cHn96mMwq3GKKCu+86vvgrL2zbvyyRk19Qwh/X98rECsIWgbmtzvtpbVeNz47zkQPpkdcmuWAvF8fsHnS0iVnlzEV0kunQ7XSss3IlcawGWHz6s7bRsirJxSPBP3PhITIygTxVJSVQ/QqbgNotvQjsto+ZkqhUx5yKSBEPLjTnPyJ7qw2rkOHfunrYFSFIhX9z1i1Hltdyjy3R9GeF/ndg7TyPVvlOva9NV1PvMX+uj3yPjnuQPGpMftH7ic8du72LwiZn7dNJz2JBpg==
Received: from DB8P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::22)
 by VI1PR03MB6495.eurprd03.prod.outlook.com (2603:10a6:800:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 16:18:27 +0000
Received: from DB8EUR05FT024.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:130:cafe::c6) by DB8P191CA0012.outlook.office365.com
 (2603:10a6:10:130::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32 via Frontend
 Transport; Mon, 29 Jan 2024 16:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 DB8EUR05FT024.mail.protection.outlook.com (10.233.239.191) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7249.20
 via Frontend Transport; Mon, 29 Jan 2024 16:18:27 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id DD71220080F8A;
	Mon, 29 Jan 2024 16:18:26 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.104])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 0072F2008006F;
	Mon, 29 Jan 2024 16:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYmYJOUo0VbilvJVoBpZLTULezmBmkEeeq7bXA6FLIOSxxqLKvpLeVf9FPVEmvYsPh/ooIZTGFxLkRCQ8K699Hn5WDj/Pa6DV1yuB4mh4bGn22ZZdL1ZEDh6/D2GtK0pmJ5sYSzgo3ZbXUXkIb8HG9chIrUtM9nuzEgmjXOJzf/wiuxfO0oUHEVU8sd70YI7ZbQ0oe6TL9cRjDeEyAoeaj5BV0HgEJ03UcH9hdj6kVd6h4wmVqGqXqOSZ7ZkueFTDm5w2zRVL5uAbgeaWDTlZTpOTTWN+668xgCQqZuWiF39e79l4J99HLSug42dUnOqb2SKrznoEXvEuIlPX+C6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFFH4KCMg9RpZ7zle6CGngr3ZER9IM289PQclcW1c9g=;
 b=QgpupWpPZPXRN08BHUiQZmRLJEkNQouV5zLxUX7mcC6aYLvNAnfWcZxuU1SLhwKxA5PraV9KBxCqWMmyf76fnGLLEqItXcGEXFiVBZHWfhISsdb32rmcO5ZHhl94XFq2p/5oJ72SsEE1Rcqzn2OKZQ0RAwVU7bGFit+A8PG7P+2BV0CgWcwMeZISj7oTy50B2eaYPfTP4Kib1JudP14bfSa5pRSERlD9G7t2LvgzKlu5BA4itP7nxmz9l0cCUQ5q3GyC9LzZqoPpjgRCr1rdml0sE7IfeF9whkRKEY9lF1Hgfa95Aj+Yi9f1949P+r07HRepmpVBfQnn31Peej9frg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFFH4KCMg9RpZ7zle6CGngr3ZER9IM289PQclcW1c9g=;
 b=TfFovYNkuLIF2XTxoR88WsByXCAVHd2zCNWwJ9tDD5dChCi5rlgmX81zFLoUfHoHkuXV8/cHn96mMwq3GKKCu+86vvgrL2zbvyyRk19Qwh/X98rECsIWgbmtzvtpbVeNz47zkQPpkdcmuWAvF8fsHnS0iVnlzEV0kunQ7XSss3IlcawGWHz6s7bRsirJxSPBP3PhITIygTxVJSVQ/QqbgNotvQjsto+ZkqhUx5yKSBEPLjTnPyJ7qw2rkOHfunrYFSFIhX9z1i1Hltdyjy3R9GeF/ndg7TyPVvlOva9NV1PvMX+uj3yPjnuQPGpMftH7ic8du72LwiZn7dNJz2JBpg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU0PR03MB8933.eurprd03.prod.outlook.com (2603:10a6:10:475::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Mon, 29 Jan
 2024 16:18:24 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:18:23 +0000
Message-ID: <39a17b10-c66a-432e-b4ed-012374dcbe20@seco.com>
Date: Mon, 29 Jan 2024 11:18:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] usb: phy: generic: Get the vbus supply
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Felipe Balbi <balbi@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Jules Maselbas <jmaselbas@kalray.eu>, linux-kernel@vger.kernel.org
References: <20240123225111.1629405-1-sean.anderson@seco.com>
 <20240123225111.1629405-3-sean.anderson@seco.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240123225111.1629405-3-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|DU0PR03MB8933:EE_|DB8EUR05FT024:EE_|VI1PR03MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 74407e92-e978-4c43-a72b-08dc20e5ecd3
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 rIYmaihUVp/1WNXyq7iJuDY81jBDyD8s+qB/pBnyc1UnqwsETHCD7zrjKeh2IZUb5wQ4i92uIph42uXvqJrXOqLjBcDO1gZxbXMHvI2+Wacex5jtLEL4f/t73uV3r3a4TXRa6DJX/Hgt91Fe/5tCWt2HeX93K0sptmweRRbtPoVy4r/zAahzM4m6GHsdrgnukhXBPVtFyNGPW0mpPCiCBM/DvLvs5BdojUz5qjJd1z4ER8BkX71VpYkc9VwdWkTJEnAgv7PpGXTwnx7JWrIlgE365NU12O42braq0sAE3kmKH4fguODXBM/pCAk2JI3QiJ4FOFiU/pP6yjGKUYtbVf+JT9I2bjCqgWTVfNlNzFs1ODgo0RKkVLiJUa767GbF+TlOkYuC5eYWg/FPZRNSJgC/FPU6UKPL7YqfUfn/4GSgE/AdxVN6ikBpuV1uQ74AJNCj/PZ7xZCW2ro/AN3keJvk9jSdjp013IwKZ7KABhLysRlElfLHItROiNIytEInJ1rtZi0e9C8a6PoJQy6PPda3XVkPNJvhCEEqSIrvabQYBTW3Y8zERj6Mh8NMpq86PCZTMR5eRpYYqO6igpj6BIPHNepDjj+XuaweUjxnBxG/HL/eB4fZ9rdjXdTQEZrSjH4+IRxyPADJ7JIskleNaDcCDClH8rudGWLVKlz7dAOE0GBsvK8U6U+VGYdji288hxfryAX9naZbjUVU+4JmGl5Wpte22lCJ+22anW34wRiWGOmv3bH/kv6rcll2612J
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39850400004)(366004)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(6512007)(38100700002)(2616005)(66556008)(8676002)(8936002)(4326008)(5660300002)(44832011)(6486002)(6506007)(53546011)(2906002)(54906003)(66476007)(478600001)(52116002)(6666004)(41300700001)(316002)(66946007)(38350700005)(31696002)(86362001)(36756003)(31686004)(41533002)(15583001)(43740500002)(41080700001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8933
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB8EUR05FT024.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	96f1017b-cc6b-4d3f-882b-08dc20e5eab4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yyjlJ+9bcDZyzh9gT6l4Zfn3HrHpdLWHEvrvo+FI2+P8xfo1oPj8OA9/iNA/G7xnGeSBYSYLEdGzqgCSHdnfKV37J0BP+Qk6gfOax+oKCJsZJmC20k96U6sKfek5N/ktj7PP/NrqKwrqRCRLvLfdQ0ilq/Vs187/CP1Ddp6kFGvG3HXfmyk/LL06UCgJ7z1LSs44u3A6T7BVXM3GvNGT4lnMBeIj8a2pDdBk8Dd5e2peSfUjSN0M83/5gjhPSXbM4l/gvs6jxQGGOcNQfgGoNyE+121N9rNW2SQM9sIEoyHcZ5vRFwp/A8ABiKHuezvRpizptvw+h81Pqd6RvlFW6Ve5HqMT0WROG8h0NDTpB4wMVWZS0ZfZmPi5nCE6kcvBK90cKZ1196oGpJbHzCLYwjT0WOsWFjgMCUlTmHCY/bLDjLuAPjHuGB+gc75A+/B6ijJd/gNsRutinTzEhMfQ6SYLzz96nnUO+VW5875B19ocRyqEQVB6HPLeRrM7H2li7BVfRPUMRTJZCHas93Y5VHbW1XWikoe/ZaFpc0xxJQavzsl598Giq9hrGOD7f3XfCxogjc+yt8OIkTtsrLP7sl4P2f5AQNzXGc0MsU1enQ0UeAYQ7oBFO3g7aLQICHl+3KXwpDH2F5sdR0yupx6V5P7iG/C3SrdfoVqXmHWV5JYS/Q0nUYH/jbuRsHIoHPB6QULwJNEuqhVqXXHeXB+Q8NBnX3p26YIRZsBJQ/Ld1Ca2g8kYU3/f8jDwJmn2Br8bQV12V1RT58Ezn3aXGgXVsO7EROa+BkcCawf2E/xyQsRzlQ/vjObuuwYJdJgaPWpERJW4L7JOpowWAx7MGaTLtxnmAg11DlbydW6sSzt7KmY=
X-Forefront-Antispam-Report:
	CIP:20.160.56.85;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(346002)(376002)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(46966006)(36840700001)(36860700001)(31696002)(36756003)(47076005)(316002)(54906003)(70206006)(86362001)(70586007)(8676002)(6506007)(53546011)(8936002)(6486002)(478600001)(6666004)(4326008)(26005)(2906002)(336012)(44832011)(6512007)(5660300002)(2616005)(34020700004)(41300700001)(356005)(40480700001)(7596003)(7636003)(82740400003)(31686004)(41533002)(15583001)(43740500002)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 16:18:27.1880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74407e92-e978-4c43-a72b-08dc20e5ecd3
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.85];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB8EUR05FT024.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6495

On 1/23/24 17:51, Sean Anderson wrote:
> While support for working with a vbus was added, the regulator was never
> actually gotten (despite what was documented). Fix this by actually
> getting the supply from the device tree.
> 
> Fixes: 7acc9973e3c4 ("usb: phy: generic: add vbus support")
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
> (no changes since v1)
> 
>  drivers/usb/phy/phy-generic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
> index 9ab50f26db60..16494030209e 100644
> --- a/drivers/usb/phy/phy-generic.c
> +++ b/drivers/usb/phy/phy-generic.c
> @@ -274,6 +274,13 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
>  		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
>  				     "could not get vbus regulator\n");
>  
> +	nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
> +	if (PTR_ERR(nop->vbus_draw) == -ENODEV)
> +		nop->vbus_draw = NULL;
> +	if (IS_ERR(nop->vbus_draw))
> +		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
> +				     "could not get vbus regulator\n");
> +
>  	nop->dev		= dev;
>  	nop->phy.dev		= nop->dev;
>  	nop->phy.label		= "nop-xceiv";

OK, so as it turns out, this patch (and only this one) got applied as
03e607cbb293 ("usb: phy: generic: Get the vbus supply"). Which of course
messes with the premise of this series that no one was using the vbus
supply (so we can repurpose it), by adding the possibility that someone
was using the vbus supply. However, the only in-tree user is in
arch/arm/boot/dts/armada-388-helios4.dts, which was added before this
patch (so presumably they don't care).

At the very least, this patch should get dropped (and hopefully no one
complains about the next patch).

--Sean

