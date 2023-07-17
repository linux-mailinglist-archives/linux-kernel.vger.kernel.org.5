Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F95B7560CC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGQKox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjGQKov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:44:51 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2131.outbound.protection.outlook.com [40.107.113.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05282BC;
        Mon, 17 Jul 2023 03:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPp0i0Rlc80tIdxcZnpdm+mhXRzgpoinAROXhP0uWb2ARD5duKGWtyIMasa2cD9q6HbnEzD7eKHK8tQWuluxdFy3zkZ+2/k3HRRW3sTyZwl9KAMLMKccsdXEdiPfWUQqREBLUwePkfBeH0IS1as97xTJjyVYUlTG6pvzmHIBsbFNFOn2vGClnwkZTNlZ/GXo0csPoA3BASBVzJHQs6hyjiw09hNMEdP7pJmo+9rmiDZIvhKoSVAycry9xy+x3hs6ZMWotjyhUAcdRqt1d4JnccMk6PxYdjBMQCl6jyo1bkqrv6rwmPEMw4vKlKTl6T4W/kdPwmnU8XFkmKX+3A1STQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFA/ZYwgEixBxYNP9QKxP/SahgYbe6yQ9+dRrSCWc3k=;
 b=LAmaICxS/xCf9XCArAfrqxReZhr7nF1pFsKxfA0BwPj1geaXUCdVlZ/3C6PseVQrRXqSgoIVI9k0mQRMzNnT61VP2p+4bywehGr5qgwoAUvXRskA+dgMfcvQuMoNhXsi2LVCnWgdcEtgUgjOfsFssOUckiBN2tR1ARxlBJC1aKsMd6cpYQfGeJnplvMP2RKtEKMMs7GsqlTygnOstRVi4+6uy+7AQPdSpFgcCfVseO3O++Et8ZuOOjY+vGtUpUe08tsgTMxbyeC5xJEzQZTjA6pMv2lVos7lEsYUFRCvzACAmENqvk48mWcjAdi3SFzzZWwdpyG+ioOfjbFIDfah4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFA/ZYwgEixBxYNP9QKxP/SahgYbe6yQ9+dRrSCWc3k=;
 b=iUAcsOMf8mrhgBw5IerbnjQ01xoRgYYS1FriacxtmvXwCICwMOMmyJl1SwnVvcnnPWSVy/RkX+NXdaym1j035Mrdzqmeg/6yJC421h7gFu1TjQPl4Dj0hqMpjUcQFsJr3SVJNdKsXG+s4cuqa8DlNSyrl/YqrXiK1XROC3B6V7o=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB10664.jpnprd01.prod.outlook.com (2603:1096:400:291::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 10:44:47 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 10:44:47 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 06/10] spi: rzv2m-csi: Squash timing settings into one
 statement
Thread-Topic: [PATCH 06/10] spi: rzv2m-csi: Squash timing settings into one
 statement
Thread-Index: AQHZtrhTlrRadOTQFkS2KnXOj1xxl6+6ddAAgANSGXA=
Date:   Mon, 17 Jul 2023 10:44:47 +0000
Message-ID: <TYWPR01MB8775831C81B7153DB24F86C2C23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
 <20230715010407.1751715-7-fabrizio.castro.jz@renesas.com>
 <CAHp75VdyUhvk9JA4oW6iYjK=YdatjG3OVa0APMQrc+un2EyadQ@mail.gmail.com>
In-Reply-To: <CAHp75VdyUhvk9JA4oW6iYjK=YdatjG3OVa0APMQrc+un2EyadQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB10664:EE_
x-ms-office365-filtering-correlation-id: 2d172c08-95a2-4f82-1f2e-08db86b2d6e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uWTd7HE1wYl8aSeQVZOL1zu3WykByENKjq8zBHWxlrqxe/ChhZQStMCqPmZ4d+Q8hGp+JTeXvWU4rupM7e5Z3G5aSKuwuSwGJlauSIX8bmcNouGNg6sI28PqFQWS++yV7I7AwE7t30vhDAMPePbaviY0FVrGV3OIlLY6CFrCVcXRb7BpotuhKThvwDWTzYxsnDnc4dB8nMF083MwaZq5FgLfbxCIVSAiwy0dSdKT92+jsYto8Pd1UL68PbQYP6puVEisOvIPrJ1u6kjN75v1IF2gu++tLxzLkJtZSzh+W2dzreBzGyz2k815A8ATsH5o5A1rzyed6SGw+RIqN2wFKJqvul0GA3Ldrs67HetswrBl1abiige6Bic57PmZ5lb1kbH9Q5BIJaWHs7W4bnPTRfZLPelxG25bH5LWKAHwjiDpFgZtov45X8HbfB7RgVAr6hudDonZJeqpjjQQ2EMP14XQg+RjIQ4Ca1QPteUoZfYKw2nwVDFLMaipfvuohpd9EDgMyJrP0DH7XkCx34bbQJtvSLwoREFW+IMAWY/xeyqX+4EI2SQWRX51e1L8h4VsvqjcV/6DQTHR8ikQgLMAYwFu4kl1WiOcpty4ivnh4s3FisSrTXvpMPN3KRczzLIb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(86362001)(2906002)(33656002)(38070700005)(55016003)(186003)(83380400001)(9686003)(53546011)(6506007)(26005)(38100700002)(7696005)(54906003)(122000001)(71200400001)(316002)(66946007)(66556008)(66476007)(76116006)(6916009)(66446008)(64756008)(4326008)(41300700001)(478600001)(5660300002)(52536014)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djJnWWUzTWllOXhtNHVLaXFKRkFYbzJyTFRkYk5hM2ppSUI0QldIOGM5L2li?=
 =?utf-8?B?SWhFU3NSeThDU2twZXFOekYxbzlNdGJOQjNWV1FZVzhZVXAxSU8xRlY2M3Rq?=
 =?utf-8?B?bk1vN2I2emV2Vm1JYmZUd3lJYjg1R3BJVTlFM2tnVnUzK0Z0aHVzSXgxcDBl?=
 =?utf-8?B?Sng3VUJBdkpTSkJQbm1qOStrRE9lSkNBamxTMXIrQnJEU29SUk9ZMkhUY3da?=
 =?utf-8?B?T0QvVFpGdUVBV2dYM1hoenFuc05TQ0hMR3EvaVhZV3BTNHNwMFkxa281WkhE?=
 =?utf-8?B?NU91SHZPellRcjN2dllZQktXRXF1dFVxUE1iNXNFNzNZaXlIVGorQzc2QytZ?=
 =?utf-8?B?VzEvM1hFakxUMXNvVEFBeW1DdlRoQW1BM1lsTCtic0l4ZW9ZUlBDRi9zOWhR?=
 =?utf-8?B?OFdtb2Z2b0VRSjljd0ZRUXJzOVpLM1FSL2ZLcVpCS29hTE1XOExwcFhydU9L?=
 =?utf-8?B?RUM3ZXhmbmN1SSttam9aNEw4YnpRMTYyYmFVaDZvTXAzTWZkMWNrSFliN3BD?=
 =?utf-8?B?SmxoRlhQOWZvT3lvV1FPd2MrYm5MRzFxTzdNTU9VYUcxaEZ3L25URk80V25n?=
 =?utf-8?B?bC9sUVZMUHkyRjV6dGNrRXZFK2lOZ3JHZG00Qmp6UHJUSDY1Rm51VVBoS2VK?=
 =?utf-8?B?eW1SQkd5WTBaUG55aGtjdktleGwyQW90WGdUOWx1RE1aaDlTaDZVSmFtL3Qv?=
 =?utf-8?B?MzkyWEJNcU9KNWZFaC95ZWJVVGVnNTJ4ZWtLM1dWKzdFQm50ZmZwR1hhNURG?=
 =?utf-8?B?WkxiSGduSE1OYnBtYVBMWjRLY2ExL0VDT0cyVHhneGp0TEMzRStkOGxIRDZB?=
 =?utf-8?B?L29wYnNlbVZPc0ZnR21JdUJSMy9ranpSS0xoaXNCaDlCSVVhdlZGdGxjSVJi?=
 =?utf-8?B?Ry9nQW1qcDR0eGFWczJmSUFDNXpaTzBER1k2dGFOc3pmeWhhLyt1WGJWQmRw?=
 =?utf-8?B?OFZXVGhUdmhuazdPK09uY2wrU0QyMUtOT09OM1RHOVplMlZOWkZHcmZteWd2?=
 =?utf-8?B?UW9QSW00bjNKNVZnM0NaSk5JYVg0ZVlHcC9tYzRadW1iSXBXSVRRSHFWS3Ry?=
 =?utf-8?B?Z2dOLzltZmFnR2pEZ0FWaUlEMkdTMVQ2UGVFT283ZUVEVCtyNVFjdVVOU1l3?=
 =?utf-8?B?bXhTdUcwT0E3bHF3NXJQTWhWd3ZRUDFYb29kSWRKZ20zb0x4Y1lpdFVpQ0FF?=
 =?utf-8?B?bjYwZGJoU2FlL0NtMjhGa0RkL2F2T28vSHIyVk4rcTJmZ1VoU0h1WWhnSTRn?=
 =?utf-8?B?UXVnNHQ3alZkVGZGY2RNN2JmQVI1N1hoMisyWVpYWDZIMEw3RmlmQjArOWk4?=
 =?utf-8?B?dXU2eEVPbEVJU0cyWlkvQTNZR3Fwb3VNOTlqd3NqQnY0WjgxS1JidSthY3Qr?=
 =?utf-8?B?WnU4Wlp5Rko1dUYxMVVHMDBiS0I4UmN1MUVFUWFJZ2R5SnljZEIzZjVESCtt?=
 =?utf-8?B?bjdsbHI4d3lqSFVhcktnR3JaYnlQQ1dFOGlKRnQ3VXBLc3lGcmIxYkt6a1JF?=
 =?utf-8?B?eFFnZTZhWkoyNHZ5ZE4yYlprU1d4ODdVNnBEUzh0bUpvVEVKb2V4WmhNNzdp?=
 =?utf-8?B?WTlFT1owVTJLd1NMOTdCSmNPckM1Zm8yb0F0WW9PS3VkV3FUb09BZ1BJamJZ?=
 =?utf-8?B?TTZtUUNCR3VoUjdNSXNBNVlLdFdZV05ZVGRQbHo1Q05jd1Q4RCtDVnZYaEha?=
 =?utf-8?B?MkQ0UUZVeTd1SjFNMG54UW1qb0hDSHRLMzJkQTlMTzF5RzUya2tnVTVrTlJ6?=
 =?utf-8?B?cS9pQ2RaQkYyeW9pN0NBMUJGWHVLeWlSQ3JydW5qNkdVWk05NTZ3S0tTUEJN?=
 =?utf-8?B?cFlxZXNVTzVnbC9uc0xoaGMzRk9QNmZFYTgzWUtkUXhuVnViOE5tZlVoanZD?=
 =?utf-8?B?UEZWVFVTamloeDdPUkk2ckRQSFN0bE42d0E4RmpIUFI0Z0JjK0MxSjN2ZmE2?=
 =?utf-8?B?MUtsUWhJMktDMmptRFdRa01RdVQvQzhGZ2xqTW9YeklrZTc5bWdPalVBSHAw?=
 =?utf-8?B?U3QxY1c2a1l6NUtPZFZpYkJPQ3lPdGpkSmRGeUs4YU9MUzMvWTdWUXJoQWNn?=
 =?utf-8?B?RElWa0ZCSnU4SHhhSFJsUjk1cXhuRm5rV1I2dEtMMmtyMnFYSmV2cWJLWnVw?=
 =?utf-8?B?WExZV09KYWJlWTJXZkZraStqcVhseUVJZ0M2ekxNQTRRU1MzdTJHOVdOdzNl?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d172c08-95a2-4f82-1f2e-08db86b2d6e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 10:44:47.0668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TONkdIFHZ/YGmMSFf+j+2yQ3wecNh8ZUiw5sjTITTt4aCIEoWE1CCE9HljrBkW730SrznsAe0jhfrPmgFiJlh2nCLaGvuqdRwWPkdCqjhGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQo+IEZyb206IEFuZHkgU2hldmNo
ZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAw
Ni8xMF0gc3BpOiByenYybS1jc2k6IFNxdWFzaCB0aW1pbmcgc2V0dGluZ3MgaW50bw0KPiBvbmUg
c3RhdGVtZW50DQo+IA0KPiBPbiBTYXQsIEp1bCAxNSwgMjAyMyBhdCA0OjA04oCvQU0gRmFicml6
aW8gQ2FzdHJvDQo+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gUmVnaXN0ZXIgQ0xLU0VMIGhvc3RzIHRoZSBjb25maWd1cmF0aW9uIGZvciBib3RoIGNs
b2NrIHBvbGFyaXR5DQo+ID4gYW5kIGRhdGEgcGhhc2UsIGFuZCBib3RoIHZhbHVlcyBjYW4gYmUg
c2V0IGluIG9uZSB3cml0ZSBvcGVyYXRpb24uDQo+ID4NCj4gPiBTcXVhc2ggdGhlIGNsb2NrIHBv
bGFyaXR5IGFuZCBkYXRhIHBoYXNlIHJlZ2lzdGVyIHdyaXRlcyBpbnRvDQo+ID4gb25lIHN0YXRl
bWVudCwgZm9yIGVmZmljaWVuY3kuDQo+IA0KPiAuLi4NCj4gDQo+ID4gICAgICAgICAvKiBTZXR1
cCBjbG9jayBwb2xhcml0eSBhbmQgcGhhc2UgdGltaW5nICovDQo+ID4gLSAgICAgICByenYybV9j
c2lfcmVnX3dyaXRlX2JpdChjc2ksIENTSV9DTEtTRUwsIENTSV9DTEtTRUxfQ0tQLA0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIShzcGktPm1vZGUgJiBTUElfQ1BPTCkpOw0K
PiA+IC0gICAgICAgcnp2Mm1fY3NpX3JlZ193cml0ZV9iaXQoY3NpLCBDU0lfQ0xLU0VMLCBDU0lf
Q0xLU0VMX0RBUCwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICEoc3BpLT5t
b2RlICYgU1BJX0NQSEEpKTsNCj4gPiArICAgICAgIHJ6djJtX2NzaV9yZWdfd3JpdGVfYml0KGNz
aSwgQ1NJX0NMS1NFTCwgQ1NJX0NMS1NFTF9NT0RFLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfnNwaS0+bW9kZSAmIFNQSV9NT0RFX1hfTUFTSyk7DQo+IA0KPiBJIHRoaW5r
IHRoaXMgbm93IHJlZ3Jlc3NlcyBkdWUgdG8gdGhlIGFic2VuY2Ugb2YgcGFyZW50aGVzZXMuDQoN
ClRoaXMgbG9va3Mgb2theSB0byBtZS4gQ1NJX0NMS1NFTF9DS1AgbmVlZHMgdG8gY29udGFpbiB0
aGUgaW52ZXJ0ZWQgdmFsdWUNCm9mIFNQSV9DUE9MLCBhbmQgQ1NJX0NMS1NFTF9EQVAgbmVlZHMg
dG8gY29udGFpbiB0aGUgaW52ZXJ0ZWQgdmFsdWUgb2YNClNQSV9DUEhBLCBhbmQgdGhhdCBoYXBw
ZW5zIHdpdGggYm90aCB1c2UgY2FzZXMuDQoNClRoYW5rcywNCkZhYg0KDQo+IA0KPiAtLQ0KPiBX
aXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
