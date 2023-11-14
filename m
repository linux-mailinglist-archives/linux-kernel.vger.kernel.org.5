Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27667EAB21
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjKNH7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjKNH7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:59:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66B6195
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699948750; x=1731484750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZO+5s7i41UB/m3vKcrgtq15tXRsLjlcUxdRCjH+NqTA=;
  b=BdoIlk0r3TgfkgcX+Q1mV32dge117eCAAOSIaqNHh9D9oBgBNGD2fiBQ
   5sbTM3bBLyjGtqrNkOnVOT+aH/p3DYS+1NF59MKsH5wZrll/R0AV1gfh/
   yMGiYfOB1titC+/0c+HN2zsYB+MH0n+Hyl28k6y3r02vNe8iFiFQ5JkwH
   NtjmFpSuKw31OQBfy4bqE8veY9zURX+aVP5U2bLqCHVpfmB0u30/vMuMg
   K54x2840Gqy/NaRE+6GnJKqk5VD9gvO071XJtiCE7Tj8sxrUbJJyd7oBj
   pNXYhiYtx1EwF9XsEtRbMvoX6fsVTtrM7NhHSBnKsonjJwsAjSdZ4AV40
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="369947047"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="369947047"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 23:59:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="5926080"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 23:59:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 23:59:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 23:59:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 23:59:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 23:59:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKhN3+IU6AxRGKv3pm36AUr/ARj90VG/7o5VXBAss+gvEoGGyDjPmSL2DnwmYlzCqLnpOjZax+0fKVqnFEDcG9y1PGDuGsX5kprJdnGZyjkV1el/Wt36B899TDoxc3TpQn4Q0vQGGbbwJhUDiz+b0XxMtUxinAEJfp5dy1ZpQuVMRCS/Iwb4z+qbT/RnKTktf+7yiEYPD0j++AkjxBK7TUGlTuHhmUlPT5bs5NuytD7jZ/NGf/braWka/YJ0yZzvLP30ERJmNTl+VDPUDtq3bma/TjM2No/BB0y6fZgkfVyh+KamrotftQnW5cZPXSw3QEQ8guAK161pxtzeKS8vbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foHLzu0wi3UJnV47yQLmEoAS3sKUMupEyYV4vCBQpOw=;
 b=DLXl3Xy2F8+QBDy8YlfL90FB6Gpf95InnX3eZcNogGpRc9M6DpmOxEFzyuWsa7eYQKzrJuyxuB7DJNoVdt/UlT173UN3wWs76oqAlqNs5nEfd3Y6Ro+upJOAHUCiktcowdK32LNF8wFC1i6tR/QIp3LC4LYdt7Snp03vM8JK4ar0ySepWuzD7znMayo7iTfzic7/hFiJa48ya6KmzN94LkbykoixI6O0d4l9W+Nh1h/GSBM7XVyK1GkNNyAYgbGNJaQp5EqlTA9wA/h7QqqTOzqCloHkHh1RQobfWiuJam3kw5V/2fQRzanJpSV/iwg3EJJgOXQpMbJv41j+zGqW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 07:59:06 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Tue, 14 Nov 2023
 07:59:06 +0000
Date:   Tue, 14 Nov 2023 15:54:26 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Ayush Singh <ayushdevel1325@gmail.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: drivers/greybus/gb-beagleplay.c:347:24: sparse: sparse: restricted
 __le16 degrades to integer
Message-ID: <202311072329.Xogj7hGW-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA1PR11MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad31d7c-83b8-40cb-b3bb-08dbe4e7932a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uctHmXhTEx1YpOUdolRrGpg4CVoA5UsTRGoizKEr/2+PDomD72GL3EWnTrRsG9Hh0mxt5Z38EY5bwfMc/DBi1xgbmypFbFB7ZajRP6V0NRdiAO1Ca12DvRgBm9/9nSnuSJzscbfljJ9Fouugqt30QXVHQH3lWv+VVNXh2DO7PQYz3y5/svnz/CASrKJGWN88Dcjopp2VhCD8JLm880n5POwQW08L+Z3jo1OMdC/+25TImlc7+5fFH0WZJGTknJYkh474fWsNSR8zrcLIN4BhnDMm++7zKQZjVi8WoFToAOY7iCmI48n0dzPAFZzmWgoymHmOpulJwbRT5OGR+ZZf8NIDxVsUKcMvXzNk5aQfJLpoYw0xzZpltmhCDt8Q0fQdSFN2cHbjmsr9rxEO/4wfUz61LmtDf01sEyzM8Agth44hbbLsOb4JucCbuhhUWJW/6ZUVjvMx5QO4TxFD4sX+FObRJhJ4kzLnJt3Ju6VDrcorvIwzjd7VnE8wrQh/QEOkXIVqfDliClssWG/demyXnRGSuxgAz2QwiMHFhxI5XktQa3eBfG+TWkxEh7AFRUbd714Boe2uMG4Ewi+UMlh77NE/xsxjuy0KOEYzoboAyBCJGzQN1UoqQBKd0HCBFzo8YVYS0AaJaQGawK9WseOu3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(1076003)(82960400001)(38100700002)(83380400001)(86362001)(5660300002)(2616005)(6512007)(6506007)(478600001)(6486002)(6666004)(36756003)(966005)(66946007)(316002)(66556008)(6916009)(66476007)(8676002)(4326008)(8936002)(4001150100001)(2906002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gO2eTp5kL3Ys+oAPo+g2Q/7nkdFo/Ud7SmsP7NvJ2Kfu2Q654VuyjC2qNuYk?=
 =?us-ascii?Q?MAEPhtrCvyY4XCkteqtJImgPMYiKgJv5/4ZzvgBTACPB3pNkYyuDWF5hI9uL?=
 =?us-ascii?Q?vnUr/bRMBuSDxiAJSL/SjIwqxb50GFjFG8mDc0HXBKSdo+0O0wiUttsMYqdl?=
 =?us-ascii?Q?2koskTwcTYCcPN1f6fHD14TwElabF+I/xoY6lq4yT6unyuVTSDfJ7SnlFSRa?=
 =?us-ascii?Q?MN9SSgY+lYJ++r1dq9y6B/LbulCvR5qwLPTCmxlXZOlCxDf4zvxNZFBIIO41?=
 =?us-ascii?Q?3XTAMpVE4nzl7Kuo0i+fbQDhoB1tCsb0WNFyeg+jOwG6T1JQ8D6t70q5LMj5?=
 =?us-ascii?Q?rQAtAfWCmMjBYTpOlEHrnzzdIvqgjuQmi27ayu9Xdr5HZ2QfGOqKzJOahXxQ?=
 =?us-ascii?Q?VnXBJDZnplzrpQZUTGap9s/5XTNBEnMSPffMNGMKTwdwqtavfj77pzIFANvA?=
 =?us-ascii?Q?Wpn6Sr0lUacXuo39T2M7BWE7HkLrY05y0XfDHsfvicIDXKJjQJZK/PUMG9eC?=
 =?us-ascii?Q?mlMOBakzzghKYtmyEiHNUxK4zsSuT/2NtXVq+LFz2eQkMBo0g6ONKXxx7TrB?=
 =?us-ascii?Q?QRD8hrsxuuXlvWQft1jdxzdKhyAbDkjwfK1GXDrnKNrxdr28j4gqkmlgea5k?=
 =?us-ascii?Q?iklkHSS0mcamcpp0iSCKEbFJg1VnJ0KI0MlJZs5cgCLYtsVhVPln2R2l5eJe?=
 =?us-ascii?Q?EkW0WkHvF9g7kt9LdH8zRS1b4htkVC9yyPjCcuO0wqcLKkBgzFWfgg9o7JkX?=
 =?us-ascii?Q?21Uo7/HrmFj2M1/uE+nMfDTkKi74kegHuZbDyHEYoZ8IjzxGNTcKUfnDbR/R?=
 =?us-ascii?Q?j9DqETvTUsBom5sgY8iV35qTJnrHprTVVSKt74lourAmxKXKqdlqbCAljhnH?=
 =?us-ascii?Q?geKG1DJmk6Xe3GOm9RNF/V5QAW0jgbzF+sD7LYjoGx61RGpwU1kv9wZTq1lI?=
 =?us-ascii?Q?BGlSnHDrTYEyCZDzY+IOALz0NaIzmOZoGDJPq53kdil8tUsS8MLNptU/rZXz?=
 =?us-ascii?Q?UmMOKmJQgzJq/lnSmPFOzPYXjUZoJCBwAMv1v7QU3wf2VHfkuG+2ZA8ibNmc?=
 =?us-ascii?Q?T2BqslKBB8f1MZyRTs2ZBuyyTeBBNNLb46725s0pcZyqlpfTRd0veaFVIWyz?=
 =?us-ascii?Q?JT+ZGqwIAiEx13r6jq536wiilMZ6+IXQ1niGBx4Jw5oZ2mzo44N6lXmM894N?=
 =?us-ascii?Q?dc3lMfzRPRxrDlPBtKSkfN7wfV+KtroKW5FPReeMB/jZsQLne7OY4i5Ofq6s?=
 =?us-ascii?Q?gCJczehjq6hqlVuJj5UzoNobZQAoase2q10umKHHkULTqFMx9oRGaSViuluI?=
 =?us-ascii?Q?rluRb3srurBlO+fFnHILJlnr6O9VIjAMm3Okb7T2P/q4pqEzX1y7JXL5TXBf?=
 =?us-ascii?Q?c7UOERif6ShtIa7wgweXTFohCH6fTVAO3ixuYWn8ctoT1yUVMg6eFnms8Om1?=
 =?us-ascii?Q?VKXlFuxYEeevZKn3WHqCm7nLEkagNTW0cdm0yPKNqHCRnMF97bCMpuPcm1xy?=
 =?us-ascii?Q?y/8Zu4WEoBJ4SAtvTSJLpzeUKaGKJvbEBwopl7bZg17iRHB2AsCTk15h+4a5?=
 =?us-ascii?Q?uqn7UjxFQXH8Ti1inZ9C8sNoZGoiwBjgq+fp2CIW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad31d7c-83b8-40cb-b3bb-08dbe4e7932a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 07:59:06.1647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esbGPPr1Szr30I/ia87iZ3bL2dMgqmEBeKyz3WSlyQqA5GG9CKTMMDIqbovRQP+c//sJASZDAMQKYA5/jKvMow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
commit: ec558bbfea671ac020a6dc6be8bf8f0ee556cce0 greybus: Add BeaglePlay Linux Driver
date:   11 days ago
config: x86_64-randconfig-122-20231107 (https://download.01.org/0day-ci/archive/20231107/202311072329.Xogj7hGW-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311072329.Xogj7hGW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311072329.Xogj7hGW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/greybus/gb-beagleplay.c:347:24: sparse: sparse: restricted __le16 degrades to integer

vim +347 drivers/greybus/gb-beagleplay.c

ec558bbfea671a Ayush Singh 2023-10-17  338  
ec558bbfea671a Ayush Singh 2023-10-17  339  static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_message *msg, gfp_t mask)
ec558bbfea671a Ayush Singh 2023-10-17  340  {
ec558bbfea671a Ayush Singh 2023-10-17  341  	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
ec558bbfea671a Ayush Singh 2023-10-17  342  	struct hdlc_payload payloads[2];
ec558bbfea671a Ayush Singh 2023-10-17  343  
ec558bbfea671a Ayush Singh 2023-10-17  344  	dev_dbg(&hd->dev, "Sending greybus message with Operation %u, Type: %X on Cport %u",
ec558bbfea671a Ayush Singh 2023-10-17  345  		msg->header->operation_id, msg->header->type, cport);
ec558bbfea671a Ayush Singh 2023-10-17  346  
ec558bbfea671a Ayush Singh 2023-10-17 @347  	if (msg->header->size > RX_HDLC_PAYLOAD)
ec558bbfea671a Ayush Singh 2023-10-17  348  		return dev_err_probe(&hd->dev, -E2BIG, "Greybus message too big");
ec558bbfea671a Ayush Singh 2023-10-17  349  
ec558bbfea671a Ayush Singh 2023-10-17  350  	memcpy(msg->header->pad, &cport, sizeof(cport));
ec558bbfea671a Ayush Singh 2023-10-17  351  
ec558bbfea671a Ayush Singh 2023-10-17  352  	payloads[0].buf = msg->header;
ec558bbfea671a Ayush Singh 2023-10-17  353  	payloads[0].len = sizeof(*msg->header);
ec558bbfea671a Ayush Singh 2023-10-17  354  	payloads[1].buf = msg->payload;
ec558bbfea671a Ayush Singh 2023-10-17  355  	payloads[1].len = msg->payload_size;
ec558bbfea671a Ayush Singh 2023-10-17  356  
ec558bbfea671a Ayush Singh 2023-10-17  357  	hdlc_tx_frames(bg, ADDRESS_GREYBUS, 0x03, payloads, 2);
ec558bbfea671a Ayush Singh 2023-10-17  358  	greybus_message_sent(bg->gb_hd, msg, 0);
ec558bbfea671a Ayush Singh 2023-10-17  359  
ec558bbfea671a Ayush Singh 2023-10-17  360  	return 0;
ec558bbfea671a Ayush Singh 2023-10-17  361  }
ec558bbfea671a Ayush Singh 2023-10-17  362  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

