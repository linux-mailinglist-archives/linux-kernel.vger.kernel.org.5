Return-Path: <linux-kernel+bounces-103681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE3487C2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3FC1C21AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F92675805;
	Thu, 14 Mar 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y0y7e8Gl"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B474C19;
	Thu, 14 Mar 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441752; cv=fail; b=TmbKp/ygvUSueXrqWCYVfpR7GySgD6AOxF1jitqT+k9AhXfbRH0WRQjI8CVFfJFOatRWILWjCVzVGWDvAGuAkm6CN2p4DSO870bGN+P2BMn19XfaLUvVZB5c3TYyAqEzI+Udesm5iY2HmVyZbArldK32PM2AERzwOUK2MqJD6lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441752; c=relaxed/simple;
	bh=FPI7S+t2dlbyJioNG1GMw+EfZfWA/DiLSYRrDpN2b0k=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=ZUDW39VUzhI+Y5Gu6cF2FWD6f0c65DR8xs1lkyzbGNs+QuyVDfRrcihy4VuQDfx8xxrGvBCshVisURXD4siSsOmRQSHi2777wcjMzyg2+FKKSIptMAUnk2Ipe6eyrejPgH4v3rjaBNjg3Iidmi4afDcWDXFWdmkovTrewVtpvjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y0y7e8Gl; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYk2rJQYxAMpqKposudLYeTR1r/2+X1mYc/t1qH6lORRZYZsQKP8NRCZN50X+RZl51ZcXKjrDtiYXkk5y5Jq24f7ymWUYUKmCJT/+Wtx/iWHCiWNVpGlG/dbaDer5WleembJlrp3lWC0QcSJc1QuUSFPJBPCz+yRFXUCte47DCWgaGNzc6fslIQebZFnetFmOFeJ2jswMxZl0oxgcGGAMF7UbVsxZYmwGw3h99OtEfyvjUrxmoVMuUCwHEedFKYhkA5aithN2gDKCxYMkWXm7F/WdhtjxVtnqKrK677qTT6huQ2vL4dh0vqWYdIVH+kWmZzKLjGfkDkr0nou81lKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dK9akpO8GJnjaJeLtxNSkM5SO65rvZckW3CK1p9LmxE=;
 b=d03Zeigu2zP+Tcad/vOTqZZYg9YMo/LXy23fTxhjVBTOJPr0G+Vcx8GyTo5C7CL44vf0RyS9J+0tugdDlv8yeb/5MC8dKDr8KBzyzM6sC+xpy9Vi3Pv+UmsFtBiPY7LxQTQ3HyxvCh30wAO3PZB+vzai9ZeqAijrZgiJnOdkvat+cMNc8Q0D7XhFf09PiE4mM6zbc6sSHgrvngIKMuNrz5OXwhVNbQxh+nkYiUXl5ri1Ok2ytAXYGEYfIw7aVT18SpwutqrMycBVWPkfND7/8IhuoZt3zrtVE7y6KdGURUgwWMefJPIXjq56YBjbY8S8ItHg/f8jH+SP4G56d8Te7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dK9akpO8GJnjaJeLtxNSkM5SO65rvZckW3CK1p9LmxE=;
 b=Y0y7e8GloBb6rg5xRDb7LE70USNGjZnQPxxt138oMI8Ps5DxtkbreNnTGkfWl2J/S6zwviZCLOeZRNCojhy54wGcfjn4WpIUNv7ziCclJZ7oZ2FzK+yA5TCP1VHcNOUzo+RTRSGFqK5ws5Jpyfl+MvX6tsHnuMH7BSKyt2fTI64oIMCSVCcNnkHQYbp+wCJg3jzamRXRfprtu0+833tQ2Rui16shGJxic56z5kK1vqnOO20qKktFkpP2Zwtc956P4kQLQ75EUhz9sBVJA2vOr8ox1cOzff9ClL952MpeoXMc+8O3Yte72oM3d7pdR0dnzxBG24Ams4poxVCd7vOVSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.37; Thu, 14 Mar
 2024 18:42:26 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 18:42:26 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-7-rrameshbabu@nvidia.com>
 <20240312165544.75ced7e1@kernel.org> <87plvxbqwy.fsf@nvidia.com>
 <20240313174707.38a71c84@kernel.org> <87ttl9fhyd.fsf@nvidia.com>
 <20240314110553.1c5310c9@kernel.org>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, corbet@lwn.net,
 davem@davemloft.net, dtatulea@nvidia.com, edumazet@google.com,
 gal@nvidia.com, hkallweit1@gmail.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, joabreu@synopsys.com, justinstitt@google.com,
 kory.maincent@bootlin.com, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 6/6] tools: ynl: ethtool.py: Output timestamping
 statistics from tsinfo-get operation
Date: Thu, 14 Mar 2024 11:39:56 -0700
In-reply-to: <20240314110553.1c5310c9@kernel.org>
Message-ID: <87o7bgveni.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0028.prod.exchangelabs.com (2603:10b6:a02:80::41)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f8b4d6-ffff-4f58-b399-08dc44567e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OTjDvKNVJJlHQOitzUKP1mwJ6+fOooHvA0aEn8goojC4S9MWrlXBxbjsUtQ8xcPyzJDUI8CcASUXOcB7fAl3CVh8FdaBcr3FxzrbWvEIz6ObU6eCuSd+IgoKY39zpGA1zqgQXnAEftfVRGhZMA1VXnreT/fZAeMwjrasmUF7UgUFXKwK7A4nnGb+92MB4VYwHq/wtumyjoPRX4TfqL3PLuF2FGH39/JSbM14DI1wJ7SjjBgQEeIwzPFCe9CUy9glQKqcFKq1j2CjzfqL9abD/mLv+Q4RZBrvz7x+XpyLf8p+MQb7TsP5B6v4ZHdn0Xudpxg+OeNuJ8ANgBunVjr2hGqX/J+I8Vinxq1NeqGg/oebMJlP9fnU4P+DyqMOZlp+69aFznQk24wJ28TFUlbrwRTjD01QfClaOKVE+DaW88ZBomgFJMx9Qig8NJNjmoQoTkjcac7zquhEPj04NR3fp0s2i+2VRxWOiBZ4LlffZcYUoYxkPZuKMeNoZ2QVfNzjz9TIUmXYiPwmKl8XJv10HBYHQSSzbRWxCPE6siBb9vvl+Yf5zAoKSwPsopV3OC3bAl32FAaF+BAdULv11TpiE1GTtauuMWC+Atq8MFEqnZqhbdCF4RqH619oX2dhpEVM2JRLsWJMjIni2KMI4u+ajUYl1NQ2eavGyhwc0HVy7uM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0wCi5ozJ5S18kJGnuKC9HxqKLEtLipWGp+LEoaCFPQJBMiMUyWzMMJE+iT2Y?=
 =?us-ascii?Q?mzSOYweYi1IxDc2jNkmHZOMFHdvZQD0/z4ew5d7cGLjP5vpuAAtr5iDrGcaL?=
 =?us-ascii?Q?yRd1DuTWDsBiPhvtENqK4+XdGy7HxQFoy7mWd2E6Zmxzuh06yUqjeIh8ZdZs?=
 =?us-ascii?Q?1vuqpy52R8mR82vM6ZM0nVve4L62pI1XQbkVvt1kkxbuaKmtJZY0OlBuVI9n?=
 =?us-ascii?Q?SLoxY4HVnlZJROOP6myZrQqjmxUcTloS7Skms8JGGBWJMz6AprIPx5OOUNUj?=
 =?us-ascii?Q?D/Otn+IZ4zA/FCXi3WCFMwKH+ZWZEemMRlYeaqvYzKH4xbpVtaBBuiki+D8U?=
 =?us-ascii?Q?By8IOqWeAaw/+H6KMHv7KDwm18c2ZNWOlkivl2+zXiGOo6qgvTo5C519msI/?=
 =?us-ascii?Q?uCuT7tlI2tSgB0D0nUbO1H+sxJRIUzAzNWqTY3d6KcIpXu2DeMD7qmNACnN2?=
 =?us-ascii?Q?si2bRODM8ImwGuehGyQEBU+4omR1/wG2ZfQdOILWqOx8v+05Su32uPKc0h4t?=
 =?us-ascii?Q?InqXVlhKKWjB1A3UfGNiFEWm9A39PaSe3N9jpM1ipmAeVVjYgRH8AkwnbH0b?=
 =?us-ascii?Q?lFzyfPuihBl+KFZJLsvUOPvdxESnhIS1ZbIbG85VHCXRbE98hxhVK2GynGUr?=
 =?us-ascii?Q?XLaTXvjyTjIuDaSvqeQ5NnbC/viuwZKz6caUUdHV//xXAt+U5Sw4f4Ag7Pha?=
 =?us-ascii?Q?wlHNunRzgt+LlP4zso329pdbNUtupDnGTrkFUi3E6GnH7D0uqObD9hJpYuEm?=
 =?us-ascii?Q?UDXkW5FBAsUB7nrnqXrDcxyy+rYP8jxZJn/jxIBXTtOvi411QSUFfJ0cnnXw?=
 =?us-ascii?Q?7weKYFxidQSeHwcBSmJr8ZyqkMXt2eDArwm9h3D5i5zH/M4mGwkbS9kSD7x5?=
 =?us-ascii?Q?5KSyx4IBr2bdt/Ot7qqKSxuKhQ5GQoNINNs5ATRzTyUsbWTUuaCxi5zlMxcw?=
 =?us-ascii?Q?ZcF6X/xHmh/XSE6axQVl75QEe4avjimZi+4nMTVOfgXHDnz+qXyO+0WpF4BM?=
 =?us-ascii?Q?5KAP4gHsxkyfV6EK0AfD1Nyiy8y52P0GAjEKf7Vb7+/Qcg//DZxXeeR/oWqt?=
 =?us-ascii?Q?UQ+lx0FoqNj6pBGekC+VPlIWUjqsi6RSMEZ7Cd6Z45NYvNrRU6mLzKKSueyj?=
 =?us-ascii?Q?bj+dw49s5h9/yZ0jYN2aVZ911NfyT2wXxOg/XBzldK70/1nekM6F92MIsTcW?=
 =?us-ascii?Q?Ndgtu1qE/KLaHvROaDGAPLPUlPaKW21gcDvT2fFjKTemc0ssKbCi9Wd6LxdN?=
 =?us-ascii?Q?upuPwoTXQWhceNkmT9zyqPobzU1dl6reMkhvMmKRLD7aBQHsZJO81EUGIQJI?=
 =?us-ascii?Q?/AklmpjjfbJl+m0p97w6bucsJkAjNSRxlMIvHamKfIBBVxn8bx2n4YhRzn5F?=
 =?us-ascii?Q?/vAyopoMznNyUT4Q0jgoJxnk831mKl44w8KKeB0Azc5yDKsfjmC56+2oLJ9q?=
 =?us-ascii?Q?RPNzqSc4I8Jea5f9YswiDNQ5f8eyg7hafvEjVI92p9PeiXBZu2aiN4kp2HWj?=
 =?us-ascii?Q?0nHpRny4sFkwf2440bxa1Ntmi1W90LNJctdSETbsGBOyhaQDL5hHpaIDFvQJ?=
 =?us-ascii?Q?cMRfYgBvkboqBg/qERUMauj6qLjM+Nzr+ZhIfuFK8xN49FXqwi4up5YYQpAP?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f8b4d6-ffff-4f58-b399-08dc44567e73
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 18:42:26.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glnG0juCMLMFJj178jn+AGz+QYgtW4OPStFnMJdJ76rVMKIQ0qyB/FbjwvDWWjyzgH89QW9N5qscR51vO1w5mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817


On Thu, 14 Mar, 2024 11:05:53 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 13 Mar 2024 23:07:22 -0700 Rahul Rameshbabu wrote:
>> What's your expectation for how the request structure would look like? I
>> have tried the following.
>> 
>>   if args.show_time_stamping:
>>       req = {
>>         'header': {
>>           'flags': 'stats',
>>         },
>>       }
>> 
>>   if args.show_time_stamping:
>>       req = {
>>         'header': {
>>           'flags': {
>>              'stats': True,
>>           },
>>         },
>>       }
>> 
>> I tried looking through the lib/ynl.py code, but I did not understand
>> how the 'flags' type was specifically handled.
>
> Rebased on latest net-next?

Thanks, I was using our internal branch that mixes net-next with some of
our mlx5 changes for verification purposes, and it was not rebased to
latest net-next. Your suggestion works as expected with latest net-next
and will be integrated into the series (with the suggested-by trailer
added).

>
> I used this:
>
> ./tools/net/ynl/cli.py \
> 	--spec Documentation/netlink/specs/ethtool.yaml \
> 	--do fec-get --json '{"header":{"dev-index": 2, "flags": "stats"}}'

--
Thanks,

Rahul Rameshbabu

