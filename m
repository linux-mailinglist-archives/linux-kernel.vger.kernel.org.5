Return-Path: <linux-kernel+bounces-43141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DA7840C42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFBC1F22773
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7704157055;
	Mon, 29 Jan 2024 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dybGBWq1"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F3155A50;
	Mon, 29 Jan 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546916; cv=fail; b=oBcZG/VZ6KbIUgQ8S/UyfW0whRoD7EfZebqPC2MrtsyhgzOGElF8z56F0ExQ0+p4KA0UVlAheiuoz3VFSmB6zAbD1rZn0Eo0D/L90Mh7EG+rk1kJahfa6JHufuCkprv0HE/9rWcm4dhxwWHjfF6/UK1ONuQfOU2wCWEt7eTVwm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546916; c=relaxed/simple;
	bh=lqsqGzC8MUDDhSST9O0fdZ4YGgEUZshs2ymzYJTv9mM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f5NcclylORs3hqPWiEdOVzxP9xLy1qmMoIDdCIk3kuzFezypJ4q23k2uPNA55L83UMzzCwoWk/YLhJt9H2P5hoGCCQVXP13KXzb2mH+QKHDXssdfuc5AgqddAfESuD51luxoVDcC+2uNGSKG+MQEVtlE2EfMSGeeQLCrAr6y9B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dybGBWq1; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZtOmhMyGZiOqWQvhJYLmRx3M0pdgMnHIr3/t3Q25EB1xOJAYaEwavRBekBh/s6P8KQk1xp5HvINrHvsqUoqWH9OJMUyH9J6wNtLDWd5Xj28L/GFLG7Vxh0ESy/6NtLgfrBfDHNlBRN0eSA4RUY9kWvqGfjrX6BRk81r5/6bMSzBS67DlcosJ/rFsp6+E25Z03gxcResU8tAPsMAJDbmng99juCdJqPmZMhvWpTDxI5AONpidT1LC4a5uWCFE7C4XBlXomAnvDpobAVQwzqS14A0xipwrYFULI38UdiSXG9PcFikxAhhSj447vpunOAi8oUcL0t2HTyCZQZzDDfz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqsqGzC8MUDDhSST9O0fdZ4YGgEUZshs2ymzYJTv9mM=;
 b=CBVlxTDXcs8cV++vs8DviuTYrltWyoTjj157vpc4qse09Kucf/ks8wLIqOHukZ417Jg6RM3OG8LTTr4wcho5/q+2p8HoTin/74tQeoS7hAc1+WkW9o3WCIPxc/Dbn8qIa3jEUIWyTXK9ceuoVlQirkTlztHV1VwXP1OFzWIPSjf3zWCSfGXFTybisBmhZnw2TFV7oXS98hVlpqoi6ZfgKeWo6PYWatRx6klWCcXskmetA2FBBP0QsQrnGperZRuH8vwOcrCeliLLw6pt6nXhrx5Xklm3VlkuZ0jr5iDrdCV6YoPdqQ46i5doYLOoXINY9k0u0uvzOMwT8XdJosJaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqsqGzC8MUDDhSST9O0fdZ4YGgEUZshs2ymzYJTv9mM=;
 b=dybGBWq19BCcH0yZRNrsvvcmL1ZU+BVpQHrMeHgh0e7PpOBl+Jc60AI3+7gWev28y+tBlpWY4M36g536ehhbgnyoIQPWvYdOp77LhwNqiTOQeux66UZ5As+oh9NkvDrorBVaA5yc13eWopDK6W1kpG/AqUpF6WCf6LdyoZUYWZQ=
Received: from PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 16:48:32 +0000
Received: from PH7PR12MB7284.namprd12.prod.outlook.com
 ([fe80::cd3:fb61:5d48:fb08]) by PH7PR12MB7284.namprd12.prod.outlook.com
 ([fe80::cd3:fb61:5d48:fb08%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:48:32 +0000
From: "Trivedi Manojbhai, Naman" <Naman.TrivediManojbhai@amd.com>
To: Stephen Boyd <sboyd@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"robh@kernel.org" <robh@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Thread-Topic: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Thread-Index: AQHaPhVjvmRGRPQ6SUKSkOvyusaGNLDI1osAgAiDI9CAH8+CUA==
Date: Mon, 29 Jan 2024 16:48:31 +0000
Message-ID:
 <PH7PR12MB72844125C4BA6B9BF3BCE1798A7E2@PH7PR12MB7284.namprd12.prod.outlook.com>
References: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com>
 <55fd522918aa41f386e01432248933da.sboyd@kernel.org>
 <PH7PR12MB7284595E5D409486D91118768A6A2@PH7PR12MB7284.namprd12.prod.outlook.com>
In-Reply-To:
 <PH7PR12MB7284595E5D409486D91118768A6A2@PH7PR12MB7284.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7284:EE_|BN9PR12MB5368:EE_
x-ms-office365-filtering-correlation-id: 0f16e20e-3a8f-44e8-86d1-08dc20ea2093
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F9PMjScMr7B0TVY/1Pg4XWBYLnECRqoZqkO3O0msFWejG41j8a10qIpjnMvyljR7tu1JgzrTMhpefwsP5+BJfAYd1Drbd1sAJt3szM0fvJbZJrQPUzWJ6ZfNj3Ncn6ygtJlm7BzdgVEREulMX+uGXkrGOA2iVt9f7MW+RoowTsCgnlNNlTheQJSxOSzDIf1gdVfA2oSZL4OzuUB67Po2UPSPzwszCbKBILcPA6zcG/0uHdxHkC3p5RZybPUV7yLqtnjonsa8hjZkX87b9EI3AYy5rFugJ9red2YtEiN5hOqno81YCQ7bJfU+2QasPAonMZPym01l5yg+qhwC8VHjfnZj5tluVCEY6s8TuxdbE9Zd8zvpb6EuIWnsWuiW9nujbpmxcONxUXJdwg+IERgZtRCgG7rLjqgIK/s9GLLZzsVuh4Yt4ahXy5OwEadf1mBxq4jYMWetqfoUqqn4FSeG+uBxmUC7h9Bz2wG/Gfpxw9IohS3Xkn0N5uwuNrNZx0gqKH8UGJ0Kej6QyPjI/mHidXgASGYJGyJVccqcooiFORSiATs8b/E+vXy92jB633GXgN4eQ/i2wy9un0F+gUH5rA+oflzzs2Ib1hsLyXNjG/TLzYI2ueXArsc0iGrVqz0mB1QJ1fT33u9N8NE1xi3vKDhtjo7lKn5dhZQ5npPqELA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7284.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(55016003)(26005)(7696005)(6506007)(83380400001)(9686003)(33656002)(38070700009)(86362001)(5660300002)(71200400001)(8676002)(41300700001)(8936002)(4326008)(52536014)(38100700002)(122000001)(76116006)(66476007)(66946007)(64756008)(66556008)(110136005)(2906002)(66446008)(316002)(478600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEdNcHc1RS9ERE9zL2RqakxhUm8vdDZWQlVWRDl2c3JzaWRPYkdFSVVMWnBE?=
 =?utf-8?B?Zjl0aTcrUVhmSDBGV1c4eHp4cnNuWEtGa05OcytYK0prM2tLekNQa2NRL3lu?=
 =?utf-8?B?S3RoT1Rhd0pjbXRTa1ZhZERvMi9adFIrYVN2NlNtMzNqUDdZS2xhSWdtMVRP?=
 =?utf-8?B?ZmJ0S1A2K05DZkl3RERlU0RyZ2MrVmZTK3V5dHhHUUhtQlcyMDVFSXdFM1lk?=
 =?utf-8?B?aENqMVBQQ3ZONjh5cklTVkxnbXl1bFRQUzhJc0I1RGwySlZBOXdvdmJ3MTlG?=
 =?utf-8?B?d0FUc3pjaFM3dDBTQUh6NU13ZlV3dFJwMVQxcEVmaXNqWEpFQm5SdGxMNEto?=
 =?utf-8?B?b1ppWnlWNlRUZ1ZmVHpYVDVJNnUxRUFJdGpzOTBnOVVmSWtPQ0xWTWVQYXU0?=
 =?utf-8?B?MUErWmRlQ2IxSnZFNmRzNjlOS0R4aGpTV3hUcjhNa0tNd3Y1dUJrQmxldXJj?=
 =?utf-8?B?TWh3N0YrWmo1ZVhtSGU4QTFvVXQxZi9qWlM5dlFoeFc2Ty9GZ0E1eWNoUk55?=
 =?utf-8?B?OGdwdTJMTjVzMmpsRitoNlB5TEpxMG04dHNUeXdaUlA0bi9iVjdrM0t1ejY5?=
 =?utf-8?B?WHE4aVo3WEZWZGFJT0svTkRSd0lhZm9ydlRFVE5wZ1RuVEZLdWlQZHBSWjRG?=
 =?utf-8?B?YlhpUmFtS3lzb2JmZGN1QWVnTFpDUE1sTHhzaVRJall6ZUoxWllianliY1R0?=
 =?utf-8?B?b2tIMXIrNnc5N08zNXJTSTZHSk1PQTByUzl1dWFwRnFESG9tdXdFNm1RZU9V?=
 =?utf-8?B?SnYzR3g2a1JJOERFck9od0lTNVdMZkpBUFJTWVF0a0c1ZEtDMWIrUkJWc1ZM?=
 =?utf-8?B?aDJoNWdRMCs5RmxsMzk2NVd0U0l4aGVHS21DZklzT3luclBkQUViMGtBNkFO?=
 =?utf-8?B?VWdPUlJXSGFpRHl2QkVWWHBvWFNCYzZta3ZqNGhxTWpSYnRoNDhsMFNNRDB0?=
 =?utf-8?B?MGx2SWFWTTdSSFNoWUtveVZwQm9sL1Yyd0RqY1h5Ri9rOGU1MVljSUhjQzJI?=
 =?utf-8?B?YTFydUtLLzlCb2Y0eTcydFNFNnVrNlVjbkprNXlXVnpleUpGajJ0ZDBDbFpl?=
 =?utf-8?B?RTZiQTFrYXA1aG9UTTNxeWhrVmRWTmxGKzVlS1MwbElVV2V1MmNvcFVORkJt?=
 =?utf-8?B?TmxHakJWLzNxUzBLUzVYTmx0cWNrcFRoZkJ6TDFFN3QvZGZqaWJTNWVra0tP?=
 =?utf-8?B?bDg0NWxjSnIwUGhKVFJyTkR6N2hKRGFnSEk5SVBncm1qbTdWTzd6dnFQaFJB?=
 =?utf-8?B?STFSTkxIY1NJNFhsNmU4Wk9qTHNFcWxDZFFFS04xZFV1b1BVOG1BSGVNQkJK?=
 =?utf-8?B?Yy9nZlNmSU9xQWFzUzlDWThmeGp5YWVFamZ0RHVVempIMmdweDdYbTlkaU12?=
 =?utf-8?B?RHNod3kzalppV0JzQk5rbjhyNmErYjZwNU1xVG1OWTl5aGNkREtGZ0hYSGFm?=
 =?utf-8?B?Y0xOT01UaUNqZUhXNkxzVkNqYXRXVVEyRGNrUXlPVUg2ZDJJY29SbGtCNUps?=
 =?utf-8?B?akhZQ29kOHlNa09FSVNWNFJBWHljQkxRRlN5NUtSekZRVHZnWXdXMUlveENu?=
 =?utf-8?B?V2RmRW10Ymd6M01USzZnMnpWT25yd3p1cGxDeS94RjNTRk9VOTRKNk0wVXIz?=
 =?utf-8?B?cFFDU0ZjMWMrMmVtVGlSTnhsRjhMWHJ5UVhKTWdUUnZtWXBVNEx0eHFQeDZK?=
 =?utf-8?B?VC9CNmhCSUdac3ZHbGxuaTRQREFLdndkMWt3ZUdUdWRWK1Q5UDFBYmtQSk1s?=
 =?utf-8?B?RXNoaTVjMUhGUTBjQ1dHK2FvV1lvT3pUZ1ZZaVdETC9VUWNaQUJSdjJFZEI1?=
 =?utf-8?B?cFEyUjE2Z3lUdGdpK2VkaG5qVGNMclNzR0xDYkM1V25QZXVodGhNQWVOYUpE?=
 =?utf-8?B?cFlZaGE5WnhWSzdqMzdUMkc2NUxTK2wwRnh0NzNKeHk3U3ZaZ09DNTU0bzl4?=
 =?utf-8?B?YW9vVTYvMmVESHdKMmdFOHozTVpHZjJjVmFzckh0UUxaWExtZGxuTE9SWjlK?=
 =?utf-8?B?NXppSUVzSkdPRit0SEVpM3FCb2d3c2pDbldTbXhicUorNDQ3MTJhb0c3WHdK?=
 =?utf-8?B?b2c1TWFYcThYbEtKRlNZVlNXZUc3ekdZaTdiNmN0S2hBQlFRQnY1K3VhQkJp?=
 =?utf-8?Q?UL7U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f16e20e-3a8f-44e8-86d1-08dc20ea2093
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 16:48:32.0118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xipOskHPYN2QkKqwRMREVBTocFK16vRozdLI1DiGpSspbobewBUM8U4nqW1VMeLa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368

SGkgU3RlcGhlbiwNCg0KQSBnZW50bGUgcmVtaW5kZXIuIENhbiB5b3UgcGxlYXNlIGhlbHAgbWUg
dG8gY2xhcmlmeSB0aGUgYmVsb3cgcXVlcnk/DQoNClRoYW5rcywNCk5hbWFuDQoNCj4tLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFRyaXZlZGkgTWFub2piaGFpLCBOYW1hbg0KPlNl
bnQ6IFR1ZXNkYXksIEphbnVhcnkgOSwgMjAyNCA0OjU1IFBNDQo+VG86IFN0ZXBoZW4gQm95ZCA8
c2JveWRAa2VybmVsLm9yZz47IGFiZWwudmVzYUBsaW5hcm8ub3JnOw0KPmFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbTsgU2ltZWssIE1pY2hhbA0KPjxtaWNoYWwuc2ltZWtA
YW1kLmNvbT47IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyByb2JoQGtlcm5lbC5vcmcNCj5DYzog
bGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBsaW51eC0NCj5rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUkU6IFtQ
QVRDSF0gZHJpdmVyczogY2xrOiB6eW5xbXA6IHJlbW92ZSBjbG9jayBuYW1lIGRlcGVuZGVuY3kN
Cj4NCj5IaSBTdGVwaGVuLA0KPg0KPlRoYW5rcyBmb3IgcmV2aWV3LiBQbGVhc2UgZmluZCBteSBy
ZXNwb25zZSBpbmxpbmUuDQo+DQo+VGhhbmtzLA0KPk5hbWFuDQo+DQo+Pi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+PkZyb206IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4+
U2VudDogVGh1cnNkYXksIEphbnVhcnkgNCwgMjAyNCA2OjMwIEFNDQo+PlRvOiBUcml2ZWRpIE1h
bm9qYmhhaSwgTmFtYW4gPE5hbWFuLlRyaXZlZGlNYW5vamJoYWlAYW1kLmNvbT47DQo+PmFiZWwu
dmVzYUBsaW5hcm8ub3JnOyBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb207
DQo+PmtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZzsgU2ltZWssIE1pY2hhbCA8bWljaGFs
LnNpbWVrQGFtZC5jb20+Ow0KPj5tdHVycXVldHRlQGJheWxpYnJlLmNvbTsgcm9iaEBrZXJuZWwu
b3JnDQo+PkNjOiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+PmxpbnV4LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUcml2
ZWRpIE1hbm9qYmhhaSwgTmFtYW4NCj4+PE5hbWFuLlRyaXZlZGlNYW5vamJoYWlAYW1kLmNvbT4N
Cj4+U3ViamVjdDogUmU6IFtQQVRDSF0gZHJpdmVyczogY2xrOiB6eW5xbXA6IHJlbW92ZSBjbG9j
ayBuYW1lIGRlcGVuZGVuY3kNCj4+DQo+PkNhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVk
IGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+PmNhdXRpb24gd2hlbiBvcGVu
aW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4+DQo+Pg0K
Pj5RdW90aW5nIE5hbWFuIFRyaXZlZGkgTWFub2piaGFpICgyMDI0LTAxLTAyIDIzOjIwOjE3KQ0K
Pj4+IEN1cnJlbnRseSwgZnJvbSB6eW5xbXBfZ2V0X3BhcmVudF9saXN0KCkgZnVuY3Rpb24gdGhl
IGNsb2NrIGRyaXZlcg0KPj4+IHJlZmVyZW5jZXMgdGhlIGNsb2NrIGJ5IG5hbWUgaW5zdGVhZCBv
ZiBpdHMgcmVmZXJlbmNlIGZyb20gZGV2aWNlIHRyZWUuDQo+Pj4gVGhpcyBjYXVzZXMgcHJvYmxl
bSB3aGVuIHRoZSBjbG9jayBuYW1lIGluIHRoZSBkZXZpY2UgdHJlZSBpcyBjaGFuZ2VkLg0KPj4+
DQo+Pj4gUmVtb3ZlIGhhcmQgZGVwZW5kZW5jeSBvZiBjbG9jayBuYW1lIGFuZCB1cGRhdGUgdGhl
IGxvZ2ljIHRvIHVzZQ0KPj4+IGNsb2NrIHJlZmVyZW5jZSBmcm9tIGRldmljZSB0cmVlIGluc3Rl
YWQgb2YgY2xvY2sgbmFtZS4NCj4+DQo+PlBsZWFzZSB1c2Ugc3RydWN0IGNsa19wYXJlbnRfZGF0
YSBpbnN0ZWFkLg0KPkNhbiB5b3UgcGxlYXNlIGNsYXJpZnkgaG93IHN0cnVjdCBjbGtfcGFyZW50
X2RhdGEgY2FuIGJlIHVzZWQgaGVyZT8NCj4NCj5UaGUgenlucW1wIGNsb2NrIGRyaXZlciByZWNl
aXZlcyBjbG9jayBwYXJlbnQgaW5mb3JtYXRpb24gZnJvbSBmaXJtd2FyZSBhbmQgaXQNCj5pcyBz
dG9yZWQgaW4gc3RydWN0IGNsb2NrX3BhcmVudC4gSW4gdGhpcyBwYXRjaCwgSSBhZGRlZCBsb2dp
YyB0byBnZXQgdGhlIHBhcmVudA0KPmNsb2NrIHJlZmVyZW5jZSBmcm9tIGRldmljZSB0cmVlIGFu
ZCBnZXQgY29ycmVzcG9uZGluZyBjbG9jayBuYW1lLiBDYW4geW91DQo+cGxlYXNlIGV4cGxhaW4g
aG93IHRoZSBzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhIGNhbiBiZSB1c2VkIGZvciB0aGUgc2FtZT8N
Cj4NCj5UaGFua3MsDQo+TmFtYW4NCg==

