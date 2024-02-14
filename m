Return-Path: <linux-kernel+bounces-64896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E43854468
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924BD1F2A7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575012B9E;
	Wed, 14 Feb 2024 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiXtMrR/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB312B88;
	Wed, 14 Feb 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900859; cv=fail; b=H9oYIYxRgfnLd8HzwuJILCU9Y58iegV67QHDwdXe1vemfyMNiz3ZgzyBncZmql/twnuCIDco655v5SLnAZnusBDgBKRN//rNxZFNDq4VbeBKQZ9hNhC9TNI3JCqVY5K337D/Bx27pM7KUXWw1hR9706yAIGltvd5TpvKta4awJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900859; c=relaxed/simple;
	bh=oebu53Kt3p5ZsUubTolXhFKtjmVIZAyujJJtyZhd07A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jfISR5gFNViLHLok4BdpBqZHMMlI6SeePkuAx1flOYO3f/1wNQX6CxuSN//XWm3CDMoXXik4FL6YifkmG7yVqEeE31hmf1heuY+lq/fdVFAhqT3rdrZ+gu3wtRsZj1cZUJa9s+UvklAa+bpr70RhxUnvAqYsab1DYQT8/WyUID4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiXtMrR/; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707900856; x=1739436856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oebu53Kt3p5ZsUubTolXhFKtjmVIZAyujJJtyZhd07A=;
  b=DiXtMrR/s0FlkOgsEls5ZGa+TaNzWcaQ3+18pecX6ZYD3aV+hOm+bHXf
   Obe7bnCtgrfkWwQqBFK8rjv53SQLf1kOw9LhtX1zu9959qGjgE92PvF7d
   5bieCcT0Vbqrto0h49NhwaaGzg/EUgOBT6Q7HbooCz/jCTaOt6u/Q7EBX
   0a6bfh0jTAyDaF5SKpamEikcQRoomfQqIYUDFIPwvGRwOkCmJl3lolJ5j
   /9+0bOGpQjwVexGChTjXAWcAZGYagHm3aYxysW7XpStZljI1A1pdG50WX
   /tH0H4rUFiV+387Dyh15OvP9aS/wFu584PXhwRI5ZS6keQbwCPerkRawK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="4902000"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="4902000"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 00:54:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3034933"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 00:54:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 00:54:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 00:54:14 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 00:54:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbZliMGMaUXJXguE9hZy2ca0PiaEgYr1qTU2YSG6mI/h8qV+qnYEFuQL5Jb9Jg4Zg5hys73TpWiJWvLTHQajzI43MgvAFAtvu8o47dAUFJ0tJnJBojmr2NWkMgvLKXeGkBozC+Nd1JEZc0tGfZv8/jTr04Bf2SAyJ0D3AO8tBVOvUJ/1JAlsSRG8m+42APRvLFBn62oMK6l6St6Jo3dJw8UF94fmnIXPJbWWSVdUZwd7rZ0cQMoHY55reWJsOhPvmrfbDtrvHVEuHPb9vOUrb5/IoHX70tg2tD666MGyvCyPObNGzbWqtqQd03+UVdewwjWTmf17PjmiWm+raFc0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nzfy11Llkre2zzYE59Xp4hMlUE9gE5l7mkLChnCm1pc=;
 b=cphSlUtUoWCIw8HxXPLbcevh64mq5g+xLN6NS68ZhXoT14qchud5Srkgv2a1WxdikSg0gJu6qBzWdoTx5zo72gaE+KtLBUTyQb2xFtcAtXbb76kM7dnxmQWH0chTSrnQjNQn29Z/K52JlrKAKJ4lausgq1GpVOM3fDTrUre5jo7rrV116UCBPVLANe2kQMZRErAA5ydPq8loRQCruKpZ/f4DgUPMqXsAiUpQFRjUelgQfsxV2dV6qA1Gwp6Luu4uGN2B7khegfwB6fcNu9YpMbCBuBCaDD3XA2Boj/knSoP8pi38GLHznPXE/di7c03nAib55L77Q22U4TwE45E7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 08:54:12 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5%4]) with mapi id 15.20.7270.033; Wed, 14 Feb 2024
 08:54:12 +0000
Message-ID: <ef770532-6db6-4262-8225-2d3ee09b7d23@intel.com>
Date: Wed, 14 Feb 2024 00:54:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
Content-Language: en-US
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Dan Williams
	<dan.j.williams@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Dan Middleton
	<dan.middleton@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>
CC: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, <biao.lu@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
 <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
 <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
 <65c691e13a50d_afa42948a@dwillia2-xfh.jf.intel.com.notmuch>
 <226df539-b3f4-4099-b6a6-293fa200c536@intel.com>
 <982e19fcd71c41a162ba664281eb0a68d9dc960c.camel@HansenPartnership.com>
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <982e19fcd71c41a162ba664281eb0a68d9dc960c.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:303:b5::27) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|PH7PR11MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: b8869869-e2e8-489d-d670-08dc2d3a838b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tfYeZ0WGUR1eCSUzjI45JKq8IVV8FDHjlaAOt2shkBpwbr9RDMw2JZvPYPhWaebFuGrPhCDirwLfa+Wgj1FD/1eVZizKETO0vO+FrwIHQwuR4aSE221fZ97V3Ff272x5eYpFXR+AOBzj90QQwrt8+wnvyMBOzK4Pw3302TtaZXZYVIEx/Bxp1WYiMw8bB6yLiYooB48NXPF0AL3vbA4gTbsDvSejSLhYTxAQuk2J+sGd+j6eeSPXjprQH2CWUWdkq6nh/mXk2tEK/uUIjEhKrPEZHupLgSx/EHhZTgRdxjtA0gPv3tRZT/4yfezkATTRdLUSf5INLqgboVa2ZvefHXXIfnLumhhu6cOvSOL4kEH7O927BwBmBY8ILJrVU8FmZL3bebWaTaqsMgoWpUumR581vCy00UdCE3XttUU2cQeF2LZgeYErXQadTuorex9yNGhQ7vdrFs+HNppbmnK1piiceATvpursytZanxyYxJVm7k1nWrFmsoupt7EBtZZOib/U3gCIUG0ynn2+bB57L7weLHsBjmt/4O1u28E+0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(2906002)(2616005)(53546011)(6506007)(8936002)(83380400001)(66476007)(5660300002)(6512007)(66556008)(8676002)(4326008)(66946007)(26005)(36756003)(41300700001)(478600001)(966005)(54906003)(110136005)(6486002)(6666004)(316002)(38100700002)(86362001)(31696002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2RLZmFxeVlRQ2VleGhLZFMzNW94ay9tRFlTN0t2bzRxNjhoSnQzZ1NxV1ZT?=
 =?utf-8?B?eXFHanpKakpRa1ZiWE1ibitnZTNlL2xoelhKOTdhWmdOek5BeFo2QmJLNW40?=
 =?utf-8?B?ZG9yenRHVytFeEJRbEpaTnhDWURlZ0FYSHREcFNsK1A2WGp6ZXR0bTF5UXFP?=
 =?utf-8?B?SE5ia0NQWHBWYW1YdjcvekxCMTNGSG13eHRJdjNHT0Z5MkplTkh3eDcxazEx?=
 =?utf-8?B?Tk9ONmRhczRGZHR5MmJyL0hZRURqRmw2Z1V4bko4MXRWUys0MlRwdXRSQlEv?=
 =?utf-8?B?S0dXRmhKUUdWTE5kWEkveGljT1NzSlZ1ODZwK0tleERQUVU4REZkN1liWHlH?=
 =?utf-8?B?S0lwMkRWNVd6UE4rTHlOV2pBWWpjNTI3eTJ1Z29iLzRPU3hnckpxOGVTTUNa?=
 =?utf-8?B?Vjc0TW80MHgramJJbTdOODZNdG91aTF3ZUF0U1JOaFk1dGh6MCtUSmpzTnV4?=
 =?utf-8?B?RWVYN3AzbnJuVmRaakJYMU1pS2ovcWpnRXhNZFBmZVdKQ0FBUUdxNS9UZjhz?=
 =?utf-8?B?M2lOdXI4aTk4T2xyWUo1OUFKSWVnQTFNbGV2SGlRbjhqOC9uR2k2c0tkYmtl?=
 =?utf-8?B?NjFjdFEyazN1VnVnbnJRSldETWk5Q3p4WHEvT1VyOTk1WHkzMnYrbzZmQWtS?=
 =?utf-8?B?Z1o0RVdCWWZCTHNPK0djOXU5eDc4cTRTRDVQeDhieE9KcEtjeldZcHdXakNG?=
 =?utf-8?B?NGgwbTFzM0cwNC9sbk5wSTdtYTRQb3QxYzZVQTNWWElDYmtSVmdTZTRJM2xO?=
 =?utf-8?B?eFlpUnM4UmIxZkIrL0pLZ0cxUEtnQlVJWGxWNG00RjkrUEU0YjJlMVdoU3Jq?=
 =?utf-8?B?MHFmQzVNTytoU0Y1YkxVQjNYdHhSWWhMRW9yOHRha0Y2Zmh6aTdvUW9EUy9o?=
 =?utf-8?B?dU1wZ2VsWHR1dktWVnJEYXI5azI1WmVWeDhqK1U4MWVraCs3ajVPRUdpcW5m?=
 =?utf-8?B?cWExYnJma2k4aHVHUEwzaWJiUmM0eGlIaWk5RVBQQkpaTFdZaThLelFtclpw?=
 =?utf-8?B?TmIvYzI4K3RGd3pnK2hpQ3R4aWVGWlNKVEZ0ZnFKSFdWTUx5a0FhblQ3bENv?=
 =?utf-8?B?MVhHZmowT29JQU5YekpkMk5aNEI4bnRzUFdjc2MyWlMyYk5iczRsd29FY0My?=
 =?utf-8?B?TjIzZCtTR2ZVNTRQaXpEMis2YU8xM2hwaklBTGN3ajMvektzWGVoQ3JDY3Rr?=
 =?utf-8?B?ZHRyS2Y0dlRnZjFQbHl1MFJxUm1JYXlHeE5yQStGd0h1bU1JcXB3U1FkZ3VU?=
 =?utf-8?B?ZmNXWmIwWnc4ZGpZMUFqYUFFQzVXTHN6VDJIWjVYOEQ2RHUxMW9VRVE5eVBI?=
 =?utf-8?B?N040M2Rwd3hUTmMzdHBtWTNrWWpROEt2ODd1RDNxWFpHWlpkRGZFK05ocW9D?=
 =?utf-8?B?bjE4V1c4eDg2cWhGYmhoMlBSY3pDZndhRzAxUWFBcFAvUFR2c3g0YzVuM0x0?=
 =?utf-8?B?ZHB4WktJcXZKOVlxUDlMOTVLYlZ1OHlZQ0hVZDdLS2czVnJENEEwZS90VFB4?=
 =?utf-8?B?VWhnRjhyTWUwcHlSTDQwTi95ZUpNOXo4ZWZCcEZySTEvNmhVazFiay9GdCti?=
 =?utf-8?B?MHlGTkpwUTcyMEhUYXVXMDIyYUI4NnVoeWk2UkY4L2crR3FBMWtoTXZEUWds?=
 =?utf-8?B?Sk8zRWI2cSt0OFdSck5kRlByWG55OWFaVjZMV3hDQUhVaFlzSmJtWEcvdWhL?=
 =?utf-8?B?NVBJdjFOYlZodjgwcDFvS1ZvakdoT1JOdk9FMlR3T0tWNHBlTWxnY1VHMDR1?=
 =?utf-8?B?bHlhTVdiOGhOcmEra0llMTVSRzhvVzhHQ0s4Ti9maHB6YnFjalBzVDJpY1Zv?=
 =?utf-8?B?WGhBM3RsSVFRT0JCUlQwc3VCQVNaTUNhY2w3Rmo5QTJHWS9Wa0pIUEphSXRu?=
 =?utf-8?B?SEN1K2pueE1IdlJHRTE3OVdSNU5EU1l3VFY5RE93M0M1eGJ6bENUd2t2MGpH?=
 =?utf-8?B?dXBhb0Q2c0h1MHJwN3BFWjRjZE5wU3dIbFQrNEhEaWlzMms5Q0JpKzBlYUM3?=
 =?utf-8?B?cG1PRnpyZnpoZTNJQ081SFQzT1g1QkNPVERydUZZY3JpcnhxWUYwTUJMVWNw?=
 =?utf-8?B?T2YzMlhjOVIyQ0hPVEI4MEx3eTBndTRKWXJlODNsNDNZcmZ6YktHQjVIam1k?=
 =?utf-8?Q?/qnSWHGfpw/FxX/wX+TZvt7La?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8869869-e2e8-489d-d670-08dc2d3a838b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 08:54:11.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WMdDbJYN1f47aOaZylQbzQjC4Fmg757Px5XonJjxsvIAVyjPn/BIadzJpqsOPoxHeTbtPFoAHZXqthQSX1Qaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com

On 2/13/2024 8:05 AM, James Bottomley wrote:
> On Mon, 2024-02-12 at 23:36 -0800, Xing, Cedric wrote:
>> On 2/9/2024 12:58 PM, Dan Williams wrote:
>>> James Bottomley wrote:
>>>> Just to correct this: IMA uses its own log format, but I think
>>>> this was a mistake long ago and the new log should use TCG2
>>>> format so all the tools know how to parse it.
>>>
>>> Is this a chance to nudge IMA towards a standard log format? In
>>> other words, one of the goals alongside userspace consumers of the
>>> RTMR log would be for IMA to support it as well as an alternate in-
>>> kernel backend next to TPM. IMA-over-TPM continues with its current
>>> format, IMA-over-RTMR internally unifies with the log format that
>>> is shared with RTMR-user-ABI.
>>>
>> I'm not a TCG expert. As far as I know,
>> https://trustedcomputinggroup.org/wp-content/uploads/TCG-PC-Client-Platform-Firmware-Profile-Version-1.06-Revision-52_pub-1.pdf
>>   
>> defines the event types for TCG2 logs for firmware uses only. I
>> cannot  find a spec that defines event types for OS or applications.
>> We may  reuse the firmware event types for Linux but I doubt they can
>> accommodate IMA.
> 
> The TCG crypto agile log format is
> 
>   index (32 bit),
>   event tag (32 bit),
>   digests array,
>   sized event entry (up to 4GB)
> 
> So an IMA log entry can definitely be transformed into this format
> (providing someone agrees to the tag or set of tags).  The slight
> problem would be that none of the current IMA tools would understand
> it, but that could be solved over time (the kernel could use the TCG
> format internally but transform to the IMA format for the current
> securityfs IMA log).
> 
Hi James,

As Mikko mentioned in his reply, TCG has defined the "Canonical Event 
Log Format" (aka. CEL) [1], while systemd-pcr* services use a subset of 
CEL format in their user space log.

I skimmed through the CEL spec today. Comparing to TCG2 log, CEL follows 
the same design (i.e., each event has a type field that determines the 
structure of the event data) but separates the encoding from the 
information model.

IMHO, CEL only works for applications defined in its information model 
(currently UEFI BIOS and IMA) but wouldn't work for any other 
applications like systemd. The systemd source code has documented the 
difference [2] between their log format and CEL.

One problem of CEL is its "content_type", which contains numeric values 
assigned by the spec. systemd doesn't have a numeric "content_type" 
assigned so has to use a string value - "systemd", which can only be 
encoded in JSON but not in TLV or CBOR. Technically, the systemd log is 
NOT CEL even though they claim that's a subset of it.

Another problem of CEL is that NOT every byte of an event is 
hashed/extended. CEL spec has defined for each "content_type" the subset 
of bytes to hash, so a verifier must understand ALL content types to be 
able to verify the integrity of a log. In other words, the integrity of 
a "systemd" log can never be verified by a CEL conformant verifier.

So I wouldn't recommend CEL to be the log format here.

We are looking for, as I believe, is a format that can accommodate all 
applications and allow application-agnostic verifiers. For every event, 
the kernel only needs to know what to store in the log, and what to 
hash/extend and to which measurement registers, but isn't concerned by 
the semantics of the event. If reusing CEL terms, what needs to be 
defined here is the "encoding" (so that every application can 
store/extend "something" in a log that every verifier knows how to 
replay); while every application should be allowed to define its own 
"information model".

-Cedric

[1] https://trustedcomputinggroup.org/resource/canonical-event-log-format/

[2] 
https://github.com/systemd/systemd/blob/e1390da0256bbe2017c4c2fbc636c54fe02c84cb/src/shared/tpm2-util.c#L6112

>> IMHO, we don't have to follow TCG2 format because TDX is never TPM,
>> nor are any other TEEs that support runtime measurements. The
>> existing TCG2 format looks to me somewhat like ASN.1 - well defined
>> but schema is needed to decode. In contrast, JSON is a lot more
>> popular than ASN.1  nowadays because it's human readable and doesn't
>> require a schema. I just wonder if we should introduce a text based
>> log format. We could make the log a text file, in which each line is
>> an event record and the digest of the line is extended to the
>> specified runtime measurement register. The content of each line
>> could be free-form at the ABI level, but we can still recommend a
>> convention for applications - e.g., the first word/column must be an
>> URL for readers to find out the format/syntax of the rest of the
>> line. Thoughts?
> 
> https://xkcd.com/927/
> 
That is funny :-D

I can't agree more, so "no log" I think is always an option.

>>   For the new TEE measurement log, I don't think it has to be
>> collocated with the BIOS log, because TEEs are never TPMs.
> 
> This depends.  Logs are separable by PCRs.  As in every entry for the
> same PCR could be in a separate, correctly ordered, log.  However, you
> can't have separate logs that both use the same PCR because they won't
> replay.
> 
We can have separate logs for the same PCR as long as there's a way to 
order those logs. A simple way is to record the current PCR value at the 
beginning of every log, then a verifier can always replay the log to get 
the PCR value at exit, and use that value to match the next log.

Anyway, those details are unimportant. What I intended to say was that 
those logs don't have to be in the same format.

> James
> 
> 
> 

