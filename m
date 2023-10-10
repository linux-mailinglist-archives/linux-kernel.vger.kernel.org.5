Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729C17C002A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjJJPQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjJJPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:16:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE8D97;
        Tue, 10 Oct 2023 08:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlkdAMVAHr12NmD91Z0d0TdQRvFpeV1F+IloHCHgieooKeKBpuKuMqqUjVRCOBp4eMM72cCDfkKROoZAZwftflA0Ecy+6PLWowiAsG6d4hCjSE2fY8zgtE9nQIrvLXmPgEhXEFMb/dY/rgUPIkoxftZv05TKJanNrZiHZ1RoZj6O1hwTmy5hvtD2s3wkcDepWwHEh271SUiWmOtZ99j/0AU9w+iOLUiWXkSl1S2Tacl+KSrMA+97kL1bZQ5KweE95N3b3no9+apmUkjc2BmrHOjQ3fTZME1blS3hFiseEphcCTtVRQYae2aasezC50tUFwXf2hpNQvEaK8NRF4uCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFbX3IkojXF3hUwgHOtQjE3MYuxR6PZQrRwcejTpuWU=;
 b=gFW1Um21Ac7pHPzAvD1sqc2035Xjvzn3DMllYUbfOhRGUj6bb8Civ15MTlMkSQIdai+v/WQT0KorwoOIPVoLkFbG912BWinwmhWrtGLm+W51ESujcP2hQ8Bj8e+k7jb2YDvrO+sVBXkGPRy/eVSiW9GrAA50T/uOz0Qr3/0sLQ/aVPMz+WWm7I+bkVU2liZBiPClbX8yElK3EwtFlUk3YI/4V4O0rXPF+kWYWUOGmiKz+kya4llmZnj7mJVVi/XMWK/jfhzDfc9o6Z21N+a2SgsCjkxYCH3uC8Z8zCY5e23C7t8yFYAlE35QGMmOQ5cn4kzKCgBGGsZRSHFhV3+61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFbX3IkojXF3hUwgHOtQjE3MYuxR6PZQrRwcejTpuWU=;
 b=CEAQ826Vlw0cUKZRKJZMFDXqF5YfPxdbqb6Gv1Ga+RkD4YHeTbwFtw6ZcrMOep8HVU5H6mWerh6udLst4WKtjmvYRrQXeyDQtQrAd59VaO8+kV4fn7MSiB7OlrQ955RDJ2fQWgurkaGJADJOC6/kzhsFrjp/gYlkfR/fTbCAUJE=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 15:16:40 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:16:40 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH net-next v7 3/3] net: axienet: Introduce dmaengine support
Thread-Topic: [PATCH net-next v7 3/3] net: axienet: Introduce dmaengine
 support
Thread-Index: AQHZ8XmjDysNxqIG3UGZtitzZHc+JbBB+SwAgAE7GyA=
Date:   Tue, 10 Oct 2023 15:16:40 +0000
Message-ID: <MN0PR12MB5953084410FBD7AC6AA0594FB7CDA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1695843151-1919509-4-git-send-email-radhey.shyam.pandey@amd.com>
 <995341e0-d2d7-451e-bd8b-0741cb98bcff@gmail.com>
In-Reply-To: <995341e0-d2d7-451e-bd8b-0741cb98bcff@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM4PR12MB7600:EE_
x-ms-office365-filtering-correlation-id: 9a5b3809-311b-45d0-a2a8-08dbc9a3e789
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: srSKukV8bEppnJmqa9Sa4eOobToMlCAln0slL69HaeGrAMvvmFo3miZBdjt9AwVq9HFkm2iq9poDlxtsqLfCjV85Qe93bNUl3D80u8iBnEDktsHxnI5raN71pgENejQxIA1nN7G7n4GMqrukOulh2vzKATyXi/R4i3SoFBlWB7eCA1RKQt6WnY4xGntJFjdNt4ofcwuOT2awmw/7IN2s0nbTmxIEnbYKLxPaZrsN50vmucMTxAJVxSquioEke8WbDwFciROSga7H9oLx6cE1yn1h54oIUfveKH3x8EBwOrrCDDWH+7ltqJn2HvBBsedTqxojkHx+A87w1wXxIHlrbM3634uZdGwMV+nR6JDgzkBzQONDPQ3lEez2fDgH1EdfmuM0d6osaxCy1R67/8XV96hm/FvMTX/sGXrqerTNlRPGHMzxOC9LOxmJUx3WXFLNA/q5RwzBFv3onkpImkUpkU5Fh7++LVnsnFziWbtzlXXpu8Fw81ApgHkhg/rhw1Edp5oi8QiUVnsTez5cPI/m0j+aSFbgl6US4fo19BZAp8S0JrZfJ+lM4mVXjkjp0ln7y7pnhNlFHjr3N/ZSpXb1xzotlOdd6cgHJ6a3U33gcRXClFK4w8riHNnFjcZsH8J9j2D69sq8/tpr9bpsTPhstw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(55016003)(9686003)(83380400001)(5660300002)(26005)(76116006)(66556008)(66476007)(110136005)(66946007)(66446008)(54906003)(7416002)(64756008)(53546011)(71200400001)(7696005)(52536014)(8676002)(41300700001)(2906002)(478600001)(316002)(6506007)(8936002)(4326008)(33656002)(921005)(38100700002)(86362001)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHBCdTZaaktNcUtDRG9JZXRvYjhvL1dJSTJFRGRzckJzcDQxZlowNmZiV0d5?=
 =?utf-8?B?eFFhTXBKam5wWW80ZzJXeGE2UHNYYll5NXpaYlJQdHFhaHhDWnRqc2RRYzIz?=
 =?utf-8?B?bkR3MTlTZ1I3QVNMa0p0S1JLV0xmaVN4Um9uQ1FKNHZDRnFieWF2M1dyRnZJ?=
 =?utf-8?B?ZFRIVi9wOTBJTUY4cHZOemJHQUxuNjBmUUZyM3ZQV3R2ZTVQNGJDTW9qZXZW?=
 =?utf-8?B?cC9ySHZOakl4LzhvSnd6VVBQa3psZ09mZ2phZERRbDFIV0tRSkF2MEdtYytH?=
 =?utf-8?B?b040QzdBcEpTZEU3QXBxdDBkQlpBY2xJMEZ2cUdPMEJqQ09FYjdMVFo0UTE0?=
 =?utf-8?B?V2s2VlVkcGFZRUJrY3Q3dUVZVGVLRzNQQmRqaTdBcURlVmwraWZSNVBjVnpE?=
 =?utf-8?B?S2paYUJ0Y3RLNlg0cnliUldaOWtLT09taXpVeG82Y08vYnpETTVySEpmNDc1?=
 =?utf-8?B?TTZNcDExRkc5M0oreWo3MGdIMGlXYXR3V28vemU0Q2ZxeWp3OVhwQy8wRXBs?=
 =?utf-8?B?NG1NR016UjBjSmMzL1J5YWlwcDNQSTNxdmxyOXJhL3Y1T0RoUUZyekVTcEVP?=
 =?utf-8?B?WWNSdDd1RjRhMmk0RGtNSkdWa2dzRUlERWEyay9Pa3U1cWJiOFExeWpGbFhW?=
 =?utf-8?B?SVZreFRKTDZKaG1lZHZUWXhDKzZqMkczKytOTGdxNDI0TFZNREhjSGVFRlVt?=
 =?utf-8?B?bktQN3lHcDNIQlJpUEg5VU54NDV5eUhmTlBsb3hkamxjL2F6Vzl4N3ZoYUJj?=
 =?utf-8?B?dWVqVFVKSVlQdlhCTWRacTNuekRsbUVRQ1hMaW9NRCtqMldkb2JDUFQwWndq?=
 =?utf-8?B?b2xKdVNINGxVUmFGVWx6VlFxd2RxdkV3RDhXOUxJT3ZWK0YrMGsyai9SWHpN?=
 =?utf-8?B?dGJadmFHc2Z6TUk3Q0NNTGpuV1JLSmJLTmpWTEx1VGMzam1aRExsaXFkLzlp?=
 =?utf-8?B?SmRMTUFRK3FuQUVUR1VHcTYrSEtHNmRyTWVYTGpYUGFObURlb0ZlWTZRWTVV?=
 =?utf-8?B?Zlp3S3B1eE55V051YWNoeUFFTGF1NW1lKzZhUk9lYVdoc0pkUk9UcGlVNW5y?=
 =?utf-8?B?QTZEWEdzeThJUXRpZEkwdUNvSGdiU0J4Q0w2dXpRUDRycGp5cS9QckV5Uk5J?=
 =?utf-8?B?ZEg3SS96S0VMOFpJYU9aN08rbVBOcVliWXBldnFQMVFIa0FvczdmWDZoMDg3?=
 =?utf-8?B?Qkp6SWU3cTJoTnV0WnRFbVJZUmtxLzFtL2E3anBPRCszSjYrYjNCQzdKYStC?=
 =?utf-8?B?NGE5amZOdnVscDdxd3JxcmVvaldBT1FwZHNWMkx1dFJVb0RxbTN1MEJJK3ZP?=
 =?utf-8?B?T2dWRyt1NG9GZzRqdFJDQ1ExNXovRGVZeTBOWFJWOFFVOXBtSDlOM2ZLSVdI?=
 =?utf-8?B?SmY1bVIyNTZtZkRLQWNLdzg2VzZHM25WandQU2hOM2Y3LzE1RkMwZWtGa2hF?=
 =?utf-8?B?dUJyZEV1RVUwRjI1cGs4enY1UGF2SFRTb2FibWRieTNEdkQ3R01aNmhWNW5q?=
 =?utf-8?B?eXl0NnJSWHVON05XbHpXemttKzNUQmgxOElpOXRFUi9xVFdtMTRpSmR0c1kv?=
 =?utf-8?B?bXRJRi8yOTlJUW4vMzJqUStLYjd4cTRBM1ZlSmlqYWMxNFhkcVIyaWhySnJS?=
 =?utf-8?B?cmU0TWhGS1BQQjUxbXB4bUw0MzZmOFRSY0NrcDRadVc0d3lEcjZPa3lJZTlJ?=
 =?utf-8?B?QjdsMWhiS3o0b1dTWDI4SjVaWWdycjRIMHNKc2VOaEdaVURETUtnSkdTSzhz?=
 =?utf-8?B?QlVXdVBpcUhvZ3FwV2hDU3FQRjNSeTU0WkxIV2RoQUcrWlNTaTBPMWZ4SFNh?=
 =?utf-8?B?dWRnUkszMXpFRDlXMEdZWWZ3RWZOTG04QjZVbUR0bzJvVm1XUnJUWCttNXZB?=
 =?utf-8?B?MTBVVWVtcmxPY3Z6Sk1uTFY4QXk0L2xMSDNYYXMwMHFMZGVWWGs2WEtFYzE3?=
 =?utf-8?B?RUlhRDVEQjU2Q3NLVXQyR3A0aXVQT2J0SXNlV2hRTjZJeVoxbjIwY0dQQVFK?=
 =?utf-8?B?TTlnL1E4VGdrQzY5aDNicVpwZVJLMnBiZkp5ZFM0ZTlUb0E2NGx1RXpFZGw1?=
 =?utf-8?B?T3l6NlU5T3VYZExPOXdlSjNVMk1aSytjTy9nLzhVUnJIUzJ0Y2JKV0l6MlFy?=
 =?utf-8?Q?z9ck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5b3809-311b-45d0-a2a8-08dbc9a3e789
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 15:16:40.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8h7Ui8ZIXGPxOglIw8pEIKpevDkNfQtr5m7XW9jlxlTrvZRiFkk61FMFN9UcoD5p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGbG9yaWFuIEZhaW5lbGxpIDxm
LmZhaW5lbGxpQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxMCwgMjAyMyAx
OjUxIEFNDQo+IFRvOiBQYW5kZXksIFJhZGhleSBTaHlhbSA8cmFkaGV5LnNoeWFtLnBhbmRleUBh
bWQuY29tPjsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3Vi
YUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0K
PiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7
IFNpbWVrLCBNaWNoYWwNCj4gPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbGludXhAYXJtbGludXgu
b3JnLnVrDQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZ2l0IChBTUQtDQo+IFhpbGlueCkgPGdpdEBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHY3IDMvM10gbmV0OiBheGllbmV0OiBJ
bnRyb2R1Y2UgZG1hZW5naW5lDQo+IHN1cHBvcnQNCj4gDQo+IE9uIDkvMjcvMjMgMTI6MzIsIFJh
ZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+ID4gQWRkIGRtYWVuZ2luZSBmcmFtZXdvcmsgdG8g
Y29tbXVuaWNhdGUgd2l0aCB0aGUgeGlsaW54IERNQWVuZ2luZQ0KPiA+IGRyaXZlcihBWElETUEp
Lg0KPiA+DQo+ID4gQXhpIGV0aGVybmV0IGRyaXZlciB1c2VzIHNlcGFyYXRlIGNoYW5uZWxzIGZv
ciB0cmFuc21pdCBhbmQgcmVjZWl2ZS4NCj4gPiBBZGQgc3VwcG9ydCBmb3IgdGhlc2UgY2hhbm5l
bHMgdG8gaGFuZGxlIFRYIGFuZCBSWCB3aXRoIHNrYiBhbmQNCj4gPiBhcHByb3ByaWF0ZSBjYWxs
YmFja3MuIEFsc28gYWRkIGF4aSBldGhlcm5ldCBjb3JlIGludGVycnVwdCBmb3INCj4gPiBkbWFl
bmdpbmUgZnJhbWV3b3JrIHN1cHBvcnQuDQo+ID4NCj4gPiBUaGUgZG1hZW5naW5lIGZyYW1ld29y
ayB3YXMgZXh0ZW5kZWQgZm9yIG1ldGFkYXRhIEFQSSBzdXBwb3J0Lg0KPiA+IEhvd2V2ZXIgaXQg
c3RpbGwgbmVlZHMgZnVydGhlciBlbmhhbmNlbWVudHMgdG8gbWFrZSBpdCB3ZWxsIHN1aXRlZCBm
b3INCj4gPiBldGhlcm5ldCB1c2VjYXNlcy4gVGhlIGV0aGVybmV0IGZlYXR1cmVzIGkuZSBldGh0
b29sIHNldC9nZXQgb2YgRE1BIElQDQo+ID4gcHJvcGVydGllcywgbmRvX3BvbGxfY29udHJvbGxl
ciwobWVudGlvbmVkIGluIFRPRE8pIGFyZSBub3Qgc3VwcG9ydGVkDQo+ID4gYW5kIGl0IHJlcXVp
cmVzIGZvbGxvdy11cCBkaXNjdXNzaW9ucy4NCj4gPg0KPiA+IGRtYWVuZ2luZSBzdXBwb3J0IGhh
cyBhIGRlcGVuZGVuY3kgb24geGlsaW54X2RtYSBhcyBpdCB1c2VzDQo+ID4geGlsaW54X3ZkbWFf
Y2hhbm5lbF9zZXRfY29uZmlnKCkgQVBJIHRvIHJlc2V0IHRoZSBETUEgSVAgd2hpY2gNCj4gPiBp
bnRlcm5hbGx5IHJlc2V0IE1BQyBwcmlvciB0byBhY2Nlc3NpbmcgTURJTy4NCj4gPg0KPiA+IEJl
bmNobWFyayB3aXRoIG5ldHBlcmY6DQo+ID4NCj4gPiB4aWxpbngtemN1MTAyLTIwMjMyOn4kIG5l
dHBlcmYgLUggMTkyLjE2OC4xMC4yMCAtdCBUQ1BfU1RSRUFNIE1JR1JBVEVEDQo+ID4gVENQIFNU
UkVBTSBURVNUIGZyb20gMC4wLjAuMCAoMC4wLjAuMCkgcG9ydCAwIEFGX0lORVQgdG8gMTkyLjE2
OC4xMC4yMA0KPiA+ICgpIHBvcnQgMCBBRl9JTkVUDQo+ID4gUmVjdiAgIFNlbmQgICAgU2VuZA0K
PiA+IFNvY2tldCBTb2NrZXQgIE1lc3NhZ2UgIEVsYXBzZWQNCj4gPiBTaXplICAgU2l6ZSAgICBT
aXplICAgICBUaW1lICAgICBUaHJvdWdocHV0DQo+ID4gYnl0ZXMgIGJ5dGVzICAgYnl0ZXMgICAg
c2Vjcy4gICAgMTBeNmJpdHMvc2VjDQo+ID4NCj4gPiAxMzEwNzIgIDE2Mzg0ICAxNjM4NCAgICAx
MC4wMyAgICAgOTE1LjU1DQo+ID4NCj4gPiB4aWxpbngtemN1MTAyLTIwMjMyOn4kIG5ldHBlcmYg
LUggMTkyLjE2OC4xMC4yMCAtdCBVRFBfU1RSRUFNDQo+IE1JR1JBVEVEDQo+ID4gVURQIFNUUkVB
TSBURVNUIGZyb20gMC4wLjAuMCAoMC4wLjAuMCkgcG9ydCAwIEFGX0lORVQgdG8gMTkyLjE2OC4x
MC4yMA0KPiA+ICgpIHBvcnQgMCBBRl9JTkVUDQo+ID4gU29ja2V0ICBNZXNzYWdlICBFbGFwc2Vk
ICAgICAgTWVzc2FnZXMNCj4gPiBTaXplICAgIFNpemUgICAgIFRpbWUgICAgICAgICBPa2F5IEVy
cm9ycyAgIFRocm91Z2hwdXQNCj4gPiBieXRlcyAgIGJ5dGVzICAgIHNlY3MgICAgICAgICAgICAj
ICAgICAgIyAgIDEwXjZiaXRzL3NlYw0KPiA+DQo+ID4gMjEyOTkyICAgNjU1MDcgICAxMC4wMCAg
ICAgICAxODE5MiAgICAgIDAgICAgIDk1My4zNQ0KPiA+IDIxMjk5MiAgICAgICAgICAgMTAuMDAg
ICAgICAgMTgxOTIgICAgICAgICAgICA5NTMuMzUNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJh
ZGhleSBTaHlhbSBQYW5kZXkgPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbT4NCj4gPiAtLS0N
Cj4gW3NuaXBdDQo+ID4gICAvKioNCj4gPiAgICAqIGF4aWVuZXRfdHhfcG9sbCAtIEludm9rZWQg
b25jZSBhIHRyYW5zbWl0IGlzIGNvbXBsZXRlZCBieSB0aGUNCj4gPiAgICAqIEF4aSBETUEgVHgg
Y2hhbm5lbC4NCj4gPiBAQCAtOTExLDcgKzEwMzYsNDMgQEAgYXhpZW5ldF9zdGFydF94bWl0KHN0
cnVjdCBza19idWZmICpza2IsIHN0cnVjdA0KPiBuZXRfZGV2aWNlICpuZGV2KQ0KPiA+ICAgCWlm
ICghbHAtPnVzZV9kbWFlbmdpbmUpDQo+ID4gICAJCXJldHVybiBheGllbmV0X3N0YXJ0X3htaXRf
bGVnYWN5KHNrYiwgbmRldik7DQo+ID4gICAJZWxzZQ0KPiA+IC0JCXJldHVybiBORVRERVZfVFhf
QlVTWTsNCj4gPiArCQlyZXR1cm4gYXhpZW5ldF9zdGFydF94bWl0X2RtYWVuZ2luZShza2IsIG5k
ZXYpOw0KPiANCj4gRGlkIG5vdCBub3RpY2UgdGhpcyBiZWZvcmUsIGJ1dCBzaG91bGQgY29uc2lk
ZXIgdXNpbmcgYSBzZXBhcmF0ZSBzZXQgb2YNCj4gbmV0X2RldmljZV9vcHMgd2l0aCBhIGRpZmZl
cmVudCBuZG9fc3RhcnRfeG1pdCgpIGltcGxlbWVudGF0aW9uLCByYXRoZXINCj4gdGhhbiBhZGQg
YW5vdGhlciBsYXllciBvZiBpbmRpcmVjdGlvbiBoZXJlLg0KDQpUaGFua3MsIHdpbGwgbWFrZSBp
dCBhIHNlcGFyYXRlIG5ldF9kZXZpY2Vfb3BzIGZvciBkbWFlbmdpbmUgZmxvdyBhbmQNCnJldmVy
dCBjaGFuZ2VzIGluIGF4aWVuZXRfc3RhcnRfeG1pdCgpIGZyb20gMi8zIHBhdGNoLg0KDQpUaGFu
a3MsDQpSYWRoZXkNCg0K
