Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6C0757205
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGRCyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGRCyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:54:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87BC100;
        Mon, 17 Jul 2023 19:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689648847; x=1721184847;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cZGiV0cNohOvxzDUu3QmnVp0Ph4E9irFnOylIbGjCyk=;
  b=MFexfEtve1+CdBzH4wD2Yn1dC7ONsihWk9SHPixAqN6jI/MIpJwM+3Wn
   687qmRsoDt0Xi+q5Xf4m9aWCWL17QUq/xKhFv6mgWoN52QOHIttqaEAyC
   hEJdzOYL2RpWdXgs9K0+EFlyL2wTN8ooxMey1OOAMqMcmuzhRoc0cUpiF
   kDi7RSLPE5/x889P5SWKjJvNMwuTi8xIeYUIhYA/PDIoYcNLIO4VpdzpZ
   lqcVQbLmvwm1VAqSl+ghq3IJM7oWvI0wu4jWUij3nzkAAnAwXzHqNzlwT
   VtwRc2luRpqr0HwyaH3ooOb8EaQScflEfAR9JIVkzn3O9Di2L+Fm5gEu7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366130097"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="366130097"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 19:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793470715"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="793470715"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2023 19:54:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 19:54:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 19:54:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 19:54:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 19:54:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHHxKFHcY5taS1NDVZgwrB+Bf9GTmQ3aAHC91Q/l2NPAQmuFdWqGg45d1e0vj+7ekxiy5bQ/VXjDr3adrxkv9QpBR1RItodnsMEQaI+/Xjyq/OaAamFAPkzZE+kUx9MGfDbX2umx3ta0JzudPgIhX1gF+9WcI/nqnmsNltgnBq92ik2hYEVHlcaaFVJIHwHjtdTXwWqG0HGO61VvLx2ABbO9TIpLPinzLfJ1m1AwBRVJSUrstJ1Ckvq4gtf5worH+GOIukqJGerVbdjFQqUnZBhQ7jW2fgUI/TG+E72FS438uAeubhRKO2dgkq8lTTuElTYD6vvrzxz6OtAr16/0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10mAVhD6BKEsAAGsNj+AYZdA5qRMQFWVj/I5CSsYHp8=;
 b=IdxhLezWTqkkDI4CzOosqBo4VUBomlpl1fpRzc5TwGTEW9F2C29x9X9+qJkPAl/qb46+wRx8SkZdba8TX8Jsj4IL5e3k59C5lUP27iYjbse522cENkubF0Hgtljqghey11IkmCskIdp7yqdsLB1gKoYQmSP7qZYm1ewR2XebHQ1H2D7UYSJ2YmwpQ1L0+8HDS3fJqnbVQCG2OIHEk61uzd6dfWs/Sj1jVu9giu2a6BQmka7B7x/vzsN/1rzKWVd8AYMwr/pnleantoYkMpxTfXgEmfCEzieqIyGHeahwDd6IP0FmWD5PvCFAi2eEpr4zv1+lkZ8jKa4enzzxyC16hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4699.namprd11.prod.outlook.com (2603:10b6:303:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 02:54:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Tue, 18 Jul 2023
 02:54:01 +0000
Date:   Mon, 17 Jul 2023 19:53:58 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Chenyuan Mi <michenyuan@huawei.com>
CC:     <Jonathan.Cameron@huawei.com>, <dave.jiang@intel.com>,
        <rrichter@amd.com>, <alison.schofield@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl: Fix memory leak bug in alloc_mock_res()
Message-ID: <64b5fec6800a4_45a6294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230717041609.1162445-1-michenyuan@huawei.com>
 <64b5d3a033e5c_45a6294f1@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64b5d3a033e5c_45a6294f1@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:303:83::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: 465450b5-2edf-4bdc-cde9-08db873a3d4f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3KYD8Wbkh7kvlgA4y9ysom6GqxGzJ7ZS+KJluZ0MvJvY+bx0VWEWMMMyrs/tfLahOMuxpbnYHvXwL2QRoYG/pezawv1vQUQ8xc2Ab19UTzj7JPlomMIjXJY530Pu4Gj2Ixy9IVoqEkxBjKCvDLxYPGTvMgwmYT/EJ/VSen/LKqVdO5zfQJjy1fef2tDlFeWG1CrSTO2w2uLeV7MBcltnfPsbzUhnlOgumZhFu6k+6RhVoltaxShy7jlRW6WxXJmgDawso4iNQqhMlOd/3ipO4EcW3W5iRdp/GRYBOnWjI1nNzvXk3CliVFIq08Fo1InqfIhI3NuYI+0sL6jgm2bSc/q2jB6JufGwAWl02MGenI3HOihMNF2niOb2nGDraWfIFlqN+eIMlrprcpuBAwPH2q3cW9yIs+rndGfm7U3eBiRcMQ3spOPzd5aqbmVopkDmxpHhDmVlp9k2pILV5/yPhJLmU3qY+8vewr+mJrXY9f1YhX+RZ9/r9qQHzxOnOf8ZugJJqixNjVnh3iOn2J2exD4Qgk+DBI5WT9HULGiQT17AptLgJbGnr7bNVm++wfc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(6666004)(110136005)(82960400001)(6486002)(38100700002)(316002)(8676002)(41300700001)(8936002)(5660300002)(478600001)(66476007)(4326008)(66946007)(66556008)(83380400001)(186003)(6512007)(6506007)(26005)(9686003)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VY7T1KR90OEVU3cGDYpzs4toYy0ACW+AXSSa8C8fxKoLtYH7nE3AMACrbH/7?=
 =?us-ascii?Q?FhSSi98oNZP8kyazbSgS1UK5OdJHfl4FTyLDUp+d26WwoaxdK6bt7laWt7hB?=
 =?us-ascii?Q?FXJ18scYJG3qFzIIiWxCGh2HlbUznfP8zMBibXvzAXEqpZbxPPPgR2yhpvKA?=
 =?us-ascii?Q?oTaRsG4jF1mdg1AB+lD12NIKTgHgoBqKlaqCS2hJ41zRC6JFphp+/RUwB2en?=
 =?us-ascii?Q?jBAzWnhd4qKFCrmbx0h9RfjKRPBNA/TUyaohcn+mpxV1jRHAeshtWv099Dib?=
 =?us-ascii?Q?YeBnUwdFd71McSr4WabwXkcx2coozjlUBNBfqPHn1SODzd0z96j1yYWz4wHf?=
 =?us-ascii?Q?oXhQQQl/qHj04KCktiTCVnw5gEbdyp0JkbWyF0TgObwYndDDr7TVlb/ee0Lg?=
 =?us-ascii?Q?fExuEr6d9ci/G4NG7qUuN7jEHjDd0IJyYvbTplFZE5deBc+gzfKVoAaps1xH?=
 =?us-ascii?Q?a8dl6K4FJdtv0BwGMtVZFohsajWlNMdGCzCjCqoF1Jwtz1ZAT1hxelTqYrsc?=
 =?us-ascii?Q?iDqsxl97J2i7YXNm8aJDqkLsm9DCRP9+2/7MPhppORBmDV0zuZQSfdNiq9l0?=
 =?us-ascii?Q?vftgwctEpmv3LnWIdVncbL4nW5wQgIP6Dun7HkPSaaEGQPrAlg8cTp0oox2y?=
 =?us-ascii?Q?m30XsGEXoQFNxnc+CP4PP7QWlXURpsWTNAXyrgsc1+5k9mr8lKPmZq9kiHty?=
 =?us-ascii?Q?CVWr/tBWleXFlN06RvysiaibOWyesxT1t3kbgUEOybI6OCEs+SjqKUEw93bT?=
 =?us-ascii?Q?EOFB5TIKEXMGf+2WnycMI+Apy78MM6p0gbWm30EduwTmxcCS/2gThWRYp1/f?=
 =?us-ascii?Q?BtlDlFGTgE1zCXdl4iwAVBcWc9kS0lz4+MbTAGhqBbNtLuF/C9xcYT3jUR2A?=
 =?us-ascii?Q?G4AU9wJfAt3xov/it9i4+j4kZOoPi1ZDn1A0gJTARkTODEyyZKpqa5fdLAwL?=
 =?us-ascii?Q?NcZh//zfjSkmtaX51K0SFRlLsC9rdHmPRkoeoWXm5ImlIg7B3xLbfXSLPpkC?=
 =?us-ascii?Q?Arb1hNoOHih8o1k58MRjs8N6AHNsL9x+szeB7VKTb9db51+qUIs88EQ9S7e5?=
 =?us-ascii?Q?lqoI3y4m2lzUJCdHzwGj6K3jCf7PQQQY2ChytKxcZPL7U9zQrKAihSVxy7aq?=
 =?us-ascii?Q?d1tX8lWd/Kk70iI33/d0vl4C8o+8+rkyOu4elnxX0r6VvX94aNoK8Bw0ct6Y?=
 =?us-ascii?Q?btmFzAV54ZtIsrIkbujHTeXu0DFgKQg0DARKq/ytmxaTk+ocQLQFbvBPCkDr?=
 =?us-ascii?Q?DnKPgsUQllfgu5t7wD96y0VzKqsiZHPIEw9+LytAkPpSuIM+WATYmM1QlwdG?=
 =?us-ascii?Q?4Z8HEzhvlukOXxSczvquOJKO8cUY9zesXx4Sy27s25ftflUuParQofFKGJM1?=
 =?us-ascii?Q?M1t8tv1cj0xiGaJEJDD3S4tIFHGdJsYgtHNwt+T0kK54kZgR1sYx8m2jrS52?=
 =?us-ascii?Q?MfKNvVKDA5XA/bPRqD7GAfqOgC006mEEQUXE7OaheyZi62PoxMVoMHsG847J?=
 =?us-ascii?Q?JeQUY5zU416339Ug0h3j3tSDKRiZNC/et6fLW5tfma9U8R0kTLqpWwQI6F5i?=
 =?us-ascii?Q?/CoYtAJtTC0qk00HH4Rz2iWAvgynGnAh09aReTsRcpDP3H0t9qZLtc9j5nTO?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 465450b5-2edf-4bdc-cde9-08db873a3d4f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 02:54:01.0804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LCH5bQUM9o19JymxqW6XnciivYZRj7UZv9uEWTVesFss+QCU8eCEI92CiMLlsyg8WowXnTXFfIACBf0nHGRjcwCdJh/bImFn1HFz+su7dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4699
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Chenyuan Mi wrote:
> > When gen_pool_alloc_algo() fails, the error handling path
> > forgets to free 'res'. It would cause a memory leak bug.
> > 
> > Fix it by add kfree() in error handling path.
> 
> Going forward I want to set the policy that any error path resource leaks be
> fixed by converting to using __free() and associated helpers.
> 
> So in this case it would be:

...and to be clear I do think the fix should be applied in a backportable
fashion and then followed up with a conversion for the next merge window.

> 
> -- >8 --
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 0e78d8e19895..ea04995fe42c 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -396,7 +396,8 @@ static void depopulate_all_mock_resources(void)
>  
>  static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
>  {
> -	struct cxl_mock_res *res = kzalloc(sizeof(*res), GFP_KERNEL);
> +	struct cxl_mock_res *res __free(kfree) =
> +		kzalloc(sizeof(*res), GFP_KERNEL);
>  	struct genpool_data_align data = {
>  		.align = align,
>  	};
> @@ -416,7 +417,7 @@ static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
>  	list_add(&res->list, &mock_res);
>  	mutex_unlock(&mock_res_lock);
>  
> -	return res;
> +	return_ptr(res);
>  }
>  
>  static int populate_cedt(void)


