Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF27A862A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjITOHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjITOHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:07:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2122.outbound.protection.outlook.com [40.107.114.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9E7AC;
        Wed, 20 Sep 2023 07:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaBBnxB/xhC0Vl6y0qs0egeo8cjRC0qRRL5FQJdUq8xAuZ9+Sl+poKgJQQlU6Ddf3nFxcX6pNEhkz7rkOzEyNNZPHuGJ/dMMahpt5HREjVeU0ND221deigwgOhjl3RT/WEkb/W8bapi7Ko2Xqrk4I0Ss8fRLdpsdWK6dNwl840ISqRxg9uaniKskQH6sRZKTAFpUU8z7tTXevKURZ687FZXWEn94LxsqJrWJ1kST2F2S9eNEzlf0mHt2OoUx+0/7IJVsvRe9ix3uTJfmISO2HE9JyagS0DCB375kCiBM8inQVtB+xNCh6P11MvdgDVC1O3A7lB+JcebinWm2mQU/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plHTiluY/CjPzG7WEhBSu18XBhnz7JJOqjWK2Pa8nco=;
 b=IR6am5r13EAakKJuVJVB6P4Zk38vKfc/DaYIZaYzg3gv9AE8ucFxY/P46/xhMpBMjzxB3Nzd4evN7K1+El0kOPOz4gU56GSzziJwSNBW0aaLzIt7J34NsxwY9J4JpD3ofQBh9U7UB9T+K9kX9TAuLKweDye3K4qgXtHgtmGI33F1vnGsnO5CbIZvYLgjGxPu/oNxIIKDqd1cq29Ab0UIbPB4fE3jGZGRS7enYDgFWsj0sFoBaICP2CFgSmaP44GLNNhyEJxF2dwVvxIYIoeFCCAblQGXbzVeZpWTt1t6u7HyE6DjADxjBziQEopOxhzjYzKY11kfHaLQQ8zzjyL7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plHTiluY/CjPzG7WEhBSu18XBhnz7JJOqjWK2Pa8nco=;
 b=TuuvOmnm6QETBnpQvQfKCo8sBnhKkCrioKxFhkLHAnwJ0NAUrHjW6IwKex4kOKVXSLx9ub9Khm4OTwcEcL14+nGF4HuzVVgE3JGjGvgAMo8XLiNX+fWEdkNViu5vDGo/xO4gNkNMI+b1bhNB0coNPMpbBEVBUHjPY3LhRNjjgXw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10935.jpnprd01.prod.outlook.com (2603:1096:400:397::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 14:06:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 14:06:50 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Subject: RE: [PATCH 2/2] pinctrl: renesas: rzg2l: Enable noise filter for GPIO
 interrupt input
Thread-Topic: [PATCH 2/2] pinctrl: renesas: rzg2l: Enable noise filter for
 GPIO interrupt input
Thread-Index: AQHZ6ixt37i5mirEkU2vvrutS3Og4rAjpVMAgAAA4OCAABligIAAAoNw
Date:   Wed, 20 Sep 2023 14:06:49 +0000
Message-ID: <OS0PR01MB592202B4523DDC18B3E4511D86F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230918123355.262115-1-biju.das.jz@bp.renesas.com>
 <20230918123355.262115-3-biju.das.jz@bp.renesas.com>
 <CACRpkdYYKAFLvpKH0ih5qZVbv7L3auny5WWx+qKa_HD1o-vsog@mail.gmail.com>
 <OS0PR01MB5922A256D2C57963ADEBCEDB86F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CACRpkdbM+XNjvxBZQFzZCsU+3V7PucBhbi_WjVtnGpakFQasAw@mail.gmail.com>
In-Reply-To: <CACRpkdbM+XNjvxBZQFzZCsU+3V7PucBhbi_WjVtnGpakFQasAw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10935:EE_
x-ms-office365-filtering-correlation-id: ea7c8cf4-6f9b-4c62-20d7-08dbb9e2d590
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3EwTFgMNdVbgqdTsr6D6oDmR9/zsaTn7H+6waH99J9/yiu0CUeomxbSEw7swb/lsGxEHwY04STN4kgHd5D+bJKzJ4GWhuOkodjNGhGEK1qvGishfys1qQZQAvipmCz1kXRqV0AqEphEbQFJjoQJV2Da7rWmjO3b8JLy1QjyXzlD0X638fN//AJq0jlXndjTkDg4sEz6sBVqS4Lyc0D4mjXY9rQSIUZWr20FgLiH2pmgqzKswB6hBdA7ZK0u8Djg9972OJzjGPhMQi+q5/0kd8tAX6mRm9PS16mB2bAEg/yVFPbk/j3SXPf5RG2Uaq0QT0cldEA2SFL1kAI/f5/zoDTBv7UsaWIsVtWqB6+XRThc0seXmvhei4SNtWpKccxtHgSKG9WvjvOtZcNUbL2aforprVBqXVG/N086+uua3ix7pbIi0zW3WdJMVskqa4x/Y6Y361xvT2XGSLRrY5JTKCCp5zqDoP9g77wdXU8rifioXFx7lvrJ4pvPU63DtjXe2E1xuVfXYOYAY78+chUOHFd4LIkIyYcEKg37YO2cS3GPvFGiEReS082UpsSFf7S2rEKQkcmnXnIYxymlkzvSxEiu8P/MOOM4+8CJLMg7nRrSojmx+YxBdGRC7sZvEwNN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(1800799009)(186009)(451199024)(9686003)(53546011)(71200400001)(6506007)(7696005)(83380400001)(122000001)(86362001)(33656002)(38100700002)(38070700005)(55016003)(76116006)(66446008)(66476007)(316002)(66556008)(6916009)(66946007)(54906003)(64756008)(41300700001)(2906002)(52536014)(5660300002)(8676002)(4326008)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2NLZHB0Y3JFUXR2NVBhVkhuSkRSK0wwWWFRcE9MQ2ZrOEREZ24vQmIzdGtK?=
 =?utf-8?B?OUJMd3RiV0ZmVzZuc3FhYk1hL01SUE5XdUplaUhGU1Rrc3hURTZrcW1BK05R?=
 =?utf-8?B?MDlnVWNTRGI2enZEV0hmYVNLWUZsOGxBNWZpTjgydjMvdEwvYnNlUVp4azlQ?=
 =?utf-8?B?NDN0WEIvME5UUDhqekw4ejBBbmx1ZFZXRHptVHFCV0JwSHgwTDZrR2tJbDM0?=
 =?utf-8?B?QWtSTldaWmdiWnQ3NWpNMWxpQnRqdVJCMXJ0aFZDTFN4NXJWU2JyYUhTdFJ2?=
 =?utf-8?B?Qk85WkJTQmh1VytuSUVlbmlUdUZEZHZMQi9TY1AzS3c3RitqV3FyYUpkMU5Y?=
 =?utf-8?B?OExCcGZnOFdRazBKNzV6bEFUd0lUUFZTSFBwbXhzdzN1WTlmZzFUYm5LWVYv?=
 =?utf-8?B?ZkZhZFk2d2xsREgzaXB5YXRrOGJzWWhWVzhkMlRMRThLcnhveVJTVDhQeENu?=
 =?utf-8?B?RkhiQ0J5N243SWJzUEZBRnVpQmJYMnd5bTVaZGp3dkFYT3hwVjdhaW9tem9m?=
 =?utf-8?B?RHVtM1RWT2VpZ2tYckd4SGVTMFloeWpDMjZOcmdDcmRVZEhWdy9HQTRWWWd5?=
 =?utf-8?B?a2pHTnFoc1JLbTgzQ1k4c2lmVW1jNktoVWlsVlZYWlhHQUZrV3RDSmxBaFkx?=
 =?utf-8?B?ekxaNmVDcERvc3J0TE9SSnQzY0Qzd3ZSNEI1ZVl3T2hpY1gweW1LZktNQ2lI?=
 =?utf-8?B?eVBXQjR6ZWJNSlluRnpjcGRRL05CZEpMNFprNy9SMCs4L1JCaUhQZ3E1c01w?=
 =?utf-8?B?Nmd5MndHUzM5eUFmWnE0c3pvR1pUKzgwVGJTMnZNanhMSWZzd09TN295WkF6?=
 =?utf-8?B?UExRR1dGWmJPQWFjNlFmbEtXVk5JSmVtWVpwRTJFMU1BOW55MHdtTTVnbnFO?=
 =?utf-8?B?NzZEWVUrdWxac3hENnI0M1NocHdXNHpQRXpmS0Y5ajVCN2pEdXVCU2xMckph?=
 =?utf-8?B?N3l0dXBoRDZwUnl1Vko2NWMwNmFLZG9zQjc0dmk3cStQK3R4MXlaelhDV1lD?=
 =?utf-8?B?MkV6ZUR6Wng5V3Q5WnBvcVlRRzZjbEw3c3lKZFhJVk1lTmVsNVRWZDJNSlZl?=
 =?utf-8?B?RFVoT1RtUU56UmF3S2dQNVdjeUt5S2dYdWJjdi9DZk9UZkcvcFYyc2JmcGFz?=
 =?utf-8?B?R1NEWlQ2YWZPWFR4eVhTeFVJWlFwRGR4RXZtc1lTdUM3aUgrMG42dXdSZ3Fh?=
 =?utf-8?B?LzV4OGNwREZpeFlkRHJVeGZqVmNJOWxjcUpTTHR5T3RrS3BjWE11ekN2T3BN?=
 =?utf-8?B?cEZma3pXcno1Qm1HYnFLSUl5QTlzZkJiaGpoYUg1VUxZTVArVTlQQU5pSHdu?=
 =?utf-8?B?d2ZKVDM1dm9HSmlJMmw5R3BLbDFBVlBtU2RRS25qazJjU1FWUFF2eG11bXQ2?=
 =?utf-8?B?NmkzUGhBbGZIa1BVaFJLUmFRTVlrL0NTc0IrNCt5RTJ3QU5aRnlLSEQvRndO?=
 =?utf-8?B?M1g2QkFWM016RXhwZHFndzErSGR5K1NUeWt0TktKSTFDSWVUcWxWcUVzZDFq?=
 =?utf-8?B?TVE4cUNhZ2JqenRyQU9CbnJZb01HbVBMTlNpUnlJM3I0ZEJCRS90Z1lwOUlm?=
 =?utf-8?B?bEJ3VXBsMHlkQmlFTS93Q3VpZ01QcU1QaWI1cXJEV2hMZ01LdmE1NXBXTUhx?=
 =?utf-8?B?SzNqcGxPNnJLRVQwb0tTRGp1V2xYdzdWZjQ3YWs0SlhoT1pRYmRHbkZjRkd4?=
 =?utf-8?B?ZVN4bkhlRDJUMkF3QVJ5WEc2aDhpK1FiOC9EREJER0pObzJRSGlBaWFHdnpB?=
 =?utf-8?B?VWY1elBDQm4yZWE1NGlpZGtlcVFBMDk4NlVjLzJidy9xMzNVb1k0YS9zOE01?=
 =?utf-8?B?R2N5LzQ4WktIRStjaVpjRjhNS3NhcVVLYXRSVjRVT3BvN2Jmamh6Nnh6VmRR?=
 =?utf-8?B?eDZmS09CdG1RNlFXR2hQS2piV1gzbnU2aTlsUjgxV3hVMkFrUnEzVmZSZjls?=
 =?utf-8?B?Q25OWDRzZHRIM3MrTHFFVlpnMUN4cTNVRkp5UXd1RHRFQTNTbkRIeERub2FP?=
 =?utf-8?B?Um5xb3h0K2FEWEpyandnb3BxN1JZNndNR05IelY3OVJQMDlwbmpzQWkwci9F?=
 =?utf-8?B?TkRXSmdqWm1ONWRqVXZnL2p5K3R6VFQ0RXZ3ZFlOWWl0QWVtUk52UlRRRUhm?=
 =?utf-8?Q?W97k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7c8cf4-6f9b-4c62-20d7-08dbb9e2d590
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 14:06:49.9659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4jauP0aQ/XykkZy1M0Gb+AsvujNnxg7XYPZC6eG0jSSO2qc/oxSKEYi89gDIUkdyZPvtaDqzFf0ll2R5nD4X8T+PPl1w1sNRn3dcriMvcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10935
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMgV2FsbGVpaiwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAyLzJdIHBpbmN0cmw6IHJlbmVzYXM6IHJ6ZzJsOiBFbmFibGUgbm9pc2Ug
ZmlsdGVyIGZvcg0KPiBHUElPIGludGVycnVwdCBpbnB1dA0KPiANCj4gT24gV2VkLCBTZXAgMjAs
IDIwMjMgYXQgMjozN+KAr1BNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4N
Cj4gd3JvdGU6DQo+IA0KPiA+IDIpIERpZ2l0YWwgTm9pc2UgRmlsdGVyIENsb2NrIFNlbGVjdGlv
biBSZWdpc3RlciAoRklMQ0xLU0VMKToNCj4gPg0KPiA+IFRoZSBGSUxDTEtTRUwgcmVnaXN0ZXIg
c2VsZWN0cyB0aGUgZGl2aWRlZCBjbG9jayB0byBiZSBpbnB1dCB0byBkaWdpdGFsDQo+IG5vaXNl
IGZpbHRlcnMuDQo+ID4NCj4gPiAwMGI6IE5vdCBkaXZpZGVkIChpbml0aWFsIHZhbHVlKQ0KPiA+
IDAxYjogRGl2aWRlZCBieSA5MDAwICg0MS42NjYgbnMgeCA5MDAwID0gMzc1LDAwMCBucykNCj4g
PiAxMGI6IERpdmlkZWQgYnkgMTgwMDAgKDQxLjY2NiBucyB4IDE4MDAwID0gNzUwLDAwMCBucykN
Cj4gPiAxMWI6IERpdmlkZWQgYnkgMzYwMDAgKDQxLjY2NiBucyB4IDM2MDAwID0gMSw1MDAsMDAw
IG5zKQ0KPiA+IE5vdGU6IFRoaXMgdmFsdWUgaXMgdGhlIHZhbHVlIHdoZW4gdGhlIGV4dGVybmFs
IGNsb2NrIGlzIDI0TUh6Lg0KPiA+DQo+ID4gUTEpIFdoYXQgaXMgdGhlIHJlY29tbWVuZGVkIHdh
eSB0byBhc3NvY2lhdGUgdGhlIGFib3ZlIHZhbHVlcyB3aXRoDQo+ID4gICAgIFBJTl9DT05GSUdf
SU5QVVRfREVCT1VOQ0U/DQo+ID4NCj4gPiBFZzogSSBuZWVkIHRvIGNvbmZpZ3VyZSBmaWx0ZXIg
b24sIDggc3RhZ2UgZmlsdGVyICwgYSBkaXZpc29yIG9mIDE4MDAwDQo+IGZvciBhIG1lY2hhbmlj
YWwgYnV0dG9uIGJvdW5jZSBub2lzZS4NCj4gDQo+IEFzIHBlciB0aGUgZ2VuZXJpYyBwaW4gY29u
ZmlnIGFuZCBEVCBiaW5kaW5nczoNCj4gDQo+ICAqIEBQSU5fQ09ORklHX0lOUFVUX0RFQk9VTkNF
OiB0aGlzIHdpbGwgY29uZmlndXJlIHRoZSBwaW4gdG8gZGVib3VuY2UNCj4gbW9kZSwNCj4gICog
ICAgICB3aGljaCBtZWFucyBpdCB3aWxsIHdhaXQgZm9yIHNpZ25hbHMgdG8gc2V0dGxlIHdoZW4g
cmVhZGluZyBpbnB1dHMuDQo+IFRoZQ0KPiAgKiAgICAgIGFyZ3VtZW50IGdpdmVzIHRoZSBkZWJv
dW5jZSB0aW1lIGluIHVzZWNzLiBTZXR0aW5nIHRoZQ0KPiAgKiAgICAgIGFyZ3VtZW50IHRvIHpl
cm8gdHVybnMgZGVib3VuY2luZyBvZmYuDQo+IA0KPiAgIGlucHV0LWRlYm91bmNlOg0KPiAgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ICAgICBkZXNj
cmlwdGlvbjogVGFrZXMgdGhlIGRlYm91bmNlIHRpbWUgaW4gdXNlYyBhcyBhcmd1bWVudCBvciAw
IHRvDQo+IGRpc2FibGUNCj4gICAgICAgZGVib3VuY2luZw0KPiANCj4gVGhlIHJlY29tbWVuZGVk
IHdheSBpcyB0byBwYXNzIHRoZSBkZXNpcmVkIGNsb2NrIGN5Y2xlIGluIG1pY3Jvc2Vjb25kcyBh
cw0KPiB0aGUgYXJndW1lbnQgdG8gdGhlIHBpbiBjb25maWcuDQoNCkhvdyB0byBhZGQgbnVtYmVy
IG9mIEZGIHN0YWdlcyBpbmZvIG9uIHRvcCBvZiB0aGlzIGNsb2NrIGN5Y2xlPw0KDQpVc2Ugc29t
ZSBlbmNvZGluZyBpbiBEVCBhbmQgZGVjb2RlIGl0IGluIGRyaXZlcj8/DQoNCkNoZWVycywNCkJp
anUNCg==
