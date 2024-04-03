Return-Path: <linux-kernel+bounces-130638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF5B897AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4307328AA62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B9515687B;
	Wed,  3 Apr 2024 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PetnpU/o"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2098.outbound.protection.outlook.com [40.107.92.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181F2BB02;
	Wed,  3 Apr 2024 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180143; cv=fail; b=a1YCfHk35RSspn1S5zxlXTUm8OjX8aw9d94BKHL6pXhf3I0NWAgXCs12Ub5PmV8v2Jg4pItg9qOehC9U6v2rt/AZ+NOSTWKtkjnIMFx6gnNaD7sDh9P8P3ERe7TXewFjc3DixxCKwwyCtb9+UNpILT8y+TLSh4cP2hCMBvHV2CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180143; c=relaxed/simple;
	bh=pXFxqvj+imfUq5sfwuAekt489TthqcCwSLcLfgpEAb0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=jIlPFpP/m6JbBSDunDzxbF9NI5bc+Vb9ynEsWVOqa5XtWmL++9VqW6XkOJPyZgIwEPqg03Th2wEQPSjo7vc+TUNRmXvtwspYJ+kyx+Qs+Td4JqMb7QJuNW9n+kQvJLjV2WGbZ4aG4iS1gkqlRI1DE+H5doDlVeE0AWUfJpjcsIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PetnpU/o; arc=fail smtp.client-ip=40.107.92.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEuCdvjPOlYtP+UjLi2zX3T/BpEy5EhqBGU6F9Jxts9YKYG1Vjf5lOTO8hG3gXQl+XMvFXDKzIdGbJPQfj5UWd7X4x9VR9gjVnjhnpivta0YjustsH1TGvKfF9ubrxjwOZsYF6rcN0rKAbN9WNjCZE60R/Qfw56GBd0N1yoeiOyKSJLXB+FvZGhSLwDoDRy4MXwCU2CeVFuewRinjtF7f8Ga1jPC3ISWgnovEFdOLHdd8pSrENvLJRSoea0zP8fNAnwieKvijasnjIfnTsQm81AySSn9boM1RJKMziyJdYi9Am5Le14FAuP30nHb/qG0ppo911s+1RQrjOSYd1TMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXFxqvj+imfUq5sfwuAekt489TthqcCwSLcLfgpEAb0=;
 b=mltOKYwYm5QYyGmtq+suVcvygwrPerVRwvMG21pF2bBbURY1Ohm7t0yJDfRS909Fqv1uhlz0nhAKyn5JUN75gfdA0hR2GJGDGxaiu3kG6Zx6vqFrKBPp4fh3jWi6xl18VfvV9Hgj7cpkJZgNfzvLmBpp7bN3q+GxSh/iO02qZI4SFkYYV7eY64eFJwgMVvIJFqXg4APyDRkETNpoIDyJPcWiKoid6ko9hOM2/tc1ghYiXTF9WdzjdrTQdXOnPOiNWuACI+iFCC5O0rlX/E4E6D1oJXMAnUKl+h+7xNxdAbMa9m/PJ0BbpZBvuIM032ZK4KxvxFkZDxeYaNt+KgBtGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXFxqvj+imfUq5sfwuAekt489TthqcCwSLcLfgpEAb0=;
 b=PetnpU/oRwJvEBdKgCVlmcgC9MuCvoHnE/Me653SCKjIZWbo3FklQubuhHlMEUt9le9v9M/Hv84GjP7jJVIm3sRXMZelt1tdFXXbVCVn0S383PvXOxuxWIYHjRh7VDm+p6ccznYROAXMLyS63v7uQxy9oLU+bbegBrvJoP2ewZOvrZoxrgd5w7J1SXScM5Tadl6zpVbVDPgLlgXoVONKdwz9sFzuKOkMnWbjzCjYr+1NK1pgGq3c9EZHdPMUvZP8D0Vd/Hig2zeqSNt3x5v9MvfnV8alOdTIB9HtJofF6Sm2O+BejFrKWI//MVnBrYC6lX7ZV0O8rToMs6/yFRfTig==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 21:35:38 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 21:35:38 +0000
References: <20240403212931.128541-1-rrameshbabu@nvidia.com>
 <20240403212931.128541-7-rrameshbabu@nvidia.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, alexandre.torgue@foss.st.com,
 andrew@lunn.ch, cjubran@nvidia.com, corbet@lwn.net, davem@davemloft.net,
 dtatulea@nvidia.com, edumazet@google.com, gal@nvidia.com,
 hkallweit1@gmail.com, jacob.e.keller@intel.com, jiri@resnulli.us,
 joabreu@synopsys.com, justinstitt@google.com, kory.maincent@bootlin.com,
 kuba@kernel.org, leon@kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 5/6] tools: ynl: ethtool.py: Make tool invokable
 from any CWD
Date: Wed, 03 Apr 2024 14:34:42 -0700
In-reply-to: <20240403212931.128541-7-rrameshbabu@nvidia.com>
Message-ID: <87sf02yvrr.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:40::14) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB8317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8hNRToBg7klJvXL03YWU+OSZT1npUMAlVXwjQhl8Cl8fto8K0PMrXGPu3vkmTdt3BWRNgsB2TzRr4u556okEp0VEo+h1yxwxe9z8WO7kuavcrEdqU3f7QXHHBFjbypsitJjkTKUBOLvuabBSANZIakUKpT6Yv5t5J7EeuBSWF1nbwBeTS6M7abDCS7XQozNQuv0x+JE4AMrqSeyMGB2jhZzYYMq6fglosyb/JRTf7has/g0IHIpN+1MjFKJsaDeMn65122HH0vRQOHAhHE4PWdRTr4vR67mHKs0DaOEV6xlgou4KOUhhRUb5TDNtz5KRD4pwmFmE95YruIAUy66paZk7r/w/YvZDJzLhCEAHypjEbToJu0tlfMqeIgQcdhuc/vU/36KwFAcjk3WuaR49z7uB+Bnm9TbNnridZxVYoW1NyiHhlUb/dqiCz8663ic7zvrKXYxaoMuN0gT7MNq7odEd6Y5eM9+FGsYlCPzeKcLLfI77CKEBltAxbSzCtuq+dijwaspjUt6B/dmUA/FUcYRmaEjGBwh0QWZlhhyUNRewHAtDh3XKlEiQKcvMWTp3cuHQTV1Cp14jkCpx/NWKxKB2DKdyldVYrIJK/P/mibypQD6QyJR3ijmm4qSUTPcgdtGNIkrAmWnyUYdwIxeKueFaFVGDgqa6ug8sWBmb/jE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I6Sj2d6ZZs4vDZgImCnE4tBC0kAdpAU67waN9zQkuEUKWX4CCSAOB5HdFPaV?=
 =?us-ascii?Q?8FyqH8Rl0ES4HhL0Ezde09Ky4LO4mII9nkWUEnlXpsFLEBfNmsyoBrT9P1hn?=
 =?us-ascii?Q?l6bCUvMzsWy00scvpcpPhJV0ifUaAE4XLl4w6bL8rhDnzEVVVtUzBjNt2RpB?=
 =?us-ascii?Q?gtIOb47aYEbUSzmlZVv7BeeuONuT9Cvnd/UmLfmb7rGuKe1YNa9VTYfbSHnm?=
 =?us-ascii?Q?QVgkNt5btWmFsiau6NFllqyhOqUHhGjnq0vh9foR+Z0qMgPwlvfiWPecOXDa?=
 =?us-ascii?Q?Mi6KlGJcZBacrp6cPU/A30fpn2JXQexshMKQAi/CYVwicLu32ELk9Y+3jKTF?=
 =?us-ascii?Q?Jz5oRVFE79PXp8RFV0JYiMRBCNmMOK/UmIbm9bsQ2YID6wtO4l5Xo1rrIBQl?=
 =?us-ascii?Q?cee93JMkFlhm+AE3J5+qnR6pdMazB2/mDenJKLMSt4CIBwueWr+1xbLp47rC?=
 =?us-ascii?Q?sHZidScnTveoyIVsmX4a349RVzdtRtXi4vFvX8WG257W4qFRvoQx4e7veI1U?=
 =?us-ascii?Q?VtOJDBpbvqFdo6XccZtQF4c7rhOLDKE7PzTWMhcwpK2FvzHPzyt8siSB6Ft7?=
 =?us-ascii?Q?TH68ciAeRE16NLUXqBxzNz9OQVpwweOmvp3dfTvtnRXB/hwXK6Opt8gZ+RyM?=
 =?us-ascii?Q?sjzwASHOKHE9xiM4CzYZinuhzxZMABWvNIOk6TviQpkygURkQgqxxs73On/7?=
 =?us-ascii?Q?wWYkrwocKW/W4A3IW2uf0BaG+PNViXqke3HQdAt5vtAGRzBINw3K7jG3hiS/?=
 =?us-ascii?Q?iHF4zpbvGrhbcIz2XmDlvOA0pTL3vvzFPtktOSEp0EhWTrP0fVenKAHV2Uzy?=
 =?us-ascii?Q?wneoj37rdo5vpML5P+0eZ2zJdKg76OaNeiYZURcvE32SLsk9DExgndR4i4gA?=
 =?us-ascii?Q?3JZVDRRdLz+Xo65ZndgCw+T/68OVsOOBQj/2d33sewopVHIqmPR1dcXyA560?=
 =?us-ascii?Q?tL5xKzwBsRIRWco1YCK71IqfvbQXJeuQz19kCzZg1BrPbop8ScS9GNzBpCzj?=
 =?us-ascii?Q?MEGeotxHH54dWHMtEvY+sqw1Q8QmRtuE+NChFcY3Xlb+pT//DcNv6SbK6fgb?=
 =?us-ascii?Q?XcJYuTDK3U5mx3dGkHN4iWmtewFsXiZNdRaWAmM/vW/K2+EszIot2JDTRRPw?=
 =?us-ascii?Q?CDuiFxpq/sSkUIOas+Q+DUd3OZgyZYTWhv8cnP3QF05H0Fn+GSvl62ZnSVse?=
 =?us-ascii?Q?4gdXcBp6TppSxb+DgjiILNy38qVaGFnoZPrMPndJ9lhgzTIZtf9pK+wCMz4S?=
 =?us-ascii?Q?3Fwfz1CHfQQmRpaHI4zkLRTTBPAj9PtHRio4rrUZ35GKaokWtRAkf/gDt0WD?=
 =?us-ascii?Q?ZOSS6UrRKjOqc9DdHM62IlawN+fP1wwjMNg5DIFz2F+hKGGvUvbRj+OfJaAR?=
 =?us-ascii?Q?G51N3aqqk4p7t0P+8bGkKkV0COS6gwhBiBUGft6I85arhSnkTYsaLBx7cnY8?=
 =?us-ascii?Q?qvNg1eHXW6sFOn78VRKgPOotMI4FxavFcLQ7xHfd1uVWxIUxQVWpd1iQyZyS?=
 =?us-ascii?Q?LpWA50wAYY2TqAdMyIVLCtiwZwbzv4FQJVE7fypC/PMkQVxTjN8kemZLuwMH?=
 =?us-ascii?Q?Y35VAzP8UbEHzJy1s2DORZ3mWqIRq36iuBDj5OPrEKaaeXLMH7rgBptAEBp/?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac7c25a-c76a-4524-806d-08dc542600c1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:35:37.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTqh3SFgFIz1VZT2iYl18qMbHCtlEliVhcUUTlwMhczgG5dXhNQvDVSb1FwxjjR8xhf+zdGFB9MR1V5teDJ5TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

On Wed, 03 Apr, 2024 14:28:44 -0700 Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:
> ethtool.py depends on yml files in a specific location of the linux kernel
> tree. Using relative lookup for those files means that ethtool.py would
> need to be run under tools/net/ynl/. Lookup needed yml files without
> depending on the current working directory that ethtool.py is invoked from.
>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> ---

This patch should be dropped. Accidentally had it in my mail queue.

Link: https://lore.kernel.org/netdev/20240402204000.115081-1-rrameshbabu@nvidia.com/

