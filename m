Return-Path: <linux-kernel+bounces-47726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96288451D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D69283C93
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A297157E9E;
	Thu,  1 Feb 2024 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fjZpz5F5"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0D157E90;
	Thu,  1 Feb 2024 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771663; cv=fail; b=WQcb6woy4xud0tQrGaQKWatI9lSckJpsF7Z7AsCNXoC0Xw5/HE5flp9bCm8znj+a16Gzut/CPNjmYdwgEca+D1ok0sPBCMD9MTifSv0nboTC6R/KrDZK6MfODBWxaunn89oqyQdDixMruiDTEoKipDYiOOVdXArIrBZzXyXQXpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771663; c=relaxed/simple;
	bh=aXT/+wd/6KkMDWWlJGc+K75yvCANB/5zwvjaIBMXsI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UrMQDZJBrpBCSn8PIGF5i2TCE5Dn/H01behKYUBDLo3akS0KMPPdrl77GF7Mi0ZanC08GH1g5yqXcwMJm/MI7tBxCOVIr8fBOP4zqR3iY8MlT6ly0Ef9kRas21FbKzLmwprrnoCSrQturd6CQryPzb34I/IrdWaeuGqJF1e23ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fjZpz5F5; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwUo3FYezNC+/xGdp0dMN7PeoK8wgqubDslWb33k9gGtMCHbz2X9haRu9KJz68UeCESVNbOOH6z/WmEAZu/HhcJNzZm2qEtSSudFCy1CoPqp84BOShJfxhEip9/WGIMC6LWqvO7CwlsmUhbAiQty7k/6pktjYUfZDXUhlWkHf96GdqHWAfMdF1X8SG8c02C4hIteMPHbC8xX1EzuxKRJ9xG7ZHBlbIw2DZatHg/GVdeWtUnh4qPSj5odbK4/uWOrKWSSmWZz+MR3kd/zhAe6IvT9t/1I/QrLkjBm8fy4K3dMtebhzYujUWtlsu2MleL4x39SFwzApVQx1LbDiGQhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXT/+wd/6KkMDWWlJGc+K75yvCANB/5zwvjaIBMXsI4=;
 b=DeqaFtJlRe4LOqUM33sd4c5/brH69At52OZX4t//fs+Pu/df2bezC8OiD3IlEifRsxBZUGZLeA/Ef4ZKWT/LvdReJpQn3HrQVNU5+sDOTAudZIjEFLIcz5abTGnWVy1JmbSaYJyM21iwQHibZiKURbCnz9sDvTVogpk1WQXEANlF9jPzCgzSSACiLJ67NehdwBaq3ARh+U8lolT6fMC+SBJz+8vjWjGTZbaP5DBy9nHxt41kFuOIQCfvxMOlCk3NikGIl3PtlslhyeixPYw7/6N96uZVu7YGxm4hxajIeY9LSNcagNtzKf/4hqPG2yHGgbs2Lx07zEfjZBps5nFk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXT/+wd/6KkMDWWlJGc+K75yvCANB/5zwvjaIBMXsI4=;
 b=fjZpz5F5d/UXHqFHlgOe7ZrBNYxnycnYUFb25viUG8x54+ObfqBk34bkwu7pQ47SDrO0DwsMPTtxz73Ge9shwzicjbgHcegQiBcTl8B8A5bGNyJ8jBVs3kjyPWlLcHOSh3srn7ccD2LcZwcFeaqz7+ghp1mvgVSA0RlHyMv8kGI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9323.eurprd04.prod.outlook.com (2603:10a6:10:356::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 07:14:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 07:14:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "souvik.chakravarty@arm.com"
	<Souvik.Chakravarty@arm.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHaTFMXfSW/KLMkFECgD1P261LWWrDwxwIAgAAQxgCABEqJkA==
Date: Thu, 1 Feb 2024 07:14:17 +0000
Message-ID:
 <DU0PR04MB9417A9074C5DC49AE689E65288432@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
 <f88d07ef-83b2-4d14-976a-6dbbd71e036f@oss.nxp.com>
 <CACRpkdYV=qYQ9qDUWYTLDAV1niay30gYH5S=zjfi31GpeY5o-A@mail.gmail.com>
In-Reply-To:
 <CACRpkdYV=qYQ9qDUWYTLDAV1niay30gYH5S=zjfi31GpeY5o-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9323:EE_
x-ms-office365-filtering-correlation-id: 152d5977-d42d-4acf-112e-08dc22f56721
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YyJhSGKZg0ThTnYM7z+V5gXHucEhflPB+iCKvp9W8OBIkV/SiKi7jF1jndhXR5IGCpVvtD/umA5j1aDfK/dV1mwvCrl3RUVEI+kzppgXcARH7Q+w+F8CFGGR8PdAHCtA/kA6akae14L9KlqqExru9NmBg5EdwL2uDJdOxEuSocqkzU8xpCCyeayqjstJAAT8Xslj3uDWeb5UobrIvhkKjfrAFEzMis8HDnzNMUsm40wlAZhzD4JvY0gTjmmRzt6bgjMqlKF9chrF7YcYSJYzfwAicmdKwR2IIy/9WjXK8tWZA+tv3jSrFxfopThjtLAz/VC895hs3r4uot0Rz/0HNs9kuPQTEy9zZW29cMVIP+QzNBEWeODWHGovpRDF5o197dcJJhKODykOp9V3pG5FlDSsG0hJOd+VK4vm2LTUTEuKCLapGbxM0ArdCd0lRgkvjM6FP71DF6jPpIRoBZx3rz02X+C9Q1BrAOMTFzVeVQtilEz5TVRkOwlvNnLsthO4IdyEgdAVVJznX+dQLtadLd8goPnazG8q+h9iidkHcC4rwfXPkopL3LvYm1JD6xuqdV1kkXwksg8b00an6gTuagvPme1zsgdWMxcSwRQdJ1ag9JXNZNzh/2ma0f9njLyE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(54906003)(52536014)(4326008)(44832011)(8936002)(8676002)(110136005)(33656002)(66946007)(2906002)(5660300002)(7416002)(86362001)(64756008)(76116006)(66446008)(66476007)(66556008)(38070700009)(316002)(122000001)(38100700002)(9686003)(478600001)(6506007)(71200400001)(53546011)(7696005)(83380400001)(26005)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjVVa1FBWllSKzEwaStXZWVMQUNKdXVPWnlDaHJNd0R1WDFreElNY09INVVh?=
 =?utf-8?B?dTZrY1VqQUhEOEtsaUozQWhVdjZkQ0ZUanVFSUhiakwyS3A4eVA0Z0t4cHNy?=
 =?utf-8?B?WjJ3OFIyUWt2bXRPUTRVaUJNQ0M5ZCtVZ3JncUxDT09zbllkeXVnSnFtUWZ1?=
 =?utf-8?B?QldsYW5NNGlEOWFOTStOZHQyeks5b3pGT1FOdDMxVzJia2c4emY1V0F2VWZL?=
 =?utf-8?B?REw2Z3FEOEpZSkJyMzdRVHZNVHg0ZEw1MWZSUHltR2NTcU5Jbk9UY1p2Y3pH?=
 =?utf-8?B?STkrYkNXMG5DbE90VjA0WUMyOVdnSHB0c2tnVG5DdThibHc5OFY3SWlSamFD?=
 =?utf-8?B?ZmZ4aWdZRTZXQ0w0WUVpNzJMOHkvN3IwSjNycjRuZndmSURhK3ZIcWViUFRE?=
 =?utf-8?B?eVdiKzQ4Y0t6UHpKek9EUE1OV2pIREc4dkU4bGhjRHZQZk5aSnNvQ1hXM0ln?=
 =?utf-8?B?NkF6dDlPY003akNxV0ZMQ1lpOGtKSFNmN3JHWFlzc0t1elNpTTl4MFMzOHA5?=
 =?utf-8?B?b0ZmS0VaSUc1N0FNZEs3SnhFdm9aZ1BCbzQvRVpwQlJtbkhNdGNEOVQ4ZVpy?=
 =?utf-8?B?WEZNVURtaThMUHRyYTB4cE1jN2oyazczTmZXNVYvVnMrTGFRMkZzaENaM2xT?=
 =?utf-8?B?bysyMnlwd3RwL0RFNjRCK01sTWxPMHpuWEFYTEh6RkpHUkxzQW9XbG5ER3BM?=
 =?utf-8?B?REIwOXRjbzhEd0hFcWNnWmUya085UGNwSnRSMzV1cWRvdTE0MzFoS0VUajVY?=
 =?utf-8?B?NlVPc080N2tIaHhtd2tWdWdZREpsME1VdU1jSXBMaWo4USttWWJqeDBIczdG?=
 =?utf-8?B?QlhQei9yMFRLZGJTUHRmZXBHb015WlppY2ZSNHdxWCtTdVplazNEZnM0UUhy?=
 =?utf-8?B?amtKR1ZVQVJVU3NJcTQvZENWRkVteHdrSmt6aWhMRnFNMmJZdlFOVWFJNkMz?=
 =?utf-8?B?U1dwSEJEaGoyWm9HV21ESFg2M1lpVGV2SXV4RlNqUEtCL3VQU295S1hvY1p3?=
 =?utf-8?B?ajRqK3IvV0JlSHlEYnNjRHhsR1lrRU5ZMmpkVzlqaVFWbCtGWXdmRG5qdU1q?=
 =?utf-8?B?dEtGV1pxL0xkWGhtMXBHTFZ3am5oTmFFTzZoWFdvODY5aFlnZUM0T29OK3JP?=
 =?utf-8?B?MGxObjUvZW0xc0QzZ0dzanM2SDJlZGhwMk54bi91NlNBb0tuR0ZzQU44QXV5?=
 =?utf-8?B?TVNuYmtxNkhybmdCZFZGOC8zMEFFYktQNUlJeW1UK0lYWGc2bkgrT3gzRTA5?=
 =?utf-8?B?ekNZL3ZhM0hwSlV3U1VnSmZDQTdKa0ZIdkQ0Tm5CTUhxVE5UVEpQYW43TUVq?=
 =?utf-8?B?dGppeDg3YXE3ZGwxc1lQbEZDcDdkWGhNVGpYeGp3RHphSEZmK0FtZis2Z3F5?=
 =?utf-8?B?bzQxQ0dGL1dLdmdYcXAwTWV2OWFBdU03S0VscHNLaW5ZdFlWTzFuTHBVYmVD?=
 =?utf-8?B?ei9nQ3hEc1VEL2dwYlJrZE5oaTVOWmJ0d3VFQzJtS3BYWkxVOU0wbjl5ODBQ?=
 =?utf-8?B?aTJsWk1jRFRUOEpZODRTQURlTGtITFdiNThueEc3VnhDbUp4MDNOeXdFclRQ?=
 =?utf-8?B?bVgrUDc5V2Q5cEJyUVlPK20vL3hyelI2Y24vUjRyL09XZXp4NTRoMFZhUCtZ?=
 =?utf-8?B?bkVoOUJIZWlUKzJuU1dwVHlkNWpSdzJHSVYxQTJGZHJ0dm5BaEp3NndrVUVK?=
 =?utf-8?B?RWE0RWtSd0hJUjJYWW81bFkwajNYSko2MVZtd2Mxd2hFU0w0VTRhWE1ES0pN?=
 =?utf-8?B?MDBmYjEzN0JxN1dhT256VDUwbk9IZlU3TENxNzFIaWVnTkdyZ3BrVndXV0Uz?=
 =?utf-8?B?byswZjQ2d3J5WHRxa3I4MExFQzd3Q0hmMGxpOEMvYkRUS0N5VlRCNEpIVjBG?=
 =?utf-8?B?N21ML2kzbzl0NGxicDgrSnRVK3g3WkJWd2NpUngxQUhDWExueFZWQTNnWFZY?=
 =?utf-8?B?QVVPZzRYU3pRRUIvSC8yekdyaUtXVEcraEx1aTM0V2ZPa1I5eXFmTXJySXhq?=
 =?utf-8?B?d2dmczJrT09VQ2tUcVVDWlpuY0wrWEVqSEJQNjdKZm1qcHhiZVJET2xySmlw?=
 =?utf-8?B?VXA0eFFxK3ZNMCtiakdJbThrbXc3LzFYWi9ISGVaVUNoNnFrdjJuaEhrK21w?=
 =?utf-8?Q?fJEc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152d5977-d42d-4acf-112e-08dc22f56721
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 07:14:17.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wINOwaan4PZ6ySY0NECwrMvipOr51prWvyxEmgQjVwj2+pBbAGFp+uvhLvrkocLkCmmRUE9m23hqWpAKInL4SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9323

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvNl0gZmlybXdhcmU6IGFybV9zY21pOiBBZGQgU0NN
SSB2My4yIHBpbmNvbnRyb2wNCj4gcHJvdG9jb2wgYmFzaWMgc3VwcG9ydA0KPiANCj4gT24gTW9u
LCBKYW4gMjksIDIwMjQgYXQgMTozN+KAr1BNIFBlbmcgRmFuIDxwZW5nLmZhbkBvc3MubnhwLmNv
bT4gd3JvdGU6DQo+IA0KPiA+IEFuZCBmb3IgaS5NWDk1IE9FTSBleHRlbnN0aW9uLCBkbyB5b3Ug
aGF2ZSBhbnkgc3VnZ2VzdGlvbnM/DQo+ID4gSSBoYXZlIHR3byBwb2ludHM6DQo+ID4gMS4gdXNl
IHZlbmRvciBjb21wYXRpYmxlLiBUaGlzIHdvdWxkIGFsc28gYmVuZWZpdCB3aGVuIHN1cHBvcnRp
bmcNCj4gPiB2ZW5kb3IgcHJvdG9jb2wuDQo+ID4gMi4gSW50cm9kdWNlIGEgcHJvcGVydHkgc2F5
aW5nIHN1cHBvcnRpbmctZ2VuZXJpYy1waW5jb25mDQo+ID4NCj4gPiBIb3cgZG8geW91IHRoaW5r
Pw0KPiANCj4gV2hpbGUgSSBkb24ndCBrbm93IGhvdyBPRU0gZXh0ZW5zaW9ucyB0byBTQ01JIHdl
cmUgZGVzaWduZWQsIHRoZSBwaW4NCj4gY29udHJvbCBzdWJzeXN0ZW0gaGFzIHRoZSBwaGlsb3Nv
cGh5IHRoYXQgZXh0ZW5zaW9ucyBhcmUgZm9yIG1pbm9yIGZyaW5nZQ0KPiBzdHVmZiwgc3VjaCBh
cyBhIHBpbiBjb25maWcgb3B0aW9uIHRoYXQgbm8gb3RoZXIgc2lsaWNvbiBpcyB1c2luZyBhbmQg
dGh1cyBoYXZlDQo+IG5vIHVzZSBmb3IgYW55b25lIGVsc2UuIFdlbGwgdGhhdCBpcyBhY3R1YWxs
eSBhbGwgdGhlIGN1c3RvbSBleHRlbnNpb25zIHdlDQo+IGhhdmUuDQo+IChUaGlzIG5vdGlvbiBp
cyBldmVuIGNhcnJpZWQgb3ZlciB0byBTQ01JIHBpbmN0cmwuKQ0KPiANCj4gVGhlIGkuTVg5NSBP
RU0gZXh0ZW5zaW9uIGlzIHJlYWxseSBvZGQgdG8gbWUsIGl0IGxvb2tzIGxpa2UgYQ0KPiByZWlt
cGxlbWVudGF0aW9uIG9mIHRoZSBjb3JlIGFzcGVjdHMgb2YgU0NNSSBwaW4gY29udHJvbCwgYW5k
IGxvb2tzIG11Y2gNCj4gbW9yZSBsaWtlIHRoZSBvbGQgaS5NWCBkcml2ZXJzIHRoYW4gbGlrZSB0
aGUgU0NNSSBkcml2ZXIuDQoNCmkuTVggU0NNSSBwaW4gcHJvdG9jb2wgY29uZiBzZXR0aW5ncyBm
b2xsb3dzIG5vbi1TQ01JIHBpbiBjb25mIHNldHRpbmdzLg0KDQo+IA0KPiBCdXQgSSBzdXJlIGNh
bm5vdCBzcGVhayBvZiB3aGF0IGlzIGFsbG93ZWQgaW4gU0NNSSBPRU0gZXh0ZW5zaW9ucyBvciBu
b3QuDQoNCisgU1BFQyBvd25lciwgU291dmlrLiBBbnkgY29tbWVudHM/DQoNClRoYW5rcywNClBl
bmcuDQoNCj4gDQo+IFlvdXJzLA0KPiBMaW51cyBXYWxsZWlqDQo=

