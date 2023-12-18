Return-Path: <linux-kernel+bounces-4366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 664BC817C16
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192D4283B14
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009CF7346C;
	Mon, 18 Dec 2023 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igM9SvtE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9441E52B;
	Mon, 18 Dec 2023 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702932270; x=1734468270;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=WMojkvc00klSVujx2NZPJAcTjoWF0FNAM702hiyN740=;
  b=igM9SvtEr1+vbaOYwLh0rAVbbPq92YtDZE54SQiN5E9kdTwFFWRXquT0
   8IhT5qakZHBpJr+lr6jcpM9DjuktbdR1B8eGZ26YTtWs9oan3bkXAhpMh
   TdxUpj21dogQMSuVqemiQ4g/6H470EDPzHCrpal6Et4WHDh4bVlb6GZqU
   Mibpae0Twd+CDg++RVjAeemZgGG7ID71z2lJCZcdtDmD2mVELgfRSI0Cz
   tVmecS1SXNcXm2JXzYpP8gU3r3/fUHNiZoYqw6XuyanBiMi0OXGB1V6T3
   5u/BRgVjPpO1M2rhsyQ78iyTIkyLfdZgBgpVdqbaV62d9Ncd+PDspU2++
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="380546083"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="380546083"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:44:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="779228643"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="779228643"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 12:44:29 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 12:44:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 12:44:28 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 12:44:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NENhjmkz0Vzu3AesBB/m+NZOJRZMc1qlbpB6UflWykGK8aqRTBj8JhX3kcK+Pi+bSPFac84ZkXwYeohueVYUK/4xWAVCPFm54CSTv37OQsbEYC9/kgbeE73BvRmeuHe29y/I8cJEltKmfjeKJJocy2Ryy5Y11Xnqp2jwy5PLyrRKbm1gCLJhDmxVBfJ9MAagvptrRIYWx1+FvvVrng2+ouh4lZPCwRMoJml9z0Xqtvu4B7I/7p0I1vggQ3xo1FnnXIAbKwAF1FD/OZ38xh/u8lWaPqfho9daQHr19bYYID1PQgZGk7KBIbmgwE9Nzw+zL6WhA8y1aLyjIygKHyCIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAS8ylrjcO3qv8hRt2/nJoMYPDuGU78VneTtoTBzFYg=;
 b=U53uMGbrb8AUV1ftbazG/4yVY9fZL8UszJeBB7U4SrkdFkEdxntgxRLM76xFAsOJTqCsrHWdVTLiyi8sEEj2F8HZVeGLFLauFT8wl8dhs8S9uPgwZhhmfGCeDrvUfa63L3GXwhh2m/4dxqOirEFifPevEZ693tibhGkOVL5Bhk8bj527oTBjy8u9zap3zYcu9T8K+Gglr8xJ4Trb3w6Vt06ePNrWu4thbKkgsVDhj472oGW09bSMACWqe+8RD7XtJa75ZbL1d4/dlzHbvbytWYd8RPBYDx8Xai09XLTp4fr06yvHkc4zMxDsMBUFPY5/jjVAYa3PVQ0jTkU4Vik49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6394.namprd11.prod.outlook.com (2603:10b6:208:3ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 20:44:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 20:44:26 +0000
Message-ID: <c48b24d9-f05f-4c66-a0ca-5cd6f59bea0c@intel.com>
Date: Mon, 18 Dec 2023 12:44:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] octeontx2-af: Fix marking couple of structure as
 __packed
To: Suman Ghosh <sumang@marvell.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<sgoutham@marvell.com>, <sbhatta@marvell.com>, <jerinj@marvell.com>,
	<gakula@marvell.com>, <hkelam@marvell.com>, <lcherian@marvell.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231218082758.247831-1-sumang@marvell.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218082758.247831-1-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0206.namprd04.prod.outlook.com
 (2603:10b6:303:86::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 4570c4d7-e71a-4dbf-a2b7-08dc000a1f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5TYfOIvcFxU0Cxy19iqEye4n8hK/BVvIRyYH48ufCreOG/Dd12jr4aWUhVW4VurUXIQi/cm+3JGwriCUAXEHBnSLYeRqS1v3lMUxMx6bizGLa1aeNN0LfnAqfd3+2XftmYNCn2M3/YbflzdiCcUG8urNL6ZURmOuti1AI1MCRDCqQxgVguhKp+H26ViDETO2UqYwTT4eHmiRtXC69ZOwz94nbscdV6NgjUfmxBjwzf3g2NbKZ23R0JaFb91HFz4szaqoWHNFJw2a2WSruLDrthb8Nu9r9zCme+aXWXQ8JRzy1FIxWcGttWGRTXfu7TCj+InB0/Iizgo0KRLbL2iAEvQy1FIhUOUAOfg8L2zpMF0dRoV9XyRnQnNOCh6K04T8Y2wUhdrPfOa02z1qHXlh0LJgPLo3t/PNOGRx5JTQ3w1n+W/XsD12Mh3KsG5oRzbdVWhNCtZKufV/SAoIHIKMHc3zs5KfZWnp745J9VkL8Ol1IOp8ut7wMam1orJhbFh5YmGOHwAWPxx5gKHMmxvUROQ7At2eGZA+jfBJCbdy3cX1hIM1p14u9Y5Mi64lIbQXfid+z0nC2vECx/T8B00sRIv4AmHUtNBsL1YfzNpTFU7MxWRh/fsmIEYkKqLoc5GxUaSNaxSbx+58qrLtcQC2uo3sD1N1qHHcWw7341gk1YQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(2616005)(6506007)(53546011)(6666004)(6512007)(26005)(921008)(82960400001)(38100700002)(86362001)(31696002)(36756003)(8676002)(8936002)(41300700001)(7416002)(2906002)(478600001)(5660300002)(83380400001)(6486002)(66946007)(66476007)(66556008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3pxKzNKYjgvd3VrZFBjQzdveHo5NjVyQWNDTFJObE9vN3JzTVkzeXJ5cTlC?=
 =?utf-8?B?K3RDUUZQdXRyQ210aThpOERyVkc0NDdaMGN1dCtwdy9nWWxRWEhmK0pQN0wy?=
 =?utf-8?B?cFFPVTRUODFkODJXVTFhQ0JLVU9lK1Z2WVh2LytncEhtc2NhbW5TV2pjNFdG?=
 =?utf-8?B?UUV0QTZid0hrd01zYU5BS2tLN2VDOXR6SjhvV29PMGVpOWl5L2xxa3BrYWVn?=
 =?utf-8?B?UTJ5RDkvLzNXTStTOEM2Sld4WVcxYnZvT2dQTy9uQnlHTFlwWW9qUFZ4a1hJ?=
 =?utf-8?B?Yjd5OU5POUdNSENKamM2YmFGVTJnSGRyZFZpMGZ1K0R5MnQ1MWFZVnZaSWll?=
 =?utf-8?B?SUttSUk3cHdIOXMwSHNub0MwTXFPYi95RXdlZGoydkRVMEpNY0x0dFppdlVR?=
 =?utf-8?B?dkhscXhEbFpBL2RoTUFpQkd0a25EYmJ4cEd5R1pWMk5SVEhDSXFFOEFQRmFR?=
 =?utf-8?B?M1FWKzhJRm9meTAzZ1VXSDZWOWpTTGlNZ1h4dSswYWVxN29wclJXalVXZWJz?=
 =?utf-8?B?MnM5VjRLSnYvZ3cxbjlPUzZEdmZTMVlMUG1vREM2SDYzSi90YlphMHQ1VU5X?=
 =?utf-8?B?YU95QiswZHA2MU1XWEdJUFlzK0NCajNpQ2xxR1FmalpPZHA0SGNvL0dsUWht?=
 =?utf-8?B?dkZuYUhOQ2J0b0FtUHhsN3J3cy9EVy8reDJ3MjZuWXN0V1l2aVY5T2JxcjBQ?=
 =?utf-8?B?Tk5tajZXa1VPY1czZHB0VjdtS3puZkZUTzIvQ1doQUgvQVgrL3AycnpnQTE5?=
 =?utf-8?B?UFBpblVNRGp0MTRoSkQweENyV2hQR2tFUEJrZlB1UUk1REhqbnRZRlRCcis4?=
 =?utf-8?B?TFZ4UkJjd2NHSmdudkM2Wjk4YXBRTE9IN2pjeWloVGRHdDA1RFMxSXdpa3Fo?=
 =?utf-8?B?VDFvdGtxNjVUanZmZWhCK2J0SmZudXlSRENHeXBzZHQxaTR6bVVWR2JQeEhq?=
 =?utf-8?B?eVFDT1pXQU1mMGVDYkVIcEREcGxaL0d3YmJOUkR4ZkFpVDU5Qi81OE1hVEwx?=
 =?utf-8?B?U1dUOTYyamNyejdlRUNjcFV1ck11SGZ2QTZadUNjTTREZGVDTzdDVGVxcUpB?=
 =?utf-8?B?S3pjdHZnR0cvUDhNRFFiTFAzZXU4V0FJZnRLMTVzQmhCajN2V3lYZGpUV1R4?=
 =?utf-8?B?MHdEVEQ3UVIxVVdxR2lFNDBmb09wNEthcEpZQmJlaFUwWnFLaEhiZk8vcVJG?=
 =?utf-8?B?SW9kamxBZEZjUXZRWm8zK0R5WExldVdVa2wzTGNKWnNvc3pZVnJLTE1sbytP?=
 =?utf-8?B?NzNNeW40bWxYZWtKVlVqa2tiOHc4ZlZycjIyWUVMem9yYkFnOEgydnVHaitJ?=
 =?utf-8?B?UkFHSDZXQkVnY0Y2eTJORzU0dVJDYzRzQ05vSDU3R0dzTEFpRitlM2VpZFZV?=
 =?utf-8?B?L0NZWVhNcEFmRHhxYWp5Y0FCcGxTTFBVUzBaZlJ3bEdtZVNlb2Y2c3hyUWhQ?=
 =?utf-8?B?a0gyYXJXQmx6OFl6UW9qckQ3SlluaVJNeUdFWDgxRUtxcUM2VjYwTENvQnZN?=
 =?utf-8?B?Z3lPZCtTUjJVLzBkK0dySjhlaUU1TzN2WEVyYTVHL0FnQUM2MEZQUzlKaHlF?=
 =?utf-8?B?azA0dVNBUTBIQTBnS3FGZVdyYWhwa1pkQ1Y5cklPeHJHYlFDQy90OWJpR1Jo?=
 =?utf-8?B?bTJGT2ZDcEhRYVhPL1hNaHpZaGxoMURSSWl6cjU4a1pISjhjRlNtQ2FkQnZa?=
 =?utf-8?B?SnFReWIwTldQUnZMZnQzMmNENFFHOFlJNGYvSkFycThpRWdadzZrNXRIMlVp?=
 =?utf-8?B?L2J1Y05lTnVtTUd6SXJHNzMxRVJLQlcxMGFWcDhiZ09lZXh5RUpLN1VPWEdD?=
 =?utf-8?B?LzNxdWZ4WU10MkZ5RU0vZDdCRXpqL1d6Z0YraGZIdVlSa0Y5dTBnTUVXalZ5?=
 =?utf-8?B?OWI4WDVlS0p4blFoN3hqTGpuQXlEWk1pdEJpNnZrZGMyS20yT0djOXROVzg3?=
 =?utf-8?B?aGNpZXA4TGNhVHpiQk1Fb1BmdVhzbCtQOWU1TElsU1EzUTFPN3I4S2EwR0xp?=
 =?utf-8?B?aDNwclFxd1lwbWd4L0RBNUdGaGpNdWlabjVKZVpOZUJxZm5lTDRQVUZhSXAv?=
 =?utf-8?B?dVJyZ3NvajVteHkzdExGYXdKeVNuYmcyZXpuZGJ2dWJvQmhZQmtDTWZiRXJT?=
 =?utf-8?B?R3NLVHF0TGZuYytHc3gyUlVWMHExbkpHbUl6NFZTdCtwV3ZIUzdrdjhKK2M1?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4570c4d7-e71a-4dbf-a2b7-08dc000a1f3b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 20:44:25.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YhayzcTHPsroFGqiLUP3FCW6jfBesuuGjkMli2+rB6gEp6xpeJ/AIxFjdsD6oy+kL+gVzCylK86+MWYPLrt35TxsN/G5vE3g/yO9M/1ynY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6394
X-OriginatorOrg: intel.com



On 12/18/2023 12:27 AM, Suman Ghosh wrote:
> Couple of structures was not marked as __packed which may have some
> performance implication. This patch fixes the same and mark them as
> __packed.

Not sure I follow why lack of __packed would have performance
implications? I get that __packed is important to ensure layout is
correct or to ensure the whole structure has the right size rather than
unexpected gaps. I'd guess maybe because the structures size would
include padding without __packed, leading to a lot of gaps when
combining several structures together...

I did test on my system with pahole, and even without __packed, I don't
get any gaps in the npc_lt_def_cfg structure:


> struct npc_lt_def_cfg {
>         struct npc_lt_def          rx_ol2;               /*     0     3 */
>         struct npc_lt_def          rx_oip4;              /*     3     3 */
>         struct npc_lt_def          rx_iip4;              /*     6     3 */
>         struct npc_lt_def          rx_oip6;              /*     9     3 */
>         struct npc_lt_def          rx_iip6;              /*    12     3 */
>         struct npc_lt_def          rx_otcp;              /*    15     3 */
>         struct npc_lt_def          rx_itcp;              /*    18     3 */
>         struct npc_lt_def          rx_oudp;              /*    21     3 */
>         struct npc_lt_def          rx_iudp;              /*    24     3 */
>         struct npc_lt_def          rx_osctp;             /*    27     3 */
>         struct npc_lt_def          rx_isctp;             /*    30     3 */
>         struct npc_lt_def_ipsec    rx_ipsec[2];          /*    33    10 */
>         struct npc_lt_def          pck_ol2;              /*    43     3 */
>         struct npc_lt_def          pck_oip4;             /*    46     3 */
>         struct npc_lt_def          pck_oip6;             /*    49     3 */
>         struct npc_lt_def          pck_iip4;             /*    52     3 */
>         struct npc_lt_def_apad     rx_apad0;             /*    55     4 */
>         struct npc_lt_def_apad     rx_apad1;             /*    59     4 */
>         struct npc_lt_def_color    ovlan;                /*    63     5 */
>         /* --- cacheline 1 boundary (64 bytes) was 4 bytes ago --- */
>         struct npc_lt_def_color    ivlan;                /*    68     5 */
>         struct npc_lt_def_color    rx_gen0_color;        /*    73     5 */
>         struct npc_lt_def_color    rx_gen1_color;        /*    78     5 */
>         struct npc_lt_def_et       rx_et[2];             /*    83    10 */
> 
>         /* size: 93, cachelines: 2, members: 23 */
>         /* last cacheline: 29 bytes */
> };


However that may not be true across all compilers etc. Also all the
other structures are __packed. Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> 
> Fixes: 42006910b5ea ("octeontx2-af: cleanup KPU config data")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/npc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> index ab3e39eef2eb..8c0732c9a7ee 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> @@ -528,7 +528,7 @@ struct npc_lt_def {
>  	u8	ltype_mask;
>  	u8	ltype_match;
>  	u8	lid;
> -};
> +} __packed;
>  
>  struct npc_lt_def_ipsec {
>  	u8	ltype_mask;
> @@ -536,7 +536,7 @@ struct npc_lt_def_ipsec {
>  	u8	lid;
>  	u8	spi_offset;
>  	u8	spi_nz;
> -};
> +} __packed;
>  
>  struct npc_lt_def_apad {
>  	u8	ltype_mask;

