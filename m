Return-Path: <linux-kernel+bounces-22421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C623829D71
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A456A1C21DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6278A4C600;
	Wed, 10 Jan 2024 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1CKKcQC"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B814C3AA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704900087; x=1736436087;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cJ2Rfw3DkedzYKRBrq58qIII+bekXEeaTonOTD1LvGY=;
  b=N1CKKcQC6pcK725SuOx48AlESBGxRpfzAiM82xw/BH90QtxFhC3tD8jt
   7nF3FcmQrwtj44SX9wA6HQ+clkrarViOciP1u8JDx/fLDtbDXJJ5tptCg
   7B+5fJmmdcYqJhLTo0tzW3z2Mh/4oYCmJT4cVykVxWi8+xn/9lv8PMgMe
   SHWtmx8Ufy2NEX93f3610+nsmV1VLyOBNFypeCFzRaOTp36APdk+6x1xM
   5yPsZxMmYxUnSD6q9EReuf4pcFLwez5Z0C3LRQFUyvZqwdmQ8MrsDLwxY
   qLrOGn+nfNIoIKuToM6cXyFmZfndZRoephkEQaGmpmQpP5W2ZGZUpr7XY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="484732972"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="484732972"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:21:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="23980222"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 07:21:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 07:21:24 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 07:21:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 07:21:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 07:21:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIask1KUCLvnmIqcB07eDfKJPiSwlsTy5mhA3XG8t1ljOxWpUd2wtmKQyQQdyKjRtTDQrbUuzaG/tqPpnbXX/H3c6dbw+kEgkMHy60+ydb8V3eXfif3cvvb/0dHWrx6SZdBctcufiChqZDHlZF9/7xXHF2GJME+wO/c5Pkvmal9D4KrlW4TaRdKimJLvC8Mhv1Ljt5xNjiVfx4uVqaR7sAj19UMf5rSxwWsJH7zozyZVjseATnjuYofQWHsq6iCUJ4i2BLecr9J3j7qt7CNFfEBnHgMBrd3dDohNxFfJDlVRdUok6IiKxBan7ifAoFbYsFnpygN2DECoWlSWQpE2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqw4zAv4J+xCtJ4luGSCVIKbtaqxeeLwgHApJFO6OZQ=;
 b=HwO4JRvSQ0gkfTXEZ5pGbofVVt5WN/JXZ8SrsNfxSjfxz7WwVTODf7Gfp1oPYwvkSf2jDK8HbavQ4eJ8rGU/X5tll//KdKGXydYtj2BA/wKQtwuln1tNH9xakE6SD9LG3pFQ3goGoV3/ZyjpmGBg3HTU1BMuUpuI3ftBfV9AiEr9EvxHmvnUzxB6P3mroSTiDjXaZPBSWXN0mzSjTJERIlccVlDO1UP+i5NcWfC4OYQMqoQmGnP53/oToV0wBszkD3aX+B97vGbVQOQMkwycKzLwefmjYA+MYtXmpF8d4vbSeQuFcVfnNQ91Wu2ORD1RRZ6oOZw1Jzb04/6UcBVdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA2PR11MB4924.namprd11.prod.outlook.com (2603:10b6:806:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 15:21:16 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 15:21:16 +0000
Date: Wed, 10 Jan 2024 09:21:14 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>, Stephen Rothwell
	<sfr@canb.auug.org.au>, <linux-kernel@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>
Subject: Re: [BUG] allmodconfig build error in next-20240108
Message-ID: <azaumdst7zwqbluhjywk336rencu5cop6vbozjiciopklz3ian@yfzizulcec5r>
References: <341a4955-0cdd-48d0-bfbd-cc6f6f09df37@paulmck-laptop>
 <atbx7mspjbymkzgstk4l64qz3uky3wpmx4isrfg3ixgtvebdd2@cktpe4ejfk7k>
 <20240110081155.48bb0cbd@oak>
 <d61dfe52-9567-4f62-98f5-5c1e00cb4708@paulmck-laptop>
 <20240110095822.3ba3d979@canb.auug.org.au>
 <3d14049c-d44c-4b33-9933-0f96055b8a70@paulmck-laptop>
 <20240110160335.2bad7d54@oak>
 <3a10ef2b-acbe-4d80-805a-e947e15e5db3@paulmck-laptop>
 <6r2zjqbs2g3hkt3uhnglwpboalwck5ye34b6gxzmhe4gae77g7@3bzqt4s7i2qb>
 <87o7dtusi4.fsf@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <87o7dtusi4.fsf@intel.com>
X-ClientProxiedBy: SJ0PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::34) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA2PR11MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d8bbc1-360f-4b22-de14-08dc11efca26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/JRp5EV76rjEopq4Q7nhI8hyhoOuut/711Tg4Hj94J3NHCJsGEYrjyyMNl/JtuqcMea7ZqcOuvn/T7IZ973Tobvw7SsyRhtZtZwavEhSUGh3Y174E+PW5dNLJjMXFW5FC74hO8vd46UXd2Yujm/iOWr6cX9yC8TzJmgAL7kwS/OCbBx/aRDuhfDvw8hXmcQoP3Czv2wpjlZKB8W5d3+8/ASkUZPV5smbwae7oURsVTVENrbGvD92RQTwyjjZiYK1PAk68JqjtBDoOQAM3tWfgzDvS7iVOaOB+MBZbNZZOwLA6taGMHQ/t6+/79ou53BmfRAP5wLfyZQWSnfEruyIzKH2ajM/XjOqA7QY1hK1vPfScBWQNAwANAfxUlvQPvSA7ZZ9DpLkxTR8iIzwbE3TpTTvU1ppGPDI/fnoM6T3siwrKxtgO6OI0FCTP7DEeeENXVGbxtiruL5n/N9gVPiV7F61yycyoEi8zRbub559sCrgYMZX0vLLc4+M5X7enDvhS2wF9oTWRmXugcQK0t3zf5NTByDnWhQunwQKcxSP6nfhQcRuudVQwpn6EA/Dfv8EWObcHUq22if2yNwAxAdFarupRW9iOBrYJeTGk2FgLTWpQaQtTQgj04ZWqjstDsf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(4744005)(2906002)(86362001)(82960400001)(38100700002)(6486002)(83380400001)(33716001)(6506007)(478600001)(6512007)(9686003)(26005)(316002)(8936002)(4326008)(8676002)(41300700001)(54906003)(66946007)(6916009)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JYlrzIIquAlH1v6z2o7jQKISbsV19loCqTFe3jJHJAGduk7eJ7w9DOZwvZtM?=
 =?us-ascii?Q?6/eU72R1pdB2CJLUpGSuNCb1YiuLbxnll8eVMXezPAzfvi/sBnwxyGGP5sN9?=
 =?us-ascii?Q?XhCrzJVqlwoCBnFgQoOVsSe6mzEnU/pRusULAOIWLYlHwIKDNEIlhLr8HPsU?=
 =?us-ascii?Q?jND4M5l73ZsF4ADzRedyq/BL5KBZeXHbIanPE+Dislg+HKY0vdqvDbT+V/bj?=
 =?us-ascii?Q?iEj7NJlsMcfVcptgqDfdi19NMe3NAHbJmQnfsGEvrlPay79vt5mR6fYIwb3a?=
 =?us-ascii?Q?yroVd7NiK0WSj3MfuM10q0HJcyZ+01JRVfFkSoA11l16POUGP6bCu1iG02I3?=
 =?us-ascii?Q?I3eeDzdDnvsoWn0WUSuY+F332m78/jkMwPrlrOOq8ay4oIszk3qKxbh4QvkU?=
 =?us-ascii?Q?rYAsGtIMPjWo1MU/9wCg2QOUrOhTf4KQZ9cRdpzug+MIKBHsDMmZr8gK99yQ?=
 =?us-ascii?Q?hJeeRoSgxlAzIz+samkeiLxhdlY5QUHnO6VerBIuQ84uNPoyOA61dNSLDscf?=
 =?us-ascii?Q?azakMgQmgVyfwjrR5GJDlC8XWRVIOQaVhKn7JS6CTjB4wI8fCgACMOBUspww?=
 =?us-ascii?Q?OUfVYupsCvyzuhdOpNp32YlmR/GROUQQHohH8IzdQTbhDR40xwSIJBCUMi7b?=
 =?us-ascii?Q?OT55CxrC2Eoko36PE7IBLKPxj7gYb2/+R1T2xEgbpfN8wp3rLnVtGYpkgmKh?=
 =?us-ascii?Q?e2IWg22mUVhu1a9IeRzrCfpXzp/HJvK7TdZuo/oXdTjRiVd/6o0+d5c1gs5N?=
 =?us-ascii?Q?EtIinoM+wUs8Mqw8m4nVtg/u7BUg7In2rR+iK8laFJEuzcTT1yXj8fbRiVmH?=
 =?us-ascii?Q?Fv2rK7Lun188mgQA/A2sbif+rbF01CGNo3syLUQ2zPVxYOIi0zqQwnECpfyK?=
 =?us-ascii?Q?iyfAH58G781444iym+KzNQ66I8g24nuJpnlNYkg6AbNe9YUL0UkwDE31gvrb?=
 =?us-ascii?Q?sAjqnYGS/7XraCspOT4fIaMk244pY94v4Gl+IPGgQ86DsWS01OKOguzu12Ut?=
 =?us-ascii?Q?lx4O61h1S5JWkGC/SHkYI4x/y1u2C+M2xcpXEJi9ZdVLWHoG0decLKiqplp5?=
 =?us-ascii?Q?7DGIyAFZBz1ZqDJZrQdyD4nT6LgsUQdlY9qJLSjEca4F4eoeZNFes52xEv/1?=
 =?us-ascii?Q?1G+3YhyH6q5aXEhk209k2QE5pfBDTywZt11K8OXXyeCcoCa075M6Smqrl/8Q?=
 =?us-ascii?Q?P0ZYP6FBEOKwYuQowYlPaefmpApUEP+Pu0/6Oavn7E8soyZTid8GEAETOine?=
 =?us-ascii?Q?7xvjOCPc7Ufp+w1m/UVE0IJ3s5PWewVfQ2TXNvjSbIR6HI5GSXcZI9uoBQX1?=
 =?us-ascii?Q?hQFROM1qzUp5KRmqDVnjdrsxWmzdoPoiCom5QDZv/CpLZpZTF4Bb54YxQXxT?=
 =?us-ascii?Q?GDVBfj2apKhcPbicF8Xx7rVFgRHJzYD59MVAwh/+5TPJF617bjkqIGRJH0zw?=
 =?us-ascii?Q?3Nqs5a41L87fLa8w/18QuCq0UWf4hNEFhIQinCUqNDDdRUk/cOg+kWWOIkaF?=
 =?us-ascii?Q?YA2oeK64M76DMfR9+JnvjVqtSeOItH1zSkPM0fhFrguELeUPjhjMbzC98AU0?=
 =?us-ascii?Q?xAP2aLor5tiQzXGFM8W7Zvd8eIPhG2FGUSMByL1R5r39BugdPOLPbcRU7zC+?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d8bbc1-360f-4b22-de14-08dc11efca26
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:21:16.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fsk1tVI9qoA0dwKATLXBYJRaxt6rSiO+2r3XhEI/sDGlubGaRMpJdMU+4n43MG4hWuj3t4uJ1FLFF6sEapwLJKeusw6U1g+lj1z1toJaSv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4924
X-OriginatorOrg: intel.com

On Wed, Jan 10, 2024 at 05:18:11PM +0200, Jani Nikula wrote:
>On Wed, 10 Jan 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>> [ This particular warning is broken on GCC11. In future changes it will
>>    be moved to the normal C flags in the top level Makefile (out of
>>    Makefile.extrawarn), but accounting for the compiler support. Just
>>    remove it out of xe's forced extra warnings for now ]
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> would you mind if I extend it to drivers/gpu/drm/i915/Makefile
>> in the same commit or would you prefer a separate one?
>
>I think I'd prefer separate patches for i915 and xe. And just remove the
>line instead of subdir-ccflags-$(call gcc-min-version, 120000) as
>linux-next handles it properly in the top level Makefile.

yes, this is what this patch is doing, just removing the line.

Lucas De Marchi.

>
>BR,
>Jani.
>
>
>
>-- 
>Jani Nikula, Intel

