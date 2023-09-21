Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E467AA0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjIUUuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjIUUtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:49:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40B190F1B;
        Thu, 21 Sep 2023 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318446; x=1726854446;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7y8W/ezEPnzjg6KEPTxEtNCd9uUM5nh0AKEIq5X93XU=;
  b=VRb/pZwW1oL6NAnlAr7WLpKU0Vh+cMj2HBWvl2WKOGRyw94TEh2EYGyR
   nGMF4ZGFh/5RJw88nvtE518Uoow0jfGwnRpuzocQBDN/l9cYWXc9pACIh
   xPoWDFcfrDsJJ/er85f7f/zy2C50Hog5GPAqMPEpOGfqvHEQnGA10CNqM
   /ai0ebW+CZm4AsFEqHAMS1FMySxhIu46ScsNR5RgzYeMXIeT2KvzOzKSu
   +KkTxVaIH3rBhGZs8PTPYYGVh44+MznE9as+37P3NotFYJORTIA+HnLqO
   ddPukpOildNIhNBcnUVP4Rl8VEDRwmT4A/Q8iSu/BI/3VUf6waRa+/EPF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="377805444"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="377805444"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 06:05:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="920720413"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="920720413"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 06:05:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 06:05:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 06:05:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 06:05:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 06:05:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkQECvbp/DFOxUOdT37wrdm0T5Qc8AXDvPHDmNzvnpO1LdlKNN1k4YZWZNmROBQGQBZxWEqdSqAADTougZnESTU/p3rwzKh8a+VNqcAMijJIYsiDfknCKD8VICjKlDGziEvxl0ur1ZvmVYMWPJSiy+YAOa7pD5NxDNIvi+OSAFEcAWsKtGubQWuPskYplmNXV7HMwVMg4/vQ0AfNhMgRH0pY7tQ7OnXM9IeRVBoBUMvhrzKbGZXHaZPbaczaqxjT7xelOPcRksfnIvxXo6wEg7E0ofGW9RftrVWIRuf4hza2G2/SQzAQaxdghQ+kA+ntfuKSYTA4KtGmJl1NOkjBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg8HRrSB5KEcaqVmwVrFKnenivR/OZIKq5lGTiwzBXY=;
 b=HLuzCmvKKyGLzLN8komMHNhLGgYJcTaEwE0UgdL3JtTzMntwGdAESA+jKuXwtF3Bp6nNb6I0cASsd03dCP8DssGkXZYuCZHHdNEd6o73PbZyRBcGqxPgoDOTSKQ6fAdPiXMg+QY6vl7ReLr8UaEhRp9rZPGkY+ZUTS7kQKauhKyoAdZr+C7Li6oXUclqt7XRXCrnx9CIbflpMI4m8qdFmhM8/rqbRzJOW7yp5vVkX+C9nxT0Als1+koJu9TiER2+VIXqOuvSDizSjQoyDTpZmZTpT0+YLuckDdcQSjJHu/U0QixIA7mGVEGtZ4EZgZt6yjrVAk6me/Ty/JFso01ydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH3PR11MB8361.namprd11.prod.outlook.com (2603:10b6:610:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 13:05:29 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 21 Sep 2023
 13:05:29 +0000
Message-ID: <ed6eafdf-d788-5eec-1feb-ef7d56184715@intel.com>
Date:   Thu, 21 Sep 2023 15:04:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] net/intel: fix link-time
 undefined reference errors
Content-Language: en-US
To:     Jacob Keller <jacob.e.keller@intel.com>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
 <f05c2a5b-d434-5edc-828f-4b87049d01fe@intel.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "Richard Cochran" <richardcochran@gmail.com>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Michal Michalik <michal.michalik@intel.com>,
        Milena Olech <milena.olech@intel.com>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <f05c2a5b-d434-5edc-828f-4b87049d01fe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::9) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH3PR11MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c355a32-96de-4323-c60c-08dbbaa36dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VnbZnb+G4YyaVGIUooRywhhCPuW77d4Xz4E5B2LOcKvRKVSaNMOtgmCw/m8hfu/25lmjx2PrXF4CUb2akLTXFzZI19RiScezFxp0SQfBqMPWHSgauEGAvRqJGG7EYCTvb7wnswVXjAKJ+59BYgB0oD77ZQ6hhB9SL8pkpLZL8SDD+AVjTbdQDy3nDgfH+X8u4NlIO4bRL7tzM+WmIRCZJzZcrs+gjsikrJ6+VZ6ACNIOWQfnuncy+/35xbl0+NuB9hqHN5/zPX5jBem65OJezTG7ftk8djgW56sO3DlhT83a5wC21HmlReTeAD9sNLgN8zYRl+D0ROLcTU/s4bVcY078CjJbycpNmmIzeJtOhSHs1AZAni4ymo/63D1nOy+OlIAamv464tiC37Cwnwu0oY3wktZdABQ15QynRcved/431tw7m1HELuVmj60QgFA8WuXw9mGRFznR0zKtt8S3MZx9QoTXl/mmyQRAcCqDJQUl6WZo4uIRVmLteMO9xJInT5WmtjYbTQ6V6wXMg5CwxcZffdCD7YVTA/fvE+PbluhovFn6LX9cUdqlqC1BGuJijUKuhiJjnzmW5EFrJTdPZrGE8YxCzjO77//roKKahQwEblLOlCL4WWMHjjRovyW68yjxSWHCCj6wxo2ZH8c+tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(39860400002)(396003)(1800799009)(186009)(451199024)(6506007)(6486002)(6666004)(53546011)(6512007)(478600001)(83380400001)(2616005)(26005)(2906002)(6862004)(8936002)(8676002)(37006003)(316002)(66476007)(6636002)(66946007)(66556008)(5660300002)(41300700001)(54906003)(4326008)(966005)(82960400001)(31696002)(36756003)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXpqOTV3enMwdWxNY05MeHFKQVVIbW5Ca3dDMVVsR1JNZGJIY0cySk85bHM3?=
 =?utf-8?B?T210VGtFdjVqenN4dlF2dDc0V2ppNWFHYzZVSE1ONEZkZ1JFQ1B1dlF2RXpQ?=
 =?utf-8?B?K0JZdFRaekx4ZmRqU2JHY2c2bHo0L3I4U29HWExVZkJWU0pWcVJpV0YyWXVG?=
 =?utf-8?B?T1Frak8rOXRBa2RhQ1dtejJsK20rTlk5Y0x5S0JCVEtaYkw1Wm1YTDZ3YURS?=
 =?utf-8?B?SzUxVVIrM3BObUlXNTg0aEY5dGVTQmhVNVVmQVBHMGxNYS9DYzlJa1FzUEZX?=
 =?utf-8?B?dnFzQkMyZmd6U3NyZHg2Z2pZS3lrUW9zVERoeVhualNyUEZESUNJYW8vZXRq?=
 =?utf-8?B?UTdjRjhmQVhQRnhsS0c2b0Q1WXlCMUtyUkU3VWVYRS9Ldnh4czZLcmFCSG9I?=
 =?utf-8?B?UEdmWkdRb1MwL0RhZ3dLTElpL0w4NmE5RE81T2FHM0QyZlZaSTFkMzZxVGxr?=
 =?utf-8?B?MmUxdGhnK3dyclUwcjJyOHNqcGIzVWQ4cnZMTlpwSlFjbUhlOGdPcnYyNFlw?=
 =?utf-8?B?V2lyNU1Ua2k2Tng5OWx1T3UwYkFLbFFxcndveWN6SXlTejdmbTc1ejlsNFRL?=
 =?utf-8?B?MitqcE05dWY5WGt3S3BsV1JvNFJUdVdDUldQUnBaVXZOc2IvdzVhQm9EaDgy?=
 =?utf-8?B?YXBXNFJ1ZlBWcnAyR1lnblZ4TlFoVTFkUVBHWEF1Wk5CUnhFL3JJU0g1ei9t?=
 =?utf-8?B?UEE3bXZuWGRVTHRNSG1iNm4yRGpEcTdZQWl3aEZ5aTBlaUtNaEkrcXVGSHAv?=
 =?utf-8?B?SU9mWWpvNTlDWk9udzlEZ0gxMUUrNHBSREZGV0ZZUTVYZktoOS94Mm80WnVL?=
 =?utf-8?B?MjFwNnAzdW9WaWpFN0tvbXpud1FOQUV1aUZoSk45VGdjN3VTcDBlazNuVjM1?=
 =?utf-8?B?a2tQU1ExTnl2ejJXSjk3TzF3YzlTNXNVMXpQQlIyenMxZWJ3NEJLL0Q4VmFh?=
 =?utf-8?B?MWVqcHdHRytoaDZjYVE2UVRlUDNxUWdCMGVHOURBa3YrK28yYnIwdnczNkkz?=
 =?utf-8?B?SXE5Z0xxaCtuUEt0elpKLytyaVUzVEhiV01MdEMxK01MRnpsT1lTOVFMTFVG?=
 =?utf-8?B?QlZlQVRYOTVvVUJJYUpOVEFXMWtpQ1hVaHJZa245T1JBaHVGS2g5MHczZkp5?=
 =?utf-8?B?T2tQUm5FNWpyU2Q1QlI0M3NLRXYrNGVuK0VHNlpMVUE2bFp3V0pTQUxFV3Zj?=
 =?utf-8?B?QmJSQlQ2WGpQNm95cCtxaDhKNGdSVUhBanIrdktJSC92Yy85OGpXYmxzeFYw?=
 =?utf-8?B?TUh5Y2ZaVWpHQmdqV2ZPQisyQlFDTUxkSGF1eW8wejlKZStTaG4xcExuTFpn?=
 =?utf-8?B?OWhpTTRaQ1ZGZ0Rpanhockp2T3FORDVrMXA5OUNsUGlkdzBQcGZ2ZlNpbHVx?=
 =?utf-8?B?bUJoNUtFQXFRSjFiVTFQZndBWk1kdklJZkdhckprNmEzT0pIaDBGbzh6elc0?=
 =?utf-8?B?N3hKQlRaelVVdXhBUWxBMlE3dGh2QkJxU3RpdFhBQnI5aTRGWkp3dUlPRTFn?=
 =?utf-8?B?YXFvZlovcmIvbUpDdlY3TXNKRzFSeHNla05XVFRjRkxsVzM3b1VIbWpoeXpo?=
 =?utf-8?B?TXhhb21YR3Q0V1B4NlFoVGhBNjcwSlNsdldjdGp5ZHc1MnM4RGhxbXU5MEt6?=
 =?utf-8?B?STBYZi9BQUM1MC9DZ0JRTDVJOTdqM1p0VUxCTFhzMm0vVHJ5aXdKMlkrSHR2?=
 =?utf-8?B?dlNVZUsvaXFvb2krN2RoMEVzb3p0NEk2eTJWVzg3K1U4VTFhaWtjTGtxY0hU?=
 =?utf-8?B?UFhleGUvZ0RMeFAwbVZMdForZE9OaTk4Z3ordGtFdC84dDhybWErUVhvOEZv?=
 =?utf-8?B?NGxuOEErZWRyZzFxVXFlRTFKalI4WER6Qk84V1gvVGt6N0pBUzI5NXljVk16?=
 =?utf-8?B?VktaK3piMWdBaS9TcStuMVFZSVNjZkR4UHBxWE9ZdlpqdjJ0Qm1oSkt4SGti?=
 =?utf-8?B?NXVhUEZBZmc0YjRVNmxVV3F2K0twakZTWjdKZWNnakIrTnJkOFFrTFpvbi9K?=
 =?utf-8?B?RGlxSFl5L1h5Q0sySmtNcWxzV3loNzZNWHZoMWhVMG9ualVGWW56YzVrVDBJ?=
 =?utf-8?B?ZlQvZWZLZVhEdDZ3RmtMTWtMaXdQQ3ZmWTYzTFNDd2NhVldpRldjQWVXWUly?=
 =?utf-8?B?ZUVyWHk5eHl6WHpYMUV4SUlodTJpV21pWDBUelhqZ0hZTHZURUNOVkovU3lp?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c355a32-96de-4323-c60c-08dbbaa36dea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 13:05:29.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+jYFNazd6Pg2SJChtvenEFIBf8V8LIAgP1LgFNqZmeqju3KrjVHeKhal00qR+D0sTeu1iG/ROMfiq+mRWWz2ZJcFnnOeRcJ5RfcbT4lZOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8361
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 20 Sep 2023 16:31:27 -0700

> 
> 
> On 9/20/2023 11:07 AM, Alexander Lobakin wrote:
>> Recently, several link-time issues were spotted in the ethernet/intel/
>> folder thanks to Kbuild bots and linux-next.
>> The fixes are pretty straightforward, just some stubs and CONFIG_*
>> guards, so resolve all of them in one shot and unbreak randconfig
>> builds.
>>
>> Alexander Lobakin (3):
>>   ice: fix undefined references to ice_is_*() when
>>     !CONFIG_PTP_1588_CLOCK
>>   ice: fix undefined references from DPLL code when
>>     !CONFIG_PTP_1588_CLOCK
>>   idpf: fix undefined reference to tcp_gro_complete() when !CONFIG_INET
>>
>>  drivers/net/ethernet/intel/ice/Makefile     |  5 ++---
>>  drivers/net/ethernet/intel/ice/ice_main.c   |  8 ++++---
>>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 25 ++++++++++++++++++++-
>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c |  3 +++
>>  4 files changed, 34 insertions(+), 7 deletions(-)
>>
>> ---
>> Directly to netdev/net-next, build bots are not happy and the next
>> linux-next is approaching :s
> 
> I had alternative fixes for ice at:
> 
> https://lore.kernel.org/intel-wired-lan/20230919233435.518620-1-jacob.e.keller@intel.com/
> 
> that are slightly more invasive but bring things in line with changes I
> had proposed earlier before the DPLL code got merged. See:
> 
> https://lore.kernel.org/intel-wired-lan/20230919233435.518620-1-jacob.e.keller@intel.com/
> 
> I'd obviously prefer my version of the ice changes, but I understand if
> we prefer a simple more 'obvious' fix be merged now. I can spin my
> changes again to cleanup/refactor in a follow up if necessary.

Go forth with yours. You can take some of my pieces if you like them
more if you want. I just spotted both idpf and ice reports at the same
time and was ignorant enough to not look at our MLs (internal and IWL)
first.
I'm respinning IDPF solely.

> 
> Thanks,
> Jake

Thanks,
Olek
