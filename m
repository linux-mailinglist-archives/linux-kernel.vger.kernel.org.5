Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF97D7A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjJZBpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZBp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:45:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B24810E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698284727; x=1729820727;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=pYXEq+gwvGQBzCys+lxNIoDIXwex0qHBO7AzNFyaJBs=;
  b=RB0fO3iXG/29zh46z92RTd9s/1jvitfbP98KKfoghU8zfTlbKJ7RR5Dh
   w8jxRYWbJYrhRzURYbEZEgqXsecEaLWtJaFkZzn7BqtpQvJWneyt63tJL
   juNcaLwC8GQ8mzOryB26wR6PzXO8mpVUK3GOJwbZ+ZG1CJK7Eae1P1sc0
   ue2Qg2GAFL3Nxk3nJfLGCo4GYh/5zholSiJ7IANKxMMCakGgd31Kvk6nd
   6PSGXIj5kJAvISTnJnZA+TKqas95TJT1ioqSZ7N0eZncYdYyLGhUZFMRj
   kCBhU8zzblneuu7CsH2HbJFCPyJpj6oUXNo5et6U/oHk0ppMsfFk9/VCE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="418563440"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="418563440"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 18:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1090435597"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="1090435597"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 18:45:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 18:45:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 18:45:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 18:45:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 18:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6dk7h/jyvDpxZMrwLLpHSF/ZUT6MvpAZVc5zSBvxXm2yJoH8NBWhtFtAsQL5wQlzurvZXSJiIRp9jIy75Ni+H5wuh053MkVhiSoc8DRGuD5cQxd5jtqN9tjdOJ/AzvV/2cnz44FmH2YwwiKV2ZakTD19JfhFhDUBnWzPaweaTrZwspe3g+Aq5v+qCaN+ZZsqQQkyDM1WTkjyPO5ZHN7O+8COz5WSPDYF4QNWzwFc55sIEpwrYArIsZPIyIfqbbLaz5BUjDD8fFLgxYZzSH+rCjy/4GXCnEVXmoAynzRGCUu7eyFaBWhhzC7BUbD8DFdxV8wHdiXDVrUbLmWGMdJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYXEq+gwvGQBzCys+lxNIoDIXwex0qHBO7AzNFyaJBs=;
 b=fCxvQ0yc2O7l+4mNagwgFaYoWEqwLI2XZ0qhBUtdEJ6nBHtrO6J0zTs0bgLX+o0+ap8iMFOjsF1PpG/0l5iGf1ShjX2k7Ka40ttWkIr7nBlY+VKl7LXHxCyynl9STHIXvE5TITp5lUwaaPn2rqU83P7tdjbj1yDzzj4ldHzPc2c+U8frLjgpoWwMzYVyBZIsOw+msRBDGl+XSyW8S2pSDUQTCbpFOKAUhmmg+D6/ve5EgU9raDJA6HB9o6wd0s9RlxIGNE0M814HzwqW1GqhvK1wf12AjVG6VQPtaO3nGhUpcG+yWQe/uLFIvZlNC/5Tbj9Osoh2KF2UKSIMD0gPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by BN9PR11MB5548.namprd11.prod.outlook.com (2603:10b6:408:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 01:45:15 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Thu, 26 Oct 2023
 01:45:15 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Topic: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Index: AQHaBtSoD4BaRGvpYEWdXJl+rjaNYrBazYeAgACA8AA=
Date:   Thu, 26 Oct 2023 01:45:15 +0000
Message-ID: <15e8b03ef471514d9347e8bffba4fdfa1ef4f3d7.camel@intel.com>
References: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
         <29564bbe-b7a0-fcc5-47ee-093a032a11b6@amd.com>
In-Reply-To: <29564bbe-b7a0-fcc5-47ee-093a032a11b6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|BN9PR11MB5548:EE_
x-ms-office365-filtering-correlation-id: a12ac521-188c-4f3e-0ea3-08dbd5c53398
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cdSPFTpLlvI5JIfPtT2E2BVGIEUndu1AYXFxI3ZuIG/0WD8O3GwrtoFb430EQWF1+sMGYCMFl4gykueFPzTkxricmGsClc7xwV9R9JaYVmQQPskys1ePtUPLzY0Hskk8VKGKBu46C+fx6Q5rZ4SIzStBuSCYtuqIwafri+hQsjemZ3zLO2HT/PFbAFDhBdgUeKomM9K1WpKI95gf9fXckv3ZgZGwgRvj+3jBUrbgg7HO6HFA1+fzfAjn689WvtrIKvojJGEAeq+hXydDYNti8O5ataHajcD3F+lHxDLlT1b1GYZNwPrU+VfNEjbXUOy3mJzGSNSavN9E3LfKWsI5U/LshLaNvbOCXQhRLAlcrA+DAOjNzfEip+e0k6qXjS08R5Xs7mVR/I8Q5xjkJBko2C4EnlyQwPB0l87IiJ4YSj9wHL00BsimnUUQuKivxo4XlnqVNazNnHwV1adC1uruLYnxI+dYzJMt+oMkQaoCRJBD9vMiqF7QbYl1+18AW+ObPnEP2+oCp1YC7kwRKSPUNfAoOt2U4NNI4rc6pSb7XKCY/bUqEUKvRgNKlnM5IYXye36Y7sjPKa9ATKn2lmm0CBs4AeUiBf8ldxTCyiV3zPNgd/bHlXwkJCzGsVcR0wbuAnD5//hkWTf9tmxeyt6FRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(122000001)(38100700002)(82960400001)(86362001)(36756003)(2906002)(4744005)(6486002)(4001150100001)(478600001)(6506007)(26005)(7416002)(6512007)(2616005)(66556008)(66476007)(76116006)(5660300002)(8936002)(8676002)(921008)(71200400001)(66446008)(66946007)(38070700009)(91956017)(110136005)(64756008)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEhsRkZwcGFOVzMvQ0t4L29pNlMwRi9BRTJiejZLd0gvVG1od3dXcEZZWGpY?=
 =?utf-8?B?ZlpadWVCa0VxRWsxVEdOR29ldjg0a1pUZUwrVTRTREVkM3I0V291SmdQeFEw?=
 =?utf-8?B?SHR4VCtXRG9RelBzd1V4YzhzS2lLWXZRK2pORUZUS3ZMRnh5MkdvdjJaMVds?=
 =?utf-8?B?ZSsybFhpUFczZU1WdWJ2QTdCd29HVTEzdHU1bkhTUkdTUWx6dGhtUUZ5K2Fi?=
 =?utf-8?B?STIvYituN0VzZTZHeGdHL3Y2b01hNVM1OXNoOHJvU29aMWNaQUgzdkYxd25v?=
 =?utf-8?B?dGREQS9hOGswU1BjU2xaTWwvSkl2c1J2Z2R6OXdWR1JEWTd0dG5DT1FKSytW?=
 =?utf-8?B?VENtd0REYU9wVEFkRUdKNldZakF1S0hDNlp3K3pIbmxnelFheEYrUm1UUjVU?=
 =?utf-8?B?Zm0vMmt1U0IxUTZxR3JiRklyNjl3d1pvUTE4bExqZ3R1ZU9HbzU4enl6OE5Y?=
 =?utf-8?B?MllHMFlIM0h5RkJ3RFp1eHIvaFkraVhBYXBzUUFhSVM3ZXg5VU5RaVhRdVVK?=
 =?utf-8?B?aWh3MFNLdE1PNC9jUVpxUGNwN1hTc3kzWTVUbW4rbEVYZXNXN25IbHFqVDN1?=
 =?utf-8?B?ZmVsSmJBNTRkRDd0SG5ZbzFMQVlOaUFOWnppOGVNYThmZVBiRGo4N050bE1Q?=
 =?utf-8?B?V1p6Q3E4YnczY0hNVWVJb0x1dlB0UlNMRFlYamdIWHFoeU83Y2pPVjVScUlj?=
 =?utf-8?B?UjQ3WDVNOUJvdE92ZXVMU3NKcGpFSTRpeExKRmZUQjE1aUJhTzAyWElPS2pz?=
 =?utf-8?B?a0loNWg3ZlF1SG9NWXpPcmcvMzBlblM0cWRzcGdPb3pncEltWTZSdS9nbmk5?=
 =?utf-8?B?N1FmbitEV0dJUVFJZDlEeE1BVEJ2MzBBY2ttVUFuU1U1aFduVnRHU2pMZFhl?=
 =?utf-8?B?Rkxjb3pZYWtZQjA5R29oak1lU3QvdXdQeUNSd0s3ekJTcVE3NXNjeTJBQ1Z4?=
 =?utf-8?B?SDViZ1RscW9NYWJpaXdCOHpzQjVhTTNHUm9nSUdRajhaMnA3ckl6QUFQWThU?=
 =?utf-8?B?cCtvc0pmVUJXWUdpY0hINEwrWFlUNnVVK29ib3FaaTN2Q3hXWnVsNmlpdE15?=
 =?utf-8?B?b2NMUzY0dU1aMm54MWZVZHMwRXMyZ2sxUS9YZ3JGMnlnMDZhNVdwcFNHU1VD?=
 =?utf-8?B?RUtFelFPY2pYNHo1R2JmMWZUdDRQVkpuV3p1UVoxYTVKMlNLaUYrVFpvME84?=
 =?utf-8?B?bUdaejVSelVhRjVGZlgrSW1BcUtjc3AvdSswbys5UWRjbVB6NXk2U1k5NUNR?=
 =?utf-8?B?dElDOHVIUUlhUGVFdDJGS2s2bnlidjJvM0ZBa25rK0FKRVhvSmdaL1NZQnR4?=
 =?utf-8?B?Q2t5SEhvNlArR1dHR3dDQThEdEMxeUFuTlJFTDBQQVVBVm8zU0ZvVVNrdmxy?=
 =?utf-8?B?bDVEOFgvd3RnUEI3YVMyUVV0RExUSSs5QzJoV0I0QWNYSGxId1pYSFcyRHZr?=
 =?utf-8?B?c0JCTU43SUpXY3NaU0w0N3hDNWY3anRYNmpGOEZmbzhXWHhveGZBRldUYjQ3?=
 =?utf-8?B?OVdMMmFYQnd5L1NkL09KV1JQelovTTlpRXZpSDlOT2ZoaVlLYS9LS09BY1Vt?=
 =?utf-8?B?dGRFVzNzQ0dMVGJHN1JvVkhEM2I4RkpmYllrcVFuMHdpMDVEOHpJckx5VGNR?=
 =?utf-8?B?SXF6Zzhxa0t6eVBnZlhjd2R3QWg2TXIzS2JPdCs5alZIc1I1RTlSQzNRVXdQ?=
 =?utf-8?B?blBPR2JGZDhDNVZXaEFxK1dOcmxIcWp2cDRYOGZwSDNMTHdQc3A3VEZYbzVo?=
 =?utf-8?B?amdaamgwTXpMUVc2bjFRcERVM1hiMUdRNGUzRHRQa3pLMTdFWkJ4TmIzUU9j?=
 =?utf-8?B?MUJTVDFyZlA5M2Fpcm9WSHR1LzFTcitYMGp1YVJNZk1aY2VvWTlwUlB0dlJn?=
 =?utf-8?B?MVpZMGhFRk9lTFYrYi9VRmMwOGVPekpOT1VqQndZRXV0VlNWYXR1eVZRM25p?=
 =?utf-8?B?SGg3c0NwUEI4TXlOZGJSd3Npd2h3UVEvQ3BaVkNUKzdFMm9OUWxIQ1JOeFZP?=
 =?utf-8?B?NmNyWjV6MmJBV2lsUUlvTmV1VGF5ZDk5dmdyNEZHdk1EZHFWdzFVZzBrbkFa?=
 =?utf-8?B?dFhUekV0c3RLQWhnZjRwT01MMzFsTU5LdzRLSEIxMzFGazEzTHJpWGMxSUpG?=
 =?utf-8?B?T2UxbWZ5NnBDSDR1TEx4Mmo1YU1wcitXUVp1RzF0OS93cEFIcCtHcCt1VmRr?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BE4CC1FA0253D4C89634DBD6F37BB18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12ac521-188c-4f3e-0ea3-08dbd5c53398
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 01:45:15.3820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0TQh7z7qnv2E0vawwAJ27jQ57hzc0nhi1fVpOR2HwmCql6F/TWblO1EUyz0ux010W2YX79qR+k6K9BRcjk6UY5tmX2BGo2jMjsW/h3iY3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTI1IGF0IDEzOjAzIC0wNTAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+
IA0KPiBSZXZpZXdlZC1ieTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4N
Cg0KVGhhbmtzIQ0KPiA+IA0KPiANCj4gVW5kZXIgU0VWLCB3aGVuIG1ha2luZyBhIHBhZ2UgcHJp
dmF0ZS9lbmNyeXB0ZWQgYW5kIHRoZSBoeXBlcnZpc29yDQo+IGRvZXMgDQo+IG5vdCBhc3NpZ24g
dGhlIHBhZ2UgdG8gdGhlIGd1ZXN0IChlbmNyeXB0ZWQpLCBidXQgc2F5cyBpdCBkaWQsIHRoZW4N
Cj4gd2hlbiANCj4gU0VWIHRyaWVzIHRvIHBlcmZvcm0gdGhlIFBWQUxJREFURSBpbiB0aGUgZW5j
X3N0YXR1c19jaGFuZ2VfZmluaXNoKCkNCj4gY2FsbCwgDQo+IGEgbmVzdGVkIHBhZ2UgZmF1bHQg
KCNOUEYpIHdpbGwgYmUgZ2VuZXJhdGVkIGFuZCBleGl0IHRvIHRoZQ0KPiBoeXBlcnZpc29yLiAN
Cj4gVW50aWwgdGhlIGh5cGVydmlzb3IgYXNzaWducyB0aGUgcGFnZSB0byB0aGUgZ3Vlc3QsIHRo
ZSBndWVzdCB3aWxsDQo+IG5vdCBiZSANCj4gYWJsZSB0byBtYWtlIGZvcndhcmQgcHJvZ3Jlc3Mg
aW4gcmVnYXJkcyB0byB1cGRhdGluZyBvciB1c2luZyB0aGF0DQo+IHBhZ2UuDQoNClllYSwgbWlz
bWF0Y2hlcyBiZXR3ZWVuIGd1ZXN0IHBhZ2UgdGFibGVzIGFuZCBFUFQvTlBUIGNhbiBiZSB0cm91
YmxlDQpmb3IgVERYIGFzIHdlbGwuDQoNCj4gDQo+IEFuZCBpZiB0aGUgaHlwZXJ2aXNvciByZXR1
cm5zIGFuIGVycm9yIHdoZW4gY2hhbmdpbmcgdGhlIHBhZ2Ugc3RhdGUsDQo+IHRoZW4sIA0KPiB5
ZXMsIHRoZSBndWVzdCB3aWxsIHRlcm1pbmF0ZS4NCg0KSSBndWVzcyB0aG9zZSBjYWxsYmFja3Mg
Y291bGQgYmUgY2hhbmdlZCB0byByZXR1cm4gYW4gZXJyb3IgYWZ0ZXIgYWxsDQp0aGVzZSBmaXhl
cyB0aGVuLCBpZiB5b3Ugd2FudC4NCg==
