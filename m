Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FBC7F6C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjKXGxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXGxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:53:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F1BD5E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 22:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700808810; x=1732344810;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=aFwwtQW7njXamApmCieaYkjd266vKBVtl1gXZi+u5io=;
  b=dBlTq9fBpONs2QIKgHRlHoZcEt+WWsDs1IpV+xPCKJuzGASsmXi40ScU
   kasNQWAWpaLly2dVZxhzy9MSTEhZRra144zsYbEIYj4WmAT0a+R1b/+Fo
   jvlCmWRbZGsQvzLm8UDCeID9xSglChRfJ/tGMvK7Kx1JiMmPU5ZN8Sthz
   ITE+O3LPefG4+JFuqrMCmuTb4qzQOk5JNKTi7rKJtiZN9EBRCNGo3e0vg
   BxSL2EC6yssaHDzuLnmGPdc4tTPHlYChtZ91qol90CY/MOT5C7HcG5KHT
   WDl3YbmApaBCBhcdELlLhP4wF9DYPF0qK8HNQxlBHlFpwsZYu6Vc0PxkK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377407951"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="377407951"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 22:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="911357692"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="911357692"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 22:53:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 22:53:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 22:53:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 22:53:25 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 22:53:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj3gOwFkIJk+1XBtAJFnuy9PB2eYQz85STakZRVNpNvFrZCHr9vMXCW01GEP485Rvdh0FPElzgq7w0lNnB+SxDs/62B/tt/RVkR/UVKHk5JyE3kPIVpcB802u6q9cZIUqPrrSAv5tyXgNxX/tCMP+2TjpkicQfvWP4qauRbRIArDro0lFX2DkzEUS47ur1sHRnBaUNIYT0nyQf0O+lmhFzolUxkijQxUpgqlStYbcIBnBD/qw6EDoVx9muhhrhbz2aP3WGsiuwMYBEGtoMyBDC7nHSiSScu1R7g/HrdWwajppXOmcNgDJ6HhdSna+NktDoOTXZAEIKTSKzdFjiRXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwcpR9C/823jYjLnO4kkvlRVTPEvulU97rHu8KJYJs4=;
 b=CL2F2xSt4sJmlNOkgC/ZIf6G/hmEIVvn/qQZH9N1LYcpKP+Ka0XPMRXzflRWQpQL3ALuOifvUIyqqPXD2wOgq4z8Si3eD4Nj3qTUCTgtiUbVyH2dRw//x7WlA1dwQu73AclH4iaQEb8jJbpCsl1CkA0Tl6pwqrOmfw/3sqYyBphKlicp/Yb4abbA2vyHrBKCXFX+ckNM+XqdeC4mKFkOomsxfsnx8P6jAebdXYNIWVgkP33gW1RDOynzGLM6zlbjZuKvnrxh+5MiilINXF7RVFfs756JV1Bb1ebHoL0wF+hl3gcui3Hh+XcreFFyCI3JLuum89kg+5BBKzWDUGHRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ1PR11MB6273.namprd11.prod.outlook.com (2603:10b6:a03:458::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Fri, 24 Nov
 2023 06:53:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Fri, 24 Nov 2023
 06:53:19 +0000
Date:   Fri, 24 Nov 2023 14:53:05 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Pavel Tatashin" <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>, <linux-mm@kvack.org>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: Re: [linus:master] [mm, pcp]  6ccdcb6d3a: stress-ng.judy.ops_per_sec
 -4.7% regression
Message-ID: <ZWBIUa92yQFaQ/kM@xsang-OptiPlex-9020>
References: <202311231029.3aa790-oliver.sang@intel.com>
 <87r0kh81u5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/mixed; boundary="p/yrhrNiooBtE2cS"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0kh81u5.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ1PR11MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e70f69-746e-4964-01b1-08dbecba0974
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdCcfHRLum9GTVO1SP4yLeDtJO3tUZTGg0zlDadQ1Qasarqg2y1YmGk2ttPhUQurU+p+MacTQj5UP/MLLntKZq9GJcIl9OVtDKTBtOndm37vHASz9pWeZ3WxxD4b4URf1UIFfhv01SIVAA40fespQjFRMwW20L9nY8QmdbeNZExQh7aUwbGZfNnLuOinWCwzIrWqxPpSnSVbp/YyOnGBZgI9lz/H2O+Wc6oQYfhFU1RqB2j8WicGMHa3z8OOFbpUzJ//1VlZ11YeaA7yOwl4R8yjx8kODQ7kjiE0B7AQKK8bSOqugoXcwaQ2Z7gK440/JCQy31RYdSUK76LkHMyUuBYPYlchHwLwnGYLeGNZQaunL1bc99WNhJYl3u154jHxQ10sdiH24wh/J6qaDr0/VOUE5f3VsRSdN/hY6dFRayUrs7YLL91GjFG3kIP7xXZZVWmi7qdQkdeQY4P6VJGZw0/PF6AIrQMddE1QCoXLW9G7S9wx8OijWgUSBlPszKKwXY2PNl+pk3dctAay0rrHSBUJYri4dQhB6o/ftvEf9+j5zay/H02+xoXyukHNrRNjVLPEW1xCfhiIleezVrodHojROvx4W0PRVZPsIClnWa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6506007)(84970400001)(66946007)(66556008)(82960400001)(54906003)(38100700002)(66476007)(86362001)(6666004)(966005)(33716001)(44144004)(9686003)(83380400001)(6512007)(316002)(2906002)(26005)(8676002)(6486002)(7416002)(4326008)(6636002)(478600001)(19627235002)(8936002)(41300700001)(6862004)(5660300002)(235185007)(44832011)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?G3VvszzBDp5GWBXHUFgmMn78ri5zgR574kbfDJrCnRwCaGoZPy3Zz4zGXE?=
 =?iso-8859-1?Q?GnYLbIUEq/HTNxzlg9pi7oHGdc5S9w1YMBKPQNaW0rbkEzdkMkCWE3CQ9z?=
 =?iso-8859-1?Q?W08dXI9KNLHCcE5xk7gPzMe4spLwmoS+e327JmGempwlNgFFofHscD0Dak?=
 =?iso-8859-1?Q?2Vmk11D7ykjiCHL6yOV/C20Hq+2ISFYVLoUhDAm18wRDz02p+HNJ8MMsH7?=
 =?iso-8859-1?Q?6oZB9+KW3VQIs+pO4D2oW9jLBfl2WpD/ZqDHQrbWqA0VmkuClb8USlhO+n?=
 =?iso-8859-1?Q?ZiofD7tciepqM6OD+h00RVMz/ibB/jyLIjLjLx/lRUxMgMtlzGBpYSX9O6?=
 =?iso-8859-1?Q?baN3E4ZtXMazZMecB6+DhNGTDUHC/+c4IcTZkxfaTlGXmdpSuXOIf+pXx6?=
 =?iso-8859-1?Q?6sMuD65U0s5owZ/adwtbElA5db6U06yOr8yC+88Pl2RmEe12VRz8JkIvTq?=
 =?iso-8859-1?Q?5hTAu64ZQ+cCzXdDF9AEJrpi8wz6dvFXjRiTBEyKWGD8GXSG6TJr9jBW1c?=
 =?iso-8859-1?Q?QtzAF78koEetMvExwgDOabClA2GxxL4QtECFsyZHgZ9H7mqHIbktGb5cW9?=
 =?iso-8859-1?Q?Vfv3409OOUQCgAoBpxfZAqDrfdQc5uiwy1t+UKTroAmLwKDrOLIxTbvRaa?=
 =?iso-8859-1?Q?AxcgmCwOChuCIxDGvSD/RjuK/FLb3O4qgzLZclL3Asbmd7uikPCPyt1GGE?=
 =?iso-8859-1?Q?bumCTI2fIoEM3IqpmWqwhKzvtpbFwRsBluhnDkeDEKIeCK7qTfrQaZqgEx?=
 =?iso-8859-1?Q?vWSlFBL7H2qqv1bX2MOEeGFaV9Uw5H0zw31BIHjCXwJ333HjPzfjGzbRvo?=
 =?iso-8859-1?Q?yWkUN3JXfAmiRdHF93qvBEezv7rZt7OhaG1LKljwTKGlpFv8k2IoPvsguF?=
 =?iso-8859-1?Q?nLIkyKl9bclJK6Q4EzPDwSVMqd7XK0ozko4eALLCZZaXt4CRjHxkR7z+xl?=
 =?iso-8859-1?Q?oln4DXZJBLKdq7AImkfRgmyu4Hkv8WId1cSsbvJ+eIbM/+p8BWAp8p763E?=
 =?iso-8859-1?Q?ZwrXl6JTTza9ZRGnBfQKhsuyflopYBODgZmohW/lYrXDINuix+TVSw5stV?=
 =?iso-8859-1?Q?jCjuvCwUCPKp4OwW8ZCljsB8FxixEPGQBYbcYRlJKLYNQWW+s6BEin+37y?=
 =?iso-8859-1?Q?6WuGMelHP+eCcbEiEX46FKoZDSXB8m0OtMiGlnefTc57EFq1WjoXy+RFna?=
 =?iso-8859-1?Q?y/vhG91+56kRPtEVMsIAL09mqw8JP/hQWHkJZhHbBNKKtHHKu4QGEPIna1?=
 =?iso-8859-1?Q?sdjoEhMnvwvezW6S2c/NlD890CN9GeQKCCacMEFXMkm3r4t8l5TUH57Gmk?=
 =?iso-8859-1?Q?YbjB7215LNds2aks8fR+32bTZ2JDI+5TOsGPquxTbDO2OKm7Ka2gsEO9wc?=
 =?iso-8859-1?Q?v61sD7fzGRQTZHYLExCGYD4nA3lITaGf8LQvunY7oLJJAs0ECze7LsgTN1?=
 =?iso-8859-1?Q?YMcnlrwlFJefo1Gqq9hkkN/ZoOSmJ44jFFUMNk4ZoenmEgxTfHM4iG0J3H?=
 =?iso-8859-1?Q?dyQDMFvmiKS2+nYeyGJO5tlpYc4KgV1oK1UxF0Lxk9AzaV4K4qQUwpoWpi?=
 =?iso-8859-1?Q?9ybQ27tTONvt4C3F1ZxV/e20kIZIIHoQaIiYmY6OyKyff7qaO3RsgFg7pd?=
 =?iso-8859-1?Q?um4g4RLE7i2e3l01+ojWvj18AxHyf4KDO9ngtr3zwCIZdEoRAojlrk9g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e70f69-746e-4964-01b1-08dbecba0974
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 06:53:18.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxOhLBqGZPjRqjcwgDraEr8jSxonsYhTryLcubVmnqVU9y529JWvoUOm7JroJk7Mts9BLSCi6nFpO2ggfm//WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6273
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--p/yrhrNiooBtE2cS
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

hi, Huang Ying,

On Thu, Nov 23, 2023 at 01:40:02PM +0800, Huang, Ying wrote:
> Hi,
> 
> Thanks for test!
> 
> kernel test robot <oliver.sang@intel.com> writes:
> 
> > Hello,
> >
> > kernel test robot noticed a -4.7% regression of stress-ng.judy.ops_per_sec on:
> >
> >
> > commit: 6ccdcb6d3a741c4e005ca6ffd4a62ddf8b5bead3 ("mm, pcp: reduce detecting time of consecutive high order page freeing")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > testcase: stress-ng
> > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
> > parameters:
> >
> > 	nr_threads: 100%
> > 	testtime: 60s
> > 	class: cpu-cache
> > 	test: judy
> > 	disk: 1SSD
> > 	cpufreq_governor: performance
> >
> >
> > In addition to that, the commit also has significant impact on the following tests:
> >
> > +------------------+-------------------------------------------------------------------------------------------------+
> > | testcase: change | lmbench3: lmbench3.TCP.socket.bandwidth.10MB.MB/sec 23.7% improvement                           |
> > | test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory |
> > | test parameters  | cpufreq_governor=performance                                                                    |
> > |                  | mode=development                                                                                |
> > |                  | nr_threads=100%                                                                                 |
> > |                  | test=TCP                                                                                        |
> > |                  | test_memory_size=50%                                                                            |
> > +------------------+-------------------------------------------------------------------------------------------------+
> > | testcase: change | stress-ng: stress-ng.file-ioctl.ops_per_sec -6.6% regression                                    |
> > | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory        |
> > | test parameters  | class=filesystem                                                                                |
> > |                  | cpufreq_governor=performance                                                                    |
> > |                  | disk=1SSD                                                                                       |
> > |                  | fs=btrfs                                                                                        |
> > |                  | nr_threads=10%                                                                                  |
> > |                  | test=file-ioctl                                                                                 |
> > |                  | testtime=60s                                                                                    |
> > +------------------+-------------------------------------------------------------------------------------------------+
> 
> It's expected that this commit will benefit some workload (mainly
> network, inter-process communication related) and hurt some workload.
> But the  whole series should have no much regression.  Can you try the
> whole series for the regression test cases?  The series start from
> commit ca71fe1ad922 ("mm, pcp: avoid to drain PCP when process exit") to
> commit 6ccdcb6d3a74 ("mm, pcp: reduce detecting time of consecutive high
> order page freeing").

since:
* 6ccdcb6d3a741 mm, pcp: reduce detecting time of consecutive high order page freeing
* 57c0419c5f0ea mm, pcp: decrease PCP high if free pages < high watermark
* 51a755c56dc05 mm: tune PCP high automatically
* 90b41691b9881 mm: add framework for PCP high auto-tuning
* c0a242394cb98 mm, page_alloc: scale the number of pages that are batch allocated
* 52166607ecc98 mm: restrict the pcp batch scale factor to avoid too long latency
* 362d37a106dd3 mm, pcp: reduce lock contention for draining high-order pages
* 94a3bfe4073cd cacheinfo: calculate size of per-CPU data cache slice
* ca71fe1ad9221 mm, pcp: avoid to drain PCP when process exit
* 1f4f7f0f8845d mm/oom_killer: simplify OOM killer info dump helper

I tested 1f4f7f0f8845d vs 6ccdcb6d3a741.

for stress-ng.judy.ops_per_sec, there is a smaller regression (-2.0%):
(full comparison is attached as ncompare-judy)

=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  cpu-cache/gcc-12/performance/1SSD/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-spr-2sp4/judy/stress-ng/60s

1f4f7f0f8845dbac 6ccdcb6d3a741c4e005ca6ffd4a
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
   6925490            -0.9%    6862477        stress-ng.judy.Judy_delete_operations_per_sec
  22515488            -0.4%   22420191        stress-ng.judy.Judy_find_operations_per_sec
   9036524            -3.9%    8685310 ±  3%  stress-ng.judy.Judy_insert_operations_per_sec
    171299            -2.0%     167905        stress-ng.judy.ops
      2853            -2.0%       2796        stress-ng.judy.ops_per_sec


for stress-ng.file-ioctl.ops_per_sec, there is a similar regression (-6.9%):
(full comparison is attached as ncompare-file-ioctl)

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1SSD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/file-ioctl/stress-ng/60s

1f4f7f0f8845dbac 6ccdcb6d3a741c4e005ca6ffd4a
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    340971            -6.9%     317411        stress-ng.file-ioctl.ops
      5682            -6.9%       5290        stress-ng.file-ioctl.ops_per_sec

> 
> --
> Best Regards,
> Huang, Ying
> 

--p/yrhrNiooBtE2cS
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: attachment; filename="ncompare-judy"
Content-Transfer-Encoding: 8bit


xsang@inn:~$ lkp ncompare -s commit=1f4f7f0f8845d/tbox_group=lkp-spr-2sp4/testcase=stress-ng -o commit=6ccdcb6d3a741  -a | grep -v interrupts | grep -v softirq
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  cpu-cache/gcc-12/performance/1SSD/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-spr-2sp4/judy/stress-ng/60s

commit:
  1f4f7f0f8845dbac40289cc3d50b81314c5a12b8
  6ccdcb6d3a741c4e005ca6ffd4a62ddf8b5bead3

1f4f7f0f8845dbac 6ccdcb6d3a741c4e005ca6ffd4a
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
         10:10           0%          10:10    stress-ng.judy.Judy_delete_operations_per_sec.pass
         10:10           0%          10:10    stress-ng.judy.Judy_find_operations_per_sec.pass
         10:10           0%          10:10    stress-ng.judy.Judy_insert_operations_per_sec.pass
         10:10           0%          10:10    stress-ng.judy.pass
         %stddev     %change         %stddev
             \          |                \
    151.27 ± 56%      +6.6%     161.22 ± 52%  dmesg.timestamp:last
    124.42 ± 11%      +1.1%     125.79 ±  9%  kmsg.timestamp:last
 1.107e+09 ± 29%     +67.3%  1.852e+09 ± 75%  cpuidle..time
   1084691 ± 30%     +71.0%    1855097 ± 77%  cpuidle..usage
    125.81 ± 10%      +3.3%     129.98 ± 11%  uptime.boot
     13667 ± 21%      +6.8%      14591 ± 23%  uptime.idle
     53.76 ±  5%      +0.6%      54.06 ±  4%  boot-time.boot
     30.41            -0.2%      30.36        boot-time.dhcp
     11000 ±  5%      +0.6%      11066 ±  4%  boot-time.idle
     10.11 ± 18%     +35.2%      13.67 ± 51%  iostat.cpu.idle
      4.96 ±  2%     +25.9%       6.25 ± 17%  iostat.cpu.system
     84.92 ±  2%      -5.7%      80.08 ±  8%  iostat.cpu.user
      7.37 ± 27%      +3.8       11.16 ± 66%  mpstat.cpu.all.idle%
      1.57 ±  3%      -0.1        1.51 ±  5%  mpstat.cpu.all.irq%
      0.14 ±  3%      +0.4        0.49 ± 33%  mpstat.cpu.all.soft%
      3.38 ±  2%      +1.0        4.41 ± 22%  mpstat.cpu.all.sys%
     87.54 ±  2%      -5.1       82.43 ±  8%  mpstat.cpu.all.usr%
     17731 ± 33%      +7.7%      19098 ± 26%  perf-c2c.DRAM.local
    227.40 ± 39%     +19.3%     271.30 ± 26%  perf-c2c.DRAM.remote
    396.50 ± 33%     +21.0%     479.80 ± 29%  perf-c2c.HITM.local
     54.60 ± 51%     +12.1%      61.20 ± 35%  perf-c2c.HITM.remote
    451.10 ± 35%     +19.9%     541.00 ± 29%  perf-c2c.HITM.total
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
  42179114           -12.9%   36727757 ±  8%  numa-numastat.node0.local_node
  42322224           -12.9%   36881294 ±  8%  numa-numastat.node0.numa_hit
    141985 ± 51%      +8.1%     153548 ± 39%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
  41820129           -12.8%   36449421 ±  9%  numa-numastat.node1.local_node
  41909301           -12.8%   36528507 ±  9%  numa-numastat.node1.numa_hit
     89842 ± 81%     -12.8%      78315 ± 77%  numa-numastat.node1.other_node
      9.94 ± 20%     +37.6%      13.68 ± 50%  vmstat.cpu.id
      4.91 ±  2%     +27.3%       6.25 ± 17%  vmstat.cpu.sy
     85.15 ±  2%      -6.0%      80.06 ±  8%  vmstat.cpu.us
      0.02 ±  2%      -4.2%       0.01 ±  8%  vmstat.io.bi
      4.00            +0.0%       4.00        vmstat.memory.buff
   3275886            +0.7%    3300023        vmstat.memory.cache
 5.199e+08            -0.1%  5.196e+08        vmstat.memory.free
    202.27 ±  2%      -3.2%     195.88 ±  7%  vmstat.procs.r
      9290            -4.0%       8915 ±  6%  vmstat.system.cs
    366738            -2.3%     358141 ±  2%  vmstat.system.in
     62.20            -0.0%      62.20        time.elapsed_time
     62.20            -0.0%      62.20        time.elapsed_time.max
    258360            -2.6%     251676        time.involuntary_context_switches
      0.30 ±152%    +166.7%       0.80 ±108%  time.major_page_faults
     10893 ±  7%     +23.0%      13397 ± 29%  time.maximum_resident_set_size
  82141065           -13.1%   71375734 ±  9%  time.minor_page_faults
      4096            +0.0%       4096        time.page_size
     21055            -1.2%      20804        time.percent_of_cpu_this_job_got
    480.34           +35.5%     650.87 ± 21%  time.system_time
     12618            -2.6%      12291        time.user_time
    563.40 ±  2%      -0.7%     559.50 ±  3%  time.voluntary_context_switches
      2608 ±  2%      -3.3%       2521 ±  7%  turbostat.Avg_MHz
     92.38 ±  2%      -3.8       88.53 ±  8%  turbostat.Busy%
      2839            +0.9%       2864        turbostat.Bzy_MHz
      1414 ± 18%     +32.0%       1866 ± 35%  turbostat.C1
    527910 ± 28%     +64.1%     866385 ± 73%  turbostat.C1E
      3.33 ± 26%      +1.7        5.05 ± 64%  turbostat.C1E%
    612375 ± 28%     +67.9%    1028102 ± 76%  turbostat.C6
      4.26 ± 24%      +2.1        6.39 ± 62%  turbostat.C6%
      7.50 ± 25%     +51.2%      11.34 ± 63%  turbostat.CPU%c1
      0.12 ± 17%      +1.6%       0.13 ± 21%  turbostat.CPU%c6
     59.70 ±  3%      -2.0%      58.50 ±  4%  turbostat.CoreTmp
      1.25            -2.6%       1.22        turbostat.IPC
  24279278            +2.3%   24843604 ±  5%  turbostat.IRQ
    180.02 ±  2%     -11.0      169.01 ±  8%  turbostat.PKG_%
      2789 ± 31%     +33.1%       3712 ± 47%  turbostat.POLL
     60.00 ±  3%      -2.3%      58.60 ±  4%  turbostat.PkgTmp
    672.54            -1.8%     660.52 ±  3%  turbostat.PkgWatt
     37.66            -2.4%      36.77 ±  2%  turbostat.RAMWatt
      1989            -0.0%       1988        turbostat.TSC_MHz
   6925490            -0.9%    6862477        stress-ng.judy.Judy_delete_operations_per_sec
  22515488            -0.4%   22420191        stress-ng.judy.Judy_find_operations_per_sec
   9036524            -3.9%    8685310 ±  3%  stress-ng.judy.Judy_insert_operations_per_sec
    171299            -2.0%     167905        stress-ng.judy.ops
      2853            -2.0%       2796        stress-ng.judy.ops_per_sec
     62.20            -0.0%      62.20        stress-ng.time.elapsed_time
     62.20            -0.0%      62.20        stress-ng.time.elapsed_time.max
    258360            -2.6%     251676        stress-ng.time.involuntary_context_switches
      0.30 ±152%    +166.7%       0.80 ±108%  stress-ng.time.major_page_faults
     10893 ±  7%     +23.0%      13397 ± 29%  stress-ng.time.maximum_resident_set_size
  82141065           -13.1%   71375734 ±  9%  stress-ng.time.minor_page_faults
      4096            +0.0%       4096        stress-ng.time.page_size
     21055            -1.2%      20804        stress-ng.time.percent_of_cpu_this_job_got
    480.34           +35.5%     650.87 ± 21%  stress-ng.time.system_time
     12618            -2.6%      12291        stress-ng.time.user_time
    563.40 ±  2%      -0.7%     559.50 ±  3%  stress-ng.time.voluntary_context_switches
     46768 ± 18%     +73.1%      80961 ± 56%  meminfo.Active
     46689 ± 18%     +73.2%      80881 ± 56%  meminfo.Active(anon)
     78.40 ±  6%      +2.0%      79.98        meminfo.Active(file)
    127245 ± 16%      +5.8%     134611 ± 14%  meminfo.AnonHugePages
   1451846            -2.1%    1422053 ±  6%  meminfo.AnonPages
      4.00            +0.0%       4.00        meminfo.Buffers
   3121206            +0.7%    3144477        meminfo.Cached
 2.637e+08            +0.0%  2.637e+08        meminfo.CommitLimit
   4368713            -2.2%    4271782 ±  5%  meminfo.Committed_AS
 5.245e+08            -0.1%   5.24e+08        meminfo.DirectMap1G
  11274240 ± 12%      +4.5%   11782144 ± 12%  meminfo.DirectMap2M
    198052 ±  5%      +8.3%     214436 ±  5%  meminfo.DirectMap4k
      2048            +0.0%       2048        meminfo.Hugepagesize
   1800847            -2.1%    1763898 ±  5%  meminfo.Inactive
   1800650            -2.1%    1763721 ±  5%  meminfo.Inactive(anon)
    197.33 ±  2%     -10.5%     176.70 ±  8%  meminfo.Inactive(file)
    148140            +0.2%     148422        meminfo.KReclaimable
     41102            -0.2%      41026        meminfo.KernelStack
    517263 ±  2%      +0.3%     518808 ±  2%  meminfo.Mapped
 5.178e+08            -0.1%  5.175e+08        meminfo.MemAvailable
 5.199e+08            -0.1%  5.196e+08        meminfo.MemFree
 5.274e+08            +0.0%  5.274e+08        meminfo.MemTotal
   7517161            +4.3%    7841550 ±  4%  meminfo.Memused
     10.95 ±  2%      -4.0%      10.51 ±  8%  meminfo.Mlocked
     25594 ±  3%      -1.9%      25112 ±  7%  meminfo.PageTables
    109277            +0.3%     109597        meminfo.Percpu
    148140            +0.2%     148422        meminfo.SReclaimable
    462907            +0.2%     463832        meminfo.SUnreclaim
    405085 ±  2%      +5.8%     428379 ±  8%  meminfo.Shmem
    611047            +0.2%     612255        meminfo.Slab
   2715849            -0.0%    2715845        meminfo.Unevictable
 1.374e+13            +0.0%  1.374e+13        meminfo.VmallocTotal
    292661            +0.0%     292707        meminfo.VmallocUsed
   7721333            +6.6%    8231493 ±  4%  meminfo.max_used_kB
      6639 ± 70%     +25.7%       8344 ±160%  numa-meminfo.node0.Active
      6609 ± 70%     +25.5%       8296 ±161%  numa-meminfo.node0.Active(anon)
     30.40 ±123%     +57.9%      48.00 ± 81%  numa-meminfo.node0.Active(file)
     65249 ± 56%     -24.1%      49545 ± 74%  numa-meminfo.node0.AnonHugePages
    698546 ± 10%     -10.1%     627683 ± 11%  numa-meminfo.node0.AnonPages
    783098 ±  9%      -4.6%     746765 ± 10%  numa-meminfo.node0.AnonPages.max
   1849056 ± 60%     -27.0%    1350657 ± 82%  numa-meminfo.node0.FilePages
    708083 ± 10%      -8.9%     645187 ± 13%  numa-meminfo.node0.Inactive
    708005 ± 10%      -8.9%     645081 ± 13%  numa-meminfo.node0.Inactive(anon)
     77.48 ±122%     +37.3%     106.35 ± 82%  numa-meminfo.node0.Inactive(file)
     82324 ± 32%      -8.0%      75702 ± 27%  numa-meminfo.node0.KReclaimable
     20512 ±  7%      +1.4%      20790 ±  7%  numa-meminfo.node0.KernelStack
    175959 ±  9%      -0.1%     175730 ±  7%  numa-meminfo.node0.Mapped
 2.594e+08            +0.2%  2.599e+08        numa-meminfo.node0.MemFree
 2.635e+08            +0.0%  2.635e+08        numa-meminfo.node0.MemTotal
   4076783 ± 28%     -10.2%    3660809 ± 31%  numa-meminfo.node0.MemUsed
      6.66 ± 81%      -2.3%       6.51 ± 81%  numa-meminfo.node0.Mlocked
      9901 ± 61%      +4.5%      10346 ± 49%  numa-meminfo.node0.PageTables
     82324 ± 32%      -8.0%      75702 ± 27%  numa-meminfo.node0.SReclaimable
    248888 ±  3%      +0.5%     250078 ±  4%  numa-meminfo.node0.SUnreclaim
     20568 ± 40%     +41.9%      29194 ± 98%  numa-meminfo.node0.Shmem
    331213 ±  9%      -1.6%     325780 ±  7%  numa-meminfo.node0.Slab
   1828379 ± 61%     -27.7%    1321308 ± 85%  numa-meminfo.node0.Unevictable
     40129 ± 22%     +83.1%      73478 ± 53%  numa-meminfo.node1.Active
     40081 ± 22%     +83.2%      73447 ± 53%  numa-meminfo.node1.Active(anon)
     48.00 ± 81%     -33.4%      31.98 ±122%  numa-meminfo.node1.Active(file)
     62048 ± 50%     +37.2%      85152 ± 49%  numa-meminfo.node1.AnonHugePages
    756214 ±  9%      +3.8%     784679 ± 12%  numa-meminfo.node1.AnonPages
    924235 ±  6%      +6.7%     986345 ±  7%  numa-meminfo.node1.AnonPages.max
   1271716 ± 88%     +41.1%    1793782 ± 63%  numa-meminfo.node1.FilePages
   1095798 ±  5%      +1.1%    1108364 ± 10%  numa-meminfo.node1.Inactive
   1095678 ±  5%      +1.2%    1108294 ± 10%  numa-meminfo.node1.Inactive(anon)
    119.85 ± 77%     -41.3%      70.35 ±118%  numa-meminfo.node1.Inactive(file)
     65822 ± 40%     +10.5%      72715 ± 29%  numa-meminfo.node1.KReclaimable
     20590 ±  7%      -1.7%      20233 ±  8%  numa-meminfo.node1.KernelStack
    341090 ±  4%      +0.0%     341144 ±  4%  numa-meminfo.node1.Mapped
 2.605e+08            -0.3%  2.597e+08        numa-meminfo.node1.MemFree
 2.639e+08            +0.0%  2.639e+08        numa-meminfo.node1.MemTotal
   3445580 ± 33%     +21.0%    4169560 ± 27%  numa-meminfo.node1.MemUsed
      4.33 ±122%      -8.0%       3.98 ±123%  numa-meminfo.node1.Mlocked
     15703 ± 37%      -6.1%      14739 ± 38%  numa-meminfo.node1.PageTables
     65822 ± 40%     +10.5%      72715 ± 29%  numa-meminfo.node1.SReclaimable
    214196 ±  4%      -0.2%     213692 ±  5%  numa-meminfo.node1.SUnreclaim
    384078 ±  3%      +3.9%     399143 ±  7%  numa-meminfo.node1.Shmem
    280018 ± 11%      +2.3%     286407 ±  9%  numa-meminfo.node1.Slab
    887469 ±126%     +57.1%    1394536 ± 80%  numa-meminfo.node1.Unevictable
      1655 ± 70%     +28.3%       2123 ±163%  numa-vmstat.node0.nr_active_anon
      7.60 ±123%     +57.9%      12.00 ± 81%  numa-vmstat.node0.nr_active_file
    173571 ± 10%      -9.6%     156867 ± 11%  numa-vmstat.node0.nr_anon_pages
     31.86 ± 57%     -24.0%      24.20 ± 74%  numa-vmstat.node0.nr_anon_transparent_hugepages
    462268 ± 60%     -27.0%     337669 ± 82%  numa-vmstat.node0.nr_file_pages
  64861249            +0.2%   64962956        numa-vmstat.node0.nr_free_pages
    176031 ±  9%      -8.5%     161129 ± 12%  numa-vmstat.node0.nr_inactive_anon
     19.37 ±122%     +37.3%      26.59 ± 82%  numa-vmstat.node0.nr_inactive_file
      0.00 ±300%      +1.6%       0.00 ±300%  numa-vmstat.node0.nr_isolated_anon
     20512 ±  7%      +1.4%      20790 ±  7%  numa-vmstat.node0.nr_kernel_stack
     43945 ±  9%      -0.2%      43864 ±  7%  numa-vmstat.node0.nr_mapped
      1.66 ± 81%      -2.5%       1.62 ± 81%  numa-vmstat.node0.nr_mlock
      2475 ± 61%      +4.5%       2585 ± 49%  numa-vmstat.node0.nr_page_table_pages
      5146 ± 40%     +41.9%       7303 ± 98%  numa-vmstat.node0.nr_shmem
     20581 ± 32%      -8.0%      18925 ± 27%  numa-vmstat.node0.nr_slab_reclaimable
     62224 ±  3%      +0.5%      62514 ±  4%  numa-vmstat.node0.nr_slab_unreclaimable
    457094 ± 61%     -27.7%     330327 ± 85%  numa-vmstat.node0.nr_unevictable
      1655 ± 70%     +28.3%       2123 ±163%  numa-vmstat.node0.nr_zone_active_anon
      7.60 ±123%     +57.9%      12.00 ± 81%  numa-vmstat.node0.nr_zone_active_file
    176029 ±  9%      -8.5%     161125 ± 12%  numa-vmstat.node0.nr_zone_inactive_anon
     19.37 ±122%     +37.3%      26.59 ± 82%  numa-vmstat.node0.nr_zone_inactive_file
    457094 ± 61%     -27.7%     330327 ± 85%  numa-vmstat.node0.nr_zone_unevictable
  42322270           -12.9%   36881741 ±  8%  numa-vmstat.node0.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node0.numa_interleave
  42179160           -12.9%   36728210 ±  8%  numa-vmstat.node0.numa_local
    141985 ± 51%      +8.1%     153548 ± 39%  numa-vmstat.node0.numa_other
     10088 ± 22%     +82.5%      18410 ± 53%  numa-vmstat.node1.nr_active_anon
     12.00 ± 81%     -33.4%       7.99 ±122%  numa-vmstat.node1.nr_active_file
    187803 ±  9%      +4.4%     196071 ± 12%  numa-vmstat.node1.nr_anon_pages
     30.30 ± 50%     +37.2%      41.58 ± 49%  numa-vmstat.node1.nr_anon_transparent_hugepages
    317887 ± 88%     +41.1%     448582 ± 63%  numa-vmstat.node1.nr_file_pages
  65116967            -0.3%   64935325        numa-vmstat.node1.nr_free_pages
    272583 ±  6%      +1.6%     276951 ± 10%  numa-vmstat.node1.nr_inactive_anon
     29.96 ± 77%     -41.3%      17.59 ±118%  numa-vmstat.node1.nr_inactive_file
      0.00       +5.9e+101%       0.59 ±300%  numa-vmstat.node1.nr_isolated_anon
     20596 ±  7%      -1.8%      20229 ±  8%  numa-vmstat.node1.nr_kernel_stack
     85156 ±  4%      +0.3%      85436 ±  4%  numa-vmstat.node1.nr_mapped
      1.08 ±122%      -8.0%       1.00 ±123%  numa-vmstat.node1.nr_mlock
      3929 ± 37%      -6.4%       3678 ± 38%  numa-vmstat.node1.nr_page_table_pages
     95977 ±  3%      +4.1%      99922 ±  7%  numa-vmstat.node1.nr_shmem
     16455 ± 40%     +10.5%      18180 ± 29%  numa-vmstat.node1.nr_slab_reclaimable
     53550 ±  4%      -0.2%      53423 ±  5%  numa-vmstat.node1.nr_slab_unreclaimable
    221867 ±126%     +57.1%     348634 ± 80%  numa-vmstat.node1.nr_unevictable
     10088 ± 22%     +82.5%      18410 ± 53%  numa-vmstat.node1.nr_zone_active_anon
     12.00 ± 81%     -33.4%       7.99 ±122%  numa-vmstat.node1.nr_zone_active_file
    272580 ±  6%      +1.6%     276963 ± 10%  numa-vmstat.node1.nr_zone_inactive_anon
     29.96 ± 77%     -41.3%      17.59 ±118%  numa-vmstat.node1.nr_zone_inactive_file
    221867 ±126%     +57.1%     348634 ± 80%  numa-vmstat.node1.nr_zone_unevictable
  41909012           -12.8%   36528578 ±  9%  numa-vmstat.node1.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node1.numa_interleave
  41819840           -12.8%   36449493 ±  9%  numa-vmstat.node1.numa_local
     89842 ± 81%     -12.8%      78314 ± 77%  numa-vmstat.node1.numa_other
     59.40 ±  9%     +14.0%      67.70 ±  9%  proc-vmstat.direct_map_level2_splits
      5.00 ± 28%     +12.0%       5.60 ± 27%  proc-vmstat.direct_map_level3_splits
     11737 ± 19%     +72.4%      20235 ± 56%  proc-vmstat.nr_active_anon
     19.60 ±  6%      +2.0%      19.99        proc-vmstat.nr_active_file
    362955            -2.2%     354917 ±  6%  proc-vmstat.nr_anon_pages
     62.13 ± 16%      +5.8%      65.73 ± 14%  proc-vmstat.nr_anon_transparent_hugepages
  12924190            -0.1%   12916030        proc-vmstat.nr_dirty_background_threshold
  25879981            -0.1%   25863641        proc-vmstat.nr_dirty_threshold
    780355            +0.7%     786173        proc-vmstat.nr_file_pages
   1.3e+08            -0.1%  1.299e+08        proc-vmstat.nr_free_pages
    450188            -2.2%     440379 ±  5%  proc-vmstat.nr_inactive_anon
     49.33 ±  2%     -10.5%      44.18 ±  8%  proc-vmstat.nr_inactive_file
      0.57 ±300%      -2.9%       0.56 ±299%  proc-vmstat.nr_isolated_anon
     41099            -0.2%      41022        proc-vmstat.nr_kernel_stack
    129179 ±  2%      +0.3%     129620 ±  2%  proc-vmstat.nr_mapped
      2.73 ±  2%      -4.2%       2.62 ±  8%  proc-vmstat.nr_mlock
      6394 ±  3%      -1.9%       6270 ±  7%  proc-vmstat.nr_page_table_pages
    101324 ±  2%      +5.7%     107147 ±  8%  proc-vmstat.nr_shmem
     37036            +0.2%      37105        proc-vmstat.nr_slab_reclaimable
    115732            +0.2%     115946        proc-vmstat.nr_slab_unreclaimable
    678962            -0.0%     678961        proc-vmstat.nr_unevictable
     11737 ± 19%     +72.4%      20235 ± 56%  proc-vmstat.nr_zone_active_anon
     19.60 ±  6%      +2.0%      19.99        proc-vmstat.nr_zone_active_file
    450188            -2.2%     440380 ±  5%  proc-vmstat.nr_zone_inactive_anon
     49.33 ±  2%     -10.5%      44.18 ±  8%  proc-vmstat.nr_zone_inactive_file
    678962            -0.0%     678961        proc-vmstat.nr_zone_unevictable
     59062 ±  5%      -2.1%      57815 ± 10%  proc-vmstat.numa_hint_faults
     55966 ±  7%      -3.9%      53755 ±  9%  proc-vmstat.numa_hint_faults_local
  84235288           -12.8%   73412158 ±  8%  proc-vmstat.numa_hit
     36.70 ±  4%      -1.9%      36.00        proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
  84003235           -12.9%   73179535 ±  8%  proc-vmstat.numa_local
    231828            +0.0%     231864        proc-vmstat.numa_other
      4365 ± 37%      -0.1%       4362 ± 61%  proc-vmstat.numa_pages_migrated
    191149            +1.4%     193820 ±  4%  proc-vmstat.numa_pte_updates
     72087 ± 36%      -8.6%      65920 ± 67%  proc-vmstat.pgactivate
  85864265           -12.5%   75117942 ±  8%  proc-vmstat.pgalloc_normal
  82879163           -13.0%   72119383 ±  9%  proc-vmstat.pgfault
  85427394           -12.6%   74693640 ±  8%  proc-vmstat.pgfree
      4365 ± 37%      -0.1%       4362 ± 61%  proc-vmstat.pgmigrate_success
      0.00          -100.0%       0.00        proc-vmstat.pgpgin
     27273 ±  3%      +4.5%      28501 ± 11%  proc-vmstat.pgreuse
     46.70 ±  9%     +11.3%      52.00 ± 14%  proc-vmstat.thp_collapse_alloc
      0.20 ±200%    +200.0%       0.60 ± 81%  proc-vmstat.thp_deferred_split_page
     48.40            +0.6%      48.70        proc-vmstat.thp_fault_alloc
      4.80 ± 75%     -37.5%       3.00 ±100%  proc-vmstat.thp_migration_success
      0.20 ±200%    +200.0%       0.60 ± 81%  proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
     35.00            +0.0%      35.00        proc-vmstat.unevictable_pgs_culled
      3.00            +0.0%       3.00        proc-vmstat.unevictable_pgs_mlocked
      3.00            +0.0%       3.00        proc-vmstat.unevictable_pgs_munlocked
      0.00          -100.0%       0.00        proc-vmstat.unevictable_pgs_rescued
   1563750 ±  2%      +3.0%    1610100 ± 12%  proc-vmstat.unevictable_pgs_scanned
      0.61 ±  3%      +0.4%       0.61        perf-stat.i.MPKI
 1.501e+11 ±  2%      -6.3%  1.407e+11 ±  8%  perf-stat.i.branch-instructions
      0.33 ±  3%      +0.0        0.33 ±  6%  perf-stat.i.branch-miss-rate%
 3.963e+08 ±  2%      -7.9%  3.649e+08 ±  9%  perf-stat.i.branch-misses
     65.13            -2.3       62.80 ±  7%  perf-stat.i.cache-miss-rate%
 7.382e+08 ±  2%      -6.3%  6.919e+08 ±  8%  perf-stat.i.cache-misses
 1.106e+09            -6.6%  1.033e+09 ±  8%  perf-stat.i.cache-references
      9256            -4.6%       8828 ±  6%  perf-stat.i.context-switches
      0.50 ±  7%     +33.3%       0.66 ± 43%  perf-stat.i.cpi
    224180            -0.0%     224171        perf-stat.i.cpu-clock
  5.93e+11 ±  2%      -3.8%  5.706e+11 ±  8%  perf-stat.i.cpu-cycles
    359.21 ±  2%      -6.1%     337.30 ±  3%  perf-stat.i.cpu-migrations
    810.86 ±  3%     +50.1%       1217 ± 61%  perf-stat.i.cycles-between-cache-misses
      0.01 ±134%      +0.1        0.13 ±176%  perf-stat.i.dTLB-load-miss-rate%
  12662250 ±  2%      +1.0%   12784614 ±  2%  perf-stat.i.dTLB-load-misses
 2.861e+11 ±  2%      -6.5%  2.677e+11 ±  8%  perf-stat.i.dTLB-loads
      0.01 ±  9%      +0.0        0.01 ± 43%  perf-stat.i.dTLB-store-miss-rate%
  13024682 ±  2%     -14.4%   11149515 ±  8%  perf-stat.i.dTLB-store-misses
 1.757e+11 ±  2%      -6.6%  1.641e+11 ±  8%  perf-stat.i.dTLB-stores
 1.275e+12 ±  2%      -6.4%  1.194e+12 ±  8%  perf-stat.i.instructions
      2.10            -6.3%       1.97 ±  7%  perf-stat.i.ipc
      0.20 ± 48%      +6.9%       0.21 ± 40%  perf-stat.i.major-faults
      1.26 ±  2%      -6.7%       1.18 ±  9%  perf-stat.i.metric.G/sec
      2.65 ±  2%      -3.8%       2.55 ±  8%  perf-stat.i.metric.GHz
    694.48            -3.0%     673.92 ±  2%  perf-stat.i.metric.K/sec
      1472            -6.2%       1380 ±  8%  perf-stat.i.metric.M/sec
   1305005 ±  2%     -17.5%    1076189 ±  9%  perf-stat.i.minor-faults
      4.59 ±  8%      +2.1        6.65 ± 51%  perf-stat.i.node-load-miss-rate%
   2077324 ±  2%      -2.2%    2032308 ± 12%  perf-stat.i.node-load-misses
 1.353e+08            -5.4%  1.281e+08 ±  8%  perf-stat.i.node-loads
   1305005 ±  2%     -17.5%    1076190 ±  9%  perf-stat.i.page-faults
    224180            -0.0%     224171        perf-stat.i.task-clock
      0.46 ± 50%     +25.1%       0.58        perf-stat.overall.MPKI
      0.21 ± 50%      +0.0        0.26        perf-stat.overall.branch-miss-rate%
     53.47 ± 50%     +13.6       67.06        perf-stat.overall.cache-miss-rate%
      0.37 ± 50%     +28.6%       0.48        perf-stat.overall.cpi
    643.14 ± 50%     +28.4%     826.00        perf-stat.overall.cycles-between-cache-misses
      0.00 ± 50%      +0.0        0.00 ± 10%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ± 50%      +0.0        0.01 ±  7%  perf-stat.overall.dTLB-store-miss-rate%
      1.72 ± 50%     +21.6%       2.09        perf-stat.overall.ipc
      1.19 ± 50%      +0.4        1.58 ± 12%  perf-stat.overall.node-load-miss-rate%
 1.173e+11 ± 50%     +17.9%  1.383e+11 ±  7%  perf-stat.ps.branch-instructions
 3.098e+08 ± 50%     +15.8%  3.586e+08 ±  8%  perf-stat.ps.branch-misses
 5.777e+08 ± 50%     +17.9%  6.809e+08 ±  7%  perf-stat.ps.cache-misses
 8.643e+08 ± 50%     +17.4%  1.015e+09 ±  7%  perf-stat.ps.cache-references
      7130 ± 50%     +19.9%       8552 ±  5%  perf-stat.ps.context-switches
    174005 ± 50%     +25.5%     218373        perf-stat.ps.cpu-clock
 4.644e+11 ± 50%     +21.0%  5.621e+11 ±  7%  perf-stat.ps.cpu-cycles
    272.51 ± 50%     +16.6%     317.85 ±  2%  perf-stat.ps.cpu-migrations
   9924949 ± 50%     +25.8%   12485559 ±  2%  perf-stat.ps.dTLB-load-misses
 2.237e+11 ± 50%     +17.6%  2.631e+11 ±  7%  perf-stat.ps.dTLB-loads
  10159493 ± 50%      +7.8%   10948561 ±  7%  perf-stat.ps.dTLB-store-misses
 1.374e+11 ± 50%     +17.4%  1.613e+11 ±  7%  perf-stat.ps.dTLB-stores
 9.964e+11 ± 50%     +17.7%  1.173e+12 ±  7%  perf-stat.ps.instructions
      0.16 ± 73%     +21.3%       0.20 ± 35%  perf-stat.ps.major-faults
   1016189 ± 50%      +3.9%    1056067 ±  9%  perf-stat.ps.minor-faults
   1612917 ± 50%     +25.8%    2029077 ± 12%  perf-stat.ps.node-load-misses
 1.067e+08 ± 50%     +18.9%  1.269e+08 ±  7%  perf-stat.ps.node-loads
   1016189 ± 50%      +3.9%    1056067 ±  9%  perf-stat.ps.page-faults
    174005 ± 50%     +25.5%     218373        perf-stat.ps.task-clock
 6.343e+13 ± 50%     +23.6%  7.843e+13        perf-stat.total.instructions
   7114718            -1.2%    7027229        sched_debug.cfs_rq:/.avg_vruntime.avg
   7180297            -1.0%    7105319        sched_debug.cfs_rq:/.avg_vruntime.max
   4657471            -3.9%    4477025 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
    174545 ±  2%      +3.8%     181256 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.55            +2.0%       0.56        sched_debug.cfs_rq:/.h_nr_running.avg
      2.10 ± 20%      +9.5%       2.30 ± 17%  sched_debug.cfs_rq:/.h_nr_running.max
      0.50            +0.0%       0.50        sched_debug.cfs_rq:/.h_nr_running.min
      0.22 ±  8%     +12.7%       0.25 ± 10%  sched_debug.cfs_rq:/.h_nr_running.stddev
     43106 ± 33%    +312.8%     177940 ± 52%  sched_debug.cfs_rq:/.left_vruntime.avg
   6406425 ± 17%     +10.2%    7059947        sched_debug.cfs_rq:/.left_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.left_vruntime.min
    490512 ± 23%    +111.4%    1037149 ± 28%  sched_debug.cfs_rq:/.left_vruntime.stddev
      9516 ± 26%    +105.3%      19537 ± 37%  sched_debug.cfs_rq:/.load.avg
   1009013 ± 48%     +15.6%    1166009 ± 43%  sched_debug.cfs_rq:/.load.max
      2280            -0.4%       2271        sched_debug.cfs_rq:/.load.min
     80417 ± 39%     +48.9%     119761 ± 28%  sched_debug.cfs_rq:/.load.stddev
    615.03 ± 25%     +70.0%       1045 ± 46%  sched_debug.cfs_rq:/.load_avg.avg
     43884 ±  3%      +0.4%      44060 ±  3%  sched_debug.cfs_rq:/.load_avg.max
      2.15 ± 10%      +0.0%       2.15 ± 14%  sched_debug.cfs_rq:/.load_avg.min
      4551 ± 15%     +29.7%       5903 ± 27%  sched_debug.cfs_rq:/.load_avg.stddev
   7114719            -1.2%    7027233        sched_debug.cfs_rq:/.min_vruntime.avg
   7180297            -1.0%    7105319        sched_debug.cfs_rq:/.min_vruntime.max
   4657590            -3.9%    4477122 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
    174538 ±  2%      +3.8%     181250 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.54            +1.4%       0.54        sched_debug.cfs_rq:/.nr_running.avg
      1.80 ± 22%      +8.3%       1.95 ± 17%  sched_debug.cfs_rq:/.nr_running.max
      0.50            +0.0%       0.50        sched_debug.cfs_rq:/.nr_running.min
      0.17 ± 12%     +18.9%       0.21 ± 12%  sched_debug.cfs_rq:/.nr_running.stddev
     92.62 ±144%    +105.7%     190.49 ± 96%  sched_debug.cfs_rq:/.removed.load_avg.avg
     13672 ±147%     +96.3%      26833 ± 80%  sched_debug.cfs_rq:/.removed.load_avg.max
      1060 ±145%    +102.2%       2144 ± 84%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      6.84 ± 48%      -1.3%       6.76 ± 45%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    265.30 ±  2%      -1.6%     261.00        sched_debug.cfs_rq:/.removed.runnable_avg.max
     39.85 ± 21%      -1.3%      39.33 ± 20%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      6.84 ± 48%      -1.3%       6.76 ± 45%  sched_debug.cfs_rq:/.removed.util_avg.avg
    265.30 ±  2%      -1.6%     261.00        sched_debug.cfs_rq:/.removed.util_avg.max
     39.85 ± 21%      -1.3%      39.33 ± 20%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     43106 ± 33%    +312.8%     177940 ± 52%  sched_debug.cfs_rq:/.right_vruntime.avg
   6406449 ± 17%     +10.2%    7059947        sched_debug.cfs_rq:/.right_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.right_vruntime.min
    490516 ± 23%    +111.4%    1037152 ± 28%  sched_debug.cfs_rq:/.right_vruntime.stddev
    602.56            +1.7%     612.78        sched_debug.cfs_rq:/.runnable_avg.avg
      1824 ± 15%      +8.0%       1970 ± 13%  sched_debug.cfs_rq:/.runnable_avg.max
    511.80            -9.8%     461.45 ± 32%  sched_debug.cfs_rq:/.runnable_avg.min
    197.27 ±  7%      +6.7%     210.57 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
      0.50 ± 99%     +10.0%       0.55 ±124%  sched_debug.cfs_rq:/.spread.avg
    111.63 ± 99%      +7.6%     120.07 ±126%  sched_debug.cfs_rq:/.spread.max
      7.44 ± 99%      +7.7%       8.02 ±125%  sched_debug.cfs_rq:/.spread.stddev
    588.90            +0.3%     590.76        sched_debug.cfs_rq:/.util_avg.avg
      1267 ± 16%      +1.5%       1286 ± 17%  sched_debug.cfs_rq:/.util_avg.max
     32.70 ±290%    +205.4%      99.85 ±172%  sched_debug.cfs_rq:/.util_avg.min
    163.16 ±  4%      +0.8%     164.51 ±  9%  sched_debug.cfs_rq:/.util_avg.stddev
    261.48            +0.7%     263.22        sched_debug.cfs_rq:/.util_est_enqueued.avg
    924.20            +9.8%       1014 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.max
     16.40 ± 90%     +74.4%      28.60 ± 42%  sched_debug.cfs_rq:/.util_est_enqueued.min
     87.88 ±  8%      +5.1%      92.40 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    895647            +2.7%     919389 ±  5%  sched_debug.cpu.avg_idle.avg
   1584773 ± 25%      -5.4%    1499839 ± 21%  sched_debug.cpu.avg_idle.max
    180026 ± 47%     -17.3%     148883 ± 47%  sched_debug.cpu.avg_idle.min
    139458 ± 12%     +17.5%     163799 ± 45%  sched_debug.cpu.avg_idle.stddev
     91837 ± 13%      +0.9%      92634 ± 10%  sched_debug.cpu.clock.avg
     91883 ± 13%      +0.9%      92682 ± 10%  sched_debug.cpu.clock.max
     91778 ± 13%      +0.9%      92573 ± 10%  sched_debug.cpu.clock.min
     28.81 ± 15%      +1.8%      29.34 ± 13%  sched_debug.cpu.clock.stddev
     91190 ± 13%      +0.9%      91995 ± 10%  sched_debug.cpu.clock_task.avg
     91362 ± 13%      +0.9%      92168 ± 10%  sched_debug.cpu.clock_task.max
     78321 ± 15%      +1.2%      79242 ± 12%  sched_debug.cpu.clock_task.min
    873.05            -1.0%     864.68        sched_debug.cpu.clock_task.stddev
      4249            -1.9%       4166        sched_debug.cpu.curr->pid.avg
      7337 ±  3%      +0.8%       7398 ±  2%  sched_debug.cpu.curr->pid.max
      1048 ± 97%     -90.8%      96.65 ± 46%  sched_debug.cpu.curr->pid.min
    836.33 ± 10%     +35.5%       1132 ± 14%  sched_debug.cpu.curr->pid.stddev
    502089            +1.2%     508197 ±  3%  sched_debug.cpu.max_idle_balance_cost.avg
    700999 ± 18%      -2.1%     685975 ± 15%  sched_debug.cpu.max_idle_balance_cost.max
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
     17056 ± 57%     +39.7%      23833 ±121%  sched_debug.cpu.max_idle_balance_cost.stddev
      4294            +0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            +0.0%       4294        sched_debug.cpu.next_balance.max
      4294            +0.0%       4294        sched_debug.cpu.next_balance.min
      0.00 ± 57%     -20.1%       0.00 ± 36%  sched_debug.cpu.next_balance.stddev
      0.55            +1.9%       0.56 ±  2%  sched_debug.cpu.nr_running.avg
      2.45 ± 19%      +2.0%       2.50 ± 20%  sched_debug.cpu.nr_running.max
      0.50            +0.0%       0.50        sched_debug.cpu.nr_running.min
      0.24 ± 10%      +8.1%       0.26 ± 11%  sched_debug.cpu.nr_running.stddev
      2437            -0.6%       2423        sched_debug.cpu.nr_switches.avg
     46748 ± 21%      +2.2%      47779 ± 11%  sched_debug.cpu.nr_switches.max
      1195            -3.2%       1157 ±  2%  sched_debug.cpu.nr_switches.min
      3810 ± 11%      +1.6%       3869 ±  6%  sched_debug.cpu.nr_switches.stddev
      0.01 ± 56%     -54.2%       0.00 ±110%  sched_debug.cpu.nr_uninterruptible.avg
     42.85 ± 38%      -0.9%      42.45 ± 38%  sched_debug.cpu.nr_uninterruptible.max
    -17.50           +35.1%     -23.65        sched_debug.cpu.nr_uninterruptible.min
      5.78 ± 12%      +4.1%       6.02 ± 12%  sched_debug.cpu.nr_uninterruptible.stddev
     91781 ± 13%      +0.9%      92577 ± 10%  sched_debug.cpu_clk
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            +0.0%  4.295e+09        sched_debug.jiffies
     90574 ± 13%      +0.9%      91369 ± 10%  sched_debug.ktime
      0.00            +0.0%       0.00        sched_debug.rt_rq:.rt_nr_migratory.avg
      0.50            +0.0%       0.50        sched_debug.rt_rq:.rt_nr_migratory.max
      0.03            +0.0%       0.03        sched_debug.rt_rq:.rt_nr_migratory.stddev
      0.00            +0.0%       0.00        sched_debug.rt_rq:.rt_nr_running.avg
      0.50            +0.0%       0.50        sched_debug.rt_rq:.rt_nr_running.max
      0.03            +0.0%       0.03        sched_debug.rt_rq:.rt_nr_running.stddev
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.avg
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.max
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.min
      0.00        +2.2e+98%       0.00 ±299%  sched_debug.rt_rq:.rt_throttled.avg
      0.00         +5e+100%       0.05 ±300%  sched_debug.rt_rq:.rt_throttled.max
      0.00        +3.3e+99%       0.00 ±299%  sched_debug.rt_rq:.rt_throttled.stddev
      0.91 ± 64%      -7.2%       0.84 ± 91%  sched_debug.rt_rq:.rt_time.avg
    203.22 ± 64%      -7.2%     188.67 ± 91%  sched_debug.rt_rq:.rt_time.max
     13.55 ± 64%      -7.2%      12.58 ± 91%  sched_debug.rt_rq:.rt_time.stddev
     92678 ± 12%      +0.9%      93471 ± 10%  sched_debug.sched_clk
      1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
      3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_base_slice
  25056823            +0.0%   25056823        sched_debug.sysctl_sched.sysctl_sched_features
      1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      0.13 ±200%      -0.1        0.00        perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.13 ±200%      -0.1        0.00        perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.12 ±200%      -0.1        0.00        perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.10 ±200%      -0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.j__udyLAllocJBBJP
      0.05 ±299%      -0.1        0.00        perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.14 ±199%      -0.0        0.10 ±200%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.12 ±200%      +0.0        0.16 ±152%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush
      0.13 ±200%      +0.1        0.22 ±122%  perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
      0.25 ±200%      +0.1        0.40 ± 65%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.2        0.19 ±152%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.pte_alloc_one.__pte_alloc
      0.00            +0.2        0.19 ±152%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages.pte_alloc_one
      0.00            +0.2        0.19 ±153%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.pte_alloc_one.__pte_alloc.do_anonymous_page
      0.00            +0.2        0.20 ±152%  perf-profile.calltrace.cycles-pp.__alloc_pages.pte_alloc_one.__pte_alloc.do_anonymous_page.__handle_mm_fault
      0.00            +0.2        0.20 ±152%  perf-profile.calltrace.cycles-pp.__pte_alloc.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.2        0.20 ±152%  perf-profile.calltrace.cycles-pp.pte_alloc_one.__pte_alloc.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.23 ±200%      +0.2        0.43 ±122%  perf-profile.calltrace.cycles-pp.JudyLDel@plt
      0.14 ±200%      +0.3        0.40 ± 66%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_list.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region
      0.12 ±200%      +0.3        0.38 ± 65%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.JudyLGet
      0.12 ±200%      +0.3        0.38 ± 65%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.JudyLGet
      0.16 ±200%      +0.3        0.42 ± 66%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.13 ±200%      +0.3        0.43 ± 65%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.JudyLGet
      0.14 ±200%      +0.3        0.47 ± 65%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.JudyLGet
      0.17 ±200%      +0.4        0.53 ± 65%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.17 ±200%      +0.4        0.54 ± 65%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      0.17 ±200%      +0.4        0.54 ± 65%  perf-profile.calltrace.cycles-pp.cfree
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.calltrace.cycles-pp.__cmd_record
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      0.20 ±200%      +0.4        0.65 ± 65%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.21 ±200%      +0.5        0.67 ± 65%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.22 ±200%      +0.5        0.72 ± 65%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.25 ±200%      +0.5        0.77 ± 65%  perf-profile.calltrace.cycles-pp.j__udyLCascade2
      0.24 ±200%      +0.5        0.76 ± 65%  perf-profile.calltrace.cycles-pp.j__udyLCreateBranchU
      0.27 ±200%      +0.6        0.87 ± 65%  perf-profile.calltrace.cycles-pp.JudyLGet@plt
      0.27 ±200%      +0.6        0.88 ± 65%  perf-profile.calltrace.cycles-pp.JudyLIns@plt
      0.00            +0.7        0.68 ± 92%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page.rcu_do_batch
      0.34 ±200%      +0.8        1.11 ± 65%  perf-profile.calltrace.cycles-pp.malloc
      0.00            +0.8        0.82 ± 79%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_page.rcu_do_batch.rcu_core
      0.00            +1.1        1.13 ± 84%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page.__unfreeze_partials
      0.00            +1.2        1.24 ± 83%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_page.__unfreeze_partials.rcu_do_batch
      0.00            +1.2        1.24 ± 82%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.__unfreeze_partials.rcu_do_batch.rcu_core
      0.73 ±200%      +1.6        2.29 ± 65%  perf-profile.calltrace.cycles-pp.JudyLDel
      0.00            +1.6        1.57 ±101%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages.__folio_alloc
      0.70 ±200%      +1.6        2.27 ± 65%  perf-profile.calltrace.cycles-pp.JudyLIns
      0.00            +1.6        1.58 ±100%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio
      0.00            +1.6        1.59 ±110%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
      0.00            +1.6        1.59 ±110%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue
      0.00            +1.7        1.71 ±108%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages
      0.12 ±200%      +1.7        1.86 ± 92%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page
      0.12 ±200%      +1.8        1.88 ± 92%  perf-profile.calltrace.cycles-pp.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page.__handle_mm_fault
      0.12 ±200%      +1.8        1.88 ± 92%  perf-profile.calltrace.cycles-pp.__folio_alloc.vma_alloc_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.13 ±200%      +1.8        1.90 ± 91%  perf-profile.calltrace.cycles-pp.vma_alloc_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +1.8        1.81 ± 87%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page
      0.12 ±200%      +2.2        2.30 ± 73%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
      0.13 ±200%      +2.2        2.32 ± 73%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region
      0.00            +2.2        2.19 ± 74%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush
      0.12 ±200%      +2.3        2.42 ± 77%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.12 ±200%      +2.3        2.45 ± 77%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.12 ±200%      +2.3        2.45 ± 77%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.12 ±200%      +2.3        2.45 ± 77%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.05 ±200%      +2.4        3.42 ± 65%  perf-profile.calltrace.cycles-pp.stress_judy
      0.33 ±200%      +2.6        2.90 ± 70%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      0.34 ±200%      +2.6        2.92 ± 70%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.__do_sys_brk
      0.46 ±200%      +2.6        3.10 ± 80%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.38 ±200%      +2.7        3.04 ± 69%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      0.48 ±200%      +2.7        3.15 ± 79%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.50 ±200%      +2.7        3.20 ± 79%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.53 ±200%      +2.8        3.30 ± 78%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.53 ±200%      +2.8        3.31 ± 78%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.57 ±200%      +2.9        3.43 ± 77%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.49 ±200%      +2.9        3.36 ± 68%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.78 ±200%      +3.5        4.26 ± 67%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.81 ±200%      +3.6        4.36 ± 67%  perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.82 ±200%      +3.6        4.38 ± 67%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.82 ±200%      +3.6        4.38 ± 67%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
      0.83 ±200%      +3.6        4.40 ± 67%  perf-profile.calltrace.cycles-pp.brk
     13.33 ±200%     +29.8       43.13 ± 65%  perf-profile.calltrace.cycles-pp.JudyLGet
      0.02 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_pending
      0.01 ±201%      -0.0        0.00        perf-profile.children.cycles-pp.update_cfs_group
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.perf_rotate_context
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.check_cpu_stall
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.down_write
      0.01 ±200%      +0.0        0.01 ±200%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.01 ±300%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.mas_store_b_node
      0.01 ±300%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.01 ±200%      +0.0        0.02 ±152%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.02 ±200%      +0.0        0.02 ±122%  perf-profile.children.cycles-pp._compound_head
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.perf_mmap__read_head
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__get_free_pages
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.01 ±201%      +0.0        0.02 ±122%  perf-profile.children.cycles-pp.j__udyLAllocJLL3
      0.01 ±200%      +0.0        0.02 ±100%  perf-profile.children.cycles-pp.rcu_nocb_try_bypass
      0.00            +0.0        0.02 ±152%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.02 ±200%      +0.0        0.04 ± 65%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.0        0.02 ±153%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.0        0.02 ±153%  perf-profile.children.cycles-pp.process_one_work
      0.01 ±200%      +0.0        0.03 ± 82%  perf-profile.children.cycles-pp.mas_find
      0.01 ±201%      +0.0        0.03 ± 81%  perf-profile.children.cycles-pp.mtree_range_walk
      0.03 ±200%      +0.0        0.05 ± 67%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.01 ±200%      +0.0        0.04 ± 65%  perf-profile.children.cycles-pp.update_load_avg
      0.01 ±201%      +0.0        0.04 ± 65%  perf-profile.children.cycles-pp.mas_destroy
      0.01 ±201%      +0.0        0.04 ±100%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.01 ±200%      +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.01 ±200%      +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.01 ±200%      +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.__cond_resched
      0.01 ±200%      +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.01 ±200%      +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.do_brk_flags
      0.01 ±200%      +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.02 ±200%      +0.0        0.05 ± 66%  perf-profile.children.cycles-pp.hrtimer_active
      0.02 ±200%      +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.free_unref_page_list
      0.01 ±200%      +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.02 ±200%      +0.0        0.05 ± 65%  perf-profile.children.cycles-pp.___perf_sw_event
      0.02 ±200%      +0.0        0.05 ± 66%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.02 ±200%      +0.0        0.05 ± 65%  perf-profile.children.cycles-pp.try_charge_memcg
      0.03 ±200%      +0.0        0.07 ± 65%  perf-profile.children.cycles-pp.update_curr
      0.02 ±200%      +0.0        0.05 ± 65%  perf-profile.children.cycles-pp.mas_walk
      0.01 ±200%      +0.0        0.05 ± 65%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.00            +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.note_gp_changes
      0.02 ±200%      +0.0        0.05 ± 65%  perf-profile.children.cycles-pp.free_pgtables
      0.02 ±200%      +0.0        0.05 ± 65%  perf-profile.children.cycles-pp.task_work_run
      0.02 ±200%      +0.0        0.06 ± 66%  perf-profile.children.cycles-pp.__perf_sw_event
      0.02 ±200%      +0.0        0.06 ± 66%  perf-profile.children.cycles-pp.j__udyLCascade3
      0.02 ±200%      +0.0        0.06 ± 65%  perf-profile.children.cycles-pp.j__udyLFreeJLL2
      0.02 ±200%      +0.0        0.06 ± 65%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.02 ±200%      +0.0        0.07 ± 67%  perf-profile.children.cycles-pp.lru_add_fn
      0.04 ±200%      +0.0        0.08 ± 66%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.02 ±200%      +0.0        0.07 ± 65%  perf-profile.children.cycles-pp.j__udyLAllocJBBJP@plt
      0.02 ±200%      +0.0        0.06 ± 65%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.04 ±200%      +0.0        0.09 ± 66%  perf-profile.children.cycles-pp.__count_memcg_events
      0.02 ±200%      +0.0        0.07 ± 65%  perf-profile.children.cycles-pp.j__udyLLeaf2ToLeaf3
      0.02 ±200%      +0.0        0.07 ± 65%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.02 ±200%      +0.0        0.07 ± 65%  perf-profile.children.cycles-pp.mas_commit_b_node
      0.02 ±200%      +0.0        0.07 ± 65%  perf-profile.children.cycles-pp.__call_rcu_common
      0.01 ±200%      +0.1        0.06 ± 68%  perf-profile.children.cycles-pp.generic_perform_write
      0.02 ±200%      +0.1        0.07 ± 65%  perf-profile.children.cycles-pp.j__udyLFreeJBBJP@plt
      0.03 ±200%      +0.1        0.08 ± 65%  perf-profile.children.cycles-pp.anon_vma_clone
      0.05 ±200%      +0.1        0.10 ± 66%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.01 ±200%      +0.1        0.07 ± 69%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.02 ±200%      +0.1        0.07 ± 70%  perf-profile.children.cycles-pp.vfs_write
      0.03 ±200%      +0.1        0.09 ± 65%  perf-profile.children.cycles-pp.mod_objcg_state
      0.03 ±200%      +0.1        0.08 ± 65%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.02 ±200%      +0.1        0.07 ± 69%  perf-profile.children.cycles-pp.ksys_write
      0.00            +0.1        0.06 ± 74%  perf-profile.children.cycles-pp.allocate_slab
      0.05 ±200%      +0.1        0.10 ± 66%  perf-profile.children.cycles-pp.page_remove_rmap
      0.03 ±200%      +0.1        0.09 ± 65%  perf-profile.children.cycles-pp.j__udyLAllocJLL2
      0.03 ±200%      +0.1        0.09 ± 65%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.02 ±200%      +0.1        0.08 ± 69%  perf-profile.children.cycles-pp.__libc_write
      0.04 ±200%      +0.1        0.10 ± 66%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.02 ±200%      +0.1        0.08 ± 70%  perf-profile.children.cycles-pp.record__pushfn
      0.02 ±200%      +0.1        0.08 ± 68%  perf-profile.children.cycles-pp.writen
      0.06 ±200%      +0.1        0.12 ± 66%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.04 ±200%      +0.1        0.10 ± 66%  perf-profile.children.cycles-pp.flush_tlb_func
      0.02 ±200%      +0.1        0.08 ± 71%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.02 ±200%      +0.1        0.09 ± 68%  perf-profile.children.cycles-pp.___slab_alloc
      0.03 ±200%      +0.1        0.10 ± 67%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.04 ±200%      +0.1        0.12 ± 66%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.04 ±200%      +0.1        0.13 ± 65%  perf-profile.children.cycles-pp.sync_regs
      0.04 ±200%      +0.1        0.13 ± 65%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.04 ±200%      +0.1        0.13 ± 66%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.03 ±200%      +0.1        0.12 ± 66%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.04 ±200%      +0.1        0.13 ± 65%  perf-profile.children.cycles-pp.kmem_cache_free
      0.04 ±200%      +0.1        0.13 ± 65%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.08 ±200%      +0.1        0.18 ± 65%  perf-profile.children.cycles-pp.task_tick_fair
      0.02 ±200%      +0.1        0.12 ± 69%  perf-profile.children.cycles-pp.perf_mmap__push
      0.03 ±199%      +0.1        0.13 ± 65%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.02 ±200%      +0.1        0.12 ± 69%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.02 ±200%      +0.1        0.13 ± 69%  perf-profile.children.cycles-pp.cmd_record
      0.10 ±200%      +0.1        0.20 ± 66%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.05 ±200%      +0.1        0.16 ± 65%  perf-profile.children.cycles-pp.__slab_free
      0.05 ±200%      +0.1        0.16 ± 65%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.05 ±200%      +0.1        0.16 ± 65%  perf-profile.children.cycles-pp.vm_area_dup
      0.03 ±200%      +0.1        0.14 ± 68%  perf-profile.children.cycles-pp.__libc_start_main
      0.03 ±200%      +0.1        0.14 ± 68%  perf-profile.children.cycles-pp.main
      0.03 ±200%      +0.1        0.14 ± 68%  perf-profile.children.cycles-pp.run_builtin
      0.00            +0.1        0.11 ± 68%  perf-profile.children.cycles-pp.__free_one_page
      0.05 ±200%      +0.1        0.16 ± 65%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.05 ±200%      +0.1        0.16 ± 65%  perf-profile.children.cycles-pp.free@plt
      0.05 ±200%      +0.1        0.16 ± 65%  perf-profile.children.cycles-pp.JudyFree
      0.05 ±200%      +0.1        0.16 ± 65%  perf-profile.children.cycles-pp.malloc@plt
      0.05 ±200%      +0.1        0.17 ± 65%  perf-profile.children.cycles-pp.JudyMalloc
      0.08 ±200%      +0.1        0.19 ± 67%  perf-profile.children.cycles-pp.zap_pte_range
      0.06 ±200%      +0.1        0.18 ± 65%  perf-profile.children.cycles-pp.mas_store_gfp
      0.06 ±200%      +0.1        0.18 ± 65%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.08 ±200%      +0.1        0.20 ± 66%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.06 ±200%      +0.1        0.18 ± 65%  perf-profile.children.cycles-pp.vma_complete
      0.08 ±200%      +0.1        0.20 ± 67%  perf-profile.children.cycles-pp.zap_pmd_range
      0.05 ±200%      +0.1        0.18 ± 68%  perf-profile.children.cycles-pp.folio_add_lru_vma
      0.06 ±200%      +0.1        0.19 ± 65%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.05 ±200%      +0.1        0.18 ± 68%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.08 ±200%      +0.1        0.22 ± 67%  perf-profile.children.cycles-pp.unmap_page_range
      0.05 ±200%      +0.1        0.18 ± 65%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.05 ±200%      +0.1        0.19 ± 65%  perf-profile.children.cycles-pp.mas_preallocate
      0.09 ±200%      +0.1        0.23 ± 67%  perf-profile.children.cycles-pp.unmap_vmas
      0.05 ±200%      +0.1        0.20 ± 65%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.07 ±200%      +0.2        0.22 ± 65%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.2        0.16 ± 70%  perf-profile.children.cycles-pp.clockevents_program_event
      0.05 ±200%      +0.2        0.21 ± 66%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.08 ±200%      +0.2        0.24 ± 65%  perf-profile.children.cycles-pp.JudyFree@plt
      0.06 ±200%      +0.2        0.23 ± 66%  perf-profile.children.cycles-pp.clear_page_erms
      0.08 ±200%      +0.2        0.25 ± 65%  perf-profile.children.cycles-pp.JudyMalloc@plt
      0.10 ±200%      +0.2        0.29 ± 66%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.10 ±200%      +0.2        0.31 ± 65%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.10 ±200%      +0.2        0.31 ± 65%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.00            +0.2        0.20 ± 68%  perf-profile.children.cycles-pp.ktime_get
      0.12 ±200%      +0.2        0.33 ± 66%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.13 ±200%      +0.2        0.37 ± 66%  perf-profile.children.cycles-pp.uncharge_batch
      0.14 ±200%      +0.3        0.40 ± 66%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.16 ±200%      +0.3        0.43 ± 66%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.00            +0.3        0.28 ± 94%  perf-profile.children.cycles-pp.__pte_alloc
      0.00            +0.3        0.28 ± 94%  perf-profile.children.cycles-pp.pte_alloc_one
      0.12 ±200%      +0.3        0.40 ± 65%  perf-profile.children.cycles-pp.j__udyLFreeJBBJP
      0.23 ±200%      +0.4        0.58 ± 65%  perf-profile.children.cycles-pp.scheduler_tick
      0.16 ±200%      +0.4        0.53 ± 65%  perf-profile.children.cycles-pp.j__udyLAllocJBBJP
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.children.cycles-pp.ordered_events__queue
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.children.cycles-pp.queue_event
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.children.cycles-pp.process_simple
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.children.cycles-pp.record__finish_output
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.children.cycles-pp.perf_session__process_events
      0.16 ±200%      +0.4        0.53 ± 68%  perf-profile.children.cycles-pp.reader__read_event
      0.17 ±200%      +0.4        0.55 ± 65%  perf-profile.children.cycles-pp.JudyLDel@plt
      0.26 ±200%      +0.4        0.64 ± 65%  perf-profile.children.cycles-pp.update_process_times
      0.26 ±200%      +0.4        0.64 ± 65%  perf-profile.children.cycles-pp.tick_sched_handle
      0.27 ±200%      +0.4        0.70 ± 65%  perf-profile.children.cycles-pp.tick_sched_timer
      0.20 ±200%      +0.4        0.63 ± 65%  perf-profile.children.cycles-pp.cfree
      0.20 ±200%      +0.4        0.65 ± 65%  perf-profile.children.cycles-pp.__split_vma
      0.20 ±200%      +0.5        0.67 ± 65%  perf-profile.children.cycles-pp.JudyLIns@plt
      0.18 ±200%      +0.5        0.66 ± 67%  perf-profile.children.cycles-pp.__cmd_record
      0.29 ±200%      +0.5        0.80 ± 65%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.25 ±200%      +0.5        0.77 ± 65%  perf-profile.children.cycles-pp.j__udyLCascade2
      0.24 ±199%      +0.5        0.77 ± 65%  perf-profile.children.cycles-pp.j__udyLCreateBranchU
      0.32 ±200%      +0.7        1.02 ± 65%  perf-profile.children.cycles-pp.JudyLGet@plt
      0.33 ±200%      +0.7        1.07 ± 65%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.33 ±200%      +0.7        1.08 ± 65%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.38 ±200%      +0.9        1.25 ± 65%  perf-profile.children.cycles-pp.malloc
      0.39 ±200%      +0.9        1.28 ± 65%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.42 ±200%      +1.0        1.39 ± 65%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +1.3        1.27 ± 82%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.13 ±200%      +1.8        1.89 ± 91%  perf-profile.children.cycles-pp.__folio_alloc
      0.13 ±200%      +1.8        1.91 ± 91%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.00            +1.8        1.84 ±100%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.05 ±200%      +1.9        1.91 ± 98%  perf-profile.children.cycles-pp.rmqueue
      0.84 ±200%      +1.9        2.72 ± 65%  perf-profile.children.cycles-pp.JudyLIns
      0.00            +1.9        1.89 ± 99%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.92 ±200%      +2.0        2.88 ± 65%  perf-profile.children.cycles-pp.JudyLDel
      0.12 ±200%      +2.1        2.18 ± 92%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.13 ±200%      +2.1        2.21 ± 91%  perf-profile.children.cycles-pp.__alloc_pages
      0.01 ±300%      +2.1        2.09 ± 81%  perf-profile.children.cycles-pp.free_unref_page
      0.01 ±300%      +2.1        2.09 ± 81%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.00            +2.1        2.10 ± 81%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.15 ±200%      +2.3        2.40 ± 73%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.12 ±200%      +2.3        2.42 ± 77%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.12 ±200%      +2.3        2.45 ± 77%  perf-profile.children.cycles-pp.kthread
      0.12 ±200%      +2.3        2.45 ± 77%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.12 ±200%      +2.3        2.45 ± 77%  perf-profile.children.cycles-pp.ret_from_fork
      0.14 ±199%      +2.4        2.50 ± 76%  perf-profile.children.cycles-pp.rcu_do_batch
      0.16 ±200%      +2.4        2.56 ± 75%  perf-profile.children.cycles-pp.rcu_core
      0.34 ±200%      +2.6        2.92 ± 70%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.34 ±200%      +2.6        2.92 ± 70%  perf-profile.children.cycles-pp.release_pages
      0.46 ±200%      +2.6        3.11 ± 80%  perf-profile.children.cycles-pp.do_anonymous_page
      0.38 ±200%      +2.7        3.04 ± 69%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.48 ±200%      +2.7        3.16 ± 79%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.50 ±200%      +2.7        3.21 ± 79%  perf-profile.children.cycles-pp.handle_mm_fault
      0.53 ±200%      +2.8        3.31 ± 78%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.54 ±200%      +2.8        3.32 ± 78%  perf-profile.children.cycles-pp.exc_page_fault
      0.58 ±200%      +2.9        3.44 ± 77%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.49 ±200%      +2.9        3.36 ± 68%  perf-profile.children.cycles-pp.unmap_region
      1.44 ±200%      +3.2        4.66 ± 65%  perf-profile.children.cycles-pp.stress_judy
      0.78 ±200%      +3.5        4.27 ± 67%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.81 ±200%      +3.6        4.37 ± 67%  perf-profile.children.cycles-pp.__do_sys_brk
      0.83 ±199%      +3.6        4.42 ± 67%  perf-profile.children.cycles-pp.brk
      0.84 ±200%      +3.6        4.48 ± 67%  perf-profile.children.cycles-pp.do_syscall_64
      0.84 ±200%      +3.6        4.49 ± 67%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.12 ±200%      +5.7        5.86 ± 83%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.16 ±200%      +5.8        6.00 ± 83%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     13.47 ±200%     +30.1       43.58 ± 65%  perf-profile.children.cycles-pp.JudyLGet
      0.02 ±200%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.01 ±201%      -0.0        0.00        perf-profile.self.cycles-pp.update_cfs_group
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.update_curr
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.check_cpu_stall
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.01 ±200%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.01 ±200%      +0.0        0.02 ±152%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.rcu_nocb_try_bypass
      0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.zap_pte_range
      0.01 ±200%      +0.0        0.02 ±152%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.01 ±200%      +0.0        0.02 ±122%  perf-profile.self.cycles-pp._compound_head
      0.01 ±201%      +0.0        0.02 ±122%  perf-profile.self.cycles-pp.mtree_range_walk
      0.01 ±201%      +0.0        0.02 ±123%  perf-profile.self.cycles-pp.try_charge_memcg
      0.01 ±200%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.02 ±200%      +0.0        0.05 ± 68%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.01 ±200%      +0.0        0.04 ± 66%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.01 ±300%      +0.0        0.03 ±101%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.02 ±200%      +0.0        0.04 ± 66%  perf-profile.self.cycles-pp.hrtimer_active
      0.01 ±200%      +0.0        0.04 ± 66%  perf-profile.self.cycles-pp.___perf_sw_event
      0.02 ±200%      +0.0        0.05 ± 66%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.01 ±200%      +0.0        0.05 ± 66%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.01 ±300%      +0.0        0.04 ± 66%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.04 ±201%      +0.0        0.08 ± 66%  perf-profile.self.cycles-pp.__count_memcg_events
      0.02 ±200%      +0.0        0.05 ± 65%  perf-profile.self.cycles-pp.j__udyLFreeJLL2
      0.02 ±200%      +0.0        0.06 ± 66%  perf-profile.self.cycles-pp.release_pages
      0.02 ±200%      +0.0        0.06 ± 65%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.02 ±200%      +0.0        0.06 ± 65%  perf-profile.self.cycles-pp.j__udyLCascade3
      0.02 ±200%      +0.0        0.06 ± 66%  perf-profile.self.cycles-pp.j__udyLAllocJLL2
      0.05 ±200%      +0.0        0.10 ± 66%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.02 ±200%      +0.0        0.06 ± 66%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.02 ±200%      +0.0        0.07 ± 65%  perf-profile.self.cycles-pp.j__udyLFreeJBBJP@plt
      0.02 ±200%      +0.0        0.07 ± 65%  perf-profile.self.cycles-pp.j__udyLAllocJBBJP@plt
      0.02 ±200%      +0.0        0.07 ± 65%  perf-profile.self.cycles-pp.mod_objcg_state
      0.02 ±200%      +0.0        0.07 ± 65%  perf-profile.self.cycles-pp.j__udyLLeaf2ToLeaf3
      0.02 ±200%      +0.1        0.08 ± 65%  perf-profile.self.cycles-pp.malloc@plt
      0.03 ±200%      +0.1        0.08 ± 65%  perf-profile.self.cycles-pp.free@plt
      0.03 ±200%      +0.1        0.08 ± 65%  perf-profile.self.cycles-pp.JudyFree@plt
      0.02 ±200%      +0.1        0.08 ± 65%  perf-profile.self.cycles-pp.JudyFree
      0.03 ±200%      +0.1        0.08 ± 65%  perf-profile.self.cycles-pp.kmem_cache_free
      0.02 ±200%      +0.1        0.08 ± 65%  perf-profile.self.cycles-pp.JudyMalloc
      0.05 ±200%      +0.1        0.11 ± 66%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.03 ±200%      +0.1        0.08 ± 65%  perf-profile.self.cycles-pp.JudyMalloc@plt
      0.04 ±200%      +0.1        0.10 ± 66%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.03 ±200%      +0.1        0.10 ± 67%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.07 ± 76%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.05 ±200%      +0.1        0.13 ± 65%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.04 ±200%      +0.1        0.13 ± 65%  perf-profile.self.cycles-pp.sync_regs
      0.04 ±200%      +0.1        0.13 ± 65%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.04 ±200%      +0.1        0.14 ± 65%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.00            +0.1        0.09 ± 69%  perf-profile.self.cycles-pp.__free_one_page
      0.04 ±200%      +0.1        0.14 ± 65%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.05 ±200%      +0.1        0.15 ± 65%  perf-profile.self.cycles-pp.__slab_free
      0.08 ±200%      +0.1        0.20 ± 66%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.06 ±200%      +0.1        0.19 ± 65%  perf-profile.self.cycles-pp.JudyLDel@plt
      0.06 ±200%      +0.1        0.19 ± 65%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.07 ±200%      +0.2        0.23 ± 65%  perf-profile.self.cycles-pp.JudyLIns@plt
      0.05 ±200%      +0.2        0.21 ± 66%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.06 ±200%      +0.2        0.23 ± 66%  perf-profile.self.cycles-pp.clear_page_erms
      0.10 ±200%      +0.2        0.28 ± 66%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.09 ±200%      +0.2        0.29 ± 66%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.00            +0.2        0.20 ± 68%  perf-profile.self.cycles-pp.ktime_get
      0.10 ±200%      +0.2        0.33 ± 65%  perf-profile.self.cycles-pp.j__udyLFreeJBBJP
      0.12 ±200%      +0.3        0.39 ± 65%  perf-profile.self.cycles-pp.JudyLGet@plt
      0.12 ±200%      +0.3        0.40 ± 65%  perf-profile.self.cycles-pp.j__udyLAllocJBBJP
      0.15 ±200%      +0.4        0.52 ± 68%  perf-profile.self.cycles-pp.queue_event
      0.17 ±200%      +0.4        0.54 ± 65%  perf-profile.self.cycles-pp.cfree
      0.25 ±200%      +0.5        0.76 ± 65%  perf-profile.self.cycles-pp.j__udyLCascade2
      0.23 ±200%      +0.5        0.75 ± 65%  perf-profile.self.cycles-pp.j__udyLCreateBranchU
      0.36 ±200%      +0.8        1.15 ± 65%  perf-profile.self.cycles-pp.malloc
      0.78 ±200%      +1.7        2.44 ± 65%  perf-profile.self.cycles-pp.JudyLDel
      0.76 ±200%      +1.7        2.48 ± 65%  perf-profile.self.cycles-pp.JudyLIns
      1.25 ±200%      +2.8        4.04 ± 65%  perf-profile.self.cycles-pp.stress_judy
      0.12 ±200%      +5.7        5.86 ± 83%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     13.20 ±200%     +29.5       42.71 ± 65%  perf-profile.self.cycles-pp.JudyLGet
      2886 ±  8%      +3.7%       2993 ± 12%  slabinfo.Acpi-State.active_objs
     56.60 ±  8%      +3.7%      58.70 ± 12%  slabinfo.Acpi-State.active_slabs
      2886 ±  8%      +3.7%       2993 ± 12%  slabinfo.Acpi-State.num_objs
     56.60 ±  8%      +3.7%      58.70 ± 12%  slabinfo.Acpi-State.num_slabs
     36.00            +0.0%      36.00        slabinfo.DCCP.active_objs
      2.00            +0.0%       2.00        slabinfo.DCCP.active_slabs
     36.00            +0.0%      36.00        slabinfo.DCCP.num_objs
      2.00            +0.0%       2.00        slabinfo.DCCP.num_slabs
     34.00            +0.0%      34.00        slabinfo.DCCPv6.active_objs
      2.00            +0.0%       2.00        slabinfo.DCCPv6.active_slabs
     34.00            +0.0%      34.00        slabinfo.DCCPv6.num_objs
      2.00            +0.0%       2.00        slabinfo.DCCPv6.num_slabs
    451.20 ±  2%      -0.7%     448.00        slabinfo.RAW.active_objs
     14.10 ±  2%      -0.7%      14.00        slabinfo.RAW.active_slabs
    451.20 ±  2%      -0.7%     448.00        slabinfo.RAW.num_objs
     14.10 ±  2%      -0.7%      14.00        slabinfo.RAW.num_slabs
    278.20 ±  4%      +0.0%     278.20 ±  4%  slabinfo.RAWv6.active_objs
     10.70 ±  4%      +0.0%      10.70 ±  4%  slabinfo.RAWv6.active_slabs
    278.20 ±  4%      +0.0%     278.20 ±  4%  slabinfo.RAWv6.num_objs
     10.70 ±  4%      +0.0%      10.70 ±  4%  slabinfo.RAWv6.num_slabs
     55.02 ±  7%      +3.5%      56.97        slabinfo.TCP.active_objs
      3.93 ±  7%      +3.5%       4.07        slabinfo.TCP.active_slabs
     55.02 ±  7%      +3.5%      56.97        slabinfo.TCP.num_objs
      3.93 ±  7%      +3.5%       4.07        slabinfo.TCP.num_slabs
     37.70 ± 10%      +3.4%      39.00        slabinfo.TCPv6.active_objs
      2.90 ± 10%      +3.4%       3.00        slabinfo.TCPv6.active_slabs
     37.70 ± 10%      +3.4%      39.00        slabinfo.TCPv6.num_objs
      2.90 ± 10%      +3.4%       3.00        slabinfo.TCPv6.num_slabs
    110.40 ± 10%      +6.5%     117.60 ±  6%  slabinfo.UDPv6.active_objs
      4.60 ± 10%      +6.5%       4.90 ±  6%  slabinfo.UDPv6.active_slabs
    110.40 ± 10%      +6.5%     117.60 ±  6%  slabinfo.UDPv6.num_objs
      4.60 ± 10%      +6.5%       4.90 ±  6%  slabinfo.UDPv6.num_slabs
      2115 ±  8%      -1.2%       2089 ± 10%  slabinfo.UNIX.active_objs
     70.51 ±  8%      -1.2%      69.65 ± 10%  slabinfo.UNIX.active_slabs
      2115 ±  8%      -1.2%       2089 ± 10%  slabinfo.UNIX.num_objs
     70.51 ±  8%      -1.2%      69.65 ± 10%  slabinfo.UNIX.num_slabs
     40729 ±  4%      +2.9%      41929 ±  3%  slabinfo.anon_vma.active_objs
      1047 ±  4%      +2.9%       1077 ±  3%  slabinfo.anon_vma.active_slabs
     40838 ±  4%      +2.9%      42028 ±  3%  slabinfo.anon_vma.num_objs
      1047 ±  4%      +2.9%       1077 ±  3%  slabinfo.anon_vma.num_slabs
     61114 ±  2%      +1.7%      62156 ±  2%  slabinfo.anon_vma_chain.active_objs
    959.75 ±  2%      +1.8%     976.69 ±  2%  slabinfo.anon_vma_chain.active_slabs
     61424 ±  2%      +1.8%      62508 ±  2%  slabinfo.anon_vma_chain.num_objs
    959.75 ±  2%      +1.8%     976.69 ±  2%  slabinfo.anon_vma_chain.num_slabs
     76.00 ± 15%     +10.5%      84.00 ± 17%  slabinfo.bdev_cache.active_objs
      3.80 ± 15%     +10.5%       4.20 ± 17%  slabinfo.bdev_cache.active_slabs
     76.00 ± 15%     +10.5%      84.00 ± 17%  slabinfo.bdev_cache.num_objs
      3.80 ± 15%     +10.5%       4.20 ± 17%  slabinfo.bdev_cache.num_slabs
    454.40 ±  4%      +1.4%     460.80 ±  5%  slabinfo.bio-120.active_objs
      7.10 ±  4%      +1.4%       7.20 ±  5%  slabinfo.bio-120.active_slabs
    454.40 ±  4%      +1.4%     460.80 ±  5%  slabinfo.bio-120.num_objs
      7.10 ±  4%      +1.4%       7.20 ±  5%  slabinfo.bio-120.num_slabs
    537.60 ± 22%      +3.1%     554.40 ±  8%  slabinfo.bio-184.active_objs
     12.80 ± 22%      +3.1%      13.20 ±  8%  slabinfo.bio-184.active_slabs
    537.60 ± 22%      +3.1%     554.40 ±  8%  slabinfo.bio-184.num_objs
     12.80 ± 22%      +3.1%      13.20 ±  8%  slabinfo.bio-184.num_slabs
    128.00            +0.0%     128.00        slabinfo.bio-248.active_objs
      2.00            +0.0%       2.00        slabinfo.bio-248.active_slabs
    128.00            +0.0%     128.00        slabinfo.bio-248.num_objs
      2.00            +0.0%       2.00        slabinfo.bio-248.num_slabs
     51.00            +0.0%      51.00        slabinfo.bio-296.active_objs
      1.00            +0.0%       1.00        slabinfo.bio-296.active_slabs
     51.00            +0.0%      51.00        slabinfo.bio-296.num_objs
      1.00            +0.0%       1.00        slabinfo.bio-296.num_slabs
    121.80 ± 10%      +3.4%     126.00        slabinfo.bio-360.active_objs
      2.90 ± 10%      +3.4%       3.00        slabinfo.bio-360.active_slabs
    121.80 ± 10%      +3.4%     126.00        slabinfo.bio-360.num_objs
      2.90 ± 10%      +3.4%       3.00        slabinfo.bio-360.num_slabs
     42.00            +0.0%      42.00        slabinfo.bio-376.active_objs
      1.00            +0.0%       1.00        slabinfo.bio-376.active_slabs
     42.00            +0.0%      42.00        slabinfo.bio-376.num_objs
      1.00            +0.0%       1.00        slabinfo.bio-376.num_slabs
     36.00            +0.0%      36.00        slabinfo.bio-432.active_objs
      1.00            +0.0%       1.00        slabinfo.bio-432.active_slabs
     36.00            +0.0%      36.00        slabinfo.bio-432.num_objs
      1.00            +0.0%       1.00        slabinfo.bio-432.num_slabs
    170.00            +0.0%     170.00        slabinfo.bio_post_read_ctx.active_objs
      2.00            +0.0%       2.00        slabinfo.bio_post_read_ctx.active_slabs
    170.00            +0.0%     170.00        slabinfo.bio_post_read_ctx.num_objs
      2.00            +0.0%       2.00        slabinfo.bio_post_read_ctx.num_slabs
     33.60 ± 14%      +9.5%      36.80 ± 19%  slabinfo.biovec-128.active_objs
      2.10 ± 14%      +9.5%       2.30 ± 19%  slabinfo.biovec-128.active_slabs
     33.60 ± 14%      +9.5%      36.80 ± 19%  slabinfo.biovec-128.num_objs
      2.10 ± 14%      +9.5%       2.30 ± 19%  slabinfo.biovec-128.num_slabs
    300.80 ±  9%      +7.4%     323.20 ± 12%  slabinfo.biovec-64.active_objs
      9.40 ±  9%      +7.4%      10.10 ± 12%  slabinfo.biovec-64.active_slabs
    300.80 ±  9%      +7.4%     323.20 ± 12%  slabinfo.biovec-64.num_objs
      9.40 ±  9%      +7.4%      10.10 ± 12%  slabinfo.biovec-64.num_slabs
     56.00            +0.0%      56.00        slabinfo.biovec-max.active_objs
      7.00            +0.0%       7.00        slabinfo.biovec-max.active_slabs
     56.00            +0.0%      56.00        slabinfo.biovec-max.num_objs
      7.00            +0.0%       7.00        slabinfo.biovec-max.num_slabs
    136.00            +0.0%     136.00        slabinfo.btrfs_extent_buffer.active_objs
      2.00            +0.0%       2.00        slabinfo.btrfs_extent_buffer.active_slabs
    136.00            +0.0%     136.00        slabinfo.btrfs_extent_buffer.num_objs
      2.00            +0.0%       2.00        slabinfo.btrfs_extent_buffer.num_slabs
      0.00       +7.8e+102%       7.80 ±200%  slabinfo.btrfs_free_space.active_objs
      0.00         +2e+101%       0.20 ±200%  slabinfo.btrfs_free_space.active_slabs
      0.00       +7.8e+102%       7.80 ±200%  slabinfo.btrfs_free_space.num_objs
      0.00         +2e+101%       0.20 ±200%  slabinfo.btrfs_free_space.num_slabs
    104.40 ± 13%     -11.1%      92.80 ± 12%  slabinfo.btrfs_inode.active_objs
      3.60 ± 13%     -11.1%       3.20 ± 12%  slabinfo.btrfs_inode.active_slabs
    104.40 ± 13%     -11.1%      92.80 ± 12%  slabinfo.btrfs_inode.num_objs
      3.60 ± 13%     -11.1%       3.20 ± 12%  slabinfo.btrfs_inode.num_slabs
    211.85 ±  5%      +1.7%     215.47        slabinfo.btrfs_path.active_objs
      5.88 ±  5%      +1.7%       5.99        slabinfo.btrfs_path.active_slabs
    211.85 ±  5%      +1.7%     215.47        slabinfo.btrfs_path.num_objs
      5.88 ±  5%      +1.7%       5.99        slabinfo.btrfs_path.num_slabs
    156.00           +15.0%     179.40 ± 10%  slabinfo.buffer_head.active_objs
      4.00           +15.0%       4.60 ± 10%  slabinfo.buffer_head.active_slabs
    156.00           +15.0%     179.40 ± 10%  slabinfo.buffer_head.num_objs
      4.00           +15.0%       4.60 ± 10%  slabinfo.buffer_head.num_slabs
     14481            +0.1%      14494        slabinfo.cred_jar.active_objs
    344.80            +0.1%     345.10        slabinfo.cred_jar.active_slabs
     14481            +0.1%      14494        slabinfo.cred_jar.num_objs
    344.80            +0.1%     345.10        slabinfo.cred_jar.num_slabs
     39.00            +0.0%      39.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     39.00            +0.0%      39.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
    165719            +0.4%     166422        slabinfo.dentry.active_objs
      3967            +0.6%       3990        slabinfo.dentry.active_slabs
    166647            +0.6%     167586        slabinfo.dentry.num_objs
      3967            +0.6%       3990        slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
     64.00            +0.0%      64.00        slabinfo.dmaengine-unmap-2.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-2.active_slabs
     64.00            +0.0%      64.00        slabinfo.dmaengine-unmap-2.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-2.num_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
     24640 ± 10%      -1.5%      24268 ±  6%  slabinfo.ep_head.active_objs
     96.25 ± 10%      -1.5%      94.80 ±  6%  slabinfo.ep_head.active_slabs
     24640 ± 10%      -1.5%      24268 ±  6%  slabinfo.ep_head.num_objs
     96.25 ± 10%      -1.5%      94.80 ±  6%  slabinfo.ep_head.num_slabs
    706.56 ±  7%      +1.7%     718.75 ±  9%  slabinfo.file_lock_cache.active_objs
     19.10 ±  7%      +1.7%      19.43 ±  9%  slabinfo.file_lock_cache.active_slabs
    706.56 ±  7%      +1.7%     718.75 ±  9%  slabinfo.file_lock_cache.num_objs
     19.10 ±  7%      +1.7%      19.43 ±  9%  slabinfo.file_lock_cache.num_slabs
      9531            +1.5%       9673 ±  2%  slabinfo.files_cache.active_objs
    207.21            +1.5%     210.29 ±  2%  slabinfo.files_cache.active_slabs
      9531            +1.5%       9673 ±  2%  slabinfo.files_cache.num_objs
    207.21            +1.5%     210.29 ±  2%  slabinfo.files_cache.num_slabs
     40884            +0.5%      41085        slabinfo.filp.active_objs
    672.40            +0.2%     674.07 ±  3%  slabinfo.filp.active_slabs
     43033            +0.2%      43140 ±  3%  slabinfo.filp.num_objs
    672.40            +0.2%     674.07 ±  3%  slabinfo.filp.num_slabs
      2316 ±  7%      +2.8%       2380 ±  8%  slabinfo.fsnotify_mark_connector.active_objs
     18.10 ±  7%      +2.8%      18.60 ±  8%  slabinfo.fsnotify_mark_connector.active_slabs
      2316 ±  7%      +2.8%       2380 ±  8%  slabinfo.fsnotify_mark_connector.num_objs
     18.10 ±  7%      +2.8%      18.60 ±  8%  slabinfo.fsnotify_mark_connector.num_slabs
      9300 ±  3%      +1.2%       9409 ±  5%  slabinfo.ftrace_event_field.active_objs
    127.40 ±  3%      +1.2%     128.90 ±  5%  slabinfo.ftrace_event_field.active_slabs
      9300 ±  3%      +1.2%       9409 ±  5%  slabinfo.ftrace_event_field.num_objs
    127.40 ±  3%      +1.2%     128.90 ±  5%  slabinfo.ftrace_event_field.num_slabs
     56.00            +0.0%      56.00        slabinfo.fuse_request.active_objs
      1.00            +0.0%       1.00        slabinfo.fuse_request.active_slabs
     56.00            +0.0%      56.00        slabinfo.fuse_request.num_objs
      1.00            +0.0%       1.00        slabinfo.fuse_request.num_slabs
     98.00            +0.0%      98.00        slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
     98.00            +0.0%      98.00        slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
    105824            +0.1%     105909        slabinfo.inode_cache.active_objs
      2077            +0.1%       2079        slabinfo.inode_cache.active_slabs
    105950            +0.1%     106056        slabinfo.inode_cache.num_objs
      2077            +0.1%       2079        slabinfo.inode_cache.num_slabs
    182.50 ± 20%     +16.0%     211.70 ± 10%  slabinfo.ip_fib_alias.active_objs
      2.50 ± 20%     +16.0%       2.90 ± 10%  slabinfo.ip_fib_alias.active_slabs
    182.50 ± 20%     +16.0%     211.70 ± 10%  slabinfo.ip_fib_alias.num_objs
      2.50 ± 20%     +16.0%       2.90 ± 10%  slabinfo.ip_fib_alias.num_slabs
    212.50 ± 20%     +16.0%     246.50 ± 10%  slabinfo.ip_fib_trie.active_objs
      2.50 ± 20%     +16.0%       2.90 ± 10%  slabinfo.ip_fib_trie.active_slabs
    212.50 ± 20%     +16.0%     246.50 ± 10%  slabinfo.ip_fib_trie.num_objs
      2.50 ± 20%     +16.0%       2.90 ± 10%  slabinfo.ip_fib_trie.num_slabs
    168800            +0.0%     168832        slabinfo.kernfs_node_cache.active_objs
      2637            +0.0%       2638        slabinfo.kernfs_node_cache.active_slabs
    168800            +0.0%     168832        slabinfo.kernfs_node_cache.num_objs
      2637            +0.0%       2638        slabinfo.kernfs_node_cache.num_slabs
     21600            -0.1%      21570        slabinfo.khugepaged_mm_slot.active_objs
    211.77            -0.1%     211.48        slabinfo.khugepaged_mm_slot.active_slabs
     21600            -0.1%      21570        slabinfo.khugepaged_mm_slot.num_objs
    211.77            -0.1%     211.48        slabinfo.khugepaged_mm_slot.num_slabs
     20061            +0.5%      20170        slabinfo.kmalloc-128.active_objs
    320.03            +0.0%     320.16        slabinfo.kmalloc-128.active_slabs
     20482            +0.0%      20490        slabinfo.kmalloc-128.num_objs
    320.03            +0.0%     320.16        slabinfo.kmalloc-128.num_slabs
     83404            -0.0%      83399        slabinfo.kmalloc-16.active_objs
    325.80            +0.1%     326.10        slabinfo.kmalloc-16.active_slabs
     83404            +0.1%      83481        slabinfo.kmalloc-16.num_objs
    325.80            +0.1%     326.10        slabinfo.kmalloc-16.num_slabs
     21409            +0.1%      21421        slabinfo.kmalloc-192.active_objs
    509.82            +0.1%     510.14        slabinfo.kmalloc-192.active_slabs
     21412            +0.1%      21425        slabinfo.kmalloc-192.num_objs
    509.82            +0.1%     510.14        slabinfo.kmalloc-192.num_slabs
     10382            -0.2%      10360        slabinfo.kmalloc-1k.active_objs
    325.71            -0.1%     325.33        slabinfo.kmalloc-1k.active_slabs
     10422            -0.1%      10410        slabinfo.kmalloc-1k.num_objs
    325.71            -0.1%     325.33        slabinfo.kmalloc-1k.num_slabs
     20195            +0.2%      20233        slabinfo.kmalloc-256.active_objs
    323.34 ±  2%      +0.2%     323.86        slabinfo.kmalloc-256.active_slabs
     20693 ±  2%      +0.2%      20727        slabinfo.kmalloc-256.num_objs
    323.34 ±  2%      +0.2%     323.86        slabinfo.kmalloc-256.num_slabs
      9041            -0.3%       9015        slabinfo.kmalloc-2k.active_objs
    566.68            -0.2%     565.41        slabinfo.kmalloc-2k.active_slabs
      9066            -0.2%       9046        slabinfo.kmalloc-2k.num_objs
    566.68            -0.2%     565.41        slabinfo.kmalloc-2k.num_slabs
    175334            -0.1%     175183        slabinfo.kmalloc-32.active_objs
      1370            -0.1%       1368        slabinfo.kmalloc-32.active_slabs
    175365            -0.1%     175221        slabinfo.kmalloc-32.num_objs
      1370            -0.1%       1368        slabinfo.kmalloc-32.num_slabs
      3202            -0.6%       3184        slabinfo.kmalloc-4k.active_objs
    400.65            -0.5%     398.60        slabinfo.kmalloc-4k.active_slabs
      3205            -0.5%       3188        slabinfo.kmalloc-4k.num_objs
    400.65            -0.5%     398.60        slabinfo.kmalloc-4k.num_slabs
     33467            +0.5%      33643        slabinfo.kmalloc-512.active_objs
    524.91            +0.4%     527.19        slabinfo.kmalloc-512.active_slabs
     33594            +0.4%      33740        slabinfo.kmalloc-512.num_objs
    524.91            +0.4%     527.19        slabinfo.kmalloc-512.num_slabs
    172450            -0.1%     172322        slabinfo.kmalloc-64.active_objs
      2694            -0.1%       2692        slabinfo.kmalloc-64.active_slabs
    172473            -0.1%     172339        slabinfo.kmalloc-64.num_objs
      2694            -0.1%       2692        slabinfo.kmalloc-64.num_slabs
    138463            +0.5%     139132        slabinfo.kmalloc-8.active_objs
    280.42 ±  2%      -0.1%     280.24        slabinfo.kmalloc-8.active_slabs
    143573 ±  2%      -0.1%     143480        slabinfo.kmalloc-8.num_objs
    280.42 ±  2%      -0.1%     280.24        slabinfo.kmalloc-8.num_slabs
      1429            -0.1%       1427        slabinfo.kmalloc-8k.active_objs
    357.53            -0.1%     357.17        slabinfo.kmalloc-8k.active_slabs
      1430            -0.1%       1428        slabinfo.kmalloc-8k.num_objs
    357.53            -0.1%     357.17        slabinfo.kmalloc-8k.num_slabs
     38336            +1.3%      38843 ±  2%  slabinfo.kmalloc-96.active_objs
    932.92            +1.5%     946.90 ±  2%  slabinfo.kmalloc-96.active_slabs
     39182            +1.5%      39769 ±  2%  slabinfo.kmalloc-96.num_objs
    932.92            +1.5%     946.90 ±  2%  slabinfo.kmalloc-96.num_slabs
      1542 ±  2%      -0.4%       1536 ±  5%  slabinfo.kmalloc-cg-128.active_objs
     24.10 ±  2%      -0.4%      24.00 ±  5%  slabinfo.kmalloc-cg-128.active_slabs
      1542 ±  2%      -0.4%       1536 ±  5%  slabinfo.kmalloc-cg-128.num_objs
     24.10 ±  2%      -0.4%      24.00 ±  5%  slabinfo.kmalloc-cg-128.num_slabs
      4325 ±  2%      -1.7%       4252 ±  4%  slabinfo.kmalloc-cg-16.active_objs
     16.90 ±  2%      -1.7%      16.61 ±  4%  slabinfo.kmalloc-cg-16.active_slabs
      4325 ±  2%      -1.7%       4252 ±  4%  slabinfo.kmalloc-cg-16.num_objs
     16.90 ±  2%      -1.7%      16.61 ±  4%  slabinfo.kmalloc-cg-16.num_slabs
      8798 ±  2%      +2.3%       9004        slabinfo.kmalloc-cg-192.active_objs
    209.49 ±  2%      +2.3%     214.40        slabinfo.kmalloc-cg-192.active_slabs
      8798 ±  2%      +2.3%       9004        slabinfo.kmalloc-cg-192.num_objs
    209.49 ±  2%      +2.3%     214.40        slabinfo.kmalloc-cg-192.num_slabs
      6641 ±  3%      +2.4%       6802 ±  3%  slabinfo.kmalloc-cg-1k.active_objs
    207.56 ±  3%      +2.4%     212.58 ±  3%  slabinfo.kmalloc-cg-1k.active_slabs
      6641 ±  3%      +2.4%       6802 ±  3%  slabinfo.kmalloc-cg-1k.num_objs
    207.56 ±  3%      +2.4%     212.58 ±  3%  slabinfo.kmalloc-cg-1k.num_slabs
      1472 ±  4%      -6.1%       1382 ±  5%  slabinfo.kmalloc-cg-256.active_objs
     23.00 ±  4%      -6.1%      21.60 ±  5%  slabinfo.kmalloc-cg-256.active_slabs
      1472 ±  4%      -6.1%       1382 ±  5%  slabinfo.kmalloc-cg-256.num_objs
     23.00 ±  4%      -6.1%      21.60 ±  5%  slabinfo.kmalloc-cg-256.num_slabs
      1018 ±  3%      +2.2%       1040 ±  4%  slabinfo.kmalloc-cg-2k.active_objs
     63.66 ±  3%      +2.2%      65.06 ±  4%  slabinfo.kmalloc-cg-2k.active_slabs
      1018 ±  3%      +2.2%       1040 ±  4%  slabinfo.kmalloc-cg-2k.num_objs
     63.66 ±  3%      +2.2%      65.06 ±  4%  slabinfo.kmalloc-cg-2k.num_slabs
     29379            +0.1%      29422        slabinfo.kmalloc-cg-32.active_objs
    229.52            +0.1%     229.87        slabinfo.kmalloc-cg-32.active_slabs
     29379            +0.1%      29422        slabinfo.kmalloc-cg-32.num_objs
    229.52            +0.1%     229.87        slabinfo.kmalloc-cg-32.num_slabs
      2697            -0.5%       2683        slabinfo.kmalloc-cg-4k.active_objs
    340.10            -0.6%     338.10        slabinfo.kmalloc-cg-4k.active_slabs
      2720            -0.6%       2704        slabinfo.kmalloc-cg-4k.num_objs
    340.10            -0.6%     338.10        slabinfo.kmalloc-cg-4k.num_slabs
     14431            -0.1%      14419        slabinfo.kmalloc-cg-512.active_objs
    225.50            -0.1%     225.30        slabinfo.kmalloc-cg-512.active_slabs
     14431            -0.1%      14419        slabinfo.kmalloc-cg-512.num_objs
    225.50            -0.1%     225.30        slabinfo.kmalloc-cg-512.num_slabs
      3134 ±  4%      -0.2%       3127 ±  7%  slabinfo.kmalloc-cg-64.active_objs
     48.97 ±  4%      -0.2%      48.87 ±  7%  slabinfo.kmalloc-cg-64.active_slabs
      3134 ±  4%      -0.2%       3127 ±  7%  slabinfo.kmalloc-cg-64.num_objs
     48.97 ±  4%      -0.2%      48.87 ±  7%  slabinfo.kmalloc-cg-64.num_slabs
    115595            +0.1%     115732        slabinfo.kmalloc-cg-8.active_objs
    225.77            +0.1%     226.04        slabinfo.kmalloc-cg-8.active_slabs
    115595            +0.1%     115732        slabinfo.kmalloc-cg-8.num_objs
    225.77            +0.1%     226.04        slabinfo.kmalloc-cg-8.num_slabs
     50.61 ±  3%      +0.3%      50.74 ±  3%  slabinfo.kmalloc-cg-8k.active_objs
     12.65 ±  3%      +0.3%      12.68 ±  3%  slabinfo.kmalloc-cg-8k.active_slabs
     50.61 ±  3%      +0.3%      50.74 ±  3%  slabinfo.kmalloc-cg-8k.num_objs
     12.65 ±  3%      +0.3%      12.68 ±  3%  slabinfo.kmalloc-cg-8k.num_slabs
      1931 ±  4%      +2.8%       1986 ±  7%  slabinfo.kmalloc-cg-96.active_objs
     46.00 ±  4%      +2.8%      47.30 ±  7%  slabinfo.kmalloc-cg-96.active_slabs
      1931 ±  4%      +2.8%       1986 ±  7%  slabinfo.kmalloc-cg-96.num_objs
     46.00 ±  4%      +2.8%      47.30 ±  7%  slabinfo.kmalloc-cg-96.num_slabs
    300.80 ± 13%      +2.1%     307.20 ±  8%  slabinfo.kmalloc-rcl-128.active_objs
      4.70 ± 13%      +2.1%       4.80 ±  8%  slabinfo.kmalloc-rcl-128.active_slabs
    300.80 ± 13%      +2.1%     307.20 ±  8%  slabinfo.kmalloc-rcl-128.num_objs
      4.70 ± 13%      +2.1%       4.80 ±  8%  slabinfo.kmalloc-rcl-128.num_slabs
     42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.active_objs
      1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.active_slabs
     42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.num_objs
      1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.num_slabs
      8078 ±  3%      -0.7%       8020 ±  4%  slabinfo.kmalloc-rcl-64.active_objs
    126.36 ±  3%      -0.7%     125.46 ±  3%  slabinfo.kmalloc-rcl-64.active_slabs
      8087 ±  3%      -0.7%       8029 ±  3%  slabinfo.kmalloc-rcl-64.num_objs
    126.36 ±  3%      -0.7%     125.46 ±  3%  slabinfo.kmalloc-rcl-64.num_slabs
      1247 ±  7%      +0.0%       1247 ±  7%  slabinfo.kmalloc-rcl-96.active_objs
     29.70 ±  7%      +0.0%      29.70 ±  7%  slabinfo.kmalloc-rcl-96.active_slabs
      1247 ±  7%      +0.0%       1247 ±  7%  slabinfo.kmalloc-rcl-96.num_objs
     29.70 ±  7%      +0.0%      29.70 ±  7%  slabinfo.kmalloc-rcl-96.num_slabs
      1113 ±  6%      -9.2%       1011 ± 10%  slabinfo.kmem_cache.active_objs
     17.40 ±  6%      -9.2%      15.80 ± 10%  slabinfo.kmem_cache.active_slabs
      1113 ±  6%      -9.2%       1011 ± 10%  slabinfo.kmem_cache.num_objs
     17.40 ±  6%      -9.2%      15.80 ± 10%  slabinfo.kmem_cache.num_slabs
      1297 ±  5%      -7.4%       1201 ±  8%  slabinfo.kmem_cache_node.active_objs
     20.30 ±  5%      -7.4%      18.80 ±  8%  slabinfo.kmem_cache_node.active_slabs
      1299 ±  5%      -7.4%       1203 ±  8%  slabinfo.kmem_cache_node.num_objs
     20.30 ±  5%      -7.4%      18.80 ±  8%  slabinfo.kmem_cache_node.num_slabs
     44655            -0.2%      44587        slabinfo.lsm_file_cache.active_objs
    263.38            -0.1%     263.16        slabinfo.lsm_file_cache.active_slabs
     44775            -0.1%      44737        slabinfo.lsm_file_cache.num_objs
    263.38            -0.1%     263.16        slabinfo.lsm_file_cache.num_slabs
     48621 ±  2%      +7.3%      52173 ±  4%  slabinfo.maple_node.active_objs
    772.36 ±  2%      +8.3%     836.19 ±  3%  slabinfo.maple_node.active_slabs
     49431 ±  2%      +8.3%      53516 ±  3%  slabinfo.maple_node.num_objs
    772.36 ±  2%      +8.3%     836.19 ±  3%  slabinfo.maple_node.num_slabs
      5734            +1.2%       5801        slabinfo.mm_struct.active_objs
    238.95            +1.2%     241.73        slabinfo.mm_struct.active_slabs
      5734            +1.2%       5801        slabinfo.mm_struct.num_objs
    238.95            +1.2%     241.73        slabinfo.mm_struct.num_slabs
      1116 ±  6%      -0.5%       1111 ±  5%  slabinfo.mnt_cache.active_objs
     21.90 ±  6%      -0.5%      21.80 ±  5%  slabinfo.mnt_cache.active_slabs
      1116 ±  6%      -0.5%       1111 ±  5%  slabinfo.mnt_cache.num_objs
     21.90 ±  6%      -0.5%      21.80 ±  5%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
      1792            +0.2%       1795        slabinfo.names_cache.active_objs
    224.00            +0.2%     224.40        slabinfo.names_cache.active_slabs
      1792            +0.2%       1795        slabinfo.names_cache.num_objs
    224.00            +0.2%     224.40        slabinfo.names_cache.num_slabs
      7.00            +0.0%       7.00        slabinfo.net_namespace.active_objs
      1.00            +0.0%       1.00        slabinfo.net_namespace.active_slabs
      7.00            +0.0%       7.00        slabinfo.net_namespace.num_objs
      1.00            +0.0%       1.00        slabinfo.net_namespace.num_slabs
     46.00            +0.0%      46.00        slabinfo.nfs_commit_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_commit_data.active_slabs
     46.00            +0.0%      46.00        slabinfo.nfs_commit_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_commit_data.num_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    292.96 ±  8%      -0.9%     290.20 ±  8%  slabinfo.nsproxy.active_objs
      5.23 ±  8%      -0.9%       5.18 ±  8%  slabinfo.nsproxy.active_slabs
    292.96 ±  8%      -0.9%     290.20 ±  8%  slabinfo.nsproxy.num_objs
      5.23 ±  8%      -0.9%       5.18 ±  8%  slabinfo.nsproxy.num_slabs
    240.00            +0.0%     240.00        slabinfo.numa_policy.active_objs
      4.00            +0.0%       4.00        slabinfo.numa_policy.active_slabs
    240.00            +0.0%     240.00        slabinfo.numa_policy.num_objs
      4.00            +0.0%       4.00        slabinfo.numa_policy.num_slabs
     10075            -0.5%      10024        slabinfo.perf_event.active_objs
    404.18            -0.4%     402.52        slabinfo.perf_event.active_slabs
     10104            -0.4%      10062        slabinfo.perf_event.num_objs
    404.18            -0.4%     402.52        slabinfo.perf_event.num_slabs
     16201            -0.7%      16089        slabinfo.pid.active_objs
    253.20            -0.7%     251.40        slabinfo.pid.active_slabs
     16204            -0.7%      16089        slabinfo.pid.num_objs
    253.20            -0.7%     251.40        slabinfo.pid.num_slabs
     13300            -1.0%      13163        slabinfo.pool_workqueue.active_objs
    208.12            -1.1%     205.93        slabinfo.pool_workqueue.active_slabs
     13319            -1.1%      13179        slabinfo.pool_workqueue.num_objs
    208.12            -1.1%     205.93        slabinfo.pool_workqueue.num_slabs
      4792            -1.1%       4741        slabinfo.proc_dir_entry.active_objs
    114.10            -1.1%     112.90        slabinfo.proc_dir_entry.active_slabs
      4792            -1.1%       4741        slabinfo.proc_dir_entry.num_objs
    114.10            -1.1%     112.90        slabinfo.proc_dir_entry.num_slabs
     29409            +0.4%      29525        slabinfo.proc_inode_cache.active_objs
    639.60            +0.4%     642.26        slabinfo.proc_inode_cache.active_slabs
     29421            +0.4%      29544        slabinfo.proc_inode_cache.num_objs
    639.60            +0.4%     642.26        slabinfo.proc_inode_cache.num_slabs
     40983            +0.1%      41043        slabinfo.radix_tree_node.active_objs
    732.66            +0.2%     733.78        slabinfo.radix_tree_node.active_slabs
     41029            +0.2%      41091        slabinfo.radix_tree_node.num_objs
    732.66            +0.2%     733.78        slabinfo.radix_tree_node.num_slabs
    294.00 ± 18%      +8.3%     318.50 ± 18%  slabinfo.request_queue.active_objs
     10.20 ±  9%      +4.9%      10.70 ± 16%  slabinfo.request_queue.active_slabs
    357.00 ±  9%      +4.9%     374.50 ± 16%  slabinfo.request_queue.num_objs
     10.20 ±  9%      +4.9%      10.70 ± 16%  slabinfo.request_queue.num_slabs
     46.00            +0.0%      46.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     46.00            +0.0%      46.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
      4812            +0.3%       4825        slabinfo.scsi_sense_cache.active_objs
     76.20            +0.3%      76.40        slabinfo.scsi_sense_cache.active_slabs
      4876            +0.3%       4889        slabinfo.scsi_sense_cache.num_objs
     76.20            +0.3%      76.40        slabinfo.scsi_sense_cache.num_slabs
     15979            -0.1%      15967        slabinfo.seq_file.active_objs
    234.99            -0.1%     234.81        slabinfo.seq_file.active_slabs
     15979            -0.1%      15967        slabinfo.seq_file.num_objs
    234.99            -0.1%     234.81        slabinfo.seq_file.num_slabs
    101821            +0.2%     101974        slabinfo.shared_policy_node.active_objs
      1197            +0.2%       1199        slabinfo.shared_policy_node.active_slabs
    101821            +0.2%     101974        slabinfo.shared_policy_node.num_objs
      1197            +0.2%       1199        slabinfo.shared_policy_node.num_slabs
      8779            +0.4%       8816 ±  3%  slabinfo.shmem_inode_cache.active_objs
    204.19            +0.4%     205.04 ±  3%  slabinfo.shmem_inode_cache.active_slabs
      8779            +0.4%       8816 ±  3%  slabinfo.shmem_inode_cache.num_objs
    204.19            +0.4%     205.04 ±  3%  slabinfo.shmem_inode_cache.num_slabs
      5473            +0.8%       5519        slabinfo.sighand_cache.active_objs
    365.02            +0.9%     368.23        slabinfo.sighand_cache.active_slabs
      5475            +0.9%       5523        slabinfo.sighand_cache.num_objs
    365.02            +0.9%     368.23        slabinfo.sighand_cache.num_slabs
      8990            +0.1%       8995 ±  2%  slabinfo.signal_cache.active_objs
    321.28            +0.1%     321.61 ±  2%  slabinfo.signal_cache.active_slabs
      8995            +0.1%       9005 ±  2%  slabinfo.signal_cache.num_objs
    321.28            +0.1%     321.61 ±  2%  slabinfo.signal_cache.num_slabs
     11923            +0.2%      11946        slabinfo.sigqueue.active_objs
    233.79            +0.2%     234.24        slabinfo.sigqueue.active_slabs
     11923            +0.2%      11946        slabinfo.sigqueue.num_objs
    233.79            +0.2%     234.24        slabinfo.sigqueue.num_slabs
    510.09 ±  8%      +3.2%     526.37 ±  6%  slabinfo.skbuff_ext_cache.active_objs
     12.15 ±  8%      +3.2%      12.53 ±  6%  slabinfo.skbuff_ext_cache.active_slabs
    510.09 ±  8%      +3.2%     526.37 ±  6%  slabinfo.skbuff_ext_cache.num_objs
     12.15 ±  8%      +3.2%      12.53 ±  6%  slabinfo.skbuff_ext_cache.num_slabs
     15648            -0.4%      15590        slabinfo.skbuff_head_cache.active_objs
    245.30            -0.4%     244.20        slabinfo.skbuff_head_cache.active_slabs
     15699            -0.4%      15628        slabinfo.skbuff_head_cache.num_objs
    245.30            -0.4%     244.20        slabinfo.skbuff_head_cache.num_slabs
      8653 ±  5%      -1.9%       8491 ±  5%  slabinfo.skbuff_small_head.active_objs
    169.68 ±  5%      -1.9%     166.50 ±  5%  slabinfo.skbuff_small_head.active_slabs
      8653 ±  5%      -1.9%       8491 ±  5%  slabinfo.skbuff_small_head.num_objs
    169.68 ±  5%      -1.9%     166.50 ±  5%  slabinfo.skbuff_small_head.num_slabs
      4352 ±  5%      -2.8%       4228 ±  5%  slabinfo.sock_inode_cache.active_objs
    111.59 ±  5%      -2.8%     108.42 ±  5%  slabinfo.sock_inode_cache.active_slabs
      4352 ±  5%      -2.8%       4228 ±  5%  slabinfo.sock_inode_cache.num_objs
    111.59 ±  5%      -2.8%     108.42 ±  5%  slabinfo.sock_inode_cache.num_slabs
      1634 ±  6%      +4.9%       1714 ±  5%  slabinfo.task_group.active_objs
     32.05 ±  6%      +4.9%      33.62 ±  5%  slabinfo.task_group.active_slabs
      1634 ±  6%      +4.9%       1714 ±  5%  slabinfo.task_group.num_objs
     32.05 ±  6%      +4.9%      33.62 ±  5%  slabinfo.task_group.num_slabs
      3787            -0.3%       3777        slabinfo.task_struct.active_objs
      3790            -0.3%       3779        slabinfo.task_struct.active_slabs
      3790            -0.3%       3779        slabinfo.task_struct.num_objs
      3790            -0.3%       3779        slabinfo.task_struct.num_slabs
    262.17 ±  8%      -1.9%     257.14 ±  9%  slabinfo.taskstats.active_objs
      7.09 ±  8%      -1.9%       6.95 ±  9%  slabinfo.taskstats.active_slabs
    262.17 ±  8%      -1.9%     257.14 ±  9%  slabinfo.taskstats.num_objs
      7.09 ±  8%      -1.9%       6.95 ±  9%  slabinfo.taskstats.num_slabs
      2350            -0.4%       2341        slabinfo.trace_event_file.active_objs
     51.10            -0.4%      50.90        slabinfo.trace_event_file.active_slabs
      2350            -0.4%       2341        slabinfo.trace_event_file.num_objs
     51.10            -0.4%      50.90        slabinfo.trace_event_file.num_slabs
      2394            +0.3%       2400        slabinfo.tracefs_inode_cache.active_objs
     47.89            +0.3%      48.02        slabinfo.tracefs_inode_cache.active_slabs
      2394            +0.3%       2400        slabinfo.tracefs_inode_cache.num_objs
     47.89            +0.3%      48.02        slabinfo.tracefs_inode_cache.num_slabs
     60.00            +0.0%      60.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     60.00            +0.0%      60.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
     74.00            +0.0%      74.00        slabinfo.uts_namespace.active_objs
      2.00            +0.0%       2.00        slabinfo.uts_namespace.active_slabs
     74.00            +0.0%      74.00        slabinfo.uts_namespace.num_objs
      2.00            +0.0%       2.00        slabinfo.uts_namespace.num_slabs
     85556            -2.1%      83786 ±  4%  slabinfo.vm_area_struct.active_objs
      1952            -1.8%       1916 ±  4%  slabinfo.vm_area_struct.active_slabs
     85920            -1.8%      84334 ±  4%  slabinfo.vm_area_struct.num_objs
      1952            -1.8%       1916 ±  4%  slabinfo.vm_area_struct.num_slabs
     98458            -0.5%      97931 ±  2%  slabinfo.vma_lock.active_objs
    969.74            -0.4%     965.79 ±  2%  slabinfo.vma_lock.active_slabs
     98913            -0.4%      98510 ±  2%  slabinfo.vma_lock.num_objs
    969.74            -0.4%     965.79 ±  2%  slabinfo.vma_lock.num_slabs
    811570            +0.0%     811625        slabinfo.vmap_area.active_objs
     14497            +0.0%      14499        slabinfo.vmap_area.active_slabs
    811855            +0.0%     811960        slabinfo.vmap_area.num_objs
     14497            +0.0%      14499        slabinfo.vmap_area.num_slabs
    276.34            +0.1%     276.48        slabinfo.x86_lbr.active_objs
     13.95            +0.0%      13.96        slabinfo.x86_lbr.active_slabs
    293.03            +0.0%     293.07        slabinfo.x86_lbr.num_objs
     13.95            +0.0%      13.96        slabinfo.x86_lbr.num_slabs
      0.00       +1.4e+100%       0.01 ±146%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page
      0.00       +4.1e+101%       0.41 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.__pud_alloc.__handle_mm_fault.handle_mm_fault
      0.00          +7e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.move_page_tables
      0.01 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__flush_work.isra.0.__lru_add_drain_all
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.acpi_ex_allocate_name_string.acpi_ex_get_name_string
      0.00          +7e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.load_elf_phdrs.load_elf_binary
      0.00          +8e+99%       0.01 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_node_trace.alloc_fair_sched_group.sched_create_group
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      0.00        +1.4e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.vmstat_start.seq_read_iter
      0.00        +1.1e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.00        +1.4e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      0.00 ± 96%     +50.0%       0.00 ± 80%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.18 ±292%     -97.9%       0.00 ±156%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.00       +7.8e+100%       0.08 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.change_pmd_range.change_p4d_range.change_protection_range.mprotect_fixup
      0.00          +9e+98%       0.00 ±299%  perf-sched.sch_delay.avg.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
      0.00       +3.7e+101%       0.37 ±299%  perf-sched.sch_delay.avg.ms.__cond_resched.dentry_kill.dput.step_into.link_path_walk
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      0.00        +1.1e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.vma_modify
      0.05 ±298%    +730.6%       0.39 ±106%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.00          +7e+98%       0.00 ±299%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
      0.00       +5.1e+100%       0.05 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.00       +2.5e+101%       0.25 ±298%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.00       +2.7e+101%       0.27 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.00          +1e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
      0.00          +8e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
      0.00          +1e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.00        +2.7e+99%       0.00 ±299%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.acpi_ut_create_generic_state.acpi_ds_result_push.acpi_ds_exec_end_op
      0.00 ±152%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      0.00       +2.5e+101%       0.25 ±299%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.05 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
      0.00       +4.2e+100%       0.04 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.vma_link
      0.00 ±200%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm.do_execveat_common
      0.00        +1.3e+99%       0.00 ±299%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.00        +1.6e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.drm_property_free_blob.drm_gem_destroy_shadow_plane_state.drm_atomic_state_default_clear
      0.00       +5.4e+101%       0.54 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_interruptible.devkmsg_read.vfs_read.ksys_read
      0.00       +9.1e+101%       0.91 ±130%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.alloc_bprm
      0.00        +7.9e+99%       0.01 ±133%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      0.01 ±299%     -65.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.00        +2.1e+99%       0.00 ±213%  perf-sched.sch_delay.avg.ms.__cond_resched.refresh_cpu_vm_stats.vmstat_update.process_one_work.worker_thread
      0.30 ±299%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00       +8.1e+101%       0.81 ±155%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_read_folio_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages
      0.01 ±  3%      -5.8%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.77 ±  5%      +4.7%       1.85 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.33 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00        +2.2e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      0.00       +5.9e+100%       0.06 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.00       +3.1e+100%       0.03 ±201%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      0.31 ±201%    +246.6%       1.06 ±228%  perf-sched.sch_delay.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.67 ±152%     +24.2%       2.08 ±122%  perf-sched.sch_delay.avg.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      1.06 ±200%     +40.8%       1.50 ±153%  perf-sched.sch_delay.avg.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_cleanup_planes
      0.00        +4.7e+99%       0.00 ±192%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.69 ± 83%     -69.5%       0.21 ±172%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.20 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.cleaner_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.84 ± 69%   +1807.1%      15.92 ±108%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.42 ±119%     -48.3%       0.22 ±121%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.14 ± 54%    +235.6%       0.46 ± 31%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.16 ± 32%     +37.1%       0.22 ± 20%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±208%      +6.1%       0.01 ±123%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.02 ± 41%    +249.5%       0.07 ± 68%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.20 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.28 ±297%     -99.2%       0.00 ±300%  perf-sched.sch_delay.avg.ms.kthreadd.ret_from_fork.ret_from_fork_asm
      0.04 ± 40%     -28.4%       0.03 ± 28%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.40 ± 23%     -27.9%       0.29 ± 40%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      2.21 ± 49%      +9.3%       2.42 ± 42%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.25 ± 62%     +79.2%       0.46 ±168%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ±202%     -28.6%       0.00 ±300%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm
      2.67 ±203%     -30.4%       1.86 ±300%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_killable.__kthread_create_on_node
      0.45 ± 23%     +14.3%       0.52 ± 16%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ± 25%     -13.2%       0.02 ± 23%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.02 ± 45%     +11.2%       0.03 ± 39%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00 ±299%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
      0.01           +77.7%       0.02 ± 32%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.96 ± 77%   +1111.2%      11.68 ± 99%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.12 ±102%    +410.5%       0.62 ± 19%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.02 ± 10%     +57.8%       0.04 ± 48%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00       +6.6e+101%       0.66 ±159%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page
      0.00       +4.1e+101%       0.41 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.__pud_alloc.__handle_mm_fault.handle_mm_fault
      0.00          +7e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.move_page_tables
      0.01 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__flush_work.isra.0.__lru_add_drain_all
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.acpi_ex_allocate_name_string.acpi_ex_get_name_string
      0.00          +7e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.load_elf_phdrs.load_elf_binary
      0.00       +1.6e+100%       0.02 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_node_trace.alloc_fair_sched_group.sched_create_group
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      0.00        +1.4e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.vmstat_start.seq_read_iter
      0.00        +1.1e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.00        +1.4e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      1.62 ± 97%     +65.5%       2.69 ± 82%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.18 ±292%     -97.9%       0.00 ±156%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.00       +2.3e+101%       0.23 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.change_pmd_range.change_p4d_range.change_protection_range.mprotect_fixup
      0.00          +9e+98%       0.00 ±299%  perf-sched.sch_delay.max.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
      0.00       +3.7e+101%       0.37 ±299%  perf-sched.sch_delay.max.ms.__cond_resched.dentry_kill.dput.step_into.link_path_walk
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      0.00        +1.1e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.vma_modify
      0.19 ±298%    +433.1%       1.00 ± 87%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.00          +7e+98%       0.00 ±299%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
      0.00       +3.6e+101%       0.36 ±299%  perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.00       +2.5e+101%       0.25 ±298%  perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.00       +2.7e+101%       0.27 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.00          +1e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
      0.00        +1.6e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
      0.00          +1e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.00        +2.7e+99%       0.00 ±299%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.acpi_ut_create_generic_state.acpi_ds_result_push.acpi_ds_exec_end_op
      0.00 ±152%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      0.00       +2.5e+101%       0.25 ±299%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.26 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
      0.00       +4.2e+100%       0.04 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.vma_link
      0.00 ±200%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm.do_execveat_common
      0.00        +1.3e+99%       0.00 ±299%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.00        +1.6e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.drm_property_free_blob.drm_gem_destroy_shadow_plane_state.drm_atomic_state_default_clear
      0.00       +5.4e+101%       0.54 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_interruptible.devkmsg_read.vfs_read.ksys_read
      0.00       +1.2e+102%       1.24 ±129%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.alloc_bprm
      0.00        +7.9e+99%       0.01 ±133%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      0.01 ±299%     -65.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.00        +2.1e+99%       0.00 ±213%  perf-sched.sch_delay.max.ms.__cond_resched.refresh_cpu_vm_stats.vmstat_update.process_one_work.worker_thread
      0.30 ±299%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00       +1.3e+102%       1.30 ±158%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_read_folio_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages
      0.02 ± 22%      +4.5%       0.02 ± 23%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.01 ±  3%      -0.8%       3.97 ±  2%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.33 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00        +2.2e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      0.00       +1.2e+101%       0.12 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.00       +5.7e+101%       0.57 ±200%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      0.44 ±205%    +141.1%       1.06 ±228%  perf-sched.sch_delay.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.67 ±152%     +24.2%       2.08 ±122%  perf-sched.sch_delay.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      1.06 ±200%     +40.8%       1.50 ±153%  perf-sched.sch_delay.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_cleanup_planes
      0.00       +3.7e+100%       0.04 ±191%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      3.10 ± 59%     -60.7%       1.22 ±161%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.20 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.cleaner_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1.64 ± 70%    +909.5%      16.51 ±101%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2.08 ±108%     -37.6%       1.30 ±122%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      3.28 ± 34%     +29.2%       4.24 ± 13%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3.32 ± 27%      -2.9%       3.22 ± 23%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.53 ±209%    +168.8%       1.43 ± 93%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.55 ±194%     +60.5%       0.88 ±201%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      2.77 ± 30%    +150.3%       6.93 ±142%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.40 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.28 ±297%     -99.2%       0.00 ±300%  perf-sched.sch_delay.max.ms.kthreadd.ret_from_fork.ret_from_fork_asm
      3.24 ± 30%     -10.1%       2.91 ± 47%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.63 ± 18%     -14.5%       3.10 ± 33%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      3.25 ± 30%     +14.0%       3.70 ± 27%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      2.83 ± 57%     +81.2%       5.12 ±167%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ±202%     -28.6%       0.00 ±300%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm
      2.67 ±203%     -30.4%       1.86 ±300%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_killable.__kthread_create_on_node
      4.15 ± 10%     +17.7%       4.89 ± 23%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.08 ±106%     -26.8%       0.06 ±115%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      8.41 ±161%     +26.1%      10.61 ± 97%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00 ±299%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
      4.38 ± 45%    +154.3%      11.15 ± 59%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.90 ± 78%    +518.9%      11.77 ± 98%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      2.30 ± 46%     +56.5%       3.60 ±  7%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      3.74 ± 39%     +32.3%       4.95 ± 55%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  4%     +41.1%       0.02 ± 19%  perf-sched.total_sch_delay.average.ms
     13.07 ± 84%    +113.7%      27.94 ± 42%  perf-sched.total_sch_delay.max.ms
     73.81            +1.5%      74.92        perf-sched.total_wait_and_delay.average.ms
     42853            -1.5%      42224        perf-sched.total_wait_and_delay.count.ms
      4899            -0.2%       4892        perf-sched.total_wait_and_delay.max.ms
     73.80            +1.5%      74.90        perf-sched.total_wait_time.average.ms
      4898            -0.2%       4889        perf-sched.total_wait_time.max.ms
     40.85 ±299%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.acpi_ex_allocate_name_string.acpi_ex_get_name_string
      0.00         +1e+104%     100.01 ±300%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.vmstat_start.seq_read_iter
      6.73            -5.2%       6.37 ± 17%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00       +1.4e+103%      14.35 ±299%  perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.00         +5e+103%      50.14 ±300%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.acpi_ut_create_generic_state.acpi_ds_result_push.acpi_ds_exec_end_op
      0.00         +1e+104%     100.02 ±300%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.00       +2.1e+103%      20.74 ±299%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.drm_property_free_blob.drm_gem_destroy_shadow_plane_state.drm_atomic_state_default_clear
      0.00         +3e+104%     300.08 ±152%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
    204.67 ±300%      +0.1%     204.80 ±200%  perf-sched.wait_and_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.00         +2e+104%     204.67 ±200%  perf-sched.wait_and_delay.avg.ms.__cond_resched.refresh_cpu_vm_stats.vmstat_update.process_one_work.worker_thread
      0.00       +5.3e+103%      52.66 ±161%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_read_folio_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages
      0.00       +7.8e+102%       7.84 ±299%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00         +1e+104%     100.06 ±300%  perf-sched.wait_and_delay.avg.ms.__cond_resched.task_work_run.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      0.00       +2.6e+103%      25.66 ±202%  perf-sched.wait_and_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
    271.66 ± 68%     -70.3%      80.71 ±155%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    214.27 ± 86%     -29.6%     150.78 ±104%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    235.93 ±  5%      +1.4%     239.24 ±  5%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00       +7.1e+101%       0.71 ±175%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.24 ±  6%    +311.6%       1.00 ± 46%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.02 ±299%    +545.1%       0.11 ± 45%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.24 ±  6%    +338.2%       1.07 ± 53%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     23.21 ± 50%      -6.7%      21.65 ± 34%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    169.92 ± 16%     -30.1%     118.73 ± 28%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    552.06 ±  5%      +1.1%     558.36 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    370.29 ±  4%      +4.6%     387.38 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    319.32 ±299%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm
    452.79            +0.1%     453.34        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      3.65 ±  2%      -5.4%       3.45 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    121.38            +2.6%     124.58        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    724.27 ±  2%      +1.6%     735.88        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__kmem_cache_alloc_node.__kmalloc.acpi_ex_allocate_name_string.acpi_ex_get_name_string
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.vmstat_start.seq_read_iter
      1344            +0.0%       1344        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00         +7e+101%       0.70 ±300%  perf-sched.wait_and_delay.count.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.acpi_ut_create_generic_state.acpi_ds_result_push.acpi_ds_exec_end_op
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.drm_property_free_blob.drm_gem_destroy_shadow_plane_state.drm_atomic_state_default_clear
      0.00         +3e+101%       0.30 ±152%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      0.10 ±300%    +100.0%       0.20 ±200%  perf-sched.wait_and_delay.count.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.00         +2e+101%       0.20 ±200%  perf-sched.wait_and_delay.count.__cond_resched.refresh_cpu_vm_stats.vmstat_update.process_one_work.worker_thread
      0.00         +4e+101%       0.40 ±165%  perf-sched.wait_and_delay.count.__cond_resched.shmem_get_folio_gfp.shmem_read_folio_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages
      0.00       +1.3e+103%      12.90 ±299%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.__cond_resched.task_work_run.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      0.00       +1.6e+102%       1.60 ±201%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      8.00 ± 50%     -50.0%       4.00 ±122%  perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.40 ± 66%     -18.2%       3.60 ± 81%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    124.30            -0.2%     124.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00       +1.1e+104%     112.40 ±152%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     18268            -4.4%      17455 ±  3%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     28.50 ±300%    +834.4%     266.30 ± 34%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      1595            +1.4%       1617 ±  3%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
    284.40 ± 37%     +95.5%     556.00 ± 36%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    439.20 ± 15%     +50.7%     662.00 ± 30%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     21.30 ±  5%      -1.4%      21.00 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     13.20 ±  7%      -3.8%      12.70 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm
     19.70 ±  3%      +1.0%      19.90        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      1365            +6.3%       1451 ±  5%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     17282            -3.5%      16674 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1249 ±  2%      -1.4%       1231        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     40.85 ±299%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.acpi_ex_allocate_name_string.acpi_ex_get_name_string
      0.00         +1e+104%     100.01 ±300%  perf-sched.wait_and_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.vmstat_start.seq_read_iter
      4899            -8.0%       4506 ± 25%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00         +1e+104%     100.35 ±300%  perf-sched.wait_and_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.00         +5e+103%      50.14 ±300%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.acpi_ut_create_generic_state.acpi_ds_result_push.acpi_ds_exec_end_op
      0.00         +1e+104%     100.02 ±300%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.00       +2.1e+103%      20.74 ±299%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.drm_property_free_blob.drm_gem_destroy_shadow_plane_state.drm_atomic_state_default_clear
      0.00         +3e+104%     300.08 ±152%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
    204.67 ±300%      +0.1%     204.80 ±200%  perf-sched.wait_and_delay.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.00         +2e+104%     204.67 ±200%  perf-sched.wait_and_delay.max.ms.__cond_resched.refresh_cpu_vm_stats.vmstat_update.process_one_work.worker_thread
      0.00       +6.3e+103%      62.80 ±152%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_read_folio_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages
      0.00       +9.3e+102%       9.33 ±300%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00         +1e+104%     100.06 ±300%  perf-sched.wait_and_delay.max.ms.__cond_resched.task_work_run.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      0.00         +2e+104%     200.44 ±200%  perf-sched.wait_and_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
    804.48 ± 50%     -50.2%     400.68 ±122%  perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    702.01 ± 65%     -14.4%     600.63 ± 81%  perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1323 ± 48%     +37.2%       1815 ± 54%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00         +1e+104%     102.23 ±292%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
    128.86 ±226%      +2.2%     131.68 ±219%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.25 ±299%   +1670.4%       4.39 ± 60%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      5.66 ±156%     +54.5%       8.74 ± 54%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
    901.41 ± 33%     +53.9%       1387 ± 83%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1051            +0.8%       1059        perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1007            -0.1%       1006        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    499.87            +0.0%     499.88        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    319.32 ±299%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm
    504.61            +0.1%     505.27        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     20.67 ±122%     +10.5%      22.84 ± 81%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1053           +10.8%       1167 ± 26%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2046            -0.0%       2046        perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.20 ± 25%    +330.8%       0.87 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page
      0.30 ±300%    +166.9%       0.80 ±228%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.wp_page_copy
      0.00       +1.2e+102%       1.19 ±225%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__pud_alloc.alloc_new_pud.constprop
      0.40 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.__do_fault.do_read_fault
      0.00       +4.7e+101%       0.47 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.do_anonymous_page
      2.19 ±124%     -88.6%       0.25 ±299%  perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     40.85 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.acpi_ex_allocate_name_string.acpi_ex_get_name_string
      0.00          +2e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.alloc_cpumask_var_node.__sched_setaffinity
      0.00       +3.1e+101%       0.31 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      0.00 ±300%    +308.3%       0.00 ±200%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      0.00        +3.9e+99%       0.00 ±200%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.single_open.single_open_size
      0.00         +1e+104%     100.01 ±299%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.vmstat_start.seq_read_iter
      6.72            -5.2%       6.37 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.84 ±132%     -63.0%       0.31 ±194%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.15 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.00 ±300%    +327.3%       0.01 ±299%  perf-sched.wait_time.avg.ms.__cond_resched.change_pmd_range.change_p4d_range.change_protection_range.mprotect_fixup
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dentry_kill.dput.step_into.link_path_walk
      0.15 ±154%    +506.7%       0.92 ±112%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.__do_sys_brk
      0.20 ± 41%    +161.6%       0.53 ± 98%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.do_vmi_align_munmap
      0.00        +2.2e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.vma_modify
      0.00       +2.6e+101%       0.26 ±201%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.01 ±204%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.00 ±300%   +1245.2%       0.04 ±299%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      0.05 ±194%    +126.6%       0.12 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.unmap_region
      0.00 ±299%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.07 ±125%     -33.7%       0.05 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
      0.02 ±300%    +723.8%       0.19 ±259%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.do_brk_flags.__do_sys_brk
      0.25 ± 76%    +104.2%       0.51 ±114%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.32 ±194%     -79.5%       0.07 ±248%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.00 ±299%  +12272.7%       0.41 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
      0.21 ±299%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map.load_elf_binary
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map.load_elf_interp
      0.38 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.08 ±198%  +17398.4%      14.54 ±294%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.01 ±122%    +290.4%       0.04 ±282%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.58 ±206%     -99.7%       0.00 ±299%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.00 ±201%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.00 ±299%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
      0.00 ±200%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.20 ±300%   +1341.7%       2.87 ±188%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.00 ±300%   +2110.0%       0.02 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.00       +3.9e+101%       0.39 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.wp_page_copy.__handle_mm_fault
      0.00         +5e+103%      50.14 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.acpi_ut_create_generic_state.acpi_ds_result_push.acpi_ds_exec_end_op
      0.42 ±154%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      0.20 ± 30%    +241.4%       0.68 ±123%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
      0.21 ±128%    +117.3%       0.46 ±137%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.do_brk_flags
      0.16 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
      0.00        +2.4e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.vma_expand
      0.00 ±299%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping.map_vdso
      0.32 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.do_brk_flags.__do_sys_brk
      0.10 ±299%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      0.32 ± 65%     +94.9%       0.62 ±100%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.00       +1.7e+101%       0.17 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
      0.00         +1e+104%     100.01 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.12 ± 94%     -11.6%       0.10 ±152%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.__split_vma
      0.00 ±300%  +24600.0%       0.42 ±250%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.do_brk_flags
      0.00       +2.1e+103%      20.73 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.drm_property_free_blob.drm_gem_destroy_shadow_plane_state.drm_atomic_state_default_clear
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.00 ±200%     -47.7%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
      2.39 ± 81%     -18.7%       1.94 ±100%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.00       +7.7e+100%       0.08 ±299%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.alloc_bprm
      0.00         +3e+104%     300.07 ±152%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
    204.66 ±300%      +0.1%     204.80 ±200%  perf-sched.wait_time.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.00         +2e+104%     204.66 ±200%  perf-sched.wait_time.avg.ms.__cond_resched.refresh_cpu_vm_stats.vmstat_update.process_one_work.worker_thread
      0.20 ±122%    +125.5%       0.44 ±244%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      0.00 ±300%  +1.3e+06%      57.48 ±143%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_read_folio_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages
      0.15 ±300%    +362.8%       0.69 ±202%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.00        +2.8e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
     39.66 ± 14%     +56.8%      62.18 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±106%    +448.4%       0.08 ±146%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      0.04 ± 89%     +47.0%       0.07 ±174%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode
      0.00       +4.6e+100%       0.05 ±271%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00         +1e+104%     100.06 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      0.40 ±295%     -99.0%       0.00 ±209%  perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.28 ± 15%    +483.6%       1.63 ± 48%  perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.constprop
      0.02 ±300%   +1253.6%       0.30 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.unmap_region.constprop
      0.28 ± 28%    +193.3%       0.81 ± 66%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      0.00 ±214%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      5.09 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      0.00       +3.7e+100%       0.04 ±253%  perf-sched.wait_time.avg.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_cleanup_planes
      0.27 ± 29%   +9684.8%      26.29 ±195%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
    271.34 ± 67%     -69.9%      81.76 ±152%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.37 ± 40%     -67.9%       0.76 ±154%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    214.20 ± 86%     -29.4%     151.17 ±104%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    235.79 ±  5%      +1.3%     238.78 ±  5%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      2.94 ±  4%     +30.9%       3.84 ± 85%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00       +2.6e+101%       0.26 ±300%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt
      0.26 ± 22%    +375.6%       1.22 ± 80%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.24 ±  6%    +311.6%       1.00 ± 46%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.13 ± 18%      -9.5%       0.11 ± 29%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.24 ±  6%    +338.2%       1.07 ± 53%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     27.55 ± 36%     -21.7%      21.58 ± 34%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.73 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.00 ±300%  +32366.7%       0.39 ±300%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
    169.88 ± 16%     -30.1%     118.71 ± 28%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    551.67 ±  5%      +1.2%     558.07 ±  2%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    370.03 ±  4%      +4.6%     386.92 ±  3%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    319.32 ±299%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm
      0.01 ±122%      +6.5%       0.01 ±123%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr
      2.65 ± 10%     +17.7%       3.12 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    452.77            +0.1%     453.32        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.18 ±300%    +102.3%       0.36 ±299%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      3.63            -5.5%       3.43 ±  5%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    121.37            +2.6%     124.56        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.83 ± 19%     -71.1%       1.11 ±123%  perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.44 ± 43%     -21.7%       0.34 ± 40%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    724.24 ±  2%      +1.6%     735.84        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.83 ± 62%    +573.9%       5.62 ± 59%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page
      0.30 ±300%    +166.9%       0.80 ±228%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.wp_page_copy
      0.00       +1.2e+102%       1.19 ±225%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__pud_alloc.alloc_new_pud.constprop
      0.40 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.pte_alloc_one.__do_fault.do_read_fault
      0.00       +8.8e+101%       0.88 ±300%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.do_anonymous_page
      2.19 ±124%     -77.3%       0.50 ±300%  perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     40.85 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.acpi_ex_allocate_name_string.acpi_ex_get_name_string
      0.00          +2e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.alloc_cpumask_var_node.__sched_setaffinity
      0.00       +5.5e+101%       0.55 ±300%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      0.00 ±300%    +104.2%       0.00 ±200%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      0.00        +3.9e+99%       0.00 ±200%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.single_open.single_open_size
      0.00         +1e+104%     100.01 ±299%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.vmstat_start.seq_read_iter
      4898            -8.1%       4504 ± 25%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.84 ±132%     -63.0%       0.31 ±194%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.15 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.00 ±300%   +1100.0%       0.03 ±300%  perf-sched.wait_time.max.ms.__cond_resched.change_pmd_range.change_p4d_range.change_protection_range.mprotect_fixup
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dentry_kill.dput.step_into.link_path_walk
      0.16 ±148%    +731.9%       1.33 ±146%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.__do_sys_brk
      0.52 ± 53%    +238.0%       1.75 ±108%  perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.do_vmi_align_munmap
      0.00        +2.2e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.vma_modify
      0.00       +2.9e+101%       0.29 ±178%  perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.01 ±212%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.00 ±300%   +1245.2%       0.04 ±299%  perf-sched.wait_time.max.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      0.06 ±199%    +321.8%       0.24 ±258%  perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.unmap_region
      0.00 ±299%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.08 ±119%     -37.4%       0.05 ±300%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
      0.02 ±300%    +763.4%       0.20 ±247%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.do_brk_flags.__do_sys_brk
      0.48 ±115%     +96.0%       0.94 ± 98%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.32 ±192%     -12.3%       0.28 ±276%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.00 ±299%  +12272.7%       0.41 ±300%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
      0.21 ±299%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map.load_elf_binary
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map.load_elf_interp
      0.38 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.14 ±230%  +71629.0%     101.64 ±294%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.01 ±122%    +290.4%       0.04 ±282%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.58 ±206%     -99.7%       0.00 ±299%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.00 ±201%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.00 ±299%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
      0.00 ±200%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.40 ±300%    +961.6%       4.23 ±219%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.00 ±300%   +4310.0%       0.04 ±300%  perf-sched.wait_time.max.ms.__cond_resched.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.00       +3.9e+101%       0.39 ±300%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.wp_page_copy.__handle_mm_fault
      0.00         +5e+103%      50.14 ±300%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.acpi_ut_create_generic_state.acpi_ds_result_push.acpi_ds_exec_end_op
      0.42 ±154%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      0.53 ±101%    +124.1%       1.19 ± 90%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
      0.28 ±154%    +291.2%       1.11 ±157%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.do_brk_flags
      0.16 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
      0.00        +2.4e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.vma_expand
      0.00 ±299%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping.map_vdso
      0.32 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.do_brk_flags.__do_sys_brk
      0.10 ±299%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      1.20 ± 83%     +66.0%       2.00 ±101%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.00       +1.7e+101%       0.17 ±300%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
      0.00         +1e+104%     100.01 ±300%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.12 ± 92%     -16.6%       0.10 ±152%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.__split_vma
      0.00 ±300%  +38405.9%       0.65 ±244%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.do_brk_flags
      0.00       +2.1e+103%      20.73 ±300%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.drm_property_free_blob.drm_gem_destroy_shadow_plane_state.drm_atomic_state_default_clear
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.00 ±200%     -47.7%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
      2.39 ± 81%     -18.7%       1.94 ±100%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.00       +4.6e+101%       0.46 ±300%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.alloc_bprm
      0.00         +3e+104%     300.07 ±152%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
    204.66 ±300%      +0.1%     204.80 ±200%  perf-sched.wait_time.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.00         +2e+104%     204.66 ±200%  perf-sched.wait_time.max.ms.__cond_resched.refresh_cpu_vm_stats.vmstat_update.process_one_work.worker_thread
      0.32 ±126%     +45.0%       0.46 ±237%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      0.00 ±300%  +1.6e+06%      73.17 ±128%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_read_folio_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages
      0.30 ±300%    +244.1%       1.02 ±220%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.00        +2.8e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
     86.01 ±  6%      +5.5%      90.72 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.75 ±105%     +80.5%       3.16 ±114%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      0.10 ±100%    +248.6%       0.35 ±258%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode
      0.00       +4.6e+100%       0.05 ±271%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00         +1e+104%     100.06 ±300%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      0.40 ±295%     -98.7%       0.01 ±200%  perf-sched.wait_time.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      2.03 ± 23%    +227.5%       6.66 ± 48%  perf-sched.wait_time.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.constprop
      0.02 ±300%   +1253.6%       0.30 ±300%  perf-sched.wait_time.max.ms.__cond_resched.unmap_page_range.unmap_vmas.unmap_region.constprop
      1.59 ± 53%    +153.9%       4.04 ± 57%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      0.00 ±200%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      5.09 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      0.00       +3.7e+100%       0.04 ±253%  perf-sched.wait_time.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_cleanup_planes
      1.18 ± 46%  +17108.0%     202.73 ±197%  perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
    802.26 ± 49%     -49.8%     402.51 ±120%  perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.73 ± 40%     -67.8%       1.52 ±154%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    702.00 ± 65%     -14.3%     601.71 ± 81%  perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1321 ± 48%     +37.2%       1813 ± 54%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      6.90 ±  9%   +1483.8%     109.24 ±272%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00       +2.6e+101%       0.26 ±300%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt
      2.33 ± 39%   +4436.5%     105.58 ±282%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
    128.51 ±225%      +2.5%     131.68 ±219%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      2.44 ± 12%     +89.7%       4.63 ± 50%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      5.66 ±156%     +54.5%       8.74 ± 54%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      1000           +38.5%       1386 ± 83%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1.41 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.00 ±300%  +16133.3%       0.39 ±300%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      1051            +0.8%       1059        perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1004            -0.0%       1003        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    499.84            +0.0%     499.86        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    319.32 ±299%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm
      0.01 ±122%      +4.8%       0.01 ±123%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr
      8.87 ±  6%     +50.9%      13.38 ± 50%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    504.57            +0.1%     505.25        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.18 ±300%    +102.3%       0.36 ±299%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
     14.61 ± 99%      +0.9%      14.74 ± 73%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1053           +10.8%       1167 ± 26%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      7.67 ± 19%     -71.1%       2.22 ±123%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      3.55 ± 12%     +13.4%       4.03 ± 29%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      2046            +0.0%       2046        perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm

xsang@inn:~$

--p/yrhrNiooBtE2cS
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: attachment; filename="ncompare-file-ioctl"
Content-Transfer-Encoding: 8bit


xsang@inn:~$ lkp ncompare -s commit=1f4f7f0f8845d/tbox_group=lkp-skl-d08/testcase=stress-ng -o commit=6ccdcb6d3a741  -a | grep -v interrupts | grep -v softirq
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1SSD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/file-ioctl/stress-ng/60s

commit:
  1f4f7f0f8845dbac40289cc3d50b81314c5a12b8
  6ccdcb6d3a741c4e005ca6ffd4a62ddf8b5bead3

1f4f7f0f8845dbac 6ccdcb6d3a741c4e005ca6ffd4a
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
     10.99            +0.0%      10.99        kmsg.timestamp:EDAC_skx:ECC_is_disabled_on_imc
     75.12            +2.0%      76.60 ±  3%  kmsg.timestamp:last
     26.34 ±  2%      +5.6%      27.82 ± 10%  kmsg.timestamp:x86/PAT:bmc-watchdog:#map_pfn_expected_mapping_type_uncached-minus_for[mem#-#],got_write-back
     75.12            +2.0%      76.60 ±  3%  dmesg.timestamp:last
 2.143e+09            +5.1%  2.252e+09 ±  9%  cpuidle..time
   3124995            +3.6%    3237684 ±  7%  cpuidle..usage
     91.83            +5.0%      96.44 ±  7%  uptime.boot
      3043            +5.3%       3205 ±  8%  uptime.idle
     24.14            -0.2%      24.08        boot-time.boot
     10.14            -0.3%      10.11        boot-time.dhcp
    826.15            -0.3%     823.94        boot-time.idle
     12.62 ± 40%     +17.2%      14.80 ± 44%  perf-c2c.DRAM.local
    130.38 ± 10%     +26.7%     165.20 ± 16%  perf-c2c.HITM.local
    130.38 ± 10%     +26.7%     165.20 ± 16%  perf-c2c.HITM.total
     91.17            +0.2%      91.37        iostat.cpu.idle
      0.05           +39.9%       0.07 ± 38%  iostat.cpu.iowait
      8.11            -1.8%       7.96 ±  5%  iostat.cpu.system
      0.67 ±  3%     -11.3%       0.59 ± 14%  iostat.cpu.user
     90.99            +0.2       91.21        mpstat.cpu.all.idle%
      0.05            +0.0        0.07 ± 38%  mpstat.cpu.all.iowait%
      0.79 ±  3%      +0.1        0.87 ± 20%  mpstat.cpu.all.irq%
      0.04 ±  5%      +0.0        0.05 ± 20%  mpstat.cpu.all.soft%
      7.48            -0.2        7.23 ±  8%  mpstat.cpu.all.sys%
      0.65 ±  3%      -0.1        0.58 ± 14%  mpstat.cpu.all.usr%
     62.04            +0.0%      62.04        time.elapsed_time
     62.04            +0.0%      62.04        time.elapsed_time.max
      2112            +0.0%       2112        time.file_system_inputs
     96.00            +0.0%      96.00        time.file_system_outputs
      6184 ±  7%     -23.0%       4761 ±  5%  time.involuntary_context_switches
      0.62 ±210%     -52.0%       0.30 ±213%  time.major_page_faults
      6912            +0.0%       6912        time.maximum_resident_set_size
      9509            -0.1%       9496        time.minor_page_faults
      4096            +0.0%       4096        time.page_size
    286.00            +0.0%     286.00        time.percent_of_cpu_this_job_got
    172.84            +0.3%     173.27        time.system_time
      4.68            -8.0%       4.31        time.user_time
    123062 ±  5%      -8.5%     112627 ±  5%  time.voluntary_context_switches
     91.20            +0.2%      91.42        vmstat.cpu.id
      8.25            -2.1%       8.08 ±  5%  vmstat.cpu.sy
      0.49 ±  5%     -12.7%       0.43 ± 20%  vmstat.cpu.us
      0.05 ± 13%     +32.8%       0.07 ± 36%  vmstat.cpu.wa
     15.91            -3.6%      15.33 ±  8%  vmstat.io.bi
      6.65 ± 76%     +49.4%       9.93 ± 69%  vmstat.io.bo
      1034            +0.1%       1035        vmstat.memory.buff
   2954092            -0.0%    2953196        vmstat.memory.cache
  28985158            +0.0%   28997431        vmstat.memory.free
      0.02 ± 77%     +79.8%       0.03 ± 55%  vmstat.procs.b
      3.19 ±  2%      -3.3%       3.08 ±  8%  vmstat.procs.r
     33719            -4.5%      32188 ±  7%  vmstat.system.cs
     51824            -1.1%      51271 ±  2%  vmstat.system.in
    340971            -6.9%     317411        stress-ng.file-ioctl.ops
      5682            -6.9%       5290        stress-ng.file-ioctl.ops_per_sec
     62.04            +0.0%      62.04        stress-ng.time.elapsed_time
     62.04            +0.0%      62.04        stress-ng.time.elapsed_time.max
      2112            +0.0%       2112        stress-ng.time.file_system_inputs
     96.00            +0.0%      96.00        stress-ng.time.file_system_outputs
      6184 ±  7%     -23.0%       4761 ±  5%  stress-ng.time.involuntary_context_switches
      0.62 ±210%     -52.0%       0.30 ±213%  stress-ng.time.major_page_faults
      6912            +0.0%       6912        stress-ng.time.maximum_resident_set_size
      9509            -0.1%       9496        stress-ng.time.minor_page_faults
      4096            +0.0%       4096        stress-ng.time.page_size
    286.00            +0.0%     286.00        stress-ng.time.percent_of_cpu_this_job_got
    172.84            +0.3%     173.27        stress-ng.time.system_time
      4.68            -8.0%       4.31        stress-ng.time.user_time
    123062 ±  5%      -8.5%     112627 ±  5%  stress-ng.time.voluntary_context_switches
    357.50            -3.4%     345.30 ±  6%  turbostat.Avg_MHz
      9.56            -0.2        9.38 ±  3%  turbostat.Busy%
      3740            -1.8%       3672 ±  3%  turbostat.Bzy_MHz
     61848            -0.6%      61459        turbostat.C1
      0.14 ±  6%      +0.0        0.14 ± 10%  turbostat.C1%
    926012            -0.1%     924627        turbostat.C1E
      2.70            -0.1        2.58 ±  6%  turbostat.C1E%
   2097927            +5.4%    2211048 ± 10%  turbostat.C6
     87.94            +0.4       88.29        turbostat.C6%
     88.61            -1.3%      87.45 ±  3%  turbostat.CPU%c1
      1.83 ± 21%     +72.6%       3.16 ± 95%  turbostat.CPU%c6
     34.12            +4.9%      35.80 ±  3%  turbostat.CoreTmp
      0.43            -2.7%       0.42 ±  2%  turbostat.IPC
   3473046            +3.2%    3585079 ±  6%  turbostat.IRQ
     35417 ±  9%      +3.2%      36563 ±  9%  turbostat.POLL
      0.00 ±264%      -0.0        0.00        turbostat.POLL%
      1.58 ± 24%     +59.7%       2.53 ± 95%  turbostat.Pkg%pc2
     33.75 ±  3%      +3.4%      34.90 ±  2%  turbostat.PkgTmp
     87.13            -2.7%      84.80 ±  5%  turbostat.PkgWatt
      0.86            +1.5%       0.87        turbostat.RAMWatt
      3001            -0.0%       3000        turbostat.TSC_MHz
     69867            -0.7%      69398 ±  5%  meminfo.Active
     66909            -0.6%      66489 ±  5%  meminfo.Active(anon)
      2958            -1.7%       2908 ±  6%  meminfo.Active(file)
     55351 ±  9%     +11.3%      61587 ± 17%  meminfo.AnonHugePages
    297646            -0.3%     296691        meminfo.AnonPages
      1034            +0.1%       1035        meminfo.Buffers
   2874923            -0.0%    2873986        meminfo.Cached
  16281020            +0.0%   16281020        meminfo.CommitLimit
    566106            -1.1%     559898        meminfo.Committed_AS
  27525120 ±  3%      -0.2%   27472691 ±  3%  meminfo.DirectMap1G
   5554944 ± 18%      +1.0%    5609062 ± 16%  meminfo.DirectMap2M
    166176 ±  7%      -1.0%     164486 ± 11%  meminfo.DirectMap4k
     62.51 ± 16%     -10.6%      55.88        meminfo.Dirty
      2048            +0.0%       2048        meminfo.Hugepagesize
    307749            -0.5%     306284        meminfo.Inactive
    305087            -0.5%     303694        meminfo.Inactive(anon)
      2662 ±  2%      -2.7%       2589 ±  3%  meminfo.Inactive(file)
     78478            +0.1%      78579        meminfo.KReclaimable
      9050            +0.3%       9075        meminfo.KernelStack
     41083            -1.2%      40591 ±  2%  meminfo.Mapped
  28759154            +0.0%   28770515        meminfo.MemAvailable
  28981905            +0.0%   28993284        meminfo.MemFree
  32562044            +0.0%   32562044        meminfo.MemTotal
   3580138            -0.3%    3568759        meminfo.Memused
     10.86            -3.3%      10.50 ±  8%  meminfo.Mlocked
      5273            -1.0%       5220 ±  2%  meminfo.PageTables
     16259            -0.0%      16253        meminfo.Percpu
     78478            +0.1%      78579        meminfo.SReclaimable
     90009            +0.3%      90246        meminfo.SUnreclaim
     74602            -1.1%      73789 ±  4%  meminfo.Shmem
    168487            +0.2%     168825        meminfo.Slab
   2795729            -0.0%    2795724        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
     20749            +0.2%      20783        meminfo.VmallocUsed
      0.77 ±200%      -6.4%       0.73 ±134%  meminfo.Writeback
   3758317            +0.1%    3762244        meminfo.max_used_kB
     70.38 ±  8%      -3.2%      68.10 ± 13%  proc-vmstat.direct_map_level2_splits
      2.75 ± 35%     -20.0%       2.20 ± 34%  proc-vmstat.direct_map_level3_splits
     16707            -0.5%      16622 ±  5%  proc-vmstat.nr_active_anon
    740.83            -1.9%     727.11 ±  6%  proc-vmstat.nr_active_file
     74446            -0.4%      74173        proc-vmstat.nr_anon_pages
     26.99 ±  9%     +11.4%      30.07 ± 17%  proc-vmstat.nr_anon_transparent_hugepages
    148.88 ± 65%     +53.4%     228.40 ± 86%  proc-vmstat.nr_dirtied
     15.63 ± 16%     -10.6%      13.97        proc-vmstat.nr_dirty
    717010            +0.0%     717280        proc-vmstat.nr_dirty_background_threshold
   1435774            +0.0%    1436316        proc-vmstat.nr_dirty_threshold
    718972            -0.0%     718748        proc-vmstat.nr_file_pages
      0.00         +1e+101%       0.10 ±300%  proc-vmstat.nr_foll_pin_acquired
      0.00         +1e+101%       0.10 ±300%  proc-vmstat.nr_foll_pin_released
   7245424            +0.0%    7248168        proc-vmstat.nr_free_pages
     76303            -0.5%      75925        proc-vmstat.nr_inactive_anon
    662.04 ±  3%      -3.0%     642.06 ±  3%  proc-vmstat.nr_inactive_file
      9051            +0.3%       9076        proc-vmstat.nr_kernel_stack
     10282            -1.3%      10149 ±  2%  proc-vmstat.nr_mapped
      2.72            -3.5%       2.62 ±  8%  proc-vmstat.nr_mlock
      1318            -1.0%       1305 ±  2%  proc-vmstat.nr_page_table_pages
     18634            -1.0%      18448 ±  4%  proc-vmstat.nr_shmem
     19618            +0.1%      19644        proc-vmstat.nr_slab_reclaimable
     22503            +0.3%      22561        proc-vmstat.nr_slab_unreclaimable
    698932            -0.0%     698931        proc-vmstat.nr_unevictable
      0.19 ±200%      -6.4%       0.18 ±134%  proc-vmstat.nr_writeback
    122.62 ± 66%     +55.4%     190.60 ± 76%  proc-vmstat.nr_written
     16707            -0.5%      16622 ±  5%  proc-vmstat.nr_zone_active_anon
    740.83            -1.9%     727.11 ±  6%  proc-vmstat.nr_zone_active_file
     76303            -0.5%      75925        proc-vmstat.nr_zone_inactive_anon
    662.04 ±  3%      -3.0%     642.06 ±  3%  proc-vmstat.nr_zone_inactive_file
    698932            -0.0%     698931        proc-vmstat.nr_zone_unevictable
     15.58 ± 15%      -9.5%      14.09 ±  2%  proc-vmstat.nr_zone_write_pending
  89530411            -7.1%   83208879        proc-vmstat.numa_hit
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
  89301961            -7.0%   83009577        proc-vmstat.numa_local
     26399            -2.7%      25675        proc-vmstat.pgactivate
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
  93091135            -6.9%   86691043        proc-vmstat.pgalloc_normal
      0.00          -100.0%       0.00        proc-vmstat.pgdeactivate
    212409            +1.2%     215026 ±  3%  proc-vmstat.pgfault
  93049512            -6.9%   86647969        proc-vmstat.pgfree
      1056            +0.0%       1056        proc-vmstat.pgpgin
    440.00 ± 76%     +65.1%     726.40 ± 77%  proc-vmstat.pgpgout
      8496            +2.4%       8699 ±  4%  proc-vmstat.pgreuse
      0.00          -100.0%       0.00        proc-vmstat.pgrotated
     46.75 ±  4%      +9.1%      51.00 ± 11%  proc-vmstat.thp_collapse_alloc
      0.00          -100.0%       0.00        proc-vmstat.thp_deferred_split_page
      1.50 ± 74%     -46.7%       0.80 ± 93%  proc-vmstat.thp_fault_alloc
      0.00          -100.0%       0.00        proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
     14.00            +0.0%      14.00        proc-vmstat.unevictable_pgs_culled
      3.00            +0.0%       3.00        proc-vmstat.unevictable_pgs_mlocked
      3.00            +0.0%       3.00        proc-vmstat.unevictable_pgs_munlocked
      0.13 ± 62%    +299.7%       0.51 ±132%  perf-stat.i.MPKI
 3.868e+09            -6.1%  3.632e+09 ±  8%  perf-stat.i.branch-instructions
      0.69 ± 17%      +0.6        1.26 ± 85%  perf-stat.i.branch-miss-rate%
  21656746 ±  2%      -7.3%   20079062 ±  9%  perf-stat.i.branch-misses
      1.38 ± 12%      +0.2        1.61 ± 23%  perf-stat.i.cache-miss-rate%
   1243295 ± 18%     +17.9%    1465860 ±  9%  perf-stat.i.cache-misses
 2.181e+08 ±  2%      +0.5%  2.192e+08 ±  7%  perf-stat.i.cache-references
     35135            -4.7%      33477 ±  8%  perf-stat.i.context-switches
      0.74 ± 12%     +67.7%       1.24 ± 71%  perf-stat.i.cpi
     36006            -0.0%      36004        perf-stat.i.cpu-clock
 1.247e+10            -3.6%  1.203e+10 ±  6%  perf-stat.i.cpu-cycles
     65.35            -1.7%      64.26 ±  4%  perf-stat.i.cpu-migrations
     24611 ± 31%     -29.1%      17449 ± 17%  perf-stat.i.cycles-between-cache-misses
      0.02 ± 68%      +0.1        0.08 ±143%  perf-stat.i.dTLB-load-miss-rate%
    311590 ±  2%      +4.9%     326828 ± 14%  perf-stat.i.dTLB-load-misses
 4.523e+09            -6.5%  4.227e+09 ±  8%  perf-stat.i.dTLB-loads
      0.00 ± 92%      +0.0        0.01 ±149%  perf-stat.i.dTLB-store-miss-rate%
      9906 ±  6%     +34.2%      13292 ± 45%  perf-stat.i.dTLB-store-misses
 2.698e+09            -6.0%  2.536e+09 ±  8%  perf-stat.i.dTLB-stores
     23.04 ±  4%      +1.5       24.52 ± 17%  perf-stat.i.iTLB-load-miss-rate%
    338747 ± 21%      -9.7%     305803 ± 14%  perf-stat.i.iTLB-load-misses
   1150637 ± 14%      -9.2%    1044691 ±  8%  perf-stat.i.iTLB-loads
 1.885e+10            -5.9%  1.775e+10 ±  8%  perf-stat.i.instructions
     57534 ± 14%      +1.4%      58352 ± 11%  perf-stat.i.instructions-per-iTLB-miss
      1.50            -5.5%       1.41 ±  8%  perf-stat.i.ipc
      0.28 ± 54%     +75.9%       0.49 ± 22%  perf-stat.i.major-faults
      0.35            -3.6%       0.33 ±  6%  perf-stat.i.metric.GHz
     68.15 ± 26%    +110.8%     143.65 ± 93%  perf-stat.i.metric.K/sec
    314.01            -6.2%     294.69 ±  8%  perf-stat.i.metric.M/sec
      1925            -3.0%       1867 ±  4%  perf-stat.i.minor-faults
    109386 ± 22%      -3.9%     105144 ±  7%  perf-stat.i.node-loads
    166651 ± 31%     +85.0%     308368 ±  4%  perf-stat.i.node-stores
      1925            -3.0%       1868 ±  4%  perf-stat.i.page-faults
     36006            -0.0%      36004        perf-stat.i.task-clock
      0.07 ± 19%     +26.7%       0.08 ± 16%  perf-stat.overall.MPKI
      0.56 ±  2%      -0.0        0.55 ±  8%  perf-stat.overall.branch-miss-rate%
      0.57 ± 20%      +0.1        0.67 ± 14%  perf-stat.overall.cache-miss-rate%
      0.66            +2.6%       0.68        perf-stat.overall.cpi
     10338 ± 15%     -19.7%       8301 ± 13%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  2%      +0.0        0.01 ± 24%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  7%      +0.0        0.00 ± 55%  perf-stat.overall.dTLB-store-miss-rate%
     22.61 ±  3%      +0.0       22.64 ± 10%  perf-stat.overall.iTLB-load-miss-rate%
     57455 ± 14%      +2.2%      58724 ± 11%  perf-stat.overall.instructions-per-iTLB-miss
      1.51            -2.5%       1.47        perf-stat.overall.ipc
 3.808e+09            -6.1%  3.578e+09 ±  8%  perf-stat.ps.branch-instructions
  21311538 ±  2%      -7.2%   19773267 ±  9%  perf-stat.ps.branch-misses
   1223635 ± 18%     +18.0%    1443696 ±  9%  perf-stat.ps.cache-misses
 2.148e+08 ±  2%      +0.5%  2.159e+08 ±  6%  perf-stat.ps.cache-references
     34590            -4.7%      32976 ±  7%  perf-stat.ps.context-switches
     35446            +0.1%      35466        perf-stat.ps.cpu-clock
 1.228e+10            -3.5%  1.185e+10 ±  6%  perf-stat.ps.cpu-cycles
     64.33            -1.6%      63.29 ±  3%  perf-stat.ps.cpu-migrations
    306740 ±  2%      +5.0%     321949 ± 14%  perf-stat.ps.dTLB-load-misses
 4.453e+09            -6.5%  4.164e+09 ±  8%  perf-stat.ps.dTLB-loads
      9745 ±  6%     +34.3%      13089 ± 45%  perf-stat.ps.dTLB-store-misses
 2.656e+09            -5.9%  2.498e+09 ±  8%  perf-stat.ps.dTLB-stores
    333519 ± 21%      -9.7%     301231 ± 14%  perf-stat.ps.iTLB-load-misses
   1132855 ± 14%      -9.2%    1029084 ±  8%  perf-stat.ps.iTLB-loads
 1.856e+10            -5.8%  1.748e+10 ±  8%  perf-stat.ps.instructions
      0.28 ± 54%     +76.0%       0.48 ± 22%  perf-stat.ps.major-faults
      1894            -2.9%       1838 ±  4%  perf-stat.ps.minor-faults
    107669 ± 22%      -3.8%     103537 ±  7%  perf-stat.ps.node-loads
    164076 ± 31%     +85.2%     303821 ±  4%  perf-stat.ps.node-stores
      1894            -2.9%       1839 ±  4%  perf-stat.ps.page-faults
     35446            +0.1%      35466        perf-stat.ps.task-clock
 1.201e+12            -2.2%  1.175e+12        perf-stat.total.instructions
      9668 ± 38%     +21.7%      11761        sched_debug.cfs_rq:/.avg_vruntime.avg
     73804 ± 37%     +22.9%      90724 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.max
    761.77 ± 37%     +36.5%       1039 ± 20%  sched_debug.cfs_rq:/.avg_vruntime.min
     15647 ± 39%     +24.9%      19545 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.34 ± 22%     -18.3%       0.27 ±  6%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.44 ± 47%     -20.0%       1.15 ± 19%  sched_debug.cfs_rq:/.h_nr_running.max
      0.48 ± 15%      -9.2%       0.43 ±  5%  sched_debug.cfs_rq:/.h_nr_running.stddev
     19.19 ±141%    +560.7%     126.76 ±184%  sched_debug.cfs_rq:/.left_vruntime.avg
    549.96 ±132%    +700.5%       4402 ±189%  sched_debug.cfs_rq:/.left_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.left_vruntime.min
     94.06 ±133%    +671.5%     725.66 ±189%  sched_debug.cfs_rq:/.left_vruntime.stddev
     40431 ± 59%     -19.3%      32628 ± 34%  sched_debug.cfs_rq:/.load.avg
    664217 ±106%     -50.6%     327942 ± 70%  sched_debug.cfs_rq:/.load.max
    133230 ± 85%     -35.2%      86300 ± 54%  sched_debug.cfs_rq:/.load.stddev
      5030 ± 34%     -20.8%       3981 ±  3%  sched_debug.cfs_rq:/.load_avg.avg
     14574 ± 32%     -20.9%      11525 ±  3%  sched_debug.cfs_rq:/.load_avg.max
      1.06 ±197%     -10.6%       0.95 ±162%  sched_debug.cfs_rq:/.load_avg.min
      6600 ± 34%     -21.3%       5193 ±  2%  sched_debug.cfs_rq:/.load_avg.stddev
      9668 ± 38%     +21.7%      11761        sched_debug.cfs_rq:/.min_vruntime.avg
     73804 ± 37%     +22.9%      90727 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
    761.77 ± 37%     +36.5%       1039 ± 20%  sched_debug.cfs_rq:/.min_vruntime.min
     15647 ± 39%     +24.9%      19545 ±  4%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.34 ± 22%     -18.3%       0.27 ±  6%  sched_debug.cfs_rq:/.nr_running.avg
      1.44 ± 47%     -20.0%       1.15 ± 19%  sched_debug.cfs_rq:/.nr_running.max
      0.48 ± 15%      -9.2%       0.43 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
     24.80 ± 79%     +82.3%      45.20 ± 59%  sched_debug.cfs_rq:/.removed.load_avg.avg
    637.94 ± 53%     -11.9%     562.10 ± 49%  sched_debug.cfs_rq:/.removed.load_avg.max
    120.18 ± 63%     +20.1%     144.33 ± 49%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      7.66 ± 68%    +140.4%      18.41 ± 64%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    270.06 ± 66%      -1.4%     266.15 ± 57%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     44.38 ± 66%     +36.4%      60.54 ± 56%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      7.65 ± 68%    +140.5%      18.41 ± 64%  sched_debug.cfs_rq:/.removed.util_avg.avg
    269.94 ± 66%      -1.4%     266.10 ± 57%  sched_debug.cfs_rq:/.removed.util_avg.max
     44.36 ± 66%     +36.5%      60.53 ± 56%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     19.19 ±141%    +560.6%     126.76 ±184%  sched_debug.cfs_rq:/.right_vruntime.avg
    550.03 ±132%    +700.4%       4402 ±189%  sched_debug.cfs_rq:/.right_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.right_vruntime.min
     94.07 ±133%    +671.4%     725.66 ±189%  sched_debug.cfs_rq:/.right_vruntime.stddev
    480.62 ± 26%     -15.5%     406.33 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
      1462 ± 15%     -10.4%       1310 ±  9%  sched_debug.cfs_rq:/.runnable_avg.max
     16.62 ±140%     -39.5%      10.05 ±180%  sched_debug.cfs_rq:/.runnable_avg.min
    373.33 ± 16%     -11.4%     330.95 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
      0.00 ±228%    -100.0%       0.00        sched_debug.cfs_rq:/.spread.avg
      0.07 ±228%    -100.0%       0.00        sched_debug.cfs_rq:/.spread.max
      0.01 ±228%    -100.0%       0.00        sched_debug.cfs_rq:/.spread.stddev
    476.46 ± 26%     -15.4%     403.03 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
      1454 ± 15%     -10.4%       1303 ±  9%  sched_debug.cfs_rq:/.util_avg.max
     15.75 ±142%     -42.9%       9.00 ±201%  sched_debug.cfs_rq:/.util_avg.min
    371.95 ± 16%     -11.4%     329.56 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
     83.12 ± 15%      -5.3%      78.72 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    836.69 ±  3%      -0.7%     830.70 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.max
    215.18 ± 12%      +1.9%     219.21 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    577964 ± 14%      +5.2%     608099 ±  3%  sched_debug.cpu.avg_idle.avg
    985615 ±  2%      +0.2%     988020 ±  2%  sched_debug.cpu.avg_idle.max
     28127 ±134%     -81.3%       5250 ± 49%  sched_debug.cpu.avg_idle.min
    274888 ± 10%      +7.8%     296303 ±  4%  sched_debug.cpu.avg_idle.stddev
     48833 ± 26%     +18.4%      57815 ±  5%  sched_debug.cpu.clock.avg
     48834 ± 26%     +18.4%      57817 ±  5%  sched_debug.cpu.clock.max
     48832 ± 26%     +18.4%      57814 ±  5%  sched_debug.cpu.clock.min
      0.80 ±  6%      +3.2%       0.82 ±  9%  sched_debug.cpu.clock.stddev
     48639 ± 25%     +18.3%      57562 ±  5%  sched_debug.cpu.clock_task.avg
     48681 ± 25%     +18.3%      57610 ±  5%  sched_debug.cpu.clock_task.max
     48275 ± 26%     +18.5%      57194 ±  5%  sched_debug.cpu.clock_task.min
     74.28 ±  8%      +6.2%      78.89 ±  2%  sched_debug.cpu.clock_task.stddev
    972.91 ± 15%      -9.7%     878.68 ±  9%  sched_debug.cpu.curr->pid.avg
      3815 ±  7%      +4.4%       3984        sched_debug.cpu.curr->pid.max
      1478 ±  2%      -1.4%       1457        sched_debug.cpu.curr->pid.stddev
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.avg
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.max
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
      4294            +0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            +0.0%       4294        sched_debug.cpu.next_balance.max
      4294            +0.0%       4294        sched_debug.cpu.next_balance.min
      0.00 ± 19%      -6.3%       0.00 ± 21%  sched_debug.cpu.next_balance.stddev
      0.32 ± 21%     -14.4%       0.28 ±  8%  sched_debug.cpu.nr_running.avg
      1.44 ± 47%     -20.0%       1.15 ± 19%  sched_debug.cpu.nr_running.max
      0.47 ± 15%      -8.9%       0.43 ±  4%  sched_debug.cpu.nr_running.stddev
     28149 ± 48%     +26.3%      35546        sched_debug.cpu.nr_switches.avg
    117924 ± 41%     +26.2%     148828 ± 16%  sched_debug.cpu.nr_switches.max
      1171 ± 52%     +24.6%       1459 ± 38%  sched_debug.cpu.nr_switches.min
     27983 ± 44%     +25.6%      35144 ± 15%  sched_debug.cpu.nr_switches.stddev
      0.00 ±264%     -20.0%       0.00 ±300%  sched_debug.cpu.nr_uninterruptible.avg
     18.56 ± 30%     +11.5%      20.70 ± 16%  sched_debug.cpu.nr_uninterruptible.max
    -12.56            -3.3%     -12.15        sched_debug.cpu.nr_uninterruptible.min
      6.74 ± 19%      +0.4%       6.77 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
     48832 ± 26%     +18.4%      57814 ±  5%  sched_debug.cpu_clk
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            +0.0%  4.295e+09        sched_debug.jiffies
     48753 ± 26%     +18.4%      57735 ±  5%  sched_debug.ktime
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.avg
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.max
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.min
     48853 ± 26%     +18.4%      57835 ±  5%  sched_debug.sched_clk
      1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
      3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_base_slice
  25056823            +0.0%   25056823        sched_debug.sysctl_sched.sysctl_sched_features
      1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      0.00 ±264%    +416.0%       0.01 ±178%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.folio_alloc.do_read_cache_folio.vfs_dedupe_file_range_compare
      0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space
      0.00        +1.5e+99%       0.00 ±161%  perf-sched.sch_delay.avg.ms.__cond_resched.__flush_work.isra.0.__lru_add_drain_all
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.btrfs_alloc_block_rsv.btrfs_replace_file_extents
      0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.btrfs_fallocate.vfs_fallocate
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.00          +9e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.00          +6e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.00 ±264%    +140.0%       0.00 ±152%  perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_replace_extent.btrfs_replace_file_extents
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.flush_memcg_stats_dwork
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      0.02 ±259%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.find_free_extent.btrfs_reserve_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
      0.17 ±262%     -99.8%       0.00 ±165%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_clone_files
      0.00        +7.3e+99%       0.01 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_do_readpage
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_extent_same_range
      0.00       +1.3e+100%       0.01 ±297%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_invalidate_folio
      0.00 ±264%     +60.0%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_replace_file_extents
      0.00 ±264%     -73.3%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.set_extent_bit
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_drop_extent_map_range.btrfs_drop_extents.btrfs_replace_file_extents
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_fileattr_set.vfs_fileattr_set
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_replace_file_extents.btrfs_punch_hole
      0.00          +6e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.rcu_gp_cleanup.rcu_gp_kthread.kthread.ret_from_fork
      0.00        +1.7e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache
      0.00 ± 78%      +6.7%       0.01 ± 70%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00          +8e+98%       0.00 ±156%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00 ±264%     -60.0%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.01 ±264%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.truncate_inode_pages_range.btrfs_clone_files.isra.0
      0.00          +2e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.01 ± 17%      -4.0%       0.00 ± 15%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 44%      +1.7%       0.01 ± 39%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00            +0.0%       0.00        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00 ± 10%      -4.0%       0.00        perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01            +0.0%       0.01        perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ±264%    +140.0%       0.00 ±300%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.00          +2e+98%       0.00 ±200%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00 ±133%   +6324.6%       0.10 ±295%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.08 ±260%     -99.6%       0.00 ±213%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00          +1e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_data_bytes.btrfs_fallocate
      0.00 ±111%     +10.0%       0.00 ±103%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.00            +3.3%       0.00 ±  9%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00           +10.0%       0.00 ± 27%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 33%     -11.7%       0.01 ± 12%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.00 ± 10%     +14.6%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.00 ±158%     +30.9%       0.00 ±263%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      0.00        +1.1e+99%       0.00 ±209%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.00 ± 10%      -4.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.00 ± 14%      +4.2%       0.00 ± 18%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00        +1.1e+99%       0.00 ±124%  perf-sched.sch_delay.avg.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      0.00 ± 29%      -8.1%       0.00 ±  9%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.03 ± 46%      -1.7%       0.03 ± 42%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 30%     +10.9%       0.01 ± 40%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00 ± 15%     +17.6%       0.00 ± 36%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.03 ± 36%     +10.7%       0.04 ± 24%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.16 ±261%    +395.6%       0.81 ±172%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.folio_alloc.do_read_cache_folio.vfs_dedupe_file_range_compare
      0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space
      0.00        +1.5e+99%       0.00 ±161%  perf-sched.sch_delay.max.ms.__cond_resched.__flush_work.isra.0.__lru_add_drain_all
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.btrfs_alloc_block_rsv.btrfs_replace_file_extents
      0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.btrfs_fallocate.vfs_fallocate
      0.01 ±  8%     +10.5%       0.01 ± 20%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.00          +9e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.btrfs_alloc_path.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.00          +6e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.00 ±130%     -20.0%       0.00 ±157%  perf-sched.sch_delay.max.ms.__cond_resched.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_replace_extent.btrfs_replace_file_extents
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.flush_memcg_stats_dwork
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      0.12 ±259%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.find_free_extent.btrfs_reserve_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
      0.34 ±262%     -98.6%       0.00 ±133%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_clone_files
      0.00 ± 86%  +10253.9%       0.43 ±297%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_do_readpage
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_extent_same_range
      0.00 ±264%  +28300.0%       0.18 ±297%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_invalidate_folio
      0.00 ±264%     -60.0%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_replace_file_extents
      0.01 ± 38%      +2.9%       0.01 ± 28%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.lock_extent
      0.00 ±264%     -85.2%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.set_extent_bit
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.btrfs_drop_extent_map_range.btrfs_drop_extents.btrfs_replace_file_extents
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_fileattr_set.vfs_fileattr_set
      0.00 ±264%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_replace_file_extents.btrfs_punch_hole
      0.00          +6e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.rcu_gp_cleanup.rcu_gp_kthread.kthread.ret_from_fork
      0.00        +1.7e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache
      0.01 ± 78%     +13.2%       0.01 ± 66%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00          +8e+98%       0.00 ±156%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00 ±264%     -60.0%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.31 ±262%     -99.4%       0.00 ±127%  perf-sched.sch_delay.max.ms.__cond_resched.truncate_inode_pages_range.btrfs_clone_files.isra.0
      0.00 ±141%     -60.0%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.vfs_dedupe_file_range_compare.constprop.0.__generic_remap_file_range_prep
      0.00          +2e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.01 ± 27%      -6.0%       0.01 ± 36%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 44%      +5.9%       0.01 ± 38%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.21 ±201%    +167.9%       0.56 ±270%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 11%      +5.6%       0.01 ± 36%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 19%      +3.5%       0.01 ± 15%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ±264%    +140.0%       0.00 ±300%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.00 ±264%    +513.3%       0.00 ±148%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00 ±152%   +7456.4%       0.21 ±296%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.68 ±262%     -99.8%       0.00 ±200%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00 ±130%      -7.7%       0.00 ±225%  perf-sched.sch_delay.max.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_data_bytes.btrfs_fallocate
      0.00 ±102%      -5.5%       0.00 ±103%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.02 ± 23%     -23.3%       0.01 ± 29%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 21%      +9.3%       0.01 ± 15%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 48%     -20.0%       0.01 ± 17%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ± 39%      +4.9%       0.01 ± 28%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.64 ± 85%     -71.6%       0.47 ±128%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.19 ±169%     -43.9%       0.11 ±259%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      0.00        +1.1e+99%       0.00 ±209%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.00 ± 35%     +29.7%       0.01 ± 40%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.00 ±  9%     +43.2%       0.01 ± 30%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00        +1.1e+99%       0.00 ±124%  perf-sched.sch_delay.max.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      0.51 ±260%     -98.1%       0.01 ± 20%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.09 ± 40%      -1.1%       3.06 ± 27%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 30%     +20.7%       0.01 ± 36%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00 ± 85%     +75.1%       0.01 ±158%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      2.39 ± 35%      +5.1%       2.51 ± 28%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.0%       0.00        perf-sched.total_sch_delay.average.ms
      3.72 ± 30%      +0.8%       3.75 ± 17%  perf-sched.total_sch_delay.max.ms
      4.89 ±  3%      +4.9%       5.13 ±  3%  perf-sched.total_wait_and_delay.average.ms
     89766            -3.1%      86942        perf-sched.total_wait_and_delay.count.ms
      3132 ± 20%      +5.2%       3295 ± 18%  perf-sched.total_wait_and_delay.max.ms
      4.89 ±  3%      +4.9%       5.13 ±  3%  perf-sched.total_wait_time.average.ms
      3132 ± 20%      +5.2%       3295 ± 18%  perf-sched.total_wait_time.max.ms
      0.00       +1.5e+103%      15.38 ±300%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     18.52 ±  5%      +1.5%      18.81 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00       +2.3e+102%       2.33 ±300%  perf-sched.wait_and_delay.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.00         +1e+103%      10.44 ±300%  perf-sched.wait_and_delay.avg.ms.__cond_resched.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
     18.90 ±264%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.flush_memcg_stats_dwork
      0.00         +1e+104%     100.10 ±300%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.00         +1e+104%     100.02 ±300%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache
    250.06 ±172%     +54.6%     386.64 ±113%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    799.87            -0.0%     799.87        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.12            +0.0%       0.12        perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    283.11 ±  8%      +0.4%     284.37 ±  9%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00         +1e+104%     100.02 ±300%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
    286.77 ±  7%      -1.3%     283.11 ±  6%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    298.84            +0.4%     299.90 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    420.93 ±  7%      -8.3%     386.20 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±  9%      +7.9%       0.01 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
    453.61            -0.2%     452.50        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.01 ±  8%      -0.5%       3.99 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    312.30 ±  5%      +2.2%     319.28 ±  8%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    496.24 ±  3%      +2.0%     506.30 ±  6%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
    200.50 ±  8%      +0.5%     201.50 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.__cond_resched.btrfs_alloc_path.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.__cond_resched.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.12 ±264%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.flush_memcg_stats_dwork
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache
      0.50 ±141%    +160.0%       1.30 ±142%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.00            +0.0%      10.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     74939            +0.0%      74972        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     64.00            +0.0%      64.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
    165.88 ±  7%      +1.2%     167.80 ±  5%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     56.50            -0.9%      56.00 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     11.75 ±  7%      +6.4%      12.50 ±  4%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     11447 ±  6%     -24.2%       8673 ±  6%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
     10.00            -2.0%       9.80 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      1253 ±  8%      +0.5%       1259 ±  8%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    674.00 ±  7%      -3.4%     651.10 ±  4%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    225.25 ±  5%      +5.3%     237.20 ±  4%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00       +1.5e+103%      15.38 ±300%  perf-sched.wait_and_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      1000            +0.0%       1000        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00       +2.3e+102%       2.33 ±300%  perf-sched.wait_and_delay.max.ms.__cond_resched.btrfs_alloc_path.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.00         +1e+103%      10.44 ±300%  perf-sched.wait_and_delay.max.ms.__cond_resched.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
     18.90 ±264%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.flush_memcg_stats_dwork
      0.00         +1e+104%     100.10 ±300%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.00         +1e+104%     100.02 ±300%  perf-sched.wait_and_delay.max.ms.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache
    251.12 ±171%    +179.6%     702.09 ±128%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    999.87            -0.0%     999.86        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000            +0.0%       1000        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1868 ± 49%     -19.8%       1498 ± 44%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00         +1e+104%     100.02 ±300%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      1008            -0.0%       1008        perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1000            -0.0%       1000        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    531.24 ±  7%      -5.9%     499.99        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      2.63 ± 60%     -53.1%       1.23 ± 67%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
    504.63            +0.0%     504.71        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      5.01            +0.1%       5.01        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2794 ± 23%      +7.7%       3011 ± 18%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2561 ± 18%     +14.4%       2930 ± 33%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±182%     +31.8%       0.00 ±109%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__kmalloc_large_node.__kmalloc_node.kvmalloc_node
      0.01 ± 43%      -1.9%       0.01 ± 49%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.folio_alloc.do_read_cache_folio.vfs_dedupe_file_range_compare
      0.00          +8e+98%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space
      0.00 ±174%     -64.4%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.__clear_extent_bit.btrfs_replace_file_extents.btrfs_punch_hole.btrfs_fallocate
      0.00       +1.5e+103%      15.38 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.00 ±174%     -20.0%       0.00 ±201%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node_track_caller.memdup_user.do_vfs_ioctl
      0.01 ±101%     -20.0%       0.01 ± 49%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.btrfs_alloc_block_rsv.btrfs_replace_file_extents
      0.00 ±264%    +508.0%       0.00 ±191%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.btrfs_fallocate.vfs_fallocate
     18.52 ±  5%      +1.5%      18.81 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.08 ±264%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.00 ±264%     -52.9%       0.00 ±200%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_clone.btrfs_clone_files.isra
      0.00        +3.8e+99%       0.00 ± 52%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_clone.btrfs_extent_same_range.btrfs_remap_file_range
      0.00       +2.3e+102%       2.33 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_get_extent.find_first_non_hole.btrfs_punch_hole
      0.00 ±174%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_punch_hole.btrfs_fallocate.vfs_fallocate
      0.00        +2.4e+99%       0.00 ±112%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.insert_prealloc_file_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_clone.btrfs_clone_files.isra
      0.00          +6e+98%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_clone.btrfs_extent_same_range.btrfs_remap_file_range
      0.00         +1e+103%      10.44 ±299%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.01 ± 53%    +269.2%       0.04 ±240%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_replace_extent.btrfs_replace_file_extents
      0.01 ±106%     -75.2%       0.00 ±152%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.btrfs_replace_file_extents
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_get_extent.find_first_non_hole
     18.90 ±264%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.flush_memcg_stats_dwork
      0.00 ±105%     -24.4%       0.00 ±162%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      0.00 ±174%      -2.2%       0.00 ±201%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.find_free_extent.btrfs_reserve_extent.__btrfs_prealloc_file_range
      0.00 ±264%      +0.0%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.unmap_mapping_range.truncate_pagecache_range.btrfs_punch_hole_lock_range
      0.00 ± 85%     +45.2%       0.00 ± 95%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      0.00          +5e+98%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.btrfs_inode_lock.btrfs_punch_hole.btrfs_fallocate
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.btrfs_inode_lock.btrfs_remap_file_range.do_clone_file_range
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.btrfs_remap_file_range.do_clone_file_range.vfs_clone_file_range
      0.00 ±174%     -70.9%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.lock_two_inodes.btrfs_remap_file_range.do_clone_file_range
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.lock_two_inodes.btrfs_remap_file_range.vfs_dedupe_file_range_one
      0.00          +4e+98%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vfs_fileattr_set.do_vfs_ioctl.__x64_sys_ioctl
      0.03 ±210%     -80.2%       0.01 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.find_free_extent.btrfs_reserve_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
      0.00 ± 41%     -15.4%       0.00 ± 76%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_map.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
      0.00 ±196%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent.btrfs_do_readpage
      0.01 ± 83%     -18.6%       0.01 ± 34%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_clone_files
      0.01 ±  8%     +10.5%       0.01 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_do_readpage
      0.00 ±102%     -45.9%       0.00 ±101%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_extent_same_range
      0.00 ±105%     +11.1%       0.00 ±101%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_fallocate
      0.01 ± 42%     +14.7%       0.01 ± 77%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_invalidate_folio
      0.00 ±264%     -55.6%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_punch_hole
      0.01 ± 73%     -33.7%       0.01 ±105%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_replace_file_extents
      0.01 ±  9%     +39.5%       0.01 ± 69%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.lock_extent
      0.01 ± 27%     +26.8%       0.01 ± 60%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.set_extent_bit
      0.00 ±264%     +12.0%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_alloc_reserved_file_extent.btrfs_insert_replace_extent
      0.00 ± 79%     +12.0%       0.00 ± 83%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_drop_extents.btrfs_replace_file_extents
      0.00 ±100%     -41.8%       0.00 ±153%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_insert_replace_extent.btrfs_replace_file_extents
      0.00        +3.7e+99%       0.00 ±265%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_clone.btrfs_clone_files.isra
      0.00 ±100%     +84.0%       0.00 ± 57%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_drop_extent_map_range.btrfs_drop_extents.btrfs_replace_file_extents
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_drop_extent_map_range.btrfs_replace_extent_map_range.__btrfs_prealloc_file_range
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_get_extent.btrfs_do_readpage.btrfs_read_folio
      0.00          +5e+98%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_punch_hole.btrfs_fallocate.vfs_fallocate
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.insert_prealloc_file_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
      0.00 ± 83%     -40.7%       0.00 ±122%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_dirty_inode.file_modified
      0.00 ±173%    +520.0%       0.01 ±230%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_fileattr_set.vfs_fileattr_set
      0.00 ±133%     +42.9%       0.00 ±100%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_replace_file_extents.btrfs_clone
      0.00 ±264%     -27.3%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_replace_file_extents.btrfs_punch_hole
      0.00 ±173%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_replace_file_extents.insert_prealloc_file_extent
      0.00 ±264%     +20.0%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write_file.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      0.00          +1e+99%       0.00 ±204%  perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write_file.vfs_dedupe_file_range_one.vfs_dedupe_file_range.do_vfs_ioctl
      0.00 ±136%     -20.0%       0.00 ±153%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.__btrfs_release_delayed_node.part.0
      0.00 ±264%      +0.0%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.__btrfs_prealloc_file_range
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_dirty_inode
      0.00 ±264%    +380.0%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_fileattr_set
      0.00 ±264%    +252.0%       0.00 ±245%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_punch_hole
      0.00 ±173%    +212.0%       0.00 ± 51%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.clone_finish_inode_update
      0.00         +1e+104%     100.10 ±299%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.00         +4e+101%       0.40 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.rcu_gp_cleanup.rcu_gp_kthread.kthread.ret_from_fork
      0.00         +1e+104%     100.02 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache
    250.06 ±172%     +54.6%     386.64 ±113%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00          +4e+98%       0.00 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.start_transaction.btrfs_replace_file_extents.btrfs_clone.btrfs_extent_same_range
      0.00        +5.8e+99%       0.01 ±300%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.01 ± 22%     +21.7%       0.01 ± 67%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.btrfs_clone_files.isra.0
      0.00        +1.4e+99%       0.00 ±153%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.btrfs_punch_hole_lock_range.btrfs_punch_hole.btrfs_fallocate
      0.00 ± 43%     -12.5%       0.00 ± 69%  perf-sched.wait_time.avg.ms.__cond_resched.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl
      0.01 ± 93%     -31.9%       0.01 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.vfs_dedupe_file_range_compare.constprop.0.__generic_remap_file_range_prep
      0.00 ± 39%     -38.3%       0.00 ± 82%  perf-sched.wait_time.avg.ms.__cond_resched.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64
    799.87            -0.0%     799.86        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.11 ±173%    +141.9%       0.27 ± 82%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.11            +0.0%       0.11        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    283.11 ±  8%      +0.4%     284.37 ±  9%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.28 ±  2%      +4.4%       0.29 ±  2%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00         +1e+104%     100.02 ±300%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.00 ± 10%     +21.1%       0.01 ± 29%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.08 ±205%     -69.0%       0.03 ± 77%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.02 ±155%     -57.8%       0.01 ± 47%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01 ± 12%      +1.8%       0.01 ± 26%  perf-sched.wait_time.avg.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_data_bytes.btrfs_fallocate
      0.00 ±185%     -46.7%       0.00 ±200%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
    286.76 ±  7%      -1.3%     283.11 ±  6%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    298.84            +0.4%     299.90 ±  3%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    420.93 ±  7%      -8.3%     386.19 ±  5%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±  6%      +3.4%       0.01 ±  8%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.01 ±  9%    +106.5%       0.01 ±117%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      0.00        +1.5e+99%       0.00 ±155%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.00 ±188%     -70.5%       0.00 ±300%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr
      0.42            +1.3%       0.42        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    453.61            -0.2%     452.50        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00         +5e+101%       0.50 ±202%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      4.01 ±  8%      -0.5%       3.99 ±  8%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    312.27 ±  5%      +2.2%     319.25 ±  8%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.11 ±173%    +141.6%       0.27 ± 82%  perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00          +1e+98%       0.00 ±300%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    496.21 ±  3%      +2.0%     506.26 ±  6%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±178%     +24.4%       0.00 ±109%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__kmalloc_large_node.__kmalloc_node.kvmalloc_node
      0.12 ±183%     -29.5%       0.08 ±218%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.folio_alloc.do_read_cache_folio.vfs_dedupe_file_range_compare
      0.00          +8e+98%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space
      0.00 ±174%     -64.4%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.__clear_extent_bit.btrfs_replace_file_extents.btrfs_punch_hole.btrfs_fallocate
      0.00       +1.5e+103%      15.38 ±300%  perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.00 ±174%     -20.0%       0.00 ±201%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node_track_caller.memdup_user.do_vfs_ioctl
      0.01 ±125%     -32.6%       0.01 ± 59%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.btrfs_alloc_block_rsv.btrfs_replace_file_extents
      0.00 ±264%    +508.0%       0.00 ±191%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.btrfs_fallocate.vfs_fallocate
      1000            +0.0%       1000        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.08 ±264%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.00 ±264%     -52.9%       0.00 ±200%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_alloc_path.btrfs_clone.btrfs_clone_files.isra
      0.00        +3.9e+99%       0.00 ± 51%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_alloc_path.btrfs_clone.btrfs_extent_same_range.btrfs_remap_file_range
      0.00       +2.3e+102%       2.33 ±300%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_alloc_path.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_alloc_path.btrfs_get_extent.find_first_non_hole.btrfs_punch_hole
      0.00 ±174%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_alloc_path.btrfs_punch_hole.btrfs_fallocate.vfs_fallocate
      0.00        +2.6e+99%       0.00 ±120%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_alloc_path.insert_prealloc_file_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_clone.btrfs_clone_files.isra
      0.00          +6e+98%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_clone.btrfs_extent_same_range.btrfs_remap_file_range
      0.00         +1e+103%      10.44 ±299%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.03 ± 85%    +731.0%       0.27 ±273%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_replace_extent.btrfs_replace_file_extents
      0.01 ± 99%     -77.1%       0.00 ±152%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.btrfs_replace_file_extents
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_get_extent.find_first_non_hole
     18.90 ±264%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.flush_memcg_stats_dwork
      0.00 ±105%     -15.6%       0.00 ±170%  perf-sched.wait_time.max.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      0.00 ±174%      -2.2%       0.00 ±201%  perf-sched.wait_time.max.ms.__cond_resched.down_read.find_free_extent.btrfs_reserve_extent.__btrfs_prealloc_file_range
      0.00 ±264%      +0.0%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.down_read.unmap_mapping_range.truncate_pagecache_range.btrfs_punch_hole_lock_range
      0.00 ± 89%     +30.7%       0.00 ± 95%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      0.00          +5e+98%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.down_write.btrfs_inode_lock.btrfs_punch_hole.btrfs_fallocate
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.btrfs_inode_lock.btrfs_remap_file_range.do_clone_file_range
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.btrfs_remap_file_range.do_clone_file_range.vfs_clone_file_range
      0.00 ±174%     -70.9%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.down_write.lock_two_inodes.btrfs_remap_file_range.do_clone_file_range
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.lock_two_inodes.btrfs_remap_file_range.vfs_dedupe_file_range_one
      0.00          +4e+98%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vfs_fileattr_set.do_vfs_ioctl.__x64_sys_ioctl
      0.18 ±251%     -96.5%       0.01 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.find_free_extent.btrfs_reserve_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
      0.00 ± 41%     -13.1%       0.00 ± 76%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_map.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
      0.00 ±196%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_map.btrfs_get_extent.btrfs_do_readpage
      0.01 ±114%     +58.0%       0.02 ± 82%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_clone_files
      0.02 ± 71%      +7.8%       0.03 ± 61%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_do_readpage
      0.01 ±122%     -56.2%       0.00 ±101%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_extent_same_range
      0.00 ±105%     +11.1%       0.00 ±101%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_fallocate
      0.02 ±136%     +68.4%       0.04 ±226%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_invalidate_folio
      0.00 ±264%     -55.6%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_punch_hole
      0.01 ± 96%     -53.5%       0.01 ±102%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_replace_file_extents
      0.04 ± 44%    +210.9%       0.11 ±198%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.lock_extent
      0.02 ± 72%      +6.8%       0.02 ± 97%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.set_extent_bit
      0.00 ±264%     +12.0%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_alloc_reserved_file_extent.btrfs_insert_replace_extent
      0.00 ± 79%     +24.8%       0.00 ± 91%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_drop_extents.btrfs_replace_file_extents
      0.00 ±100%     -41.8%       0.00 ±153%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_insert_replace_extent.btrfs_replace_file_extents
      0.00        +3.7e+99%       0.00 ±265%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.btrfs_clone.btrfs_clone_files.isra
      0.00 ±100%     +84.0%       0.00 ± 57%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.btrfs_drop_extent_map_range.btrfs_drop_extents.btrfs_replace_file_extents
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.btrfs_drop_extent_map_range.btrfs_replace_extent_map_range.__btrfs_prealloc_file_range
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.btrfs_get_extent.btrfs_do_readpage.btrfs_read_folio
      0.00          +5e+98%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.btrfs_punch_hole.btrfs_fallocate.vfs_fallocate
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.insert_prealloc_file_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
      0.00 ± 94%     -46.7%       0.00 ±122%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_dirty_inode.file_modified
      0.00 ±173%    +520.0%       0.01 ±230%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_fileattr_set.vfs_fileattr_set
      0.00 ±133%     +42.9%       0.00 ±100%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_replace_file_extents.btrfs_clone
      0.00 ±264%     -27.3%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_replace_file_extents.btrfs_punch_hole
      0.00 ±174%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_replace_file_extents.insert_prealloc_file_extent
      0.00 ±264%     +20.0%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write_file.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      0.00          +1e+99%       0.00 ±204%  perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write_file.vfs_dedupe_file_range_one.vfs_dedupe_file_range.do_vfs_ioctl
      0.00 ±136%     -20.0%       0.00 ±153%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__btrfs_release_delayed_node.part.0
      0.00 ±264%     +20.0%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.__btrfs_prealloc_file_range
      0.00 ±264%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_dirty_inode
      0.00 ±264%    +380.0%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_fileattr_set
      0.00 ±264%    +252.0%       0.00 ±245%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_punch_hole
      0.00 ±173%    +220.0%       0.00 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.clone_finish_inode_update
      0.00         +1e+104%     100.10 ±299%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.00         +4e+101%       0.40 ±300%  perf-sched.wait_time.max.ms.__cond_resched.rcu_gp_cleanup.rcu_gp_kthread.kthread.ret_from_fork
      0.00         +1e+104%     100.02 ±300%  perf-sched.wait_time.max.ms.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache
    251.12 ±171%    +179.6%     702.09 ±128%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00          +4e+98%       0.00 ±300%  perf-sched.wait_time.max.ms.__cond_resched.start_transaction.btrfs_replace_file_extents.btrfs_clone.btrfs_extent_same_range
      0.00        +5.8e+99%       0.01 ±300%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.03 ± 80%    +209.9%       0.08 ±208%  perf-sched.wait_time.max.ms.__cond_resched.truncate_inode_pages_range.btrfs_clone_files.isra.0
      0.00        +1.4e+99%       0.00 ±153%  perf-sched.wait_time.max.ms.__cond_resched.truncate_inode_pages_range.btrfs_punch_hole_lock_range.btrfs_punch_hole.btrfs_fallocate
      0.00 ± 43%      -2.5%       0.00 ± 77%  perf-sched.wait_time.max.ms.__cond_resched.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl
      0.08 ±209%     -77.4%       0.02 ±111%  perf-sched.wait_time.max.ms.__cond_resched.vfs_dedupe_file_range_compare.constprop.0.__generic_remap_file_range_prep
      0.00 ± 40%     -37.8%       0.00 ± 82%  perf-sched.wait_time.max.ms.__cond_resched.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64
    999.86            -0.0%     999.86        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.22 ±173%    +141.8%       0.53 ± 82%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1000            +0.0%       1000        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1868 ± 49%     -19.8%       1498 ± 44%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.86 ±  3%      +1.6%       0.87 ±  3%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00         +1e+104%     100.02 ±300%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.01 ± 14%    +127.8%       0.01 ±127%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.09 ±198%     -58.3%       0.04 ± 70%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.08 ±214%     -83.2%       0.01 ±104%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.02 ± 81%      -3.8%       0.02 ± 91%  perf-sched.wait_time.max.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_data_bytes.btrfs_fallocate
      0.00 ±174%     -28.9%       0.00 ±200%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      1008            -0.0%       1008        perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1000            -0.0%       1000        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    531.24 ±  7%      -5.9%     499.98        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.34 ± 92%     -23.4%       1.02 ± 82%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.04 ± 54%    +806.7%       0.39 ±206%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      0.00        +2.1e+99%       0.00 ±157%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.00 ±188%     -70.5%       0.00 ±300%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr
      0.93            +0.4%       0.94        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    504.62            +0.0%     504.70        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00         +5e+101%       0.50 ±202%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      5.00            +0.0%       5.00        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2794 ± 23%      +7.7%       3011 ± 18%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.22 ±173%    +141.7%       0.54 ± 82%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00 ±264%    +100.0%       0.00 ±200%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      2561 ± 18%     +14.4%       2930 ± 33%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    860.62 ± 13%      -2.8%     836.40 ± 18%  slabinfo.Acpi-State.active_objs
     16.88 ± 13%      -2.8%      16.40 ± 18%  slabinfo.Acpi-State.active_slabs
    860.62 ± 13%      -2.8%     836.40 ± 18%  slabinfo.Acpi-State.num_objs
     16.88 ± 13%      -2.8%      16.40 ± 18%  slabinfo.Acpi-State.num_slabs
     36.00            +0.0%      36.00        slabinfo.DCCP.active_objs
      2.00            +0.0%       2.00        slabinfo.DCCP.active_slabs
     36.00            +0.0%      36.00        slabinfo.DCCP.num_objs
      2.00            +0.0%       2.00        slabinfo.DCCP.num_slabs
     34.00            +0.0%      34.00        slabinfo.DCCPv6.active_objs
      2.00            +0.0%       2.00        slabinfo.DCCPv6.active_slabs
     34.00            +0.0%      34.00        slabinfo.DCCPv6.num_objs
      2.00            +0.0%       2.00        slabinfo.DCCPv6.num_slabs
     96.00            +0.0%      96.00        slabinfo.RAW.active_objs
      3.00            +0.0%       3.00        slabinfo.RAW.active_slabs
     96.00            +0.0%      96.00        slabinfo.RAW.num_objs
      3.00            +0.0%       3.00        slabinfo.RAW.num_slabs
     78.00            +6.7%      83.20 ± 12%  slabinfo.RAWv6.active_objs
      3.00            +6.7%       3.20 ± 12%  slabinfo.RAWv6.active_slabs
     78.00            +6.7%      83.20 ± 12%  slabinfo.RAWv6.num_objs
      3.00            +6.7%       3.20 ± 12%  slabinfo.RAWv6.num_slabs
     54.83 ±  8%      +3.6%      56.80        slabinfo.TCP.active_objs
      3.92 ±  8%      +3.6%       4.06        slabinfo.TCP.active_slabs
     54.83 ±  8%      +3.6%      56.80        slabinfo.TCP.num_objs
      3.92 ±  8%      +3.6%       4.06        slabinfo.TCP.num_slabs
     37.38 ± 11%      -2.6%      36.40 ± 14%  slabinfo.TCPv6.active_objs
      2.88 ± 11%      -2.6%       2.80 ± 14%  slabinfo.TCPv6.active_slabs
     37.38 ± 11%      -2.6%      36.40 ± 14%  slabinfo.TCPv6.num_objs
      2.88 ± 11%      -2.6%       2.80 ± 14%  slabinfo.TCPv6.num_slabs
    105.00 ± 11%      -1.7%     103.20 ± 14%  slabinfo.UDPv6.active_objs
      4.38 ± 11%      -1.7%       4.30 ± 14%  slabinfo.UDPv6.active_slabs
    105.00 ± 11%      -1.7%     103.20 ± 14%  slabinfo.UDPv6.num_objs
      4.38 ± 11%      -1.7%       4.30 ± 14%  slabinfo.UDPv6.num_slabs
    986.19 ±  4%      +2.2%       1008 ±  4%  slabinfo.UNIX.active_objs
     32.87 ±  4%      +2.2%      33.60 ±  4%  slabinfo.UNIX.active_slabs
    986.19 ±  4%      +2.2%       1008 ±  4%  slabinfo.UNIX.num_objs
     32.87 ±  4%      +2.2%      33.60 ±  4%  slabinfo.UNIX.num_slabs
      6255 ±  3%      -0.8%       6207 ±  5%  slabinfo.anon_vma.active_objs
    163.36 ±  3%      -1.2%     161.37 ±  5%  slabinfo.anon_vma.active_slabs
      6371 ±  3%      -1.2%       6293 ±  5%  slabinfo.anon_vma.num_objs
    163.36 ±  3%      -1.2%     161.37 ±  5%  slabinfo.anon_vma.num_slabs
      7503            +2.4%       7681 ±  4%  slabinfo.anon_vma_chain.active_objs
    119.97            +1.6%     121.86 ±  4%  slabinfo.anon_vma_chain.active_slabs
      7678            +1.6%       7798 ±  4%  slabinfo.anon_vma_chain.num_objs
    119.97            +1.6%     121.86 ±  4%  slabinfo.anon_vma_chain.num_slabs
     70.00 ± 14%     +14.3%      80.00 ± 15%  slabinfo.bdev_cache.active_objs
      3.50 ± 14%     +14.3%       4.00 ± 15%  slabinfo.bdev_cache.active_slabs
     70.00 ± 14%     +14.3%      80.00 ± 15%  slabinfo.bdev_cache.num_objs
      3.50 ± 14%     +14.3%       4.00 ± 15%  slabinfo.bdev_cache.num_slabs
     60.55 ± 16%     +15.3%      69.81 ± 10%  slabinfo.bio-120.active_objs
      1.89 ± 16%     +15.3%       2.18 ± 10%  slabinfo.bio-120.active_slabs
     60.55 ± 16%     +15.3%      69.81 ± 10%  slabinfo.bio-120.num_objs
      1.89 ± 16%     +15.3%       2.18 ± 10%  slabinfo.bio-120.num_slabs
    990.14 ±  8%      +7.9%       1068 ±  6%  slabinfo.bio-184.active_objs
     23.57 ±  8%      +7.9%      25.45 ±  6%  slabinfo.bio-184.active_slabs
    990.14 ±  8%      +7.9%       1068 ±  6%  slabinfo.bio-184.num_objs
     23.57 ±  8%      +7.9%      25.45 ±  6%  slabinfo.bio-184.num_slabs
     64.00            +0.0%      64.00        slabinfo.bio-248.active_objs
      2.00            +0.0%       2.00        slabinfo.bio-248.active_slabs
     64.00            +0.0%      64.00        slabinfo.bio-248.num_objs
      2.00            +0.0%       2.00        slabinfo.bio-248.num_slabs
     51.00            +0.0%      51.00        slabinfo.bio-296.active_objs
      1.00            +0.0%       1.00        slabinfo.bio-296.active_slabs
     51.00            +0.0%      51.00        slabinfo.bio-296.num_objs
      1.00            +0.0%       1.00        slabinfo.bio-296.num_slabs
    176.79 ±  8%      +7.2%     189.60 ± 10%  slabinfo.bio-360.active_objs
      4.21 ±  8%      +7.2%       4.51 ± 10%  slabinfo.bio-360.active_slabs
    176.79 ±  8%      +7.2%     189.60 ± 10%  slabinfo.bio-360.num_objs
      4.21 ±  8%      +7.2%       4.51 ± 10%  slabinfo.bio-360.num_slabs
     42.00            +0.0%      42.00        slabinfo.bio-376.active_objs
      1.00            +0.0%       1.00        slabinfo.bio-376.active_slabs
     42.00            +0.0%      42.00        slabinfo.bio-376.num_objs
      1.00            +0.0%       1.00        slabinfo.bio-376.num_slabs
     36.00            +0.0%      36.00        slabinfo.bio-432.active_objs
      1.00            +0.0%       1.00        slabinfo.bio-432.active_slabs
     36.00            +0.0%      36.00        slabinfo.bio-432.num_objs
      1.00            +0.0%       1.00        slabinfo.bio-432.num_slabs
    170.00            +0.0%     170.00        slabinfo.bio_post_read_ctx.active_objs
      2.00            +0.0%       2.00        slabinfo.bio_post_read_ctx.active_slabs
    170.00            +0.0%     170.00        slabinfo.bio_post_read_ctx.num_objs
      2.00            +0.0%       2.00        slabinfo.bio_post_read_ctx.num_slabs
     52.00 ± 29%      -7.7%      48.00 ± 53%  slabinfo.biovec-128.active_objs
      3.25 ± 29%      -7.7%       3.00 ± 53%  slabinfo.biovec-128.active_slabs
     52.00 ± 29%      -7.7%      48.00 ± 53%  slabinfo.biovec-128.num_objs
      3.25 ± 29%      -7.7%       3.00 ± 53%  slabinfo.biovec-128.num_slabs
    423.27 ± 11%      -0.3%     421.86 ± 10%  slabinfo.biovec-64.active_objs
     13.23 ± 11%      -0.3%      13.18 ± 10%  slabinfo.biovec-64.active_slabs
    423.27 ± 11%      -0.3%     421.86 ± 10%  slabinfo.biovec-64.num_objs
     13.23 ± 11%      -0.3%      13.18 ± 10%  slabinfo.biovec-64.num_slabs
     56.14            +2.3%      57.45 ±  3%  slabinfo.biovec-max.active_objs
      7.02            +2.3%       7.18 ±  3%  slabinfo.biovec-max.active_slabs
     56.14            +2.3%      57.45 ±  3%  slabinfo.biovec-max.num_objs
      7.02            +2.3%       7.18 ±  3%  slabinfo.biovec-max.num_slabs
      5847 ±129%     +16.9%       6837 ±122%  slabinfo.btrfs_delayed_ref_head.active_objs
    195.09 ±129%     +16.9%     228.11 ±122%  slabinfo.btrfs_delayed_ref_head.active_slabs
      5852 ±129%     +16.9%       6843 ±122%  slabinfo.btrfs_delayed_ref_head.num_objs
    195.09 ±129%     +16.9%     228.11 ±122%  slabinfo.btrfs_delayed_ref_head.num_slabs
    217.62 ± 11%      +5.8%     230.16 ± 11%  slabinfo.btrfs_extent_buffer.active_objs
      6.40 ± 11%      +5.8%       6.77 ± 11%  slabinfo.btrfs_extent_buffer.active_slabs
    217.62 ± 11%      +5.8%     230.16 ± 11%  slabinfo.btrfs_extent_buffer.num_objs
      6.40 ± 11%      +5.8%       6.77 ± 11%  slabinfo.btrfs_extent_buffer.num_slabs
    376.75 ± 12%      +6.1%     399.82 ± 14%  slabinfo.btrfs_free_space.active_objs
      9.66 ± 12%      +6.1%      10.25 ± 14%  slabinfo.btrfs_free_space.active_slabs
    376.75 ± 12%      +6.1%     399.82 ± 14%  slabinfo.btrfs_free_space.num_objs
      9.66 ± 12%      +6.1%      10.25 ± 14%  slabinfo.btrfs_free_space.num_slabs
    212.92 ± 11%      -0.6%     211.70 ±  9%  slabinfo.btrfs_inode.active_objs
      7.34 ± 11%      -0.6%       7.30 ±  9%  slabinfo.btrfs_inode.active_slabs
    212.92 ± 11%      -0.6%     211.70 ±  9%  slabinfo.btrfs_inode.num_objs
      7.34 ± 11%      -0.6%       7.30 ±  9%  slabinfo.btrfs_inode.num_slabs
      0.65 ±174%    +958.1%       6.90 ±126%  slabinfo.btrfs_ordered_extent.active_objs
      0.02 ±174%    +958.1%       0.18 ±126%  slabinfo.btrfs_ordered_extent.active_slabs
      0.65 ±174%    +958.1%       6.90 ±126%  slabinfo.btrfs_ordered_extent.num_objs
      0.02 ±174%    +958.1%       0.18 ±126%  slabinfo.btrfs_ordered_extent.num_slabs
      1128 ±  3%      -0.8%       1119 ±  4%  slabinfo.btrfs_path.active_objs
     31.36 ±  3%      -0.8%      31.09 ±  4%  slabinfo.btrfs_path.active_slabs
      1128 ±  3%      -0.8%       1119 ±  4%  slabinfo.btrfs_path.num_objs
     31.36 ±  3%      -0.8%      31.09 ±  4%  slabinfo.btrfs_path.num_slabs
      1553 ±  3%      +0.3%       1557 ±  2%  slabinfo.buffer_head.active_objs
     39.83 ±  3%      +0.3%      39.94 ±  2%  slabinfo.buffer_head.active_slabs
      1553 ±  3%      +0.3%       1557 ±  2%  slabinfo.buffer_head.num_objs
     39.83 ±  3%      +0.3%      39.94 ±  2%  slabinfo.buffer_head.num_slabs
      2441 ±  4%      -1.9%       2393 ±  4%  slabinfo.cred_jar.active_objs
     58.13 ±  4%      -1.9%      57.00 ±  4%  slabinfo.cred_jar.active_slabs
      2441 ±  4%      -1.9%       2393 ±  4%  slabinfo.cred_jar.num_objs
     58.13 ±  4%      -1.9%      57.00 ±  4%  slabinfo.cred_jar.num_slabs
     39.00            +0.0%      39.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     39.00            +0.0%      39.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
     75745            -0.0%      75742        slabinfo.dentry.active_objs
      1827            -0.1%       1825        slabinfo.dentry.active_slabs
     76744            -0.1%      76680        slabinfo.dentry.num_objs
      1827            -0.1%       1825        slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
     64.00            +0.0%      64.00        slabinfo.dmaengine-unmap-2.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-2.active_slabs
     64.00            +0.0%      64.00        slabinfo.dmaengine-unmap-2.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-2.num_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
      7872 ±  6%      +0.8%       7936 ±  5%  slabinfo.ep_head.active_objs
     30.75 ±  6%      +0.8%      31.00 ±  5%  slabinfo.ep_head.active_slabs
      7872 ±  6%      +0.8%       7936 ±  5%  slabinfo.ep_head.num_objs
     30.75 ±  6%      +0.8%      31.00 ±  5%  slabinfo.ep_head.num_slabs
    693.75 ± 14%      -2.8%     674.48 ± 14%  slabinfo.file_lock_cache.active_objs
     18.75 ± 14%      -2.8%      18.23 ± 14%  slabinfo.file_lock_cache.active_slabs
    693.75 ± 14%      -2.8%     674.48 ± 14%  slabinfo.file_lock_cache.num_objs
     18.75 ± 14%      -2.8%      18.23 ± 14%  slabinfo.file_lock_cache.num_slabs
      1684            -0.3%       1679        slabinfo.files_cache.active_objs
     36.62            -0.3%      36.50        slabinfo.files_cache.active_slabs
      1684            -0.3%       1679        slabinfo.files_cache.num_objs
     36.62            -0.3%      36.50        slabinfo.files_cache.num_slabs
      5932 ±  2%      +0.5%       5964        slabinfo.filp.active_objs
    282.47 ±  2%      +0.4%     283.61 ±  2%  slabinfo.filp.active_slabs
      9039 ±  2%      +0.4%       9075 ±  2%  slabinfo.filp.num_objs
    282.47 ±  2%      +0.4%     283.61 ±  2%  slabinfo.filp.num_slabs
      2371 ±  8%      +7.7%       2553 ± 11%  slabinfo.fsnotify_mark_connector.active_objs
     18.53 ±  8%      +7.7%      19.95 ± 11%  slabinfo.fsnotify_mark_connector.active_slabs
      2371 ±  8%      +7.7%       2553 ± 11%  slabinfo.fsnotify_mark_connector.num_objs
     18.53 ±  8%      +7.7%      19.95 ± 11%  slabinfo.fsnotify_mark_connector.num_slabs
      6433            -0.4%       6409        slabinfo.ftrace_event_field.active_objs
     88.12            -0.4%      87.80        slabinfo.ftrace_event_field.active_slabs
      6433            -0.4%       6409        slabinfo.ftrace_event_field.num_objs
     88.12            -0.4%      87.80        slabinfo.ftrace_event_field.num_slabs
    942.93 ±  3%      -1.7%     926.82 ±  3%  slabinfo.fuse_request.active_objs
     33.68 ±  3%      -1.7%      33.10 ±  3%  slabinfo.fuse_request.active_slabs
    942.93 ±  3%      -1.7%     926.82 ±  3%  slabinfo.fuse_request.num_objs
     33.68 ±  3%      -1.7%      33.10 ±  3%  slabinfo.fuse_request.num_slabs
     98.00            +0.0%      98.00        slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
     98.00            +0.0%      98.00        slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     64153            +0.1%      64202        slabinfo.inode_cache.active_objs
      1260            +0.1%       1262        slabinfo.inode_cache.active_slabs
     64287            +0.1%      64367        slabinfo.inode_cache.num_objs
      1260            +0.1%       1262        slabinfo.inode_cache.num_slabs
    191.62 ± 26%      -8.6%     175.20 ± 20%  slabinfo.ip_fib_alias.active_objs
      2.62 ± 26%      -8.6%       2.40 ± 20%  slabinfo.ip_fib_alias.active_slabs
    191.62 ± 26%      -8.6%     175.20 ± 20%  slabinfo.ip_fib_alias.num_objs
      2.62 ± 26%      -8.6%       2.40 ± 20%  slabinfo.ip_fib_alias.num_slabs
    223.12 ± 26%      -8.6%     204.00 ± 20%  slabinfo.ip_fib_trie.active_objs
      2.62 ± 26%      -8.6%       2.40 ± 20%  slabinfo.ip_fib_trie.active_slabs
    223.12 ± 26%      -8.6%     204.00 ± 20%  slabinfo.ip_fib_trie.num_objs
      2.62 ± 26%      -8.6%       2.40 ± 20%  slabinfo.ip_fib_trie.num_slabs
     47676            -0.1%      47638        slabinfo.kernfs_node_cache.active_objs
      1489            -0.1%       1488        slabinfo.kernfs_node_cache.active_slabs
     47676            -0.1%      47638        slabinfo.kernfs_node_cache.num_objs
      1489            -0.1%       1488        slabinfo.kernfs_node_cache.num_slabs
      2852 ±  5%      -1.8%       2800 ±  9%  slabinfo.khugepaged_mm_slot.active_objs
     27.96 ±  5%      -1.8%      27.46 ±  9%  slabinfo.khugepaged_mm_slot.active_slabs
      2852 ±  5%      -1.8%       2800 ±  9%  slabinfo.khugepaged_mm_slot.num_objs
     27.96 ±  5%      -1.8%      27.46 ±  9%  slabinfo.khugepaged_mm_slot.num_slabs
      2123            +0.0%       2124        slabinfo.kmalloc-128.active_objs
     66.37            +0.0%      66.39        slabinfo.kmalloc-128.active_slabs
      2123            +0.0%       2124        slabinfo.kmalloc-128.num_objs
     66.37            +0.0%      66.39        slabinfo.kmalloc-128.num_slabs
     18176            -0.7%      18048        slabinfo.kmalloc-16.active_objs
     71.00            -0.7%      70.50        slabinfo.kmalloc-16.active_slabs
     18176            -0.7%      18048        slabinfo.kmalloc-16.num_objs
     71.00            -0.7%      70.50        slabinfo.kmalloc-16.num_slabs
      2713 ±  4%      -1.0%       2685 ±  2%  slabinfo.kmalloc-192.active_objs
     64.60 ±  4%      -1.0%      63.95 ±  2%  slabinfo.kmalloc-192.active_slabs
      2713 ±  4%      -1.0%       2685 ±  2%  slabinfo.kmalloc-192.num_objs
     64.60 ±  4%      -1.0%      63.95 ±  2%  slabinfo.kmalloc-192.num_slabs
      2439            -0.4%       2428        slabinfo.kmalloc-1k.active_objs
     76.23            -0.4%      75.89        slabinfo.kmalloc-1k.active_slabs
      2439            -0.4%       2428        slabinfo.kmalloc-1k.num_objs
     76.23            -0.4%      75.89        slabinfo.kmalloc-1k.num_slabs
      4185 ±  2%      +2.5%       4291        slabinfo.kmalloc-256.active_objs
    131.05 ±  2%      +2.7%     134.64        slabinfo.kmalloc-256.active_slabs
      4193 ±  2%      +2.7%       4308        slabinfo.kmalloc-256.num_objs
    131.05 ±  2%      +2.7%     134.64        slabinfo.kmalloc-256.num_slabs
      1734 ±  2%      -0.5%       1725 ±  2%  slabinfo.kmalloc-2k.active_objs
    111.17 ±  2%      -0.8%     110.32 ±  2%  slabinfo.kmalloc-2k.active_slabs
      1778 ±  2%      -0.8%       1765 ±  2%  slabinfo.kmalloc-2k.num_objs
    111.17 ±  2%      -0.8%     110.32 ±  2%  slabinfo.kmalloc-2k.num_slabs
     16923            +1.2%      17130        slabinfo.kmalloc-32.active_objs
    132.22            +1.3%     133.91        slabinfo.kmalloc-32.active_slabs
     16923            +1.3%      17140        slabinfo.kmalloc-32.num_objs
    132.22            +1.3%     133.91        slabinfo.kmalloc-32.num_slabs
    649.65            -0.5%     646.70        slabinfo.kmalloc-4k.active_objs
     82.06            -0.3%      81.81        slabinfo.kmalloc-4k.active_slabs
    656.49            -0.3%     654.49        slabinfo.kmalloc-4k.num_objs
     82.06            -0.3%      81.81        slabinfo.kmalloc-4k.num_slabs
      5183 ±  2%      +0.9%       5231 ±  2%  slabinfo.kmalloc-512.active_objs
    162.48 ±  2%      +0.9%     163.93 ±  2%  slabinfo.kmalloc-512.active_slabs
      5199 ±  2%      +0.9%       5245 ±  2%  slabinfo.kmalloc-512.num_objs
    162.48 ±  2%      +0.9%     163.93 ±  2%  slabinfo.kmalloc-512.num_slabs
     19017            -0.1%      18996        slabinfo.kmalloc-64.active_objs
    297.15            -0.1%     296.82        slabinfo.kmalloc-64.active_slabs
     19017            -0.1%      18996        slabinfo.kmalloc-64.num_objs
    297.15            -0.1%     296.82        slabinfo.kmalloc-64.num_slabs
     33657            -0.2%      33580        slabinfo.kmalloc-8.active_objs
     65.75            -0.2%      65.60        slabinfo.kmalloc-8.active_slabs
     33664            -0.2%      33587        slabinfo.kmalloc-8.num_objs
     65.75            -0.2%      65.60        slabinfo.kmalloc-8.num_slabs
    197.38            -0.5%     196.45        slabinfo.kmalloc-8k.active_objs
     50.72            -0.1%      50.65        slabinfo.kmalloc-8k.active_slabs
    202.86            -0.1%     202.60        slabinfo.kmalloc-8k.num_objs
     50.72            -0.1%      50.65        slabinfo.kmalloc-8k.num_slabs
     20981            -0.6%      20845        slabinfo.kmalloc-96.active_objs
    517.73            -0.8%     513.39        slabinfo.kmalloc-96.active_slabs
     21744            -0.8%      21562        slabinfo.kmalloc-96.num_objs
    517.73            -0.8%     513.39        slabinfo.kmalloc-96.num_slabs
    447.63 ± 10%     +10.6%     495.16 ±  6%  slabinfo.kmalloc-cg-128.active_objs
     13.99 ± 10%     +10.6%      15.47 ±  6%  slabinfo.kmalloc-cg-128.active_slabs
    447.63 ± 10%     +10.6%     495.16 ±  6%  slabinfo.kmalloc-cg-128.num_objs
     13.99 ± 10%     +10.6%      15.47 ±  6%  slabinfo.kmalloc-cg-128.num_slabs
      3257 ± 10%      +8.9%       3547 ±  8%  slabinfo.kmalloc-cg-16.active_objs
     12.73 ± 10%      +8.9%      13.86 ±  8%  slabinfo.kmalloc-cg-16.active_slabs
      3257 ± 10%      +8.9%       3547 ±  8%  slabinfo.kmalloc-cg-16.num_objs
     12.73 ± 10%      +8.9%      13.86 ±  8%  slabinfo.kmalloc-cg-16.num_slabs
      1638            +0.5%       1646        slabinfo.kmalloc-cg-192.active_objs
     39.00            +0.5%      39.20        slabinfo.kmalloc-cg-192.active_slabs
      1638            +0.5%       1646        slabinfo.kmalloc-cg-192.num_objs
     39.00            +0.5%      39.20        slabinfo.kmalloc-cg-192.num_slabs
      1568 ±  3%      +3.5%       1622 ±  5%  slabinfo.kmalloc-cg-1k.active_objs
     49.00 ±  3%      +3.5%      50.70 ±  5%  slabinfo.kmalloc-cg-1k.active_slabs
      1568 ±  3%      +3.5%       1622 ±  5%  slabinfo.kmalloc-cg-1k.num_objs
     49.00 ±  3%      +3.5%      50.70 ±  5%  slabinfo.kmalloc-cg-1k.num_slabs
    280.00 ±  9%      -0.6%     278.40 ±  8%  slabinfo.kmalloc-cg-256.active_objs
      8.75 ±  9%      -0.6%       8.70 ±  8%  slabinfo.kmalloc-cg-256.active_slabs
    280.00 ±  9%      -0.6%     278.40 ±  8%  slabinfo.kmalloc-cg-256.num_objs
      8.75 ±  9%      -0.6%       8.70 ±  8%  slabinfo.kmalloc-cg-256.num_slabs
    530.09 ±  7%      -0.7%     526.12 ±  6%  slabinfo.kmalloc-cg-2k.active_objs
     33.13 ±  7%      -0.7%      32.88 ±  6%  slabinfo.kmalloc-cg-2k.active_slabs
    530.09 ±  7%      -0.7%     526.12 ±  6%  slabinfo.kmalloc-cg-2k.num_objs
     33.13 ±  7%      -0.7%      32.88 ±  6%  slabinfo.kmalloc-cg-2k.num_slabs
      5010 ±  2%      -0.4%       4991        slabinfo.kmalloc-cg-32.active_objs
     39.14 ±  2%      -0.4%      39.00        slabinfo.kmalloc-cg-32.active_slabs
      5010 ±  2%      -0.4%       4991        slabinfo.kmalloc-cg-32.num_objs
     39.14 ±  2%      -0.4%      39.00        slabinfo.kmalloc-cg-32.num_slabs
    498.48            -1.8%     489.34 ±  3%  slabinfo.kmalloc-cg-4k.active_objs
     65.83            -1.4%      64.93 ±  2%  slabinfo.kmalloc-cg-4k.active_slabs
    526.61            -1.4%     519.45 ±  2%  slabinfo.kmalloc-cg-4k.num_objs
     65.83            -1.4%      64.93 ±  2%  slabinfo.kmalloc-cg-4k.num_slabs
      1188            +0.5%       1193        slabinfo.kmalloc-cg-512.active_objs
     37.12            +0.5%      37.30        slabinfo.kmalloc-cg-512.active_slabs
      1188            +0.5%       1193        slabinfo.kmalloc-cg-512.num_objs
     37.12            +0.5%      37.30        slabinfo.kmalloc-cg-512.num_slabs
      1572 ±  8%      +1.5%       1596 ±  7%  slabinfo.kmalloc-cg-64.active_objs
     24.58 ±  8%      +1.5%      24.94 ±  7%  slabinfo.kmalloc-cg-64.active_slabs
      1572 ±  8%      +1.5%       1596 ±  7%  slabinfo.kmalloc-cg-64.num_objs
     24.58 ±  8%      +1.5%      24.94 ±  7%  slabinfo.kmalloc-cg-64.num_slabs
     18432            +0.0%      18432        slabinfo.kmalloc-cg-8.active_objs
     36.00            +0.0%      36.00        slabinfo.kmalloc-cg-8.active_slabs
     18432            +0.0%      18432        slabinfo.kmalloc-cg-8.num_objs
     36.00            +0.0%      36.00        slabinfo.kmalloc-cg-8.num_slabs
     59.11 ±  6%      -4.1%      56.71 ±  7%  slabinfo.kmalloc-cg-8k.active_objs
     14.78 ±  6%      -4.1%      14.18 ±  7%  slabinfo.kmalloc-cg-8k.active_slabs
     59.11 ±  6%      -4.1%      56.71 ±  7%  slabinfo.kmalloc-cg-8k.num_objs
     14.78 ±  6%      -4.1%      14.18 ±  7%  slabinfo.kmalloc-cg-8k.num_slabs
    969.83 ± 11%      -0.1%     969.09 ±  6%  slabinfo.kmalloc-cg-96.active_objs
     23.09 ± 11%      -0.1%      23.07 ±  6%  slabinfo.kmalloc-cg-96.active_slabs
    969.83 ± 11%      -0.1%     969.09 ±  6%  slabinfo.kmalloc-cg-96.num_objs
     23.09 ± 11%      -0.1%      23.07 ±  6%  slabinfo.kmalloc-cg-96.num_slabs
     88.00 ± 24%      +9.1%      96.00 ± 21%  slabinfo.kmalloc-rcl-128.active_objs
      2.75 ± 24%      +9.1%       3.00 ± 21%  slabinfo.kmalloc-rcl-128.active_slabs
     88.00 ± 24%      +9.1%      96.00 ± 21%  slabinfo.kmalloc-rcl-128.num_objs
      2.75 ± 24%      +9.1%       3.00 ± 21%  slabinfo.kmalloc-rcl-128.num_slabs
     42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.active_objs
      1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.active_slabs
     42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.num_objs
      1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.num_slabs
      6310 ±  2%      +1.7%       6416 ±  2%  slabinfo.kmalloc-rcl-64.active_objs
    100.99 ±  2%      +0.4%     101.41 ±  2%  slabinfo.kmalloc-rcl-64.active_slabs
      6463 ±  2%      +0.4%       6490 ±  2%  slabinfo.kmalloc-rcl-64.num_objs
    100.99 ±  2%      +0.4%     101.41 ±  2%  slabinfo.kmalloc-rcl-64.num_slabs
      1386 ±  7%      -0.9%       1373 ±  7%  slabinfo.kmalloc-rcl-96.active_objs
     33.00 ±  7%      -0.9%      32.70 ±  7%  slabinfo.kmalloc-rcl-96.active_slabs
      1386 ±  7%      -0.9%       1373 ±  7%  slabinfo.kmalloc-rcl-96.num_objs
     33.00 ±  7%      -0.9%      32.70 ±  7%  slabinfo.kmalloc-rcl-96.num_slabs
    416.00 ±  9%      -2.3%     406.40 ±  9%  slabinfo.kmem_cache.active_objs
     13.00 ±  9%      -2.3%      12.70 ±  9%  slabinfo.kmem_cache.active_slabs
    416.00 ±  9%      -2.3%     406.40 ±  9%  slabinfo.kmem_cache.num_objs
     13.00 ±  9%      -2.3%      12.70 ±  9%  slabinfo.kmem_cache.num_slabs
    632.00 ± 11%      -1.8%     620.80 ± 13%  slabinfo.kmem_cache_node.active_objs
      9.88 ± 11%      -1.8%       9.70 ± 13%  slabinfo.kmem_cache_node.active_slabs
    632.00 ± 11%      -1.8%     620.80 ± 13%  slabinfo.kmem_cache_node.num_objs
      9.88 ± 11%      -1.8%       9.70 ± 13%  slabinfo.kmem_cache_node.num_slabs
      9711 ± 77%      +4.6%      10157 ± 81%  slabinfo.kvm_async_pf.active_objs
    324.09 ± 77%      +4.5%     338.80 ± 81%  slabinfo.kvm_async_pf.active_slabs
      9722 ± 77%      +4.5%      10163 ± 81%  slabinfo.kvm_async_pf.num_objs
    324.09 ± 77%      +4.5%     338.80 ± 81%  slabinfo.kvm_async_pf.num_slabs
      7974 ±  5%      -0.8%       7909 ±  4%  slabinfo.lsm_file_cache.active_objs
     47.18 ±  4%      -1.0%      46.72 ±  4%  slabinfo.lsm_file_cache.active_slabs
      8021 ±  4%      -1.0%       7941 ±  4%  slabinfo.lsm_file_cache.num_objs
     47.18 ±  4%      -1.0%      46.72 ±  4%  slabinfo.lsm_file_cache.num_slabs
      4530            -1.2%       4476 ±  3%  slabinfo.maple_node.active_objs
    164.60 ±  2%      -2.0%     161.37 ±  5%  slabinfo.maple_node.active_slabs
      5267 ±  2%      -2.0%       5163 ±  5%  slabinfo.maple_node.num_objs
    164.60 ±  2%      -2.0%     161.37 ±  5%  slabinfo.maple_node.num_slabs
    903.00            +0.5%     907.20        slabinfo.mm_struct.active_objs
     37.62            +0.5%      37.80        slabinfo.mm_struct.active_slabs
    903.00            +0.5%     907.20        slabinfo.mm_struct.num_objs
     37.62            +0.5%      37.80        slabinfo.mm_struct.num_slabs
    930.36 ±  6%      +4.0%     967.46 ±  8%  slabinfo.mnt_cache.active_objs
     18.24 ±  6%      +4.0%      18.97 ±  8%  slabinfo.mnt_cache.active_slabs
    930.36 ±  6%      +4.0%     967.46 ±  8%  slabinfo.mnt_cache.num_objs
     18.24 ±  6%      +4.0%      18.97 ±  8%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
    290.00            -0.7%     288.00        slabinfo.names_cache.active_objs
     36.25            -0.7%      36.00        slabinfo.names_cache.active_slabs
    290.00            -0.7%     288.00        slabinfo.names_cache.num_objs
     36.25            -0.7%      36.00        slabinfo.names_cache.num_slabs
      7.00            +0.0%       7.00        slabinfo.net_namespace.active_objs
      1.00            +0.0%       1.00        slabinfo.net_namespace.active_slabs
      7.00            +0.0%       7.00        slabinfo.net_namespace.num_objs
      1.00            +0.0%       1.00        slabinfo.net_namespace.num_slabs
     46.00            +0.0%      46.00        slabinfo.nfs_commit_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_commit_data.active_slabs
     46.00            +0.0%      46.00        slabinfo.nfs_commit_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_commit_data.num_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    338.26 ±  9%      -5.3%     320.40 ± 13%  slabinfo.nsproxy.active_objs
      6.04 ±  9%      -5.3%       5.72 ± 13%  slabinfo.nsproxy.active_slabs
    338.26 ±  9%      -5.3%     320.40 ± 13%  slabinfo.nsproxy.num_objs
      6.04 ±  9%      -5.3%       5.72 ± 13%  slabinfo.nsproxy.num_slabs
     60.00            +0.0%      60.00        slabinfo.numa_policy.active_objs
      2.00            +0.0%       2.00        slabinfo.numa_policy.active_slabs
     60.00            +0.0%      60.00        slabinfo.numa_policy.num_objs
      2.00            +0.0%       2.00        slabinfo.numa_policy.num_slabs
      1489            +0.0%       1489        slabinfo.perf_event.active_objs
     62.34 ±  2%      +0.1%      62.38        slabinfo.perf_event.active_slabs
      1558 ±  2%      +0.1%       1559        slabinfo.perf_event.num_objs
     62.34 ±  2%      +0.1%      62.38        slabinfo.perf_event.num_slabs
      1822 ±  3%      +0.4%       1829 ±  2%  slabinfo.pid.active_objs
     56.95 ±  3%      +0.4%      57.16 ±  2%  slabinfo.pid.active_slabs
      1822 ±  3%      +0.4%       1829 ±  2%  slabinfo.pid.num_objs
     56.95 ±  3%      +0.4%      57.16 ±  2%  slabinfo.pid.num_slabs
      2692 ±  2%      +0.7%       2711        slabinfo.pool_workqueue.active_objs
     84.15 ±  2%      +0.7%      84.75        slabinfo.pool_workqueue.active_slabs
      2692 ±  2%      +0.7%       2711        slabinfo.pool_workqueue.num_objs
     84.15 ±  2%      +0.7%      84.75        slabinfo.pool_workqueue.num_slabs
      1013 ±  2%      +4.9%       1062 ±  5%  slabinfo.proc_dir_entry.active_objs
     24.12 ±  2%      +4.9%      25.30 ±  5%  slabinfo.proc_dir_entry.active_slabs
      1013 ±  2%      +4.9%       1062 ±  5%  slabinfo.proc_dir_entry.num_objs
     24.12 ±  2%      +4.9%      25.30 ±  5%  slabinfo.proc_dir_entry.num_slabs
      5273            +0.8%       5313        slabinfo.proc_inode_cache.active_objs
    114.97            +0.8%     115.94        slabinfo.proc_inode_cache.active_slabs
      5288            +0.8%       5333        slabinfo.proc_inode_cache.num_objs
    114.97            +0.8%     115.94        slabinfo.proc_inode_cache.num_slabs
     29682            -0.0%      29682        slabinfo.radix_tree_node.active_objs
      1062            +0.0%       1062        slabinfo.radix_tree_node.active_slabs
     29749            +0.0%      29752        slabinfo.radix_tree_node.num_objs
      1062            +0.0%       1062        slabinfo.radix_tree_node.num_slabs
     87.50 ± 20%      +4.0%      91.00 ± 18%  slabinfo.request_queue.active_objs
      2.50 ± 20%      +4.0%       2.60 ± 18%  slabinfo.request_queue.active_slabs
     87.50 ± 20%      +4.0%      91.00 ± 18%  slabinfo.request_queue.num_objs
      2.50 ± 20%      +4.0%       2.60 ± 18%  slabinfo.request_queue.num_slabs
     46.00            +0.0%      46.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     46.00            +0.0%      46.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
    352.00            +0.0%     352.00        slabinfo.scsi_sense_cache.active_objs
     11.00            +0.0%      11.00        slabinfo.scsi_sense_cache.active_slabs
    352.00            +0.0%     352.00        slabinfo.scsi_sense_cache.num_objs
     11.00            +0.0%      11.00        slabinfo.scsi_sense_cache.num_slabs
      1407            -0.7%       1397        slabinfo.seq_file.active_objs
     41.40            -0.7%      41.11        slabinfo.seq_file.active_slabs
      1407            -0.7%       1397        slabinfo.seq_file.num_objs
     41.40            -0.7%      41.11        slabinfo.seq_file.num_slabs
      8021            -0.2%       8007        slabinfo.shared_policy_node.active_objs
     94.38            -0.2%      94.20        slabinfo.shared_policy_node.active_slabs
      8021            -0.2%       8007        slabinfo.shared_policy_node.num_objs
     94.38            -0.2%      94.20        slabinfo.shared_policy_node.num_slabs
      2346 ±  2%      -2.4%       2290 ±  3%  slabinfo.shmem_inode_cache.active_objs
     54.58 ±  2%      -2.4%      53.26 ±  3%  slabinfo.shmem_inode_cache.active_slabs
      2346 ±  2%      -2.4%       2290 ±  3%  slabinfo.shmem_inode_cache.num_objs
     54.58 ±  2%      -2.4%      53.26 ±  3%  slabinfo.shmem_inode_cache.num_slabs
      1053            -0.9%       1043        slabinfo.sighand_cache.active_objs
     70.23            -0.9%      69.58        slabinfo.sighand_cache.active_slabs
      1053            -0.9%       1043        slabinfo.sighand_cache.num_objs
     70.23            -0.9%      69.58        slabinfo.sighand_cache.num_slabs
      1711 ±  3%      -1.0%       1694 ±  3%  slabinfo.signal_cache.active_objs
     61.14 ±  3%      -0.9%      60.60 ±  3%  slabinfo.signal_cache.active_slabs
      1711 ±  3%      -0.9%       1696 ±  3%  slabinfo.signal_cache.num_objs
     61.14 ±  3%      -0.9%      60.60 ±  3%  slabinfo.signal_cache.num_slabs
      2441 ±  2%      +1.1%       2468 ±  3%  slabinfo.sigqueue.active_objs
     47.88 ±  2%      +1.1%      48.40 ±  3%  slabinfo.sigqueue.active_slabs
      2441 ±  2%      +1.1%       2468 ±  3%  slabinfo.sigqueue.num_objs
     47.88 ±  2%      +1.1%      48.40 ±  3%  slabinfo.sigqueue.num_slabs
    326.54 ±  8%      +2.0%     333.10 ± 14%  slabinfo.skbuff_ext_cache.active_objs
      7.77 ±  8%      +2.0%       7.93 ± 14%  slabinfo.skbuff_ext_cache.active_slabs
    326.54 ±  8%      +2.0%     333.10 ± 14%  slabinfo.skbuff_ext_cache.num_objs
      7.77 ±  8%      +2.0%       7.93 ± 14%  slabinfo.skbuff_ext_cache.num_slabs
      2389 ±  7%      +5.9%       2531 ±  7%  slabinfo.skbuff_head_cache.active_objs
     76.38 ±  7%      +4.2%      79.60 ±  7%  slabinfo.skbuff_head_cache.active_slabs
      2444 ±  7%      +4.2%       2547 ±  7%  slabinfo.skbuff_head_cache.num_objs
     76.38 ±  7%      +4.2%      79.60 ±  7%  slabinfo.skbuff_head_cache.num_slabs
      2454 ±  4%      +1.4%       2488 ±  7%  slabinfo.skbuff_small_head.active_objs
     49.62 ±  3%      +1.8%      50.50 ±  6%  slabinfo.skbuff_small_head.active_slabs
      2530 ±  3%      +1.8%       2575 ±  6%  slabinfo.skbuff_small_head.num_objs
     49.62 ±  3%      +1.8%      50.50 ±  6%  slabinfo.skbuff_small_head.num_slabs
      1506 ±  2%      +1.2%       1524 ±  2%  slabinfo.sock_inode_cache.active_objs
     38.62 ±  2%      +1.2%      39.10 ±  2%  slabinfo.sock_inode_cache.active_slabs
      1506 ±  2%      +1.2%       1524 ±  2%  slabinfo.sock_inode_cache.num_objs
     38.62 ±  2%      +1.2%      39.10 ±  2%  slabinfo.sock_inode_cache.num_slabs
      1045 ± 10%      +1.6%       1062 ±  8%  slabinfo.task_group.active_objs
     20.49 ± 10%      +1.6%      20.83 ±  8%  slabinfo.task_group.active_slabs
      1045 ± 10%      +1.6%       1062 ±  8%  slabinfo.task_group.num_objs
     20.49 ± 10%      +1.6%      20.83 ±  8%  slabinfo.task_group.num_slabs
    825.90            +1.0%     833.92        slabinfo.task_struct.active_objs
    826.76            +1.0%     834.85        slabinfo.task_struct.active_slabs
    826.76            +1.0%     834.85        slabinfo.task_struct.num_objs
    826.76            +1.0%     834.85        slabinfo.task_struct.num_slabs
    293.53 ±  6%      -5.6%     277.11 ±  9%  slabinfo.taskstats.active_objs
      7.93 ±  6%      -5.6%       7.49 ±  9%  slabinfo.taskstats.active_slabs
    293.53 ±  6%      -5.6%     277.11 ±  9%  slabinfo.taskstats.num_objs
      7.93 ±  6%      -5.6%       7.49 ±  9%  slabinfo.taskstats.num_slabs
      2294            +0.1%       2295        slabinfo.trace_event_file.active_objs
     49.88            +0.1%      49.90        slabinfo.trace_event_file.active_slabs
      2294            +0.1%       2295        slabinfo.trace_event_file.num_objs
     49.88            +0.1%      49.90        slabinfo.trace_event_file.num_slabs
    788.76 ±  4%      -0.2%     787.16 ±  6%  slabinfo.tracefs_inode_cache.active_objs
     15.78 ±  4%      -0.2%      15.74 ±  6%  slabinfo.tracefs_inode_cache.active_slabs
    788.76 ±  4%      -0.2%     787.16 ±  6%  slabinfo.tracefs_inode_cache.num_objs
     15.78 ±  4%      -0.2%      15.74 ±  6%  slabinfo.tracefs_inode_cache.num_slabs
     30.00            +0.0%      30.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     30.00            +0.0%      30.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
     74.00            -5.0%      70.30 ± 15%  slabinfo.uts_namespace.active_objs
      2.00            -5.0%       1.90 ± 15%  slabinfo.uts_namespace.active_slabs
     74.00            -5.0%      70.30 ± 15%  slabinfo.uts_namespace.num_objs
      2.00            -5.0%       1.90 ± 15%  slabinfo.uts_namespace.num_slabs
      8533 ±  2%      -0.8%       8462        slabinfo.vm_area_struct.active_objs
    197.16 ±  2%      -0.8%     195.49        slabinfo.vm_area_struct.active_slabs
      8674 ±  2%      -0.8%       8601        slabinfo.vm_area_struct.num_objs
    197.16 ±  2%      -0.8%     195.49        slabinfo.vm_area_struct.num_slabs
     11310 ±  2%      +0.5%      11367 ±  3%  slabinfo.vma_lock.active_objs
    113.38 ±  2%      +0.0%     113.38 ±  3%  slabinfo.vma_lock.active_slabs
     11564 ±  2%      +0.0%      11565 ±  3%  slabinfo.vma_lock.num_objs
    113.38 ±  2%      +0.0%     113.38 ±  3%  slabinfo.vma_lock.num_slabs
     50524            +0.1%      50562        slabinfo.vmap_area.active_objs
    903.07            +0.0%     903.44        slabinfo.vmap_area.active_slabs
     50571            +0.0%      50592        slabinfo.vmap_area.num_objs
    903.07            +0.0%     903.44        slabinfo.vmap_area.num_slabs
    143.69            +0.2%     144.05        slabinfo.xfrm_dst_cache.active_objs
      2.82            +0.2%       2.82        slabinfo.xfrm_dst_cache.active_slabs
    143.69            +0.2%     144.05        slabinfo.xfrm_dst_cache.num_objs
      2.82            +0.2%       2.82        slabinfo.xfrm_dst_cache.num_slabs
     20.08            -1.5       18.61        perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.btrfs_clone_files.btrfs_remap_file_range.do_clone_file_range.vfs_clone_file_range
     11.79 ±  2%      -0.9       10.85        perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.btrfs_clone_files.btrfs_remap_file_range.do_clone_file_range
     11.45 ±  2%      -0.9       10.53        perf-profile.calltrace.cycles-pp.btrfs_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.btrfs_clone_files.btrfs_remap_file_range
     16.01 ±  2%      -0.8       15.17 ±  3%  perf-profile.calltrace.cycles-pp.filemap_read_folio.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep
     15.67 ±  2%      -0.8       14.87 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_read_folio.filemap_read_folio.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep
      9.93 ±  2%      -0.6        9.38 ±  2%  perf-profile.calltrace.cycles-pp.memcmp.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep.btrfs_remap_file_range
     12.06 ±  2%      -0.6       11.51 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_do_readpage.btrfs_read_folio.filemap_read_folio.do_read_cache_folio.vfs_dedupe_file_range_compare
      4.16 ±  3%      -0.4        3.76 ±  3%  perf-profile.calltrace.cycles-pp.__clear_extent_bit.btrfs_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.btrfs_clone_files
     27.14 ±  4%      -0.4       26.75 ±  6%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.15 ±  4%      -0.4       26.77 ±  6%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.15 ±  4%      -0.4       26.77 ±  6%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     26.86 ±  4%      -0.4       26.51 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.47 ±  4%      -0.3       26.13 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      8.63 ±  2%      -0.3        8.29 ±  2%  perf-profile.calltrace.cycles-pp.filemap_add_folio.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep
      0.33 ± 77%      -0.3        0.07 ±300%  perf-profile.calltrace.cycles-pp.alloc_pages.folio_alloc.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep
      3.44 ±  4%      -0.3        3.18 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_lock_and_flush_ordered_range.btrfs_read_folio.filemap_read_folio.do_read_cache_folio.vfs_dedupe_file_range_compare
     23.72 ±  4%      -0.3       23.46 ±  5%  perf-profile.calltrace.cycles-pp.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.23 ±  3%      -0.3        2.98 ±  3%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.btrfs_clone_files.btrfs_remap_file_range.do_clone_file_range
      0.57 ±  3%      -0.2        0.32 ± 81%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.try_release_extent_mapping.btrfs_invalidate_folio
     27.67 ±  4%      -0.2       27.44 ±  6%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.61 ±  4%      -0.2        0.38 ± 65%  perf-profile.calltrace.cycles-pp.find_free_extent.btrfs_reserve_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range.btrfs_fallocate
      0.62 ±  9%      -0.2        0.40 ± 66%  perf-profile.calltrace.cycles-pp.clock_nanosleep
      0.26 ±100%      -0.2        0.05 ±300%  perf-profile.calltrace.cycles-pp.folio_mark_accessed.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep
      3.78 ±  2%      -0.2        3.58 ±  3%  perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.btrfs_clone_files.btrfs_remap_file_range.do_clone_file_range
      3.68 ±  2%      -0.2        3.48 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.truncate_inode_pages_range.btrfs_clone_files.btrfs_remap_file_range
      5.42 ±  2%      -0.2        5.22 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep
      2.47 ±  2%      -0.2        2.28 ±  5%  perf-profile.calltrace.cycles-pp.lock_extent.btrfs_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.btrfs_clone_files
      0.62 ±  7%      -0.2        0.43 ± 67%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.66 ±  9%      -0.2        0.48 ± 51%  perf-profile.calltrace.cycles-pp.set_page_extent_mapped.btrfs_do_readpage.btrfs_read_folio.filemap_read_folio.do_read_cache_folio
      0.62 ±  4%      -0.2        0.45 ± 50%  perf-profile.calltrace.cycles-pp.btrfs_reserve_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range.btrfs_fallocate.vfs_fallocate
      1.50 ±  5%      -0.2        1.32 ±  5%  perf-profile.calltrace.cycles-pp.clear_state_bit.__clear_extent_bit.btrfs_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range
      2.50 ±  4%      -0.2        2.33 ±  4%  perf-profile.calltrace.cycles-pp.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      2.37 ±  4%      -0.2        2.20 ±  4%  perf-profile.calltrace.cycles-pp.lock_extent.btrfs_lock_and_flush_ordered_range.btrfs_read_folio.filemap_read_folio.do_read_cache_folio
      2.28            -0.2        2.11 ±  5%  perf-profile.calltrace.cycles-pp.__set_extent_bit.lock_extent.btrfs_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range
      2.46 ±  4%      -0.2        2.29 ±  3%  perf-profile.calltrace.cycles-pp.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.20 ±  5%      -0.2        2.04 ±  5%  perf-profile.calltrace.cycles-pp.__set_extent_bit.lock_extent.btrfs_lock_and_flush_ordered_range.btrfs_read_folio.filemap_read_folio
      2.37 ±  3%      -0.2        2.21 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_fallocate.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64
      5.28            -0.1        5.14 ±  2%  perf-profile.calltrace.cycles-pp.memset_orig.btrfs_do_readpage.btrfs_read_folio.filemap_read_folio.do_read_cache_folio
      2.86 ±  3%      -0.1        2.72 ±  3%  perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep
      3.71 ±  2%      -0.1        3.57 ±  4%  perf-profile.calltrace.cycles-pp.__clear_extent_bit.btrfs_do_readpage.btrfs_read_folio.filemap_read_folio.do_read_cache_folio
      2.59 ±  4%      -0.1        2.46 ±  3%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.do_read_cache_folio.vfs_dedupe_file_range_compare
      0.13 ±173%      -0.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      1.14 ±  2%      -0.1        1.03 ±  3%  perf-profile.calltrace.cycles-pp.alloc_extent_state.__clear_extent_bit.btrfs_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range
      0.72 ±  5%      -0.1        0.61 ±  3%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__filemap_add_folio.filemap_add_folio.do_read_cache_folio.vfs_dedupe_file_range_compare
      0.95 ±  6%      -0.1        0.84 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_get_extent.btrfs_do_readpage.btrfs_read_folio.filemap_read_folio.do_read_cache_folio
      1.19 ±  3%      -0.1        1.09 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_prealloc_file_range.btrfs_fallocate.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl
      1.19 ±  3%      -0.1        1.09 ±  5%  perf-profile.calltrace.cycles-pp.__btrfs_prealloc_file_range.btrfs_prealloc_file_range.btrfs_fallocate.vfs_fallocate.ioctl_preallocate
      1.52 ±  5%      -0.1        1.42 ±  4%  perf-profile.calltrace.cycles-pp.xas_store.delete_from_page_cache_batch.truncate_inode_pages_range.btrfs_clone_files.btrfs_remap_file_range
      2.27 ±  5%      -0.1        2.17 ±  3%  perf-profile.calltrace.cycles-pp.try_release_extent_mapping.btrfs_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.btrfs_clone_files
     26.65 ±  4%      -0.1       26.56 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.88 ±  6%      -0.1        1.79 ±  4%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep
      0.41 ± 57%      -0.1        0.32 ± 81%  perf-profile.calltrace.cycles-pp.xa_get_order.__filemap_add_folio.filemap_add_folio.do_read_cache_folio.vfs_dedupe_file_range_compare
      0.84 ±  3%      -0.1        0.76 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_invalidate_folio.truncate_cleanup_folio
      1.75 ±  5%      -0.1        1.67 ±  3%  perf-profile.calltrace.cycles-pp.__clear_extent_bit.try_release_extent_mapping.btrfs_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range
      1.49 ±  5%      -0.1        1.40 ±  4%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.filemap_add_folio.do_read_cache_folio
      0.72 ±  5%      -0.1        0.63 ±  6%  perf-profile.calltrace.cycles-pp.clear_page_extent_mapped.btrfs_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.btrfs_clone_files
      0.87 ±  3%      -0.1        0.79 ±  5%  perf-profile.calltrace.cycles-pp.filemap_unaccount_folio.delete_from_page_cache_batch.truncate_inode_pages_range.btrfs_clone_files.btrfs_remap_file_range
      0.98 ±  5%      -0.1        0.90 ±  6%  perf-profile.calltrace.cycles-pp.alloc_extent_state.__set_extent_bit.lock_extent.btrfs_lock_and_flush_ordered_range.btrfs_read_folio
      0.65 ±  6%      -0.1        0.57 ±  7%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.filemap_unaccount_folio.delete_from_page_cache_batch.truncate_inode_pages_range.btrfs_clone_files
      1.60 ±  7%      -0.1        1.53 ±  4%  perf-profile.calltrace.cycles-pp.filemap_get_entry.__filemap_get_folio.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep
      0.07 ±264%      -0.1        0.00        perf-profile.calltrace.cycles-pp.end_page_read.btrfs_do_readpage.btrfs_read_folio.filemap_read_folio.do_read_cache_folio
      1.06 ±  2%      -0.1        1.00 ±  6%  perf-profile.calltrace.cycles-pp.alloc_extent_state.__set_extent_bit.lock_extent.btrfs_invalidate_folio.truncate_cleanup_folio
      0.06 ±264%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__wake_up.clear_state_bit.__clear_extent_bit.btrfs_invalidate_folio.truncate_cleanup_folio
      1.62 ±  3%      -0.1        1.56 ±  5%  perf-profile.calltrace.cycles-pp.clear_state_bit.__clear_extent_bit.btrfs_do_readpage.btrfs_read_folio.filemap_read_folio
      0.06 ±264%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__wake_up.clear_state_bit.__clear_extent_bit.btrfs_do_readpage.btrfs_read_folio
      0.06 ±264%      -0.1        0.00        perf-profile.calltrace.cycles-pp.folio_unlock.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep.btrfs_remap_file_range
      0.68 ± 16%      -0.1        0.62 ±  8%  perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.__filemap_get_folio.do_read_cache_folio.vfs_dedupe_file_range_compare
      0.67 ±  8%      -0.1        0.62 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_replace_file_extents.btrfs_clone.btrfs_extent_same_range.btrfs_remap_file_range.vfs_dedupe_file_range_one
      0.79 ±  3%      -0.1        0.74 ±  6%  perf-profile.calltrace.cycles-pp.alloc_extent_state.__clear_extent_bit.try_release_extent_mapping.btrfs_invalidate_folio.truncate_cleanup_folio
      0.72 ±  7%      -0.0        0.67 ±  6%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.lock_extent.btrfs_lock_and_flush_ordered_range
      0.78 ±  4%      -0.0        0.74 ±  5%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.lock_extent.btrfs_invalidate_folio
      0.74 ±  5%      -0.0        0.70 ±  6%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.ioctl.stress_run
      0.65 ±  4%      -0.0        0.61 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_lookup_ordered_range.btrfs_lock_and_flush_ordered_range.btrfs_read_folio.filemap_read_folio.do_read_cache_folio
      0.67 ±  4%      -0.0        0.63 ±  7%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.stress_run
      0.20 ±129%      -0.0        0.16 ±152%  perf-profile.calltrace.cycles-pp.btrfs_insert_replace_extent.btrfs_replace_file_extents.btrfs_clone.btrfs_clone_files.btrfs_remap_file_range
     41.84 ±  2%      -0.0       41.80 ±  2%  perf-profile.calltrace.cycles-pp.generic_remap_file_range_prep.btrfs_remap_file_range.vfs_dedupe_file_range_one.vfs_dedupe_file_range.do_vfs_ioctl
     41.84 ±  2%      -0.0       41.80 ±  2%  perf-profile.calltrace.cycles-pp.__generic_remap_file_range_prep.generic_remap_file_range_prep.btrfs_remap_file_range.vfs_dedupe_file_range_one.vfs_dedupe_file_range
     41.78 ±  2%      -0.0       41.75 ±  2%  perf-profile.calltrace.cycles-pp.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep.btrfs_remap_file_range.vfs_dedupe_file_range_one
      0.93 ±  4%      -0.0        0.90 ±  5%  perf-profile.calltrace.cycles-pp.find_lock_entries.truncate_inode_pages_range.btrfs_clone_files.btrfs_remap_file_range.do_clone_file_range
      1.23 ±  4%      -0.0        1.20 ±  2%  perf-profile.calltrace.cycles-pp.free_unref_page_list.release_pages.__folio_batch_release.truncate_inode_pages_range.btrfs_clone_files
      1.12 ±  3%      -0.0        1.10 ±  4%  perf-profile.calltrace.cycles-pp.xas_store.__filemap_add_folio.filemap_add_folio.do_read_cache_folio.vfs_dedupe_file_range_compare
      1.26 ±  4%      -0.0        1.23 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_replace_file_extents.btrfs_clone.btrfs_clone_files.btrfs_remap_file_range.do_clone_file_range
      0.90 ±  3%      -0.0        0.90 ±  7%  perf-profile.calltrace.cycles-pp.alloc_extent_state.__clear_extent_bit.btrfs_do_readpage.btrfs_read_folio.filemap_read_folio
      1.27 ±  2%      -0.0        1.27 ±  6%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.do_read_cache_folio.vfs_dedupe_file_range_compare
      0.65 ±  6%      +0.0        0.65 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_punch_hole.btrfs_fallocate.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl
      1.12 ±  6%      +0.0        1.14 ± 10%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.66 ±  3%      +0.0        0.67 ±  6%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_do_readpage.btrfs_read_folio
      1.39 ±  7%      +0.0        1.42 ± 10%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.13 ±173%      +0.0        0.16 ±152%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      1.40 ±  7%      +0.0        1.44 ± 10%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.60 ±  7%      +0.0        0.64 ±  9%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.76 ±  4%      +0.0        0.80 ±  9%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
     42.89 ±  2%      +0.0       42.94 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_remap_file_range.vfs_dedupe_file_range_one.vfs_dedupe_file_range.do_vfs_ioctl.__x64_sys_ioctl
      0.68 ±  5%      +0.0        0.73 ±  9%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.69 ±  5%      +0.1        0.74 ±  9%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      2.02 ±  7%      +0.1        2.07 ±  9%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue
      0.00            +0.1        0.05 ±300%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.do_read_cache_folio
     42.93 ±  2%      +0.1       42.98 ±  2%  perf-profile.calltrace.cycles-pp.vfs_dedupe_file_range.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     42.92 ±  2%      +0.1       42.97 ±  2%  perf-profile.calltrace.cycles-pp.vfs_dedupe_file_range_one.vfs_dedupe_file_range.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      0.49 ± 38%      +0.1        0.55 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_drop_extents.btrfs_replace_file_extents.btrfs_clone.btrfs_clone_files.btrfs_remap_file_range
      1.85 ±  9%      +0.1        1.91 ±  9%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.13 ±173%      +0.1        0.21 ±122%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      1.00 ±  7%      +0.1        1.08 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_extent_same_range.btrfs_remap_file_range.vfs_dedupe_file_range_one.vfs_dedupe_file_range.do_vfs_ioctl
      0.92 ±  7%      +0.1        1.01 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_clone.btrfs_extent_same_range.btrfs_remap_file_range.vfs_dedupe_file_range_one.vfs_dedupe_file_range
      0.06 ±264%      +0.1        0.16 ±152%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_list.release_pages.__folio_batch_release.truncate_inode_pages_range.btrfs_clone_files
      0.00            +0.1        0.10 ±200%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
      0.34 ±195%      +0.2        0.58 ±114%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.34 ±195%      +0.3        0.59 ±114%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.34 ±195%      +0.3        0.60 ±115%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      0.34 ±195%      +0.3        0.60 ±115%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      0.34 ±195%      +0.3        0.60 ±115%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      0.34 ±195%      +0.3        0.60 ±115%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.34 ±195%      +0.3        0.60 ±115%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.34 ±195%      +0.3        0.60 ±115%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.34 ±195%      +0.3        0.60 ±115%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
     70.99            +0.3       71.33 ±  2%  perf-profile.calltrace.cycles-pp.stress_run
     70.59            +0.4       70.96 ±  2%  perf-profile.calltrace.cycles-pp.ioctl.stress_run
     69.39            +0.5       69.86 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl.stress_run
     68.99            +0.5       69.46 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.stress_run
     68.25            +0.5       68.76 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.stress_run
     22.27            +0.6       22.89 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_remap_file_range.do_clone_file_range.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl
     22.35            +0.6       22.97 ±  2%  perf-profile.calltrace.cycles-pp.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.32            +0.6       22.94 ±  2%  perf-profile.calltrace.cycles-pp.do_clone_file_range.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl
     21.97            +0.6       22.59 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_clone_files.btrfs_remap_file_range.do_clone_file_range.vfs_clone_file_range.ioctl_file_clone
     22.34            +0.6       22.96 ±  2%  perf-profile.calltrace.cycles-pp.vfs_clone_file_range.ioctl_file_clone.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
     29.94 ±  2%      +0.6       30.58 ±  3%  perf-profile.calltrace.cycles-pp.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep.btrfs_remap_file_range
     65.60            +0.7       66.27 ±  2%  perf-profile.calltrace.cycles-pp.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.00            +0.8        0.85 ±  8%  perf-profile.calltrace.cycles-pp.__list_del_entry_valid_or_report.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
      0.00            +1.5        1.51 ±  6%  perf-profile.calltrace.cycles-pp.__free_one_page.free_pcppages_bulk.free_unref_page_commit.free_unref_page.btrfs_clone
      0.89 ±  7%      +1.9        2.80 ±  5%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.folio_alloc.do_read_cache_folio
      2.57 ±  3%      +2.0        4.54 ±  5%  perf-profile.calltrace.cycles-pp.folio_alloc.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep.generic_remap_file_range_prep
      1.19 ±  6%      +2.0        3.17 ±  5%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.folio_alloc.do_read_cache_folio.vfs_dedupe_file_range_compare
      1.91 ±  3%      +2.0        3.90 ±  4%  perf-profile.calltrace.cycles-pp.__alloc_pages.folio_alloc.do_read_cache_folio.vfs_dedupe_file_range_compare.__generic_remap_file_range_prep
      0.00            +2.0        1.99 ±  5%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages
      1.67 ±  4%      +2.1        3.76 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_clone.btrfs_clone_files.btrfs_remap_file_range.do_clone_file_range.vfs_clone_file_range
      0.00            +2.1        2.09 ±  4%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_page.btrfs_clone.btrfs_clone_files
      0.00            +2.1        2.12 ±  4%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.btrfs_clone.btrfs_clone_files.btrfs_remap_file_range
      0.00            +2.1        2.14 ±  4%  perf-profile.calltrace.cycles-pp.free_unref_page.btrfs_clone.btrfs_clone_files.btrfs_remap_file_range.do_clone_file_range
      0.00            +2.3        2.29 ±  6%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages.folio_alloc
     20.14            -1.5       18.68        perf-profile.children.cycles-pp.truncate_inode_pages_range
     11.79 ±  2%      -0.9       10.85        perf-profile.children.cycles-pp.truncate_cleanup_folio
     11.57 ±  2%      -0.9       10.64        perf-profile.children.cycles-pp.btrfs_invalidate_folio
     16.02 ±  2%      -0.8       15.18 ±  3%  perf-profile.children.cycles-pp.filemap_read_folio
     15.69 ±  2%      -0.8       14.89 ±  3%  perf-profile.children.cycles-pp.btrfs_read_folio
     10.00 ±  2%      -0.7        9.34 ±  2%  perf-profile.children.cycles-pp.__clear_extent_bit
      9.99 ±  2%      -0.6        9.43 ±  2%  perf-profile.children.cycles-pp.memcmp
     12.08 ±  2%      -0.5       11.53 ±  3%  perf-profile.children.cycles-pp.btrfs_do_readpage
     27.15 ±  4%      -0.4       26.77 ±  6%  perf-profile.children.cycles-pp.start_secondary
      5.00 ±  2%      -0.4        4.63 ±  3%  perf-profile.children.cycles-pp.lock_extent
      4.82 ±  2%      -0.4        4.46 ±  3%  perf-profile.children.cycles-pp.__set_extent_bit
      5.19 ±  2%      -0.3        4.84 ±  3%  perf-profile.children.cycles-pp.alloc_extent_state
      8.65 ±  2%      -0.3        8.32 ±  2%  perf-profile.children.cycles-pp.filemap_add_folio
      3.27 ±  3%      -0.3        3.01 ±  3%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      4.23 ±  2%      -0.3        3.97 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc
      3.45 ±  4%      -0.3        3.20 ±  3%  perf-profile.children.cycles-pp.btrfs_lock_and_flush_ordered_range
      3.40 ±  2%      -0.2        3.15 ±  4%  perf-profile.children.cycles-pp.clear_state_bit
     27.67 ±  4%      -0.2       27.44 ±  6%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     27.67 ±  4%      -0.2       27.44 ±  6%  perf-profile.children.cycles-pp.cpu_startup_entry
     27.66 ±  4%      -0.2       27.43 ±  6%  perf-profile.children.cycles-pp.do_idle
     23.81 ±  4%      -0.2       23.59 ±  5%  perf-profile.children.cycles-pp.intel_idle_ibrs
      3.97 ±  2%      -0.2        3.76 ±  3%  perf-profile.children.cycles-pp.release_pages
      5.54 ±  2%      -0.2        5.33 ±  2%  perf-profile.children.cycles-pp.__filemap_add_folio
     27.38 ±  4%      -0.2       27.18 ±  6%  perf-profile.children.cycles-pp.cpuidle_idle_call
      3.78 ±  2%      -0.2        3.58 ±  3%  perf-profile.children.cycles-pp.__folio_batch_release
     26.97 ±  4%      -0.2       26.78 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
     26.97 ±  4%      -0.2       26.78 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
      1.42 ±  3%      -0.2        1.24 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      2.50 ±  4%      -0.2        2.33 ±  4%  perf-profile.children.cycles-pp.ioctl_preallocate
      0.86 ±  6%      -0.2        0.69 ±  7%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      2.46 ±  4%      -0.2        2.30 ±  3%  perf-profile.children.cycles-pp.vfs_fallocate
      2.38 ±  3%      -0.2        2.21 ±  4%  perf-profile.children.cycles-pp.btrfs_fallocate
      5.31            -0.1        5.16 ±  2%  perf-profile.children.cycles-pp.memset_orig
      2.88 ±  3%      -0.1        2.74 ±  3%  perf-profile.children.cycles-pp.folio_add_lru
      2.67 ±  4%      -0.1        2.53 ±  3%  perf-profile.children.cycles-pp.folio_batch_move_lru
      1.26 ±  2%      -0.1        1.13 ±  3%  perf-profile.children.cycles-pp.free_extent_state
      2.70 ±  4%      -0.1        2.58 ±  3%  perf-profile.children.cycles-pp.xas_store
      1.10 ±  5%      -0.1        0.99 ±  7%  perf-profile.children.cycles-pp.btrfs_get_extent
      1.19 ±  3%      -0.1        1.09 ±  5%  perf-profile.children.cycles-pp.btrfs_prealloc_file_range
      1.19 ±  3%      -0.1        1.09 ±  5%  perf-profile.children.cycles-pp.__btrfs_prealloc_file_range
      2.74 ±  2%      -0.1        2.64 ±  3%  perf-profile.children.cycles-pp.btrfs_replace_file_extents
      0.96 ±  3%      -0.1        0.87 ±  5%  perf-profile.children.cycles-pp.__wake_up
      2.28 ±  5%      -0.1        2.18 ±  2%  perf-profile.children.cycles-pp.try_release_extent_mapping
      1.93 ±  5%      -0.1        1.83 ±  3%  perf-profile.children.cycles-pp.__filemap_get_folio
      1.56 ±  5%      -0.1        1.46 ±  3%  perf-profile.children.cycles-pp.lru_add_fn
      0.62 ±  9%      -0.1        0.53 ± 17%  perf-profile.children.cycles-pp.clock_nanosleep
      1.33 ±  9%      -0.1        1.24 ±  4%  perf-profile.children.cycles-pp.xas_load
      0.72 ±  5%      -0.1        0.63 ±  6%  perf-profile.children.cycles-pp.clear_page_extent_mapped
      0.66 ±  9%      -0.1        0.58 ± 13%  perf-profile.children.cycles-pp.set_page_extent_mapped
      0.61 ±  4%      -0.1        0.53 ±  7%  perf-profile.children.cycles-pp.find_free_extent
      0.62 ±  4%      -0.1        0.54 ±  7%  perf-profile.children.cycles-pp.btrfs_reserve_extent
      0.88 ±  3%      -0.1        0.81 ±  4%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.63 ±  4%      -0.1        0.55 ±  7%  perf-profile.children.cycles-pp.__cond_resched
      1.63 ±  7%      -0.1        1.56 ±  4%  perf-profile.children.cycles-pp.filemap_get_entry
      0.46 ±  8%      -0.1        0.39 ±  8%  perf-profile.children.cycles-pp.end_page_read
      1.59 ±  4%      -0.1        1.52 ±  5%  perf-profile.children.cycles-pp.kmem_cache_free
      0.89 ±  4%      -0.1        0.83 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.97 ±  3%      -0.1        0.92 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.64 ±  9%      -0.1        0.58 ±  7%  perf-profile.children.cycles-pp.cache_state_if_flags
      0.47 ±  6%      -0.1        0.41 ±  8%  perf-profile.children.cycles-pp.__entry_text_start
      1.01 ±  3%      -0.1        0.96 ±  6%  perf-profile.children.cycles-pp.btrfs_insert_replace_extent
      0.81 ±  4%      -0.1        0.76 ±  5%  perf-profile.children.cycles-pp.folio_unlock
      0.33 ±  4%      -0.0        0.28 ± 12%  perf-profile.children.cycles-pp.try_charge_memcg
      0.27 ± 11%      -0.0        0.22 ±  9%  perf-profile.children.cycles-pp._raw_read_lock
      0.33 ± 11%      -0.0        0.28 ± 15%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      0.68 ±  4%      -0.0        0.63 ±  2%  perf-profile.children.cycles-pp.btrfs_lookup_ordered_range
      0.31 ± 17%      -0.0        0.26 ± 16%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.30 ± 13%      -0.0        0.26 ± 14%  perf-profile.children.cycles-pp.common_nsleep
     41.92 ±  2%      -0.0       41.88 ±  2%  perf-profile.children.cycles-pp.__generic_remap_file_range_prep
      2.01 ±  3%      -0.0        1.96 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      0.43 ± 10%      -0.0        0.38 ± 13%  perf-profile.children.cycles-pp.__schedule
     41.96 ±  2%      -0.0       41.92 ±  2%  perf-profile.children.cycles-pp.generic_remap_file_range_prep
      0.42 ±  6%      -0.0        0.38 ±  4%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.81 ±  7%      -0.0        0.77 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.30 ± 14%      -0.0        0.26 ± 14%  perf-profile.children.cycles-pp.hrtimer_nanosleep
      0.63 ±  7%      -0.0        0.59 ± 18%  perf-profile.children.cycles-pp.intel_idle
      0.29 ±  5%      -0.0        0.25 ±  9%  perf-profile.children.cycles-pp.btrfs_update_inode
      0.59 ±  7%      -0.0        0.55 ±  7%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     41.82 ±  2%      -0.0       41.78 ±  2%  perf-profile.children.cycles-pp.vfs_dedupe_file_range_compare
      0.22 ± 12%      -0.0        0.18 ± 11%  perf-profile.children.cycles-pp.btrfs_page_clear_checked
      0.71 ±  8%      -0.0        0.68 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.28 ±  9%      -0.0        0.25 ± 11%  perf-profile.children.cycles-pp.schedule
      0.79 ± 12%      -0.0        0.76 ±  7%  perf-profile.children.cycles-pp.xas_descend
      0.47 ±  3%      -0.0        0.44 ±  6%  perf-profile.children.cycles-pp.insert_prealloc_file_extent
      0.35 ± 11%      -0.0        0.32 ± 10%  perf-profile.children.cycles-pp.__init_waitqueue_head
      0.34 ± 10%      -0.0        0.31 ±  6%  perf-profile.children.cycles-pp.btrfs_lookup_first_ordered_range
      0.53 ±  6%      -0.0        0.50 ± 12%  perf-profile.children.cycles-pp.alloc_pages
      0.28 ± 13%      -0.0        0.24 ± 16%  perf-profile.children.cycles-pp.do_nanosleep
      0.31 ± 11%      -0.0        0.28 ±  8%  perf-profile.children.cycles-pp.xas_clear_mark
      0.12 ± 11%      -0.0        0.09 ± 41%  perf-profile.children.cycles-pp.activate_task
      0.23 ±  8%      -0.0        0.20 ± 10%  perf-profile.children.cycles-pp.filemap_free_folio
      0.96 ±  4%      -0.0        0.93 ±  5%  perf-profile.children.cycles-pp.find_lock_entries
      0.28 ± 11%      -0.0        0.25 ± 12%  perf-profile.children.cycles-pp.__lookup_extent_mapping
      0.03 ±102%      -0.0        0.00        perf-profile.children.cycles-pp.btrfs_free_path
      0.28 ± 11%      -0.0        0.25 ± 11%  perf-profile.children.cycles-pp.btrfs_page_set_uptodate
      0.28 ± 11%      -0.0        0.25 ± 11%  perf-profile.children.cycles-pp.btrfs_wait_ordered_range
      0.22 ±  9%      -0.0        0.19 ± 10%  perf-profile.children.cycles-pp.rcu_all_qs
      0.31 ± 10%      -0.0        0.28 ± 10%  perf-profile.children.cycles-pp.btrfs_del_items
      0.16 ±  7%      -0.0        0.13 ± 14%  perf-profile.children.cycles-pp.__tree_search
      0.37 ±  6%      -0.0        0.34 ± 12%  perf-profile.children.cycles-pp.setup_items_for_insert
      0.22 ±  9%      -0.0        0.19 ±  8%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.15 ± 11%      -0.0        0.12 ± 15%  perf-profile.children.cycles-pp.read_tsc
      0.25 ± 12%      -0.0        0.23 ±  6%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.19 ±  8%      -0.0        0.16 ±  8%  perf-profile.children.cycles-pp.clone_finish_inode_update
      0.20 ±  9%      -0.0        0.18 ± 16%  perf-profile.children.cycles-pp.try_to_wake_up
      0.11 ± 12%      -0.0        0.09 ± 41%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.11 ± 13%      -0.0        0.09 ± 22%  perf-profile.children.cycles-pp.update_load_avg
      0.06 ± 13%      -0.0        0.04 ± 66%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.04 ± 58%      -0.0        0.02 ±153%  perf-profile.children.cycles-pp.xas_nomem
      0.10 ± 11%      -0.0        0.08 ± 41%  perf-profile.children.cycles-pp.enqueue_entity
      0.44 ±  6%      -0.0        0.42 ±  2%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.11 ± 13%      -0.0        0.09 ± 18%  perf-profile.children.cycles-pp.btrfs_put_block_group
      0.10 ± 18%      -0.0        0.08 ± 18%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.26 ±  3%      -0.0        0.23 ±  7%  perf-profile.children.cycles-pp.xas_find
      0.48 ±  7%      -0.0        0.45 ±  6%  perf-profile.children.cycles-pp.xas_find_conflict
      0.14 ± 15%      -0.0        0.12 ± 28%  perf-profile.children.cycles-pp.hrtimer_wakeup
      0.14 ± 15%      -0.0        0.12 ± 18%  perf-profile.children.cycles-pp.vfs_fileattr_set
      0.54 ±  6%      -0.0        0.52 ±  6%  perf-profile.children.cycles-pp.xa_get_order
      0.32 ±  7%      -0.0        0.30 ±  9%  perf-profile.children.cycles-pp.btrfs_is_subpage
      0.02 ±100%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.26 ±  7%      -0.0        0.24 ±  8%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.06 ± 63%      -0.0        0.04 ±111%  perf-profile.children.cycles-pp.cleanup_ref_head
      0.15 ± 12%      -0.0        0.13 ± 12%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.13 ± 11%      -0.0        0.11 ± 28%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.37 ± 11%      -0.0        0.35 ±  8%  perf-profile.children.cycles-pp.start_transaction
      0.62 ±  8%      -0.0        0.60 ±  8%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.52 ±  6%      -0.0        0.50 ±  8%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      0.14 ± 15%      -0.0        0.12 ± 17%  perf-profile.children.cycles-pp.intel_idle_irq
      0.06 ± 18%      -0.0        0.04 ± 66%  perf-profile.children.cycles-pp.wake_up_q
      0.51 ±  6%      -0.0        0.49 ±  7%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.08 ± 30%      -0.0        0.07 ± 74%  perf-profile.children.cycles-pp.process_one_work
      0.07 ± 64%      -0.0        0.05 ± 96%  perf-profile.children.cycles-pp.btrfs_preempt_reclaim_metadata_space
      0.07 ± 64%      -0.0        0.05 ± 96%  perf-profile.children.cycles-pp.flush_space
      0.07 ± 64%      -0.0        0.05 ± 96%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs
      0.07 ± 64%      -0.0        0.05 ± 96%  perf-profile.children.cycles-pp.__btrfs_run_delayed_refs
      0.03 ±101%      -0.0        0.01 ±206%  perf-profile.children.cycles-pp.tick_sched_do_timer
      1.24 ±  4%      -0.0        1.22 ±  3%  perf-profile.children.cycles-pp.free_unref_page_list
      0.36 ±  9%      -0.0        0.35 ±  7%  perf-profile.children.cycles-pp.set_state_bits
      0.15 ±  8%      -0.0        0.13 ± 11%  perf-profile.children.cycles-pp.__fxstat64
      0.05 ± 38%      -0.0        0.04 ± 65%  perf-profile.children.cycles-pp.mutex_unlock
      0.36 ±  7%      -0.0        0.34 ±  7%  perf-profile.children.cycles-pp.should_failslab
      0.10 ± 16%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.memmove_extent_buffer
      0.39 ± 10%      -0.0        0.37 ±  3%  perf-profile.children.cycles-pp.test_range_bit
      0.06 ± 15%      -0.0        0.05 ± 53%  perf-profile.children.cycles-pp.btrfs_get_64
      0.12 ± 15%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.file_modified
      0.12 ± 14%      -0.0        0.10 ± 16%  perf-profile.children.cycles-pp.btrfs_get_block_group
      1.20 ±  5%      -0.0        1.18 ±  5%  perf-profile.children.cycles-pp.btrfs_drop_extents
      0.19 ± 11%      -0.0        0.17 ±  9%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.03 ±100%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.free_extent_buffer
      1.52 ±  6%      -0.0        1.51 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.12 ± 13%      -0.0        0.10 ± 13%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.13 ± 11%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.11 ± 18%      -0.0        0.10 ± 15%  perf-profile.children.cycles-pp.__btrfs_tree_lock
      0.02 ±131%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.btrfs_lookup_first_ordered_extent
      0.09 ± 22%      -0.0        0.08 ± 62%  perf-profile.children.cycles-pp.worker_thread
      0.18 ±  9%      -0.0        0.16 ±  8%  perf-profile.children.cycles-pp.__write_extent_buffer
      0.07 ± 17%      -0.0        0.06 ± 37%  perf-profile.children.cycles-pp.btrfs_duplicate_item
      0.26 ± 10%      -0.0        0.24 ±  6%  perf-profile.children.cycles-pp.add_delayed_ref_head
      0.18 ± 18%      -0.0        0.17 ± 14%  perf-profile.children.cycles-pp.llseek
      0.14 ± 21%      -0.0        0.12 ± 22%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.07 ± 14%      -0.0        0.05 ± 35%  perf-profile.children.cycles-pp.memcpy_extent_buffer
      0.07 ± 21%      -0.0        0.06 ± 51%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.56 ±  5%      -0.0        0.55 ±  5%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.14 ± 13%      -0.0        0.12 ± 11%  perf-profile.children.cycles-pp.__btrfs_qgroup_release_data
      0.02 ±129%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.policy_nodemask
      0.02 ±129%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.set_next_entity
      0.12 ±  9%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      0.01 ±173%      -0.0        0.00        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.01 ±173%      -0.0        0.00        perf-profile.children.cycles-pp.inode_needs_update_time
      0.02 ±130%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.set_extent_buffer_dirty
      0.52 ±  3%      -0.0        0.50 ±  6%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.17 ± 16%      -0.0        0.16 ± 22%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.09 ± 10%      -0.0        0.08 ± 20%  perf-profile.children.cycles-pp.btrfs_set_token_32
      0.05 ± 40%      -0.0        0.04 ± 67%  perf-profile.children.cycles-pp.work_busy
      0.18 ± 13%      -0.0        0.17 ± 16%  perf-profile.children.cycles-pp.btrfs_drop_extent_map_range
      0.14 ± 15%      -0.0        0.13 ± 13%  perf-profile.children.cycles-pp.filemap_alloc_folio
      0.19 ±  9%      -0.0        0.18 ± 13%  perf-profile.children.cycles-pp.btrfs_set_delalloc_extent
      0.11 ± 17%      -0.0        0.10 ± 20%  perf-profile.children.cycles-pp.btrfs_fileattr_set
      0.12 ± 18%      -0.0        0.11 ± 11%  perf-profile.children.cycles-pp.should_fail_alloc_page
      0.11 ± 13%      -0.0        0.10 ± 20%  perf-profile.children.cycles-pp.down_read
      0.22 ±  5%      -0.0        0.21 ±  7%  perf-profile.children.cycles-pp.uncharge_batch
      0.12 ± 18%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.btrfs_lock_root_node
      0.02 ±129%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.20 ±  8%      -0.0        0.19 ± 14%  perf-profile.children.cycles-pp.policy_node
      0.14 ± 10%      -0.0        0.13 ± 11%  perf-profile.children.cycles-pp.btrfs_alloc_reserved_file_extent
      0.14 ±  9%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.07 ± 16%      -0.0        0.06 ± 18%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.06 ± 13%      -0.0        0.05 ± 36%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.08 ± 13%      -0.0        0.08 ± 17%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.08 ± 13%      -0.0        0.07 ± 53%  perf-profile.children.cycles-pp.perf_rotate_context
      0.02 ±129%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.read
      0.11 ± 11%      -0.0        0.10 ± 19%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
      0.08 ± 14%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      0.29 ±  9%      -0.0        0.28 ±  9%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.40 ±  9%      -0.0        0.39 ±  7%  perf-profile.children.cycles-pp.xas_start
      0.16 ± 16%      -0.0        0.15 ± 18%  perf-profile.children.cycles-pp.schedule_idle
      0.08 ± 27%      -0.0        0.07 ± 42%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.08 ± 19%      -0.0        0.07 ± 42%  perf-profile.children.cycles-pp.sched_clock
      0.10 ± 18%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.dequeue_entity
      0.06 ± 17%      -0.0        0.05 ± 55%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.07 ± 23%      -0.0        0.06 ± 18%  perf-profile.children.cycles-pp.btrfs_fdatawrite_range
      0.07 ± 16%      -0.0        0.06 ± 40%  perf-profile.children.cycles-pp.rwsem_wake
      0.01 ±173%      -0.0        0.01 ±299%  perf-profile.children.cycles-pp.__switch_to_asm
      0.01 ±264%      -0.0        0.00        perf-profile.children.cycles-pp.update_rq_clock
      0.01 ±264%      -0.0        0.00        perf-profile.children.cycles-pp.rep_movs_alternative
      0.11 ± 20%      -0.0        0.10 ± 17%  perf-profile.children.cycles-pp.rebalance_domains
      0.11 ± 23%      -0.0        0.10 ± 24%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.23 ±  9%      -0.0        0.22 ±  6%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
      0.12 ± 20%      -0.0        0.12 ± 38%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.06 ± 39%      -0.0        0.05 ± 54%  perf-profile.children.cycles-pp.task_tick_fair
      0.40 ±  5%      -0.0        0.40 ±  6%  perf-profile.children.cycles-pp.wait_subpage_spinlock
      0.12 ± 21%      -0.0        0.12 ± 38%  perf-profile.children.cycles-pp.ret_from_fork
      0.03 ±100%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.12 ± 20%      -0.0        0.12 ± 40%  perf-profile.children.cycles-pp.kthread
      0.07 ± 19%      -0.0        0.07 ± 22%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.07 ± 19%      -0.0        0.06 ± 12%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.01 ±264%      -0.0        0.00        perf-profile.children.cycles-pp.btrfs_del_csums
      0.01 ±264%      -0.0        0.00        perf-profile.children.cycles-pp.ksys_read
      0.01 ±264%      -0.0        0.00        perf-profile.children.cycles-pp.btrfs_get_8
      0.01 ±264%      -0.0        0.00        perf-profile.children.cycles-pp.__switch_to
      0.01 ±264%      -0.0        0.00        perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.01 ±264%      -0.0        0.00        perf-profile.children.cycles-pp.assert_eb_page_uptodate
      0.01 ±264%      -0.0        0.00        perf-profile.children.cycles-pp.__slab_free
      0.18 ± 14%      -0.0        0.17 ± 28%  perf-profile.children.cycles-pp.btrfs_clear_delalloc_extent
      0.15 ±  8%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.xas_alloc
      0.12 ±  5%      -0.0        0.12 ± 10%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.08 ± 19%      -0.0        0.08 ± 22%  perf-profile.children.cycles-pp.find_busiest_group
      0.10 ±  7%      -0.0        0.09 ± 20%  perf-profile.children.cycles-pp._find_first_bit
      0.04 ± 78%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.read_cache_folio
      0.09 ± 14%      -0.0        0.09 ± 16%  perf-profile.children.cycles-pp.perf_pmu_nop_void
      0.03 ±100%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.03 ± 78%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.read_extent_buffer
      0.09 ± 16%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.04 ± 58%      -0.0        0.04 ± 82%  perf-profile.children.cycles-pp.xas_find_marked
      0.05 ± 60%      -0.0        0.04 ± 50%  perf-profile.children.cycles-pp.btrfs_update_root_times
      0.11 ± 13%      -0.0        0.11 ± 15%  perf-profile.children.cycles-pp.filemap_fdatawait_range
      0.17 ±  7%      -0.0        0.16 ± 13%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.21 ±  7%      -0.0        0.20 ±  6%  perf-profile.children.cycles-pp.rb_next
      0.08 ± 20%      -0.0        0.08 ± 25%  perf-profile.children.cycles-pp.update_sd_lb_stats
      1.85 ±  7%      -0.0        1.85 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.09 ± 14%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.__memmove
      0.07 ± 12%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.btrfs_alloc_block_rsv
      0.06 ± 20%      -0.0        0.06 ± 10%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.08 ± 17%      -0.0        0.08 ± 19%  perf-profile.children.cycles-pp.leaf_space_used
      0.08 ± 13%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.filemap_get_folios_tag
      0.02 ±129%      -0.0        0.02 ±153%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.09 ± 15%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.rcu_do_batch
      0.01 ±174%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.mutex_lock
      0.04 ± 79%      -0.0        0.04 ± 67%  perf-profile.children.cycles-pp._copy_from_user
      0.10 ± 28%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.memcg_check_events
      0.02 ±129%      -0.0        0.02 ±153%  perf-profile.children.cycles-pp.filemap_write_and_wait_range
      0.16 ± 18%      -0.0        0.16 ± 15%  perf-profile.children.cycles-pp.btrfs_release_path
      0.09 ± 16%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.29 ±  2%      -0.0        1.29 ±  6%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.84 ±  7%      -0.0        1.83 ±  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.13 ± 10%      -0.0        0.13 ± 13%  perf-profile.children.cycles-pp.btrfs_get_token_32
      0.08 ± 20%      -0.0        0.08 ± 40%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.11 ± 19%      -0.0        0.11 ± 21%  perf-profile.children.cycles-pp.load_balance
      0.27 ±  6%      -0.0        0.27 ±  8%  perf-profile.children.cycles-pp.uncharge_folio
      0.08 ± 16%      -0.0        0.08 ± 21%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.01 ±173%      -0.0        0.01 ±201%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.08 ± 17%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.btrfs_root_node
      0.01 ±264%      -0.0        0.01 ±299%  perf-profile.children.cycles-pp.folio_wait_writeback
      0.01 ±264%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.btrfs_free_block_rsv
      0.12 ± 19%      -0.0        0.12 ± 14%  perf-profile.children.cycles-pp.up_write
      0.29 ± 16%      -0.0        0.29 ± 14%  perf-profile.children.cycles-pp.menu_select
      0.61 ±  8%      -0.0        0.61 ±  9%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.06 ± 40%      -0.0        0.06 ± 38%  perf-profile.children.cycles-pp.btrfs_leaf_free_space
      0.08 ± 20%      -0.0        0.08 ± 15%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.01 ±264%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.prepare_task_switch
      0.04 ± 58%      +0.0        0.04 ± 68%  perf-profile.children.cycles-pp.btrfs_dirty_inode
      0.02 ±173%      +0.0        0.02 ±152%  perf-profile.children.cycles-pp.kmalloc_trace
      0.09 ± 15%      +0.0        0.09 ± 18%  perf-profile.children.cycles-pp.find_first_non_hole
      0.15 ± 10%      +0.0        0.15 ±  9%  perf-profile.children.cycles-pp.down_write
      0.01 ±264%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.04 ± 79%      +0.0        0.04 ± 65%  perf-profile.children.cycles-pp.join_transaction
      0.46 ±  5%      +0.0        0.47 ±  5%  perf-profile.children.cycles-pp.workingset_update_node
      0.09 ± 20%      +0.0        0.09 ± 16%  perf-profile.children.cycles-pp.security_file_permission
      0.19 ± 10%      +0.0        0.19 ± 12%  perf-profile.children.cycles-pp.__reserve_bytes
      0.09 ± 22%      +0.0        0.09 ± 16%  perf-profile.children.cycles-pp.set_extent_bit
      0.05 ± 61%      +0.0        0.05 ± 51%  perf-profile.children.cycles-pp.__libc_start_main
      0.05 ± 61%      +0.0        0.05 ± 51%  perf-profile.children.cycles-pp.main
      0.05 ± 61%      +0.0        0.05 ± 51%  perf-profile.children.cycles-pp.run_builtin
      0.11 ± 17%      +0.0        0.11 ± 11%  perf-profile.children.cycles-pp.rcu_core
      0.65 ±  5%      +0.0        0.65 ±  5%  perf-profile.children.cycles-pp.btrfs_punch_hole
      0.08 ± 15%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.btrfs_double_extent_lock
      0.18 ± 12%      +0.0        0.19 ± 12%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      0.09 ± 21%      +0.0        0.09 ± 15%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.10 ± 15%      +0.0        0.11 ±  5%  perf-profile.children.cycles-pp.__wake_up_common
      0.10 ± 14%      +0.0        0.11 ± 13%  perf-profile.children.cycles-pp.btrfs_get_32
      0.02 ±129%      +0.0        0.02 ±123%  perf-profile.children.cycles-pp.vfs_fstat
      0.01 ±174%      +0.0        0.02 ±153%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.01 ±174%      +0.0        0.02 ±153%  perf-profile.children.cycles-pp.newidle_balance
      0.10 ± 10%      +0.0        0.11 ± 13%  perf-profile.children.cycles-pp.rb_erase
      0.20 ± 11%      +0.0        0.20 ±  8%  perf-profile.children.cycles-pp.clockevents_program_event
      0.09 ± 20%      +0.0        0.09 ± 23%  perf-profile.children.cycles-pp.btrfs_bin_search
      0.01 ±173%      +0.0        0.02 ±153%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.01 ±173%      +0.0        0.02 ±153%  perf-profile.children.cycles-pp.security_capable
      0.01 ±173%      +0.0        0.02 ±153%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.09 ± 19%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.xas_expand
      0.01 ±264%      +0.0        0.01 ±200%  perf-profile.children.cycles-pp.stress_file_ioctl
      0.37 ± 15%      +0.0        0.38 ± 10%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.08 ± 13%      +0.0        0.08 ± 19%  perf-profile.children.cycles-pp.btrfs_punch_hole_lock_range
      0.09 ± 24%      +0.0        0.10 ± 15%  perf-profile.children.cycles-pp.__fget_light
      0.06 ± 40%      +0.0        0.06 ± 57%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.60 ±  8%      +0.0        0.60 ±  9%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.add_extent_mapping
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.btrfs_trans_release_metadata
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.folio_mapping
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.ksys_write
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.execve
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.do_execveat_common
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.cmd_record
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__cmd_record
      0.27 ± 30%      +0.0        0.28 ± 39%  perf-profile.children.cycles-pp.ktime_get
      0.02 ±129%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.capable
      0.01 ±174%      +0.0        0.02 ±123%  perf-profile.children.cycles-pp.update_existing_head_ref
      0.09 ± 20%      +0.0        0.09 ± 24%  perf-profile.children.cycles-pp.native_sched_clock
      0.15 ± 16%      +0.0        0.16 ± 22%  perf-profile.children.cycles-pp.__count_memcg_events
      0.07 ± 22%      +0.0        0.08 ± 17%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      0.01 ±264%      +0.0        0.02 ±152%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.28 ±  7%      +0.0        0.29 ±  6%  perf-profile.children.cycles-pp.xas_create
      0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.btrfs_inode_lock
      0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.need_preemptive_reclaim
      0.51 ±  7%      +0.0        0.52 ±  2%  perf-profile.children.cycles-pp.btrfs_add_delayed_data_ref
      0.00            +0.0        0.01 ±201%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.02 ±129%      +0.0        0.03 ±102%  perf-profile.children.cycles-pp.poll_idle
      0.07 ± 17%      +0.0        0.09 ± 20%  perf-profile.children.cycles-pp.__btrfs_end_transaction
      0.23 ±  9%      +0.0        0.24 ± 13%  perf-profile.children.cycles-pp.free_extent_map
      0.06 ± 44%      +0.0        0.07 ± 18%  perf-profile.children.cycles-pp.update_blocked_averages
      0.06 ± 45%      +0.0        0.08 ± 42%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.07 ± 15%      +0.0        0.09 ± 21%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.04 ± 60%      +0.0        0.06 ± 35%  perf-profile.children.cycles-pp.rb_insert_color
      0.13 ± 21%      +0.0        0.15 ±  7%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.01 ±173%      +0.0        0.03 ±104%  perf-profile.children.cycles-pp.btrfs_find_space_for_alloc
      0.02 ±131%      +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.btrfs_reduce_alloc_profile
      0.06 ± 43%      +0.0        0.08 ± 18%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.05 ± 65%      +0.0        0.06 ± 12%  perf-profile.children.cycles-pp.insert_delayed_ref
      1.07 ±  5%      +0.0        1.09 ±  7%  perf-profile.children.cycles-pp.tick_sched_timer
      0.38 ± 14%      +0.0        0.40 ±  9%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.84 ±  5%      +0.0        0.86 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.01 ±264%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.0        0.02 ±122%  perf-profile.children.cycles-pp.___slab_alloc
      2.45 ±  9%      +0.0        2.47 ±  7%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.02 ±131%      +0.0        0.04 ± 51%  perf-profile.children.cycles-pp.calc_available_free_space
      0.01 ±174%      +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.update_curr
      0.02 ±134%      +0.0        0.05 ± 52%  perf-profile.children.cycles-pp.btrfs_can_overcommit
      2.69 ±  7%      +0.0        2.71 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.98 ±  5%      +0.0        1.01 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      0.42 ±  7%      +0.0        0.45 ±  9%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.13 ± 74%      +0.0        0.16 ± 73%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.04 ± 80%      +0.0        0.07 ± 18%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.96 ±  5%      +0.0        1.00 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.01 ±264%      +0.0        0.04 ± 67%  perf-profile.children.cycles-pp.rcu_pending
      0.11 ± 86%      +0.0        0.15 ± 77%  perf-profile.children.cycles-pp.tick_irq_enter
     42.93 ±  2%      +0.1       42.98 ±  2%  perf-profile.children.cycles-pp.vfs_dedupe_file_range
     42.92 ±  2%      +0.1       42.97 ±  2%  perf-profile.children.cycles-pp.vfs_dedupe_file_range_one
      1.00 ±  7%      +0.1        1.08 ±  5%  perf-profile.children.cycles-pp.btrfs_extent_same_range
      0.29 ± 16%      +0.1        0.39 ±  6%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.52 ±113%      +0.2        0.67 ± 96%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.52 ±113%      +0.2        0.67 ± 96%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.52 ±113%      +0.2        0.67 ± 96%  perf-profile.children.cycles-pp.start_kernel
      0.52 ±113%      +0.2        0.67 ± 96%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.52 ±113%      +0.2        0.67 ± 96%  perf-profile.children.cycles-pp.rest_init
      0.26 ±  8%      +0.2        0.41 ±  7%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.08 ± 21%      +0.2        0.25 ±  8%  perf-profile.children.cycles-pp.__kmalloc_node
      0.08 ± 22%      +0.2        0.24 ±  8%  perf-profile.children.cycles-pp.__kmalloc_large_node
      0.08 ± 21%      +0.2        0.25 ±  6%  perf-profile.children.cycles-pp.kvmalloc_node
     70.99            +0.3       71.33 ±  2%  perf-profile.children.cycles-pp.stress_run
     70.65            +0.4       71.02 ±  2%  perf-profile.children.cycles-pp.ioctl
     70.37            +0.4       70.77 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     69.83            +0.4       70.25 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     68.25            +0.5       68.76 ±  2%  perf-profile.children.cycles-pp.__x64_sys_ioctl
      1.13 ±  3%      +0.6        1.69 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.31 ± 11%      +0.6        0.90 ±  6%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     22.35            +0.6       22.97 ±  2%  perf-profile.children.cycles-pp.ioctl_file_clone
     21.97            +0.6       22.59 ±  2%  perf-profile.children.cycles-pp.btrfs_clone_files
     22.34            +0.6       22.96 ±  2%  perf-profile.children.cycles-pp.vfs_clone_file_range
     22.32            +0.6       22.94 ±  2%  perf-profile.children.cycles-pp.do_clone_file_range
     30.09 ±  2%      +0.6       30.73 ±  3%  perf-profile.children.cycles-pp.do_read_cache_folio
     65.16            +0.7       65.82 ±  2%  perf-profile.children.cycles-pp.btrfs_remap_file_range
     65.61            +0.7       66.28 ±  2%  perf-profile.children.cycles-pp.do_vfs_ioctl
      0.52 ±  4%      +1.0        1.48 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.00            +1.5        1.54 ±  6%  perf-profile.children.cycles-pp.__free_one_page
      2.58 ±  3%      +2.0        4.55 ±  5%  perf-profile.children.cycles-pp.folio_alloc
      0.93 ±  6%      +2.1        3.02 ±  5%  perf-profile.children.cycles-pp.rmqueue
      0.00            +2.1        2.10 ±  4%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.01 ±264%      +2.2        2.17 ±  4%  perf-profile.children.cycles-pp.free_unref_page
      2.03 ±  3%      +2.2        4.19 ±  4%  perf-profile.children.cycles-pp.__alloc_pages
      1.25 ±  6%      +2.2        3.42 ±  5%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.37 ± 10%      +2.2        2.54 ±  4%  perf-profile.children.cycles-pp.free_unref_page_commit
      2.60 ±  4%      +2.2        4.77 ±  3%  perf-profile.children.cycles-pp.btrfs_clone
      0.00            +2.2        2.20 ±  6%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.00            +2.5        2.49 ±  6%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      9.91 ±  2%      -0.5        9.38 ±  2%  perf-profile.self.cycles-pp.memcmp
     23.80 ±  4%      -0.2       23.59 ±  5%  perf-profile.self.cycles-pp.intel_idle_ibrs
      3.24 ±  2%      -0.2        3.05 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
      1.16 ±  3%      -0.1        1.02 ±  4%  perf-profile.self.cycles-pp.__set_extent_bit
      5.27            -0.1        5.12 ±  2%  perf-profile.self.cycles-pp.memset_orig
      0.63 ±  6%      -0.1        0.50 ±  7%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.19 ±  2%      -0.1        1.06 ±  3%  perf-profile.self.cycles-pp.free_extent_state
      1.46 ±  4%      -0.1        1.36 ±  4%  perf-profile.self.cycles-pp.xas_store
      0.92 ±  3%      -0.1        0.84 ±  6%  perf-profile.self.cycles-pp.alloc_extent_state
      1.45 ±  3%      -0.1        1.37 ±  4%  perf-profile.self.cycles-pp.__clear_extent_bit
      0.58 ±  7%      -0.1        0.51 ± 11%  perf-profile.self.cycles-pp.set_page_extent_mapped
      1.15 ±  4%      -0.1        1.08 ±  9%  perf-profile.self.cycles-pp.vfs_dedupe_file_range_compare
      0.62 ±  5%      -0.1        0.55 ±  6%  perf-profile.self.cycles-pp.clear_page_extent_mapped
      0.84 ±  4%      -0.1        0.78 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.88 ±  4%      -0.1        0.82 ±  4%  perf-profile.self.cycles-pp.btrfs_invalidate_folio
      0.94 ±  8%      -0.1        0.88 ±  7%  perf-profile.self.cycles-pp.clear_state_bit
      0.82 ±  7%      -0.1        0.76 ±  4%  perf-profile.self.cycles-pp.lru_add_fn
      0.97 ±  3%      -0.1        0.92 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.60 ±  9%      -0.1        0.54 ±  7%  perf-profile.self.cycles-pp.cache_state_if_flags
      1.51 ±  4%      -0.1        1.46 ±  5%  perf-profile.self.cycles-pp.kmem_cache_free
      0.38 ±  7%      -0.1        0.33 ±  9%  perf-profile.self.cycles-pp.__cond_resched
      0.42 ±  7%      -0.1        0.37 ±  9%  perf-profile.self.cycles-pp.__entry_text_start
      0.79 ±  4%      -0.1        0.74 ±  5%  perf-profile.self.cycles-pp.folio_unlock
      1.11 ±  4%      -0.0        1.06 ±  4%  perf-profile.self.cycles-pp.release_pages
      0.27 ± 11%      -0.0        0.22 ±  9%  perf-profile.self.cycles-pp._raw_read_lock
      0.41 ±  5%      -0.0        0.36 ±  5%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.25 ±  7%      -0.0        0.20 ± 12%  perf-profile.self.cycles-pp.try_charge_memcg
      0.33 ±  4%      -0.0        0.29 ± 13%  perf-profile.self.cycles-pp.filemap_read_folio
      0.53 ±  2%      -0.0        0.48 ±  7%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.23 ±  8%      -0.0        0.19 ± 12%  perf-profile.self.cycles-pp.xas_find_conflict
      1.92 ±  4%      -0.0        1.88 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.63 ±  7%      -0.0        0.59 ± 18%  perf-profile.self.cycles-pp.intel_idle
      0.49 ±  7%      -0.0        0.46 ±  9%  perf-profile.self.cycles-pp.xas_load
      0.50 ±  8%      -0.0        0.47 ±  8%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.28 ± 18%      -0.0        0.24 ± 14%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.15 ± 16%      -0.0        0.12 ± 22%  perf-profile.self.cycles-pp.end_page_read
      0.21 ± 11%      -0.0        0.18 ± 11%  perf-profile.self.cycles-pp.btrfs_page_clear_checked
      0.53 ±  5%      -0.0        0.50 ±  6%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.29 ± 11%      -0.0        0.26 ±  8%  perf-profile.self.cycles-pp.xas_clear_mark
      0.40 ±  7%      -0.0        0.37 ±  5%  perf-profile.self.cycles-pp.btrfs_lock_and_flush_ordered_range
      0.34 ±  9%      -0.0        0.31 ±  6%  perf-profile.self.cycles-pp.btrfs_lookup_ordered_range
      0.28 ± 11%      -0.0        0.25 ± 12%  perf-profile.self.cycles-pp.__lookup_extent_mapping
      0.41 ±  7%      -0.0        0.38 ±  8%  perf-profile.self.cycles-pp.free_unref_page_list
      0.42 ±  7%      -0.0        0.39 ±  9%  perf-profile.self.cycles-pp.do_read_cache_folio
      0.20 ± 11%      -0.0        0.17 ±  9%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.23 ±  8%      -0.0        0.20 ± 10%  perf-profile.self.cycles-pp.filemap_free_folio
      0.24 ± 13%      -0.0        0.21 ±  6%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.67 ±  8%      -0.0        0.64 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.03 ± 78%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.28 ± 11%      -0.0        0.25 ± 11%  perf-profile.self.cycles-pp.btrfs_page_set_uptodate
      0.17 ±  6%      -0.0        0.14 ± 11%  perf-profile.self.cycles-pp.xas_find
      0.17 ±  5%      -0.0        0.14 ± 15%  perf-profile.self.cycles-pp.rcu_all_qs
      0.29 ± 12%      -0.0        0.27 ± 10%  perf-profile.self.cycles-pp.__init_waitqueue_head
      0.46 ±  8%      -0.0        0.43 ±  8%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.14 ± 12%      -0.0        0.12 ± 17%  perf-profile.self.cycles-pp.read_tsc
      0.12 ± 23%      -0.0        0.09 ± 14%  perf-profile.self.cycles-pp.btrfs_lookup_first_ordered_range
      1.16 ±  5%      -0.0        1.14 ±  4%  perf-profile.self.cycles-pp.__filemap_add_folio
      0.19 ±  6%      -0.0        0.17 ± 12%  perf-profile.self.cycles-pp.find_free_extent
      0.30 ±  6%      -0.0        0.28 ± 10%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.13 ±  9%      -0.0        0.11 ± 14%  perf-profile.self.cycles-pp.__tree_search
      0.32 ±  7%      -0.0        0.30 ±  9%  perf-profile.self.cycles-pp.btrfs_is_subpage
      0.24 ±  7%      -0.0        0.22 ± 11%  perf-profile.self.cycles-pp.__wake_up
      0.03 ±100%      -0.0        0.01 ±200%  perf-profile.self.cycles-pp.__mem_cgroup_uncharge_list
      0.11 ± 12%      -0.0        0.09 ± 18%  perf-profile.self.cycles-pp.btrfs_put_block_group
      0.55 ±  7%      -0.0        0.53 ± 12%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.81 ±  3%      -0.0        0.79 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.02 ±100%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.14 ± 12%      -0.0        0.12 ±  9%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.22 ±  7%      -0.0        0.20 ±  8%  perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.60 ±  9%      -0.0        0.58 ±  7%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.25 ±  7%      -0.0        0.23 ±  9%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.70 ± 13%      -0.0        0.69 ±  8%  perf-profile.self.cycles-pp.xas_descend
      0.30 ±  6%      -0.0        0.28 ± 14%  perf-profile.self.cycles-pp.alloc_pages
      0.02 ±129%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.06 ± 14%      -0.0        0.04 ± 68%  perf-profile.self.cycles-pp.btrfs_get_64
      0.13 ±  9%      -0.0        0.11 ± 16%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.12 ± 14%      -0.0        0.10 ± 16%  perf-profile.self.cycles-pp.btrfs_get_block_group
      0.40 ±  8%      -0.0        0.39 ±  8%  perf-profile.self.cycles-pp.btrfs_get_extent
      0.18 ±  9%      -0.0        0.16 ± 11%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.02 ±129%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.set_extent_buffer_dirty
      0.20 ± 10%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.add_delayed_ref_head
      0.05 ± 38%      -0.0        0.04 ± 65%  perf-profile.self.cycles-pp.mutex_unlock
      0.09 ±  7%      -0.0        0.08 ± 23%  perf-profile.self.cycles-pp._find_first_bit
      0.02 ±129%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.09 ±  7%      -0.0        0.08 ± 26%  perf-profile.self.cycles-pp.btrfs_set_token_32
      0.22 ±  8%      -0.0        0.21 ± 12%  perf-profile.self.cycles-pp.wait_subpage_spinlock
      0.15 ± 18%      -0.0        0.14 ± 15%  perf-profile.self.cycles-pp.test_range_bit
      0.25 ± 10%      -0.0        0.24 ± 12%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.18 ± 14%      -0.0        0.17 ± 15%  perf-profile.self.cycles-pp.xa_get_order
      0.05 ± 40%      -0.0        0.04 ± 83%  perf-profile.self.cycles-pp.intel_idle_irq
      0.03 ±100%      -0.0        0.02 ±153%  perf-profile.self.cycles-pp.update_load_avg
      0.78 ±  6%      -0.0        0.76 ±  7%  perf-profile.self.cycles-pp.find_lock_entries
      0.03 ± 77%      -0.0        0.02 ±122%  perf-profile.self.cycles-pp.read_cache_folio
      0.12 ± 12%      -0.0        0.11 ± 11%  perf-profile.self.cycles-pp.__btrfs_qgroup_release_data
      0.06 ± 13%      -0.0        0.05 ± 53%  perf-profile.self.cycles-pp.__write_extent_buffer
      0.03 ±100%      -0.0        0.02 ±155%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.10 ± 19%      -0.0        0.08 ± 18%  perf-profile.self.cycles-pp.filemap_alloc_folio
      0.02 ±129%      -0.0        0.01 ±200%  perf-profile.self.cycles-pp._copy_from_user
      0.26 ±  6%      -0.0        0.25 ±  8%  perf-profile.self.cycles-pp.lock_extent
      0.19 ± 10%      -0.0        0.18 ± 13%  perf-profile.self.cycles-pp.btrfs_set_delalloc_extent
      0.03 ±100%      -0.0        0.02 ±123%  perf-profile.self.cycles-pp.__schedule
      0.02 ±129%      -0.0        0.01 ±201%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.03 ±100%      -0.0        0.02 ±154%  perf-profile.self.cycles-pp.__filemap_fdatawait_range
      0.27 ±  3%      -0.0        0.26 ± 14%  perf-profile.self.cycles-pp.folio_add_lru
      0.03 ±102%      -0.0        0.02 ±123%  perf-profile.self.cycles-pp.start_transaction
      0.06 ± 15%      -0.0        0.06 ± 16%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.01 ±173%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.__switch_to_asm
      0.01 ±264%      -0.0        0.00        perf-profile.self.cycles-pp.mutex_lock
      0.10 ± 15%      -0.0        0.09 ± 13%  perf-profile.self.cycles-pp.rb_next
      0.04 ± 80%      -0.0        0.03 ±103%  perf-profile.self.cycles-pp.__filemap_fdatawrite_range
      0.09 ± 12%      -0.0        0.08 ± 19%  perf-profile.self.cycles-pp.perf_pmu_nop_void
      0.07 ± 16%      -0.0        0.07 ± 39%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.01 ±264%      -0.0        0.00        perf-profile.self.cycles-pp.btrfs_wait_ordered_range
      0.01 ±264%      -0.0        0.00        perf-profile.self.cycles-pp.xas_nomem
      0.01 ±264%      -0.0        0.00        perf-profile.self.cycles-pp.btrfs_insert_replace_extent
      0.01 ±264%      -0.0        0.00        perf-profile.self.cycles-pp.btrfs_get_8
      0.01 ±264%      -0.0        0.00        perf-profile.self.cycles-pp.assert_eb_page_uptodate
      0.01 ±264%      -0.0        0.00        perf-profile.self.cycles-pp.__slab_free
      0.01 ±264%      -0.0        0.00        perf-profile.self.cycles-pp.uncharge_batch
      0.26 ±  9%      -0.0        0.26 ±  9%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.05 ± 62%      -0.0        0.05 ± 69%  perf-profile.self.cycles-pp.btrfs_drop_extents
      0.07 ± 17%      -0.0        0.07 ± 15%  perf-profile.self.cycles-pp.setup_items_for_insert
      0.17 ±  7%      -0.0        0.16 ± 13%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.09 ± 14%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.__memmove
      0.13 ± 11%      -0.0        0.12 ± 12%  perf-profile.self.cycles-pp.btrfs_get_token_32
      0.57 ± 15%      -0.0        0.57 ± 14%  perf-profile.self.cycles-pp.btrfs_do_readpage
      0.04 ± 58%      -0.0        0.04 ± 82%  perf-profile.self.cycles-pp.xas_find_marked
      0.03 ±101%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.btrfs_fallocate
      0.08 ± 17%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.btrfs_root_node
      0.20 ± 13%      -0.0        0.19 ±  9%  perf-profile.self.cycles-pp.filemap_unaccount_folio
      0.10 ± 12%      -0.0        0.10 ± 13%  perf-profile.self.cycles-pp.btrfs_get_32
      0.04 ± 58%      -0.0        0.04 ± 67%  perf-profile.self.cycles-pp.btrfs_clone
      0.35 ± 10%      -0.0        0.35 ±  6%  perf-profile.self.cycles-pp.xas_start
      0.07 ± 15%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.ioctl
      0.07 ± 22%      -0.0        0.07 ± 17%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.07 ± 45%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.memcg_check_events
      0.46 ±  5%      -0.0        0.46 ±  5%  perf-profile.self.cycles-pp.workingset_update_node
      0.10 ± 15%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.__wake_up_common
      0.08 ± 22%      -0.0        0.08 ± 39%  perf-profile.self.cycles-pp.native_sched_clock
      0.03 ±100%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.read_extent_buffer
      0.06 ± 13%      +0.0        0.06 ± 15%  perf-profile.self.cycles-pp.should_fail_alloc_page
      0.01 ±264%      +0.0        0.01 ±300%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.05 ± 41%      +0.0        0.05 ± 40%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.35 ±  7%      +0.0        0.35 ±  6%  perf-profile.self.cycles-pp.rmqueue
      0.16 ± 17%      +0.0        0.16 ± 32%  perf-profile.self.cycles-pp.btrfs_clear_delalloc_extent
      0.15 ± 21%      +0.0        0.15 ± 10%  perf-profile.self.cycles-pp.set_state_bits
      0.25 ±  5%      +0.0        0.25 ±  8%  perf-profile.self.cycles-pp.uncharge_folio
      0.09 ± 21%      +0.0        0.09 ± 15%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.86 ±  4%      +0.0        0.86 ±  6%  perf-profile.self.cycles-pp.filemap_get_entry
      0.10 ± 11%      +0.0        0.10 ± 14%  perf-profile.self.cycles-pp.rb_erase
      0.21 ±  9%      +0.0        0.21 ±  8%  perf-profile.self.cycles-pp.should_failslab
      0.02 ±129%      +0.0        0.02 ±124%  perf-profile.self.cycles-pp.btrfs_remap_file_range
      0.09 ± 19%      +0.0        0.09 ± 24%  perf-profile.self.cycles-pp.btrfs_bin_search
      0.01 ±173%      +0.0        0.02 ±153%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.01 ±173%      +0.0        0.02 ±153%  perf-profile.self.cycles-pp.folio_lruvec_lock_irqsave
      0.10 ± 17%      +0.0        0.10 ± 15%  perf-profile.self.cycles-pp.policy_node
      0.01 ±264%      +0.0        0.01 ±201%  perf-profile.self.cycles-pp.__generic_remap_file_range_prep
      0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.vfs_fallocate
      0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.policy_nodemask
      0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.__btrfs_end_transaction
      0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.01 ±264%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.09 ± 24%      +0.0        0.09 ± 15%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.09 ± 27%      +0.0        0.10 ± 17%  perf-profile.self.cycles-pp.__fget_light
      0.05 ± 39%      +0.0        0.06 ± 22%  perf-profile.self.cycles-pp.do_syscall_64
      0.04 ± 78%      +0.0        0.04 ± 51%  perf-profile.self.cycles-pp.btrfs_add_delayed_data_ref
      0.07 ± 42%      +0.0        0.08 ± 22%  perf-profile.self.cycles-pp.truncate_inode_pages_range
      0.12 ± 13%      +0.0        0.13 ± 18%  perf-profile.self.cycles-pp.menu_select
      0.03 ±130%      +0.0        0.04 ± 85%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.10 ± 20%      +0.0        0.12 ± 23%  perf-profile.self.cycles-pp.__count_memcg_events
      0.64 ±  6%      +0.0        0.65 ±  5%  perf-profile.self.cycles-pp.__alloc_pages
      0.22 ±  5%      +0.0        0.24 ±  8%  perf-profile.self.cycles-pp.filemap_add_folio
      0.00            +0.0        0.01 ±201%  perf-profile.self.cycles-pp.__btrfs_release_delayed_node
      0.01 ±174%      +0.0        0.02 ±100%  perf-profile.self.cycles-pp.btrfs_replace_file_extents
      0.17 ±  9%      +0.0        0.18 ±  8%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.11 ± 22%      +0.0        0.12 ± 15%  perf-profile.self.cycles-pp.try_release_extent_mapping
      0.22 ±  9%      +0.0        0.24 ± 13%  perf-profile.self.cycles-pp.free_extent_map
      0.04 ± 60%      +0.0        0.06 ± 35%  perf-profile.self.cycles-pp.rb_insert_color
      0.06 ± 45%      +0.0        0.08 ± 42%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.02 ±129%      +0.0        0.03 ±104%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.10 ± 12%      +0.0        0.12 ±  9%  perf-profile.self.cycles-pp.xas_create
      0.01 ±174%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.down_write
      0.01 ±264%      +0.0        0.02 ±123%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.01 ±174%      +0.0        0.03 ±102%  perf-profile.self.cycles-pp.poll_idle
      0.14 ± 15%      +0.0        0.15 ± 14%  perf-profile.self.cycles-pp.btrfs_read_folio
      0.13 ± 21%      +0.0        0.15 ±  7%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.37 ± 14%      +0.0        0.39 ± 10%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.02 ±132%      +0.0        0.04 ± 51%  perf-profile.self.cycles-pp.up_write
      0.02 ±130%      +0.0        0.04 ± 52%  perf-profile.self.cycles-pp.btrfs_del_items
      0.16 ± 53%      +0.0        0.18 ± 58%  perf-profile.self.cycles-pp.ktime_get
      0.03 ±104%      +0.0        0.05 ± 38%  perf-profile.self.cycles-pp.__x64_sys_ioctl
      0.07 ± 18%      +0.0        0.10 ± 12%  perf-profile.self.cycles-pp.folio_alloc
      0.34 ±  7%      +0.0        0.37 ±  8%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.04 ± 79%      +0.0        0.06 ± 15%  perf-profile.self.cycles-pp.do_vfs_ioctl
      0.20 ± 11%      +0.0        0.23 ± 10%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.31 ± 12%      +0.1        0.36 ±  6%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.32 ±  9%      +0.1        0.37 ±  9%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.26 ± 19%      +0.1        0.36 ±  5%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.24 ±  8%      +0.1        0.38 ±  6%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.00            +0.2        0.15 ± 10%  perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.00            +0.2        0.24 ±  8%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.31 ± 11%      +0.6        0.90 ±  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.6        0.62 ± 13%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.51 ±  4%      +0.9        1.44 ±  6%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.00            +1.3        1.32 ±  6%  perf-profile.self.cycles-pp.__free_one_page

xsang@inn:~$

--p/yrhrNiooBtE2cS--
