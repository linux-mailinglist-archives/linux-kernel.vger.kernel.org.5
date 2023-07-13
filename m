Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D5752D12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 00:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjGMWfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 18:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjGMWfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 18:35:17 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2090.outbound.protection.outlook.com [40.107.113.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DE12701;
        Thu, 13 Jul 2023 15:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij9Gi0q/RALRy9iJUhmi7xmFRqwvIW/jBTvhhSiB4WnDne7EgAP1gEU1c+Alfumcq4o89pkxoAjiaOXYMahJrfBieLz2aTBN2JHzhiMzUe2B7gS6TGbgh1w3d0Osl0XKytT/FKr8/ei1IX1tAL+WU0lXhc+CFMjJYlHB8w+8BR/ytSBaTHvbs/KJTt3JaR3vG0uciVZ99ylBSJw9QhPrtOFfrexXUQWLvHKO3n65tBmDAW2jJxNP7zHGRKEEyEwmqD+QK47YsgqdXipMrrBf4DZfIpTTjrEOb753Ni7hlFoOJhX616y3PdvvILhasVh45sQ5qDOdkSdbCv4oOokCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNG0lrxAOGUciiO8rqfP7y6UizZZbp42JnDbgmxUK6I=;
 b=JDrjJ9qY/hYYAWuboKBT82B0uVcaS51s2tMEcPym9hEfV36EEvPw2syneylt/hUXdD37G1P7f5KxIGtxEer4BQH2dUm+F/vr/ZRU7OaBFL80RznOU19Op8sP2QacEDShWY0lkuvlAorgTpsHETszGGvS0zkL6LAht5TOui2lunZvhJBR/b2oxbvH4MCj6wwUqw9DbBG7mLEJhTJbPKYAGBCQse/yK7jsB+JKrmEknbLulRURXQGKhToFdlqMmbt2n1yWtUdfKe4lpgIhQCcvrMZzRsWQgd9G3NAgH3gj2FIThr/jmmw+bE7YjL5zXxjnG4fSQGFC4Z18FIdkXJxO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNG0lrxAOGUciiO8rqfP7y6UizZZbp42JnDbgmxUK6I=;
 b=i/xYi1rq6zofdSysRt8FjYDJA1uErvA0sRYv+dQwcxIVX/qx2tYRtvLbRr0AeZANg3RNj3HT8VjJRNf5PsB/UbmcMiEmFBZ9eMr7oOkuHVbhnYGFj7tyZY5lN21wLFtkmQNmuKqpoqpjyFt/47Wb3yyEp9D2MZnQpYmQV8uqz6g=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TY1PR01MB10896.jpnprd01.prod.outlook.com (2603:1096:400:323::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 22:35:12 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::97db:c5f3:bb48:c03b]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::97db:c5f3:bb48:c03b%2]) with mapi id 15.20.6588.025; Thu, 13 Jul 2023
 22:35:08 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH v2 3/5] spi: Add support for Renesas CSI
Thread-Topic: [PATCH v2 3/5] spi: Add support for Renesas CSI
Thread-Index: AQHZpP1zFctKcaLpHUujhHkndUbaba+rEJGAgAzi07CAABM2AIAAW2Zg
Date:   Thu, 13 Jul 2023 22:35:08 +0000
Message-ID: <TYWPR01MB8775E433ACFA2F78D357FF05C237A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
 <20230622113341.657842-4-fabrizio.castro.jz@renesas.com>
 <ZKVI4XPbPXfzQa9J@surfacebook>
 <TYWPR01MB8775144ADA4B4FF2CB9B940BC237A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <CAHp75VcJvRq7BotoODW_BOh84+TD_1Q3vbXSQv3FCiJfnBx8Vw@mail.gmail.com>
In-Reply-To: <CAHp75VcJvRq7BotoODW_BOh84+TD_1Q3vbXSQv3FCiJfnBx8Vw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TY1PR01MB10896:EE_
x-ms-office365-filtering-correlation-id: e814823a-82fa-429f-974d-08db83f16969
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ODIjeev2MUU6Zcgjj4s3ZlANLtTtCyjZ0+85vHBmORlhSQTMzmBAv73diz6fbNvMEPdI0exFHvjbsUciPJQxUybOw3htaNlJLhGsaa8fZkBL4TeaszUIWnyBp6llxcfTjitsWoy8VVA0FNJg+TXQCDGp+qRWOFj5dKlQoxaleAXGLA2gr31VjsIHUzx3pglapG/71dh88BoCUeDz8SiJbFVf4LHfsLNWmnl/eYDiaRsntVs2CrrLcFXJGh6foRg507yBastsAhg4RHDhG3MGtYRCs9zVPrnrAXiiDu/nS4IyMR3R5HRtddZ9YvH1ykOaoKZmXUKT/a11yzblOFgkKkEcjZZbTK5VSmjWI59wcSKFwgnFMQJSq3ldK8Mfl4ZbriaORvJ4mczSHPEx5SAJ+ePwpgkVZggCp1XLmFq8w7qtcMe0c2ONQoXQQqW5S0GTaNvSNLA7AQVQctGkh6p3cH7b3rracb1CW+TGy9O9iu7rUh1Rd1uCcCEwra4ruPpIb/REu4UQ4KJXAmrkU6mvQ+c4VrOssk3aWK6/mJIDLFTUN4mPTUjQ5okmzscSdmDiAJzk4JZTKu1rVHS3kN304zrnPrzaB58Axt9SO7o/jm+mytQy7SAodSiVwrbQlVP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(2906002)(83380400001)(66899021)(33656002)(38070700005)(86362001)(122000001)(38100700002)(55016003)(6916009)(4326008)(316002)(66446008)(66476007)(66556008)(66946007)(76116006)(71200400001)(64756008)(107886003)(53546011)(186003)(41300700001)(6506007)(26005)(54906003)(478600001)(7696005)(9686003)(52536014)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWdlSjVCS1BsWkxiTy9vOGNSR0FCanRrdUVRbGIwTGJXOHVCT1ludEUrNTdF?=
 =?utf-8?B?ZlNwRWQ2VXpLcWZMSE1YRzQrek8zcTBHWld0bzFLcWIvOU4zVzQvemJmRWVz?=
 =?utf-8?B?OThNVEdLRlVtOTFwcTVYMHFsWVdSUG52YVByZ3BlYStHaVB6cXZvQUhIbEt4?=
 =?utf-8?B?aXN3L21MT1lBWW4zSjIzblFOK2J6UWwwdHdmVmRyTnJiNmlJMzBUcDJGOUYv?=
 =?utf-8?B?YWJNTTRZQ3lXNjVUU05KZ0dDYSsvZ2RkMlRLUGN6NmNEVHJOYjE2RndVYzY0?=
 =?utf-8?B?YzQ5Vk9Ka3hwcEJrTlUxK0ZXNndiVkdLUkcwWXNRY1lXMWNpMkl2Vmp5dTBk?=
 =?utf-8?B?Uy95RWdta3ozbkhrRWNMdDBwb2UrcWpqTWVQUjZlYllsVk5LQndxSW1iK0ZO?=
 =?utf-8?B?YjZoMDZ1c3lDejNoK1hCM09oWFZsNzhVcm9SR3pvZGhzVGlnQ3NrelpnWGZY?=
 =?utf-8?B?ZVhKVW81d0lRWHBqY0VjZkNDUDYxS2lrRUtzWGFKTFRhNXNGbkFoVzc1clo5?=
 =?utf-8?B?NDBFTHh3UWhxZUtIRSt6SmlqZFNBU2NXd2E2VTFtZ2xzZE5odExPUWVLdnNR?=
 =?utf-8?B?bW8wbkY3VHh0VTVDcUJVR2xIWWROU0Z0S1FoNXJ4VGF1b0ZLUmpoZ2ZDUzQr?=
 =?utf-8?B?SlJ5LzFzeDJqZXRuN0lsUTRSM1o2M2k2ajB6QjVublRGQ2RoOFoyMTZiSGll?=
 =?utf-8?B?cnduUzlSYU10ZUtGT0U1SkRLUFhObG9pZDRZVld6by8xb0xXcnpOMUpsVS8r?=
 =?utf-8?B?NkJMRmFHSjhuRzBvdmdtRExYWGJKT1N1dkJ6WG5mejVmQkxBY25rUUEwYVVM?=
 =?utf-8?B?YzdUdVNEd0l6VWhXbzQxbS9yVFJxbnZVR1NXZHV3QUlMNi9iaUFZYjFrbmVC?=
 =?utf-8?B?S251V1V5Q2FxN1F6VUk5UlcvU3AvR2tzVDRZT3FYZWxoeVNJUXQyQ0x5SmZH?=
 =?utf-8?B?MjJOckZQc3NiYXNWNHdQTGFiWk5TNEU4QjUxTWtNWGlPN0lKMFQ0RmFGbEZU?=
 =?utf-8?B?eElSQUppeDh3RWdzeTJ3TCtCNVNBRThoVFBzQUUzVFREcnRXVzhXclBld1pq?=
 =?utf-8?B?b2l2TC96M3lXVm1INVpuNzlsc0IvUDRHRG0xb0pDZER3dnRuaGFBY3VpRGtX?=
 =?utf-8?B?eXZQaDBPeTFDUEsrVHk0UlRuV1hxSGF5eVNiUG5ET1M4YW5yUVc0YlM4UFFY?=
 =?utf-8?B?dEM0cG9ucVhTdEovdjdaS0liUEdXdnVvWjEyMG1FN3lqOE1KUTNiWVA1VVdt?=
 =?utf-8?B?V0I5VGt2akdWVlgvKzZXckZwbFJ0MDNLdzZOT3ZMMG1sdlRic1hDdjIwUnFG?=
 =?utf-8?B?VitiYWc1WWJFdDNBdmovd0t3NmhFVGF1QSthSmxOdFR0OTZISjB5YXNnQVNa?=
 =?utf-8?B?ZE9TdC9YT2VaNmNzVFh4a1VOVWE3WjQ2YXhqUTV3V2tGVngxdXNWWGFjWitr?=
 =?utf-8?B?VmVnQ3dZbDM4ZFErOHhUekRBRXBMSVFUM3YySXpQT3ZVT1N3RS9ndURVTlhN?=
 =?utf-8?B?QzJPU1g0RmNMaFFKTzBKN2xQdjFLcUxsZGJTUW1FQUpSTkhkRzFNVC9tYVl1?=
 =?utf-8?B?ZjNhcnVwcmhvcTJ1TjBMUmxnbFRnOVEzQS83R2I5TGRacTR2YU1nZDNycS9p?=
 =?utf-8?B?RFRVRXE3d1V6b2dLd2VERVVCalJna1QvUmJlQ3B5ZlJ6UTVtM1NLN0htWjl1?=
 =?utf-8?B?NnJIRHh3WkpBMmVqcXg1Q3A2YlZJb2E0QzAwYURuNEdOL0puZVpya29UZWFl?=
 =?utf-8?B?d3VqVC9sWlkrcThBOERIaW1qTmMzL2VqNGZMUjZZTzFvWGIyR0dkd1JQSnB4?=
 =?utf-8?B?NmVKZ0JKWENJZ2sxMlRZNUU1QW9lUnhmQ3ZZdGUzSW54OTNrM2taT0Q2UmhZ?=
 =?utf-8?B?U1krdWVCRWlRaGJKSm5tR0NKT3N2RDBycjczWXNRa0ZBVVlNb2ppWGhKQmxQ?=
 =?utf-8?B?dnVYRldCUEZQQnU5eDVZQ0R1TFR5RVZseFM5dlpNRS9MU3d2cjU2VGh3U2Jm?=
 =?utf-8?B?azRIekh4ZHE5TGxGRlV0YXU2YUdKV2djQ3hkVHBpTFpOdjgwNTZIaHd5SXZV?=
 =?utf-8?B?dHUyY3BJRWdnempPMU5ZNnBUZUdBcmVQYWM0ZTBYYjB3OXFVeEZPdVI0NFlC?=
 =?utf-8?B?Q1lqbFB4aFl3bW9KREQ3V0N1eTVZd2wxREF3WW1CNFArNVloeitwRmV4RDJO?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e814823a-82fa-429f-974d-08db83f16969
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 22:35:08.1768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /N+kfInCTYQuChKtjhbAtVGZvlh3aj1G9H6qh/EtAMwR50oF4bU6sRCJXD9BQfeE04+IF3x5RSXWQIiWIx1N2jUeBENMCb3mPQ1nQQg1X7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10896
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5IQ0KDQo+IEZyb206IEFuZHkgU2hldmNo
ZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAzLzVdIHNwaTogQWRkIHN1cHBvcnQgZm9yIFJlbmVzYXMgQ1NJDQo+IA0KPiBPbiBUaHUsIEp1
bCAxMywgMjAyMyBhdCA2OjUy4oCvUE0gRmFicml6aW8gQ2FzdHJvDQo+IDxmYWJyaXppby5jYXN0
cm8uanpAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiArI2RlZmlu
ZSBDU0lfQ0tTX01BWCAgICAgICAgICAgICAgICAweDNGRkYNCj4gPiA+DQo+ID4gPiBJZiBpdCdz
IGxpbWl0ZWQgYnkgbnVtYmVyIG9mIGJpdHMsIGkgd291bGQgZXhwbGljaXRseSB1c2UgdGhhdA0K
PiBpbmZvcm1hdGlvbg0KPiA+ID4gYXMNCj4gPiA+IChCSVQoMTQpIC0gMSkuDQo+ID4NCj4gPiBU
aGF0IHZhbHVlIHJlcHJlc2VudHMgdGhlIHJlZ2lzdGVyIHNldHRpbmcgZm9yIHRoZSBtYXhpbXVt
IGNsb2NrDQo+IGRpdmlkZXIuDQo+ID4gVGhlIG1heGltdW0gZGl2aWRlciBhbmQgY29ycmVzcG9u
ZGluZyByZWdpc3RlciBzZXR0aW5nIGFyZSBwbGFpbmx5DQo+IHN0YXRlZA0KPiA+IGluIHRoZSBI
VyBVc2VyIE1hbnVhbCwgdGhlcmVmb3JlIEkgd291bGQgbGlrZSB0byB1c2UgZWl0aGVyIChwbGFp
bikNCj4gdmFsdWUNCj4gPiB0byBtYWtlIGl0IGVhc2llciBmb3IgdGhlIHJlYWRlci4NCj4gPg0K
PiA+IEkgdGhpbmsgcGVyaGFwcyB0aGUgYmVsb3cgbWFrZXMgdGhpcyBjbGVhcmVyOg0KPiA+ICNk
ZWZpbmUgQ1NJX0NLU19NQVhfRElWX1JBVElPICAgMzI3NjYNCj4gDQo+IEhtbS4uLiBUbyBtZSBp
dCdzIGEgYml0IGNvbmZ1c2luZyBub3cuIFNob3VsZG4ndCBpdCBiZSAzMjc2Nz8NCg0KMzI3NjYg
aXMgdGhlIGNvcnJlY3QgdmFsdWUuDQoNCkNsb2NrICJjc2ljbGsiIGdldHMgZGl2aWRlZCBieSAy
ICogQ1NJX0NMS1NFTF9DS1MgaW4gb3JkZXIgdG8gZ2VuZXJhdGUgdGhlDQpzZXJpYWwgY2xvY2sg
KG91dHB1dCBmcm9tIG1hc3RlciksIHdpdGggQ1NJX0NMS1NFTF9DS1MgcmFuZ2luZyBmcm9tIDB4
MSAodGhhdA0KbWVhbnMgImNzaWNsayIgaXMgZGl2aWRlZCBieSAyKSB0byAweDNGRkYgKCJjc2lj
bGsiIGlzIGRpdmlkZWQgYnkgMzI3NjYpLg0KDQo+IA0KPiA+ICNkZWZpbmUgQ1NJX0NLU19NQVgg
ICAgICAgICAgICAgKENTSV9DS1NfTUFYX0RJVl9SQVRJTyA+PiAxKQ0KPiANCj4gV2hhdGV2ZXIg
eW91IGNob29zZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gYWRkIGEgY29tbWVudCB0byBleHBsYWlu
DQo+IHRoaXMuIEJlY2F1c2UgdGhlIGFib3ZlIGlzIG1vcmUgY2xlYXIgdG8gbWUgd2l0aCBCSVQo
MTQpLTEgaWYgdGhlDQo+IHJlZ2lzdGVyIGZpZWxkIGlzIDE0LWJpdCBsb25nLg0KPiBXaXRoIHRo
aXMgdmFsdWUocykgSSdtIGxvc3QuIERlZmluaXRlbHkgbmVlZHMgYSBjb21tZW50Lg0KDQpUbyBj
YXRlciBmb3IgYSB3aWRlciBhdWRpZW5jZSAoYW5kIG5vdCBqdXN0IGZvciB0aG9zZSB3aG8gaGF2
ZSByZWFkIHRoZQ0KSFcgbWFudWFsKSwgSSB0aGluayBwZXJoYXBzIHRoZSBiZWxvdyB3b3VsZCBw
cm9iYWJseSBiZSB0aGUgYmVzdCBjb21wcm9taXNlOg0KDQovKg0KICogQ2xvY2sgImNzaWNsayIg
Z2V0cyBkaXZpZGVkIGJ5IDIgKiBDU0lfQ0xLU0VMX0NLUyBpbiBvcmRlciB0byBnZW5lcmF0ZSB0
aGUNCiAqIHNlcmlhbCBjbG9jayAob3V0cHV0IGZyb20gbWFzdGVyKSwgd2l0aCBDU0lfQ0xLU0VM
X0NLUyByYW5naW5nIGZyb20gMHgxICh0aGF0DQogKiBtZWFucyAiY3NpY2xrIiBpcyBkaXZpZGVk
IGJ5IDIpIHRvIDB4M0ZGRiAoImNzaWNsayIgaXMgZGl2aWRlZCBieSAzMjc2NikuDQogKi8NCiNk
ZWZpbmUgQ1NJX0NLU19NQVggICAgICAgICAgICAgKEJJVCgxNCktMSkNCg0KPiANCj4gLi4uDQo+
IA0KPiA+DQo+ID4gc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgeF90cmcodW5zaWduZWQgaW50
IHdvcmRzKQ0KPiA+IHsNCj4gPiAgICAgICAgIHJldHVybiBmbHMod29yZHMpIC0gMTsNCj4gPiB9
DQo+IA0KPiBPSywgYnV0IEkgdGhpbmsgeW91IGNhbiB1c2UgaXQganVzdCBpbnBsYWNlLCBubyBu
ZWVkIHRvIGhhdmUgc3VjaCBhcyBhDQo+IHN0YW5kYWxvbmUgZnVuY3Rpb24uDQoNClRoZSBhYm92
ZSBpcyBhY3R1YWxseSBlcXVpdmFsZW50IHRvIGlsb2cyKCkNCg0KPiANCj4gPiBzdGF0aWMgaW5s
aW5lIHVuc2lnbmVkIGludCB4X3RyZ193b3Jkcyh1bnNpZ25lZCBpbnQgd29yZHMpDQo+ID4gew0K
PiA+ICAgICAgICAgcmV0dXJuIDEgPDwgeF90cmcod29yZHMpOw0KPiA+IH0NCj4gDQo+IEJlc2lk
ZXMgYSBiZXR0ZXIgZm9ybSBvZiBCSVQoLi4uKSB0aGlzIGxvb2tzIHRvIG1lIGxpa2UgTklIDQo+
IHJvdW5kdXBfcG93X29mX3R3bygpLg0KDQpyb3VuZGRvd25fcG93X29mX3R3bygpLg0KDQpJIGhh
dmUgdGVzdGVkIHRoZSBkcml2ZXIgd2l0aCBzL3hfdHJnL2lsb2cyIGFuZA0Kcy94X3RyZ193b3Jk
cy9yb3VuZHVwX3Bvd19vZl90d28gYW5kIGl0IGxvb2tzIGxpa2UgSSBhbSBsb3NpbmcgdGlueSBi
aXQgb2YNCnBlcmZvcm1hbmNlIChwcm9iYWJseSBkb3duIHRvIHRoZSB1c2Ugb2YgdGVybmFyeSBv
cGVyYXRvcnMgaW4gYm90aCBtYWNyb3MpDQpidXQgSSB0aGluayBpdCdzIG9rYXksIGxldCdzIG5v
dCByZWludmVudCB0aGUgd2hlZWwgYW5kIGxldCdzIGtlZXAgaXQgbW9yZQ0KcmVhZGFibGUsIEkn
bGwgc3dpdGNoIHRvIHVzaW5nIHRoZSBhYm92ZSBtYWNyb3MuDQoNCj4gDQo+IC4uLg0KPiANCj4g
PiA+ID4gKyAgIC8qIFNldHVwIGNsb2NrIHBvbGFyaXR5IGFuZCBwaGFzZSB0aW1pbmcgKi8NCj4g
PiA+ID4gKyAgIHJ6djJtX2NzaV9yZWdfd3JpdGVfYml0KGNzaSwgQ1NJX0NMS1NFTCwgQ1NJX0NM
S1NFTF9DS1AsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAhKHNwaS0+bW9k
ZSAmIFNQSV9DUE9MKSk7DQo+ID4gPiA+ICsgICByenYybV9jc2lfcmVnX3dyaXRlX2JpdChjc2ks
IENTSV9DTEtTRUwsIENTSV9DTEtTRUxfREFQLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIShzcGktPm1vZGUgJiBTUElfQ1BIQSkpOw0KPiA+ID4NCj4gPiA+IElzIGl0IGEg
bXVzdCB0byBkbyBpbiBhIHNlcXVlbnRpYWwgd3JpdGVzPw0KPiA+DQo+ID4gSXQncyBub3QgYSBt
dXN0LCBJJ2xsIGNvbWJpbmUgdGhvc2UgMiBzdGF0ZW1lbnRzIGludG8gMS4NCj4gDQo+IElmIHNv
LCB5b3UgY2FuIHVzZSBTUElfTU9ERV9YX01BU0suDQoNClRoYXQncyB0aGUgcGxhbi4NCg0KVGhh
bmtzIGZvciB5b3VyIGhlbHAgQW5keS4NCg0KQ2hlZXJzLA0KRmFiDQoNCj4gDQo+IC4uLg0KPiAN
Cj4gPiA+ID4gKyAgIGNvbnRyb2xsZXItPm1vZGVfYml0cyA9IFNQSV9DUE9MIHwgU1BJX0NQSEEg
fCBTUElfTFNCX0ZJUlNUOw0KPiA+ID4NCj4gPiA+IFNQSV9NT0RFX1hfTUFTSw0KPiA+DQo+ID4g
VGhpcyBzdGF0ZW1lbnQgc2V0cyB0aGUgbW9kZV9iaXRzLiBVc2luZyBhIG1hY3JvIG1lYW50IHRv
IGJlIHVzZWQgYXMNCj4gYQ0KPiA+IG1hc2sgaW4gdGhpcyBjb250ZXh0IGlzIHNvbWV0aGluZyBJ
IHdvdWxkIHdhbnQgdG8gYXZvaWQgaWYgcG9zc2libGUuDQo+IA0KPiBIbW0uLi4gbm90IGEgYmln
IGRlYWwsIGJ1dCBJIHRoaW5rIHRoYXQncyB3aGF0IGNvdmVycyBhbGwgbW9kZV9iaXRzLA0KPiBh
bmQgbW9kZV9iaXRzIGJ5IG5hdHVyZSBfaXNfIGEgbWFzay4NCj4gDQo+IC0tDQo+IFdpdGggQmVz
dCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg==
