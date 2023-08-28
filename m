Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7A478B6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjH1Rj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjH1Rjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:39:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A3CA6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7An19nsx3ItDaQwEWYY8maEP9Nxlde4GUtVV/Vq7G91L4wUAgn3vc4zp6Ok5BwHVTugG71sw0T3psr0yX2TKEUPXUNquHgUcj26HSrtm6vIz3UKgqgjoKTnVxQuFoPZEH3GYxpKIBDla5+mgfV6ZqH4Mx760bmM9qkUdB62H/0MGuYH5y6Bpb09c1NOw6zwBw5J4IclnGjOPBMe4IBJZcAPJaImsvTZ3emZK3hmHkhfCbuIZyvAXoxk945spvyef6URmCdEtQGhkw+xdcshipz7FpX66Tc6PccYvYPMq5R7VyFaIyiQTQnqxGt5OrFgw7vNtGssvgv0KEdpBUlpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJFxyWenX/up3x9iCQjv+frRF22QL0pti5AaY0SLZUI=;
 b=DhV4v91KIvUNatBh4w6F/8SxBeqAalBhLh1U2kZCjk7uQudifipP/evpNSOk1ONaoR5RQPWMBAr4zC7BBpMPDbpE6u+vnfk68cz4FEuaI3318JNGnPSf0gfHOUtpe2/myn9kDyTiw4bmrNvWWZW2pKi0AofYGkl9jYmsM58FlNcQ4rqB3SElmLnnWwe/qkHdInyZ/Z0ZTdd+VTOWEMr2O1eJ79wovbA5dYP4zcA3PZp3D4Gs1LxKzNT9Hz4J0w4Ezh6JTM1CWBxIGsF8dCPCLRXXWC+WYlQw+rTO2K1yd+fMcd8qQBAAfrFskmU1FgQclD2hMkdNfhJKZcy+3tv8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJFxyWenX/up3x9iCQjv+frRF22QL0pti5AaY0SLZUI=;
 b=KN9nxBoVDRiUXOyCu16ObBxt1sp9ANVkAw9G/kz+DtZPQBG3azkSd+FjzBs+PXlWHsKYnN+6YQG66EbB3f2aaKXLks7KS18On8bhpSHknYHDJM5Vx0Y64m0SWLS0sLWzWGLB3UoKwEST6PpyW5aiLmh9zeHvsmfiJ+hQFBNh6WA=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 17:39:27 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 17:39:27 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Alexander Kamensky <alexander.kamensky42@gmail.com>
CC:     "bhe@redhat.com" <bhe@redhat.com>,
        "piliu@redhat.com" <piliu@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sarangi, Anirudha" <anirudha.sarangi@amd.com>
Subject: RE: kexec reports "Cannot get kernel _text symbol address" on arm64
 platform
Thread-Topic: kexec reports "Cannot get kernel _text symbol address" on arm64
 platform
Thread-Index: AdnKK79OkD4zpG4kTFa/kOe2Uun+RAAOxmsAAHwHDeAAlUzuAAFfZ4gQACCkigAAUgkXYAAp+FgAAMt+ALA=
Date:   Mon, 28 Aug 2023 17:39:27 +0000
Message-ID: <MN0PR12MB5953557EB8909B66B4D09B28B7E0A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <MN0PR12MB59538822AA264031D0CAE468B70DA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNL14lnrHvzbpRQu@MiWiFi-R3L-srv>
 <MN0PR12MB59535434E071499DDE439B08B710A@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNogKKZCp12Q92jh@MiWiFi-R3L-srv>
 <MN0PR12MB5953FFB655A208BD4FA32EE4B71EA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <CACBYKvRJL_WmZUN7BH_TjxX+TC2O1gjsudkh1GtRyB3WifjMJA@mail.gmail.com>
 <MN0PR12MB59532ABFAF131AC84F36B73FB71CA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <CACBYKvT6AzupfrHZ58BYM8xi8TDLeppqD+Lt=rf9hfmSew+nmQ@mail.gmail.com>
In-Reply-To: <CACBYKvT6AzupfrHZ58BYM8xi8TDLeppqD+Lt=rf9hfmSew+nmQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|BN9PR12MB5259:EE_
x-ms-office365-filtering-correlation-id: 1a1f1111-1c6d-4cf8-e14b-08dba7edba04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQVtbRRpSGCwiNL90JcPoFbHCvGvGR2XFhUeDIFK2GFCYTBxx75aV4TjWODuGfa4EpouHQTZ2bgkJZMaI0pIv0afcFq5zYYPaIB7kM5oJ3KWochKHAZC/BB7vBTRMqiIOMKX3PyVr4zbUQhuV0kuw3S9bziuyfR+vajjtwXUPdEFfq7gHh/DW1bzc4kSMlPsgg7yY8OEvaOC8DMPGdCoLQoSG5iNhPCYUMJE0ckh3AUzpRnq/KZQ9wMq0R5OSekkrAfg2ETVDh96YQUzWaCt5Lgao+mcesWhECVj+X9ExDqAu+FbYvhxcjuqw1ZiEaX/vtoYPGN2uAa+9S4DBb+I8ufeAt6FYp04HSG/NWRbLhX3lDcizqlXmPR405dk5ThbU4LzHG7JUGSSUxsDx/LkLdZ6hMAZHzTBcl6tWuiW1lSD98A8sk/FxHYaQIeCPSS0QVxaZzUnwz6efk2DeFBKQAfLdOT+9jB955BoCdF6ffiAXbAeQGaCzOUMuPEeAcXgUazIcvRzaGioJtH3jacKgScNofPiU37Atb89qkZiqW6or7bqGcSbQ9mlnxZTDn9nppgKHAjCtp61zOILABaD7si1hXNgOc9i0aVSDff2Fow=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(186009)(451199024)(1800799009)(41300700001)(122000001)(38100700002)(86362001)(83380400001)(478600001)(38070700005)(71200400001)(966005)(26005)(9686003)(53546011)(7696005)(6506007)(55016003)(66946007)(76116006)(66476007)(54906003)(6916009)(2906002)(66446008)(64756008)(33656002)(66556008)(316002)(5660300002)(4326008)(8676002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWVLQ3BVLzk2bDhDZkxHd1U1aCt5bnk4YUFlVUNsMWxRQ3lQYTRlV0p1ZU4w?=
 =?utf-8?B?QkJTRzR1QUxaN1NrV3BFQysraGxEcDFpSlRockVtSEIrWGhuL3BqTXBhZjhT?=
 =?utf-8?B?QlV5WC9mdmlHcUkrTmNJU1pxQWdOY2dybnJTQ1NySVlpNUp6c2Y5WWdLMmNZ?=
 =?utf-8?B?T1M3VWFVT0xYeWdFK1E4K1lkYnVnSWJSOEY2ZHluUG1SdE56YmZVeFkybWkr?=
 =?utf-8?B?NVgwdTdCSFFQU3Vwc2tCZk5pc1YrcGdvYzZZVGVGOGRqck0yZUJRbDlhd0Nu?=
 =?utf-8?B?dmRBVEdrektVcUY4d0duVG5HZ1A0UENRbHdjWWFBZGFqbUNMcm9iWkxKaktJ?=
 =?utf-8?B?aC9yVG5yNEdGVWF2ZzNLZm9kK2dZNWJuZUpJd0dSRWxyTElWVXhyQVdxblNS?=
 =?utf-8?B?NnBEYWNmZTBXOG5YUTBjMG9lT2JlSUw3U3kxaU9wV0RFQlhUY3dtWlVBZk9w?=
 =?utf-8?B?MWd6dUNIYzlzVHpBd3dtZUFRTk1ZanUyS2wzbVdZTHpRc01lcno4MGRkR1E0?=
 =?utf-8?B?cWQvSzlhQ2VzcWJsbk1xWUg3MjRFcDBqY1d1OCt6eWRPVHM0SVRUVTd3VWhP?=
 =?utf-8?B?ZzlWUEZIaTAzVkZ0TDEyL09XRmN2NHlGZEltZ3ZwTkF1bnRBR1Qvck16aWRt?=
 =?utf-8?B?dGJZVFBZemZhUjBUMlUwenVKenFkQlNlMjcwayt6MVBJN3pDR3dCNDRDbVhm?=
 =?utf-8?B?TDdSY1AzQ01WR0ZLbkwrTEFKcWNhb0F2UStlM0prZU9rMEJZMTZjbDNmdkxC?=
 =?utf-8?B?Zkx1MkFrWVRyVGg5NkRoK21WbDJWMHMzNzVPZ2xUUEhjdWF0SzNja1FiQWNj?=
 =?utf-8?B?ZzEzWEpKUzlndm5wdG4ya28wRUpJTUNGaG93SXlIU1ZOTE9scEswc20xNGwv?=
 =?utf-8?B?aGlPcU5tNEpaaWdwbDY1SzJLSml3KzVoMFVaNmMzd0NxRHFvdXhGTmRXVEFU?=
 =?utf-8?B?QzM3d1ZZY3ozSExDL29vdGF5SWhUelZjMGIyNHFwVFZDUk9uTEpCWGlkRzI5?=
 =?utf-8?B?WTFlRXh2YnpjKzh6OGwzRWpxREJTcFMrOFRHYnRPeHhMNkExb2J6aUJScEhS?=
 =?utf-8?B?NVUvbEplUnVLZW5xaHpNTjVOMkhET2wxMUlTUUhWSjV4ZndWSlZ0dGgrcTFV?=
 =?utf-8?B?Y1ZncGpHREdRMGJIUWIwK21QQkpwcUFjK0l6NFo0SXpRYWJkNWF1dHFHVmlX?=
 =?utf-8?B?MmdCb1Y4T2VuS0t6a2htNUY2VVpQN1E5Ri9JMFRDNmd4OGlIc2pGNU1hQ1Fw?=
 =?utf-8?B?b01ZdTA4UUhZSHB3bmZuQ0x3SGI2N2hJenBRbHhtR3RtRCtQbVlwd1JSK0I1?=
 =?utf-8?B?d2N0aUhjN2dJTXBRUHUyQlJrZ3pWK2ZOc3BpR1BMNG5XdzZIL09hMGxXZlV4?=
 =?utf-8?B?WFdYMXRuaDdtL0hwUUhqYWQ1RHZUeW5md2FCUzdLT2dudUtPQnFCY3BEc0Zr?=
 =?utf-8?B?OSt6MEdBYyt0MHlKRVc5Qkk0UnZJSFN2UnRibE1ReERvL293M0FkbnBZMURM?=
 =?utf-8?B?ZEJoamVscHgvQ0tyUEtkVkRRMXkzK2RLQmxjc2NkMlFhRFhZdzEyTy93ZVha?=
 =?utf-8?B?UWxjMXpUWlNEYlZwM1lnTzFWZjROVUFSbCtrZ3loa3NxK0szZXRKNlZ6cnlV?=
 =?utf-8?B?cm1salVKQzZ6S09aNklhZlFQWDFTM2pMdk5uOGk5VUtOc0Y0cEl4SzQ5eFUv?=
 =?utf-8?B?azdIOXFWckljdWVsZGd1cm1Ib2NvdjFXTUJmaSt0OTNlRmZYUk04c3JSN0xB?=
 =?utf-8?B?S1FlRHNwZWVYOGJieHUwNTVheGZ3YjR6Zlo4VW5UT0J0Z0pLbGxvL0RIQzRr?=
 =?utf-8?B?RWg2cFhtdkx6RGNaRDgrM1BrcndGYTlEVVNFbUNrV1QwR0psQ0lHK3lBKy85?=
 =?utf-8?B?SFg0eDdDM3NYaC9VZFgvbVNsZENMdWh3aGhPS2FDMGZDUi92bkpPYklMYnVL?=
 =?utf-8?B?UG80TElEU2M1Y3I2N2s3VHpnQUEzSmVibXNpakRTQnQzZm9WbHlPd3pFeXE0?=
 =?utf-8?B?WnhJUVdqOWk5Uk03cUJIY2RFNEV0RVdBODVCVmx2L0tORWpnekwzM0R4STNG?=
 =?utf-8?B?d1E0MGRLdnlLZWFWT3RaLzdsMmFncWhBQVhKT3FCQVg4WVY5UU81MnZVa1Z5?=
 =?utf-8?Q?5YqI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1f1111-1c6d-4cf8-e14b-08dba7edba04
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 17:39:27.2801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onC7Q3kB7gVldhwvu7hRXl0lzXRZZopmtkMyPd9HcqKgcL5Qygj3OdF6CZ//XEHm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5259
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgS2FtZW5za3kg
PGFsZXhhbmRlci5rYW1lbnNreTQyQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3Vz
dCAyNCwgMjAyMyA4OjM1IFBNDQo+IFRvOiBQYW5kZXksIFJhZGhleSBTaHlhbSA8cmFkaGV5LnNo
eWFtLnBhbmRleUBhbWQuY29tPg0KPiBDYzogYmhlQHJlZGhhdC5jb207IHBpbGl1QHJlZGhhdC5j
b207IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBTYXJhbmdpLCBBbmlydWRoYSA8YW5pcnVkaGEuc2FyYW5naUBhbWQuY29tPg0KPiBT
dWJqZWN0OiBSZToga2V4ZWMgcmVwb3J0cyAiQ2Fubm90IGdldCBrZXJuZWwgX3RleHQgc3ltYm9s
IGFkZHJlc3MiIG9uDQo+IGFybTY0IHBsYXRmb3JtDQo+IA0KPiBPbiBXZWQsIEF1ZyAyMywgMjAy
MyBhdCAxMjowOeKAr1BNIFBhbmRleSwgUmFkaGV5IFNoeWFtDQo+IDxyYWRoZXkuc2h5YW0ucGFu
ZGV5QGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gRnJvbTogQWxleGFuZGVyIEthbWVuc2t5IDxhbGV4YW5kZXIua2FtZW5za3k0MkBn
bWFpbC5jb20+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjIsIDIwMjMgOToyNCBBTQ0K
PiA+ID4gVG86IFBhbmRleSwgUmFkaGV5IFNoeWFtIDxyYWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5j
b20+DQo+ID4gPiBDYzogYmhlQHJlZGhhdC5jb207IHBpbGl1QHJlZGhhdC5jb207IGtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBsaW51eC0ga2VybmVsQHZnZXIua2VybmVsLm9yZzsg
U2FyYW5naSwgQW5pcnVkaGENCj4gPiA+IDxhbmlydWRoYS5zYXJhbmdpQGFtZC5jb20+DQo+ID4g
PiBTdWJqZWN0OiBSZToga2V4ZWMgcmVwb3J0cyAiQ2Fubm90IGdldCBrZXJuZWwgX3RleHQgc3lt
Ym9sIGFkZHJlc3MiDQo+ID4gPiBvbg0KPiA+ID4gYXJtNjQgcGxhdGZvcm0NCj4gPiA+DQo+ID4g
PiBIaSBBbGwsDQo+ID4gPg0KPiA+ID4gU29ycnkgZm9yIHRoZSB0b3AgcG9zdCwgYnV0IEkgYmVs
aWV2ZSB0aGF0IEkgbWlnaHQgaGF2ZSBwb3N0ZWQgYSBmaXgNCj4gPiA+IGZvciB0aGlzIGlzc3Vl
IGEgY291cGxlIGRheXMgYWdvLg0KPiA+ID4NCj4gPiA+IFBsZWFzZSBjaGVjayBhbmQgc2VlIGlm
IGl0IGhlbHBzDQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rZXhlYy8yMDIzMDgxOTE5
MTExOS45NzUyOTktMS0NCj4gPiA+IGFsZXhhbmRlci5rYW1lbnNreTQyQGdtYWlsLmNvbS9ULyN1
DQo+ID4gPg0KPiA+ID4gRXhwbGFuYXRpb24gZm9yIHRoZSBpc3N1ZSBJIG9ic2VydmVkIHdpdGgg
YSBzaW1pbGFyIHNlY29uZGFyeSBrZXJuZWwNCj4gPiA+IHRyYWNlYmFjayBvbiBhcm02NCBpcyBp
biB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4NCj4gPiBJIGZldGNoZWQgbGF0ZXN0IGtleGVjIHNv
dXJjZXMNCj4gPiAoNzc3Y2E0NTNjYTY5ZTQ2ZjczNzZiMDdiYTY3MjdiZDI2MWVjOTdlZikNCj4g
PiBhbmQgYXBwbGllZCBhYm92ZSBwYXRjaCwgYSBiaXQgaW1wcm92ZWQgYnV0IHN0aWxsIHZtY29y
ZSBzaXplIGlzIGh1Z2UuDQo+ID4NCj4gPiAvICMgbHMgLWxydGggL3Byb2Mvdm1jb3JlDQo+ID4g
LXItLS0tLS0tLSAgICAxIHJvb3QgICAgIHJvb3QgICAgICAgMTUuNUcgQXVnIDIzIDE4OjU1IC9w
cm9jL3ZtY29yZQ0KPiA+DQo+IEhvdyBiaWcgaXMgeW91ciBzeXN0ZW0gbWVtb3J5PyBJZiBpdCBp
cyAxNkcgdGhlbiB0aGUgYWJvdmUgaXMgbm9ybWFsLg0KDQpZZXMsIGl0J3MgMTZHLg0KDQo+IA0K
PiBUaGUgbW9zdCBpbXBvcnRhbnQgdGhpbmcgaXMgY2FuIHlvdXIgc2Vjb25kYXJ5IGtlcm5lbCBy
ZWFkIGl0PyBGb3IgZXhhbXBsZQ0KPiANCj4gY2F0IC9wcm9jL3ZtY29yZSA+IC9kZXYvbnVsbA0K
DQpUaGlzIHJ1bnMgZmluZSBhbmQgSSBjYW4gcmVhZCAvcHJvYy92bWNvcmUNCg0KPiANCj4gSWYg
eW91IHdhbnQgdG8gY2FwdHVyZSBvbmx5IGtlcm5lbCBjb3JlIG91dCBvZiAvcHJvYy92bWNvcmUg
eW91IG5lZWQgdG8gdXNlDQo+IG1ha2VkdW1wZmlsZSB0byBmaWx0ZXIgb3V0IHRoZSByZXN0IG9m
IHRoZSBtZW1vcnkuDQoNClRoYW5rcyBmb3IgdGhlIHBvaW50ZXJzLiBJIGNvdWxkIHVzZSBtYWtl
ZHVtcGZpbGUgdG8gZXh0cmFjdCBkbWVzZyBkdW1wIA0KYW5kIGl0IHBvaW50ZWQgdG8gc3lzdGVt
IEtlcm5lbCBkdW1wIGNvcnJlY3RseSBhbHNvIGNvbXByZXNzIGR1bXAgZGF0YS4NCg0KRnVydGhl
ciBleHBsb3Jpbmcgb24gaXQgYW5kIHdpbGwgcmVwb3J0IGhvdyB0aGUgYW5hbHlzaXMgZ29lcy4N
Cg0KeGlsaW54LXZjazE5MC0yMDIzMjovcnVuL21lZGlhL21tY2JsazBwMSMgbWFrZWR1bXBmaWxl
IC1jIC0tc3BsaXQgLWQgMyAgIC9wcm9jL3ZtY29yZSBkdW1wZmlsZTEgZHVtcGZpbGUyDQpUaGUg
a2VybmVsIHZlcnNpb24gaXMgbm90IHN1cHBvcnRlZC4NClRoZSBtYWtlZHVtcGZpbGUgb3BlcmF0
aW9uIG1heSBiZSBpbmNvbXBsZXRlLg0KQ2hlY2tpbmcgZm9yIG1lbW9yeSBob2xlcyAgICAgICAg
ICAgICAgICAgICAgICAgICA6IFsxMDAuMCAlXSB8ICAgICAgICAgICAgICAgICAgQ2hlY2tpbmcg
Zm9yIG1lbW9yeSBob2xlcyAgICAgICAgICAgICAgICAgICAgICAgICA6IFsxMDAuMCAlXSB8ICAg
ICAgICAgICAgIA0KQ2hlY2tpbmcgZm9yIG1lbW9yeSBob2xlcyAgICAgICAgICAgICAgICAgICAg
ICAgICA6IFsxMDAuMCAlXSAvICAgICAgICAgICAgICAgICAgQ2hlY2tpbmcgZm9yIG1lbW9yeSBo
b2xlcyAgICAgICAgICAgICAgICAgICAgICAgICA6IFsxMDAuMCAlXSAvICAgICAgICAgICAgIA0K
Q2hlY2tpbmcgZm9yIG1lbW9yeSBob2xlcyAgICAgICAgICAgICAgICAgICAgICAgICA6IFsxMDAu
MCAlXSB8ICAgICAgICAgICAgICAgICAgQ2hlY2tpbmcgZm9yIG1lbW9yeSBob2xlcyAgICAgICAg
ICAgICAgICAgICAgICAgICA6IFsxMDAuMCAlXSB8ICAgICAgICAgICAgIA0KQ2hlY2tpbmcgZm9y
IG1lbW9yeSBob2xlcyAgICAgICAgICAgICAgICAgICAgICAgICA6IFsxMDAuMCAlXSBcICAgICAg
ICAgICAgICAgICAgQ2hlY2tpbmcgZm9yIG1lbW9yeSBob2xlcyAgICAgICAgICAgICAgICAgICAg
ICAgICA6IFsxMDAuMCAlXSBcICAgICAgICAgICAgIA0KQ2hlY2tpbmcgZm9yIG1lbW9yeSBob2xl
cyAgICAgICAgICAgICAgICAgICAgICAgICA6IFsxMDAuMCAlXSB8ICAgICAgICAgICAgICAgICAg
Q2hlY2tpbmcgZm9yIG1lbW9yeSBob2xlcyAgICAgICAgICAgICAgICAgICAgICAgICA6IFsxMDAu
MCAlXSB8ICAgICAgICAgICAgIA0KQ2hlY2tpbmcgZm9yIG1lbW9yeSBob2xlcyAgICAgICAgICAg
ICAgICAgICAgICAgICA6IFsxMDAuMCAlXSAtICAgICAgICAgICAgICAgICAgQ2hlY2tpbmcgZm9y
IG1lbW9yeSBob2xlcyAgICAgICAgICAgICAgICAgICAgICAgICA6IFsxMDAuMCAlXSAtICAgICAg
ICAgICAgIA0KQ29weWluZyBkYXRhICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA6IFsgNDUuNyAlXSAtICAgICAgICBldGE6IDZtMTNzDQpDb3B5aW5nIGRhdGEgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogWyA1NC4xICVdIC0gICAgICAgICAgIGV0YTog
MXMNCg0KVGhlIGR1bXBmaWxlcyBhcmUgc2F2ZWQgdG8gZHVtcGZpbGUxLCBhbmQgZHVtcGZpbGUy
Lg0KDQptYWtlZHVtcGZpbGUgQ29tcGxldGVkLiANCg0KPiANCj4gVGhhbmtzLA0KPiBBbGV4YW5k
ZXINCj4gDQo+ID4gVGhhbmtzLA0KPiA+IFJhZGhleQ0K
