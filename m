Return-Path: <linux-kernel+bounces-36017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB79839A33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522FA1F26151
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6784585C4C;
	Tue, 23 Jan 2024 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N5Emaixn"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18E60EE4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041304; cv=fail; b=qGqcxCMo3IpWTWRtRQ3csKz9d5sM8JlflDiXXurg3v1IV1CTxnxgUuEdZJs/zP+iKUronyPTCJ/KMBagGf8HuZt2Y5U+Jc7ai8Uq3dJ1NHzwtqH5msDxZlxOJDMva7wk08OafByM33gkJlUNzPhtMDPfmQlDpP3/S+E9Qu92Qdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041304; c=relaxed/simple;
	bh=dbqaTp1pL68Da03LhYd5e40h1iLORv5CHbRd7h50wZY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=elYMJadS8bP90DOBTEkROYgxXpGw8hC1WteGHrpq9uBhVuQ/sLrC9gmGguxisj0NxUB2i71eGZoWq2NyklG9FGYHKMTDncyArvtlR0JwW7mH0RocsubpohsdNYxBQS5kMWGcPqRt0bB9LqO1IrYhqS3dxebKMX32O3qb79lzlOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N5Emaixn; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnZVLB+hdz2o1VdAj6OgTD0viVe7BMxlcaQ/8expPT2e8htENDOY03WFB7YjI8GT+FGJz5+XnOTkHlIybem0KsTFL78zmmjKhc2lIhYTClpQ14sfj5JH2BF/+QHbZRwsxwH7GpvysUp+9l72HI5mIa+dk3qSAUxFImVPrNjoprzIGJpxXlGDAHlLdhuL4uYdnxoS5euOpUBZhmgu7zlvIMx38ljzHT4J+oVfKKN/DdJwyurEIvMuKrY45C/pjkpf8ES/795zV0e5D8ejO6E9MPVHHTDOQec70yS0cXy6HLQ+8Ik+KyFjg+17oCjnVcDVvPF1/q+eBBwAvXi89KDCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbqaTp1pL68Da03LhYd5e40h1iLORv5CHbRd7h50wZY=;
 b=U39dnklwidMkprnFgZ+aUmSRgnQ2GtFbxSqVLWRZ0fD07bpBx6zThAIzPtFB/Ci1uUndi6OidOTEGRsukM4YcGpeo6m3IARJA6wYQOEY6DCbxNoRDGd2bc4XfpvjiHo3CE1Bm0KgrLx/XbbHlMtx+1SFfrZwv5Q+fEo9vFctFa5ClRY5WshXVw0TBZuICeQc6c+p/XoE5AEPqQVIjXys+I1NfLq1cAhIAxO94LVdYQ4fbD2zq9WaXo4EJ1Jtfkh2AxNlC0PCu6UrvghA0V2nYw/yRmhcUFTvLnJXNoVRt1wWZZH8nlu/LukNjtq/acEfoo6lszp8QmgtRJFFLwg5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbqaTp1pL68Da03LhYd5e40h1iLORv5CHbRd7h50wZY=;
 b=N5EmaixnDuk6zJnakzd0jqwrKsjIvpfG8iH0xQ9EDpkeNJIwMiaVNRA/ldtbmQfuSOg59cKaRCiaAUHkP0VcgdryKgya/7m9kFP0LyLmb1TMX1eG1OmbXiymd3+clTBfw2DsM5cdcS97HKpmFvj6bDZAwNscgYuTc9PUiUEnHICMF2eFhwYFVGAyLW1WNhj1nH4KWc5n3B6DnPILtCAARvZy1Soxbof9On7u+6bBSqo9Ij2Q4BuiVMQy+qPDZWZgBU7o7pkQTZTxllDiqNZhoARFEDSomf9CrwDR9OY9F02Wbw5xdQVhTFj8N7V1u85K6HoGqWL2KcEHe6eFyktN1w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 20:21:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 20:21:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Stuart
 Hayes <stuart.w.hayes@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme_core: scan namespaces asynchronously
Thread-Topic: [PATCH v2] nvme_core: scan namespaces asynchronously
Thread-Index: AQHaSlIKntzx/IwLnkWxcp7khtdImLDlkdGAgAIOgoCAAD6UAA==
Date: Tue, 23 Jan 2024 20:21:39 +0000
Message-ID: <c05add9f-d375-44a4-a859-2757b19c70dc@nvidia.com>
References: <20240118210303.10484-1-stuart.w.hayes@gmail.com>
 <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
 <Za_rVS-0MEr2U731@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Za_rVS-0MEr2U731@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6006:EE_
x-ms-office365-filtering-correlation-id: 72bbcb1f-5b81-4bab-d38d-08dc1c50e7f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TCDRaR3l5k27cpLpP/yoWz1UQ3JK7ANdi98VYj4FsIFJXP3imJ2PU0jxv8g3TtbReyCjnk2lMV73KnpTqV+0KLbwxcteEHZg4M7bQOFHoLFNOdMYKRvpEO/9dYZsJ/FSqwYAcRfM5UFKVd6qh7YdwInnsjVKL2KPu6gCXCQvAzqzJLyOJIm63eQRi5JrloQhWL9kGdZll7xbK9PBi0+4qGWXHTjnRRV7vUARHiA+vtWvTRBtFCaVzjLdt8m/mgWG05sl0HUuF2O9AtfJHzvGjJ6ZPQpPPQRvkg9QAcT1Dp0EEdhKVaVleC23t3YV6o82Qbyz0XdQo4gPzEMLjPZIK+yp/EbiW+G5KRsVPU0+XKmLDPu5kGeJT56TjqnTrMPfM6kVGfKHjJVDHTGnX4Jl2Vf/q0ss4jeFNt6ZQU0+Ru+Cgs5senMmL1ZIds/fJVeweB5JgjamvyMBkhZ7upOwLLb+R6VyY895XwcwaHbYeiQ9wvoh7Oh+mMHb2GV3ISp23v6vQ4TQRdn4ap0AbzzaMh1QKooVhcXvcb87Z2/lEl3VtmiSJlSBS+QLtmGl9Y1NqJl9VunkqA9Ph6Y34Weh9XKvJbLW5B+fKlfQ/BtNIva5zOTWvIRsBQEgCXmO35m5wSyMn2qYPtPRpAbBy0xtYTQr9HaICtFWHk43nUAkuUfVho9dBduKgvXinV8i62ri
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38070700009)(110136005)(64756008)(91956017)(76116006)(66476007)(66556008)(66446008)(66946007)(8936002)(8676002)(316002)(31686004)(54906003)(122000001)(5660300002)(4326008)(38100700002)(2616005)(6506007)(71200400001)(53546011)(26005)(6512007)(478600001)(83380400001)(31696002)(86362001)(41300700001)(36756003)(6486002)(40140700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0o4VkxROXRDemRPQVhxTkNDTElOTW1Rc2EvbGZ4WVFrc0s0UldBeU44ck15?=
 =?utf-8?B?Tktoa3ZBSTNrRGlOOWVyS1lvb0dleHY2R05GWnhJMDNlbEwvcHN5L1hscHBK?=
 =?utf-8?B?MzZoNHFxWEVadFpNWVllR3F3aVB1UHo4WTFNb2pORmNqUzIyVXRjcTh0T3FX?=
 =?utf-8?B?bm9lNXlGam1HQk1oQTZnRjBvNi9WK3UrK0h1M0Jaek1zTzJyQUdIYlJmK3lF?=
 =?utf-8?B?b3Uwc3AxYURiSTNwdnZDdVNIb2pEQnBsLzdQeHZCVUV1NkhaUDVEcXNnWVJI?=
 =?utf-8?B?K0N0b01pZ0lHRDdIV3N0NGRYaTlGQzVQbHVZR3BUMExVTFRxV3pIOGhNUVFW?=
 =?utf-8?B?Yy9vakluWmQ0Y3J6eFRLSmVIMDIrVk5aK24zTnBhSXJyV3lidTAwRmhCenJI?=
 =?utf-8?B?d3NJUm8zc0tieGVSZ2xSOTRrRUR0bThUSmdxSVRsUjNlODhpQWJpTmJsazg1?=
 =?utf-8?B?ZkxpK2hvRXpvcHNsVTBMQnZjVHE2THJGYW1pRmFabVROTU9lK0Fqbkx2cGxH?=
 =?utf-8?B?SkJuUzk1dU1FQ28vaE12YWJRN3Rzek1BWm45Y1FiWjVsWWhJaUFVeVR4Y00x?=
 =?utf-8?B?TXV2emI2MVBURWh0SGxkOHJtcXZiV2JvWVdqMkg1b3o4S3Qvb0oybEg1UXpa?=
 =?utf-8?B?c000dzdjTVVwZU5nc1doQnZzSmRNNzdpaHlmdDJkbi9pMjQ2R1JVUFdSaEdx?=
 =?utf-8?B?ejFKdHN2MDBIRWowTTBLd05ESEFVWFpYQjhZc25oZ1FvZXFBT0xPSXY1RnFn?=
 =?utf-8?B?R3MrY0hnQ3owWm1DTndRNGxLNk5hRUVuT2x4T0djMmc2Qm4vczJhMzQ1MzJZ?=
 =?utf-8?B?Y2MwU1JjM0tJZGVsZHdXVW5ReVo5aVpWMjZtOHJldk9CdWxSMXJGekVmSlZN?=
 =?utf-8?B?T29CVVpNeWtoUGNXOTBadkwwdHZvM1B0bWpuNlRLb2xpL2t4czdJdHMxMTBC?=
 =?utf-8?B?ZDBPWlFOQTVuVElmMk5tNGMyQVh6VEhDVzkySjl1bE5rZU0zb3g5TUtLQklY?=
 =?utf-8?B?WEF2a3grZmlNMmRXQ0pPQ1d0Wm44N2oxMVI0VEVUYklLZ2F2UnZMMHVHUGNs?=
 =?utf-8?B?ZFJuUXFUbjRkckRMVVducUhSTExtRFpzUThhdjA3Tnl5WG5MY0VyTUtmVUow?=
 =?utf-8?B?WUNlY0lzUlZFa0xQWHVmN3R6dUtaT2dhRXJ6blczU1JtYnNRWHhCeUtnTWE2?=
 =?utf-8?B?Mk5NN2lLYkxFeXlNdHZKM2hYcTN1cHJrR0RVZU9rd2VRVVMxYVg1R1pvenFy?=
 =?utf-8?B?SW5LSFVLRUJhY2pjT1N4V2l3SEYwVU1Da1VLZFVFQmVVNldQZy9FL3NPemlF?=
 =?utf-8?B?VjFUbWRhd2cyMHRzVHlSWm94K1haVzRFQzFIR2d0dS96aVVZMFBVUC9iTjVn?=
 =?utf-8?B?S0lvZDR0dlNRZDRGRUZ4VWdjM2owZVVSbFJNK2lTU3VKdXEveUNEWlBMUU15?=
 =?utf-8?B?aVhXejNCY05SbjY4Yi9KR1pFaThUK0lzT0p1WjNLajRHV29qYUwxY1BYcHNt?=
 =?utf-8?B?Z0JEeFV1MGY5Z2xXNGx4NjNaeVRueHJIQ0JYRS9mY2hmTS9zT3NkUWVucmJW?=
 =?utf-8?B?RDRadlhENWlSR1gzb0QyYXBUVGRxMVo3MnlMaVVCRUdXRGFXZTd2MmFKWU9S?=
 =?utf-8?B?WTYwbmdoRDNTVDd4NXp5RDBQeWxQT2M5a0tRYmNnSHpkTTBtL21YTEF4bEdk?=
 =?utf-8?B?dlB3UFhNa3dUUHRQRTFqK3A1OXF5a1pJN1czUGpiUmpJRmp2a0d2Z2d2TXZi?=
 =?utf-8?B?YkRUcHhVc0dPb0N0OExnQlhxYktLQnU1dGpTMjBoa2JSKzN2MlpZTEpRQ2RI?=
 =?utf-8?B?bityYmUweHEvT3hkWG84RXJxaXZtN2k0bEFtNDJiVmtRUzZMczJsUjJ6MXE0?=
 =?utf-8?B?ZG13Q0huL2FVQlV6RmExcmhwUHErdklWZVNTelNhN2VJUTZYdFRuK2JLNDE4?=
 =?utf-8?B?L2ovWnFOM0FvYkZoTjlXdkpnWk9zR20rbENHUnA3YTZCcnR3S3hjMVNuditV?=
 =?utf-8?B?VEVYdDA2RmN5YWQ0d3RBZ2xTYUxCaWJmWEhGUjdlU1E1WDliTU10b3Nzdnc3?=
 =?utf-8?B?cjE5SU1XVGxiem5Qbks5TUFESHViRmhKU0R2cjQ3UUFrNWtsakZVUXNqU1B5?=
 =?utf-8?Q?knz4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FDCEF7110792248BDE9802AC35AE098@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bbcb1f-5b81-4bab-d38d-08dc1c50e7f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 20:21:39.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tnvo3NDT/AT5+HheLiuxh5R4VE4ieSce1/SWgSrcukA4vsJmZHPF9daudu2HDOmwcYwCUj9XBdmA0hCJkh2dLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006

T24gMS8yMy8yMDI0IDg6MzcgQU0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBNb24sIEphbiAy
MiwgMjAyNCBhdCAxMToxMzoxNUFNICswMjAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPj4gT24g
MS8xOC8yNCAyMzowMywgU3R1YXJ0IEhheWVzIHdyb3RlOg0KPj4+IEBAIC0zOTAxLDE5ICszOTMy
LDI1IEBAIHN0YXRpYyBpbnQgbnZtZV9zY2FuX25zX2xpc3Qoc3RydWN0IG52bWVfY3RybCAqY3Ry
bCkNCj4+PiAgICAJCQlnb3RvIGZyZWU7DQo+Pj4gICAgCQl9DQo+Pj4gKwkJLyoNCj4+PiArCQkg
KiBzY2FuIGxpc3Qgc3RhcnRpbmcgYXQgbGlzdCBvZmZzZXQgMA0KPj4+ICsJCSAqLw0KPj4+ICsJ
CWF0b21pY19zZXQoJnNjYW5fc3RhdGUuY291bnQsIDApOw0KPj4+ICAgIAkJZm9yIChpID0gMDsg
aSA8IG5yX2VudHJpZXM7IGkrKykgew0KPj4+ICAgIAkJCXUzMiBuc2lkID0gbGUzMl90b19jcHUo
bnNfbGlzdFtpXSk7DQo+Pj4gICAgCQkJaWYgKCFuc2lkKQkvKiBlbmQgb2YgdGhlIGxpc3Q/ICov
DQo+Pj4gICAgCQkJCWdvdG8gb3V0Ow0KPj4+IC0JCQludm1lX3NjYW5fbnMoY3RybCwgbnNpZCk7
DQo+Pj4gKwkJCWFzeW5jX3NjaGVkdWxlX2RvbWFpbihudm1lX3NjYW5fbnMsICZzY2FuX3N0YXRl
LCAmZG9tYWluKTsNCj4+PiAgICAJCQl3aGlsZSAoKytwcmV2IDwgbnNpZCkNCj4+PiAgICAJCQkJ
bnZtZV9uc19yZW1vdmVfYnlfbnNpZChjdHJsLCBwcmV2KTsNCj4+PiAgICAJCX0NCj4+PiArCQlh
c3luY19zeW5jaHJvbml6ZV9mdWxsX2RvbWFpbigmZG9tYWluKTsNCj4gDQo+IFlvdSBtZW50aW9u
ZWQgYXN5bmMgc2Nhbm5pbmcgd2FzIGFuIGltcHJvdmVtZW50IGlmIHlvdSBoYXZlIDEwMDANCj4g
bmFtZXNwYWNlcywgYnV0IHdvdWxkbid0IHRoaXMgYmUgd29yc2UgaWYgeW91IGhhdmUgdmVyeSBm
ZXcgbmFtZXNwYWNlcz8NCj4gSU9XLCB0aGUgZGVjaXNpb24gdG8gdXNlIHRoZSBhc3luYyBzY2hl
ZHVsZSBzaG91bGQgYmUgYmFzZWQgb24NCj4gbnJfZW50cmllcywgcmlnaHQ/DQo+IA0KDQpQZXJo
YXBzIGl0J3MgYWxzbyBoZWxwZnVsIHRvIGRvY3VtZW50cyB0aGUgZGF0YSBmb3Igc21hbGwgbnVt
YmVyIG9mDQpuYW1lc3BhY2VzLCB3ZSBjYW4gdGhpbmsgb2YgY29sbGVjdGluZyBkYXRhIHNvbWV0
aGluZyBsaWtlIHRoaXM6LQ0KDQpOUiBOYW1lc3BhY2VzICAgICAgICBTZXEgU2NhbiAgICAgICAg
QXN5bmMgU2Nhbg0KMg0KNA0KOA0KMTYNCjMyDQo2NA0KMTI4DQoyNTYNCjUxMg0KMTAyNA0KDQpJ
ZiB3ZSBmaW5kIHRoYXQgZGlmZmVyZW5jZSBpcyBub3QgdGhhdCBtdWNoIHRoZW4gd2UgY2FuIGdv
IGFoZWFkIHdpdGgNCnRoaXMgcGF0Y2gsIGlmIGl0IHRoZSBkaWZmZXJlbmNlIGlzIG5vdCBhY2Nl
cHRhYmxlIHRvIHRoZSBwb2ludCB0aGF0IGl0DQp3aWxsIHJlZ3Jlc3MgZm9yIGNvbW1vbiBzZXR1
cHMgdGhlbiB3ZSBjYW4gbWFrZSBpdCBjb25maWd1cmFibGUgPw0KDQotY2sNCg0KDQo=

