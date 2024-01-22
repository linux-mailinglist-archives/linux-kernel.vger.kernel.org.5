Return-Path: <linux-kernel+bounces-32300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7FF8359BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F65B20BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178834A39;
	Mon, 22 Jan 2024 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="k78Vb53C"
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682874A29
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705894157; cv=fail; b=Wpt7J55NQ/7MVjtAn0najOHMrAMFr7P25zh3IJPZeiuRwOh6Upq5gPvk1vMDs+Kppcv4XGrz2fe7CIgTiNyoGyPH/4KJnT4U3EdQT55zTY1lz/z0mBjSWcj4GjKEFYVb0PQ8K0pyJNotes06yBl8UBFQ8eaVn4l8dEkSI1gzoOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705894157; c=relaxed/simple;
	bh=C7cHS53LtlPmvEiFprr8QgoOKoGhDK6UCJrQucGr8P8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGRtf9xCo3A+Y+gs9TOIl3GAJb9zabxjXtQCkNkP5tGtffqCYFy/U8HD10pX6P8B0DfbT/ZtyOJUsAWufBEJ06o2aeboiTS8Wp//5w624srVACN3OXhfDm1G4pIew1BzzJfeliEkZ4+skBlp/2xOCKGJSt2HmxYz+AUpfFFNkrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=k78Vb53C; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705894154; x=1737430154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C7cHS53LtlPmvEiFprr8QgoOKoGhDK6UCJrQucGr8P8=;
  b=k78Vb53Cuo60a3YDvxqYYV55Ia2i4d6FUWxPhZ/Q3dHRKIYdqmmzuCni
   U3YhNVrPUKp/DocW+Q4oYzvpWLiO7kx5kIaP7XTlXIJBo1Mq+WH5Bk7xu
   gYLPc6+4Z3BAtRbcK/IVaFstDqVu+Zm0BiCcYeKvUEVlz8zmt1ImgtCI1
   QRULH6+SKvQ8kPY00b6PdZVk8muJ+bfO+IP0kg9/M9e+9cUVBMGWbYwL4
   buMamZoqDLHfnzDp0knWF1TiVPLPP3tFPjWXQH8/6n+3RGBZNsX8bj1hi
   WsBbnO8m6Yq1IdG4VTcIddcuzKtUEemecUz+IUyWlKoOc4h2KmW9lP5mZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="19976537"
X-IronPort-AV: E=Sophos;i="6.05,211,1701097200"; 
   d="scan'208";a="19976537"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 12:29:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqF2CyKmNxHGy/hRfVruiJLtfDlICP/rSG3g2kB1ZMrFZf+w9iM4w7MPfwHBCZ4pV/oF1FgN+psIsc8DXDP7BtUAGQ25ExC+NdGQoMWWLDVSVY1PEY+6SXPIdBjdzfleaYeouFSbhACgsMklPDpXY8UBZ4YUApY2hgxpXEUGwqupIk/z147NSCRl62aiUX4CyEFkuYejcNJgUqGGvIbz/F9d3ujt62l5cEG0Pn3PqZ8ATMLV1ep1EzpOLXpQlRpdmJnarafvRJbN7UYjAyE7j9ANRP7nrqZInNgqx/iqFXODOXbyEM+d/9KuW3hAbcauFY7zlrZmVzeteNn9y2XlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7cHS53LtlPmvEiFprr8QgoOKoGhDK6UCJrQucGr8P8=;
 b=cD0O81zxPxkYzD16pJHRq2Tm2trGAjG4SkDdZ6qazCzi8DrGkx8z8xRHmy5FN/VyHOrimyi0vX/7IqyaLJiLyEUl7i2BPW4FCsRS6gaVI4rSdC+o0UcJQELLKtRGvKj7PDo2ui/r8205eL7VvNVEee4YwnFZpNQf+gEr/lx0puKWfmbzw3x98Bu2816zhfXrL0lLNN/HNDxyg6f6aJcpq69ATbnOi9z9PWbxhgQEQ6DAEAwzvG+uX9gdQ5VkLiclzxuM/Fh5gxSvlYqeMjtT4IM+Rs91icjPI8heuOa56qfY6m9zzem95O5/YDsYDbM1XEFy3eQLg9P3bbZehSt3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5445.jpnprd01.prod.outlook.com (2603:1096:604:84::13)
 by TY3PR01MB11004.jpnprd01.prod.outlook.com (2603:1096:400:3b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.11; Mon, 22 Jan
 2024 03:29:02 +0000
Received: from OSYPR01MB5445.jpnprd01.prod.outlook.com
 ([fe80::c61:6ef5:22ee:565]) by OSYPR01MB5445.jpnprd01.prod.outlook.com
 ([fe80::c61:6ef5:22ee:565%4]) with mapi id 15.20.7228.011; Mon, 22 Jan 2024
 03:29:02 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas
 Palix <nicolas.palix@imag.fr>, "cocci@inria.fr" <cocci@inria.fr>
Subject: Re: [PATCH v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
Thread-Topic: [PATCH v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
Thread-Index: AQHaSp+vRA5kPLZbkUqjfxDpv5AXBbDjN7kAgAH5TgA=
Date: Mon, 22 Jan 2024 03:29:01 +0000
Message-ID: <d14443fd-96ee-4d94-a149-d81990f64de6@fujitsu.com>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5445:EE_|TY3PR01MB11004:EE_
x-ms-office365-filtering-correlation-id: 6aa8879f-1911-4f30-fa19-08dc1afa4744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 01fMV+JfQui0iCnjXJy5b/DRQYiNwVEbbTy9fCOqEHz5Zo/TwVsub5uZyEpG+eu1QINQ8AZsqPbOY2dMOkt2oTENf19pt7lw347B5Ce25Oh8dZcHsnYi0Wgq6afnpnc2I3NSXMrGVTlIGZ3ppgUqYGZVGfyeYYAERDHjrOJWT25YU4Oxq7u3mWbEfwx9jke1QeFpnWqtUrZ3s3xfblWxAgPVvftJLc9iPJYT6lrm6oS5M6PpmpOjyXcKWmZyDV9PvhjOSVmquhUB4NCtX4CKYYQfFCSJc8hIkJYqxFivpmQFWfwrXnwE59V+5wtuyHH06OJezqXrZ6wZbrTjH2fHRoYhgsVzv5j6dJsA6s5Xvgqjskhm9UqRYGiHcENJCLN9edptP8XKLHUDvuWMmKexto2UWelxwGrGwa/o7UtN2BUZHekfQ0m8KSqAQdF/Xt4hiHwkU67be8jDtWAhymedvL+SGM5s5g5PJVt8ukUgBQs49e4QfJq3Lr0dXogdNZxE4UG2aWKMq1dZs/eLXu926+UCuFqRie/ayLnVRsPLBFmoCjh/9nc/0EShxe2UbvIKswNQgK6glPfom46q5B1AVFOlH6043Cgm1Vk1Y2TGbE0M3ilEIBa2vPOYpPI33jT4zyOuBjQPMJc0OW1RhMJcs1p1LW1x4+9jqNltrLdcgT2hpdRuPdq7Oo+rrIF1b5O37xbNNaoIzulmveSygT7NmwMzi7pqu0u28uLkk1egvMqzv1AGkPLHvA5mFsb7lhga
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5445.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(451199024)(1590799021)(186009)(26005)(6506007)(2616005)(6512007)(53546011)(71200400001)(5660300002)(122000001)(316002)(4326008)(8936002)(4744005)(2906002)(6486002)(76116006)(66556008)(6916009)(66946007)(478600001)(91956017)(64756008)(66446008)(54906003)(66476007)(41300700001)(8676002)(82960400001)(31696002)(86362001)(36756003)(85182001)(38070700009)(83380400001)(38100700002)(1580799018)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGxMa241NHh3NjJZVmh0eEh2ODNob2dJM09CRXZyTWlQTUMvNEpId21ReHFa?=
 =?utf-8?B?MlJqQ0tWZUF3QmUzOVBXQUdwVU5BdlNYY1d5UFVDSTRkenlLOWFpTTN3Nk11?=
 =?utf-8?B?QXB6ODI0RW9WR241Z1FpaVdRV05aRkpacVJmQXNjaEdSTCtWMTBNV1A5UXV0?=
 =?utf-8?B?RmZqTVRSbS8wdEMxSjlxa1Bjd3lnV1c3RVB4SWVYelF1elRYRExKelpnSHYx?=
 =?utf-8?B?dktSdFRhcXhUT2V2bUx0L1llbmNtek9kUkNCQmlqZlR0QXVTdm5SNmhXdSs0?=
 =?utf-8?B?ai9pTmcyYzRVcHpRRlJ6TUVUZkZtVWxGdURrWjYzNWNrejlIN2xnVmk0c3h5?=
 =?utf-8?B?WXN4bjVXNU9pSzlnUzdsSlZmeHlDR0lHdGtTUk9FSWVaSWZiVlhDNk4wVXh1?=
 =?utf-8?B?TmNPM2VqQzJvTE1mV09rN21GUUlmcURzbFZVeHBDR1VncjF0aXI1M21TWXlM?=
 =?utf-8?B?V2VXaUFiVGlsRVpXLzNpbVdFcHBZYjdLZnBXaXdienYwLzNoaTFHWGdpNWd0?=
 =?utf-8?B?QzYxTlRlRU5peDRlVWhpd2JhNHpGd1JqMUpmbmZHUWRXMFhjK0w3M3o1ZzlN?=
 =?utf-8?B?RG5YREhEZW1QMzJ3NGtva1hIRCswQ0tRdjdhWkNkMVM3M00wc3dzTzBBS3Mv?=
 =?utf-8?B?Q29BNjBKMngxdFVjVkJiS2JUTng2ZTNSRjBHUURHMmEwZ3luSTNoZVNsaHg0?=
 =?utf-8?B?a25GRC9wZkg1VUlzc2Z5QWZ1TXoxcFJya3Z2Mld1MDJkcVhyL21kaWMvMUw1?=
 =?utf-8?B?OHlnNUx2S09xZDUrVUtxY1N3aklDRVFWMGpoWXdKV3NRRy85QWI0L0xoakpH?=
 =?utf-8?B?aFkxU3ZtOHAzT1pHMmlQVHhCU1BQT2Nsc25MN0RCVHRlbUJRN3JqdTlHcU1z?=
 =?utf-8?B?ZUptcEVybHpzVDQ0VUhnVk5vcXVYLzZSTzVwSUhzUkgxUGpkU2pCaE43d1c0?=
 =?utf-8?B?a2duMVJqS1AxVmpoQTN2eGpvc1RHbG14eW5OSUxrOXA5WVRHTTBSdmtab2lL?=
 =?utf-8?B?SGlJVmF2cEZwT1hvQ3d6aG5pbkQzNmtvUVR1QzNGU1psNjZXbEVFWTdjQnly?=
 =?utf-8?B?L2FUWHB2L2pPTlk5OHA1S3Z3amd4TzdjMks0NHhLVVNqbzBtb2QxV1lPczZ6?=
 =?utf-8?B?L09KdlFIc2NkL2h4OURWRDA4dkRYZkNwdDZheEFZK1lzUWlYbjZTZDE1a3l4?=
 =?utf-8?B?dXRjUnN4V2JtRTRtK1ozYzdMSjFpc1JadVNrQWRTVkg5QTB0R28vT2UzNjZu?=
 =?utf-8?B?ZnM0WlpGOVoyMjk5d2F6SzRXckNOTXdtOHZvSHN1ZXd5Q1o3ZXBUWXRTN3Fz?=
 =?utf-8?B?V3ZCS0FBSmZVWUx1cGE4L1B3K3dwSlRxNU5EeUU2TXdCeXNtd29wMHVxOTBJ?=
 =?utf-8?B?TE0rbXo1aHl5THVEZmw3aXBiMEtGaGRjb3NnQ0JtNVE1UGpab3ZxUDZrT085?=
 =?utf-8?B?Zk1KWGhtRzZ3Y1dtYktEVDZlUC96VCtOYmgrb2hqRVdYcmY3OHM3cjhEeXQ4?=
 =?utf-8?B?OS92SnNGTUhoMllhd2VWZkQ5K1NwWnp3Q1NOdENYcGo2YTMzdy9iOWFJWGZC?=
 =?utf-8?B?RXpxeU0weFA4dnBnbFFRdmtnd0FDcGIzN2V2a3A1cnhQR3FLdk1GenVGSVdC?=
 =?utf-8?B?d1ozMitLV1ZhM3l2WjNBUldJNXdCK3ZoejA4MWgrakFHRERqSmRHN1BRVUFv?=
 =?utf-8?B?ODA5NHA3RXUzY3hlZzR5cWZMMGRTMWw2OEFwZ1F1NW81UUxHKzIvWjhqY2k2?=
 =?utf-8?B?Tis4akVBQkNpTnlLNFV5TFQ2NlRXMmhGcThyL3JlcEpjeTdNZUV0UmwwbUc4?=
 =?utf-8?B?dk5BcmF6UmI3T0FOL2VNZUUrNjBKcHRobHVJeGJ3L0xwREVLK01XV2lyZW1p?=
 =?utf-8?B?OUhkbnE1YU5TLzBPcTkrSkNCbDIyekJIMTF5Q1R5YnY4YXdQTG9MOE1WZ2tO?=
 =?utf-8?B?aTl1Y1J3aTA3Rmo5SGZ1d014MEI1M2VHSkpSeFVTeXVIcFpxT0ZwSzhVaHZZ?=
 =?utf-8?B?dHFxK3NqQUZXN2tTejRrWG13OU9SZXBhb0ZpLzZveCs3UWxKTDFpOHhHVmYw?=
 =?utf-8?B?clQ5UXFVVUZyVU5Cd0RXOTFTWVF2TEkyd1hQTVlqMzVpVUV1ci9KMEMrRllU?=
 =?utf-8?B?NW9HMmJzWnl2V1lBMGQ1MTl1NDE2Tmp5bE1CTFQ1NStSbklVOHE1ei9TZHdY?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5269B382AB50624787E8AA8C1DF5CFEE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	09UZIJj+IYBhhXhvVq3v6IZBH/TzqfmpjGQUfz93aM+4aWtAW9kXpjBzOM3NaJGMJ53ZOdDeUgCrtQrOJA1bKZAahIL2IrxUod2FTTVXuzVA8qYL2auFi0Ia1+HaOkF2gM0TbpoD/zIJGzJz8OBohaz8IPiGVqO8itToh/ZiVgXXQBK1oveih6L2mzFptAy3FaWbBYFuJ9SZ+DQXFo7q5B5P3EHnbL0jYMbyi5+EYAnTXt42s4q9S8q82miTkKI0KFAGs+VSd7fAxrX4PIBoq53m0fobeCuGNAZzLQ2nVm09kLO8vqt0l6IVX5e6CTPfB/fCvGcrFWDcHt2978+R9VMhinNAbS4+r/66FEnIJgLVza7FdGRn3uv04Br608sphE1FmmaqAYeHKTWuSonoiAQtNlUZFXVSOwkenZ0P1HfdeY+X8G0vv3fMjaRzAaNu9b31sf4va9OLVIWxraZSYUszLZI0PkM5cQh0m+Qsotd92FwxrUIKnOOnjkFw+lBf5w4VI0XM82dZg0u8LA5K6UBY5Q7A3RP1W6eM8P3oUTeZ1cEXQesONk6yrUmKZVesmMrJ0yIjjZ9OkAQDCObO5gUA8XtlGWJ/CtscCYlbv26CgD+0c9DjngX7qlF+PHy/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5445.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa8879f-1911-4f30-fa19-08dc1afa4744
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 03:29:01.9028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sVoWx2wJ7o1EmDUyEYZFNbvhb2SoNWpgPllk15yDBLID9+FSH1hZdy9SnDNzF9HSP/hziBZ1pCZdqm3k1YYbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11004

DQoNCk9uIDIxLzAxLzIwMjQgMDU6MjAsIEp1bGlhIExhd2FsbCB3cm90ZToNCj4+IFYyOg0KPj4g
LSBjaGFuZ2VkIHRpdGxlIGZyb20gY29jY2luZWxsZTogZGV2aWNlX2F0dHJfc2hvdy5jb2NjaTog
dXBkYXRlIGRlc2NyaXB0aW9uIGFuZCB3YXJuaW5nIG1lc3NhZ2UNCj4+IC0gRml4IE1PREU9cGF0
Y2gNCj4+IC0gRXh0cmFjdCBwYXRjaCBmcm9tIHRoZSBwYXRjaCBzZXRbMV0gc28gdGhhdCBtYWlu
dGFpbmVyIGNhbiBhY2NlcHQgaXQgc2VwYXJhdGVseS4NCj4gQXBwbGllZC4NCj4gDQo+IEkgc3Vi
c2VxdWVudGx5IHNpbXBsaWZpZWQgdGhlIHBhdGNoIGNhc2UgdG8gY29udGFpbiB0aGUgZm9sbG93
aW5nOg0KPiANCj4gLSAgICAgICAgICAgICAgc25wcmludGYoQlVGLCBTWiwgRk9STUFUDQo+ICsg
ICAgICAgICAgICAgIHN5c2ZzX2VtaXQoQlVGLCBGT1JNQVQNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAsLi4uKTsNCkdyZWF0LCB0aGF0IHdhcyB3aGF0IGkgd2FudC4gQnV0IGkg
ZGlkbid0IGdldCB0aGUgY29ycmVjdCBzeW50YXguIEkgd3JvdGUgaXQgd3JvbmdseToNCi0gc25w
cmludGYoQlVGLCBTWiwgRk9STUFULCAuLi4pOw0KKyBzeXNmc19lbWl0KEJVRiwgU1osIEZPUk1B
VCwgLi4uKTsNCg0KDQoNCj4gDQo+IFRoaXMgYWxzbyB3b3JrcyBmb3IgdGhlIGNhc2Ugd2hlcmUg
dGhlcmUgYXJlIG9ubHkgdGhyZWUgYXJndW1lbnRzLg0KPiBJdCBoYXMgdGhlIGJlbmVmaXQgdGhh
dCB0aGUgY2hhbmdlIGlzIHJlY29nbml6ZWQgYXMgYSBsaW5lIHJlcGxhY2VtZW50LCBzbw0KPiBu
byBleHRyYSB7fSBhcmUgYWRkZWQgd2hlbiB0aGUgY2FsbCBpcyBpbiBhbiBpZiBicmFuY2gu

