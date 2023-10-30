Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05C7DC302
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjJ3XPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjJ3XPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:15:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B785ED;
        Mon, 30 Oct 2023 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698707702; x=1730243702;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IDV1z8i/YpiqHdIJypgatpTymRYzO3qNIKWwwxhU0xQ=;
  b=LHqAY31Kq9oqXjAGVee1TaUlUf4PqApRxCxTAs3xN0omZyOYPiSGbSMw
   awzXAvk6UZpTdQxvnJpqSMXzoymETenhD53RUULr/uLwNUUAe7Sl+M/pu
   vxmsSJI6Lnw9MLQgiUxcUBc1rWfrMyAExYPq4jC3icyXxnABSPremer8A
   ATsBYpbTa8Bv1rnuxp4W4LQkwlbdn9oOA6NN/kfrWs61i7pwd6IZti4ez
   rrfmytG7b0yO1tDhX0NVQndtyvy5HAej/EeLEWiycRnyG4oEobUciLGrb
   dOO/DeepoqiiPThtzxLpod+inkGRR1Sx9HlGP33CoQ23e47HYg8A7IkXg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="387998189"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="387998189"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 16:15:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="736891872"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="736891872"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 16:15:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 16:15:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 16:15:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 16:15:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 16:14:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edDI+uCwqKC/sLOtHiIdDOJzh+E3lWDVXTCDQ5c5KDHBKeYxkgov4vfLp/jPLn+PaW8bOgqdXJ3dlJEMUo/UQg0jY95iShwe/fQpE19zpukfQjEyUD0QyLNE3Rg2soSMmuVpDtgA4fXsNR4anl9piYQ/WULb697tiK6AkoEGc4YDdImKZfUoC67zXf4YRkIIZZMcPTnZxn/7UL+KhWsV+wak8STGzzCahv2POodsgY5CyRXNViQPVRVUO2gOJGefbDZHKcTuWoiSVQk+s/7BfXhCdY0BQ9LLW5hAdU34Kvh7z6ZJXT2SdWMIEJx6Lk5nX9JANDJCC2EEYDr3FsgqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QuVXuEZw8s4HCd+7fbgXZgH3AyWtuEtV19N37Qn+ak=;
 b=SW4jdG2PQiysCxuoccBmrZ9cJ9CwAR7V4n29eeoSqrPGnJOZEXDJIoZSaQOiNqebxuoP+61AOSXCB9IIgD8O+PxvksQFi3ngwkmIWK42AQhmL0Q8zjFVU9/qt0n13JZVPfp9fuRmlyWyWHP/MAHbejs4A27V32k2fEOtc8p2ZPY3cuX6lhgGJWRiIOfOPNksLPqF8uMlg01KvxLJkXxRwB2opRiFF/2Mgq2h4hb6qJ4JDm/dUyZWlXYD35PhdoUbQI3zpzLDFOVTtHBG6P2Wu7S1DKP5kbPI6VuIusuuFkZnfEJ1n9e/X7jVHVtQl+IPAUbm6XUZJK/LmtXj/bYV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6955.namprd11.prod.outlook.com (2603:10b6:510:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 23:14:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5e89:2476:6382:34b1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5e89:2476:6382:34b1%4]) with mapi id 15.20.6933.029; Mon, 30 Oct 2023
 23:14:56 +0000
Message-ID: <e1c666d8-c7f0-440e-b362-3dbb7a67b242@intel.com>
Date:   Mon, 30 Oct 2023 16:14:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] r8169: Coalesce r8169_mac_ocp_write/modify calls
 to reduce spinlock stalls
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>, <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
 <e7a6b0c1-9fc6-480c-a135-7e142514d0e7@intel.com>
 <a85e41ab-7cfa-413a-a446-f1b65c09c9ab@gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <a85e41ab-7cfa-413a-a446-f1b65c09c9ab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0361.namprd04.prod.outlook.com
 (2603:10b6:303:81::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ba470f-a5be-4182-3764-08dbd99e07e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4aUt457Z5znwR6G9D6ToqL4O7sHH9yCTUYyvgZMHHbmhTemGCVNVHo8enA/7NyFwNsUk61k5fxzPbBHX6T0zsBqsdcTrXk8hhQzQ0hX1lh7UEBqi4OiHblheVnG+bK585MXNMZ7z2O25gCkEI0/4UZzkC2WGTjryzOs8PCRtU7YJfTecacCeuli6M8C4atWHMtGSu+z048ol0YDmpPLM57g7zHujdmxgRrga9MHfnNv5GjEckOYpOPjSOJwzWtBOcK5KfhgqKOjlukFaRuVn95TUeiUepYBflSrFvLIdNtCKZXBJn9Te/W+3FLSU3umyjf07/yP+jo4pt7HSgEcNUCkmEMjtcMd78ZZiHQKF9ru90vQ9JW25eDkJfmGYMKLM642mnO66xm47G4jzxQRahaHeqWvl10OFVXflKlcFnwb3o9pWDZ42cmhzfkXQNuQAGbDAGKVnVUVa25a8xqAs+D3cnumMWFkBqDbR5nghh1jPYgk26AKNm6BxTNvor4oku8nm+LOuMqT7a4R3fNwFT7/LAfuVlRTlRZsGPl3vd9moUQMiowBpbEdS8kFHm59B0YZmoHRV7LScVpNu73APzwlY21y61hJg1jrHl1wtB1dZ2FfZbQ1hHB8QUkJsnowoyZbczkNGCBE9mRaNUcv4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6512007)(26005)(53546011)(6506007)(478600001)(6666004)(41300700001)(83380400001)(7416002)(2906002)(5660300002)(110136005)(66556008)(66946007)(6486002)(8936002)(66476007)(966005)(8676002)(2616005)(316002)(54906003)(4326008)(38100700002)(82960400001)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djYwV3JqUnN1dUQzYWpHcHd2OTNsS0k1UW9ub1RvT3FxdG5zelN1WG9rb2E3?=
 =?utf-8?B?R3IyN3dFQ2hobXFFam5pam5vL1RQMnJaT0loZVpXT05sY21NbjdieVBESDR5?=
 =?utf-8?B?Qk9pNzIvanhaeFZXNFpPcUlmYjJUbnVxVk1RbUNGT2oxOUdlR3J6ZXk1MXZJ?=
 =?utf-8?B?eThjSkhaeURwR1JnNjI2N2RSMWdrRHU2ckVrNzJlcWdHMjhMc250N3N6RE9L?=
 =?utf-8?B?ODJmSVF0bEdKQklnK1RGSGI5eUJiemlhN05uQVNscHZFS3haSW0xaG1aSlND?=
 =?utf-8?B?bnBDUzdCcGgwSE42NU1TUFFlejhDQkNmQUFwM1BvaGkxMXh0dnlTT01GdG1T?=
 =?utf-8?B?b3FwQVpNZ3RtUDlXczRHalJHRnhoWkJOdlJib0FPcSt0aVZlbnZ3NGhHV2Nv?=
 =?utf-8?B?RFlheWdIY0JHNmgwL1BaeWplZFJvbS9rZ3pQWHhZMnU0Rlc2QnFkVkswa1Z4?=
 =?utf-8?B?YmgwQnBYYklRMEtvYUZMQ0JTMmlsTFhZODBUbkZZazhwMzRCS0JNdmx5aDBp?=
 =?utf-8?B?RGczS211TEZKOG9sNmIxanduRG5XT3NWZ1I0aWdPTStLM0p4bFoxZUJIRHN3?=
 =?utf-8?B?RkVVNmJESXZ0TmtsdjFrVlg4NXNwcHkzYXp6c2o4bmp0MG52VUcrRmV3Ymdi?=
 =?utf-8?B?L2xQV0VQUVkwdG5jZUpaYnU0a2pOL1FqZERZT1NwZjVGZE1hZ3JxWkZDcGFq?=
 =?utf-8?B?VWsrOUVIaEE4WXp5Wk13VS91cHQ3N0dyU1J0WjRxY1E4K0NjK1J0ZGNsZkhG?=
 =?utf-8?B?blFwQ3hnYVd2eW5WMWQzL1d2blpqaXdiV3RHREpGaUJ4TDhYK3ZGdUlLUFly?=
 =?utf-8?B?eFR3L1NDVlpab0c0K3BpbzJuZi9CdkpyVnFydnBRWms0VE50bWJ1eWlQckVN?=
 =?utf-8?B?VGNqMlpseUMwUldpQkFIWWo1cWNubmg3QW02K0ZPNVR1MlFQRWJmN1R1TkU3?=
 =?utf-8?B?a01SR2NMa3JyTGFvRGIwUEdqVWdEb2NNQXZ0REU2VGJnZU9sakcvS1JTT0pH?=
 =?utf-8?B?MERtTU9ibzNRWjVnUjJ5SnIyWFc0NFI2R21RUHlZbmE1Y0ZtWXY3a0htblJL?=
 =?utf-8?B?Yy9sM3JsdmJqQjhWZE85Ky9WT0dmNnZRZjdJT0taQ2N0SzhOMmFzbkR2QUtC?=
 =?utf-8?B?bHN4Yks3eXZ4S3g0TEJsTVhuckZjcEJtREltdXE3MXdXL0wzRk1LQWtyRURa?=
 =?utf-8?B?bE9rOTh6OCtQRjJxZ3NyWCtpZzl2ZUNTNHU1dGVWOStuQ1htMkt2MVhqZ3Jw?=
 =?utf-8?B?VjhmT1A5WUVSRFZlUFQ0NXpuYzV5YXdKblkvSHVqeGRWOGxqMnpDQ1llRzc3?=
 =?utf-8?B?dGxIN3JkUEJRMi80V0pQck5mdU5pYnpTMVVhekNNaUNXdlF0RkJtckw1cHIw?=
 =?utf-8?B?Ui9zV2JtWVVLa1p5V0VYWHd6MDFibWVsVVN2RG85TnplckNhZUJsTFN0c3A3?=
 =?utf-8?B?azY3eEFLTEJTaDRNbVppQko2aWJ3NnF6NDUwUkJKa0ZMbmxweXgwMjlWckc4?=
 =?utf-8?B?RjJmYWhUdFJnUk9hQ3hxcWZzejdzVVVSbmJZQWI4NHhmYWNyc3hCdnZML2M5?=
 =?utf-8?B?NDZRNzBYUS9oOTlINXkrN0o5SUdiSDFGVVByd0JrOFd6cExqczB5VUZsMVMz?=
 =?utf-8?B?dHU1SEJQdkF3dSt3Zkd1ZVRZTXZOL1pRQzRRQlQvV1dLbGJtcVgzQm5icStl?=
 =?utf-8?B?M2NMUWhiOFk3NGd3MDFHNnpyd21oWmk3a1ZQKzE2Y3hmSEJvamVRdktzR3pV?=
 =?utf-8?B?OWFYM0k2bnF5MTVST0w3by9meXpSNCsway96VWYxb2syV1lMTmlNazBaVUdE?=
 =?utf-8?B?UFVvRUFNTGoxNURDR2NscS9iUVdwOVJ2ZzcyN21BT0hjNU1XaE1BcXZUVi9J?=
 =?utf-8?B?UWRkY25aY2cvdm9UUDJrakR5ZFJNZFcwRHozTUt2UmFlcVJnRE55MkJBSjds?=
 =?utf-8?B?WGZFVXlOVTZKN3QzMEhOa2VQRlQ1akpMWVNpc05jbzlNTGx5ZWNnNmVjTkEv?=
 =?utf-8?B?UGtXUExlZFlLVXYxTkxIcWE0RFhVcktUcVFNdFFYTUVXT0thTTB4MTdLKzlp?=
 =?utf-8?B?R2x0c25iZE5iZ2VHTmcrem1jdzlxNGp3VC90WllCZGtMNHhYN1NES2s1akRa?=
 =?utf-8?B?MndaZmRjcTdWNlVSMm1lZ3NzcWwrTnRKR01CQmZGN0dYK2pwUFF6enQybkIw?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ba470f-a5be-4182-3764-08dbd99e07e4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 23:14:56.7856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZiHArpw7lDeZufIEJAEb5K5DSJmsy9WuEYUs27MMysKoxtg9ALQE6XYjDCDNSz7kxcruzQoh8X81QxCdB06ceUxNNZNo7jMyvwqjukqawI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6955
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/2023 3:08 PM, Heiner Kallweit wrote:
> On 30.10.2023 22:50, Jacob Keller wrote:
>>
>>
>> On 10/29/2023 4:04 AM, Mirsad Goran Todorovac wrote:> A pair of new
>> helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq()
>>> are introduced.
>>>
>>> The motivation for these helpers was the locking overhead of 130 consecutive
>>> r8168_mac_ocp_write() calls in the RTL8411b reset after the NIC gets confused
>>> if the PHY is powered-down.
>>>
>>> To quote Heiner:
>>>
>>>     On RTL8411b the RX unit gets confused if the PHY is powered-down.
>>>     This was reported in [0] and confirmed by Realtek. Realtek provided
>>>     a sequence to fix the RX unit after PHY wakeup.
>>>
>>> A series of about 130 r8168_mac_ocp_write() calls is performed to program the
>>> RTL registers for recovery, each doing an expensive spin_lock_irqsave() and
>>> spin_unlock_irqrestore().
>>>
>>> Each mac ocp write is made of:
>>>
>>>     static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>>>                       u32 data)
>>>     {
>>>         if (rtl_ocp_reg_failure(reg))
>>>             return;
>>>
>>>         RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
>>>     }
>>>
>>>     static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>>>                     u32 data)
>>>     {
>>>         unsigned long flags;
>>>
>>>         raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>>>         __r8168_mac_ocp_write(tp, reg, data);
>>>         raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>>     }
>>>
>>> Register programming is done through RTL_W32() macro which expands into
>>>
>>>     #define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))
>>>
>>> which is further (on Alpha):
>>>
>>>     extern inline void writel(u32 b, volatile void __iomem *addr)
>>>     {
>>>         mb();
>>>         __raw_writel(b, addr);
>>>     }
>>>
>>> or on i386/x86_64:
>>>
>>>     #define build_mmio_write(name, size, type, reg, barrier) \
>>>     static inline void name(type val, volatile void __iomem *addr) \
>>>     { asm volatile("mov" size " %0,%1": :reg (val), \
>>>     "m" (*(volatile type __force *)addr) barrier); }
>>>
>>>     build_mmio_write(writel, "l", unsigned int, "r", :"memory")
>>>
>>> This obviously involves iat least a compiler barrier.
>>>
>>> mb() expands into something like this i.e. on x86_64:
>>>
>>>     #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
>>>
>>> This means a whole lot of memory bus stalls: for spin_lock_irqsave(),
>>> memory barrier, writel(), and spin_unlock_irqrestore().
>>>
>>> With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
>>> a lock storm that will stall all of the cores and CPUs on the same memory controller
>>> for certain time I/O takes to finish.
>>>
>>> In a sequential case of RTL register programming, the writes to RTL registers
>>> can be coalesced under a same raw spinlock. This can dramatically decrease the
>>> number of bus stalls in a multicore or multi-CPU system.
>>>
>>> Macro helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq() are
>>> provided to reduce lock contention:
>>>
>>>     static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>>     {
>>>
>>>         ...
>>>
>>>         /* The following Realtek-provided magic fixes an issue with the RX unit
>>>          * getting confused after the PHY having been powered-down.
>>>          */
>>>
>>>         static const struct recover_8411b_info init_zero_seq[] = {
>>>             { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 },
>>>             ...
>>>         };
>>>
>>>         ...
>>>
>>>         r8168_mac_ocp_write_seq(tp, init_zero_seq);
>>>
>>>         ...
>>>
>>>     }
>>>
>>> The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
>>> functions that only changed the function names and the ending of the line, so the actual
>>> hex data is unchanged.
>>>
>>> To repeat, the reason for the introduction of the original commit
>>> was to enable recovery of the RX unit on the RTL8411b which was confused by the
>>> powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
>>> into a series of about 500+ memory bus locks, most waiting for the main memory read,
>>> modify and write under a LOCK. The memory barrier in RTL_W32 should suffice for
>>> the programming sequence to reach RTL NIC registers.
>>>
>>> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075
>>>
>>
>>
>> I might have chosen to send some of this information as the cover letter
>> for the series instead of just as part of the commit message for [1/5],
>> but either way:
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Cover letter is still missing, and there's a v5 already.
> Good example why we have the "max one version per day" rule.
> 
> There's still some issues with the series, see my review comments
> for v5. As-is I'd NAK the series.
> 

Heh, ya. A v5 was sent without there being a single (public) comment on
the list prior to my reviewing. I didn't notice the v5, and my mail
scripts pointed out this series didn't have anyone who'd looked at it
yet.. I guess I could have searched for and noticed a newer version.

Thanks,
Jake
