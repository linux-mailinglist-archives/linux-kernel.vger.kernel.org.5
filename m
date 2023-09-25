Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256947ADE95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjIYSYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYSYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:24:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F0B8E;
        Mon, 25 Sep 2023 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695666271; x=1727202271;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KhrzO3K+2jCI8GkexAAeza1+uj1y1ymsQGYBwwwQv5g=;
  b=JrqiDGRumgyvd1jbAraQz6TqBbC7oWaueirvu5s1XAQ3xTiRyi1SV1AM
   hOnBZzihgTdOGwodYzieVW8Q+jNWwA3KEfqUQLQn1GEj4qK1/rsMvnc3e
   cxKlkjtcJ/8Hn4F1m4DsTGcVouYZFelW6XZIGlyHjqVRJ1Ne56XvEUkih
   g9VpU9oJa6MgSo3lmTrISomxbNWoUbbOg9WLJUnLis9j6LtpypNJsFeCW
   eGkCuTRPubUeucVhkhwbU3rBbalPec9wg1Quyxq4V0nKITEAxGjqWOlrd
   +6Pu8BaASIe1kzUnsrzk6FYGw42WdLylBOXQ49mayppPM/NoBD6o/7yYA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360709174"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="360709174"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 11:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="922082434"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="922082434"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 11:24:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 11:24:28 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 11:24:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 11:24:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 11:24:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvN/ZTVCxuL8YzeMRu3dNx9fpD/oB8bWDpHDyrwTDp/DinPhEXyLvVFERZwryXknNEX/J1rZKS2o1UIewRkn8aYr5106eWGKUFVa5lahKZ9gf9ujyDpoQaiyyvWHJAdpesAoXEztLytcbNMOQxOCMinrzlG/mP6nTYcXIDkNrt+3BRREsCklRkpwVLPbctgl1GN2svhnX+TuX5mw/G8pUKfSz7xW15Me58/djRJeUIfcKwCzUVoKpchq7DRGaapbx6LAdS0jNUDOmhuFm3lv4oQAJ9ufvsBzipCxHyZh64e129y5Efs7PcloJ0sv3xT9u7zsRYi+v9YjaxOwEevsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S63fiben6LMNd0w0Gk0k8D/pU7FvweOjHBeZWshhESY=;
 b=VNU61EyaYYnXb/Ys/vwpA5os/Z/2AOvNC34oWiMIEOKINsM+IPpzm5dPEZdz4C4b7VqE4e5iq9JhQsB3aKe4s7tcH8e6einByZoZqouqFBwvkFGFljb25qB0BvMaD9a5KfmPicyFRjf9ca94sh39qoloALAqMaAHKqE5NaT6Rn3Fn+c3qLoH3LGjRmZ2wiJ03+LPol3SNZlUc77MIxUEuLOy7Qs8nykz3/l1D5ihSW6YIL+bQ2KwA/q3Q1j9VR9MH9dp+bkaQXYeLJYtQkWjGAIYsYI5oZv9axFvxmz9BllTMP2W+AkSKLgczVi9cEkzJ6kS4SadKUnBUV6PVSaH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by MW4PR11MB7007.namprd11.prod.outlook.com (2603:10b6:303:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 18:24:26 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 18:24:25 +0000
Message-ID: <3cb7f5d1-ed78-7b36-472f-1fbe9e2d26b6@intel.com>
Date:   Mon, 25 Sep 2023 11:24:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/9] platform/x86/intel/ifs: Validate image size
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <pengfei.xu@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230922232606.1928026-6-jithu.joseph@intel.com>
 <318e7426-fcab-c1e4-6e84-752c332088f2@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <318e7426-fcab-c1e4-6e84-752c332088f2@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:303:8c::29) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|MW4PR11MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f58f3a-d0a3-4ba2-7045-08dbbdf4a5df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEZqQVj/xe6kXz4muQ0Qjnts0ljk6YiVH4Wf+vT6eUw3t7rvwlRlcNNBsHnyPMKF2L6U6C12WiRxIE8krDgOCoe8LC00SsziffHi9jakuqWB5mclXf92Q/9hlC/o88qlbOaRBAcQAJ5//grNTn9pHViHsXfjFFBkzW4qK+Qt7I0Hs2L6ayIz6tSmiq+RQ25ZhgYIl5XQXfkCw/bg4Y8pzeYaGROpvqogi54GFbeH56ixvpfWGkaNgboAZDMrce4A2MgSCOyf8Mm9lk8PGL/MPKv/slZ5I6BPnNmpgNCIKp87kalNPOsdatH0mn/1W2YhbyYwCB2gDo3Pqd7BohQz/1bi9t0eS4on+/eW6ZXSGnn67rCnRLmK+uHR6SQT/xyqmUm/TYd18FVvPCJ6iUwYhz+nYWuWhZQFHa0AP1yMDYU8nQJjzilnpnXvI7YenBnsR2zu25HOxOtx1NPB3KJFHBDuygQR49V/hID+oxFnkd5F3vf+k+XEXFGEP0Wa90SdH8792xjwpB6FrbvYb1laOwsZT7qJf16XYamZMA0EpFQpLsEtP+zNL88OqK5a3R+QmIsbdEVzOzYIQwBhNGH+wdEnxpiafJdKk2H0sR8aBat+KW4aIXPcU3Q7nSERdRVAhQR/opwCTmXlf6zsC/OT3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(2906002)(478600001)(86362001)(6486002)(36756003)(6666004)(26005)(38100700002)(82960400001)(6506007)(6512007)(53546011)(2616005)(31696002)(8936002)(8676002)(4326008)(41300700001)(316002)(5660300002)(31686004)(66946007)(7416002)(6916009)(66556008)(66476007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGtoMmtOUHhBUmhwbFI3MC9mQ3R3bUhCZ2o5dXE2MmY1YVdoVUUrRVBWUVFM?=
 =?utf-8?B?V2tHRGc1bzY3amJvbktEdUZOSDV0bWJkSmFuVFFFSEFWUjY0KzFBYVY2Q1g0?=
 =?utf-8?B?MVVON0NjSjEzOHBxS0NUa1U5REVPZ2VEVDVSbENtWllLWEpvK0wrU29Ka3hj?=
 =?utf-8?B?TEo3d2FRSG0vNExSN0FKWHhjemFCT3hYcXMwTTNZY0JiMHc1bzVjbnU2TUhY?=
 =?utf-8?B?RFowa0RsblJpMUJtQTFGcHQrVGhheEFXVHlTRWZMSmNWajRiZXdXZmNMSnBr?=
 =?utf-8?B?MVoxMXJVNHBxWUJLOGhPWHJ5MEJDQ05idzZ0aE5YUUhPMzIxK2Z3aUo5Y1lB?=
 =?utf-8?B?WlJOOWVaNCtFY1R2SlJUWDliTmdBeXN2a3pDamFYZkpKN2QzZk9qMmRCVDdS?=
 =?utf-8?B?WVYwMTZPT1F2elNqTzZDQUcrRDBEb2JXQW1BRjFVN3ZjeFl3ajByanl0SzY5?=
 =?utf-8?B?WWhpaWh5bEdnaUw4YnZHTVVUaWR5TVFKeGdsOHZ1T3NwYjZORGNYSkpnZmF3?=
 =?utf-8?B?NDhQUmZBRFVldGxmZGtSSCtpY2pobVBMNXhycVpSUUE5QUhzQkM5YmNWLzQ0?=
 =?utf-8?B?cDduSTlybDBuNFdFWUNVdyt5aFFuVXRWNVdZWEJnVWNYbkVNNCtoUTJ2TW5t?=
 =?utf-8?B?cXZzT1RhcGxXN0w2U0pwckcxWW14dWpIQldMSTE5NU5IMjVYWmZWcHZ4YmJ5?=
 =?utf-8?B?MXBHNDZxWjVZT1prREdHbjZIeHhaQnBidDR2YkJwVWFLcTR5L093c2YzQ2xZ?=
 =?utf-8?B?VTMzcGpYR1M4SmxjK2tmeVFQU2NZME1qeTEvMEs3UWdFNy8rRkhJNFgzQW1I?=
 =?utf-8?B?TThNRFNWOVovV0xDdjRKb1NmK2wrRHNORFZ2bW5hdzV4cFAzNDRQbjRVTFNr?=
 =?utf-8?B?UEFJZ29ZbWoySzVZaXVOUUtvdCtLZThzSlpVZHhFU2V3enpwZHU5bWxZd0Iv?=
 =?utf-8?B?YVh1UmNZQlNuc3dqTEFQZDJleEpEQ1ZwRTJkU0tEV2gzbysyRzdiaTFPTFpE?=
 =?utf-8?B?Vkp5U1dkT2lxNkxKK095TjhOUEptbHdvUnBEWGxnNkt5Q0IrcjdSbll0UzFH?=
 =?utf-8?B?bUJvekpQZGNxVkc4OGxrckkyekJPT3FZaXMyVmhhMGlZMm9LbDVyRDFwaHJY?=
 =?utf-8?B?R0NHZy9wVzBOZ2VuanBEK2VJMkhUeU5OeFJiUE5uZWYzQXpQd3FQdVdINFpi?=
 =?utf-8?B?R054R2JxdE5ZSEQyb0M4L0pzZjZiMVd5SDlGNGdpVDA5Sk9kTmxIUUxodlNx?=
 =?utf-8?B?ZjVjVTIvSmwySUlHY0xrQmtWYlpqLzhwUlBrYVE3OXRranUwM2Zoc0FUQjdM?=
 =?utf-8?B?VFNKMUJsL1ZYRzNGZlpTZnY3NUdsOHEwZ2l1NTZ4c3dXVUZETHFWdDVPcWk5?=
 =?utf-8?B?VHBaQjJ3VmJyVGtmMDRXbXRPRzd6dHFhUU1iSjd3aGFuR1dEZms5M3NXT3dO?=
 =?utf-8?B?dElNTTVGd25WVElJLzRmaDZqeEpmdVJlRGtDOENoaTZ5NmZHdExrNkl3WkJr?=
 =?utf-8?B?SE9CTURGWTBTa0FsWTRKMnJzM1hWdVJxN2drd1l6enl0Rmw4K2c5Z2ZnbjJo?=
 =?utf-8?B?SExXaks4NGVKZ29IdmMwNHVrUDRPOWNzSnNYbXYvZXM4QVhmcVNOVWQyYkc2?=
 =?utf-8?B?ZjV5NVlIelpRQUJ5OEp4d2daQnZLRDFxMm53TXI3bEhjcHM3ZCsyNUJBS1py?=
 =?utf-8?B?aGlCR0c2bDNUZVVVcW5sVlB5YnlpN3NSTDdVelRUWnFmY2V1S3lxN0dBeEZ4?=
 =?utf-8?B?anNvc3dCK3BUZDRNZGlQdVU5NlloMWZORFE3YUxlUlFhckZPQWZWNVdFQ3Av?=
 =?utf-8?B?THE4R0lnVEEvQzVqRExiVHZUL1k5R243Ti9HWkNiWXIwdmxDZVFreVE3YVlG?=
 =?utf-8?B?NXd4ZXJBbENjbTFIb3R5ZjYvYW9CWlBkL0lHbkV4VFhIbEk5RWJwVFhmOGJ2?=
 =?utf-8?B?aWozUFJscjRuc0Vyb1RNK24wVmttQUtRU2hJTU5CR2lDVXY3K1V5YjdBQ2Yv?=
 =?utf-8?B?amtwUTFmZi9WS01TUjdUclBRdmpKbHlpSFlCRzBjTHArTS9UOU81ejh5cFJq?=
 =?utf-8?B?OGQvUFo2R0ZMS0Z1T2g3TE5Wb25qSmRBcGx0OHJoUC9RQmZpdU5FMk1RanJ2?=
 =?utf-8?B?WXZ2bG03dUlsV3RGZ2YvbnQ4NXZHdjZWTG5WejVjb0RrMUlLNFBxQzBNWFBo?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f58f3a-d0a3-4ba2-7045-08dbbdf4a5df
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 18:24:25.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8hAjmebKyiLnJf5V8cEE6C6SdVS0zlDhasMnjxssbk/6x1upSj8dgL8T8YcryN55dD3nvoLj3uM5dpluU5zIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7007
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



On 9/25/2023 8:43 AM, Ilpo Järvinen wrote:
> On Fri, 22 Sep 2023, Jithu Joseph wrote:
> 
>> Perform additional validation prior to loading IFS image.
>>
>> Error out if the size of the file being loaded doesn't match the size
>> specified in the header.
>>
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>> ---
>>  drivers/platform/x86/intel/ifs/load.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
>> index 6b827247945b..b09106034fac 100644
>> --- a/drivers/platform/x86/intel/ifs/load.c
>> +++ b/drivers/platform/x86/intel/ifs/load.c
>> @@ -375,6 +375,7 @@ int ifs_load_firmware(struct device *dev)
>>  {
>>  	const struct ifs_test_caps *test = ifs_get_test_caps(dev);
>>  	struct ifs_data *ifsd = ifs_get_data(dev);
>> +	unsigned int expected_size;
>>  	const struct firmware *fw;
>>  	char scan_path[64];
>>  	int ret = -EINVAL;
>> @@ -389,6 +390,13 @@ int ifs_load_firmware(struct device *dev)
>>  		goto done;
>>  	}
>>  
>> +	expected_size = ((struct microcode_header_intel *)fw->data)->totalsize;
>> +	if (fw->size != expected_size) {
>> +		dev_err(dev, "File size mismatch (expected %d, actual %ld). Corrupted IFS image.\n",
>> +			expected_size, fw->size);
>> +		return -EBADFD;
> 
> I don't think this error code is best suited for what occurred. I guess 
> returning just -EINVAL would be fine.

Will change

Jithu
