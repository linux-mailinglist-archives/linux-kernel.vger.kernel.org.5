Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECF180C631
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjLKKRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKKRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:17:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC95B8;
        Mon, 11 Dec 2023 02:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702289862; x=1733825862;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mzNvv5owgiB5pYCM51sIZvr6wKI2GwoncdlHRjG8apo=;
  b=b4UyrD3/wQwD98zEXe0mWJLAWIO7Uh95GVEuNUEW5WpO5iZohGpCrUGI
   2fg6DzamKbEO+htafe/kM+vclBwvCaX3bOZcO08Q1NvlZ7MsfnCU34LUn
   tgyaJN7EQh8Op3gTZD+YnerGlYpGSZ44vS4IL7AfRrcD91BdfSC5AyjX+
   qRAm6/sk08JDbXqWqPVfuZ+lJknrV+dtc8tv+UbvaOXyRheuKjwcmhVpr
   pFxIZQXJ4FlTkf64ylHEmkmD7Tok2LBTMhil50r41vPcujrizShVcRBtn
   gADAIjJFKKuGwGTurODe35R5xhezLgBWgtZghhHzXBNB7W2zbfWTXFa6A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1693500"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1693500"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:17:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="946254222"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="946254222"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 02:17:40 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 02:17:39 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 02:17:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 02:17:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 02:17:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Blc4K/9O/8SvThwFZaxyH+aYE47+vf2Eh0/l44eoXd+Qpq9zFd1imgaYvkuuBmkQ9uB+IGCA9IrUDR+ZBzjLWm8RDwRfseFsQ/rsnaWUUwS7vXJpJdkxXZCfmQ8XP+u4l8mxHN+dWaTtXvTRc6CNzBCr2mnCuC7AMjI7manqAvGn2HPVIf8TqjlNkUipJeJ5DFtG1nCJJKnnMIz9klo5YjiqRwRObaECc+9JG3Wny/BgqtDSA7sYI0bYnZnq7+S4smU9HltP1BMd5cGG8IDOEYMZCGE8RD2ZQX8yl87+1GzU4lxtuLmbfkN/ONhOJw9jjRbT9MXNcr9zWOcE4uLqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg+PbDidB59WsZToXbE5X+o2oE4mTewZ6WfBGcAr50Q=;
 b=O7044WCUfcOiiED3WdWf8DKpFH9KszzNSgbPNDQP+SlXFmvbDw91J14xwehlwLpbR0KdO/pqZI1odSZ+emkScRbeALC6xy7PYkcj+ZiAZ0JdH07YwBXxp9txEwDGPMXPAk96HW6nsbfmVYP5qrw7rcl/ofMM6f25dFZiRGnGwi98GlKvgHoi9RWbxSpQYO651cTNSn4dG4WfZdbJ1sdiugbMyn2rz1jwxzCKy0GGeKOvTboRa1098a0eOxfDemLycF3wMBK0giAMhlNooeMnggq5scqSH4Uhuhif/dpBSqpEJK/GRYtgr3WkcSzgKVrTsyr90GTCKnIzFewhT8SQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS0PR11MB6520.namprd11.prod.outlook.com (2603:10b6:8:d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:17:33 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4ef8:c112:a0b4:90f2]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::4ef8:c112:a0b4:90f2%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 10:17:33 +0000
Message-ID: <03d7e8b0-8766-4f59-afd4-15b592693a83@intel.com>
Date:   Mon, 11 Dec 2023 11:16:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 08/12] libie: add Rx buffer management (via
 Page Pool)
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "David Christensen" <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
 <20231207172010.1441468-9-aleksander.lobakin@intel.com>
 <1103fe8f-04c8-8cc4-8f1b-ff45cea22b54@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <1103fe8f-04c8-8cc4-8f1b-ff45cea22b54@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS0PR11MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 05237e04-53c1-4a1d-0609-08dbfa326393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7M0Ah6AMbVLDEoBAbOs1cZ1Vo+fKsnC+8mqmRIpqZt+pDrJeR7Qtp+XBJpyqUSZN8wjVcZW0R0RKRD2nf/d9tlkG4uN0I/AOtsAZXrqT08upTQGJf+h0rqlg6cVhys/1mY7+vqXBL6OZ4vY0jspKQndO4+ehPhfvTIrrninw2kzjXoaFseik1IH82NGYg4y1YIGMIXUY1z7h/GyOIEyVMjFUjFbgsGBWMbhjPku4XTpR0QtMI7fwBVlWrjjb6C2W+iwcM6wPerXrLyQrBP6pu21V+XlOauzfF6VLrw0esgNvZZ++aj1RHy0W2jhnBSIeBaXRozPJGo8F9Uo0vTJ7gTrcXGYK1iogu0r7U/IgqFFjkH+UNCKTE09vMPYTiqrMRdqtrFB77dh/wvWDQfqf7sEmG/jYOPLtR6MSz37QhTD3dBGT28XQuAeIri5Ve7HAV9LtC+1rFYVyKILTykqLxXKDLdlEdh3wFL/yftMVi+VE5eZix2bczOCExmgK4308BBbEfv/3YEpEdkw6NbSOy1C5WgJBanO+QmL/GgsCf++Jjx9UYwMB6dgvgr+Y8SQxr2c139FMFcwBvt1aPrYuYr5V2YRvfbZcy26vHvXsVkazT77Zkax4W2tMUQcH8UXrWp6KrTcI8ExjC3QJD5s7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2906002)(478600001)(41300700001)(31686004)(82960400001)(66556008)(66476007)(54906003)(6916009)(66946007)(7416002)(6486002)(316002)(38100700002)(6666004)(86362001)(31696002)(4326008)(8936002)(8676002)(53546011)(6506007)(6512007)(66899024)(36756003)(5660300002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzFlMlQzbFd0MUhkUDROTUE1MzhvbHZ2dnoybWZ3VGF1dDRiSXlSMEJJL0FR?=
 =?utf-8?B?dEFkTHNuRUo4cjlNOGJ6amJNdzY5bUlTckJOblQrMTg3eVZQQlpFcmpuZmlU?=
 =?utf-8?B?STFJdFpWVDRwVVorbFYyM2NqUGhGbDBuVlBwd2xiZ25MYjNFK2xZdkNCQ1Zp?=
 =?utf-8?B?aU10VHcwTHpoNk8yQmIvZGxDRVg0aWE4eTJMRDk5UUhWdEQ5TGk2UytGMFN3?=
 =?utf-8?B?MGQwU0NlWElsMVRraWlHZStoMjZRQzQ0TUd0K1FQZzYyOWNDMXNsYkhXa25C?=
 =?utf-8?B?bzh5dGxaZVJjNnZ4TUM3NHl0VnBhcFBLRGxJbitJb0lhSjR2ZEEzQ1EvcTAw?=
 =?utf-8?B?Z0JYT0xzZ1dORmQ3NG1FbTJXNkZUdXE1NklLYk0wZkJqUnVZV3FmNHIvOTlk?=
 =?utf-8?B?eGNveG9SLzhOMG5vdkk3d0dkZ3ZuNWhURTZUV2pVK0JZNGxOK0NYdVNNQ2Ev?=
 =?utf-8?B?citVRXh4dkRUNVlMSStzdWUvYU9KdHJ4eEhCem0vQ3Z5T1dZWjJibHVvVmNv?=
 =?utf-8?B?eHp6MCs1OGRjanBpQ3B6YkFveVkvVlllN1R4MFJRL3lvR1RtRVlZWHZyM0dS?=
 =?utf-8?B?SU1aTU01ci9uWmZBa3I3N05yKy9mckRhRXBtUDV0dWZxeGN0WTU5NVNvdjZZ?=
 =?utf-8?B?L0owbzZNdUN0WnVHSWp6R0U5eGJVY2JSZFM0ZzQxamdXeTlxYTlxM0pkM1dG?=
 =?utf-8?B?M2N3bXpvM2RYRDBDWmpxdUd3NHZqQUJrQ2ttclM0b3RXc1d3L1AvVmtPV21B?=
 =?utf-8?B?WlFsS0FzN3hEdU1FaXlsYUNLTGZwL1lENi9LaU15bVNaaThGL21zTCt2Z3Jm?=
 =?utf-8?B?aWJEbzBmZnF2YzZOcFE4a2tzZUhIRHAvaUp4NHpobUc3aE9HNGpzV0loR3NO?=
 =?utf-8?B?REtFeEJBTXV2ZjF5OTFJVEhwNE5QVlNaOFJUazg5OFBuR2hLWG1nT3pVOWQ1?=
 =?utf-8?B?U1dGTkJVOWNORS83MHNjSytMdDlkamREd0N2bVZVZmxQY0tIS1dvUnNHVDJx?=
 =?utf-8?B?eGRacGx6M041dXBqelFxaGdXOHJqQ0xycE5vWmlBd3JkQzN3Z0ZzZzRwYUdZ?=
 =?utf-8?B?aTd6S1dJVWxYNFIwYVEyeGpZZksvN0Vpc1E3Vm1IR1hDWk5nWE9WWnk4NkJt?=
 =?utf-8?B?UHAyTGFOaXk1UWJBd0tXWU56UnlLQVYvbHM3aGdoMlVuL3hjUFY1dzMzWnE2?=
 =?utf-8?B?MDJWa045S3BzSy9QcEhXbkU1MjRpM0lUN0gzay9jSG9OT0xaMUxaU1NXektq?=
 =?utf-8?B?NzJ5R2dFcXRrb0tKTkFBbmJWZWVXZWNUdDAya2ZjOTAveTB4eUdONC9Fd3Jj?=
 =?utf-8?B?Q0tTTUhHRVRNT3phREh1NHRxWFVmYnhxL24zN21SREUxbzVmOFVPUFdBWW9x?=
 =?utf-8?B?VWFQWERjNUlvb2hFOXFiSktPRHJGLytBa1lpOW84MXlXRkUrV0tWU01TQmNz?=
 =?utf-8?B?Q0ZZSjZzdWxReVovazVsTHA1aTE1NG5qTDJuV2w0dzVWMEVSUHRwSlkrelc3?=
 =?utf-8?B?enk0SDFXNFg1Q3JTOHFWUXp0K295L292N3pSTWZWYUw3SzZodXpRckRTOVBo?=
 =?utf-8?B?ZFU1QyszajNubVBwQjlkRy8xR0dYK3dCd281SEhqK2dRZGNVeGlSeGc4L2Vo?=
 =?utf-8?B?bkYvVkFWMk8zM0wrcC9sNHJQY2sxT1UvSSt5dk5wcjFwQzBqTUpBTVhjNXdQ?=
 =?utf-8?B?UzVNMWZ4eS93eFN2eTFnSmVwUjhpMUkyTnN3Z3pPdXN6NURrdVZXUlE5L2pF?=
 =?utf-8?B?L210VUNMZ2hkYURtYm5TaGgzTWhERTJkZllqN29ZQW5sMzdZY3RKT0ZtK3Er?=
 =?utf-8?B?OTBzRDN6Umdtbkl1Vk1oUG5UekJwWUw1VWVEZUNsb3RVNEp5N0Ntak8zY08v?=
 =?utf-8?B?eUczNGdIY0Y4T1pueVN5VGsvOUlnNEVZc0RFY0RYNGVpQkRpV3dpY2JtaWZS?=
 =?utf-8?B?UC8wYWhDOUFEcHcwaUxOOWNFUVhhWDNINXV2K0NQQ3VnRFQxeW1TTmdtamM0?=
 =?utf-8?B?SWNMRHRpdSsxeDFOZ0pnN2UxbnhsTEtoNXpnZTh4eWVZWXAweEF1STE5QnZD?=
 =?utf-8?B?enlyK2hMTU5JNXlHR1J5SFpLNkR4U2wxbWNhSm02ZHJuZzJsRW1JMWFqaUFS?=
 =?utf-8?B?VnhFVmRRWHdIc0c4V0l6eEVPTjlTT1g3T2d4U2JRV1l1eGpySWxCTkF3YWlp?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05237e04-53c1-4a1d-0609-08dbfa326393
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:17:33.1376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HeqXPFRpiH8gezsKiuwNgtVJBTjvoRZ5P0BZPTqc/OmTZqsXqpzvVvnm6DJ7Aqw6ITgGQGpjPUENc6KNTKhDaI+sQAlxoA8kf8W/t9UwFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Fri, 8 Dec 2023 17:28:21 +0800

> On 2023/12/8 1:20, Alexander Lobakin wrote:
> ...
> 
>> +
>> +/**
>> + * libie_rx_page_pool_create - create a PP with the default libie settings
>> + * @bq: buffer queue struct to fill
>> + * @napi: &napi_struct covering this PP (no usage outside its poll loops)
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +int libie_rx_page_pool_create(struct libie_buf_queue *bq,
>> +			      struct napi_struct *napi)
>> +{
>> +	struct page_pool_params pp = {
>> +		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>> +		.order		= LIBIE_RX_PAGE_ORDER,
>> +		.pool_size	= bq->count,
>> +		.nid		= NUMA_NO_NODE,
> 
> Is there a reason the NUMA_NO_NODE is used here instead of
> dev_to_node(napi->dev->dev.parent)?

NUMA_NO_NODE creates a "dynamic" page_pool and makes sure the pages are
local to the CPU where PP allocation functions are called. Setting ::nid
to a "static" value pins the PP to a particular node.
But the main reason is that Rx queues can be distributed across several
nodes and in that case NUMA_NO_NODE will make sure each page_pool is
local to the queue it's running on. dev_to_node() will return the same
value, thus forcing some PPs to allocate remote pages.

Ideally, I'd like to pass a CPU ID this queue will be run on and use
cpu_to_node(), but currently there's no NUMA-aware allocations in the
Intel drivers and Rx queues don't get the corresponding CPU ID when
configuring. I may revisit this later, but for now NUMA_NO_NODE is the
most optimal solution here.

[...]

Thanks,
Olek
