Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6617EF89D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjKQUZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQUZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:25:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626FC120;
        Fri, 17 Nov 2023 12:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700252715; x=1731788715;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+bm566xMNLvUbEWWP+eA1XU4ZFlWcdXOgbYj99uT0uk=;
  b=cOmUWSBdzQdlxuRe11ZnZIC7EdhegXkgiZ9VaSHQbBQWjIpSc8qlEaD9
   C4rU2d3EQ63hI6W/jA6u+Y6YL5eqVxs6lYwgcK87i2YznuFHOy5E4kBrf
   JeRD/1WTPMIdLkvh2/qnxvevp/k0h2j1+r1c6fZ+3xebqkdJMM3vfRh4F
   ttH3jVge3upN6GsnUgTpv6qVg0ZtjEAFdaELh+atlGMrNCCcKsuuAjaQM
   4imBRC+SBTM2neCCHVc63iW/mpiIVrNugpZqrE+p3mLm9lejcUKxXMPRp
   YPaCPLw7fHEF0NMyOiMp8xnMl2Zoa/Z+A2DBJCvrziJpYyLMsnwP9YTmB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="12915407"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="12915407"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 12:25:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="14017792"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 12:25:15 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 12:25:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 12:25:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 12:25:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 12:25:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/1W7qSEfGs7zwADECmHFXOb4l4k7QhTXnGInQ28g9o78Lv0j7mrxZR4ebsoZU6yCjpabzLhO9tF7DhPsu1AJ5guqV0MG4+mGkJkimkgdeyfU6H+qKaVy47HaQtk+lyBWeFARwdOvSybQ2c5QIrUBc/xSSDWJm/03ObQ3VLeCVW52uFj3iFxVb01LrVjioZoBX5H2sCWJhnjgv+NuKcYGMC48DXhRnwhkWEZ6C9ZGPhn6ksZujzo11p4AeiiDg1EVmSP2cSVFYJxbkxTCiM3RmXR0tXfspoaHFY1qf132wmpl35ZarNMa9spaUtW6yhsxYrXEzBUlvYpTMybiwZfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcnGuB/YPm+0P6t/f1+R+R6IvJif2waFf6oxduQefTo=;
 b=AKx83wIt2w+W0xrU1Zmws+/XuiVJFY8Bb+A5z6yT6+LQ83MayC3E+xyUX+QL3J/KRWL8nNhgVIbqCETw1z4xTdPmUL5q7TozS138/hs/HvM7UtaURdWPR7+WJG2+iKyVPIxWYaw5YqSgmd/TbarSHGif0eZdJpnDd9zlquSjFWFPgapUR+k/LL9yhr6/U1+DgZar0Yx+HV9Zr8UMR9/ee8LnVJzHhDfyyFTVkvUsJnL6NZTmpSkP2ZrBN6XorOuZdq4233OvIehX0qcsazDZV6B20+inEHLE1pIpFJI5pvjV7r/y0su8IdNs1mVrWblXiGQcojwOv3C8KGwZIYNcMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH0PR11MB5564.namprd11.prod.outlook.com (2603:10b6:610:d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 20:25:09 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 20:25:09 +0000
Message-ID: <74320528-097b-4395-9e61-928a4eb9771a@intel.com>
Date:   Fri, 17 Nov 2023 13:25:06 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fan Ni <nifan.cxl@gmail.com>, Lukas Wunner <lukas@wunner.de>
References: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
 <ZVfIaNhiSc-yQZo5@rric.localdomain> <ZVfJ6Fxidvw_gz7r@rric.localdomain>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZVfJ6Fxidvw_gz7r@rric.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH0PR11MB5564:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f375af-2ce3-46ae-6b6f-08dbe7ab4b79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QezIIxjSDck4900L3L2wUFERrP6js1xziv0CRAUVhbw44Vmqaia8hozDdmLjoPdPQTd1iIZ4IEg688Cpc3RVxvsroK56Hxi7dO7qZExkREryTmO/+htqGXuqGavGZguNdgtw3IrsEsW3LEHT2+E5f7taxPptIcJkiklKZ0dIow0cpdRsc1WJGM+bQClSEQZIqEJVgXuu6F+v54vBDmwymNShJFL1uJOxdEp3wlI4B0YuvBbdjyHm1cDce8+d/0lsOqfG24MOEmjLqIrRNlVBiHQxxKO5ybRk6Ke/sIDnZRutRUE75P1rQW/WzmqQxC11OjUn6Ws77kQ58dPT5aE8ASLiOrhrim8uC0eOA8DV569pV/JW8qd5QW3156lsB1bvE7c/HuymVz3WWEbwSaH8U/Emq7bZrNwfUHfy6t2I+mijXkgyEEKgagqbNN+j/DZaKUkq/zK/EWYFjsa6ZrSxykgKpP5bGJEMerQ1Py0XytmZedze3353zSQAZbKoSaSd+vr582ALwCWSyMCSl7IFkoEzUiPIkzZyFY9LYkDmhBZQVPGEZroU74+72DKIBaH+bWQwIJo94EoUWGmIRwHXdXbMjwR/hv+M6dhShf3SYBeLV+BVDKum3GCNgx5iQU8sRGL+7IPpDsIafQyDpGIxXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6486002)(2906002)(478600001)(31686004)(4326008)(8676002)(5660300002)(8936002)(53546011)(6506007)(44832011)(66476007)(66556008)(66946007)(6636002)(316002)(110136005)(54906003)(6666004)(2616005)(41300700001)(26005)(6512007)(83380400001)(38100700002)(82960400001)(36756003)(31696002)(86362001)(26583001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNjUUtvSXpxTjR5Wnp2VXNCaHRvN0taTWZCczFUaFFQTWhCdFVsYzNyRFZC?=
 =?utf-8?B?ZEJoZVkyY3BsQ21melIwRnFLWmtXaThJbG1ubUJ4TFBEQUNoOHIrZFZ1UmEr?=
 =?utf-8?B?djRrU2xFaTBDZGQ4bFpDL0pnRmpoTGQ2T2JhSW1oUnhCK1dDd2pISjNmSDYy?=
 =?utf-8?B?eE40dmRGdUdkLzVkbzdQa0JyWVU1Wk9zN3lUZUZGeUgxOGNua3NIaXpjcmZZ?=
 =?utf-8?B?djN0Rm5JN0d4VXhpeTRBREtqaGkzTE9SaGZBT2xSNDZFVXl5SUhLeUtFQVpq?=
 =?utf-8?B?WGwza2lxMXFmcnJITnBFMHdBb0M4eXJNU3YzMUY4ajVvbnRVcGxYUElvMUcr?=
 =?utf-8?B?N00vSkQyemUzYy93azdNaWd6WHk3V0pvVGUyaGtlWWVBQmhYdTNvQmpVNWkv?=
 =?utf-8?B?MXRUbUsySnRQTUUvOWZDZzF5SytvTHNhK3RubHRBb3l2UElvWFVqelhKUyti?=
 =?utf-8?B?SXZBUFByUmcra1E5V25WQmk5WGlWcm9kNzM4TFBTWEF2VnYzNXVBSXRCSHp2?=
 =?utf-8?B?cjlZRS9Gb09Sc0lReDFBZStFUkE3aEJBekI1SmRGUmNGYnE0V0JiTkkzYmFs?=
 =?utf-8?B?d0tjUkM4V2VEZnh3eWpsaXNoenhCaHZJNWlCbS9lMERuUmVKQVlaL2N0K0hq?=
 =?utf-8?B?ZzZnMEppVjNiclJNVUdXc29STzhua1lyYjBBMUY3WHpGWmlUNGhjMjV4WjhH?=
 =?utf-8?B?VCs5QzYwK1VNZjhxclBnSEpjWlVoV05YWlpiRkgrL01PK0FpYnVnNHdDN290?=
 =?utf-8?B?bU1jOTVtSUg1cFh5OXZaUnIySEg1V0NCRmpIYzBLNTlDdEdDVUlrNmI2SnBB?=
 =?utf-8?B?YWVEWkd1N3ZiWktuQnNvOEduYjZVbkNORm9jckgrWjNMbXZsRmFLRFZHQVFr?=
 =?utf-8?B?WmI4MWI5aHVlMmZyRnBqbU5lR0JRaEZxMzB1RElDWml4TGg4L3BJeDFLTjAv?=
 =?utf-8?B?b0JUbTVZa2RWdEVLM09hZElicG4xSFFHKzllLzdHME5zNWJFR3g4UXcwc3Z0?=
 =?utf-8?B?TjFDVk10QWJuQ1FmTTMrZW5qcnhVMUlFdGhPbWNZT2NUakdaTlMzNWtpbDVt?=
 =?utf-8?B?TkFMSGhjZzdabmJYSG5GVmNkOC9jRnhaZVBkUklNa1RTZnI0emdzSHdiSnAv?=
 =?utf-8?B?RTV5V1JkeVJCOWw3Q1FqSnBGTWs2MFBMNDhGRnlEbGNvejQwcklMZFB1R21n?=
 =?utf-8?B?MXR0SW1MWER3MzJmaXJ5NXZEK2dVQVlSeVVhdGp2UlF6dHYzb1RabjNyZldi?=
 =?utf-8?B?bTlnV3kvRlhwcTl1T1I5em5NbXpBeFdTVVZ2NldMSkwxS0U5alRHSWRzYW5U?=
 =?utf-8?B?b0g3aTVCcWhJNUtnZGNTeEdoTm1ScnVvdytrYUYydzJQUEVaZG14SjhzVDB4?=
 =?utf-8?B?WE5ISmc1VnNjejlWRTc2VStoTGRpZzVoWG4wM256U3pabXUyUzc3NFlzVVRn?=
 =?utf-8?B?QSthWjk2TzVwQ2FDQlZ6dVB1czNVWVRSamZRNUpoTG5ITTM5SE5QV0czUXo2?=
 =?utf-8?B?amxxZGJxdmpUUVJlbXJKY1d0blNtNDhzdkkvVStuZzVwSzZQLzVpZng2UDE2?=
 =?utf-8?B?d0dlY2VaU3JIL21GTXE4Z1YwNnM5UTRPb2JnNU1aSFArV1cvV1hwaDRJWXFD?=
 =?utf-8?B?cWl5ZFlnRmN2Ri9QTE5HanAwcDBOR3R1RFlZRnNrS00zOUxweXg5eEIzU3Ji?=
 =?utf-8?B?MDg5dmZRdFIybFQwV1RhVTZScndWRDRyRzY2Z1BCQkRjSVhyTGZCbjhkVnVx?=
 =?utf-8?B?WURYNXBONm9xWFdaOFZLRzdmTklEY1VlbTdzYS9sWkVxMFdHQ1hvMFFLbHlC?=
 =?utf-8?B?Vk5aYTYxMHBGajlMSEF3bUdqcExESStqUHF3OVRyUExvRFZKMkxyeTlpTUd3?=
 =?utf-8?B?Um1HMUJJZUV4dXNOVGs1UWkwMWN1OGEvVEVDMk5LNm9Kb0dVcmxJUFBnbGw1?=
 =?utf-8?B?Q3lCS2NKUXdWL2NKZnNCRUhPZFZBaGJTd2Y5VnFnUmhHMkhhZENHVy9qbVhN?=
 =?utf-8?B?TGRiUUR3QzRFR1JCNEd1dFpzcDVWRFlzcnJPNXZ6QWludFlQbjhiOHhtcVhk?=
 =?utf-8?B?VFBUYWJUUnFJc2MvazVsL1VrWjJGSEM1c2pCalJjcEQxUmFiYmVVaWJqaVJy?=
 =?utf-8?Q?48b+9g0VqzB3n0FpROfVqS1AS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f375af-2ce3-46ae-6b6f-08dbe7ab4b79
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 20:25:09.6274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fJHu8LbJg4XLfwManfomSz8sVFAUH+UP2u+IsIWQveet3GrRwJ6xTFMQ5MPO9XIQfzX94q1ryEvuxHufEOD5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5564
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



On 11/17/23 13:15, Robert Richter wrote:
> On 17.11.23 21:09:18, Robert Richter wrote:
>> I will send an on-top patch for 6.8 that reworks that code area to
>> remove the pointer arithmetic.
> 
> Here it is:
> 
> From 13787f72c20b8c54754ae86015d982307eae0397 Mon Sep 17 00:00:00 2001
> From: Robert Richter <rrichter@amd.com>
> Subject: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
> 
> Reading the CDAT table using DOE requires a Table Access Response
> Header in addition to the CDAT entry. In current implementation this
> has caused offsets with sizeof(__le32) to the actual buffers. This led
> to hardly readable code and even bugs (see fix of devm_kfree() in
> read_cdat_data()).
> 
> Rework code to avoid calculations with sizeof(__le32). Introduce
> struct cdat_doe for this which contains the Table Access Response
> Header and a variable payload size for various data structures
> afterwards to access the CDAT table and its CDAT Data Structures
> without recalculating buffer offsets.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Fan Ni <nifan.cxl@gmail.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 80 ++++++++++++++++++++----------------------
>  drivers/cxl/cxlpci.h   | 19 ++++++++++
>  2 files changed, 57 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5aaa0b36c42a..f900740c6dea 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -517,14 +517,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
>  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
>  
>  static int cxl_cdat_get_length(struct device *dev,
> -			       struct pci_doe_mb *cdat_doe,
> +			       struct pci_doe_mb *doe_mb,
>  			       size_t *length)
>  {
>  	__le32 request = CDAT_DOE_REQ(0);
>  	__le32 response[2];
>  	int rc;
>  
> -	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> +	rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
>  		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>  		     &request, sizeof(request),
>  		     &response, sizeof(response));
> @@ -542,56 +542,54 @@ static int cxl_cdat_get_length(struct device *dev,
>  }
>  
>  static int cxl_cdat_read_table(struct device *dev,
> -			       struct pci_doe_mb *cdat_doe,
> -			       void *cdat_table, size_t *cdat_length)
> +			       struct pci_doe_mb *doe_mb,
> +			       struct cdat_doe *doe, size_t *length)
>  {
> -	size_t length = *cdat_length + sizeof(__le32);
> -	__le32 *data = cdat_table;
> +	size_t received, remaining = *length;
>  	int entry_handle = 0;
>  	__le32 saved_dw = 0;
>  
>  	do {
>  		__le32 request = CDAT_DOE_REQ(entry_handle);
> -		struct cdat_entry_header *entry;
> -		size_t entry_dw;
>  		int rc;
>  
> -		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> +		rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
>  			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>  			     &request, sizeof(request),
> -			     data, length);
> +			     doe, sizeof(*doe) + remaining);
>  		if (rc < 0) {
>  			dev_err(dev, "DOE failed: %d", rc);
>  			return rc;
>  		}
>  
> -		/* 1 DW Table Access Response Header + CDAT entry */
> -		entry = (struct cdat_entry_header *)(data + 1);
> +		if (rc < sizeof(*doe))
> +			return -EIO;
> +
> +		received = rc - sizeof(*doe);
> +
>  		if ((entry_handle == 0 &&
> -		     rc != sizeof(__le32) + sizeof(struct cdat_header)) ||
> +		     received != sizeof(doe->header[0])) ||
>  		    (entry_handle > 0 &&
> -		     (rc < sizeof(__le32) + sizeof(*entry) ||
> -		      rc != sizeof(__le32) + le16_to_cpu(entry->length))))
> +		     (received < sizeof(doe->entry[0]) ||
> +		      received != le16_to_cpu(doe->entry->length))))
>  			return -EIO;
>  
>  		/* Get the CXL table access header entry handle */
>  		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> -					 le32_to_cpu(data[0]));
> -		entry_dw = rc / sizeof(__le32);
> -		/* Skip Header */
> -		entry_dw -= 1;
> +					 le32_to_cpu(doe->doe_header));
> +
>  		/*
>  		 * Table Access Response Header overwrote the last DW of
>  		 * previous entry, so restore that DW
>  		 */
> -		*data = saved_dw;
> -		length -= entry_dw * sizeof(__le32);
> -		data += entry_dw;
> -		saved_dw = *data;
> +		doe->doe_header = saved_dw;
> +		remaining -= received;
> +		doe = (void *)doe + received;
> +		saved_dw = doe->doe_header;
>  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
>  
>  	/* Length in CDAT header may exceed concatenation of CDAT entries */
> -	*cdat_length -= length - sizeof(__le32);
> +	*length -= remaining;
>  
>  	return 0;
>  }
> @@ -616,11 +614,11 @@ void read_cdat_data(struct cxl_port *port)
>  {
>  	struct device *uport = port->uport_dev;
>  	struct device *dev = &port->dev;
> -	struct pci_doe_mb *cdat_doe;
> +	struct pci_doe_mb *doe_mb;
>  	struct pci_dev *pdev = NULL;
>  	struct cxl_memdev *cxlmd;
> -	size_t cdat_length;
> -	void *cdat_table, *cdat_buf;
> +	struct cdat_doe *doe;
> +	size_t length;
>  	int rc;
>  
>  	if (is_cxl_memdev(uport)) {
> @@ -637,40 +635,38 @@ void read_cdat_data(struct cxl_port *port)
>  	if (!pdev)
>  		return;
>  
> -	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> -					CXL_DOE_PROTOCOL_TABLE_ACCESS);
> -	if (!cdat_doe) {
> +	doe_mb = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
> +	if (!doe_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
>  		return;
>  	}
>  
>  	port->cdat_available = true;
>  
> -	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
> +	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
>  		dev_dbg(dev, "No CDAT length\n");
>  		return;
>  	}
>  
> -	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32),
> -				  GFP_KERNEL);
> -	if (!cdat_buf)
> -		return;
> +	doe = devm_kzalloc(dev, sizeof(*doe) + length, GFP_KERNEL);
> +	if (!doe)
> +		goto err;
>  
> -	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
> +	rc = cxl_cdat_read_table(dev, doe_mb, doe, &length);
>  	if (rc)
>  		goto err;
>  
> -	cdat_table = cdat_buf + sizeof(__le32);
> -	if (cdat_checksum(cdat_table, cdat_length))
> +	if (cdat_checksum(doe->table, length))
>  		goto err;
>  
> -	port->cdat.table = cdat_table;
> -	port->cdat.length = cdat_length;
> -	return;
> +	port->cdat.table = doe->table;
> +	port->cdat.length = length;
>  
> +	return;
>  err:
>  	/* Don't leave table data allocated on error */
> -	devm_kfree(dev, cdat_buf);
> +	devm_kfree(dev, doe);
>  	dev_err(dev, "Failed to read/validate CDAT.\n");
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 0fa4799ea316..d12ed9d8dec1 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -85,6 +85,25 @@ struct cdat_entry_header {
>  	__le16 length;
>  } __packed;
>  
> +/*
> + * Response contains the CDAT only response header of the DOE. The
> + * response payload is a CDAT structure (either CDAT header or entry),
> + * it may also mark the beginning of the CDAT table.
> + *
> + * Spec refs:
> + *
> + * CXL 3.1 Table 8-14: Read Entry Response
> + * CDAT Specification 1.03: 2 CDAT Data Structures
> + */
> +struct cdat_doe {
> +	__le32 doe_header;
> +	union {
> +		u8 table[0];
> +		struct cdat_header header[0];
> +		struct cdat_entry_header entry[0];
> +	};
> +} __packed;
> +
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
