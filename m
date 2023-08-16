Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB60277E6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbjHPQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344994AbjHPQuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:50:05 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D508C199B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbMEueIEsJiPLvvjCY5LyLtBcQ4EUrgAiMzfL4SP/mKej8gnPtLXb2kWbqUonsOptE6aMIsOzl5C1eVu7J26P2Xo/xHG6xIKKr8NvqSekwYLHgQpOxXglt5ZpslBd3Awaxx71NEef9N2xHKmGsuHGqPTLqQEjCIOrzchWtBh2iZSNkY0+3nA2+YHBQUG1vTBO6UJu0IleFwRgXVU1ZNR94eLpW+ZH9dAoEpyk1FAN247jPGwKhSVqphApvKtBLV4wOn/5x0YtmO3tJ8BgcUspDx20VeuIRCfm5gfjacaiIFsb+eRUuAck9K4QpuGAeJQs/1LkXui7g7U7cG2Km+BDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBWyg7BLvoQ3It+zIUqTcdEc3NMvS5yITJmzsJTO1s0=;
 b=AxsEj3XSfuprZ1LmSTo68mPixIxvHtOI4UEiuzi4xQ33y453ME7mKMIoYGFwhP7MWP2ws5xfGjKBoEcaSb3J2zeIw1+PJqPM780v6RxN7IMGEXCjWE5wRLuWB7gqwwXdgkuenVTrfPpTHNST3xc0Gm7+ebpMaAKaRDxkbPdERcQEqhN1p1zxzCpqhg2eSp9+w4zaEbkRQRzkuFeuXLl2/+qg9el5QLFOIAB8YI0ML0nMUntWFSvYxGRgJm0Gm3sgxhneSOaj2RS1P7K4ijEnR6wCyVapTo2KthVF/yz6J9Rt6UF0zphHTBDYYvwBcMRLbRNFQ3yF0rv2OmZHUrdEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBWyg7BLvoQ3It+zIUqTcdEc3NMvS5yITJmzsJTO1s0=;
 b=X+KOKW7HoaBTzznOfPy/pbedGRfj8DrrVaNVrYe24t9dpoP1q0xZSj93wo7olxbOaPBSwJR9Q3IVaOmXjLERwu4AMpDnAT/fKZ1kHFFdxeW9S1jww8MOzk1rZCiNfQKFQ3gWIY36YTkbtGNIfQ6idza/z5cqnAEHAydRQWp9JaY=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 SI2P153MB0704.APCP153.PROD.OUTLOOK.COM (2603:1096:4:19f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.4; Wed, 16 Aug 2023 16:49:58 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188%6]) with mapi id 15.20.6723.005; Wed, 16 Aug 2023
 16:49:57 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Zach O'Keefe <zokeefe@google.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Thread-Topic: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Thread-Index: AQHZzWA78fOP2PgBLkyBLwXjPivf+6/nv4MggAJlYgCAAAUiAIAAU2yAgAKpOqA=
Date:   Wed, 16 Aug 2023 16:49:57 +0000
Message-ID: <PUZP153MB0635DBD4E63A1A90C25F67ADBE15A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <20230812210053.2325091-1-zokeefe@google.com>
 <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org>
 <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
In-Reply-To: <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bf6ea88f-d745-4549-9b67-ace24a029c9f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T16:42:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|SI2P153MB0704:EE_
x-ms-office365-filtering-correlation-id: 9be1f997-4d30-4d16-87c3-08db9e78d30e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/fXze4xbJbyqkS5Keeg3V473HA4LRlsVhS2ERIp1ajcIMt9TYKTkkeLk5rvkZXGxw6Ywf/uloXyN/eX1FPohx48AdcyJdaryl+mmJngAMlPcDVszqdetqrdASejxQoqtiSovuC0mmV44RnbvlosD2Zly1mk9IRTdsKagpeTVk0yX1qBVPHtlel2UZc64eHnjkIU/2+marsXCgjkL6CBHIOCYS2OBgu7phR5WP+b+tz2br8k78mdCMZZ2vJjgalDr4sFUWNj5X7e3AOVM/9yXXvf6AFyiDin+o7Djf8brUR3yuxk0pEa9+1nqiNwr6ZI8Y5TnL7OkRwQ8GYZQ5FFP+JvawdcPhwi4EO53G0BjSKsYWs3wfYuYQ+adCekp15XuUBbImrz1HkRcdHf30PJ7pYono9x1KpLKBCKXRxTyvLdrDoEO+JwoYWwypkA6ZMQjAIIuu/8oebeG7+ezil76n2/8t1znU3N1RLGEiWxYcmTh/ME03KjNMI/FuFgJK5CXsoAarX5x6DJlCOi9q0jKQ1YaN5G0ap1bi1AMLG9xJPei4AHdxlYuII/n48oa+sdRM8qL7XRpe+DrYVP9jHgTH6n5kJbdGn/jzMoVPTKkUDt0RWN5v6dQagSkkGUgaDt8rEppJk51buIj9Gq2ltdhkUomwpcMwOjZO8p12qS686nkhDNesm6Zadp5bnOyJqR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(1800799009)(186009)(451199024)(12101799020)(10290500003)(478600001)(7696005)(966005)(55016003)(110136005)(9686003)(33656002)(83380400001)(86362001)(38070700005)(8990500004)(2906002)(6506007)(71200400001)(52536014)(66476007)(5660300002)(4326008)(122000001)(38100700002)(64756008)(66446008)(76116006)(316002)(41300700001)(54906003)(66946007)(82960400001)(66556008)(82950400001)(53546011)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmNUdkk4Qjh3NHpHV1ZtaVBLbDZjcm12TVErWGR1NmF1R2VLU1g2Mno2OXRC?=
 =?utf-8?B?SUZWWllFcDhZQ0J3RlVSMmlzVmliK1MrL0pMaVFCNHQ5MHJiNFZ3OUFjRGZy?=
 =?utf-8?B?NkpGQWdzQmVsSUZ1UzdBb2FSZW9LUlFwQmE4MFhUUW9aazlhWHZ2cDEwRFFz?=
 =?utf-8?B?R1I1YkF3S0FNaTRDY0ZIckpHNGwxZVQxVUo2bHFybFFab3hpUXlVanRYc2JJ?=
 =?utf-8?B?YUhxWVJaanhqZHdoOGZ1TDlPYThScGVUK1gwMXdmckFETjRDREV2blZqb3pS?=
 =?utf-8?B?aVhCMEt3ZFFsVVJRZW9Ha252N0lrY3VOUGRHWUJNem1kN2pFbyt0bjhVK0Ft?=
 =?utf-8?B?NTlWc0lFMWpCTUVOcnBvWXU1V216K0hyZ1FxUzhrTGlwU2QvbEtHaW5HdmF0?=
 =?utf-8?B?ZlNyS0phQVA1QWVkbVg1SDV2bzZMa0xrU240YlA4dXVsdFZXSzVNMjQyc0ph?=
 =?utf-8?B?clhQN2xqbEQrZEdpNG43TnVTNldhc2djSVdJVWVZQXZrTWJrWlVLb2dFWjFR?=
 =?utf-8?B?c2s5Y1ZmcEN1UVlaaDFXb29neGp0cEhPZHZxZ3FCYkhLcktyMzJ1ZEJDZmE1?=
 =?utf-8?B?cXZ1azFRQkNodmRGaUE3RXdqUldFRlo3RzIvN3IzS2tJczBiZG9ZZTQ1a1Yw?=
 =?utf-8?B?M1NtbTF3T0ZBSFVNb2tIYnhMMEo2WDZFNVZ4b20vMXNWYTcrcXhpVzdrN25q?=
 =?utf-8?B?T0xwYTFvOEx0U3dNV0xpaklkTysvUUxsSm13WFllbGVPZ3h2eUNFdzY0YnQ2?=
 =?utf-8?B?a3lMTXpUYUgxV2VFSWdpeVZ6U3pkV21LL0EyRTFsTTdiOXNGeHp0MW5sa1V3?=
 =?utf-8?B?Z0djd1RkeVU0elgweDV4T3E2Nmo5SjRNbW4vVVJDVFY5NHRmNFhEd1FrTE5w?=
 =?utf-8?B?cVlWMVJzOTZJSHNqTEQrL2hKTytkOXZlOVloejV1cncwY2loWTl3eFBRQmhF?=
 =?utf-8?B?akRVYzVRNHc2T1Y0SnFGdzd5d1M3K1hUS2JsdXhmYlRJaGlkODRsUkxRblBm?=
 =?utf-8?B?VXVhZlkvU0QxdnB0WFpqMFMyZ0k0THU3bFg5VEdMZkFpMGVNMVlML25RWEZY?=
 =?utf-8?B?NTFFN0FESEVVUGNYNGFjSnRPeW1ZUVIrWStVTE96UVJjdENSUThlS3pYeTVv?=
 =?utf-8?B?RnBHLy9jMHJxdW9vYk02d0FENFRWQXowVUE0T2hKSlF4YVVEOHBYeCtLUDFu?=
 =?utf-8?B?UitYREQ0c0hmZzdtU0NhdnhkNjdka1l4VkUwalZYYXcvVzZrNFJ6bis3WXFN?=
 =?utf-8?B?Y1ZTQVFjcThNRmlNWEZqMEhZeTZtUDlOZURrbEo1UThiV0F4VThOVGtubHAy?=
 =?utf-8?B?UlRHMzVEbFl1eTM4SFBkSUk5K1IvdkxHT1E5S0RvdVhnM210RFhZWmFZQ093?=
 =?utf-8?B?T0NNU2ZvbkNwMzdCaWV3UkEyd0JXQmdXSTRtQ3k4eDZOOXVBUDJjbnBXZDQ3?=
 =?utf-8?B?MXZ2MUxlRTdEc3VHU3NCL0hZd0plaTUwOGxSRHR6b29VOFc0cVM1ZnNRSmNO?=
 =?utf-8?B?a0U5c0hvcTlJWCtGV2FXeUJtcy9weWpmellqSzNUSWhOSHB2cVRIMWNiTTN0?=
 =?utf-8?B?NlBoT1BPMmtabWNsc1M2MmJxeUlzV1MwWDBpV2R2RkliRFoyOWtaNmJuaW5X?=
 =?utf-8?B?cWZ5bGxSSjJmQmRNYjgybkJBcFdENElPaUZZV0F5N1lYWFM2YWNXZDdTRnpI?=
 =?utf-8?B?a2pXTVBQdmZlMkp6ckw5YWNOSGs0a09qQ05DdkQwalhya1EzVFg4U1h2MHhN?=
 =?utf-8?B?WmkraUxaekZCVDZpbzdoU1ZKNGdNT2VmVDhBTVRoSjJaTnhrMEhRRlJLQU4y?=
 =?utf-8?B?SkI3cE95Tkk1b0JlQTRBV044T0ZtTjhNMWJycDNGcjl1TFBYYmdiSTBiMERR?=
 =?utf-8?B?WmtYdmpKSFVvYzVuS2dRVVpnekdmUXk2SDJvNWh4RU9qcjQ3bU9JVHlxYmtF?=
 =?utf-8?B?OHZmNi95Tzd5d0NURFAvaUJRNEtlRUJvZmt5ekJuNm04YkNiK2pyM3RyYlpR?=
 =?utf-8?B?Z29lUjNFdWw1c0ZoSDNVRkxna0tCdDdrOVhhT3VDd1lHSENVTVJrUURrWFFX?=
 =?utf-8?B?OXdGQU5qbFdrcFkydmFrRHBvcDB4QnBlbC9KVldIR3Z6MW1heS9UMURWYnhu?=
 =?utf-8?Q?aT/FNVddcMraYsuBOM2Qm/9sG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be1f997-4d30-4d16-87c3-08db9e78d30e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 16:49:57.7178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5/9f+bxrDXS29+6mST6nBeoOzdhm66j7CFlDHNY+ZG4hEd8hHeVbYWvQmu6mdGhe5bUZ6Xlrr3DK2HGfCTeGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0704
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmFjaCBPJ0tlZWZlIDx6
b2tlZWZlQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAxNSwgMjAyMyA1OjM1
IEFNDQo+IFRvOiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IFNh
dXJhYmggU2luZ2ggU2VuZ2FyIDxzc2VuZ2FyQG1pY3Jvc29mdC5jb20+OyBEYW4gV2lsbGlhbXMN
Cj4gPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT47IGxpbnV4LW1tQGt2YWNrLm9yZzsgWWFuZyBT
aGkNCj4gPHNoeTgyODMwMUBnbWFpbC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFtQQVRDSF0gbW0vdGhwOiBmaXggIm1tOiB0aHA6
IGtpbGwNCj4gX190cmFuc2h1Z2VfcGFnZV9lbmFibGVkKCkiDQo+IA0KPiBbWW91IGRvbid0IG9m
dGVuIGdldCBlbWFpbCBmcm9tIHpva2VlZmVAZ29vZ2xlLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMN
Cj4gaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNh
dGlvbiBdDQo+IA0KPiBPbiBNb24sIEF1ZyAxNCwgMjAyMyBhdCAxMjowNuKAr1BNIE1hdHRoZXcg
V2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIE1vbiwg
QXVnIDE0LCAyMDIzIGF0IDExOjQ3OjUwQU0gLTA3MDAsIFphY2ggTydLZWVmZSB3cm90ZToNCj4g
PiA+IFdpbGx5IC0tIEknbSBub3QgdXAtdG8tZGF0ZSBvbiB3aGF0IGlzIGhhcHBlbmluZyBvbiB0
aGUgVEhQLWZzIGZyb250Lg0KPiA+ID4gU2hvdWxkIHdlIGJlIGNoZWNraW5nIGZvciBhIC0+aHVn
ZV9mYXVsdCBoYW5kbGVyIGhlcmU/DQo+ID4NCj4gPiBPaCwgdGhhbmsgZ29vZG5lc3MsIEkgdGhv
dWdodCB5b3Ugd2VyZSBjYydpbmcgbWUgdG8gYXNrIGEgREFYIHF1ZXN0aW9uIC4uLg0KPiANCj4g
OikNCj4gDQo+ID4gRnJvbSBhIGxhcmdlIGZvbGlvcyBwZXJzcGVjdGl2ZSwgZmlsZXN5c3RlbXMg
ZG8gbm90IGltcGxlbWVudCBhDQo+ID4gc3BlY2lhbCBoYW5kbGVyLiAgVGhleSBjYWxsIGZpbGVt
YXBfZmF1bHQoKSAoZGlyZWN0bHkgb3IgaW5kaXJlY3RseSkNCj4gPiBmcm9tIHRoZWlyDQo+ID4g
LT5mYXVsdCBoYW5kbGVyLiAgSWYgdGhlcmUgaXMgYWxyZWFkeSBhIGZvbGlvIGluIHRoZSBwYWdl
IGNhY2hlIHdoaWNoDQo+ID4gc2F0aXNmaWVzIHRoaXMgZmF1bHQsIHdlIGluc2VydCBpdCBpbnRv
IHRoZSBwYWdlIHRhYmxlcyAobm8gbWF0dGVyDQo+ID4gd2hhdCBzaXplIGl0IGlzKS4gIElmIHRo
ZXJlIGlzIG5vIGZvbGlvLCB3ZSBjYWxsIHJlYWRhaGVhZCB0byBwb3B1bGF0ZQ0KPiA+IHRoYXQg
aW5kZXggaW4gdGhlIHBhZ2UgY2FjaGUsIGFuZCBwcm9iYWJseSBzb21lIG90aGVyIGluZGljZXMg
YXJvdW5kIGl0Lg0KPiA+IFRoYXQncyBkb19zeW5jX21tYXBfcmVhZGFoZWFkKCkuDQo+ID4NCj4g
PiBJZiB5b3UgbG9vayBhdCB0aGF0LCB5b3UnbGwgc2VlIHRoYXQgd2UgY2hlY2sgdGhlIFZNX0hV
R0VQQUdFIGZsYWcsDQo+ID4gYW5kIGlmIHNldCB3ZSBhbGlnbiB0byBhIFBNRCBib3VuZGFyeSBh
bmQgcmVhZCB0d28gUE1ELXNpemUgcGFnZXMgKHNvDQo+ID4gdGhhdCB3ZSBjYW4gZG8gYXN5bmMg
cmVhZGFoZWFkIGZvciB0aGUgc2Vjb25kIHBhZ2UsIGlmIHdlJ3JlIGRvaW5nIGEgbGluZWFyDQo+
IHNjYW4pLg0KPiA+IElmIHRoZSBWTV9IVUdFUEFHRSBmbGFnIGlzbid0IHNldCwgd2UnbGwgdXNl
IHRoZSByZWFkYWhlYWQgYWxnb3JpdGhtDQo+ID4gdG8gZGVjaWRlIGhvdyBsYXJnZSB0aGUgZm9s
aW8gc2hvdWxkIGJlIHRoYXQgd2UncmUgcmVhZGluZyBpbnRvOyBpZg0KPiA+IGl0J3MgYSByYW5k
b20gcmVhZCB3b3JrbG9hZCwgd2UnbGwgc3RpY2sgdG8gb3JkZXItMCBwYWdlcywgYnV0IGlmDQo+
ID4gd2UncmUgZ2V0dGluZyBnb29kIGhpdCByYXRlIGZyb20gdGhlIGxpbmVhciBzY2FuLCB3ZSds
bCBpbmNyZWFzZSB0aGUNCj4gPiBzaXplIChhbHRob3VnaCB3ZSB3b24ndCBnbyBwYXN0IFBNRCBz
aXplKQ0KPiA+DQo+ID4gVGhlcmUncyBhbHNvIHRoZSAtPm1hcF9wYWdlcygpIG9wdGltaXNhdGlv
biB3aGljaCBoYW5kbGVzIHBhZ2UgZmF1bHRzDQo+ID4gbG9ja2xlc3NseSwgYW5kIHdpbGwgZmFp
bCBiYWNrIHRvIC0+ZmF1bHQoKSBpZiB0aGVyZSdzIGV2ZW4gYSBsaWdodA0KPiA+IGJyZWV6ZS4g
IEkgZG9uJ3QgdGhpbmsgdGhhdCdzIG9mIGFueSBwYXJ0aWN1bGFyIHVzZSBpbiBhbnN3ZXJpbmcg
eW91cg0KPiA+IHF1ZXN0aW9uLCBzbyBJJ20gbm90IGdvaW5nIGludG8gZGV0YWlscyBhYm91dCBp
dC4NCj4gPg0KPiA+IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhlIGNvZGUgdGhhdCdzIGJl
aW5nIG1vZGlmaWVkIHdlbGwgZW5vdWdoDQo+ID4gdG8gYmUgYWJsZSB0byBnaXZlIHlvdSBhIHN0
cmFpZ2h0IGFuc3dlciB0byB5b3VyIHF1ZXN0aW9uLCBidXQNCj4gPiBob3BlZnVsbHkgdGhpcyBp
cyBoZWxwZnVsIHRvIHlvdS4NCj4gDQo+IFRoYW5rIHlvdSwgdGhpcyB3YXMgZ3JlYXQgaW5mby4g
SSBoYWQgdGhvdWdodCwgaW5jb3JyZWN0bHksIHRoYXQgbGFyZ2UgZm9saW8gd29yaw0KPiB3b3Vs
ZCBldmVudHVhbGx5IHRpZSBpbnRvIHRoYXQgLT5odWdlX2ZhdWx0KCkgaGFuZGxlciAoc2hvdWxk
IGJlDQo+IGRheF9odWdlX2ZhdWx0KCkgPykNCj4gDQo+IElmIHRoYXQncyB0aGUgY2FzZSwgdGhl
biBmYXVsdGluZyBmaWxlLWJhY2tlZCwgbm9uLURBWCBtZW1vcnkgYXMgKHBtZC0NCj4gbWFwcGVk
LSlUSFBzIGlzbid0IHN1cHBvcnRlZCBhdCBhbGwsIGFuZCBubyBmYXVsdCBsaWVzIHdpdGggdGhl
DQo+IGFmb3JlbWVudGlvbmVkIHBhdGNoZXMuDQo+IA0KPiBTYXVyYWJoLCBwZXJoYXBzIHlvdSBj
YW4gZWxhYm9yYXRlIG9uIHlvdXIgdXNlIGNhc2UgYSBiaXQgbW9yZSwgYW5kIGhvdw0KPiB0aGF0
IGFub255bW91cyBjaGVjayBicm9rZSB5b3U/DQoNClphY2gsDQoNCldlIGhhdmUgYSBvdXQgb2Yg
dHJlZSBkcml2ZXIgdGhhdCBtYXBzIGh1Z2UgcGFnZXMgdGhyb3VnaCBhIGZpbGUgaGFuZGxlIGFu
ZA0KcmVsaWVzIG9uIC0+IGh1Z2VfZmF1bHQuIEl0IHVzZWQgdG8gd29yayBpbiA1LjE5IGtlcm5l
bHMgYnV0IDYuMSBjaGFuZ2VkIHRoaXMNCmJlaGF2aW91ci4NCg0KSSBkb27igJl0IHRoaW5rIHJl
dmVydGluZyB0aGUgZWFybGllciBiZWhhdmlvdXIgb2YgZmF1bHRfcGF0aCBmb3IgaHVnZSBwYWdl
cyBzaG91bGQNCmltcGFjdCBrZXJuZWwgbmVnYXRpdmVseS4NCg0KLSBTYXVyYWJoDQoNCj4gDQo+
IEJlc3QsDQo+IFphY2gNCg==
