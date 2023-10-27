Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB3D7D92DB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345617AbjJ0I5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345544AbjJ0I5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:57:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FD0BD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698397023; x=1729933023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l471cKL8rrQyCfVVpvn1U+mlD7Xp2DqI+onyc6XXLVo=;
  b=ToRJdCQmdalqpmJy+2jydrVQmM8A0SO64MCKFBXnOXFKf6ZaIEg+qPBj
   ZI3CvuQJMDx/fsk7DjBz3ZzlxuGKvGoQy/tVGPQkN40B3Vlw3F0D0f7rk
   UOPFdwkWxPgsgEnYNBEOU75mbYXyyNA5H7mloMfKfUwGtQ+QoPkhXMpTH
   wTpe1bKbwMUSlXxsqiFd/8aJEEKNSG21kIvZIgA6KmymgTzY7ZigBl6pO
   n6jLNx2GPe2rYwCwC3o1Io9DeG7fJ4gtyJXflM8TBmkysBS/ynPs0oY+O
   PjSeBOZELMFnNeFHzrLIRoX8cnDDQpxAjL/cGG7Nvk8uK7HEftYwTu74A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="473978594"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="473978594"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 01:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="736027104"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="736027104"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 01:57:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 01:57:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 01:57:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 01:57:02 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 01:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1Iw/hfUAJWhYvWKJNGxIIoqGl1oCLEwP6EBdi+TlR5pFKs4z+xnM8XOGbuJ5WFz+RQOQaJsmD3ewTvk9bHOnNFCxB0fSAyulm8a6V8ZkfRkuuHwIdOog23DNyTs63wB9XT+yfM0Bjp7i4qCaNz+Y0sbx5R7w8QvxlQVQPlWWS52/jEKKMuPWPOU6x7YMaRpyyu4cVjq0MKiwKz62Rxhn5JeUFFlCNIV8TG6jU3MUhVqHKJpNrq6uwudRJire0PGU6ETEMkqr0BPIXGuSdt6Ds8Ao4DArqO/5kPEMedzhsx+rMDrjCs9EBV7rRfAJxMN9wNX/84ymkSzMJ60SabucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l471cKL8rrQyCfVVpvn1U+mlD7Xp2DqI+onyc6XXLVo=;
 b=jl1BKR6Cn0TX1+AHlwniD8aHfzvX26iFVnKmnxMCYY9Ox+FfJe5UzIA20kQusLeMrD1dMhAEfHDMcyqOm30WHIsEpYRuA4CFLT6PqNpz1LjZGPW9sNa9HfAEZ0EWuH8GIs1tvw+rFgCX5BLBJ91Y2uRqTsBCPYixGvgKS2/PEo8XOQY76Bnv1OSRuCKkd3NkwuwgsY75j5pons0m5wCOkrBVXp77l8CvNOWRDIlTcaGzGGziREc1fmQDxCaHfC8YEEpMseG979DdBGjQk1kfutpybaK12vZ6rGc2GHJAjfHMgLl7H7m7NRQ066HAuz0U7JrmoOA3HluNj5qRXNkbUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 08:56:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::9704:bf7c:b79f:9981]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::9704:bf7c:b79f:9981%6]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 08:56:54 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Sun, Yi" <yi.sun@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Yan, Dongcheng" <dongcheng.yan@intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.sun@linux.intel.com" <yi.sun@linux.intel.com>,
        "Su, Heng" <heng.su@intel.com>
Subject: Re: [PATCH v7] x86/tdx: Dump TDX Version During TD Bootup
Thread-Topic: [PATCH v7] x86/tdx: Dump TDX Version During TD Bootup
Thread-Index: AQHaCJGalPRi0ssdWEeUTep3S36MoLBdVeeA
Date:   Fri, 27 Oct 2023 08:56:54 +0000
Message-ID: <03ceb0cf8f0fd5e7f4e9dba996da09a02305a04b.camel@intel.com>
References: <20231027045234.1371846-1-yi.sun@intel.com>
In-Reply-To: <20231027045234.1371846-1-yi.sun@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5247:EE_
x-ms-office365-filtering-correlation-id: 7f90a769-3e79-47cb-57ca-08dbd6caaaf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMWkw71SYnS4uHCmm/bemfmmfBepd4mW1Xfnb9qkHwkme2tUMDWQLP2F/YDK/vv9zqzpA4/oRX71L66ChowgMHEc5BjYu1qYhDVkTIMnKN704Eqxk3S6qF3TxvqRwV7wA52z3vvHHqLbn/jE0k7zGDI9e/fv44zbqrSZipg+W6NM9q8PdM/utJZKk9eN1Q08NkAteO+eoIJBlEY7kDYyiaCQjFt7qC6Vds2nhEfsSjjOMQAdUwMqq3iynFIzT4LDUGcZrPYLzZ4luz1XF2KeX57uPQW7qLWBi95cJlCSHVOTVqYYaJVq4nnDL206CYHn/ti+A1Rui7dAtRYSs/R+9ABPE80Af2PAkJW6up93eOyOD2nZ7c2LTwc6kKeBNN5A46C8iDs4fiC0KDLuVKJ0sxdOfw4rk2t7eFlcrKVj1RxlPaHSeKEXE+vbc9lKWhvGs1UtXTluVBn5YXrdkz2Dnmr+6dozXor86CfFIvKMUV2m3cyio1PRe3f8VdZrY7Pswjv6BN8I0tl3ogO21sLdwT/54YtZ+SlDwlT6FC+wQI70bE5t6nqfLtuS7S3/jhJ39l/QLCy9jxVB312R9DdG1CoxhHCwuEAmahogaD3dj2G/1GnpGP7Q4Nnevv/qoP8T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66556008)(66476007)(71200400001)(478600001)(6486002)(6512007)(6506007)(38100700002)(86362001)(5660300002)(122000001)(82960400001)(36756003)(2906002)(7416002)(41300700001)(66446008)(66946007)(64756008)(76116006)(83380400001)(26005)(2616005)(316002)(38070700009)(54906003)(91956017)(8676002)(110136005)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qkg3V1c3cDgzZklnTGcwQjlTVmpkRXFTMDdsSkRRSGdmbXIyU0R4WUptS2lF?=
 =?utf-8?B?M09zR2lObW9OOHBvT0IyNWtFVFk0V1drVS9UdngwUGxGdGJLS1VhZ1Y0K2R1?=
 =?utf-8?B?bWdJbThWNUxKUUQ3eUFPSXFQZ2xaRmRuOVFKSDBnMENoY0ttakc3QXFxWTUz?=
 =?utf-8?B?RnFnclBWQlJBNUI0bWFUTDBtOXp2ZDRXU0hMSlFPbTFNM1RUcHF1K2NBNUQz?=
 =?utf-8?B?eVBxY0NqeWZlV1BCYlJlSWFxWDFkMXpjTFh6Y3gvRlM0dkVFZ0JYRnc3Tlgv?=
 =?utf-8?B?cWROYnJEc3gybmlYWlJIdUNzSFAzdkVFR0UwUE94R0VvQlA1MCtQK0pwTVF4?=
 =?utf-8?B?bXdrakJPcWR5a29ZTmo1RHNrR1c5YmN2clEyS09Tay9KQWRUbjVSUUwrL1JJ?=
 =?utf-8?B?cDUrWWVaZ0xwaGlvVUthVWlMZ3o5NFJ1WFNzYlhyeU1QaFVBd2JkOFgzNXQ2?=
 =?utf-8?B?ajMxekt3bGpqNVc5VkVhVlpPWGpYWnphb04rOFF0UGJZSWhWdjlCWW5tT2kx?=
 =?utf-8?B?VDl5RHUxN1VWYTl0K3Z2ak4zeU5paFBXWVRXWkZIREI4Sm1Hd0t3MGhUcHFF?=
 =?utf-8?B?RFlTWDErVUVaKys2K2daS1IrQTBFZFh6aE9iWlhQK1h2WmlCQW1Oc1ZrMmVG?=
 =?utf-8?B?SkM1Z3U2RTVtYlY4b05wR293V2FXaStBdlZlYUJZUXhETTI2dlVRR1JZUGdT?=
 =?utf-8?B?azlmNkRWS0tmWHZmRk5nRk1tR0JjQzF6eHo5SVl5WEtRT1NwczZPUHp2bmtD?=
 =?utf-8?B?ekw2UVNXMC9MMzBjUzI2S0tPY1YzYmlQRkJodkVXMGMvamtsZWZhVm1VT3lQ?=
 =?utf-8?B?dVBzMUs5N3l1cTc1R1E0YThaQnZ3SmlON0pRdEJ3VGoxOUtZWHVpN0QrZ0Fu?=
 =?utf-8?B?YmJjaVVidE1neDNZZUVTSXhGenB3d3RxQXJveGJuZ2NLNlRwNjBoamR5dEZw?=
 =?utf-8?B?SVQvelJMYWpoQ3F2RzFSeUUrSzV4VzIvUWhSZUNrbi9zREhSSjNLUkhSOTB0?=
 =?utf-8?B?b2FTazFndGlocWpkeWNqbHdFT3JyTHZPdEx5L0tkSzM1OEthVnM2Z3kwVXN0?=
 =?utf-8?B?Yk5Fb3V3VUttOTZuNnBobDJQWmNNaXZ1c0dVU0RHN2h5ME9mRXZRSllkSlBX?=
 =?utf-8?B?MjIweWozNWMvbS8vUEx6bExqSkRnK091WHFOcWtZcGlNS2RZcHhYUFRMMzln?=
 =?utf-8?B?M0p3aHpoWHpwRjBwbkJMK0poUW9YKzZkQkVSRlRVUkt2N2ZPRkYxSnphYzhT?=
 =?utf-8?B?bjhhMWxsN3E2NytNVEpTaEd4UzBXQVdVUEVwd3BoTTBFOVdxc2J4ZTBHT1dI?=
 =?utf-8?B?UGs1ZTI2SlRUbkYyV3ZCN2tNRUtWWFNRVWQxQk9iSlFKRzRBeXBNTEtRcXBG?=
 =?utf-8?B?eXplV3NTVkpwcDFTNFVRcElrTzZEVU1TSjRCNFlOMmZaMlRhWEdzRmZieU5r?=
 =?utf-8?B?V241R0lsWGYxY1daMlBaVnBNOVlDTDU2eUdFM010L2VhSmlZbm5IMEVzMlRC?=
 =?utf-8?B?OTYxbXhDMDhxMG93bDZoTU94L2svVVZ6Y0ljZkR0U1Z2c1gzaHBBVkw0bW1J?=
 =?utf-8?B?TTBXQmpBWTVGaG1IY0FSZGxBODZETjlidUlsM3MyTXljd0I5cW9mc3dCWkZj?=
 =?utf-8?B?T1JJNmN0QVpHTHZLT2lxcFpzRXlCMjFVVWxGeGI4UlQzWTVvSHR1NGVNTUVs?=
 =?utf-8?B?dklLdHFOWVBXRzhxMjdvSTVxY25vdkJsNmZYcFdQdXc1TnFyL0lUanFPNVZ0?=
 =?utf-8?B?ZWFUY0dMUTBDOFpCM1pLVlV0L1ZMdkdxWkJoSSs4TE9BRWpGcmQrMGtUSTVv?=
 =?utf-8?B?bFJhb1NaV0VPajIrL1VPRUNNRi9scSt4RVFPQWtscmVlTHNDcEd4bHpNSHV6?=
 =?utf-8?B?cUpOTlI0bFZhNjh1T0VTTGxDWDFCM1hwdnZlWXR5WlhsNm9xRGVKUmYzRWh1?=
 =?utf-8?B?QzVwM1BnaVFiSm1CN3hOUXp1YWkwSmRoQ1ZIR1ZnRCtHcnA5eUNuVTRVclJa?=
 =?utf-8?B?ZWZndWJGYlRpSzRjOFBQK0NYWEo5d3dkT2JPYzJhaURrZ2ZaRnhIdnVoV1Iv?=
 =?utf-8?B?ZzZXSCtaS014UHNiNFVaenN2dnhFSUN3bXI2S041d1BJa3dRaVlyZTlYeW5V?=
 =?utf-8?B?eHNEOSttVVBUN1dUc2s2aWZ2YUpDSFdmMEZ4TVZoNStLVDFhTFcyR1lnUGNL?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38B0902FE733EF4195265FA4CCAF868C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f90a769-3e79-47cb-57ca-08dbd6caaaf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 08:56:54.2588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGv6oVywrx8bmAKoWcv89DbJeQBJPlSuOT/CKFuAUA4Jx9hPi8Dmoa47xfge9lzI8Ls6x67M2AxPNebQ8caBuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5247
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ICsvKg0KPiArICogRGV0ZWN0IFREWCBNb2R1bGUgdmVyc2lvbiBpbmZvIGZyb20gVERHLlNZ
Uy5SRCBURENBTEwNCj4gKyAqLw0KPiArc3RhdGljIHZvaWQgZGV0ZWN0X3RkeF92ZXJzaW9uKHZv
aWQpDQo+ICt7DQo+ICsJc3RydWN0IHRkeF9tb2R1bGVfYXJncyBhcmdzID0ge307DQo+ICsJdTE2
IG1ham9yX3ZlcnNpb24sIG1pbm9yX3ZlcnNpb247DQo+ICsJdTMyIHZlbmRvcl9pZDsNCj4gKwl1
NjQgcmV0Ow0KPiArDQo+ICsJYXJncy5yZHggPSBURFhfU1lTX1ZFTkRPUl9JRF9GSUQ7DQo+ICsJ
cmV0ID0gX190ZGNhbGxfcmV0KFRER19TWVNfUkQsICZhcmdzKTsNCj4gKwlpZiAocmV0KQ0KPiAr
CQlnb3RvIGVycl9vdXQ7DQoNCkkgYW0gbm90IHN1cmUgd2UgbmVlZCB0byBkZXRlY3QgdmVuZG9y
IElEPyAgSSBiZWxpZXZlIFREWCBtdXN0IGJlIGZyb20gSW50ZWw/DQoNCkFsc28sIEkgdGhpbmsg
ZWl0aGVyICJlcnIiIG9yICJvdXQiIGlzIHN1ZmZpY2llbnQ/DQoNCj4gKw0KPiArCXZlbmRvcl9p
ZCA9IGFyZ3Mucjg7DQo+ICsNCj4gKwltZW1zZXQoJmFyZ3MsIDAsIHNpemVvZihhcmdzKSk7DQo+
ICsJYXJncy5yZHggPSBURFhfU1lTX01BSk9SX0ZJRDsNCj4gKwlyZXQgPSBfX3RkY2FsbF9yZXQo
VERHX1NZU19SRCwgJmFyZ3MpOw0KPiArCWlmIChyZXQpDQo+ICsJCWdvdG8gZXJyX291dDsNCj4g
Kw0KPiArCW1ham9yX3ZlcnNpb24gPSBhcmdzLnI4Ow0KPiArDQo+ICsJbWVtc2V0KCZhcmdzLCAw
LCBzaXplb2YoYXJncykpOw0KPiArCWFyZ3MucmR4ID0gVERYX1NZU19NSU5PUl9GSUQ7DQo+ICsJ
cmV0ID0gX190ZGNhbGxfcmV0KFRER19TWVNfUkQsICZhcmdzKTsNCj4gKwlpZiAocmV0KQ0KPiAr
CQlnb3RvIGVycl9vdXQ7DQo+ICsNCj4gKwltaW5vcl92ZXJzaW9uID0gYXJncy5yODsNCj4gKw0K
PiArCXByX2luZm8oIkd1ZXN0IGRldGVjdGVkLiB2ZXJzaW9uOiV1LiV1IFZlbmRvcklEOiV4XG4i
LA0KPiArCQltYWpvcl92ZXJzaW9uLCBtaW5vcl92ZXJzaW9uLCB2ZW5kb3JfaWQpOw0KPiArDQo+
ICsJcmV0dXJuOw0KPiArDQo+ICtlcnJfb3V0Og0KPiArCWlmIChURENBTExfUkVUVVJOX0NPREUo
cmV0KSA9PSBURENBTExfSU5WQUxJRF9PUEVSQU5EKQ0KPiArCQlwcl9pbmZvKCJUREcuU1lTLlJE
IG5vdCBhdmFpbGFibGVcbiIpOw0KPiArCWVsc2UNCj4gKwkJcHJfaW5mbygiVERHLlNZUy5SRCB1
bmtub3duIGVycm9yICglbGx1KSwgcmVhZGluZyBmaWVsZCAlbGx1XG4iLA0KPiArCQkJcmV0LCBh
cmdzLnJkeCk7DQo+ICsNCj4gKwlwcl9pbmZvKCJBc3N1bWluZyBURFggdmVyc2lvbjoxLnggKHg8
NSkgVmVuZG9ySUQ6JXhcbiIsDQo+ICsJCVREWF9WRU5ET1JfSU5URUwpOw0KDQpZb3UgcmVtb3Zl
ZCAiR3Vlc3QgZGV0ZWN0ZWQiIGluIHRkeF9lYXJseV9pbml0KCksIGJ1dCBkaWRuJ3QgYWRkIGl0
IGhlcmUsIHNvDQp1bmZvcnR1bmF0ZWx5IHRoZSAiR3Vlc3QgZGV0ZWN0ZWQiIHdpbGwgZ2V0IGxv
c3QgaGVyZS4NCg0KQWxzbywgSSBzdXBwb3NlIGZvciB0aGUgY2FzZSBUREcuU1lTLlJEIGlzbid0
IHN1cHBvcnRlZCB0aGVyZSdzIHN0aWxsIHNvbWUgdmFsdWUNCnRvIHByaW50ICJBc3N1bWUgbW9k
dWxlIHZlcnNpb246IDEueCAoeDw1KSIsIGJ1dCB3aGVuIFRERy5TWVMuUkQgZmFpbGVkDQp1bmV4
cGVjdGVkbHkgSSBkb24ndCB0aGluayB3ZSBjYW4gbWFrZSB0aGF0IGFzc3VtcHRpb24sIGFuZCBw
cmludGluZyAiYXNzdW1pbmcNCi4uLiIgY291bGQgZ2l2ZSB1c2VyIG1pc2luZm9ybWF0aW9uIHdo
aWNoIGlzIHdvcnNlIHRoYW4gbm90IHByaW50aW5nIElNSE8uDQoNClNvLCBJIHRoaW5rIHlvdSBj
YW4ga2VlcCB0aGUgcHJpbnRpbmcgb2YgIkd1ZXN0IGRldGVjdGVkIiBpbiB0ZHhfZWFybHlfaW5p
dCgpLA0KYW5kIHNvbWVob3cgcmVmaW5lIHRoZSBjb2RlIHRvIHByaW50IHNvbWV0aGluZyBsaWtl
IGJlbG93Og0KDQpGb3IgbW9kdWxlIHRoYXQgZG9lcyBUREcuU1lTLlJEIHN1Y2Nlc3NmdWxseToN
Cg0KICB0ZHg6IEd1ZXN0IGRldGVjdGVkDQogIHRkeDogTW9kdWxlIHZlcnNpb246ICV1LiV1DQoN
CkZvciBtb2R1bGUgdGhhdCBkb2Vzbid0IHN1cHBvcnQgVERHLlNZUy5SRDoNCg0KICB0ZHg6IEd1
ZXN0IGRldGVjdGVkDQogIHRkeDogRmFpbGVkIHRvIGdldCBtb2R1bGUgdmVyc2lvbjogVERHLlNZ
Uy5SRCB1bnN1cHBvcnRlZC4gQXNzdW1lIG1vZHVsZQ0KdmVyc2lvbjogMS54ICh4IDwgNSkuDQoN
CkZvciBtb2R1bGUgdGhhdCBUREcuU1lTLlJEIGZhaWxlZCB1bmV4cGVjdGVkbHk6DQoNCiAgdGR4
OiBHdWVzdCBkZXRlY3RlZA0KICB0ZHg6IEZhaWxlZCB0byBnZXQgbW9kdWxlIHZlcnNpb246IFRE
Ry5TWVMuUkQgZmFpbGVkIHRvIHJlYWQgMHglbGx1OiAweCVsbHUgIA0K
