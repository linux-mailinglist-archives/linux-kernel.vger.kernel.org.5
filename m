Return-Path: <linux-kernel+bounces-69158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7894885853A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C432823E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6C31369B0;
	Fri, 16 Feb 2024 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L4Z8JCnB"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E41353E9;
	Fri, 16 Feb 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108181; cv=fail; b=L53+H3GZT9Z3PWiSBgaPnNzzQwN6cBYHxKqfrcdBviRF/cUie6o3EdhrQEI+yh9sFzLEEKSgPGZvALS8ve/8x2OqSp5OWCqMr/P83fZ+OKgPRRNRJIzuf176D1KV/M4ChgjhIXdvTfYUo4bvwAWZ4FQPRiNYbdX+da8ne4gt6L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108181; c=relaxed/simple;
	bh=K8zTmwwAFjLcGVkVUZwP7Kv4W43S8CGzHlZkmZF3MrI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=S3YQGAsRvy/NMeeKWgri1XuEfRFDTFLy6rHz2+cMAtNVWQkUbuIgOEA3RgqLUx6X5SbxqXZH8KfsEY/oLnDoAQeIkC6dlyOYx4ZJZHWGaY4Brl2xzeH1IxMxCJrtexvVdCqeRJohjKLBhOt8O3Z/hwiZb6HqmuGRMtqQLLKwufs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L4Z8JCnB; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBYF6yuKfsPdvM9y2nsWzz7A0TQ100AOREHks0FHQiaQH5d0qU8iWGvzhBeg3cr+M9drzb1PO2Dg7TgVrnTEGg76wt8mc34MSZTy0tBwjorARtNRDcJzzef99nrlefG4vsp6jx2ORquPiFJemeGhCwtZHvoU4VCVr5KlN5h/RoVDgiJxzU4RaCbeUGRplMNlTeNAk8/JbIWrev8LOcqjEdtK55k5dl5hqVcjCYEdK1MuJbbZ7aB+mfWC8+V5k0D7HC4ifgzuoWCNXPKGW4fx5LRrI8CqxLUtoXCwSOxeJ1iz9r80TQ+Dded4jCsExLIxmT6VDgmPYExgN4u2y5DLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU6m7RZrm/a+IcN+z8MnFfp1E9tRVMaHXC62geD5uM4=;
 b=CmKTMgbTUFFYk62Lv6cknx46ckaAmuqSFVZ9znaytmXtPEfhEIo6ccHPr/FoPjhRpf0BELNl2C7hXAuOiZtEK/AhxeN/5glww+Rk28L/YGJo/spDPJ3pYRV+vRstCxagXgNRHtCWD91IrMrAEH9xUrtWFbN06np2HAQPhJ+i8ODZoYaMQX83/aYJGVlngShoM4ElayDAqdZ/473fM/M0s+oaoGPKG7Job6TBJGEqDfmWlkInwGLiXspvzPEpi8rxLXGKlXIwaMo8+pTYK+X5Ubz4pYKvwkUJMDnHHjql1iBD9BWa7b5aXhiZOuHuqjK0Ougio151x5KLgvHCCo+nOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU6m7RZrm/a+IcN+z8MnFfp1E9tRVMaHXC62geD5uM4=;
 b=L4Z8JCnBf6fQW0BmCoqVS6iKKAcRXfjfqLgXxrNL6Jpdlfmvs2yZAKxV2Uh4p1kbxV56VhyYCoK35ZeFoLRC1QO7/eIh+RDYEQjzd8wOlb9YqRBk/ySWARLNHZ8JWhXiZU8M5MuBNMiqoEKMP0w4eU52S6pEh5pp/D4wZ1xzaYdrw+WupQOzf6qTFx30xTXPNXVdw6ZP1mzR4t3ps8deWjPk9RddC7Lq6PFO+fClSWULYQhwkqkHGedOt8hbTqxtKI+y9XD49jwo/MibPQ734v3PSz4DdxcW4Bzo+CU37o2kDDu89+4JGHTA3EJW+6jh6K3oOUsI/eQBm+0urae3nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 18:29:34 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 18:29:34 +0000
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
 <20240216-feature_ptp_netnext-v8-6-510f42f444fb@bootlin.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v8 06/13] net: Add struct
 kernel_ethtool_ts_info
Date: Fri, 16 Feb 2024 10:27:32 -0800
In-reply-to: <20240216-feature_ptp_netnext-v8-6-510f42f444fb@bootlin.com>
Message-ID: <87frxsgt4i.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: ab299b75-130d-48c2-8daf-08dc2f1d3920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1mA639xOeZZ4dOutWbSG59OydrGh+7cQ2UG6s3ZeKNFbiOxCnaDDb1q2J9gXzccAE9eHJZK3acDUIXTEpoyN4cW8zkiar2TeVRUgLNVpWoWC7xjQihDVJdmbH4ysn/88lFcl2W61C+Aby89k38FEYbSDx6J9J5F5tNQIc8i1Ft+4jqbLh39AdgrHtFx4/tpiBAgCyhjikJ35ZLmQzqwmqx76HB1jseNaaNaXiwQFvmd/at1f4MaHTLm5VJcSSZtmrCiUnoSj/FhasiTWlOcvUVIIhFcu1bsiUUUsuVSroeVn6KAREgNW8WC0REdgcQDzT/+0LZizkD945vqRAuQi820XK4hH3RmhXmRCX2tMh+pKdfDoq0TP+OKMdImw2FL72KAFv0BEqP8KHoeiuA5hsY/wSGhTqZTpBBpuOZamumflSAjtVfZYcd4+cTL0Ea0hJp6gnAdFNVCpBaKdLyH92UqI4d6GdVo+dKQt4NfwUSahGGJVyVFgx0FfNdolSbiHOj3dgtxrfpz5CUz+j6sN8ESp6RHtgkbNYt7a1D/SHfZo9RuQuN6ePCm4ryLLb2gf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(7416002)(8676002)(5660300002)(66946007)(66556008)(8936002)(66476007)(2906002)(6916009)(4326008)(36756003)(86362001)(38100700002)(83380400001)(316002)(478600001)(26005)(2616005)(6512007)(6506007)(6486002)(54906003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eBazfm7itDGr4mVJFVyww7HvVQIcjZPGWl2y/HNPlTRxSoXL4JXfN4jEXS0T?=
 =?us-ascii?Q?49tMjV2/YOv16tkwPHEjGh2Ebaa9M5Z4LCdodnLLyWLNHz9SsuPaDbr5kuo6?=
 =?us-ascii?Q?gjqnmA7qQKjWNxIKB9aVlpenOMYr5w4p0xsz6oLbodu29zu2cpLKlUqn4cvy?=
 =?us-ascii?Q?rtwvwYXYG7gYtOcUjyLwEVQJmJQT9C0mcg/MyHsMMBctubYoCb+KYcx+mLt5?=
 =?us-ascii?Q?85YQoOY+XbYaU0vtlw5kdKWsk0m5E+oRN2FfBAdIu9f36nQbu9x3+dWHeF1M?=
 =?us-ascii?Q?2bR+5MWoNCab1HikKpx8/Dgy7anvhoa9nZyuLEw8nl4hKgubrubTfzbEhgzt?=
 =?us-ascii?Q?QIPAwOPeD9XBrMy1F2Oum9N1vyQFKwwI+yB3uw9II2mhl0eXr1BVV7QQUP7o?=
 =?us-ascii?Q?MiVssZBIzsNSBRIGkH08fK3H2+wUOUsZTtxelu+mNYyHzjI+MJ+aGFe1Zxz6?=
 =?us-ascii?Q?xrM2/dBBvsSiE8YN4qz/kQEjJd+DTA76oWf912wFCoBSZ+hEswV7xl8Wt/w7?=
 =?us-ascii?Q?35zjVKsk+397cqxaMoHnib+R2mugTuN5d4Snz48bUk4EOEbZzSvqsGN7Cndu?=
 =?us-ascii?Q?j2IQdXv5HFMVBlQb8t+MLTYZ465jOKLACfDnilw14fxIpNnUDfceIGFq3AXc?=
 =?us-ascii?Q?Cgdmp/JDqh81OyY2H+Wg9oZvKHbliIOF0dGX5h/dgD2+S7ecRMMhjH8ZqkrI?=
 =?us-ascii?Q?bRzrl98NxQCFyAyP75H0QHZZcSjJ46TqZlL1x9vsgTZWHVHSBFujXsi4UEuD?=
 =?us-ascii?Q?okQA8YWoJtPfQMROtokDUNg6GHK6yAPLYAWuAfSvb0kxlIw9y/lnjsyGMwSY?=
 =?us-ascii?Q?UjE6usfXCVX6DaaoVGsPVutSpYhpdIWB7lnCEpdXmy5dUnka29ceEauJU+9n?=
 =?us-ascii?Q?Yeee0f1E/no50gcDBzviowXnV9eglkUWSxolWAnqW3yHH2Ix16H59wpS/MGq?=
 =?us-ascii?Q?15tGVFQCUSSRM5QWooyCpTqf6RLsAYKpcxtFLVhUmGQfDmYf3gmmeF9ZB7Fc?=
 =?us-ascii?Q?s05iCxguukDG6IjnEaA5GEVxixtgiuwgsqnO5RNq7jVPd+tEYgY1HWhO2mPm?=
 =?us-ascii?Q?50NJjP/o8+JOrzJRJfAoBiBzuEMtZvfaYu4XQp3dSDytxyvl25IMQScA+4Je?=
 =?us-ascii?Q?+oWmXHZnqKCVsx7pZZDEUQCo6Juvny7KHJMfYir/rgcyvzdTEm2sAgrxasB+?=
 =?us-ascii?Q?lDUOv+bumhTBf/JvT8mJF5A8KnV7dd6nv97sK7SUB8aWESCzI/mwcyEb5Vk6?=
 =?us-ascii?Q?BwYnmJgzUBtxAg+zAJ1OZnzmj2p9gG2v8G5GAblTP5z8prVqQp6GcWy9ReXx?=
 =?us-ascii?Q?OnFMNnMQtnhoG6wFWyvztdelHKmsFZUS/TWRIhIz3xPpjbN/a2Z2iNzTY3Bz?=
 =?us-ascii?Q?p1Im+0neKE8eOziOjFPrMN2LglAOKTC/fRFJDLbko9tsIt6jFw/AvOmlDBEP?=
 =?us-ascii?Q?4xUBIxhmavFjT4GKvdkWlrEAUYuJG557iXqpkv4y7xuIWCCapOw9xqOlfKpo?=
 =?us-ascii?Q?lPajcfo3MaYBJdWiZxIKNrKYBWKrx04kSfJxYc05By+2as8JaTQk/x6c766U?=
 =?us-ascii?Q?KRy7PsNzD7Z/tj9Qv6Bclduw2qhqlghVWjQ0kG8mtNG5t5Gf9tC1U8PH+8Pc?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab299b75-130d-48c2-8daf-08dc2f1d3920
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 18:29:33.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enNP7yuO4gG07BWXQ+7Qh/GfpVZB9glDaytMB5xpjMl23cX0UymcmFxocdJAtvy+sG6ObzBZn9wzFIZtsTPr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139

On Fri, 16 Feb, 2024 16:52:24 +0100 Kory Maincent <kory.maincent@bootlin.com> wrote:
> In prevision to add new UAPI for hwtstamp we will be limited to the struct
> ethtool_ts_info that is currently passed in fixed binary format through the
> ETHTOOL_GET_TS_INFO ethtool ioctl. It would be good if new kernel code
> already started operating on an extensible kernel variant of that
> structure, similar in concept to struct kernel_hwtstamp_config vs struct
> hwtstamp_config.
>
> Since struct ethtool_ts_info is in include/uapi/linux/ethtool.h, here
> we introduce the kernel-only structure in include/linux/ethtool.h.
> The manual copy is then made in the function called by ETHTOOL_GET_TS_INFO.
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  drivers/net/bonding/bond_main.c                    |  4 ++--
>  drivers/net/can/dev/dev.c                          |  2 +-
>  drivers/net/can/peak_canfd/peak_canfd.c            |  2 +-
>  drivers/net/can/usb/gs_usb.c                       |  2 +-
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c       |  2 +-
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h       |  2 +-
>  drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c    |  2 +-
>  drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h    |  2 +-
>  drivers/net/dsa/microchip/ksz_ptp.c                |  2 +-
>  drivers/net/dsa/microchip/ksz_ptp.h                |  2 +-
>  drivers/net/dsa/mv88e6xxx/hwtstamp.c               |  2 +-
>  drivers/net/dsa/mv88e6xxx/hwtstamp.h               |  4 ++--
>  drivers/net/dsa/ocelot/felix.c                     |  2 +-
>  drivers/net/dsa/sja1105/sja1105_ptp.c              |  2 +-
>  drivers/net/dsa/sja1105/sja1105_ptp.h              |  2 +-
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |  2 +-
>  .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |  2 +-
>  .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |  2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  2 +-
>  drivers/net/ethernet/broadcom/tg3.c                |  2 +-
>  drivers/net/ethernet/cadence/macb.h                |  2 +-
>  drivers/net/ethernet/cadence/macb_main.c           |  4 ++--
>  drivers/net/ethernet/cavium/liquidio/lio_ethtool.c |  2 +-
>  .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |  2 +-
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |  2 +-
>  drivers/net/ethernet/cisco/enic/enic_ethtool.c     |  2 +-
>  drivers/net/ethernet/engleder/tsnep_ethtool.c      |  2 +-
>  drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |  2 +-
>  .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |  2 +-
>  .../net/ethernet/freescale/enetc/enetc_ethtool.c   |  2 +-
>  drivers/net/ethernet/freescale/fec_main.c          |  2 +-
>  drivers/net/ethernet/freescale/gianfar_ethtool.c   |  2 +-
>  .../net/ethernet/fungible/funeth/funeth_ethtool.c  |  2 +-
>  drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  2 +-
>  drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  2 +-
>  .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |  2 +-
>  .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h |  2 +-
>  drivers/net/ethernet/intel/e1000e/ethtool.c        |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c       |  2 +-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c       |  2 +-
>  drivers/net/ethernet/intel/igc/igc_ethtool.c       |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  2 +-
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  2 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |  2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en.h       |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  4 ++--
>  .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |  2 +-
>  drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |  2 +-
>  .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |  2 +-
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c |  4 ++--
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h | 10 ++++-----
>  drivers/net/ethernet/microchip/lan743x_ethtool.c   |  2 +-
>  .../ethernet/microchip/lan966x/lan966x_ethtool.c   |  2 +-
>  .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |  2 +-
>  drivers/net/ethernet/mscc/ocelot_net.c             |  2 +-
>  drivers/net/ethernet/mscc/ocelot_ptp.c             |  2 +-
>  .../net/ethernet/pensando/ionic/ionic_ethtool.c    |  2 +-
>  drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |  2 +-
>  drivers/net/ethernet/qlogic/qede/qede_ptp.c        |  2 +-
>  drivers/net/ethernet/qlogic/qede/qede_ptp.h        |  2 +-
>  drivers/net/ethernet/renesas/ravb_main.c           |  2 +-
>  drivers/net/ethernet/renesas/rswitch.c             |  2 +-
>  drivers/net/ethernet/sfc/ethtool.c                 |  2 +-
>  drivers/net/ethernet/sfc/falcon/nic.h              |  2 +-
>  drivers/net/ethernet/sfc/ptp.c                     |  2 +-
>  drivers/net/ethernet/sfc/ptp.h                     |  5 +++--
>  drivers/net/ethernet/sfc/siena/ethtool.c           |  2 +-
>  drivers/net/ethernet/sfc/siena/ptp.c               |  2 +-
>  drivers/net/ethernet/sfc/siena/ptp.h               |  4 ++--
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  2 +-
>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c        |  2 +-
>  drivers/net/ethernet/ti/cpsw_ethtool.c             |  4 ++--
>  drivers/net/ethernet/ti/cpsw_priv.h                |  2 +-
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c      |  2 +-
>  drivers/net/ethernet/ti/netcp_ethss.c              |  4 ++--
>  drivers/net/ethernet/xscale/ixp4xx_eth.c           |  2 +-
>  drivers/net/macvlan.c                              |  2 +-
>  drivers/net/netdevsim/ethtool.c                    |  2 +-
>  drivers/net/phy/bcm-phy-ptp.c                      |  2 +-
>  drivers/net/phy/dp83640.c                          |  2 +-
>  drivers/net/phy/marvell_ptp.c                      |  2 +-
>  drivers/net/phy/micrel.c                           |  4 ++--
>  drivers/net/phy/mscc/mscc_ptp.c                    |  2 +-
>  drivers/net/phy/nxp-c45-tja11xx.c                  |  2 +-
>  drivers/ptp/ptp_ines.c                             |  2 +-
>  drivers/s390/net/qeth_ethtool.c                    |  2 +-
>  include/linux/can/dev.h                            |  2 +-
>  include/linux/ethtool.h                            | 25 +++++++++++++++++++---
>  include/linux/mii_timestamper.h                    |  2 +-
>  include/linux/phy.h                                |  2 +-
>  include/net/dsa.h                                  |  2 +-
>  include/soc/mscc/ocelot.h                          |  2 +-
>  net/8021q/vlan_dev.c                               |  2 +-
>  net/dsa/user.c                                     |  2 +-
>  net/ethtool/common.c                               |  6 +++---
>  net/ethtool/common.h                               |  2 +-
>  net/ethtool/ioctl.c                                | 12 +++++++++--
>  net/ethtool/tsinfo.c                               |  6 +++---
>  net/sched/sch_taprio.c                             |  2 +-
>  101 files changed, 150 insertions(+), 122 deletions(-)
>
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index b90c33607594..f74190a8d9ee 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -18,6 +18,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/netlink.h>
>  #include <uapi/linux/ethtool.h>
> +#include <uapi/linux/net_tstamp.h>
>  
>  struct compat_ethtool_rx_flow_spec {
>  	u32		flow_type;
> @@ -644,6 +645,22 @@ struct ethtool_rxfh_param {
>  	u8	input_xfrm;
>  };
>  
> +/**
> + * struct kernel_ethtool_ts_info - kernel copy of struct ethtool_ts_info
> + * @cmd: command number = %ETHTOOL_GET_TS_INFO
> + * @so_timestamping: bit mask of the sum of the supported SO_TIMESTAMPING flags
> + * @phc_index: device index of the associated PHC, or -1 if there is none
> + * @tx_types: bit mask of the supported hwtstamp_tx_types enumeration values
> + * @rx_filters: bit mask of the supported hwtstamp_rx_filters enumeration values
> + */
> +struct kernel_ethtool_ts_info {
> +	u32 cmd;
> +	u32 so_timestamping;
> +	int phc_index;
> +	enum hwtstamp_tx_types tx_types;

I might just be terrible at reading code, but isn't this what
tx_reserved in ethtool_ts_info is for? I feel like using one of the
reserved memspaces for this enum removes the need to make
kernel_ethtool_ts_info? I might be missing something obvious however.

> +	enum hwtstamp_rx_filters rx_filters;
> +};

--
Thanks,

Rahul Rameshbabu

