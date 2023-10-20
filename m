Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E070E7D0E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377012AbjJTLVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377053AbjJTLVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:21:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014B31BF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697800900; x=1729336900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AbbZd6l5ICs0EYnqMBI+3wRGyIMcTTWtjsv88tAsf88=;
  b=G8yfE9+p0hW/QEENkjUZkJi+O1jpJI6lnlRmiTyM4PeWK9rKGqEnoyLE
   jmOTuJH87zSdOgpAi4aXUL52WbwrENuAKLgB7YSywzRTCCc3u/Gbd9AvU
   4BjmD1lv2V8LtW+7ck16D+LgmygVNyc7rJyDGkF7DxV5CQ5ov0ZQsAurS
   GjYpYbE+/5LwhiIMTg9YUNtHFWDPsgFEQH/Dte7L0wFCaozeLeme9oBIu
   iLEjYKZDKslB4+yR3DWF9F1FzgzPTkg3p043e18LvFczggzWo5hWDml9N
   J7YjoZUKcmPajXxe1BEj1Jk0usyFC6aIDLOATDwM67dqMraSOHREEpTAr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389342248"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="389342248"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 04:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="786761969"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="786761969"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 04:21:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 04:21:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 04:21:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 04:21:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 04:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQGkmfeK/OfEXT1OCWAb75BgTrs4Tl8yWkODsO3Lfdd8IvLiYSM7ax6wgDMHP9q+7JFdmG+/qp0jul4uMi4friB0t7C5VMTiIXk+otT8uEPYYaqA/qm+I5YypykAv5YVm04eucf8rzAW63d5FPpYHwGvH4vU4+MiqH4NIGw9W1oNz4igTMQ9k+TQu+8c4LstgaJpzBM3WNgH67SM2hMz6PxQVGICEdl2az/7VaMhadFxaeLYvMgA6ndlFoiKAFTV3qZVAuI8Y/2g/COBNA87HGEZoK1BepfxN8lT3xCG64fHTIr/njbjA4ksqeOg1ki6hABptcykioD185/UJthY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbbZd6l5ICs0EYnqMBI+3wRGyIMcTTWtjsv88tAsf88=;
 b=EF92/s++ROe2TBhVFQSTVCC2fRfJKyf7KObfryfrUPLfMosBmtauuRtZYRvJfVLHG3OHi4Ce38wrr+IkExRYv6Iiuzda14KJMIfbWF1JYedxyrQUjKe0174A6o9DUcwwWoZjdugobaCwb8gZjitHWd2Y6oRkOswN7WtR2WjYRn1beYW4zFn/TDJqJjPHZ/SrEfkjotE8Uyzq+UV4XzyGqo7vW6ogEyn9c+d4Z5d1hceUdVhrs08l5l/j+yakJUYO4BU+R5x4GjNVqiqDvA5hZ6hlZPWkum3SASnd8VxJPnU43ICpMUw1y9WTdT/jV+98sesXpf+VZjXczR7LQmwIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB8297.namprd11.prod.outlook.com (2603:10b6:a03:539::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37; Fri, 20 Oct
 2023 11:21:35 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 11:21:34 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Topic: [PATCH 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Index: AQHZ949Af5rSrjmHNUm2GvR447PSc7BSoAIA
Date:   Fri, 20 Oct 2023 11:21:34 +0000
Message-ID: <e4cf5fbf384a14b06034667d62bb6cb85ec64305.camel@intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
         <20231005131402.14611-14-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231005131402.14611-14-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ2PR11MB8297:EE_
x-ms-office365-filtering-correlation-id: ff14597e-8f67-49d0-2ed6-08dbd15eb7b1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2cP4LX4dSLOi8EcTf4H3555UPpYrGne3pOpXrliSWi1E0KLzJeTK3Jalu9BFPYNoHnWlDakj16Kt0Zv4ApLSFG0R3bR9Rvdo6jxCNp3ihLSI3+oMtH6FgJxxoVPmKHLr6x0ew1VN5ukslvQ/VhhdLSDEzFuUGb6WnaMbLaKGDgyhoq/Hux7sX9MeKxDTuD4yQ/uGaLhjfd3o+YLGI18BXeLs5d/FezOJ/0D+sPT58V8QehXgHry4VTNLeXRFXJXgij5jJ5vXWeva6LXnYorhB/JQnWLnJHX/x9AsaTQdVPVwpzU5Hzp2ME5A6eaPTJ89Itazr2Yun7rVqYQgKT/Le62u39uF/REL7ibF1b9HiTXOzEH9mTdNxP4Tc9wjLlzrRlO/JALBdNpQ4HieIJDpBffyBOgqUkXLjQG3buSqPXDVLgwo+VbnwgRWNt2kd7sN1SWpQQplEU4YQwG0cRdXRoPfqpqZ0iOwHKh6IxlRkHrmxhipwTtOfmJbVGBRM4LwrmESwQWsMIbzqum9Qe47EJzkTwU+NMOIq/Da/7f1/w9tITyoN/Qj3trqwo5fiM5w7T0owV0PbGowCy1695RonoIRbHX2QIvRg4ewHSprO89YqyI+WgvH9pUDQBCcHRKB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38070700009)(122000001)(66556008)(316002)(66476007)(64756008)(66446008)(66946007)(26005)(71200400001)(110136005)(2616005)(6506007)(91956017)(76116006)(478600001)(6486002)(82960400001)(6512007)(54906003)(5660300002)(41300700001)(86362001)(7416002)(2906002)(83380400001)(4326008)(8676002)(8936002)(38100700002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGhwNFJTcjhtV3RpL0FWZkR0cXg5YXllcUwzQ3p2b0FjWWtrZHZkZFIxTjFj?=
 =?utf-8?B?L0d1Q05vNytJOGp4eTF6QnJxOEpaRm9SY3YxWTVERzM0VE1CeVFGOGpGVm8y?=
 =?utf-8?B?Q2NnQnJsZUttT3VkeXZiNDdiK3V4bm13ckF2N2xEc1pnRmNTdEJDRnJyakN2?=
 =?utf-8?B?VHFsMFE5RUFJSjdocExxLzRpNFd3TmZkWTYyS0prbjJHTGErNm5Ib2FFRWJ3?=
 =?utf-8?B?R2t1aVdsWWdqNWpKUnZqUmJGMWJJSVdHQWVMeUY0R0x4dStGK2hBN1A3Nkd0?=
 =?utf-8?B?RUw5TVAxRHJHTzZNamRsdkVPMjFTRjZJNFd5aWYxemhJRXhQK2tRVWRVOEFo?=
 =?utf-8?B?Ti9KQzFMSnpCMm5sRjBXNU15VGNVSis2VTRoT203MC9DVzUvb2VpRWQ4OFpW?=
 =?utf-8?B?WU81VU93a3hvcnM4RGpzRmxzSzFaWkcyQkMrODBsR2s1VG12MENRc1FPNEdz?=
 =?utf-8?B?d1JYOEtrNzc4eEJJeWFqZDhweUFvUVJDSHVyRGV3ck5HTU10TE1ERjVubzho?=
 =?utf-8?B?U0NBd2h1V0lqWjhVZkZEYURzNEltOThVOEo3dFp6VHJ1R2RzVUVTVE83bGt0?=
 =?utf-8?B?WUNXQk1LMk9QUDh3Yk1PTkVmTXRzd0dHYnlHNFF1UUJrcUp4NWhMSnpFcnR0?=
 =?utf-8?B?MU0yUDhKNHZCcENxcFIyazAzOW1XcGl1dVBkdzhrOEZWMmVNcmlRa2NJMGpB?=
 =?utf-8?B?MWJ5NE9CMFZPbVVqNG1qdEFrazdZSENPVjE1azZLanJTNnhuWmxETWtKVURZ?=
 =?utf-8?B?Ujh4aDVKR1c5ZTkra2xGSXVySWFjcjlBZ2ZJNUJ6WklpeGZqc2dWUFl2bCtT?=
 =?utf-8?B?a0FpWVdPVkZoWTBZQ1hxbWFtN202b2hjSEFwUDVneDdYWUpuT0RHa20zM3pB?=
 =?utf-8?B?blRPVFNFTE95M0M5bnpWWjNGWCszS3Q3aXc5ZVRMVnNFSm9Hem1hOEpwWE94?=
 =?utf-8?B?djdOTFNYVWYwQ3dPTVdQODVJdFJJK0d1ZEdCWUViQzlYV0dQTGkzdVA1WWxl?=
 =?utf-8?B?SVJwam9BZTNRT3NxNEp2TXZUZXN0QUE5NVJzUEFjSUo1NEwrNGsxTFY0UnQ3?=
 =?utf-8?B?SWlSczY0cER0bWVaRG9KTHRMSU9nY1JtSTVZTnlQVGg5RDNxRFZaYjFjbUsz?=
 =?utf-8?B?RVA0ZnlmSTBkVm1kY0Q2QVUweURncng0RVRYZ1RvQ2JTUnVZTU05aWlwdlJm?=
 =?utf-8?B?dVQrYU9mZ0ZyU1pJelRBcWlpL25yK0lkdzI2N1M1YzVjeVR4d3k5cXhRVVFu?=
 =?utf-8?B?RTBvdldGcGZ4VGF4VUh3ejRFd3N3VUphQS9PMlJBSjYxRWFPamV6ZkhOU09B?=
 =?utf-8?B?Z3QxcVNVRGlzSVQ4ZFhlTEs2WTBQWTVReHhvZWlaejhuWityVy91R1lPU3dv?=
 =?utf-8?B?VDg1eEhTd3hSdXRkKzdFNWdvMFVDdjlOeXVUMElqdUkzR2xPUENJZWdLNDc3?=
 =?utf-8?B?L0ZyNWVQTVFHTDM4V01SNTVWamVCZU1tc2s4bS9UY0IycGpYSC9pTHVJNmFI?=
 =?utf-8?B?Unh6SitOUENHWm1MbFcyN0NOaGZ1bHIydFkwcXB1QjI4M1hRakZYV3hRT3VN?=
 =?utf-8?B?SC8yRHRycVVvM0pUb1pjS3FScFJKQTBZK3RjUENWclh6c09FTll1NmhPR0pO?=
 =?utf-8?B?RDBjYW94MUVZSG9FNHBwMVY2SkJLWmpuWGNTdFZjZit1Ty9lMHVsa2RtNmlU?=
 =?utf-8?B?V2M0UzU2MHhIMlRMTC9taTZaZDF4SThlSWlpWEkxd3lQL2k0b2I1UU1aQ3k1?=
 =?utf-8?B?cXRqRXltYXAwOFkrY1Q0M3lMTSt1OUhqTFZ0WUFQeTdsVUJFSko4ZytLbGE3?=
 =?utf-8?B?QzFjaFNaWUh3MURJcElmMllIZUQxekJqZHRGK2thZ1FkREtaejc2MlUzckR5?=
 =?utf-8?B?cis5enVwQlhhSzJWb2NzeHRPYnpMYUlkYTlMUGdicU8wMUNnWHovYWxmbEQz?=
 =?utf-8?B?QnVNZVk5UDJqbzRmSUkvSHNDZHVpdlA0MkduMDhpOHlDS2lHSG85NFlieVk3?=
 =?utf-8?B?WkZMTXd6K3JXanlPWGk1bjRjdGw2S2Nya0pOa3huSW5ONU1XWUR1RFNNaTM5?=
 =?utf-8?B?bGp3ZFV1MU1aYkJMUFplR2MrZmJvN255dUhXTUlwZmtFL0pKT1BTSVgyeTIx?=
 =?utf-8?B?VmU1dFRFN1cvcDRDcFp2UUo3MkFVQkhWZkdxbGZZUkF5MmNIa0twL283SjdK?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2A3BB0179D8B846AE4B27C455DB0733@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff14597e-8f67-49d0-2ed6-08dbd15eb7b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 11:21:34.1777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7X7KTeWwpldRWVdOBTPHJ3MZmw+euTFmxo56xWz+017RYkB1n5WmC3U+9Iob0V6I640Yt2UlY8lNzts8Yej+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8297
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2FjcGkvbWFkdC5TDQo+
IEBAIC0wLDAgKzEsMjggQEANCj4gKyNpbmNsdWRlIDxsaW51eC9saW5rYWdlLmg+DQo+ICsjaW5j
bHVkZSA8YXNtL25vc3BlYy1icmFuY2guaD4NCj4gKyNpbmNsdWRlIDxhc20vcGFnZV90eXBlcy5o
Pg0KPiArI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3ItZmxhZ3MuaD4NCj4gKw0KPiArCS50ZXh0DQo+
ICsJLmFsaWduIFBBR0VfU0laRQ0KPiArU1lNX0ZVTkNfU1RBUlQoYXNtX2FjcGlfbXBfcGxheV9k
ZWFkKQ0KPiArCS8qIExvYWQgYWRkcmVzcyBvZiByZXNldCB2ZWN0b3IgaW50byBSQ1ggdG8ganVt
cCB3aGVuIGtlcm5lbCBpcyByZWFkeSAqLw0KPiArCW1vdnEJYWNwaV9tcF9yZXNldF92ZWN0b3Jf
cGFkZHIoJXJpcCksICVyY3gNCj4gKw0KPiArCS8qIHplcm8gb3V0IGZsYWdzLCBhbmQgZGlzYWJs
ZSBpbnRlcnJ1cHRzICovDQo+ICsJcHVzaHEJJDANCj4gKwlwb3BmcQ0KPiArDQo+ICsJLyogVHVy
biBvZmYgZ2xvYmFsIGVudHJpZXMuIEZvbGxvd2luZyBDUjMgd3JpdGUgd2lsbCBmbHVzaCB0aGVt
LiAqLw0KPiArCW1vdnEJJWNyNCwgJXJkeA0KPiArCWFuZHEJJH4oWDg2X0NSNF9QR0UpLCAlcmR4
DQo+ICsJbW92cQklcmR4LCAlY3I0DQo+ICsNCj4gKwkvKiBTd2l0Y2ggdG8gaWRlbnRpdHkgbWFw
cGluZyAqLw0KPiArCW1vdnEJYWNwaV9tcF9wZ2QoJXJpcCksICVyYXgNCj4gKwltb3ZxCSVyYXgs
ICVjcjMNCj4gKw0KPiArCS8qIEp1bXAgdG8gcmVzZXQgdmVjdG9yICovDQo+ICsJQU5OT1RBVEVf
UkVUUE9MSU5FX1NBRkUNCj4gKwlqbXAJKiVyY3gNCj4gK1NZTV9GVU5DX0VORChhc21fYWNwaV9t
cF9wbGF5X2RlYWQpDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9tYWR0X3dh
a2V1cC5jIGIvYXJjaC94ODYva2VybmVsL2FjcGkvbWFkdF93YWtldXAuYw0KPiBpbmRleCA0ZTky
ZDFkNGE1ZmEuLjJjYzg1OTBlYzdhNSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2Fj
cGkvbWFkdF93YWtldXAuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9tYWR0X3dha2V1
cC5jDQo+IEBAIC0xLDEyICsxLDE2MiBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCj4g
ICNpbmNsdWRlIDxsaW51eC9jcHUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L21lbWJsb2NrLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcGd0YWJsZS5o
Pg0KPiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2hvdHBsdWcuaD4NCj4gICNpbmNsdWRlIDxhc20v
YXBpYy5oPg0KPiArI2luY2x1ZGUgPGFzbS9pbml0Lmg+DQo+ICANCj4gIC8qIFBoeXNpY2FsIGFk
ZHJlc3Mgb2YgdGhlIE11bHRpcHJvY2Vzc29yIFdha2V1cCBTdHJ1Y3R1cmUgbWFpbGJveCAqLw0K
PiAgc3RhdGljIHU2NCBhY3BpX21wX3dha2VfbWFpbGJveF9wYWRkcjsNCj4gIC8qIFZpcnR1YWwg
YWRkcmVzcyBvZiB0aGUgTXVsdGlwcm9jZXNzb3IgV2FrZXVwIFN0cnVjdHVyZSBtYWlsYm94ICov
DQo+ICBzdGF0aWMgc3RydWN0IGFjcGlfbWFkdF9tdWx0aXByb2Nfd2FrZXVwX21haWxib3ggKmFj
cGlfbXBfd2FrZV9tYWlsYm94Ow0KPiAgDQo+ICt1bnNpZ25lZCBsb25nIGFjcGlfbXBfcGdkOw0K
PiArdTY0IGFjcGlfbXBfcmVzZXRfdmVjdG9yX3BhZGRyOw0KDQpOaXQ6wqANCg0KVGhleSBhcmUg
Ym90aCBwaHlzaWNhbCBhZGRyZXNzLiAgSXQncyBhIGxpdHRsZSBiaXQgb2RkIGZvciBvbmUgdG8g
dXNlICd1bnNpZ25lZA0KbG9uZycgYW5kIHRoZSBvdGhlciB0byB1c2UgJ3U2NCcuDQoNCj4gKw0K
PiArdm9pZCBhc21fYWNwaV9tcF9wbGF5X2RlYWQodm9pZCk7DQo+ICsNCj4gK3N0YXRpYyB2b2lk
IF9faW5pdCAqYWxsb2NfcGd0X3BhZ2Uodm9pZCAqY29udGV4dCkNCj4gK3sNCj4gKwlyZXR1cm4g
bWVtYmxvY2tfYWxsb2MoUEFHRV9TSVpFLCBQQUdFX1NJWkUpOw0KPiArfQ0KDQpJZiBJIGFtIHJl
YWRpbmcgY29ycmVjbHR5LCBAY29udGV4dCBpcyBuZXZlciB1c2VkLiAgSXQncyBub3QgdXNlZCBp
bnNpZGUgdGhpcw0KZnVuY3Rpb24sIGFuZCBhbGwgdGhlIGNhbGxlcnMgY2FsbCB0aGlzIHdpdGgg
QGNvbnRleHQgPSBOVUxMLg0KDQoNClsuLi5dDQoNCj4gKw0KPiArc3RhdGljIHZvaWQgYWNwaV9t
cF9wbGF5X2RlYWQodm9pZCkNCj4gK3sNCj4gKwlpZGxlX3Rhc2tfZXhpdCgpOw0KPiArCWNwdWhw
X2FwX3JlcG9ydF9kZWFkKCk7DQo+ICsJYXNtX2FjcGlfbXBfcGxheV9kZWFkKCk7DQo+ICt9DQo+
ICsNCg0KTG9va3MgeW91IGNhbiB1c2UgcGxheV9kZWFkX2NvbW1vbigpIGhlcmUsIGlmIHlvdSB0
YWtlIElSUSBkaXNhYmxlIHBhcnQgb3V0IGZyb20NCnRoZSBhc3NlbWJseSwgYmVjYXVzZSBwbGF5
X2RlYWRfY29tbW9uKCkgZG9lczoNCg0Kdm9pZCBwbGF5X2RlYWRfY29tbW9uKHZvaWQpDQp7ICAg
ICAgICAgICAgICAgDQogICAgICAgIGlkbGVfdGFza19leGl0KCk7DQogICAgICAgICAgICAgICAg
DQogICAgICAgIGNwdWhwX2FwX3JlcG9ydF9kZWFkKCk7ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgIA0KICAgICAgICBsb2NhbF9pcnFfZGlz
YWJsZSgpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IA0KfQ0K
