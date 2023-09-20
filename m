Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72C07A81A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbjITMrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjITMrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:47:21 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066A783;
        Wed, 20 Sep 2023 05:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQTDBNyrhshHI54LlRW30qvaVXG5OvjR67dnQca0cjaVNdvcWaiDTKOeUusCSCk0ZwkrFW92ApqFAL4ryFXFwwHhxf+elVbqEeAlI+9DnE7yOqHTLuBeoTnnrTq7LxHtfM4znoGK6G+FjrS/xcPBqojfOWdQvsuB3+PjylMGrmEbbifFCCz3DodH3PGX5a70W6cgVUDjbYcK8QW5xYmrTWHT0Vg+RLwX5jNx1Te1XMn+7lOBShtxA5VVxJc8zC0w7oSC7/jzSfolqTSH/uXLXpJM/rfzkpB9232yG+29GjToWWBNPOra7sFGuIhGHPTOdyPs8kTum1Fn+1ODSPLo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68T7T0ZyquwgJ2XBEoJqmTJLvEdWwaEiQEVRSQvMfII=;
 b=Bqyittr2XeuoJgyW0uUIpGMKPFriyLivltkTwxxsSGDo1nRWPHv8TSQ5GbPuHVtprZFOZK9u4cTHVz5S4HBILnyvhtWAiD0WO703ehVSbAfp3UjFfIGmPgEfgaTtVgzUmislZLrBNXVtTsVE+Baiz4UwUK+y4JhRMyI8ZDDao5SnBs6hcEODFJTEvjI2m3EZ0R3uc10/Pm5GNufDXTk5D+xjFwDm1OK+h9fMNCzbnhBJVVz7HWyvB0NELwFRbO7/vym2H1eZJa3jgS67odQzVzUvDLDh5S1bMjESYbFavixpuzhp3vqEpL0cDMo8RZt8UCo6FoKOYbYALpXFUiHTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68T7T0ZyquwgJ2XBEoJqmTJLvEdWwaEiQEVRSQvMfII=;
 b=lAX/epkpi8r9fkFpepDaMe1r6FloZH5/pWpbn+zKgiNtEKvLY0kwrlxc88jVKrw+/DydAacMoFwN2IUgQ59RPhDq10LXGBtBnVIvimgYixIXLHNqrKZSnZBlJ4SOP8NFy0p7i+rdxGo7IFoh6dwhpXtIyeaPcFZ/E0NlaA3Qd78=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB11100.jpnprd01.prod.outlook.com (2603:1096:400:3d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29; Wed, 20 Sep
 2023 12:47:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 12:47:10 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] alarmtimer: Fix rebind failure
Thread-Topic: [PATCH] alarmtimer: Fix rebind failure
Thread-Index: AQHZ67nxDPIpzSJRaUGrxRMZix2AJrAjo1KAgAADuiA=
Date:   Wed, 20 Sep 2023 12:47:10 +0000
Message-ID: <OS0PR01MB59221716AD7E6A10CDB295D986F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230920115935.144391-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdWp_U_k5nSgmNV6whdK=pNr14h2dS=NetJXRgVEDSSK_g@mail.gmail.com>
In-Reply-To: <CAMuHMdWp_U_k5nSgmNV6whdK=pNr14h2dS=NetJXRgVEDSSK_g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB11100:EE_
x-ms-office365-filtering-correlation-id: 48420bff-c875-4161-96ef-08dbb9d7b4be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+YnzjLDyeL1gHFWQzQK4KSGmXyTT5KkBMrbVqt2Cz8KxzX13QXL5qcOgNmd7PzgWZ3VKzZKHwbSM1cfWHTbN4A/akrosdRAjF1ALo1DlEjbWC+4bluNjFyOJLnNmtQ+LJzPApzvdfThdc+odVDxnz77MW5BzbvSvKlvtOAeXAGKa2eIpIkDONRHKiQV2k8E6hFMzDQMaIbMXTVlLN/Dr+FDr+8/vQo7E+nf46gvcXTDRFfMeb7XLhrqw6Z+w35W9fLUJkcuHPpU3RWkKOQXPkaOnQtmy9CcqXUCCVyhxshm+q2CwNPQPjRoOxoMzjPVCUONzos0SATDcxR8kFyTK70PT9gDWtROBouDZ8PI3i8tOi9rPLqrtEeGDL7jznGKxQbha3O8YQ42CgGAub5cUgIQT9fidcLaBZyQKL/s380mOhg2U/1tvTa26GQ0gUpUZ3joLe3JgKc83i7psPWwfilTMtrkqrSM6QfBW3eHYHYLx5Bf4cTgY/6+OFg1KXtRWD2kzITdetV3PR0gOsIthzqS51+8e/PHhNjUVj+rF+ehii57mwyYJ18WHLnlVqGvI3mgtnjU9G6M+rk7h8HDR/dsg+OTu8DHa9U5zVc/dpZGIPBmrTs/kGC3cMYTnWdv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199024)(186009)(1800799009)(55016003)(38100700002)(38070700005)(6506007)(7696005)(53546011)(33656002)(122000001)(86362001)(2906002)(9686003)(83380400001)(71200400001)(478600001)(7416002)(8676002)(8936002)(5660300002)(52536014)(4326008)(66556008)(6916009)(41300700001)(66946007)(54906003)(64756008)(316002)(66476007)(76116006)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eER3SXNySHpxaGc3ZHlCb0sxRlhFRnBObE1oVzEyRCtZbHh0dTRjVHpOcUVw?=
 =?utf-8?B?N1BjRkloQ3JydEFUa3A3ekJkSnBnbVF6TFhoTHozSkZVcVppeW5sL1Y5MEVB?=
 =?utf-8?B?VEdJZ3d0b2dvY3B3ZzgzM1FTbzkxSXpGb3FTbVNPd2VOZ3pJZXg3eThwbEtY?=
 =?utf-8?B?d2hjNWM1QnZOYlN2SnBBdWZuTGsrZ3dvUDNoYzh5cEIwZXRaai9CREYwS29F?=
 =?utf-8?B?b1BaSFFMM3pFa2x4YlV2aGVGb1BjM1FSY0lZdW9JRnNwc1NRS0N2V2h5STdl?=
 =?utf-8?B?TnVVVE1nRXNDY0tUKzRGdjBMcUVudUNPNmNsTjZuSFFjOXFDUFl3Tk5FMVly?=
 =?utf-8?B?RnZDK1ZIcGJnQ0pxNG9hMU42RkIveEE4S3J5eTZGSVBOREZEaUVBYW1uOFQ5?=
 =?utf-8?B?czlpRUJoeFY3Q25QVWo5cXBzRXprWGNpSUlmbk16QkRTSEFmbDJkQlZGR0Rz?=
 =?utf-8?B?blFjbEJBTlhtTTlWUTZhY3BtTVBUOVdZSjRsZlVHaEFUdjIrYy9VU2w3cVBp?=
 =?utf-8?B?M3UzZlF5aU5RalJCN1hSdVJqaTM2eVZ4MEQzUzFLVkNOWi9lN0FVdDRpN1Jp?=
 =?utf-8?B?dnlYMzA4WENkTEdDbjc1aW1TQ09HaXNxczVqcVRGVnZxb0JxWXBYQzloeFVq?=
 =?utf-8?B?MWdzY2pLa1ZjN241RUxrcG1wc3QvTlRkYlBMTGx0LzlMNjc3UGo4U0F0MVNJ?=
 =?utf-8?B?SzQwYnBRUkdESW9jcTFGZ3RJWVNjVVVwaGpqYUxCQ0dKampSb1BmWlRpZHI5?=
 =?utf-8?B?WmhFdy9EK1BkVEwwOXZNZFV6Ky9ybjJIbVZHY3FBSkVnbjRYRSt0Tk1TaWph?=
 =?utf-8?B?T1I4VThOWUlnRnF0eldDTFRtVHNqUUtJMm90aldkMEJObXVEUU5PUXhZckRo?=
 =?utf-8?B?bGthSzBhd2dOVi9IcDZzQUU2QWFWMTcxZjRGaDFrVjB5a2JRS0NOUm1ONEFo?=
 =?utf-8?B?M21JcjdRU2RsaGswOXZVMlFKUE5ULzRHU3Q3SXVuVHBLY0o2bEw4aXFmOWk4?=
 =?utf-8?B?dVdQdVAvcFordDFkdTQwMW9TUmoyVDVQS1hHWTlmc3ZmbkZFblh0bE1YdHJN?=
 =?utf-8?B?WVprc3VESXZzMlVRbGhHZm1JMnA4Nk1nNVdwa1BZN2RiS2k5R3ZkOFNIbk5C?=
 =?utf-8?B?bE1Gb1NEVzdxTHVRMGhHOElsNjdPcmtRSk9EbW9lMFBGb2R6SnQzZHVEVG1a?=
 =?utf-8?B?L29aWjdmbzFkZ0pQU2VUOTI4VnQyRXAxVWdBM2hsVWxkZGFLc3NwekllUTNU?=
 =?utf-8?B?RlcxTFRuWjhMZ2xzNVh5b3A2eVBZREZoQVBza2FmM3A1dTVWVmxQQk9kMGZG?=
 =?utf-8?B?UXF6OU8wam5jVTZHQ3ZCY3plcHp1OFZSY28rcjE3YVljWE9BYm5mclRmOHVw?=
 =?utf-8?B?OXJxZFJCbjVCQVRYY1BVaXFBSzFWRGtrUTRSQzRhZ0tFZk4vcWdTUit6V0VB?=
 =?utf-8?B?TjRxVDl6WWdYRkRPdkg0ZE5xSmN3MXJmY29aWWtYa3VmUDM5WUcrL1RMa2FS?=
 =?utf-8?B?R2V4QllLaEhYbEh3R0dyRVdpR2NnQUszamo0ZExRSURtQW5DeFB6SFkyU05t?=
 =?utf-8?B?QnZvNEM4b0FGUGxWdFJ0MDBzbUFKVm1vSTNDUnhScUMzYUNycTZ2YnNyb0tJ?=
 =?utf-8?B?UDJTMkVIRWVJTnhYWFVIaDRhZ0FzaFdsVitJKzNxSCtNcStvVUhraWFITCs3?=
 =?utf-8?B?WGxGQlZDMzMySktGbnlaOGpWSkxkeTVUWTA4cldRWlg1WGxyRmQ3UGVCUW5k?=
 =?utf-8?B?bG1oZmF1MVc5cDBzMEQ5aG40MkxrQ3JvVC8zM05WWlFsV3FrUkNrZjU3TmIz?=
 =?utf-8?B?YytON0l4Q3doT1RyRWJrVTRYNm5xSEFyQ3pMSmlqVGVIUGtDY0krYnUwVDMw?=
 =?utf-8?B?VkliZDJRSGd4TjJXZjBSbFVpQnRNRkNsQVFCYTN5L0g1a3dRa0o2U0pscldU?=
 =?utf-8?B?OTE5MHFvSElhOWIzdVlnWndUT1FHcnNZVVBncndwYW5YVW0yRHY5WjZTRGRw?=
 =?utf-8?B?VE1JTkJ4YjJueEJoUFdVVFRQYUM3dzUzYnhPNTl6bU0vQ0s4ZzdFTHk0MDky?=
 =?utf-8?B?d1BQdjc1SHRKTXM2a3JwY0RJVko0S3AzMXh5TS9XeEhndzJUYTVhM2k4NVpj?=
 =?utf-8?Q?X1e8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48420bff-c875-4161-96ef-08dbb9d7b4be
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 12:47:10.4299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTgf3zdGQWyxZmVOmlJCrdDsDO8Nc6QMovsSvGImXryJKxvohQcKoWTjzYbjxQv2Oa5hgxQYKm1jcAH1+bX6o1L4vTz8Jo0Kzy0uPbS1O6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQgVXl0dGVyaG9ldmVuLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBhbGFybXRpbWVyOiBGaXggcmViaW5kIGZhaWx1cmUNCj4gDQo+
IEhpIEJpanUsDQo+IA0KPiBPbiBXZWQsIFNlcCAyMCwgMjAyMyBhdCAxOjU54oCvUE0gQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiBUaGUgcmVzb3Vy
Y2VzIGFsbG9jYXRlZCBpbiBhbGFybXRpbWVyX3J0Y19hZGRfZGV2aWNlKCkgYXJlIG5vdCBmcmVl
ZA0KPiA+IGxlYWRpbmcgdG8gcmUtYmluZCBmYWlsdXJlIGZvciB0aGUgZW5kcG9pbnQgZHJpdmVy
LiBGaXggdGhpcyBpc3N1ZSBieQ0KPiA+IGFkZGluZyBhbGFybXRpbWVyX3J0Y19yZW1vdmVfZGV2
aWNlKCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAu
cmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiBEb2VzIHRo
aXMgbmVlZCBhIEZpeGVzIHRhZz8NCg0KSSB0aGluayBzbywgYXMgaXQgYnJlYWtzIHVuYmluZC9i
aW5kIG9uIGxvdCBvZiBSVEMgZHJpdmVycy4NCg0KVGhlcmUgYXJlIDIgY29tbWl0cywgSSB3aWxs
IGFkZCBib3RoIGFzIGZpeGVzIHRhZy4NCg0KYzc5MTA4YmQxOWE4ICgiYWxhcm10aW1lcjogTWFr
ZSBhbGFybXRpbWVyIHBsYXRmb3JtIGRldmljZSBjaGlsZCBvZiBSVEMgZGV2aWNlIikNCg0KN2M5
NGNhY2E4NzdiICgiYWxhcm10aW1lcjogVXNlIHdha2V1cCBzb3VyY2UgZnJvbSBhbGFybXRpbWVy
IHBsYXRmb3JtIGRldmljZSINCg0KPiANCj4gPiAtLS0gYS9rZXJuZWwvdGltZS9hbGFybXRpbWVy
LmMNCj4gPiArKysgYi9rZXJuZWwvdGltZS9hbGFybXRpbWVyLmMNCj4gPiBAQCAtNjEsNiArNjEs
NyBAQCBzdGF0aWMgREVGSU5FX1NQSU5MT0NLKGZyZWV6ZXJfZGVsdGFfbG9jayk7DQo+ID4gIC8q
IHJ0YyB0aW1lciBhbmQgZGV2aWNlIGZvciBzZXR0aW5nIGFsYXJtIHdha2V1cHMgYXQgc3VzcGVu
ZCAqLw0KPiA+ICBzdGF0aWMgc3RydWN0IHJ0Y190aW1lciAgICAgICAgICAgICAgICBydGN0aW1l
cjsNCj4gPiAgc3RhdGljIHN0cnVjdCBydGNfZGV2aWNlICAgICAgICpydGNkZXY7DQo+ID4gK3N0
YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICAqcnRjX3BkZXY7DQo+ID4gIHN0YXRpYyBERUZJ
TkVfU1BJTkxPQ0socnRjZGV2X2xvY2spOw0KPiA+DQo+ID4gIC8qKg0KPiA+IEBAIC0xMDksNiAr
MTEwLDcgQEAgc3RhdGljIGludCBhbGFybXRpbWVyX3J0Y19hZGRfZGV2aWNlKHN0cnVjdCBkZXZp
Y2UNCj4gKmRldikNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAgICAg
ICAgIHJ0Y2RldiA9IHJ0YzsNCj4gPiArICAgICAgICAgICAgICAgcnRjX3BkZXYgPSBwZGV2Ow0K
PiA+ICAgICAgICAgICAgICAgICAvKiBob2xkIGEgcmVmZXJlbmNlIHNvIGl0IGRvZXNuJ3QgZ28g
YXdheSAqLw0KPiA+ICAgICAgICAgICAgICAgICBnZXRfZGV2aWNlKGRldik7DQo+ID4gICAgICAg
ICAgICAgICAgIHBkZXYgPSBOVUxMOw0KPiA+IEBAIC0xMjMsNiArMTI1LDIzIEBAIHN0YXRpYyBp
bnQgYWxhcm10aW1lcl9ydGNfYWRkX2RldmljZShzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpDQo+ID4g
ICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgYWxhcm10
aW1lcl9ydGNfcmVtb3ZlX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gPiArICAgICAg
IHN0cnVjdCBydGNfZGV2aWNlICpydGMgPSB0b19ydGNfZGV2aWNlKGRldik7DQo+ID4gKw0KPiA+
ICsgICAgICAgaWYgKHJ0Y19wZGV2KSB7DQo+IA0KPiBBcyB0aGUgcmV0dXJuIHZhbHVlIG9mIGNs
YXNzX2ludGVyZmFjZS5hZGRfZGV2KCkgaXMgbmV2ZXIgY2hlY2tlZA0KPiAoYWxhcm10aW1lcl9y
dGNfYWRkX2RldmljZSgpIHJldHVybnMgLUVCVVNZIG9uIGFkZGluZyBhIHNlY29uZCBhbGFybXRp
bWVyKSwNCj4gbXVsdGlwbGUgdGltZXJzIG1heSBoYXZlIGJlZW4gYWRkZWQsIGJ1dCBvbmx5IG9u
ZSBvZiB0aGVtIHdpbGwgYmUgdGhlIHJlYWwNCj4gYWxhcm10aW1lci4NCj4gSGVuY2UgdGhpcyBm
dW5jdGlvbiBzaG91bGQgY2hlY2sgaWYgcnRjZGV2ID09IHJ0YyBiZWZvcmUgdW5yZWdpc3Rlcmlu
ZyB0aGUNCj4gcmVhbCBhbGFybXRpbWVyLiAgT2YgY291cnNlIGFsbCBvZiB0aGlzIHNob3VsZCBi
ZSBwcm90ZWN0ZWQgYnkgcnRjZGV2X2xvY2suDQoNCk9rIHdpbGwgYWRkIGxvY2sgaGVyZSBhbmQg
dGhlIGNoZWNrLg0KPiANCj4gPiArICAgICAgICAgICAgICAgbW9kdWxlX3B1dChydGMtPm93bmVy
KTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGRldmljZV9tYXlfd2FrZXVwKHJ0Yy0+ZGV2LnBh
cmVudCkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2aWNlX2luaXRfd2FrZXVwKCZy
dGNfcGRldi0+ZGV2LCBmYWxzZSk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBwbGF0Zm9y
bV9kZXZpY2VfdW5yZWdpc3RlcihydGNfcGRldik7DQo+ID4gKyAgICAgICAgICAgICAgIHB1dF9k
ZXZpY2UoZGV2KTsNCj4gDQo+IFBlcmhhcHMgdXNlIHRoZSByZXZlcnNlIG9yZGVyIG9mIG9wZXJh
dGlvbnMgYXMgaW4NCj4gYWxhcm10aW1lcl9ydGNfYWRkX2RldmljZSgpPw0KDQpQbGF0Zm9ybSBk
ZXZpY2UgaXMgY2hpbGQgb2YgcnRjIGRldmljZS4gU28gaXQgaGFzIHRvIGJlDQphdCB0aGUgbGFz
dCBhcyBhbHJlYWR5IHRoZXJlIGlzIHB1dF9kZXZpY2UoKSBjYWxsIGluIA0KZGV2bV9ydGNfcmVs
ZWFzZV9kZXZpY2UoKQ0KDQpDaGVlcnMsDQpCaWp1DQoNCg0KPiANCj4gPiArICAgICAgIH0NCj4g
PiArDQo+ID4gKyAgICAgICBydGNkZXYgPSBOVUxMOw0KPiA+ICsgICAgICAgcnRjX3BkZXYgPSBO
VUxMOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW5saW5lIHZvaWQgYWxhcm10aW1lcl9y
dGNfdGltZXJfaW5pdCh2b2lkKSAgew0KPiA+ICAgICAgICAgcnRjX3RpbWVyX2luaXQoJnJ0Y3Rp
bWVyLCBOVUxMLCBOVUxMKTsNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAt
LSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtDQo+IG02
OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBl
b3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4NCj4gQnV0IHdoZW4gSSdtIHRhbGtpbmcgdG8g
am91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nDQo+IGxpa2Ug
dGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxk
cw0K
