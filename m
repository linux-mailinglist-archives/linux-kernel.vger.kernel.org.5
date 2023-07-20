Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1094175B89C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGTUUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGTUUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:20:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCC8271C;
        Thu, 20 Jul 2023 13:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689884412; x=1721420412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=npGzk3jykTImHy8rFpnlQ/zmtZus/yVKQWItp7bycWI=;
  b=YYXxFcMv+uMRVVnI6GTiHOGswegabsgZZkriKEOUqOklmVNlfkgC432Z
   ESwpdIYHTVri7sFTTA9EWHVz9EkIPv97k2BJLa9fDLkekr+79ciTvB+Q0
   yZ10riPrB9pecL4QWx5H+yyETASH7P8XvFEknY7oZ3yuBdt/myGh3+zXK
   JJmnaS2H5ai4HZYu39iHrDPAAwA1f/k5KNOJCPph5smmoKNdEg7tcxzON
   KOcAVVkT/M48WaQ26Wp3LHn2km8K6DKkOraBC/rE8msc5AGmULAag7bnq
   H0ikKToKUZS75VhPafhLUKUEWXyFYeODEo2Ix/k12orLBzPNNn68TZRhz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433077471"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="433077471"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 13:20:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="674811877"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="674811877"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 20 Jul 2023 13:20:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 13:20:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 13:20:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 13:20:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 13:20:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMZI3o/s+eIytSowzGIWaG57kzkzPKi2W7NJxQMt/cIfhgre+nP18Ea5QqwfEb4C/Ad7PPf7cJUY+dSugSxJR247hznOQx9AiPePAL5pPaK7+8BojKl/un5elq9987Kbc/UXL0AQEXNLDqsVT2V4EHbopFWg8NGmkrbUpqOcFlE6R0GcrU1DdHl83fTx7m1sgQkxWwGil2m9VXtd0mQlvacHUWmp2K4kihIXz+p0NIe7JLORQ9bk1fcSl6HQRBFPd5P8qO0vKN2jav8PnNqgZjkPqe+r+0vtDe9nhqoKTNO4KdtYLIzNHgeE97JjpH1Zq+WorRmyo0wTTv3529F/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npGzk3jykTImHy8rFpnlQ/zmtZus/yVKQWItp7bycWI=;
 b=GSxU4WKueNbai3Ap0M2EBGV5zwftG3q3NPfnEKNfoj+MGjK9v7ps+JvUxoPLDnVa97a0yt7cmkTpsFENsIiGIYTsI0dgP19sX+5EckRwHXUYFb3zWZXLvcTTeTnBzuJqPC3qpVSCodckvGNx/VuPVnSueVpxdeVwD0dJQRCD4M7niw3AI6R22IN1cZS837ckF2hKdj4ypNz4Dsvcb8z8xIpNdBmXeKNsWzpCPVJJk7gTz/S8MvT1l4Gu0c7HM9ThxxCEIfphQFBW1Ovua2lTTl5STweOQYGqYbiRsH53jjHDIO2sekJkax8s63JFgbn4q85LaNEdIRnzvid4t2LYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32; Thu, 20 Jul 2023 20:20:09 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::2f24:2dc9:60b:a244]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::2f24:2dc9:60b:a244%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 20:20:09 +0000
From:   "Winiarska, Iwona" <iwona.winiarska@intel.com>
To:     "tmaimon77@gmail.com" <tmaimon77@gmail.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
CC:     "avifishman70@gmail.com" <avifishman70@gmail.com>,
        "Fair, Benjamin" <benjaminfair@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "venture@google.com" <venture@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "warp5tw@gmail.com" <warp5tw@gmail.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/4] peci: Add peci-npcm controller driver
Thread-Topic: [PATCH 2/4] peci: Add peci-npcm controller driver
Thread-Index: AQHZuo3OPHLtIwLsKUWAISvdIc8ZeK/CL1aAgAAmpICAAGc4gIAAXNiA
Date:   Thu, 20 Jul 2023 20:20:08 +0000
Message-ID: <d6de8b0e5b54ca12d9f9930f01a85467b145b134.camel@intel.com>
References: <20230719220853.1029316-1-iwona.winiarska@intel.com>
         <20230719220853.1029316-3-iwona.winiarska@intel.com>
         <dfda43af-e9b4-85bf-e165-02127e02fbf0@molgen.mpg.de>
         <9a6eb22ef6b7a6a686250ed83894e8d37de30baa.camel@intel.com>
         <2f9858b0-88e2-736a-f16a-f4fbe549e389@molgen.mpg.de>
In-Reply-To: <2f9858b0-88e2-736a-f16a-f4fbe549e389@molgen.mpg.de>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5823:EE_|DM3PR11MB8670:EE_
x-ms-office365-filtering-correlation-id: 78d091ef-a0e6-4587-6ee2-08db895eb6d8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cdDEr/gPEtxms6vDTHwah53P8AADx0c4CpOWXlKSQQAf6GEyAgb/BrSQDbYm9Ov8NYreTWrFN3v/Ymgc2CYyFfTv5pjiu9V/wZa5wYbhPlhZG4HGFsHTjI/qPti9bmcuyXvXCrN/GoexU10x8oZ+5Nm/SknO3W0sGXO6IRl7+7L/C/ePZkv0WhjNKg5bWX8KzLxTji78u5J5FUM9+2zkVg5pWvzps9AsEVQY6hy+iLQhKfD6YEVigOnE20PjicFMrEhZIyLSn9Zti2aKE/DrorPXAIAfOrcI62mODKwy2X3FPEW7L5luhJOmWy6T3e83AYzsfaOIwHbcuZdq8r4c6h23sWmeUbq/adFqOV3Ts4I2bH7LJ0rXHgqCvAMhJ18QTJQ9PZD88fuLOn2UWnWdemRDWbnNuor9Pf093OPnP5AtTf+TyAMBwg74vQULoUVKMWok02dsayeGzP91dKweRKBRqfKO23FVtAHs47LUWPsp5cwnqzHtKPjSrJg4la0iWEJVimYF9Koex4SM9qJF3ah05JrnHDJQlW8BYbO+euMBOvnpV3Ul0AyBywBaFavf2THv4dF1Dh8YeYmRMFg8MH2gBiyX61A1oazP0f/iR/f0MBxpH1SqO4Lv0ghVlFyW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(41300700001)(91956017)(6512007)(66446008)(8676002)(7416002)(8936002)(2906002)(66556008)(66946007)(6486002)(54906003)(76116006)(86362001)(122000001)(66476007)(4326008)(64756008)(316002)(36756003)(2616005)(5660300002)(38100700002)(83380400001)(26005)(186003)(71200400001)(82960400001)(6506007)(38070700005)(110136005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGcvcExjb2JXNUlYY0N6ZXI5Q0FqdUR6VHFPTE5VZGdIYkNIS1M4UWlweEFI?=
 =?utf-8?B?WHBhMi9BVzBsS2ZhVDBxeEpBWVJuTkVDaDRaR0cwQmNZaHlmQjUrNjhKQktY?=
 =?utf-8?B?bFpHdzVyMmpWNC9KaDlrN3hhc09zSktPZTVkc3d5WG9ZOTFTekk5MDdrWjFN?=
 =?utf-8?B?NnRuU1RUem5HK081WDZqVUY2NWpnalVaVU1jcVZvV082cmFDVmsxbWw2UUpx?=
 =?utf-8?B?L3Jtc2hyOFFwSTdQUG5VeU5nZk94NlhyLytOdzZIRkdGdkNuWEEyUmZ3SGZp?=
 =?utf-8?B?bUxWYWd2dlNNQ2xuYzNOY2xVS2tRZlJCUFF4Y1JudU93M2tCMmFldlBjSW01?=
 =?utf-8?B?TE9ralZPUHYwdHVSNnJNZE5LU2lWWGpBSU9CRFRHbWVCTmt3ZG9QQmx6WGZU?=
 =?utf-8?B?ZFZFd0t2VHBLQXpxeEVLTUx3eE4xWkpCV1g4NlJJYXp5WTVaTU9pdG4wRFUx?=
 =?utf-8?B?Z2dKQm42clNmUGtoWkZrZm5LV1dhd0tnaVMzV2ZBdHdGZHpsUk5STGRCalRN?=
 =?utf-8?B?djRRV0l3alJ2ZkZZVlpVbTNCZk1zMmE1Mm4zNjVOMlo2K0F5akVTOUxnSWw3?=
 =?utf-8?B?cnZ4L0xQVTMzd2cyTnJMRkFZcFBnczIvQkc5UkpnOWNxYTFWalIxaDUyZjk1?=
 =?utf-8?B?b2ZvRFFzaEpYS3NjUlhmYkJndnVOZGNiWDFvODMweUh1RWgwWk5KelFlQ0ZU?=
 =?utf-8?B?bWNZNUpWYWxiNFh0cVRqTDVFaVRNa2c3Sk1JTVIwUTl6LzVNcWorbENnV2wr?=
 =?utf-8?B?U0xOUUdOU1BJTWE4ZFBySjR3K1ZrNEQxUUpKbmV4Rk1Fa3JOUFYrdzY0RWJG?=
 =?utf-8?B?WmlBMnZHck16aVRTMk1SdW0zVklYYk1FT0NIRWlySGNTbUZwNWwvREJYY3Yv?=
 =?utf-8?B?OGZWUWpxU1M2NzdoQjlSZm9vUGlPdFhJWEpzaElUNE5pVFRVMXhaSkRYZGNo?=
 =?utf-8?B?QzZib0tLU2FTK0RUdzZxTUtsbThqdW5kWFFXYThvNyt0YTdubERYTm5maEJk?=
 =?utf-8?B?TWlLUzdaUjErbkJ6Y04rZklQTUlpaWRtWStzenBGV1c1d2VHL2ZFbS9FMENC?=
 =?utf-8?B?enlsYzVxU1krWlVySFNtTDZFbHJRMWxOZkRQSy9aQVN0RVNPRFFUekZVZ05h?=
 =?utf-8?B?QS9WNGxFVEw2aG5vY05veDgwaktsNC9lMm5rVkJqODhPUnEvQlkvTE9wZHF3?=
 =?utf-8?B?UU5PRGZzZUZtNllmaGhGRVhIUDdZSWxjNG9ydEROSmdvQXVrdnFPQXdCTDZt?=
 =?utf-8?B?Z3UyaWJNUkpGanh5K1FxMTl4aDRvOWtVVFRlUXJFSno0SU0ycWhhbjhrM3lL?=
 =?utf-8?B?VStBTDZHWW5vVFFuclFmenl5bUY1dTlYK1hYbnNWOTc3dTYxTWdwdTJzMmNv?=
 =?utf-8?B?VWJwRnROTmQrdldHaWV5RG43N2pFajMzdC9yVWJVQ1RCOE0va1RPajNZSFRG?=
 =?utf-8?B?Nld1RHBBelR3OXlSSk9FenhRVnJ6b1lVMHV1a0JaS0p0QWlDS0UzR0Q1YlFM?=
 =?utf-8?B?QkZwRTNxZC8xNU9Jb1cxaGh0Rm9MQ2RvR1doYnpEZGFVcjJ3cEd4Y3JiVlJz?=
 =?utf-8?B?TzRTWldYSkcyeXMybUtXNWJ4MG9NVzM3UHQwajZVcnM5MVBMVmFoRXJvNUR1?=
 =?utf-8?B?RTkza3Z6N3BFaWM1dEt1SlEzQ2FOSmJYUkVBU1JuMHBiVWYrWjFoYXJtejI4?=
 =?utf-8?B?QVRNeTdSeWRRY2VIQ2REeE5ZQS9ERUZkVTdrNXJWdjIvTmc0c2tXYVFwNnhi?=
 =?utf-8?B?aURoR1VLY2MzSTlJeHNOczJUV0VwaHdYeEJVOUc3WVJyazRDcm1PaGhLZGNm?=
 =?utf-8?B?WDg5cDJBMXZLM3ROQkZEK3VndmNTcVQ4M0FPRnRGa3VnWlNudGVnOHVyZGxQ?=
 =?utf-8?B?NDNZZkcvRWhBSlNFbGNpR2t5ZlBIZ2czczlhYVlrTlFLVUhVS2xFcThIVlVz?=
 =?utf-8?B?WlR2aUk1MkJWYUV0T3FCTmZ4MThrcWNySmJGaHU4UTJDOW1JOE9WVGZTVVEz?=
 =?utf-8?B?T0Rxb2pVNDIveU1TYXhEWXBlc2RNYmtnZVBvYWlpdHowU01Bd2JPbmJrbmVi?=
 =?utf-8?B?YzN6ZWh5bVZoa1BLYlU3OFhUQWFmRDFQRmpMQ2ZrZE9XTmRjcUVXN3YvVzBW?=
 =?utf-8?B?MDdkSXRTdndhaEhlMmpOSHQvenc0SXhDRnRrVHhnSWY2U202RG9HM1VnRWFU?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FF4940B08D0D341A4BA3E0F78D8D24C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d091ef-a0e6-4587-6ee2-08db895eb6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 20:20:09.0252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hIkeR1pkBfqqnZrEahvLPxEuHE64KerneQdz/euvPp5higI77lL9GLIoE3aRqIU+XwCUeXIwGbUequqwn4eJ/6/3+ZuTrzLrzhVicqLHGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTIwIGF0IDE2OjQ3ICswMjAwLCBQYXVsIE1lbnplbCB3cm90ZToNCj4g
RGVhciBJd29uYSwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBxdWljayByZXBseS4NCj4g
DQo+IEFtIDIwLjA3LjIzIHVtIDEwOjM4IHNjaHJpZWIgV2luaWFyc2thLCBJd29uYToNCj4gPiBP
biBUaHUsIDIwMjMtMDctMjAgYXQgMDg6MjAgKzAyMDAsIFBhdWwgTWVuemVsIHdyb3RlOg0KPiAN
Cj4gPiA+IEFtIDIwLjA3LjIzIHVtIDAwOjA4IHNjaHJpZWIgSXdvbmEgV2luaWFyc2thOg0KPiA+
ID4gPiBGcm9tOiBUb21lciBNYWltb24gPHRtYWltb243N0BnbWFpbC5jb20+DQo+ID4gPiA+IA0K
PiA+ID4gPiBBZGQgc3VwcG9ydCBmb3IgTnV2b3RvbiBOUENNIEJNQyBoYXJkd2FyZSB0byB0aGUg
UGxhdGZvcm0gRW52aXJvbm1lbnQNCj4gPiA+ID4gQ29udHJvbCBJbnRlcmZhY2UgKFBFQ0kpIHN1
YnN5c3RlbS4NCj4gPiA+IA0KPiA+ID4gUGxlYXNlIGVsYWJvcmF0ZSBvbiB0aGUgaW1wbGVtZW50
YXRpb24sIGFuZCBkb2N1bWVudCB0aGUgdXNlZCBkYXRhc2hlZXRzLg0KPiA+IA0KPiA+IEFzIGZh
ciBhcyBJIGtub3csIHRoZXJlIGlzIG5vIHB1YmxpY2x5IGF2YWlsYWJsZSBkb2N1bWVudGF0aW9u
Lg0KPiANCj4gVG9vIGJhZC4gRG9jdW1lbnRpbmcgdGhlIGRhdGFzaGVldCBuYW1lIGFuZCB2ZXJz
aW9uIGlzIHN0aWxsIGltcG9ydGFudCwgDQo+IHNvIGRldmVsb3BlcnMgY291bGQgcmVxdWVzdCBp
dCwgYW5kIGl0IGNhbiBiZSBtYXBwZWQsIG9uY2UgdGhleSBhcmUgbWFkZSANCj4gcHVibGljLg0K
DQpTb3JyeSwgdW5mb3J0dW5hdGVseSBJIGNhbid0IGhlbHAgd2l0aCB0aGF0LCBJIGRvbid0IGhh
dmUgYWNjZXNzIHRvIGFueSBOdXZvdG9uDQpkb2NzLiBQZXJoYXBzIFRvbWVyIGNhbiBwcm92aWRl
IG1vcmUgaW5mb3JtYXRpb24/DQoNCj4gDQo+ID4gPiBBZGRpdGlvbmFsbHksIHBsZWFzZSBkb2N1
bWVudCBob3cgeW91IHRlc3RlZCB0aGlzLg0KPiA+IA0KPiA+IEFyZSB5b3UgYXNraW5nIHRvIGlu
Y2x1ZGUgdGhpcyBpbmZvcm1hdGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2U/DQo+IA0KPiBZZXMu
DQo+IA0KPiA+IFRoYXQgd291bGQgYmUgdW51c3VhbC4NCj4gPiBCdXQgaW4gZ2VuZXJhbCAtIGl0
J3MgYSBjb250cm9sbGVyIGRyaXZlciwgaXQgYWxsb3dzIFBFQ0kgc3Vic3lzdGVtIHRvDQo+ID4g
ZGV0ZWN0DQo+ID4gZGV2aWNlcyBiZWhpbmQgaXQgYW5kIGZvciBQRUNJIGRyaXZlcnMgdG8gYmlu
ZCB0byB0aG9zZSBkZXZpY2VzLg0KPiANCj4gSGF2aW5nIGEgdGVzdCBsaW5lIGluIHRoZSBjb21t
aXQgbWVzc2FnZSBpcyBub3QgdW51c3VhbCBhdC4gU28gcGVvcGxlIA0KPiB3aXRoIHN5c3RlbXMg
d2hlcmUgaXQgZG9lc27igJl0IHdvcmssIGNvdWxkIHJlcGxpY2F0ZSB0aGUgdGVzdCBzZXR1cCB0
byBhdCANCj4gbGVhc3QgdmVyaWZ5IHRoYXQgaXQgd29ya3MgaW4gdGhhdCBjb25maWd1cmF0aW9u
Lg0KDQpJdCdzIHVudXN1YWwgYXMgYWxtb3N0IG5vbmUgb2YgdGhlIGNvbW1pdHMgaW4gTGludXgg
a2VybmVsIGNvbnRhaW4gImhvdyB0byB0ZXN0DQppdCIgZGVzY3JpcHRpb24uDQpUaGUgZXhwbGFu
YXRpb24gYm9keSBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugc2hvdWxkIGV4cGxhaW4gKndoeSogdGhl
IHBhdGNoIHdhcw0KY3JlYXRlZCwgbm90IGhvdyB0byB0ZXN0IGl0Lg0KQW5kIHdoZW4gdGFrZW4g
YXMgYSBzZXJpZXMgLSBpdCdzIHNlbGYgZG9jdW1lbnRpbmcuIFRoZXJlJ3MgYSBLY29uZmlnIHdo
aWNoDQphbGxvd3MgdG8gZW5hYmxlL2Rpc2FibGUgdGhlIGRyaXZlciwgYW5kIHRoZXJlIGFyZSBi
aW5kaW5ncyB3aGljaCBzaG93IHdoYXQNCnBsYXRmb3JtIGNvbnRhaW5zIHRoZSBoYXJkd2FyZSB0
aGF0IGlzIGNvbXBhdGlibGUgd2l0aCBpdC4NCg0KPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
VG9tZXIgTWFpbW9uIDx0bWFpbW9uNzdAZ21haWwuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBUeXJvbmUgVGluZyA8d2FycDV0d0BnbWFpbC5jb20+DQo+ID4gPiA+IENvLWRldmVsb3BlZC1i
eTogSXdvbmEgV2luaWFyc2thIDxpd29uYS53aW5pYXJza2FAaW50ZWwuY29tPg0KPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBJd29uYSBXaW5pYXJza2EgPGl3b25hLndpbmlhcnNrYUBpbnRlbC5jb20+
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoMKgIGRyaXZlcnMvcGVjaS9jb250cm9sbGVyL0tjb25m
aWfCoMKgwqDCoCB8wqAgMTYgKysNCj4gPiA+ID4gwqDCoCBkcml2ZXJzL3BlY2kvY29udHJvbGxl
ci9NYWtlZmlsZcKgwqDCoCB8wqDCoCAxICsNCj4gPiA+ID4gwqDCoCBkcml2ZXJzL3BlY2kvY29u
dHJvbGxlci9wZWNpLW5wY20uYyB8IDI5OA0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ID4gPiA+IMKgwqAgMyBmaWxlcyBjaGFuZ2VkLCAzMTUgaW5zZXJ0aW9ucygrKQ0K
PiA+ID4gPiDCoMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BlY2kvY29udHJvbGxlci9w
ZWNpLW5wY20uYw0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGVjaS9j
b250cm9sbGVyL0tjb25maWcNCj4gPiA+ID4gYi9kcml2ZXJzL3BlY2kvY29udHJvbGxlci9LY29u
ZmlnDQo+ID4gPiA+IGluZGV4IDJmYzVlMmFiYjc0YS4uNGY5YzI0NWFkMDQyIDEwMDY0NA0KPiA+
ID4gPiAtLS0gYS9kcml2ZXJzL3BlY2kvY29udHJvbGxlci9LY29uZmlnDQo+ID4gPiA+ICsrKyBi
L2RyaXZlcnMvcGVjaS9jb250cm9sbGVyL0tjb25maWcNCj4gPiA+ID4gQEAgLTE2LDMgKzE2LDE5
IEBAIGNvbmZpZyBQRUNJX0FTUEVFRA0KPiA+ID4gPiDCoMKgIA0KPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBUaGlzIGRyaXZlciBjYW4gYWxzbyBiZSBidWlsdCBhcyBhIG1vZHVsZS4gSWYg
c28sIHRoZSBtb2R1bGUNCj4gPiA+ID4gd2lsbA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBiZSBjYWxsZWQgcGVjaS1hc3BlZWQuDQo+ID4gPiA+ICsNCj4gPiA+ID4gK2NvbmZpZyBQRUNJ
X05QQ00NCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgdHJpc3RhdGUgIk51dm90b24gTlBDTSBQRUNJ
IHN1cHBvcnQiDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gQVJDSF9OUENNIHx8
IENPTVBJTEVfVEVTVA0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBkZXBlbmRzIG9uIE9GDQo+ID4g
PiA+ICvCoMKgwqDCoMKgwqDCoHNlbGVjdCBSRUdNQVBfTU1JTw0KPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqBoZWxwDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgIFRoaXMgb3B0aW9uIGVuYWJsZXMg
UEVDSSBjb250cm9sbGVyIGRyaXZlciBmb3IgTnV2b3RvbiBOUENNN1hYDQo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgIGFuZCBOUENNOFhYIFNvQ3MuIEl0IGFsbG93cyBCTUMgdG8gZGlzY292ZXIg
ZGV2aWNlcyBjb25uZWN0ZWQNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqAgdG8gaXQgYW5kIGNv
bW11bmljYXRlIHdpdGggdGhlbSB1c2luZyBQRUNJIHByb3RvY29sLg0KPiA+ID4gPiArDQo+ID4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgIFNheSBZIGhlcmUgaWYgeW91IHdhbnQgc3VwcG9ydCBmb3Ig
dGhlIFBsYXRmb3JtIEVudmlyb25tZW50DQo+ID4gPiA+IENvbnRyb2wNCj4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqAgSW50ZXJmYWNlIChQRUNJKSBidXMgYWRhcHRlciBkcml2ZXIgb24gdGhlIE51
dm90b24gTlBDTSBTb0NzLg0KPiA+ID4gPiArDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgIFRo
aXMgc3VwcG9ydCBpcyBhbHNvIGF2YWlsYWJsZSBhcyBhIG1vZHVsZS4gSWYgc28sIHRoZSBtb2R1
bGUNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqAgd2lsbCBiZSBjYWxsZWQgcGVjaS1ucGNtLg0K
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wZWNpL2NvbnRyb2xsZXIvTWFrZWZpbGUNCj4g
PiA+ID4gYi9kcml2ZXJzL3BlY2kvY29udHJvbGxlci9NYWtlZmlsZQ0KPiA+ID4gPiBpbmRleCAw
MjJjMjhlZjFiZjAuLmUyNDc0NDliYjQyMyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9w
ZWNpL2NvbnRyb2xsZXIvTWFrZWZpbGUNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wZWNpL2NvbnRy
b2xsZXIvTWFrZWZpbGUNCj4gPiA+ID4gQEAgLTEsMyArMSw0IEBADQo+ID4gPiA+IMKgwqAgIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ID4gPiA+IMKgwqAgDQo+ID4g
PiA+IMKgwqAgb2JqLSQoQ09ORklHX1BFQ0lfQVNQRUVEKcKgwqDCoMKgwqArPSBwZWNpLWFzcGVl
ZC5vDQo+ID4gPiA+ICtvYmotJChDT05GSUdfUEVDSV9OUENNKcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgKz0gcGVjaS1ucGNtLm8NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGVjaS9jb250cm9sbGVyL3BlY2ktbnBjbS5jDQo+ID4gPiA+IGIvZHJpdmVycy9wZWNpL2NvbnRy
b2xsZXIvcGVjaS1ucGNtLmMNCj4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4g
aW5kZXggMDAwMDAwMDAwMDAwLi4zNjQ3ZTM2MjhhMTcNCj4gPiA+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ID4gPiArKysgYi9kcml2ZXJzL3BlY2kvY29udHJvbGxlci9wZWNpLW5wY20uYw0KPiA+ID4g
PiBAQCAtMCwwICsxLDI5OCBAQA0KPiA+ID4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjANCj4gPiA+ID4gKy8vIENvcHlyaWdodCAoYykgMjAxOSBOdXZvdG9uIFRlY2hub2xv
Z3kgY29ycG9yYXRpb24uDQo+ID4gPiANCj4gPiA+IE5vIGRvdC9wZXJpb2QgYXQgdGhlIGVuZC4N
Cj4gPiA+IA0KPiA+ID4gW+KApl0NCj4gPiA+IA0KPiA+ID4gPiArc3RhdGljIGludCBucGNtX3Bl
Y2lfeGZlcihzdHJ1Y3QgcGVjaV9jb250cm9sbGVyICpjb250cm9sbGVyLCB1OCBhZGRyLA0KPiA+
ID4gPiBzdHJ1Y3QgcGVjaV9yZXF1ZXN0ICpyZXEpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoHN0cnVjdCBucGNtX3BlY2kgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoY29udHJv
bGxlci0NCj4gPiA+ID4gPmRldi5wYXJlbnQpOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqB1bnNp
Z25lZCBsb25nIHRpbWVvdXQgPSBtc2Vjc190b19qaWZmaWVzKHByaXYtPmNtZF90aW1lb3V0X21z
KTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IG1zZ19yZDsNCj4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgdTMyIGNtZF9zdHM7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGludCBp
LCByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgLyogQ2hlY2sgY29tbWFu
ZCBzdHMgYW5kIGJ1cyBpZGxlIHN0YXRlICovDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHJldCA9
IHJlZ21hcF9yZWFkX3BvbGxfdGltZW91dChwcml2LT5yZWdtYXAsIE5QQ01fUEVDSV9DVExfU1RT
LA0KPiA+ID4gPiBjbWRfc3RzLA0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIShjbWRfc3Rz
ICYNCj4gPiA+ID4gTlBDTV9QRUNJX0NUUkxfU1RBUlRfQlVTWSksDQo+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoA0KPiA+ID4gPiBOUENNX1BFQ0lfSURMRV9DSEVDS19JTlRFUlZBTF9VU0VDLA0K
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCj4gPiA+ID4gTlBDTV9QRUNJX0lETEVfQ0hFQ0tf
VElNRU9VVF9VU0VDKTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCkNCj4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7IC8qIC1FVElNRURPVVQg
Ki8NCj4gPiA+ID4gKw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBzcGluX2xvY2tfaXJxKCZwcml2
LT5sb2NrKTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmVpbml0X2NvbXBsZXRpb24oJnByaXYt
PnhmZXJfY29tcGxldGUpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHJlZ21h
cF93cml0ZShwcml2LT5yZWdtYXAsIE5QQ01fUEVDSV9BRERSLCBhZGRyKTsNCj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgcmVnbWFwX3dyaXRlKHByaXYtPnJlZ21hcCwgTlBDTV9QRUNJX1JEX0xFTkdU
SCwNCj4gPiA+ID4gTlBDTV9QRUNJX1dSX0xFTl9NQVNLICYgcmVxLT5yeC5sZW4pOw0KPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqByZWdtYXBfd3JpdGUocHJpdi0+cmVnbWFwLCBOUENNX1BFQ0lfV1Jf
TEVOR1RILA0KPiA+ID4gPiBOUENNX1BFQ0lfV1JfTEVOX01BU0sgJiByZXEtPnR4Lmxlbik7DQo+
ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJlcS0+dHgubGVuKSB7DQo+ID4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWdtYXBfd3JpdGUocHJpdi0+cmVn
bWFwLCBOUENNX1BFQ0lfQ01ELCByZXEtDQo+ID4gPiA+ID50eC5idWZbMF0pOw0KPiA+ID4gPiAr
DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwg
KHJlcS0+dHgubGVuIC0gMSk7IGkrKykNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWdtYXBfd3JpdGUocHJpdi0+cmVnbWFwLA0KPiA+ID4g
PiBOUENNX1BFQ0lfREFUX0lOT1VUKGkpLCByZXEtPnR4LmJ1ZltpICsgMV0pOw0KPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqB9DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyNpZiBJU19FTkFCTEVEKENPTkZJ
R19EWU5BTUlDX0RFQlVHKQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBkZXZfZGJnKHByaXYtPmRl
diwgImFkZHIgOiAlIzAyeCwgdHgubGVuIDogJSMwMngsIHJ4LmxlbiA6DQo+ID4gPiA+ICUjMDJ4
XG4iLA0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWRkciwgcmVxLT50
eC5sZW4sIHJlcS0+cngubGVuKTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgcHJpbnRfaGV4X2R1
bXBfYnl0ZXMoIlRYIDogIiwgRFVNUF9QUkVGSVhfTk9ORSwgcmVxLT50eC5idWYsDQo+ID4gPiA+
IHJlcS10eC5sZW4pOw0KPiA+ID4gPiArI2VuZGlmDQo+ID4gPiANCj4gPiA+IFRoZSBwcmVwcm9j
ZXNzb3IgZ3VhcmRzIGFyZSBub3QgbmVlZGVkLCBhcyBpdOKAmXMgdGFrZW4gY2FyZSBvZiBpbg0K
PiA+ID4gYGluY2x1ZGUvbGludXgvcHJpbnRrLmhgLiBBbHNvIGluIG90aGVyIHBhcnRzIG9mIHRo
ZSBwYXRjaC4NCj4gPiANCj4gPiBTaW5jZSB0aGlzIGlzIGR1bXBpbmcgdGhlIHJhdyBjb250ZW50
cyBvZiBQRUNJIG1lc3NhZ2VzLCBpdCdzIGdvaW5nIHRvIGJlDQo+ID4gcXVpdGUNCj4gPiB2ZXJi
b3NlLiBUaGUgaWRlYSBiZWhpbmQgcHJlcHJvY2Vzc29yIGd1YXJkIGlzIHRoYXQgd2UgZG9uJ3Qg
ZXZlciB3YW50IHRoaXMNCj4gPiB0bw0KPiA+IGJlIGNvbnZlcnRlZCB0byByZWd1bGFyIHByaW50
ay4gSWYgdGhlcmUncyBubyBkeW5hbWljIGRlYnVnIGF2YWlsYWJsZSAtIHRoaXMNCj4gPiB3b24n
dCBiZSBwcmludGVkIHVuY29uZGl0aW9uYWxseSAoZXZlbiB3aXRoIC1EREVCVUcpLg0KPiANCj4g
SG93IHdpbGwgaXQgYmUgY29udmVydGVkIHRvIGEgcmVndWxhciBwcmludGs/DQo+IA0KPiDCoMKg
wqDCoCAjaWYgZGVmaW5lZChDT05GSUdfRFlOQU1JQ19ERUJVRykgfHwgXA0KPiDCoMKgwqDCoMKg
wqDCoMKgIChkZWZpbmVkKENPTkZJR19EWU5BTUlDX0RFQlVHX0NPUkUpICYmIA0KPiBkZWZpbmVk
KERZTkFNSUNfREVCVUdfTU9EVUxFKSkNCj4gwqDCoMKgwqAgI2RlZmluZSBwcmludF9oZXhfZHVt
cF9kZWJ1ZyhwcmVmaXhfc3RyLCBwcmVmaXhfdHlwZSwgcm93c2l6ZSzCoMKgwqDCoMKgIFwNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBncm91cHNpemUsIGJ1ZiwgbGVuLCBhc2NpaSnCoMKgwqDCoMKgwqDCoCBcDQo+IMKgwqDCoMKg
wqDCoMKgwqAgZHluYW1pY19oZXhfZHVtcChwcmVmaXhfc3RyLCBwcmVmaXhfdHlwZSwgcm93c2l6
ZSzCoMKgwqDCoMKgIFwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZ3JvdXBzaXplLCBidWYsIGxlbiwgYXNjaWkpDQo+IMKgwqDCoMKgICNlbGlm
IGRlZmluZWQoREVCVUcpDQo+IMKgwqDCoMKgICNkZWZpbmUgcHJpbnRfaGV4X2R1bXBfZGVidWco
cHJlZml4X3N0ciwgcHJlZml4X3R5cGUsIHJvd3NpemUsIA0KPiDCoMKgwqDCoMKgwqDCoMKgIFwN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBncm91cHNpemUsIGJ1ZiwgbGVuLCBhc2NpaSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgXA0KPiDCoMKgwqDCoMKgwqDCoMKgIHByaW50X2hleF9kdW1wKEtFUk5fREVCVUcsIHBy
ZWZpeF9zdHIsIHByZWZpeF90eXBlLCByb3dzaXplLMKgwqDCoCBcDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ3JvdXBzaXplLCBidWYsIGxlbiwgYXNj
aWkpDQo+IMKgwqDCoMKgICNlbHNlDQo+IMKgwqDCoMKgIHN0YXRpYyBpbmxpbmUgdm9pZCBwcmlu
dF9oZXhfZHVtcF9kZWJ1Zyhjb25zdCBjaGFyICpwcmVmaXhfc3RyLCBpbnQgDQo+IHByZWZpeF90
eXBlLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgcm93c2l6ZSwgaW50IGdyb3Vwc2l6
ZSwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgdm9pZCAqYnVmLCBzaXplX3QgbGVu
LCANCj4gYm9vbCBhc2NpaSkNCj4gwqDCoMKgwqAgew0KPiDCoMKgwqDCoCB9DQo+IMKgwqDCoMKg
ICNlbmRpZg0KDQpMZXQncyBjb25zaWRlciAzIHNjZW5hcmlvcw0KMSkgRHluYW1pYyBkZWJ1ZyBp
cyBhdmFpbGFibGUNCjIpIER5bmFtaWMgZGVidWcgaXMgbm90IGF2YWlsYWJsZSwgYnV0IHdlJ3Jl
IGJ1aWx0IHdpdGggLURERUJVRw0KMykgRHluYW1pYyBkZWJ1ZyBpcyBub3QgYXZhaWxhYmxlLCB3
ZSdyZSBidWlsdCB3aXRob3V0IC1EREVCVUcNCg0KRm9yIDEpLCBwcmludF9oZXhfZHVtcF9kZWJ1
ZyBpcyBkeW5hbWljIC0gaXQgY2FuIGJlIGNvbnRyb2xsZWQNCihlbmFibGVkL2Rpc2FibGVkKSB1
c2luZyBkeW5hbWljIGRlYnVnIGtub2JzIChkZWJ1Z2ZzIC8gZHluZGJnIGtlcm5lbCBhcmcpLg0K
Rm9yIDIpLCBwcmludF9oZXhfZHVtcF9kZWJ1ZyBpcyB1c2luZyBwcmludF9oZXhfZHVtcCwgd2hp
Y2ggaXMganVzdCB1c2luZyBwcmludGsNCndpdGggS0VSTl9ERUJVRyBsZXZlbCB1bmRlciB0aGUg
aG9vZC4NCkZvciAzKSwgaXQncyBjb21waWxlZCBvdXQuDQoNCkFuZCBpdCdzIHNjZW5hcmlvIDIp
IHRoYXQgd2Ugd291bGQgbGlrZSB0byBhdm9pZCwgYXMgaGV4LWR1bXBpbmcgYWxsIFBFQ0kNCmNv
bW11bmljYXRpb24gaW50byBkbWVzZyBpcyBsaWtlbHkgZ29pbmcgdG8gbWFrZSBkbWVzZyBvdXRw
dXQgdW51c2FibGUgKGNhbg0Kb3ZlcmZsb3csIHByaW50aW5nIHRoYXQgdG8gdGVybWluYWwgaXMg
Z29pbmcgdG8gYmUgc2xvdywgZXRjKS4NCg0KVGhlIGR1bXAgY2FuIGJlIHVzZWZ1bCwgaXQncyBq
dXN0IHRoYXQgaW4gb3JkZXIgdG8gYmUgdXNlZnVsIGl0IG5lZWRzIHRoZQ0KZHluYW1pYyBkZWJ1
ZyBmYWNpbGl0aWVzIDopDQoNClRoYW5rcw0KLUl3b25hDQoNCj4gDQo+ID4gPiBb4oCmXQ0KPiA+
ID4gDQo+ID4gPiA+ICttb2R1bGVfcGxhdGZvcm1fZHJpdmVyKG5wY21fcGVjaV9kcml2ZXIpOw0K
PiA+ID4gPiArDQo+ID4gPiA+ICtNT0RVTEVfQVVUSE9SKCJUb21lciBNYWltb24gPHRvbWVyLm1h
aW1vbkBudXZvdG9uLmNvbT4iKTsNCj4gPiA+ID4gK01PRFVMRV9ERVNDUklQVElPTigiTlBDTSBQ
RUNJIGRyaXZlciIpOw0KPiA+ID4gPiArTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiA+ID4gPiAr
TU9EVUxFX0lNUE9SVF9OUyhQRUNJKTsNCj4gPiA+IA0KPiA+ID4gQWxzbyBhZGQgYW4gZW50cnkg
dG8gYE1BSU5UQUlORVJTYCwgaWYgVG9tZXIgaXMgZ29pbmcgdG8gYmUgdGhlDQo+ID4gPiBtYWlu
dGFpbmVyPw0KPiA+IA0KPiA+IEFsbCBvZiB0aGUgbmV3bHkgYWRkZWQgZmlsZXMgc2hvdWxkIGFs
cmVhZHkgYmUgY292ZXJlZCBieSBlaXRoZXIgQVJNL05VVk9UT04NCj4gPiBOUENNIEFSQ0hJVEVD
VFVSRSBvciBQRUNJIFNVQlNZU1RFTS4NCj4gDQo+IEdvb2QgdG8ga25vdy4gVGhhbmsgeW91Lg0K
PiANCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBhdWwNCg0K
