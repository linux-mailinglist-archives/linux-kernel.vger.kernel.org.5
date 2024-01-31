Return-Path: <linux-kernel+bounces-46182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B0B843BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C3D1C25E69
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3D869975;
	Wed, 31 Jan 2024 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ca7aO2mc"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC266996B;
	Wed, 31 Jan 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706695919; cv=fail; b=o4n0cCLoK/J1pIoXIfuLgB5eBpf0i1ouZwUDmJITrwy9rysa2BUp7nXeAISw0zOMAZddWpfpkhnfOYZtQuTOsEbgkc0MFXeh0kHlPpLyq2bJY/0mH3xjeJrPsuk3V41XwJAmKDcVeJsW8dhrlIvP7csT31+MlaiR0Ad/3Kz0hu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706695919; c=relaxed/simple;
	bh=M6W/fVXHHpJU2xT3l1drIM8S6ixt8Q7bmFUVZWytrm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KfSeOk4IeBbmQuc+T/6KyCPGHBfVd2yXw/82ZP69oESi1qsM5pcYTXy+dhZulLlHaC44gDD+qwS8vZdlfF/WZkjgx5Gps30ZwtVmRVc+W1aZ9UG9V9qplJEAOrmVlF4LFvWarXaeZS7frheQDaf+NLJ+wq0b3aBw02zvSyYvLhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ca7aO2mc; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ2Mf3J1gdq212h4WN2Mz9FO3C6uOItg5ryWzdJ4TmKe7bOWqPOzGJo5lI0zXijqqK2VOHhWcSSs74CKKqegBSVarOgcGiVSIKvqpA8SCx3GLmkY9CmyRMIeQ8hKtPq/lDzN5zu1IJevezGsKvQSNS7WUFquUjUtnk939FZW05ysT2PxGK2+CQo9CCUmUE7+j6U0KAVlNQfSymBmX/q0yjCMQsccjxfSErcsypCHVT5b46eyG1SvvZTzToiEtQNXCba6vQevl+/jf+Xzm7T3Yw8idMLwJPnwBz+hkph1xEEbHHF7nsBWuA1IV77Itmb2utzeDvzdu3XJQi0y3/B0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6W/fVXHHpJU2xT3l1drIM8S6ixt8Q7bmFUVZWytrm0=;
 b=ijT47y3V6CrVUvbozcLWzP1HT8BmD55w7zwsJHNagyaDTheGXFz+vK+ote5dtehAmpdmv9qEFIl2py0e3nyGLt8JjdxQPgLtp4O9j+zgOKHXz9u+VsES+VXf9AzMrKIcDQ4+0Oge/5qJk2V5su3b8m8qEW32hSTh2l642d+JCzW/HYlFTlcQwz2EGzsfEPmfEtBFMSsIle8PKCMdSkt/1cdjuGNq+iBapRCHY5NzhJG11YSY7fIOGFufKZvcSImiEQXv5tTQjzmlcQ5qwgJg4QJ4qVFbUInsBGIg6/1K5nnFJtPcUfZj2CIKKqBXVHovLpyomhTHaxcrMu09dzGQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6W/fVXHHpJU2xT3l1drIM8S6ixt8Q7bmFUVZWytrm0=;
 b=Ca7aO2mcg7quEC+wGLN3H6IXq6yvOrQRd7Zks0yScMofss1Ebmjhobzu3+OD3vLWA1WZ7A9PzxnJF5mPB0Ccv+5iAXAZgziKvEXf0v61SYWWap02y9vTRYNsB4AMzgvALIPorbZ1rtR8BEsyWqL8M2JJ08QumpEa2DSNh9Tjkp8=
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com (2603:10a6:10:1a::19)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 10:11:51 +0000
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::6bca:3978:83bb:8a8a]) by DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::6bca:3978:83bb:8a8a%7]) with mapi id 15.20.7228.026; Wed, 31 Jan 2024
 10:11:50 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "broonie@kernel.org" <broonie@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx
	<linux-imx@nxp.com>, "benjamin@bigler.one" <benjamin@bigler.one>,
	"stefanmoring@gmail.com" <stefanmoring@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: imx: fix the burst length at DMA mode and CPU mode
Thread-Topic: [PATCH] spi: imx: fix the burst length at DMA mode and CPU mode
Thread-Index: AQHaVC3otfDou86mc0KogxOLjuuCkQ==
Date: Wed, 31 Jan 2024 10:11:50 +0000
Message-ID:
 <DB7PR04MB50031F5413B1B67B12B0934AE87C2@DB7PR04MB5003.eurprd04.prod.outlook.com>
References: <20240131024623.329240-1-carlos.song@nxp.com>
 <20240131-chant-reoccur-7d63ba3f02cf-mkl@pengutronix.de>
In-Reply-To: <20240131-chant-reoccur-7d63ba3f02cf-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5003:EE_|DB8PR04MB7002:EE_
x-ms-office365-filtering-correlation-id: 303e636d-2233-4064-9957-08dc22450aaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bgf9fPZLo8Wj48yfGrVkX8FUlHcjdLXBfAcvM7Sg6N68xR4n4ciC8ptZb8YOwEn2oEjS2M3fj0nHaJhd5NRJtI7eQr70hBfWp7bDNT6uwtOQKYnSIeWPfEunqs+2NPqZTfYmlL5MeBkICrO/BQrEuAR1trqxK0couAgadpJANTycj8996Ys705vFXylm5poemyt8Ay+Yz6M0/n9Ra6a2RHw4x2z7sQDSYN7t4EaI2btYLJXvB0SNsCUc7Ok34FaxrO7lTTVmn90nfjq6M5H+eiYgWUWgr2rnZjsY2BYmpgSzXeov7wr2S9TIMdkInW7wyycR2PxTFdS50DgiDCixCoaYbOXqRWJENYdqce1qMGeWRDZpUH+q8UBbFLvauB6f13xUMwDkbmiCQrtk1Nh0kzyNT7bY6+fCylUhngUOFee2S/88TVJJ0IbA45/T06CmTM3sfxpRvKjKWQE0IQW1tiR1CnzAUB+CvezVar9rO47FT0PPUnZo1pTpT8J3nxVw9km6OYOzb8pErmIoqPRbYjL1IrWLDPwSEXUVZxtStZM5diF7Tpf+PTO3+sElHSuLTqbCbbAcQOsDXW3+fA+xetO7SWpI5yDUoB0sEpUSFL8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5003.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(52536014)(966005)(86362001)(478600001)(122000001)(76116006)(33656002)(26005)(66946007)(316002)(66476007)(66556008)(66446008)(54906003)(6916009)(64756008)(66574015)(83380400001)(7696005)(6506007)(53546011)(71200400001)(38100700002)(41300700001)(9686003)(4326008)(8936002)(8676002)(38070700009)(5660300002)(55016003)(7416002)(2906002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFdJUitaYzA2YXpqT1ZBaHp2emdXNjN5NHBrajA0NllFWWlPdHRFRXVuNG93?=
 =?utf-8?B?MldJampvYXlQWEhNc1pIc2U5SDJ6Qnk2Qk55WGJ6RGdLR3B1ZlI5S2IzUXQ1?=
 =?utf-8?B?WXJmVmxkMytQOEpHajBvR3c5UDhmMzRJNm9hSDVYTW5JSlgvYUhDTTFiWVZX?=
 =?utf-8?B?RDN2RUgyeEI3WmRVTW1XK1BKeWp5ZVp3Qk81RUI4bnpFNXdLMDYxbmZ2eE9S?=
 =?utf-8?B?NnVMY3dWalRWNGJOZTBJVkxrYmVGVkZPOFpidmtHN3o3V2xOS1ltMkJjRDJM?=
 =?utf-8?B?MFYzODJVeWpGM04zeDR5UWR1YlJtZ3Q2RzVIMU0vUUpiMDYyNmRydVZST0VR?=
 =?utf-8?B?TDMrZU9lSVE0OXZWUlNpMTZoREp5Q0dYSEdIZnFWZ3F6dWRZM2dxc3FXUDZ3?=
 =?utf-8?B?MzY5dW5ocndDOHBmcEUzVTFRdUZGdGRWMkN0OTdjZkltS3p1VkFVUnNXQnlT?=
 =?utf-8?B?SmM5T2JmcTFrdlk2YWliSUsraGZxTzBnWEw3MkJjSktpbHFVVVlBS1krSGhV?=
 =?utf-8?B?ODJ2cmtEUWFrRFVwbWxPWjRKMEU0aUVNK3pyODdZQWZaRXRiY1lXTHRuNFcw?=
 =?utf-8?B?bk0zYjVsZkJkN21Ccms3MzgrV3M1Q3pMNGRiYzJjdHE0VU45amJvb0ROY3Er?=
 =?utf-8?B?WlhWK0Y3OERMeXVUbm4xNEZyK2JFMWVEUG5GM292V3BrS1llMnpPc3VWcTht?=
 =?utf-8?B?ZXdqQ20zTkpiR01GbTVIbCtVSzRzckVVY04wN25pVDVJQ2JmSTE5OVp2QTFH?=
 =?utf-8?B?ZjJrNjFDc01kaGs3WGNaNUpQNEJ1MlNmWEtLMXVLTmE0c0tPN1FCN1Zabzkr?=
 =?utf-8?B?eGh0UDJ4TDBpbFJxazB3cmtNYXdsTHpkSGpIOWZCM0haNm1KMCthVStDNHpG?=
 =?utf-8?B?V2FxSmlxQXhJUERiN0owU2Fuek9oU1RhYnRLNjllUmNaVWhheFpFdmV6QW9p?=
 =?utf-8?B?dXMxZzluUmR6Wkc3ZE90N2RZazlIVENGS0w4Rm1DcG1NbytwcGJEVWZIbVBJ?=
 =?utf-8?B?alNhWGhNOEpUeWwxbXhQNlRDRTZCV2lRMEJRMFRqdG5YdzdIem5GN2JJaDJj?=
 =?utf-8?B?SElTdHZyY1laQkN3UXpCUm5qcTN6N0JVQXBUelkwNEFkSWdrQklTUjhUazYz?=
 =?utf-8?B?VDB2eUcxSGZWd2NmQkl1RHBySVhHejZSUzRzMkJ4WjFTTndzT1JyS25YRFpx?=
 =?utf-8?B?akxOVllIaVl6bmZvT2UvS1lGL2VablU4N1k4TDFPblpuNGxYdEMwdWdnRW9X?=
 =?utf-8?B?Nk9xcE0rOFJIOWtlZG0vOGszVUhMNzlkeFVzcHF6aGxqT3VIUGFDeTFuendK?=
 =?utf-8?B?ZHJJcll6TGZBK1lPQUNHaGx4OWFmVDZwRlR4Z0xUNWtCemJNVzBHaWFVMC9U?=
 =?utf-8?B?aWp3S1lLSkJ0dHdBTkU0YU1NZUFqcnhDMHN2d0p5OFl4eUd6WE9xZ216eVJk?=
 =?utf-8?B?WjZqeWx3ZGhiZEx0b0dLTGtRYm9GNkxFYUw2M0x6NHlTZ3g2SXpJZUdCSW01?=
 =?utf-8?B?ankvcjNIYkNScTAzcXJzWTM1YlF5bm1mLzhuMHM2UnNvaFNycENHRUtVMWRD?=
 =?utf-8?B?R3U5UHh0QlloeVVZbitLcVZiVDNaekdqWUhsV2JaaGY0OE1kWWRkQ1Z1bEE4?=
 =?utf-8?B?RENHaWs3bFZKUmR6Z1NaOWxaVEF1a3NDNHliUjZRM0Z0V3FmazgyeFJZMWhM?=
 =?utf-8?B?UWxJQk5kZk1HTjV6eHFoY2FzM1ZMUjhzVldGZDZ5S2RIZlQ3T1RLbTFVWXcx?=
 =?utf-8?B?Ung0K043cVcxaUVBTENrcmc3bUpNSGxlNC9aKzdsYWwzazUvWkl0OXdjNG1m?=
 =?utf-8?B?NXE2VC92cG91RWg4cUxUQWQxT2lNcUVxRVRvRlpZYmludjB1dnNZcC9rUUts?=
 =?utf-8?B?REEzOUdIMHhDdVBjVlBpSGkxSFVyMWhNMFQ1MmF6VHVyTTFweDR5c0puWnUv?=
 =?utf-8?B?Sy8xYWNMeVJaRlAvSU81OXRqQ00xNkM1VlhBMUJBWUx0ajZwcDREUVlsaTBy?=
 =?utf-8?B?ZGtaaThwZmZZMGRITXdJdTRrN2hFLy9LMkU5ZmpHNitCWFJKVnU0TDN0d1BM?=
 =?utf-8?B?WmllV0JHY3lqL05xRG1TUFhHa2xGZ0cyelNwMW95RWpJS0phZHI1bFBqMjJq?=
 =?utf-8?Q?bQhM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5003.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303e636d-2233-4064-9957-08dc22450aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 10:11:50.6839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6yqBr19CmV3p5SEj6YFy+AJf1mEQOH6q6HzuJAvHlSI0A6NwCOmV7k/dHbV66edU18A8WiBYQ2AtKG/iioyFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMzEsIDIwMjQg
NDowOCBQTQ0KPiBUbzogQ2FybG9zIFNvbmcgPGNhcmxvcy5zb25nQG54cC5jb20+DQo+IENjOiBi
cm9vbmllQGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhA
bnhwLmNvbT47IGJlbmphbWluQGJpZ2xlci5vbmU7DQo+IHN0ZWZhbm1vcmluZ0BnbWFpbC5jb207
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgtc3BpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhU
XSBSZTogW1BBVENIXSBzcGk6IGlteDogZml4IHRoZSBidXJzdCBsZW5ndGggYXQgRE1BIG1vZGUg
YW5kIENQVQ0KPiBtb2RlDQo+IA0KPiBPbiAzMS4wMS4yMDI0IDEwOjQ2OjIzLCBjYXJsb3Muc29u
Z0BueHAuY29tIHdyb3RlOg0KPiA+IEZyb206IENhcmxvcyBTb25nIDxjYXJsb3Muc29uZ0BueHAu
Y29tPg0KPiA+DQo+ID4gRm9yIERNQSBtb2RlLCB0aGUgYnVzIHdpZHRoIG9mIHRoZSBETUEgaXMg
ZXF1YWwgdG8gdGhlIHNpemUgb2YgZGF0YQ0KPiA+IHdvcmQsIHNvIGJ1cnN0IGxlbmd0aCBzaG91
bGQgYmUgY29uZmlndXJlZCBhcyBiaXRzIHBlciB3b3JkLg0KPiA+DQo+ID4gRm9yIENQVSBtb2Rl
LCBiZWNhdXNlIG9mIHRoZSBzcGkgdHJhbnNmZXIgbGVuIGlzIGluIGJ5dGUsIHNvIGJ1cnN0DQo+
ID4gbGVuZ3RoIHNob3VsZCBiZSBjb25maWd1cmVkIGFzIGJpdHMgcGVyIGJ5dGUgKiBzcGlfaW14
LT5jb3VudC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENhcmxvcyBTb25nIDxjYXJsb3Muc29u
Z0BueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54
cC5jb20+DQo+ID4gRml4ZXM6IGU5YjIyMGFlYWNmMSAoInNwaTogc3BpLWlteDogY29ycmVjdGx5
IGNvbmZpZ3VyZSBidXJzdCBsZW5ndGgNCj4gPiB3aGVuIHVzaW5nIGRtYSIpDQo+ID4gRml4ZXM6
IDVmNjZkYjA4Y2JkMyAoInNwaTogaW14OiBUYWtlIGluIGFjY291bnQgYml0cyBwZXIgd29yZCBp
bnN0ZWFkDQo+ID4gb2YgYXNzdW1pbmcgOC1iaXRzIikNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9z
cGkvc3BpLWlteC5jIHwgOSArKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Nw
aS9zcGktaW14LmMgYi9kcml2ZXJzL3NwaS9zcGktaW14LmMgaW5kZXgNCj4gPiA1NDZjZGNlNTI1
ZmMuLmI0YWRlMmQ1M2ZlZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktaW14LmMN
Cj4gPiArKysgYi9kcml2ZXJzL3NwaS9zcGktaW14LmMNCj4gPiBAQCAtNTQsNyArNTQsNyBAQCBN
T0RVTEVfUEFSTV9ERVNDKHBvbGxpbmdfbGltaXRfdXMsDQo+ID4gICNkZWZpbmUgTVg1MV9FQ1NQ
SV9DVFJMX01BWF9CVVJTVAk1MTINCj4gPiAgLyogVGhlIG1heGltdW0gYnl0ZXMgdGhhdCBJTVg1
M19FQ1NQSSBjYW4gdHJhbnNmZXIgaW4gdGFyZ2V0IG1vZGUuKi8NCj4gPiAgI2RlZmluZSBNWDUz
X01BWF9UUkFOU0ZFUl9CWVRFUwkJNTEyDQo+ID4gLQ0KPiA+ICsjZGVmaW5lIEJJVFNfUEVSX0JZ
VEUJOA0KPiANCg0KSXQgd2lsbCBiZSByZW1vdmVkIGFuZCBJIHdpbGwgc2VuZCBwYXRjaCBWMi4N
ClRoYW5rIHlvdSENCg0KQlINCkNhcmxvcw0KDQo+IFRoYXQncyBhbHJlYWR5IGRlZmluZWQgaW4g
bGludXgvYml0cy5oDQo+IA0KPiByZWdhcmRzLA0KPiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5ndXRy
b25peCBlLksuICAgICAgICAgICAgICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgIHwN
Cj4gRW1iZWRkZWQgTGludXggICAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRy
b25peC5kZSB8DQo+IFZlcnRyZXR1bmcgTsO8cm5iZXJnICAgICAgICAgICAgICB8IFBob25lOiAr
NDktNTEyMS0yMDY5MTctMTI5IHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYg
fCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTkgICB8DQo=

