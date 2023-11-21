Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AEB7F2638
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjKUHS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjKUHSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:18:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B7B10F;
        Mon, 20 Nov 2023 23:18:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLTQ7OBDqxP41dxGlUzrjy++qEWO1jiKRxaZl7h3QoLEznLZ8wefggjYyxKK9VDonY5arHXp8Yrv4Z5DI3rw83DmE/F6po/slnvDHzIxoAxHWsBnpV8RbNf1XcLN1NzQzQ39RRK5cQSBHspJrN+SXqq8nOOJdYJ3qpZVSjupvsIrB52vb2K5j6UbG9BnlB4qv9SZqtkhHf8exnvKgzp6VF5gaFUq5I6MiSHy/aqeMravz25A7J31SX2XV4pAwD+jBi84x6zPL1HrBcz0oXdWEY3wg0OuZafZNn0k3UL6hJjo6r4hE5L7wPontn+2GKWx24haemczYf5GAGaGm5UyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0Hp/6+aW18F6WcIgHjUz+bcfHrMYrmx5jTGUNobcGU=;
 b=bKf8m6f2Crpw82l3+cUFNbD3cL/EAct4Rnoe+PP1iRat1CsWeEvdhGKgMLLtX7wQb4FUG8ssYWfG0zRPFbeBP3MW5Rx1PV4smTd5gNSKDJul1zKdTd4bjOSMpsn6UC9VoHuTa059alIB5FxNOx+hrAl/9zUREv25UPSVeWAacUm+iGG3zXTtiTHHZJZZ2eY2zS8FjM1bRGw8JzR3b1vWl0QU8VCXjQe/Gbej2y7VGax4B6MqF9DXtadMHgMu/rKxqWz8B1793VrQAW4EZVjOkg5nEUaSVKQUVEljwX14mlUYqRZkowMuhI8pcFC83I8KuP3/bSV40foW5uxBiLEtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0Hp/6+aW18F6WcIgHjUz+bcfHrMYrmx5jTGUNobcGU=;
 b=lITwNvELQA3ldnHLhzPjiIujKxl1c64PsTEdjb6oe4wNQrmUWICCmRjm3VMUEwygEbNWXQWlcOvYGdh7I8cWjqK4yHzEW1tiXhVQKgdSojWOesTdAE64sP4ZuCAM8LqtbonNPsp2+D5ua1CbPjacvicSLIVoC4GNJHlUqg4qjkk=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 07:18:16 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 07:18:16 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v10 1/8] spi: Add multi-cs memories support in SPI core
Thread-Topic: [PATCH v10 1/8] spi: Add multi-cs memories support in SPI core
Thread-Index: AQHaGibZHpgN4p9GY0OYE+Yp0J4AjrCDQBgAgAEe/jA=
Date:   Tue, 21 Nov 2023 07:18:15 +0000
Message-ID: <BN7PR12MB28020429F4221F79E6D654DBDCBBA@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
 <20231118135446.52783-2-amit.kumar-mahapatra@amd.com>
 <281c9708-f965-4bb1-821e-3e6cfe26ba5d@sirena.org.uk>
In-Reply-To: <281c9708-f965-4bb1-821e-3e6cfe26ba5d@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|DS0PR12MB7804:EE_
x-ms-office365-filtering-correlation-id: d32e010e-e185-417d-3abb-08dbea6207c7
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sRpSspTn+cG2uKLxa+JyVwpTh5Pgzr9Iv4gayj2GGSAXMjWoY/nPkJ7GyHiTPlAIgqx95Sx8c+BprnkHaQElBgbIDCgd5mqWL+ZGC2UrOTJ887UBV6PB+d+aMMt5WL5A5AXi3c4Bpo/UjmdnZl8kljRvwSGwyQjWKebk4X6PeXaD/VYtaSRsxNXHOQVMK8bf2Ts1KH4k3x+lnAsYXNNAXs8jL8DYBXL8N+cHJGN0hSwRd4r09aPC756Mo/I2vPgdEJsCvtw2zLWZG8iK1PZw6Gk9V+XPR6m1aNHtKwgzCWMz5AUfKBkOdUXDsYIyW81ii0BAzsQRDSGDK00c0yPXTR0IokOz09r51q8D4N3AzfIQYUUoV4ZN4w/BGbYuzJpAaYW35L39jAl9k6PS57Bzkk0CRYSWnOt1L9meOB4leXawhWwrNQuAqaJWbNBkPBMilR8vL9Wpd52TlHbwBdgZq29iLnYfnP09YQ6xcHjZEPH3VSJ4nn3y297rSHGLVOu5tOQ7FZJ10Tchgiv5/LcdsI1B3zqsd3lYUA9/g4n86JeNHg3W771LMd2dRIGsSxFO3wbodZ3mHRzQqNFBve8LMAkkU7lkygyL69x7Q34FK/RQr1uV1TZRAwRsPWgrPSzXL7zuupG4nIyntfV33pwMIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66556008)(66476007)(66446008)(66946007)(76116006)(316002)(6916009)(64756008)(54906003)(53546011)(9686003)(71200400001)(6506007)(7696005)(26005)(478600001)(38070700009)(966005)(38100700002)(122000001)(83380400001)(33656002)(86362001)(55016003)(5660300002)(7416002)(2906002)(8676002)(4326008)(8936002)(41300700001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTV6VjlmdVdXZExLYUU5MnNBZVF3YWE5V0IxcTZTb1BTV0d0bDA0UnRFb0o1?=
 =?utf-8?B?dzJYRE1sd3JjcVJ5aUNxVDY4MnFwZG9aMGIvS1d6Z2hsSEYvWHhhSG5IempX?=
 =?utf-8?B?UDkzMW9VdUplVlJlUTBjMkROeHRkcFFrZTM4d3ZRRzJTRWpPYmIvTjRvVHg3?=
 =?utf-8?B?cXpsOGtydG1wZnB3aE9kTUxkQlJmT3p4WlJqTEtqYjkrTHR4bXo5UGZ4YVNz?=
 =?utf-8?B?TlhIVHNaY3h2YU80TFlrMmhlQ2xveHNVVHJJVWZKRi8xUlhwVCtTZDNJVW5G?=
 =?utf-8?B?dUVmTWtzb09Ibks2TnhmRnRxMmV0NEJWaS9qbUhuMmY1V1hqZGovM1ptVExU?=
 =?utf-8?B?bVhUVFVMODl4Y0Z5VHhqaUJnSE9FQVhYQXVSbVFoTENpYlRTc1pKT1FVcHJq?=
 =?utf-8?B?U0xzK3FtdHpCbCt4RFJEMFg0b0JmeFZTQjJtN1kvMjhDcmM0MUg1bFg4cGZ1?=
 =?utf-8?B?OUNHeTdWNUZ1aEJLSjNnU09JaHJwb0JCcUJid3RaTERidVVqb0FCQ0oyT1VL?=
 =?utf-8?B?bDhnUXUxUFNwNk0xOXAxUmgyejZDWVBLeFJJRklxVmZ4a3dYMXVJODMzZFVB?=
 =?utf-8?B?RHlNbHJuUDFGbXdMZmx6Zmcrbi9nek9jNHZtd05qS3IwSWFLN1djdmFGYSt6?=
 =?utf-8?B?U2xnRUxPMC9pcDZIeG4zZ2tJdUZGcVowdUlZY2hvcllneUFIdll2dVZZa0NS?=
 =?utf-8?B?d3RvaGEwSm9CUEpYWU9ZTXpWU0NIajk0WDM4VTFyTHRrdVpVK0V3RnQrMy93?=
 =?utf-8?B?T0Y0RTlPOGlNOFhBanFIMldFRW5nc3R6cFAwZkxKeVh2emVMNS9IRTJaSDhz?=
 =?utf-8?B?RFBNZS9DZ0xVcXJhVktheTd6NHo2ek11NGtQWW9BVlhveHlSd1pQb0lNYnAw?=
 =?utf-8?B?K00vZ1JZWENWYjl3UVA2c1BkTGdkbUVZRm5ZTzFyRlVaQXllTkUwejl3ay8y?=
 =?utf-8?B?VmZ6T2J2QS9Yd0ZBWXVCanFtZ2hMSkFSN25LWkxySUVheXBGSStmRWMyTVlw?=
 =?utf-8?B?cFdobWo0bm5pT0ZJL2VraEhUL3gvek45ckFMTUNxMldDajBLUmk0TzV4V0Fk?=
 =?utf-8?B?ZHNmQkVXL0ljcjNaOEpBeFhVejU5TlNpVXBDZHVwVlU0d0RtTUJxbW1teDNO?=
 =?utf-8?B?bUc3bVBRL2ttSk1UQnN3K2E1K0lHeEtzKzhHTDNvT1dFTldnQUVmYlN5K1Vv?=
 =?utf-8?B?eE5BTFRSK2UxR25JZU9UYW9kaEkwQTFldDRGaWdzTzZOYXhwUmZ5Z0NiQWor?=
 =?utf-8?B?a1pyejRlcGR5UVZQWUdnVkNwOW9XUitnR05KS2h4b3ZDdzNSajMxZzhQQzAy?=
 =?utf-8?B?ajVFZmZNNVBFQkFrY0RGWW5XNkdGd2orei9kNkxQS0JPdmVZNDk1Q21NdnZs?=
 =?utf-8?B?SkZZbXRDQjM2YmQzUWpMR3JXM0kxS0RuSUpOd0FmUHQ0a3owY3c1NWd4ZU1v?=
 =?utf-8?B?dkpjQXNIWWpzUHRUN1NXTjh6dmVabTJ4RkF4cXRmSlR2aUk4ZGVIME9aVUJK?=
 =?utf-8?B?OGpEdEliRUJMNHNtYWN2YWNERjRjRVp1OTVOc2pEMkFkQTkzYUF5UjJVc2FV?=
 =?utf-8?B?ZkhsY0hBVklkSHhCZ0VnQ3J4ellYdDFEczhSaUJEYmFDR1hKbDdRdVVsMTBI?=
 =?utf-8?B?RmZLdWhRanBqQ0NYK2dQQnpkaGhQV2EwbEw2YkNONWo4S1FqaHpYK0Rxc21v?=
 =?utf-8?B?ZXc3R3daYU5EQisrSWQ3cjlFTGY1OEthdUs2Y3RaU1JzQ2Rmb3ByWXExekhj?=
 =?utf-8?B?ZWlTYWFRVGJVUGhzYmVFdUhncjROSzBUZUQ4cmgzUnlIeHRETHkxNno2UzNx?=
 =?utf-8?B?OVpjOXlMQzBjMlQ1aXU3ZHNvZ3R3aXNBR3V2UEwwN0FUMy9Sa3pWZlNKWERm?=
 =?utf-8?B?YjNOTmJ2aytVbzUvbElNM1VEUGIvZG1JQkM0cEppa0RoZS95N2ZYUFJHMWRn?=
 =?utf-8?B?eGpUZzdTUFdPaFhsQUp6bDJ1ZUN5ajJqTnFmR1lpTUVTcll6T3ZaZExaZXlI?=
 =?utf-8?B?eFdIaHhlS2VqKzJtNG1RVnFEc2RKK1gvYStMdSsxdWxoNFRBMHMrVXdOOXhi?=
 =?utf-8?B?cVFkdzlhejcvMVEybFZzT3U0cEhhODJTcDJ4OWZIMHVGUThBcE9pNXpBNlVM?=
 =?utf-8?Q?J9kQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32e010e-e185-417d-3abb-08dbea6207c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 07:18:16.0842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kp3yvTyAw83YgafGycMypgoLMCZHuxhEHkUD2A1uOKIr3PAKZPlqDXoEB+zdBBEptWarkn7gfzmY9ihfayI0hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWFyaywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJr
IEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjAs
IDIwMjMgNzozMyBQTQ0KPiBUbzogTWFoYXBhdHJhLCBBbWl0IEt1bWFyIDxhbWl0Lmt1bWFyLW1h
aGFwYXRyYUBhbWQuY29tPg0KPiBDYzogdHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnOyBwcmF0eXVz
aEBrZXJuZWwub3JnOw0KPiBtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tOyByaWNoYXJkQG5vZC5h
dDsgdmlnbmVzaHJAdGkuY29tOw0KPiBzYmluZGluZ0BvcGVuc291cmNlLmNpcnJ1cy5jb207IGxp
bnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBtaWNoYWVsQHdhbGxlLmNjOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbmlj
b2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tOyBhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbTsN
Cj4gY2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2OyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtA
YW1kLmNvbT47IGxpbnV4LQ0KPiBhcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGdpdCAo
QU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPjsNCj4gYW1pdHJrY2lhbjIwMDJAZ21haWwuY29tDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEwIDEvOF0gc3BpOiBBZGQgbXVsdGktY3MgbWVtb3JpZXMg
c3VwcG9ydCBpbiBTUEkgY29yZQ0KPiANCj4gT24gU2F0LCBOb3YgMTgsIDIwMjMgYXQgMDc6MjQ6
MzlQTSArMDUzMCwgQW1pdCBLdW1hciBNYWhhcGF0cmEgd3JvdGU6DQo+ID4gQU1ELVhpbGlueCBH
UVNQSSBjb250cm9sbGVyIGhhcyB0d28gYWR2YW5jZWQgbW9kZSB0aGF0IGFsbG93cyB0aGUNCj4g
PiBjb250cm9sbGVyIHRvIGNvbnNpZGVyIHR3byBmbGFzaGVzIGFzIG9uZSBzaW5nbGUgZGV2aWNl
Lg0KPiANCj4gVGhpcyBicmVha3MgYW4geDg2IGFsbG1vZGNvbmZpZyBidWlsZDoNCg0KVGhlIGNh
dXNlIG9mIHRoaXMgZmFpbHVyZSBhcmUgdGhlIGZvbGxvd2luZyBwYXRjaGVzLCB3aGljaCBuZWds
ZWN0cyB0byANCnV0aWxpemUgc3BpX2dldF9jaGlwc2VsZWN0KCkgZm9yIHJldHJpZXZpbmcgdGhl
IENTIHZhbHVlLiBJbnN0ZWFkLCANCml0IGRpcmVjdGx5IGFjY2Vzc2VzIHNwaS0+Y2hpcF9zZWxl
Y3QuDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDUyNTE1MDY1OS4yNTQwOS0x
NC1yZkBvcGVuc291cmNlLmNpcnJ1cy5jb20vDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyMzAyMTYxMTQ0MTAuMTgzNDg5LTMtanBhbmlzQGJheWxpYnJlLmNvbS8NCg0KSW4gbXkgdXBj
b21pbmcgc2VyaWVzLCBJIHdpbGwgYWRkcmVzcyB0aGVzZSBpc3N1ZXMuDQoNClJlZ2FyZHMsDQpB
bWl0DQo+IA0KPiAvYnVpbGQvc3RhZ2UvbGludXgvc291bmQvcGNpL2hkYS9jczM1bDU2X2hkYV9z
cGkuYzogSW4gZnVuY3Rpb24NCj4g4oCYY3MzNWw1Nl9oZGFfc3BpDQo+IF9wcm9iZeKAmToNCj4g
L2J1aWxkL3N0YWdlL2xpbnV4L3NvdW5kL3BjaS9oZGEvY3MzNWw1Nl9oZGFfc3BpLmM6MzI6NTI6
IGVycm9yOiBwYXNzaW5nDQo+IGFyZ3VtZW4gdCAyIG9mIOKAmGNzMzVsNTZfaGRhX2NvbW1vbl9w
cm9iZeKAmSBtYWtlcyBpbnRlZ2VyIGZyb20gcG9pbnRlcg0KPiB3aXRob3V0IGEgY2FzdCBbLVdl
IHJyb3I9aW50LWNvbnZlcnNpb25dDQo+ICAgIDMyIHwgICAgICAgICByZXQgPSBjczM1bDU2X2hk
YV9jb21tb25fcHJvYmUoY3MzNWw1Niwgc3BpLT5jaGlwX3NlbGVjdCk7DQo+ICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+Xn5+fn5+fn5+
fn5+fg0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1OCAqIHtha2EgdW5zaWduZWQgY2gNCj4gYXIgKn0NCj4gSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIC9idWlsZC9zdGFnZS9saW51eC9zb3VuZC9wY2kvaGRhL2NzMzVsNTZf
aGRhX3NwaS5jOjEyOg0KPiAvYnVpbGQvc3RhZ2UvbGludXgvc291bmQvcGNpL2hkYS9jczM1bDU2
X2hkYS5oOjQ1OjYzOiBub3RlOiBleHBlY3RlZCDigJhpbnTigJkNCj4gYnV0IGEgcmd1bWVudCBp
cyBvZiB0eXBlIOKAmHU4ICrigJkge2FrYSDigJh1bnNpZ25lZCBjaGFyICrigJl9DQo+ICAgIDQ1
IHwgaW50IGNzMzVsNTZfaGRhX2NvbW1vbl9wcm9iZShzdHJ1Y3QgY3MzNWw1Nl9oZGEgKmNzMzVs
NTYsIGludCBpZCk7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn5efg0K
