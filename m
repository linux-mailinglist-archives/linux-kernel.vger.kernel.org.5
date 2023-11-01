Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F9A7DE312
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344339AbjKAOdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjKAOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:33:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8753F83
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698849206; x=1730385206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hb1xQ9uNQ+k38zWG+ROseJRsi91jO69e7vKsJyRLslw=;
  b=KCm2MUaFf7UaDQme8CzjTExRTxhtvNvA/y8gjW2M+DKNzj9agTbLJxzp
   x5r6GQQD1U7qIfG99m89CXwLIxby9yOtaz0T2AYex2dwywquLxxIrvtgq
   BnwudjgKR9+/REvnyv0bBkGNqwr9+CrsDDCMTETAIMMpp/PivKcl6swmd
   ACuJcIUTSLZLLzNPN5VBsDdt/abOVbURRInjRL6ESFKLO/JiXT94lYB6p
   w3uxD34GknFHVTFIWbyXB1INCX7UjFogIImlIHVcAbgBDEkvN/2UBHKA8
   MHa5TWtQ4I+Y3jjMse8Og8D9u5Q7ac1b3gDDZFrhgFPASCDccFwS/XlXP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="385676517"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="385676517"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 07:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="8675376"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2023 07:33:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 07:33:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 07:33:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 07:33:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 1 Nov 2023 07:33:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9E5LepAOcm+OFp/aJJi7gaKnu27A7GqnK+xfhR5U6xKg5qfB/b2p7O9uDiw5TQ3aPKRmT9MExOicYK0YG9ec0ulWWVR5Jwi9GQ5vzNXsY4EwvK48P6045TNgljgSI2MGNvnzDW0UICVrO3+ANCTfSyu8IHmT5sRqvjiO16fj5x4SXobSm4qjcvg2ClLqqCM3bTd1uNgj3+/QxL3b7AnQEciHLnGsfjdrgO+g49atTs9NtiqqkqFGE9nISKvO+MQxjeIUlWPaH3f/+Kk0rCRUEQBGebik7g6XwEbB3YdVygp03byb06ycPYXajG0K4p9VrEMD8xQ0gX8AcVamcqRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb1xQ9uNQ+k38zWG+ROseJRsi91jO69e7vKsJyRLslw=;
 b=jlqFvLC91hmbrjd4Sn+/Fvn0OwDTyPI4mdF29aWamc0NVNSBLFx3loXn3LUC5YlySI3rHMHqAtJSvhaP0Vkcsrx6mAScHXtJ0eFhj+UIpU5RiSHHdFPvOm2eoVouM3l4mg4ZLCeNx1EclunlLFmyEk/X5UZudcEdVQaX1gjWLMQ/ltn5/hfp9luLR7EGRQNAKKn0rKmnk8TNHpic6NDrbbjErPpOPrHDCms32qalzhkF9Jvh44+/G9DOKXHZF+DGn09WcNdYjETgSn5Fju5IusKkhCgIKg4AJAn1NSrEE+Ssb3N2k3OlLFZe1exvYtC9f+rDMersGCarrWg/VBkM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ2PR11MB8565.namprd11.prod.outlook.com (2603:10b6:a03:56b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 14:33:21 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%5]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 14:33:21 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Thread-Topic: [PATCH] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Thread-Index: AQHaDEZs+0NIXdfp+UKs6XMbXW1JaLBlNxsAgABQICA=
Date:   Wed, 1 Nov 2023 14:33:20 +0000
Message-ID: <SJ1PR11MB60837E71B5BC7B20E172E334FCA7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231031220534.37730-1-tony.luck@intel.com>
 <ZUIdsK5LGmRww9ER@debian.me>
In-Reply-To: <ZUIdsK5LGmRww9ER@debian.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ2PR11MB8565:EE_
x-ms-office365-filtering-correlation-id: 122d32e5-0667-4eca-443d-08dbdae77f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +WIVH2/aqLUKsFZ1Fqy9qXy/FMwEQSdMCSsdnHgiqVEDdNYTuLF/9xz688KZstPiGgYv13Idef/3MYf3qIxxm3yZ8Gsv7thyg+1W6hGPBX5YcqEgc8YqgK9lE4Ei7ErSm2YSLOKwCfqR+NBrqinW71N/OQJK4ig28FRSG0tshqymBHM0JdH8qNV8Bm9S6FcVNy94K28c1X51Ll16bW5mP6FI8HhNkR2bSZAJSL+Jmmr0iOVZF/Zd6yixshGGdlruJYLtb1c9Lnk3qx0avPhL+QeEIhoeKYWhevZsb38Lib8S4VkMmSodBk8QsOCDwl6DttjBmgAPcZfWcXcKNf5L6jLAf3L/pm8sJam6zgV9+mUypQfulcySJmT+3mUDzqYt4gKs1QRhUa0/xVywuQff0LMShc0+5MJdgKNxju798MXKKmLMyHDfpPpqMzwk2HlfMK1veeWFmtBbZkrsuK3sGNn7Fek9bZi4pZKZi0pctAkhyZwh5EoXHspReZLik7PCY5XqKDLhCMB2ODv4YaHA7zXenIfOLgFb9PVrwt/n2Bjl2lnuuWI7LtL1rq8AdKcqMrUUgeee3Cxik8QZ4MMLnBK8nnCcJPad7nDOujmYE8t2efpcmHnwM3w8iwYQPO8Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(33656002)(38100700002)(5660300002)(7416002)(2906002)(4744005)(86362001)(38070700009)(41300700001)(122000001)(82960400001)(26005)(7696005)(71200400001)(76116006)(316002)(110136005)(66446008)(64756008)(66556008)(66946007)(66476007)(54906003)(6506007)(478600001)(55016003)(9686003)(52536014)(83380400001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFVPeEJ1ZWJZNnAzeDUrWFFTdklwRlVxQ1JOMU5JMkZVYjJPckdLbnczSm1l?=
 =?utf-8?B?bndkeU9yc1VaN2xMT1ZLaTY0OXhaWDhFbzNxZkF5dGk1aGVySTBHTFhpTlYr?=
 =?utf-8?B?Y3o0cldJVzVReWlHaDN3Q3BZSEdFYU0vRlRvUlQ2M2xpTzYrTFdPY0dtOTVs?=
 =?utf-8?B?eUZPZEVLc0F0cHlDeUZOK2NQZktib1lmanNQZXhTaUNGZ2hEVGJqd2hGSkdY?=
 =?utf-8?B?dnhqOEtyQm8ycjljc2lEUUdvQkhSRXJ3RkVrdlhPMkJkMDFwK0NLTjVjVy9D?=
 =?utf-8?B?RTQyMlNVWDNpVmlDZTRoR3pQdUpRZHM1bnZSb2h3UVhaSkFaWEg4dmZoQ2Z4?=
 =?utf-8?B?Y0Qram5WMnZ0cXRXVCtrL0VnQVViYVN4YVZnbGR0V1dIYUhyT21FYmhIa21B?=
 =?utf-8?B?eVdCTTZlSDdZcnNPZ1VrbGlRRmtVd2VhakJhOTliMk8zQ21sbU05NWFpK0Ev?=
 =?utf-8?B?MzJNWUx0QmNKRXQ3T2Z4SThMMXhPWEpPV0xQdkUwV25TMnM5c0NMeWhqWWVE?=
 =?utf-8?B?YWEzN0hPYkQrN25pcGZqQVBhUWRSOGxuaitja28xbm9FWUdTNWxnMDBHeGVi?=
 =?utf-8?B?RlBjcGwvbDZrcXVpWmxESUNZeEtqTFpONUlMdStHY2pPSVVtU0tsV1JzNjds?=
 =?utf-8?B?NDhJbzdMSThSZHRJelpPVmRrbkU2ejBCOGR0dkh3Q1BKZUlyZ0t2SVVsZmNz?=
 =?utf-8?B?d2hmYTFabTliL1JGeC9DZGtvWlVoQ01ZcGQrdnZPRDVjNUpGeTlvTmVGMVg2?=
 =?utf-8?B?ay9nSVBoL05KZjdCK0oyNGpYcWprUHI3WCs3V3NoaFZRRDU3alNDVUdGRmNI?=
 =?utf-8?B?c090TEE4TFloL21ZWDdXdEcyZFZJdWxpNGdKVnBpUWtid2hWL2w5WS9GbzRq?=
 =?utf-8?B?aHFubmRsLzZ5WGFIWDdrQ1o2bkh0TFBoNkxqYjZqQ1AxZ2M4NkxzbDNBbUth?=
 =?utf-8?B?V2FrRXVUbzJ6ZURFTXhzQnJabGJZQVRuVmpEaDZQV2N1dVJGdlhFb2huNEJW?=
 =?utf-8?B?YXd1TUxwZzQyZGRBT21TWEs2VWhUd0lEUjhkQldGZDU5VkZ0S01maHd0ZzRT?=
 =?utf-8?B?Y3VzcEM2M3RHdEpIS0UvbU5RengrWDNucFg1d2ZyM2hPOHpxRWVXLzk2WDgr?=
 =?utf-8?B?bVBYMGQvS0UwbEh4cUEya2g0ekI4aVBzZXpLTFZPMHRHclNORHJiT2VmUUlH?=
 =?utf-8?B?UnQxdTlIVWh0R1RxWGdaeUNVV0YzZ0w0aXZINlp2Z2JvLzBVNVh5Q0JhaUw0?=
 =?utf-8?B?M1ljcjM3MEFmMVE1K0p1NnM2d212c3BtUFdoZnRlZkhXWVViaGZNTnZaR1pn?=
 =?utf-8?B?RnowR3NCRkdVdTdsanFBYnczV2RmeFdiVzNwNDNBR2hVMjgxODdnWDV4Mm1U?=
 =?utf-8?B?US95WWpMZTlsRXp3bithaHlhdTJrUnlpSjd4TkF1Wm1yV1BVSVEwTGlpaThS?=
 =?utf-8?B?MkI1ZHl5TDhSQy9xTkZoeWFPZ05aSFh6RWFvWU5PVzN4RkdHS2ltcnBON3JM?=
 =?utf-8?B?MHFxZk9aTEpQcjZodFlNQVdoYVMvcWFiZkxBVEZkaysyMWcxK0F4YWlpQWc2?=
 =?utf-8?B?aWtsM0lqS25VdXlvWlN0Yit6QnVRQXNmbjhvdlpiRFhHNlpGbEkzVE5mTG1O?=
 =?utf-8?B?dFF1ZDVWdlhwYXVoK3dmL1dwM3BoQTl1TDhvU1I2TUovL3lEMk1HZDhrVVN3?=
 =?utf-8?B?dnN5TmhlenhpeWtSNUhMbEFRN3VwdnBKYjZ6N1ErNmNuR1lRQlJoSnN0dkxz?=
 =?utf-8?B?R0Y5cnNQQks1L0lWWjhjbE1Iays1QXFtZmlDNjQrMDZTbjYzREhjYkN0Q094?=
 =?utf-8?B?MGZNeENXcDJMUUdFRTEvNVhhcGkybVFPK0JudVJ3dlBoOGptVHlMZmZMRHJE?=
 =?utf-8?B?R2pUZ3NRek80KzBNV1BuOTdKOGo0SGVnT3p6cE4zT29SVXlDaTRyYm8rZnJp?=
 =?utf-8?B?TERteUREa0FnUkJiNE52ZGVvaDArd2F5SGszcUVkYkdYSHpvS0REY29kbndT?=
 =?utf-8?B?UHllK1cydjFJMFVEZnZYci9ubjF5L0lXR1RlK3g4TXVrUEE1WDlFQUpLVnVE?=
 =?utf-8?B?TTZsNWYxZmdlMmk2VnJDdi9WbHM2cHN1QjdWSVVqL0dDb01YNzdZc2p4ODlU?=
 =?utf-8?Q?ROOr8TKBuBnEjIt5XgX3xHD5w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122d32e5-0667-4eca-443d-08dbdae77f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 14:33:20.9512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fD+KU65TOLviWpQSIZSi3Las5BrR76rQBV5EGhBvLNSn86rtqX/NOI9OOCmfvLelAR6HObRJezsOoWtE7UXwNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8565
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBObyBub3RpY2VhYmxlIHJlZ3Jlc3Npb25zIG9uIG15IEFjZXIgQXNwaXJlIEUxNSAodGhlIGxh
cHRvcCB1c2VzIEludGVsIENvcmUNCj4gaTMgSGFzd2VsbCksIHRoYW5rcyENCj4NCj4gVGVzdGVk
LWJ5OiBCYWdhcyBTYW5qYXlhIDxiYWdhc2RvdG1lQGdtYWlsLmNvbT4NCg0KVGhhbmtzIGZvciBy
ZXBvcnRpbmcgdGhhdCB5b3UgdGVzdGVkLiBJIGRvbid0IHRoaW5rIGEgSGFzd2VsbCBpMyBnZXRz
IGFzIGZhciBhcw0KdGhlIHBpZWNlIG9mIGNvZGUgdGhhdCBJIGNoYW5nZWQuIHRoZSB3cm1zcl9z
YWZlKCkgd2lsbCByZXR1cm4gbm9uLXplcm8gYW5kDQp0aGUgZnVuY3Rpb24gcmV0dXJucyBiZWZv
cmUgZ2V0dGluZyB0byB0aGUgcGllY2UgdGhhdCBJIGNoYW5nZWQuDQoNCi1Ub255DQo=
