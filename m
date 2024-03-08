Return-Path: <linux-kernel+bounces-96377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9133875B6B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A170282A4D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910FB36F;
	Fri,  8 Mar 2024 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hntBuHYa"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A87363
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 00:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856722; cv=fail; b=OuhUHFbdlmgHHcdtp9dgDzXzy9JDeUO9SUvK66Ux1OtYsHvn7UfavZekDJLlurj0IMzi8s5YoS0vbjsHkzidKgRMVKHq11nM/30Kr3xvMXQgt4ddbfIslcArmUdzCmPOYXthDJ+BPhEAz9AV7rcGf/r3/6WSezuLqQgy3vRfIIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856722; c=relaxed/simple;
	bh=8G8zmJ731IziwpFfffSUUlthBReIgfsTuDsUAXNF8k0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HB01NBwUOGFkhcJkzFQuf/i19Jo00q9VfBsiR5mOJQ2Q5mfl7mJnOV/44xOBh1iiXwaOoUYKsBz9P04z/7iEQMSdkQ6Ox48pld/Bg4gSRlBvxwZLHN1mVHMzXmw12PzPO8M9phLHnZwNB4q6jxJlzghREujC1UJe0HXW8ea/D2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hntBuHYa; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea7HKxLi8xgHmoT3UOexEX4ovkR3DgJXsvLEOY6r2RaFyVycXy6iZTSrhW/G0VgHsMMIDCgZnzfjaGaNBtKdgHPXiCJ7edVD/mzGhr4XymPeoqHf3nhMEK7iT3qsfi/hSOtyVFraQ3oECHhdhcFtmXtkl2X5bErQx+VT+gfQf1MX00Zv4lDrXmFnJv1ZCDNkRGD4P61WVcqbgMD6cKF+TjfhITC3mPhedCOeFkwJ05WrzCaMbgnzwSla3yVo6f3vCeaBGjKvQvvbL5pix5Bi03hji5uzZkxcf3xXuyGXWrNnOd2mJM9q8i89g703WBp/InnH7Wm7sHIrDUHKSnAXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8G8zmJ731IziwpFfffSUUlthBReIgfsTuDsUAXNF8k0=;
 b=mjbdE8lG65YYgl02r2Fu7D/aXvhuacyE8H2lZMnzyzKAfIPXreJ6X15fjmzSm2KYhGHjgSuw5hjCKd9E4L6UKQ7jsQHtrWQ9L8emHDrsjpMGDTsFsb6qBfpLOhRlOF2F4YT7emxIJL+ddCg19nWhGsUavRjzXj0FePhPoPCbCyKtSxywDVAlWDKaJJF2DnDH5IK+s05JUpChrdKKfjevndAoKDwz7JJ7zoPpdoPX4FyyxnYM5GXTaJ9rZ+TzBL89/755+BZT6++NABSdy/cOSIw8wOK2w/r5w3L0vm5ado79PwXJCBYeUt3SmLOuY4x+iycgDV+UcOhla4irpZRdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G8zmJ731IziwpFfffSUUlthBReIgfsTuDsUAXNF8k0=;
 b=hntBuHYaE5sfIVwPoSlqpI1NV9BN3/Ue1kKd5I95w7Z6uVv/VFt0fUiEy2mI4cAZQp9+zLLHFzhoMScohtDAhZ/KFKD0NUbQ7E7qmzwc/6KiKL8+RZbfiYzXnV4jW4AY3ZG0QBreXMwYpKaQn+aP9GtAuRsmuFNIJFe7TN5u+TWgAFtjPQ7cBozw+Q56j+vnE56IymWI2mmiuAhPCCnlMmUF6SXNxd+DtbnaJaaN3akSX29ISwuzD0PVO3kmyVa/CVbGwVS17xsYcutjtq6Y4L0sGaDRxFcdE5wQmYLBA1627ZiiztRjBYnVtTleRCea157LVebcZTZf7sza46e4Tg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 00:11:58 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 00:11:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Len Brown <lenb@kernel.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown
	<len.brown@intel.com>
Subject: Re: [PATCH] nvme: Re-word D3 Entry Latency message
Thread-Topic: [PATCH] nvme: Re-word D3 Entry Latency message
Thread-Index: AQHacMRKgZXzDa4Qy0SNAlK7Hj9fHLEs+O6A
Date: Fri, 8 Mar 2024 00:11:58 +0000
Message-ID: <4a39e04f-900a-4460-8cff-0b0d6c50a200@nvidia.com>
References:
 <63ff4f9aedcb73ec5d8cc7f3e77ec4c72d72b4ae.1709839023.git.len.brown@intel.com>
In-Reply-To:
 <63ff4f9aedcb73ec5d8cc7f3e77ec4c72d72b4ae.1709839023.git.len.brown@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4087:EE_
x-ms-office365-filtering-correlation-id: 3a876a0a-091f-4349-c94c-08dc3f045ed2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /ufLAR59MGZcS+8luiXFbZccrBg4/WMNr48I8r7OTxoHHRMZ8L1Vk6aVxp1PxFgIRXr1gLc10Gp0JPAI/GKhJcNCAu7QbDrbB++8bYUqPqAjwOBXHNIXa/8i2iI8Mcb/0TEqXz8NNm/cK2cn/TxweqcCezkwgQiwjgzFAp3B8/rS0XffntH+znsV1UCXbqVrpbg798nvpUIJ6AcLWTUmt9vbCBFtnTjsN60F8FqLELyCjSFhppVGaWqOkKcR59Rec11NvHHRu7v00Epbx6RkgrZ10OwT52/qQ2X9pA6PMThgPSJ7L1oqEHuWa27j8+48G1Zgh2xDkRFldEL2vAvXleSBQZGbbYVjf9vTcBYwktmZ0nsX0MJ2x5c3xIIDv80y8tKBv65re/Ww3M1cnB50ezUI9sX06xhm2qq0Iej0Tpw7Rbzx/58UnpI02gRsMaPsTjc5nWlFxCrwliEYb5DlSUN1Qfin14X8xS7UfR5LBjPJglXIWKzAHYE0Anx3GgRQIbKdQ1IRm+jXbnJA1KOXNcd1d3VIhLf54gNK+5825sHkrfKAJG3X7I+AxMA9sgdeqyS0cENsc7j48pXBt7AqBbM/75lxw71+0XRcNgXT0ooDs/GB4nqBnjE/0q0OEvET/qHbH+c/MoCvEnnVZvFaN570vhpK5+CpGmQ/QD9BtZYzOMaARYDVChsBT7EXJlXA8u/bQsvSq35BrsIjOC+45KKnBn3IB2s0BjJpTCNm6PA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799014)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFdsa2NkRXRGZG5DVjRSNnlxbmFuQUxySUhhdGxpUUlnM0dkeHRmcWZqdjdY?=
 =?utf-8?B?S21XOE5jOGdPSkpGV095ZC91Zi85RGg0czdRUXRJZDV2T0FTeXFWYlpuMXBK?=
 =?utf-8?B?YWlEaUxRMkxhdUMrVWZSWTNJek5OT0FEU3lVMXFNLzEreWVhWEVWVkJYR0px?=
 =?utf-8?B?Z2pSdTR3cUJ5YysvczRWc2hKYU82WHE5Q2U2NHBPM0NLaUoxVWVaTytTNTJs?=
 =?utf-8?B?M2FRQTQrOGo0WlNVQnd0c1BocWhGeVg2VElyWWhqc09vQjZvdzJCS3lscEFX?=
 =?utf-8?B?SHAzU3FpZHJyc0FJcnRXcllhMmVZRXZHNlhXNm9YS0JVRk54YktwenZIOUls?=
 =?utf-8?B?ZVV3Y3BETXpDNXpUdjk5Zko0QTQ3Y2FVKzZmUHBGMjFaOGMzbFZ3TFdPMU0x?=
 =?utf-8?B?SnJzeW5hTkVQak4vZExNL1B4WmZrNTY5QzRJc1U5R3hHY1UxbTVud21veVhP?=
 =?utf-8?B?aW1iODhQSkNqeWEvT2h3NVllTnlLUVZIaHkxSkEzM28yMFVFcDF2RXE4UG1u?=
 =?utf-8?B?SVlkMzllQm9WcjJwOGY0RU5ZQk1UVGg3Z2FGR2J0Ym55Z2ovL1NlVVl6YTFS?=
 =?utf-8?B?WDhtbURDR3VTT0VkaXI4MFVja2VzSnBiWkFxNVFta2gxaWxSY0NUWTFLT3N0?=
 =?utf-8?B?WGtmMVI1cFRUR3FHVFJTQVFwQSt4S1RWeTRRaEJGOE1hTUNybGswVG9LbFBr?=
 =?utf-8?B?aGNnSnRXYU01TExTaCtkSHBWOFh2dktBOGF5b21SWFVLK3QzQ0psRSs5dnF3?=
 =?utf-8?B?dFl2ZWtoVTRFMGVEM1NPOTIxeGc1Vm1jOFV1VWNjaDlZMWErT01mQW1JdjV1?=
 =?utf-8?B?bG1ScFlXQ0pMb05iTTJHSW8rYzhpMkQ3NFhEWHBsM0JBSmo1bXlQMmRvbmdZ?=
 =?utf-8?B?eVdMMGlpeVhxdWh3MmFHSDdiTkJFRzJRTGRqR3dBblB1U2k0bnZ3L0xlS2xY?=
 =?utf-8?B?SDhNV3NDZkV3RW1WQnMreDZFM2NjT3A4T1duamEvaktTL1RtUkh2Q1RRdDV2?=
 =?utf-8?B?MzZkU09HU2J4QS9YQWhyelRqQ1BoZ0htT1FrQ09wQng0SVdUKzB6L0lpRVlz?=
 =?utf-8?B?Y21HbWNhWkhQU2NjbDR2Yk93c0RINDVSUjdDbVY5Z0dhM0FnNWdxOVhNTi9V?=
 =?utf-8?B?b2RxNExZV3BIVURveDlWMmxwcG1BUmt3STJURkw1SFQzRXhLSTRJQ0FFQVVJ?=
 =?utf-8?B?a2M1NHlJbjFiUll0TVY2b1BBeWRjVVdRSTFvS2ZjWUdZYlgyRlIxU1lCYm40?=
 =?utf-8?B?MDgwVFRmdTl6aEpPeTd4cGtyN05nZ0tqcUtQYlVpNGJDQlZUYko4OXdTUHRP?=
 =?utf-8?B?aTh0RmlaRGcrcjVVV3lnVmVQSWg2c3Y5eW1PQzduSlNHdG1EMG01N003c2pW?=
 =?utf-8?B?L0cyd1d5enJHeUZ6RFFaYW5qWFNQMWxaQnpUNlZCcDZsYXZBUmxXSUxLSk4v?=
 =?utf-8?B?WGM1TDNiQWkyRk15QkUxdlQ3TzBublJRR0ZzQXVSVmxhdUE3WitucU1wUzN2?=
 =?utf-8?B?em1sZm1ZYmxDTFk4TU1TS1FyTmJXeVNERXNJcGF1SGV0amJHdUVIS0txeWhM?=
 =?utf-8?B?c3hDMlV3NkNseXFiYkswNFRSbTNvTmdPcG9KdjFQbDB3NUU1ZjJpMFM4NGwx?=
 =?utf-8?B?WHVxcERZUFB1RitOUHpWMnB3K0k0ZGRUeTkvTGk2V01qYmpDaG94dVhxaGlW?=
 =?utf-8?B?K1Ivd0lWYU90NHVQQmorc3ROTU1icTVyak02QloyaDRaN2JWRFVOZmNBSk1X?=
 =?utf-8?B?QVo0UUZXZGtzR2wyV0VMMUMzcCtKL2ZUWEFHbHA0bFlWb0pPSk5wTmZyK2Rx?=
 =?utf-8?B?SGxnd2J3bFZtZXBIcGdTaWErK2tRSVIzNzB4SHF2WDNHNFZJMTZReUVPOURq?=
 =?utf-8?B?L1czNjhPL3ozekE3bDIwb3VkTzRLaHhqQm9DYWRHTGRvWHl1WlE1Z3l0ZGsx?=
 =?utf-8?B?dnQvMDBGalhOdk5mRlZUWGt0YzdkR3dic0J5d1NRZFIzY1B5c1N3ZFhidFA5?=
 =?utf-8?B?S010UXYrbmpVMktKV0srTk83YkhMSmxnakx2dmczcDNzRkNWUDZ2M1hpdlZi?=
 =?utf-8?B?cGl4WUFOUU10WGhCMW1aMDhtSGlxaEo1ZnNPanUwZTdqUGNaRmpnVExrTE9x?=
 =?utf-8?Q?7shKmjaxSObguTXoafUYtAASi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19D4530993DD484AB7F8123352AFDF83@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a876a0a-091f-4349-c94c-08dc3f045ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 00:11:58.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIC9E5tSHNod4sFS49RknRH+XgNrVu4PzuMiYDeU9cih9JXJc+aNTQOACoP9WUxdYLm4A1iZ0fBViCFGrivMcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087

T24gMy83LzI0IDExOjE3LCBMZW4gQnJvd24gd3JvdGU6DQo+IEZyb206IExlbiBCcm93biA8bGVu
LmJyb3duQGludGVsLmNvbT4NCj4NCj4gU29tZSB3b3JkcyBhcmUgYWxhcm1pbmcgaW4gcm91dGlu
ZSBrZXJuZWwgbWVzc2FnZXMuDQo+ICJ0aW1lb3V0IiBpcyBvbmUgb2YgdGhlbSwgc28gYXZvaWQg
dXNpbmcgaXQuDQo+DQo+IEZpeGVzOiAxYTM4MzhkNzMyZWEgKCJudm1lOiBtb2RpZnkgdGhlIGRl
YnVnIGxldmVsIGZvciBzZXR0aW5nIHNodXRkb3duIHRpbWVvdXQiKQ0KPg0KPiBTdWdnZXN0ZWQt
Ynk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogTGVu
IEJyb3duIDxsZW4uYnJvd25AaW50ZWwuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMgfCAyICstDQo+DQoNCm5vdCBzdXJlIHdoaWNoIG9uZSB3aWxsIGdldCBpbiwgaGVu
Y2UgLi4uDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQotY2sNCg0KDQo=

