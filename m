Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247207788A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjHKH7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHKH7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:59:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5691FD3;
        Fri, 11 Aug 2023 00:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691740777; x=1723276777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vwi7KIeZ45fBZ7gPfHhEdGbFGSuLrtPt1KM89dMqyDU=;
  b=ELuAu8S9fi0EhYPG+B4mtAcpxIub8TPlcbau4DDlNA1tg3rjpXygKl95
   Ny4Tm5IJKUdvPK+AjxTUgEkjc10/FE0XOngODU8om9iyJwF+pWL0432OC
   7TpEPkrNSdwOlOVjaJKUjLcgjxkFQx0H76EejzgPomBnFavr4p2jg15eU
   ObXu6KQ8aFuTKlLwmq1PW8+cdDOOQy5eQp09l5ZtL1YsWwKl3hVaA7T7q
   qtI67aRzMiarZxka/UuF6VVwTSyEVU8uWJBN/zROdNnAoSiLDCBU1Fdhu
   P5PTmTo8xvU1OGQHi+7ZzkleXpZmvkWB6NtwI2ie2htOhAbRIIgrzoeG1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="374392273"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="374392273"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 00:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="876073495"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 11 Aug 2023 00:59:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 00:59:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 00:59:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 00:59:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 00:59:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKD7Zy8tK12EwB6sJ1U2cSQNl4/ALg5cz94v/5GTjRuci9EpzBcklp1OgHckCD3gR4rSWfBgUf+UlMh/kZoEmFUPj/PMhI0Tss3ee3+cCYqllZgUr/s7ZWEY3SxI7Ls9m2btWKBYxkeL72hd7OSUzxFAbxohrjQchmWqqnp9pdpvwyz6kju3+VMvq2EGk7qSNAyzQhkaYPWnIUyD0rd7+iktPNFHVtKQxo7SEJ/0KAMDQEtukQSNBnSCwwRIxjva4mksDOnGid58DqCChU5dnXxzpxb09+fprRCc6SRkrNQ6e+XDCSGHg8nyjMoCfVLVqglUcOdhpFSLXc1RiGqUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwi7KIeZ45fBZ7gPfHhEdGbFGSuLrtPt1KM89dMqyDU=;
 b=jwg1h6ztsPmw1IY95lo32waoMaTSslWjWPj8awGlKnznVJfbVIZWYLmcUvwPM4CfLoEbakANriZyMejBiNcoIcyN0Sz4W6ydWRqVZ4ICPyoMu+4uVw069bJ98I+03a1IwSpsa3Mo3ipiT0bzUMj3UJdiNzRQIs9MB+xyKiMFu9J0PrIKl52X4y2o9s9YwCNfBrtUIebP6yCU2Pb5jeCcKa3MLPNtZzxFu7ngB675g0FJgA9qLpB9xX9F1GwqCOXw6qiCEqNVH/pPeGjy5jG12nx8jTZwY36omvWhv8YJDNvsGs5N4Q8HQL1NQJ8HnxCVl6vgJkiSI/Eza3CiGMnQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 07:59:32 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::a8a8:7f69:edc8:2d6b%6]) with mapi id 15.20.6652.028; Fri, 11 Aug 2023
 07:59:32 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1 0/7] thermal: intel: intel_soc_dts_iosf: Cleanups,
 fixes and usage of generic trips
Thread-Topic: [PATCH v1 0/7] thermal: intel: intel_soc_dts_iosf: Cleanups,
 fixes and usage of generic trips
Thread-Index: AQHZy79qWLcK66M7C0y6izmFFy21ca/kvAQA
Date:   Fri, 11 Aug 2023 07:59:32 +0000
Message-ID: <1ad3ec648a4bd62cb8319a23ce58d1d901cb880f.camel@intel.com>
References: <5713357.DvuYhMxLoT@kreacher>
In-Reply-To: <5713357.DvuYhMxLoT@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CY8PR11MB7267:EE_
x-ms-office365-filtering-correlation-id: 97e66aca-9488-4b3d-8832-08db9a40e5ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fSZA2GJdSfkUhYohoT0ztDfifSEgPOgCHb0wLEofS6AEWOXbFTYcXOdcrRTGXbT2nXs/76cfRCqXeqs2UtSq5OTMXsvmO3DTVTQZVpkd8tBKh9/djF2vm9R6AiOnihnLOsNwBhvHZlhPrfzhc0cj9upX1vm8jQ6AUFpI86D7iBzYVuIYvqtPvGVW8ppQDx2rG5t//EZHnmIyYw+kguN032hhO+cwr5q0QBP51VFBTjJsOdh5EiZ2orEOGxegNjvkP6Szy1WtdI0rQDXI/PGYzijQQis+jsCElNFNEF9W5H8svEYIrJ2A/XkFRnJFmKnqhyz555ZeGAXHMw7C2uTXElxhQfT0gPVo1UoBkSK2L5/Bjxc9JOmyFc1k78wBZ5nhjpRvwumFr/K0fQt/hQP8nOPBmcmKftW3EOlvWlRv20zKnGJO7MYJUxoQypoeCmo5+VeJDKqmxU1LieEJGXV4Ky16G2Nvv8lFQKDVMlI7Sfzme0Wqg5yaDBtdmgoDuscZfgzNhLBHBSzhpBAixwW7WGh5HUawWsqFnz1bym1Xbq34o0Q/H/N67zF0UpFTeqKoNwhxf9n1EMBOoFzSIs4KUDZl1yXYxbDyP9opDX4y096cv173yfRg8aNnRUCf4Iod
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(1800799006)(186006)(966005)(6512007)(478600001)(110136005)(71200400001)(6486002)(54906003)(83380400001)(6506007)(26005)(4744005)(2616005)(2906002)(64756008)(66446008)(5660300002)(66476007)(66556008)(66946007)(76116006)(4326008)(91956017)(8936002)(8676002)(316002)(41300700001)(86362001)(38070700005)(36756003)(122000001)(82960400001)(38100700002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTdSU2Q1NGJZMng2bU1VQUdXQmphZzNJeW1kdkpHc0QzWGxJdmtkb21vYU51?=
 =?utf-8?B?dE02R2lQK1p6a0dSajNUMjRTeGhpa0xIK0VVa25DVmIwanQveUp2RVdhSW5K?=
 =?utf-8?B?eHdVajZOb0FRU0ZsUk9RdXFJS1ZqY3E1WWJrMTNmclVGQjhrb3dyTFlYWmU3?=
 =?utf-8?B?TlFkeGM2ODNrSTE4a29RM25zNm5rOFpNeDl6SEJCMjg4WnJFVExma1VzRGYz?=
 =?utf-8?B?OWR5TEZDbHI5U1NFTHNUdFZ5Z0NOVjJ5ZWpXYmRFOGg3U0JZWjI1RW1kM05P?=
 =?utf-8?B?L2ZCMlNsY1dmV0VvTW0zR0FqRVVhenZNVHVLTGk1aW5GeVNZOHhyeGdQaTZa?=
 =?utf-8?B?RU9PN3JyMS8rWWtpMnBxZnlyQ1BqRFVDNlBmRkdFWVA5ZHFsdysvTXFzUFY5?=
 =?utf-8?B?OVZMZDRmMzBrd0ljdk8zaXdHT1d3YmtVc0xTWjJxQUF2THpzVW5zWlgwdmRs?=
 =?utf-8?B?cDJlaEoweERNWFVqcWUxWFB5RmpZWExqUmVYcnh5aUxkS2dKenhIWTAyblU0?=
 =?utf-8?B?bkhNNjArSXpHQ3hJcWxObXljQjZmOHF0UWlMWk0zaFc3Ull2d2FDallWV2pH?=
 =?utf-8?B?dHVaNGdudHZFeEhPaVVUME5CYU51YjJMenNQL25kaG9tUWYwQ1NobHU5TU9H?=
 =?utf-8?B?Q29IUnBRRFBWUnhlemQ5L2dUcnk0RlJaVUlwMitIMGQ4NDBBdCtWRCtzWUVD?=
 =?utf-8?B?Vmkvbm03RzlXaDFGYzBWaHN1TWg0TmJLbHJ2clVXbXRCL3c4K2Vudkgyd0RS?=
 =?utf-8?B?RmZ2NHVGU295dHhyNExYQWZaQURaZTFnYndxVzA1OGk2RW5ldlN5RlhJMVdM?=
 =?utf-8?B?bzJOYng0RDRJME9rYnA4QlpJRVAzV2ZrT21VdmZKbUFLM3pJcE1ZNit6YTNT?=
 =?utf-8?B?UjdUOUcyZXcxbGwrT1QvRlZsdkpqbzQzM3QxNDlrQjErOUtycUo3N2ZwRVpW?=
 =?utf-8?B?Umg0UitlQ1RKKytNUzI4L2dhWUYrc0MyZTdVRktPQ3dMdFpBekpnd3dIZWox?=
 =?utf-8?B?UGFtbkR4UVZETWJpcmkxako2QUlhc0tzSjR0dFBPdmFzQ2JtQnBRS2ZLb1lo?=
 =?utf-8?B?Z3B2NnNiSW1EclJMV1JJUjl1QitUaGdkdzRSZmxDT0xaU2ttd2E4SWlXU3Vi?=
 =?utf-8?B?dnUxekxESjQwY3BVS2tTMTFGbW1mQVoxWGliYmtqeXBsSnJ2Q01OUzArcm0z?=
 =?utf-8?B?ZE1QaXQ2eXVRMUQ2ay92L3lkeHdKancyU25Ca1E1MU1ZNWFJSXl5aklFSFZB?=
 =?utf-8?B?WmYrQXRrNmpseVg2cEp2T2pkVUNqTU1Ga0MyS29JREl0RFlpMUxMRHdFVlE5?=
 =?utf-8?B?UkRqb04xdTZpSjhxMjkzRjNjRGd6dGZ4UzBwUVRMRndiQ2JBKzVEU1FBUGll?=
 =?utf-8?B?WGlDd3RKc0NQMUpxTml3V2xIN0ljQVFRTVk3NkxTczE2Z3c2S0JKOEZhNUFI?=
 =?utf-8?B?OE04SXhLc3I3QjlGeW9zWlZCekRoN21LQ2Y4WmFjR1dQd3ZHdzUvSkVYTEVI?=
 =?utf-8?B?bmNtLy9uaEJTOXNLNnNBUXpPbURxa1locHppNnlsZ0NaNWtmeFhDaHpxbW1q?=
 =?utf-8?B?TStoSHpxQmM2TEFHNFRVKytUMk1qenptOGNPcjlxNTFROWlsbWtKaUo4MXQ3?=
 =?utf-8?B?dW9WeDhyZ0QwRm91akcrVGtDcThndXphQUFXdjVsS2MxV01tVlF3am5PUTNj?=
 =?utf-8?B?MzdkREpSaXdDNTRsNjFNdGtCdzQ0V3Z1cklmWkFuZnVKL1pFQ0dzaTV0MHZY?=
 =?utf-8?B?NlVGS2NaR3h6L29Tbm80VFZxdlViMUMvSUtxT0IrQ2xrRzQyWGdZUGFhaFlp?=
 =?utf-8?B?RVl6WWJCWTJlcFg3YlRST0lkcktqVlJyNEtLd1Y4UDVRMThUTjY1akpKZDlD?=
 =?utf-8?B?QVI5Z3VyaWRsbStqYTlUdU1OWDM3UEV3RzF5aFBtQzh1Tm5DVW1sTHNUT2s0?=
 =?utf-8?B?aVFwSzZ5dlBSMFJWUU5KTWFnMTVLV1JIaldSNE5DRnlhdGRLUFRsV0ZRT3FJ?=
 =?utf-8?B?UUROSGdDaUdSVnl3SHZoNm5jQUwxRHlWNHllZk1OMDBKQXFwZHhnMi9FZC9R?=
 =?utf-8?B?QTVxemZuNm12SEhkR0IxTVB4WWVTdlAxS1RJdGNzYlJpVVJ0ai94NkhBWmNE?=
 =?utf-8?B?Z2xVVnR5WHc4S1JDak9pUjNPQXVxZm9DRUYxaU9ITlAxUUpCbVprVlFHYnAx?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59F29F7E04F7974C958C331FA9A60F9C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e66aca-9488-4b3d-8832-08db9a40e5ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 07:59:32.4279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCHzrGTVQdzvP7Y8tndjP+SYR/npxnAr0R1u4rNzaFmcWzRgwGfJFd6xx6i2JdmZkJASESKEy4L3jFHP5Os3Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
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

SGksIFJhZmFlbCwNCg0KdGhlIHBhdGNoZXMgbG9vayBnb29kIHRvIG1lLg0KSnVzdCBmb3VuZCBv
bmUgbW9yZSB0aGluZyB0byBmaXggd2hlbiBjaGVja2luZyB0aGUgY29kZS4NCldpbGwgcG9zdCBh
IHBhdGNoIG9uIHRvcCBzb29uLg0KDQp0aGFua3MsDQpydWkNCg0KT24gVGh1LCAyMDIzLTA4LTEw
IGF0IDIxOjA4ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gSGkgRm9sa3MsDQo+
IA0KPiBUaGlzIHNlcmllcyBpcyBvbiB0b3Agb2YgdGhlIGNsZWFudXBzIG9uZSBwb3N0ZWQgeWVz
dGVyZGF5Og0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcG0vMTIyNzE5MzUu
TzlvNzZaZHZRQ0BrcmVhY2hlci8NCj4gDQo+IEl0IGNvbnRpbnVlcyBjbGVhbmluZyB1cCB0aGUg
ZHJpdmVyLCBmaXhlcyBzb21lIHBvdGVudGlhbCBpc3N1ZXMNCj4gcmVsYXRlZCB0byB0aGUgb3Jk
ZXJpbmcgb2YgYWN0aW9ucyBpbiBpdCBhbmQgZmluYWxseSBtYWtlcyBpdCB1c2UNCj4gdGhlcm1h
bF96b25lX2RldmljZV9yZWdpc3Rlcl93aXRoX3RyaXBzKCkgZm9yIHRoZSByZWdpc3RyYXRpb24g
b2YNCj4gdGhlcm1hbCB6b25lcy4NCj4gDQo+IFBsZWFzZSByZWZlciB0byB0aGUgaW5kaXZpZHVh
bCBwYXRjaCBjaGFuZ2Vsb2dzIGZvciBkZXRhaWxzLg0KPiANCj4gVGhhbmtzIQ0KPiANCj4gDQo+
IA0KDQo=
