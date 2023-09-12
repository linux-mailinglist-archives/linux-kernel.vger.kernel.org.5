Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B2679DCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjILXZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjILXZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:25:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C3D10FE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694561120; x=1726097120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U7bTlZexKlpr6ShHuMpgqNEdM0/TSs0OkpTThTMTIO4=;
  b=e6vL1n81gL8dgeEtWHj4OkYbUEguNJcGg2TTSbxv22BzORgnYe10ouT5
   K+ihCPddjH+35VbvgnVAGy3NqzkgtL19Y0T8B5wU4kzz1wli7EI5OfCMy
   gD2kToGNqBeQSJJ1ifH3skCZjRoQnrNqH9+wRxezs1mEfZ09yZyZJspkp
   ZrHk8wwlk2gM/w1PB0O8liq/BJx3mfnVbWxBy59yOTY3bo0RjaCHOIDCb
   RC6TbL17DLlIn9A25Y1ZhyJYW+Jh339WCv+CrxaZrgpSFSLHNc3M2XwpK
   Xmf9BjAiVu/fnG9CCR0PCpMh3oidAjMdDgO8YMzUKcFG5ogK/5tXvcg1n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464889837"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="464889837"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 16:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="887126910"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="887126910"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 16:24:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 16:25:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 16:25:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 16:25:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 16:25:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmdMi5SrgFU1MLEJbmGm9fUpzj3EzGHkvxOzhQkZZYICMEObEdVUG8vxtRX7I3fcoaz7Io/ADltwk0w1i/xjLgpSjhgg3uvaDOPQVUApmqapq/U49Sr01dW+OS8VKiKDLWrEQJzg6ZPNvlQ6PKQ8IqMdQSct+Uxgs7I+q5DW2Jit3R2Q8r60RVlmJc8aJ5ozvH+LC4oVj4Z41hT/FKJlLkSEEkaiACh5UcJIJaDCm1Tbzngzf/nclXhXY43t6UWemBBcRa3Vuy5ZXBnvUSz35C+JtYIR0nUarGGnSxK0Dbvj+JYa19dVRKo0niMFBRoq5vxbelvKZYCkTmH9vtpI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7bTlZexKlpr6ShHuMpgqNEdM0/TSs0OkpTThTMTIO4=;
 b=iYElEf2Wd9JwPQ9j1tdz9VGcCfuYjarLz3SgIORAIUIVaDlibzheOPz6vJBh42BmHDhZzB1BuBhPLiEnxT+VTzLCLZ5Ac29nhaS7o2X7Z5DIRIyHtNm1fcDvuMp0K+GqMfwGJgyIf7an+OH1BZ38RpyN0dI+MQWCA1NYWOPBF3PD7oJSVrBoSHVgo2fUUsfrf7SuvTlIMDfJlO1VtDOkzqx+7SpRY31evqLSvOH1xrlw+a761NwtUd3Y6FdgZkKryXT+T/zvcCklQSnQ1HAZ7QXnI9DStnsubd1iGERKI4joUOmiPgOTZTrjbr58QE0JC9kkGUYjMsbOdoYwRy+bRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB7039.namprd11.prod.outlook.com (2603:10b6:806:2b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 12 Sep
 2023 23:25:14 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 23:25:14 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     lkp <lkp@intel.com>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [tip:x86/tdx 8/12] arch/x86/coco/tdx/tdx.c:733:27: error:
 implicit declaration of function '__tdx_hypercall_ret'; did you mean
 '__tdx_hypercall'?
Thread-Topic: [tip:x86/tdx 8/12] arch/x86/coco/tdx/tdx.c:733:27: error:
 implicit declaration of function '__tdx_hypercall_ret'; did you mean
 '__tdx_hypercall'?
Thread-Index: AQHZ5ckSLfkE07qhtkqy+CMcJEHPn7AX1S2A
Date:   Tue, 12 Sep 2023 23:25:14 +0000
Message-ID: <1271a062b2e61ed71b54e4024b11a86bcc027ffc.camel@intel.com>
References: <202309130622.Ba60ODDl-lkp@intel.com>
In-Reply-To: <202309130622.Ba60ODDl-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB7039:EE_
x-ms-office365-filtering-correlation-id: a39b3b63-61ff-4e3a-4f9e-08dbb3e78492
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bDxfjsiS2DGE1j+LQant6W9OMWi2lUqCKEiA8B3V/iJc0E7qmDKUZTLfjONzUZlwzh2cFrScI1uGuM1PhcD3wV4i1MK54OGh6FLi0DC2z8uTWbMqJlXj/Rj4Ou4s61a3wk3dTBb/YP6HNr8SWzY2zBEMGyHgGqCNy4teBRg0sUAzNjHBzF1qmbOilhk+cZLBW/d0j/REODbZUHj9SE0ai9aSWZu98ntDFZ96jKBmrgZNsRqTITUI46ITvjChbhRwvF0aUvSWn9jYhRBU4l3cC+N7JXm08V+Vw99lCZ2/oXUwGCrZBp0KTyh8xVe3r084S3AL6sPpTKAmUuYVAFf+s0o8Nrofk55AA/R6cmtb59N0BuKohy/cWVFgDwWlX2oIGZRTnKsndkNl6GuVTgxF2cqwtwaLKS+kbL6Z5RMClPfvQ8u4l2xwq6o9OKUBc2aOHTMMw0LXHspZsNM1CpnWt1yP1VGFOw6lk+w9uUGB1dsXoK2O+XllacEoPH+jg1DDsc3bqCdp/TopHLT/spQ+Vbbky4Zt94H7pCHce9G1O3oZABbIl6gRkdmmBuM83u24ryDrEQt6z0LCGkj4KZsdPPhCuqLRfWXx+FxoE1FTF5p3KwEeUEvqpwyzzjNSzfUF4/1Bje58g6uG0bMdwcnCRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(346002)(136003)(186009)(1800799009)(451199024)(38070700005)(6486002)(71200400001)(6512007)(122000001)(6506007)(36756003)(38100700002)(82960400001)(83380400001)(41300700001)(478600001)(2616005)(26005)(966005)(66476007)(64756008)(54906003)(66556008)(66446008)(37006003)(6636002)(66946007)(316002)(91956017)(76116006)(5660300002)(4326008)(8676002)(86362001)(8936002)(6862004)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG1SZGZLaHFVTGNUK2RSc3lvWHg0Mk1jVUJyQWVFOWxoM0tkYmRFdUFEczdJ?=
 =?utf-8?B?eW5xZkk0cUJ6ZTI0ajFhRkgyZmJDdUF6aXFoK2VtSGZ0cTd6NnlMRDRORDZK?=
 =?utf-8?B?VHNZdDdGdlpoaE0vOExsZS9yVlZHVldUZUw0ekg1NXZFTlpjSG1pTjlTYWZz?=
 =?utf-8?B?SWdaSE1RRE5MMWNqZG5rbkVKZWFpbXh3dEN4OTBmOWNmbldpYlZzbFgxRTc2?=
 =?utf-8?B?N0ZzZGgwSmI5WUxBRUF5Mzg5cGRoc1lYT29rWkF4eFFQZ3gybmp3dlZQOUZV?=
 =?utf-8?B?NzNrMng4Ui9abHQ4eVhmRHJYQ3ZVa0NSZjBIVkxJUHJiWThOTiszS05nQnU0?=
 =?utf-8?B?N1RYcGF3Vjk2Uk03NzdNQmZaa2JhYzFiZ05LeTFiT0ZMeXRXR2taKzJsV3J1?=
 =?utf-8?B?dnY4N3NiOHkxd3pKWHJVdFNZWlFqcUpXV1hUZWU2a3M4L1pqWjZ1WEQvNGQ2?=
 =?utf-8?B?OENGWVB5dFAySng4TC8vUWNnK2JFZUJxU1hTU1QvWWZKdlVPelBxazZ4UVZy?=
 =?utf-8?B?aFJOcU92WVV1c0t1NG5CWFNhOExkcGwwclljR0RIR2h1QVllUXdMTEJyUzBI?=
 =?utf-8?B?VGRpVk9PZHdOSWFVT3VCT3diczhONjlkWHUxK3hBQzYySFZUMWd5SXEvaFp4?=
 =?utf-8?B?akhGNWNacThkdnR6U3VDekZGbTgzdHJyRXFQVXA5c3VaZ0dTWHR0RFNxR1p0?=
 =?utf-8?B?NktkdmlZTXlKMWFhRU9LUGNnNzdtNE9ud1FPMUhUdkE0MTIyWFJINHVhRzF6?=
 =?utf-8?B?bjYyeis5bzE3aGFBU0sveGV0bzNqc3hXM2hibGxWY0lSd0luNnk4eHhGZFFH?=
 =?utf-8?B?VjM4ZDFGamZtTGZLQ0M4UXg2djdHOG9iZ3FkRGdTdGlpWFZ6YkVWS2luZ3NW?=
 =?utf-8?B?YXE5YWwyS1I3THdSazhmOHNRU1YzdVE4WS85NkFscFdwSDNqY3ZrVUxHdnBy?=
 =?utf-8?B?bE9sdVUxQVRxR04wbVlzbzhvZk94cU85Szc0V1hsRTkwYkFTeG9Vd3JhaHc1?=
 =?utf-8?B?cytBWjhaMVVjK2VqWi9vNXkzRHNTOFg2ZjRlVnB4YUpDaTlrY294bGN3c1FT?=
 =?utf-8?B?WTI2TFNoL2FoL25IUmdmbTcwTFNXSFhzb0x3SkFVN3IrZm9xekFOQkNMZEtt?=
 =?utf-8?B?UzNnMGdEQ1FVR1pMTnRiNWR5RmpkNFdRL1d5aGhOUWgvaVdwNXh0TWdlU3Jt?=
 =?utf-8?B?V0pnK0tGQzdWK3FYMUpkL2VNYUUzN3pJbXBQUVFSekdPU1k0Vzgwb1ZuSjc2?=
 =?utf-8?B?QTlIVndMenozNm55N3lDOWdkaXJOT2VHa2xHK2dWVXBuTExCRkpNeEJFSG1n?=
 =?utf-8?B?L1U5RC9EeHVyOWV5SjRobjl6aEhjOFd0SDltSHJoaDRURUo0aEkrQkRoTGpq?=
 =?utf-8?B?N3V5dklsd3BIczZOUVRyMVpqekZoRGpuQVFySlEwdXdHMDByNjJXcmJURzUx?=
 =?utf-8?B?aHRpbDA4cHpoVDJ0UlJhQ1lTVkt2TkJFN2NXQTlFL3NyTWdKaklPY2M3ZjZ0?=
 =?utf-8?B?enFpMElCUTdKbXdScWxRbVh5eDFRa1FlNi9NdHg1UmpGQUM2Y2ZENWZFQ0tW?=
 =?utf-8?B?ekFSZ3RhUWlPYktHakRNa2tUL3psd0JrajZlVjdQcE9iOU82NFRsN2x0clVk?=
 =?utf-8?B?alBQL3dyeTF6SG40R2lMU1hQQnY0OHp6K2p6RERadW1IZFBrWm5qZ3pqWkZQ?=
 =?utf-8?B?WFdrSHZMQW1TcWRwa0h3ZHFBcURNRHVGY3NWa0NsYXhhYzZrN0ZnNjh4K2p1?=
 =?utf-8?B?UVI3a1JZdGVWNDNrREV2blJBY0RaT0Q3ZUZQR1JITmR5aHVzUEpQVk5LVkgv?=
 =?utf-8?B?eEdSUUdzMGZFVXBxYkg4K3RXOHNTRit2K3lTVFB4dzhRSjhPcjhBN3ZhWmJI?=
 =?utf-8?B?Ukpmbk1YV0d3aXd3UERHc0thWHlISHRia1A5dDhURXJBZzdFSkpoY0J0bEIy?=
 =?utf-8?B?WUhOektad2hhT3dTQUhaclZYTXhHV0Z6WlZ0MkdHVzRwc0o3OXZYeXM1Rml5?=
 =?utf-8?B?bjA0TnM3a3daV09aRjllRGtFRmg1cTNwenZhL0x4K1o5MTVsREZ0L2lXRGto?=
 =?utf-8?B?ZjlJRC9GU2Y1VEtpSTJMNTVBT3U2ZjRIYlg5eUZwZUczbEpFOGRFRkhzWElI?=
 =?utf-8?B?U3ZmZjlTdEhhSC9INmpxb1pZZVc3L0NmdEhLWlhpVFhXc0xWT2NkQmtyQXkv?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7743C09D89A3E64BA75BA1E788015715@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39b3b63-61ff-4e3a-4f9e-08dbb3e78492
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 23:25:14.5735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOfDPdxfIQ3Y3gjuF3MfEa1cxHBuOeytoxkJtswcgbJJmTXNG0nmBqzN14EJrqC8n7Xxxu6cF3cEdDG/BEl2kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7039
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgdGhpcyBpcyBkdWUgdG8gdGhlIHY0IFVuaWZ5IFREQ0FMTC9TRUFNQ0FMTCBhbmQgVERW
TUNBTEwgYXNzZW1ibHkgcGF0Y2hzZXQNCndhcyBiYXNlZCBvbiBvbGQgdGlwL3g4Ni90ZHggYmVm
b3JlIDYuNiwgdGh1cyBkaWRuJ3QgY29udGFpbiBjaGFuZ2luZyB0byB0aG9zZQ0KbmV3IHBhdGNo
ZXMuDQoNCkkndmUgc2VudCBwYXRjaGVzIHRvIERhdmUgdG8gZml4Lg0KDQpPbiBXZWQsIDIwMjMt
MDktMTMgYXQgMDY6MzIgKzA4MDAsIGtlcm5lbCB0ZXN0IHJvYm90IHdyb3RlOg0KPiB0cmVlOiAg
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXAu
Z2l0IHg4Ni90ZHgNCj4gaGVhZDogICBkNmNiMGYwMTY0NGM1Y2QyYmM1MWI4OGRmOTMzZTA3ODQ5
Y2ZhYTc2DQo+IGNvbW1pdDogZjllYTY5ZTY0MDZhYmYyMTQ1YWJhNzk4N2U3YjgxZWExYjRlYTM1
NiBbOC8xMl0geDg2L3RkeDogTWFrZSBURFhfSFlQRVJDQUxMIGFzbSBzaW1pbGFyIHRvIFREWF9N
T0RVTEVfQ0FMTA0KPiBjb25maWc6IHg4Nl82NC1hbGx5ZXNjb25maWcgKGh0dHBzOi8vZG93bmxv
YWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIzMDkxMy8yMDIzMDkxMzA2MjIuQmE2ME9ERGwt
bGtwQGludGVsLmNvbS9jb25maWcpDQo+IGNvbXBpbGVyOiBnY2MtMTIgKERlYmlhbiAxMi4yLjAt
MTQpIDEyLjIuMA0KPiByZXByb2R1Y2UgKHRoaXMgaXMgYSBXPTEgYnVpbGQpOiAoaHR0cHM6Ly9k
b3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjMwOTEzLzIwMjMwOTEzMDYyMi5CYTYw
T0REbC1sa3BAaW50ZWwuY29tL3JlcHJvZHVjZSkNCj4gDQo+IElmIHlvdSBmaXggdGhlIGlzc3Vl
IGluIGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0IGEgbmV3IHZlcnNpb24g
b2YNCj4gdGhlIHNhbWUgcGF0Y2gvY29tbWl0KSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFncw0K
PiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gPiBD
bG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyMzA5MTMwNjIy
LkJhNjBPRERsLWxrcEBpbnRlbC5jb20vDQo+IA0KPiBBbGwgZXJyb3JzIChuZXcgb25lcyBwcmVm
aXhlZCBieSA+Pik6DQo+IA0KPiAgICBhcmNoL3g4Ni9jb2NvL3RkeC90ZHguYzogSW4gZnVuY3Rp
b24gJ3RkeF9tYXBfZ3BhJzoNCj4gPiA+IGFyY2gveDg2L2NvY28vdGR4L3RkeC5jOjczMzoyNzog
ZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdfX3RkeF9oeXBlcmNhbGxf
cmV0JzsgZGlkIHlvdSBtZWFuICdfX3RkeF9oeXBlcmNhbGwnPyBbLVdlcnJvcj1pbXBsaWNpdC1m
dW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gICAgICA3MzMgfCAgICAgICAgICAgICAgICAgdTY0IHJl
dCA9IF9fdGR4X2h5cGVyY2FsbF9yZXQoJmFyZ3MpOw0KPiAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgX190ZHhfaHlwZXJjYWxsDQo+ICAgIGNjMTogc29tZSB3YXJuaW5n
cyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0KPiANCj4gDQo+IHZpbSArNzMzIGFyY2gveDg2L2Nv
Y28vdGR4L3RkeC5jDQo+IA0KPiA3ZGJkZTc2MzE2Mjk4OSBLaXJpbGwgQS4gU2h1dGVtb3YgMjAy
Mi0wNC0wNiAgNzA3ICANCj4gN2RiZGU3NjMxNjI5ODkgS2lyaWxsIEEuIFNodXRlbW92IDIwMjIt
MDQtMDYgIDcwOCAgLyoNCj4gMDE5YjM4M2QxMTMyZTQgRGV4dWFuIEN1aSAgICAgICAgIDIwMjMt
MDgtMTAgIDcwOSAgICogTm90aWZ5IHRoZSBWTU0gYWJvdXQgcGFnZSBtYXBwaW5nIGNvbnZlcnNp
b24uIE1vcmUgaW5mbyBhYm91dCBBQkkNCj4gMDE5YjM4M2QxMTMyZTQgRGV4dWFuIEN1aSAgICAg
ICAgIDIwMjMtMDgtMTAgIDcxMCAgICogY2FuIGJlIGZvdW5kIGluIFREWCBHdWVzdC1Ib3N0LUNv
bW11bmljYXRpb24gSW50ZXJmYWNlIChHSENJKSwNCj4gMDE5YjM4M2QxMTMyZTQgRGV4dWFuIEN1
aSAgICAgICAgIDIwMjMtMDgtMTAgIDcxMSAgICogc2VjdGlvbiAiVERHLlZQLlZNQ0FMTDxNYXBH
UEE+Ii4NCj4gN2RiZGU3NjMxNjI5ODkgS2lyaWxsIEEuIFNodXRlbW92IDIwMjItMDQtMDYgIDcx
MiAgICovDQo+IDAxOWIzODNkMTEzMmU0IERleHVhbiBDdWkgICAgICAgICAyMDIzLTA4LTEwICA3
MTMgIHN0YXRpYyBib29sIHRkeF9tYXBfZ3BhKHBoeXNfYWRkcl90IHN0YXJ0LCBwaHlzX2FkZHJf
dCBlbmQsIGJvb2wgZW5jKQ0KPiA3ZGJkZTc2MzE2Mjk4OSBLaXJpbGwgQS4gU2h1dGVtb3YgMjAy
Mi0wNC0wNiAgNzE0ICB7DQo+IDAxOWIzODNkMTEzMmU0IERleHVhbiBDdWkgICAgICAgICAyMDIz
LTA4LTEwICA3MTUgIAkvKiBSZXRyeWluZyB0aGUgaHlwZXJjYWxsIGEgc2Vjb25kIHRpbWUgc2hv
dWxkIHN1Y2NlZWQ7IHVzZSAzIGp1c3QgaW4gY2FzZSAqLw0KPiAwMTliMzgzZDExMzJlNCBEZXh1
YW4gQ3VpICAgICAgICAgMjAyMy0wOC0xMCAgNzE2ICAJY29uc3QgaW50IG1heF9yZXRyaWVzX3Bl
cl9wYWdlID0gMzsNCj4gMDE5YjM4M2QxMTMyZTQgRGV4dWFuIEN1aSAgICAgICAgIDIwMjMtMDgt
MTAgIDcxNyAgCWludCByZXRyeV9jb3VudCA9IDA7DQo+IDdkYmRlNzYzMTYyOTg5IEtpcmlsbCBB
LiBTaHV0ZW1vdiAyMDIyLTA0LTA2ICA3MTggIA0KPiA3ZGJkZTc2MzE2Mjk4OSBLaXJpbGwgQS4g
U2h1dGVtb3YgMjAyMi0wNC0wNiAgNzE5ICAJaWYgKCFlbmMpIHsNCj4gN2RiZGU3NjMxNjI5ODkg
S2lyaWxsIEEuIFNodXRlbW92IDIwMjItMDQtMDYgIDcyMCAgCQkvKiBTZXQgdGhlIHNoYXJlZCAo
ZGVjcnlwdGVkKSBiaXRzOiAqLw0KPiA3ZGJkZTc2MzE2Mjk4OSBLaXJpbGwgQS4gU2h1dGVtb3Yg
MjAyMi0wNC0wNiAgNzIxICAJCXN0YXJ0IHw9IGNjX21rZGVjKDApOw0KPiA3ZGJkZTc2MzE2Mjk4
OSBLaXJpbGwgQS4gU2h1dGVtb3YgMjAyMi0wNC0wNiAgNzIyICAJCWVuZCAgIHw9IGNjX21rZGVj
KDApOw0KPiA3ZGJkZTc2MzE2Mjk4OSBLaXJpbGwgQS4gU2h1dGVtb3YgMjAyMi0wNC0wNiAgNzIz
ICAJfQ0KPiA3ZGJkZTc2MzE2Mjk4OSBLaXJpbGwgQS4gU2h1dGVtb3YgMjAyMi0wNC0wNiAgNzI0
ICANCj4gMDE5YjM4M2QxMTMyZTQgRGV4dWFuIEN1aSAgICAgICAgIDIwMjMtMDgtMTAgIDcyNSAg
CXdoaWxlIChyZXRyeV9jb3VudCA8IG1heF9yZXRyaWVzX3Blcl9wYWdlKSB7DQo+IDAxOWIzODNk
MTEzMmU0IERleHVhbiBDdWkgICAgICAgICAyMDIzLTA4LTEwICA3MjYgIAkJc3RydWN0IHRkeF9o
eXBlcmNhbGxfYXJncyBhcmdzID0gew0KPiAwMTliMzgzZDExMzJlNCBEZXh1YW4gQ3VpICAgICAg
ICAgMjAyMy0wOC0xMCAgNzI3ICAJCQkucjEwID0gVERYX0hZUEVSQ0FMTF9TVEFOREFSRCwNCj4g
MDE5YjM4M2QxMTMyZTQgRGV4dWFuIEN1aSAgICAgICAgIDIwMjMtMDgtMTAgIDcyOCAgCQkJLnIx
MSA9IFREVk1DQUxMX01BUF9HUEEsDQo+IDAxOWIzODNkMTEzMmU0IERleHVhbiBDdWkgICAgICAg
ICAyMDIzLTA4LTEwICA3MjkgIAkJCS5yMTIgPSBzdGFydCwNCj4gMDE5YjM4M2QxMTMyZTQgRGV4
dWFuIEN1aSAgICAgICAgIDIwMjMtMDgtMTAgIDczMCAgCQkJLnIxMyA9IGVuZCAtIHN0YXJ0IH07
DQo+IDAxOWIzODNkMTEzMmU0IERleHVhbiBDdWkgICAgICAgICAyMDIzLTA4LTEwICA3MzEgIA0K
PiAwMTliMzgzZDExMzJlNCBEZXh1YW4gQ3VpICAgICAgICAgMjAyMy0wOC0xMCAgNzMyICAJCXU2
NCBtYXBfZmFpbF9wYWRkcjsNCj4gMDE5YjM4M2QxMTMyZTQgRGV4dWFuIEN1aSAgICAgICAgIDIw
MjMtMDgtMTAgQDczMyAgCQl1NjQgcmV0ID0gX190ZHhfaHlwZXJjYWxsX3JldCgmYXJncyk7DQo+
IDAxOWIzODNkMTEzMmU0IERleHVhbiBDdWkgICAgICAgICAyMDIzLTA4LTEwICA3MzQgIA0KPiAw
MTliMzgzZDExMzJlNCBEZXh1YW4gQ3VpICAgICAgICAgMjAyMy0wOC0xMCAgNzM1ICAJCWlmIChy
ZXQgIT0gVERWTUNBTExfU1RBVFVTX1JFVFJZKQ0KPiAwMTliMzgzZDExMzJlNCBEZXh1YW4gQ3Vp
ICAgICAgICAgMjAyMy0wOC0xMCAgNzM2ICAJCQlyZXR1cm4gIXJldDsNCj4gN2RiZGU3NjMxNjI5
ODkgS2lyaWxsIEEuIFNodXRlbW92IDIwMjItMDQtMDYgIDczNyAgCQkvKg0KPiAwMTliMzgzZDEx
MzJlNCBEZXh1YW4gQ3VpICAgICAgICAgMjAyMy0wOC0xMCAgNzM4ICAJCSAqIFRoZSBndWVzdCBt
dXN0IHJldHJ5IHRoZSBvcGVyYXRpb24gZm9yIHRoZSBwYWdlcyBpbiB0aGUNCj4gMDE5YjM4M2Qx
MTMyZTQgRGV4dWFuIEN1aSAgICAgICAgIDIwMjMtMDgtMTAgIDczOSAgCQkgKiByZWdpb24gc3Rh
cnRpbmcgYXQgdGhlIEdQQSBzcGVjaWZpZWQgaW4gUjExLiBSMTEgY29tZXMNCj4gMDE5YjM4M2Qx
MTMyZTQgRGV4dWFuIEN1aSAgICAgICAgIDIwMjMtMDgtMTAgIDc0MCAgCQkgKiBmcm9tIHRoZSB1
bnRydXN0ZWQgVk1NLiBTYW5pdHkgY2hlY2sgaXQuDQo+IDdkYmRlNzYzMTYyOTg5IEtpcmlsbCBB
LiBTaHV0ZW1vdiAyMDIyLTA0LTA2ICA3NDEgIAkJICovDQo+IDAxOWIzODNkMTEzMmU0IERleHVh
biBDdWkgICAgICAgICAyMDIzLTA4LTEwICA3NDIgIAkJbWFwX2ZhaWxfcGFkZHIgPSBhcmdzLnIx
MTsNCj4gMDE5YjM4M2QxMTMyZTQgRGV4dWFuIEN1aSAgICAgICAgIDIwMjMtMDgtMTAgIDc0MyAg
CQlpZiAobWFwX2ZhaWxfcGFkZHIgPCBzdGFydCB8fCBtYXBfZmFpbF9wYWRkciA+PSBlbmQpDQo+
IDAxOWIzODNkMTEzMmU0IERleHVhbiBDdWkgICAgICAgICAyMDIzLTA4LTEwICA3NDQgIAkJCXJl
dHVybiBmYWxzZTsNCj4gMDE5YjM4M2QxMTMyZTQgRGV4dWFuIEN1aSAgICAgICAgIDIwMjMtMDgt
MTAgIDc0NSAgDQo+IDAxOWIzODNkMTEzMmU0IERleHVhbiBDdWkgICAgICAgICAyMDIzLTA4LTEw
ICA3NDYgIAkJLyogIkNvbnN1bWUiIGEgcmV0cnkgd2l0aG91dCBmb3J3YXJkIHByb2dyZXNzICov
DQo+IDAxOWIzODNkMTEzMmU0IERleHVhbiBDdWkgICAgICAgICAyMDIzLTA4LTEwICA3NDcgIAkJ
aWYgKG1hcF9mYWlsX3BhZGRyID09IHN0YXJ0KSB7DQo+IDAxOWIzODNkMTEzMmU0IERleHVhbiBD
dWkgICAgICAgICAyMDIzLTA4LTEwICA3NDggIAkJCXJldHJ5X2NvdW50Kys7DQo+IDAxOWIzODNk
MTEzMmU0IERleHVhbiBDdWkgICAgICAgICAyMDIzLTA4LTEwICA3NDkgIAkJCWNvbnRpbnVlOw0K
PiAwMTliMzgzZDExMzJlNCBEZXh1YW4gQ3VpICAgICAgICAgMjAyMy0wOC0xMCAgNzUwICAJCX0N
Cj4gMDE5YjM4M2QxMTMyZTQgRGV4dWFuIEN1aSAgICAgICAgIDIwMjMtMDgtMTAgIDc1MSAgDQo+
IDAxOWIzODNkMTEzMmU0IERleHVhbiBDdWkgICAgICAgICAyMDIzLTA4LTEwICA3NTIgIAkJc3Rh
cnQgPSBtYXBfZmFpbF9wYWRkcjsNCj4gMDE5YjM4M2QxMTMyZTQgRGV4dWFuIEN1aSAgICAgICAg
IDIwMjMtMDgtMTAgIDc1MyAgCQlyZXRyeV9jb3VudCA9IDA7DQo+IDAxOWIzODNkMTEzMmU0IERl
eHVhbiBDdWkgICAgICAgICAyMDIzLTA4LTEwICA3NTQgIAl9DQo+IDAxOWIzODNkMTEzMmU0IERl
eHVhbiBDdWkgICAgICAgICAyMDIzLTA4LTEwICA3NTUgIA0KPiAwMTliMzgzZDExMzJlNCBEZXh1
YW4gQ3VpICAgICAgICAgMjAyMy0wOC0xMCAgNzU2ICAJcmV0dXJuIGZhbHNlOw0KPiAwMTliMzgz
ZDExMzJlNCBEZXh1YW4gQ3VpICAgICAgICAgMjAyMy0wOC0xMCAgNzU3ICB9DQo+IDAxOWIzODNk
MTEzMmU0IERleHVhbiBDdWkgICAgICAgICAyMDIzLTA4LTEwICA3NTggIA0KPiANCj4gOjo6Ojo6
IFRoZSBjb2RlIGF0IGxpbmUgNzMzIHdhcyBmaXJzdCBpbnRyb2R1Y2VkIGJ5IGNvbW1pdA0KPiA6
Ojo6OjogMDE5YjM4M2QxMTMyZTQwNTFkZTBkMmU0MzI1NDQ1NGI4NjUzOGNmNCB4ODYvdGR4OiBS
ZXRyeSBwYXJ0aWFsbHktY29tcGxldGVkIHBhZ2UgY29udmVyc2lvbiBoeXBlcmNhbGxzDQo+IA0K
PiA6Ojo6OjogVE86IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+DQo+IDo6Ojo6OiBD
QzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gDQoNCg==
