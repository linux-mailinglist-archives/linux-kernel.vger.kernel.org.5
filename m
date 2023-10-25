Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5C7D6B41
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbjJYMWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbjJYMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:21:58 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08059C;
        Wed, 25 Oct 2023 05:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNx1gPHCuqBHU3/jaror6WJ3P58hQ3BoipjhTsRdviBBVO5Je97aA37pVCXUz3fm13yOjNe6ug5cKeJNsJOYkW/mqBIi0Sv7Uqb9k4OCUkgD/NUGmhztzY+e7itK6r0Wmp6iws5ScSixMKKHjtaUVhYDpvjUUnlIcPYk31Or8LOH7OPCtXXmypSOHZivsBabNb9zvRMslVKrCUfEk8ZMom9Dw9nfpjJc38PJIu40WWxVC8XazcrUeAZ1EkDY1VxoZg9qPJeuPIOQtpygbwtftD/D6+/nv/WXUxKlP4MAA+lsI45kFQ37xawtFFTpi4L1S1FFhgixTXMOSS5ld4szww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbiBzXRCLtu8IJKJ1wGpbLX3Yalr333XgmahGcagItw=;
 b=N4QzR4VBmOduNM2zaX1VQJ6XW4DSVdSKJeSa+QY8mLpX7j/RCNsVxZ1yZ7H2wi4LW8YFquP9iuHqBH0eGRy8ZHjPgvd+oYK/y+69zPj3L3PVWZjtgON6c4gkKORRTAofRnABi6i0JqPA/o4DcLLhb6fDGYCCIEVViqf6VZKOgPAodiuE4l59cZRSiwGyyu5ZevsOuST1dItqUViQWHNWs0hYLMDj9JnjzEX5VVpjyl5oUDBxO1Lgx4vltIFfhVika4Ze7HNXy55lyp6a0z++e9hYddkLIDOYPpWFXt/I14O7FXWioQ4bOCwqo9M1zyQHkC6s3xxcA+6VPSv2xt1S4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbiBzXRCLtu8IJKJ1wGpbLX3Yalr333XgmahGcagItw=;
 b=lN3qSWra+AuMTxRi9XnMsg2YlbtuIUYAGqS0V2W5EO/Kj62PYwJwTQVa9KQFvH7HlikhwOQ64IiuMy15oVcEtHw4A142qzZ7hW8aaLx/U4Z2cXNycmRTO/CrtDHpY7O74pyCkblj14Mq9DQQ+5TPlnawQVc0VZuZR41grHtL6N0=
Received: from DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17)
 by BY5PR12MB4933.namprd12.prod.outlook.com (2603:10b6:a03:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 12:21:53 +0000
Received: from DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::a5c1:c32c:cffd:84d2]) by DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::a5c1:c32c:cffd:84d2%2]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 12:21:53 +0000
From:   "Buddhabhatti, Jay" <jay.buddhabhatti@amd.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND 2/2] drivers: clk: zynqmp: update divider round
 rate logic
Thread-Topic: [PATCH RESEND 2/2] drivers: clk: zynqmp: update divider round
 rate logic
Thread-Index: AQHaACQrpS86hlDw70eQyI6Dj0lr1rBYVqOAgAIifnA=
Date:   Wed, 25 Oct 2023 12:21:52 +0000
Message-ID: <DM6PR12MB4465531035B81E676B62AC509DDEA@DM6PR12MB4465.namprd12.prod.outlook.com>
References: <20231016113002.15929-1-jay.buddhabhatti@amd.com>
 <20231016113002.15929-3-jay.buddhabhatti@amd.com>
 <3ff911fa4c417a81462813f975ac757f.sboyd@kernel.org>
In-Reply-To: <3ff911fa4c417a81462813f975ac757f.sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4465:EE_|BY5PR12MB4933:EE_
x-ms-office365-filtering-correlation-id: 48a60500-b4f1-428c-b3d4-08dbd554f8bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owe35/FzIZX7cCnnUU++HLqcupYLsznyLlMSbmKCA1Z+wF19ve15e5IcYVjOx5buOGf89whOK6Okcy4QW8HeBpgZuF8GylWSrngrTwfkV+ch4OF131xmGBRfvpfG6Q7S6aGsWKkBSeL2HC2yKUkqW+nMdU96CD44S/50UWwAKwwcVF7bByvO1M/Vbx9qj4IBAYCLls/baNwTpeJxKS2I2PepklWJyoPxpPSe7sKNgYGvKVNfK+CeiCe4CBVCtWoHDJ7HROfUoPzvF9ZC9Eqohxu9w0wFfAQ1Cypch/9WGqGQ36mKFq1PuRVe0iVWZuGTi7Si8nvYBt2K1MUU7nhtphvZHESnQVrgSQQeafR96cqazSaiPkmn9WuSooYiNqDfTi//wljl3F58Xs4sDT4lN5wSl7tqg1sw6KKseSzEHYj7+w6WEGchvWmtweZ/UujPlTMYApZV6NR3tgBNZH3OprdHFzownbL0Kuu4fSlpuWmNu8i2tcNQI44wG8gskzW61ZhVcBW14ztrinNVMx4iCbM/2xcJ5zVevSPz1fQkeK74dcam9o2Vwwl6n3oNFFuAVAoH2rUpuo+3xRrK0JQ58+oVsaS3dScEAsosgs0L7nzqZIZC30f5RC9cjurcD3SP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4465.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(122000001)(15650500001)(41300700001)(2906002)(26005)(33656002)(83380400001)(38070700009)(71200400001)(6506007)(7696005)(86362001)(66446008)(9686003)(53546011)(478600001)(76116006)(4326008)(52536014)(66946007)(4001150100001)(66476007)(64756008)(110136005)(54906003)(316002)(5660300002)(8676002)(8936002)(38100700002)(66556008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHVnMCtQTnJTbEJSSy9qamdrUUc4eWR1cERLeDhZMFltTVA2Q2o2VHRBVVd6?=
 =?utf-8?B?anVvUHZxNjZ4eVU4SWV4YnFWK1FGWWN2UUprZlhvTEJoQVBXZCtwcmZFOE01?=
 =?utf-8?B?NXp5ZHFCUWdSMUx6WW5vUlpmcnQ0K3hGV1EyanFLalVHQ3E2OGs1RWhwM3lT?=
 =?utf-8?B?cHgrRm1EQ25XVEx5SThIbEZUd0pVZng0UEU5bkFrNFVuckNKREQyWHZzZHgx?=
 =?utf-8?B?UXhqaTN2RFhnVDZSdWNWUkVvNnNtZHdZZ1VmZ1ZTaWJBeGE4M1N0empGM0VF?=
 =?utf-8?B?QWEzbWw3OEY2ajRXQTdudXFWVkh4VUhjV1FKS3BkY2VlcDhWRW9zelBaS1Va?=
 =?utf-8?B?R1RabG9tbTMxbWdtM2YxVG1hdVJzOTQ1QUhCR051Z1V4UTIrUGExUnlZZC94?=
 =?utf-8?B?MkU0U0QxM2phNFJ3REVpb0dzY1FhZXlIbWtwVXpWcllHRmtyRzBFa2x0STFV?=
 =?utf-8?B?OUZpY1lzb3dHdng3V0hpbjFSUGRsU1dSYTh2b1JPaXl0TFZzMHNhejhpVGVJ?=
 =?utf-8?B?TStlM1JLMkVwQTQwMWhJVnIxZktqdmVDckFna1B1VG1uY3RFWGFMNlR5Yk1Z?=
 =?utf-8?B?Mkp0Ui8vUjF5YVRRTWtSUjZ5cm9UaGJJdnR4WUZJdUkzSzVnb2tidXBqK3FG?=
 =?utf-8?B?VVZIQ1EwWkZ5ajdjVEprbE1SZk9lZjQ3eWw1QTN6TGQyOU1mVmE0c3pWclAy?=
 =?utf-8?B?Y3JsMTVaa3ZlSDBRWktFcjdZRW95YlFCWjhoQ2tHWks3ZWR3S1hUZU5jWUdi?=
 =?utf-8?B?UWczYUF3ZUV3TXB5Z0tYRWZGdUZIaEtvTVppYXFjNEk0ZnpTT2FtcGNsOTlF?=
 =?utf-8?B?eHQrYkt4T1drTVFqQTdOOFVoSEJZZm4ydXNzTlBVYWFYdUh3cmJmeHR0RTdG?=
 =?utf-8?B?U0YvaUVaYzlkcnlKZytzb3JSeVdxWldaZUJJYTRGYVY5WVhQOXJzb3EzVkUv?=
 =?utf-8?B?SVRqcHQrZlZyNlFtV0ZheDRHS1lrOUNjREdoYlhXbTNGYzBIMGNKN1pTNjVu?=
 =?utf-8?B?T05qa0hmZVVOa2w5WWVndWhZL2dkRndFM0Y2MndmVmtQckFCZFNrSTJ1Z3BV?=
 =?utf-8?B?clFqMWlrTEcvUXN0bkhFaUFuMmJLbHhOVHBXOCtGRDNuRGR3TEk4cFU5TDN4?=
 =?utf-8?B?WEV0WXJlLzlRT3NWaTlxcE9HKytOMzFyeDZqTi8vaFdpSFZZQ1FxTVJ5SVBr?=
 =?utf-8?B?V0Fjbms4dFFmWmE3RHJHS2FjdHUyUDJQcmNoTno3bWl4WWhqcGo1S0xWWUJ6?=
 =?utf-8?B?YzBsekZlWDIwLzNPTTVhbThBejhoVHRBTjA2aDhEWWdBSEZrYmJEazREYjZQ?=
 =?utf-8?B?ZWs2MVNBd0VRYUFpaUpXUXVpNm9yZEZwSTN1WFNvREJkeHNXc2txeFFtNzI1?=
 =?utf-8?B?cEVlZG04bDhEbUVMZ1dLVzIrU0t5b3BKZnBwYUZHd3FRbFBkNFpUbVVud3dH?=
 =?utf-8?B?K2kxYTZyN1hBbTQ4bUxkOVRtdTgxUGY1aHRLaDRYN3JwZlA4TzFiSm5jTnpt?=
 =?utf-8?B?VTh3QTlGR0x0VFdXaStZSGRtRGJjcUJQdjh0SnM4QkorOENFT1ROMDdMYUZQ?=
 =?utf-8?B?L2ZaVXhpMy9aL0p5WVRYbGNFYWo1MXVKZ0JJUUhwdWV1L1d3OWxFdG1tcmFo?=
 =?utf-8?B?SUo4K2hNekVGYjc5WUlEZTZRTWF4aCtkZHlBVmZLNXdDcVZBZHBMTHlBbjdh?=
 =?utf-8?B?cWlYSldKNjhzUjdKVVhFemJUNFJpOU00U1EzdXg3dHcrU3U2ZFB2OC96Q01Q?=
 =?utf-8?B?dUVRenlUQy9GbzBISXNWbWlnWUczeE94YmNIRjE1LzBuWEpBSzh2bllpc1VT?=
 =?utf-8?B?cFBWVGFlZVBtK2NXSzNUSUVmQjV2bmxLc1JRZTRDVXJiWGFkWG1WdlhtdzJu?=
 =?utf-8?B?RjZZSWlVYk5rTldTcmlrVUd5WXFaMytnanVIandQbzh1Q3M2ejRrUjFobTVI?=
 =?utf-8?B?VklRUFYvOEpHclNUSmIwQlBwSk5ZRGN5WEFLTFJuS1VxczdjZmRHTnEzcFdv?=
 =?utf-8?B?ZTVSSERZSzVTS0xKNjlod1FDcFQ0MnFlSnZ5RWVPSWVvNERIYWxjd0MxZmp3?=
 =?utf-8?B?cDhONDRxTlR1WVVHakRhNmtwNEgremNBallZRTk1SUphbVJPZVZ5WHlFNWJk?=
 =?utf-8?Q?zb28=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a60500-b4f1-428c-b3d4-08dbd554f8bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:21:52.9812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XuTlHSUhCZnSUsIBoOYcEjRWy19YkrX2z0CnO/Oc5chI11G4yHig8NNhONzjJ+zV+2batmUxW+/WPVVVhoJPgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4933
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjQs
IDIwMjMgOTowOCBBTQ0KPiBUbzogQnVkZGhhYmhhdHRpLCBKYXkgPGpheS5idWRkaGFiaGF0dGlA
YW1kLmNvbT47IFNpbWVrLCBNaWNoYWwNCj4gPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbXR1cnF1
ZXR0ZUBiYXlsaWJyZS5jb20NCj4gQ2M6IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEJ1ZGRoYWJoYXR0aSwgSmF5IDxqYXkuYnVkZGhhYmhhdHRpQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIDIvMl0gZHJpdmVyczogY2xrOiB6eW5xbXA6IHVw
ZGF0ZSBkaXZpZGVyIHJvdW5kDQo+IHJhdGUgbG9naWMNCj4gDQo+IFF1b3RpbmcgSmF5IEJ1ZGRo
YWJoYXR0aSAoMjAyMy0xMC0xNiAwNDozMDowMikNCj4gPiBDdXJyZW50bHkgenlucW1wIGRpdmlk
ZXIgcm91bmQgcmF0ZSBpcyBjb25zaWRlcmluZyBzaW5nbGUgcGFyZW50IGFuZA0KPiA+IGNhbGN1
bGF0aW5nIHJhdGUgYW5kIHBhcmVudCByYXRlIGFjY29yZGluZ2x5LiBCdXQgaWYgZGl2aWRlciBj
bG9jaw0KPiA+IGZsYWcgaXMgc2V0IHRvIFNFVF9SQVRFX1BBUkVOVCB0aGVuIGl0cyBub3QgdHJ5
aW5nIHRvIHRyYXZlcnNlIHRocm91Z2gNCj4gPiBhbGwgcGFyZW50IHJhdGUgYW5kIG5vdCBzZWxl
Y3RpbmcgYmVzdCBwYXJlbnQgcmF0ZSBmcm9tIHRoYXQuIFNvIHVzZQ0KPiA+IGNvbW1vbg0KPiA+
IGRpdmlkZXJfcm91bmRfcmF0ZSgpIHdoaWNoIGlzIHRyYXZlcnNpbmcgdGhyb3VnaCBhbGwgY2xv
Y2sgcGFyZW50cyBhbmQNCj4gPiBpdHMgcmF0ZSBhbmQgY2FsY3VsYXRpbmcgcHJvcGVyIHBhcmVu
dCByYXRlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmF5IEJ1ZGRoYWJoYXR0aSA8amF5LmJ1
ZGRoYWJoYXR0aUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Nsay96eW5xbXAvZGl2
aWRlci5jIHwgNzANCj4gPiArKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDYwIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gQ2FuJ3QgYXJndWUgYWdhaW5zdCByZW1vdmluZyB0aGF0IG1hbnkgbGluZXMhDQo+IA0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3p5bnFtcC9kaXZpZGVyLmMNCj4gPiBiL2Ry
aXZlcnMvY2xrL3p5bnFtcC9kaXZpZGVyLmMgaW5kZXggMzNhM2IyYTIyNjU5Li5hNDJjMTgzZDdl
NWQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvenlucW1wL2RpdmlkZXIuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvY2xrL3p5bnFtcC9kaXZpZGVyLmMNCj4gPiBAQCAtMTkzLDIzICsxNDksMTcg
QEAgc3RhdGljIGxvbmcgenlucW1wX2Nsa19kaXZpZGVyX3JvdW5kX3JhdGUoc3RydWN0DQo+IGNs
a19odyAqaHcsDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBESVZfUk9VTkRfVVBfVUxMKCh1
NjQpKnByYXRlLCBiZXN0ZGl2KTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgYmVz
dGRpdiA9IHp5bnFtcF9kaXZpZGVyX2dldF92YWwoKnByYXRlLCByYXRlLCBkaXZpZGVyLT5mbGFn
cyk7DQo+ID4gLQ0KPiA+IC0gICAgICAgLyoNCj4gPiAtICAgICAgICAqIEluIGNhc2Ugb2YgdHdv
IGRpdmlzb3JzLCBjb21wdXRlIGJlc3QgZGl2aWRlciB2YWx1ZXMgYW5kIHJldHVybg0KPiA+IC0g
ICAgICAgICogZGl2aWRlcjIgdmFsdWUgYmFzZWQgb24gY29tcHV0ZSB2YWx1ZS4gZGl2MSB3aWxs
ICBiZSBhdXRvbWF0aWNhbGx5DQo+ID4gLSAgICAgICAgKiBzZXQgdG8gb3B0aW11bSBiYXNlZCBv
biByZXF1aXJlZCB0b3RhbCBkaXZpZGVyIHZhbHVlLg0KPiA+IC0gICAgICAgICovDQo+ID4gLSAg
ICAgICBpZiAoZGl2X3R5cGUgPT0gVFlQRV9ESVYyICYmDQo+ID4gLSAgICAgICAgICAgKGNsa19o
d19nZXRfZmxhZ3MoaHcpICYgQ0xLX1NFVF9SQVRFX1BBUkVOVCkpIHsNCj4gPiAtICAgICAgICAg
ICAgICAgenlucW1wX2dldF9kaXZpZGVyMl92YWwoaHcsIHJhdGUsIGRpdmlkZXIsICZiZXN0ZGl2
KTsNCj4gPiArICAgICAgIG1heCA9IGRpdmlkZXItPm1heF9kaXY7DQo+ID4gKyAgICAgICB3aGls
ZSAobWF4ICE9IDApIHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKChtYXggJiAxKSA9PSAxKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHdpZHRoKys7DQo+ID4gKyAgICAgICAgICAgICAg
IG1heCA9IG1heCA+PiAxOw0KPiANCj4gSXMgdGhpcyBmZnMoKT8NCltKYXldIFdlIG5lZWQgbGFz
dCBzZXQgYml0IHRvIGdldCBtYXggd2lkdGguIEkgd2lsbCB1c2UgZmxzKCkgdG8gZ2V0IG1vc3Qg
c2lnbmlmaWNhbnQgc2V0IGJpdCBmb3IgdGhpcy4gVGhhbmtzIGZvciBzdWdnZXN0aW9uLg0KDQpU
aGFua3MsDQpKYXkNCj4gDQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAtICAgICAgIGlmICgoY2xr
X2h3X2dldF9mbGFncyhodykgJiBDTEtfU0VUX1JBVEVfUEFSRU5UKSAmJiBkaXZpZGVyLT5pc19m
cmFjKQ0KPiA+IC0gICAgICAgICAgICAgICBiZXN0ZGl2ID0gcmF0ZSAlICpwcmF0ZSA/IDEgOiBi
ZXN0ZGl2Ow0KPiA+ICsgICAgICAgcmF0ZSA9IGRpdmlkZXJfcm91bmRfcmF0ZShodywgcmF0ZSwg
cHJhdGUsIE5VTEwsIHdpZHRoLA0KPiA+ICsgZGl2aWRlci0+ZmxhZ3MpOw0KPiA+DQo+ID4gLSAg
ICAgICBiZXN0ZGl2ID0gbWluX3QodTMyLCBiZXN0ZGl2LCBkaXZpZGVyLT5tYXhfZGl2KTsNCj4g
PiAtICAgICAgICpwcmF0ZSA9IHJhdGUgKiBiZXN0ZGl2Ow0KPiA+ICsgICAgICAgaWYgKGRpdmlk
ZXItPmlzX2ZyYWMgJiYgKGNsa19od19nZXRfZmxhZ3MoaHcpICYgQ0xLX1NFVF9SQVRFX1BBUkVO
VCkNCj4gJiYgKHJhdGUgJSAqcHJhdGUpKQ0KPiA+ICsgICAgICAgICAgICAgICAqcHJhdGUgPSBy
YXRlOw0K
