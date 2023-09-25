Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7247AD77B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjIYMEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjIYMEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:04:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A635EE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695643409; x=1727179409;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zErDlVvL9qqnIU8F33Ah/15Q7C2Tf89RWcRmWqqxTdY=;
  b=Zq1VDSMVktzLxeG4YQU3zHVOXivs6GS8ZqLFAHijce4kqSBgSM3puzMz
   ZvoxF2nCssuMKww4P3KNnmWG4N15lSMMsjWKnbStSzjmekHBYRwNimw3f
   mCBSzZgYmX/nOhgAnFaR3jodRjEYR8kvBvRUHsz6HM3kjVxXI6yGKsT7N
   Qmo44M3C5wWi6qRGUiDx5WIHSZ8SAi8dWdSyv/WWS9RUWlBAucmiN4jS4
   LE1+fI5kIJscLxMi4gVVXKHdiqj5fUl/l4qfu1JeHTEj8OizHtZ+qe2p5
   KBnl9FkqoSFWeJmY3AJI8cv+jbm4+ANKkMcmQ5rXbtp2XGjwxOkvNq4SA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447722773"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="447722773"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838545293"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="838545293"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 05:03:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 05:03:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 05:03:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 05:03:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 05:03:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgGYvXq3fAY5/gEi+5JcDKulTA3YNYCWRfHWS7OA1u4+HjuK9h9yEIntcUVBS142Y2CWcJp4weCfpAGgu1JaTUc0h/WdnEzbLk89oSnNHGfm6+T0QYsVVCA9eM+81uvbgKNDmoeKVMKkN8rYGt+2f9Z8GbM7JorK0NPuywyoCoPSRENQFOzNgvDYccYuut9Wh4j2x/30F+AH3MNct9422D7XT8nGctJSLaKAU+2eOmkI99ekCYHQCWhvWhvy8pAOtiz7tMGwYqQUyfb10QdEREr5el/564nsZ5XT3avbzb2jTNpMGgmxUt2ZepmmFEPeHAEVggYJfzBRbzI1opyteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlE/wnw8pUnID5UsU6vPzvsjBnKvgE93CTRA3N7fzpg=;
 b=USUkVCPEOr8oIw5gZY/bkyBvDbezr7gnHOBB3s4/j4RCHMP95F2MvvQRVz7fBsc0a2EuWTGthaExeb3iT2XYarm4auay3V0HnYibz41Y4zCoUu7wOQhC4td2j9W41wX1fMfM03UAmYqZHIHgzcLk/lV7RNpDIUwc5bvimXcM+g3q+lQJr/lWvCU6N767ohfI8YcO+UyPYZfkU1CpbFSvNC44LlTY/VkJkg8spi17v8iuEC3Z+lTVrEsyXnm0iF8i8p2+AYF/8WsVvkTNRmGJwEEHqj8Sl2WF/kZijPfa422uQjufzeRQHDlLVkdtpB3Jaz6yUlL4+LYb1v2ieU8bxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5462.namprd11.prod.outlook.com (2603:10b6:208:31e::5)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 12:03:23 +0000
Received: from BL1PR11MB5462.namprd11.prod.outlook.com
 ([fe80::5d9b:b3d1:7125:f777]) by BL1PR11MB5462.namprd11.prod.outlook.com
 ([fe80::5d9b:b3d1:7125:f777%3]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 12:03:22 +0000
Message-ID: <3931328b-2470-9cb7-ef87-5d0fdeb58142@intel.com>
Date:   Mon, 25 Sep 2023 20:03:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] iommu/vt-d: debugfs: Create/remove debugfs file
 per {device, pasid}
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20230922151636.77139-1-Jingqi.liu@intel.com>
 <20230922151636.77139-3-Jingqi.liu@intel.com>
 <6a0abdd4-3c81-c7dd-1cbf-a3c04762dd41@linux.intel.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <6a0abdd4-3c81-c7dd-1cbf-a3c04762dd41@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To BL1PR11MB5462.namprd11.prod.outlook.com (2603:10b6:208:31e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5462:EE_|MN2PR11MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: afadf806-798e-449c-6652-08dbbdbf6a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpKeJ6AzN3AVpF2N5j+NlmKpzRWjxx4HyrbBwcGS7ONDBeSZFkEoK6oy/e71ssdcQJtt+MSK3CnJ75AJW+WkBxJn/bdt0IVGuo4+CvrLs/nx9PhwXzZe6idD7clpCVnwZH+CggY6RdyZezTv9Xd4IYEcDk1angrKzGjXHd8PN1yKLS0j0VDrtWzbFLxNRWUMOgcoYj59yF0CX4KKwj6yCZLjrT5xeIitKn18T/b1y8HJ82u/DZRsv/6NkjtysUUpTdypYG/RAdCUfQO680k7Bty8mVi7s8fhB/3NKLrYGsek8gJWopRTT+VlnSPRNzQMxJdArOup5FwQXHtEVFxjvGqdmGl/r8TUJXEpQgIpdgPql9jDDI112HjVHJAtMYbGbQzLsTiyPVC1h8lWCbHvI0gYN0vpVf9DOlEfKlz+dcWO9XAhH6LRgjCVC5hCZxHtKvD8lW61g6DKh6/lfBOC7SC3VXI2Q4bEpOCFnKd0r33FtKMzdOHAUdzA4vocQLReFAW5nioVr204drV8x/LZft63lN86Np55kwQryNTNXnnyCA+FXJVpyfGHY9xmpfXclkB7SPSlhE2eeoW/gF8IoOGpdZZdyoGUx8Lpq8BHiwfi2XGizUAvlF1YqutSlDD/fWgjIz1B4M4O8+4DiXNPCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5462.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(31686004)(6512007)(66476007)(316002)(66946007)(2906002)(110136005)(66556008)(41300700001)(8936002)(4326008)(8676002)(478600001)(6666004)(5660300002)(38100700002)(53546011)(6506007)(83380400001)(36756003)(2616005)(26005)(6486002)(86362001)(31696002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVhTTWhhK0lMdVUzdU9ZejNXekRRUXBoMHZ3VGYwc1g3M0hrZ1hCZGE2ZnVr?=
 =?utf-8?B?alZ3NjNBQVZRMjZZTjU0TkFKd2NVN3EyU1VMc2MxbzVjekcrblNPWVVHejNm?=
 =?utf-8?B?NmFuTEt1ekM3N0NYM1ZhcmdmMjBpYUwyZG9Mbk5SanY2eGw5SVo1bVE1MFYv?=
 =?utf-8?B?M3RNVTFoOVpSTW5DUWVaZ0U3dExHaFNtOWUyLzlBNXg1Ry9qVGVodVVSWjU5?=
 =?utf-8?B?bCtybGhXaVNDRDJLNEZCN0RsaEcyVUlTNzUrODhZNGh4VkxTWFZOVDBhdHd3?=
 =?utf-8?B?aC9odTh6UEJ2MUF6VVMwOW45dW5wSlBuU1VkeGhsUlpHbjdpVnQ5bDArL0JY?=
 =?utf-8?B?blloaTBRa1JML3R5Rzhmd09oM0o0YWFROU1pZko4R1hVaThNaExHeG1JNUtr?=
 =?utf-8?B?WW9ra29tNHkvRmZPYzRhUnQraDA4cHRWeHFmUW9md2Rpa1puby8zT3QxSnJH?=
 =?utf-8?B?RUgxTHVWQXhuWUtFQmtidUdHUWQ3Nkx0cktEYVR5TVMrT3dpQmw3Z2llM2Nm?=
 =?utf-8?B?dXkxaHZZa3JtdWIzajlqaVBaMWlLY3c3Y2lVYzNNd1dmWXRWRUlFVVBlZ0FS?=
 =?utf-8?B?SUtYbHkwdXZSY0tHV2YveWZLdGxSRGhYYWV6cHpCVGI2VlZUWXU0NkJXM2lr?=
 =?utf-8?B?eGNGMnl5VnFtTC9yTi9HU3paZ1FhRWdWLzBuMVI0bG5HVUpxVk5qcTNraXU3?=
 =?utf-8?B?alNIZy81M2xrL3h5SVpUd1NPZ2Zxb2RkMUE3YjQ0NDBUbGo2VWs4bnpMWGpS?=
 =?utf-8?B?b0N0SWljN3o2dFdXSWVRSG9WNmViSzBGdjN3ekxaeXZCWmlFMFpqOEY0WUVj?=
 =?utf-8?B?YWNzTlJvUm4zY1JKbkxrdnYreGVKNHdsWUFFWmU2S2xsV1MrVDQ4MW83YXVq?=
 =?utf-8?B?eW80S1FQUFRma0J0dkd2VXFYTHdUSnEvRm84bk1mTDU1UDJDUDhOemwrR1Jt?=
 =?utf-8?B?L1RVd0hOVWZRS0QvRWlJc1l3YWdJRUVLaUo0RHFISFhWbXVUK3ZyNlliSlVN?=
 =?utf-8?B?VHo4UExUUTY2MEMxejhJZkpYNVE2MzAwSXU4bXRQRmNJOFhvMmFMdE56bjA2?=
 =?utf-8?B?ZnZhczdXZ1lUVWxtV0VaVisvREdYRm83T1JhSHVUNXZYcXVobnNMcFk2bHAr?=
 =?utf-8?B?YVR3bUxVL3krcTR5OU02UGU4MU8zcVNVQkxneW1yT0QxQURyd05pQ0hxQzFV?=
 =?utf-8?B?TDFPN0JkREFNNFZJcVNWOUlGaHRFaVB5bG5RcUxUeVNDVWk3MnJYNUwwVi9i?=
 =?utf-8?B?UkRrdHJxL2F3ckQzRFd1WU1UQmpIMCtHRkhTNmFEc3BlSXBEUmt3QVI4R096?=
 =?utf-8?B?TldBbFdlQ2dtS0JPOGx2RFZJVnd1MzY3NWNVamdzYlBRUFRKSXAzdk5XSnc1?=
 =?utf-8?B?TUU0SHNQdE5rZTVob2g3NEtHVGwrT3lqTnlhV0xKNVpxb3VjQ29RRkxGdTFj?=
 =?utf-8?B?WmpxblJHRHVGaksrWWZjUFJqYjJBWjFxOFVGUExIL0xQVG54bGJIU3h0L2xr?=
 =?utf-8?B?Sm9QczdMTTM2YWlHaFZyNVVqeUoyeDlOeU03MXBkVitRbTV5ZzhrRDJZK1Nx?=
 =?utf-8?B?WDFtdWNhTGxWZDV4aFNsWkpyRHFXWHB5QnJoQVg0emdiZWdDaU1wTFpkNS9r?=
 =?utf-8?B?N2xKWFBwZWFIcjY4c0pwR1N6U0JIK3gxbGtPb2RzZGNld3F0WllhYXo1UGh0?=
 =?utf-8?B?QlFXL2NHdlRNZUhiazc3SVJwWlJXNnQ5VGRjMXRVOFlkMk0vMHhIYTRSOXRU?=
 =?utf-8?B?Q25tUUNVekZNTER1YTJjV3Z4Vkp2aWJPc0V6SzF5WEtTVE1ETXU4ZWtHVUFO?=
 =?utf-8?B?Ym9wUzRpcHJ5QThQWURqVlhLcG90emZQWjdqSXVzNENsaXBPcGRJNkczdWVL?=
 =?utf-8?B?YTBJcC9mVmVvVC8vYklLVDhybUM4cVIxU3ZuakYyUHp5QlpMaHZxU2d3T3pU?=
 =?utf-8?B?bXN5YUtVUDhwWkNmNDZvODQwQkdPY1FvMG5TMmtVR1Q1MlA1S2dkVGp1NFI5?=
 =?utf-8?B?dEI0bWhKeGpNM0hjb3hPQVVSOVBZdzZSMVZJSkNNOWVDaUNORjQ4bm5mUkZE?=
 =?utf-8?B?WXEwSTJnOTZjeXB5NHVrajdwVUJTK3N4dlVIVEh4eTZTaEtuU2plQzRrQzJn?=
 =?utf-8?Q?fVz8Djo28T855hM49zp+jdh0U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afadf806-798e-449c-6652-08dbbdbf6a63
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5462.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 12:03:22.7798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4FjNzV006KtiVCK3pZUaa8V2JZXUOxFvKHhAGQfjFVkzsRZo4QCOUb+tovFdWMPz0l2zXF1VF9MuOWsqUE+KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/25/2023 9:47 AM, Baolu Lu wrote:
> On 9/22/23 11:16 PM, Jingqi Liu wrote:
>> Add a debugfs directory per pair of {device, pasid} if the mappings of
>> its page table are created and destroyed by the iommu_map/unmap()
>> interfaces. i.e. /sys/kernel/debug/iommu/intel/<device source 
>> id>/<pasid>.
>> Create a debugfs file in the directory for users to dump the page
>> table corresponding to {device, pasid}. e.g.
>> /sys/kernel/debug/iommu/intel/0000:00:02.0/0/domain_translation_struct.
>>
>> When attaching device without pasid, create a debugfs file with
>> PASID#0, i.e. RID_PASID. When attaching a domain to a pasid of device,
>> create a debugfs file with the specified pasid.
>>
>> When detaching without pasid, remove the directory and file for
>> PASID#0. When detaching with pasid, remove the debugfs directory and
>> file of the specified pasid. Remove the entire debugfs directory of
>> the specified device for releasing device.
>> e.g. /sys/kernel/debug/iommu/intel/0000:00:01.0
>>
>> Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
>> ---
>>   drivers/iommu/intel/debugfs.c | 117 ++++++++++++++++++++++++++++++++--
>>   drivers/iommu/intel/iommu.c   |  16 +++++
>>   drivers/iommu/intel/iommu.h   |   4 ++
>>   3 files changed, 132 insertions(+), 5 deletions(-)
>>
>>
......
>> +
>> +/*
>> + * Create a debugfs directory per pair of {device, pasid},
>> + * then create the corresponding debugfs file in this directory
>> + * for user to dump its page table. e.g.
>> + * 
>> /sys/kernel/debug/iommu/intel/0000:00:01.0/0/domain_translation_struct
>> + */
>> +void intel_iommu_debugfs_create_dev_pasid(struct device *dev, u32 
>> pasid)
>> +{
>> +    struct dentry *pasid_dir = NULL, *dev_dir = NULL;
>> +    struct iommu_domain *domain = NULL;
>> +    struct show_domain_info *sinfo;
>> +    char pname[10];
>> +
>> +    if (pasid == IOMMU_NO_PASID) {
>> +        struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +        if (!info)
>> +            return;
>> +        domain = &info->domain->domain;
>> +    } else
>> +        domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>
> Can you just add domain as a parameter to this helper? This helper is
> probably called in the process of attaching. so the domain pointers may
> not be initialized yet.
>
Thanks.
Yes. This helper may be called before domain is initialized.
I'll add 'domain' as a parameter, and remove the check code above.
Check if the 'domain' is valid as the following code.
>> +
>> +    /*
>> +     * The debugfs only dumps the page tables whose mappings are 
>> created
>> +     * and destroyed by the iommu_map/unmap() interfaces. Check the
>> +     * mapping type of the domain before creating debugfs directory.
>> +     */
>> +    if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
>> +        return;
>> +
>> +    dev_dir = debugfs_lookup(dev_name(dev), intel_iommu_debug);
>
> The comments of debugfs_lookup says:
>
> /**
>  * debugfs_lookup() - look up an existing debugfs file
>  * @name: a pointer to a string containing the name of the file to 
> look up.
>  * @parent: a pointer to the parent dentry of the file.
>  *
>  * This function will return a pointer to a dentry if it succeeds.  If 
> the file
>  * doesn't exist or an error occurs, %NULL will be returned.  The 
> returned
>  * dentry must be passed to dput() when it is no longer needed.
>  *
>  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
>  * returned.
>  */
>
> where is the paired dput()?
>
> Ditto to all debugfs_lookup() calls in this file.
>
Good catch.
Need to 'dput()' the entry before returning from the helper.
I'll revise it.

......
>> +
>> +/*
>> + * Remove the debugfs directory and file corresponding to each pair of
>> + * {device, pasid}. There're two scenarios that will call this helper:
>> + * 1) Detach the specified device with pasid.
>> + * 2) IOMMU release a device.
>> + */
>> +void intel_iommu_debugfs_remove_dev_pasid(struct device *dev, u32 
>> pasid)
>> +{
>> +    struct dentry *pasid_dir = NULL, *dev_dir = NULL;
>> +    struct dentry *dentry = NULL;
>> +    char pname[10];
>> +
>> +    dev_dir = debugfs_lookup(dev_name(dev), intel_iommu_debug);
>> +    if (!dev_dir)
>> +        return;
>> +
>> +    /* Check if the entire debugfs directory needs to be removed. */
>> +    if (pasid == IOMMU_PASID_INVALID) {
>> +        struct list_head *plist;
>> +        struct dentry *sub_dentry;
>> +
>> +        list_for_each(plist, &(dev_dir->d_subdirs)) {
>> +            sub_dentry = list_entry(plist, struct dentry, d_child);
>> +            if(sub_dentry) {
>> +                dentry = debugfs_lookup("domain_translation_struct", 
>> sub_dentry);
>> +                if (!dentry)
>> +                    continue;
>> +
>> +                if (dentry->d_inode->i_private)
>> +                    kfree(dentry->d_inode->i_private);
>> +            }
>> +        }
>> +
>> +        debugfs_remove_recursive(dev_dir);
>> +    } else { /* Remove the directory with specified pasid. */
>> +        sprintf(pname, "%x", pasid);
>> +        pasid_dir = debugfs_lookup(pname, dev_dir);
>> +        if (!pasid_dir)
>> +            return;
>> +
>> +        dentry = debugfs_lookup("domain_translation_struct", 
>> pasid_dir);
>> +        if (!dentry)
>> +            return;
>> +
>> +        if (dentry->d_inode->i_private)
>> +            kfree(dentry->d_inode->i_private);
>> +
>> +        debugfs_remove_recursive(pasid_dir);
>> +    }
>> +}
>
> The above is too complex to review and maintain.
>
> If I were to make the change, I would move the device directory
> management to the IOMMU probe/release devices path, and keep the PASID
> directory management in the domain attaching/detaching paths.
>
> Or I overlooked anything?
Good point.
In this way, the debugfs device directory and pasid directory can be 
managed separately.

intel_iommu_probe_device()/intel_iommu_release_device()
is responsible for adding/removing the device directory.
In the domain attaching/detaching paths,
add/remove the PASID directory and the corresponding debugfs file.

I'll implement like this.

Thanks,
Jingqi
