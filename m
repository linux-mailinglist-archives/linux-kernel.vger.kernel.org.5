Return-Path: <linux-kernel+bounces-55832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E102584C238
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC839B2A8ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE539EADD;
	Wed,  7 Feb 2024 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThOy+bSo"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD3DF4E;
	Wed,  7 Feb 2024 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271349; cv=fail; b=he1VOgYBfXF4PbFjQUAzP6w8di8Rg2I/WFVXvbxRWzUZtXjPp8ipCJ265Q0hGevv4S5wGy9Kjc9zmnR1450Z+vLIU9ROHBNC+7ydUWvUADzOMYr4k5opQdwuyR+9GaYeEyHL0EMwRO7dev52ZO5lfMcF/E+654So6ZkNV87U67A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271349; c=relaxed/simple;
	bh=KNl4PjIMGZSH3FMDtg6prZGeahW6CtXizMn+/kr6lks=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ukB6J1IcAMIpOcVq+LgpLMR31D8FTAfKwsKpQDufK5qdi4wiUPBF942SPGA8V68rsvCBUJ0Kyzay1yVGiv8McmWLU18Pxp9P22fNdD88Ss19qnmEtEuWzLN71VzCyzFkAlN8GsRsCIi2IuX3KZ5Z6l5rZZIWiBCeSBmlyWxcRlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThOy+bSo; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707271348; x=1738807348;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KNl4PjIMGZSH3FMDtg6prZGeahW6CtXizMn+/kr6lks=;
  b=ThOy+bSofRSpdZGk+cKfiBznkIkBefDXPO3mxYvcmn8ZCZDuSGBNSzkY
   xdntZ1WJpGZNJd+QTil+o10e+V/JyXJ3vSAqu6IrruNGbCoc8T1wGGhX6
   pXy35eyhZY0XrNk4yb6Opfb2psTsdBZV06vO3OgqfiGHvz6tMOCcAaGBr
   SjBzFzMQEzCVPmZYtHHhvMxOiYdoqRc+UYOOCvSIASnZ89Ffqgm/NWJZB
   eKX497hRWLoZ6qjtbvcBTtMZsHUXCG2jz99QJ8NC0sPdnQZLIeqDUpQOx
   kFR7WRhJlrG2es522GFsHnowfuZT+8qOMplW0WYjWUN2F/vi8dlsWruMu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="436025519"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="436025519"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 18:02:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1503113"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 18:02:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 18:02:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 18:02:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 18:02:25 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 18:02:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3hrRLxKS298fpE/OKgKhcf6P41I+TjertOqTggKMHMDv/LuR3T/slMQ03j7Nuem65De8zq88ezLJTXIOo4skVXg0QGW46768xBn+Svfyo9BN5a/YatQ4WGUKL8V9ViSITrc9FhTbdO2A98HJrwVrFva0QD9Xaf65i26LAKxHAhvH91ROVmkzF0PWItLfpk4BvDM3tmELebKxRZvso4JqY+3JGPBNkkL5IDs6LWxzIxNYR032FkzW1Ueemmd7svunvXtPJbHf77pkEPpn9WzrFXW9RJI9Ci7aWgOU4kM4E904Dlm06CzlSBC0a1NUlgRFGc3hvr6NTH4MyjTCyKxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hW7Bx3Li3Jt5mc+Baj29OAOuhygjBBoAKTjVE++czgM=;
 b=np4Sg2m4ietd80olfkdVuC3RrcHpzoaolF29SDcxmPzt/4OVfRqZRi5MZWiXcXz28QyK6CfagW8jNJ6aHi+1OfBhr0gyZ/QP9jptisMOR3YUT0SoeZTIRmS9PxrvSRjWuLPmjkGT8TEURpaeYEceMqmGqn0TMuhbvsdHI7XsYbBtbhcmmR4Ilm+sCWd6ZW/DQoLO+WTYKlE3F6hb7ZUK+K22O3v3syo5t1I8411g97uifimKwQuPFlvtFmSVHh4Vt9K1mRb5qTYIQWMx2txH38lqfz29dsT5v/aooi5dvtZs1082he/7D7KF1MgKr62hDyXJtYEqOWDfRUhDOVlC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6463.namprd11.prod.outlook.com (2603:10b6:930:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 02:02:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 02:02:21 +0000
Date: Tue, 6 Feb 2024 18:02:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, "Xing, Cedric"
	<cedric.xing@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Dan Middleton
	<dan.middleton@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>, "Dan
 Williams" <dan.j.williams@intel.com>
CC: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, <biao.lu@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
Message-ID: <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
 <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
X-ClientProxiedBy: MW4PR04CA0206.namprd04.prod.outlook.com
 (2603:10b6:303:86::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a789fb7-430e-433c-6dbe-08dc2780d1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZS1djYpWp26hDhuoqKr+FdLI76K6W5ww8CmeiKAF/4WkUXJsMbW4oHckZ3f2fnstf+7H06flv95+9Ygmz6s79sLScP9ag7FUdaERdh7or3jZq/KT5jTcT4S+y+aahjYG18GmfXTjr2DveNZsLkBW6uFtGpRXRf3b2V08B11DjOmnR6ZDQajsbWaVGdqALcRW8/3sJbVrEWhpBF7L2pB7AbV0G1JMeZ5e/lQBTpwI6RSpArkdbhKYxxhjslXUM2YbFfpH1O7f7UcOeL9DgYLPZLnFMoMiSoOQuwH9khp9+yblQRnE0HAEO78AV14xeJXmoYIQLYrh2By8VWzeUOFEqCC0/2f5MkeGJ6e+WUwy+tUjGOw4WsXVo9RZmgaqABVVlolByXO/SpYrzZTJXJpIPztD+PNlRQBgb6SPM6lRBlGfSXiCWu8Ttup91VDkvCgnVVY3m7JD/jKIeidIyp0XDou1I9AMur7LmKOIXPmtQorZEk7UKEuwYg2xKlDDfoX3TgbNK7sIX12EhmuhHhsyrNfUPVXrJs8JZ3XU0Que6n9gB0p6qi0CHf1WWoqmTB8Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(86362001)(41300700001)(4744005)(478600001)(6486002)(5660300002)(2906002)(110136005)(66946007)(66476007)(54906003)(66556008)(316002)(8676002)(4326008)(6512007)(9686003)(8936002)(6506007)(6666004)(38100700002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o5mPQavRjapFuBk5hBb8IbOA9k6FmTWXbOD5O8X0VgZhhgcWT22CnbfMtbhN?=
 =?us-ascii?Q?zzxW+pPP/VL/KS1APZfzmkhehgUfo+iyqzAJpLbyXNsU8w/HCFSA83QNP4cb?=
 =?us-ascii?Q?p5XSPasjtKo9AwaYy1m4ap+AuDScu8/y5XJqol2KrVKD/EwK0f4rzB5MNA2P?=
 =?us-ascii?Q?fVekoaHOExw4rXQttujsl7hzLdH0dZoRWE1OPqtLw9GkWM+xk+yNkCcqlIqc?=
 =?us-ascii?Q?wuE+Yf0UtiA5KFfNeBYTxvK2peF15YPh+UjtNxZoZ3CmuTMd28zSTMUy1otR?=
 =?us-ascii?Q?+Ah3sb/9T4euk6hogMiSkjnWHk3fiJkF9IR2PklkNC12g2shHNqkzj0BYlB4?=
 =?us-ascii?Q?ML8z2V2vMVIi02kwnXeHX4YtyFgFwbncQfvasrgHGjkTov3VWH5vuxf5ksbw?=
 =?us-ascii?Q?GBuMKlGsZ01qm90hvc4Ofs1zd3kRRtfO5feGS2ITMQSZCQ883Q0wCxu8SLY/?=
 =?us-ascii?Q?nlnnR4TOvrv0EvJN8uhFq20Yq8ugnp7Ndz/slm+KBb/EdvQGv2JI9NxIvBRY?=
 =?us-ascii?Q?pD2etrRsChxy6va4/XxSGvUtkxt73WT4Ijc3qWQTKwX8ETec1OJwWr82B4iN?=
 =?us-ascii?Q?ZUIJ1MwCTmvVJCS3yKakLLpnGR8OodCC1UIAMqQy4RdJccZI/kHa6dQCGLRi?=
 =?us-ascii?Q?HKNVhGt5mdH2pW9agMB25uX8QQJprpKTASL0bfs8AJ69nVLeYfr37pPRctGt?=
 =?us-ascii?Q?SoygUhFumlfHuY/kgBNy487/6Dy82TxM6l+xWkymWF2jwKwO2VFF0xSNZo1j?=
 =?us-ascii?Q?8aWw8fzpsVL8gDwxRco52Ty8RAYoJcu1kd/e5OAKwuqJam+SEJ8r7Ki43DZs?=
 =?us-ascii?Q?9/uIqDBfVFm7zcsBk2/DdGtWHkHskk0Q6qvb/hx0qmJvOILh0zcTN0FPCtDr?=
 =?us-ascii?Q?OfAXO6AB48zLDyO5D/5OAIiX/88dCgdRvNDawjVpn9fJACnU8tKZ3CyILAk6?=
 =?us-ascii?Q?/EjvrqUcq43jeW3s8I4N732Zpf5qDJ6cn7GbamcwQvMUZD46tNM+sljHP/oM?=
 =?us-ascii?Q?sl7OICLPHMBjwPVADRDxwn0WP9Q2CYTcWHN2jOC11CiICnQmcBIRtEbyYaV1?=
 =?us-ascii?Q?3cjnlK/KFg+IdigkBUqN/sZmxwZhdtz+o0k1nXCT8RYZlqiwhjEjNaxpig0p?=
 =?us-ascii?Q?kmYWR+cDHOc5dtoQ3lKTGxr+IccZ/Bm3kEBv/m5Gu6hmAlncVfrh71i/K4Sd?=
 =?us-ascii?Q?eNAuLeUmEzo0J1XaJQl870m4/KFYpfNA1lFvHwcaFf7Yf79VUpaYQIVwbG3R?=
 =?us-ascii?Q?SjzYqGSP74hayUF30G6o4Q1mzPAugRp84iIdgOiTUCRVpaHilyKGDD5zM84G?=
 =?us-ascii?Q?Wx21p8b2KM9ET+XgpYHEycqj56BWCY6anf5cAm+/1lP8bf0hSxWUq+JLa5PG?=
 =?us-ascii?Q?zRgC1F1JniSdgMo51zxkQ7eL3Hegk6XEEK/VzV5L5YR/j8yHMC/OozheDufI?=
 =?us-ascii?Q?nmLkDEaFozwXZRI2ti5JPG3x3BwV0iR5Xx0Lacl0Js0Z/y/7znAPYtKhJGWE?=
 =?us-ascii?Q?TEon0isNcFkYiU7qG+p3FFidJ8kssWZl5SwpZix7KIOlPTI0/7y3S5yhuzn7?=
 =?us-ascii?Q?r3r5lixA38OKikqkXlKCafLqDJL3UB+UkVp4YvunzImXGxBahpAYy4GOvs1x?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a789fb7-430e-433c-6dbe-08dc2780d1b7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 02:02:20.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbIQK4ng1Uv6eTLK9tb9Vx4PsmtAgR6QhfjLxUE7h1EWxd646ZdPbeXxIXpP17xkrj5kc/3VGJxAhYoYBto4S3b4Op6nm9IozmoCNiDnOVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6463
X-OriginatorOrg: intel.com

James Bottomley wrote:
> There isn't really anything more complex about an interface that takes
> a log entry, and does the record an extend, than an interface which
> takes a PCR extension value.  So best practice would say that you
> should create the ABI that you can't get wrong (log and record) rather
> than creating one that causes additional problems for userspace.

Agree, there's no need for the kernel to leave deliberately pointy edges
for userspace to trip over.

Cedric, almost every time we, kernel community, build an interface where
userspace says "trust us, we know what we are doing" it inevitably
results later in "whoops, turns out it would have helped if the kernel
enforced structure here". So the log ABI adds that structure for the
primary use cases.

