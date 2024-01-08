Return-Path: <linux-kernel+bounces-19874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0699E8275FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5572838AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABB053E3A;
	Mon,  8 Jan 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="f6hOR0Rw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EDB53E2A;
	Mon,  8 Jan 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9rWEoMAPvxmhRSlxDSPrczOYWZ2C4pU6KaX5BnNtce2eBzMdzdwz8x9VRTbb1QifOxbttlBRE4Yq2baNZF3I6MX37CbZh8VCdvGEm1xilN9v9RQfRF2v9AaaaNpo3J9yCpDl8L4BEGGpYafaOZ4xtrXszBZ7nG7UEJlIKFa36FiFl56ARqx+T01ndy/+I/KeWX5zz4BPH02kJZiOxABfqkPnl1Dncoks3NmFnS8LG5pM4yzuKLOZQjALtJSHBK9klQQvcuBUX3dr05aRqX2JvUHaxKfZIrMXBKleGJOjh95CFMA+v5ivqmb7kRm6pKrDb3j8QNy4Ua24hSVwfR/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEoSsfRbWtj26Q2RQKpLHi1B5ndwjI52C/k9+njXgXk=;
 b=eJx2gKxNGydorKH63Jxr+O1YXh8Lvgv9TKPRUAQc963tDyqy3eGUPtGyBeRKA6hyCetZTcNOSuf7G1I3wJwvB8THB5Rrm92D7cN9ezZ4FhAZuEPC1elm9Sfiwi9dWxzbf5N0GygZSWDx1mExzrmFhfOqd/KsagW42GlbqZ/XN96+1zfVWGZQi1oC2bz8SQF4Qf5qXvMuPgtjhkAdD/dPgJKtIX/+h7Hz58buG115eZrEGgnPszyZQEUVwcnLOopa7Ug07ptL0fIpIqKqJgGHsBNiFaVZBXcLHGgZydNf6JmLGzSjggN95Krkj43dwSy6JHpI9/evuLYtpiAGKHIQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEoSsfRbWtj26Q2RQKpLHi1B5ndwjI52C/k9+njXgXk=;
 b=f6hOR0RwY4U56q2yo7akLmbmvYzkfBZalIMfEIaQh79aHjNDUzfVWLOdVFk5v3uEQwIpdKIoxt0TibhX2PXfX4FDAmPY2W9EIkjR7hSWNrkG1ag/7V/bdIjn6DQfMzTgFFa44WUPOd+cxDWFWdhKnsQBaLo9JF9WqHgk0mpS9zA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM8PR17MB4918.namprd17.prod.outlook.com (2603:10b6:8:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 17:04:43 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 17:04:43 +0000
Date: Mon, 8 Jan 2024 12:04:34 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"tj@kernel.org" <tj@kernel.org>,
	"john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Wei Xu <weixugc@google.com>,
	Hao Xiang <hao.xiang@bytedance.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
Message-ID: <ZZwrIoP9+ey7rp3C@memverge.com>
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
 <87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZXyQIJOim1+tE0Qr@memverge.com>
 <87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87wmspbpma.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmspbpma.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BY3PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:a03:255::12) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM8PR17MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: 2514978e-f88d-45c2-72ec-08dc106be8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2yxa03Sz0wt/hwnN3qHVA9UtoaKdXetsK/RygeK/QuqjU0lI51EBkCvMW/tZbUUaPh2QiFb1Qp7oNNWCA+gLI4FvsTwyo90pSpxAeZIKy417yTmTCBXwpVvkNBgUZm/hPy02tWC6wLmf8GM7JMh6wSSV/Ilv0ZClvBb3GfH95shyg8O3i3sXyo3u4TCnzGy7sJxyj2vZA4+5EsLDlrmoVhRvRob/HMqOPROhuEIXcmlcyacrpyl/PwZxWejUmCtjpuzw+H7RSjWBJXFEFny5ps/Sc7N4b6B3lFVTQXuNsT9FlMSlw8l80FBCgZTIWuNOv1vJDrbyEgMn1SNWPHOebezbztlREiBXbaw6+WS4IwHaWpSPmD2aKd/a63H78f1hIYG6CA7iFT9rIDkvN0L1vCXjanXYEUx9flYvjChlGHTXcSyxChSTLuB+hRCCMJ63nXklJYOEQzNm/ce9lgqJYcuU4ZC9AqFOfMgi3wlI99xPRI2kpviPqYJZ/eJ8Y1yyzomkAxeFLC7+kEcaQCh+QBwm0Pin8B/F3WvJz68EwLNHVSLBHZ2bHdS4rgEQFyTgAd1UvQ3VztjfeG8cnVDF5QLCgC0JmNejqLCwa3RPFh8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(7416002)(41300700001)(2906002)(6916009)(5660300002)(54906003)(6486002)(44832011)(36756003)(86362001)(6666004)(6506007)(6512007)(316002)(8676002)(8936002)(4326008)(66946007)(66476007)(66556008)(83380400001)(966005)(26005)(478600001)(2616005)(66899024)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D9wFwcSVZg+zID1cfbn9mAap174Ik85HiXOI92X4RCGvjYSIT+SyVexZLEt7?=
 =?us-ascii?Q?P2lypAGc0WWg0njkc51kRMbztMDjHQhOmBpeF52qlh1IVkPvpg9Mzot+q9c+?=
 =?us-ascii?Q?+uPvlCROm0CTJbFEilFWZtCJvdU+hWbb825xob0gN/4DUUSP84f9NTlqMn4Y?=
 =?us-ascii?Q?heCEcp6ah0jgafGbzzwZ9iziMN6pgjBDG0611fGLdfLqvdhSZotPy148umzx?=
 =?us-ascii?Q?cfMV5SOAsLeylipG0JfHTP92cEJGelFo+dEk7ZJ11H1OKYOfrTw9KttGgaP6?=
 =?us-ascii?Q?td4kQNAX0sa+wSSZgq/WVfK7f6nvTPqAbzlEIThH7cPChy5QYfX96UOm0ZPP?=
 =?us-ascii?Q?fWENK2rJwfh2GmakaU9uiqVEB0YRQ09hnIhz6QT0bqbR2pOSHw2ccRbDQgoV?=
 =?us-ascii?Q?TRt1nKvvAAqAFZh/nyDQpkndEXekxbaFvNYiHfOxr67/Vli1hh8MDy5UNxqD?=
 =?us-ascii?Q?8czyPbLJojmFkypDblzPqKZmdCbslGNp77ruTgoBUqpLbUFQwlyuhfM3xtdQ?=
 =?us-ascii?Q?Hr1Jv9LpHpOcJ1ZmoYqlK5J76bcU+nKgZApU4Ve02VbudxpVt4bAJhEtCmXi?=
 =?us-ascii?Q?IMfSzRcHNHg1sArWkKiJqCnzeWK8nlAn0mV/LI44yh2268/DREku0JUMKp5c?=
 =?us-ascii?Q?D4KPlMPFHRcPVPXFbRJuBAqRV+BIVWEClr/3H6t8PBCO79FboIiWO0gX1ZGL?=
 =?us-ascii?Q?bDz3UTwhLw8bLpWHOXih3Q3fWf9ttH+yDTzh0OmpnNddfoMbhY1rDmk8ojyi?=
 =?us-ascii?Q?ANHcnk6sdD1xPAPGYs0WOD3Bft55JiO0fvTZI/kBH/z2XDnKQ7Dm7Rgkq4rC?=
 =?us-ascii?Q?L6+m6G8RYYfR4dCFXPLfmeScoYC2lEG3cnInAwlBSD5PQKYOXNLUFHUaH9vy?=
 =?us-ascii?Q?2ZMnSGeEaEW9g6HQTOdM8/YI1EVLPwlCRwFnZqhYVN8EogVY1IPB10lT5ZUZ?=
 =?us-ascii?Q?r3cXW1JE94MFl8I1yU0zEdfUNwwC5wx64b0wXYUbeiJAllTgHzAgkPq0NdIH?=
 =?us-ascii?Q?khKxyYEQ2WMqcDtmTgtm2l/LDZVTJdNemu6Ht9EgLMUyI0kLAiMYAVn4GuYh?=
 =?us-ascii?Q?1qs54PA2pEN4EhDKdwKfyydG49cCsOi/g+TMPBV2Ue9UNLIuh8zqIRk28SQ6?=
 =?us-ascii?Q?qMzlDCU71SOkjxuT1l56YB5Sa4gIlZTA9uGoPczFiapZc9cNXOZwXUYqhp80?=
 =?us-ascii?Q?ywQ+zvnoCNZjla3IBx0VreVOTNal+03mzvqrMYZ/hFsrjcITMCccOF4wSAN5?=
 =?us-ascii?Q?EIC6bLUki3uO+fXMUMe8ZNRLvmBdWkQeceFJPwVbjOHXYRxRi+5wtvzE1fUE?=
 =?us-ascii?Q?45jQdxh+F2+Dgg2lyNO4K0kpCcVRlC8x10t9A17hmrn1TbcFUmL3bADcemgu?=
 =?us-ascii?Q?5M+2cIdRxiRQSz1H31tA1xhKAK4v6acJEmnHftuhNWfEFW6CDsvaAdlrkLgQ?=
 =?us-ascii?Q?dizEhgl+cH/RTnBsHww7gIs0frMSs9LQh3yQPkzovfhOfXpGgcbNl+aRtxz/?=
 =?us-ascii?Q?SU9nbIyORm6Sg/f05HGV2qcQSc+oS2pQD30fTfCNkt/z26+e7taD+N5LpFt7?=
 =?us-ascii?Q?vGCBGuEq0dHpkGVvYxp6tUjzidQZ+foczSL0+DoYxGwBftKSwNZu8K98tnIX?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2514978e-f88d-45c2-72ec-08dc106be8c9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 17:04:43.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HebD+YOq+L7dOXn4dnxvi9lkWrXru4NTtmBipAFE/9x+iVkrrSIffcOzrX+dAg/cD8nTYVS+4UILTNPFLClUz67c9xrmbLJWHsvltWeZ60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR17MB4918

On Thu, Jan 04, 2024 at 02:05:01PM +0800, Huang, Ying wrote:
> >
> > From  https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf
> > abstract_distance_offset: override by users to deal with firmware issue.
> >
> > say firmware can configure the cxl node into wrong tiers, similar to
> > that it may also configure all cxl nodes into single memtype, hence
> > all these nodes can fall into a single wrong tier.
> > In this case, per node adistance_offset would be good to have ?
> 
> I think that it's better to fix the error firmware if possible.  And
> these are only theoretical, not practical issues.  Do you have some
> practical issues?
> 
> I understand that users may want to move nodes between memory tiers for
> different policy choices.  For that, memory_type based adistance_offset
> should be good.
> 

There's actually an affirmative case to change memory tiering to allow
either movement of nodes between tiers, or at least base placement on
HMAT information. Preferably, membership would be changable to allow
hotplug/DCD to be managed (there's no guarantee that the memory passed
through will always be what HMAT says on initial boot).

https://lore.kernel.org/linux-cxl/CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com/

This group wants to enable passing CXL memory through to KVM/QEMU
(i.e. host CXL expander memory passed through to the guest), and
allow the guest to apply memory tiering.

There are multiple issues with this, presently:

1. The QEMU CXL virtual device is not and probably never will be
   performant enough to be a commodity class virtualization.  The
   reason is that the virtual CXL device is built off the I/O
   virtualization stack, which treats memory accesses as I/O accesses.

   KVM also seems incompatible with the design of the CXL memory device
   in general, but this problem may or may not be a blocker.

   As a result, access to virtual CXL memory device leads to QEMU
   crawling to a halt - and this is unlikely to change.

   There is presently no good way forward to create a performant virtual
   CXL device in QEMU.  This means the memory tiering component in the
   kernel is functionally useless for virtual CXL memory, because...

2. When passing memory through as an explicit NUMA node, but not as
   part of a CXL memory device, the nodes are lumped together in the
   DRAM tier.

None of this has to do with firmware.

Memory-type is an awful way of denoting membership of a tier, but we
have HMAT information that can be passed through via QEMU:

-object memory-backend-ram,size=4G,id=ram-node0 \
-object memory-backend-ram,size=4G,id=ram-node1 \
-numa node,nodeid=0,cpus=0-4,memdev=ram-node0 \
-numa node,initiator=0,nodeid=1,memdev=ram-node1 \
-numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=10 \
-numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=10485760 \
-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=20 \
-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=5242880

Not only would it be nice if we could change tier membership based on
this data, it's realistically the only way to allow guests to accomplish
memory tiering w/ KVM/QEMU and CXL memory passed through to the guest.

~Gregory

