Return-Path: <linux-kernel+bounces-970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F808148B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330B52830AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15822D7A2;
	Fri, 15 Dec 2023 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iynj4Nh1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D0C2DB7D;
	Fri, 15 Dec 2023 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702645499; x=1734181499;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EFeVGqOjsgQ/YJeVSBL34xEMl9zoWv4TmDXAuKWTwGI=;
  b=iynj4Nh1pqticoVMKHl+DtnRwozqqt+fqQjtuLhP4dbbN/Mk4HkFSj2i
   hZ399PzCOiVq0HVDjomiRRQUHhMymbX+L1hYUhsZjrbmIQCR109r+as6e
   XIWslZDy91X/gHzfL0dx9dxN2OPzwglizOgOFZYHSAKtfjdiZHJzE9e3N
   jF59OYZdcP6FuhA4E2qWFuph8VhNxzZAuBtps0KoJxnmKuDPsUufUneJL
   i4kE48Rwli4uOkNVVUF1ockSDjit9CL8W4nVVUuwlBC7fF7dSyIv+JRFk
   nkZCPJZa8FojOXHGt47olQCWWRslQutC6j/y6WAeBJ1+OXVIUhgv94/wQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="398065017"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="log'?scan'208";a="398065017"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 05:04:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="774760649"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="log'?scan'208";a="774760649"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 05:04:58 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 05:04:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 05:04:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 05:04:57 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 05:04:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0VRJHOxEB202hAamBf96uFQ8J2ye6MHmw9//Q1RZ4bAt8FfsDo5CLCeSPs12Ba/s1Eg4iKHrMZbdmM4kJ1pThTORtVlUBwZ+gqNULHLikd52Ch/vNZ2H9T0bDekhFCaQL7nxXEbUdUXryy2uVcxFoYGcyktEU2FqReAq0PjzLcd8JrNldKbMtWwrowrv5ER+k0DCsC6urVcoe1chRtTZ9VTVLgg5/SxLsd+12OvV1/8wSsF2wLx2Za1a5/Voj5A6M0E5SHXzW5NoLPoFr5s6KGnn2mPlsHsbE1y0nelaJbFrB+zAHUSq2hnbdKNVuzsr5E1zg/dyfisSmxb1GBa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqGDmDavCfMVfA8hRiLIGnVZY5Y5M+/KrthLGVBqNx0=;
 b=Dhbvf998KXHO1AeJpNHHQ2pLkr6EF9aLhkbb8dElWVZgEDTbsC9qi9jBLNv/3r8wKkL+NkYbrSTSo2jcOqc+XOq+ApvhJjjkAUc4FEiGBbit5bQwm7/0funNSqIjnqZF16/loNjn4D3ch1wi79+WgiMsR5PxKAA9fGUOh85oaBBPw8fH/NNC8y/0iHwpURy9xCMppXyYXgGTjz3QuyJ8kTJ7Eu78mabZHxtpJnQMm0gj1RuGuYfKqGSdK2tAPeex9qlJ1Z2keTFGfjBz7i3zjgrI2qLTByD848PWYfCNxms59Mri50fItTRUkrZA2m0IjUMX5ulht6vd4hNj/F4XAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 13:04:54 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 13:04:54 +0000
Date: Fri, 15 Dec 2023 20:59:11 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"De Marchi, Lucas" <lucas.demarchi@intel.com>, Mark Rutland
	<mark.rutland@arm.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: perf/urgent] perf: Fix perf_event_validate_size() lockdep
 splat
Message-ID: <ZXxNn6lHPopIxnKr@xpf.sh.intel.com>
References: <20231215112450.3972309-1-mark.rutland@arm.com>
 <170264057897.398.420625380438569608.tip-bot2@tip-bot2>
Content-Type: multipart/mixed; boundary="ITiTr7uqWZkvxSaz"
Content-Disposition: inline
In-Reply-To: <170264057897.398.420625380438569608.tip-bot2@tip-bot2>
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CO6PR11MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 273e1b7d-cfde-41c8-4032-08dbfd6e6e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4Qs+D1F9ToQyuZYXDDDGe4sBRIlgpFty3wX3GG+fDU3dEABeFUfOaim9Ex8Gmn/5ohbIBg0HWYIAlXSHZgYZpPueUMCIuk3U1a7bBTY8fFkU/JvDFjF1wm1bmrcnld+6LseQLJqsPfZkIPgvIEeFKkd5BVvks2Pl8DRpFRhjUGbCKSmOSpaBNAcqDUAhkdtopVtHI47sFfc/EMp1qyEoxG4ruUMpFbM/TgHfiMYOpLeBg4i+aUnmluDBUgNib7wZVPXcrAuAhOMfjN9mvgMHjBpVqEEC58LotWEUdZz/vsp42XmYeXBjFSXS40mwrPdGvzpvRmcrf6VVLCn1AanUJy/QEwwpiXmkhn4IragsGQXJcJshUcE1qme9ydnyiWYkkZqoPo+k3Uy+7CFIu74bSyhPurUPcZauShtryDxzyce+0LJtP7aWIZqbqhfNbDBYUikxq4IuvORLWHiJlAhAQ23lWOGGnqz157c+IgVFVoz1MPmXfng40HsljxOWLGUkb7NMmn2JbELECb7lH7p9kLZVyXScepaliM5qiAZi46rTs+D11S0tLJ+YBmsB2jEUYL83dX/Qz7+gvvceUVdccv/d9sI75y+bGl5A1LR11PpqoZXk9dSMwMVkwFWwhDvPdW7i5c2X03VdkDBh+ykyqN7xbo57bKg8heiP7EvJ0Rz/J6NfSR7J042WXdTCs4T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82960400001)(2906002)(5660300002)(4001150100001)(235185007)(83380400001)(53546011)(6666004)(6506007)(21480400003)(38100700002)(44144004)(26005)(6512007)(478600001)(6916009)(54906003)(66476007)(66556008)(66946007)(6486002)(966005)(41300700001)(86362001)(4326008)(8676002)(8936002)(316002)(44832011)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/CZ3SNm0g4hqd7IByiGNncyfHIu0c3Wuwm6Weteu1LSqD0lvUc6vwHQaSvwk?=
 =?us-ascii?Q?bnJhtFHtFNAzeDLv7+17ngoKO/3tQHBhFj4zBU0F1UtxQFLDZDsQr7DNQ0se?=
 =?us-ascii?Q?rKP11iUriqzc06SUO0UrWUTdn5Vm2GOXxiY9vdv7DnhBy7FxBD8MOR9Jdrzv?=
 =?us-ascii?Q?ynPtD+6Iu5QVNowzqTsHeSmJRjWQ+63qqul2R/b3uNVXSh4PzpKQTlDxtWHB?=
 =?us-ascii?Q?tx4wLFH5+vtbBDHZjqw5M/WI0CPiKF67lqSJaggD6HpaRcfr7cyA8SH8U6AP?=
 =?us-ascii?Q?qLh9d+f2Qbe8KTe5DIh7gYfdGh9N2pcrLGvKV72ubcEy6+vcm2t/v6L4y1a1?=
 =?us-ascii?Q?RqP/yOjjhwCbmLkn5fHAVhhs619n0r1lqLXiYXmnotQ8StFvaJPV7iFqUmu6?=
 =?us-ascii?Q?opUWgW8rwb6MXzWGPxi4+U111pZNF6coaIf9jGH+rjOJ7fQz/MpTYWG4jfE8?=
 =?us-ascii?Q?cy6deopzA5e1rAiLwuKW7MCHUPCNEockjFDCTAKpopiv1oiP+IeI9Qndi6aq?=
 =?us-ascii?Q?JVn9neU4efSdYXh8Goi4vHllnJbLUiQuVuxmc37Zd00RlASK5OtO+fNfAEau?=
 =?us-ascii?Q?1f9M7GK0BDY7Jl95xJMgdIUDv3T/Xx9Tvc+tJ2vdooCqUqhvmS1T4RlsDCwZ?=
 =?us-ascii?Q?bJMevIT1bk8bB9SoY9DWWrlX6yQulbbbXqWMKTWQtYPy8nKbp88VGVimqHdU?=
 =?us-ascii?Q?G7sT0kG1NdTlcvLTn8uLYjU1TqoQIWrrQhI7xpy9wm6I55TqKVHzu6BxuJk+?=
 =?us-ascii?Q?6FbWxM28EVOiz4HuqafwQLr4bhOI8V9w1dcmDNR8rQ9DYqqkleATGXc6U58G?=
 =?us-ascii?Q?OBJLjI0xTD6kADt7OLhoOgJoW9qFSz5m20P1OF2EZH+6WbdEPL6f6af0LKjd?=
 =?us-ascii?Q?eiZxYYGMUMScRhKJ8ZJMnkiIlfDUxX8GF+6ayyOmKiY4Z3lXvHgcKRovt7a+?=
 =?us-ascii?Q?FcHBldMlXOpSG62xCjNGPF+wzpipmguIfGuYNeJneHOa3eih4vZX9NIq/4ME?=
 =?us-ascii?Q?kVR9vDKBnYDHXp4y69HJYyab3i3HClNJhd5rn2MVQQg5uCSF4Kw/GMWhL+pw?=
 =?us-ascii?Q?+GPAPb05ltS2NOoCSVeJLJItOKhoa8qnUsn8cIZYCLjN1C5ABreIPTseTrOs?=
 =?us-ascii?Q?+pb+ioKyfexMRj4rZOK7+UsKEG2TXjZOwXr/TyvYaguftOf39pgGt9KdrhIk?=
 =?us-ascii?Q?drX8PfsdAm3BHbwQYZ0+ln5OMdgmqoD4VpqsE5HekeHGBLt3rJpnLW95JFAc?=
 =?us-ascii?Q?0xpdR2fLgOyUZYVw3c6Ku4KVie6+621Lkljb0jo1eiOWtNy0cy10YO5l3TEy?=
 =?us-ascii?Q?jEv3CE5c+/A5Ry6o3I9dSQTJk1AbbDIl0jBY7FlgXlkRjKW+jqvd02naRT28?=
 =?us-ascii?Q?V2q1nGdfMJ37gUbMg0ytAdz1sA7gtumjs48sU+tXwj84vBpzuScfC9AZasnO?=
 =?us-ascii?Q?Vw9OHHS2iRYPHpQRbwonBDHRGyJbA+NhAbkKkE++Xz18BKcXLnyHkSkDwgzJ?=
 =?us-ascii?Q?8+ATqXCEuhAqsvmYskw7E2gNPsLXpx7Ocjd9Pw7DYRct4N83TS1y7cMmjKTz?=
 =?us-ascii?Q?RPaSRBrDWJB+izU8ARiuDNq+EWC9Pn8jOWYtoItq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 273e1b7d-cfde-41c8-4032-08dbfd6e6e0c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 13:04:54.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBG6ZvYwUUNh0DCK2bk48wXOdCw6aCU4iSlqdlAYuQSB4jNzFE/lCqZT3AWWtQXMiAyaKNg2leQJ+p6Bju/uDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5586
X-OriginatorOrg: intel.com

--ITiTr7uqWZkvxSaz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi,

I tested the following patch on top of v6.7-rc5 kernel.
This perf issue was gone.
It's fixed.
Attached is the fixed dmesg log.

Thanks!


On 2023-12-15 at 19:42:58 +0800, tip-bot2 for Mark Rutland wrote:
> The following commit has been merged into the perf/urgent branch of tip:
> 
> Commit-ID:     7e2c1e4b34f07d9aa8937fab88359d4a0fce468e
> Gitweb:        https://git.kernel.org/tip/7e2c1e4b34f07d9aa8937fab88359d4a0fce468e
> Author:        Mark Rutland <mark.rutland@arm.com>
> AuthorDate:    Fri, 15 Dec 2023 11:24:50 
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 15 Dec 2023 12:33:23 +01:00
> 
> perf: Fix perf_event_validate_size() lockdep splat
> 
> When lockdep is enabled, the for_each_sibling_event(sibling, event)
> macro checks that event->ctx->mutex is held. When creating a new group
> leader event, we call perf_event_validate_size() on a partially
> initialized event where event->ctx is NULL, and so when
> for_each_sibling_event() attempts to check event->ctx->mutex, we get a
> splat, as reported by Lucas De Marchi:
> 
>   WARNING: CPU: 8 PID: 1471 at kernel/events/core.c:1950 __do_sys_perf_event_open+0xf37/0x1080
> 
> This only happens for a new event which is its own group_leader, and in
> this case there cannot be any sibling events. Thus it's safe to skip the
> check for siblings, which avoids having to make invasive and ugly
> changes to for_each_sibling_event().
> 
> Avoid the splat by bailing out early when the new event is its own
> group_leader.
> 
> Fixes: 382c27f4ed28f803 ("perf: Fix perf_event_validate_size()")
> Closes: https://lore.kernel.org/lkml/20231214000620.3081018-1-lucas.demarchi@intel.com/
> Closes: https://lore.kernel.org/lkml/ZXpm6gQ%2Fd59jGsuW@xpf.sh.intel.com/
> Reported-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20231215112450.3972309-1-mark.rutland@arm.com
> ---
>  kernel/events/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c9d123e..9efd0d7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1947,6 +1947,16 @@ static bool perf_event_validate_size(struct perf_event *event)
>  				   group_leader->nr_siblings + 1) > 16*1024)
>  		return false;
>  
> +	/*
> +	 * When creating a new group leader, group_leader->ctx is initialized
> +	 * after the size has been validated, but we cannot safely use
> +	 * for_each_sibling_event() until group_leader->ctx is set. A new group
> +	 * leader cannot have any siblings yet, so we can safely skip checking
> +	 * the non-existent siblings.
> +	 */
> +	if (event == group_leader)
> +		return true;
> +
>  	for_each_sibling_event(sibling, group_leader) {
>  		if (__perf_event_read_size(sibling->attr.read_format,
>  					   group_leader->nr_siblings + 1) > 16*1024)

Tested-by: Pengfei Xu <pengfei.xu@intel.com>


--ITiTr7uqWZkvxSaz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="v6.5-rc7_perf_fix_pass.log"

[root@test ~]# ./repro






ot@test ~]# dmesg
[    0.000000] Linux version 6.7.0-rc5-fix-dirty (root@xpf.sh.intel.com) (gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-20), GNU ld version 2.36.1-2.el8)3
[    0.000000] Command line: console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg  plymouth.enable=0
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] printk: legacy bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000003] kvm-clock: using sched offset of 687721526 cycles
[    0.000535] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.002189] tsc: Detected 1881.600 MHz processor
[    0.008492] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.008520] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.008541] last_pfn = 0x7ffe0 max_arch_pfn = 0x400000000
[    0.009149] MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
[    0.009996] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.014980] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
[    0.015620] Using GB pages for direct mapping
[    0.017888] ACPI: Early table checksum verification disabled
[    0.018467] ACPI: RSDP 0x00000000000F59C0 000014 (v00 BOCHS )
[    0.019059] ACPI: RSDT 0x000000007FFE1951 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.019935] ACPI: FACP 0x000000007FFE17FD 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.020805] ACPI: DSDT 0x000000007FFE0040 0017BD (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.021683] ACPI: FACS 0x000000007FFE0000 000040
[    0.022157] ACPI: APIC 0x000000007FFE1871 000080 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.023019] ACPI: HPET 0x000000007FFE18F1 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.023879] ACPI: WAET 0x000000007FFE1929 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.024741] ACPI: Reserving FACP table memory at [mem 0x7ffe17fd-0x7ffe1870]
[    0.025456] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe17fc]
[    0.026170] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe003f]
[    0.026886] ACPI: Reserving APIC table memory at [mem 0x7ffe1871-0x7ffe18f0]
[    0.027599] ACPI: Reserving HPET table memory at [mem 0x7ffe18f1-0x7ffe1928]
[    0.028309] ACPI: Reserving WAET table memory at [mem 0x7ffe1929-0x7ffe1950]
[    0.029504] No NUMA configuration found
[    0.029896] Faking a node at [mem 0x0000000000000000-0x000000007ffdffff]
[    0.030589] NODE_DATA(0) allocated [mem 0x7ffb5000-0x7ffdffff]
[    0.032521] Zone ranges:
[    0.032783]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.033416]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]
[    0.034038]   Normal   empty
[    0.034331]   Device   empty
[    0.034623] Movable zone start for each node
[    0.035052] Early memory node ranges
[    0.035409]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.036038]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]
[    0.036665] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdffff]
[    0.037703] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.037872] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.063427] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.243588] kasan: KernelAddressSanitizer initialized
[    0.244976] ACPI: PM-Timer IO Port: 0x608
[    0.245406] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.246029] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.246713] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.247330] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.247975] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.248652] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.249347] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.250042] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.250684] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.251211] TSC deadline timer available
[    0.251600] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.252136] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
[    0.252848] kvm-guest: KVM setup pv remote TLB flush
[    0.253361] kvm-guest: setup PV sched yield
[    0.253822] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.254567] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.255311] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.256064] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.256827] [mem 0x80000000-0xfeffbfff] available for PCI devices
[    0.257456] Booting paravirtualized kernel on KVM
[    0.257939] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.258998] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.261319] percpu: Embedded 82 pages/cpu s299008 r8192 d28672 u1048576
[    0.262021] pcpu-alloc: s299008 r8192 d28672 u1048576 alloc=1*2097152
[    0.262036] pcpu-alloc: [0] 0 1 
[    0.262142] kvm-guest: PV spinlocks enabled
[    0.262558] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.263291] Kernel command line: net.ifnames=0 console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg  plymouth.enable=0
[    0.264963] random: crng init done
[    0.266749] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.268435] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.269488] Fallback order for Node 0: 0 
[    0.269504] Built 1 zonelists, mobility grouping on.  Total pages: 515808
[    0.270548] Policy zone: DMA32
[    0.270849] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.271445] stackdepot: allocating hash table via alloc_large_system_hash
[    0.277404] stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.317507] Memory: 1627232K/2096632K available (73728K kernel code, 14095K rwdata, 16700K rodata, 14912K init, 21912K bss, 469144K reserved, 0K)
[    0.320284] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.320937] kmemleak: Kernel memory leak detector disabled
[    0.321664] ftrace: allocating 72459 entries in 284 pages
[    0.347134] ftrace: allocated 284 pages with 4 groups
[    0.351570] Dynamic Preempt: voluntary
[    0.352539] Running RCU self tests
[    0.352883] Running RCU synchronous self tests
[    0.353347] rcu: Preemptible hierarchical RCU implementation.
[    0.353914] rcu:     RCU lockdep checking is enabled.
[    0.354386] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
[    0.355054]  Trampoline variant of Tasks RCU enabled.
[    0.355514]  Rude variant of Tasks RCU enabled.
[    0.355966]  Tracing variant of Tasks RCU enabled.
[    0.356454] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.357228] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.357986] Running RCU synchronous self tests
[    0.402417] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16
[    0.403885] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.412867] Console: colour VGA+ 80x25
[    0.413437] printk: legacy console [ttyS0] enabled
[    0.414554] printk: legacy bootconsole [earlyser0] disabled
[    0.415855] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.416734] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.417236] ... MAX_LOCK_DEPTH:          48
[    0.417719] ... MAX_LOCKDEP_KEYS:        8192
[    0.418221] ... CLASSHASH_SIZE:          4096
[    0.418728] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.419270] ... MAX_LOCKDEP_CHAINS:      65536
[    0.419802] ... CHAINHASH_SIZE:          32768
[    0.420322]  memory used by lock dependency info: 6493 kB
[    0.420946]  memory used for stack traces: 4224 kB
[    0.421517]  per task-struct memory footprint: 1920 bytes
[    0.422321] ACPI: Core revision 20230628
[    0.423464] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.424857] APIC: Switch to symmetric I/O mode setup
[    0.425636] x2apic enabled
[    0.426358] APIC: Switched APIC routing to: physical x2apic
[    0.427037] kvm-guest: APIC: send_IPI_mask() replaced with kvm_send_ipi_mask()
[    0.427888] kvm-guest: APIC: send_IPI_mask_allbutself() replaced with kvm_send_ipi_mask_allbutself()
[    0.429103] kvm-guest: setup PV IPIs
[    0.430868] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.431617] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x363e8c91135, max_idle_ns: 881590568389 ns
[    0.433147] Calibrating delay loop (skipped) preset value.. 3763.20 BogoMIPS (lpj=7526400)
[    0.434614] CPU0: Thermal monitoring enabled (TM1)
[    0.435439] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.436348] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.437117] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.437848] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.438840] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.440163] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.441119] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.442067] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.442937] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.443909] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.444889] MMIO Stale Data: Unknown: No mitigations
[    0.445178] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.446109] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.446853] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.447599] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.449118] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.449860] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.450593] x86/fpu: Enabled xstate features 0x207, context size is 840 bytes, using 'compacted' format.
[    0.584795] Freeing SMP alternatives memory: 56K
[    0.585118] pid_max: default: 32768 minimum: 301
[    0.585989] LSM: initializing lsm=capability,yama,integrity
[    0.586652] Yama: becoming mindful.
[    0.587517] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.588382] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.591253] Running RCU synchronous self tests
[    0.591789] Running RCU synchronous self tests
[    0.594787] smpboot: CPU0: Genuine Intel(R) 0000 (family: 0x6, model: 0xba, stepping: 0x2)
[    0.596956] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    0.597105] RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    0.597272] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    0.598259] Running RCU Tasks wait API self tests
[    0.599075] Running RCU Tasks Rude wait API self tests
[    0.599820] Running RCU Tasks Trace wait API self tests
[    0.600485] Performance Events: unsupported p6 CPU model 186 no PMU driver, software events only.
[    0.601162] signal: max sigframe size: 3632
[    0.601951] rcu: Hierarchical SRCU implementation.
[    0.602522] rcu:     Max phase no-delay instances is 1000.
[    0.605250] Callback from call_rcu_tasks_trace() invoked.
[    0.610604] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.611725] smp: Bringing up secondary CPUs ...
[    0.613436] smpboot: x86: Booting SMP configuration:
[    0.614063] .... node  #0, CPUs:      #1
[    0.614326] smp: Brought up 1 node, 2 CPUs
[    0.614326] smpboot: Max logical packages: 1
[    0.614656] smpboot: Total of 2 processors activated (7526.40 BogoMIPS)
[    0.619161] devtmpfs: initialized
[    0.622064] x86/mm: Memory block size: 128MB
[    0.632095] Running RCU synchronous self tests
[    0.633164] Running RCU synchronous self tests
[    0.633787] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.634919] futex hash table entries: 512 (order: 4, 65536 bytes, linear)
[    0.636463] pinctrl core: initialized pinctrl subsystem

[    0.638422] *************************************************************
[    0.639202] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.639989] **                                                         **
[    0.640768] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    0.641115] **                                                         **
[    0.641893] ** This means that this kernel is built to expose internal **
[    0.642672] ** IOMMU data structures, which may compromise security on **
[    0.643452] ** your system.                                            **
[    0.644241] **                                                         **
[    0.645027] ** If you see this message and you are not debugging the   **
[    0.645126] ** kernel, report this immediately to your vendor!         **
[    0.645908] **                                                         **
[    0.646693] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.647476] *************************************************************
[    0.648382] PM: RTC time: 12:51:22, date: 2023-12-15
[    0.654282] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.656976] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.657156] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.658095] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.659194] audit: initializing netlink subsys (disabled)
[    0.659936] audit: type=2000 audit(1702644683.099:1): state=initialized audit_enabled=0 res=1
[    0.663019] thermal_sys: Registered thermal governor 'fair_share'
[    0.663031] thermal_sys: Registered thermal governor 'bang_bang'
[    0.663814] thermal_sys: Registered thermal governor 'step_wise'
[    0.664512] thermal_sys: Registered thermal governor 'user_space'
[    0.665262] cpuidle: using governor ladder
[    0.666482] cpuidle: using governor menu
[    0.667550] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.669546] PCI: Using configuration type 1 for base access
[    0.671750] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.980364] Callback from call_rcu_tasks_rude() invoked.
[    0.978765] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.980204] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.981149] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.982576] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.993776] ACPI: Added _OSI(Module Device)
[    0.994717] ACPI: Added _OSI(Processor Device)
[    0.995619] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.996620] ACPI: Added _OSI(Processor Aggregator Device)
[    1.058015] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    1.075681] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    1.084028] ACPI: Interpreter enabled
[    1.085209] ACPI: PM: (supports S0 S3 S4 S5)
[    1.086073] ACPI: Using IOAPIC for interrupt routing
[    1.087296] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.089125] PCI: Using E820 reservations for host bridge windows
[    1.094195] ACPI: Enabled 2 GPEs in block 00 to 0F
[    1.298871] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.299790] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI EDR HPX-Type3]
[    1.300775] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    1.301534] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    1.312673] acpiphp: Slot [3] registered
[    1.313425] acpiphp: Slot [4] registered
[    1.314253] acpiphp: Slot [5] registered
[    1.315038] acpiphp: Slot [6] registered
[    1.315810] acpiphp: Slot [7] registered
[    1.316583] acpiphp: Slot [8] registered
[    1.317418] acpiphp: Slot [9] registered
[    1.318193] acpiphp: Slot [10] registered
[    1.319002] acpiphp: Slot [11] registered
[    1.319805] acpiphp: Slot [12] registered
[    1.320627] acpiphp: Slot [13] registered
[    1.321415] acpiphp: Slot [14] registered
[    1.322187] acpiphp: Slot [15] registered
[    1.322966] acpiphp: Slot [16] registered
[    1.323779] acpiphp: Slot [17] registered
[    1.324591] acpiphp: Slot [18] registered
[    1.325384] acpiphp: Slot [19] registered
[    1.326160] acpiphp: Slot [20] registered
[    1.326983] acpiphp: Slot [21] registered
[    1.327808] acpiphp: Slot [22] registered
[    1.328595] acpiphp: Slot [23] registered
[    1.329375] acpiphp: Slot [24] registered
[    1.330184] acpiphp: Slot [25] registered
[    1.330987] acpiphp: Slot [26] registered
[    1.331778] acpiphp: Slot [27] registered
[    1.332576] acpiphp: Slot [28] registered
[    1.333440] acpiphp: Slot [29] registered
[    1.334298] acpiphp: Slot [30] registered
[    1.335090] acpiphp: Slot [31] registered
[    1.335772] PCI host bridge to bus 0000:00
[    1.336299] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.337133] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.337984] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.338906] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebfffff window]
[    1.339834] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    1.340783] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.341509] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    1.367129] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    1.370545] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    1.373567] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    1.375197] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    1.376068] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.376886] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    1.377118] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    1.378758] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    1.379963] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    1.380853] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    1.381995] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    1.389519] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    1.392526] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    1.401630] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    1.402815] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.429598] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    1.431374] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    1.433144] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    1.438071] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    1.479312] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    1.482564] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    1.485730] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    1.488789] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    1.490119] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    1.496751] iommu: Default domain type: Translated
[    1.497118] iommu: DMA domain TLB invalidation policy: lazy mode
[    1.502291] SCSI subsystem initialized
[    1.505106] libata version 3.00 loaded.
[    1.505106] ACPI: bus type USB registered
[    1.505106] usbcore: registered new interface driver usbfs
[    1.505249] usbcore: registered new interface driver hub
[    1.506020] usbcore: registered new device driver usb
[    1.507168] pps_core: LinuxPPS API ver. 1 registered
[    1.507782] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.508944] PTP clock support registered
[    1.513105] EDAC MC: Ver: 3.0.0
[    1.513105] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    1.515651] NetLabel: Initializing
[    1.516138] NetLabel:  domain hash size = 128
[    1.516678] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.517439] NetLabel:  unlabeled traffic allowed by default
[    1.519067] PCI: Using ACPI for IRQ routing
[    1.519604] PCI: pci_cache_line_size set to 64 bytes
[    1.519717] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.519746] e820: reserve RAM buffer [mem 0x7ffe0000-0x7fffffff]
[    1.520243] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.521008] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.521105] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.525132] vgaarb: loaded
[    1.526915] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.527558] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.552797] clocksource: Switched to clocksource kvm-clock
[    2.854929] VFS: Disk quotas dquot_6.6.0
[    2.855635] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.857308] pnp: PnP ACPI init
[    2.858990] pnp 00:02: [dma 2]
[    2.864579] pnp: PnP ACPI: found 6 devices
[    2.884662] Callback from call_rcu_tasks() invoked.
[    2.903979] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    2.908089] NET: Registered PF_INET protocol family
[    2.909354] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    2.911945] tcp_listen_portaddr_hash hash table entries: 1024 (order: 4, 73728 bytes, linear)
[    2.913036] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    2.914120] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    2.915370] TCP bind hash table entries: 16384 (order: 9, 2359296 bytes, linear)
[    2.918665] TCP: Hash tables configured (established 16384 bind 16384)
[    2.919790] UDP hash table entries: 1024 (order: 5, 163840 bytes, linear)
[    2.920788] UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes, linear)
[    2.922168] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    2.924738] RPC: Registered named UNIX socket transport module.
[    2.925478] RPC: Registered udp transport module.
[    2.926045] RPC: Registered tcp transport module.
[    2.926586] RPC: Registered tcp-with-tls transport module.
[    2.927219] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.927988] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.928742] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.929457] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    2.930251] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff window]
[    2.931044] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    2.932470] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    2.933153] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    2.933958] PCI: CLS 0 bytes, default 64
[    2.934557] ACPI: bus type thunderbolt registered
[    2.935744] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x363e8c91135, max_idle_ns: 881590568389 ns
[    2.946364] Initialise system trusted keyrings
[    2.947127] Key type blacklist registered
[    2.948351] workingset: timestamp_bits=36 max_order=19 bucket_order=0
[    2.949713] zbud: loaded
[    2.954683] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.959237] NFS: Registering the id_resolver key type
[    2.960195] Key type id_resolver registered
[    2.960992] Key type id_legacy registered
[    2.961854] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    2.963128] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    2.965183] fuse: init (API version 7.39)
[    2.967272] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
[    2.971900] 9p: Installing v9fs 9p2000 file system support
[    2.991824] Key type asymmetric registered
[    2.992677] Asymmetric key parser 'x509' registered
[    2.993810] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    2.995852] io scheduler mq-deadline registered
[    2.996977] io scheduler bfq registered
[    2.999962] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    3.003910] IPMI message handler: version 39.2
[    3.005019] ipmi device interface
[    3.010217] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    3.012297] ACPI: button: Power Button [PWRF]
[    3.016388] ERST DBG: ERST support is disabled.
[    3.020166] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.021820] serial 00:04: using ACPI '\_SB.PCI0.ISA.COM1' for 'rs485-term' GPIO lookup
[    3.021879] acpi PNP0501:00: GPIO: looking up rs485-term-gpios
[    3.021895] acpi PNP0501:00: GPIO: looking up rs485-term-gpio
[    3.021909] serial 00:04: using lookup tables for GPIO lookup
[    3.021960] serial 00:04: No GPIO consumer rs485-term found
[    3.021974] serial 00:04: using ACPI '\_SB.PCI0.ISA.COM1' for 'rs485-rx-during-tx' GPIO lookup
[    3.022001] acpi PNP0501:00: GPIO: looking up rs485-rx-during-tx-gpios
[    3.022015] acpi PNP0501:00: GPIO: looking up rs485-rx-during-tx-gpio
[    3.022028] serial 00:04: using lookup tables for GPIO lookup
[    3.022040] serial 00:04: No GPIO consumer rs485-rx-during-tx found
[    3.024844] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    3.084046] Linux agpgart interface v0.103
[    3.089620] ACPI: bus type drm_connector registered
[    3.129935] brd: module loaded
[    3.152816] loop: module loaded
[    3.165638] ata_piix 0000:00:01.1: version 2.13
[    3.175449] scsi host0: ata_piix
[    3.179266] scsi host1: ata_piix
[    3.181120] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14 lpm-pol 0
[    3.182458] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15 lpm-pol 0
[    3.186995] mdio_bus fixed-0: using lookup tables for GPIO lookup
[    3.187019] mdio_bus fixed-0: No GPIO consumer reset found
[    3.189116] tun: Universal TUN/TAP device driver, 1.6
[    3.191145] e100: Intel(R) PRO/100 Network Driver
[    3.191722] e100: Copyright(c) 1999-2006 Intel Corporation
[    3.192479] e1000: Intel(R) PRO/1000 Network Driver
[    3.193038] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    3.344966] ata2: found unknown device (class 0)
[    3.346845] ata1: found unknown device (class 0)
[    3.349555] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    3.350950] ata1.00: 17196647 sectors, multi 16: LBA48 
[    3.352691] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    3.358295] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    3.369841] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.371837] sd 0:0:0:0: [sda] 17196647 512-byte logical blocks: (8.80 GB/8.20 GiB)
[    3.373449] sd 0:0:0:0: [sda] Write Protect is off
[    3.374200] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.375493] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.376920] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    3.379037] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    3.390459] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.403689] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[    5.211318] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    5.545091] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    5.545817] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    5.546687] e1000e: Intel(R) PRO/1000 Network Driver
[    5.547157] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    5.547860] igb: Intel(R) Gigabit Ethernet Network Driver
[    5.548366] igb: Copyright (c) 2007-2014 Intel Corporation.
[    5.549201] PPP generic driver version 2.4.2
[    5.551367] VFIO - User Level meta-driver version: 0.3
[    5.554318] usbcore: registered new interface driver uas
[    5.554970] usbcore: registered new interface driver usb-storage
[    5.555950] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    5.558069] serio: i8042 KBD port at 0x60,0x64 irq 1
[    5.558661] serio: i8042 AUX port at 0x60,0x64 irq 12
[    5.561172] mousedev: PS/2 mouse device common for all mice
[    5.564555] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    5.564843] rtc_cmos 00:05: RTC can wake from S4
[    5.568042] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
[    5.571404] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[    5.571787] rtc_cmos 00:05: registered as rtc0
[    5.573464] rtc_cmos 00:05: setting system clock to 2023-12-15T12:51:27 UTC (1702644687)
[    5.574895] rtc_cmos 00:05: using ACPI '\_SB.PCI0.ISA.RTC' for 'wp' GPIO lookup
[    5.574931] acpi PNP0B00:00: GPIO: looking up wp-gpios
[    5.574946] acpi PNP0B00:00: GPIO: looking up wp-gpio
[    5.574958] rtc_cmos 00:05: using lookup tables for GPIO lookup
[    5.574973] rtc_cmos 00:05: No GPIO consumer wp found
[    5.575578] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    5.577052] i2c_dev: i2c /dev entries driver
[    5.578587] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    5.580745] device-mapper: uevent: version 1.0.3
[    5.582706] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    5.583889] intel_pstate: CPU model not supported
[    5.584872] sdhci: Secure Digital Host Controller Interface driver
[    5.585556] sdhci: Copyright(c) Pierre Ossman
[    5.586252] sdhci-pltfm: SDHCI platform and OF driver helper
[    5.587201] ledtrig-cpu: registered to indicate activity on CPUs
[    5.588511] drop_monitor: Initializing network drop monitor service
[    5.589856] NET: Registered PF_INET6 protocol family
[    5.600353] Segment Routing with IPv6
[    5.600953] In-situ OAM (IOAM) with IPv6
[    5.601521] NET: Registered PF_PACKET protocol family
[    5.602609] 9pnet: Installing 9P2000 support
[    5.603672] Key type dns_resolver registered
[    5.608111] IPI shorthand broadcast: enabled
[    5.670395] sched_clock: Marking stable (5652009998, 16434902)->(5683764879, -15319979)
[    5.672707] registered taskstats version 1
[    5.674003] Loading compiled-in X.509 certificates
[    5.737390] Key type .fscrypt registered
[    5.738154] Key type fscrypt-provisioning registered
[    5.747693] Key type encrypted registered
[    5.748313] ima: No TPM chip found, activating TPM-bypass!
[    5.749027] ima: Allocated hash algorithm: sha1
[    5.749698] ima: No architecture policies found
[    5.750492] evm: Initialising EVM extended attributes:
[    5.751078] evm: security.selinux
[    5.751461] evm: security.SMACK64
[    5.751844] evm: security.SMACK64EXEC
[    5.752260] evm: security.SMACK64TRANSMUTE
[    5.752793] evm: security.SMACK64MMAP
[    5.753223] evm: security.apparmor
[    5.753623] evm: security.ima
[    5.753984] evm: security.capability
[    5.754392] evm: HMAC attrs: 0x1
[    5.759153] PM:   Magic number: 3:775:885
[    5.762046] RAS: Correctable Errors collector initialized.
[    5.763756] clk: Disabling unused clocks
[    5.766684] md: Waiting for all devices to be available before autodetect
[    5.767490] md: If you don't use raid, use raid=noautodetect
[    5.768159] md: Autodetecting RAID arrays.
[    5.768724] md: autorun ...
[    5.769070] md: ... autorun DONE.
[    5.787921] EXT4-fs (sda): mounted filesystem 088740a9-c8b4-422c-999d-a804eb68a4da ro with ordered data mode. Quota mode: none.
[    5.789213] VFS: Mounted root (ext4 filesystem) readonly on device 8:0.
[    5.792869] devtmpfs: mounted
[    5.818102] Freeing unused decrypted memory: 2028K
[    5.822351] Freeing unused kernel image (initmem) memory: 14912K
[    5.822962] Write protecting the kernel read-only data: 92160k
[    5.825623] Freeing unused kernel image (rodata/data gap) memory: 1732K
[    5.891038] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    5.891663] Run /sbin/init as init process
[    5.892013]   with arguments:
[    5.892020]     /sbin/init
[    5.892025]   with environment:
[    5.892030]     HOME=/
[    5.892035]     TERM=linux
[    6.158084] systemd[1]: systemd 252-15.el9 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL )
[    6.161817] systemd[1]: Detected virtualization kvm.
[    6.162442] systemd[1]: Detected architecture x86-64.
[    6.173993] systemd[1]: Hostname set to <test>.
[    6.632825] systemd-rc-local-generator[123]: /etc/rc.d/rc.local is not marked executable, skipping.
[    7.132053] systemd[1]: Queued start job for default target Multi-User System.
[    7.156507] systemd[1]: Created slice Virtual Machine and Container Slice.
[    7.165822] systemd[1]: Created slice Slice /system/getty.
[    7.170282] systemd[1]: Created slice Slice /system/modprobe.
[    7.174578] systemd[1]: Created slice Slice /system/serial-getty.
[    7.179963] systemd[1]: Created slice Slice /system/sshd-keygen.
[    7.184079] systemd[1]: Created slice User and Session Slice.
[    7.186554] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    7.190490] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    7.192889] systemd[1]: Reached target Local Integrity Protected Volumes.
[    7.194904] systemd[1]: Reached target Slice Units.
[    7.196380] systemd[1]: Reached target Swaps.
[    7.197818] systemd[1]: Reached target Local Verity Protected Volumes.
[    7.200248] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.203266] systemd[1]: Listening on LVM2 poll daemon socket.
[    7.205209] systemd[1]: multipathd control socket was skipped because of an unmet condition check (ConditionPathExists=/etc/multipath.conf).
[    7.301625] systemd[1]: Listening on RPCbind Server Activation Socket.
[    7.304130] systemd[1]: Reached target RPC Port Mapper.
[    7.310904] systemd[1]: Listening on Process Core Dump Socket.
[    7.313895] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    7.317884] systemd[1]: Listening on Journal Socket (/dev/log).
[    7.321331] systemd[1]: Listening on Journal Socket.
[    7.324768] systemd[1]: Listening on udev Control Socket.
[    7.327505] systemd[1]: Listening on udev Kernel Socket.
[    7.369154] systemd[1]: Mounting Huge Pages File System...
[    7.379868] systemd[1]: Mounting POSIX Message Queue File System...
[    7.397959] systemd[1]: Mounting Kernel Debug File System...
[    7.416605] systemd[1]: Mounting Kernel Trace File System...
[    7.419213] systemd[1]: Kernel Module supporting RPCSEC_GSS was skipped because of an unmet condition check (ConditionPathExists=/etc/krb5.keyta.
[    7.421649] systemd[1]: Create List of Static Device Nodes was skipped because of an unmet condition check (ConditionFileNotEmpty=/lib/modules/6.
[    7.437662] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    7.456811] systemd[1]: Starting Load Kernel Module configfs...
[    7.474150] systemd[1]: Starting Load Kernel Module drm...
[    7.498857] systemd[1]: Starting Load Kernel Module fuse...
[    7.517304] systemd[1]: Starting Read and set NIS domainname from /etc/sysconfig/network...
[    7.564289] systemd[1]: Starting Journal Service...
[    7.613537] systemd[1]: Starting Load Kernel Modules...
[    7.653582] systemd[1]: Starting Generate network units from Kernel command line...
[    7.714292] systemd[1]: Starting Remount Root and Kernel File Systems...
[    7.721733] systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
[    7.769500] systemd[1]: Starting Coldplug All udev Devices...
[    7.822099] systemd[1]: Mounted Huge Pages File System.
[    7.825561] systemd[1]: Mounted POSIX Message Queue File System.
[    7.830906] systemd[1]: Mounted Kernel Debug File System.
[    7.833561] EXT4-fs (sda): re-mounted 088740a9-c8b4-422c-999d-a804eb68a4da r/w. Quota mode: none.
[    7.856062] systemd[1]: Started Journal Service.
[    8.111324] systemd-journald[145]: Received client request to flush runtime journal.
[   13.852812] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX

--ITiTr7uqWZkvxSaz--

