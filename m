Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1C7E8070
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbjKJSKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbjKJSHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:07:47 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Nov 2023 06:57:02 PST
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF2D39CF1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
        t=1699628220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k8wW97RIkC0ak1u9FnhlWb7h6PcqiSLNP3wU3ysY89U=;
        b=Wt435rdI6g19joyCFqx38rsZJknPUxyipEWWXJbBNIIz5PSoIE4vOCg0UILiKKIMguBHVx
        8CAlkNgkL49VkT2fsnRv5/HE0ZHVeOmV2QB5Ysv2Z9WT+NTZ4C8ufSPN16PEFeT0ms4bSC
        6slj8g9BbwE1/xGGS12xIYNnTwzoUX4=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-42-0W62bmbLPHGb-T2pEcUjgg-2; Fri, 10 Nov 2023 15:55:56 +0100
X-MC-Unique: 0W62bmbLPHGb-T2pEcUjgg-2
Received: from ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:48::5) by
 ZR1P278MB1150.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:58::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18; Fri, 10 Nov 2023 14:55:51 +0000
Received: from ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4587:99bd:381d:2042]) by ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4587:99bd:381d:2042%2]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 14:55:51 +0000
From:   =?utf-8?B?Sm/Do28gUGF1bG8gU2lsdmEgR29uw6dhbHZlcw==?= 
        <joao.goncalves@toradex.com>
To:     "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: SDHCI AM654 driver delaying boot time
Thread-Topic: SDHCI AM654 driver delaying boot time
Thread-Index: AQHaEnVCf5sjwm2UEkq/5WYQVpvAvw==
Date:   Fri, 10 Nov 2023 14:55:51 +0000
Message-ID: <5d4785dc46f7798fe96366d6128e068f623ce1c2.camel@toradex.com>
References: <0e81af80de3d55e72f79af83fa5db87f5c9938f8.camel@toradex.com>
         <20231109175159.wylup6z45h7mgxji@clump>
         <81fee24c-47d2-4c2d-8f88-35fd1ea1d639@ti.com>
In-Reply-To: <81fee24c-47d2-4c2d-8f88-35fd1ea1d639@ti.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZRAP278MB0873:EE_|ZR1P278MB1150:EE_
x-ms-office365-filtering-correlation-id: 74d5e0b1-5686-4bd0-1853-08dbe1fd21a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: h/SEDnBscaFZqqk5ddrhs7Mg1z6xRVVIyjRI3TyWnzl7IgQvA8RVgeq+HahpigMQ8T7uykGX32ZtwqdhsHrVLB2iyHNDZZfZ+fMi2Y+0MHMlKpyChy35+ggRzzoIJceAgB7gC4AyhGZSYUViGVKLVBHPQzaJ2mjUcj15s9vEZ70HkILjTUAEUzWbXcCdoQngemSS2r7cxTlUS7JBNGRq68lyVS7PHzVm9590JdyEciNK4INtOWzyagpTLX3RYWOyopnpg1IDa5ztxYKCvFH8diLwiV016VjTDNDkCFI+K0ARUwoLNIfgmZlHU3tJCnMZ+8coswejtw52ZdRNHu+DalT82UGBGTe4XEIjJMPL8GGo/4YDvYPwkUZ6KMS2QTlIip8IQVGxksM8gQGlEHlbsqykl+mnsiph8mphqT7kT9IGne9X+tQZVkw8T9JTw/KCWU3DptQiKjQjNznWcn8vcYGFsl7tVQ7PSzGu9IhU0JeqEMn0BvqqjfTir+LyoeEtggF2ImJf6Psu47vInFTm+Ailowit3IuB8k+HHiGltda8rwY+2cYUBjevbe4HQovOx5c+k6IZfKUzUJ7Ee6p0m6uniVvc3poXJ7pKDIoz7J8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39850400004)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(85202003)(66946007)(316002)(64756008)(6512007)(76116006)(66556008)(66476007)(66446008)(41300700001)(54906003)(36756003)(38100700002)(38070700009)(71200400001)(2906002)(91956017)(110136005)(5660300002)(478600001)(122000001)(966005)(85182001)(83380400001)(6486002)(8936002)(66574015)(4001150100001)(8676002)(86362001)(26005)(2616005)(4326008)(107886003)(53546011)(6506007);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjNPREFzSkFoRzVRdGwrMElMRnVvdmI4RFpYUEZBTWNGUXNiL016Wis0ZWxs?=
 =?utf-8?B?R0I1Vm0wbzhRWEpMeng0QlpUUmg5TDJXN3hULyswbCtJUGpxRzJtLzZ5aUhi?=
 =?utf-8?B?Ym5DcDdnU3p0R1ljR2dpM2NDai9UODNQampza3gwak1Lc2lCcGs4N2pRTkRU?=
 =?utf-8?B?UU9rSjllN2RMMXFYNk9mVGhMOVg2UHp0VTlHNHFVK3crQ28vM1JycVU2UStS?=
 =?utf-8?B?ZnMrUUd2WEhPNytQdDRsNlhwcTNGU2VLeTJYQitXRzUwdjZTYXBwdGlOMHRo?=
 =?utf-8?B?QXl3Y3BLYzhiSmlNbmg3UTF5SmpFU0Jmd0pWRCt2TVk0YmsvVFZsdUJ0Yjkz?=
 =?utf-8?B?QmRrVkVuSmxSbU9BL0t6eE1MSWR0a084c2ZoOFVpMXFTMEp0OEhRd21mdmgy?=
 =?utf-8?B?b1diMFBQVWhyaHBldE5xcjBZQ2ZFWlZTWWFVT2l3c3d3N1N2UUlKcVk2V0lC?=
 =?utf-8?B?V3V0K2szdUlXanN4VkFLTm4xNkg4WG5CSmJwRVlpaEZ3Z2pnNitzMTdMTG9I?=
 =?utf-8?B?d0ZVWHRxb1JOS0xLOHNPYzFURHpDeE5PNHI1RGt2emU5dG0wK3dyUGt0M0tI?=
 =?utf-8?B?bVhlaVlLSWc3cHZEdU91dm5DWS9qTnY4MUdYUGhRNGhybTIyUFJLdFpXWUtZ?=
 =?utf-8?B?eUt3ZnVvbFZPcUpTVi9rN21LS3djeTVDTE9RT3lQM3JKT3hKU2s3a0JGK0Fp?=
 =?utf-8?B?cG1Ka2VmT0dqNTdOREowTlc4VnhCWWZKenprYlFCVmV1NU9wRUwyL1d1OHMx?=
 =?utf-8?B?TmZ3Y3lwZTJ3OXNETVIvQkJxaUtDa1hJMWd3UFhZTy92VGpvckEwTnBXM0c1?=
 =?utf-8?B?Z3A0ZmR0OTArcndTWXFVelJSSjBuY1cxSWNBcVJ5eDBMRGJoZDVhS1d3eVEv?=
 =?utf-8?B?cHAwd21VQjNaeTBpcEgvUlAzdk5GdEtUYzZmczZtK2IvSVhGcmI1MFJMQ1I2?=
 =?utf-8?B?eUNnMFlqUHdvUUxRRmdUeUprdE5Pd1pWK2Y5VzJhVFlFV1RqeWFHVlZURjdY?=
 =?utf-8?B?UEhwaWk3Q24rVk1kTWhIdDhBY1Z4cU81c1duQnlpOHA2dFR3akIrYm50VmNF?=
 =?utf-8?B?ZU5rbHBmaHh2bFNLZk12NjJqandDWFRZYXN6VHFhT3I3WGpaR2xSanhDU3BY?=
 =?utf-8?B?djlNZnNiZFF3U3JKdUU4YVh4eSt0NFdyNys0aHdEQ2M5V1UyV0dNdkFHazdO?=
 =?utf-8?B?MCtrV1g4QXBBcDZuTlBYV2lkV2JQL0pNRld1SVN2ZFRQWDl6VFNSQWdUbjk4?=
 =?utf-8?B?WThRQWNXUmhibWRLcU9iN01TbEpvNGNNdHdENzN4OXltUE9GZ3VBUTkyVEsv?=
 =?utf-8?B?cjBaNG14dk03bkpKUTIxSHNxUU9aeEJ0dUh3OEZXUjVaMGRkT1VWWTRaQ3pY?=
 =?utf-8?B?SFJPMEJZRFBUMXFtQy9lWXB1WFJkQkRmRGtNS3oxWHY5YjZFczNEbTljcWNt?=
 =?utf-8?B?Q014eENoVjI0VitTL3E0KzhqTVlBbWU0ZkNaL3ExZkNOUmdGcFhoSXBrbGhM?=
 =?utf-8?B?Q2ZQa3crSlA2a1Z4RlJxS0tHWGRHdGFyM2UxSlh5VDlHZ0ptMzlwM1pPbWhr?=
 =?utf-8?B?azV5bWVVcXFXcHAyMFpPN3FvUWlwNkhNbVFrTXhKSHNyY0J3YnhqNHhFMVJ1?=
 =?utf-8?B?ZFFNWXdFUzB5TGIvMlpURXVPUUJYUWtyZm43ZXk4aVVWOW5kVDE1c1F3TnIv?=
 =?utf-8?B?OEM1YzhINHJJYlZmUFc3NFJpbU1paTNUYzJpcHptWStZS0JWRkxZSEJKRHdi?=
 =?utf-8?B?bGdZVWFvcktSRXV1ei91T2IxUEhDZ0tnK0laL0dwTndFcjVTVU5tYlVCSGRK?=
 =?utf-8?B?cGM2MmFQblNkZWlGUXViUWZXYkZxRm5MR1lTbGhLK2RHMlpya3VibUpwbGtW?=
 =?utf-8?B?THc1VDFvY3VPTTlwbmp1SHI5K053VWkwWVBZUllNS1hMSWRralBSYmlqazJ1?=
 =?utf-8?B?OE5iOHFiemt4NmF4dENLRCs3MzZnMTY4dVp6TURnbmYrWm54MFc5WVdOZTNk?=
 =?utf-8?B?NDFGbHh3dE9KekI2RWJvbE93bTFDc2cvS3dIM3l6bUdWY21VazRmNThTdExC?=
 =?utf-8?B?M1g3V1loMHF6V1NZL2RuM0EySVpVcjk1d1JmSmcvNG41SGUxb1pwTkw0Q2VQ?=
 =?utf-8?B?UXhBZy9teHA2YVh6Zmc0ek1hdFo0RFA4MWdZUXR2bFdoS1RmWlFUWHN0WGp1?=
 =?utf-8?B?Smc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d5e0b1-5686-4bd0-1853-08dbe1fd21a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 14:55:51.0224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6nC0O36EoU+4rX1nByVGaRdpZUvtKh7E6D1VHydFl84WnNO8uNsrEHutitOeLjR8zWStvj0gpuwSeuH1UghF61rAxo6KtSl7vKE+LWUdhII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1150
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <19C3D9E87C45A644B002734E701D7C81@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTExLTEwIGF0IDEwOjA4ICswNTMwLCBWaWduZXNoIFJhZ2hhdmVuZHJhIHdy
b3RlOg0KPiBIaSBKb2FvDQo+IA0KPiBPbiAwOS8xMS8yMyAyMzoyMSwgTmlzaGFudGggTWVub24g
d3JvdGU6DQo+ID4gT24gMTg6NTYtMjAyMzExMDgsIEpvw6NvIFBhdWxvIFNpbHZhIEdvbsOnYWx2
ZXMgd3JvdGU6DQo+ID4gPiBIZWxsbyBhbGwsIA0KPiA+ID4gDQo+ID4gPiBXZSBhcmUgdHJ5aW5n
IHRvIG1pbmltaXplIGJvb3QgdGltZSBmb3Igb3VyIEFNNjIgZGV2aWNlcy4gVW5mb3J0dW5hdGVs
eSwgd2UgaGF2ZSBpZGVudGlmaWVkIGEgZGVsYXkgb2YgYXBwcm94aW1hdGVseSAxLjUgc2Vjb25k
cyBjYXVzZWQgYnkgdGhlDQo+ID4gPiBzZGhjaV9hbTY1NCBkcml2ZXIuIFRoaXMgZGVsYXkgaXMg
YSByZXN1bHQgb2YgYSB0aW1lb3V0IHdpdGhpbiB0aGUgZHJpdmVyIChNQVhfUE9XRVJfT05fVElN
RU9VVCkgYW5kIHdhcyBpbnRyb2R1Y2VkIGluIGNvbW1pdCA3Y2EwZjE2ICgibW1jOg0KPiA+ID4g
c2RoY2lfYW02NTQ6IEFkZCB3b3JrYXJvdW5kIGZvciBjYXJkIGRldGVjdCBkZWJvdW5jZSB0aW1l
ciIpLiBUaGlzIGlzc3VlIGFyaXNlcyBvbmx5IHdoZW4gdGhlcmUgaXMgbm8gU0QgY2FyZCBwcmVz
ZW50IGluIHRoZSBNTUMgc2xvdC7CoCBXZSB0ZXN0ZWQgdGhlDQo+ID4gPiBkcml2ZXIgd2l0aCBh
IGxvd2VyIHRpbWVvdXQgdmFsdWUgYW5kIGV2ZXJ5dGhpbmcgd29ya2VkLiBIb3dldmVyLCBhcyBp
bmRpY2F0ZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCB0aGlzIHRpbWVvdXQgbWF5IGJlIHJlbGF0
ZWQgdG8gdGhlIHdheSB0aGUgc2RoY2kNCj4gPiA+IGNvbnRyb2xsZXIgaGFyZHdhcmUgSVAgd29y
a3MuIEN1cnJlbnRseSwgdGhlIGRyaXZlciBlbXBsb3lzIGEgc29ydCBvZiBhICJidXN5IGxvb3Ai
IHRvIHdhaXQgZm9yIHRoaXMgdGltZW91dCB0byBwYXNzIGRlbGF5aW5nIHRoZSBib290LiBXaHkg
aXMNCj4gPiA+IG5lZWQgdG8gYnVzeSBsb29wIGZvciB0aGlzIHRpbWVvdXQ/IElzIGl0IHBvc3Np
YmxlIHRvIHdhaXQgZm9yIGl0IGluIHRoZSBiYWNrZ3JvdWQ/IEFtIEkgYW0gbWlzc2luZyBzb21l
dGhpbmcgaGVyZT8gDQo+IA0KPiBzZGhjaV9hbTY1NF93cml0ZV9wb3dlcl9vbigpIGRvZXMgaGF2
ZSB1c2xlZXBfcmFuZ2UoKSBvZiAxIHRvIDEwbXMuIElmDQo+IHRoYXQgaXNuJ3Qgc3VmZmljaWVu
dCB0byBwcmVlbXB0IGFuZCBhbGxvdyBvdGhlciBkcml2ZXJzIHRvIHByb2JlLCB0aGVuDQo+IHBy
b2JhYmx5IHdvcnRoIHNldHRpbmcgc2xlZXBfdXMgaW4gcmVhZF9wb2xsX3RpbWVvdXQoKSBjYWxs
Lg0KPiANCj4gDQo+ID4gDQo+ID4gSSBhbSBub3QgYW4gbW1jIGV4cGVydCwgYnV0LCBJc24ndCB0
aGlzIHNlcXVlbmNlIHBhcnQgb2YgdGhlIHByb2dyYW1tZXINCj4gPiBtYW51YWwgaW4gdGhlIFRS
TVsxXT8gRWl0aGVyIHdheSwgb25lIGFkZGl0aW9uYWwgaXNzdWUgSSBkaWQgZW5kIHVwIHdpdGgN
Cj4gPiB3aGVuIEkgd2FzIGRvaW5nIGJlYWdsZXBsYXlbMl0gd2FzIHdoZW4gaSBib290ZWQgb2Zm
IGVtbWMgYW5kIHJ1bnRpbWUgUE0NCj4gPiBkaXNhYmxlZCBTRC9NTUMgaW50ZXJmYWNlLCB0aGUg
TU1DIElQJ3MgQ0QgbW9kZSB3b3VsZCdudCB3b3JrIHNpbmNlIHRoZQ0KPiA+IElQIGlzbid0IGNs
b2NrZWQuIFNvIEkgc3dpdGNoZWQgdGhlIG11eCBtb2RlIHRvIEdQSU8gdG8gdXNlIG1tYyBDRA0K
PiA+IHRoZXJlLiBJIGhhdmVuJ3QgdGltZWQgdGhhdCBhcHByb2FjaCB3aGVyZQ0KPiA+IFNESENJ
X0FNNjU0X1FVSVJLX0ZPUkNFX0NEVEVTVCB3b3VsZCBnZXQgc2V0Lg0KPiA+IA0KPiA+IFsxXSBo
dHRwczovL3d3dy50aS5jb20vbGl0L3BkZi9zcHJ1aXY3DQo+ID4gWzJdIGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVl
L2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02MjUtYmVhZ2xlcGxheS5kdHMjbjgzNQ0KPiAN
Cj4gDQo+IEFib3ZlIGlzIGEgZ29vZCBleHBlcmltZW50IHRvIHNlZSBpZiBpdCBoZWxwcyBib290
IHRpbWUuIENhbiB5b3Ugc2V0DQo+IFNEQ0QgbGluZSB0byBHUElPIGFuZCBob29rIHVwIHVzaW5n
IGNkLWdwaW9zP8KgIFlvdSB3b3VsZCBhbHNvIG5lZWQgdG8NCj4gc2V0IHRpLGZhaWxzLXdpdGhv
dXQtdGVzdC1jZA0KPiANCg0KSSB3aWxsIHRyeSB3aGF0IE5pc2hhbnRoIHNhaWQgYWJvdXQgdGhl
IGdwaW8gYW5kIGFsc28gaW5jcmVhc2Ugc2xlZXBfdXMuwqANClRoYW5rIGZvciB0aGUgaW5zaWdo
dHMhIA0KDQpSZWdhcmRzLA0KSm9hbyBQYXVsbyBHb25jYWx2ZXMNCg0K

