Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42DE7CFC56
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbjJSOVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjJSOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:21:45 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AAD119;
        Thu, 19 Oct 2023 07:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1BJN+XwQ5jWTrEOW40ZPxxiW06b83bvTt2I40gGm53zMbf3x0QKTsODhqObEnOx4/niASKUF987YxXm+DmxKQiuGTa4WxKdrIgKwiowsu1OKkGzHjrvBEbMVa7xb5l7WsUpULnO56UCVtKxo7DqPcReIb3fRBoXTPzqUs8PKOfV9Ck0lTC8add1rsaXDRaPaw62Ki8nqte8+6CFL2d1+Yw0DQFBTZDJRJhwTozRkHtID17hCBilU1Pjio1xMa0iCHbfHGMj2Qf4qAeGDg8EhCiOGky3CcCG+WzyT0jYTvurNwRe8nwSbD3z1/2r4XWKnyzBze0Qn/IFRC/h9IgD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77MOgNI0EBbGNGL41l71pRWu5HZvwrh+3DZHEB83DxQ=;
 b=dHDn+E+U5mWpuph+pnGxK269VsWLySaRcB7LQ6Ia5z2WV14XahGLz4QqTmrDqlKk/kNZIpHInRvXmrXrYxrQ11ww6xU4+0Htwzghy/OQ+05b6AMc0JzcGZH7GAWNJa1Bqy03flc+4QukXc7hbUxpzqQZyIyLGFm8xJeUUXlMUzDbkhMAqviRDMWntP7ixhUThP7KVoiWsvDFe22KD4GgbtJ4Fc+yFaqpiQpkTXfA+cCFzfZkg3cgfNKAjkEGx3oOxZTjy/Od5jd/TtURyXNPqGknsPBTfgy8/bSk035Kri0aYPOW1AzcuyaI9lCyo3/CThfJrEwlM+f1Kr2cBulGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77MOgNI0EBbGNGL41l71pRWu5HZvwrh+3DZHEB83DxQ=;
 b=lXJFm/Z6JrM/fRGdhEdxUzPDTG4bqsnwQP2012Ui1VK2tyBzTfut3uLb5nWM1EI4y+4GaTqiExV5yQ3NJxdxQ/nopv5VrttWwY/EYhvMY7dENQmp9Mo0l0sqcXyRly602v443ZZ8OFltYQ/vvVjT50AgYFdNVLpFOtTEflvDHdo=
Received: from SN6PR12MB2702.namprd12.prod.outlook.com (2603:10b6:805:6c::16)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Thu, 19 Oct 2023 14:21:40 +0000
Received: from SN6PR12MB2702.namprd12.prod.outlook.com
 ([fe80::293a:d73e:e856:543a]) by SN6PR12MB2702.namprd12.prod.outlook.com
 ([fe80::293a:d73e:e856:543a%7]) with mapi id 15.20.6886.039; Thu, 19 Oct 2023
 14:21:40 +0000
From:   "Kaplan, David" <David.Kaplan@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: RE: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Thread-Topic: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Thread-Index: AQHZ/TSeSSFyryg+x0KeMifZktOt3rBPkkIAgAAENgCAABo2gIAAC66AgAAhzICAAC1XgIAApvyAgAAGtgCAAHnAAIAAAE5Q
Date:   Thu, 19 Oct 2023 14:21:40 +0000
Message-ID: <SN6PR12MB2702AC3C27D25414FE4260F994D4A@SN6PR12MB2702.namprd12.prod.outlook.com>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
 <20231019063527.iwgyioxi2gznnshp@treble>
 <20231019065928.mrvhtfaya22p2uzw@treble>
 <20231019141514.GCZTE58qPOvcJCiBp3@fat_crate.local>
In-Reply-To: <20231019141514.GCZTE58qPOvcJCiBp3@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d68e872f-0162-41a4-9b3b-8afd19257e89;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T14:16:19Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR12MB2702:EE_|DS7PR12MB6312:EE_
x-ms-office365-filtering-correlation-id: 4e969336-969f-403d-8b3d-08dbd0aeb682
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9R2OPy7zDWf2tzPNEdCq8O+4MPq0038ormjaAujcqoVY7XKkDEkMjHJbNwcyRzS5GOi3lB1uEgEXZmrTt8/00dnyjReIFA73BIPsfEye9yFpBltkNbZfKYseOniCPo4ULbwmvpENdxk8rnpI6H6t8WCRyEO/laS6nwRQkWk+yvc1uIQY6CpUavA61xIuG6glNOHUQHpjJtt14UuzRPX2pGSihU39LE8oMTuL/pyKvfDGPHoy9IFAMcwJO6OcnFkL9e4zfjzm/ZaXVFznGH39fzefA0F8T27own9D9+y9pPL8Q8l/WVVx+c9SdY5W/FHde6cHxbatbXpHe04peDouawO1aCnhV7zw2ftFwbvE1uZQ3RIBseh6Ze6JuKETv+v5NIMKh9C3aXU0BZPXQ0qh94k944RnCgjs6QsVghqQWYKLf/SbN8LubGs2JNf6TO5pTaBwRTwr9TNT1sKe3qKozW6s7BKhQe5RwU9IsFc1HKaoOp79qQ3dzAfl/sXwhiG6Kp8pt3NBIOOZzK5ZUmPMIJs1ezZf7egqcgDIwRlfZj1fY4Tk4iz35TkFaTB7rBqBeb1hdheRL4A91GKwVq8kLb3Opj0R9STfzP3gO1TLfeNlXTbXByKlU6P73786Ry/s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2702.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(478600001)(71200400001)(122000001)(66556008)(38100700002)(66946007)(66476007)(76116006)(26005)(38070700005)(53546011)(66446008)(54906003)(64756008)(110136005)(7696005)(6506007)(9686003)(316002)(83380400001)(5660300002)(8936002)(4326008)(52536014)(55016003)(8676002)(2906002)(33656002)(86362001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm5XR3pHYmxPN3Mrd1BuVWZOTDVZeHZsUGNKSUxwYWpONVFmVDU4V3F3N0Iz?=
 =?utf-8?B?T3FKSkZGRmtEWGUyRndFN0VUeU1vTndNREgwZW1FUEVYd0NUbkpLNUg0YzZm?=
 =?utf-8?B?YzF3SWNMOCtTVHZIelNJcE9Idm9LODg3K2FXZzA0Zm1JN0RSSGRLeFVFVjVI?=
 =?utf-8?B?ZkVveWNYTy9PSUJLcDJFVyttTkxsZVpQQXhJcnFQS1hpbkRmVmNoemxwVXda?=
 =?utf-8?B?bjh1dlFjaktmeWh3Nk1zMHhXQjV4M3ZrUlV1UG5nWTNzUzVlREJMNUFRb1JN?=
 =?utf-8?B?UUEzbHZ1Q25ka1J4eE10VytBVFZCS3BRWEVUN096enBqTFN4cm9ZZXNnQXIw?=
 =?utf-8?B?NlpjOHRQMmRSQTdSdFc4KzNWZWVsc1lVL1hYQ01GWFE0U1QrMzNCU0h0Y1Fs?=
 =?utf-8?B?YlgzaWdUZ3pJdDBNM2VxTHNpNXVWSFpOb1FnQkp3Wm5GcGpNbHBGb0gvaVVL?=
 =?utf-8?B?c3V3WldQNFd4WjN3TGwyUVRwNnQ1SS9qUWZQTFhBZTd1c09mTFZmNjhsTkNm?=
 =?utf-8?B?MDRidXJTWlhDQ1puV1paeURIU05wS1pJWVNqYlA3b1d1b005dkFoMnVXWTZ3?=
 =?utf-8?B?NHpsRCtncldGQjkwcG1TTjdxalJ2L1c4dmdha25vYWVydTMvM1ROQU1mSjJi?=
 =?utf-8?B?S2h2ckgxd1lPdnAzdnZMb284Z2xUTFRXS1A5dCt1dWdXRXViUTZQWjgxK0hS?=
 =?utf-8?B?emsrdWZOanV0bllObFZNakVid2p1QkVKL1Z5VDVUdXB5cElXUG9vRWd2UGEv?=
 =?utf-8?B?TTVxZjFncWtxZVlRSGJWbTQ2ZGVyM0JUODVhL0pFZE5IbFc2RnNlYkNsUzZL?=
 =?utf-8?B?Yjh1SFlWZ0FhbXh1ODJHSnFybDZ2b25SZnpuL3kvQU4yd0JCQU5ZVmk3QnE5?=
 =?utf-8?B?RXVPOWFCM3hYM2xzM3dybnNvdHA5MHpLajQ4aXNYM3lXRlZWcFU4S2JFNGFv?=
 =?utf-8?B?OHpkNUNHWTRFWGsvRW1ZcGNyVmRRa2VUQkNMYU9sYitybGRacjFHRUc4eThU?=
 =?utf-8?B?cTJOYW5BcDZra2lhdE9NdnJ3Yjh5SW13MWx0RzhYalMxSi9EUDlVRCs0MTRK?=
 =?utf-8?B?WE9NM292RWNoZVF1S1BnNU12cXlZeEZKTEdsSTQveVhRS05kbjdtRjhDS0FY?=
 =?utf-8?B?alMvRW81ODhjbVdkcnlpQTVkNWZFYnBmZG9rSzRVaUVYbU9ic2hqSzdZYkk2?=
 =?utf-8?B?d3RyYnA0QU0zNmUzM3Njam5WS1RVSDNzUVc1bVVRZzBRU2ZLM2x3dzBzT0FU?=
 =?utf-8?B?TU4zODlMSVNBeVMwUi9YclNPbnBkUjN5U1M2ZXRsV2s5NnZCUkJvZDBFY0lv?=
 =?utf-8?B?SDc1M0xpRmZJbXBzdHNrV3JVNW1nZjdPU0p3MnZTVWp5c3hYL09ZL2tiQ25v?=
 =?utf-8?B?NFlpVDdqRmpBbDVNcVRIRCtmZ2cxZVBxdmltNTFCa3BtZEtMSXJEUkVGUjRK?=
 =?utf-8?B?d3pXbFRCU244dlFOVEZxcHNGMTRURkYwbkpqNllXY3pzRm5oTUkzelhFR0Y1?=
 =?utf-8?B?MDgxVHNyYmFYUjBXOFVIc1c1OFNWVVBMeWNEeHF4VDhDeHl4M1VSN1RsWklL?=
 =?utf-8?B?MUFsdDVQRFF3SEErWlU2RmRWanNxWEVHWC9HKzJvdXArU2tTUGh6Nzh5TGdo?=
 =?utf-8?B?NERwVTlWUW5sR2JlbVpCdEQvTHhDYjRFSTlXbzVGOTNaZXhSRnB3UFNRN2Iv?=
 =?utf-8?B?VS9INjEwRmI1c3NVcjdhelNLZnZOUEw0QjBkT3F0U3REYVp5d0xoOXAzQ3hw?=
 =?utf-8?B?NXZjWHU3RGZQMFE2WmY2QnlSVUwyOWdrK1ZkTGJldXFUMkw5Z1crTVRRMk1m?=
 =?utf-8?B?Qk9YMmEzYVVxZEpLeVZkNHNXQ0M4WDhqY3FMcFNPbnZTZC9BcE1GV0RsYkx0?=
 =?utf-8?B?b0xSdFpKeHpEVTBtK1M1aEF1MDdOSjhjKzRlckJPNkIzUE91OG5UL2psUHBE?=
 =?utf-8?B?cHRKSmJNRFg4UEdPbTZTVWlZUTdBVzYvbkpGTVZFUVdVTlhpSGU4WTdFUXhm?=
 =?utf-8?B?bjRpWHhpUEpVdEN5R3AwQW5WVVRValNJdTBhQVVXY2ErNUxUc1ZPNUlrdDZB?=
 =?utf-8?B?ZHZQVGZ6L1BrZVpJTy9oNkRJMGYxSVVSYXhnUVhDZm9NV3F5RlB4ODUvMEhX?=
 =?utf-8?Q?FDWI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2702.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e969336-969f-403d-8b3d-08dbd0aeb682
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 14:21:40.7385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hssPi0r02eKXy3eUoMnjCdDUV9MdYAOZ1XTi/3O9l4Oh3B2gDfwUhHiXUEePeg8M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6
IFRodXJzZGF5LCBPY3RvYmVyIDE5LCAyMDIzIDk6MTUgQU0NCj4gVG86IEpvc2ggUG9pbWJvZXVm
IDxqcG9pbWJvZUBrZXJuZWwub3JnPg0KPiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5v
cmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC10aXAtDQo+IGNvbW1pdHNA
dmdlci5rZXJuZWwub3JnOyBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT47IFBl
dGVyDQo+IFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgeDg2QGtlcm5l
bC5vcmc7IERhdmlkIEhvd2VsbHMNCj4gPGRob3dlbGxzQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbdGlwOiB4ODYvYnVnc10geDg2L3JldHBvbGluZTogRW5zdXJlIGRlZmF1bHQgcmV0dXJu
IHRodW5rIGlzbid0DQo+IHVzZWQgYXQgcnVudGltZQ0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3Nh
Z2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9u
DQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRp
bmcuDQo+DQo+DQo+IE9uIFdlZCwgT2N0IDE4LCAyMDIzIGF0IDExOjU5OjI4UE0gLTA3MDAsIEpv
c2ggUG9pbWJvZXVmIHdyb3RlOg0KPiA+IE9uZSBsYXN0IGlkZWEsIHNpbmNlIHRoZSByZXR1cm4g
dGh1bmsgaXMgdXNlZCBldmVyeXdoZXJlIChldmVuIG5vbi1BQkkNCj4gPiBjb21wbGlhbnQgZnVu
Y3Rpb25zKSBpdCBtaWdodCBiZSBwb3NzaWJsZSB0aGUgImNhbGwgY2hlY2tfdGh1bmtzIiAoYW5k
DQo+ID4gaXRzIGNhbGwgdG8gd2Fybl9wcmludGspIGlzIGNsb2JiZXJpbmcgc29tZSByZWdpc3Rl
cnMgd2hpY2ggc29tZSBjb2RlDQo+ID4gKGV4Y2VwdGlvbiBoYW5kbGluZyBlbnRyeSBjb2RlPykg
ZG9lc24ndCBhcHByZWNpYXRlLg0KPg0KPiBZZWFoLCB0aGF0IGlzIHN0aWxsIHVuY2xlYW4sIEkn
ZCBzYXkuIGdjYyBkb2Vzbid0IGtub3cgdGhhdCB3ZSBwYXRjaCBpbiBhIENBTEwgaW5zbg0KPiBp
biB0aGUgYWx0ZXJuYXRpdmUuIFdoYXQgc2hvdWxkIHdvcmsgaXMgdG8gaGF2ZQ0KPg0KPiAgICAg
ICAgIGFsdGVybmF0aXZlX2NhbGwNCj4NCj4gdGhlcmUgd2hpY2ggYWx0ZXJuYXRlcyBiZXR3ZWVu
IHR3byBjYWxscyBhbmQgZ2NjIGtub3dzIHRoZXJlJ3MgYSBjYWxsIHNvIGl0IGNhbg0KPiBhY3Qg
YWNjb3JkaW5nbHkgd3J0IGNhbGxlZS0qIHJlZ3MuDQo+DQo+IENvbnNpZGVyaW5nIGhvdyBfX3g4
Nl9yZXR1cm5fdGh1bmsgaXMgdGhlcmUgb25seSB1bnRpbCBhbHRlcm5hdGl2ZXMgaGF2ZSBydW4s
DQo+IHdlIGNvdWxkIGRvIHNvbWV0aGluZyBsaWtlDQo+DQo+ICAgICAgICAgQUxURVJOQVRJVkVf
Q0FMTCBub3AsIGNoZWNrX3RodW5rcw0KPg0KPiB3aGVyZSBub3AgaXMgYSBmdW5jdGlvbiB3aGlj
aCBkb2Vzbid0IGRvIGFueXRoaW5nLg0KPg0KPiBJIHNheSAiQUxURVJOQVRJVkVfQ0FMTCIgYmVj
YXVzZSB3ZSBkb24ndCBoYXZlIGEgX0NBTEwgYXNtIG1hY3JvIHlldC4NCj4NCj4gQW5kIHRoZW4g
aW4gY2hlY2tfdGh1bmtzKCkgd2UgY2FuIGRvIGFsbCBraW5kcyBvZiBzY3JlYW1pbmcsIHRhaW50
aW5nIGFuZA0KPiBzZXR0aW5nIG1pdGlnYXRpb24gc3RhdHVzIHRvIHZ1bG5lcmFibGUsIGV0Yy4N
Cj4NCj4gQW55d2F5IHNvbWV0aGluZyBhbG9uZyB0aG9zZSBsaW5lcy4NCg0KVGhlIHJldHVybiB0
aHVuayBpcyB1c2VkIGZvciBhbGwgZnVuY3Rpb25zIHRob3VnaCwgaW5jbHVkaW5nIGFzc2VtYmx5
IGNvZGVkIGZ1bmN0aW9ucyB3aGljaCBtYXkgdXNlIG5vbi1zdGFuZGFyZCBjYWxsaW5nIGNvbnZl
bnRpb25zIGFuZCBhcmVuJ3QgdmlzaWJsZSB0byBnY2MuICBJIHRoaW5rIHRoZSBvbmx5IHNhZmUg
dGhpbmcgd291bGQgYmUgdG8gcHJlc2VydmUgYWxsIEdQUnMgYWNyb3NzIHRoZSBjYWxsIHRvIGNo
ZWNrX3RodW5rcy4gIFNvbWV0aGluZyBsaWtlIFBVU0hfUkVHUy9jYWxsIGNoZWNrX3RodW5rcy9Q
T1BfUkVHUy4NCg0KLS1EYXZpZCBLYXBsYW4NCg0KDQo=
