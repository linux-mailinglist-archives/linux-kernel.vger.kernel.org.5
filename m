Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92450764172
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGZVwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGZVwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:52:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C18FA;
        Wed, 26 Jul 2023 14:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690408328; x=1721944328;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kw6KFSJmiZeaHsVnaP89Q8YIotoWmDJYjU55ND3ADHw=;
  b=mc2chOVlcDevfnjdE7A0a1H0MwT/DjEf8aBrgPZj0r8n4dHB9PunHQgL
   jENH/FWd2ar4RO8e6P1QjRuz65/IdhUbM07UQPnblYzXVYQKqOlaKW0oe
   +JBdxloH2ovaD/62k4pwmvL3+1/maK0EoFIw8q3fpmVSDQmKWnd6mVZjy
   7LzvRCI1V3E9G9iWiFFbJxOSnSuqFlmbOwkhWuRcf+P5P5Ib9SrrqYzZi
   /CYYLBLkV/TGu/Ex9FNl+3ic4A/Yy0BK2IVbJ8IjVBm8lb/oz7t8NhCi8
   RETZO8Za2oxw01AYjP8PYqKs+B5UfNLWmO0SqKO6/Vz34YxcBpPdmtcHC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="368159072"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="368159072"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 14:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="840421661"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="840421661"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2023 14:52:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 14:52:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 14:52:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 14:52:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 14:52:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDNduuzCQLQWX7cQfTN2ELHnQpFmhfsJWKwgv0v1y7PcF3nN7aqXXXU30/Rwk5Qa+WXkLmo26sUbWzB52dct4AwgRx6p6jqGhHlxjpmlE2VFycB+sXyjuPWy6p13UeJbuSIlmLjiKyX6VV7EUlDrKik0mtA/FwYM7khTBXrKxFbg9ZMNLFnNdbleVwCh14nDUukOnCx1qikSEfSSPrB2eRpnf3udQgfR1zGQGgRAood8YMQ0AF6Fp8KVCNHUB/5hWjZeQbc3Qcc75k4n3sIo+gmVj7xXOKE1I0ZBq2C69tBnCQ/if/eQiHPHlX8S8As/3ATQggjW4cepJPOSkiOINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwnq/ShTM67hV6oEgXdGBo5UbFbXYAnIxKBjJJh3Ano=;
 b=QqTE+KYXDMXrZOE6/aW2Bgpd4nVGqJI4Mx3v0jwVfA774pqBWFLcV3vvr2MrzSmg4/NWWOUvhXXdxW/+FtZ8wj6DQLotLHfekdRdwc8RsOXxqGFaNfj+pvRWFnqusukOu5NLoyuRRIJ09sQaWAQX2/jb76kr7wIJ8KbOAmQenEIpxhfW//tJkmmKqz/aLgNLLeLle/NULMBKazxv4Sog50XTIcq+Zmg2WYl2AoGkqQ1P8hFwasEjGtWYcI+0u25YcGhkb0o/BsFmb0fVK2G7EiiY8mwmanilUPGOlEtjF5zMOJQ0xUNE7zqlcSmDrjpXR/JN/R1L/mvWYaOaKX45cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB5886.namprd11.prod.outlook.com (2603:10b6:510:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 21:52:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 21:52:04 +0000
Message-ID: <130e505e-a0d3-548d-61bc-5b7e14cc6117@intel.com>
Date:   Wed, 26 Jul 2023 14:52:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4] x86/sgx: Resolves SECS reclaim vs. page fault for EAUG
 race
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <kai.huang@intel.com>,
        <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-sgx@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
CC:     <dave.hansen@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <stable@vger.kernel.org>,
        <sohil.mehta@intel.com>
References: <20230726205056.25592-1-haitao.huang@linux.intel.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230726205056.25592-1-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:303:b4::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: db6ba376-8311-4266-2f6f-08db8e228cea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/4b5gGtXHhVsIdbiUbGWUdTFIZQgHtL9YSV3H4K8bpxLLuZwfZiizITIV1kzewAMDuD0Re9rz07ZvQnDIBDAYZ0M/6OCRi+b8gmYNz8/7HpFWBFGzBrzovVxSScirRZwAQuTQW2QxjhRqFrlKni9siQgkCcLrTWtf3MyEjt339mse+2RY9ueT3x7JcMKqSC0v57rwDitL2qUiHsSX1y/sTzxMb6KDxjwlKEHyNcSgGiC1Ra7p7tsDQS6cpTkjCn3Ghxbfrs3SnVkod+XjfRJQGQlfmUu0gPM7sbMIovjtrqD14YzjGc6swmo91kJgebqKDQlO9W0mWVJEocxrOT36Vg85E31rwzkIoTJUjzUJzCvAkQEOnbr91g7c6vyWp+TqQzMuCMXK/uKOoA9Nj2kUOge7xSE2UskGjIvK0jBGC/15KkfvQvO4mX7XLtXDUZ3RZrnNW9o+w1ZWWIBF0p2b08dk6hjxUpxXff54tW+yBvnwuh4lOKYx2MbdBnGjgoK7ZYpu4p7ZcsCzLG2O+1ckbfIoLAb6ujQoKLFSvxlu5JXsbbIHnSjsJM2/yB9Ef3tTNzr++9ZxFqpJY3nM9FDbkJBNfSZckWKT3+au7SGBhoJh5ZWn7exBSSpHrBi9mEU4mPKdLEvB0UodUNW30nO/ZEkEuCpdBaYYO7LE3BeOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(66899021)(41300700001)(2906002)(316002)(44832011)(7416002)(8676002)(5660300002)(8936002)(31696002)(36756003)(86362001)(31686004)(45080400002)(6666004)(2616005)(110136005)(478600001)(82960400001)(921005)(53546011)(6506007)(186003)(26005)(6512007)(6486002)(38100700002)(66476007)(66946007)(66556008)(4326008)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0JKY0lBSVRMTWw4UEo0Szc4bnJ5aWNnUUc3aC9iY0VUdkNqMm9DbGlSa0Rs?=
 =?utf-8?B?OWNORG4xTGZOM1Y4aU9VU21rblJXWnVGc01tVDBGdDdDU0ZGQnhpbW9LTVli?=
 =?utf-8?B?ajFNb0w4YzgwM0IreVZvWlVJS0MybVNDR3N2eHZFQ29zZ3JyeG9kZFFyZ0Vy?=
 =?utf-8?B?SnBYOGlRYzlsS0h0Mk1LdmhxajRRS0YyT01pbGc0YmE4WGZKYkc2bjBPQmRs?=
 =?utf-8?B?RXVZejR0RTJsY1BjbGhKbHJ5KzY4eElkMXhZdDlWNi8xUHk4ZlhyQzdTNDBN?=
 =?utf-8?B?aTRQd0pOSU9JTU5nQWNiNm8zbXNaMk9SaU5xVkFZRUNmME9QTzc5RkVNZm9U?=
 =?utf-8?B?WUl4TmhMb3lhaVozU3VKa0doVW85eFYxemV6WjRuN3ZaZWlEbFRlcktEKzJh?=
 =?utf-8?B?SWk1WFZUVVA3VklRdzFiOURncEkvMmdvMVpnTTN2ZGloNXUyRUY5Z0JQN0dF?=
 =?utf-8?B?aXJuajdMWHRBWFA3NTNRNFRBdHNzUzhEajQyTlJCM1AyMWFOdXdTZDFmQmNH?=
 =?utf-8?B?ZDhWS21vK09TZHQxNW5jVTVoRFVGLzFCL05tM0twaHo4S0NxbHNKNjA2bXVS?=
 =?utf-8?B?QkNDMUdMZmNjYWN3Y2NrT0NjODZWdjVZZkZnQmpmMHhPb0wzcUh0VmJKUDRB?=
 =?utf-8?B?eTlhaUUwUERQY3BxYTl6WEdwazJxWThEOXBIMVBPZ0w3N2s1cTg4bHB4RDRY?=
 =?utf-8?B?T3R0VW1KMy81QWIvbmlhZlZMUkZpc0xKcUlma0cweVdVNmZVTVB4ZmUzOXV2?=
 =?utf-8?B?Rm9RcE5DOGZ1MVhMQS9pTUtrdWR4QW1hQTlPSEFjc0dja3JQUTZadGwxVlI3?=
 =?utf-8?B?Vm01eVZUMzA4MGZPNHF0UERoeEdTVnc3SzlyQWc3MldxNlZQVmZ4SGtmZnFk?=
 =?utf-8?B?TnFsSmErK3o5b3hmQzJ4SFhBTlZ1VG41d21mYUdkaFphYUp4ZzI5Rzd5eVU5?=
 =?utf-8?B?TEM0cXJMMTlWTnJsZVlQRFpsaEdSYk16dHNabWllbktYUmMzT0oydDR5Vnkx?=
 =?utf-8?B?dDBTNHAxZ1NoUTNIbXh3UnBJRmRhcEdHRmV3OEgvTVBRSnFJRWUwbGxZY3g3?=
 =?utf-8?B?YXpuSHVVVWIxOEhKVVRVeWRWVGpDU2ZRWjRyS0c0cTJNeGJLMy8zMDBGNmRK?=
 =?utf-8?B?M0oyTXY2NHNPcjZMV2dONnlSUXVDQllvYVJSUFR0QXR3VUdNWmY5bFF1eVlW?=
 =?utf-8?B?QUxIdHhFazRpdTd4cFFIS2kvU0k4SnIvTmJEMTY0eGZuaTdCUzh4YWxkMG9a?=
 =?utf-8?B?OVdpUjZSNHIxTDFOZjZwTnlHVEdsbzNwRlM3dkRwTk4vZFk5L0dQaHFPR05l?=
 =?utf-8?B?MlJoQ3FnSmNjWGJSRGhGREU2blFlTnptazI4ellnaDV1dlVZWmVscDMybEhG?=
 =?utf-8?B?ZVh6NE4zL0g4VGZaYUIvUE94Q1BHTFB2Z3VzNmVkcGdYbHlZTDlmbFdEejND?=
 =?utf-8?B?Uy9oL3BRcGw3SXI4MnJsZ0RjS3VPNmg5UWpIQUxzRWN6WmpseCthd2huSThO?=
 =?utf-8?B?Ty9BN1IrWjhhQUczdytDb2RrZnRLMThvdHhicnNvMFhXSTlxdXROZ1RaVmdk?=
 =?utf-8?B?VEx3TVhmd0hmNzIrZG5kM242S0MwSHBaanhOQ1VDQnZKOHBvT0trVEZ5RlZK?=
 =?utf-8?B?UFZSVk93dlpKMC91WjFhdjB3U1czVWVjNTBNY211SjhTMndtVXplN2dWcE84?=
 =?utf-8?B?TkxNUzhBYlJWR3R3a1RTeXlKRXBEbkkwWi9qQ1NuNkJEQi8zWTBnNFBnQUpw?=
 =?utf-8?B?cmdpcnVDdi9idlcrQkNRT3gya0szYWVqMlZqU0VSM0FaSkxrYU4za09tQ3VX?=
 =?utf-8?B?MTM0U1J0eGhrTHJuTi9ValZiSWpQcytzbXBNWnR0WG1obit4Q2FlZ1ZJQ0tz?=
 =?utf-8?B?UDdVQ3hFTWl3UHI1bXFjazFyYlB5dmQ1ZWRiR3lreHVzZk1JNFBkazh6SlFm?=
 =?utf-8?B?dE1JeGNiRk5pMWFiem5GOU0wd0xmL3VydUM5ZHhZLzFCUUZvRkkrZXFibE1Y?=
 =?utf-8?B?d0FFU1REQWFVN2tTNnprMTB0bTlaYWRabEpQb2lBODBtc1FQQjhvOGVnZUNJ?=
 =?utf-8?B?TzZPRnVWNGpIb2M5eVRQeXNnY2taUm43T0RBa1hjbXZxTjVrcDVCQ1dabDRz?=
 =?utf-8?B?NW90TlVVSmlYZExWRjV3RWFIeUNxdzNWaldOWTdKT1NzZkRCdm5sODF5aVlO?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db6ba376-8311-4266-2f6f-08db8e228cea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 21:52:04.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXsRyIA9IU39kmBNNrjrc0TnJtzGx4mitVxGBGPxVrIt0nmF4kZ7oDJMe/YxsNNxFebBfNNjE15Nms/kmI6fE1m7GTFfYO+F94itb4zD0MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5886
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haitao,

On 7/26/2023 1:50 PM, Haitao Huang wrote:
> Under heavy load, the SGX EPC reclaimer (ksgxd) may reclaim the SECS EPC
> page for an enclave and set encl->secs.epc_page to NULL. But the SECS
> EPC page is used for EAUG in the SGX page fault handler without checking
> for NULL and reloading.
> 
> Fix this by checking if SECS is loaded before EAUG and loading it if it
> was reclaimed.
> 
> The SECS page holds global enclave metadata. It can only be reclaimed
> when there are no other enclave pages remaining. At that point,
> virtually nothing can be done with the enclave until the SECS page is
> paged back in.
> 
> An enclave can not run nor generate page faults without a resident SECS
> page. But it is still possible for a #PF for a non-SECS page to race
> with paging out the SECS page: when the last resident non-SECS page A
> triggers a #PF in a non-resident page B, and then page A and the SECS
> both are paged out before the #PF on B is handled.
> 
> Hitting this bug requires that race triggered with a #PF for EAUG.
> Following is a trace when it happens.
> 

Thank you very much for finding this issue as well as providing
a fix.

> [ 1682.914263] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [ 1682.922966] #PF: supervisor read access in kernel mode
> [ 1682.929115] #PF: error_code(0x0000) - not-present page
> [ 1682.935264] PGD 0 P4D 0
> [ 1682.938383] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ 1682.943620] CPU: 43 PID: 2681 Comm: test_sgx Not tainted 6.3.0-rc4sgxcet #12
> [ 1682.951989] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [ 1682.965504] RIP: 0010:sgx_encl_eaug_page+0xc7/0x210
> [ 1682.971359] Code: 25 49 8b 96 98 04 00 00 48 8d 40 48 48 89 42 08 48 89 56 48 49 8d 96 98 04 00 00 48 89 56 50 49 89 86 98 04 00 00 49 8b 46 60 <8b> 10 48 c1 e2 05 488
> [ 1682.993330] RSP: 0000:ffffb2e64725bc00 EFLAGS: 00010246
> [ 1682.999585] RAX: 0000000000000000 RBX: ffff987e5abac428 RCX: 0000000000000000
> [ 1683.008059] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff987e61aee000
> [ 1683.016533] RBP: ffffb2e64725bcf0 R08: 0000000000000000 R09: ffffb2e64725bb58
> [ 1683.025008] R10: 0000000000000000 R11: 00007f3f5c418fff R12: ffff987e61aee020
> [ 1683.033479] R13: ffff987e505bc080 R14: ffff987e61aee000 R15: ffffb2e6420fcb20
> [ 1683.041949] FS:  00007f3f5cb48740(0000) GS:ffff989cfe8c0000(0000) knlGS:0000000000000000
> [ 1683.051540] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1683.058478] CR2: 0000000000000000 CR3: 0000000115896002 CR4: 0000000000770ee0
> [ 1683.067018] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1683.075539] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1683.084085] PKRU: 55555554
> [ 1683.087465] Call Trace:
> [ 1683.090547]  <TASK>
> [ 1683.093220]  ? __kmem_cache_alloc_node+0x16a/0x440
> [ 1683.099034]  ? xa_load+0x6e/0xa0
> [ 1683.103038]  sgx_vma_fault+0x119/0x230
> [ 1683.107630]  __do_fault+0x36/0x140
> [ 1683.111828]  do_fault+0x12f/0x400
> [ 1683.115928]  __handle_mm_fault+0x728/0x1110
> [ 1683.121050]  handle_mm_fault+0x105/0x310
> [ 1683.125850]  do_user_addr_fault+0x1ee/0x750
> [ 1683.130957]  ? __this_cpu_preempt_check+0x13/0x20
> [ 1683.136667]  exc_page_fault+0x76/0x180
> [ 1683.141265]  asm_exc_page_fault+0x27/0x30
> [ 1683.146160] RIP: 0033:0x7ffc6496beea
> [ 1683.150563] Code: 43 48 8b 4d 10 48 c7 c3 28 00 00 00 48 83 3c 19 00 75 31 48 83 c3 08 48 81 fb 00 01 00 00 75 ec 48 8b 19 48 8d 0d 00 00 00 00 <0f> 01 d7 48 8b 5d 101
> [ 1683.172773] RSP: 002b:00007ffc64935b68 EFLAGS: 00000202
> [ 1683.179138] RAX: 0000000000000003 RBX: 00007f3800000000 RCX: 00007ffc6496beea
> [ 1683.187675] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [ 1683.196200] RBP: 00007ffc64935b70 R08: 0000000000000000 R09: 0000000000000000
> [ 1683.204724] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [ 1683.213310] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 1683.221850]  </TASK>
> [ 1683.224636] Modules linked in: isofs intel_rapl_msr intel_rapl_common binfmt_misc kvm_intel nls_iso8859_1 kvm ppdev irqbypass input_leds parport_pc joydev parport rapi
> [ 1683.291173] CR2: 0000000000000000
> [ 1683.295271] ---[ end trace 0000000000000000 ]---

Could you please trim this trace? There is more detail in
Documentation/process/submitting-patches.rst (search for
"Backtraces in commit messages"), but the ideal trace should
have just the information needed to describe the issue (no
timestamps, register dumps, etc.).

With that addressed, feel free to add:

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
