Return-Path: <linux-kernel+bounces-99213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 294E78784FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84CB7B21594
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941058AB2;
	Mon, 11 Mar 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="WTTbpKjX"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA24AEEB;
	Mon, 11 Mar 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173870; cv=fail; b=J9T1vLGFqk7cvaFDjaShgAziQZrcCL4/bqzKWOCFge5ndPEhQarBshkKYob1URY2fvnRUAvurWadjSUijD4zPJjwwTNS1QpACRS5z5DuM9Vy4Hg1O9CgVnVrNaV5exNe/qVt0moAN0wHER1FtOS7H/2R59Ch3HyMDtxIcxSXmDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173870; c=relaxed/simple;
	bh=x4HEW0OREup/eDBRIFv0u8UwLQm2d74zi1NAoG0YqWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WdcSFxaJLdnRuduIAWmfhF8+4rOAZoqi88IGUoxf3+DP65a1AROGBA2+OhrYEGBj+AcHo80Tu+bfhJkKAQphHVnJVBBYa2jmoGAaXKKhZeK9QkbCPfsnNnx8Q8aroLdnoY7IzEq4B8uFtu0xwPqAz+iwwgx+egvNmkc+VmvIA+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=WTTbpKjX; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rh2p4H0va+BkaW7r9Jg/6jpCGP6f8w0TqF9O6TwgZ6NtHFZ7VXXsP99/aI9ObiHp4SHPzLbBFw4YHoru1wcnHhXGo5dOP2gUmjiScg7Kb+Jbd+9z4AB1fp2pbbHofU6lDKiZnXcq+nYxKS7xBYaHvAP8qDRMZemhSQDPosiOcOlwNAvp/3gORCLyz6XCRwVG+EFTJOf/U2yU0a3lVGva4xC4vHcMzwWaIAIAngP0P1EWuoHyhDnbpnK9phmEjyKfU0hAJnaNXA0T0uYowMh28jAHAtvnX1/5MQVc73KNehqv0/FHyp2hjAENnn1dEShP6pn4q148+rlSIBXNK1Ru2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4HEW0OREup/eDBRIFv0u8UwLQm2d74zi1NAoG0YqWA=;
 b=jg6iqbTzfnU4W/zQrR3V+oU1HNfOfrjsUaHyembpcbijuJucVOq7dtNtqJ9dhYej1sN3Pc3bd9AbLn/I4gpajD1Nn+6d0FqP5ir11D62IiPLKZCeEeirDK1mUOrVll+m/QPeobLTmG9s4wnDSbsq3DKdqRga6zOX6E/2jesm2bVlx3UncsMoGktcDG7O4evWsLrelFqkRthmkfkV2eEc2LxdxPDrF6/+mcQXpH62AmpFpsIUe1WlTtXzldbCE8+uBqzm668msHjnWzE0M775CnqMmrvYXzbnJZZ/md3InQlb3qUn6Zv+O8/i5ftOgJtGono6spfsRIozKwyaiBXuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4HEW0OREup/eDBRIFv0u8UwLQm2d74zi1NAoG0YqWA=;
 b=WTTbpKjXJVeUxsGPKqVnmTp+ekgP9fHpj8vC4RyADzzESFAr/blmCyGxPdh1uyZlU+LdoOB3+/PAdNZ8fVt9YUZVEs1FJRLzneRQI7zzsdD/VVuM3ul4Ww46XcBo8VuXIuyW9aydy1qFkoGQhlEcaYpNvGvwE6ChRa+GJGLet0tAT5xLqigAqiA+qYg01XzOlfCgNeXgpNrCOSQoHQWTHyqTHjq7EUsov2PM2NUu3AyEk6/LYjXm6gw10T3D+L5MjudeilecHETcAoyZVhlGR5O4xlkyQCo7u8PtNRZM/ED7lmH6glmTCMH7GkEyx0RrG7HOm29dCKeUNTiUBT6mDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by PAXPR07MB7725.eurprd07.prod.outlook.com (2603:10a6:102:15e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 16:17:45 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::995b:5be7:51dd:e540]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::995b:5be7:51dd:e540%4]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:17:45 +0000
Message-ID: <c0001d35-a75a-4cdf-917b-8e1ec159502d@nokia.com>
Date: Mon, 11 Mar 2024 17:17:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <Ze8sl01dgGTLcREs@shell.armlinux.org.uk>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <Ze8sl01dgGTLcREs@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|PAXPR07MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: d2165aba-c1bb-4199-fb19-08dc41e6c907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V+S2OKCjHhmIHqYiV0X5mY8pnb4n5sZsNAqbajYNXqWMJCyLNF3uXGWn3dvRbfWxHLy3vJ//HFMsQXrRHc2WkrwyAm0w+FWS5JT/BlX+NQjHZmTyaHUybWHRfQxZ+XQ/MlBahz3VBbOg1uG/FgeThNxQNxCc0RQyIxgzj0VmHPnnr1NF6qPKwXvW7hnKFBPkWkUVkRCNhGOYL+uiowcmE5jA34V5k2CE1VccR7Ul73ArboFaetqd6izPLEvGe6Q8z1AVYohict/GfskZVHM7hwKxZ0+YFbQv93O8jEJnMRLMgmucuUm+JvKUz7LPnfLBgk+xMKhPNAg1tYcH9uNmgeMydd5OJ8YE+nVx0YQhzP/aJCBxRvdAW0tLBVQ2ftI4ACWiUKQPiRcDgNq2442V3eR1XNbNuaWBgHZohOalKq1So4hd3U7GAb9qYCBBqkgTXtVDeitftbiTpzmh07z+9kj0epFiRzoKPn8BGqLCPpGPYiINL7GHaeoi0ftza9blwIXpDrtk9HUA5iz0n1fWgIOyCo3DRYPJ3bH5xEmXPlXJMzhYuJv1s8WDjLkB4nLKCet6PJrHbah25CoaT82CA0112ngNFUKcBQkFKvtbPxNOUFRnkOtB8wIZc2p1LSK08PkyRFlgqzVaJZEPZKBk4ZXifp0QoTzdYqNocEh4BeA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkJ3aE95RlhyRzF0SzVJaHJZQjBsd0tJY1NtTFRaWjY4MTY1UUhLUWtmZjZZ?=
 =?utf-8?B?VnFDdG5CZ3AzekFySEZLcHltWElad3dGbGJKVG14ZzBBR1d6RE1ITDZVdTY2?=
 =?utf-8?B?M3BGOG9xd0tQSTZDYmFWYkJBVUtHem5uSlNzcXB4bkZvVmZsTWVxemthWVNP?=
 =?utf-8?B?TEt6T0JMVmlZZWZBSnlzd0ZuWE9WMStEazhjcCtnVjUzNXdRVk1uNmdGUWhL?=
 =?utf-8?B?bThTUzU4VG5Yb3RWZnlJc215VHM3Zi9DUjIvOTcyTkQ3V2VrWVF0a1RxRUJo?=
 =?utf-8?B?amZSc20vVGdmR2JzSTNpcUlKVVBrTnc3TysvUGVVOWFUd1hJZkRycEp4ZUNP?=
 =?utf-8?B?d0lDZXJYL1loblViUW1lS0orbGU3dHlybWhjd0NKWjFaN1l0UFBEckVENVFp?=
 =?utf-8?B?S056eFh1RGc3MVlHd3ZUNWFjKzNucENldUhhVUsrT0V1ZHc2Q1lWSTZtQ1JM?=
 =?utf-8?B?TXVXbjNqQXZhdkZqRmlqNUpCSmJXYTFMR2djUzFEa2xUMENXak1hbEtBSFVt?=
 =?utf-8?B?cDJVSGV6eE0yQW9tY0FWSE5wd04yanNpdlg3ZmFoU2dOS2ZZUGVueXFHZHVW?=
 =?utf-8?B?ZjBHTGh4YzUrcEpKQXJadHJRTy9wVzFkdk9qQUw4ZjRxMDlSQ1k4Tm1HRnUv?=
 =?utf-8?B?cTBDWXlrT1pHUTRNWmtwRTRza1MvcTVEVEIzcG5SMWJBdXZNY3FBazY3M1hJ?=
 =?utf-8?B?RDZhdEJybzl3bklCMjVvTnhhamJLaEY2S1pIZmpmMGFMQjdDWDMrTk11MWMv?=
 =?utf-8?B?RkhWTlRRRS82Qk81T2draTI1RjZUYkx5SGZmeGxiVDcyZEQxalN5WllnaDFS?=
 =?utf-8?B?SlBnTWpMQVU4YUNjdnhVMmQ0SStzZzdGaEV3eHpBZ253cys4UHVpN25MRW9k?=
 =?utf-8?B?SE52dUMzLy9zek5Ka0ZrWUY2TElHaXdRSEw0MStXU0E4ZXhUN1FDYzg4dUZU?=
 =?utf-8?B?NFBrMkM0NlFZZ3ltOEhYK203YVFKZTRKOFRLR2VtcTVxVmZ4Vy92aHQyNURu?=
 =?utf-8?B?aHpwQ1Q3SUYxbXQ2d3FMWFMxZVl0TXFLaUpKR2VEMWJpaTVrYm9OUGh4RnR0?=
 =?utf-8?B?VGNpcXA0T04wVnkzV011ZXNMWFB5M1dHOEZIaUJTaUJKRW5ZdVVPNjFFTkxO?=
 =?utf-8?B?UWhkaEtZZVVNaExsNEd1WGlyOGdjMDRWK2dadnV6L0tTZDFpeWUyK0c1a1lF?=
 =?utf-8?B?T1d5VWlId1dvbTNKVFdoMEZjWGZaNjVpamZyNlpOQWt3WTEyV2pUOXg5ejdR?=
 =?utf-8?B?NHpmUEhkTlRFZ2hmZUR6U3NEQk9vRlhYbjRxR3g0SFRxa0VsaHUwdlA1Wkp1?=
 =?utf-8?B?T1o1U3laM2pPY2NndnIvd3pjaS9CR1ZQM3VKTXNUZHBoNng4RVJzbW9HMTlI?=
 =?utf-8?B?NCsxNlZZb1VkbXdwOHFoQTdXZWpBT00wdHFBRnQ0NXhGVngzN0RIczhmNlB3?=
 =?utf-8?B?M055K04yU2xvZ3EwYlVEa2FSVTBPT3VCb2JtTmxqeExsY3JaeXBXK3YvbmdH?=
 =?utf-8?B?NmxNbStnSk5OU3JuQnZ5NjYwZ3llUm5hSFhBNEdrZ1A4L25zd0x5Q3pGeHVC?=
 =?utf-8?B?SHV4WHdreGNYL3JJMk5ldEtkVTM0VFlqblZEUUVTeUdNQmNyU2ZLSkQ3WTVI?=
 =?utf-8?B?NlhTZTVpRXhVdkRIdUxRWUx6Mk9kS0FGLy9KN2N4WFhTak1GNko0SFdqa052?=
 =?utf-8?B?ZDdpYXdWZ0VUQTNObHRpaXYrM3dCbEJ3cmpQYUFlcGhVTFlzQXkvakZnRGJp?=
 =?utf-8?B?TVloNnVGbWM5cGphcXl4WFBWcFQvejIvQ1NOcjlSWXZtTTVtQXZIcGJOS1p1?=
 =?utf-8?B?VFVwc2FSYWhkMVlYeTZsdTRYRmVmeXZma2ZYYS9zejJJQUdIUVhyVjZZRW96?=
 =?utf-8?B?LzZsOWh0bWN0MTZRMG9TTmY3RC9yUyt6TS9LWXRRaGc3eFVWK1JNZHBDYlFO?=
 =?utf-8?B?T0R6Ymc1U1laSWdwSURjOXN5bnJ4Z2U2REFEV3R0dHNYbDlmL1B2REZwS0p4?=
 =?utf-8?B?QkFRU2JMZlc5ZmgxcTBwVzJFZmxRZldGRHo1cHJEd0pubnlXblRYTWk0UEU5?=
 =?utf-8?B?b2ZUdE5QYWNrbVdaQWF3NGhMR1FvUDNVWXNPdXp1TzVQcWFGNXV1bjVRVkJV?=
 =?utf-8?B?VzdDalNVaEdObDBSZENkS3lrcy9BRWxoUWlYVVVCN3lOUkdjdnE3TDQ4M3hz?=
 =?utf-8?B?dk5wNVU1SFlyQUd4TDFvMHo4eVJQd3NjNjhXL3BmeDdkUm1SWDVGb3JiSm84?=
 =?utf-8?B?bDY2TmJPaGpPZmtWWnVkZS9Vc1FRPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2165aba-c1bb-4199-fb19-08dc41e6c907
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:17:45.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYasUfHG+brMLG99N/l92n/79NqePdgfpmk1Z1ZbcwOh/JG2bK8/pRVqI2InQC/AN05YXq+8NR0Ux/gG/4nMo9zNT/sdIKrf21dqDB9JPJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7725

> So what do I do about this? I see you submitted this to the patch system
> on the 8th March, but proposed a different approach on the 9th March. I
> don't see evidence that Paul is happy with the original approach either
> and there's no ack/r-b's on anything here.

I think we need to wait for feedback from Will Deacon regarding the new
arch_spin_lock() based approach. So please abandon the original proposal in the
patch system, at least for now…

