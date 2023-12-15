Return-Path: <linux-kernel+bounces-1438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0870814F12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C681C2459B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058F4134CD;
	Fri, 15 Dec 2023 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="ML3l9Nfi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13A30120;
	Fri, 15 Dec 2023 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GS2gnzJIvVpiUXe21z2Of1uy1st8iHU15YTQ0r+Ejhh6MkoKR3+sAikrnXIP1e89tlMhT85MCk6QTNjC5gNkIW2X27iT4tjw91KQISEgAAMq2EkHbNs5PAHyY7OfjlNwYZnyp3QrUuXefVG2fTRp3JXDLb76hYUYodMLFOe2ClNa6RkYJaCJus9B7g4TYdP8irovcrMf6Fuk3o2KQo7RHcEY6wsI0Z+saIpf10O9m/GL1TlJwtizRBJMbmjFg5VMURUgDH/EQ0MFSdUG8xYkGtw4qyrCnEdY45mVMZnnOmx4IOsJUoQ77KL+YqPvk0j8k8pY8V3KxtJkZt2hFjIuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs8b5T3/it40OjUoOr268t4NxdigYV1DrI7lbLsyghU=;
 b=HrxYfbllUzHIluYZurZqVsqR/jjkfH3TzROxK6oKzKnnsKHs7Mw2Jg8yszekvyUsgXJqJzCavI2AN7drqlms0c3Iq3wWMSfvw8+tXrsRAM75ETQuoPiFtS2vp5pC/yTaGSuicuPSbHXe740Y7M1s50w1t0v2tLJR18UVZPAYV3fgJdAQv6ai+/vwRgicKZMhbxT5GUqwQ5ujtshNZ7K+N1fbnTIutxhi91l6b92fznG483zzRgEYTAXrZmyIxY6kUv8p41r7QhOfrfmUaSzag6K2seUALanvyNihtNnOb/rXLqDoc5Xklb/vOZi7spnFW2ZfDpfQzlBCcd1uR3NVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs8b5T3/it40OjUoOr268t4NxdigYV1DrI7lbLsyghU=;
 b=ML3l9NfiBjm5UEnB0IBxr4wNb2bfy9j4FZTD+LIsNepqVBfHs8WB3mlj2U34Y9/v+ceuzc5+vTzay+MwUGpt/NfY20yt6l7ljP3puTrffdV675mmHRIxus2q1345XSMF8OHc8iFomlcsSoAmmi2zFfBYOWNyzNcFkfwvF8gnEY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BY5PR17MB3873.namprd17.prod.outlook.com (2603:10b6:a03:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.30; Fri, 15 Dec
 2023 17:43:05 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 17:43:04 +0000
Date: Fri, 15 Dec 2023 12:42:56 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: sthanneeru.opensrc@micron.com, linux-cxl@vger.kernel.org,
	linux-mm@kvack.org, sthanneeru@micron.com,
	aneesh.kumar@linux.ibm.com, dan.j.williams@intel.com,
	mhocko@suse.com, tj@kernel.org, john@jagalactic.com,
	emirakhur@micron.com, vtavarespetr@micron.com,
	Ravis.OpenSrc@micron.com, Jonathan.Cameron@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] Node migration between memory tiers
Message-ID: <ZXyQIJOim1+tE0Qr@memverge.com>
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
 <87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BY5PR17MB3873:EE_
X-MS-Office365-Filtering-Correlation-Id: c17b7672-beb9-4748-0847-08dbfd954a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qtNfuqUUGqXw38/361ldaMoSCoW1DFcvLafBgeDBpzcHZlg7JyTsSWKpxmY7pi0g3PqqdPm9j6SjyZnvoCveNYo1rC0aJBt0LbAVefXSyDfi6gsgMtYcKRctJ1lGkKI6FgYwj+KlLNICwJi2sppjo5abmhE9vvh4EtKujhkQS4xfA1qh7VFytgiT9RxrXybsCwzsnopIy4SwTPVI6v7NyRPTG53Y/aszhs4DNYtmcziapNWJ9GTBFjL+g3HgVg8UOk8QLxfrfjQ/MdfHgtlx5cEGO5w0G46fllnAGWaWBjFxw30IvQNamDEKIrLuyXcgRNoHkvn3zPo3NJmIAUE7I6x5BkVDOklt5Dy4QxaM2gNiEhJZFNsVAu+4QjT12xUHHLb1PI/bBTeOonubAgw864Hew3rz+qVwCqHbJWlIOn30zTyQDx+HPL3HhCNS0Dn7nRwT4g+lBxbuNTkExBSUkW27QuejnHJAOxkGo6SuayScYOhMdHejmAbQJZRQStxloqHUZXGRW1s3omo/dd63/mdsGQM3EzdlNs8Bo1TzYwawe1HSi94TaREknnRxoo7EeodnleGAhpuzOC0nHW7ty22o+OudknN+6wXL2tr8qeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39830400003)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66899024)(36756003)(86362001)(38100700002)(316002)(26005)(2616005)(478600001)(6506007)(6666004)(6512007)(8676002)(66946007)(66556008)(66476007)(4326008)(44832011)(6486002)(8936002)(966005)(6916009)(2906002)(41300700001)(5660300002)(7416002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LvHmO1X/jLL9+s8cBAU9ANDDX2acNVj9CPGN+MNUM7u+Ryd6O5R19AaRpaXZ?=
 =?us-ascii?Q?yKhm/kQO9zaDu2IpOIybDh0nYoaod56qOU/7ei+C2Pul0XZ81nQM70d9Upa5?=
 =?us-ascii?Q?zXFLw6jXuk0+vbv+YfmGlWMCgUKxRgv1i6082qEfvI/v3XD/1jk9KK0oaaFO?=
 =?us-ascii?Q?B4M/VuAB+XVp/v6v6R0KdbF+laYGf3Npad7jSfyvYoyhLBYCa5jxMGtdTVXe?=
 =?us-ascii?Q?0k4LzU0yrIvWRr6glDNKuNIwTSCnXAbf+OvbSfu1ToV+4IlshrciJxWXIRoS?=
 =?us-ascii?Q?yEZQgjFUvV/E80jKSgnqrpXzSiS3jaqoiD6gz7an4/4eJeOkde1qbxNEpDP7?=
 =?us-ascii?Q?oWEehBy/cKHDiV6Jm7boL9DMSQkHFgtYYSakq13J4JoIBmv924+Nf0sHJ4nA?=
 =?us-ascii?Q?lr4zTVyOjRi4/uP31p3naYMxDYzLI/3ckapCcnLe7FF9kVP+KLoPmTUJwhhO?=
 =?us-ascii?Q?Gn7yupmz+XqpeaaoO/PmGyHAyIq1FalYnmbbB5Bg2Bp0/kDzA1+ajYS8lrZL?=
 =?us-ascii?Q?B+PZvP0Bb3BsqSHipIc1S+Ta9UPpTmnPNxx+OX79LuLgf7yMPTW2MqiHd0u7?=
 =?us-ascii?Q?83GaiuTvHgJ11iNH45HjxFDHmNvIWibVIG97dy04jQtZDnwF/r4ZTTl5W7EC?=
 =?us-ascii?Q?ihL4BO2bdwPuZQpBgMln47Oe+2ewQhjAosRzetTbgK2+F74MOkCGhIKENss0?=
 =?us-ascii?Q?P+WT7p5cuQYve3XdXopXmm/dnWS46P/v6J3rhBU/DHe+DsMQ3mCfTZRn36OS?=
 =?us-ascii?Q?3tEiyr/EpLbgktGQ3cwWaTz+l7JRzF/JA28f5rVFktGHIOKpbkYGvzDq+fyD?=
 =?us-ascii?Q?hM4QtJr21vm/JNHsE2UIOTyui4Zs0dTmDjjV/99RkE07rtsLmdPOzIa74D3R?=
 =?us-ascii?Q?Ky5yxeXRb9tIlKJl5xrW5QtiSkWuYDQcfjwTFGWjLCcVuxbyQNXXE7BrPl1g?=
 =?us-ascii?Q?YU3LC3bnEcobkuhJ+k9JHaRZLh+PcdVwGZltoMfOhWIiz2OxNTIAxMaEzwkn?=
 =?us-ascii?Q?3iNL+FWgr6HAGFON+j8r2FcCLmEsekTrRExTDN4v8r2AmEuSbFZY5yfkVsbd?=
 =?us-ascii?Q?BITaZZkzHiHTEGUb8scYzJzAv7al7IoDGBJ7MbPgbPohH8/tZznOvgqEkl8x?=
 =?us-ascii?Q?S8JQMZA3DYrSG+xzpUb+KqnuChe+TAK3G0NqAIHky3VVhHPnkKW5E2RDMx8D?=
 =?us-ascii?Q?mJH5zVtgWmuEyvw9Eg72vJSdt47LGB3841UvHFBo8re1VR2/sZh8j92PIjEI?=
 =?us-ascii?Q?YFzdkeQi+521K2GidDs0ucrm5DaUOSvxAIA4qVhrNBzI23wYhapmImjRAowZ?=
 =?us-ascii?Q?1alSfHyeH/RJUhMI8Royn12gztw6+9hv5X1SCgnpy+r4MLdZib+U0roliJxg?=
 =?us-ascii?Q?oikYBK6zwZjZn7Wdnk2TPPN22AB7D68w0X/6LTe1qRWq1gmloIZ9TJbtdmJy?=
 =?us-ascii?Q?9LUUNr2z3LDNynTMZ7CWAJnOBZ62wIU/l1Td/woX6LzIA5BL8NSkY6riQ8hE?=
 =?us-ascii?Q?ETg2z6WJH/EVqE6fS3od0FQu23aoRSPOPr7NdbW+oCrHQzme0V5Vtd7V6U2O?=
 =?us-ascii?Q?DQEynX1dE9rsP5bbImodYBGFuDroGjDrFmmpaoDq2vWiD0TuL6Zy/fE3EoBR?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17b7672-beb9-4748-0847-08dbfd954a49
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:43:04.3528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tyNjT48BM55/16fj+TVk5bU+ZTcsTnQeJZsBgCABQB17Rsa5xcTjoprr1B2x/ouiZlDAwGx4CGG+PDGEso2o+vz3+1TpZIh2FudEdK8Zb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3873

On Fri, Dec 15, 2023 at 01:02:59PM +0800, Huang, Ying wrote:
> <sthanneeru.opensrc@micron.com> writes:
> 
> > =============
> > Version Notes:
> >
> > V2 : Changed interface to memtier_override from adistance_offset.
> > memtier_override was recommended by
> > 1. John Groves <john@jagalactic.com>
> > 2. Ravi Shankar <ravis.opensrc@micron.com>
> > 3. Brice Goglin <Brice.Goglin@inria.fr>
> 
> It appears that you ignored my comments for V1 as follows ...
> 
> https://lore.kernel.org/lkml/87o7f62vur.fsf@yhuang6-desk2.ccr.corp.intel.com/
> https://lore.kernel.org/lkml/87jzpt2ft5.fsf@yhuang6-desk2.ccr.corp.intel.com/
> https://lore.kernel.org/lkml/87a5qp2et0.fsf@yhuang6-desk2.ccr.corp.intel.com/
> 

Not speaking for the group, just chiming in because i'd discussed it
with them.

"Memory Type" is a bit nebulous.  Is a Micron Type-3 with performance X
and an SK Hynix Type-3 with performance Y a "Different type", or are
they the "Same Type" given that they're both Type 3 backed by some form
of DDR?  Is socket placement of those devices relevant for determining
"Type"?  Is whether they are behind a switch relevant for determining
"Type"? "Type" is frustrating when everything we're talking about
managing is "Type-3" with difference performance.

A concrete example:
To the system, a Multi-Headed Single Logical Device (MH-SLD) looks
exactly the same as an standard SLD.  I may want to have some
combination of local memory expansion devices on the majority of my
expansion slots, but reserve 1 slot on each socket for a connection to
the MH-SLD.   As of right now: There is no good way to differentiate the
devices in terms of "Type" - and even if you had that, the tiering
system would still lump them together.

Similarly, an initial run of switches may or may not allow enumeration
of devices behind it (depends on the configuration), so you may end up
with a static numa node that "looks like" another SLD - despite it being
some definition of "GFAM".  Do number of hops matter in determining
"Type"?

So I really don't think "Type" is useful for determining tier placement.

As of right now, the system lumps DRAM nodes as one tier, and pretty
much everything else as "the other tier". To me, this patch set is an
initial pass meant to allow user-control over tier composition while
the internal mechanism is sussed out and the environment develops.

In general, a release valve that lets you redefine tiers is very welcome
for testing and validation of different setups while the industry evolves.

Just my two cents.

~Gregory

> --
> Best Regards,
> Huang, Ying
> 

