Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520987B2EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjI2JOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjI2JOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:14:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1621B6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695978843; x=1727514843;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=qtXf93Mdrn2sahcc4IRYxxL9rJjduRocHAKMQpTFM0A=;
  b=NLbNXOEZq83byA5G3NyZnqzqZXsVS6whPuH/ndSIB317dyVN8PBET4JY
   mAWTesmmwhQTUEaiJTzOJW0UTQfao7plo6ka9rdB78nwM507CgDr+yhZh
   rCk0cIYJKiLFSwJ/0/HeuSaE8j4i15ayEVfuibmIk6Jm0Cudh9Dk5V8+Z
   1kCuvL4ubjgUVVIOdt0a/bfcfO6cgoJP0YWouqQTXrl2tQvgsJg+8vM8R
   7Y0ewRPilCVYBwGFpOkfP44YcmUbybomj4kO7od7XPHvqYpfr+P/k4LVg
   dAqTELdPZVnHp4BBJ56JNlyWDur7bgyK8XE81xHUz/RnagwnPKk8mSFPn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="362509098"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="362509098"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 02:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="780709"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 02:13:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 02:14:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 02:14:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 02:14:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 02:14:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuI2t8VAohyUEjQUWvNeI/ZDDPf1r7OgUONEsylmUSfYau6213sWbpT3YRmjvdi4CGewIT6gtpMvZklvF9oBUUT+gL+7g0FwQgeQ/ShaKp0cqs3rqrZ34b9BY3RJ+ff9pUNmR8b9oKvuefzhLtplQoV8NPct3yhyQUBwi3EwWvdARYiSgqOY0803wWs18IPQZXTVWU9mFBOp6xWfsasAicyKNkd9GZL2a+sUa4YrscbPu6LRm4xfWgv0ttL5MHqojKeOxXJWxvnXnVZXvA84d86+XQ+KCdBUDZao/5tPBkLbDLThEMlnRzovsd5EoGUdqungYmYmmuDZZM1X4XQbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtXf93Mdrn2sahcc4IRYxxL9rJjduRocHAKMQpTFM0A=;
 b=NAA5N+EoZoq0/FmZpyU89L4fySkjkMRHdqAQB4fJGn0/QWwsWVXn+T34nagY1j8Veo4SKpaxrFrG6zWMIY/xGfdK9B66ougHAr/NOOcOW0cbLQGE3w046WCFvBzJ1F6/aECRyX1NOHXSMyfWMde1UtJ6S3Dv/Ehk2FBELQxqZl1L8LzD0AY8VuAzkdesWlfgOoThRO9AHa2tHAHFAut0YAn45g2HX5FQGuhqwddZGvWQMMWegI2e6+PHL89VHRdlZJfl/xwwOWBQqPBktePPx9TWI2fDvByBHm0Wd7OLTyWKa9OlmKnuecaHYbdGJnPDeiPqo3UStiYGj1q3CUbEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH8PR11MB8285.namprd11.prod.outlook.com (2603:10b6:510:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 09:14:00 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 09:14:00 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "mingo@kernel.org" <mingo@kernel.org>,
        "Li, Xin3" <xin3.li@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Compostella, Jeremy" <jeremy.compostella@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v3 1/2] x86/cpu/intel: Fix MTRR verification for TME
 enabled platforms
Thread-Topic: [PATCH v3 1/2] x86/cpu/intel: Fix MTRR verification for TME
 enabled platforms
Thread-Index: AQHZ8lt1lNiOeHZND0aep32XrBS2Q7AxhdQA
Date:   Fri, 29 Sep 2023 09:14:00 +0000
Message-ID: <00392c722e65c8d0da40384eecf8955be4875969.camel@intel.com>
References: <87a5t6ylpc.fsf@jcompost-mobl.amr.corp.intel.com>
In-Reply-To: <87a5t6ylpc.fsf@jcompost-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH8PR11MB8285:EE_
x-ms-office365-filtering-correlation-id: e33d9685-9eeb-4adf-52ce-08dbc0cc6ae8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASPyS0Inn21+NTJwkL+GCzWp6s9uo3/mdRuvbmdHoil+Se5uWNtEGQIXk7vjt3onCx1/oa+kpIdBnyk1OY0w8a9FqE7eyBPKy+F4vU84JddBJoNxgIaCAuriS9rM3tlxGElNVpcqgF8hOCMKrXDm2eWc2cm6IWAFvJBaTLF+nYYkky2I/hw4eKGDB14cBCDrCRmxXJC45OVmUNeEfc1Emb8+EphQ+6JRcZK5jOTYMqQWPlGQTA+QZY7b4Trt6Ykvbd/JkUVOuMaRjXfMPyYD/QExzRCpCokyb4XZChggdFxwXWlIH2wD5YstV4NUmxzn9jvI0D1FLuKvYfGRW2adi3OVYJmqXCb/l8SOIqJNIiS8rfEJfIBeGj49jH/c6WHtzxU5UlNa9GLCy4kajvxzFeTNACfAYUUMhPF++Gzz2+IRKFWoTNTCc1ZjC1TTa0IJjzso+kGiv8YQx6E4k5lqSMpb1u1gHzI0Gi/SUrlRQCM1Uxy3K6b377rRy2yt/95VTnI4cm2UNFvXGxqJIhzTPQFkMp090Ayqd3wBgX/JPQuXJjFesmukCQQBiHgLqi1QjXKw4BSt6LNtz8GKbe1/S02y7cFvMsBHbnrAphMMRDLNj9Jjv6eE932lDnBCNTGrCwgR70Mv+/jbSTMRwtQYow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(6506007)(2616005)(478600001)(6486002)(71200400001)(83380400001)(26005)(15650500001)(2906002)(5660300002)(66476007)(76116006)(91956017)(110136005)(66946007)(64756008)(66446008)(66556008)(316002)(8676002)(8936002)(41300700001)(36756003)(86362001)(38070700005)(38100700002)(122000001)(82960400001)(3714002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGxWa3haQVYzdzhraW5iR1lxaUVHRHd5dCtMVVVtTjBVd2ZKOWF3dHR1TmxO?=
 =?utf-8?B?ZUNFTUVBS0hoL0RFN0FLWGJKTXNFKzFvZjNIVUJ2M2ZXWnA1MUhvMkVlbUVX?=
 =?utf-8?B?Y1Y4SjJpNDVxem5VV2FzUGxnVS91emIvT2hLYlU5MnluVUU4dzhoUzJlbWIv?=
 =?utf-8?B?WGpDUVhwLyszRDFrc3Z3UEhQRzVNbGlGa1JSdzRNUjExSW4zUmloUVdxaU40?=
 =?utf-8?B?UjU5alIxdWVYUXpVd1ZjTmZScEUrSFJWYTFUclZBdm5yV0M4NzQvU0NaeGd0?=
 =?utf-8?B?MmxJYTdTeG9EVmJ1OFp4M0IvL0xBQlp5bG1sazF3VytjeXU2dmFqeXVCaWNP?=
 =?utf-8?B?ektMcC95QkZQczBhdGVlZnc3Nm52UWF2cS9OMTRCRFZkNEd1d05zUGNQc3g2?=
 =?utf-8?B?enNCVGZueFVqdFBZOWM1U25udzBnNi9UTVErZWI5VEV4cjcxcGxuL2tnbS9U?=
 =?utf-8?B?RXZIUWlvb0wrbTI0eDgwME0zblhJanJhNG44ckNJVHR1djBUYkdBdXNMQVZJ?=
 =?utf-8?B?VVc2alNHYklHSVFBU0RobEpTM0EvZmZObG51WFVyNnRORXNYMk9FOGtYMjNV?=
 =?utf-8?B?RlVPVEQvTjN3akRtbmhsLzF2ZnNZbjJYa2hGNWF3Vy9aL05XWHBFNE1vbk9n?=
 =?utf-8?B?VzZKMzdla096MFZHN01Qak1RdldIQ3F3RDV0NjhXMGYxOHlydnFzVVFWb0Vy?=
 =?utf-8?B?ZE4vcDVaVFAwU1dZaDhrWTJNZFpYa0J1YU9oUnRpSG16U1dEamgzVlZmcE1Y?=
 =?utf-8?B?d1RUak1Ha2kwRWlScGZ0TzBac3NQOTJ4K1lqU3BtQ2xvWGV5RHVjdTdvVnNu?=
 =?utf-8?B?NUlMV0d6QUZFaU03eUhpWmFMRDVvOTlpSFplK0VzczhxdWZwQWZHNmtSRVZ1?=
 =?utf-8?B?Z28wd0xPNTFrZ3Y0VTNlRklqNWdJWG4wdnIwLysvbkJHOTN3ZGFuOGRCRHZR?=
 =?utf-8?B?OG9EOEJFWnhkdWFIS1VNeGxxbkFYUDhkdmJOZUNvYnkvMVZyWmZubVhxV2lD?=
 =?utf-8?B?MDdPanM2WUhUQ1hkUGRCdkdLMWo5MHhnS08rZVczWWZld0piL1o0YW1BOXh5?=
 =?utf-8?B?aURaUVh2RTdvRGF4NWdjTjlFNWJ1d2xSaFRWOFpSeTFQb2dYRlFBSTR0dVpS?=
 =?utf-8?B?dldPWTd5WUIxaXV1eEdhMktXQndiemJCTVA1b2U4RDNmWndDVzlzZmxSWGli?=
 =?utf-8?B?T0psOUVSQlpqcXRlNDljS2haSEcvVld4SmgxSDZIUWZqK0tnOFdxNjY1Mitk?=
 =?utf-8?B?bU5zai9ZTmpwYmNJRHhiNmdTc1JSZjUyVUtNNnl3aE9McHQwM1R4eG9HUDFB?=
 =?utf-8?B?aWpZYkhKczEvTFAwRkZZbDVwNFNOR08xTTEyS29iSGFkdFN6VVpvU3dyd0Q0?=
 =?utf-8?B?dVF4ekZWSlYvakwyS0Vla0F6N3lxemFqRDNZaWdNRmdXYnYxVnNjdG9SR1hi?=
 =?utf-8?B?RElFTExEdENkU3pUNXRvazk5VVJleXZrUG1Nd09QRm9GaWxoSEhqVVhOYTVL?=
 =?utf-8?B?WlpvdlFuam1QYWVvNGhoRnlHRTk4S0tmSHVsT0N6NVp5UFdzczFOZWNkWUx0?=
 =?utf-8?B?VnVON3hLR2ZGSWx2QXFna3JoS3M2Rjd0MEdoYTNhVGxxZG1FM3dORm44cGFx?=
 =?utf-8?B?dmlQVnRJcjRjdk1sQlBQNkU5NnBpakZiZUVVMTRLUmZKd3RhZnBFS2lRS3BC?=
 =?utf-8?B?M0VCQ3JtMXZOT3dOZ05qN0hVUFJVWVcwZUlseDFmbExkVG40UkJyczJRMU1z?=
 =?utf-8?B?blNuaEdCaHRSUTdvRUh0dTdxWExwTDlOc2lQaGpvVlRLbzZsQkFUaUF1VHNX?=
 =?utf-8?B?N0txNzdtUjFSNHorcml1UVJZa3FvS0ZrdXRQU1JTK0wweG5tRE1KWmFCZTdS?=
 =?utf-8?B?cWVOSXh1aEtXNWxYWUVocE5XSXkwcVMwNkhXRmhEeHdZY29BTkZsTHpTTFJL?=
 =?utf-8?B?UTRJcEVkQnFVSDBRYWFTUnQzenNCMkQxc09Vekx4alBHMGpkR2ZKVnV2aGcx?=
 =?utf-8?B?dzlORjZ5dUZpQ25rQy84OE15TDVhdnA1MnE1WklNTmZhR3VtWXp0VFljN1BC?=
 =?utf-8?B?RFdQVnNNSWVMRzFmNXB6cFBRR2cvY2ZESURPeE1zd1pmWXNCeXRWRW52Q2RO?=
 =?utf-8?B?M24wdUlmWVNqTXowZFFnTHptaU9meWw5QWdsZHltb3FXUmp0ZFM2ZElVQUsr?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDCFEFB6BA6B914ABE3018FA156470C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33d9685-9eeb-4adf-52ce-08dbc0cc6ae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 09:14:00.2471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gNHw/YmRK6xU5LpsKvjqs0ycDC7hBkaf81iPNlU3G3TEe84JR2iJ0/YRtSrlSSysgkKC59KFHl8xquwb7ifIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8285
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTI4IGF0IDE1OjMwIC0wNzAwLCBDb21wb3N0ZWxsYSwgSmVyZW15IHdy
b3RlOg0KPiBPbiBUTUUgZW5hYmxlZCBwbGF0Zm9ybSwgQklPUyBwdWJsaXNoZXMgTVRSUiB0YWtp
bmcgaW50byBhY2NvdW50IFRvdGFsDQo+IE1lbW9yeSBFbmNyeXB0aW9uIChUTUUpIHJlc2VydmVk
IGJpdHMuDQo+IA0KPiBnZW5lcmljX2dldF9tdHJyKCkgcGVyZm9ybXMgYSBzYW5pdHkgY2hlY2sg
b2YgdGhlIE1UUlJzIHJlbHlpbmcgb24gdGhlDQo+IGBwaHlzX2hpX3JzdmQnIHZhcmlhYmxlIHdo
aWNoIGlzIHNldCB1c2luZyB0aGUgY3B1aW5mb194ODYgc3RydWN0dXJlDQo+IGB4ODZfcGh5c19i
aXRzJyBmaWVsZC4gIEJ1dCBhdCB0aGUgdGltZSB0aGUgZ2VuZXJpY19nZXRfbXRycigpDQo+IGZ1
bmN0aW9uIGlzIHJhbiB0aGUgYHg4Nl9waHlzX2JpdHMnIGhhcyBub3QgYmVlbiB1cGRhdGVkIGJ5
DQo+IGRldGVjdF90bWUoKSB3aGVuIFRNRSBpcyBlbmFibGVkLg0KPiANCj4gU2luY2UgdGhlIHg4
Nl9waHlzX2JpdHMgZG9lcyBub3QgcmVmbGVjdCB5ZXQgdGhlIHJlYWwgbWF4aW1hbCBwaHlzaWNh
bA0KPiBhZGRyZXNzIHNpemUgeWV0IGdlbmVyaWNfZ2V0X210cnIoKSBjb21wbGFpbnMgYnkgbG9n
Z2luZyB0aGUgZm9sbG93aW5nDQo+IG1lc3NhZ2VzLg0KPiANCj4gICAgIG10cnI6IHlvdXIgQklP
UyBoYXMgY29uZmlndXJlZCBhbiBpbmNvcnJlY3QgbWFzaywgZml4aW5nIGl0Lg0KPiAgICAgbXRy
cjogeW91ciBCSU9TIGhhcyBjb25maWd1cmVkIGFuIGluY29ycmVjdCBtYXNrLCBmaXhpbmcgaXQu
DQo+ICAgICBbLi4uXQ0KPiANCj4gSW4gc3VjaCBhIHNpdHVhdGlvbiwgZ2VuZXJpY19nZXRfbXRy
cigpIHJldHVybnMgYW4gaW5jb3JyZWN0IHNpemUgYnV0DQo+IG5vIHNpZGUgZWZmZWN0IHdlcmUg
b2JzZXJ2ZWQgZHVyaW5nIG91ciB0ZXN0aW5nLg0KPiANCj4gRm9yIGB4ODZfcGh5c19iaXRzJyB0
byBiZSB1cGRhdGVkIGJlZm9yZSBnZW5lcmljX2dldF9tdHJyKCkgcnVucywNCj4gbW92ZSB0aGUg
ZGV0ZWN0X3RtZSgpIGNhbGwgZnJvbSBpbml0X2ludGVsKCkgdG8gZWFybHlfaW5pdF9pbnRlbCgp
Lg0KDQpIaSwNCg0KVGhpcyBtb3ZlIGxvb2tzIGdvb2QgdG8gbWUsIGJ1dCArS2lyaWxsIHdobyBp
cyB0aGUgYXV0aG9yIG9mIGRldGVjdF90bWUoKSBmb3INCmZ1cnRoZXIgY29tbWVudHMuDQoNCkFs
c28gSSBhbSBub3Qgc3VyZSB3aGV0aGVyIGl0J3Mgd29ydGggdG8gY29uc2lkZXIgdG8gbW92ZSB0
aGlzIHRvDQpnZXRfY3B1X2FkZHJlc3Nfc2l6ZXMoKSwgd2hpY2ggY2FsY3VsYXRlcyB0aGUgdmly
dHVhbC9waHlzaWNhbCBhZGRyZXNzIHNpemVzLiANClRodXMgaXQgc2VlbXMgYW55dGhpbmcgdGhh
dCBjYW4gaW1wYWN0IHBoeXNpY2FsIGFkZHJlc3Mgc2l6ZSBjb3VsZCBiZSBwdXQgdGhlcmUuDQoN
ClBlcmhhcHMgY2FuIGJlIGRvbmUgaW4gdGhlIGZ1dHVyZSBpZiBldmVyIG5lZWRlZC4NCg0KPiAN
Cj4gQ2hhbmdlIGZvciB2MzoNCj4gVGFrZSByZXZpZXcgY29tbWl0IG1lc3NhZ2UgY29tbWVudHMg
aW50byBhY2NvdW50Lg0KPiANCj4gQ2hhbmdlIGZvciB2MjoNCj4gQWRkIGEgY29tbWVudCBpbiB0
aGUgY29kZSBleHBsYWluaW5nIHdoeSBkZXRlY3RfdG1lKCkgbmVlZHMgdG8gY2FsbGVkDQo+IGlu
IGVhcmx5X2luaXRfaW50ZWwoKS4NCg0KWW91IGNhbiBwdXQgdmVyc2lvbiBoaXN0b3J5IHRvIA0K
DQoJPFlvdXIgU29CPg0KCS0tLQ0KCXZlcnNpb24gaGlzdG9yeQ0KCS0tLQ0KCS4uLg0KDQp0aGVu
IGl0IHdpbGwgYmUgc3RyaXBwZWQgYXdheSB3aGVuIHRoZSBwYXRjaCBpcyBhcHBsaWVkLg0KDQpB
bHNvLCBmb3IgcmVsYXRlZCBtdWx0aXBsZSBwYXRjaGVzIHBsZWFzZSB1c2UgLS1jb3Zlci1sZXR0
ZXIgLS10aHJlYWQgdG8gbWFrZSBpdA0KYSBzZXJpZXMuICBZb3UgY2FuIGFsc28gdXNlIC0tYmFz
ZT1hdXRvIHRvIGluY2x1ZGUgdGhlIGJhc2UgY29tbWl0IGlkIHRvIHRoZQ0KcGF0Y2guDQoNCg==
