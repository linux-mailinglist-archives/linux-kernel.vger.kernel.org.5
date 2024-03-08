Return-Path: <linux-kernel+bounces-96668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D53875FC2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C995283410
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A6253372;
	Fri,  8 Mar 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="vG3YcsPc"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2126.outbound.protection.outlook.com [40.107.93.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529421106;
	Fri,  8 Mar 2024 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887185; cv=fail; b=oTuxgJ1p94PYJ9leMl3l6w/JbYhh5x3mNtHM1PvpoqGD1Ya+cIM/IgXTgWYsrqXyyJXBeU7IWAfyBl1e0ib6p05k0oBiho5VukJYsxGXb1BItJeMSDnjCZ1YyxxTwNLYThsftev+HSzVnpdMOxtkplO2je7Cnd/pgWY3xya3KtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887185; c=relaxed/simple;
	bh=xrH/G/X2xoA+CVqzGUSWlmyWB10z9q02kkViEUUegWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BBSj9+kAStdN81b0FdxmGIwzynnLsQmteBxps86sRf5kLca5Y+oWmzJNfCeCIW/04HMKfdNqpBGfliCfco5op4RX0uJUSZ4ngP+lZcUv3xPG30zZZLSjb3t9UEuC6Ia5HTsC1C/GmHeOXdGVjynbh/28An6xd/fR2UzuXQ8LQJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=vG3YcsPc; arc=fail smtp.client-ip=40.107.93.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YK4Msqvk/Zj24wHi3D8KxXGEl9+QOtIq/BXCTHbt2HCW31efmP1wHUrk/WuX9JZ8VK9dHKp8AZGBJKhkRlSNDGD7iuKwQHPWZoxB3xyjMZjlaZs491e5q6fHtvWlAVpejlVM4Es8lHoPmB19tjVZgWYyUiOy3xD7uzfvGJ0V1ApX12TyuQY6OiS1IBDnHogPQLwG5dRD31nPz8SrBzHYXKZxyZMsR3lLWYUqvVWTFSfofzcSg2D5hiONLjjHVsx2Jv4cDGgCilXinDrf1AmG4yhLhn53jD2fJAImaxRbiMqYqGW7Fy2sAN3KPm81bRjCXh3wYfk/pYrusyllpRVNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6UMG7UZq6QYt5lmK0MKkMbvguaD9Wn/wRo5Zg2/bpw=;
 b=HyMJ/eYWjBWcKmyL+5ABcdW8v9MMvESMlSwRQ1grrIRoaEs2oDRkCxCFewmTIOM5Zopb8Z6BuFt8GeSJefty+uHmCU/aklXUoN/yMc+yMeyVzrTAFyUDIwU4HqSGH8Yisb9bjmDEUA//LlgiIHf/XzHn1kw6pfFmH+okMZInd5DH61auxKtVYm52ePceT+SaD2knvlwcToem1fnwk4tkaXwyQ++0nGE9kuB+8xG5BHwt2hRiLwTqRFzolHOFZTGZlLVAOIBc9hCfjXjHA3jCoH0hChtCWZYOabyl6msUyefp5weivTfP6OL3DFBViZIpNHp1Zas+aFHqAMSSnfIzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6UMG7UZq6QYt5lmK0MKkMbvguaD9Wn/wRo5Zg2/bpw=;
 b=vG3YcsPcdZwUQOrOph3Z4RQCEgYX5ILExlj+4ZRoqyaQR5YNNYqr3r3RM6MREZAk5KTYUd/Y88yN+ys+TlkP7ZOH+Ta5X7m0t3viJOpSGZ5yvlyXb0rIWHYtBZbobM1E5KNq6aOEOjorQOOYX5G3adiDLfMK/Yi5CzPgN68BM78=
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by LV3PR13MB6384.namprd13.prod.outlook.com (2603:10b6:408:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 08:39:38 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::59bd:c652:6485:aa42]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::59bd:c652:6485:aa42%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 08:39:38 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: Duoming Zhou <duoming@zju.edu.cn>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, oss-drivers
	<oss-drivers@corigine.com>, "christophe.jaillet@wanadoo.fr"
	<christophe.jaillet@wanadoo.fr>, "horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, Louis Peens <louis.peens@corigine.com>
Subject: RE: [PATCH] nfp: flower: handle acti_netdevs allocation failure
Thread-Topic: [PATCH] nfp: flower: handle acti_netdevs allocation failure
Thread-Index: AQHacJbnGqenCY0PeEmlsd7MLWD/0bEthN5w
Date: Fri, 8 Mar 2024 08:39:37 +0000
Message-ID:
 <DM6PR13MB3705982C783811A22D1692F1FC272@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20240307135335.19306-1-duoming@zju.edu.cn>
In-Reply-To: <20240307135335.19306-1-duoming@zju.edu.cn>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3705:EE_|LV3PR13MB6384:EE_
x-ms-office365-filtering-correlation-id: 244d81de-6d99-41d0-72ec-08dc3f4b4a2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Cv60qNLc4OfgB3biyrBug1Q/rQpASy7vNsz+NLiwBiQqWI9crHWvqGeEe4j9gEuB9hKKC0rXV16KDW69gWYma44RUGwAJ1aM+7/5IPagIfdKCeR6bOVHauts/QTZq02qQFUBGW6e1g5g+bzFzieTg57qiPmS2vFApwmfOsouVYfAi3YG5ZTNzUxUz7dOtKfqpC6DLEz6QhuZcdalikIrfYJJ7YuXnEJcF47sWqTzUlJtjazWd+++vnwzblf069MHTgWJoZrozCRRpi5E8Jp7BIexFIOriEHbF6Yr3BeF3Us9c1cQIPnPPWtq889n24SnjNR/f20rn2vQ8WEzPKfh9SAN/UuaqDyRKei+x94p0MDTxh2IuYFOcSvw0QS3i3ZxakTlSkZFefNK27NY1BiO8WsvV8ThVuY5PMC8JnwZEq+yyOaB+qlCCy+sAAVL6lYS5DjOaRRQpHKswlXYfGmpZvuR6EMtunmsj+Q5CT9gHorIayk3y1/XaLHsz5T1KQgR+7o/U2skRoEd5+tbD1SQPWqf8zBZR2fdm0fJNV8gcyMVi4w9Vmdjw5omhLC+NmVQZkYpa2jl63/edTFBnq+ZJQLVyn9SvAB2gjN2tb5Dfwy9h+REBodntjXLhF5WpxiB0WmbgVdYFW0h5OdYvQUDoqF+V9fLLTNl7dv9RmS4EvQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wDkWNABCWpReQ2pBan8hwaRvJTFxvkRsaxfnjlmqq/y4Rh72mM2DYlDv20EZ?=
 =?us-ascii?Q?N8K79eBtQKrKLk5njEM92+cnwVYtQWqBtd1IUjtaoqcQEcSp+XpjccFuC7EU?=
 =?us-ascii?Q?7MqzN2UX5eP77Fwr/2TrB5lltJpV/cLJeSCWnjwlc2NdJOABaDFQcLfRYlom?=
 =?us-ascii?Q?HPWYcuWyXXIoQW5HX1y++/G+0vFLSyd+D8qSuMSrddX6NTKq0P2LAMBFUn+E?=
 =?us-ascii?Q?txBDFBuzAwF8i5iT3GOOjioSs4ZO7txhBZBG+R05T35h/KC9NYToCGa/A+Ve?=
 =?us-ascii?Q?p5Nfny5vrKsA4+qLlEXA9cTGTSeZY7M4strch+X52IqkIgX1k6EIfvrVhgtm?=
 =?us-ascii?Q?0c5qAKxbmgbH2WbqLC8b5CYBOl4m4xKaHnBshkOFtuBnKWZjEXYfiRgZjkUt?=
 =?us-ascii?Q?l7RRnO/rjMpmlFF0Q7ZrngVrEPKlsiLmAHfWuV1/u1rF61vZQbDA/SGdLMW+?=
 =?us-ascii?Q?5f60kDDHSq+zXAycQmgopXXsC2UMHZr7qwK4Oq46D/NwX0XpBtezpQtRxdIf?=
 =?us-ascii?Q?ItJhXMT+a1OEp0Xy8McFkE0S5lAemIx8fxinsKfA0dRfWOUS7ixKha+1j9GG?=
 =?us-ascii?Q?WoB4551NyjTBCEHW3ZYYap8NUsHG4XcmSWvtJVi3uhIee4E4HM3BuaWFXKWT?=
 =?us-ascii?Q?OMI79iPeHsbRvBOG81GLLf64/N+/WQcZKSFpeXPN955/EL5gNIgjuU854czr?=
 =?us-ascii?Q?hrY/kbfjjUb7aoma4fet88mp3C8vWHvNjVHa+q5QE5kz/OAXkIuJpBWbvDpQ?=
 =?us-ascii?Q?O6tBhUC+RfePZUDxxBqhBNe54eJXCXWUAqtXvhOKob+KEGTtwi4BKUrj5sIx?=
 =?us-ascii?Q?/fDz5m/qdCwjuO/zZ2vbnigbSo+2YlTHmGZs6YMpcbs9kzVQYhRa2DT18TsQ?=
 =?us-ascii?Q?UajFNRNBGbMEsz1M8KGaX2cIkBQ6FCFP9n8f53OaJjpG1A88BqGvuHlLrpd4?=
 =?us-ascii?Q?pb8+09lXOVeYt0P2cZW1QmXIPR3mPq00Hqus9PvhX5l15R3r0+AsLSsKXnlb?=
 =?us-ascii?Q?wEHEqZAnjQ32I7b6y2aop4RDVjI4jit98KwC/+rdBdVpwzQvPYJV4WHrIojU?=
 =?us-ascii?Q?AIZhF29CiQC5dut4HrbF9BAGqND68mLQGcBpSgU5HvfRuZooH7yYzobu2c7u?=
 =?us-ascii?Q?dovUzO1bqdZCAejNbqNzgEmt60zGiOQWojE2Xiym4r12hirCgXT7kpCo0ExQ?=
 =?us-ascii?Q?lURC4LIKW5WLdSQQBmz/BmR5cJ3q+fK6WTf/W7/OVMHbhTWhMVG0cwVTWRKI?=
 =?us-ascii?Q?mkhLcgFahFknwT1L7UMpdYuGebrVrx3QTWNmcS8BYflxJ7SgU+Jk94ZbTvTx?=
 =?us-ascii?Q?r02HYGGD9eJvtSa1Vk+KgyuSmDQUq81Mnz1Sseu7bMK2qDLdyzsrrobAHz4O?=
 =?us-ascii?Q?T3T+7HcxyZRfCiLLMpVeGHwEiz54BEEcCGcqj4fVnfTP9ScIkP4BN/FtH3i2?=
 =?us-ascii?Q?C2N7KPuRbUblTxSSFkKfyY7fRGUwJzh/OmZRgEdY6wTUtw18a6E7w4Aksz7w?=
 =?us-ascii?Q?ExRH07Kd/tSy6Lhx/Mr+ga11vKtXGDc/xnQoCH1r9zF3tl8ahsMEALKp1w0H?=
 =?us-ascii?Q?C/BxnogOZAiX0tUCI2ICwa8pjoEobg2dve+KWLMt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244d81de-6d99-41d0-72ec-08dc3f4b4a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 08:39:37.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QO8qzthJNOM5gVXA7TglStqQyW5nD3ct0GiBXKuslpI8RZAwuFNnrDjoOQxlEklAuQvOSUqMUr4WF0+C6g/ZrX1bcyuqTggx2rg7IhB/oBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6384

On Thursday, March 7, 2024 9:54 PM, Duoming Zhou wrote:
<...>
>=20
>                 acti_netdevs =3D kmalloc_array(entry->slave_cnt,
>                                              sizeof(*acti_netdevs), GFP_K=
ERNEL);
> +               if (!acti_netdevs) {
> +                       nfp_flower_cmsg_warn(priv->app,
> +                                            "memory allocate failed\n");
> +                       schedule_delayed_work(&lag->work,
> +                                             NFP_FL_LAG_DELAY);
> +                       continue;
> +               }

It reminds me that this issue was reported and tried to fix in
https://lore.kernel.org/netdev/ZVsFBACC05VrrCfw@LouisNoVo/T/#t
However there's no followed v2 to address the review comments.
Based on that discussion, we don't need warn "allocate failed" locally.

>=20
>                 /* Include sanity check in the loop. It may be that a bon=
d has
>                  * changed between processing the last notification and t=
he
> --
> 2.17.1


