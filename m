Return-Path: <linux-kernel+bounces-67952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF88857385
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C451EB24610
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBE5101C4;
	Fri, 16 Feb 2024 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ebI1JG8e"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986AAFBE9;
	Fri, 16 Feb 2024 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047652; cv=fail; b=KMGjGMO/E3HaUvmMzAl6WgDp81Gn0YS85lVQucoyffSvbGEF/OlRRCkvgOX9uxjAWS/iPOUljPffrebcSIfOS4zEdTakEAqBdx5H1XYnNsM9QkKs33Yl07SN2ytvk5vqiD6UNRUPjr8gLeCwVJl0PMpEIHPaaIRRjwA7YYejPAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047652; c=relaxed/simple;
	bh=f4GUNYpsKuy0bQdxK0sjskZbLD9PGxN9yN7iWh0472c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M7k1EsdijQJ1HGmUsCv2VavUO8hGIglQMJi+3LnJU41nyAiGUBc0JqT7KoQQ7gUigMBKgueq9ucWZBHbRKl8wHVLCX2goJiw/mfqsqZ+1netHH+8Pzekg1XlkMfnnArYZk/F23lcFISDNMvM59GAzG3XYiFqvYFlDBcc3xE05qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ebI1JG8e; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dxj0km6ZWEO5sIs6Ur2wPe7usD+lOC13cDmDDLTBMXlVwwIRkPQEMCx+eVSHw65tcS9bOz4deZqu62l+2PfAQOrcCGXsP2J9dA90wYDDjXzGMp/Cu+E1huDe5jKEx6AqQeIKxNWAcyd+0nonvNH864nTvvqtXuAuIzVJQHIwwsGJpxvyI0aVbi9eu8DtgrXGoFiKg/LwvxJ2W826HOMQaHKPIZXK6TIuLmEJDD5mRqMPlGPOsGVHRqc6O2bxV8TrkmSUSgzWPeXg3h/Mz4ggO8NwbReTRLN27MCY1tLsIFdtFmZsRmV3c+lAxKiOCcGXHfQjmBopJrc4aCXGnHkfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4GUNYpsKuy0bQdxK0sjskZbLD9PGxN9yN7iWh0472c=;
 b=HF0oRinyNYJtLKebKbLKXxjW9lXNuXM6ehReznO6xFuh8RxBd8eskTcwOv2W9ww+NEHx552VVZRZoAJqCbIDgkfE0ifZstG8aHUSwvEHtJBKS/9I848W28K4z5oREh9Mj716ZSFfTMTAPkO7Ypr3uqsL5zN6ypMU0CcGou67/JzzwdOGR2LVJ9YOpcDjRlJbmqL0KiUoODt1xGW/nhnPHuT0QIS2Y2vtNJUML9Kq7HAsFgd7gz4iKh4HSc+7hiL+8qfkX4rfimIaYeB+2FpnWrj/twMi0gZSymy87l7hlAE80cJ6/YkNw3Of8beBXzkZi/pVCiUX1Li4t37n9qPSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4GUNYpsKuy0bQdxK0sjskZbLD9PGxN9yN7iWh0472c=;
 b=ebI1JG8eloOv62psuNXYaV+OjmSbVv9xYfrsb9QLHg5ZSDICcLsqQ37AY5WeQ17A/e+9Hqzz/Tfec/UdYYVQFdbIQa0xczKdw0v0rME31WuMRpfCHcPnXRY/Z1ugTOHcIhMKrHuUQPbSMZ65NhWZa8yxIlDmPO44O5qpVn1nVRs=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9904.eurprd04.prod.outlook.com (2603:10a6:150:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Fri, 16 Feb
 2024 01:40:46 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3%5]) with mapi id 15.20.7270.033; Fri, 16 Feb 2024
 01:40:45 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Rafael Beims <rafael@beims.me>, Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index:
 AQHaSjEAO+HQnD/Ih0ixtnf/7VSxSLDyBCEwgA2BHICAAKZRgIAKoyiggACtD4CAAOEa0A==
Date: Fri, 16 Feb 2024 01:40:45 +0000
Message-ID:
 <PA4PR04MB963849A7E04ADEE5DE92002DD14C2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
 <PA4PR04MB96389A5DDB41DFF80CBB4738D17D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <48364f66-99b4-40ca-b4b2-4adf1071960f@beims.me>
 <ZcSB3_16C6JTgBJB@gaggiata.pivistrello.it>
 <PA4PR04MB96381141AFBE8E61B8DD94F9D14D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <b77af968-ec6f-44df-a544-4ea2a5ad3ff2@beims.me>
In-Reply-To: <b77af968-ec6f-44df-a544-4ea2a5ad3ff2@beims.me>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|GVXPR04MB9904:EE_
x-ms-office365-filtering-correlation-id: c7a7cacf-c9c0-4bf1-1baa-08dc2e904bad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cUXW5tUS1O4MXnYcnnrYiAfeE8XLExcn4BATm6DRoGKmMvPEccyQr9BOVY2pFwkfcKVGblgGj2EAtiIdd6ELXJb413CZkyQFWv48+T/+P+35ZUnYBVDTsEMTy4SeoybX8dHX3SiVbwNuKgaE64ZRb99PdwyF7V6jSD5nVnHrRC6te3ISg5NaAsxQoNJpIhn0cClGfIIFxoTVO9UMxJ5q1JhuFPUwYT2PYg05Wu4mURoZm4LwEQBNnsU0Yim9m8wBDxpBxa+2DJtRvA1ZqHF0+9XmG5xZt/sqYTEzpuqPFjKNpwFW+dhQikOMacmKeZ11p/2mVzR6/hdk6Ximt0L/tbkKfsbbVhRCUx4U8cIB0+OXGj03gHSnYDyU3z0z+GwvJWGR+o2hHm2pIJaqCFRt7Cv+5o7IQWJ8Oq0KoRrvycxhJRn2iVU7ujamYWeZnZ9A1ndPtkOSNuX8YC6RPLcA+Y/vWyfcmWlguAjOHQytAWrBrkpA/FfOPnu+GH4fneQ18vCJIQvuf1CDzSFIk2Ep8UJbpxDiAI9JISg3IYr+xh/SsotSUu00WTGMhAxI8kxcON9qpTsR5Moutf/DGArVvlwCJdmznL884B7ga9EV6Yg5pKFnuUp8uig+2NAOw3vT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(86362001)(41300700001)(33656002)(9686003)(478600001)(6506007)(26005)(7696005)(53546011)(38070700009)(8936002)(8676002)(54906003)(83380400001)(52536014)(71200400001)(38100700002)(66946007)(4326008)(122000001)(66446008)(316002)(5660300002)(66556008)(64756008)(110136005)(76116006)(66476007)(2906002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qk9zM1pHSkltNklnejhCbm51L2gvNVVLTm92RjUzN1ZaRDBaQ0ZiRzk2L2Zw?=
 =?utf-8?B?cUM3dFphQUo1TFRnamVOREYrT2pGZ0tJRVJmK1kwdW8zZmJzdGlZbEttTVov?=
 =?utf-8?B?aUpXY0E0dE84VTJBYmU5dUlYZU5VbEVLYnhZaTVOc3dVbmFoVDRoOEdqVlRE?=
 =?utf-8?B?N3FFRzZOYnJYazd4dC9rL2FpS2c5bSt0MDBTVHo2TlhNcC9yOFE5U2p4Ri9i?=
 =?utf-8?B?ZkY5eEwrMU5TdG41Q2FITGVVajJURlpPOEkzTWJZWkpFeWdES2ZGMko4Z0cy?=
 =?utf-8?B?NDlzZUZLd0treDZuWWY3QndQeFBCQlRxMUdSQ1VMTVg0bC9NaGs4UDRhbzJ6?=
 =?utf-8?B?TmxPUzB4S3oxZ0tzMFpQWENReC9pNDR3N3U3ei81bERKR1Y4ZXZZMGJQci8r?=
 =?utf-8?B?OG04cURubXNNS1BFUnZPd3FteDBKVjl3ekdIOWRibXpnWFJhc3I2OTkxZ2ZL?=
 =?utf-8?B?THhCV2h4QlZDYU9lWVRrZi9mRWVtMDEzKys2SG0zc1hPMTE1ci83RmRXZWNC?=
 =?utf-8?B?Rk1BK3VLdGZWaEhENjE3MWlaYWlnODl0Nk0rTWNXVWVvVGtlYlk5Mmk1ZHlG?=
 =?utf-8?B?UXpxRkxVMlVMZHVhOHR3VHNZYnZKci9TSzJPN3NMN0Excnp0M2tReGpZNDR0?=
 =?utf-8?B?QkcrOWE5Vm9GZndqRzNmVjNUd2pXSGZieEZTb2YxZmo2RkFaS0tRQ0pXc2o0?=
 =?utf-8?B?a3gyd1BlOVRUOEdoRDlwSEg5Vm4rdjRCU0lhcVAreE1kMXZieE1DMEh4K3Rw?=
 =?utf-8?B?ei9WaFhxYTBNUElIb0ZONlIycE5kTm9FSWNMWGJoUEZqUTlkTUF0ZFIvaDZN?=
 =?utf-8?B?TldkNUwrdTkrYXRoVC9Bb1g2WmN0UUVGMW1lRmtTMlArQjdmK0pMekpGRmhv?=
 =?utf-8?B?NkxEU2dtR1AyMmFIV2JqNVFRcVN0STh0Tnd0Vy82WFcwM2ZVcW5RU1pRMEtq?=
 =?utf-8?B?OXlHUnlZcnc0MndOVXZEbnVjaVpaaFlMekNsQWRSK1duYWZWNTR0NitmYURa?=
 =?utf-8?B?Z0FFblhodFBydlpZU3doUVNyUmUzMlBMZURRelJxRkkxTEFnV0FjdUhoYmN2?=
 =?utf-8?B?Uk5GNDN3bEZSczhOQWFmK2h2OTRqN1Q3U1FUdmx3dk40SXpMVkdmRTVaZ29N?=
 =?utf-8?B?L2tPWFZ6Mnc1b0hKejNXZDFlYXJ0V1BvUXUveFI1UnlUYVpCS0RNcFQ0bFoy?=
 =?utf-8?B?Z2lNWUR3c01SOEtUL1JvQVFRTGFtMFZJcGtGa085TEl3MTlpL0xzNFRHL0N0?=
 =?utf-8?B?YUVNckMzWHpLRlJkNk91ckR5RG1CTnUrbU04Tkg3UGQ2bUhRVmREV0NQUU9n?=
 =?utf-8?B?LzJYYTIwQS9RcG5mWUVHS0E3ZkR3cStPUzUzS3haWDhBZFVTaElmSHd5ejdL?=
 =?utf-8?B?V3pUYjZGNzRKbkpTa3V4TTFSVStINXhVbXd6cXQxOVMrWlFZNVAzTHllR1hn?=
 =?utf-8?B?dEFieTZxcnZ2em1kaGNrbE5KUnc1WVZDNDlBRm1BZFc4b3A5STVQYnVQenQw?=
 =?utf-8?B?MUVPQ2RjVE5lYTgwSEJEaHllU0ExOWFXcUFUeHZGdjBOVXIvbWRXMlpnNk5S?=
 =?utf-8?B?dVNJdXJYbjd6cjZjSjJ0TWJOa2pYaXBKTldaVEVJSzVOKzJZWmltR0J4V3NG?=
 =?utf-8?B?MzFFWDZHMnRJcXlpZDc4MWNmZ2d5MFA5SlU0VHpTOS9ONUh1TmFPSVNWbGY1?=
 =?utf-8?B?MVRXWUJObVduYk5ZN3l3MDZJQ2cydUV2UTNVakR4eHByclBla3ZBaVd0YzF1?=
 =?utf-8?B?SEQzKzcweUQzNThNUGZySERsSHRkanluMzc3OGNjNTdPODZOdUw0RW5OTGlh?=
 =?utf-8?B?RThnMW5HTm9GcXRyMGhkZVVlM1VhbXl1TXd6L0VnSDVzejc4WjJIcEExWTUw?=
 =?utf-8?B?UkpSV2s2VmNMT0JHLzYxdDAycjJSaWJBb3c2a2VuZlpLcmtGYm5MekJUUURn?=
 =?utf-8?B?MEVHaU54SFFQN2ZpU3FpbXh1b1BHZXFpbFl3SEVjTGpiYVVhY1ptaE1kMU05?=
 =?utf-8?B?VW1MTXF4Vzh3ZWlPUVlub1hJMFpldzNKZnRDR2N3aWVFQWU1elJZdWtUaFVW?=
 =?utf-8?B?Um5FYmx3blNBTlNQNkVHamN5NkcwZ040aEsvZm9xY0l1N2tsSHRheHBLYTdN?=
 =?utf-8?Q?jYzCmG0caG517QszJSeXcKAkr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a7cacf-c9c0-4bf1-1baa-08dc2e904bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 01:40:45.9102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RKXVSuJkb8K6HxloOkHsyBE+eWozH4ccuf3FYHIfEfsrEHciJCs9fHVrlp6kmcpf7Z+Umn7HTNU8hRkLlZGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9904

PiBGcm9tOiBSYWZhZWwgQmVpbXMgPHJhZmFlbEBiZWltcy5tZT4NCj4gU2VudDogVGh1cnNkYXks
IEZlYnJ1YXJ5IDE1LCAyMDI0IDg6MTEgUE0NCj4gVG86IERhdmlkIExpbiA8eXUtaGFvLmxpbkBu
eHAuY29tPjsgRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjb0Bkb2xjaW5pLml0Pg0KPiBDYzog
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc7IGt2YWxvQGtlcm5lbC5vcmc7IFBldGUg
SHNpZWgNCj4gPHRzdW5nLWhzaWVuLmhzaWVoQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbRVhU
XSBSZTogW1BBVENIIHY4IDAvMl0gd2lmaTogbXdpZmlleDogYWRkIGNvZGUgdG8gc3VwcG9ydCBo
b3N0DQo+IG1sbWUNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBs
ZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1l
bnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQN
Cj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gMTQvMDIvMjAyNCAyMzowNywgRGF2
aWQgTGluIHdyb3RlOg0KPiA+PiBGcm9tOiBGcmFuY2VzY28gRG9sY2luaSA8ZnJhbmNlc2NvQGRv
bGNpbmkuaXQ+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA4LCAyMDI0IDM6MjUgUE0N
Cj4gPj4gVG86IFJhZmFlbCBCZWltcyA8cmFmYWVsQGJlaW1zLm1lPg0KPiA+PiBDYzogRGF2aWQg
TGluIDx5dS1oYW8ubGluQG54cC5jb20+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGJyaWFubm9ycmlzQGNocm9taXVt
Lm9yZzsNCj4gPj4ga3ZhbG9Aa2VybmVsLm9yZzsgZnJhbmNlc2NvQGRvbGNpbmkuaXQ7IFBldGUg
SHNpZWgNCj4gPj4gPHRzdW5nLWhzaWVuLmhzaWVoQG54cC5jb20+DQo+ID4+IFN1YmplY3Q6IFJl
OiBbRVhUXSBSZTogW1BBVENIIHY4IDAvMl0gd2lmaTogbXdpZmlleDogYWRkIGNvZGUgdG8NCj4g
Pj4gc3VwcG9ydCBob3N0IG1sbWUNCj4gPj4NCj4gPj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRl
cm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nDQo+ID4+IGxpbmtzIG9y
IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1
c2luZw0KPiA+PiB0aGUgJ1JlcG9ydCB0aGlzIGVtYWlsJyBidXR0b24NCj4gPj4NCj4gPj4NCj4g
Pj4gT24gV2VkLCBGZWIgMDcsIDIwMjQgYXQgMDY6MzA6MDNQTSAtMDMwMCwgUmFmYWVsIEJlaW1z
IHdyb3RlOg0KPiA+Pj4gT24gMzAvMDEvMjAyNCAwNDoxOSwgRGF2aWQgTGluIHdyb3RlOg0KPiA+
Pj4+PiBGcm9tOiBSYWZhZWwgQmVpbXMgPHJhZmFlbEBiZWltcy5tZT4gT24gMjIvMTIvMjAyMyAw
MDoyMSwgRGF2aWQNCj4gPj4+Pj4gTGluIHdyb3RlOg0KPiA+Pj4+Pj4gVGhpcyBzZXJpZXMgYWRk
IGhvc3QgYmFzZWQgTUxNRSBzdXBwb3J0IHRvIHRoZSBtd2lmaWV4IGRyaXZlciwNCj4gPj4+Pj4+
IHRoaXMgZW5hYmxlcyBXUEEzIHN1cHBvcnQgaW4gYm90aCBjbGllbnQgYW5kIEFQIG1vZGUuDQo+
ID4+Pj4+PiBUbyBlbmFibGUgV1BBMywgYSBmaXJtd2FyZSB3aXRoIGNvcnJlc3BvbmRpbmcgVjIg
S2V5IEFQSSBzdXBwb3J0DQo+ID4+Pj4+PiBpcyByZXF1aXJlZC4NCj4gPj4+Pj4+IFRoZSBmZWF0
dXJlIGlzIGN1cnJlbnRseSBvbmx5IGVuYWJsZWQgb24gTlhQIElXNDE2IChTRDg5NzgpLCBhbmQN
Cj4gPj4+Pj4+IGl0IHdhcyBpbnRlcm5hbGx5IHZhbGlkYXRlZCBieSB0aGUgTlhQIFFBIHRlYW0u
IE90aGVyIE5YUCBXaS1GaQ0KPiA+Pj4+Pj4gY2hpcHMgc3VwcG9ydGVkIGluIGN1cnJlbnQgbXdp
ZmlleCBhcmUgbm90IGFmZmVjdGVkIGJ5IHRoaXMgY2hhbmdlLg0KPiA+PiAuLi4NCj4gPj4NCj4g
Pj4+Pj4+IERhdmlkIExpbiAoMik6DQo+ID4+Pj4+PiAgICAgIHdpZmk6IG13aWZpZXg6IGFkZCBo
b3N0IG1sbWUgZm9yIGNsaWVudCBtb2RlDQo+ID4+Pj4+PiAgICAgIHdpZmk6IG13aWZpZXg6IGFk
ZCBob3N0IG1sbWUgZm9yIEFQIG1vZGUNCj4gPj4gLi4uDQo+ID4+DQo+ID4+Pj4+IEkgYXBwbGll
ZCB0aGUgdHdvIGNvbW1pdHMgb2YgdGhpcyBzZXJpZXMgb24gdG9wIG9mIHY2LjcgYnV0DQo+ID4+
Pj4+IHVuZm9ydHVuYXRlbHkgdGhlIEFQIGlzIGZhaWxpbmcgdG8gc3RhcnQgd2l0aCB0aGUgcGF0
Y2hlcy4gSSBnZXQNCj4gPj4+Pj4gdGhpcyBvdXRwdXQgZnJvbSAiaG9zdGFwZCAtZCIgKHJ1bm5p
bmcgb24gYSBWZXJkaW4gQU02MiB3aXRoIElXNDE2KToNCj4gPj4+Pj4NCj4gPj4+Pj4gbmw4MDIx
MToga2VybmVsIHJlcG9ydHM6IE1hdGNoIGFscmVhZHkgY29uZmlndXJlZA0KPiA+Pj4+PiBubDgw
MjExOiBSZWdpc3RlciBmcmFtZSBjb21tYW5kIGZhaWxlZCAodHlwZT0xNzYpOiByZXQ9LTExNA0K
PiA+Pj4+PiAoT3BlcmF0aW9uIGFscmVhZHkgaW4gcHJvZ3Jlc3MpDQo+ID4+Pj4+IG5sODAyMTE6
IFJlZ2lzdGVyIGZyYW1lIG1hdGNoIC0gaGV4ZHVtcChsZW49MCk6IFtOVUxMXQ0KPiA+Pj4+Pg0K
PiA+Pj4+PiBJZiBJIHJ1biB0aGUgc2FtZSBob3N0YXBkIG9uIHY2Ljcgd2l0aG91dCB0aGUgcGF0
Y2hlcywgdGhlIEFQIGlzDQo+ID4+Pj4+IHN0YXJ0ZWQgd2l0aCBubyBpc3N1ZXMuDQo+ID4+Pj4+
DQo+ID4+Pj4+IElzIHRoZXJlIGFueXRoaW5nIGVsc2UgdGhhdCBzaG91bGQgYmUgZG9uZSBpbiBv
cmRlciB0byB0ZXN0IHRoaXM/DQo+ID4+Pj4+DQo+ID4+Pj4+DQo+ID4+Pj4gSSBhcHBsaWVkIHBh
dGNoIHY4IChtYm94IGZyb20gcGF0Y2ggd29yaykgdG8gTGludXggc3RhYmxlDQo+ID4+Pj4gcmVw
b3NpdG9yeSAodGFnDQo+ID4+IHY2LjcuMikuDQo+ID4+Pj4gQm90aCBjbGllbnQgYW5kIEFQIG1v
ZGUgY2FuIHdvcmsgd2l0aCBhbmQgd2l0aG91dCBXUEEzLg0KPiA+Pj4+DQo+ID4+PiBJIHdlbnQg
YmFjayBhbmQgZXhlY3V0ZWQgdGhlIHRlc3RzIGFnYWluLiBJIHJlLWFwcGxpZWQgdGhlIHBhY2gg
b24NCj4gPj4+IHRvcCBvZiB0YWcgdjYuNy4yIHRvIG1ha2Ugc3VyZSB3ZSdyZSBzZWVpbmcgZXhh
Y3RseSB0aGUgc2FtZSB0aGluZy4NCj4gPj4+DQo+ID4+PiBBdCBmaXJzdCwgdGhlIGJlaGF2aW9y
IEkgd2FzIHNlZWluZyB3YXMgZXhhY3RseSB0aGUgc2FtZSBJIHJlcG9ydGVkIGJlZm9yZS4NCj4g
Pj4+IFVwb24gc3RhcnRpbmcgaG9zdGFwZCB3aXRoIG91ciBiYXNpYyBleGFtcGxlIGNvbmZpZ3Vy
YXRpb24sIGl0IHdvdWxkDQo+ID4+PiBmYWlsIHRvIHN0YXJ0IHRoZSBBUCB3aXRoIHRoZSBlcnJv
cjoNCj4gPj4+DQo+ID4+PiBubDgwMjExOiBrZXJuZWwgcmVwb3J0czogTWF0Y2ggYWxyZWFkeSBj
b25maWd1cmVkDQo+ID4+PiBubDgwMjExOiBDb3VsZCBub3QgY29uZmlndXJlIGRyaXZlciBtb2Rl
DQo+ID4+Pg0KPiA+Pj4gQWZ0ZXIgc29tZSBpbnZlc3RpZ2F0aW9uIG9mIHdoYXQgY291bGQgY2F1
c2UgdGhpcyBlcnJvciwgSSBmb3VuZCBvdXQNCj4gPj4+IHRoYXQgaXQgd2FzIGNvbm5tYW4gdGhh
dCB3YXMgaW50ZXJmZXJpbmcgd2l0aCB0aGlzIHNvbWVob3cuIEFmdGVyDQo+ID4+PiBraWxsaW5n
IHRoZSBjb25ubWFuIHNlcnZpY2UsIHRoZSBBUCB3b3VsZCBzdGFydCBjb3JyZWN0bHkuDQo+ID4+
Pg0KPiA+Pj4gSSB3YW50IHRvIHBvaW50IG91dCB0aGF0IHRoaXMgYmVoYXZpb3IgaXMgZGlmZmVy
ZW50IGZyb20gdGhlDQo+ID4+PiB1bnBhdGNoZWQgZHJpdmVyLiBXaXRoIHRoYXQgb25lIHdlIGRv
bid0IG5lZWQgdG8ga2lsbCBjb25ubWFuIGluDQo+ID4+PiBvcmRlciB0byBzdGFydCB0aGUgQVAg
d2l0aCBob3N0YXBkLg0KPiA+PiBBbnkgaWRlYSB3aGF0J3MgZ29pbmcgb24gaW4gdGhpcyByZWdh
cmQ/IElzIHN1Y2ggYSBjaGFuZ2UgaW4gYmVoYXZpb3INCj4gZXhwZWN0ZWQ/DQo+ID4+DQo+ID4+
IEZyYW5jZXNjbw0KPiA+IFdoZW4gSSB0cmllZCB0byB0ZXN0IHY2LjcuMisgKHdpdGggcGF0Y2gg
djgpIG9uIE5CICsgU0RJTyBJVzQxNiwgaXQgbmVlZHMgdG8NCj4gaXNzdWUgInN1ZG8gc3lzdGVt
Y3RsIHN0b3AgTmV0d29ya01hbmFnZXIiIGluIG9yZGVyIHRvIHRlc3QgQVAgbW9kZS4NCj4gDQo+
IFRoZSBpc3N1ZSBJIHJlcG9ydGVkIGlzIHRoYXQgdGhlIGtlcm5lbCB3aXRoIHRoZSBwYXRjaCBp
cyBiZWhhdmluZyBkaWZmZXJlbnRseQ0KPiB3aGVuIGNvbXBhcmVkIHRvIHRoZSBrZXJuZWwgd2l0
aG91dCB0aGUgcGF0Y2guIEkga2VwdCBhbGwgdGhlIHRlc3QgY29uZGl0aW9ucw0KPiB0aGUgc2Ft
ZSwganVzdCByZXBsYWNpbmcgdGhlIGtlcm5lbC4gSXQgc2VlbXMgdGhhdCB5b3UgY2FuIHJlcHJv
ZHVjZSB0aGlzIG9uDQo+IHlvdXIgZW5kIHVzaW5nIE5ldHdvcmtNYW5hZ2VyLg0KPiANCj4gVGhp
cyBpcyBhIGNoYW5nZSBpbiBiZWhhdmlvciBvbiB1c2Vyc3BhY2UgdGhhdCdzIG5vdCBjdXJyZW50
bHkgZXhwbGFpbmVkLg0KPiANCj4gPiBGb3IgaS5NWCArIFNESU8gSVc0MTYsIGl0IG5lZWRzIHRv
IGluc3RhbGwgZm9sbG93aW5nIHR3byBmaWxlcyBmb3IgY2xpZW50IGFuZA0KPiBBUCBtb2RlIHRv
ICIvbGliL3N5c3RlbWQvbmV0d29yayIgZm9yIHN5c3RlbWQtbmV0d29ya2Q6DQo+ID4NCj4gPiA8
PENsaWVudCBtb2RlOiA4MC13aWZpLXN0YXRpb24ubmV0d29yaz4+DQo+ID4NCj4gPiBbTWF0Y2hd
DQo+ID4gVHlwZT13bGFuDQo+ID4gV0xBTkludGVyZmFjZVR5cGU9c3RhdGlvbg0KPiA+DQo+ID4g
W05ldHdvcmtdDQo+ID4gREhDUD15ZXMNCj4gPg0KPiA+IDw8QVAgbW9kZTogODAtd2lmaS1hcC5u
ZXR3b3JrPj4NCj4gPg0KPiA+IFtNYXRjaF0NCj4gPiBUeXBlPXdsYW4NCj4gPiBXTEFOSW50ZXJm
YWNlVHlwZT1hcA0KPiA+DQo+ID4gW05ldHdvcmtdDQo+ID4gQWRkcmVzcz0xOTIuMTY4LjEwMC4x
LzI0DQo+ID4gREhDUFNlcnZlcj15ZXMNCj4gPg0KPiA+IFtESENQU2VydmVyXQ0KPiA+IFBvb2xP
ZmZzZXQ9MTAwDQo+ID4gUG9vbFNpemU9MjANCj4gPg0KPiA+IEkgdGhpbmsgdGhpcyBpcyBub3Qg
cmVsYXRlZCB0byBkcml2ZXIuDQo+ID4NCj4gPiBEYXZpZA0KPiANCj4gSSBkaWRuJ3QgcmVhbGx5
IHVuZGVyc3RhbmQgd2hhdCBzeXN0ZW1kLW5ldHdvcmtkIGhhcyB0byBkbyB3aXRoIGFueXRoaW5n
DQo+IGJlaW5nIGRpc2N1c3NlZCBoZXJlLiBXZSBjb3VsZCB1c2UgaXQgdG8gY3JlYXRlIGFuIEFQ
LCBidXQgdGhhdCdzIG5vdCB0aGUgdGVzdCBJDQo+IGRpZC4gSW4gbXkgY2FzZSBJIHVzZWQgaG9z
dGFwZCBkaXJlY3RseS4NCj4gDQo+IA0KPiBSYWZhZWwNCg0KSSB0aGluayB0aGUgZGlmZmVyZW5j
ZSBiZXR3ZWVuIHByZXZpb3VzIGRyaXZlciBpcyBob3N0IG1sbWUuIFN5c3RlbWQtbmV0d29ya2Qg
aXMgb25seSBmb3IgYWRkcmVzcyBhc3NpZ25tZW50LCBzbyBpdCB3b24ndCBhZmZlY3QgdGhlIHRl
c3Qgb2YgQVAgbW9kZS4gSG93ZXZlciwgVWJ1bnR1IE5ldHdvcmsgTWFuYWdlciB3aWxsIGFmZmVj
dCBBUCBtb2RlIHRlc3QsIHNvIGl0IG5lZWRzIHRvIHN0b3AgaXQgYmVmb3JlIHJ1bm5pbmcgaG9z
dGFwZC4NCg0KRGF2aWQNCg0K

