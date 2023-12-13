Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC8B810B40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjLMHO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbjLMHOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:14:45 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF5311B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:14:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iA+L6lSi3Mxr1IB3DRpBdt5vNxLu1rB5Ucnihd6IzcCWYTOpzfiyrlppc+33SDAsfzq8+Izep9w29LgSd1P4OJgRTmzf2d4bBjH0Yo2bfxgnyC8E58Ad3BUqmJ0qPvRMAHm1olNQKM3EXSa5z3LT/ohz193rktOXSBHiQpCgkpKRUn3ZEDB2PqPkvMWSw3AtCf/6j/gyHfzKXjDarWIJ9N4da6zSbq0VtAmF3LpDXLPVgs3dl5D01zMRvEFfIi91zofQKUCoxpfv7UnK29tWiCIpfOpjDiAnAOu1/OfReU9BxuDsK6C53dGH6hoJl5zr0VXQmFePz/b+zwwaGMCeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yRMuZTO92HjjP9nofExiqlYtPA+XYQvpt//WQYZ2+w=;
 b=bkXnU+nsrxSrwUxH5JpMqKxOfguv5/QI8P9Lk+h4ICB5KhazYrwKVhmp8gTsTC9LyZp44bW//NuaBB78c+pflmNmny7WFsjDUPEdzDpxbamScvpUen2wDo8MXi4Mtsj1MxAydVBOWHVlW8/qTmj1HvNot40kCpoRSI8FiLzdg37ty7xS/dHFU1RWcHbfisf3+Fr8cVSB6J9LZkAc6hZlwnwFOC+OAVTYcWyTcRXy7UmxZpzrXZW2hMdK2I7a+d5tKZ2TSTd8HlzS/ys1K2dEIKc7x79l9eGtrhmBUlEmVCFiBSazObkD2wjaSs+6VeCWNvjzXMUl6h1OGcKKDjTLkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yRMuZTO92HjjP9nofExiqlYtPA+XYQvpt//WQYZ2+w=;
 b=NOCun8Sq9woExMUqsVTCFjvVqj/a6ejeYy7aaE2HDrkgJ+jsaSBaAHtR8xi882bxjq9vby1NoQo1B7M1yh2qgl8DedUDEUuu1VvWQBAzKRHwiLasGVBAyPdxYyzPSYM16uxnAg5DMHvcJcsJ7nm5e3VNFxzvBrTEb9bA1NHjITQ=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 07:14:40 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 07:14:40 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        Jan Beulich <jbeulich@suse.com>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
Thread-Topic: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
Thread-Index: AQHaHsGdlNZnjmvNCkucW725DqxYz7CSRC+AgADLdgCAALwOgIAAX9AAgAE42ICAA5dDgIAAxsiAgAC4TACAABRoAIABzBGAgAf5bQCAATuOgP//4n+AgAANqwCAABvwgIAAAHmAgAAFlQCAAczKgA==
Date:   Wed, 13 Dec 2023 07:14:40 +0000
Message-ID: <BL1PR12MB5849094EEE3FCE80C9FCBD48E78DA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <alpine.DEB.2.22.394.2312041413000.110490@ubuntu-linux-20-04-desktop>
 <ZW7rDjjC0gxEI1cq@macbook> <15275706-5c31-4e29-aa29-9f5e90526219@suse.com>
 <BL1PR12MB5849C871B0B9577D1E0BF576E784A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXculMdLgwGaRC7i@macbook>
 <BL1PR12MB584997DDE6839F2340022976E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXgeieg4E8UN0KoN@macbook> <50ca26a1-38e3-45fb-9c39-56e4d04de3e0@suse.com>
 <ZXhBb0Vt6gDuprHa@macbook> <c5d4e8a4-b286-4352-bf96-a67cb132b452@suse.com>
 <ZXhGhKkcmlEZOpwZ@macbook>
In-Reply-To: <ZXhGhKkcmlEZOpwZ@macbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB8495.namprd12.prod.outlook.com
 (15.20.7113.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DM6PR12MB4436:EE_
x-ms-office365-filtering-correlation-id: 86e414a8-981b-4ed2-dc4b-08dbfbab2c4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qpUYoiSOTloduMAgkvEmccaHypsMbEOymcighg7aai5ZcA93W51ec2gGXamSFLSV7z6ie84tDO8mXQOVrD0UAMOyfpFTqPq+XhqkdzHfzg4mjNcfq+SjrcCIOns0F87ze6rXrTK7baecuai4F0ZIQ1UL2EY/yRnF73n51fVT+cc34P8V7SJXH2S3rwI1J5NN955SqZIpZBfcKGBWlQ7kN9WObJFqvWlbvk6XBymP3kCkiTsi2TcKBB5PK2CNSq2A90epXUmLga+2to/jLhHRVIfRQzQyf2a9Hz2y9Wtetn05Ke+Ai49aFu0JcJVCxSjTzi17QpWXtXLkuunYn09OocR5SbOtYZSnsE0U6hWZgpK3Q4PP9Zf0VCoHcUVwvqe1f4GHbAAOalv9NzB+al33TbhvN76OcQoOiuYDo2vuP4U5gJk9MWRSXbUNpcv5Zqm2rJ0a8eHtQDoZw0o1oD6fjc35YSCe1V1zC/cAsMXmGIkF9puWVxBbhOspIhxiYTc9MlczrxxhvzPLzUYG0h3lGzl7hFFyreBL6NBVw7UnSyh3PFeCVwPGNQXwaXxjZroGPQjNPeEvIT1l996RwNZlsYByLi2eS2XtdT+iJSzFlZJVSy8wb4ObZuTphi6oSSD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(55016003)(83380400001)(26005)(478600001)(71200400001)(9686003)(53546011)(7696005)(6506007)(76116006)(54906003)(66446008)(64756008)(66476007)(66556008)(66946007)(316002)(110136005)(8676002)(4326008)(8936002)(38100700002)(122000001)(5660300002)(2906002)(38070700009)(41300700001)(52536014)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2ZjaEprRDBvTkx1MXdzc2Z5b3pEaE5EcmpVcDJidDZFZGVMc0M2d3ZBenU2?=
 =?utf-8?B?eUFRaFdUaW0rUW9tMWovd3VaK0dUSFpLNVdzeFhwT1RuSEpNNDRFZEdRV0wv?=
 =?utf-8?B?NjF0WFRnNUkzU3Nabi9zN1RRRTY4aUdqZFNRdWliU1dWbmlOand3U3FwSkwr?=
 =?utf-8?B?WEhIT1dRWlU2SDBPVE41eC9FMGo0TmdsbFF6a1NFeDBwNHJkSVRWbm9Baktw?=
 =?utf-8?B?UkRxZHVnY2FTSkdkZytWTVY2MEZ4aWRQWDdUUVNKN3hrOGJFcXE4WWZuVGUr?=
 =?utf-8?B?VllCcDBvYmR3ZjBwMFpwWi9Sbzc4TnVZYnhEZHIvWFcxanhuQzdHS2RzUmFi?=
 =?utf-8?B?eSt5VmdTbVFwNE51dE9jSm1XU3g4TFlZS2x0S3RsTTFiUEF5V2RMb1pzemoy?=
 =?utf-8?B?elBWRlY2a2kzOW9FaTg0ZVgvRDlrdDBjQVIvNWNTSnE0bmJqR211dkkyL0Nr?=
 =?utf-8?B?Mnc3QUdVNko2Nk4rZlNqdXpZZGJKeHAvZ1ZjeStJUWI5UnBuQVFGQkxRN2NE?=
 =?utf-8?B?NEJnZURPY0p0NHJqcjJHbUZtT1l5Z1lmclRWc3lGY1o0RHAvdlNSNk1Ybnlm?=
 =?utf-8?B?STJveVFJRndrSkRoSkFQU3I5ZXM0MDc0UmY2ZWFLMEJiZVFtZEhxeThscDFQ?=
 =?utf-8?B?ZDE4T1BIWmRTRGExcTkwTi9vUStPSG9UdS9HL3RmeUU4YUhsRy9nc3puOTBh?=
 =?utf-8?B?dTVFWjBSbko0VlQwNmpPMER5dzd5KzVWRGVLWWY4TkNHRmQyUzYrMmRVbzFt?=
 =?utf-8?B?UTl3a2QwdW1BUGszU29BNlE0cHUwcWJNREU1Q1Z3a2cxZWhxdFNlOUdPdWZh?=
 =?utf-8?B?c2NFd0w4V3ArTFF3RU4ydlE0L3ZSOGd6UXo2U0hLRm0zUDVXY2tNY0NocEd1?=
 =?utf-8?B?Wk9FQlVXcUF3N2l0MVhKTEFVdXgxd1pPRml1eVlFRElvb3o3VDB5YWZnVHA5?=
 =?utf-8?B?Z2s5R2xhRFd2d1QrUHo0UXoxLzhrVVNhc2xvN0dLWXZnTjZFWm1MdVk5dHBK?=
 =?utf-8?B?L1AwQlEzMW9zQ01sNnNmQmJEaG5yc0M3ZTMrZGN1L1d3M1B4SWFrYWhTL1hS?=
 =?utf-8?B?ZmtRYjNaTmp5WnZZQVd3ZjZvaFFDL2hWaTZBUlp3MWpvYTZaUS9KMFV0UGd3?=
 =?utf-8?B?N0pSZXZ5QitsbWJXanJ0VlBIOHhwdmh2N3h4bjl0M200aWZXL0ZiZUtmUU9a?=
 =?utf-8?B?WjNpTldRZERCV2dQRGk0NzdqTUhFVElIcHBLZUJONEw1KytSVDU4V21ZNGRK?=
 =?utf-8?B?TmxUVElZQlJoeTRHR0RHOURKQldlUElLYUJhUzV2ckd2N1RUWVZPeUs1aXor?=
 =?utf-8?B?Q1V3YTV4bFJWQjNpdmdaSXZiTHFoT1ZHRjgzWmJhUVdoVVRKdVJRKzNnSGxy?=
 =?utf-8?B?V1JvTndJZzNueFZzSmFibktnSEl3TVVQOG9yRWRMSmQ4OWYzdHEzRWxOL3dC?=
 =?utf-8?B?MTg0NEZrUWo3WnhPMXZnYlZDK29wdWI1d09zdUEvc0JleWk5R3YrR0tYU1RZ?=
 =?utf-8?B?VzgvaGlNc0pKK3BmZGRoRG1YbXVocUJYMWdxVXhiOEtBdnUvM1RrajVTeHgx?=
 =?utf-8?B?M0R5ZUJEb0ljTUFXS3VkM2w0RW9tQThLSFRKMnk2amltOHJmOXYrL2ZHcXR1?=
 =?utf-8?B?cVFuOStGcmgzc0p0TEZRNk5hQmtxQytzNUZ3bzByUHJ5U3NBTmV4dlIzRnFX?=
 =?utf-8?B?eTlqeTNWWHM2eXRvdFo1Znp5ZFBxRnFIVmdCaHZLbThLcDRpY1FTbml1T3Jq?=
 =?utf-8?B?dTlHVUVxRDM5cE1LRHNiY1pzL2xhMU9nYlBlckt1VDh5d0h6Q3MveFF3N1VJ?=
 =?utf-8?B?Ymp4MkdybTdReTFsTElXVlNjcUFVcktuWVFQUFhYRk91QkNueE9SRG1KZ2Rl?=
 =?utf-8?B?Z0tUdGZkbjErVGx5elpVQm5mMjJtcE5lU3JyYW9SUm9iT0NKcjRaMS8yRlF1?=
 =?utf-8?B?UGt3T2RRZHladnNROWlPRDVuTlpOWkNzeGplSVhVeUhiRWhMRlduM1hTWkov?=
 =?utf-8?B?TG9RZTcyOWRhRm5KM2ZhejRZUmJUU045bDN5VUk0Vy9DZTBiSkhWK283VnhR?=
 =?utf-8?B?M2dHZE9YMDRack9oY3pxc1M2c0dsQkJMQTBzK3hUVCthL0s1dTRYa2pHNWJN?=
 =?utf-8?Q?/gUY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF9B457C68259148B0CCECAE3F8C77F5@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e414a8-981b-4ed2-dc4b-08dbfbab2c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 07:14:40.4204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2N6jpWTAUmtegMAEUMQksjJKEPSw9AXhROWDz5ovT7v/+36TgEOIgujDx+TnMyFu490pPVt+EQZxT2dw7OdaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMy8xMi8xMiAxOTozOSwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4gT24gVHVlLCBE
ZWMgMTIsIDIwMjMgYXQgMTI6MTk6NDlQTSArMDEwMCwgSmFuIEJldWxpY2ggd3JvdGU6DQo+PiBP
biAxMi4xMi4yMDIzIDEyOjE4LCBSb2dlciBQYXUgTW9ubsOpIHdyb3RlOg0KPj4+IE9uIFR1ZSwg
RGVjIDEyLCAyMDIzIGF0IDEwOjM4OjA4QU0gKzAxMDAsIEphbiBCZXVsaWNoIHdyb3RlOg0KPj4+
PiAoSSB0aGluayB0aGUgQ2MgbGlzdCBpcyB0b28gbG9uZyBoZXJlLCBidXQgdGhlbiBJIGRvbid0
IGtub3cgd2hvIHRvDQo+Pj4+IGtlZXAgYW5kIHdobyB0byBwb3NzaWJseSBkcm9wLikNCj4+Pj4N
Cj4+Pj4gT24gMTIuMTIuMjAyMyAwOTo0OSwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4+Pj4+
IE9uIFR1ZSwgRGVjIDEyLCAyMDIzIGF0IDA2OjE2OjQzQU0gKzAwMDAsIENoZW4sIEppcWlhbiB3
cm90ZToNCj4+Pj4+PiBPbiAyMDIzLzEyLzExIDIzOjQ1LCBSb2dlciBQYXUgTW9ubsOpIHdyb3Rl
Og0KPj4+Pj4+PiBPbiBXZWQsIERlYyAwNiwgMjAyMyBhdCAwNjowNzoyNkFNICswMDAwLCBDaGVu
LCBKaXFpYW4gd3JvdGU6DQo+Pj4+Pj4+PiArc3RhdGljIGludCB4ZW5fcHZoX3NldHVwX2dzaShn
c2lfaW5mb190ICpnc2lfaW5mbykNCj4+Pj4+Pj4+ICt7DQo+Pj4+Pj4+PiArICAgICAgIHN0cnVj
dCBwaHlzZGV2X3NldHVwX2dzaSBzZXR1cF9nc2k7DQo+Pj4+Pj4+PiArDQo+Pj4+Pj4+PiArICAg
ICAgIHNldHVwX2dzaS5nc2kgPSBnc2lfaW5mby0+Z3NpOw0KPj4+Pj4+Pj4gKyAgICAgICBzZXR1
cF9nc2kudHJpZ2dlcmluZyA9IChnc2lfaW5mby0+dHJpZ2dlciA9PSBBQ1BJX0VER0VfU0VOU0lU
SVZFID8gMCA6IDEpOw0KPj4+Pj4+Pj4gKyAgICAgICBzZXR1cF9nc2kucG9sYXJpdHkgPSAoZ3Np
X2luZm8tPnBvbGFyaXR5ID09IEFDUElfQUNUSVZFX0hJR0ggPyAwIDogMSk7DQo+Pj4+Pj4+PiAr
DQo+Pj4+Pj4+PiArICAgICAgIHJldHVybiBIWVBFUlZJU09SX3BoeXNkZXZfb3AoUEhZU0RFVk9Q
X3NldHVwX2dzaSwgJnNldHVwX2dzaSk7DQo+Pj4+Pj4+PiArfQ0KPj4+Pj4+Pg0KPj4+Pj4+PiBI
bSwgd2h5IG5vdCBzaW1wbHkgY2FsbCBwY2liaW9zX2VuYWJsZV9kZXZpY2UoKSBmcm9tIHBjaWJh
Y2s/ICBXaGF0DQo+Pj4+Pj4gcGNpYmlvc19lbmFibGVfZGV2aWNlIGhhZCBiZWVuIGNhbGxlZCB3
aGVuIHVzaW5nIGNtZCAieGwgcGNpLWFzc2lnbmFibGUtYWRkIHNiZGYiIGZyb20gcGNpYmFjay4g
QnV0IGl0IGRpZG4ndCBkbyBtYXBfcGlycSBhbmQgc2V0dXBfZ3NpLg0KPj4+Pj4+IEJlY2F1c2Ug
cGNpYmlvc19lbmFibGVfZGV2aWNlLT4gcGNpYmlvc19lbmFibGVfaXJxLT4gX19hY3BpX3JlZ2lz
dGVyX2dzaShhY3BpX3JlZ2lzdGVyX2dzaV9pb2FwaWMgUFZIIHNwZWNpZmljKQ0KPj4+Pj4+PiB5
b3UgYXJlIGRvaW5nIGhlcmUgdXNpbmcgdGhlIGh5cGVyY2FsbHMgaXMgYSBiYWNrZG9vciBpbnRv
IHdoYXQncyBkb25lDQo+Pj4+Pj4+IGF1dG9tYXRpY2FsbHkgYnkgWGVuIG9uIElPLUFQSUMgYWNj
ZXNzZXMgYnkgYSBQVkggZG9tMC4NCj4+Pj4+PiBCdXQgdGhlIGdzaSBkaWRuJ3QgYmUgdW5tYXNr
ZWQsIGFuZCB2aW9hcGljX2h3ZG9tX21hcF9nc2kgaXMgbmV2ZXIgY2FsbGVkLg0KPj4+Pj4+IFNv
LCBJIHRoaW5rIGluIHBjaWJhY2ssIGlmIHdlIGNhbiBkbyB3aGF0IHZpb2FwaWNfaHdkb21fbWFw
X2dzaSBkb2VzLg0KPj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gSSBzZWUsIGl0IGRvZXMgc2V0dXAgdGhl
IElPLUFQSUMgcGluIGJ1dCBkb2Vzbid0IHVubWFzayBpdCwgdGhhdCdzDQo+Pj4+PiB3aGF0IEkg
ZmVhcmVkLg0KPj4+Pj4NCj4+Pj4+Pj4gSXQgd2lsbCBiZSBtdWNoIG1vcmUgbmF0dXJhbCBmb3Ig
dGhlIFBWSCBkb20wIG1vZGVsIHRvIHNpbXBseSB1c2UgdGhlDQo+Pj4+Pj4+IG5hdGl2ZSB3YXkg
dG8gY29uZmlndXJlIGFuZCB1bm1hc2sgdGhlIElPLUFQSUMgcGluLCBhbmQgdGhhdCB3b3VsZA0K
Pj4+Pj4+PiBjb3JyZWN0bHkgc2V0dXAgdGhlIHRyaWdnZXJpbmcvcG9sYXJpdHkgYW5kIGJpbmQg
aXQgdG8gZG9tMCB3aXRob3V0DQo+Pj4+Pj4+IHJlcXVpcmluZyB0aGUgdXNhZ2Ugb2YgYW55IGh5
cGVyY2FsbHMuDQo+Pj4+Pj4gRG8geW91IHN0aWxsIHByZWZlciB0aGF0IEkgY2FsbGVkIHVubWFz
a19pcnEgaW4gcGNpc3R1Yl9pbml0X2RldmljZSwgYXMgdGhpcyB2MiBwYXRjaCBkbz8NCj4+Pj4+
PiBCdXQgVGhvbWFzIEdsZWl4bmVyIHRoaW5rIGl0IGlzIG5vdCBzdWl0YWJsZSB0byBleHBvcnQg
dW5tYXNrX2lycS4NCj4+Pj4+DQo+Pj4+PiBZZWFoLCB0aGF0IHdhc24ndCBnb29kLg0KPj4+Pj4N
Cj4+Pj4+Pj4NCj4+Pj4+Pj4gSXMgdGhhdCBhbiBpc3N1ZSBzaW5jZSBpbiB0aGF0IGNhc2UgdGhl
IGdzaSB3aWxsIGdldCBtYXBwZWQgYW5kIGJvdW5kDQo+Pj4+Pj4+IHRvIGRvbTA/DQo+Pj4+Pj4g
RG9tMCBkbyBtYXBfcGlycSBpcyB0byBwYXNzIHRoZSBjaGVjayB4Y19kb21haW5faXJxX3Blcm1p
c3Npb24oKS0+IHBpcnFfYWNjZXNzX3Blcm1pdHRlZCgpLCANCj4+Pj4+DQo+Pj4+PiBDYW4gd2Ug
c2VlIGFib3V0IGZpbmRpbmcgYW5vdGhlciB3YXkgdG8gZml4IHRoaXMgY2hlY2s/DQo+Pj4+Pg0K
Pj4+Pj4gT25lIG9wdGlvbiB3b3VsZCBiZSBncmFudGluZyBwZXJtaXNzaW9ucyBvdmVyIHRoZSBJ
UlEgaW4NCj4+Pj4+IFBIWVNERVZPUF9zZXR1cF9nc2k/DQo+Pj4+DQo+Pj4+IFRoZXJlJ3Mgbm8g
ZG9tYWluIGF2YWlsYWJsZSB0aGVyZSwgYW5kIGltbyBpdCdzIGFsc28gdGhlIHdyb25nIGludGVy
ZmFjZSB0bw0KPj4+PiBwb3NzaWJseSBncmFudCBhbnkgcGVybWlzc2lvbnMuDQo+Pj4NCj4+PiBX
ZWxsLCB0aGUgZG9tYWluIGlzIHRoZSBjYWxsZXIuDQo+Pg0KPj4gR3JhbnRpbmcgcGVybWlzc2lv
biB0byBpdHNlbGY/DQo+IA0KPiBTZWUgYmVsb3cgaW4gdGhlIHByZXZpb3VzIGVtYWlsLCB0aGUg
aXNzdWUgaXMgbm90IHdpdGggdGhlDQo+IHBlcm1pc3Npb25zLCB3aGljaCBhcmUgY29ycmVjdGx5
IGFzc2lnbmVkIGZyb20NCj4gZG9tMF9zZXR1cF9wZXJtaXNzaW9ucygpLCBidXQgdGhlIHVzYWdl
IG9mIGRvbWFpbl9waXJxX3RvX2lycSgpIGluDQo+IHBpcnFfYWNjZXNzX3Blcm1pdHRlZCgpIGFz
IGNhbGxlZCBieSBYRU5fRE9NQ1RMX2lycV9wZXJtaXNzaW9uLg0KPiBUaGVyZSdzIG5vIG5lZWQg
dG8gcGxheSB3aXRoIHRoZSBwZXJtaXNzaW9ucyBhdCBhbGwuDQpZZXMsIHRoZSBwcm9ibGVtIGlz
IHBjaV9hZGRfZG1fZG9uZS0+IHhjX2RvbWFpbl9pcnFfcGVybWlzc2lvbi0+IFhFTl9ET01DVExf
aXJxX3Blcm1pc3Npb24tPiBwaXJxX2FjY2Vzc19wZXJtaXR0ZWQtPmRvbWFpbl9waXJxX3RvX2ly
cS0+cmV0dXJuIGlycSBpcyAwLCBzbyBpdCBmYWlsZWQuDQpJIGFtIHRoaW5rIHRoYXQgc2luY2Ug
dGhlIFBWSCBkb2Vzbid0IHVzZSBwaXJxLCBjYW4gd2UganVzdCBza2lwIHRoaXMgaXJxX3Blcm1p
c3Npb24gY2hlY2sgZm9yIFBWSD8NCg0KPiANCj4gUmVnYXJkcywgUm9nZXIuDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQo=
