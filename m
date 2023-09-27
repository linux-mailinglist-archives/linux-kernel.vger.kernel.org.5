Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194147B01A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjI0KTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0KTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:19:05 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2135.outbound.protection.outlook.com [40.107.113.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318C64218;
        Wed, 27 Sep 2023 03:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHmCVc4p1hTdCAAmu59xjUznCsBPQ6KY3uE1k76Az3QUJHaplkLA4xRktJDc+ImAvbGK5Im05fD/yNcZWqpc8fcTn3OkhG91vJyBad1ZBK/ig8sbUgWIVtVMMn+faxu9Ki44ajQdzldmSt6x0rfXuuOBFDn5JqE+RkqjH1CQHUBy3oT2BN5D3v8jLF9Ne9OriBFuYWAe1sTBfgMpN37950cmrMW03UkLuVsxnYB+IUlI5l3MZbEPhyinV6xRzl8V6UaJ7pH63jVJRUd7vsqYHgbdWuFnX4qKR5gs6u5CoKfRpUgXVC2piV4O/9PG7Ktg/u9iU2c1eF/1FrtQC8ZxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06c27kec8Kz3dXyX2OKNZ+mujdjvb/lhLDR2W85lv8s=;
 b=ZQeUsHlLHPNQqtGcKg5lnGM0Auht8vqFiYpixC84S2o/iZcZDTXXdOP6afuxA829yBrSn9XbslkipsDZsRNWb1CxbKitZzefxxNTV6l3KX34a651uAkqs9fn1gfhLNPd+0tCIsigqU606qjE5Ydn8horoTVsMafHDWCTB3ArMhtj/L7wgaVv/UDYMvjoxzJH/0WyMU4dmvPeFz2fjU7dsxAQMwl7rrsTgqm8T1ijddlkRW+vZIhzs8LmFMz0cHxSmAIiDe3GpVJtGrHpsIa/tdg8XNUjFBglGZglHVyC/IR+J8yUtjObBw6tj3A3gVQ2w6lja84ial0jO86jafFcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06c27kec8Kz3dXyX2OKNZ+mujdjvb/lhLDR2W85lv8s=;
 b=h/jSZiR3QcXbYlVdQHR1TW0RDN0FBGA3zQ1d/rR+XMMGnfz9ocfS+C8Io/CXCFp246QZKRPua8OrCgPFSSQfnJX+6VmrNJbI1O0nabunKk4apDK5MWpatHqOTAs67qZ/N2JMZIEbe1l/BIIPRN7MAM7dIqHCxAt8WjeOtYCSltc=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB11071.jpnprd01.prod.outlook.com (2603:1096:400:3a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 27 Sep
 2023 10:18:59 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::600a:9708:18f:2528]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::600a:9708:18f:2528%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 10:18:57 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>,
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
Thread-Index: AQHZ8L2blakiXIKx8k6DD60xX0IJ3LAuT32AgAAREwCAAAMCAIAAAw4AgAAGQYCAAAXnAIAAAe0A
Date:   Wed, 27 Sep 2023 10:18:57 +0000
Message-ID: <TYWPR01MB8775B9F9F70CA75410788F83C2C2A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUibHxPBCLbeWdNrEk_szm+o4cOcskEMZAqUufNTzQKMQ@mail.gmail.com>
 <ZRPvHJXbuZ9Db2Go@finisterre.sirena.org.uk>
 <CAMuHMdUv8FFwkde8K3Ta8FEWrkkJ=9ZqbTi1EO8sRxVOhGtvzQ@mail.gmail.com>
 <ZRP0MpIHf67tfQJY@finisterre.sirena.org.uk>
 <CAMuHMdWPxn=RTU6uytOp31BoXbW0m8Oxk_LM2Rp4Dtop7okWgQ@mail.gmail.com>
 <ZRP+ZNXe975hcEJJ@finisterre.sirena.org.uk>
In-Reply-To: <ZRP+ZNXe975hcEJJ@finisterre.sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB11071:EE_
x-ms-office365-filtering-correlation-id: 3f9604fd-20ca-4334-f2c5-08dbbf4328be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TEdsqewl2vGYXW+Cpvk3hL8VrAE2Fqj8NEftGmx/gUwNyJSakSNaDDKXyD5Lo4RWUgMo+aZWLZTPMjnFHRToYpekMn4AP87Nx2+ajKqu++PVSfcbplajI4MA372R2VZ735wWb671vyyisux8bq2lDU4v1aUFQ5AdXMbtj2Zo8cd7hSpj325eSr47k9G72mLxhIQ7UyPM+9fmLHLpLy1kqX287EyVli0FmPXvU76/TRmf3H3lDOGdrTVXVUTZJdv5OxWIM6V4r66bccF1dlRAyrNW1FtPZD8/Mz2hzHUtL/ffITVO7su7m39uNrOWzY0DWB8NvEz/8Hg6SaHw98/PR+KafPvAarlvV2RP7dJxDuvUp9jv8rJ+7ftb0s2Q3TMNeukUpQMo2vipJazL0ypQ32K44eXiCVo9+P9dGjgC8wk5b22OyLXZENdCsIXV6Yiem7iBsxaxJsGQi2yBoCnSO9ihlfrmZsvTSbSD+nuIb9Nrkx6Si+gJ+70LLNnJXAdlNzLFE9jUB/tqM9KAtJGbSTFRFWb9sp25aOrcnZjozN9Bzjfnp1n6dQjJQfRpOSe62nQ2q5nVGblgCZAH90PrJez/UZWwO1gPiRyaJvf5QpfZADWO5jW5F9TDak3LgEIB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(5660300002)(107886003)(83380400001)(76116006)(26005)(54906003)(66446008)(9686003)(316002)(66476007)(7416002)(64756008)(41300700001)(8676002)(478600001)(52536014)(7696005)(55016003)(110136005)(71200400001)(66946007)(66556008)(2906002)(8936002)(6506007)(53546011)(4326008)(38070700005)(33656002)(122000001)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUtqbHV4d1U5MXZqTlRhYTU0WGloallqbU5LMTRUemx2VlUwR1I2Nllodndu?=
 =?utf-8?B?ZERYaFlCeWhvbHE2SkRuN0ptRncvMjNWRCtHbDJkYXBPNkZYdXlQZTcwVWk5?=
 =?utf-8?B?aUozUmxkYmlyNE5MWG9DZ0NEOFdnNEdVb3pPa3JRNDl3d0lpT21xa0VqTDlO?=
 =?utf-8?B?ZXY2WXExVnc1ZDBaY1ZzcGVmVVRYRGZHZk02QVRwVkpmcmsyeTFIRXJJUnlo?=
 =?utf-8?B?N3FvSHFGMXpxQmtQTmZab0hxYlduSG94VjZxU1Jxd3dxOXNPa1NxalRuOEVn?=
 =?utf-8?B?Tk1paG92WFkxQ2MzTllIcmUxaVdwNzlMUE84czQyTWdDYXZNRGZGR1lnRUtO?=
 =?utf-8?B?OEtMbHBzZVVabFpDNzYxRVNwQ2IwMWg0SHFYZzdNYkI0UG9BdHF4OHM5NG0v?=
 =?utf-8?B?UXR3NG5hVnhoSVBkMU9PTFlGMTAzT0dKWTJjVkR2MHdwVHo1ckdNR0RQVVo3?=
 =?utf-8?B?T3BZRm5xM3pNcXl2YnpuaE1SSlpncDV4NTQ4aHhObVROQTE1bzZ6elB1WXBV?=
 =?utf-8?B?aGRuK0diT1pIT01VcGREM0JtVU4xNitUYS8xNHJmZndIaEVYVHpPMmlIYTJ0?=
 =?utf-8?B?VEhPQ2t3N1JHcjYxeGN3VDFiTWtNdTdCODZNOW41aHRzcmkyc0o2WWYxNWly?=
 =?utf-8?B?djUzcDBidnFoNXdEbmNDMkY3Z0gvSnk0U3ZveEN1SFBpWnljb0F5bFNXZVBC?=
 =?utf-8?B?Tld5aTkzSXBZNi9XMHM0UDBHVzdkWVJLdGJ6MkdmejkvRUxTWUZkQ2JNdmdz?=
 =?utf-8?B?SXN6ZTVoMUtTREFDUmRqYTVhN1YwcmdPSnowYUQvcUFXT1VOeitEL2RGalNZ?=
 =?utf-8?B?d1JmUDJId2thK2k3aHFFeEp0T1ViNTh2VmtMSGUrUDdkRHJjV0lUWHU1VG5n?=
 =?utf-8?B?eTY0V2NOUTFiZk8xajJudHM5SUw1aFZkUFJsbU5MaTZ5OGVHVDFOVm5ZalU0?=
 =?utf-8?B?SVozTWhhM3FWeUdKbncvVmxZTmdZdTYwWkhyeGF5OVJMc2pvcmd3dVZPZStJ?=
 =?utf-8?B?b2dZczR6YTByYU8rQXN2KzRsdzFvem1XTlJleGlLMk1DRTFQY0t2eXZqRUVH?=
 =?utf-8?B?aW1VR3MveVNSMEo0MzltRDAvWVlGL0kxbXZWbHhTK01zZkdldHZDQzZtSHFG?=
 =?utf-8?B?bTExbm95RUxEdEJHbG42TUdUWkUvSHlwcGtDUW1xNXZEY0F5YlBlbDQ5ckJY?=
 =?utf-8?B?T1NVT1YrUlhZMGMrL0J6aUlBaUxiUW8xcmt6M3pxMk1QRnJld3FSQ2JrRmM0?=
 =?utf-8?B?SVd6WUtOSURlWi8rMjFuUkxnYTU1QkM5ZGYrb3ZpR21Oell2UHczczZEQ2F2?=
 =?utf-8?B?c0NUcmp6R1RWbWJZSGVwcFlTcFA2T1pDQnJvbGhhT3d5Vjd4TmNUU1ZQVWs3?=
 =?utf-8?B?NGtRMTZDUCtIVG82eHJheWdEU0UzdzdDbSt3Q0Rzem82QithZy9Ha2NpQUt6?=
 =?utf-8?B?UDV2aHlLRXd4SHJQU1FYbmhvZVRGZWdTRXJBTXV1YlFxQkxrbmpaMjd2OHZ3?=
 =?utf-8?B?M3BpNjJ0MWQ2ekptNWM0bStPWWJGN0t1MjJsc2dBTG5NTk9HWVFjb0FUMDh0?=
 =?utf-8?B?eUJyQzlQNEw3Uk9KT2tiSkE5WitPWTRYM21xVjAxdHV5SWk4SzVOL0hvRzdm?=
 =?utf-8?B?VmRhc0srUk81UGRjZGY5WGlNUVlJak5SYmQxYndSUlRnUEZEdHJrYklKOTdh?=
 =?utf-8?B?YTZtYnlPQXhkMHZRMGc1VUZxdGcvODhJZW1sUmgzbDZMNUE3MDhJY0ZiNzJJ?=
 =?utf-8?B?V1A5TEVoSWNMR0oydkh5ckZJTG1raHVXTDVaK2hTSHBNbUw5ZnA0VWRwRkh0?=
 =?utf-8?B?YmdFb3BucENRNlJha0ZOL1pOQjJGRWJvTnRTNDM1SnpOMUVOYU9aN1YzMHU3?=
 =?utf-8?B?dnI2WWdZSTA2MVJuK1FYSGpCS2w0ZnArejNXUFRwZXNxN1daYnFENzhSVGlJ?=
 =?utf-8?B?Z2UvUlh4YnF5ODBHcmdLdEw0eHROaDRTQzFyTXQxOVdQWmFUY0k4VHMxNmFr?=
 =?utf-8?B?aTZXU2tqZG4vaXl0LzBrOVJpd1pmU0FKcUdyYlVDT2prSWtaQTVYUFVOcjdQ?=
 =?utf-8?B?L1ZUSktUVnI2bzBQNUZ2WGUvWDFzVXBuTlE5UmN5YkNjVUVhK05VZC9rbEVL?=
 =?utf-8?B?RnZzN3dLL3F3amtHelhmUmhWNXV1dUlFcWhYdFJHR0VqR0dpRE9OTmxKQ2t3?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9604fd-20ca-4334-f2c5-08dbbf4328be
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 10:18:57.0301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBWBt1d3WmGdK93eCGDLJ+YFn/zNpzHLsftkfUGog7M8RcjHsTLkjFMUrVxxLictgEC/Rrnw3vnzyeBb447gnJuix/1dJ9Zjt7+xjjBjtbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5IQ0KDQo+IEZyb206IE1hcmsgQnJvd24g
PGJyb29uaWVAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHNwaTogcmVu
ZXNhcyxyenYybS1jc2k6IEFkZCBTUEkgU2xhdmUgcmVsYXRlZA0KPiBwcm9wZXJ0aWVzDQo+IA0K
PiBPbiBXZWQsIFNlcCAyNywgMjAyMyBhdCAxMTo0NDoxN0FNICswMjAwLCBHZWVydCBVeXR0ZXJo
b2V2ZW4gd3JvdGU6DQo+ID4gT24gV2VkLCBTZXAgMjcsIDIwMjMgYXQgMTE6MjHigK9BTSBNYXJr
IEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IHdyb3RlOg0KPiANCj4gPiA+IEkgc2VlLiAg
SXMgdGhlcmUgYW55IGNvbnRyb2wgb3ZlciB3aGF0IHRoZSBjaGlwIHNlbGVjdCBpcyB3aGVuDQo+
IHRoZXJlIGlzDQo+ID4gPiBvbmUsIGluIHdoaWNoIGNhc2Ugd2UgY291bGQganVzdCBsb29rIHRv
IHNlZSBpZiB0aGVyZSdzIG9uZQ0KPiBzcGVjaWZpZWQ/DQo+IA0KPiA+IE9uIFJaL1YyTSB0aGVy
ZSBpc24ndCwgYXMgdGhlcmUgaXMgb25seSBhIHNpbmdsZSBoYXJkd2FyZSBjaGlwDQo+IHNlbGVj
dC4NCj4gDQo+ID4gT24gTVNJT0YsIHRoZXJlIGFyZSAzIGhhcmR3YXJlIGNoaXAgc2VsZWN0cywg
YnV0IGFwcGFyZW50bHkgb25seSB0aGUNCj4gPiBwcmltYXJ5IG9uZSBjYW4gYmUgdXNlZCBpbiB0
YXJnZXQgbW9kZS4NCj4gDQo+IE9LLCBpdCBzb3VuZHMgbGlrZSB3ZSBkbyBuZWVkIGEgcHJvcGVy
dHkgdGhlbi4gIExpa2UgSSBzYXkgSSdkIHJhdGhlcg0KPiBub3QgaGF2ZSBvbmUgdGhhdCBqdXN0
IHdvcmtzIGZvciBfTk9fQ1MgaW4gb3JkZXIgdG8gYXZvaWQgY29uZnVzaW9uDQo+IGZvcg0KPiBw
ZW9wbGUgd3JpdGluZyBTUEkgZGV2aWNlIGRyaXZlcnMsIGVpdGhlciBzb21ldGhpbmcgaW4gdGhl
IGdlbmVyaWMNCj4gdGFyZ2V0IGJpbmRpbmcgb3IgYSBkZXZpY2Ugc3BlY2lmaWMgb25lLg0KDQpT
aGFsbCBJIGludmVydCB0aGUgbG9naWMgdGhlbj8gV2hhdCBJIG1lYW4gaXMgSSBjb3VsZCBkcm9w
IHByb3BlcnR5DQoicmVuZXNhcyxjc2ktc3MiIGFuZCBhZGQgcHJvcGVydHkgInJlbmVzYXMsY3Np
LW5vLXNzIiBpbnN0ZWFkLCB0aGVyZWZvcmUNCndpdGhvdXQgInJlbmVzYXMsY3NpLW5vLXNzIiBw
aW4gU1Mgd2lsbCBiZSB1c2VkLCB3aXRoICJyZW5lc2FzLGNzaS1uby1zcyINCnBpbiBTUyB3b24n
dCBiZSB1c2VkLg0KV2hhdCBkbyB5b3UgdGhpbms/DQoNCkFsc28sIEkgY291bGQgZHJvcCAicmVu
ZXNhcyxjc2ktc3MtaGlnaCIgYW5kIHVzZSAic3BpLWNzLWhpZ2giIGluc3RlYWQ/DQoNCkdlZXJ0
LCBhbnkgdGhvdWdodHMgb24gdGhlIGFib3ZlPw0KDQpUaGFua3MsDQpGYWINCg==
