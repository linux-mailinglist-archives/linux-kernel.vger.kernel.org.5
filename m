Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2943812381
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjLMXrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjLMXrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:47:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0C5196;
        Wed, 13 Dec 2023 15:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702511268; x=1734047268;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=E/CTAMKcMng59KSwsBznhFtUMPKz96uBwng5b++F5Fs=;
  b=F/PP3WFCvA+jL1BcqVGiFm7FY21aJT1veQH6lA319K/vOFz631Ik3jA3
   oJNRkhPqZjxNQWq+3qr7TRCjolKIB93Ymf1lobarvlw8CWpBOGpI/WG9L
   rMxUODdYPsGGwUeYmAcyUV7+CQpeRmbiwjo6H8NVitHej69HmzaZvNy67
   mKyPvvv1NwbQeRGm9p0KM4iPVVut4mwtzUnmNGm/3mD3/oX+xqKW6Vvrr
   tWH9z83JONSvv8RztQ9KijiP4eQTk9f9ILAyyYvNtmSsejQ6PZN4ll4P5
   Nm7w8N8Fd9Wbm+AUmvfq/ywdIpRJ8I/VooYcqtlVeEsI/Is/UvT2d6BWu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="393914281"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="393914281"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:47:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1105480328"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="1105480328"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 15:47:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 15:47:47 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 15:47:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 15:47:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 15:47:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E86FmMDNr6Fg3ZF8oiNqCxhnsTcciUfshB+lJa7mkMnRBQBCbsX4oBRO7Y1dHGldU084a4Yupnn1iuYHbX+6fSZ3GZcumrb9pcV5XH/4MERu+Pv9NlPp14EHJfLvVgQvMNcZjfdls7bOic5BjJiSQe3OXxdle+mq66d+3qYqRW1pkTpBqjWzKicqGGsCVlFocJj9arPdNKHAFmBJcp7B1OY3j+6tsYup2+eTcHAjMT3xAj3yV03OtW54IawalFuI4ocVUEQvh5Zt4cq0jurpxhHuKS9XSI/3DEoVswAEMI5Gjjlc2tgTJ8/6wZFPzUmNbWaLEhiktZwnktmM7uGSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnnEEfwkwwsoGslTqTBvn2g789oJCOrkOA5LVRkoECs=;
 b=loWG0DNdv4jhN8Izb1tcORCwakvuarvljHRYxTvVXjt27WaWzDqck2GzjXKu2+aj7FX1Yhm/3rZtOOHOCOXNWBIrh6LzqBN89ZwIsm1voBUXM1eZ38a6NWIEDZhGva6blHgvHe8YSoPjVzmgBaZbgXfEFz9qVAqZRJ0FsUI0nsZ5hZ6Kjr8Q8m904eptjjs4epFW6jX0E2JnAqwLfqToltgRIvTaAvAh4oNLJk0EvEy8zidoj8ZtgYVtQlI9TUH8vN3HK2R9aRfgAU1Ts0PA30FOg80sgzlLb8yhdCYIBtjnRPDv2bE8ewM4b0ASgo6uuglhbF+bPS5Dso6AMmHdYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7028.namprd11.prod.outlook.com (2603:10b6:510:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 23:47:39 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7091.028; Wed, 13 Dec 2023
 23:47:39 +0000
Date:   Wed, 13 Dec 2023 15:47:35 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <gregkh@linuxfoundation.org>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH] driver core: Add a guard() definition for the
 device_lock()
Message-ID: <657a42977b357_25d7a0294cb@iweiny-mobl.notmuch>
References: <170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BY5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7832c7-c5ff-4b99-fc48-08dbfc35e3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkMPpuSAwHDiANkx7XbrrzkTABOIxX3w7AN5gd2kr8P830AmRMYuUbdeVre9eUe2EDzlAgAYdWGeiLtKIt8ZYxchovL7Dug+d4KYGj3JGFu/7FpVEzf0LHMEnRpwHpXkpdeYvMAOA8KwSXQGGcMicZd+qqVInDhHWVTdLKeftkkpu1QV4PH3Jfi0Zbz08TEpA0sCmvnuY3oLYh7GaScqaei5yuAxwBZcLuZq14+8yUDOML5M01X5019YlnFx2jD7K0A7RzhGu61kdFvbCqh9Rl82R84tVE5Fg6JHktS2nUADM0LXprle5mTCMj35UyypCCeyYF7UTZqP8Zms/KLO/Xd2xpA4e7IAeFJ2/TRrwxu+yd6AmrQ87WPo17/SUt0pyuj7bxeGvFdweoDTUQdB6WmF12dD3qON9U86A0ksy1ZFhhKo1dbUMypp+0gA+u7crlojULriola+unFVj5wd31oppHKVgagCXczuuo7gJoNpvKLMvZnk5+ACT3y2pLaYz+R9HCT9i3ZDse7q4l6qknJd72jC2KmGBXrudOlvCVGQyrFBPEhNAv4ZvGP7NKu+BBBY/GXezijCCjaJ/ACKVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(66556008)(66476007)(54906003)(82960400001)(86362001)(26005)(83380400001)(478600001)(6512007)(9686003)(6506007)(966005)(2906002)(316002)(38100700002)(6666004)(6486002)(4326008)(5660300002)(44832011)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L/TKUbGZKG8HjfUk4frFp6lSfhOFd7zisl/oCYOSp7NTUEoa+aUdbf/bBGni?=
 =?us-ascii?Q?iIs1VxX2bKo6ZoKd7VX5+g6tIDlMDktGi3XRZnQ9Vk0MBSXuaCpKuAchohNq?=
 =?us-ascii?Q?xTqLVKtHypjCMpM6CZxseLm9NSEilVIKUiapSTDhKfUn3VdQoi+tEzb6kI97?=
 =?us-ascii?Q?/QcnfrrSIgBOgbJIv/08TdSSnjt0o76G2Xr4+cibVdCKA4fp8RfFh8HfOwa6?=
 =?us-ascii?Q?poqe1w26pSFV+cd+WOp9zARVkcDm4Zz8I041jZH5EyAJUzBH0uR1AzbLhU0o?=
 =?us-ascii?Q?wSen2RJZZtXHf21lbntN0pXLNgTyAe6kTCdUIvVgp8i+uBAxzuQp1E9fWLZw?=
 =?us-ascii?Q?SEWwUAy5ofuXu4JbJ9Ig3SFsVOMWLmlt2g34HBScV2gKFX0uMEgNKW+Namxr?=
 =?us-ascii?Q?uy0QueQEDPmEHV8qIGnBg57eiAtA8hORxvzAXE6OQi+atzYhZjehjd5uBRXs?=
 =?us-ascii?Q?BUgVKOO5AQIUxf92PJ6hSm871+guYfnZjU+zDzZCRdI5sWqx3JjfActtey7P?=
 =?us-ascii?Q?FlBFODDMiYfCFcBqsm6B/aqyIj76/b2uyemp/VHbOZOAyTQNJmDqx47B1LCN?=
 =?us-ascii?Q?p0bfXZTiWPIRizbxEI6Sm+KTPUD2xAG9fDvxd7c9bpbyzkevG6Uo4iJITO+4?=
 =?us-ascii?Q?ZT5xDLubdRFETbgHjEKCm/4WnhtRxMCo1PyWFPwXzjFG7hx4w9q/Rx9/UGGz?=
 =?us-ascii?Q?CHPTV9bmX6sqXniUgLKoHE9Nao64jhxzxDr07b9B+Z0lhB3+bZ4QDeb+B3za?=
 =?us-ascii?Q?1bJvQOJK8RrvvSonLtraMwVo11BEiJJvbbQ9qUlVy+/7bZzaK0UXZNopF+ZN?=
 =?us-ascii?Q?LW38glrTjuSh4vGmBBV0OusRXXH83AM8853dR7zXyxYaXfZZzuj0sRCEh9Sp?=
 =?us-ascii?Q?PDQ57LP20CrzzkbkC40bCs6T3NjSp+0sg1rF5/q1XQG2GVasbYtl5Cy+XhBQ?=
 =?us-ascii?Q?Drx16bvcvOE1Wt8TLZ6ZJla5z1yhIBPCNiEpzXyHywA0o/hna36/DsfpcqLp?=
 =?us-ascii?Q?po0QBIFBHy8+cRFWlWyh8p+aQu2JpLn01DCS4PWLyYvuDdFIzwK7lN0rGt8Y?=
 =?us-ascii?Q?/qrJkMBeWt6ARrTgAjaMtmzS33je4JB6tcIUCL06J6YKsPgKM/+s0970Kzuy?=
 =?us-ascii?Q?Cm8LJXFe6kQmIFo78jTdQjVC8+AvvpvjMlXsuPkDkjklHmp3LY2k808FWBLk?=
 =?us-ascii?Q?XH+PTay4/6PqDo6PPS+JX9QoITR9nn3GGF+pH6lOx1mAt7MVrwLRkPnbdGr1?=
 =?us-ascii?Q?AannST0YxEt3WQtuTvWzm9Mf7taAgA9e3w9tCrEEPRqWq7qFWsmCJs7Q1P5R?=
 =?us-ascii?Q?Jiq9GTeKW/kboQsGnFyncKSdbcA3momfBfT7lLSkua8fTplRCrweBSehl0xp?=
 =?us-ascii?Q?ZNv8N50BN2eqm7jGQFBBNkei3fnTEBQdRNchJqkY80i9h/YupNDdnCqEvswU?=
 =?us-ascii?Q?DsYZi2rKkAPs6wKnWsEA4OjMLociLKo8boh2DgNyCGKPhzU9DWNdYzhV3c6+?=
 =?us-ascii?Q?ZsqpkfIJGAzn2V7OZAnByFSI3WGAPIu40kubbFIXzeGMCMj6M5Bjfa6HUCOe?=
 =?us-ascii?Q?Wn1ca6RTQz88JMkDFdW6kQHwuI8k6uLa+MkiKAhn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7832c7-c5ff-4b99-fc48-08dbfc35e3d8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 23:47:39.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BPQ3x7asUZjLan5O9kmch4e3W1fJRDhNLehiSVmMZkKJPD6O99MsohA5ZvMMSszj620q4SxAcGDCM8AKh9Nyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7028
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

Dan Williams wrote:
> At present there are ~200 usages of device_lock() in the kernel. Some of
> those usages lead to "goto unlock;" patterns which have proven to be
> error prone. Define a "device" guard() definition to allow for those to
> be cleaned up and prevent new ones from appearing.
> 
> Link: http://lore.kernel.org/r/657897453dda8_269bd29492@dwillia2-mobl3.amr.corp.intel.com.notmuch
> Link: http://lore.kernel.org/r/6577b0c2a02df_a04c5294bb@dwillia2-xfh.jf.intel.com.notmuch
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Hi Greg,
> 
> I wonder if you might include this change in v6.7-rc to ease some patch
> sets alternately going through my tree and Andrew's tree. Those
> discussions are linked above. Alternately I can can just take it through
> my tree with your ack and the other use case can circle back to it in
> the v6.9 cycle.
> 
> I considered also defining a __free() helper similar to __free(mutex),
> but I think "__free(device)" would be a surprising name for something
> that drops a lock. Also, I like the syntax of guard(device) over
> something like guard(device_lock) since a 'struct device *' is the
> argument, not a lock type, but I'm open to your or Peter's thoughts on
> the naming.
> 
>  include/linux/device.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index d7a72a8749ea..6c83294395ac 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1007,6 +1007,8 @@ static inline void device_unlock(struct device *dev)
>  	mutex_unlock(&dev->mutex);
>  }
>  
> +DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
> +
>  static inline void device_lock_assert(struct device *dev)
>  {
>  	lockdep_assert_held(&dev->mutex);
> 


