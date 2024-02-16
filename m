Return-Path: <linux-kernel+bounces-69143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88F4858502
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE422849B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42E1350E3;
	Fri, 16 Feb 2024 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tb2StxJm"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878012F377;
	Fri, 16 Feb 2024 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107555; cv=fail; b=bgHhIxbioZliwFosZ1ixfti8a3oq1xY9nXPOwqRDH0L20SQvmWVt5KclfAb1KwmUwNirmXTuVAO1qg35hTQStUVCvB55ymYFNO5kNr6SgnZEwfTzK4TVbIHF2/94/HqxjSZQybPt0YAYH0pthlGh+WX19kXMMLeADjLFugN+90o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107555; c=relaxed/simple;
	bh=PBhGWBYssm5RxwzCNUb8nPcM3PZKhf32Th2bgC59IiA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=jptoIiglLKMhk2rG7zQ/RkpGD/p6MeNMzuY3jXx33kqM/qN69Ex8m0BH25/2bme8FbkiAl9WV8M4VdARXf1Z4mHKOedelzlfY28XMqf5H+F3NSX20XkC0ZnAlyIog5pBvl6h5kf4kUpM08wfG6mkS0L9nFriaKEgU7nr7bi8wqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tb2StxJm; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGT/wlhCfYDJ2p5dS9oY10DX8iS7t6yXyaFltpRdDdTErQlMFEK+WI8Z1PKY4xRgvao3p7f19hQuwEq1C17nfQ67ouLC6bN985fOMET0kvtC42hWGeIxkx037VB1bqMHuOAROnY6oaFAEjD6SVhGL3bRPzcgdvr2vJMAL7cfeP/lMOOjDvi2CDfNRe/qOGBa54FPwuaul0Kc6MFOffV4j1CfLrZwGJuDgB3e7+0gvdSRLkv03XvI8xbSNc4pYIbqSbPHLK3qI84Y2SUao0+Z+z+KdnGULdA35G9by4GosmJB+tVXK5D2cm+Ue1uy3+F7/CfuRXiD3jTZdHpX8m/fKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02r4q9XDhpN7zDi7ZTGoE3hYyKbmiz/PcPG3mkSIgto=;
 b=hK+EhMelG6AGH8JfnxeWUeyaXxIatmTZXgCMmoLCXaEVyR/aPItVc9ENeBlvEfyqukwEX0e+04ClYT7s7yUgV3mwZvDRdkx6628rqmw4Chm/phpY04sb7NJMFuJvpgLt1UsLMZy/DyZiK9njth4183vY/veRK5irNSsW+U+ivkmc03gklBzwTxQs+zLAsiS9KvhxOL1Gx6zwVFz0ysTtXoM0khhMBMaDIGFsc3dMSymNMU9FrpMD99BdwC+fJuvNWhDGPrawcw74uPqiotNMiQ0YMjv2Hy3WYRXEZrXIX8jGVx4KXjJoiLL5Gd6rQMZLdWIK0hSv38iwWnDA/Qn4Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02r4q9XDhpN7zDi7ZTGoE3hYyKbmiz/PcPG3mkSIgto=;
 b=tb2StxJmyD5wI5Esht44UYQoyh8FXaZutkqcGbQgC0NZRWoO+OcxrO/hNj3pQKVr7W5ak9Nqmjc42UPKmtZl0n3ERZMvCgtNHYXClLa180nqfFpL8WSuFUC6U8J3yjG9xL9Nyl6mooDC0B0no2T2EYbWjN/rvTDQBZonp4Xe7f01dLbURGn1HrQFK6jrQER3hpRqkDXtLH3rIEIlL2wjlkuULKZyrYu3v19CV6TzVSvbAZGtbHB+3M/wgSjptAQmsw5C9+mcaqPq9oU8ITFNtMqS6fY66X/adDG9c7e48yxdDjN1z8B96sKRLcKjugyCPSzaiBireDG+CmrEgl8tbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.30; Fri, 16 Feb
 2024 18:19:10 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 18:19:09 +0000
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
 <20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
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
Subject: Re: [PATCH RFC net-next v8 04/13] net: Change the API of PHY
 default timestamp to MAC
Date: Fri, 16 Feb 2024 10:09:36 -0800
In-reply-to: <20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
Message-ID: <87jzn4gtlv.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::24) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb4d59c-e9dd-4e56-ac0a-08dc2f1bc509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eAXOu+ryz22LWacGoqfsPtFzKDL1vHZ6b0GoIewC3rHOdq34FDVndH9uraAV1BYmIqgLCOlXN5Ar7hWdItf0gBl/LufmknhM0j/gB109d7MZvBEBatjcokS2W62rTYY+VmfuDQ86CMEXMf8NnHRPzyz5j8S1452kviigxcSCRZR8BoIoTZ5EFZhJiLNDUhaWRAJUgzQwgM9/eVBEApklAY1thPGyo+P4xcQNVLP4L1A+jTcEcDU4k2ndILLxQwMWm7szjKHoxDl3dmQQw92FOlR9oZZBUk8Q5N2TBZLG/5qzwfaZhCgONzdDWtEPDPEcR4H1O3a1b3j8B8IqwqJ3HOzEiDlhADKhUGSoW/iM4wcd2Ssb9TJ/neOVvZIdO7E+AjFD43nz0J/oohqmytoe1I8iN2h/wfNY9Rw9Jey0ISW2H5mDUPuI/FnfI8pZFdOkgn2OEfgq+WLiI3AGR8EFxAbm9NfzKCXBouM59t7W2s+nErK3x79vUHpdYggStttWsqjHzktpV1+BlkVSWl0fnFBEmR4N2g/wJ6lQnZfMBydPa8auB4cFhsgSrsZN23Un
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7416002)(5660300002)(2906002)(4326008)(2616005)(41300700001)(6916009)(66946007)(8936002)(66556008)(66476007)(8676002)(26005)(83380400001)(6506007)(6486002)(6512007)(6666004)(54906003)(316002)(478600001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hib1n3a5/IkOq46VzkHwa4Rnlj+pCD1V82HmhuBvziCHLA2ZV1E3HU+jDyqO?=
 =?us-ascii?Q?H9PtMrihRNmro53AZtJIa+LcWvCp/ALU/g1k9pkoOth3Vz3ngJUKzFB4EfSB?=
 =?us-ascii?Q?yABvU531Pa3L9mmJBR8Z/4HbChHrW1MUuEiV8iSYNoIzvRKS7gMk0Cx5mxd6?=
 =?us-ascii?Q?yV5yb8Ew+0xRWmyu6sJb/PYEAw8S12eF1sa085bBFGxd55qXRep7OrJMedb5?=
 =?us-ascii?Q?MiWfUDOsgNE6+CcpI1gmzuQKEDMgb/H0GWb7vLPg4KkAAipdvRbDjHuax9nU?=
 =?us-ascii?Q?YUqRjo0zjFaNYTgTugnftSSFMXnZnUycWXkJVKw4y7Cf0vzEJQIJ98xsJCa7?=
 =?us-ascii?Q?fq4nr0MSlHlB7pMiB+lApVSCWRV03PDpEvZJtpVz4YWYFb8CX76/HqvlcIc/?=
 =?us-ascii?Q?iLsI6n6TX2UEZO1D+ICJJfaFvle0KC5DLPriJrmew3qVtTRMbges+1vlDVWA?=
 =?us-ascii?Q?SG1YEe12wRsuhDQ4Cs9azHa7fjfvMVC2wOWOtSmAPMYrh7oSXXCNRqEV+5Ru?=
 =?us-ascii?Q?8imjaj4wb34q6yRPYrIKKgHnTsD9qLEBVmU3kZU4cr89UlMJPykRUsKRN4S4?=
 =?us-ascii?Q?Rjwcl28uX+oZ54XT7qoGp6NhK3WGf2ij/rHiIsN5nbk5ieft6HssX1w84Feo?=
 =?us-ascii?Q?K6tDmXTtfR0W1dATjpcpgHy/FnAEcDQOOQDCLeRo1cRM6zJrRpwhScoojThg?=
 =?us-ascii?Q?X4rgGxjrDheppPoqOX+L3wZ6WsxXialJHzQyQcqTgpFUdhU8vksXzvLxg2Ox?=
 =?us-ascii?Q?dvPgIeVnREjP0tFCxy0ZRSHjHdrMVYtuXqSSqbSwwxSKbF0cxY5UzdvWRv0B?=
 =?us-ascii?Q?1yfC+JgQkEIPQrNIWvr2vQNsEXtiuYzrbK2LHwnJJAC5gpwSCynTOflT8JhQ?=
 =?us-ascii?Q?sI+hIAZKQrhMCBG6EjOIEo6+9EepEPMNjKMdTZFVPdCmEab9v+/C7cqZFMSL?=
 =?us-ascii?Q?GV6ANYFxTf2K3dsC6w5cxZNeHxM4E5W6RXsH4GVTLoP15ObR73DDTVekKv/y?=
 =?us-ascii?Q?DDTzoRiZkADpovtl8Wb2DEUlZj8KbvHHIhELAdd/5w/w36N4EXnZTTfRRhT1?=
 =?us-ascii?Q?a3uQQlBCN8fWTE7B2Hzq/sLUixNueqnmnehW+NLCi31eAWeOsLXWW1swqzfY?=
 =?us-ascii?Q?6Ct/B+bHd8FLy2dUjRmOcvMGXCRM0Dob9RYttaQdkcQbTb58eIngxtLEBxpy?=
 =?us-ascii?Q?26KJvmvCzlcrJOXaJkqE/zAjC670IUGYTkzeQ54573rgW2c3WOhxcJJju/BJ?=
 =?us-ascii?Q?wIoiK7d9t5tJGt9CQsjE32D3veTFPXqxe9CUbxRba5txUumViNGXxSlyH12h?=
 =?us-ascii?Q?d7xQ0zjkmnHpSIMYmUWOKeECyd6fE5mRdWJZNnVrWx5aQ97m7I2wjXa6unBl?=
 =?us-ascii?Q?45eaRbDEcEJrj7N5673OfRkd8jPlnL78Bm91fDXpFmWM6yXWIO78xfYyG+ol?=
 =?us-ascii?Q?gHeR1uFHLBszn8itS10oQ83kRkwN6ZfRDHu/ZiEs205kmEkYrHmdLJHSLeB/?=
 =?us-ascii?Q?c+ILSzb5MXQiUyRnxJ1yalrQq/XXYZhIaLP7qSsgypPhz8uAIMQyocgGRkBD?=
 =?us-ascii?Q?EKYRXZRdVyhzH2/3ZVO9I75RS/6V0yH76e3SkJCsyvJchoMde/ctOBwEwTuI?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb4d59c-e9dd-4e56-ac0a-08dc2f1bc509
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 18:19:09.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HkNdf9roIRflVNRPPmN2epnW2QSVDqYkd+jVP4KKplivM+b8x6M6BsI2RQ4rVKgGOippHfK1KanhtGyFmcxwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983


On Fri, 16 Feb, 2024 16:52:22 +0100 Kory Maincent <kory.maincent@bootlin.com> wrote:
> Change the API to select MAC default time stamping instead of the PHY.
> Indeed the PHY is closer to the wire therefore theoretically it has less
> delay than the MAC timestamping but the reality is different. Due to lower
> time stamping clock frequency, latency in the MDIO bus and no PHC hardware
> synchronization between different PHY, the PHY PTP is often less precise
> than the MAC. The exception is for PHY designed specially for PTP case but
> these devices are not very widespread. For not breaking the compatibility
> default_timestamp flag has been introduced in phy_device that is set by
> the phy driver to know we are using the old API behavior.
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---

Overall, I agree with the motivation and reasoning behind the patch. It
takes dedicated effort to build a good phy timestamping mechanism, so
this approach is good. I do have a question though. In this patch if we
set the phy as the default timestamp mechanism, does that mean for even
non-PTP applications, the phy will be used for timestamping when
hardware timestamping is enabled? If so, I think this might need some
thought because there are timing applications in general when a
timestamp closest to the MAC layer would be best.

>
> Changes in v5:
> - Extract the API change in this patch.
> - Rename whitelist to allowlist.
> - Set NETDEV_TIMESTAMPING in register_netdevice function.
> - Add software timestamping case description in ts_info.
>
> Change in v6:
> - Replace the allowlist phy with a default_timestamp flag to know which
>   phy is using old API behavior.
> - Fix dereferenced of a possible null pointer.
> - Follow timestamping layer naming update.
> - Update timestamp default set between MAC and software.
> - Update ts_info returned in case of software timestamping.
>
> Change in v8:
> - Reform the implementation to use a simple phy_is_default_hwtstamp helper
>   instead of saving the hwtstamp in the net_device struct.
> ---

One general concern

>  drivers/net/phy/bcm-phy-ptp.c     |  3 +++
>  drivers/net/phy/dp83640.c         |  3 +++
>  drivers/net/phy/micrel.c          |  6 ++++++
>  drivers/net/phy/mscc/mscc_ptp.c   |  3 +++
>  drivers/net/phy/nxp-c45-tja11xx.c |  3 +++
>  include/linux/phy.h               | 17 +++++++++++++++++
>  net/core/dev_ioctl.c              |  8 +++-----
>  net/core/timestamping.c           | 10 ++++++++--
>  net/ethtool/common.c              |  2 +-
>  9 files changed, 47 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
> index 617d384d4551..d3e825c951ee 100644
> --- a/drivers/net/phy/bcm-phy-ptp.c
> +++ b/drivers/net/phy/bcm-phy-ptp.c
> @@ -931,6 +931,9 @@ struct bcm_ptp_private *bcm_ptp_probe(struct phy_device *phydev)
>  		return ERR_CAST(clock);
>  	priv->ptp_clock = clock;
>  
> +	/* Timestamp selected by default to keep legacy API */
> +	phydev->default_timestamp = true;
> +
>  	priv->phydev = phydev;
>  	bcm_ptp_init(priv);
>  
> diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
> index 5c42c47dc564..64fd1a109c0f 100644
> --- a/drivers/net/phy/dp83640.c
> +++ b/drivers/net/phy/dp83640.c
> @@ -1450,6 +1450,9 @@ static int dp83640_probe(struct phy_device *phydev)
>  	phydev->mii_ts = &dp83640->mii_ts;
>  	phydev->priv = dp83640;
>  
> +	/* Timestamp selected by default to keep legacy API */
> +	phydev->default_timestamp = true;
> +
>  	spin_lock_init(&dp83640->rx_lock);
>  	skb_queue_head_init(&dp83640->rx_queue);
>  	skb_queue_head_init(&dp83640->tx_queue);
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 9b6973581989..1c9eba331b01 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -3177,6 +3177,9 @@ static void lan8814_ptp_init(struct phy_device *phydev)
>  	ptp_priv->mii_ts.ts_info  = lan8814_ts_info;
>  
>  	phydev->mii_ts = &ptp_priv->mii_ts;
> +
> +	/* Timestamp selected by default to keep legacy API */
> +	phydev->default_timestamp = true;
>  }
>  
>  static int lan8814_ptp_probe_once(struct phy_device *phydev)
> @@ -4613,6 +4616,9 @@ static int lan8841_probe(struct phy_device *phydev)
>  
>  	phydev->mii_ts = &ptp_priv->mii_ts;
>  
> +	/* Timestamp selected by default to keep legacy API */
> +	phydev->default_timestamp = true;
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
> index eb0b032cb613..e66d20eff7c4 100644
> --- a/drivers/net/phy/mscc/mscc_ptp.c
> +++ b/drivers/net/phy/mscc/mscc_ptp.c
> @@ -1570,6 +1570,9 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
>  		return PTR_ERR(vsc8531->load_save);
>  	}
>  
> +	/* Timestamp selected by default to keep legacy API */
> +	phydev->default_timestamp = true;
> +
>  	vsc8531->ptp->phydev = phydev;
>  
>  	return 0;
> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
> index 3cf614b4cd52..d18c133e6013 100644
> --- a/drivers/net/phy/nxp-c45-tja11xx.c
> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
> @@ -1660,6 +1660,9 @@ static int nxp_c45_probe(struct phy_device *phydev)
>  		priv->mii_ts.ts_info = nxp_c45_ts_info;
>  		phydev->mii_ts = &priv->mii_ts;
>  		ret = nxp_c45_init_ptp_clock(priv);
> +
> +		/* Timestamp selected by default to keep legacy API */
> +		phydev->default_timestamp = true;
>  	} else {
>  		phydev_dbg(phydev, "PTP support not enabled even if the phy supports it");
>  	}
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index c2dda21b39e1..9a31243e9f7e 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -607,6 +607,8 @@ struct macsec_ops;
>   *                 handling shall be postponed until PHY has resumed
>   * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
>   *             requiring a rerun of the interrupt handler after resume
> + * @default_timestamp: Flag indicating whether we are using the phy
> + *		       timestamp as the default one
>   * @interface: enum phy_interface_t value
>   * @possible_interfaces: bitmap if interface modes that the attached PHY
>   *			 will switch between depending on media speed.
> @@ -672,6 +674,8 @@ struct phy_device {
>  	unsigned irq_suspended:1;
>  	unsigned irq_rerun:1;
>  
> +	unsigned default_timestamp:1;
> +
>  	int rate_matching;
>  
>  	enum phy_state state;
> @@ -1613,6 +1617,19 @@ static inline void phy_txtstamp(struct phy_device *phydev, struct sk_buff *skb,
>  	phydev->mii_ts->txtstamp(phydev->mii_ts, skb, type);
>  }
>  
> +/**
> + * phy_is_default_hwtstamp - return true if phy is the default hw timestamp
> + * @phydev: Pointer to phy_device
> + *
> + * This is used to get default timestamping device taking into account
> + * the new API choice, which is selecting the timestamping from MAC by
> + * default if the phydev does not have default_timestamp flag enabled.
> + */
> +static inline bool phy_is_default_hwtstamp(struct phy_device *phydev)
> +{
> +	return phy_has_hwtstamp(phydev) && phydev->default_timestamp;
> +}
> +
>  /**
>   * phy_is_internal - Convenience function for testing if a PHY is internal
>   * @phydev: the phy_device struct
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index 847254fd7f13..3342834597cd 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -260,9 +260,7 @@ static int dev_eth_ioctl(struct net_device *dev,
>   * @dev: Network device
>   * @cfg: Timestamping configuration structure
>   *
> - * Helper for enforcing a common policy that phylib timestamping, if available,
> - * should take precedence in front of hardware timestamping provided by the
> - * netdev.
> + * Helper for calling the default hardware provider timestamping.
>   *
>   * Note: phy_mii_ioctl() only handles SIOCSHWTSTAMP (not SIOCGHWTSTAMP), and
>   * there only exists a phydev->mii_ts->hwtstamp() method. So this will return
> @@ -272,7 +270,7 @@ static int dev_eth_ioctl(struct net_device *dev,
>  int dev_get_hwtstamp_phylib(struct net_device *dev,
>  			    struct kernel_hwtstamp_config *cfg)
>  {
> -	if (phy_has_hwtstamp(dev->phydev))
> +	if (phy_is_default_hwtstamp(dev->phydev))
>  		return phy_hwtstamp_get(dev->phydev, cfg);
>  
>  	return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
> @@ -329,7 +327,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
>  			    struct netlink_ext_ack *extack)
>  {
>  	const struct net_device_ops *ops = dev->netdev_ops;
> -	bool phy_ts = phy_has_hwtstamp(dev->phydev);
> +	bool phy_ts = phy_is_default_hwtstamp(dev->phydev);
>  	struct kernel_hwtstamp_config old_cfg = {};
>  	bool changed = false;
>  	int err;
> diff --git a/net/core/timestamping.c b/net/core/timestamping.c
> index 04840697fe79..891bfc2f62fd 100644
> --- a/net/core/timestamping.c
> +++ b/net/core/timestamping.c
> @@ -25,7 +25,10 @@ void skb_clone_tx_timestamp(struct sk_buff *skb)
>  	struct sk_buff *clone;
>  	unsigned int type;
>  
> -	if (!skb->sk)
> +	if (!skb->sk || !skb->dev)
> +		return;
> +
> +	if (!phy_is_default_hwtstamp(skb->dev->phydev))

Really minor but any reason to not just keep the conditional chaining
with a single if statement?

>  		return;
>  
>  	type = classify(skb);
> @@ -47,7 +50,10 @@ bool skb_defer_rx_timestamp(struct sk_buff *skb)
>  	struct mii_timestamper *mii_ts;
>  	unsigned int type;
>  
> -	if (!skb->dev || !skb->dev->phydev || !skb->dev->phydev->mii_ts)
> +	if (!skb->dev)
> +		return false;
> +
> +	if (!phy_is_default_hwtstamp(skb->dev->phydev))

Same here

  if (!skb->dev || !phy_is_default_hwtstamp(skb->dev->phydev))

>  		return false;
>  
>  	if (skb_headroom(skb) < ETH_HLEN)
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index ce486cec346c..e56bde53cd5c 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -637,7 +637,7 @@ int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
>  	memset(info, 0, sizeof(*info));
>  	info->cmd = ETHTOOL_GET_TS_INFO;
>  
> -	if (phy_has_tsinfo(phydev))
> +	if (phy_is_default_hwtstamp(phydev) && phy_has_tsinfo(phydev))
>  		return phy_ts_info(phydev, info);
>  	if (ops->get_ts_info)
>  		return ops->get_ts_info(dev, info);

--
Thanks,

Rahul Rameshbabu

