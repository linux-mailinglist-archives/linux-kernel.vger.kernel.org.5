Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61859812BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443443AbjLNJdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjLNJdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:33:36 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2091.outbound.protection.outlook.com [40.107.114.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BC098;
        Thu, 14 Dec 2023 01:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUbJV8EKnRIPHGR80r84Wtz/rto0pGGB1Kf+eWLv96Gs/YXDL3JLOasJV1AaLBl7rMfvf9tHYeXzD10XDtgvGIZbC3oYBKSQdi8/fhWyNnqFGqA1Tn1393RtDdm1pBWpbrWC4olfXftnbjJ7CG9XfHqWZThljr7oV3y9+AeWB6LU4YDHpYfyrY/CKBLPhk6TNnnNoTtAOXyGz0VZCzs5WjjzzWwniz/b8KiD9uOEhlqYywlYTjphSICrKgaTL68AnAOaiMZelJ5wroi57LHnnRWmwXaBZoodM0eYGCaY0DmLasQTsLXoNqN4O44uUZQVgJOGpOGkKWtfaIMlicH+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byGBdeTi2glpjPTgW22aB/fldZO23VcBG0KzXN9F4qY=;
 b=OQ4QMoWGGpCphrlixhumF63LxyCAVsUQuhFIr0/svZRCGvzk3KCH2m9nxJEKOzmUUWhbyLfDHuI6PbTv8azIL+82JE+ss+iaCsoTN0hMFdeN7t5Dcx/WE3zP1QwfUK8B5QpZxGTA1yFRD6hsAK/Y2mvS9U0ZR0I6nM+kvflCyIFTIIbsTZ6R7/kX3RcHCxlyYAHp247Seu0IUZxEx6+9iqHtcvWe7jHdEOVXZ667Ptx5Li4xsXmvrl+wZiUxsFDA2WHgX5/RdspyuEK1FRpS92A/YqeAecbimWUshfZzPTHONdsSUmfLAESUA1CpQ01NI5PeB4q2J7AeJpoYo9qsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byGBdeTi2glpjPTgW22aB/fldZO23VcBG0KzXN9F4qY=;
 b=bp1tL1Kwk1DSMDQB5/d3idOnUH/5gFi+FPt9O835io9snoJyyJ8oPoT35k7Q+0TKJepjD1YxOJMsCGjcIaPuTbDZj1DtPB697pWNHChxEnToZ9a3L9GqB4g/ausOLubkX1SR70xqi56x8Wp3i54KiDPu7TxQG8WvgAlSuba1S5M=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYWPR01MB9869.jpnprd01.prod.outlook.com
 (2603:1096:400:235::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8; Thu, 14 Dec
 2023 09:33:38 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7113.008; Thu, 14 Dec 2023
 09:33:38 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Berg, Johannes" <johannes.berg@intel.com>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "Berg, Benjamin" <benjamin.berg@intel.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: next: arm64: gcc-8-defconfig - failed -
 net/wireless/shipped-certs.c:92:1: error: expected '}' before numeric
 constant
Thread-Topic: Re: next: arm64: gcc-8-defconfig - failed -
 net/wireless/shipped-certs.c:92:1: error: expected '}' before numeric
 constant
Thread-Index: Adot078PtDDEl6shQJysZ7bF7F4DCQAm7U9AAAAwzQAAABMMkA==
Date:   Thu, 14 Dec 2023 09:33:38 +0000
Message-ID: <TYCPR01MB112699830AA2FC0A8348D9818868CA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <TYCPR01MB11269DD29E89EF09A4B053C1C868DA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <TYCPR01MB11269A0200358724E126E7ECD868CA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <DM4PR11MB53594DB860C5FA1539FDC570E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB53594DB860C5FA1539FDC570E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYWPR01MB9869:EE_
x-ms-office365-filtering-correlation-id: eb007071-c51d-49f9-bf93-08dbfc87c0b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qAftoWTJ9RM6/O8BhCEtF5u+oPu0jz+ygO3Rf4XfHdxcyYb2RaB0z97xMBvg6Xl78y1j52Aez6Ak745ryilYGfehxfI3jxYgX+iPYcEquL0acJekgSmTPcFaT/YzFImninF7rxCt1TWT/oPdLJ2V6xocx4IHqX8QOWcKnOJbB/98wHOLXNLYv7tFR09Ak3NNBYw2JZ9qYcXANFlrkXHT54HzK7OhqWq6JKn/wryjPFxwYXGDYFliRgBv0pMNYNgPtx6qTwnpzpNSF3su7GKARgVkUOf+fQzyRsuWDm14bv3taWXmDGlPCRE3jtuBBv5HUzEXqIwOP0RyzktEufJdc/dRoHcQrJ1AYr4vJ5Y0tB8y8kQpTzE3rKTL+RfQkhZI4kLVn5MpzGr+73XVUnQpH3ZUeavDvZw2EhQVmKpIxa7lZ59RNrfq55UyQBWpKJm7hOjVi9JkAZDcPqTBwytVvmoT6akCuBjtZ/zcznjPQqIx97OXz5HDsulZ+af0QmgeDqbPZQj0vwgJxATNNQHZ/LHBr/1XAdR2T5x6cMo9gNYdkhYjjOMxLoaZg3ZIpfEUD1UHPJUvUxYdlS8pwSgH8tDZE4mRmZeEQYh4yYLZj1IiBobAbOAwSiAOs7GHckMe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38070700009)(41300700001)(122000001)(4744005)(7416002)(5660300002)(33656002)(2906002)(53546011)(6506007)(83380400001)(71200400001)(7696005)(9686003)(478600001)(66476007)(26005)(8936002)(8676002)(4326008)(110136005)(316002)(64756008)(76116006)(54906003)(55016003)(66946007)(66446008)(66556008)(86362001)(52536014)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUVaNDhObEg5TjkwQ3l2MURub3J2SmI1dzFvb2FWUUc4MkFBS3NrYzA2K0JY?=
 =?utf-8?B?VjZJa1ppanZXRHg3WVR0eTA0S2lCazBQUzBaclhRUW01c0VxcnNVZ1V6QW1i?=
 =?utf-8?B?SU5idC9ERllBZjZDTFJZL1ZWbHMrQTFBK1M3SEowWkIzRGtkWTI5WDFySDNu?=
 =?utf-8?B?MlNra0krREdNUjZzV0txMUk3cVhQdTNtbFdzckRwWk9GM2I4TDFBRFJRa2do?=
 =?utf-8?B?bDNEazB2cWdHM290cU5vTFB0UE9rMXpJR2UweFFWVmVNcDkzMGlFdGR2bEcv?=
 =?utf-8?B?YS9ESWVyTzZBUm8zbDFzZ2ZreU8zS0pOb3djVGRDYzRFR0tCYnVQRjJ6NS94?=
 =?utf-8?B?SnpZMG5waWtSc2xpK2E0Vk5TWFd5SENoZGRtRDMzODZYQ0FNelVVc3NTNHJF?=
 =?utf-8?B?T1NwZlNZdUZpNlE1Zzk4YTh5azgvb2todVNxcXA2d1k4NHgwc21wVW5GUUhL?=
 =?utf-8?B?MHlMdHlZTjIwdFNabFdXUnNPTGFlS0hIVk12cFhDZDh1S2d6SEg5b0NHVEZ4?=
 =?utf-8?B?MzZ2L1NwRlRpM0hGZWJ6QkN4OUxzc3IvYklEQWppaTBzbDl0dUxMYkVVL01J?=
 =?utf-8?B?ZDVBTjgvMGcvbFhwcGJ4dEsyZ1A0bWtGalI4Mm5sQzlKZ0kyTkkxcjN2VUFZ?=
 =?utf-8?B?YkN1TXRwK1Z2a1c2V09ZY1JHWXZuaU5qWFE5ZEFmM1dZNlpscDRweWVJOUVi?=
 =?utf-8?B?MlhhRTlob1puOGF1RDcxRi91enFyRDhVQndQcDEzWWNUT1J1QldmWG1BOENK?=
 =?utf-8?B?MW15WWgxT3RkYU9aK3VCTWt5ZGRJb3lQM1hrb296N2Yyd2lFRElHb0tHRkow?=
 =?utf-8?B?K25yL0s3eUVNaW5YMmVEN0phTEsxMUhSSEU1M1M3YTMrSVo1Z1haYlZTSXFa?=
 =?utf-8?B?MlBCOFJVUFlROFpOVFdGTEg5VjRya3dCTVhMTEdWd3FzNUVIc3owYW1IVE9T?=
 =?utf-8?B?d041bk5UcXdEOGp0ZUhpWHdXSllGazVNdjVITDZsODJPb1hHUzdPMVkrbm13?=
 =?utf-8?B?ZFJnWlppbXhvRG9sc2lhTnIvUE1XSjhsY256Q29lMnFmZGd5QTIzb29Zejkz?=
 =?utf-8?B?QUZnclRuYzEzdkxRR3kyWkdtMXNGSlhmeEJtZjBuQ2N3MG5EdlJJeWxST1ow?=
 =?utf-8?B?RGZ2TEUrTzhvYjlrVXBMdjNNaXB4MmlqMTZyT0N6YzkwUEdiUWoyL1Boa0JT?=
 =?utf-8?B?cEpLL28zaU0xQkx1bEJrWC9PK093YW10OExVelJjeGpvaFRsSnpqS2V2MWUx?=
 =?utf-8?B?d3ArbUY0ZlI5R3pGb3c5WTlXVmpKSWNaOENuM1NwaWNGejVVeVQrNUJ6R2dZ?=
 =?utf-8?B?U0tIUlhjaXFBbWR4OU9GYzNUMGtLREJKeGZ2aUZLZS9zdEM1T092eDAvNCt3?=
 =?utf-8?B?T2g2SFUySlp6dDJYT3dlZ3M5RWQyb1lmSW9PQ2gxRWxDaVNiV1Z6NHpkZy9p?=
 =?utf-8?B?ZWxESkY4cmVRenJnOWRwS295K2txcHczbGIyZVIyRDRlSnNVQnZFeWxZUmQz?=
 =?utf-8?B?Z2RWV0syOXRMSnk4eTFFY0pJckwyQllFN1AySW5FV2dqNUFaRGNveisrUVpU?=
 =?utf-8?B?UHZZdFUwSnpTZ2hudU5LL3QvbEVtcUdWTHhacjFHekUvaythUkxwUjB2cjFC?=
 =?utf-8?B?L2JQVTJESGlrWnpubGkyZXVSTzJWZ2xXdXUrQ0VLYkRYOTBRaXVnWkZkZzBn?=
 =?utf-8?B?VndxOHB4ZlJ5R0dZcUlrUHRmeDdpY2JkQk9Ga3JkVjN1OHNyODUxRkJLNUJS?=
 =?utf-8?B?ODhhVFBEU1Z6bUNDR2dJTkxhM3lhNVdZOVNTRCt3SGxQd1VnVUtoSXVwSFBN?=
 =?utf-8?B?NWM4M1hVMEozL1pXdC9NVTByVWhGV29hWTllemlPd1VCb3lSeDNmcVhJNFZq?=
 =?utf-8?B?dTN5Y0xjc0x6OWh4YThPcUc1K3RFeTRDZVVMY2Z0Q0d6YnN0OVcxbkVFeTNi?=
 =?utf-8?B?T0ZQYWhmTlhPMlJZSUpJM1d4eHkvTDdFL25nTXR1QThMeEFDNGQzV3NRRXFt?=
 =?utf-8?B?U1lHZzFXeVgva201cUgwTng3Q2FUaERrSlVZck5MdlhOZ3dxY2VRMW9qY0JS?=
 =?utf-8?B?LzAwVTAxb0R5VldIVGZQaGNlRml3b1Z1Z1hyM212ekI1NkthL04wMlo0a1U0?=
 =?utf-8?B?NGVkekR2MG1aZU9UclIrY2ZpWkg1RU0rL2ZDSnllMWQwckcvV1FnZVlnbmdO?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb007071-c51d-49f9-bf93-08dbfc87c0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 09:33:38.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMA/dCaejbJYXAnBERtEd1eBI0EeOx1PFHRc1HT83EKOYoQV+R9xqCWfS59NtC4PcUyyx6dB+EUnTXGknH7ZLxasn6ubexr++OAG24fW6pA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9869
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9oYW5uZXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVy
ZywgSm9oYW5uZXMgPGpvaGFubmVzLmJlcmdAaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwg
RGVjZW1iZXIgMTQsIDIwMjMgOTozMiBBTQ0KPiBTdWJqZWN0OiBSRTogUmU6IG5leHQ6IGFybTY0
OiBnY2MtOC1kZWZjb25maWcgLSBmYWlsZWQgLQ0KPiBuZXQvd2lyZWxlc3Mvc2hpcHBlZC1jZXJ0
cy5jOjkyOjE6IGVycm9yOiBleHBlY3RlZCAnfScgYmVmb3JlIG51bWVyaWMNCj4gY29uc3RhbnQN
Cj4gDQo+ID4NCj4gPiBGWUksIFRoaXMgaXNzdWUgaXMgc2VlbiBvbiB0b2RheSBuZXh0IGFzIHdl
bGwsIHRoZSBnZW5lcmF0ZWQgY29kZVsyXQ0KPiA+IGlzIG1pc3NpbmcgYSBjb21tYSBsZWFkaW5n
IHRvIEJ1aWxkIGZhaWx1cmUuIElzIGl0IGEgcmVxdWlyZW1lbnQgdG8NCj4gPiB1c2UgbGF0ZXN0
IHRvb2xjaGFpbiBmb3IgbGludXgtbmV4dD8NCj4gDQo+IFdlbGwsIG5vIHN1cnByaXNlIHNpbmNl
IEkgd2FzIG91dCB5ZXN0ZXJkYXnwn5iJDQo+IA0KPiBUaGUgaXNzdWUgaXNuJ3QgdGhlIHRvb2xj
aGFpbiBvciBhbnl0aGluZyAtIGl0J3MgcmVsYXRlZCB0byB0aGUgb3JkZXJpbmcNCj4gaW4gd2hp
Y2ggdGhlIHR3byBmaWxlcyBhcmUgcmV0dXJuZWQgd2hlbiBtYWtlIGNoZWNrcyBmb3IgdGhlbS4u
LiBJJ3ZlDQo+IHB1c2hlZCBhIGZpeC4NCg0KQ29vbC4gVGhhbmtzIGZvciB0aGUgcHVzaGZpeC4N
Cg0KQ2hlZXJzLA0KQmlqdQ0K
