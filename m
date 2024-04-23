Return-Path: <linux-kernel+bounces-154618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99968ADE79
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3AE1C22191
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489D47F64;
	Tue, 23 Apr 2024 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jWeGFyEx"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440147796
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858320; cv=fail; b=TV+9Nis1eCwwK4uTqAm7RH16qK+WG7o+VtDjYt3rHZ0YccYSF+bVk8c4mQpcyRuYLpTozH32JD8JEFVvdmiUh11AQHgwhuB18C66ZNBEcSo+qubctFIoOclmpJ3szGq4gKUIYWBgMizog+vijWgnIyuvYd84fvv6k5UwNrmx2f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858320; c=relaxed/simple;
	bh=mZUWhtV/aYvpnDTW5+tf1GgxrvE3cLGp5BlIxyNl0x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FwPnnkTU4YymbYyIWyt8L3UJU6+jhat0KsyIsf7mkUetyxlobIHr/XN7NApbMyUDV17l5zzeLcSlmn8PzhuJt6Vy7qTw0oPeVDGwy705ioQEGs6ND64ZJjow+IJLjEJj0VJduLU5J0JKiiF43K5jkGcFchmc5NbKWIv6rJTWjSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jWeGFyEx; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkZMr7iX9QPudvb7sdRCkzQQyZjP+9bs8li4Qweo/MzQ7hTZwwDXK6AZIPNGKI/IvIN4HYwZu1pIR7X/65JxFBefs3MRE+z7vjoD6SClulieJycNLxXvQfhpccEevuIXrll2wSuWzQYtTEHFsuQgXtY1NBYE3vf3IRNYb4QG7vcTVvXsBepi5vyJoA2i7/PzTpLDds+POCwUXpmR/9jO0jTVZowK6v4o/fqKYITbZmalZCFkAdX3voDI8/3nPuurzXPSwRQWP9oQIxj+ugYk56oyq2ZkhlHY8Ovs+YxnVjsEh6wbXMMhoUhsoCBQj2GWVaCL5N4Vbqr4dK7gIMCTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8Vq+0NtD40EcrJ5jP36nId25nAD9nqzW5OEWwqX8Kc=;
 b=BiCLZ6TYdec9mX1AUPiuzeZ5xyyFHTMDLmJq/L+2oGhSOcadxji3Cxthznhim7MPFSRT/hvoQLMNBDA0z4TviXXJ6XFl9b8No4ouLiKw5e1KPnaQsyxFkNvmGCDJSbyGpTKOD8v70XqRZlSDeyLrJIJpNsbrbFJRYve4CrU4fiB2OLycy+hRpAGoQQwDqXkcmaJiVE0exYyJtuLBiQHFCpb7U9cUBGj8pSoMs/mRJPUBRoEPlQzcnxUz/hwtBjJDto39LpKOgadQsoPzUyT/wzCjMsNI3wrUykxP+6WkYiplDgi9rs7jciBiInw89eWW78o+zLRJCPZBy8B5D30gpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8Vq+0NtD40EcrJ5jP36nId25nAD9nqzW5OEWwqX8Kc=;
 b=jWeGFyExG/Ixi5iaKYCyqdb5ftWnfXvCE8ZMZQo69SmlPsMd5IdkDWHOf0opuCwG2+0D0G0IaHj0xjY/lgil18D3P5K9f1m2FJnpBllcwM/zgz6/6sdXX1kAXT1BUcWElziov+K9tgdUEjmkzcoT5IdpPJm79ECeKh1DeNhhCMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:45:16 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::7ecf:eda6:7dc7:119]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::7ecf:eda6:7dc7:119%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 07:45:16 +0000
Date: Tue, 23 Apr 2024 09:45:10 +0200
From: Robert Richter <rrichter@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, jgross@suse.com, tglx@linutronix.de,
	x86@kernel.org, Kim Phillips <kim.phillips@amd.com>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
Message-ID: <ZidnBlWbCaMg-UDi@rric.localdomain>
References: <20240403153511.75CB9DA0@davehans-spike.ostc.intel.com>
 <20240416151242.GGZh6VaiO2gC4ej2BT@fat_crate.local>
 <f142e9c4-4829-4ace-8757-485246ad3572@intel.com>
 <20240416174850.GEZh66AmnDjrLxoXaw@fat_crate.local>
 <ZiEMnWaHkn99_oyW@rric.localdomain>
 <20240422172055.GAZiacdxkQU0XAbybW@fat_crate.local>
 <ZibEFZ6DoxDeBxxp@rric.localdomain>
 <20240422204146.GCZibLiqZhbY1J4qFJ@fat_crate.local>
 <ZibW8D9-CTd8G-_v@rric.localdomain>
 <20240422214503.GDZibaX4G2HWQgZuvH@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422214503.GDZibaX4G2HWQgZuvH@fat_crate.local>
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4e9762-e0d5-422f-8d20-08dc636950fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t21euk1LIadqBocVU5eyFY2zpJwffkS/ios/BlgS5F6OxVnRtwS7MmuXm6FE?=
 =?us-ascii?Q?Jz9JXCvXnF0N2mz9oYF4Nw3VsLahtd81okg4CFTntG+HbI3OVrqLrk718brk?=
 =?us-ascii?Q?xVTsIVYJgGexlgfrPEZ6/3/IgLPjXtl2Q7mNlQa5kxAMNSPI4tMHCPyflqDI?=
 =?us-ascii?Q?+PFXlOFR4dvWoPG+0Mx1LUHT/xjwehpv3KNvqpkH0tIps0IEmdhyNbDDZUOx?=
 =?us-ascii?Q?XDpuKoibwaj+mqkSB9KHjTQ2rRO6qcrstV7Xhy7A8zrUbrCYQrKNGd8hkwk7?=
 =?us-ascii?Q?FOriFkIcAyI9loA9+q8jwEV6DSCHvKmlqdmMHFJAIxx0ajwlpnKPnXc+gvAc?=
 =?us-ascii?Q?jSsh99pt66dCNbsMGmzjD+cPqa3+z99ss5k67ApfhnMPdwvojTmUsTU3slqu?=
 =?us-ascii?Q?E/u3Gft11OpSDsf10UjMuRyaqd+m1JKnJ4LydntM9d6IHp1KVmkNeIbA7pev?=
 =?us-ascii?Q?iG8HpWrETIl3IPCt4NWNa5aNkA4g9M63QKvDJ4C41E6dlP9IbWMqYV9jBvi6?=
 =?us-ascii?Q?KALrx82YlTrsL8EaVDlFdEwAEvFyoVtv5MCN9zTH8wO+FANOKvwVr6ElDnOf?=
 =?us-ascii?Q?ALX6efqc3cJxXtGLIdJumRvIDMNcrKLcFWHlPc/ULVU+qowFxCDecGbYluLO?=
 =?us-ascii?Q?jLTlZyr/yhuY0GzLSwTwpHEerj7H29fakyXh9fR2mCw08ARCqSC9rx7hpcT/?=
 =?us-ascii?Q?UpHfFnGXPxrvotZOC/ly3tfmz3tXesGY9wYyPHisXK8ulBvjRb10bVWv6JP5?=
 =?us-ascii?Q?Bf9WWFO/vmqruNwbIW/7cDFb9DzUso5tmbm/5hGglm42orp0+pmL9/hLoxr2?=
 =?us-ascii?Q?kpgsGPAWppbA2wtwroaO77nIk0fHzYf3YvGwqzlgV4wG76ZRblAz0ZC89clL?=
 =?us-ascii?Q?GXd0h3hI8yBj3oJ0gv5egXGXHaxOXxk7ABagKMZtY90xRmV4rz98EEcnQWAC?=
 =?us-ascii?Q?E5G2t42ZBvwq2pvYAvWAr/kF0ADrdhBtvysU6a9VSK2sx9wflMtFPdIM5gVi?=
 =?us-ascii?Q?9ZAIVCIsmDjqE5xzeUW/DMMctmbBqf15vZd/xeb9Ece6tVCGwhkZCSRN7WDO?=
 =?us-ascii?Q?9k9GdzfjZhp53MUlDQtC7w5d4U36ZZiQL2ofXCvFTMH0VyOA7hWESALyiJl+?=
 =?us-ascii?Q?0+TfPucRX0cfSuQkvsESeITv8++D49fgfOOk65sKKPc6EUOc/qQ5M6k1pimA?=
 =?us-ascii?Q?IxhbMijnxPvszartLvVLjJx+wlD5cvGHjfIgJkLqzww+heqpffmcwuTCJkSB?=
 =?us-ascii?Q?PpY1ofV9l/u7mtwci7Ab7jCQr702joF4I51uEI0zpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IoOOZyfB6vsJ04tPR5xlTcXHk0eRL7MJ47wpt1XaCbkCpzJeND3nP52Wlsiq?=
 =?us-ascii?Q?cWe0MwinWynWG22QcHaRE8J2ypqZF6RD0Mz45fDkIcvnZxObRWMe1z56TrSH?=
 =?us-ascii?Q?g6JzkmycIgOp58TjYkgy35+NX7Z1b5O4ew9jiE2zW5WGdZJoe95s2Yd/118j?=
 =?us-ascii?Q?8Sp/fpDXM8B8bcYSi7P/kRLk/p7RE50A2noqe1EBtLrG++ytpZil0tWrtJE6?=
 =?us-ascii?Q?9zMRWlHhsZ42DTHEiHhATQj/Ob8drddxXpqmprJnTsvfEYwvBhjoVFK8H54L?=
 =?us-ascii?Q?/MhSZwv82Z6yrzcC/nIeEbFQuEtMUabU/HE4YMlgPaqH7H0D/kZ8AvFKVhDt?=
 =?us-ascii?Q?HpDEBKrliONG+KouA+5Rek+7LyILmr7cMRprwlM0e7Hx+R30xTXC5zv+RrIH?=
 =?us-ascii?Q?3ZuSlJEojq1hlvFKA3Ztk1UZmwkmzQu7DVc0vM1HvTVbnINZq1AbXOAOX3S1?=
 =?us-ascii?Q?gLHar2SddEZltHRIeSDdfz9GBB+osqV0cxAUlJrYDIWAd2qyTsUinjDWoQP4?=
 =?us-ascii?Q?LiC7DbzVA0cMFFJGA/EVTmJVrj/3KMFUPGjW7S2RJjbdI0w4jg95HPtfZrgq?=
 =?us-ascii?Q?aOb5f+IY5WkqEAja7gZza6+oitb1OMbQiAZmUMJ8NXn/ix6Q7WbNAex09nP9?=
 =?us-ascii?Q?iac7D4LCAY1fquadEWpIkq0IiMGO6cM6fgxVXRfN+qoqqnl33lb2HZjLnYM6?=
 =?us-ascii?Q?Dvrag+vbI61Z6lLjl8ZWlIU9mhh2DlSGhOYlfgqbFbm8V6Bqlr0aCxrorcgN?=
 =?us-ascii?Q?421WymdzbCZe8du+Wm1yFySrg5a1Kqb42jIiP3mOmIf90P7JDFksNNhk6DgK?=
 =?us-ascii?Q?sn0VyzBcTkArB6KVQj3it0KqJ5UNMS6FIMMa4vkgP9CoNn7VIPRtw9oRcg+o?=
 =?us-ascii?Q?jNl40tRKcc2gkLFrIoM5/O50JI1rAXq/8mnjpc2jNtj6yiQkNqOfxvxhFCXK?=
 =?us-ascii?Q?5wpPvT86byHAnC6KSA2A9LUlKbQS+rKFtg8MyAfvjmn1V1mFSJo8iREOfP4l?=
 =?us-ascii?Q?zjLdMQAy/HdM43YLgtlsluWcgx3O9lVzAUIuS5tZW+xC/jgZMSdySUfsrPKV?=
 =?us-ascii?Q?5ODO3hNJQAVH5OKUetokzwLnOXBTXQMPPhJRJ713vjTt0rlpBDT7uKnAQ2Mn?=
 =?us-ascii?Q?wU7HyqqdrDaVkbyJS7ckJ+2NGTX/BLtXXGFSC9W5iDb7nfv2VqnYzPu1wGVE?=
 =?us-ascii?Q?mlEspOvZDxABU8lsaSANwAr1WpjsFPmKdgT96eeiAcM4YB3xzIFzotWyODu2?=
 =?us-ascii?Q?VaQR98bLxIOwfo6Dl/i1sxcEoVW8kEpYG75iPCsiO4M/59J39DZOKEeL1a74?=
 =?us-ascii?Q?EMunYvPgai7ZoiZA/NV9ZkXQucu+n9zZ716dBBKClRTerECtQc91aT8umDKw?=
 =?us-ascii?Q?2pRT+jtRmzFjNyvKXxW6w9nWI5eqEaAXsZ7XsH7MH3dCrZ15SAuePGwuvNdU?=
 =?us-ascii?Q?FZOzlwhgVqPAy+X1tBVWaDDHX5xaeKyfCrXa3hWyqhX6A3Krhj9Xb3XJCLFL?=
 =?us-ascii?Q?j78VtppqIfRyq5GGE/cEZl1zh/aQepjqIU7v3hztBHTxOCQTypSNjRA0i4h4?=
 =?us-ascii?Q?GIeogZjxohcyDklC+zHF57QgghuW/P5AO7js7gia?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4e9762-e0d5-422f-8d20-08dc636950fc
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:45:16.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2brqRCG5o/K/S9ihkUsYWCq7kQBixN/1kLFcArNkBGc0KN4FkXQ4QNHwJ+Tu4qdmuUM+mRtI4VSofMzdeaUWIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418

On 22.04.24 23:45:03, Borislav Petkov wrote:
> On Mon, Apr 22, 2024 at 11:30:24PM +0200, Robert Richter wrote:
> > I mean the case where the cpuid leaf exists but IBS_CAPS_AVAIL is
> > clear. That could be possible with some cpuid override e.g. in virt
> > envs.
> 
> Until there is a valid use case, I don't care.
> 
> > Not on real hardware and if future systems not decide to enable IBS
> > feature bit and clear IBS_CAPS_AVAIL, which could be a valid case IMO.
> 
> Then they get what they ordered and get to keep the pieces.
> 
> We don't support every insane configuration virt comes up with.

I think we can assume/agree that max cpuid leaf will not decrease.
That is, future implementations will contain the IBS leaf (offset
1Bh). Second, if IBS feature bit is cleared, IBS is switched
off. Third, use IBS_CAPS_DEFAULT if the IBS leaf is missing.

Now, we just need to decide one of those for the case where the IBS
cpuid leaf exists and IBS_CAPS_AVAIL is cleared:

1) Apply 0 to caps and entirely disable IBS (my proposal).

2) Apply IBS_CAPS_DEFAULT (originally intended for GH revB) and
   enable IBS with the limited feature set for GH revB (current
   kernel implementation).

I prefer 1) as this applies IBS_CAPS_DEFAULT only if the leaf is
missing which was the original intention of IBS_CAPS_DEFAULT but can
live with 2) as it is implemented now.

Thanks,

-Robert

