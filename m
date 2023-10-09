Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B167BEA98
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378409AbjJIT2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378405AbjJIT2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:28:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0AE6;
        Mon,  9 Oct 2023 12:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5GwiJJze55Pjzowq0oXrGe/6b9XHeoYPcLL70Hixdy1AKR3Vm2q12BCJK6ChQ1GdBE9Qwv+AHMOBrVmkt0Y4/yQYDEE3z80OfL6oI3zQZhLIz+8oJ2YXUA1Da6lC2JOwpQB3P6vNk4cj9qbBWQaSbv0BoFbo1k3hmPyizWJBeVte7e1LmhlHLksnLs16tYIEItoIJNzz1caZd4vtna5qDNPTOnEp5O2c5AeqEgYujWdUs+/bDSg37/fmIB6BAwAk7/nQvjCwRpUw5IVohrXVkbEI9p9D89ek/4PQn12S6u8lHpEMIj+/eHTca3/itYNSSns6hS+QuvnPUP0K8nKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZDlauZTiGzUbui3mxIaUEU4A2vbkRvNoBUbEjd9Epg=;
 b=JI2zXPbQSetaFwqt6/zjMtKI+zFrEFuTwcgVqwrGdrRlYFp46rGT5IbZVwByTmEOrlorcmXAvIXLqsUURFlAH3ZaVZZAUIWpqgwG08sXo2y2go8atzjmVnPDCwOdH5sUJ7lO/vYVrNwJDfqdb8qsB4Us8u9RJH+g9EFiXA5qDLDdc4SBnG4k3E7/cn0yYzvll6dG/1lRbrxNfV82h4mYnPaPgnO0kcxoqnzn2EvuXKvq+I2msOGbNGqlKqdp0iQcRqGs+JnFcK7xMPUss1EgjI+u/Pq+4xOhwAAU+M5TJFkIHT8CAWa1R2D8auZwxUTcJPjLSGu9xzCK59Ipkx6nxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZDlauZTiGzUbui3mxIaUEU4A2vbkRvNoBUbEjd9Epg=;
 b=HZD/UUI5Y4QjGF4/s3qxdkjoMH3LjKLJCoHONf7FTj8YNitGYB16E6CA8P0eNJ+FpLQznWRaltnkfZEZFR12mTGiTJsgLRCbBxsU0gm9TGAnWbpLRJrLJfyAWXFDLEcFDZ5CctYSUUe9NsYYQGoT9Jfv2DlGhB/6iqmFA2E0e24CV+Enu3t333uj3IQDPKbWvXiX6fOcWZnG0DivBTs/UndG2SfrthWI5v557aF/9m/Oil7jVRaBkHJEp7sxClY0nLWRCCG+18WnZxBfBPmKNmnOzEHBHAuhrTsTBYcocqyAChFua+MDdA2ynMbZFIIXyK8Ab2BEnaZ+04SKB3FHDQ==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 19:28:32 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::e00:7275:f848:ae4b]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::e00:7275:f848:ae4b%3]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 19:28:32 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a warning
 message
Thread-Topic: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a warning
 message
Thread-Index: AQHZ94YFlBkdvRjGj0Cl1AIVKIdf4LA8uTSAgAAv4sCAABbRgIAE3Beg
Date:   Mon, 9 Oct 2023 19:28:32 +0000
Message-ID: <BN9PR12MB5068173E789479AA99FDF725D3CEA@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <bb8bc77e6ecc2287fc9110cfa08caa48eb2a0385.1696508228.git.limings@nvidia.com>
 <35467b21-941f-c829-1ad8-b4e7319dbc04@redhat.com>
 <BN9PR12MB50687C00EDAFC2B1A058E1E3D3C9A@BN9PR12MB5068.namprd12.prod.outlook.com>
 <4d40eacb-382a-f0e9-2dcd-9f9e8c7ca9fd@redhat.com>
In-Reply-To: <4d40eacb-382a-f0e9-2dcd-9f9e8c7ca9fd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|MN0PR12MB5979:EE_
x-ms-office365-filtering-correlation-id: 9e28f720-b9d0-45db-52db-08dbc8fdec59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ln1PLI/zi86BwRzRKoOpCamPsgQQgLWm1nQ5XJoPbyiU5pTW2imoiP/vGjjNzxfD7NoE2j6PR5zcGLV0ycXHQOqPnOCbVwbyBfQkUdrf6k0qRqbV6xKPEc1sUI+LaTzjeMOpMss+VUw9ebg+wnNrCK9KSSQ31+OYE8nvA9aCbgOZLHcpnutob/ItYDsqd+5xM8cL4yhKULHjYC6iVLx+anrMCA0RGsZGl9vGThusjFpkOM40aOo3BaM0OXeKsOnBYUqj70vbH7yfJuSGPC03fzWoSk1y66lu+JoU8sqVZeRZwxGnMCJiYZW+u9wqde9wLXaY4NgbjOhUQHrjW/BPfiiKs/mHGZr2d3ifh9P6IFT2qMsvFE4abQwE85ChnlHpxCkDULshj8R9M0+lbxTgqvKU69IdBezPXx4MFyNqd8N3dd0N42aWpMDFrez2ZcA9SLRLVlIOXlj7fGmxt5e2aYzAk2xuNmMtmXmWWG1dILbAfJVZ787yDFAD0TJfYD5bdMRD/HCxbE4TeSZxpSnrMfWgPUyZWlrppBdWiboyARvLbJ5mr1t8ctu+1Lkr3zbbyyE0rCE2JPsCT4g4GaxiCcWG72Kb75buFxCxS8w2x84OgNcC6dEpzQWMEBEqd4yN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(15650500001)(55016003)(86362001)(2906002)(8676002)(8936002)(41300700001)(4326008)(52536014)(5660300002)(33656002)(26005)(38100700002)(38070700005)(9686003)(122000001)(7696005)(6506007)(83380400001)(53546011)(478600001)(316002)(71200400001)(54906003)(66946007)(66556008)(66476007)(66446008)(64756008)(110136005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWZoZGl5MzFUaitpakhybXJOd0o1cjFOSHhFeFJGY004aW50a2IvY3hmeGJM?=
 =?utf-8?B?NWRuWi94cUpRTFo4Qk5BTEpJaXJob0VqY3JCRVJTZkx4aEFudjNzUXFzcUhm?=
 =?utf-8?B?TzIwL1ZsTkx3UWcwL2R1TDFMUVd4NFFGWVF5Zzk2UkhGd1Fqc1BpOXNHM0c3?=
 =?utf-8?B?N3M3RHBhVFcxWTdzbDlkS0VoQjU0dDVjenZXSUQrUWZXTnpXbDhpMnFDMjJi?=
 =?utf-8?B?L2ZPZlpEZHZwczFQMGF1NFhvcXZScGt3ZDFpT2gyK1M5aHFhemQvVlFjc0gx?=
 =?utf-8?B?Y0dJVzExb0lPUHhyV1hsMTRyOGttQlRTWVBZU3RNeDQ1VG9PWEpiZVBGTFFt?=
 =?utf-8?B?LytzWm5NNitvbmJ2MnYyZ1FjZnFDZHRPTUtreVk5NWExcUcxdFl1eWhXdWVl?=
 =?utf-8?B?WnpISkJKby9NMXdwVWxzUUNYZGRBN24rMnkxR0xSRW9Yc1U3N0JPUnl6NlZX?=
 =?utf-8?B?QWxSNzkrR1BDTzJ2Rm9mclQvSU5BeTZKRnFneEV2SktQRDNnbkpuYW1PK0E4?=
 =?utf-8?B?UVFaeGZXUUQvaTFyRE55NXhvZ1doZ0dLRmtUdDhETytnVmo1YlpZSFhmNnAv?=
 =?utf-8?B?cnQyaXZVdERjYnV2SGtlZ3o4d2NvWlp2NDdrWEJIUzM0Q3Zpd3VCd0dlbDQ4?=
 =?utf-8?B?TGErQ2VubUMzNG16UFpaREplRDFtSnErMUZLS2pMQmZxYkxWU29BOVFvRmZ0?=
 =?utf-8?B?NUxJWE5CRWZTWlYrYWN1Q1IrQWdLbnljb1FPUnFBdWhVdzBFME9xajA4aHA3?=
 =?utf-8?B?dHA5QzRPcjhpbDhidFE3L0JtdkZqWjZLZ1laT0xGTkhDdHE5SXBEV1k4cVcy?=
 =?utf-8?B?VHB6WE1ScGFhSng3S2VUWEpHanN1Rm93QytlVWJlRklzYjlvNFJ0elVMc2pr?=
 =?utf-8?B?RVdBVmIyUGhZS0FVRkM3dHpIcGJpakRCRXgwbVlBYzFOY0p3REErRndCeFlZ?=
 =?utf-8?B?M3Q0by9Nc21ub054YmFMbmZ5R1JpdnNhZzI4WHZvb3RTSGw4TTd0MUVHdG5o?=
 =?utf-8?B?bzRGMTFpZHliaXhrVjZyeHBscWsrREVBZmlLWUpFN2VtajI4OFZvNHR0OFVU?=
 =?utf-8?B?RWg1NlVtdU5lTnA4TlVxU01TcGFwMW1HUGYybk9FN3hMNlVDTlhPUFZ5bjhi?=
 =?utf-8?B?N3hqZ3YwcG9tOVVBQytuOWkrejVDQlozK2VMakRxL1RsQm9ITU1qSzdPbFRm?=
 =?utf-8?B?cTRtZkpuZ09VZGlxbnhEa2dHdmFqbHh3VGNnZWk3K21OdExsVVNBMUNwa1BC?=
 =?utf-8?B?ZTg1cjMwbVdQNGRieXpnYlBtMEM5cHpraTRlZ1d6V1ZZK2N0SnJQRm92UU5x?=
 =?utf-8?B?b3JEM0I3WDBiaWtZNWV0Um5jQVZIN3dDVmdUVnRZZXNFMTZyT2txNUVHUUhJ?=
 =?utf-8?B?akxHVTAycnd1N1JWcm1hanEvYWw1SXZRL0xVL0ZjbFR0QzRRSVdzWWNzbzIr?=
 =?utf-8?B?TWVKaEtGZWZJaDM3UjA0MHNJcUowdVZ1NDZLVmNtcG10RWl1eDlxZzdRbmZm?=
 =?utf-8?B?R3BmdjMxUktQenRQR0I4RytzMCtuamN2SG14bXVmVjloakExR2ZMVlBLWlpK?=
 =?utf-8?B?dUdNdW5RMXAyTG5uSTd4blRHcTA3YnBLdC9iU2J4Yzdobk5BWW5IUklOMkJr?=
 =?utf-8?B?a3dEVTF5TUZzV3hqalExZG1xSG4xakJLbFpta3RjU0kvUHAvWVBsOW4rbG5L?=
 =?utf-8?B?QWxKeEx6QU1XTUFGcVMxc21DVDdSRTQ0OEFzaldYdUt6a1dTblRBNmg0UTdO?=
 =?utf-8?B?UVdXZ21NN3BTY3lwVUQ3QURsbmQzWUc2Z0dFZnlUMHo3VmY5ZUF3bkt4clJF?=
 =?utf-8?B?RFl3THNsU3NrN0xCV2ZTdm9udlJCVUFMbDVyZHovY0kxdzhQdVY0RTB2VU5D?=
 =?utf-8?B?TG9yOWNobUJLdlhCanJlUnF3Qy81TmxLdUlTU2Z0NkpHTWc5WExxWE5Bdis3?=
 =?utf-8?B?Qy95RE1YRGpBMEczUFRJRmpyK0VOZlJ5TW5wajBsSkphNGRwQXphK29FK2Y5?=
 =?utf-8?B?UEZWUmVoQkhmREJzU29TWVpOUjRNWGpiQnZqdHVrd3dTQ1MxanV1aGkzKzZp?=
 =?utf-8?B?Vnc5VWtlUkcrbnp0aElQVW5WNTdKL1VVcnFSOGFrY2Ztbklxa1A0Q2Rwa0d2?=
 =?utf-8?Q?+vVE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e28f720-b9d0-45db-52db-08dbc8fdec59
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 19:28:32.0478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwtgx8k6mtugHgvb7ckD5qR/3kbUAYyvgoKnksjnRmCRmVRaL6JspgngKF19r13SYcCDZTIfG6HvWPs0yyfh5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFucyBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDYsIDIwMjMgMTow
NyBQTQ0KPiBUbzogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29tPjsgVmFkaW0gUGFzdGVy
bmFrDQo+IDx2YWRpbXBAbnZpZGlhLmNvbT47IERhdmlkIFRob21wc29uIDxkYXZ0aG9tcHNvbkBu
dmlkaWEuY29tPjsgTWFyaw0KPiBHcm9zcyA8bWFya2dyb3NzQGtlcm5lbC5vcmc+OyBEYW4gQ2Fy
cGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+IENjOiBwbGF0Zm9ybS1kcml2ZXIt
eDg2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxIDEvMV0gcGxhdGZvcm0vbWVsbGFub3g6IG1seGJmLXRtZmlmbzog
Rml4IGEgd2FybmluZw0KPiBtZXNzYWdlDQo+IA0KPiBIaSBMaW1pbmcsDQo+IA0KPiBPbiAxMC82
LzIzIDE3OjUwLCBMaW1pbmcgU3VuIHdyb3RlOg0KPiA+IFRoYW5rcyBIYW5zLg0KPiA+DQo+ID4g
QmVsb3cgaXMgdGhlIGxvZ2ljOg0KPiA+DQo+ID4gSVNfVlJJTkdfRFJPUCgpIGlzIE9OTFkgc2V0
IHRvIFRSVUUgZm9yIFJ4LCB3aGljaCBpcyBkb25lIGluIHR3byBwbGFjZXM6DQo+ID4gTGluZSA2
OTY6ICAqZGVzYyA9ICZ2cmluZy0+ZHJvcF9kZXNjOw0KPiA+IExpbmUgNzQyOiBkZXNjID0gJnZy
aW5nLT5kcm9wX2Rlc2M7DQo+ID4NCj4gPiBTbyBsaW5lIDYzNCBiZWxvdyB3aWxsIG5ldmVyIGhh
cHBlbiB3aGVuIElTX1ZSSU5HX0RST1AoKSBpcyBUUlVFIGR1ZSB0aGUNCj4gY2hlY2tpbmcgb2Yg
bGluZSA2MzMuDQo+ID4gNjMzICAgICAgICAgaWYgKCFpc19yeCkNCj4gPiAgNjM0ICAgICAgICAg
ICAgICAgICB3cml0ZXEoZGF0YSwgZmlmby0+dHguZGF0YSk7DQo+ID4NCj4gPiBQbGVhc2UgY29y
cmVjdCBtZSBpZiBpdCdzIG15IG1pc3VuZGVyc3RhbmRpbmcuDQo+IA0KPiBJZiBJU19WUklOR19E
Uk9QKCkgaXMgT05MWSBzZXQgdG8gVFJVRSBmb3IgUngsIHRoZW4gaXQNCj4gc2hvdWxkIHNpbXBs
eSAqbm90KiBiZSBjaGVja2VkICphdCBhbGwqIGluIHRoZSB0eCBwYXRocy4NCg0KSVNfVlJJTkdf
RFJPUCgpIGl0c2VsZiBpcyBhY3R1YWxseSBub3QgY2hlY2tlZCBpbiB0aGUgVHggcGF0aC4gIEl0
IGlzIHRoZSAiISBJU19WUklOR19EUk9QKCkiIHRoYXQgY2hlY2tzIHRoZSBSeC9UeCwgc29tZXRo
aW5nIGxpa2U6DQoNCmlmICghSVNfVlJJTkdfRFJPUCh2cmluZykpIHsNCglpZiAoaXNfcngpDQoJ
CS4uLg0KCWVsc2UNCgkJLi4uDQp9DQoNClRoZSByZWFzb24gaXMgdGhhdCBJIHRob3VnaHQgd2Ug
bWlnaHQgcmV1c2UgdGhlICcgSVNfVlJJTkdfRFJPUCcgZm9yIFR4IGxhdGVyLg0KDQpIb3dldmVy
LCBpZiB0aGUgbG9naWMgbG9va3MgY29uZnVzaW5nLCBJIGNvdWxkIHJldmlzZSBpdCB0byBzb21l
dGhpbmcgbGlrZToNCg0KaWYgKGlzX3J4KSB7DQoJaWYgKCFJU19WUklOR19EUk9QKHZyaW5nKSkg
DQoJCS4uLg0KfSBlbHNlIHsNCgkJLi4uDQp9DQoNClRoYW5rcy4NCj4gDQo+IEp1c3Qgc2V0dGlu
ZyBkYXRhID0gMCBpcyBzaW1wbHkgcGFwZXJpbmcgb3ZlciB0aGUgd2FybmluZw0KPiB3aXRob3V0
IGFjdHVhbGx5IGZpeGluZyBhbnl0aGluZy4NCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBIYW5zDQo+
IA0KPiANCj4gDQo+IA0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPg0KPiA+PiBTZW50OiBGcmlkYXks
IE9jdG9iZXIgNiwgMjAyMyA4OjU0IEFNDQo+ID4+IFRvOiBMaW1pbmcgU3VuIDxsaW1pbmdzQG52
aWRpYS5jb20+OyBWYWRpbSBQYXN0ZXJuYWsNCj4gPj4gPHZhZGltcEBudmlkaWEuY29tPjsgRGF2
aWQgVGhvbXBzb24gPGRhdnRob21wc29uQG52aWRpYS5jb20+Ow0KPiBNYXJrDQo+ID4+IEdyb3Nz
IDxtYXJrZ3Jvc3NAa2VybmVsLm9yZz47IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGlu
YXJvLm9yZz4NCj4gPj4gQ2M6IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEg
MS8xXSBwbGF0Zm9ybS9tZWxsYW5veDogbWx4YmYtdG1maWZvOiBGaXggYSB3YXJuaW5nDQo+ID4+
IG1lc3NhZ2UNCj4gPj4NCj4gPj4gSGkgTGltaW5nLA0KPiA+Pg0KPiA+PiBPbiAxMC81LzIzIDE0
OjE4LCBMaW1pbmcgU3VuIHdyb3RlOg0KPiA+Pj4gVGhpcyBjb21taXQgZml4ZXMgdGhlIHNtYXRj
aCBzdGF0aWMgY2hlY2tlciB3YXJuaW5nIGluDQo+ID4+PiBtbHhiZl90bWZpZm9fcnh0eF93b3Jk
KCkgd2hpY2ggY29tcGxhaW5zIGRhdGEgbm90IGluaXRpYWxpemVkIGF0DQo+ID4+PiBsaW5lIDYz
NCB3aGVuIElTX1ZSSU5HX0RST1AoKSBpcyBUUlVFLiBUaGlzIGlzIG5vdCBhIHJlYWwgYnVnIHNp
bmNlDQo+ID4+PiBsaW5lIDYzNCBpcyBmb3IgVHggd2hpbGUgSVNfVlJJTkdfRFJPUCgpIGlzIG9u
bHkgc2V0IGZvciBSeC4gU28gdGhlcmUNCj4gPj4+IGlzIG5vIGNhc2UgdGhhdCBsaW5lIDYzNCBp
cyBleGVjdXRlZCB3aGVuIElTX1ZSSU5HX0RST1AoKSBpcyBUUlVFLg0KPiA+Pj4NCj4gPj4+IFRo
aXMgY29tbWl0IGluaXRpYWxpemVzIHRoZSBsb2NhbCBkYXRhIHZhcmlhYmxlIHRvIGF2b2lkIHVu
bmVjZXNzYXJ5DQo+ID4+PiBjb25mdXNpb24gdG8gdGhvc2Ugc3RhdGljIGFuYWx5emluZyB0b29s
cy4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBMaW1pbmcgU3VuIDxsaW1pbmdzQG52aWRp
YS5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICBkcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJm
LXRtZmlmby5jIHwgMiArLQ0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3Jt
L21lbGxhbm94L21seGJmLXRtZmlmby5jDQo+ID4+IGIvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5v
eC9tbHhiZi10bWZpZm8uYw0KPiA+Pj4gaW5kZXggZjM2OTZhNTRhMmJkLi5jY2M0YjUxZDMzNzkg
MTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLXRtZmlm
by5jDQo+ID4+PiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLXRtZmlmby5j
DQo+ID4+PiBAQCAtNTk1LDggKzU5NSw4IEBAIHN0YXRpYyB2b2lkIG1seGJmX3RtZmlmb19yeHR4
X3dvcmQoc3RydWN0DQo+ID4+IG1seGJmX3RtZmlmb192cmluZyAqdnJpbmcsDQo+ID4+PiAgew0K
PiA+Pj4gIAlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IHZyaW5nLT52cS0+dmRldjsNCj4g
Pj4+ICAJc3RydWN0IG1seGJmX3RtZmlmbyAqZmlmbyA9IHZyaW5nLT5maWZvOw0KPiA+Pj4gKwl1
NjQgZGF0YSA9IDA7DQo+ID4+PiAgCXZvaWQgKmFkZHI7DQo+ID4+PiAtCXU2NCBkYXRhOw0KPiA+
Pj4NCj4gPj4+ICAJLyogR2V0IHRoZSBidWZmZXIgYWRkcmVzcyBvZiB0aGlzIGRlc2MuICovDQo+
ID4+PiAgCWFkZHIgPSBwaHlzX3RvX3ZpcnQodmlydGlvNjRfdG9fY3B1KHZkZXYsIGRlc2MtPmFk
ZHIpKTsNCj4gPj4NCj4gPj4NCj4gPj4gVGhpcyB3aWxsIGZpeCB0aGUgd2FybmluZyBidXQgbm90
IHRoZSBpc3N1ZSBhdCBoYW5kLiBBcyBEYW4gcG9pbnRlZA0KPiA+PiBvdXQgaW4gaGlzIG9yaWdp
bmFsIGJ1ZyByZXBvcnQsIHRoZSBpc3N1ZSBpcyB0aGF0IGFmdGVyOg0KPiA+Pg0KPiA+PiA3ODAz
NGNiZWNlNzkgKCJwbGF0Zm9ybS9tZWxsYW5veDogbWx4YmYtdG1maWZvOiBEcm9wIHRoZSBSeCBw
YWNrZXQgaWYgbm8NCj4gPj4gZGVzY3JpcHRvcnMiKQ0KPiA+Pg0KPiA+PiBXZSBub3cgaGF2ZSB0
aGlzIElTX1ZSSU5HX0RST1AoKSBjaGVjayBpbiB0aGUgcGF0aCwgd2hpY2ggZGVzcGl0ZQ0KPiA+
PiB0aGUgc3ViamVjdCB3cml0ZXEoZGF0YSwgZmlmby0+dHguZGF0YSk7aXMgY3VycmVudGx5IGJl
aW5nIGFwcGxpZWQgdG8gYm90aCByeA0KPiBhbmQNCj4gPj4gdHggdnJpbmctcw0KPiA+PiBhbmQg
d2hlbiB0aGlzIHJldHVybnMgdHJ1ZSB0aGUgbWVtY3B5IGZyb20gdGhlIHJpbmcgdG8gJmRhdGEN
Cj4gPj4gd2lsbCBub3QgaGFwcGVuLCBidXQgdGhlIGNvZGUgd2lsbCBzdGlsbCBkbzoNCj4gPj4N
Cj4gPj4gd3JpdGVxKGRhdGEsIGZpZm8tPnR4LmRhdGEpOw0KPiA+Pg0KPiA+PiBTbyB5b3UgbWF5
IGhhdmUgc2lsZW5jZWQgdGhlIHdhcm5pbmcgbm93LCBidXQgeW91IHdpbGwgc3RpbGwgd3JpdGUN
Cj4gPj4gZGF0YSBub3QgY29taW5nIGZyb20gdGhlIHZyaW5nIHRvIHRyYW5zbWl0LiBUaGUgb25s
eSBkaWZmZXJlbmNlDQo+ID4+IGlzIHlvdSBhcmUgbm93IGd1YXJhbnRlZWQgdG8gd3JpdGUgYWxs
IHplcm9lcy4NCj4gPj4NCj4gPj4gTm90ZSBhbm90aGVyIG9sZGVyIGlzc3VlIGlzIHRoYXQgaWYg
eW91IGhpdCB0aGUgbm90IGVub3VnaCBzcGFjZQ0KPiA+PiBwYXRoOg0KPiA+Pg0KPiA+PiAgICAg
ICAgfSBlbHNlIHsNCj4gPj4gICAgICAgICAgICAgICAgIC8qIExlZnRvdmVyIGJ5dGVzLiAqLw0K
PiA+PiAgICAgICAgICAgICAgICAgaWYgKCFJU19WUklOR19EUk9QKHZyaW5nKSkgew0KPiA+PiAg
ICAgICAgICAgICAgICAgICAgICAgICBpZiAoaXNfcngpDQo+ID4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbWVtY3B5KGFkZHIgKyB2cmluZy0+Y3VyX2xlbiwgJmRhdGEsDQo+ID4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxlbiAtIHZyaW5nLT5jdXJf
bGVuKTsNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPiA+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG1lbWNweSgmZGF0YSwgYWRkciArIHZyaW5nLT5jdXJfbGVu
LA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsZW4gLSB2cmlu
Zy0+Y3VyX2xlbik7DQo+ID4+ICAgICAgICAgICAgICAgICB9DQo+ID4+ICAgICAgICAgICAgICAg
ICB2cmluZy0+Y3VyX2xlbiA9IGxlbjsNCj4gPj4gICAgICAgICB9DQo+ID4+DQo+ID4+IFRoZW4g
ZXZlbiBpZiBJU19WUklOR19EUk9QKCkgcmV0dXJucyB0cnVlIHlvdSBhcmUgb25seSBpbml0aWFs
aXppbmcgc29tZQ0KPiBieXRlcw0KPiA+PiBvZiB0aGUgOCBieXRlcyBkYXRhIHZhcmlhYmxlIGFu
ZCB0aGUgb3RoZXIgYnl0ZXMgd2lsbCBzdGF5IGF0IHdoYXRldmVyDQo+IHJhbmRvbQ0KPiA+PiB2
YWx1ZSB0aGV5IGhhZCBiZWZvcmUgYW5kIHlvdSBlbmQgdXAgd3JpdGluZyB0aGlzIHJhbmRvbSBi
eXRlcyB3aGVuDQo+IGRvaW5nOg0KPiA+Pg0KPiA+PiB3cml0ZXEoZGF0YSwgZmlmby0+dHguZGF0
YSk7DQo+ID4+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+DQo+ID4+IEhhbnMNCj4gPj4NCj4gPj4NCj4g
Pj4NCj4gPg0KDQo=
