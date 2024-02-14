Return-Path: <linux-kernel+bounces-65978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7678554A7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A8C1C21739
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F077D13EFFC;
	Wed, 14 Feb 2024 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfLR6cSm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2A13EFE8;
	Wed, 14 Feb 2024 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945754; cv=fail; b=SpptZTp2m4t63KuXu6VJb3zoC4vNH+lj9Pn8qee9e1SYzMq4HTVp1sdoqb/si7q5UMgYqtq0qyXVhbzzTVSzru8nXQfRqjmCX73NG9Mpe4RGtUmpsa6jgBu3WctHRt+4LHVVDSieunQgfmrY2a3M3VtDm/l//jqS33D0Hn4A+VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945754; c=relaxed/simple;
	bh=KuKWedhWEw9kVX6yaA8xKCflQFisJpFI1yy2H122EQE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Po7Ol4Fq/ZsFV60gQaQ3o/HQ6hRceTLduya0nskbU1nvDyHvoFyvd8MkXAiTbd8tICYfYcST5vW2Swn2ytFhJdlrxwSJ+42WMuqDmolcuD7ztooACvJAzL3ZB3qf6kqhSy26oFPCJcQpZpBtW5DxiU3J846xTqseg7VQsyosh3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfLR6cSm; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707945751; x=1739481751;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KuKWedhWEw9kVX6yaA8xKCflQFisJpFI1yy2H122EQE=;
  b=hfLR6cSmj7+x3YUiyAYH2bZpXcYNMXbrXjkZzlT5Uy/utY4Pg9E/M5PP
   a9WA39CwveTH2YPaQWTTkU7yU6J34IQrBjLhY4Wg7x8jqm175M4O6RGw9
   nRrvZs/wWeFOHABnJZD/s3atxGXdfyLdsJWaXYPTlQaoXDGKLvrjmmnGM
   AHqUYnpxumrjt+eCSHrjy8tynQIs+Nwos0mcb0oeqm182L+dYvbIgVe8n
   KA3efBbdOlNvylPCN/SZRVsjveoif5HOpZ2nEteuPdmz8NS4NtROaUNJD
   mFf90GDgFZdeTdJ9sCKptt5jHvuOrLJHRzNSQdwCrznQOncCo7kYvdTb2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19430472"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19430472"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 13:22:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7931401"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 13:22:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 13:22:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 13:22:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 13:22:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W27/5nNrLmN7FkpPxfbxGYU9hmXFsWMx0sneLSne8EQW8bovm3FamqItA88PCSHA+4OJIJPINXeq84lhgwOoc722AD2A/O9d49vx6d93CkMJa7jo/UEqD1uLhDoyHzZLhPgCqsNRcGc2uM0EZthSPLiaqomLBBZVm+R3Hri6/LX1KakNMahLT8Xjg/jxgi/kYWBsPpc8RTkvj6hVjKg6DEHJykxa448FMy1MHv8OKubICQUDj1252byFYEwtzYLU7hsRXfdpZWRlzi8dylz53Wlpqv+lqPhpB4/YZBiUlk/yG9/E2hq1iYZCiLdS7T/zXxMo+S8TZuKSlz23Ym+Skg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSBUVdtXoXPu/DRRpUN/kumzgAnjgFKzrW8HT7ijpaU=;
 b=IM9tP9J5LgA8ChFs8bQ4yMY/ko74VmOaRTVI6zyVW2J1VkM3eNZECiN6rHiwb3HuzbS55A/efyS85pyFDun7hU1UTH+XY8UibQfL0e6L0a7SwbjgrP5aP3048gHwOXynIvxZbCKngVxjGsKYBehw8wNZnqvRM+ktn+yo9Yi7VcyPufca+5qaMx7BlGyPfPYMMBE0gceuKmuZGY9901ZJ4tzHV3RWVPAwjm323FT5CRYC5pbjBJ/+3NgcF5+QnLyryGwGqB3h7/fwahzIAHvnVpkzlRkz3vrsS49Bh3uEY0do5yG+cYd4KTbEmKPEgdYrvfvflQUCSjHQI8kJFcp+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB7638.namprd11.prod.outlook.com (2603:10b6:806:34b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 21:22:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 21:22:28 +0000
Date: Wed, 14 Feb 2024 13:22:25 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Steven Rostedt
	<rostedt@goodmis.org>
CC: Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <65cd2f116a887_d4f2d29445@iweiny-mobl.notmuch>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
 <20240214121153.00005c97@huawei.com>
 <20240214102310.7ba53f3a@gandalf.local.home>
 <20240214181200.0000500b@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240214181200.0000500b@Huawei.com>
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d55f58-b8e5-47ee-e663-08dc2da30bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxGQTtBU7q1ik4x7ZmOFHetMrPa5ayFsqPRgSpnkmYsQ2pHNMaKCTZKhDc75Z9Eh0lw58mmwqukbNYfbiUTXc/P/tRNhiI0EdIy3yK9I4Z8J/7rAyAlRKCKY4thMqCGKkYZdtff7OSyAVdRmEPStgT4Fjxds+qgMawP+RAyQTVdU1yGTUg3DPqinYCxoiOwfTQw/OQAf7TFmoE96slrFAKf6OXDs6HsvYOXJ2rqVQgnXbLMizeOfGaXNNhR9GVr9iFB2PyQCBfptnxXmrVzhepnFSs6Ji2ZVRF11ovfacm/p8sAsxIEj75WYUQDgjiu5f3pxOJLFwQoisQWpJVufcCMjfXSVvcZo0qk/0jDzPLyFXRN0dLYq6PcZ0TxAtXqxHk09Ejdu6V1QOCWvSAYk9V+4z/4+MRNXXuXVw26QpimglvnUhKt2svFvwfUcVfj47qCGSZA3LxfdhgVFwjXC1uuuEBCy02dmpfrS/QIG6fYmy2f8k5WKRurCLKmMMnnKq0Q5wW2zh9b79XJG+KA9poApJztmwxEQMyfvB2l9ESHFQwtfZ+Qy+8FWjfCPh6sF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8676002)(38100700002)(44832011)(83380400001)(82960400001)(4326008)(2906002)(5660300002)(8936002)(41300700001)(7416002)(66946007)(66476007)(66556008)(478600001)(6486002)(26005)(6512007)(6506007)(316002)(54906003)(6666004)(110136005)(9686003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0tpUSNCr8tYMGgZHEm6f4Y0SGJVob5tqokAKviI63guwqHcT9ORIyOAC9sOD?=
 =?us-ascii?Q?E1IdpuJhHBQXEdZbDMEwwAt46LFk7NCNmi2Z7rZO8zpHuym5UyNJLRgV6U2d?=
 =?us-ascii?Q?9zFgllyuVLbXe9m/jsloO1cfTiiwtn9uRBXmUbmsHJgjBIFmrbo8xc2JgkW3?=
 =?us-ascii?Q?A09d18fXWABp1uyX6dr0J6Jv5P2F8oH7jQ4bE1/QglyvyMEGInBeAAHz/Gz/?=
 =?us-ascii?Q?i96fO/Zw20kwcF1AjHHdIK6GfDRwALGvv3bjaxUmqhjvSXLasto4NmzcSuo4?=
 =?us-ascii?Q?80J3s9seISyx0njpygfw499jjk4kugS6d3rvQjzWZncnZT8N2WBHzdjmRg2e?=
 =?us-ascii?Q?ZMYG2hD7D61Xh3l+1yQOTGr8FBtqIq9Dm9NiN+UPjO0GD2Z5Xbfkn3LnKzyc?=
 =?us-ascii?Q?KmADea0OS6BB3XgvGjS3WUufRoEutnXRtzaDldexhJFvhCgcjHoMoKNa0LL8?=
 =?us-ascii?Q?uLRwKh1QvfOi875208FLGOypRmQjI42DlDQN6bCEuMkShgFfPZByznrdpGMt?=
 =?us-ascii?Q?CmqIiH7ADJgtfDXvQRr/FPtwJ3C8sTbHVeT+TurIA4qjsCJ18HQtTAGkJbuP?=
 =?us-ascii?Q?k0+cDw1fVbeI11MZh5G1j7+sTKleDMfyWJ0kNIcBDlKDzRsoyY7N27XuQno8?=
 =?us-ascii?Q?r7J0alcr7MI9RG/4Q+dpFdT5/J9uIywq54gQNuFMXjK5VsA6vzgZYmF0IsZ8?=
 =?us-ascii?Q?cvhKBZMtFP9amTdbfM4S3SVyaPwhvKo6q/9xu1I8yVMcxY/tO3iuPqi1mWTn?=
 =?us-ascii?Q?ATHc/x6M01xzkliWqL35Xb4Lxa9O6iWxSSNLfAvmfTRVCB/pqgs8P1BZBi3A?=
 =?us-ascii?Q?qWzoK87TyG/Cn9g2AiH46hiMSTozVGaz3oKwGWoKt/yzPcmraZhOyjnA3Jdh?=
 =?us-ascii?Q?yGJ1R8y5fGuFH5PRNJ/DAAp8GdLHS2e/gFPrjDCACF52ViBDvsllmkKzWcjM?=
 =?us-ascii?Q?GMo60PanvX3l7hQ2YDYjwho/2Fu3dzeMOryhDXhSc7IhsEX2A+sQ4kzLvPM4?=
 =?us-ascii?Q?Fyuxk89KW0KMdFsBEd0l5hYTOZEzxjzk0Rj+mREZZaVLiGRyfni90K3SfB+I?=
 =?us-ascii?Q?kc8Wn86n1jc5NvsXq0bG/9CsSx0Qt7XOSMoKy7dIXScGAmE+SSzFE1nyTV/Q?=
 =?us-ascii?Q?d9V62svDRJjyxacadQKhflQtg9putD1mmAcQ6WWSAO6BRjoDe+hdzbnFr69k?=
 =?us-ascii?Q?L2xv918hX5jahSuRiNXZ8KKwWAV8VEMZD9AL+yw44t5jfuvwOFwahdQRWWvY?=
 =?us-ascii?Q?fc+dP86RwgOJ7fdCuKjLLYcz/NlT21EpukusTB3yZGa+eVOeT+4x2rmaoT7Y?=
 =?us-ascii?Q?Z28K/5j9uE279zhWi1HqpM9pN0IEhtEXsKy/PH7CW3AmlczOYILkQORDSkkP?=
 =?us-ascii?Q?FcrfYyixtwpHW1S+XzjtCmC5ePp8CmfgZdsBAn0v/J/OxecedeSw1/IFZXro?=
 =?us-ascii?Q?tiASQhuPPwjUiaNuakjdh2r9Ey665oC4AHURifMxgiPyCWPrCZnUGb/K7Fcy?=
 =?us-ascii?Q?4vk4g53wtp8kD3d9RAH7gVdBn1DtmCShxTHtaPL3ImEt+XyUJTGisTTM25vx?=
 =?us-ascii?Q?NF+X0vIFLmBmcgJApJPDZPQMUy/qbCzUZXbHwQw2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d55f58-b8e5-47ee-e663-08dc2da30bf3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 21:22:28.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpAyu6aWSVPzz8P0mw6DN2VUEJiUi8Urjw2cJqvLPBfLoATokpCBoeUmqSrxXeetDPyZTkh5iITpNqHPLev/Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7638
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 14 Feb 2024 10:23:10 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 14 Feb 2024 12:11:53 +0000
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > 
> > > So I'm thinking this is a won't fix - wait for the printk rework to land and
> > > assume this will be resolved as well?  
> > 
> > That pretty much sums up what I was about to say ;-)
> > 
> > tp_printk is more of a hack and not to be used sparingly. With the right
> > trace events it can hang the machine.
> > 
> > So, you can use your internal patch locally, but I would recommend waiting
> > for the new printk changes to land. I'm really hoping that will be soon!
> > 
> > -- Steve
> 
> Thanks Steve,
> 
> Ira's fix is needed for other valid locking reasons - this was 'just another'
> lock debugging report that came up whilst testing it.
> 
> For this patch (not a potential additional one that we aren't going to do ;)
> 
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks Jonathan!  I really appreciate the testing,
Ira

