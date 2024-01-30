Return-Path: <linux-kernel+bounces-44545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAB9842403
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDB11C25E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7230867E90;
	Tue, 30 Jan 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="drECvaYh"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA867E82;
	Tue, 30 Jan 2024 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615119; cv=fail; b=FouSeeB3vjJhJHwrL+OU594Q5412zI+pMZlqAvqrDhcWF8JFJk5CksEHit4/jCO9DOFT5xmk7WVApaBvL742Cv6PoMCHeG3JioG1BfGI8bMsf2O8yNuasod7SkWLhrHG9cIt7JEnUZRnO2U9Qsi5bTtWbL7IHqPB9MxhGg1R9Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615119; c=relaxed/simple;
	bh=+n7EVImcBJteANUiNBzxx9FdhY8lCev8y+l5coO9Af8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FzKzun0hJ41QfPFNmXWWQLRGozAKIJL+mwMV+zMNI5kxo8dXDjAKSJBqBokjV5Qoz/wMBSJuE1zcrxGr7SSdEftto7HLj15NgBIUJO+qKWlddskOByz6tpBop9i4nd3lUuDV9fK33Y+Iv0YwAccxWVJxMYSZQZ/al2iTZTX7n2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=drECvaYh; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwNCBo/8LmJ9+dbclik0hESfsqIgOjH/haugtOwQGquVl+cKtwW7VULhiffDoNK1aSlaSwSJs3liF7UwXW2bEQEgbmZ8Sk9XgrxhskM2fo1Jb+Rmsx5CL9eESuMgfkKWJg9vsqX9zQQQK2pKtF5RRkyGTLAgcxJd4xV4Roh4frT+drml2UcPTKsF5gLIX6v0GR6vt2q8pKdjSzQkqn98mrPU5Wz8JjIyCZwSZwoLr0BAb4XnAdWxSK3y8LRP7VEN5CVOTSmOFDGjOt66iqdp5Gbj6kizc8MekhDWccU96cJaYcGLiCQ8g3UOq0v5wmmXDUmclPiAdn/q5k+qNeWr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+n7EVImcBJteANUiNBzxx9FdhY8lCev8y+l5coO9Af8=;
 b=hQ90lYB8B0VO0pQBKseIJAScSevZfncjJC2Vtt/LrR5lyDPbo9u6wJ2zPbZ4w/VWTIox5peY9c8M+RyL0g8HmLzam/uo5Jj07XneFIW8mMAgjERnt0SN0V8ZDmBiPGLTkKXNMy3NnQ++e5Hp8TIqb3mhAJxqCRAvAiXxoRJUhct+PIPuglv80TOscetV98gnAIr+f418b5PN2lP/Jcl2D8UILIr5HDGYQkO8WnO3DmFTC8yO/CcYu/WPx5DpM2Fat3px2XI5XeoWSXDhxbHdfPpgMUghWLv8QROcxNG5osZkiT8nI9fJyDOBxn1ua7PQGbEJksp/51nX7lwUTO3Qdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n7EVImcBJteANUiNBzxx9FdhY8lCev8y+l5coO9Af8=;
 b=drECvaYhS5l8BOTcaDome+xfhIPAM2IIoDhN6hCRAiAQm6yJY6+7edYkpsAZ6CU5twPVYN/+UF8hnYZ51nNnfc6jVeRZO2bXgOvmiz5RVBU4sB2ZejmyPIi9ZuOEwTytL8LK7+c9vAp10zU+S5egDdBO46iCIR0s12YDtZu2soMZgkyDEanic6hehqE9OGhARQskihXnRiR10DMGO4X6OOZimQDcUnetuy/gUNLYaNsn2jattOuj7bGzIdaNXa7OWxIwy2MviZ6m8YNjXNpziRihGW6rOWQZfiSDy5XLA9d2ZYmTlRsLbMZSddV0HonOaraeUTCsKZsOJx9f8CuTdw==
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Tue, 30 Jan
 2024 11:45:15 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::e10:209b:3076:a557]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::e10:209b:3076:a557%6]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:45:15 +0000
From: Kartik Rajput <kkartik@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>, "arnd@kernel.org"
	<arnd@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC: "robh@kernel.org" <robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] soc/tegra: fix build failure  on Tegra241
Thread-Topic: [PATCH] soc/tegra: fix build failure  on Tegra241
Thread-Index: AQHaPi9nLoKzUjszWk+GILgwbSr3HbDxfbCA
Date: Tue, 30 Jan 2024 11:45:15 +0000
Message-ID: <a0c534cc7a58034aa15f937a26525887bcd323be.camel@nvidia.com>
References: <20240103102654.3779458-1-arnd@kernel.org>
In-Reply-To: <20240103102654.3779458-1-arnd@kernel.org>
Reply-To: Kartik Rajput <kkartik@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5716:EE_|DM4PR12MB5070:EE_
x-ms-office365-filtering-correlation-id: d7a67112-853b-4189-fd63-08dc2188ecca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RdMbumwy9bDJOHQAHZxarb5wSle0WOkO09MrrccL2urofPSwWQYZUj2Bn1iG5rpotm8jipilh61T7m0rwf8dlN10zyF/hBvlzKUTFirmXqg330+dWFLf9YFNvSbLFYauhN9JbQ69zXa2Wc2ctiAiYzxd7XPU/mGaPncTe4gtOxdko7LYKJZSbfkGgb99Ny5JZoPw5TJ4Prfcf+IATYAHopIROLFHz8OhAzHZEzbJdMewcAR11aJ7ncbSCoSy60MSSvJjpo/fXaSAOMwfhT88LjPN5143lzq9hU0kGw2isMI9X1gv3pCSoY3Zr/hy+0OdwnHcH28SREQI715Y2ZTujye98I1cPqY0zIjauab5kAjBgzU2Tk5wp3kCrY4sMUDH9LPIAth5RSvdH/sxFZD88+OTF6iJx3wthHhAaK/SWRtS+i+u5j+FyTY8xlYMsCvRP2AqphaYTxvZpIIAy+338y2IaeaYkTXLFirV8Knmq8dO1RJHyonU+/yntvCUFGBN6uNc3MfJG6K4OvdPg+dtufO7Te3dvBM3hQ+ySuayyY/AK4nOp7vWI+ODXDS8M6Li/ugihAXzEJg7AX/vSdcxMQW6hzgsoxI+LmAb5TDYmxIyIiY6iySp74bX+z+0lxlBuMs6G+CcQt5FbNWUGsUXgMoaWX6dk3OScnk2RLrQO7I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(2616005)(41300700001)(38070700009)(36756003)(26005)(478600001)(6506007)(71200400001)(6512007)(6486002)(83380400001)(38100700002)(122000001)(86362001)(3450700001)(5660300002)(110136005)(54906003)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(76116006)(2906002)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFVGakw1VlNXMXFvbnBDdmUrMnVwT1YwZ09kSU94TFNPVzR2b1JwcDZzem5k?=
 =?utf-8?B?U09lMTJnQkFCei85TTZ0UjlEcHI0TE5OUFpPTnNHanJMZnN1eXV1T3NXRitK?=
 =?utf-8?B?ZmxIWW5BRTRsbTdyTGU3QUYwREw2aThTcHcrYW40RXFpNVpIZzA0RWxIRm10?=
 =?utf-8?B?TkpNZUhXdWR4Mm5vTnZyNGIwSXdlU081YXRXN1MyQ3BsL0phT3hJUk1wNWd5?=
 =?utf-8?B?azE3VG55UWhFUVdRcWZZd3g1b2w4WEx3NFhwT09wMUdnVktDZGowYVFwZGJB?=
 =?utf-8?B?VlNIcHZ3blJQeFZwcVR6WkpmRG9HRnlmUzZWUVBPTjVkY215K1dRbi9uN0wx?=
 =?utf-8?B?a1N0azd6blo1TGZqT3dabVJZaURRWGI2SXhWd0ROakJuTlNFZTJGQjljZ1Bi?=
 =?utf-8?B?TTNpbU1SZ0g2dUh0N0N5SENrd2d2TFZBZHRZdlRGeVkwMFhYQzZSaDdwaUxB?=
 =?utf-8?B?V01lVnozYjhsb0hZeCt4b3BpWStYOU1DL1dKNmRYa1dDS2VBOTFzR0E4N2xn?=
 =?utf-8?B?RWtZcms1L0xmL3U1WlBXT3FIN2d3dmRkVEsxWEhsMFRBN1JMWUFRdWtnbXJK?=
 =?utf-8?B?WDk3MEVYTVRpdTRNM0QyQ0pVODNMSXVOVEVVaU5rZXVwcnNsZXV3ZXBlOFBP?=
 =?utf-8?B?ZDBXR3VCUVI0U3pYUEhzbWd5US9JTmZqblMvTHBxYjR6QW8wOUhVRndkaG04?=
 =?utf-8?B?M3lKLzZNTGxrQWEvTHdONGVyeEZsV3NldDVObmlkK24rdzZLc21VUk1ydFM3?=
 =?utf-8?B?TWZRSjlnb0NVdzVpakM0Y1Q0TmRUeFdDc0xmY2xOUHZKb2ZjT3ZLSjYwTVhW?=
 =?utf-8?B?QXIrRSs3REw5S3hPamdrUDZIWlFGWjdqZEovbWJvZGllcmNWRXdMWlZHZU1C?=
 =?utf-8?B?OTJTQVlQLzd1QTcyeGN3ZDgzbzNzdm1wejVwVnJ6VlVESzZjY3kyQlkxaWdU?=
 =?utf-8?B?dnhyMEVSMkU1QjZqaXdhcHJtRzloNS96dnV5a1JNa1V3d1ZLb1lnejRJeXJl?=
 =?utf-8?B?RjlMT0lacGExOXFERXZIUzF0Tmd6TmVyNXVtN0Fsci9TQzJ6V1BSTjVCT2Zu?=
 =?utf-8?B?YlhnRUorajFQdTloWXUya0laMi9IaTZKTEVnbjRQMjU0NG04YXJXZFJvZFkr?=
 =?utf-8?B?R3lvWTlqTnFaTGQrQlNyUVZJMTViZU4vY2Nab256TU9GVVhBSnNPd0ErZW5Z?=
 =?utf-8?B?UDFMUmp4Yk5WeGQxVVdxNVhUYWp3NVpkUmNEdUdOeHRFYkVqaDBDaFVkZ292?=
 =?utf-8?B?Y3ZWSndTTnFHb1lISklZYkpNczJobG9YcS9lQnF1YUtPWWRZT2NjbnRIRUZt?=
 =?utf-8?B?UXgvc0REZzZYSnE0VHoxQ29tYzZlVGp3enhiaUw2UlRmQXFRWWhZMitaZWtm?=
 =?utf-8?B?RmZ4QnJaQUtIWS9kTkJmanY4dzFkMHFOT0ZFeGVwbTg1eU5pdkt4bGU3dzFR?=
 =?utf-8?B?M0EreGhSaHNqYUpIaE50YnJVL1BUY1B1ZzBBdW5ZY1FyVG5ja1JSWWsya09M?=
 =?utf-8?B?Y0tudkJpQWZ1M211Z1FmNEVVUWlLTUZkNGFJcVZieEZSSCtNUjZPdTNLU0Vq?=
 =?utf-8?B?aFdobmFxOWcvRzRaRllRMVdyU1VvQjkwUVVoR3RmNE43ODJTN01OcUI0Vzdx?=
 =?utf-8?B?MzJVSHAycTJYK3IvSEhKMTFSbTIveENwTWpaK0h2Y1NPQ3lGSXBrbXdHekRU?=
 =?utf-8?B?bDBiTyszcUUrZzJveTA5REVjTmRGNTg0aFJRejNxTjRmUFZtallDemkyckRt?=
 =?utf-8?B?Ty8zSUM1MnVOTW9tOUsyTmNSSlpKNEJmYXY4TlhjRjdJT2RuYm1YaVBCbjR2?=
 =?utf-8?B?YlgrVVRJdk9uZDI5N1RlYzlCbmw4WGVqVVhhZ0VtUkdJSHJjV3g2YnU3bjNk?=
 =?utf-8?B?ZVMwb3dqKzBYU0FZbEszbXgzbHNxaW8wM0hzcVQ3ei8xUEozMWgzcWlHejVh?=
 =?utf-8?B?aC93UTRJeDgxN2d1ODYzVXltTEJtN0htSSttdWZIN2IxeEhwUDQvUHMrQ3ho?=
 =?utf-8?B?R3VYeVVHY09NN0lKVUxmalAyVjBGaXRyYm1rdG1KN2xqSVVSVC9zWm9ldWFE?=
 =?utf-8?B?a1hKVkNhNDBhbXJySzFLQVZxRTUwS1JCMFV6d3ozR0l1UmJDYlBoK2N2bDl2?=
 =?utf-8?B?V1QxK2dOc21UdlkvaVdxeTVndkIwcUNQRCtPTlZWNW5MWHNMTXRQRmRTODI0?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FAB97862A7E3F4F84B2048CB995BA3D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a67112-853b-4189-fd63-08dc2188ecca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 11:45:15.1731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0d+kdJ+hqQ1FIPB7PwmUFgFv3nyaAJ09K+DC+DtLCexBasP/1+X/wnIntrZM4SYue6+seODoqQzoAzX4oUPNZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070

T24gV2VkLCAyMDI0LTAxLTAzIGF0IDExOjI2ICswMTAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50
cw0KPiANCj4gDQo+IEZyb206IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IA0KPiBJ
ZiBhbGwgdGhlIG90aGVyIFNvQ3MgYXJlIGRpc2FibGVkLCB0aGUgZHJpdmVyIGZhaWxzIHRvIGJ1
aWxkOg0KPiANCj4gZHJpdmVycy9zb2MvdGVncmEvZnVzZS9mdXNlLXRlZ3JhMzAuYzo2ODQ6MTc6
IGVycm9yOg0KPiAndGVncmEzMF9mdXNlX3JlYWQnIHVuZGVjbGFyZWQgaGVyZSAobm90IGluIGEg
ZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4NCj4gJ3RlZ3JhX2Z1c2VfcmVhZGwnPw0KPiDCoCA2ODQg
fMKgwqDCoMKgwqDCoMKgwqAgLnJlYWQgPSB0ZWdyYTMwX2Z1c2VfcmVhZCwNCj4gwqDCoMKgwqDC
oCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+fn4NCj4g
wqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGVncmFfZnVzZV9y
ZWFkbA0KPiBkcml2ZXJzL3NvYy90ZWdyYS9mdXNlL2Z1c2UtdGVncmEzMC5jOjY5NDoxNzogZXJy
b3I6DQo+ICd0ZWdyYTMwX2Z1c2VfaW5pdCcgdW5kZWNsYXJlZCBoZXJlIChub3QgaW4gYSBmdW5j
dGlvbik7IGRpZCB5b3UgbWVhbg0KPiAndGVncmFfZnVzZV9pbmZvJz8NCj4gwqAgNjk0IHzCoMKg
wqDCoMKgwqDCoMKgIC5pbml0ID0gdGVncmEzMF9mdXNlX2luaXQsDQo+IMKgwqDCoMKgwqAgfMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn5+fn5+DQo+IA0KPiBG
aXggdGhlIGxpc3Qgb2YgU29DcyB1c2luZyB0aGlzIGZ1bmN0aW9uIHRvIGluY2x1ZGUgdGhlIG5l
d2x5IGFkZGVkDQo+IG9uZS4NCj4gDQo+IEZpeGVzOiBkZWU1MDllYjljZDUgKCJzb2MvdGVncmE6
IGZ1c2U6IEFkZCBzdXBwb3J0IGZvciBUZWdyYTI0MSIpDQo+IFNpZ25lZC1vZmYtYnk6IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvc29jL3RlZ3JhL2Z1
c2UvZnVzZS10ZWdyYTMwLmMgfCAzICsrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy90ZWdy
YS9mdXNlL2Z1c2UtdGVncmEzMC5jDQo+IGIvZHJpdmVycy9zb2MvdGVncmEvZnVzZS9mdXNlLXRl
Z3JhMzAuYw0KPiBpbmRleCAyMDcwZDM2YzUxMGQuLmViMTRlNWZmNWEwYSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9zb2MvdGVncmEvZnVzZS9mdXNlLXRlZ3JhMzAuYw0KPiArKysgYi9kcml2ZXJz
L3NvYy90ZWdyYS9mdXNlL2Z1c2UtdGVncmEzMC5jDQo+IEBAIC0zOCw3ICszOCw4IEBADQo+IMKg
wqDCoMKgIGRlZmluZWQoQ09ORklHX0FSQ0hfVEVHUkFfMjEwX1NPQykgfHwgXA0KPiDCoMKgwqDC
oCBkZWZpbmVkKENPTkZJR19BUkNIX1RFR1JBXzE4Nl9TT0MpIHx8IFwNCj4gwqDCoMKgwqAgZGVm
aW5lZChDT05GSUdfQVJDSF9URUdSQV8xOTRfU09DKSB8fCBcDQo+IC3CoMKgwqAgZGVmaW5lZChD
T05GSUdfQVJDSF9URUdSQV8yMzRfU09DKQ0KPiArwqDCoMKgIGRlZmluZWQoQ09ORklHX0FSQ0hf
VEVHUkFfMjM0X1NPQykgfHwgXA0KPiArwqDCoMKgIGRlZmluZWQoQ09ORklHX0FSQ0hfVEVHUkFf
MjQxX1NPQykNCj4gwqBzdGF0aWMgdTMyIHRlZ3JhMzBfZnVzZV9yZWFkX2Vhcmx5KHN0cnVjdCB0
ZWdyYV9mdXNlICpmdXNlLCB1bnNpZ25lZA0KPiBpbnQgb2Zmc2V0KQ0KPiDCoHsNCj4gwqDCoMKg
wqDCoMKgwqAgaWYgKFdBUk5fT04oIWZ1c2UtPmJhc2UpKQ0KPiAtLQ0KPiAyLjM5LjINCj4gDQoN
ClRoYW5rcyBBcm5kIQ0KDQpSZXZpZXdlZC1ieTogS2FydGlrIDxra2FydGlrQG52aWRpYS5jb20+
DQo=

