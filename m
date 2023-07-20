Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D8775A895
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGTIDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGTIDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:03:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF182111;
        Thu, 20 Jul 2023 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689840224; x=1721376224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fr/doYNt+7oHvLZkq0W8MgIu5AflwFcK3vaylG60Kkc=;
  b=mmFoIBXuLqwatXQp4m8nkpvAV1TD41e/Dn3If2H9I7dlBjifik9bLH1s
   rcLn7Mccboo0MUVnWybrGiiqz2HhOzcGTLQlG7QYZNAUJ42/PJbHP2yX2
   ihkKkKVfcEt1J2PJgk5lT9JZmRInwfZl7pRKve3ZK0hnvi7efoq2qinmO
   cVrev63xQvqL4vgFg60cj0nNDpgm5TI7rny/oXbYyETVA6tgoBTtj/4Xr
   EYCnaRVRzmD+a2WmDkrXE6nZySwrAj4bIjyooedHl4sqHRp11NziXcrwz
   I1GqMdzj8jL8S+Q/y2I/k8vULb88+VQWWNVF7yZ+XdMYhvWvBXSTtGe3i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="364124582"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="364124582"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 01:03:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="970953107"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="970953107"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jul 2023 01:03:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 01:03:32 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 01:03:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 01:03:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 01:03:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfdrWkzkdK1fHQi+Ncwm7v3COSOvO2M5KX8+ovsCOJ/PDulAdY8ruu1/7g7Di6lUr0OHYxyx5HkTl1XiDap9vq+QJ9vlk0/QnsvZnH3oFaAoLRxqQ75k8kBsTc0g4DsHFMsF7hQV+mGQ5VGdmKqn8qNNywjvHT0nnOQBL+43QHqQ+t8vsWJM6j99aAqWI56FV4GpUZdTgOxuHLlIftJiAfzRzGRjjqLWefB0LtVgSpQcHE+zbeFyU2x01Fs47iXCu6Hpo6K8vUGPrgYO3U81mpGoE4F77B4h8/x3J0eMNcaiDFxD1w6nLThTXCaxBmXgJWK4w9PUNtjz0czvcXV/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fr/doYNt+7oHvLZkq0W8MgIu5AflwFcK3vaylG60Kkc=;
 b=nRBCUFhBz82U4njJ3vkszwvlNr5GnWs3/l+tAn6YJv9QB1b089jxA0XmeQPESPSOxc4K3fgHT0GnoFbXgQEuTDlMTOLPQinRBOicJbhLdEvdKkk6eUR+/eS0ZV8v/++H9lUKDz/qKcn6wliCA52JtLYvwMdokFXKzL9IOoCl71hpXwVTxbZXhaGEUprIaxjcde0dFx8aTkXd325sNWDlx3YL8d2WIiYXMGMkZkWm637w/Etfs0RWPyKf4mZCbKvlq+wXynd1c1pkmmFDr88gL0Nmc1Pb38r6wJAicu7fpCB692bVgZRoSwsjTLWlBr1Ynxqj4YnI6rs5nf8mJiH+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by PH0PR11MB5927.namprd11.prod.outlook.com (2603:10b6:510:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 08:03:28 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::2f24:2dc9:60b:a244]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::2f24:2dc9:60b:a244%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 08:03:28 +0000
From:   "Winiarska, Iwona" <iwona.winiarska@intel.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "avifishman70@gmail.com" <avifishman70@gmail.com>,
        "Fair, Benjamin" <benjaminfair@google.com>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>,
        "yuenn@google.com" <yuenn@google.com>,
        "venture@google.com" <venture@google.com>,
        "warp5tw@gmail.com" <warp5tw@gmail.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: Add bindings for peci-npcm
Thread-Topic: [PATCH 1/4] dt-bindings: Add bindings for peci-npcm
Thread-Index: AQHZuo3AbGEw2WnzRUim2nq9di7rt6/CLwOAgAAdNAA=
Date:   Thu, 20 Jul 2023 08:03:28 +0000
Message-ID: <6ce71c01371aefa818375d6e07b3efb8e747c86a.camel@intel.com>
References: <20230719220853.1029316-1-iwona.winiarska@intel.com>
         <20230719220853.1029316-2-iwona.winiarska@intel.com>
         <69fa21b4-3197-d5f1-f300-d070cf5e7fda@linaro.org>
In-Reply-To: <69fa21b4-3197-d5f1-f300-d070cf5e7fda@linaro.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5823:EE_|PH0PR11MB5927:EE_
x-ms-office365-filtering-correlation-id: aa9ed94c-07dc-4f6d-03b0-08db88f7cd67
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d9cFNn9++/pGuVCDC4sg4oZwe5zAH8ovjRThwKIaaqM3/C5D/W4uNwwVOPXPTy72eRGg3H8WDNy/FKfcjtAU39X8z0ekzKDgGa7QeOGl/N4CNHUyXEsrDXhy+nN8/+hSXq+tVzajMzmJTXmD6AIbnwD59M9sk2IqoYfWBLFG/D5sn/6I8qWgYzX0XgPV/dJJPmMb3EWU/RVvkCX12qtnyGbJwY/UgvgWFIIEejGfSRn5PhK+DfeMbhqtWhJBH1X5JJka7AuM6NCoYRWf9fVCD7seMRnzcm/b9DDoOwToE7e+UI2ULjXIeyd2x3zQxcB8JG5hnZDUo7VsYBDkgVHXJ1nf2lKhbGOAd/VCjrVIV0bo890LL3ay4RBqGkoJ6WoaulQ+i9ZjCgsaQRuEMoFo+sjpvBjGz7vEccqzzKXUhWnZax5nYSagq0EuTJhdA7QaPJumJrqPNnd6GcxAKxZDwSWszMET5hZ1WX8MUsN+a0LoJGSnX7tW0lYWIhjpocbxFYkxsQmZs4umrwboU/w8cTKEBYfhO0qLfPqoYP/N5Eeig6khy/qDu33BqGzUIw9L5ospRYVeE7PN+ATOvjWizqQky5WvYxXZ4p7adeUw7YMknzWMh1R1J5uaEB2q6Ui3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(6486002)(6512007)(71200400001)(36756003)(186003)(2616005)(86362001)(38100700002)(38070700005)(53546011)(122000001)(82960400001)(6506007)(26005)(91956017)(8936002)(5660300002)(41300700001)(4744005)(316002)(8676002)(66556008)(4326008)(76116006)(66476007)(64756008)(66446008)(66946007)(7416002)(478600001)(54906003)(110136005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0h4anNvN0ZKZi83YmNwSTl3cWp1TVMrVWFLMlhVVWVSdUNuVmNoMFkrSWRU?=
 =?utf-8?B?ay9yM0JqQXBaeTdEMkVHdmlzcGFRZ01BaWVqNWlpT1N6YnNtcEFJMEp4TjhG?=
 =?utf-8?B?d3lNRGRkSWFhQWI5QnNDZDFZblNjOHlOeTJGSzRmVWpqeVN2TjhOR2VscFJ2?=
 =?utf-8?B?OFdiaHdRdEhoeGRFRE5wamYyc1AyQWlCZGtaYy9QL0xRTlVTeEl2U0VuWVkr?=
 =?utf-8?B?ZWQvbGFEOE9GcTFoUWRiUzBwOE9ZSTg0d3JkdTJhcVR1MVdKdDMwOVRtUXU4?=
 =?utf-8?B?MWgxUXJrakpuRjBKeVEvb2huOG02Mksxb3dWcGx4T0tJT1hSdnNZMTVDNWNY?=
 =?utf-8?B?SzZUbWw5bnZSU1JVUDFEbjk3ZmYxMXE3UGcrc1RITFR3Z0VMZEZaQzhYU2F0?=
 =?utf-8?B?S0I4RHA1ZjlpeThRNFM4T3M2U2ZXNWRLeTh0SEhUVjdWeEtPZ01Jd1V0WEdX?=
 =?utf-8?B?UHgyTDRBYXlJMjRXcW5ha2QrOG1ZNGk2djZpMmgyUTQ3R1Z5Q2JGTXczaGVm?=
 =?utf-8?B?QlJQMWZHZjNac1I1emtFU3BIUVlDZ0V4U3lTa21GTTh0S1pPcTE3N3czQTI0?=
 =?utf-8?B?MGVhaUtETFNiNkZ2OExzQ0dCUjRZeFBLamppc0RjSFlwdll1YjNyUDZ2Z1Mv?=
 =?utf-8?B?RnlpRHdvbk5qNDF3VHIxcDFGU3RVN1ZiWERXTmdieS90cmtWK3ZhaE5SZ3hr?=
 =?utf-8?B?ZCtlN0ZSNG1STUF3cEIwNXdPVExsMjA5ekQrRXVhRFY0WHZiRGVxeFZpVTJB?=
 =?utf-8?B?cDJ5NWlldEhQUkZtUFpmbmhZVlBQUG96U0NQeHV0THhkUGdwWUhpcGwwc2Qz?=
 =?utf-8?B?NEF5VjNMblkzalU4WFdMMXdlZnBpdkFjOHA5NUdqZEYrTG5SbVR3QUo2MlRh?=
 =?utf-8?B?MkpuQTd0alA3ZytTcDYvYjZHdFZtMnZ1cmo0WDJoZnlnbmdIV0R3d2g4SlYx?=
 =?utf-8?B?b3R5d0dJY0VOM0RseGt2SFlOdEJJRC9ubGNOT2FyTUNRbFRIWkR2dGcrZlNK?=
 =?utf-8?B?RE9UN0dyM1JGb1djV2FVejJCNk5NaUliQjJEaXJYZkhya1ZZMFBYejhHQThV?=
 =?utf-8?B?WDJKM0drWVJtNmlINmd3cVV1MFV6YVNvdDQ1bW1XcGw1M0VLcDI0ZTAvblFR?=
 =?utf-8?B?T09laHlocVd2OWV6SE9MemkrZGdVNHVXZUlIR0gwVE4xQ0x5NUk2VW5jU3JT?=
 =?utf-8?B?dlFBM2UzM2VZMlpydzdLb3NsUWljcENLSkcvTDR5d1VqNThxemVhWEJQZEph?=
 =?utf-8?B?TGpLMW5nazVmcm1SK1BtektUajYvYkJaNitqNkpXQmJCT2pUQXBHNmlpOWdn?=
 =?utf-8?B?ajJCT0cvdzdrN2RmR202R3VubUpRck5PYkJMOUJ4V1RWcG9oWWNkUE83NWF3?=
 =?utf-8?B?c2ZFaGtOcG9CcThhV1ZYazVvcnh4MFFsa0ZhUTdISUw1VGZIcmVINTBLdWJQ?=
 =?utf-8?B?SnFMMzIzdXR6Y2xSMkJlckl1UWJVTWtpeVNLMVc3WnRBV2FjU2NxMzQ2cTJ0?=
 =?utf-8?B?dGsyOGdXK0ZhY3V4WHRmeDJNSGJwd3RKUWwwOVEwb3ZoQ2JKKzU5bllON0dy?=
 =?utf-8?B?L2tnZVd1UXJSNEJ2c2hKa3V5Qko0aHZjeXBqd1owcGJyeWxmL1ZJOEZ4Y2Zw?=
 =?utf-8?B?aWlMYktTOTIyb2NCZ2xjZlN1VHdzVmVoZFdBbmt6Tkkzb1E0UGJvVzBjUFBu?=
 =?utf-8?B?TzgxclVRR2V3Z3R6OThRcGhxelI1WnZ5UFZwVmFnMjg5bzNIMDhLeURFUWV5?=
 =?utf-8?B?VUNscGpXekdUbmJUUmRnV1RmKytDUktDa083TDdlcng3UnlucXdhbHlaaGpK?=
 =?utf-8?B?SU9QVitML0pmMnI2c2htMjVUTTF5M2oyUk4vZHZVRDFiK0s1RXpvYmtxUTZX?=
 =?utf-8?B?MjBHMHNLb2VaT09BMUFpUWUxQ1kySy9iL01aU0Z2c3EwaEJCWTIvOThreDI5?=
 =?utf-8?B?NFFNYTBBdnZSR3cxaU9kRk1iek9DekxNU1hPVFhPZjJnOUR1VXA4TlltaE9X?=
 =?utf-8?B?TlFuN3pCQ1NCWDl1N2FrV2VvMnBxOGY1MWRGendQbkkwUzd3TE1iUjBqa1Rm?=
 =?utf-8?B?MjRaazFkTXJtM3REeTNrV3FTMkQvWTcxOUZZSVREOFlwNy83WVNOQi9jbXQ4?=
 =?utf-8?B?eDltRWZQYmZlWXpMT2p3N25pbGtlMithL2VyZnJqZkN6dXFlS3pTRFozeWJv?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A37E5A60C29E494C8BBFC793ED8F597A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9ed94c-07dc-4f6d-03b0-08db88f7cd67
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 08:03:28.7222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WegGgAROohG9zmvHTEFEEe/uC9pPdOmEnE1NrX/2aPV/wFizeADkZDxkuk5919MJazXXSErxvXIPBSAKQ/1SZQwQqVFz4b0biCOxoM4s5vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5927
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

T24gVGh1LCAyMDIzLTA3LTIwIGF0IDA4OjE4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAyMC8wNy8yMDIzIDAwOjA4LCBJd29uYSBXaW5pYXJza2Egd3JvdGU6DQo+ID4g
RnJvbTogVG9tZXIgTWFpbW9uIDx0bWFpbW9uNzdAZ21haWwuY29tPg0KPiA+IA0KPiA+IEFkZCBk
ZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgdGhlIHBlY2ktbnBjbSBjb250cm9sbGVyIGRyaXZlci4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUb21lciBNYWltb24gPHRtYWltb243N0BnbWFpbC5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVHlyb25lIFRpbmcgPHdhcnA1dHdAZ21haWwuY29tPg0K
PiA+IENvLWRldmVsb3BlZC1ieTogSXdvbmEgV2luaWFyc2thIDxpd29uYS53aW5pYXJza2FAaW50
ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEl3b25hIFdpbmlhcnNrYSA8aXdvbmEud2luaWFy
c2thQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gDQo+IE5vIGNoYW5nZXMgZnJvbSBwcmV2aW91cyB2
ZXJzaW9ucz8gTm90aGluZyBpbXByb3ZlZD8NCg0KVGhpcyBpcyB0aGUgZmlyc3Qgc3VibWlzc2lv
bi4NCg0KPiANCj4gPiDCoC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BlY2kvcGVjaS1ucGNtLnlh
bWzCoMKgIHwgNTYgKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDU2
IGluc2VydGlvbnMoKykNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGVjaS9wZWNpLW5wY20ueWFtbA0KPiANCj4gVXNlIGNvbXBhdGli
bGUgYXMgZmlsZW5hbWUuDQoNClN1cmUgLSB0aGVyZSBhcmUgdHdvIGNvbXBhdGlibGUgZW50cmll
cywgc28gSSdtIGdvaW5nIHRvIGNoYW5nZSBpdCB0bw0KbnV2b3RvbixucGNtLXBlY2kueWFtbA0K
DQpUaGFua3MNCi1Jd29uYQ0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiAN
Cg0K
