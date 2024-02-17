Return-Path: <linux-kernel+bounces-70093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1006C8592F3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C3C1C21157
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF88002A;
	Sat, 17 Feb 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fg6Elk2d"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B15B1E7;
	Sat, 17 Feb 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708205008; cv=fail; b=Weh94+FE80jxx6gQU1KV1b4UxonRfQKZFhKHtaDYV1a1PW+yW7jFYpq0dhJAZ6DD9G3ErqRgWalG/CUsV6z+EkyKF9PblfOIfWy1LWq2+01SoHQvuPZdUbrbzaNzgCJIPZ6wG+zodj5uDQrC63VU2wCZ7xRWKR+4GFgdtoDYbu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708205008; c=relaxed/simple;
	bh=qIocdiArhV9yTZTCb509W8yUPjAVWc1M5nWkn3VsKsE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=V5D9+p0dYvOnr4HTqi/7EFJ5rRtTPseZdtSMl+GWLFthknRTNWMj0FcO9AJ16JlUgXJ4nlUyQFdctk0NokYYCpeXc0hFkkPYlMZpHqpQhqJ5SyQzlhC2wAzhC+s4t3fdV0HWF6hSzovWnfnEMCBTA99KdKzqht2sjZPLEWv4wV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fg6Elk2d; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnWPMml3hKsIK6KbgedMl3f5XDbJoD2cpUaKjM6L0AF8esNPNLPoIWtuDBE1L11xcJFRE/pNinPopAx6PNud4RRF1N+2ZX95RmTs/GJ9+1QjL+wrd4+2xVEbdq9PZSeGy9yiIDS8dXRI/iCvobpErJplomYtyMrk97vrJ1cc/xiNLxMjdGIytBVnMd3L60N4QSZHH4CGQtYMmZ4bXGt8PuVLRC0gWaeXy2vt9QXipBxtDysd1E5yP27kWiptOYuMhGmKUI3SLqBpgrdLK3fU7j7OI/vd/pTNh26edIVvBq8WT6IdMHcq1poXTJzD6Ot4ONYQwjfY5LDvIWDYcaOZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/S33O5k4T0ajGzZomawcoPsss/RcrnMFGRUK7hNGJA=;
 b=CO98w83d7Sca+GudoXCBaLfad9T5UNp9QuuUedt27FPDlOKdaphtauma60eASAjuFWbp2WVrnjA9I/LkiULcfDLRRYVCJsoTZwdOEN27H3czMQwofeA/1dWuuWyYM+0dx2B7wfx1IQne2lCFOV6kqkTdbWAq273h1/GiAnjf7OeK9aA+R3gE0h1uNamWzVJ6gby2/4n+aaDELBbA9aCkicsKuq3md1gUHg7ysRoYbMwX/WiJHiOC7azVAwUvF1n9lBEhroMt97NhZV1cvHqiHQEqvwDFsgSo+zJNIO4j3fQpO45B2gwsZUjWgFuK8vfnczE+F28kFG0a5nqwvTiaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/S33O5k4T0ajGzZomawcoPsss/RcrnMFGRUK7hNGJA=;
 b=Fg6Elk2dDiNRhMxWK1FoO9JaK1Ar1kYoduBsuuPn0YM05UAjGppDhOqaRyl9X3oQ1417bocSHf4+wBtoKzLa5ktIu97I0fHgDDEcQ69zDSbK+gbUzmB3wcpCu+iBzBk6kqcCnXuMLEZEJLgdXNbGLh7VUgHpBd2MlUZf9/x8HM+ODy/1nqnN0HGH5YBT2Wp38c6KWYxc+jWX1ejCvhONuiQQgo07QJ7GC4jWBPVJvR+EqM1mzkAC5Kmm/rbT+bNyO3jQV9D9W5DLzE7JRapGRu5jIh1YsQ/rP1ZBYAwVrFxrUf1U/K36syxVrZkz+punGb9Qd90q04+rcVHvs4RRzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Sat, 17 Feb
 2024 21:23:23 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7316.012; Sat, 17 Feb 2024
 21:23:22 +0000
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
 <20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
 <87jzn4gtlv.fsf@nvidia.com> <b8926fe5-81ef-40ea-9e87-5e84b368b745@lunn.ch>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>,
 Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v8 04/13] net: Change the API of PHY
 default timestamp to MAC
Date: Sat, 17 Feb 2024 13:05:40 -0800
In-reply-to: <b8926fe5-81ef-40ea-9e87-5e84b368b745@lunn.ch>
Message-ID: <87o7cebx9z.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::6) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: a07137ca-8036-4b6c-23fa-08dc2ffeab4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IAybwvnCHnfXxqwf9QsET4/QrFQm/287PZS5goUczZRdVk5V0Q30IULQ09uqEIrxAXLu5xR3ZycBhFNCghOGPkfJ3QXtLc1zOa01WDoDBHb0gsNX75sS9QQCKGZApM2zhp3Jeuac0FaqQj+5aTs0andLeTfMEDoY+VV0QaulRXsKtuXqc4wxVrbwNCnnI3RoJ1o/GpAybjxbXHJ3naaUq+98kF2kgVXd30ikf3IVEfeNmVkf0+o0i6h7nLOb+e7Dmz1UKreCiwbfBmHJYJjI71oUu9Zo3cwv6NSAJwhEk2zYVihyViPEQTpnFrcOpF+P5KK7dXQKduOUYeTRhXa1PRpppphlrbIRd9Jh6e17jgn8Kf78dYy+aQ+zyr/1WpdLtWEPRqqqSunYX56fPSSS1lEyf+KmRVJTLPCeLPNp6rJI3+WhcT+tbjWs8nmbOvlsJtiVEXa97UZdTWk0auzgYK39NEXlv2m0cqY6DT3eQK0PDOEP+8r8m+o+YT/+WKXnu5gYu8suR/EkJcuKZKojs4/1FLj2axSU5gs7F7Gxzmu8wfOuf3ZrYX2CUps+fI1/jVn+aaTj0SANME+9+uUIew6A65w/AAc3gQZuu/6CzrY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(5660300002)(4326008)(2906002)(66946007)(66556008)(66476007)(6916009)(8936002)(8676002)(7416002)(86362001)(66899024)(2616005)(26005)(83380400001)(54906003)(6486002)(36756003)(966005)(316002)(6506007)(6666004)(6512007)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TOBLaHYs5gryPBKf2XeTXbm+lgP/VHZLb6tZsnZyPWMRUk7hzj84RHcDrfeF?=
 =?us-ascii?Q?8TrQS5cpiIyxvrqI+aCfuyk6Mp/QHKJCYKpKdj7tATPggZSj7Kge+v/23xQe?=
 =?us-ascii?Q?vRki6XJvljEC4gK8dY5k4Fhl8RhH4iQB736F983YGJacSx88Z0tmb1pD/RJT?=
 =?us-ascii?Q?X2OUKE5LxkWNZNaVvk8AfGUvtB4aMTmV51dJ32+cWbA0+jxVjmkZwBr8NNgc?=
 =?us-ascii?Q?syKieqZ/3spkUXIQ/BznTY8vwaV16TNAdwHm2TXlxgOTOSHb0Ye3AFYzMXk8?=
 =?us-ascii?Q?opBcasYmcKB7M65vvvbdfzfg4FPL0ZeZJE+5x6iZQZbzH0ahB3XIRtMDhQHZ?=
 =?us-ascii?Q?4HDdILAJkA2YRMpOZbSCu8zuzVDy/3VB1x5rLlrWjue0N39FSXKSQpifp60T?=
 =?us-ascii?Q?D1CbwGkOV5BQFaU+2CM+IzF7REd1l2/aTZGL7Yen8nTJ11UL3mCV6UuIkS95?=
 =?us-ascii?Q?PupKeJwyA4TzM3KRe/M5G7KfXTsZJHeDXYyAiDZ6kfS5iZgO7MLyDAwIlIfF?=
 =?us-ascii?Q?T88yG9QYmmI+AhGaKL3OLbaLLsdQY8HX/L4EvEjgK9Xck2RpWU8LVu4hKXPw?=
 =?us-ascii?Q?L/2VNWJ8AKvK69OShbBa88mqIPci70LaeT8F+/cJKI6+UVNzUhjhS0Zi0g9Z?=
 =?us-ascii?Q?uyMRqqQIazbf3K40VgIljeL09lUIEh9GTByArIOgPBLNARy13N9kvECqyOZZ?=
 =?us-ascii?Q?GRoArdIgLS64jcppUUEDk+C/bXrnWCodIass/gw5DHtjQJjOx5A9D7qyz5F/?=
 =?us-ascii?Q?EpPW7346ekKAe7DlqKnJ3rNzJ9F0jbPcWZKZ5mCJoYuGMZCXJe79T9H9J6k0?=
 =?us-ascii?Q?WbbYXyOmWsa4i7dw4Q6eJ4boJeN7N9ecyqa06SXDfzw31uI99G2H1W3PupvN?=
 =?us-ascii?Q?5T+kRO0vNuWqKRW6iN3ZJC0V0nL0FnUCKSlYvxvoy7thr7ixihPiCsuLUQE3?=
 =?us-ascii?Q?Gc+3Kh4ndJAJQev3FfrUCIZgfkIv8sKuiuZfz+buPV/hNF3R1EtvUI8BiL9b?=
 =?us-ascii?Q?8ikMxJJsMFYeGk7iTNF9eZNqf/D6NNPl0Hoizjt+QDJw2xwpbMZ/1pzT68Uu?=
 =?us-ascii?Q?LC1WZwKRbu/s1eRTN6iV3yGWwi1mJzj2Y+VMY3Uz5uAViZOCsK6kpHcyGcE5?=
 =?us-ascii?Q?HXAVTH4mEM6rAakZOogLfxILRvQ5ocZ8jLU8Koi8QDz0tKplwRikoI5/h2Qj?=
 =?us-ascii?Q?fSjSjIrkxM7ajaeYpfJAzTGLkZ+AtmLUePgNw758hmVrpKyGaS6xY11L9vMJ?=
 =?us-ascii?Q?59sj2y8yerY25VQKB06/RWRhRufZ85nlKfiisL4lKdgBZe823cgm6qJrVb4a?=
 =?us-ascii?Q?1nCaoPM1DHorqGWHZxL+nY+Maj5It6NFBqo4jYbiptuCupI7OFYxNDAvn+2r?=
 =?us-ascii?Q?yIHxFZuMCWx+q4+jvj6bOftMnvZAQ83WGSuJBSf0P5Wu2e+cPJFU3lRfGPZK?=
 =?us-ascii?Q?90mnwlJGMx/lT5+nrLVF6jXhNRZZID2qZgI1fcuSBr4FFSPkTBKLsndqanf6?=
 =?us-ascii?Q?6tl65gX5F8UCxaWsN8CY0SDmxROM5zHAA9PkLE352soh3ubJkfxyiQnXqPrv?=
 =?us-ascii?Q?7Iop4LoWS2qG7cwLjNLB/JWhownol9RyOR3rEDhJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07137ca-8036-4b6c-23fa-08dc2ffeab4a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 21:23:22.3359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a63vekqXwPulcLqcFH85OWOj8RQD1iNyqNqvA2Ns8jRUXKdLZfVENCbOrRN6gaOOv+jc/FqGWO2cYzSeqEh0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322

On Sat, 17 Feb, 2024 18:07:31 +0100 Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Feb 16, 2024 at 10:09:36AM -0800, Rahul Rameshbabu wrote:
>> 
>> On Fri, 16 Feb, 2024 16:52:22 +0100 Kory Maincent <kory.maincent@bootlin.com> wrote:
>> > Change the API to select MAC default time stamping instead of the PHY.
>> > Indeed the PHY is closer to the wire therefore theoretically it has less
>> > delay than the MAC timestamping but the reality is different. Due to lower
>> > time stamping clock frequency, latency in the MDIO bus and no PHC hardware
>> > synchronization between different PHY, the PHY PTP is often less precise
>> > than the MAC. The exception is for PHY designed specially for PTP case but
>> > these devices are not very widespread. For not breaking the compatibility
>> > default_timestamp flag has been introduced in phy_device that is set by
>> > the phy driver to know we are using the old API behavior.
>> >
>> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
>> > ---
>> 
>> Overall, I agree with the motivation and reasoning behind the patch. It
>> takes dedicated effort to build a good phy timestamping mechanism, so
>> this approach is good. I do have a question though. In this patch if we
>> set the phy as the default timestamp mechanism, does that mean for even
>> non-PTP applications, the phy will be used for timestamping when
>> hardware timestamping is enabled? If so, I think this might need some
>> thought because there are timing applications in general when a
>> timestamp closest to the MAC layer would be best.
>
> Could you give some examples? It seems odd to me, the application
> wants a less accurate timestamp?
>
> Is it more about overheads? A MAC timestamp might be less costly than
> a PHY timestamp?

It's a combination of both though I think primarily about line rate.
This point is somewhat carried over from the previous discussions on
this patch series in the last revision. I assume the device in question
here cannot timestamp at the PHY at a high rate.

  https://lore.kernel.org/netdev/20231120093723.4d88fb2a@kernel.org/

>
> Or is the application not actually doing PTP, it does not care about
> the time of the packet on the wire, but it is more about media access
> control? Maybe the applications you are talking about are misusing the
> PTP API for something its not intended?

So hardware timestamping is not a PTP specific API or application right?
It's purely a socket option that is not tied to PTP (unless I am missing
something here).

  https://docs.kernel.org/networking/timestamping.html#timestamp-generation

So you could use this information for other applications like congestion
control where you do not want to limit the line rate using the PHY
timestamping mechanism.

In mlx5, we only steering PTP traffic to our PHY timestamping mechanism
through a traffic matching logic.

  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h?id=a6e0cb150c514efba4aaba4069927de43d80bb59#n71

This is because we do not want to PHY/port timestamp timing related
applications such as congestion control. I think it makes sense for
specialized timestamping applications to instead use the ethtool ioctl
to reconfigure using the PHY timestamps if the device is capable of PHY
timestamping. (So have the change be in userspace application tools like
linuxptp where precise but low <relative> rate timestamp information is
ideal).

--
Thanks,

Rahul Rameshbabu

