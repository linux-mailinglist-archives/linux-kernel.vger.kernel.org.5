Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8092C7C4B08
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjJKG6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJKG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:58:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2116.outbound.protection.outlook.com [40.107.114.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF9B8F;
        Tue, 10 Oct 2023 23:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wtq8YMYmJI5Xivs208PQmyV+7x0ZppYiFcoJuJENU74fddKI+/osyxjBOEys/oMQHshyJA0+SE4K31T5Vl2bUo+zwyc2k1VMftqus58HaSygCcicPRWcqTamsqDGRgGbGAviTljPFaP9ipsIlhPjFTrBVVEtz+8d4USZB/cFiCZBtWtYaHydLYKlTshea9Tv0guShrVw7SnnYdwBu9i6QFIlDgFvMGsNcu14scpYdozc38NNMxZ8ySYfziFEpBIsuR6RZbLQZJ/uVBLux1a9jseAOM8Jkj+wx6uvC81Px832xEKYPqdHKjK1Bce41eyXoxvkgV4eOD1PVLrBjFm29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sco/2u8ou8k6seAwTgCVA1wqdMiVptjy3LI/5bGSj3Y=;
 b=f6nRWhjYDHGCuNUOJ6fFG0mqPUTvE0wiziQvuQd6sUpvhmpBjRMHoqGOcHsu5B3WV+NGoJZtR8t8Fbfyt0aVKFy2PJZ5wbW1a6GtFqsGi03Jae8xgQJLpJw3ume51aCnYhkpjdQd1BgnfGKXZ7jJcezJUE2A4CcI3/xeiZZ3YEgkLPsBS3WUN3Zx4g6D8lia+32BSYQrRRTyv/rWjey/WqGn8R53833Qa2YYrDpOHPxW9IJtYtZenbmaPVljR4O5lwAgpCork7BWz1J/U11+lPDhi+CIVJOIaL0qSAVrcANQtj8jQY+EtFnWeH+6tPgDhE9iXT9B6uOkAldQl/BPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sco/2u8ou8k6seAwTgCVA1wqdMiVptjy3LI/5bGSj3Y=;
 b=hkZyw0P2U/Ex0okRY4w44ypj+bBnqDi6qIpCKATt79jnU3ivM9r25WbApZqY6+RjaafhrY89M3qNXCVVqzSxlbD6UuD6WXfa+NlWLnBWfIJdloLYhuxPh4TJad3OZ/QmQfijy6HoljlnGexDV9f+9OMaqJR+PPQzZS8aNIAKuHg=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OSZPR01MB9410.jpnprd01.prod.outlook.com
 (2603:1096:604:1d8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 06:58:02 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2%3]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 06:58:00 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v2] alarmtimer: Fix rebind failure
Thread-Topic: [PATCH v2] alarmtimer: Fix rebind failure
Thread-Index: AQHZ7SyA4lmrPv0tQ0OIkUBZ8XwsyrBBqzEAgAAC0jCAAAcKAIAAFRaggABTdwCAAIkS4IAAmHMAgAAIMwCAAP3uIA==
Date:   Wed, 11 Oct 2023 06:58:00 +0000
Message-ID: <TYCPR01MB112693065867ACA9C42370B9F86CCA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
 <87il7fq1al.ffs@tglx>
 <TYCPR01MB112697A5D4B57101CDE27C88D86CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87fs2jpznr.ffs@tglx>
 <TYCPR01MB11269C6BF3934F9AAC44F855186CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87bkd7pic3.ffs@tglx>
 <TYCPR01MB11269FF2DBFDC96B9C12D2E5E86CDA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87o7h6o6d1.ffs@tglx>
 <CAMuHMdVJnqkF7xmjfOyoxE_Lq=AO85CDD85qu3O+xcSr-3BLTQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVJnqkF7xmjfOyoxE_Lq=AO85CDD85qu3O+xcSr-3BLTQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OSZPR01MB9410:EE_
x-ms-office365-filtering-correlation-id: 15a0d6fb-fda2-40de-5e18-08dbca27682a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cranVFAmxbfmfRyl7WlhAGvbRmy0LIO+pmn3nMMr6beVcKJGYgllt8M8MjD07YpxF7tgI5Z/9nmWZekFZSjaUdpF0mhE1CDZecBnZLvltvUHzxowsolUzL/kTUymxj8NEPNAoLs6S9mXamwe5km4iiURZGH6viyfGlaJqprkJ/Mt4sUTzYBElqhQtzW6KzquMjOMf/KR8DJigZeTQyK5uxJBFSfHeJmTInyd+wTOpt3iB9hwPul5fg9RszlMh3ujEnMvngJTUoLzEOLs7AhHkJw0GfB9Fio+zQdfSerSxHGkI/EScyvWIlqDLBz5rJ5ffEBDLiFBAaPE/re+adjeF1bWFXzccOvgBPOvXFNzO1T7tfMK5V6g1152TvWdUwqQXVxU6a/w5luM1QJyLT1f/dlR5nslbzteBau9BpCpSN/ONgrkUEfDRVwg/MVLQWJiaQ7j3hMMTBTrW6nN8FWSnd2t1haG+9T0YWB7u/pmzKcwAHv6kbfgYK0SXfTKeChzaWjsI7VLSJg+dEJ9KVaR1TFIElK6Kp5Jf2DJlH0RSbcxROVVMJHa8jTTSvHu9oYwPwOSFFHXVPrRiRem4dc+yms0WF+gE9bpJ3SKYJOT5DR/rbS4CAtuHytEKxsvfJbi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(33656002)(86362001)(38100700002)(38070700005)(55016003)(6506007)(9686003)(2906002)(53546011)(478600001)(7696005)(66446008)(64756008)(66476007)(66556008)(76116006)(66946007)(54906003)(5660300002)(110136005)(41300700001)(316002)(7416002)(71200400001)(52536014)(26005)(4326008)(8676002)(8936002)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzBTZFJYZi9XTzZrN1hncXRjei8wSVN6c050c1I1MWg3aHg4Rm8vMVNkQUNt?=
 =?utf-8?B?Wmc4dnBWbi93eS9VQXR3dUFxVzEveWIzd0NpWFNieVFNUkRRQUJBeGQ3cE5q?=
 =?utf-8?B?ODhNRnh5S0VHNUM3THJndk9vczh1OUZ3bEFjNmdxcTkya0hWRmlJUHZSU01C?=
 =?utf-8?B?ZzFzTnFXZkFQL0Z0NFNHc256eHZvcm40OUhQdFZPekMzSE1GMENBcFJUdFRP?=
 =?utf-8?B?RmFHVHhnd09ZVSs3NEQyQWt4QVAyanVqMHVxR1hvNkRzMVp2N3J3SlNTVC9j?=
 =?utf-8?B?SFJwNDlmcnNGNXJsRFM2dVBvdmI2Z3U5SjNYK1UrMGRWRER2WHY5Y0VlcW1S?=
 =?utf-8?B?R2tlR0k1ckFRb0g5RWFtSytBVlY0UHpnaVB6YTRtNTJ3Nkt6aFFyVUcvZDJw?=
 =?utf-8?B?VTVLV1dWMU1iRjdibnhrQklSSzVnclJMYzNXWnNpQTYyOHIyRW1qTUlaVTEx?=
 =?utf-8?B?c1hEZ3d6SlhCZXhJU0t4Yk5uYnZRSkQ2V1NCT204VUtKQUd2UkNwMGhWbGJv?=
 =?utf-8?B?OFNyTzZWTitETGRzNTlVaWRCQnRjbExYb1hINklLNE1wTzhWVWFEZ3FWYXNk?=
 =?utf-8?B?MzZiRlM3M1RhNXR4TS9QNVBKa1RzdTJkU2tsTmpjblcwOGdndWVBSTBDYUFp?=
 =?utf-8?B?akNJR2EwUXJMV0szWStmZ3hHT0c0WDhVR25OaTBNUUQyQ0I0dVF2YVkrazBv?=
 =?utf-8?B?dDhyZGx1TVZFOWpDTHJXTS95RkJIV3hDZ1Bad2dVYlpWV0RZTnh1citMOFlO?=
 =?utf-8?B?ajdHM2pjSWE1WjYzTDRFQnBUcnVVRVBXTXFDQ25OZklWMGhGc0dDMy9Ycmkr?=
 =?utf-8?B?bTRDeXA2WHRyaVdETVFlb25nTkM2dFZ6QjFtdXFxR2ExMDJoTW9aSE9vdXhH?=
 =?utf-8?B?MXB5K25pcTJzVzFNV1BWR1pwRlNUeU5GZjN4ZXhGMjBiVUY2SndsUjJXOXY5?=
 =?utf-8?B?eklOZGIxL1UybHgwYUxrSnRrRUJTb0NPM29KckxjZkROam5ieFY2N1p1aHFv?=
 =?utf-8?B?NmZxOHFBSVlnUkdxNzB5MStZenliUnRGb2tZNzlBSWpMYWI0d2pNQndGNThi?=
 =?utf-8?B?NjNpdlllZVl2MzBCcjIrOVFPMVFSUERGbHVnUmowTkFOWHVUUy91b2FNcmFt?=
 =?utf-8?B?d0tDaGFFWmJmUTVTQ1hRL3lyUzM3VkkwditjOHZHak9yTTMxaklaaDlzeDB5?=
 =?utf-8?B?S2xBN082ZG1YQzIwN2FCbTUzc0VDanBzek9aM0xON2pURkE1dTdRMi9pUjd2?=
 =?utf-8?B?WFNQRHI4dzFNVFVxOENzYVAyUTJJVHEvZzVCbkk0b0Q2K0FNZTVjTnhGWGlU?=
 =?utf-8?B?SlNUeUZmMTNGdnVXTU9kY3FCcUdnMmtzVXFsYUNPZ1orRTAzQVJheHRNVm9a?=
 =?utf-8?B?QmVPMWtLMVFHSmFucWJlZ2hHNTI3SVdKYm5UU2ZxNi9ncFp3eEtNY0FGWS80?=
 =?utf-8?B?QzBsNDF4N01LOVRtT3dSTi9QS1ZMRWZaNlorRUM1T3JsMkZJOEcxS3UwQXFa?=
 =?utf-8?B?ZyttQ05NMFYxSW9aTERWaXJNZzhpMkc4UENLYytNZFpuVlJxVDh1Tjg4b2g1?=
 =?utf-8?B?N09vYldHRE5HdDgycTRlWUd4OEFoZGhhaGkyR3Q1My9NWlMvRWNXcmhUR28w?=
 =?utf-8?B?b0tQLzNpVnFpYTd4VTU2NCtGZWZhSk5VWHRaUVZhRkFteG5hQWE2aENGd0p2?=
 =?utf-8?B?cU42ZjJaY0VzZUpkTVI0NlhVSWloMU1nR0VPQmFBMTZLNTd6YmtBaGhBSG84?=
 =?utf-8?B?S1VpK200VTJ0TWRZcC94cnBVR0g3dTl6OXg5RjRoVVlNb0lFL1BZZUxNNGNO?=
 =?utf-8?B?THU0MnNodS9FQlp3RGpyYm5jWnBkVm1rS1J0cUxIQ082QlRnSUQvUnNUTGhK?=
 =?utf-8?B?WThCTmRiMHBuZ011MzNKaTB0Mko5dkcvbzZHZWpvUzdyTXF5MHZ3a0lWZFk5?=
 =?utf-8?B?Rmc3MFRkNFdLa3FRb2hueDF4UlVNY1NlRUR2cEJyYWtWMzZaakhHK2UreW9M?=
 =?utf-8?B?OU1DRVJyNTk2YlpEV0cwbHAyYUJCR3dWRkF0K3d5OHVxZUJhdVVYbUxiWTI4?=
 =?utf-8?B?YVRxcVpDYSt0dGpnbSt5d1MvdGcyUEQyNGUxUFNCd1JJYkU2Q3c3OXVCeWZZ?=
 =?utf-8?B?b29ZL0hVQ0VWVHFZa3BJSnQreUhLNjRzVEpsM095WmJ6S3MwL3hodWhXazFW?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a0d6fb-fda2-40de-5e18-08dbca27682a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 06:58:00.3130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbLKFfJqcPrJVRV/bknmbTXxIjFy5hLENZ1+TGZkw8CsQdVkYDBTyna5O7ocF64ArKXHjOmWPpbZ4HPQxqbkvZtm1U1cSFZhZZrDaB127ZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9410
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQgYW5kIFRob21hcywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBhbGFybXRp
bWVyOiBGaXggcmViaW5kIGZhaWx1cmUNCj4gDQo+IEhpIFRob21hcywNCj4gDQo+IE9uIFR1ZSwg
T2N0IDEwLCAyMDIzIGF0IDU6MTbigK9QTSBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4gd3JvdGU6DQo+ID4gT24gVHVlLCBPY3QgMTAgMjAyMyBhdCAwNjoxOCwgQmlqdSBEYXMg
d3JvdGU6DQo+ID4gPiBSVEMgZHJpdmVyIGlzIGRlZmluZWQgYXMgYSBtb2R1bGUsIHNvIEkgd2Fz
IHRlc3RpbmcgcmVtb3ZlL3VuYmluZA0KPiA+ID4gZm9sbG93ZWQgYnkgaW5zdGFsbC9iaW5kIG9u
IFJUQyBkcml2ZXIgdG8gY2hlY2sgYW55IHJlc291cmNlIGxlYWthZ2UNCj4gPiA+IGFuZCBmb3Vu
ZCB0aGF0IGRldmljZSBpcyBub3Qgd29ya2luZyBwcm9wZXJseS4NCj4gPiA+DQo+ID4gPiBBcyB5
b3UgbWVudGlvbmVkIGFib3ZlLCB3ZSBzaG91bGQgbm90IHJlbW92ZSBSVEMgZHJpdmVyLiBTbyBJ
IHdvdWxkDQo+ID4gPiBsaWtlIHRvIGRyb3AgdGhpcyBwYXRjaC4NCj4gPiA+DQo+ID4gPiBJcyB0
aGVyZSBhbnkgcGxhY2Ugd2UgY2FuIGRvY3VtZW50IHRoaXMgdG8gYXZvaWQgYW5vdGhlciBwZXJz
b24NCj4gPiA+IGRvaW5nIHNhbWUgbWlzdGFrZT8NCj4gPg0KPiA+IFRoZSBwb2ludCBpcyB0aGF0
IHRoZSByZW1vdmFsIHNob3VsZCBub3QgaGFwcGVuIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4gPg0K
PiA+IFRob3VnaCBpdCBzZWVtcyB0aGF0IGV2ZW4gYSBoZWxkIHJlZmNvdW50IG9uIHRoZSBtb2R1
bGUgaXMgbm90DQo+ID4gcHJldmVudGluZyB0aGF0LCB3aGljaCBpcyBiYWQgdG8gYmVnaW4gd2l0
aC4NCj4gDQo+IEluZGVlZC4gIEkgaGFkIGV4cGVjdGVkIHRvIGZpbmQgYXQgbGVhc3Qgb25lIFJU
QyBkcml2ZXIgZm9yIGEgZGV2aWNlIG9uIGENCj4gaG90LXBsdWdnYWJsZSBidXMgbGlrZSBVU0Is
IGJ1dCBhcHBhcmVudGx5IHdlIGhhdmUgbm9uZSBvZiB0aGVzZSAoeWV0KS4gIFNvDQo+IGN1cnJl
bnRseSBSVEMgZGV2aWNlIHJlbW92YWwgY2FuIG9ubHkgYmUgdHJpZ2dlcmVkIGJ5IGEgbWFudWFs
IHN5c2ZzIHVuYmluZA0KPiBvciBkZWxldGVfZGV2aWNlLg0KPiANCj4gPiBUaGF0IGFzaWRlIEkn
bSBub3Qgc2F5aW5nIHRoYXQgc3VwcG9ydGluZyByZW1vdmFsIGlzIGNvbXBsZXRlbHkNCj4gPiBp
bXBvc3NpYmxlLiBUaGUgY2hhcmdlciBkcml2ZXIgY2FuIHByb2JhYmx5IGJlIGZpeGVkLCBidXQg
YXMgdGhpcyBpcyBhDQo+ID4gdXNlciBzcGFjZSB2aXNpYmxlIGNoYW5nZSB0aGlzIG5lZWRzIGEg
bG90IG9mIHRob3VnaHRzIGFuZCBwcm9wZXINCj4gPiBhbmFseXNpcyB3aHkgc3VjaCBhIGNoYW5n
ZSB3b3VsZCBiZSBjb3JyZWN0IHVuZGVyIGFsbCBjaXJjdW1zdGFuY2VzLg0KPiANCj4gVGhlIGNo
YXJnZXIgbWFuYWdlciBzZWVtcyB0byBiZSBjb25zaWRlcmVkIGEgbGVnYWN5IGRyaXZlci4NCj4g
RGV2aWNlcyBhcmUgb25seSBpbnN0YW50aWF0ZWQgZnJvbSB0aGUgZHJpdmVycy9tZmQvODhwbTg2
MHguYyAoYXMgdXNlZCBvbg0KPiBNYXJ2ZWxsIFBYQTkxMCBES0IgYm9hcmRzKSwgb3IgZGlyZWN0
bHkgZnJvbSBEVCAobm8gdXBzdHJlYW0gdXNlcnMpLiBUaGUgRFQNCj4gYmluZGluZ3Mgc2F5Og0K
PiANCj4gICAgIEJpbmRpbmcgZm9yIHRoZSBsZWdhY3kgY2hhcmdlciBtYW5hZ2VyIGRyaXZlci4N
Cj4gICAgIFBsZWFzZSBkbyBub3QgdXNlIGZvciBuZXcgcHJvZHVjdHMuDQo+IA0KPiBUaGUgImlm
IChhbGFybXRpbWVyX2dldF9ydGNkZXYoKSkgeyAuLi4gfSIgeW91IHBvaW50ZWQgb3V0IGluIHRo
ZSBwcm9iZQ0KPiBmdW5jdGlvbiAgc2VlbXMgdG8gYmUgcmF0aGVyIGZyYWdpbGUsIGFzIGl0IGRl
cGVuZHMgb24gcHJvYmUgb3JkZXIuIEFuZA0KPiBib3RoIENIQVJHRVJfTUFOQUdFUiBhbmQgUlRD
X0RSVl84OFBNODYwWCBjYW4gYmUgbW9kdWxhci4NCg0KRG9lcyBpdCBtZWFuIHRoYXQgY3VycmVu
dCBwYXRjaCBpcyBmaW5lPyAgT24gbm9ybWFsIHNjZW5hcmlvLA0Kbm8gb25lIHdpbGwgcmVtb3Zl
IFJUQyBkZXZpY2UsIHNvIG5vdGhpbmcgdG8gd29ycnkgYWJvdXQgYmF0dGVyeSBjaGFyZ2VyLiBP
biBleGNlcHRpb25hbCBjYXNlcyBpZiBhbnlvbmUgd2FudHMgdG8gcmVtb3ZlIFJUQyBkcml2ZXIs
IHRoaXMgcGF0Y2ggd2lsbCBoZWxwKGZvciBlZzogY2hlY2tpbmcgcmVzb3VyY2UgbGVhayByZW1v
dmUvdW5iaW5kIGZvbGxvd2VkIGJ5IG1vZHByb2JlL2JpbmQpLg0KDQpDaGVlcnMsDQpCaWp1IA0K
