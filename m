Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F3D75D0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGURt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGURty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:49:54 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021017.outbound.protection.outlook.com [52.101.62.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5139030FF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGqtJQhU3zZhk57VrGRiglr7J49BY1r9BDvP0x+ZwacUzDgddhGqQvOdNVmUSwUV/7LbMkxF0BKAfWilmlgw/wgPZZ9NCCxCsbYJ92PwNEy3eQuQ0AqaSce4psZ8uSWWgcrK5hIOgbCep+ofqIJzTWEuSkOMBEOmvkC0/pHTbWhH9DRqcbSdvg2iCpAePqW8zlIuPT7eXv2J0ns45ORXkwJMgU7C+45frE5C7kjHrHpb/HQKAjlR4kYenQuHu0bfqk7cfk8zBGWN81e+Uv3Ehuj2Vf2K2yurcuYY2iXwtMjdmkPW3mxFUhVa+ZpXMa7YULKnsPdzL3txW83FvxO7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VisJJB7IMVOJsfKAJ2pGjUMw51rRpuEmkjvtsrT4CI=;
 b=lW3nHgFIu65IcXsLGkE2XpLXLQwa0FgG8h6xWPkF8QEGBI2y2p/Nlv9PtDqBjpR/BQefUiiHMSDN3Vw/QCPNJyEK7+jOgVwS1zLLzrWyJ5frlTpcUdxkWE0ojXCgK8XUjzCuN5Cm7907Q4m91IN7c3U52qHYemY4r7mrY+uzo+onPtJpqDgg5O3IhIqtex0TTTML2D7jiLeFXwJK/Uvw2zoKE0eFsOHjgQYWWN6VOGCxgJoIk19KYQ05o9sylUnWg9YGbJZazI9MWC3m0Inhk3/0xUOjryttEX6k0ql+DTMhtJprFDf91DQE8zujFJivPDHkn5ZPm2BvvafVo4gZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VisJJB7IMVOJsfKAJ2pGjUMw51rRpuEmkjvtsrT4CI=;
 b=CnBll09gHflp+lEf6B+xeinKc5WlwH4R+m6gGr92nKkqG6NJMg7gWO49NseTdgGhxW33wFeTDZxd5FtHNPqpVZr/djAcB/3q7r/P5h7ws51cF2jGTm1kODY/y+0BgGGWRjgeaWpqZTyQEdjO3DzDICxKxJopVGly0lEqSS0/Fm0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3748.namprd21.prod.outlook.com (2603:10b6:208:3d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.12; Fri, 21 Jul
 2023 17:49:48 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136%4]) with mapi id 15.20.6631.014; Fri, 21 Jul 2023
 17:49:50 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: RE: [patch 53/58] x86/apic: Convert other overrides to
 apic_update_callback()
Thread-Topic: [patch 53/58] x86/apic: Convert other overrides to
 apic_update_callback()
Thread-Index: AQHZuQVuetcQc80yT0m81lu4TPCIoK/EhLaQ
Date:   Fri, 21 Jul 2023 17:49:50 +0000
Message-ID: <BYAPR21MB168815CC86ADC0E33A19BCF7D73FA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230717223049.327865981@linutronix.de>
 <20230717223226.237896259@linutronix.de>
In-Reply-To: <20230717223226.237896259@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e7dc8ed7-f0f3-449b-8ae7-dc844376aeb6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-21T17:47:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3748:EE_
x-ms-office365-filtering-correlation-id: ec5cf0d1-8c55-4cd0-a087-08db8a12e1a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aKL1IX8nL1xSageQZog3XT98hzJthFuifa7vfnyhVPy7bPY4aCXERStAi5ov0UsjGcUOEmPtk80ye1c8f52p5/Iwd2DdpY75QmfM+vbO5B2DInB/dng/HEr1NtrFPZrmifErGs+UKFgFCF0zis/wRQlnOZ+fS2LXPJztdDJ02za02Ub2TjjMYTlCmoLZezVsg/+nxt6P7P/ztjoDJjiL60vHfOczsUQsh8JRFKKweF+NwA2dx6TsAmJiknqsSuQnwwLQUrnobAtVQwG2NAItPYDGaMTn1ibetSW2MTuhkUVHZAJEbs2oop+qamZX6kPcMz/Q8Qz6vigs0kXTz/5iSwGjftEZju2BtGGbmVG8XSiAqiqtR016KTeClYD66TpNL3JIsmJ6AGWOtrFpDGxMjFWg8S270RmuN0/YIvZmM+xfs7Z5zGLVKWNJIj5DnpqZJ/LBaDTw9TtENVo+zuGcr42I9JpGBvbZSpFlO7uO5V7gGg7FoKdBekVj/f6DHR52EKf2Lh5QJDc4SJZSs8N6H1DNOr40uUG8dhnCaoeUXfzfhlz+eg/hNA+qvCw2wQWiVXaMpeT7Peh7AezXj0qRuAZt8DYJ6BasuC6DQDgyloJq3yiUc2yzQGoqXgTdY+lJECDb3mz7oOvSdSYzrVRK04QXeiRWBJCUQL/u7X44fWI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(55016003)(9686003)(110136005)(82950400001)(7696005)(122000001)(54906003)(71200400001)(66556008)(5660300002)(478600001)(52536014)(10290500003)(41300700001)(8936002)(8676002)(38100700002)(66476007)(76116006)(64756008)(66446008)(66946007)(316002)(4326008)(186003)(83380400001)(6506007)(26005)(82960400001)(33656002)(38070700005)(8990500004)(7416002)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGI1RFQ4WFB3cDlRRUxNT3FLSnZObmpYeTJIRjFKY2hQSEhTRnFZRmgxK28x?=
 =?utf-8?B?a3VnT2N5NEtsbE00b2p5em1Pc3Y2UFZzUTVraWdaeWVDc1h6K3VvaENIL0Yr?=
 =?utf-8?B?VUZPdDFLT1l0S1JNSHh0RDUxcUUzSmRRYzRkaG1HVXNVWjFPREExOWR6cERT?=
 =?utf-8?B?dEppZHJsNlpLOXptRHhwbE16eHNrVTczUlBqdnNkNUJlbXZmTEs3QlJONGZD?=
 =?utf-8?B?WXlud1hFalFhd1B5NnhXUldDdytxNWJjZmhxQmY5SysyYS92OXVYMWhHbmtn?=
 =?utf-8?B?WWpFVzEvNjE0TlFwakdtSVdscVM5U3hkaUlKaVFFWmlFb3R2UlRSOExFUmll?=
 =?utf-8?B?b2Q3aEZQMDhJeGpEMmdRMXFPV1hQMi91bWNvZEJ3TXhHd0daWlVCdFp5RzE4?=
 =?utf-8?B?bEhQL1NaRTlsYWptaTlYVDcxM2RKUm9yZTdRd2grSHltbll6TTgzWjZYa3hH?=
 =?utf-8?B?a2c4akJJZU9pcGNmSUVvMk4xSWhLcDZVQnRwTUsxcEN6TnVxOTlXZjhnaFZM?=
 =?utf-8?B?VnFVYUJXOEEyZElMTVBOdUFvaE5Bd1hKb05Oa2R1eEY0TDM2VmFNNFRFQ1pi?=
 =?utf-8?B?alZNWWRLeFlJRnN4b01ZbytrcEVvV1ZXdnM1WU42Y1o2cmV6aDB2bCtOR2dN?=
 =?utf-8?B?WnArajRyVjEyUzNxekVNc3hnRjBSc2ZROXQ5Si9KT1lJY0FDVitRLzBuNzdV?=
 =?utf-8?B?QnptZEUzUHN5NWQ0b3NBR3NjaHlYUU5Sck5PZWdwakhxZURnZXI3M1ZvWEpa?=
 =?utf-8?B?Q2xjS0pCRzR2amFCcERlWlhVeFB4YVoyUGRxRTVnbXpuVDhWbkFvaU4zN3pK?=
 =?utf-8?B?aWtyZDQ2b3hncGxFVXZIOHc0Y0hubkQ1MExYalZVZjJhSXVoMDBTQWhlSllB?=
 =?utf-8?B?Y2FQajhzOTFwZlJtT09rVTNnaGx3MzJyTnNHNGpwMVNHbVV0YnRaRzVNb2cw?=
 =?utf-8?B?Y2VpbG4yNnRDd2dIcmlBSk9vTmt4UE9ZYlRWY1RtWS9LREFYY0RjQjlIazNs?=
 =?utf-8?B?NmQyaXZSYUVXTTVidmtwVjhIUmt5M3NpbmRkcjJsZlkyT0ZsVWNpN3Y4ZWVa?=
 =?utf-8?B?Wnl1TkliS3Q3OVU3SXpCdnUzSGJHNVJJNDdoR29Ta05FSXBCNmtaNkRpTUJr?=
 =?utf-8?B?Si9jMENtaGtUQXZ5eHg3OHlpNkorREdVVkc5TWdSVEoyUmRibGEyRnV5VG5r?=
 =?utf-8?B?UU1ST3ZyUHdncUVqUUVTQVBGYk5pV1NsdlpFR3hlQWVXTzRwWVZGUmhsMG9s?=
 =?utf-8?B?UktyU3hnSXpXZEdFK1lFTFpVb1J2T00rN0RwdjU3SHdUMGJhY2k1Y1NCK3JI?=
 =?utf-8?B?WlBZSVBkdmdGenRDNkpXa0dTZUJzbGdFWjRWN3NvMEhvYjZOMFhUcXQ2SThl?=
 =?utf-8?B?SmFNNlRtbFdadElCVkt1eG5WUittSkhhYzVvZzVkWkVONVdCbUNROUpBaVF2?=
 =?utf-8?B?ekRYWnM3K2l6blo1OWtVRVpyWHlGK1lCOTlJK053V3ptVTErZE55WWVqeUNt?=
 =?utf-8?B?YWR0SWh1d205eVhOQlBGSEFhR0ZONW4vM3lrellRUS9OZG9MREJtTS9oSW91?=
 =?utf-8?B?K1paWStRb2h6SkZ3SnZNYVEwUzdvZVFxRFZZbC9Wb2F4TnhCYmR2RzBtRjVk?=
 =?utf-8?B?N3k2SWR2Y0hGZDI0cmg1T3VZNm4wVXByRjJoL0MvSE81US9Na3grRjF1Rjdp?=
 =?utf-8?B?aTRjUDZzS25qS3YxZ3JXR0hTL0FKcXBZUlV2ekNnUkNqMktoRjVleGZQc29F?=
 =?utf-8?B?Y0FIN1NGM1A3bXNWSEJYZC9lampjaDBQTWE5cGIzNmQ1Z0dVWmNuZmowRFhN?=
 =?utf-8?B?bk1PT3NjRXZTeWx0TW9CWm5mbC9rZnBPWStHNFYxb2xKMjN6VklLU3krd3hy?=
 =?utf-8?B?WFBneHBHK1B3V3FRZTRyOFlDTWxua2NEazNMZnR0eDFnbFIwOW05c2F6QVZj?=
 =?utf-8?B?UHJyKzdRWGh6bE1LTEt1cUhkcWk3aFI2ZTNxanZJUjdzVklsb2hkenRXVmRW?=
 =?utf-8?B?a3FEUkZhVHI4UTFPeXJYNTNWOUh2WnRzS2RaV2RjbG9wTkN1NlUva3VVMUZx?=
 =?utf-8?B?VEx3NDM1VVQ0M1Vsck5kNk1RbWR1cXQ2MlJIMWZiZnJ6cVE3T2lYV01FQXBG?=
 =?utf-8?B?UC9pNmUzM3VpQ3JYMTRmTkg4VEdwYXFXQUZ2dXBUSXJOQ3FLMEM5czI5QmNK?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5cf0d1-8c55-4cd0-a087-08db8a12e1a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 17:49:50.2465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hf5QprkiCvF4f9KF4Uv0R34ou6yWy2KeXpvjfpLL+mb44t7d9gdej9FRjcvgHjrBQ0jbt1s8m8xfAz2F6QvEJlryocFvTUwkOdnX2A4z+Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3748
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IFNlbnQ6IE1vbmRheSwg
SnVseSAxNywgMjAyMyA0OjE2IFBNDQo+IA0KPiBDb252ZXJ0IGFsbCBwbGFjZXMgd2hpY2gganVz
dCBhc3NpZ24gYSBuZXcgZnVuY3Rpb24gZGlyZWN0bHkgdG8gdGhlIGFwaWMNCj4gY2FsbGJhY2sg
dG8gdXNlIGFwaWNfdXBkYXRlX2NhbGxiYWNrKCkgd2hpY2ggcHJlcGFyZXMgZm9yIHVzaW5nIHN0
YXRpYw0KPiBjYWxscy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPg0KPiAtLS0NCj4gIGFyY2gveDg2L2h5cGVydi9odl9hcGljLmMgfCAg
IDIwICsrKysrKysrKystLS0tLS0tLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwva3ZtLmMgICAgIHwg
ICAgNCArKy0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvc2V2LmMgICAgIHwgICAgMiArLQ0KPiAgMyBm
aWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gDQo+IC0t
LSBhL2FyY2gveDg2L2h5cGVydi9odl9hcGljLmMNCj4gKysrIGIvYXJjaC94ODYvaHlwZXJ2L2h2
X2FwaWMuYw0KPiBAQCAtMjg4LDEyICsyODgsMTIgQEAgdm9pZCBfX2luaXQgaHZfYXBpY19pbml0
KHZvaWQpDQo+ICAJCSAqLw0KPiAgCQlvcmlnX2FwaWMgPSAqYXBpYzsNCj4gDQo+IC0JCWFwaWMt
PnNlbmRfSVBJID0gaHZfc2VuZF9pcGk7DQo+IC0JCWFwaWMtPnNlbmRfSVBJX21hc2sgPSBodl9z
ZW5kX2lwaV9tYXNrOw0KPiAtCQlhcGljLT5zZW5kX0lQSV9tYXNrX2FsbGJ1dHNlbGYgPSBodl9z
ZW5kX2lwaV9tYXNrX2FsbGJ1dHNlbGY7DQo+IC0JCWFwaWMtPnNlbmRfSVBJX2FsbGJ1dHNlbGYg
PSBodl9zZW5kX2lwaV9hbGxidXRzZWxmOw0KPiAtCQlhcGljLT5zZW5kX0lQSV9hbGwgPSBodl9z
ZW5kX2lwaV9hbGw7DQo+IC0JCWFwaWMtPnNlbmRfSVBJX3NlbGYgPSBodl9zZW5kX2lwaV9zZWxm
Ow0KPiArCQlhcGljX3VwZGF0ZV9jYWxsYmFjayhzZW5kX0lQSSwgaHZfc2VuZF9pcGkpOw0KPiAr
CQlhcGljX3VwZGF0ZV9jYWxsYmFjayhzZW5kX0lQSV9tYXNrLCBodl9zZW5kX2lwaV9tYXNrKTsN
Cj4gKwkJYXBpY191cGRhdGVfY2FsbGJhY2soc2VuZF9JUElfbWFza19hbGxidXRzZWxmLA0KPiBo
dl9zZW5kX2lwaV9tYXNrX2FsbGJ1dHNlbGYpOw0KPiArCQlhcGljX3VwZGF0ZV9jYWxsYmFjayhz
ZW5kX0lQSV9hbGxidXRzZWxmLCBodl9zZW5kX2lwaV9hbGxidXRzZWxmKTsNCj4gKwkJYXBpY191
cGRhdGVfY2FsbGJhY2soc2VuZF9JUElfYWxsLCBodl9zZW5kX2lwaV9hbGwpOw0KPiArCQlhcGlj
X3VwZGF0ZV9jYWxsYmFjayhzZW5kX0lQSV9zZWxmLCBodl9zZW5kX2lwaV9zZWxmKTsNCj4gIAl9
DQo+IA0KPiAgCWlmIChtc19oeXBlcnYuaGludHMgJiBIVl9YNjRfQVBJQ19BQ0NFU1NfUkVDT01N
RU5ERUQpIHsNCj4gQEAgLTMxMiwxMCArMzEyLDEwIEBAIHZvaWQgX19pbml0IGh2X2FwaWNfaW5p
dCh2b2lkKQ0KPiAgCQkgKi8NCj4gIAkJYXBpY191cGRhdGVfY2FsbGJhY2soZW9pLCBodl9hcGlj
X2VvaV93cml0ZSk7DQo+ICAJCWlmICgheDJhcGljX2VuYWJsZWQoKSkgew0KPiAtCQkJYXBpYy0+
cmVhZCAgICAgID0gaHZfYXBpY19yZWFkOw0KPiAtCQkJYXBpYy0+d3JpdGUgICAgID0gaHZfYXBp
Y193cml0ZTsNCj4gLQkJCWFwaWMtPmljcl93cml0ZSA9IGh2X2FwaWNfaWNyX3dyaXRlOw0KPiAt
CQkJYXBpYy0+aWNyX3JlYWQgID0gaHZfYXBpY19pY3JfcmVhZDsNCj4gKwkJCWFwaWNfdXBkYXRl
X2NhbGxiYWNrKHJlYWQsIGh2X2FwaWNfcmVhZCk7DQo+ICsJCQlhcGljX3VwZGF0ZV9jYWxsYmFj
ayh3cml0ZSwgaHZfYXBpY193cml0ZSk7DQo+ICsJCQlhcGljX3VwZGF0ZV9jYWxsYmFjayhpY3Jf
d3JpdGUsIGh2X2FwaWNfaWNyX3dyaXRlKTsNCj4gKwkJCWFwaWNfdXBkYXRlX2NhbGxiYWNrKGlj
cl9yZWFkLCBodl9hcGljX2ljcl9yZWFkKTsNCj4gIAkJfQ0KPiAgCX0NCj4gIH0NCj4gLS0tIGEv
YXJjaC94ODYva2VybmVsL2t2bS5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9rdm0uYw0KPiBA
QCAtNjI0LDggKzYyNCw4IEBAIGxhdGVfaW5pdGNhbGwoc2V0dXBfZWZpX2t2bV9zZXZfbWlncmF0
aW8NCj4gICAqLw0KPiAgc3RhdGljIHZvaWQga3ZtX3NldHVwX3B2X2lwaSh2b2lkKQ0KPiAgew0K
PiAtCWFwaWMtPnNlbmRfSVBJX21hc2sgPSBrdm1fc2VuZF9pcGlfbWFzazsNCj4gLQlhcGljLT5z
ZW5kX0lQSV9tYXNrX2FsbGJ1dHNlbGYgPSBrdm1fc2VuZF9pcGlfbWFza19hbGxidXRzZWxmOw0K
PiArCWFwaWNfdXBkYXRlX2NhbGxiYWNrKHNlbmRfSVBJX21hc2ssIGt2bV9zZW5kX2lwaV9tYXNr
KTsNCj4gKwlhcGljX3VwZGF0ZV9jYWxsYmFjayhzZW5kX0lQSV9tYXNrX2FsbGJ1dHNlbGYsDQo+
IGt2bV9zZW5kX2lwaV9tYXNrX2FsbGJ1dHNlbGYpOw0KPiAgCXByX2luZm8oInNldHVwIFBWIElQ
SXNcbiIpOw0KPiAgfQ0KPiANCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3Nldi5jDQo+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9zZXYuYw0KPiBAQCAtMTA5OSw3ICsxMDk5LDcgQEAgdm9pZCBzbnBf
c2V0X3dha2V1cF9zZWNvbmRhcnlfY3B1KHZvaWQpDQo+ICAJICogcmVxdWlyZWQgbWV0aG9kIHRv
IHN0YXJ0IEFQcyB1bmRlciBTTlAuIElmIHRoZSBoeXBlcnZpc29yIGRvZXMNCj4gIAkgKiBub3Qg
c3VwcG9ydCBBUCBjcmVhdGlvbiwgdGhlbiBubyBBUHMgd2lsbCBiZSBzdGFydGVkLg0KPiAgCSAq
Lw0KPiAtCWFwaWMtPndha2V1cF9zZWNvbmRhcnlfY3B1ID0gd2FrZXVwX2NwdV92aWFfdm1nZXhp
dDsNCj4gKwlhcGljX3VwZGF0ZV9jYWxsYmFjayh3YWtldXBfc2Vjb25kYXJ5X2NwdSwgd2FrZXVw
X2NwdV92aWFfdm1nZXhpdCk7DQoNCkknbSBnZXR0aW5nIGEgYnVpbGQgd2FybmluZyBmcm9tIHRo
ZSBhYm92ZToNCg0Kc2VjdGlvbiBtaXNtYXRjaCBpbiByZWZlcmVuY2U6IHNucF9zZXRfd2FrZXVw
X3NlY29uZGFyeV9jcHUrMHgzNSAoc2VjdGlvbjogLnRleHQpIC0+IF9feDg2X2FwaWNfb3ZlcnJp
ZGUgKHNlY3Rpb246IC5pbml0LmRhdGEpDQoNCk1pY2hhZWwNCg==
