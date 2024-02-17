Return-Path: <linux-kernel+bounces-69621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 898E1858C7D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182811F21E4E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEA51CF94;
	Sat, 17 Feb 2024 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miH8rlrf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1861B593;
	Sat, 17 Feb 2024 01:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131751; cv=fail; b=n6j5MFdiDOjP03N+Up5l5nXa+ZTt6Cy2hpD24UxLm8eNF223yvX9ivSuTBrNfv6uv0CjKNQ3GUG3ZNbKPt0pHhgHTpnw4dAIXgQVmrhLbRAKT/wQNKg89y+rMwtM8LDrUHVZxwmCcK73tGAoQP43qyPtDPnvBX/dMjZ1j7v6k0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131751; c=relaxed/simple;
	bh=24DStM8LeODgG4h5Ikqf4AHQOp/tPtPVHsUr1yqXKek=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZK1h5higyVOwB6IIrwAi0GLPW3P4nelv6d53gmUPvOE90T1JlkrPVTeGnViYcFhTfk0pVsxQ8ECPOlCLS7TVfI/PcFe4L1V+BSJLjMrKCEBQadyVUJSqmfgbFIDgXUItVvI1JCaYJdWpaa2IhqeyXb+xO2W6Jc1I28jQXN3LUyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miH8rlrf; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708131750; x=1739667750;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=24DStM8LeODgG4h5Ikqf4AHQOp/tPtPVHsUr1yqXKek=;
  b=miH8rlrfHu/YUJ66B5ZL2iH7udkBY3vOyq+KmyzPrga523VMapGTkPSs
   l0PHA2ROP7A5Vo8541tOyw+f88OAfVDTJNsPXBoNRC0vdQLfhi20jxYmZ
   lfhISmjaH+fdaJlWluKtRxaE8ReP3yTgh8muG8yfpCFAn27jNYdKbYK0r
   AELJ58ygecCAA/K2RIq3boNmAIEiuBrUzN4dqn/1KC2SyOYOKb25WRiF8
   9+7zNqvv3ji6JvwjpPRtdsDeNO3CqY/TLtKFZLTbEu049hFJR6ODshaUn
   Fy0aeYXpHvAzydMEM24Jv6paSnydi9hAnFoldtHrvdrDrNRKIfckwqRP9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="24746913"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="24746913"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 17:02:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="3894252"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 17:02:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 17:02:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 17:02:22 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 17:02:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6umjAEFjkAtOwV//OyXytNUYF5YoHPaIkg0Qsp6b3IetFyHWjGVGlH9liR3FyNHLZE+III4+tvLSZ8YsuR0PaUunQ94AeqSFJFYtjXKHqMfy/FEDWiHTVQxB/vhKSvPCgYzezqlph/rGwWSlZ3WNz2LsYoXLNGQbaiNigQENHvqFkbtlFOYyWbKXytbtg7mwJ/wVh4XSH5DQROi3erPSTKtNcJ2jqEC4t4t0ejpFGJ8Djw99uGlanvyCvuXBcvapTmv//p8UpDwRlol1CWqA+eCBkNHlSobf1aZssCP3fpv7smnFa9mergWXV91CwDMbrPtaq2Y3e2kY/x0zgdgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0nm+9mNJsHUp9+iCtWPCBRNbS5GdQC1Ia/5123acFg=;
 b=P/JfbTK2Jb4NjgmFzb40xKz/Du2Jg/x7db2jP6dLgOeuBJPUjZhbdtAFCrliAm6MpfblWffj5vP23piLJ3oj0qUOz2SaDtQ6YS3gGkwJR2BZCJ0wk33FAhQCVQ3RI4B5WMpKTCzqsKFou7q7E1RHf3umGAm/Vs7zqGxgMP8I6do5eLM11+BinSFn0diQCfbGorrMi/blIbW5E5lAc5a0faLxG3Vz+5rk42tjB7a5Y8xLMCgg+7/ACL4I+h5bTeXZbeTGW5jXU5xyZzgNW59X34OADSYjzHIJbkuS8CItHZpXsGtZKHCapcO6Ke/6bKX6Epa5EfOZr26lEtWgXzsPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7805.namprd11.prod.outlook.com (2603:10b6:8:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Sat, 17 Feb
 2024 01:02:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Sat, 17 Feb 2024
 01:02:20 +0000
Date: Fri, 16 Feb 2024 17:02:17 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Steven Rostedt <rostedt@goodmis.org>
CC: Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <65d005999e39f_6c74529464@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
 <20240214121153.00005c97@huawei.com>
 <20240214102310.7ba53f3a@gandalf.local.home>
 <20240214181200.0000500b@Huawei.com>
 <65cd3c671cf86_d552e294dd@iweiny-mobl.notmuch>
 <20240214173318.2be1f3c9@gandalf.local.home>
 <20240215092527.000055b9@Huawei.com>
 <65ce4c3467d1b_eabd929437@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65ce4c3467d1b_eabd929437@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:303:dc::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c982ac4-e383-487d-a227-08dc2f5417c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZFszoDc3BvFK9roFacgK7CPqtFn3PhfWS3FStxgv5d4RegXuVC6F4OhVAYBr1o5HuxVVF2k1AUOu6/glp20lS7TlgQZplTfcEeBjg5CjNsHlw5aGcbKcnTuopc8/s+SExAzi9TvF5cdxJqHqNdpRUxOZckUkqdCh3pfP9MiWemMSRbiFoiNMBBph0WP5j/x9bf0nfGCzcP8D9VwDxYfTy2zK1PASd/E4Emdnr8L6LwQ0OyDr+j3AH0ul2xg+R8CdLmgmzwjPdNgHgQC+cEttn/Wt6X/lxcy4Ak3DHET9tiWhCpGOD1IdcnAutlODUqL/iw4+fjHMxJEMFerDNSpr9GXJ6xl6S7NIpt9/5SKI4ArbiG0mMF0WJi6VcJAcYxlUHS5GL4YDk5lbKK0NrapWCkcOGb/Bvz0uv9cZ0P8u21DYaPPkDb0hT8R4uTee41qAcXdjSFNkhrGBnql09wTtNGdwqrpuYTr9Pg/UqT0RIMv2OsvkwpC9lLVgMM4w2ilKRh9+Vg0CkgjasMLRNUMHchBMqvwMHrwGGLZY8S5gd/k3r7Kue0njIlRjMUf1NQWO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(8676002)(66556008)(66946007)(8936002)(86362001)(82960400001)(66476007)(2906002)(83380400001)(4744005)(26005)(41300700001)(4326008)(478600001)(6666004)(316002)(5660300002)(6506007)(54906003)(6512007)(9686003)(6486002)(7416002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M5pz0rIsP+tDja2gti2Ki3PMLM1sbS0CzE9Oco+QLjlP5l3BBBMNhkS4ZHnF?=
 =?us-ascii?Q?FDtppANELXXfMQC4/rLWPlYH01pRfjCdoKCJ5XRMo6huiV2C9F1l/izPz09O?=
 =?us-ascii?Q?tSvxT3ZzmUIHu8l8fyEjMsm/v8bDJaQShiNmUMIc+Mf7zAPFbptiMvXlIyLx?=
 =?us-ascii?Q?zpBvorSYh5W0SiFq5UstHeqK78anOVcM/yXPZ2cuybjsCeXCi70CJsuxx0O2?=
 =?us-ascii?Q?nlYQX8GIVplsUdxin29LLQU3NWvfv1PgCZwIBrrMYyuJXwVeha4LHJEJC3i/?=
 =?us-ascii?Q?mgNUvGCZKgzfKR88HjokYc9Mz/uQDdlEU6oh8E6nF6tTAsWO1HiD7hMrOIhN?=
 =?us-ascii?Q?ffMv8sMPMYlKq4OBbe8G8YiSG8wiTbkwplZqHakQYaM0a+pEseQB9f675gH4?=
 =?us-ascii?Q?LFGD3MEIgYyNPe2LfV7l8u4R+wOEPv0yLNtL3eCjMeKblXRbNmwpi36vQiMq?=
 =?us-ascii?Q?3CzXgN3QmPP0BbvJIDpkoEK4LLoplT1BA2JbHMbRftVvymFE0W5/NcGMRJxZ?=
 =?us-ascii?Q?ga6DgBmWPC5yEXIAvdlwgcUbyoEgly55A3OAPvqIAjqAlE8a5nEiGQH5tpYq?=
 =?us-ascii?Q?qcg7uWrnM8HM13M/apElYQxKyVLlnDGQ8pQRe6UJ2eqU9++H9vYrZ0SGDExn?=
 =?us-ascii?Q?fbStapRu97AAntpfa0TcNaxhRhfQPiNFpGL2IOFJeLdirzU3lGUS4Nnb/LtZ?=
 =?us-ascii?Q?iffPbtT7t7YRmI+03HjRGxXjVZ2wGag+d5piuFNLqpTFeEfNerucxWh0V78i?=
 =?us-ascii?Q?qtlM/vm7cDAnHFAm7m0Q5ZHmYRpFg62vAv+3Cinnm4qG3VxcfuSqQjTwlhsN?=
 =?us-ascii?Q?Mxi85yI1TcQMCohSLJGcoAbfc26PvFGNNbtK/EO1pKbIphLbhMaAViXutv/e?=
 =?us-ascii?Q?njxnRRN9OmJdcfdDcFL3hvfHhz/vDIzKVudHffhPZkSrJgnkGiLYRKfnuN2y?=
 =?us-ascii?Q?uWRz35t88HDfCWd4BS6YI+hSsPKfXDEkJFoRmCHM2srxUtlVTb+5491pnePM?=
 =?us-ascii?Q?6zVnakE2vBzMKINyasAi4rwypU9i24kRGdQciu4S4J7lkn+wvYRSrBrSuDs4?=
 =?us-ascii?Q?9gQGACsR76gOTd8Ahd0TM+/Fq+DoZDjnDziSZPrAXrY7i6zODTu6YjHwh7Vq?=
 =?us-ascii?Q?7t/Az7Lm6GEOElspWckB0m8/Bfgaplw4ZA8XJTunCYxU9KoFoKwJ55bdjQvg?=
 =?us-ascii?Q?duj/FDduEV1RiJ4AYbsooMAQMknRo6yh/cNb4iMnnDF2Olj54DPZ85C2FmWz?=
 =?us-ascii?Q?UcvYGiH/LtkrSZyUUH8uKpWvggNq35p7Awh0cTa+HZplJNq+28oGk37145uB?=
 =?us-ascii?Q?BQPPeE0+O+PFyK0BkKMF+WiMhU7VT3LG3cxdYdogIqjF2CcXimtGUZzLvcUl?=
 =?us-ascii?Q?kWwZ7dolMfYfzCwiUN9NU0fDcL77VGa71i0SNpt9Sk7jBQRtrf3EYDsQ9vAp?=
 =?us-ascii?Q?aMpB37QqVlMhoTROVzgymaCRz3vxHrnw2Q1Gmlc5ERv899RCTIzW9rYXGVjI?=
 =?us-ascii?Q?7oEZSW487gyN+jBaZZkzKFlTb8nse+DjKHj2ZekkJj5Tnr88yvCgi4bUciSi?=
 =?us-ascii?Q?WE9MjPM60EoEX9yc7MrDttHuFbzKMEntoQXxl8TA4rRTIJPENZPy5jKFktTa?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c982ac4-e383-487d-a227-08dc2f5417c2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 01:02:20.3712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zh6ktoQ86i7WZT57eczzIK6UqyMw7fvjYt5uTQFqZUYCRvAqGDQ8JPP4Yuh/oATfi4NDXR+pjOE5VItikOnr9c1+d1zQxvH2bPVAaM79TLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7805
X-OriginatorOrg: intel.com

Ira Weiny wrote:
[..]
> > As Steve said, tp_printk is a hack (a very useful one) and
> > hopefully no one runs it in production.
> 
> OMG...  I did not realize what tp_printk() was exactly.  I should have
> looked closer.
> 
> Do we have evidence of its use in production?
> 
> I would love to not have to revert/respin,

The revert is for 2 non-trivial fixes needed in one new feature, lets
just circle back and get it right for v6.9. The tp_printk() was not the
final straw for me.

