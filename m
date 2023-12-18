Return-Path: <linux-kernel+bounces-4221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390D0817944
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DB21C212BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9336C5D72D;
	Mon, 18 Dec 2023 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aP3BNLxl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5351DFDE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702922153; x=1734458153;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rrB37d0MEuCQT466K+KoaqU17Ak0vR9cydmooFfPWfc=;
  b=aP3BNLxlkVaKsz21g/RZE+P8q6dkU7Lorxvo7r1TENY/l3lvhRZSoONi
   7Xd0Ctsz7R9SNYMqizgN9ZsyGH6+DuALEUf814ydSCitLUS7H8Wssk48T
   F2VHLvCVU2o3hNj7kt0d5pbZWXp+p6dL21IRQy7Pp/LGBk5fi+1ytcj4j
   OL//caz0Gp6cjUd4D+ybBWfjOPReb9h5Ke80VMrxjIps+ut3mu9FqGt57
   byko/Rg0996Q3UpD9IVgIjuU7YaP/NvBM7mQpiHqRVEjMPpX4itVWUd0y
   wuxjp9P8Vs3yly2iqoPWtIDcaco8BZH6xVv/z45BYAv9lHfo+TCYKxPmS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2750952"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2750952"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 09:55:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="899052973"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="899052973"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 09:55:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 09:55:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 09:55:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 09:55:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SM7VrKcRhVY/UXNyO7lMmnsHa3JCMAGllS+Wgcb5tCA7yhH0bfoCwv1BCywShp4dqjF0T4Ks4isuXFb232RrqoYCLbrWbHPy08dmRd/7zRuEC+B5GwHFr478wCnWT5VDjqRRIL6FPdtcRp0nsgpxTqDyVCZvZS0Sc39S0CBjHSejG26rzYeMOsGs4US7Q6QSHgdRB4o5l7v6ZImnk43sYAt2I9ySmlmlmENu+0VBWh2EChcNS7nUS4+YQ/r02iwnjfglAc+T/FZ6pSRzqvjevp28cMMXzd0s9kTJEaWGeQqhF4S8HDzQATe/cMirpL4BDC8oLZ0kopeO4WfLW0vYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrB37d0MEuCQT466K+KoaqU17Ak0vR9cydmooFfPWfc=;
 b=hMFTD9UyehikRBKgFzMk0TufH7wYsLRFRMgsm6i+VGVXNdIDP7pjF+eoR1GQA+pSvdYOF2E2/FCQyYZobluX8g101VNj7cPZQM/y7OMjevNT6QCKaBrUDMQWm+Zlppdk1so053Dbo7GqbuZQp+RAOdBEQ7ynOOjUs+5n6JVGsZcx7IdM5edZm5ZDdDr63QY+K/9ECMJxY1zVqK2b7CId1jm2jEEPYbGVaudlaYn2IHS1XMb7zVOC9cNLYtpKf4Wc0dndhLkYtvEiUUNl67qD1q1b5yW64zJHew/hIhc65UR8LdbSjN+fTlcy47K/xMVqM2C8sewH1vKAGwtp0Gg/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA1PR11MB8544.namprd11.prod.outlook.com (2603:10b6:806:3a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 17:55:49 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 17:55:49 +0000
Date: Mon, 18 Dec 2023 11:55:47 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Badal Nilawar
	<badal.nilawar@intel.com>, Akinobu Mita <akinobu.mita@gmail.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, Qi Zheng
	<zhengqi.arch@bytedance.com>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1] fault-inject: Include linux/types.h by default.
Message-ID: <a5o2opdfsfnbptrrbvillogft2uqp73w4icu3mdmmwtvoqmdr2@y2fbrc6t4aew>
References: <20230816134748.979231-1-himal.prasad.ghimiray@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230816134748.979231-1-himal.prasad.ghimiray@intel.com>
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA1PR11MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: c7254daf-307b-4e8d-4b4b-08dbfff291d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYi2ogO6yDcHoKSW8FLbqS53wmXjlJg8Ji9x1Z1EYr8Ro9gLSLDAdX9Ei9cBnXcAw1LqOEzzdXQOBIY+/3q6Z1kUHj5hZ7LwsPz/W1LsmvEcx2WooIAqGB+q+epR1YGBVdT3GMuGaHSvPFtZvXYIBk40bplzvhNw7kn7w1Xt9oJ1AKkZI6e9uaIecLOnhPD9k1MsejGJDzrbiek/9AgXBMF1tKc9jWmueuj/APaX7aKYkt+B5bS912IobIOakE52IF8h52XvBWwACm/iPW+eUgEd+fAmBOemcYh/MBL1y6WXjUIIIYSZm8r/IQ6hKF9yLR60TVDDKqD3XVE0Dd0YDyDqOWEIs+4GwwTEAYSiSQ6kTZz47xPSVO6PetC/c7mRpBtksMZvqKlNrR9Ah4lXYOBIMWD5OSjWPTdXNQQ5uegxDpeYs/p00gkxLhmLdrFYW3t2fCiJOVi+cOwyaNJVEhWIPOWct0KR03z/LeE0CQ8vt9Resn6IW9SENT6ofWXnusGfHHsrjDlDvKY8lw07MwluSpNiM5qD85Fr10VH1AXLNuFv9d6nvvJl4RL89xdb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(9686003)(6506007)(6512007)(33716001)(83380400001)(478600001)(2906002)(5660300002)(8936002)(6862004)(4326008)(8676002)(6486002)(316002)(66476007)(6636002)(54906003)(66556008)(66946007)(41300700001)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mm0jF/iPnbnUusupNUDi+imjNVuxppHe+w8Vmnv9d6Uuj2nzfYd8Hiwh3+7D?=
 =?us-ascii?Q?LIDcQEaTKBX4ygWbyZlnqmyAOqkRxYQCWYUJn8H546It2HhobvIaZuwkOztZ?=
 =?us-ascii?Q?qtzVTF5ZqAcXwKfM8q3xW03jK2ySo/AAFXiaDChpKnWFIofw4Xqj7UzaSnS8?=
 =?us-ascii?Q?72TBuczFwdi+RCc7vC2UJDXGuaFpnvD2r8X1l/ZnifTJkkMMnuTjLnPyX0fK?=
 =?us-ascii?Q?NL3K5ra8yDPLBRkFcD4+Kh80YrYgYu4FDGTwfgCplMvhR7z7paqFfCCctkd0?=
 =?us-ascii?Q?syYy9pVFxqIB3tB5UfwSkdbKE4a7G4OSjPEM0eMrKhuXnsVdZnxVLmVVBmV7?=
 =?us-ascii?Q?v1l/cA//E9YEJvZ5Ix5mpbS1cbC2lOR1OLcduM+rFEzCzHjCu9w0ODAZvCpE?=
 =?us-ascii?Q?dQhJm1r7KBcBKBDgED+RCFImRwysq5Jx4niesnd/1P/lF5kneZB2Da7T2oOU?=
 =?us-ascii?Q?DjoPfjh/jAEowo87olYuZlzEvTlNEK+o4CqhBJ0c6BztcVlEKhai/mXGnwF5?=
 =?us-ascii?Q?bt3ZNmEGPVpwEh8LYNIQDPmUW9alSJYP5XR30iOQgVo60Jx/Vc+9jRmv0RHt?=
 =?us-ascii?Q?apK7WNT7GPzfyvg4d1TRXI8wWefGST5GhGvexIY7I1MpyeQIQZmfQlHvcOyK?=
 =?us-ascii?Q?DqgYoj/ic/4cgcR5vY1RZ5IxVedQO83lz5n98omk86A288bU1XfpIYf6OgUL?=
 =?us-ascii?Q?KoThJxpsvO7bpwLfXDPGB4U4Kdk6TmMYBRrh9MuGrUP39nt7M1h0HvifpDeG?=
 =?us-ascii?Q?OSohXWH+42KBxxrXRUJqT9pxupy0cL61BYVdMWUF0385w5R/uktk82d+cUCQ?=
 =?us-ascii?Q?O04nw/AWp9IK+Ipd6JWW4XOIn4WR6Oes2z6M5BOveoS5Ol9VFuSl69xSgdZT?=
 =?us-ascii?Q?3f0RfWHw8+Sfu5WfBd7BE1EDFN+7bzz7iijGlQoYfticbrHL1fWpoxvWT0vb?=
 =?us-ascii?Q?0OUUvv6HlMfLMnd1TWpD/gksSIGLSa+UKTCJEnRR72Jc/pYHcmrNoPbkSF+e?=
 =?us-ascii?Q?1KWKmYdSzIzQt4TsU+EaUN3OHSs7/OohK1msEXPYT6sPFXEzjsrdr+cMMfKX?=
 =?us-ascii?Q?6KDjJx31WywIt3DkCzvbJhr733mJSY8wlRpMI/Xrjn9zF/Q3W0iGAOCvSkcO?=
 =?us-ascii?Q?g77CfzMy2uqnG9zClHor32j1/GCTCMBSFqItg9KXbWcD5wNJ3xvece3ydhl8?=
 =?us-ascii?Q?ALTDzHud49+XTmR4Swmpa1+il5aCW8YWGnR9qP4pknSgaBSpob+na0jwA81D?=
 =?us-ascii?Q?p3YESUB3G1uITKA7RxM9r5kndg+IZMYX8H6pJeTjLKc9vApmwlJBuXoLHgMK?=
 =?us-ascii?Q?3HQza/2shkaEYkUy0cNgwXc8zIr2M/9oPae8dfch0NjOF56i60REQYYyQJSN?=
 =?us-ascii?Q?ve9HyWqOkWeaWx3Lz79w6BBWn1iQWbTZsUGSR7D6GBeVItkPH/Y+R7JVpBQ0?=
 =?us-ascii?Q?oSAKit7o7bqbCwN4SmJodCFhoC+SGqSBL3EesNbq3ZG/lUgH0e4Ew7cilqQO?=
 =?us-ascii?Q?f8xEY4u6U6eA2hCK5QonjV4OwC772+ROyI0613mfJ90oVKD3Ct7bI9nfz0am?=
 =?us-ascii?Q?VVSlK+jD9JG7ljtML1LfaJH1b1Pw/CSulEdL5kAs8qnoYTAdO1S266Bl42OO?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7254daf-307b-4e8d-4b4b-08dbfff291d7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 17:55:49.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnpcF6iCtuzhW7VPde7kzP87l6CzaS8e9ZAluO5o8J1kfB9Du5hGrvvZkM4/OlXNj+iQS1ErTqqmgpgwzlKXwGH4V5JY0eNxwfWXCY9GKpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8544
X-OriginatorOrg: intel.com

+Andrew

On Wed, Aug 16, 2023 at 07:17:48PM +0530, Himal Prasad Ghimiray wrote:
>Functions should_fail_alloc_page, should_failslab, and __should_failslab
>are declared irrespective of CONFIG_FAULT_INJECTION. These functions use
>bool and gfp_t types, which are treated as unknown when
>CONFIG_FAULT_INJECTION is disabled because the inclusion of linux/types.h
>is missing.
>
>Fixes: 6ff1cb355e62 ("[PATCH] fault-injection capabilities infrastructure")
>
>Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>Cc: Badal Nilawar <badal.nilawar@intel.com>
>Cc: Akinobu Mita <akinobu.mita@gmail.com>
>Cc: Jason Gunthorpe <jgg@ziepe.ca>
>Cc: Jens Axboe <axboe@kernel.dk>
>Cc: Qi Zheng <zhengqi.arch@bytedance.com>
>Cc: linux-kernel@vger.kernel.org
>Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Andrew, could we take this through our drm-xe-next branch going to
drm-next if this looks good to you?

thanks
Lucas De Marchi

