Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF40E7EEC0C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 06:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbjKQFoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 00:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQFoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 00:44:13 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FF5D4E;
        Thu, 16 Nov 2023 21:44:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8do9RwMyAOt8ey/gj8etmwpgkx9anOLp8xSXxRQ5CVbAZmTbpWqu5Vf/5hVU5i3FdyrQCvYVahAFeQjQMd0PVZInff0v11wE2u7ZKNE+A11DhQkN6r47ymCOrd2javm9Lu9dohaqHbVGj3Mv2n8vdjcXjFl8bbsfRmju7+m+eQTwSXBK1UJzGHOjHEDs2ybKjeS5yux6vygMnDZ5XQkZXa/V92rs+fy7sDlApe0BlNY5NYEwI72xCxbSilvuLpRrW/pCgL72eRvMOap5gWR4aASF7S9zgqQQkgRLptSO36UfmzeI9/NAfExJFDvPIkwRad6Ku8qH8JADrqKEqxcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGGJa448BhbiRuIy95P+Q4g4eFpYh/4YAks/SNeb2fY=;
 b=maIn9IH4XxKzh2Pqe7FSjzigxGuaVQTrVyjBSUt73GOoB1oCQPSbBryhZY+CIuSBIDJJytY4fdfs8q3oFij0R6njcWahHZ/XUP0BwXlSIYDw7MtJ2VDqi0iKHEriE5KanYsz2l4PPoylz/PAuPwJGPqdBNSSal1Q7LySQlckg6rdmu0J+9LuN7kcnsRfpzUQwrZ0UDL/ATruxSdyGEVepe7sZ7SdsdiK2baxAGKcWoI6mNauAzmOOuZ+L410H0/MgF5yTeONWufNcYxUXNKKWSaJoCiaEJrlZprj4vimFsgZ1Rqa4ytNjIcJo2aE9H4ZPYNRAimM6rPxBEUT5nbk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGGJa448BhbiRuIy95P+Q4g4eFpYh/4YAks/SNeb2fY=;
 b=wI9gXLJ2PFUUCEVadfiP4rm25fhuBlM31DuzL6K4NUBwCpvc7ParagBt8bue9W0RL4rBMfjpgKCVy9ehrzjm7YhBYlAqt7r6aAPmdpZZCBzVI+wfdb8nzWVTIACNZtpIfRUqmaOKUToQcB7TnBu54v+Vi/oGoEKDVj/ZVEevoiI=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 05:44:07 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::6f1a:10d7:a72e:4e1c]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::6f1a:10d7:a72e:4e1c%7]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 05:44:07 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Subject: RE: [PATCH] usb: dwc3: core: enable CCI support
Thread-Topic: [PATCH] usb: dwc3: core: enable CCI support
Thread-Index: AQHZ/ZcGAnt3cGDkQk+ZfNahH6Tg2rBTW7AAgBVuLxCACjijAIALMiIQ
Date:   Fri, 17 Nov 2023 05:44:07 +0000
Message-ID: <MN2PR12MB4333DDBA74CF27A38FDAFF2388B7A@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20231013053448.11056-1-piyush.mehta@amd.com>
 <20231020231615.w5m2w5bknblpkhyt@synopsys.com>
 <MN2PR12MB43336B903F927A7120A7E09F88AAA@MN2PR12MB4333.namprd12.prod.outlook.com>
 <20231110023725.fotx3bkkei5jkzid@synopsys.com>
In-Reply-To: <20231110023725.fotx3bkkei5jkzid@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|SA1PR12MB8096:EE_
x-ms-office365-filtering-correlation-id: 11c9c3ef-f2bf-4f1f-48f2-08dbe7303740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6StL8X4U4ZaedG+vJOC4JOLV1C8NBTFkYNalUGTLa+Xq7jYVY53Z2MaUVh8q74B6JsJ3K0iM4lYTvjO/4MoOZVDyl9hSvMaLA8gHIvyf5SliTsKyuy/kVr/Ozsv6ElYsEWUvTBBKmXPoqFaYzhMnM59N1+Ck54RSpn75eVpaYlK9b3lRrjpMVa6CV62s2sQP5ZIvx40VgugOoUBNBMw9e99FmQsKaoHkYmZPHguP1nNsEGzFLbGh/PAD1RX4crBabzXbAAW7ABnqy0LS1pj/Sr6sbAX4W+ozLk2ToftGwfphdAXhkIaa+DlPDkBNa/2V8GSMCS+ffA5h3Wt433CHv59EYaMbUhCmwwVzpzd7dh44GlnWjnN03kI/sX0pZu6z1/rbn1t8WIXtE6Y2gTPlAuMqFP/y9cOM/aFnHgWcN9vdSzQR5bpi0tpqeQ+ATR1dNoRVQ4JBWNNImmsm9FHAwhHiRr3zSi9OmOL34M1+jo+5QH+W6biOa1ig4IE9h88yimpj4bJSo9cpgsCMadBlJvFXk5aEip5P57UkggZRpRQZrewvQY2PNYx4ZuvU3mOctxPEunSQ/AhepcUlECdv9U3PnYFRfVCv5n8iDkbSBoo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(33656002)(86362001)(41300700001)(2906002)(5660300002)(4326008)(8676002)(8936002)(38100700002)(66946007)(64756008)(66446008)(66476007)(66556008)(54906003)(76116006)(6916009)(316002)(38070700009)(55016003)(966005)(478600001)(52536014)(122000001)(83380400001)(7696005)(71200400001)(6506007)(53546011)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmRsS1Rob2doS3FjeEZQR2hOQTdDR3RDVVNIOS9MbTI5eTZzdnBVdnRpU1pT?=
 =?utf-8?B?d3ErRUw1QStERlBnUXVmMy9ZUDlrZG9hWUZTRHk2WlN6Sy9ZcDZIZE42b3NG?=
 =?utf-8?B?a2NtNFFiaUtuYTVGamlEYlRPVTY5RlZURHQ0QStZaDV5eGQ1clpGelBVQThk?=
 =?utf-8?B?aUs1WkVZdWV3L0NxczFUV2lTenVSbkx4QTYzbUw2K29sSDNTT0JvR2l1aGxY?=
 =?utf-8?B?aUIzUmRLNmNXT3pEYmFIdWwrQW5SdExoS3FlUklJT0xxU1dPL212ay84clVB?=
 =?utf-8?B?RGVESzZ3bmR1a3p5emNEaDI4a2VUVVdzd1Z4bW9SdE9KMU1FZDlXTjFOdml0?=
 =?utf-8?B?K1pLTXUrVkpaOWFGa2psMUt2TXRhaUw2VWc4VjhlVUtDbVhLdFZLR3pndDBr?=
 =?utf-8?B?QWl1YTM0QXRsMEpLYWRHNWtkMzZmbE14UzNZd1dOcVNBdU1sbkduNmdNb1pV?=
 =?utf-8?B?VDAxUjhVUmJKbG5JdER0ZnBsbDIzOG9oejBWMHlJSWdoaWlLTEhLQU1Zb01N?=
 =?utf-8?B?WStNWk5Xa1hBUVpmVUFneDduM2RZR1ErV1RrcEpoZnJDWm9Rc0pRdllsWE9I?=
 =?utf-8?B?V3lSL1ZBVWlJTG9hTG9yRUhQUldMTnM2cTMzd0lTZ3JYcVpOWEJJTFJLMlVG?=
 =?utf-8?B?S0VkRGl1QXk2ejR2d0NqSXhybE8xMHFiZmRUbkVpeHpVNktEVFZWQzZyTEVO?=
 =?utf-8?B?M3Jxa09pRHdqKzJiSnd0RDRhNjdXZmI0aFpQZDJPTTQyNGVqUFZ2V0oxUTdz?=
 =?utf-8?B?czFiWHRMMllOSFlybUZ3cGUvallZdTMxd3RGeFNPS3B2NnpTR3BORml0WXVS?=
 =?utf-8?B?VmtVcXdRL21aN0hSNDl2cExXQ0V2Z1JWMWwxTnJmZUMyMG1QWW1WdnJoWFMx?=
 =?utf-8?B?MmtwS09XK21wZGliNjUyT0pUd3RwRnVHOEtadXBzM0YxRXBncDBMbEppY09v?=
 =?utf-8?B?dTlYcjc0dkFEdExaLzl2M2E2R2NwRlVRSTZxRHB6ZGE2VWQzK2t5S0YvalVQ?=
 =?utf-8?B?SUExeFBkT0k2V3VkRkJyeS9Nd2pQMEdMcjFmMlNQakVoU2tDcEdRcFhLNjJ2?=
 =?utf-8?B?akVTbHZhbTRFTXppYVBrODhUL1lKNGZPMTNrRUF2OEdSampHcktVUjNPTWI4?=
 =?utf-8?B?V1VYU05DSHdEUm1jaFdzM1B1K1pUQ3R6clBQRm5TalRiZHBwTkxSd0l3cnQy?=
 =?utf-8?B?TXlLa2t4dXpoWnRKa0NtSC9NcmpYVVgxbUZFSndMcWllbGc4TWxGNm9EekVK?=
 =?utf-8?B?UGRwR0czTVk3bkFpVjNBd29kWi8wNEFBbTVsZFZNSEVPdGNXdFllZjM3VXoy?=
 =?utf-8?B?VzQyYy9aL2FET0tzRTArMjYrOFNTRlRnZVFWTkZkQ2JTcUZNcTNCakVDZE04?=
 =?utf-8?B?cU5ZU1JZN0hjUHV1S0R3RjNPR1ZUY0VSb0ZXZitOY2o2MWpnVTFNSFBLUXNw?=
 =?utf-8?B?eGV6RTRtbEVxNHZjM0FNaE1oeXpOejkwcmszMktNOTZFZjJ2cWN2MFo3eE9Q?=
 =?utf-8?B?S2M0cE9nNmx2UG5rcHRiY3ZRT3kzTGxxQXlxd0pBMFlsQmd2UllQcG5rNjhR?=
 =?utf-8?B?YTJRbVJ4NU01SEk1WjkvendQOWFXL3dVV0FhMUROaTg0cUQ1VU9OR2FjR1VM?=
 =?utf-8?B?dGFKT2VrRDI0azAzS1R0UHl6NmtmcEJvZ0VPZ3RMd21Jd2xDU1UrOG9US29L?=
 =?utf-8?B?ckVrQ1V0M2tZb1lhUTNtbCtEQkllK0Z2dG15MGVKUGVGVlpWODRpbjZ4RGlv?=
 =?utf-8?B?cnN1NGZJakdGOWVmNTlkaUF2dGZGR1g5MGVac2h3aFJ5eGFuU1FaKzlLczZV?=
 =?utf-8?B?WmNVV1VKZVZQbmoyTlBOcjRnNWJybitYVkZFdVNIc0tSYWRLMElzZkF4aUhu?=
 =?utf-8?B?bjlycmJEQmdEVlliKytLUnRzUGVJWW1uU2x3QmZIOGxTY0RKU0lKbXRLNWdK?=
 =?utf-8?B?UWdkMGhoMk5pczVENlZaT0NsL25raldNZkVkQXZZUzVtc3RCZ1hTdVE1TTFO?=
 =?utf-8?B?L1hxMlBlNENYWGVpQkNWbGpUcEtXMTdldVlPQ1VQR3RoUG55RnhSREdER05j?=
 =?utf-8?B?LzhNTW1ydzl2aUNsdmUvbGJnNVBhQmJ6bGtVbHFsRlFhd0x3Z1hvY2IzSDkw?=
 =?utf-8?Q?WO5c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c9c3ef-f2bf-4f1f-48f2-08dbe7303740
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 05:44:07.3879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cty0anTolwj4SIOiC50j26nonV3aKdcYPU1DujxsP7I4+nAEp+xVy8wT3aaSh1uk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhpbmggTmd1eWVu
IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDEw
LCAyMDIzIDg6MDcgQU0NCj4gVG86IE1laHRhLCBQaXl1c2ggPHBpeXVzaC5tZWh0YUBhbWQuY29t
Pg0KPiBDYzogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPjsNCj4gZ3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQu
Y29tPjsgbGludXgtDQo+IHVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IFBhbGFkdWd1LCBTaXZhIER1cmdhIFByYXNhZA0KPiA8c2l2YS5kdXJnYS5wcmFz
YWQucGFsYWR1Z3VAYW1kLmNvbT47IFBhbmRleSwgUmFkaGV5IFNoeWFtDQo+IDxyYWRoZXkuc2h5
YW0ucGFuZGV5QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogZHdjMzogY29y
ZTogZW5hYmxlIENDSSBzdXBwb3J0DQo+IA0KPiBPbiBNb24sIE5vdiAwNiwgMjAyMywgTWVodGEs
IFBpeXVzaCB3cm90ZToNCj4gPiBIaSBUaGluaCwNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9w
c3lzLmNvbT4NCj4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDIxLCAyMDIzIDQ6NDYgQU0N
Cj4gPiA+IFRvOiBNZWh0YSwgUGl5dXNoIDxwaXl1c2gubWVodGFAYW1kLmNvbT4NCj4gPiA+IENj
OiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgU2ltZWssIE1pY2hhbA0KPiA+ID4gPG1pY2hh
bC5zaW1la0BhbWQuY29tPjsgVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29t
PjsNCj4gPiA+IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGdpdA0KPiA+ID4gKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4gPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogZHdjMzogY29yZTogZW5hYmxlIENDSSBzdXBwb3J0DQo+
ID4gPg0KPiA+ID4gT24gRnJpLCBPY3QgMTMsIDIwMjMsIFBpeXVzaCBNZWh0YSB3cm90ZToNCj4g
PiA+ID4gVGhlIEdTQlVTQ0ZHMCByZWdpc3RlciBiaXRzIFszMToxNl0gYXJlIHVzZWQgdG8gY29u
ZmlndXJlIHRoZQ0KPiA+ID4gPiBjYWNoZSB0eXBlIHNldHRpbmdzIG9mIHRoZSBkZXNjcmlwdG9y
IGFuZCBkYXRhIHdyaXRlL3JlYWQNCj4gPiA+ID4gdHJhbnNmZXJzIChDYWNoZWFibGUsIEJ1ZmZl
cmFibGUvIFBvc3RlZCkuIFdoZW4gQ0NJIGlzIGVuYWJsZWQgaW4NCj4gPiA+ID4gdGhlIGRlc2ln
biwNCj4gPiA+ID4gRFdDMyBjb3JlIEdTQlVTQ0ZHMCBjYWNoZSBiaXRzIG11c3QgYmUgdXBkYXRl
ZCB0byBzdXBwb3J0IENDSQ0KPiA+ID4gPiBlbmFibGVkDQo+ID4gPiB0cmFuc2ZlcnMgaW4gVVNC
Lg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQaXl1c2ggTWVodGEgPHBpeXVzaC5t
ZWh0YUBhbWQuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gRFdDMyBSZWdpc3RlciBNYXAgTGlu
azoNCj4gPiA+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZG9jcy54aWxp
bnguY29tL3IvZW4tVVMvdWcxMDg3DQo+ID4gPiA+IC16eW5xLQ0KPiA+ID4gdWx0cmFzY2FsZS1y
ZWdpc3RlcnMvR1NCVVNDRkcwLVVTQjNfWEhDSS0NCj4gPiA+DQo+IFJlZ2lzdGVyX187ISFBNEYy
UjlHX3BnIWNiTGJZTGs5eHU1NERaTWtpVFF6TWhkQ2FQQTRnbUlWSW5lczRaZU5iMjgNCj4gPiA+
IEFJMnBnZXNFdkhOWXRqb1pmV3ZFX3Q3d2xVZFp2WW4tUGlvOFdqQTU1ZWthbCQNCj4gPiA+ID4g
UmVnaXN0ZXIgTmFtZQlHU0JVU0NGRzANCj4gPiA+ID4gRGVzY3JpcHRpb24JR2xvYmFsIFNvQyBC
dXMgQ29uZmlndXJhdGlvbiBSZWdpc3RlciAwDQo+ID4gPiA+DQo+ID4gPiA+IEdTQlVTQ0ZHMCAo
VVNCM19YSENJKSBSZWdpc3RlciBCaXQtRmllbGQ6DQo+ID4gPiA+IERBVFJEUkVRSU5GTwkzMToy
OA0KPiA+ID4gPiBERVNSRFJFUUlORk8JMjc6MjQNCj4gPiA+ID4gREFUV1JSRVFJTkZPCTIzOjIw
DQo+ID4gPiA+IERFU1dSUkVRSU5GTwkxOToxNg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZl
cnMvdXNiL2R3YzMvY29yZS5jIHwgMTcgKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmggfCAgNSArKysrKw0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAy
MiBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+IGluZGV4IDlj
NmJmMDU0ZjE1ZC4uZmM2ODkyYzYzYWJmIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+
ID4gPiBAQCAtMjMsNiArMjMsNyBAQA0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+
DQo+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4NCj4gPiA+ID4gICNpbmNs
dWRlIDxsaW51eC9vZi5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4N
Cj4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9ncmFwaC5oPg0KPiA+ID4gPiAgI2luY2x1ZGUg
PGxpbnV4L2FjcGkuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2NvbnN1bWVy
Lmg+IEBAIC01NTksNiArNTYwLDIwIEBAIHN0YXRpYw0KPiA+ID4gPiB2b2lkIGR3YzNfY2FjaGVf
aHdwYXJhbXMoc3RydWN0IGR3YzMNCj4gPiA+ICpkd2MpDQo+ID4gPiA+ICAJCXBhcm1zLT5od3Bh
cmFtczkgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywNCj4gPiA+IERXQzNfR0hXUEFSQU1TOSk7ICB9
DQo+ID4gPiA+DQo+ID4gPiA+ICtzdGF0aWMgdm9pZCBkd2MzX2NvbmZpZ19zb2NfYnVzKHN0cnVj
dCBkd2MzICpkd2MpIHsNCj4gPiA+ID4gKwlpZiAob2ZfZG1hX2lzX2NvaGVyZW50KGR3Yy0+ZGV2
LT5vZl9ub2RlKSkgew0KPiA+ID4gPiArCQl1MzIgcmVnOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJ
CXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dTQlVTQ0ZHMCk7DQo+ID4gPiA+ICsJ
CXJlZyB8PSBEV0MzX0dTQlVTQ0ZHMF9EQVRSRFJFUUlORk9fTUFTSyB8DQo+ID4gPiA+ICsJCQlE
V0MzX0dTQlVTQ0ZHMF9ERVNSRFJFUUlORk9fTUFTSyB8DQo+ID4gPiA+ICsJCQlEV0MzX0dTQlVT
Q0ZHMF9EQVRXUlJFUUlORk9fTUFTSyB8DQo+ID4gPiA+ICsJCQlEV0MzX0dTQlVTQ0ZHMF9ERVNX
UlJFUUlORk9fTUFTSzsNCj4gPiA+ID4gKwkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dT
QlVTQ0ZHMCwgcmVnKTsNCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+
DQo+ID4gPiBZb3UncmUgb3ZlcndyaXRpbmcgZGVmYXVsdCB2YWx1ZXMgZm9yIGFsbCBwbGF0Zm9y
bXMuIERvbid0IGRvIHRoYXQuDQo+ID4gPiBOb3QgZXZlcnkgcGxhdGZvcm0gc3VwcG9ydHMgdGhp
cyBzZXR0aW5nLiBPbmx5IGFwcGx5IHRoZXNlIHNwZWNpZmljDQo+ID4gPiBzZXR0aW5ncyB0byB5
b3VyIHBsYXRmb3JtLg0KPiA+DQo+ID4gVGhpcyBEV0MzX0dTQlVTQ0ZHMCByZWdpc3RlciBpcyBw
YXJ0IG9mIHRoZSBEV0MzL0NvcmUgc3lzdGVtLiBJbg0KPiA+IGdsdWUvdmVuZG9yIGRyaXZlcnMs
IEkgY291bGRuJ3QgZmluZCBhIHdheSB0byBhY2Nlc3MgdGhlIERXQzMvQ29yZQ0KPiA+IGFjY2Vz
cyByZWdpc3Rlci4gIENvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBhIHN1Z2dlc3Rpb24gZm9yIHRo
ZSBYaWxpbnggZ2x1ZQ0KPiBkcml2ZXIgKGR3YzMvZHdjMy14aWxpbnguYykgdG8gYWNjZXNzIGR3
YzMgcmVnaXN0ZXJzPw0KPiANCj4gV2UgbWF5IG5lZWQgdG8gcGFzcyB0aGUgaGFyZHdhcmUgY29u
ZmlndXJhdGlvbiBmcm9tIHRoZSBkdCBiaW5kaW5nLg0KDQpEV0MzX0dTQlVTQ0ZHMCByZWdpc3Rl
ciBpcyBpbXBsZW1lbnRhdGlvbiBkZWZpbmVkIGFuZCBwYXJ0IG9mIERXQzMvQ29yZSAoRGF0YWJv
b2sgMi45MCkuIEJlbG93IGlzIGV4YW1wbGUgY29kZQ0KdG8gbWFrZSB0aGlzIGxvZ2ljIHBsYXRm
b3JtIHNwZWNpZmljLiBJdCBjb25kaXRpb25hbGx5IHZhbGlkYXRlcyB0aGUgZG1hLWNvaGVyZW50
IHByb3BlcnR5IGFuZCBvbmx5IHBlcmZvcm1zDQpEV0MzX0dTQlVTQ0ZHMCBjb25maWd1cmF0aW9u
IGZvciBBTUQvWGlsaW54IHBsYXRmb3JtLiAoRFQgY29tcGF0aWJsZSAieGxueCx6eW5xbXAtZHdj
MyIpLg0KDQpFeGFtcGxlIENvZGU6DQogICAgICAgaWYgKG9mX2RtYV9pc19jb2hlcmVudChkd2Mt
PmRldi0+b2Zfbm9kZSkgJiYgb2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUoZHdjLT5kZXYtPnBhcmVu
dC0+b2Zfbm9kZSwgInhsbngsenlucW1wLWR3YzMiKSkgew0KICAgICAgICAgICAgICAgdTMyIHJl
ZzsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgIHJlZyA9IGR3YzNfcmVhZGwo
ZHdjLT5yZWdzLCBEV0MzX0dTQlVTQ0ZHMCk7ICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAg
ICAgICAgcmVnIHw9IERXQzNfR1NCVVNDRkcwX0RBVFJEUkVRSU5GTyB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgRFdDM19HU0JVU0NGRzBfREVTUkRS
RVFJTkZPIHwgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAg
ICBEV0MzX0dTQlVTQ0ZHMF9EQVRXUlJFUUlORk8gfCAgICAgICAgICAgICAgICAgICAgICAgICAg
IA0KICAgICAgICAgICAgICAgICAgICAgIERXQzNfR1NCVVNDRkcwX0RFU1dSUkVRSU5GTzsgICAg
ICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgIGR3YzNfd3JpdGVsKGR3Yy0+
cmVncywgRFdDM19HU0JVU0NGRzAsIHJlZyk7ICAgICAgICAgICAgICAgICAgIA0KICAgICAgIH0N
Cj4gDQo+IFRoYW5rcywNCj4gVGhpbmgNCg==
