Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE9A7B009B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjI0JiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjI0Jhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:37:48 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2123.outbound.protection.outlook.com [40.107.114.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD4F1FF5;
        Wed, 27 Sep 2023 02:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjASV+Pb1nwQ3GKrqN07MH08KQD99aueKZKCLRV3R4giExdTF0fFQmySD1F0HZS4v9PLO6wiNmYw5aoG8MXmuZsf/6tVe2U0brhmkRL9fUtEUuOOYK3FyYtM2m45zAS+S2gccomHNk3nnbcSKV1vzbLqFpyUXVQ1PJLC5H2ORLCnE0a0WtErf3WDy8BwMgaoYMF0VicZ8DFPADBxBc+VUcuhAXHOKNfS9S5C/TLPIEi7OY+RRrDQeZR6N3jZU96E0We1LCzS9cupZhUrqEdCBftjqN67fQm8wudwTPoOo9AUgjPY6QGm8W0QbFIQkzTZmcjGUPOEK9yFfoXHAuJ7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uzy7x3GBsc9VwKt/2P6KPU4zqA+/XRH6D5dVMAm+6zE=;
 b=jR4BpNqzej7/9R4dq5DUvRgp6mMUsxt+ScD6AAgZ7htlo6OJ4G1TdfUdukJm1IWtIWGx1GNhXtIVHN7ctrDtHlFzgp6MdHzSbJKRW8/rZmoNcGTAI/Qn4hSIcaNmFLMLF8hFZupw0Wx9Q6eJWF0uao2/p2L/xWsh+zsDEes/7li8RR1qTYCX2UEKNUazXoTmLqGh1CBJmgrAwmgUS1tk+AiWv0CwP7FpQt2RVLHOTUMd3qLc6p+BDnkmp+1e5AhRKicLUOd9OorMumraYOOGj4N4cpbgSNgWQE+JifPfgDnTvK/xWfJ+OEOWhz3kU9YBVgOk92chNVKMqgUdrR4f8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uzy7x3GBsc9VwKt/2P6KPU4zqA+/XRH6D5dVMAm+6zE=;
 b=RsbgNHUONrUJzhTceRaq2QUgOoFGT4/GIXx4QQglkQfwCcyk9mBbgdXgbvkDEcs0QBcFCmCt5XEkhbdjqRJ9lQpNYjUp7MsjSEA0zUcGf5srlhRZnJXFTIKLk50v/kdY2MUl4u7mGSvkTDzY0o9Lx6g60po36BV6M1FSo4b0bTI=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TY3PR01MB10143.jpnprd01.prod.outlook.com (2603:1096:400:1d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 09:36:30 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::600a:9708:18f:2528]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::600a:9708:18f:2528%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 09:36:30 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related
 properties
Thread-Topic: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related
 properties
Thread-Index: AQHZ8L2blakiXIKx8k6DD60xX0IJ3LAuT32AgAAaGRA=
Date:   Wed, 27 Sep 2023 09:36:29 +0000
Message-ID: <TYWPR01MB8775BF850914BEFE55287486C2C2A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUibHxPBCLbeWdNrEk_szm+o4cOcskEMZAqUufNTzQKMQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUibHxPBCLbeWdNrEk_szm+o4cOcskEMZAqUufNTzQKMQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TY3PR01MB10143:EE_
x-ms-office365-filtering-correlation-id: 7e9bdaf0-8557-41e7-9478-08dbbf3d3a9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dqkfnbioB7YBFkkXZacyxJgYeoxcLT/2Aqltpey1w3iLpKDTf2TyzCItJ1Mj8rjd4dqcAkwr2+AW0UVASD5zUGUN2sqHvPw0mt3SmGxgLI5aTIIAmpvY0eKcNs+BUbc/DGNGu6QRrEXQSU/broISDvFB847CxFhsmW4ZdWcUs9v52Hj4ZrHbOSWIG9ivKiQy9hJGH36jzlg8maZaneBElVQKUSJgX6EwuPQVGgfO+SEeFohbJzLfb85e75Pr3zT+bPyAo5xnnfoeiuhLqLLu7WozJNcr2GERsbPKStv3FjwM9/yvpawPsSISkwMJHIjiYiJGWqWLWADrNFUo/FFYu0LbqMZSFXhRW/tgxuwPqaVpkWjx7DMdAt6aRcaD6PK99Fi6hw4wEsydVk5a5OUkIGaszS/bF/UfKnzD/cq30uVce9/tF0L0BAewN9AcbUji7L/XMKWR0ApgpQNbZ3dMlqtl1EKUYhuz2UFr4jQO9tORgoBE96Cwn25qG1kutsRkwesP7YIbprRtrTzXlBbsEJE7M47J92atHLvWACYQpj9qYRJYS2VdSR184o/KHTS/zfU3RZH4ODVz63R1hHYfnO1MRMU1kCUpEECM+9A+1B2Ec/ayD12JCsaDZQWSkdDZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(2906002)(7416002)(8936002)(8676002)(4326008)(5660300002)(52536014)(64756008)(54906003)(66476007)(66556008)(66946007)(41300700001)(6916009)(316002)(76116006)(66446008)(478600001)(71200400001)(6506007)(33656002)(7696005)(53546011)(9686003)(86362001)(55016003)(26005)(107886003)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHBFaUY1VmZsZGRFUDlwN3QyaEoranFpZG13cjdFSTdhWkxsVktQWFZTSlRH?=
 =?utf-8?B?V2cwVGJwYk1IV1ZZYWNQT3dLM1Q1VWhkUHMyemh1RFJNOU9iUTZ3RklZaEwy?=
 =?utf-8?B?NkNzeUVyUDA5cHBXTVFQb1ZIZ3M3Q0hycUtDcWtpNVVMa2NvcExNQnRuNGRv?=
 =?utf-8?B?d2hkZGwvRy9hT0JjV1JMaUNRSlp6RGlFcXdzbjNMSW5RdnNZTVNtNkNtZFll?=
 =?utf-8?B?SWJRb25TZmQ5Y0IxcXdMWVkwalNUUlhOTWlMK3ladFp5eUhOTU5IcDBad3cz?=
 =?utf-8?B?bFJ2SDVrblhFUmttdXpQSnMzZW5mdE42bVR6cVZwZUJEQUJ0Vjh6S2hsbUo3?=
 =?utf-8?B?ZXk1bDBpVGF3Uk5uRExrTUNYWWVGazg2N1BMK01xYUoxQnRpYzZTR1NLR3Bl?=
 =?utf-8?B?eTJISnFLN1VzMzdwTHh1eWRGQWJCOWJFaDZybkU1V1p3RmFTNFR4M3F5WHBy?=
 =?utf-8?B?OUNBSytmZXNpYkhpUVhicDBFYWdoQlM0eG91NFlKWDNBalgrWjlXNXdlb3I0?=
 =?utf-8?B?OHVRNDU2UjJlb0M2K2JrSkF0Q1EzZUV0dkd4blltQmtrdDR1aGNzb0tKeTdz?=
 =?utf-8?B?SGxqMWxXekhGZko3RzMrQnRHQlJHWDdpTjRYSjFIWHhiQWF6dkkzOXcxajBM?=
 =?utf-8?B?UWZoc0ZkTlpNUHJPMGF1N01kbmVtN0drZUFjcnJGRmVXWFNIRnNSZFlCOURB?=
 =?utf-8?B?ZHVZOExoUTFzN3FFMDZQWHFNOTZEdjFla08zSHJMMWVpM2tqQkp5clVTWDFD?=
 =?utf-8?B?a3h1TDFxVmwrdEhFbjNzQU42QXI3bFhIcmdYU3ZyaUlBZm5ZZHkvZCtibDRV?=
 =?utf-8?B?WVlJWTd5Z1prcG5aMDY1NWtxRi96MDJtSVptczN1T3p4KzhUZTY2TFBFL3hR?=
 =?utf-8?B?Nk15YlFyaHR4NjJLSnJwZ091UVJldVNMaUk5QWhUSmZ1MnJSa0xBYVY0YW5E?=
 =?utf-8?B?bkdydk1nSXk2THZjVHkrcHVGNXNlQWtkbW5ITUhzRy8vNDdPdHFBRDV4MjJU?=
 =?utf-8?B?OXNsZUhHR09FT1BaNHdnYk5JTlpmRXgvNUZYQ2o3ekpOc0RFOEYxNVAwYUVq?=
 =?utf-8?B?dDZXVFY0cFR0T2ZHSTYxNCs5eXA0aU93K0NyNTNxQ0FMUXNNNmUwUjM5VE5j?=
 =?utf-8?B?WnNmOGRaSk42WUNyZjZML2hPdFhQTUZJeHJjY1YySllzOG01S24xT2IyUzMr?=
 =?utf-8?B?YTV6MXNsNjBSNFlJWWY3MnVIam03SXBEYWN1c0wzb01mNENzRCtOZWQzR01M?=
 =?utf-8?B?em96amlpRkp1RHltTTFQdlA1NUpGMWo5eGRDS25wZkdFUk0vRkJxN2d5dTFO?=
 =?utf-8?B?YVU1U0pSeGtTc3ZNMGtNNXljbVd2azRJb2s4d0xPMWp2N2hHRFhTV0orWExF?=
 =?utf-8?B?NUZ5aXJrUE1SY01qa282ajZ3WE82T1JrVXRZVmRHMVZNSFdXNkdMdjJyS0Jk?=
 =?utf-8?B?ZytvQjJUSis0ZU9ZM0UyeDc4STlmNE5qV2d4VjBFalNTU01VYnBQcy9PYmky?=
 =?utf-8?B?endsU2hZaWc3MXh5UWhlTkw1dEFZYUJvVWFwdEJUY0hLOUxUWWdhWUpIQUdY?=
 =?utf-8?B?MkYwamdpeGpIN3RpUlF2aHMrNncxUzdXbi9qVHlUWFE2UytLclF5WlZmZENK?=
 =?utf-8?B?OWJGd2wyYUpXMjR0Vmlmc2s0K1M5dm1qK3RCaU5mN2IxZWp5QUtabnZEbHMr?=
 =?utf-8?B?WVd6RisvdlEzSnNla0dLdWYwUS9MblIrb3pZSVpJazJFRnQxd3J5YTlNNngx?=
 =?utf-8?B?UVhFcGdaZHo5eUFaM0NVaERyanNyazRGQzZOYTlLanAvTCtIczRqT05zTUIv?=
 =?utf-8?B?OHJ4enFmV1lIWC81T3diR3FzZzd3NG5VQjE3Ulh5cTNQNlIvNkszYzROUWp6?=
 =?utf-8?B?OE5GZlhVTXdKYXlnamtlSzlmbHlUNFpUc29lamlLT2d6QktKVituN1ZhVVRa?=
 =?utf-8?B?RFd6d2Z5YVluWkFtcFVYaS9iL1NJSWFtR1lCWFFOSkRvTnFJUmxrbnJXNkUy?=
 =?utf-8?B?cnJQNDhUYWtEVHlQbm5yc2dsaFZIc2tNSVJOWFZjV1N4TEluRTNET2xwK3Fk?=
 =?utf-8?B?Z1FGRW05NmxrRmpZd2hYeFBKT0ZXWkVYT0xRa1BXWDFybTVWbWlZM1hsYXFp?=
 =?utf-8?B?SGZIYmFiY3dxdnArWHFNaXlCVjM3N2NHQ01NZ1R1cklnQVJXRlNVZUVaNU0z?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9bdaf0-8557-41e7-9478-08dbbf3d3a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 09:36:29.9703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9fSiQwK5l32iyVcUGHZgkHOuVPV0Rw3yCUwjOnhh3CSCX0beh5L0at5RlgOjOsCuc8PoX37vNiRa1L5tpoObPf8TmVzhRDLoiFKGCljboM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXBseSENCg0KPiBGcm9tOiBHZWVydCBVeXR0
ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
Ml0gc3BpOiByZW5lc2FzLHJ6djJtLWNzaTogQWRkIFNQSSBTbGF2ZSByZWxhdGVkDQo+IHByb3Bl
cnRpZXMNCj4gDQo+IEhpIEZhYnJpemlvLA0KPiANCj4gT24gVHVlLCBTZXAgMjYsIDIwMjMgYXQg
MTE6MDjigK9QTSBGYWJyaXppbyBDYXN0cm8NCj4gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2Fz
LmNvbT4gd3JvdGU6DQo+ID4gVGhlIENTSSBJUCBmb3VuZCBpbnNpZGUgdGhlIFJlbmVzYXMgUlov
VjJNIFNvQyBjYW4gYWxzbyB3b3JrDQo+ID4gaW4gU1BJIHNsYXZlIG1vZGUuDQo+ID4gV2hlbiB3
b3JraW5nIGluIHNsYXZlIG1vZGUsIHRoZSBJUCBjYW4gbWFrZSB1c2Ugb2YgdGhlIFNTDQo+ID4g
KFNsYXZlIFNlbGVjdCkgcGluLCB3aXRoICJsb3ciIGFzIGRlZmF1bHQgYWN0aXZlIGxldmVsLg0K
PiA+IFRoZSBhY3RpdmUgbGV2ZWwgb2YgU1MgY2FuIGJlIGNoYW5nZWQgdG8gImhpZ2giIHVwb24g
Y29uZmlndXJhdGlvbi4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgdHdvIG5ldyBwcm9wZXJ0aWVzLCBv
bmUgdG8gbWFrZSB1c2Ugb2YgdGhlDQo+ID4gU1MgcGluIHdoZW4gaW4gc2xhdmUgbW9kZSwgYW5k
IG9uZSB0byBtYWtlIHRoZSBTUyBwaW4gYWN0aXZlIGhpZ2guDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4NCj4g
DQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9yZW5lc2FzLHJ6djJtLWNzaS55YW1sDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9yZW5lc2FzLHJ6djJtLWNzaS55
YW1sDQo+ID4gQEAgLTM5LDYgKzM5LDE3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgcG93ZXItZG9t
YWluczoNCj4gPiAgICAgIG1heEl0ZW1zOiAxDQo+ID4NCj4gPiArICByZW5lc2FzLGNzaS1zczoN
Cj4gPiArICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAg
ICBVc2UgQ1NJIFNsYXZlIFNlbGVjdGlvbiAoU1MpIHBpbiB0byBlbmFibGUgdHJhbnNtaXNzaW9u
IGFuZA0KPiByZWNlcHRpb24gd2hlbg0KPiA+ICsgICAgICBpbiBzbGF2ZSBtb2RlLg0KPiANCj4g
Q2FuJ3QgdGhpcyBiZSBkb25lIGluIGEgbW9yZSBnZW5lcmljIHdheT8gSSBoYWQgZXhwZWN0ZWQg
dGhhdCB0aGUNCj4gZXhpc3RpbmcgU1BJX05PX0NTIGZsYWcgY2FuIGJlIHNldCB1c2luZyBhIHBy
b3BlcnR5IGluIHRoZSAic2xhdmUiDQo+IHN1Ym5vZGUsDQo+IGJ1dCBhcHBhcmVudGx5IHRoZXJl
IGlzIG5vICJzcGktbm8tY3MiIHByb3BlcnR5IGRlZmluZWQgeWV0Lg0KDQpJIGNvdWxkbid0IGZp
bmQgYSBnZW5lcmljIHdheSB0byBhZGRyZXNzIHRoYXQgaW4gYSBnZW5lcmljIHdheS4NCg0KPiAN
Cj4gPiArDQo+ID4gKyAgcmVuZXNhcyxjc2ktc3MtaGlnaDoNCj4gPiArICAgIHR5cGU6IGJvb2xl
YW4NCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBUaGUgU1MgcGluIGlzIGFjdGl2
ZSBoaWdoIChieSBkZWZhdWx0IHRoZSBTUyBwaW4gaXMgYWN0aXZlDQo+IGxvdykuDQo+IA0KPiBD
YW4ndCB5b3UgdXNlIHRoZSAic3BpLWNzLWhpZ2giIHByb3BlcnR5IGluIHRoZSAic2xhdmUiIHN1
Ym5vZGUNCj4gaW5zdGVhZD8NCg0KSSBjb3VsZC4gSSBkaWRuJ3QgZ28gZm9yIGl0IGZvciB0aGUg
Zmlyc3QgdmVyc2lvbiBvZiB0aGlzIHNlcmllcw0KYWZ0ZXIgcmVhZGluZyB0aGUgYXV0b21hdGlj
IGhhbmRsaW5nIG9mIFNQSV9DU19ISUdIICh3aGljaCBmb3INCmV4YW1wbGUgZG9lc24ndCBnZXQg
YXV0b21hdGljYWxseSBhZGRlZCB0byB0aGUgbW9kZSBmb3IgdGFyZ2V0cw0KdXNpbmcgYSBHUElP
IGFzIENTKS4gRXZlbiB0aG91Z2ggbm90aGluZyBwcmV2ZW50cyB5b3UgZnJvbQ0KZXhwbGljaXRs
eSBhZGRpbmcgU1BJX0NTX0hJR0ggdG8gdGhlIG1vZGUgYW5kIHVzaW5nICJzcGktY3MtaGlnaCIN
CmluIHRoZSBkZXZpY2UgdHJlZSwgSSB0aG91Z2h0IHRoYXQgY291bGQgYmUgY29uZnVzaW5nLCBi
dXQNCm1heWJlIGl0J3Mgbm90Pw0KDQpUaGFua3MsDQpGYWINCg0KPiANCj4gPiArDQo+ID4gIHJl
cXVpcmVkOg0KPiA+ICAgIC0gY29tcGF0aWJsZQ0KPiA+ICAgIC0gcmVnDQo+IA0KPiBHcntvZXRq
ZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAt
LQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBp
YTMyIC0tDQo+IGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJz
YXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhDQo+IGhhY2tlci4g
QnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3Jh
bW1lciIgb3Igc29tZXRoaW5nDQo+IGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
