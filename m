Return-Path: <linux-kernel+bounces-103685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C4887C2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40AEAB21916
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747E674E39;
	Thu, 14 Mar 2024 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yet2SO9h"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D01A38D0;
	Thu, 14 Mar 2024 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441889; cv=fail; b=bCO1Q7XFLtWxOg7Q2TpYz/pKLbssA93iTJKluQlATFIDWxWIj1Xei+5awLbSVHMEIrK8u7kAF5WaQdpC8culStsN5wA+O96zOsuIT90HxAklVQRBeaeO1Z3GvEZRntbPQPQvr42V8O402Mzc99czMQgPvnwkMql3Fo5SP41tN9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441889; c=relaxed/simple;
	bh=9cCDo2rEEdZCDZdbRroZK7hQ2sQErLDQHdbzi8jgTLM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=mP6PuN4XLyL2j0dnwER0ji2bakLvHAJ/pm6niRZoVyJGseKMcuqcORJkoB0HLikPyRGcM5aZzUf2WAEWR5qd3yydDWTNeyahwoViornDSO97C5TiYVkXaomH3ypg0xxKcSGIV1RM0vuDhBd+azrBx3GIeixOehrSuJ9P7iASuao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yet2SO9h; arc=fail smtp.client-ip=40.107.95.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+UcuFPMnzKsAbCYvG0vT8AIsO2ShvdYTmc1EbtcitydtoHUTpiMdZsl/KCClb0lT1FyCO0CX8R9sRcfWupYyKQ5eTSEBxaMOQRpg640uAUnS6iMaasZUmBxifhBhvd/WCDXhbeKRzkwprE+54kRJvoh9Ofny7INtth7Fsgp/Vy9Bg6uuMr78UZXMOXSCl8IRboUo3Ur7ID5hFpXvOMeI2dM5GBlPkfxsCKsa4FlcBAyW/PLoymbYDij8FDR8+p/z+KiN7b5vikO8fDkh3udpcfLmoJlny3TQG4idC4JnQnAJhohXLBCuhh4PgzK6uIPCGp5kCjwdBowIIIPKR6vTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cCDo2rEEdZCDZdbRroZK7hQ2sQErLDQHdbzi8jgTLM=;
 b=c3UWOqoEJJ4xoJICFBbOdwZZfNSwZDPso19u+YKG9lNAMgjMn45g3zIznvfUM2SLrT03x0VmVhAWUUEIUPhaVYcnYO0vB6thOHVXc5g5TOb9/hI4lxb5EJDtIHcjsbGrHz8w4iEPQkZL0MQpGgyqW18x985ydzQcNgA7xTVF8GVUk02sNLXwIfIdCtZ+nw8AlMW/hJe7QkXiVaqQYeSm7cvsQ5hM2+fMs8sQrwvRX/R0cYopB1Cw/9/W+8N2KFgmjBMNzYuFgOf3CUn1KalgKzIyRvJ44bNHnIlu/Q/xeFznpbSkA2IJFkb15QeDGB4V8Bqsf9mt3c1n50fydG3dnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cCDo2rEEdZCDZdbRroZK7hQ2sQErLDQHdbzi8jgTLM=;
 b=Yet2SO9hjjvqbDyJYEwjUexRHlkt9Vw00+0pPySoulrj03vNjaWvRLja7BTREVSaKgQ6podI17O56prvytOJ12DHDq1tpU5vTDyYXUYX6aK24Ql3oeYOUNo7DElJ1EFMAIPVzo4uiHG8n48og6oBaWV2EfkuZUfprcFTAhuB7THiOl5NV8JevxC/+EOOQSFmddEuB58wAkyZfYgvJp/D7GQZkZqnN0LcJYSoVJd1iAQ23THy/Xu5vPp7juarTZUGPJzWb9v8PoQTyBJ1j8sEfr+e5xoCJQ07Vo9j/wQOPSNJbicSeD2OxrHLZTVjAlRQAzDtAqJm+1HfE3oPXxYdcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Thu, 14 Mar
 2024 18:44:43 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 18:44:42 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-2-rrameshbabu@nvidia.com>
 <20240312165346.14ec1941@kernel.org> <87v85ovj4d.fsf@nvidia.com>
 <20240314105943.7bc6f2ef@kernel.org>
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
Subject: Re: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardware
 timestamping statistics
Date: Thu, 14 Mar 2024 11:43:07 -0700
In-reply-to: <20240314105943.7bc6f2ef@kernel.org>
Message-ID: <87jzm4vejp.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0009.prod.exchangelabs.com (2603:10b6:a02:80::22)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db20667-8fc4-4823-f91c-08dc4456d001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VTVSQf9O56tvz9C7pkxu58g9bX1AoJZ93KfRReN8I3vrJNBiIKae+zkoH+RFkRFhYK7OvJAc9a8/HIRypPP662oMiVkYF+nY2JIU9szUG90x9Pb/cNZet5Qrzd6z8vo6qEIxuXwDxf5pQVm2niGC/JD32W5B5HGESFVjbmGYfwXfD1RDGkbMxDKd47zRegV6QISi2PpZ6bu8RIvo40VEQdGPtZAESIzP2xxFnoC1haPhPq0gEBf3DWNHQjJd++4DPRIetOv2wGwMyiw+SYNc5rAPDB1DBJjrXPrlG58+5wTdv0WFyOjk/HPKVTWqsM/klDuOxwgM0xbFzXH7bQ9pd9PLsN6tL7ypIEBiph8WT1J1zhuKDKC3VtjGrHgpLncu47WqKLq714TzZfWOYj39AyKUf1haqfcsVGlRxzBylYPZzJIlbpmVd0RVU67MR8+V0G4i9/UptGYTsVfcfcqVbK7kB9cqInEuz6/vkyic8YtaEDu5zReCKHpJmvailzusRZB29dxkqym5A38/Ufn7r+CGbWSGpWX8giHoCMbTEsB/R05vPGfdQ67K/N+MlUSymC/xclKaPmNMakohm2qpBXOtO8KzCtRIjTaktypTUg7p46zVGyDMzlk1mSvQvn2kFyDvMWPRSVAkHEep46rgWNqeIx6wOtmtPrZcRorlyOg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23GmvrQD0jGzV9BelBiV8eOdafnq8uK+eiJhcgWmUQOdzwBEmGBoC01q4rQs?=
 =?us-ascii?Q?uiVAq0NF5+a6QtBwhoUhtSbRnct+yNkI8thJubD8rdVsgvI80MgSpp/vr59v?=
 =?us-ascii?Q?tr28io/N4KpqyAJ5zN+hGWc63tI/9aDIKfXVa0vDT/sW47bGUBRoraoLsn8r?=
 =?us-ascii?Q?m2KD+/Goc0046YRUspiDDdZgo1e6kdiWcCSTycNHV9sUxkjuwDZDSOPL0gb8?=
 =?us-ascii?Q?pHmaMOAzSxKolaEGak30lstCYFNRzVIEXW58KKPPe9l8x3RqXIaCOB0pBzHn?=
 =?us-ascii?Q?Up0HjdSKrn63y2QWNSmqNagrtK/cN59JFRa2qcV5so5JMfWBZNybF4C7votR?=
 =?us-ascii?Q?Bl/r+t1aJg/+ekbXyKYeGvuMIkICufJpRFBtTD/GTphhCEOIb8Ru4UqDo3g4?=
 =?us-ascii?Q?tiQ4a95LhO2Yy/osrAJ+xIvhi6kEI52sIMpKjSlrK4Z4jRFOwHv5IaBIbLXj?=
 =?us-ascii?Q?lv6s+WEPygtRT+/hnqUI4fhgiIuw0UICNxd6LwVHZBgAIyYWBJfeUcsZNg29?=
 =?us-ascii?Q?f1167FNBt34J40oOO7iN9SryRGT6kpnYKZGVrvOXxwgxhzOu8rEpyGn6SWuI?=
 =?us-ascii?Q?KRPEBM/K/GANsTfAm38tJi5sVVhEN1O92NRPnKOceSnGVYRTs/+ph6vCIPnm?=
 =?us-ascii?Q?oS7m6MFhVxssuYIBjbU7FCw6geL9Qo3dH6ogrvJFZP2CW7f8jOjuVJePh65c?=
 =?us-ascii?Q?twwb2uL5JqGYNtIH2Q/jwCNaK08I3nopT5UJBAktcn5fj8YfSkn2f4suLrze?=
 =?us-ascii?Q?j9+dIITZupxFlijZ4isrCnPUuEahZUxOZCBMIOoV+2Zp41g67FpAD1FRfBF6?=
 =?us-ascii?Q?woX36axBfF8/zgRJu/6bbGlZLLxIWmsCyyBOV5maK/weZJKu74Q8GehAf6wr?=
 =?us-ascii?Q?jME7V1HkxNfA7f5fEuuQxIqW24mZ/Qidj/RcrK86eTiLZrmNMVKHNZpGdusz?=
 =?us-ascii?Q?WXWUPgtq2b+rYZwnAckVYNV+8zORgKLIHFPwzE/wzTdLY7S3clnK0wmGjmYF?=
 =?us-ascii?Q?TQjVggDMYDYCRvCwtSjqBT2qgsmVENEJWVTfoKO9Gxv9yK2Qd3UaVKsDm4ba?=
 =?us-ascii?Q?0I+DQ5JfUlXEIWeM8qGqjpPuvK4hnxbzdwFSdy7Mfd4AzStYfX9EPDzZkzj6?=
 =?us-ascii?Q?+TeFKdJ6Kt5MIE7GQHpl1bCwFfVBV+O7AW2AGSmn+ihdY/KdM+KvGxaAYSrD?=
 =?us-ascii?Q?gQQb4T+0bx7elhnmIf9QuaF6Em6yed1MntuqsBRixL6Xir/em7LMBTlJWhua?=
 =?us-ascii?Q?+NrBPUIK8J1aFJJTrzUA6kjbezbP0Qpg9UEc8Ak9u4khbI5J2aHJ3c97hsxt?=
 =?us-ascii?Q?+Kr6zsGOOi8DBUks4uE9apmKIkDZoE6lktb2L6ZJXqCohydKtzKtg4B4O36X?=
 =?us-ascii?Q?ptb4/oJ2Qf7N5Pn72/DXcfmPdEO9zvSwutMmKrvPfHbYYesZ+HNOTdKPsquH?=
 =?us-ascii?Q?ewHXhr5B/dMGnGyLIjCfAEWOs6NzyhG7q414eT9hcsLbhrW5tRb9wE5fHzd3?=
 =?us-ascii?Q?GRC7I+R8F2N+iXv4yFGGayCEacQNkg2ZI2+3CP+1wc42/kOFIclWUNF61I4R?=
 =?us-ascii?Q?RQbzDkxCBVG1qoAed213irYdqAH4galvlfn4LHlHCoStsF2FPjY2Dtxm2pgs?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db20667-8fc4-4823-f91c-08dc4456d001
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 18:44:42.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAUKsvdrYBXigks9CzMnqXKWwaKz3XCrbvbugnLjyk3l/3eAhFoBVrHhxdk+msWE3v3VaS420aVFlzGAbmB6cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510


On Thu, 14 Mar, 2024 10:59:43 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 14 Mar 2024 10:01:49 -0700 Rahul Rameshbabu wrote:
>> You need the pad to match with ETHTOOL_A_TS_STAT_PAD (which similar to
>> other ethtool stats currently defined). Otherwise, you run into the
>> following.... mm-stat and fec-stat are good examples.
>
> I don't understand.
> Are you sure you changef the kernel to use uint, rebuilt and
> there is no ETHTOOL_A_TS_STAT_PAD anywhere, anymore?

Sorry, I was not as clear as I could have been with my last reply. I did
leave ETHTOOL_A_TS_STAT_PAD in when I tested (intentionally). I was
trying to mimic other ethtool stats implementations, but you are saying
that in general there is no need for this padding (which I agree with)
and I can remove that unnecessary offset. It'll be different from the
existing stats, but I am ok with that.

--
Thanks,

Rahul Rameshbabu


