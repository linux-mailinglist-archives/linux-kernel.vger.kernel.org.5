Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885A17D48EE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjJXHtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjJXHtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:49:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E120B7;
        Tue, 24 Oct 2023 00:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVdrvtQggF3j6pe5+p+hdG4eHDkkKlttRZEAq8DUh7ihYSFx2Zh6URa+l07K/poZbpoGVejay4AGhDc88onrcggbFHxfIltfEwDDk+fPhEZ31hTKAOt75iiXWq6pBzwV+53u3LOERE141k3jIJXFtdDgv59kHsaH9lq4OKvAVFPpLQGADrdQy/Oc79McdMvtJ+Od9IKuqL3skb/C+THNNz+ELWwfEfg4s8zTw3dm3F6/0b63d7wmSCZ+i9qLPlKovAIYkdTq4YIbKkH4cHdJCSX0F/+KEBMTYHtkVHzjqyNx6kXaDNFwL7xwn57npQYGXEm1ozR8waJHSSJWIsj7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl7ybY8ZuaY38x3jIFLP4lymermMcBSAh7llRLxIlrg=;
 b=XbZ7ghVXOaIMEKZj4jTqka/o/0rLSB9TYqINsOs9RaPy5fvBdvJw4rXRywFLg9uBPWA0nCQK+Twzf2TqrStSf/6+sek/FdV4A5IV3d+TkDvUuz9wmJT+4EX/78mCb2fQ7GvvNSOlsQPL9XWFR4GisLX72D6bQQKNkt9XPSOAzAILU8e3snre+2GJMo0NH6hvt943PXtvPDy2nZ1UBQFVhqzT3izdgDEcJ89JgiK8tFDezLKrofGZizpEpSz1OZidbtM+P/rFiGAonlAPr8RNPWRRNZMlzbi+01Pwk/N6ufbS+jTgBJQZauGI3Q8mZWoZA0urpFvlOdPoA0RLOjJ1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl7ybY8ZuaY38x3jIFLP4lymermMcBSAh7llRLxIlrg=;
 b=Z/zRiOIvnUGS+ZC7YZmWnYjYEG1pteki3pJL8hgyG/5EYBm4v6/jnTBnMTNVtQRFwjF7cuzSorLSbYrHYrIo0AlL/7xXSUR5HUg+8sd39i0kysjwzqH6h/WAFDJL7l3uF31LxkRRhpUFR6d5beZemMn6FYNkA3U0bj+cnF7SqMRp+SWid7YEU9FUnA+tl06Ocfhg5CDpm7jxgwGuz8QAAAvHa1YWtQE0XbkpcYbeG0qKWy9/MWtJLNwJE+AMVsf+6eplBU13eU9PGa83gSsMF8eFDrQ6xjKIaEcmRsecqphI01+UAxGLok9kVFy4CjwSXVVFDveM+iC4TZbnY6fAvA==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by CH0PR12MB5170.namprd12.prod.outlook.com (2603:10b6:610:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 07:49:14 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::2dac:8d19:a151:8555]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::2dac:8d19:a151:8555%3]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 07:49:14 +0000
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vhost-vdpa: fix NULL pointer deref in _compat_vdpa_reset
Thread-Topic: [PATCH] vhost-vdpa: fix NULL pointer deref in _compat_vdpa_reset
Thread-Index: AQHaBgcRgMIao9htJk+9HGzjumPJbbBYkRqA
Date:   Tue, 24 Oct 2023 07:49:14 +0000
Message-ID: <c72ed78afaa8c1de803d3b4bd6624cbc032e7d4f.camel@nvidia.com>
References: <1698102863-21122-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1698102863-21122-1-git-send-email-si-wei.liu@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|CH0PR12MB5170:EE_
x-ms-office365-filtering-correlation-id: d5119cc8-54df-4498-d2f5-08dbd465b7a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27wc1T9WAh0OFvHfgozUEJbvuzjlxyJhCUi3gUWYOb8wgBQ+RdAkWYsM0xd1WnBR7uBJnrr8LXbMSvqPmDwaduX6GpNNOWwfF6+2xzuvZ4l7KN8SEvPbU/RVSLU+Y391Auz5wa/dhRbwLCtbpq8XhPNbY76VSynixgKbKDw4tZGawmjNfZPlfS7ynFMGt7vqBTpUbq+UpA6J1gZV2AU2NfJ2DhghJDjUxmoKcnDR3vD2yDmMdq2m9dVeAdGYEp1uF4XMxkDlMKsNPl+UldIMXqtrl/chygEQyxmQT2AcEgET6dmT1F762Cu0E3vb5Ouatdsf+BrewKNX5z8aMJ78g1j4cuOFHU9Hipqn48h+QgfJFFLi4TAcgEE/1cGtJ7DG04svYcJ/xz0QZAOgJCt8EQoMPlHjHipuAUtRfG55XgtdADMIAbWuTsiLvo8BwMWzxRpQoTTEuY5y4j0bi0okKfktOPrCwMKmlkqqj3V1H4xEu75XSL7syqeI1pH8+/UguGlMg7CuLbdn9bprV3AszPCsq4SSY3l4bD2TqPtytTVvVXgpGidRrehGwPraAbdRJB5STzdpngxS3zwRp+REzum6Axv+E9R8pSEbLquqbSmfKczlddQfDrvqt1xBCJRlh1JqBbIVjzkt854vXibeqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(38070700009)(71200400001)(4001150100001)(8936002)(2906002)(4326008)(36756003)(8676002)(2616005)(38100700002)(122000001)(6506007)(6512007)(316002)(478600001)(966005)(6486002)(5660300002)(66556008)(76116006)(66946007)(86362001)(66446008)(110136005)(54906003)(66476007)(41300700001)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmxDOWM3cGFDbDRyN1ZXaDNBaVNjdzRqcWtrVkp6NHo0OVEza1NkYTZzTllW?=
 =?utf-8?B?RUY5ak5aeTNoTUxMZDdQUG90Y2lEWjBJaUc1bDFvVC85M3UvZ2wvcUQ3RWtT?=
 =?utf-8?B?UlZGVFJDdUJxRTMzY3l2UVZ1cnlZMXVkKzU3MlJ3aldOaFJnR0VVSnE2NGQv?=
 =?utf-8?B?OE1iMHZwKzBFV08zbFFXdHk5SWhydWlzRXQ0d0MyZkhlV3Jpd2dRZit6bk84?=
 =?utf-8?B?M3lxSEtzZWpmZTE0bk4xV0dad28vRUtXNlFYekdNeHZ4eDZzSWYxQXYrdUtu?=
 =?utf-8?B?cko0b1JmK0REelN3b0xEbW9NcXU1aTNkdGZLSW1wdlIwN215RGdpeDVGS2Zt?=
 =?utf-8?B?TDlnbkc5RWlzQysxN3ByZWFGYWYva1U0QThmNEFWcTVNTXVmc1BJYlhEb3hC?=
 =?utf-8?B?eGJ0UkdVV0R4YU1HRTFUdGRhZkdGcm9GNTRxdytKTGdPMXRueWtpOHRGZlRB?=
 =?utf-8?B?MmFjYWFuV0FxZWVSZFprRkQrcHNrbFdSYTMzSlFEbTZ0RHdmRGZZRXEyVmN3?=
 =?utf-8?B?OG93TnZQMmozakc4L0ZOMDBOMHZpWlBUVUtVNks2djU1MTJ6Vm1mVUI4c2wx?=
 =?utf-8?B?a2QzYjJmQURrL2QvN0RqVGpsejMvNytXc1dqR2EyU1BDdE10OXJ0ZWUrNHBy?=
 =?utf-8?B?Z0tyMWEvOGNSS2hFRzBRUlgraFFVSTlFWHdUR3lCYlJaQmFUMnVOSlVRKzVZ?=
 =?utf-8?B?dWxub3hib2FVZ3M5WkF1UXp1dy90a2lzZ0JIVmFKZ0JOeEdrZkhNazA4SzFo?=
 =?utf-8?B?SkZhQjBycEZvVzhSQUJ3eHlvR0xxa3hGazYxNWc5WG1sQ1hKYXFHSmEyck9s?=
 =?utf-8?B?ZXp2Ly9iYU81YkdhMTF2eVo4d1phT21YZzhhWEpvS2YwaVpuNE8xclFjd0tm?=
 =?utf-8?B?YjlmUDZncUtXa0lXQkh6Z0ZSUVB4a09RZmRVVDM5L3ZmNTU5OXdtcWlZcXhp?=
 =?utf-8?B?WWhyZ2JJVmNDZHUvWUs2RFk4d3lzcjZJTUVkNTI4MjJXQzdEa3krNXQrY0tV?=
 =?utf-8?B?d1ppWWM4VkM5OCtuRUNsZGFDL1dCTTZQeUJsenl3QjQrdVFwUGM1bVBVQ3ZO?=
 =?utf-8?B?U0tVY3M1NXV2aDdUWThDMVhSbVAvQVZJdHF3N3I3eU56ZERMVFNOT3FQcjYv?=
 =?utf-8?B?YVFNRGluaDRzdHhRSDVhOFc4OHloZ2c2OXZoOTE4NVhObkdndk5wam45UFBp?=
 =?utf-8?B?dTJhZW91OS9TQVhMZWVsNWNqN1g0WVBJR21BV0tYSDFLaDRXcjdtNTdCTnJw?=
 =?utf-8?B?dkdGWnh4UCtuQXVDWmNnSi92SjB4OUY3cXBzejQ0L2NSQjVkbzNFTklJWjU5?=
 =?utf-8?B?RnNxN1BkVnJwTVFCaUU1VzVXaXBXdnZHSVl1dXZPZVppaWFPNGJCVDJDUzlt?=
 =?utf-8?B?WTZVSjhRaHAvZGpBRE12ZVpjU2NHaXFUSWtsTEdOVDZwUXRPbEErclUzdkFa?=
 =?utf-8?B?dHQ3M1VFS0g0aVhIaUJjcEpuU1RHakFhNUdKMnFRcm5WNUxHU2tsV3diTENo?=
 =?utf-8?B?Z0cwZnlGZ01reDZ2bDVXWUZFd3NvV3JKTVhDNXNJWGJMMTBGMEVOQ3gwdUsx?=
 =?utf-8?B?RWJvUmozcnl0OGpZVys4SGlSK0pRaFpnU05DVHpXWklJdC9rZFp4MXdwQ01i?=
 =?utf-8?B?alFsdHJPRjdETldpd292a1Jtc25qTXpoTXJSQS90Vnk4aDhEakVTODZ2ZUxG?=
 =?utf-8?B?NW9wM09SdUdBa0J4ek9yVmp0bXFxcWVsM0NacWZmWGR1Vk9KRndGRTlCZk1m?=
 =?utf-8?B?VVY0UmE3bTlUTkxNUVkyY1FkdHBaTFo5ejdVZW5GREFzelJkV3Fkd2ZMVTFi?=
 =?utf-8?B?RTFYNFRCZnZjMi9RdjlhckkxOEtBNGp5K2pLT0ZyTkNNaWhoUU9QTENwNG0w?=
 =?utf-8?B?VUIxc3dCYWlYRmxmd1lDdDVDbFFmaURCelZSdFdQcXdEc3QzUXQ1eXYzQ2t4?=
 =?utf-8?B?bGkzRml6R3YwTGRjUmgyN0N4LzMyVTFYRCtJWFZ0cFNjOXh0SFJ2c0NaaERm?=
 =?utf-8?B?UVJaYjk4Ym9yZVI1R3VnNXFIbkdocjJxdDViUW5PR081WXpFR1Y4L3d1c2dO?=
 =?utf-8?B?VHVVSVVRVlphRCtFNm1ielg0dk00R0JCblV0aXM0OUMwWm8ySWVyMmJVYllX?=
 =?utf-8?B?MVRxZ05pdWpLcjJEYkZlQjZyTE9MMHh6eGw2bGkwUWNmS003UXVBaElTWFJ3?=
 =?utf-8?Q?7cQfNH0gVU0brcmlHjSrSp6Vh+GsKvTj9GAi5mupJqjW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48E8E662548BAC46A8CB372D5E9A2CC3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5119cc8-54df-4498-d2f5-08dbd465b7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 07:49:14.0364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8U/T18w46nN86TctXO+zET+w7M2BdCp64P+I5KvJUrPaRTqkzh3cDC8GC6ClGFXgZHTNQHnR/zi/LqS5nt0Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5170
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTIzIGF0IDE2OjE0IC0wNzAwLCBTaS1XZWkgTGl1IHdyb3RlOg0KPiBB
cyBzdWJqZWN0LiBUaGVyZSdzIGEgdmhvc3RfdmRwYV9yZXNldCgpIGRvbmUgZWFybGllciBiZWZv
cmUNCj4gdmhvc3RfZGV2IGlzIGluaXRpYWxpemVkIHZpYSB2aG9zdF9kZXZfaW5pdCgpLCBlbmRp
bmcgdXAgd2l0aA0KPiBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UuIEZpeCBpcyB0byBjaGVjayBp
ZiB2cXMgaXMgaW5pdGlhbGl6ZWQNCj4gYmVmb3JlIGNoZWNraW5nIGJhY2tlbmQgZmVhdHVyZXMg
YW5kIHJlc2V0dGluZyB0aGUgZGV2aWNlLg0KPiANCj4gwqAgQlVHOiBrZXJuZWwgTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDAwDQo+IMKgICNQRjogc3Vw
ZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KPiDCoCAjUEY6IGVycm9yX2NvZGUo
MHgwMDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UNCj4gwqAgUEdEIDAgUDREIDANCj4gwqAgT29wczog
MDAwMCBbIzFdIFNNUA0KPiDCoCBDUFU6IDMgUElEOiAxNzI3IENvbW06IHFlbXUtc3lzdGVtLXg4
NiBOb3QgdGFpbnRlZCA2LjYuMC1yYzYrICMyDQo+IMKgIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3Rh
bmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIHJlbC0NCj4gwqAgYTRhZWIwMi1wcmVi
dWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0DQo+IMKgIFJJUDogMDAxMDpfY29tcGF0X3ZkcGFfcmVz
ZXQrMHg0Ny8weGMwIFt2aG9zdF92ZHBhXQ0KPiDCoCBDb2RlOiBjNyBjNyBmYiAxMiA1NiBhMCA0
YyA4ZCBhNSBiOCAwMiAwMCAwMCA0OCA4OSBlYSBlOCA3ZSBiOCBjNA0KPiDCoCA0OCA4OSBlZSA0
OCBjNyBjNyAxOSAxMyA1NiBhMCA0YyA4YiBhZCBiMCAwMiAwMCAwMCA8NDg+IDhiIDAwIDQ5DQo+
IMKgIDAwIDQ4IDhiIDgwIDg4IDQ1IDAwIDAwIDQ4IGMxIGU4IDA4IDQ4DQo+IMKgIFJTUDogMDAx
ODpmZmZmODg4MTA2M2MzYzM4IEVGTEFHUzogMDAwMTAyNDYNCj4gwqAgUkFYOiAwMDAwMDAwMDAw
MDAwMDAwIFJCWDogZmZmZjg4ODEwNzRlYjgwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANCj4gwqAg
UkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogZmZmZjg4ODEwM2FiNDAwMCBSREk6IGZmZmZmZmZm
YTA1NjEzMTkNCj4gwqAgUkJQOiBmZmZmODg4MTAzYWI0MDAwIFIwODogMDAwMDAwMDBmZmZmZGZm
ZiBSMDk6IDAwMDAwMDAwMDAwMDAwMDENCj4gwqAgUjEwOiAwMDAwMDAwMDAwMDAwMDAzIFIxMTog
ZmZmZjg4ODg3ZmVjYmFjMCBSMTI6IGZmZmY4ODgxMDNhYjQyYjgNCj4gwqAgUjEzOiBmZmZmODg4
MTA2ZGJlODUwIFIxNDogMDAwMDAwMDAwMDAwMDAwMyBSMTU6IGZmZmY4ODgxMDc0ZWJjMTgNCj4g
wqAgRlM6wqAgMDAwMDdmMDJmYmE2ZWYwMCgwMDAwKSBHUzpmZmZmODg4ODVmOGMwMDAwKDAwMDAp
DQo+IMKgIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gwqAgQ1M6wqAgMDAxMCBEUzogMDAwMCBF
UzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gwqAgQ1IyOiAwMDAwMDAwMDAwMDAwMDAw
IENSMzogMDAwMDAwMDEzMjVlNTAwMyBDUjQ6IDAwMDAwMDAwMDAzNzJlYTANCj4gwqAgRFIwOiAw
MDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAw
MDANCj4gwqAgRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6
IDAwMDAwMDAwMDAwMDA0MDANCj4gwqAgQ2FsbCBUcmFjZToNCj4gwqDCoCA8VEFTSz4NCj4gwqDC
oCA/IF9fZGllKzB4MWYvMHg2MA0KPiDCoMKgID8gcGFnZV9mYXVsdF9vb3BzKzB4MTRjLzB4M2Iw
DQo+IMKgwqAgPyBleGNfcGFnZV9mYXVsdCsweDc0LzB4MTQwDQo+IMKgwqAgPyBhc21fZXhjX3Bh
Z2VfZmF1bHQrMHgyMi8weDMwDQo+IMKgwqAgPyBfY29tcGF0X3ZkcGFfcmVzZXQrMHg0Ny8weGMw
IFt2aG9zdF92ZHBhXQ0KPiDCoMKgID8gX2NvbXBhdF92ZHBhX3Jlc2V0KzB4MzIvMHhjMCBbdmhv
c3RfdmRwYV0NCj4gwqDCoCB2aG9zdF92ZHBhX29wZW4rMHg1NS8weDI3MCBbdmhvc3RfdmRwYV0N
Cj4gwqDCoCA/IHNiX2luaXRfZGlvX2RvbmVfd3ErMHg1MC8weDUwDQo+IMKgwqAgY2hyZGV2X29w
ZW4rMHhjMC8weDIxMA0KPiDCoMKgID8gX191bnJlZ2lzdGVyX2NocmRldisweDUwLzB4NTANCj4g
wqDCoCBkb19kZW50cnlfb3BlbisweDFmYy8weDRmMA0KPiDCoMKgIHBhdGhfb3BlbmF0KzB4YzJk
LzB4ZjIwDQo+IMKgwqAgZG9fZmlscF9vcGVuKzB4YjQvMHgxNjANCj4gwqDCoCA/IGttZW1fY2Fj
aGVfYWxsb2MrMHgzYy8weDQ5MA0KPiDCoMKgIGRvX3N5c19vcGVuYXQyKzB4OGQvMHhjMA0KPiDC
oMKgIF9feDY0X3N5c19vcGVuYXQrMHg2YS8weGEwDQo+IMKgwqAgZG9fc3lzY2FsbF82NCsweDNj
LzB4ODANCj4gwqDCoCBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0Ni8weGIwDQo+
IA0KPiBGaXhlczogMTBjYmY4ZGZhZjkzICgidmhvc3QtdmRwYTogY2xlYW4gaW90bGIgbWFwIGR1
cmluZyByZXNldCBmb3Igb2xkZXINCj4gdXNlcnNwYWNlIikNCj4gUmVwb3J0ZWQtYnk6IERyYWdv
cyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPg0KDQpUaGlzIHdvcmtzLCB0aGFua3MgZm9y
IHRoZSBxdWljayByZXNwb25zZS4NCg0KVGVzdGVkLWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVs
ZWFAbnZpZGlhLmNvbT4NCg0KPiBDbG9zZXM6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC9iNDkxM2Y4NC04YjUyLTRkMjgtYWY1MS04NTczZGMzNjFmODJAb3JhY2xlLmNvbS8NCj4gU2ln
bmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPg0KPiAtLS0NCj4g
wqBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDggKysrKystLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMNCj4gaW5kZXggOWNlNDAwMDM3
OTNiLi45YTIzNDNjNDVkZjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jDQo+
ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jDQo+IEBAIC0yMzIsOSArMjMyLDExIEBAIHN0YXRp
YyBpbnQgX2NvbXBhdF92ZHBhX3Jlc2V0KHN0cnVjdCB2aG9zdF92ZHBhICp2KQ0KPiDCoMKgwqDC
oMKgwqDCoMKgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsNCj4gwqDCoMKgwqDC
oMKgwqDCoHUzMiBmbGFncyA9IDA7DQo+IMKgDQo+IC3CoMKgwqDCoMKgwqDCoGZsYWdzIHw9ICF2
aG9zdF9iYWNrZW5kX2hhc19mZWF0dXJlKHYtPnZkZXYudnFzWzBdLA0KPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUKSA/DQo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVkRQQV9SRVNFVF9GX0NMRUFOX01BUCA6IDA7DQo+
ICvCoMKgwqDCoMKgwqDCoGlmICh2LT52ZGV2LnZxcykgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZmxhZ3MgfD0gIXZob3N0X2JhY2tlbmRfaGFzX2ZlYXR1cmUodi0+dmRldi52
cXNbMF0sDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+
IFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUKSA/DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZEUEFfUkVTRVRfRl9DTEVBTl9NQVAgOiAwOw0K
PiArwqDCoMKgwqDCoMKgwqB9DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gdmRwYV9y
ZXNldCh2ZHBhLCBmbGFncyk7DQo+IMKgfQ0KDQo=
