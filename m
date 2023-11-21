Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5367F2366
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjKUCBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKUCBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:01:10 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B0F85
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOOX5m549UdxCSZy+NfGA1Slieo5PSiNMsCBMLngqM0DKLwE/9xaKAXg/o7HnLnD96xBKEwLwxKLxmScaXXGixqDoAsF7GBJzogBqDItRbPd6VyurGvUVebsKLnhTNAleB2qM+eJ1i0TqxaUWwb9XdWz6NtsjjSPEASwoKZKc8E4z0J0osx9u+1UszvoS+vya5LDKD6cjRDmuO8lnqbmlCZc1OBSf6YSTdr934Cea5V0ObOR8x/0H4rtqDnmchHNmp3yuCiEOds3LDZZ1mFRsST4BRhtckftNYnwGYjLtroePCCKisXHfmy5h8rFHYaAiD8ZjBlPq5XPMnd9oxb67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9s7V8irGKHPaAhkuKl7Kxl8IhtmBl5S1xbdycjYYyI=;
 b=Umakx1hjt0Ws6G8oDEvtN6+aivvSWtvp2s+TQb/n2rLwXf6WjhTFktPODLNVzmffxKDvtUuSbzAH4yHPRnYkpNxKdV4vS+YdKH3BUpvbhEUNNoyDyASK9M82cBYdH6A5GGMt9sQJUMHM/Yhm1owzhUHmiqImGYsmFQrLozq1HCKh4QZ15puJJ3TTDp+0IThvXIDqe8Qu29yVdrveP56OVL2HXIlKyHsZj+olkhdyk33wtKaUYGOZ9lxJvKbqvrtq36mC740fdTL15FHRgTpgDKk1AzxHoFoEo4ZPbVvu6tvmtrXaH0Y0BOmR6UN/WUTRjSLUEQAUwR2oTUxC1W1vgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9s7V8irGKHPaAhkuKl7Kxl8IhtmBl5S1xbdycjYYyI=;
 b=kGBKMhO7FGM7RRE3RqqJLd/YJ/g6TGWMhTtolKPqhEu+P01y1lamM58LuvZmRH0PMWbIOSUz/CCxJfKtpbIj/g2F2LKpH5vGotH2oZFcZ8JM3/1IrLsvUKkIoQQ2A32A4uCTdYbHQtuEKeqJNzI8d/D5wCoQF0RTf99tZypZZ7w=
Received: from DB9PR08MB7511.eurprd08.prod.outlook.com (2603:10a6:10:302::21)
 by DB5PR08MB10113.eurprd08.prod.outlook.com (2603:10a6:10:4a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 02:01:02 +0000
Received: from DB9PR08MB7511.eurprd08.prod.outlook.com
 ([fe80::ed8d:8ab6:c458:5b29]) by DB9PR08MB7511.eurprd08.prod.outlook.com
 ([fe80::ed8d:8ab6:c458:5b29%6]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 02:01:02 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Marc Zyngier <maz@kernel.org>, Cornelia Huck <cohuck@redhat.com>
CC:     James Morse <James.Morse@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rmk@armlinux.org.uk" <rmk@armlinux.org.uk>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Justin He <Justin.He@arm.com>
Subject: RE: [PATCH] arm64/kvm: Introduce feature extension for SMCCC filter
Thread-Topic: [PATCH] arm64/kvm: Introduce feature extension for SMCCC filter
Thread-Index: AQHaGIJU1EOztFCd60Gb0pK7SioEprB86xkAgAAUTYCABwv20A==
Date:   Tue, 21 Nov 2023 02:01:02 +0000
Message-ID: <DB9PR08MB75117BC1B16AA3A2BC9623E7F4BBA@DB9PR08MB7511.eurprd08.prod.outlook.com>
References: <20231116114152.912344-1-jianyong.wu@arm.com>
        <877cmhq1zp.fsf@redhat.com> <8634x522z2.wl-maz@kernel.org>
In-Reply-To: <8634x522z2.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: C74EA30ED8596F4B9798BD948448CE87.0
x-checkrecipientchecked: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR08MB7511:EE_|DB5PR08MB10113:EE_
x-ms-office365-filtering-correlation-id: 5a4cc639-59ed-4e24-f7a8-08dbea35b6fe
nodisclaimer: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kLESNgNNsKT0U15xZqbGunNiMdMIV/6b3ur1xRlgkW9Kkw4hyrn5QB0ux1UoOkygMgYicjQYVqUHwnzJYHIq6LpImeidxiqQ8xKQpll/gDiCR/ip5iNpm2vGysK+2kOdXpHXk3ER20jREVlN0+vrr8loW/J1CxOdOKLPV3B02iWAMVRsbdrbuAYrAM1l4s9MLqjY0ShbG2sIAVsG6Meq7Jpvfawr2KkQihchftGv4iyvGdKMEOYFO24FiOB/R5JZzHbBezhWOKWrjHdykwIiJaSeQoh9jh1qemt7qIshdyL2VEueF08eUhUI8PldPA6bzXBG0Erlgzjr6bjRBKKP9CirKDMz38kEikdBuyzfqhhodVcm52YhksSeZcsGCKiZdlp4Bq9TW6ddQwCokYoQ2iY52Soj5sCvxf/EIJUMlkrlzYVMqoIbx4K53+rTgQ48SgrjoJrPrJsXAtu+3ywXDCyogk6n/HJP8eSuQVbmrKQBrJ3okJNaeYHGlVSWXKsA+1NrkAOVRRDEfInC+IfvQToSTz3gUYf3St15yyxgmbW2YTf8QMOVEMhp18L7Ys9SIJTq/NpoaG/YXygYArlKpka5YsF632pfK37Ra2mLvlr2d+YKwzmRITcyxoocUqBU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7511.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39850400004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(7696005)(53546011)(26005)(71200400001)(9686003)(55016003)(316002)(478600001)(122000001)(83380400001)(66946007)(66556008)(110136005)(66476007)(54906003)(64756008)(76116006)(66446008)(52536014)(8676002)(8936002)(4326008)(86362001)(38100700002)(5660300002)(2906002)(33656002)(41300700001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S0dHcTRVYjRxNWZDQUtFZUxVU0xYNGNjNkRaakRvRjVlRUc1MzVVK3hGTGRH?=
 =?gb2312?B?bHpaMGdYb2swMjlCWmlFcmJLVFp1RWRnWEw0RVNjTDYrRjA1K1BsbllDMXBn?=
 =?gb2312?B?R05qZFZjM2x2UG9peDNMeldhS0pmOFU0bkVhMWluSmpBVkNqVUdjQTAxSkdW?=
 =?gb2312?B?eFloYmdsVHZodWk4NExLbDF1c2ZDM0puVE9IUmorLzJxWUVLcm9UTy95V003?=
 =?gb2312?B?QUFVVEVibXFjaGV5V3dpcE1NaWRWOUV1QWhvM1YyUU9iLzhjU055NStHMHZV?=
 =?gb2312?B?OEh5dFJDWXVlUGVhc3RWRGg0enhGWnRyclV5UFVHRWszVEQxU3hNMy9uaGRS?=
 =?gb2312?B?eDd1RExrQVY3eFhsTVpBOVFacnIyVnNQaWtPZHhWRU9zM3BTY2JlOWNHSGlw?=
 =?gb2312?B?Nmd1ZVlCZjFybTY4RFpCOXV4NEhOMk5WaWlHbUNHQ1NzSzRTN2xJbU1taFJW?=
 =?gb2312?B?RFV3SkkyOU53eDBNWm45TkhRWmNDNnFwU2tjV3Fqei8vRVRoZ1pPcWdLVVNI?=
 =?gb2312?B?N0JvQ1pIY1k1K1dzVS9kSmE3bmZyV1lwcTZxVnBzcjkwc1VGdm0yWVhDRWhV?=
 =?gb2312?B?V1psT1E3SE9JWG1RbnpkSm5HOWw0ckwycWlBQlVITjRjWUExOVRpcU5PRFRa?=
 =?gb2312?B?YVo4Nk81dkVnaGd6MTcrYnJHeXZWemlMbzdSTWxHMTFIdytzM3BHT1JKMGQ4?=
 =?gb2312?B?NWZsYXgvM1dkczZkTElsVWJBZitiVzZDUGRXL205OW9CU1M2Ym1wdHJCY3o2?=
 =?gb2312?B?NE5td2p1b3I3SU1GQUZxZkwxUDlEWTdudlg3Z0JuTElZYjdzMU5lTXhCb0ZF?=
 =?gb2312?B?cXg5V2JRTUR6MTFvSGc0aUlvbVl6b3k3bU5UZ25URW5ZR3ZYYW5VUDNyVVRE?=
 =?gb2312?B?RENoTUo5SS85QlpiMVJFZTNjNEhNcGZDaTRxcTQrdkY1Z1pPTktiaENwZTgx?=
 =?gb2312?B?bVRDMGFlNVlPWUg2T3pyTmo1c3VCcEZzT1R2SWxZSDRsdmdZUFlSR0hJa2k5?=
 =?gb2312?B?Y1N2UGI5NXVpT01rWkwwV0JwY3h1VEVSQm04cFp2VzA0S0dMUHU1cDRMYkU0?=
 =?gb2312?B?MUVBN3NoMUY5dDJkZlZmZTdJSTNURk1QV1pzbkZvc3kxUEVCR1ZrKzV3N2lI?=
 =?gb2312?B?WEkvdjJYSEMxYVpEY2wyZkl5TUxsaDRuNWNtbVFzSmlmcmxnRjJDWGlxTmc2?=
 =?gb2312?B?d2p3V1FHWUNHU0NRTjdWTFIrS2pZZ01BVTg3M25LUFo0cStxMHBQc2wzQThq?=
 =?gb2312?B?Z3ZDQ2lBTVJKTU9QbkNXMzR2dnNhWkZJRkdleVFRZ29Ob0RrZVgza2V0UGtD?=
 =?gb2312?B?V0xYNlZCekVTTXBXM3VHYmNPK3Z2RGhTaml2UmhIWnZtenEvZXBob3gyVHpt?=
 =?gb2312?B?WGQwSGtRNTIrZUl1OUhaUWZBbGVPQmord2ZRdzQ4eWtjWksvWjdPUGk1MU1I?=
 =?gb2312?B?RWlWZXM0TzA4MklPUjdEQVBFbGJGaDViREU1cjYrclgvQ3U5UzdTZ1RiVVNv?=
 =?gb2312?B?WjJVcDUyRm9Mdkt2WnkzOHpnV1M0Vm14K05vZEtndUhad2U4WjA1YmhjWllV?=
 =?gb2312?B?enVwTjkyc1lZNW9zdTlIVll3aEdCV0NsMGlKdjlNUDFVd2FVRCs2NEs4dHMx?=
 =?gb2312?B?RjZqa20ySGxqcFhLUWNpaTJzQy9lSjMzdm55MG16d3JsMnYrR1JqbGN2Y2Vp?=
 =?gb2312?B?NTZ5VnlGYUM2UWJUNWdhOCtzNDNoOWNZTWJONnFDK00yeU5Rc2RVQ2NDUUx1?=
 =?gb2312?B?c3pRaTBqYUtKbEZxZzBxVkg4bDVQRmlmVE5XUXI4VHJ0L0c1U3RDRCszQVkw?=
 =?gb2312?B?WnU4VDVnYTNyd1p1MWhSM2tMV0dlbmRENll0Qks1QWdlZVFVSkM4eCtObmV3?=
 =?gb2312?B?ZmNZc2g4N1pwTGtRV2craHFRWkp6SitSMnd5SWh0RkVhL0srRC9lN01XVC90?=
 =?gb2312?B?TG5VTjZac2pHS3padFA1QkdNcU9SaWZZQVJOOFA1ZzNBSE5rUzBNd1FTei9p?=
 =?gb2312?B?Y3FkS0ZWc1VvYklLYjc5SGJuWmxtemlCK01qVjBYY1BrWUIwUUVVWFp4K2N6?=
 =?gb2312?B?M1kwNitYR0tmTWpMTTBPaFFYczl5bG9QajB1M2xwelV0THVHUm9wYUNxUnZ3?=
 =?gb2312?Q?mWruXujscFD+lRaIxTuWZDXMa?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB7511.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4cc639-59ed-4e24-f7a8-08dbea35b6fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 02:01:02.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3MjVK/nTLW5lHzu/lREKJi6t8+IdZOwABSp3L4CPk4+6ZRjFYckJEV+LMPzEXeeEmldIH7jonMKjTprrV9lHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10113
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBaeW5naWVyIDxt
YXpAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyM8TqMTHUwjE2yNUgMjI6MjINCj4gVG86IENvcm5l
bGlhIEh1Y2sgPGNvaHVja0ByZWRoYXQuY29tPg0KPiBDYzogSmlhbnlvbmcgV3UgPEppYW55b25n
Lld1QGFybS5jb20+OyBKYW1lcyBNb3JzZQ0KPiA8SmFtZXMuTW9yc2VAYXJtLmNvbT47IHdpbGxA
a2VybmVsLm9yZzsgcm1rQGFybWxpbnV4Lm9yZy51azsNCj4gc2FsaWwubWVodGFAaHVhd2VpLmNv
bTsgU3V6dWtpIFBvdWxvc2UgPFN1enVraS5Qb3Vsb3NlQGFybS5jb20+Ow0KPiBvbGl2ZXIudXB0
b25AbGludXguZGV2OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGt2
bWFybUBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEp1c3Rp
biBIZQ0KPiA8SnVzdGluLkhlQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTY0
L2t2bTogSW50cm9kdWNlIGZlYXR1cmUgZXh0ZW5zaW9uIGZvciBTTUNDQyBmaWx0ZXINCj4gDQo+
IE9uIFRodSwgMTYgTm92IDIwMjMgMTM6MDg6NTggKzAwMDAsDQo+IENvcm5lbGlhIEh1Y2sgPGNv
aHVja0ByZWRoYXQuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFRodSwgTm92IDE2IDIwMjMsIEpp
YW55b25nIFd1IDxqaWFueW9uZy53dUBhcm0uY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gODIxZDkz
NWM4N2IgaW50cm9kdWNlcyBzdXBwb3J0IGZvciB1c2Vyc3BhY2UgU01DQ0MgZmlsdGVyaW5nLCBi
dXQNCj4gPiA+IGxhY2sgb2YgYSB3YXkgdG8gdGVsbCB1c2Vyc3BhY2UgaWYgd2UgaGF2ZSB0aGlz
IGZlYXR1cmUuIEFkZCBhDQo+ID4gPiBjb3JyZXNwb25kaW5nIGZlYXR1cmUgZXh0ZW5zaW9uIGNh
biByZXNvbHZlIHRoaXMgaXNzdWUuDQo+ID4gPg0KPiA+ID4gRm9yIGV4YW1wbGUsIHRoZSBpbmNv
bWluZyBmZWF0dXJlIFZjcHUgSG90cGx1ZyBuZWVkcyB0aGUgU01DQ0MgZmlsdGVyLg0KPiA+ID4g
QXMgdGhlcmUgaXMgbm8gd2F5IHRvIGNoZWNrIHRoaXMgZmVhdHVyZSwgVk1NIHdpbGwgcnVuIGlu
dG8gZXJyb3INCj4gPiA+IHdoZW4gaXQgY2FsbHMgdGhpcyBmZWF0dXJlIG9uIGFuIG9sZCBrZXJu
ZWwuIEl0J3MgYmFkIGZvciBiYWNrd2FyZCBjb21wYXRpYmxlLg0KPiA+DQo+ID4gQ2FuJ3QgeW91
IHNpbXBseSBxdWVyeSB2aWEgS1ZNX0hBU19ERVZJQ0VfQVRUUiB3aGV0aGVyIHRoZSBTTUNDQw0K
PiA+IGZpbHRlcmluZyBjb250cm9scyBleGlzdD8NCj4gDQo+IFF1aXRlLiBDb21taXQgZTBmYzZi
MjE2MTZkZCBpbnRyb2R1Y2VkIGl0IGZvciB0aGF0IGV4YWN0IHB1cnBvc2UsIHNwZWNpZmljYWxs
eQ0KPiB0byBwcmV2ZW50IGFkZGluZyBtb3JlIG9mIHRoZXNlIGNhcGFiaWxpdGllcyB3aGVuIHRo
ZXJlIGlzIGEgY29ycmVzcG9uZGluZw0KPiBhdHRyaWJ1dGUgdGhhdCBjYW4gYmUgcmVhZGlseSBx
dWVyaWVkLg0KDQpFeGFjdGx5LiBDb21taXQgZTBmYzZiMjE2MTZkZCBoYXMgZG9uZSBmb3IgdGhp
cy4gSWdub3JlIHRoaXMgcGF0Y2guDQoNClRoYW5rcw0KSmlhbnlvbmcNCj4gDQo+IAlNLg0KPiAN
Cj4gLS0NCj4gV2l0aG91dCBkZXZpYXRpb24gZnJvbSB0aGUgbm9ybSwgcHJvZ3Jlc3MgaXMgbm90
IHBvc3NpYmxlLg0K
