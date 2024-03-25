Return-Path: <linux-kernel+bounces-117440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A2288AB74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD241F66B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C112CD81;
	Mon, 25 Mar 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VaZVpigT"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50084D25
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383035; cv=fail; b=fdm1KF3q/FgVbhQSTOvKcjO0XOmd2zcJd8YyKWfr28fc6jqO5cTedbjtIFCMnjBGLrrVe2wiRrzFzPiFmYxyiMFBMKfelDpc5b6hiM8Hmq9UqXuMA/FBOzq9wnYUfae3ykYkjxN/IJN+OH5zZ1BLPjl5RsB3zB07R8OFf2/5CwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383035; c=relaxed/simple;
	bh=uCTvZ38N8onetNiAD1Jvbhm4iO6XiRZ2uT4rvWgOOa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZUf0o2oL8ML3yQUpwkl8GViRtaRfEI/C+5Y6w75Da23Wv34MN/pSfrT0IQ8Ithkn4POwMQSOx4/tXzUaKQzc9qZXxEtZuKKrmxeLfghbOXkKvXYhiZ+pEWDOpXSQy2iSfTfnJmoDi4BxGrpd8755eqSqQnR9jJy9Rrkvi/RjJ6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VaZVpigT; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In08BZQXnQc+YwdsPV8hKAVNdDxYQKQSLPSinQPpBccUWHtxhQZg8xEGP9ol0PzhWxTlQ28C6nKGxU+MS0rNe4hJBnAQ0lNMucRO7ATEkOY1RzG5UTN4k54oJ+qFfGUX6XaZwSXXxqxvEHAo+ehCvKqk6negS2basRFfgwQ0SPOkH/SA81lyykY1f839Uk9hznMrxE7GDnuJJdv3nGRk/jGDBMY9VKEkVNKmf74T3jIiulvggB6phNLedOu1uUChH6YPYxPJCA8TNUSMVei0lqH0I24D7E+dxXxiWW+nFhjFt4BUSZ/bsFLS6s0dyX6yB/2BMxF42QU6L/QqijolRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YknwQaQmQroFgMrxAZqjFv0VauM+MzLkQzG02N42Vo=;
 b=fi1+HAeTjKOM2CeojyE0L2kR9sJtlSExJ4313S/KBaMJuE3kOkUyylRC6WQyKBV5CKYdNSFbi3KzXJLlxe6zpg2vskteCxFjXfvaIqS9eNpgUFACtLTH1+kcSmy7Mk1B6YVvDmleZsWLk7HuFeW+RntX2zxihvTm4Z4OraWvX44vlJDfKm7CPHRM/cH8VYRWbv+L/MR2dlnJfQKyWuuykAVMdNtuk+LG4FbhRTi4iqRZX224MYhi4/2cZy+RtqrxyP03oNXzoqcNz3K2JMsG+4M5Sth9OJ74Hmzf10xLmcB/TjMtVmAZPyRydbgCx5oVlW3ggo6IO1a4uI9x7eOSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YknwQaQmQroFgMrxAZqjFv0VauM+MzLkQzG02N42Vo=;
 b=VaZVpigTCFjfn/gRn+vMBoZ4tbgGtqLf4VjNjHZyAzFqa6c/Ugc/97QNg5l9uBBHQlyc6K3XLiibyULyQ4eav9JrI68yg1MIB2gI63ly6O8/ZypsK1p/py4nhEPO6lqCc4sSOYLPtKbncz5MnckFBht1XPQRnCnW+9nHR7qpc4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 BY3PR01MB6724.prod.exchangelabs.com (2603:10b6:a03:369::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.24; Mon, 25 Mar 2024 16:10:29 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 16:10:29 +0000
Date: Mon, 25 Mar 2024 09:10:26 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com, 
	vincent.guittot@linaro.org, sumitg@nvidia.com, yang@os.amperecomputing.com, 
	lihuisong@huawei.com
Subject: Re: [PATCH v3 0/3] Add support for AArch64 AMUv1-based
 arch_freq_get_on_cpu
Message-ID: <5bdlm4kzni6x2bdy7kmmomf7cmyohjhr4nr7v2mb2pchuhkulj@moakmpptnbg5>
References: <20240312083431.3239989-1-beata.michalska@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240312083431.3239989-1-beata.michalska@arm.com>
X-ClientProxiedBy: CH2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:59::27) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|BY3PR01MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: e184b6f7-62ef-4d50-f26d-08dc4ce61715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jsRe2JLHiyoI0IwHbQsALgX2UYO2zJG/NDr7OSWv0vedfTPE5jjoG+6+ohWhPaCu/+WWIxBC9echrvPWe32lk+uOD79SGBoDHP5wJrtHUqMrS53ppT11PvGMEC6LFbwCjCIuhfwgiadPudy2YKbbXu7ANy4/jdKg/tXPJ6Ar+vuqXKhWwlvzBmO/1Y1DlQeqNzoL69LQdpRyU2fQgLmpjqjoUuXL+rcvJSsd12YCVHZjN1c3ta28HXN2/R0IS17to6z0+cJ+33LzE622rEV0zFhDl4Q9cfhiKoTieyyEWLyTZJ0i37MEVign5QjFwWG+4SoDl1jk/G6wOqn42t2ekMuKa6zHeW8RtMQP21LvZHbfKxdBjweG+MFpe41CO0dZm96uC3/DDRGt2jFxB+F0L7OnNjWzgF+Vf5tk0qV09R1CzmrBHdwRrxk+IZZMD66fWkEErczrCeBMXGr75qEhAF2h112v+yRZMjCZzb2Dj21p/T29ZAmHMSZxl8oKh2vcbsq0Jnyj+Ugo4AQWB3yKRv+dVJIbsq/xG9ya2rETpJo+eqh9YIE6/B1nmtG4h92T6uACrFJo8i8iqkih1n10gu4rtCtg+RqHUyNcmiZG0Fbnyg2DZ2TBQQu+jyrLno+966Xy24FIJvTFMACUWqyRU/nMDZ6gxt8ONGueuVv6xnI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cxJ6Xr6jcNtIMNL3cawSdWEBVG6Aq/VtGkVoxFreCQBybS4zUezVEOq9Kmtk?=
 =?us-ascii?Q?Mcsmv5LJapwjmxpzW8976sKOGiO5229cpMp0DKBhBwPmeregdt3bIPYe+lxD?=
 =?us-ascii?Q?YjoqTtCG6o8rQwQIj4Hwf50pmRbvgF13oB2gUPAqLASVCD8dgFCNVeRQk4gr?=
 =?us-ascii?Q?HzzeK5DA8aJ9rCi0EyBVDGgT8QEVY/239YbCE2M1DGewWmdkRsq509W3LM1l?=
 =?us-ascii?Q?W7Sn6BXC+iHaQ4Plk42wp6OJjE1EtoUISTtXCVq7NeWED/XW4X2eWHJnbPGs?=
 =?us-ascii?Q?GJ+P8y8btRllqQXuZu6xS1a/vVdbS3gCNqfe594qUmPvAY9PNYUEHu+wor6w?=
 =?us-ascii?Q?Qo0clE8qDiu+W1rlX9MB+6DvouI4Lt2OPken3ZLJQyvW7RNiO1qJCp+6tneO?=
 =?us-ascii?Q?ey9tbxl9Umnj5yE3a+An5iv0xsmMkFw+osbLlX/kPhYjQByKjbjV8m8snK38?=
 =?us-ascii?Q?NxqPEyLzBNMmqVpzIHx7NzMCjxm+wmmtzczdTTG5AP0fqrcX5C0Mlokx+CyN?=
 =?us-ascii?Q?3tMSpqThatWzdQcw/GH3025ZT8L21bEepkD8WyVp0POOrLXlE5TlwOfq1Kd2?=
 =?us-ascii?Q?jEDIu1urBa9anQEBsH66qWFpYcYtuY9vMN+kqxBQ5Dj8d2j3sWgk5glfbdYH?=
 =?us-ascii?Q?99sZBDfJnTKN6B9QFgckDNj/fAELOziIQCFayrfii+8nUXlTmT/1eqJxhBpU?=
 =?us-ascii?Q?2nWlQb2MPMAJGEGUWbx3GYNVLlGU6dY8Smk/MQeDZxjpLnu8NjAdXvJKAp4v?=
 =?us-ascii?Q?alqG5I0vfUKMz0KQskfKCYjt9r1+d2iuJf5k6CPA1WlT09k4EIULGoBh7XTI?=
 =?us-ascii?Q?m2uTIBA2QpESf8pgkitReHjS5aP6iK6MVTMI5dyosBgub6CYPD3hcKcYtlIL?=
 =?us-ascii?Q?6e/ZslHmFrZ01yv3dA7E1jyVs2L96B6fwaDckGziJgO9ADHjP97qOwKlqlvh?=
 =?us-ascii?Q?crdbaddwHtyXJFS9b3MC8Uo9lt+guUzDR2RhcobA8m6c1VgdVZM8Ms4EuL4B?=
 =?us-ascii?Q?G3HUTc1sNbBhq1aYDv1PEqQxLeaXef4WSFCo7XMqSDu2fyQVrRZLSYv8//Ip?=
 =?us-ascii?Q?77qrL+rjLWPKFbfBTxydJfhUygTdRX6GZGshubQb5TPt/UZkY7mF4Kj/5ssR?=
 =?us-ascii?Q?8ussIVoQvomyE3095aw5Ur+fqLiSmAgM8fx2WivwHLseAAreebG1xKC/Yoav?=
 =?us-ascii?Q?qMkRUea0tLKbd7/EoOJo8A8FCCzohROQdsGnw9l1dy2kjj+O7xlORBpul9pF?=
 =?us-ascii?Q?ksLjdU+bMtG88TzVUjSyovC4ybt0JGhuMv0FSgIKCUFvirY4wFpCBp5dnHtR?=
 =?us-ascii?Q?IQOtSxVP1RiYaWNWuB8IwKNHbsVvQZ0sZTpLmzEytzupTXstlOdeOXOIiJ+P?=
 =?us-ascii?Q?9YxNAT1zvqfZHry00k9+gIpsDU3EFsMbC4LI+0Pck2yJzRA+Csx/NZ0k7QgV?=
 =?us-ascii?Q?2KQ3vCmuL+hGNbjQm3EwiIZD81wrLvuGmvFVHDoP0bTrMyec1JL7uHtbL89w?=
 =?us-ascii?Q?N5TxvLXnDvt8MhIRQhuXaYDnYKpINU02SXdNVB/0+ubnUKhU3Rr0+kVM1ok3?=
 =?us-ascii?Q?2YFQyBRwA5hqNw2P8wYRmDtTJ6hzkCsAzmV6acArVkYL+KGlFpsheSwOQggx?=
 =?us-ascii?Q?XjiaJ68go8ArFpKthrTDfNQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e184b6f7-62ef-4d50-f26d-08dc4ce61715
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 16:10:29.6149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUd67gmX/xxPM7PpYGGRyjaxs41qjwFdiYew88dtkrBH6TtAlEHOqAhdqml5a+Y12EDyrrcKonFPiMskU1lZNi2p6uZ/02Jlvup2fyOq/iwQWrBXXkdKXD9rhtFln0Ya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6724

On Tue, Mar 12, 2024 at 08:34:28AM +0000, Beata Michalska wrote:
>Introducing arm64 specific version of arch_freq_get_on_cpu, cashing on
>existing implementation for FIE and AMUv1 support: the frequency scale
>factor, updated on each sched tick, serves as a base for retrieving
>the frequency for a given CPU, representing an average frequency
>reported between the ticks - thus its accuracy is limited.
>
>The changes have been rather lightly (due to some limitations) tested on
>an FVP model.
>

I tested these changes on an Ampere system. The results from reading
scaling_cur_freq look reasonable in the majority of cases I tested. I
only saw some unexpected behavior with cores that were configured for
no_hz full.

I observed the unexplained behavior when I tested as follows:
1. Run stress on all cores
    stress-ng --cpu 186 --timeout 10m --metrics-brief
2. Observe scaling_cur_freq and cpuinfo_cur_freq for all cores
    scaling_cur_freq values were within a few % of cpuinfo_cur_freq
3. Kill stress test
4. Observe scaling_cur_freq and cpuinfo_cur_freq for all cores
    scaling_cur_freq values were within a few % of cpuinfo_cur_freq for
    most cores except the ones configured with no_hz full.

no_hz full = 122-127
core   scaling_cur_freq  cpuinfo_cur_freq
[122]: 2997070           1000000
[123]: 2997070           1000000
[124]: 3000038           1000000
[125]: 2997070           1000000
[126]: 2997070           1000000
[127]: 2997070           1000000

These values were reflected for multiple seconds. I suspect the cores
entered WFI and there was no update to the scale while those cores were
idle.

Thanks,
Vanshi

