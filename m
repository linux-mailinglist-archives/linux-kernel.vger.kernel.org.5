Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D17D1648
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjJTT2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTT2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:28:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E3D51;
        Fri, 20 Oct 2023 12:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhqgJluYZoPgfTVr1WLYzUaoISPiU27rXQj3+JF1mrtKPW2m89bolaa0VofsG/nI6sYJuo+gYWmNyE5UK2oXWTpc65I3j5SNHRwKCtNPM4Be4eU7L8jtPkPd3XAb6WPCNS7rVFDoJ3mFR61O03L7bYJ+QScTCpSTD3cw2ZxCUv8gHIuFy3Fx42qHXUXtxhhmjUVJW8jyH+0i49wA4L89PkOB1O5/5N03+sOVGMZo97OLYISxqfrp2WaKvvKyQx63ZQsPznhDpTK99c2wcxPxzwQpoL8kokOyWHSt//LU6K/h/wlvwWa3f+v/BLS6IApDT9OTDhDbsHJ8NyO38an79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wixmv7xyttF4farIsDBkxECBp0B3ZIt+7LWDR1DrqPA=;
 b=ft8akngGYfZvzNduvDur8qnHum6Xo8Yiu8QEdhOPj47+/EIHyhFhmcsuncuE0zw5M9E5RcbcYckVaS0ioCYyKLucUmDw5YoBPn6h/FTGSg/hkUkrIp6oNH11n906yc/grqLDU5NeNGuJlZnBFoXxZUrvzrC5qrJv87eUbUxvgE+p2CC3ASqjVvfcVGJ6HJyCNYEK8mLYFJuANrC4RtNZfVptMVi7fNF2UbwXkEH6oTkSMwRfV6L0CaC7fGYGglO8TnEs6lh3Uk0zeb+1EkugDaBC+3PhOYZcKoGPKJHjyhZzqY4UzceMQjLBryVI7mfLKmhMB1tVuc6P/7qIUAzagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wixmv7xyttF4farIsDBkxECBp0B3ZIt+7LWDR1DrqPA=;
 b=zSEjt+746kTZZ+Jz9xl8nDqu7MoO1mlMnkQG5jYOJxlpK19aNdI4kmkzu/HZ+e/agQbvoAvlL7rgIIa/feKMGato4CYRNVWuxpPfnPMr9BGT4vLvnItFqZ8G2jk4vJHAP4pryNktuioV7r1U2rIm5n0mdfourqwymX37X/juAQM=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 19:27:51 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 19:27:51 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH net-next v8 3/3] net: axienet: Introduce dmaengine support
Thread-Topic: [PATCH net-next v8 3/3] net: axienet: Introduce dmaengine
 support
Thread-Index: AQHaAS7I0vYcCePutECs/5L9pgQeH7BQ4SSAgAIeKBA=
Date:   Fri, 20 Oct 2023 19:27:50 +0000
Message-ID: <MN0PR12MB59539D0012AF7F36BCB93AD1B7DBA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1697570274-798170-1-git-send-email-radhey.shyam.pandey@amd.com>
         <1697570274-798170-4-git-send-email-radhey.shyam.pandey@amd.com>
 <582ccc0600aea90e32e4c6416d40d0a8047f9eae.camel@redhat.com>
In-Reply-To: <582ccc0600aea90e32e4c6416d40d0a8047f9eae.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH7PR12MB7892:EE_
x-ms-office365-filtering-correlation-id: 4d862023-5561-4a5f-a29b-08dbd1a2a66e
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AMr4xsmx+VgPavr52ee64P76xAo6Dl97BcfystKJZA6oDZHjJS2ZQ40Iobrt/7j1jWfWNaT8aCFrFM8okLFZr3s6qajABONVgNyzUpJ4uaZzm/t1TWbX6mBge8jGExPZrt/Uzc7xBZXzVmVzaReXI3woNyWygmwmscT4b5ZSIG1Jm4alXJwOB4JL2te57uJUqGZUPLk8QR2+xW4EXhs8MVZzdv1jiP6+bNd48DkROFiiE6f2E4iaRuU7hTmU/JVC94u1JTwkwicMco6UeiRKUKp8eRE2H7TkbrNKqvvvhyTWy2R+BnGKLVt5GawEElN6iKQ6ej6vWeRSJSN9DsG098Tt3IUmzOP8plXMlB8yL9Uq+QjRMEc8/d06L77YETcgIlQMHLiiE1P6WJP5F/OctMGCOoQJdptkodAwCQwyJqPZSqtKK0elbAgD6vGaIhrlpp+SY8sOmLD3S2ZqdsPV08gy+FqwMbeOSzqLJC5gZNTHfz5dz2V4ofCbZLhlurr0nVaqaGCY7GRfNJwA3Us5kUcc+WIGsMUIOcFoxox94v8rtXQ7PiUO7mzvYi7zZlV4LV0kLFkcqpQFXGvjS6oXE8PxalSqLpUheRfvmoH7IW6JjorclTVTiTu3U+N/kD+JSI+O7O51cWaXOWHAWEpzlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(38070700009)(921008)(7416002)(2906002)(55016003)(52536014)(38100700002)(6506007)(41300700001)(5660300002)(7696005)(4326008)(9686003)(83380400001)(122000001)(86362001)(71200400001)(478600001)(8676002)(33656002)(8936002)(316002)(66946007)(76116006)(66476007)(66556008)(66446008)(64756008)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YURHRml2RXRnRllqMkl6SkNRTjh5ays1bk10UlI1SEhXY0ZySktYSzB6SFhq?=
 =?utf-8?B?ZTF4SHU5TjVYS29YNFh2d2hLNFVDWkRoSFh1N2FiWFY2R0pXMGJlWGlzU2Ez?=
 =?utf-8?B?MnZFeWRmd1FqVHl6WGNUejh3c1o2K3pzYzJCTzVhVEhhd01pUTBPRGNnams1?=
 =?utf-8?B?SGZoVEFRZHAxMUkydVRxa1Y1UUZlMUg2YmlZbUQyN3BmY1pKb1BrMWlCS2Zm?=
 =?utf-8?B?RkFTNmtnVEVmY3NzdTRWWFFVdk5palcrZTB6aytCd3ZFVmZDWFNHZjJaMXRa?=
 =?utf-8?B?b2RBQmxGa2xCL1dtMGVzeTlBQmVLdTB5ZCtSUFBlUzg3OVNzaENsK0VqZG5w?=
 =?utf-8?B?QXFHNlZyZzUwaktDd1ZHVGVERUhmcXh4UE1LZFVaOTlZTlRiUTcvSDBsREJV?=
 =?utf-8?B?MUNjU0RSaGRKT2JzbzF6UW1YblRPNEVCUGhybTJwR01ud0xTc1BNeEE2c3BX?=
 =?utf-8?B?Yi9XajNuNFpyYUhEdDdzUVVOVnpPS3JGemtjQ0VJMGpYNmRzYTdlcEJ2Vk1q?=
 =?utf-8?B?NjI5S0JtblBYd2tNaXY0d0piKytDbXhhRmFRZ050anl2aWZCTmpQTk0zamVk?=
 =?utf-8?B?bEdxYUcvUUhOZmlqc21mVjljMDhEdEFhT0gxdms4Z1pjUEpDUXZhbmpjM1ZC?=
 =?utf-8?B?OG5TcGFYeHFzSTk5bmNNeEVxVHY4aWhVY1Fqci9SZTMvK0tEQ25hNzhPNlIw?=
 =?utf-8?B?OEZrNXUvTkFlSjV6S2hEUnQ5Rm9mMjdPSmtvYUpNR1o2RkRCdmZTSDJRODVh?=
 =?utf-8?B?L0Zra1pTS0ZWaWVFN21YWG1EVUkyMnM3SFZHRTV2VWdmbzhDclNaVVQrZllx?=
 =?utf-8?B?aEJUS21DMVJDRXFoSG5SMkxrUko5NFhzRkF0cmhhL0xKL0trNDRDamJWTFVX?=
 =?utf-8?B?eEVWQVRJamZiVGZBcG4rTVdCdFpQWno1QWFINzRRNTNMU2hJRFlnZTl4cHFX?=
 =?utf-8?B?WGJlTy8rSk5GTVRtcHpONUlJWEVoZG5aeVJTcDhORjNjUUgrTGZndDYwZy9M?=
 =?utf-8?B?K1NITWMrU3cvQXVnWUc4UXExMFBDMXFTWmNMU29oenprZ0xBTUhJcm90c0Yx?=
 =?utf-8?B?a0gxTUY3dmZaUjZIdm5ab1lKaDNjUDZrckJSUjFocU1hR1dnV3BqVWN6QTVX?=
 =?utf-8?B?RzViMlhNRFgwVjlWVnNHVFdXendwc3pMWml3WGNUMUVKOE9KWnRnZnM3Qnlt?=
 =?utf-8?B?cVBVT1dzR0c0V1B0aDZyVXJIdFBVMlNtaWRDY3JUbTZsZUljNnJJcXBxWFRq?=
 =?utf-8?B?aVZZN1JTTFBLa0VBWEFMWWFnL05LQ052bGZrWVdDYVhHa0NmZW9QNlNOUUpX?=
 =?utf-8?B?RnNRUDRkaS9HekNlSFpOQkJNQ2RVYjVlNCtpeGVDc1UzZFpFTkNCaVFlc0xP?=
 =?utf-8?B?MUJHNG1JbGxieWxCSml6WWVqemRtMUY3MzJVUkpNWDQxbDMzZFdVMFF3Z3cz?=
 =?utf-8?B?eFdZb2ozdWlNeGhnNzRUK2wySUpnSWVvR2J1Y01zYW5pZ2kveitVZ21rMWwv?=
 =?utf-8?B?R01uZndlWDdBT2YzRnBtbEpUYXVvYjFKZWRKNTFSSi8xdG8vbStRWWVlb213?=
 =?utf-8?B?aFZyZWkxYXVReHF4Y2dITlozYWVsQ1dUNVN5bTgxTWhkTTJycmJpTmh5WE9t?=
 =?utf-8?B?K0ZQR1o1ei9JeEpzNnduQ3FkeU5PaENpN2JiRlBpTDRkUlMydVRXZnd0RVpi?=
 =?utf-8?B?TC9MVElISmRCeFVBWHo0bmU2V1pkWjFFUHBRcnVJRkxzc1hvbUQ3VXR3ZUFi?=
 =?utf-8?B?WlFKeTMxN2FLQWZBUnFFb2x6bGNwUnh1MlYrbzd3MXZ0T1dveFhkYzhkaFJF?=
 =?utf-8?B?ZDNUSWlUdlBxcWdqV01TenZ5MlllME1DV3p0a2R4WUtnOEtwcWNtNm9UUnRL?=
 =?utf-8?B?RDNHR29zRmVXbndtM0ljRFFJZXhNSEtENEFXbURlOFlHV2dkekIyOUl6SmNw?=
 =?utf-8?B?UjRUL2pzUFNPeUh4ZEthdUN4d2FRM2FKQ0JORE5DTW5FMFZJVlIvMnROR0Zh?=
 =?utf-8?B?WEpTMFRoZEJqOW05R2Vad0FmbHRsclFjM1R2d3crU1huU3UvaDhBaHc4bHRN?=
 =?utf-8?B?UEt5WVFMNmpwT29QMkd2RXM4Wk4zSmRnVGppbVR6UFRhTkc4N2ZIbzlyaDZO?=
 =?utf-8?B?QkxNdWNqUWtRMG5IMnhrcGRsZEhtQmdFVGhtUzZtRGMybytrbkU3d1UvWjc2?=
 =?utf-8?Q?ARiqVLxRSDjjX1KUHXxRtDc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d862023-5561-4a5f-a29b-08dbd1a2a66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 19:27:50.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Crscqs4yq+t9B3PLyO3A7xyMzh8rFCP0aTgdNWsdetcmB7louGhEuUpjfzQhiGeD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHNuaXA+DQo+IE1pbm9yIG5pdDogcGxlYXNlIHVzZSB0aGUgcmV2ZXJzZSB4LW1hcyB0cmVlIG9y
ZGVyDQoNClN1cmUsIHdpbGwgZml4IGl0IGluIG5leHQgdmVyc2lvbi4NCg0KPHNuaXA+DQo+IFlv
dSBjYW4gYXZvaWQgc29tZSBkdXBsaWNhdGUgY29kZSB3aXRoOg0KPiAJCWdvdG8gZHJvcF9za2I7
DQo+IA0KPiBhbmQgYWRkaW5nIGF0IHRoZSBib3R0b20gb2YgdGhpcyBmdW5jdGlvbjoNCj4gDQo+
IGRyb3Bfc2tiOg0KPiAJZGV2X2tmcmVlX3NrYl9hbnkoc2tiKTsNCj4gCXJldHVybiBORVRERVZf
VFhfT0s7DQo+IA0KDQpBZ3JlZSAsIHdpbGwgc3dpdGNoIHRvIGl0IGluIG5leHQgdmVyc2lvbi4N
Cg0KPHNuaXA+DQoNCj4gWW91IGZvcmdvdCB0byBhZGQgdGhlIG5ldGlmX3R4cV9tYXliZV9zdG9w
KCkgY2FsbCwgYXMgc3VnZ2VzdGVkIGJ5IEpha3ViIGluDQo+IHRoZSBwcmV2aW91cyByZXZpc2lv
bi4NCg0KSSB3YXMgaW4gYW4gaW1wcmVzc2lvbiB0aGF0IHRoZXNlIGFyZSBtdWx0aSBxdWV1ZSBz
cGVjaWZpYyBBUElzLCBzbyBJIHNraXBwZWQgdGhlbS4NCkJ1dCByZXZpc2l0ZWQgdGhlIGltcGxl
bWVudGF0aW9uIGFuZCBpdCBzZWVtcyBjbGVhciBub3csIGFuZCBtb2RpZmllZCB0aGUgZHJpdmVy
IA0KdG8gdXNlIHRoZXNlIGxvY2tsZXNzIHF1ZXVlIHN0b3BwaW5nIC8gd2FraW5nIGhlbHBlcnMu
DQoNCisgICAgICAgdGF4ID0gc2tiX2dldF90eF9xdWV1ZShscC0+bmRldiwgc2tiKTsNCisgICAg
ICAgbmV0ZGV2X3R4X3NlbnRfcXVldWUodHhxLCBza2ItPmxlbik7DQorICAgICAgIG5ldGlmX3R4
cV9tYXliZV9zdG9wKHR4cSwgQ0lSQ19TUEFDRShscC0+dHhfcmluZ19oZWFkLCBscC0+dHhfcmlu
Z190YWlsLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBUWF9CRF9OVU1fTUFYKSwgTUFY
X1NLQl9GUkFHUyArIDEsIDIgKiBNQVhfU0tCX0ZSQUdTKTsNCg0KDQpIb3dldmVyLCBpbiBuZXRw
ZXJmIGJlbmNobWFyayAoVENQIFRYKSBJIGFtIHNlZWluZyBhIGRpcCBpbiBwZXJmb3JtYW5jZQ0K
KH4zNS00ME1icHMpIHdoZW4gc3dpdGNoaW5nIHRvIHRoZXNlIHN0b3Avd2FrZSBoZWxwZXJzLiBJ
cyBpdCBleHBlY3RlZA0KY29uc2lkZXJpbmcgZXh0cmEgbG9naWMgaW4gbWFpbnRhaW5pbmcgZHlu
YW1pYyBxdWV1ZSBhbmQgdGhlc2UgaGVscGVycz8NCg0KQWxzbywgaW4gdGhyb3VnaHB1dCBiZW5j
aG1hcmtpbmcgdGhlcmUgd2FzIG5vIG9jY3VycmVuY2Ugd2hlbiB0aGUgDQpxdWV1ZSB3YXMgc3Rv
cHBlZC93b2tlbiB1cC4NCg0KDQpUaHJvdWdocHV0OiAoMTBeNmJpdHMvc2VjKQ0KOTE1LjU1ICh2
OCAtIHdpdGhvdXQgdXNpbmcgbG9ja2xlc3MgcXVldWUgc3RvcC93YWtlIGhlbHBlcnMpDQoNCj09
PT09PQ0KU3dpdGNoIHRvIGxvY2tsZXNzIHF1ZXVlIHN0b3Avd2FrZSBoZWxwZXJzDQoNCiMgbmV0
cGVyZiAtSCAxOTIuMTY4LjEwLjIwIC10IFRDUF9TVFJFQU0NCk1JR1JBVEVEIFRDUCBTVFJFQU0g
VEVTVCBmcm9tIDAuMC4wLjAgKDAuMC4wLjApIHBvcnQgMCBBRl9JTkVUIHRvIDE5Mi4xNjguMTAu
MjAgKCkgcG9ydCAwIEFGX0lORVQNClJlY3YgICBTZW5kICAgIFNlbmQgICAgICAgICAgICAgICAg
ICAgICAgICAgIA0KU29ja2V0IFNvY2tldCAgTWVzc2FnZSAgRWxhcHNlZCAgICAgICAgICAgICAg
DQpTaXplICAgU2l6ZSAgICBTaXplICAgICBUaW1lICAgICBUaHJvdWdocHV0ICANCmJ5dGVzICBi
eXRlcyAgIGJ5dGVzICAgIHNlY3MuICAgIDEwXjZiaXRzL3NlYyAgDQoNCjEzMTA3MiAgMTYzODQg
IDE2Mzg0ICAgIDEwLjAyICAgICA4NzYuOTQNCg0KDQo+IA0KPiA+ICsNCj4gPiArCXNrYnVmX2Rt
YS0+c2tiID0gc2tiOw0KPiA+ICsJc2tidWZfZG1hLT5zZ19sZW4gPSBzZ19sZW47DQo+ID4gKwlk
bWFfdHhfZGVzYy0+Y2FsbGJhY2tfcGFyYW0gPSBscDsNCj4gPiArCWRtYV90eF9kZXNjLT5jYWxs
YmFja19yZXN1bHQgPSBheGllbmV0X2RtYV90eF9jYjsNCj4gPiArCWRtYWVuZ2luZV9zdWJtaXQo
ZG1hX3R4X2Rlc2MpOw0KPiA+ICsJZG1hX2FzeW5jX2lzc3VlX3BlbmRpbmcobHAtPnR4X2NoYW4p
Ow0KPiA+ICsNCj4gPiArCXJldHVybiBORVRERVZfVFhfT0s7DQo+ID4gKw0KPiA+ICt4bWl0X2Vy
cm9yX3VubWFwX3NnOg0KPiA+ICsJZG1hX3VubWFwX3NnKGxwLT5kZXYsIHNrYnVmX2RtYS0+c2ds
LCBzZ19sZW4sIERNQV9UT19ERVZJQ0UpOw0KPiANCj4gSWYgeW91IG5lZWQgdG8gZHJvcCB0aGUg
c2tiIChhcyBJIHN1c3BlY3QpLCB5b3UgY2FuIHJldXNlIHRoZSBkcm9wX3NrYiBsYWJlbA0KPiBo
ZXJlOg0KPiANCj4gZHJvcF9za2I6DQo+IAlkZXZfa2ZyZWVfc2tiX2FueShza2IpOw0KPiA+ICsJ
cmV0dXJuIE5FVERFVl9UWF9PSzsNCg0KWWVzICwgd2lsbCBtYWtlIHRoaXMgY2hhbmdlIGFuZCB0
aGlzIHdpbGwgYWxzbyBmaXggc2tiIGxlYWsuDQoNCj4gPiArfQ0KPiA+ICsNCj4gPiAgLyoqDQo+
ID4gICAqIGF4aWVuZXRfdHhfcG9sbCAtIEludm9rZWQgb25jZSBhIHRyYW5zbWl0IGlzIGNvbXBs
ZXRlZCBieSB0aGUNCj4gPiAgICogQXhpIERNQSBUeCBjaGFubmVsLg0KPiA+IEBAIC04OTMsNiAr
MTAyOCw0MiBAQCBheGllbmV0X3N0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0
DQo+IG5ldF9kZXZpY2UgKm5kZXYpDQo+ID4gIAlyZXR1cm4gTkVUREVWX1RYX09LOw0KPiA+ICB9
DQo+ID4NCj4gPiArLyoqDQo+ID4gKyAqIGF4aWVuZXRfZG1hX3J4X2NiIC0gRE1BIGVuZ2luZSBj
YWxsYmFjayBmb3IgUlggY2hhbm5lbC4NCj4gPiArICogQGRhdGE6ICAgICAgIFBvaW50ZXIgdG8g
dGhlIHNrYnVmX2RtYV9kZXNjcmlwdG9yIHN0cnVjdHVyZS4NCj4gPiArICogQHJlc3VsdDogICAg
IGVycm9yIHJlcG9ydGluZyB0aHJvdWdoIGRtYWVuZ2luZV9yZXN1bHQuDQo+ID4gKyAqIFRoaXMg
ZnVuY3Rpb24gaXMgY2FsbGVkIGJ5IGRtYWVuZ2luZSBkcml2ZXIgZm9yIFJYIGNoYW5uZWwgdG8N
Cj4gPiArbm90aWZ5DQo+ID4gKyAqIHRoYXQgdGhlIHBhY2tldCBpcyByZWNlaXZlZC4NCj4gPiAr
ICovDQo+ID4gK3N0YXRpYyB2b2lkIGF4aWVuZXRfZG1hX3J4X2NiKHZvaWQgKmRhdGEsIGNvbnN0
IHN0cnVjdA0KPiA+ICtkbWFlbmdpbmVfcmVzdWx0ICpyZXN1bHQpIHsNCj4gPiArCXN0cnVjdCBh
eGllbmV0X2xvY2FsICpscCA9IGRhdGE7DQo+ID4gKwlzdHJ1Y3Qgc2tidWZfZG1hX2Rlc2NyaXB0
b3IgKnNrYnVmX2RtYTsNCj4gPiArCXNpemVfdCBtZXRhX2xlbiwgbWV0YV9tYXhfbGVuLCByeF9s
ZW47DQo+ID4gKwlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOw0KPiA+ICsJdTMyICphcHBfbWV0YWRhdGE7
DQo+IA0KPiBNaW5vciBuaXQ6IHBsZWFzZSByZXNwZWN0IHRoZSByZXZlcnNlIHgtbWFzIHRyZWUg
b3JkZXINCg0KWWVzLCB3aWxsIGZpeCBpdCBpbiBuZXh0IHZlcnNpb24uDQoNCj4gDQo+ID4gKw0K
PiA+ICsJc2tidWZfZG1hID0gYXhpZW5ldF9nZXRfcnhfZGVzYyhscCwgbHAtPnJ4X3JpbmdfdGFp
bCsrKTsNCj4gPiArCXNrYiA9IHNrYnVmX2RtYS0+c2tiOw0KPiA+ICsJYXBwX21ldGFkYXRhID0g
ZG1hZW5naW5lX2Rlc2NfZ2V0X21ldGFkYXRhX3B0cihza2J1Zl9kbWEtDQo+ID5kZXNjLCAmbWV0
YV9sZW4sDQo+ID4gKwkJCQkJCSAgICAgICAmbWV0YV9tYXhfbGVuKTsNCj4gPiArCWRtYV91bm1h
cF9zaW5nbGUobHAtPmRldiwgc2tidWZfZG1hLT5kbWFfYWRkcmVzcywgbHAtDQo+ID5tYXhfZnJt
X3NpemUsDQo+ID4gKwkJCSBETUFfRlJPTV9ERVZJQ0UpOw0KPiA+ICsJLyogVE9ETzogRGVyaXZl
IGFwcCB3b3JkIGluZGV4IHByb2dyYW1tYXRpY2FsbHkgKi8NCj4gPiArCXJ4X2xlbiA9IChhcHBf
bWV0YWRhdGFbTEVOX0FQUF0gJiAweEZGRkYpOw0KPiA+ICsJc2tiX3B1dChza2IsIHJ4X2xlbik7
DQo+ID4gKwlza2ItPnByb3RvY29sID0gZXRoX3R5cGVfdHJhbnMoc2tiLCBscC0+bmRldik7DQo+
ID4gKwlza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VNX05PTkU7DQo+ID4gKw0KPiA+ICsJX19uZXRp
Zl9yeChza2IpOw0KPiANCj4gSXQncyBhIHBpdHkgeW91IGNhbid0IGxldmVyYWdlIE5BUEkgaGVy
ZS4NCj4gDQo+IEkgdGhpbmsgdGhhdCBjb3VsZCBiZSBkb2FibGUgYXMgYSBmb2xsb3ctdXAsIGJ1
dCBJJ20gdW5zdXJlIGlmIHRoYXQgd291bGQgZml0DQo+IHRoZSBETUEgZW5naW5lIG1vZGVsOiBp
biB0aGlzIGNhbGxiYWNrIHlvdSBjb3VsZCBjYWNoZSB0aGUgcmVhZHkgZG1hIGluZGV4DQo+IChh
IHNpbmdsZSByYW5nZSBzaG91bGQgc3VmZmljZSkgYW5kIHNjaGVkdWxlIHRoZSBuYXBpIGluc3Rh
bmNlLiBUaGUgYWN0dWFsDQo+IGRtYSBwcm9jZXNzaW5nIHdpbGwgYmUgZG9uZSBpbiBuYXBpIHBv
bGwuDQo+IA0KPiBBbm90aGVyIHBvc3NpYmxlIGZvbGxvdy11cCBjb3VsZCBiZSBpbnRyb2R1Y2lu
ZyBhICJidWxrIiBSWCBjYWxsYmFjayBpbiB0aGUNCj4gRE1BIGVuZ2luZSwgdG8gbWl0aWdhdGUg
dGhlIGluZGlyZWN0IGNhbGwgb3ZlcmhlYWQgb24gYSBidXJzdCBvZiBSWCBETUENCj4gY29tcGxl
dGlvbiAtIGFzc3VtaW5nIHRoZSBETUEgZW5naW5lIGFjdHVhbGx5IGdlbmVyYXRlcyBzdWNoIGJ1
cnN0Lg0KDQpBZ3JlZSAsIHRoZXNlIGFyZSBwb3NzaWJsZSB0aG91Z2h0cyBhbmQgd2lsbCBzdGFy
dCB3b3JraW5nIG9uIGl0IG9uY2UgDQp0aGlzIGJhc2VsaW5lIGRtYWVuZ2luZSBzdXBwb3J0IHNl
cmllcyBpcyBkb25lLiAgDQo+IA0KPiA+ICsJdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbigmbHAtPnJ4
X3N0YXRfc3luYyk7DQo+ID4gKwl1NjRfc3RhdHNfYWRkKCZscC0+cnhfcGFja2V0cywgMSk7DQo+
ID4gKwl1NjRfc3RhdHNfYWRkKCZscC0+cnhfYnl0ZXMsIHJ4X2xlbik7DQo+ID4gKwl1NjRfc3Rh
dHNfdXBkYXRlX2VuZCgmbHAtPnJ4X3N0YXRfc3luYyk7DQo+ID4gKwlheGllbmV0X3J4X3N1Ym1p
dF9kZXNjKGxwLT5uZGV2KTsNCj4gPiArCWRtYV9hc3luY19pc3N1ZV9wZW5kaW5nKGxwLT5yeF9j
aGFuKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIGF4aWVuZXRfcnhfcG9sbCAt
IFRyaWdnZXJlZCBieSBSWCBJU1IgdG8gY29tcGxldGUgdGhlIEJEIHByb2Nlc3NpbmcuDQo+ID4g
ICAqIEBuYXBpOglQb2ludGVyIHRvIE5BUEkgc3RydWN0dXJlLg0KPiA+IEBAIC0xMTI2LDYgKzEy
OTcsMTUwIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBheGllbmV0X2V0aF9pcnEoaW50IGlycSwNCj4g
PiB2b2lkICpfbmRldikNCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBheGllbmV0X2RtYV9lcnJfaGFu
ZGxlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspOw0KPiA+DQo+ID4gKy8qKg0KPiA+ICsgKiBh
eGllbmV0X3J4X3N1Ym1pdF9kZXNjIC0gU3VibWl0IHRoZSByeCBkZXNjcmlwdG9ycyB0byBkbWFl
bmdpbmUuDQo+ID4gKyAqIGFsbG9jYXRlIHNrYnVmZiwgbWFwIHRoZSBzY2F0dGVybGlzdCBhbmQg
b2J0YWluIGEgZGVzY3JpcHRvcg0KPiA+ICsgKiBhbmQgdGhlbiBhZGQgdGhlIGNhbGxiYWNrIGlu
Zm9ybWF0aW9uIGFuZCBzdWJtaXQgZGVzY3JpcHRvci4NCj4gPiArICoNCj4gPiArICogQG5kZXY6
CW5ldF9kZXZpY2UgcG9pbnRlcg0KPiA+ICsgKg0KPiA+ICsgKlJldHVybjogMCwgb24gc3VjY2Vz
cy4NCj4gPiArICogICAgICAgICAgbm9uLXplcm8gZXJyb3IgdmFsdWUgb24gZmFpbHVyZQ0KPiA+
ICsgKi8NCj4gPiArc3RhdGljIGludCBheGllbmV0X3J4X3N1Ym1pdF9kZXNjKHN0cnVjdCBuZXRf
ZGV2aWNlICpuZGV2KSB7DQo+ID4gKwlzdHJ1Y3QgZG1hX2FzeW5jX3R4X2Rlc2NyaXB0b3IgKmRt
YV9yeF9kZXNjID0gTlVMTDsNCj4gPiArCXN0cnVjdCBheGllbmV0X2xvY2FsICpscCA9IG5ldGRl
dl9wcml2KG5kZXYpOw0KPiA+ICsJc3RydWN0IHNrYnVmX2RtYV9kZXNjcmlwdG9yICpza2J1Zl9k
bWE7DQo+ID4gKwlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOw0KPiA+ICsJZG1hX2FkZHJfdCBhZGRyOw0K
PiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlza2J1Zl9kbWEgPSBheGllbmV0X2dldF9yeF9k
ZXNjKGxwLCBscC0+cnhfcmluZ19oZWFkKTsNCj4gPiArCWlmICghc2tidWZfZG1hKQ0KPiA+ICsJ
CXJldHVybiAtRU5PTUVNOw0KPiANCj4gTWlub3Igbml0OiBoZXJlIGEgbmV3bGluZSB3b3VsZCBt
YWtlIHRoZSBjb3JlIG1vcmUgcmVhZGFibGUNCg0KQWNjZXB0ZWQgLCB3aWxsIGFkZCBpbiBuZXh0
IHZlcnNpb24uDQoNCj4gDQo+ID4gKwlscC0+cnhfcmluZ19oZWFkKys7DQo+ID4gKwlza2IgPSBu
ZXRkZXZfYWxsb2Nfc2tiKG5kZXYsIGxwLT5tYXhfZnJtX3NpemUpOw0KPiA+ICsJaWYgKCFza2Ip
DQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+IA0KPiBBbm90aGVyIHBvc3NpYmxlIGZvbGxvdy11
cDogdXN1YWxseSB0aGUgc2tiIGhlYWRlciBpcyBhbGxvY2F0ZWQganVzdCBiZWZvcmUNCj4gc2Vu
ZGluZyBpdCB0byB0aGUgbmV0d29yayBzdGFjayAoZS5nLiBqdXN0IGJlZm9yZSB0aGUNCj4gX19u
ZXRpZl9yeCgpIGNhbGwpIHRvIGJlIGNhY2hlIGZyaWVuZGx5LiBIZXJlIHlvdSBjb3VsZCBhbGxv
Y2F0ZSBqdXN0IHRoZSBkYXRhDQo+IHBhcnQgYW5kIGxhdGVyIHVzZSBlLmcuIGJ1aWxkX3NrYl9h
cm91bmQoKQ0KDQpTdXJlLCB3aWxsIGV4cGxvcmUgb24gaXQuDQo+IA0KPiA+ICsNCj4gPiArCXNn
X2luaXRfdGFibGUoc2tidWZfZG1hLT5zZ2wsIDEpOw0KPiA+ICsJYWRkciA9IGRtYV9tYXBfc2lu
Z2xlKGxwLT5kZXYsIHNrYi0+ZGF0YSwgbHAtPm1heF9mcm1fc2l6ZSwNCj4gRE1BX0ZST01fREVW
SUNFKTsNCj4gPiArCWlmICh1bmxpa2VseShkbWFfbWFwcGluZ19lcnJvcihscC0+ZGV2LCBhZGRy
KSkpIHsNCj4gPiArCQlpZiAobmV0X3JhdGVsaW1pdCgpKQ0KPiA+ICsJCQluZXRkZXZfZXJyKG5k
ZXYsICJETUEgbWFwcGluZyBlcnJvclxuIik7DQo+ID4gKwkJcmV0ID0gLUVOT01FTTsNCj4gPiAr
CQlnb3RvIHJ4X3N1Ym1pdF9lcnJfZnJlZV9za2I7DQo+ID4gKwl9DQo+ID4gKwlzZ19kbWFfYWRk
cmVzcyhza2J1Zl9kbWEtPnNnbCkgPSBhZGRyOw0KPiA+ICsJc2dfZG1hX2xlbihza2J1Zl9kbWEt
PnNnbCkgPSBscC0+bWF4X2ZybV9zaXplOw0KPiA+ICsJZG1hX3J4X2Rlc2MgPSBkbWFlbmdpbmVf
cHJlcF9zbGF2ZV9zZyhscC0+cnhfY2hhbiwgc2tidWZfZG1hLQ0KPiA+c2dsLA0KPiA+ICsJCQkJ
CSAgICAgIDEsIERNQV9ERVZfVE9fTUVNLA0KPiA+ICsJCQkJCSAgICAgIERNQV9QUkVQX0lOVEVS
UlVQVCk7DQo+ID4gKwlpZiAoIWRtYV9yeF9kZXNjKSB7DQo+ID4gKwkJcmV0ID0gLUVJTlZBTDsN
Cj4gPiArCQlnb3RvIHJ4X3N1Ym1pdF9lcnJfdW5tYXBfc2tiOw0KPiA+ICsJfQ0KPiA+ICsNCj4g
PiArCXNrYnVmX2RtYS0+c2tiID0gc2tiOw0KPiA+ICsJc2tidWZfZG1hLT5kbWFfYWRkcmVzcyA9
IHNnX2RtYV9hZGRyZXNzKHNrYnVmX2RtYS0+c2dsKTsNCj4gPiArCXNrYnVmX2RtYS0+ZGVzYyA9
IGRtYV9yeF9kZXNjOw0KPiA+ICsJZG1hX3J4X2Rlc2MtPmNhbGxiYWNrX3BhcmFtID0gbHA7DQo+
ID4gKwlkbWFfcnhfZGVzYy0+Y2FsbGJhY2tfcmVzdWx0ID0gYXhpZW5ldF9kbWFfcnhfY2I7DQo+
ID4gKwlkbWFlbmdpbmVfc3VibWl0KGRtYV9yeF9kZXNjKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4g
MDsNCj4gPiArDQo+ID4gK3J4X3N1Ym1pdF9lcnJfdW5tYXBfc2tiOg0KPiA+ICsJZG1hX3VubWFw
X3NpbmdsZShscC0+ZGV2LCBhZGRyLCBscC0+bWF4X2ZybV9zaXplLA0KPiBETUFfRlJPTV9ERVZJ
Q0UpOw0KPiA+ICtyeF9zdWJtaXRfZXJyX2ZyZWVfc2tiOg0KPiA+ICsJZGV2X2tmcmVlX3NrYihz
a2IpOw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhlIGVycm9yIGNv
ZGUgaXMgaWdub3JlZCBieSB0aGUgY2FsbGVyLiBQb3NzaWJseSB5b3UgY2FuIGNoYW5nZQ0KPiB0
aGlzIHRvIGEgJ3ZvaWQnIGZ1bmN0aW9uLg0KDQp3aWxsIG1ha2UgaXQgdm9pZCBpbiBuZXh0IHZl
cnNpb24uDQoNClRoYW5rcywNClJhZGhleQ0K
