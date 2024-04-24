Return-Path: <linux-kernel+bounces-156770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E8E8B07EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCE91C21D48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B08B15A49F;
	Wed, 24 Apr 2024 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O/6D+6E9"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2062.outbound.protection.outlook.com [40.107.247.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA4B15991D;
	Wed, 24 Apr 2024 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956487; cv=fail; b=p+k9xlhdMITc+OGuiMoWN6kgnT6n3NHILYrOFHQ18octAH1+m5sg4cvCdCvKWLFB8sLjVRZNGqUshSX5eywrMbjWElGL3AvzJpTft0w/LPuTXBC9HGdkTkVZrgTTht/8/5/RYzO60ZMoh8fDU74cOEC1i72g/E0np3p/t081D20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956487; c=relaxed/simple;
	bh=gIEvhPyVIqPByh0JxUVnDmWFizhr4TpUTEKO/RJAOH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NF7l8aQgKp7Ai9btF9WyvDShdj6qmudg1TmzBkZYdtRF2HgbEWkTGaYxPPM2XTGy2PPZIpB687rqiw4cHyrvoqMLBIfxA58cys43T/9iVAvfX4MxsXMN0Qc4woWR56PbpQFsDMJp9duMlayqHLlB4xsEQRR/SDu6oXI8z6H/XiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=O/6D+6E9; arc=fail smtp.client-ip=40.107.247.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClTKXjf/JNGThOS61GPY5iE8roNvMdAnCrPOj9O0Ly+n1nt34CSKtyFzBk/vqdRY6C1a3uYmiZZMTft2+g/wCtkGzLscXXNI+OI59pjfWMjAuDknGzdMnqq3+XzUH07m3dML6Q8TIHFwclTqNlVXFrALiW0DEiP7SzTC1X0MgR9FVOD77GbfYzOnz9TZTabOvRFfhdRiPVXbW5v0VGeRzopmqP1ljHoX24TOmpw/xj5Lto3dKHnArpYWdxpeBKmkNHm0gn0bXtdyk3UY5JylStwJsBpmbY/MceujQbQoUWcF7/nenT/AtbIT9sSUY4CIGshgQeyJE52akiJITw504A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIEvhPyVIqPByh0JxUVnDmWFizhr4TpUTEKO/RJAOH8=;
 b=V2MOG9+IJNFU0j/NxGEIOuBbh6HyXPFKRrDSDeZ+fuf5iyIWoSbBr3EbvvnOKDtskz77sHaR7sFqNdDZVnp5yPLi2V8CjCrY6QRFBcWaUptiHiXs5i9xSqikbe5m+TfcCGUgMo1U5qV2m+WKag/mzZmiT8NHQeNPYWrAreL9t27ve7oZCdUzGjE3vdICaNU8RmEZsF0gzg6BMVkEJHJTykI8SJ8L+zS87IEyoo0M8CycQHvpp8bM3lNvWIp5ZOLOE7sLOCDuVnk9Mxei+ABMTdMn7N+xmU5nnZztLyx7mcueiFGKjWe1V7QMcByTvm72XSCh5DMSH3VdoUN4uWuXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIEvhPyVIqPByh0JxUVnDmWFizhr4TpUTEKO/RJAOH8=;
 b=O/6D+6E9hfXLOdRSYBYOeX335b6g7dbtP/b70sf8LlmPOdzcHQ2bpooPTItsuwyZT45VO8pdjtU5J9nMdd82WV41YnmWij0ikmHOa++CzjEXnZncLqMSxOO9jhv0EG15mpb8EgtQpDlYctknUNqsH1ED1FvjkNHBGYB7bEaHavE=
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU0PR04MB9298.eurprd04.prod.outlook.com (2603:10a6:10:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 11:01:19 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 11:01:19 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: "brgl@bgdev.pl" <brgl@bgdev.pl>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] gpio: vf610: always set GPIO to input mode when used as
 interrupt source
Thread-Topic: [PATCH] gpio: vf610: always set GPIO to input mode when used as
 interrupt source
Thread-Index: AQHalSX3LJYhygbqkUe2wC+6G48jP7F1u+eAgAAHv6CAAXxfYA==
Date: Wed, 24 Apr 2024 11:01:18 +0000
Message-ID:
 <DU0PR04MB949691D7F68E2F32371B604F90102@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240423022814.3951048-1-haibo.chen@nxp.com>
 <CACRpkdaRxoEZT1_KyJ3QMDgBcciw1XUXKr=cEiPxbcwSnpmyiA@mail.gmail.com>
 <AS1PR04MB9502BE89834E7F9DA3E8D70B90112@AS1PR04MB9502.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS1PR04MB9502BE89834E7F9DA3E8D70B90112@AS1PR04MB9502.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DU0PR04MB9298:EE_
x-ms-office365-filtering-correlation-id: 40b0b31b-4abe-4d3e-8c27-08dc644ddeb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?czE5QXZiRllrNUxiVzJ2c3dyaVZxY00wWi9UU0o1RnVsWnFLdHFTT3E1NElY?=
 =?utf-8?B?VDd1RUFkM25GY3pGaEU5b3dXTUFiYjdOajRNVDlkTmVhSS9BTUFTOVRNL1Fq?=
 =?utf-8?B?cGo3Y1YyamliYVZaNzNVWjJMWnBHVkx5dkxWa2tMV3hQN3YvM2JzYW82emYy?=
 =?utf-8?B?QkNwUmxQWFZyQ2ZUb2dIMGtDam4rM1JUSnlzbENaU2NkV3VvVFpwOXRXeVlx?=
 =?utf-8?B?RGk4RUN6d1ZsYlo3RFJzcDBhRDNTZjhxT1UvemdDQnB0dXE0ZXJJRm85ZGFT?=
 =?utf-8?B?aEpsVTVubkFmbGdsbTRNeVpiQXpIV2ZWOG50eGtOaGJjV1dyeGRsSndLbEV3?=
 =?utf-8?B?d0hpa0t0bGU4N1J0Q2UvdUZxMVcwaVdlTE03MnpzVDI4ZDI5T0YwQytJMnZL?=
 =?utf-8?B?cjJXL1JCejFlTHgyUi9ILzJFaVlyRXVyalhmVGtWUjB2ZVpHbjgxRUhJRHVo?=
 =?utf-8?B?bWtISzRRSVphdytzaGdUamxGVDdadzZacUdIUDRjUkRSNFZ5VVZvLzg3bGxC?=
 =?utf-8?B?cFFYaHFhKzI4Yk9qd0FqZTRzUS9lUnROdWRqVTBQL2JCVE1LWG4wOHJKMm1k?=
 =?utf-8?B?SUJCSjIvV0RjNWdXNEUxazJGTnM5SzhuWEhDdUMrb2IzSVNNSTd3dWhqV0pa?=
 =?utf-8?B?akFyMm1wNkFDcGp6SGd2RGRmL29oMkVLTnhnU2ZHaUNNRUx1aHNMTVJ1cGwy?=
 =?utf-8?B?Mmh0a2FXUTJaUHJJcmMrL0VFTXpTOGNUL0lHUkM3MncwNkhnb2Z3OTl2bTVK?=
 =?utf-8?B?Z25NN3hkdDMxTHpyam1oRU1DckNzUmVJVUY3Q1V5UTFnTXdObFVjMDFmS25C?=
 =?utf-8?B?VzJEMEV2SllFL1NWZ3lKamRlOGJCNkFVTm5aNG51ZW1IdFZ2VG1YWHBVdTNS?=
 =?utf-8?B?RWNNU2s4akl1N0JVUUdxTC9pbi84ZTlLOGdRdUcwU1Faa25Sckx1MFNLY20x?=
 =?utf-8?B?dHlkMXlPM25NRUI1UUIzVGltUzMzV3M0VTh2VFJReTVPSjhxaFVyN1l3M1FP?=
 =?utf-8?B?ZTQrd3Nwc0pLZ0hBR2tReWRuRk90SVhJL2hWcW1sQ2NpSTZ2aXY0d0RWL3k5?=
 =?utf-8?B?N3pDSjRFMHBEbzdSeG14NHBQWE1jZHNRODhCeGhXM3JJT3N5eWJPV1dDTU84?=
 =?utf-8?B?NWxzWVRVRFN0cHBMbFdKU0tzOSs2b2RvWVRrVWlTOUo5czY5VXBlcjZ0UUJ1?=
 =?utf-8?B?NElOTjhUVzl4QU40VUI4clQySEVmTVJ4S1dDaDNnUFBiSkhIM245UDdDZ1Ja?=
 =?utf-8?B?Ni9vTjIxZVN3dmtzc3hKREpBeWxTaFozblVkK2Y1bEliK3M2dUhHZ2o3ZTVB?=
 =?utf-8?B?M0xBNjQ4dW9NTitKVGMvSkI3ZFVhT2JHNmw0T29hY2xUWDhJSGVZSkYrNzBx?=
 =?utf-8?B?K1gvYmZxRzVSTHpPQStFcGtHR1V5bWR5QkJLVDJnNGhkTGt3aVp6Z3VpSndm?=
 =?utf-8?B?TUtOZTNoNmhhbThFUEJIcldUZGpOMHV6akFpdlczWDVZbVdoU3RZV2VDYjd3?=
 =?utf-8?B?VWFIM1pIbjRsV05TV3V2Z1dyNHpiTDZvMmdOd3BEZXRHQlNISURhZm0vTkVB?=
 =?utf-8?B?K1ZCNmNHeEp5Q1hrNUxpZ2ZLaXI1VTlhUEptaEh3UUN1Ny9vSWkzMXVPY0Y0?=
 =?utf-8?B?aTV0TFZkN0cxclp5YWgya2hQNDBPUlhUcml0THZXQ054a2gwYTB5a1p1ekQ3?=
 =?utf-8?B?Q1k5ME05OHpqNEhubUpTTDJNVTZZazhNd2tka2d3NnhLc2JvL3FiWE80QUZS?=
 =?utf-8?B?K0Urbk5UWi9lU0l4dTNUN2JMVWhvQnQvYVFVN1BHNDRzRyt1RkVSaFI2VDR0?=
 =?utf-8?B?VlZZcmJrd2FKRCtEdXMvdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFdicTBhQWdnNG11TzZFbi9uekV6UHZhTjhpMisyRld2OUNXUW9LaWQzb0dq?=
 =?utf-8?B?RXlMZnJsanZnZEIyRWNvdDE0WFNyeDhFZGV0encycUlxY1BHMXBLRTRRZnFJ?=
 =?utf-8?B?S0NYa243KzRTVWRaY3REZGQybVJSZ1hVbUhLdEE4ZUFhcmdrOVA3QnRNUHNv?=
 =?utf-8?B?Y3JwK2JoYjArMklNQjRMN1NFNTgvd1Z5aWR6dHBSYmVvQnNNeHJVcG43ZHJP?=
 =?utf-8?B?TThEdFJNUktMRTdybEJnV2tVdFN0V293WmZBUEpPTWc1bDViN0pWRzZRKzVx?=
 =?utf-8?B?U0NDaW5nN3hvUERsTlhueHkyeHZVcnpweStzcXJucHUzMmFDcmhBT3lLQU54?=
 =?utf-8?B?QytwU1FoNUxxV1NBT1FVVFdvd3ByWDNYNFFFV1hiWVRackIyNHZZZVNqMVEv?=
 =?utf-8?B?aGZhSHJSQ2FPWGZTdVFMdHpCUWVqNDJFd2FKcEhJeGN2OFpncUtCTll1OU51?=
 =?utf-8?B?L1l6MXF0RUZuc1B3d2tSNFNaZzRuRmdmQ2xNR2lSby8yVzl5K202bWk2ZEpz?=
 =?utf-8?B?eFlrMzBvTDFNRWlQUWkvQkdrcW9HRzN3ZUlhUjBPdUNBaW40U1dDT1RFT3Rq?=
 =?utf-8?B?SkxET1YrTzJJVWRJT0wrc1FuWXF4emx4ejNwVXRQMWliL1NMdUV6T0JEckZV?=
 =?utf-8?B?ZG1saWdTNjV5eUdpVi9kRGwvaDRoNXlMT3BzZHVUb1pQeVRvOVNBcmxDK0Fi?=
 =?utf-8?B?NXZFTGRMSnRUTFpraGNVM2trSDZHZWIzU3cySHdVaVl1bXZmYzl6TkM4Tml1?=
 =?utf-8?B?U0NPdHh5N0E2S1h0eXlpbEx3RUVNQlVmWEpGSVhpT3FUT2IvcFZRa3ljMmNh?=
 =?utf-8?B?MFd4YXdvanpkdVhuVXNyU082VVB6L05IYUttWjREaFFCeHBtdzVBcDgreHJ5?=
 =?utf-8?B?eGJvUzZQbHNDRHk1Z0R6cS9lQ2hJRzZLbitFUFNDWG0rWjUzOGFoU2RVanFY?=
 =?utf-8?B?V25uU2p6czlIQ3E2UzlVNkZkNzRVVU80ckxXSDl3QU9UcmszMDk2c3haeVE1?=
 =?utf-8?B?RjdFUHB1aGlLUDZaNXRtQzdHR2pYQmk1OTNQQ256SHNQVmxTQzRWSERDYnFv?=
 =?utf-8?B?cENmT0NkWGlqbitNTmtTUHYrajVRQ2ptekRYdjBrUGtZWTJ2c2xMSUxJMHBF?=
 =?utf-8?B?cUNjNFZaZkx6RVRnTiszbnN5eHBXUkFxYXc3OXZURVBQd01SVEY5d2h0bEl5?=
 =?utf-8?B?TmV1SjRmZWZEaTRNb2I2OFJqb3pIQzZtRTQ4Rlc0K21YTzVOVUYzb25oTXFq?=
 =?utf-8?B?NEtLR0VGUXFuU1cwaDEwaGl2cVRvZTVKQWRTcTNBTDdHZ0srNEtKNWZKeFZl?=
 =?utf-8?B?T1ZiL0JmU00rb1d6U0xWcy9NSXRzT0RwRWVVbkR1Ukt1QVlJT3BxS2ZCaWFG?=
 =?utf-8?B?VStJUkpaTzh1U21WWHBUUHNvQlkrNTIxeTZZZG5vWGZZYzJSeXpFSm44ZDBl?=
 =?utf-8?B?VmdCSmZCWTVVWFVrUHh2a0pzZlEzc080YU4vblJnQlVFTU9ZcTF5OEZ1ajVv?=
 =?utf-8?B?emNxUnRmbnRpWWYrNWZkamZyQmpHWXRPeUV5RTErVUlGeGVsWldBT2FRZ3hs?=
 =?utf-8?B?bEJINmV2YmtVM1RwWmIwRTB1dUJrdE5vczluS3pHZDV4dkJKSjUvNitWbDFD?=
 =?utf-8?B?KzVveXB6UEtPVTYwYWMvbWh2ZVB2cUx2MmdjM2oyRHB1VUV0ejk5Vm42bW1B?=
 =?utf-8?B?QXdqckdkV0QwTmZxNk16aGxITW5Cejk0eHRXaDNMMXVtNzJ3UFVQL2hHMmF5?=
 =?utf-8?B?d2dUSzFCMk9ESTdYSU50VnlwYUNGR0NvV0JrQmlPd2Z4Ymt1SzdxeXlQSE1L?=
 =?utf-8?B?U0g0NmJkY2I5SDc0ZUJVbFNaZktnUk9Rckpzb2tvZWwrc05rUWlMQTV0a2Jt?=
 =?utf-8?B?cWpLamR4Zi9QUmVWS1VuemVLaCtDMmw1bGVyaEtsTUVTL1gxVktlYm9NMUtm?=
 =?utf-8?B?b3hYRmtMYXVna2d5VXZldmg3R3NCcjF1RFcwYlNySGEyeGY5ajhNQmVGcng4?=
 =?utf-8?B?anEraExtc1hCQkduSjFwZEZDMERKalJPakh1Y0loOWtYa1lSb2gxRFZQYXEy?=
 =?utf-8?B?SUozL29NKzBGWVUxdEpwQkY0L0lySUpEMXhoWjlYRis2SFQvWWc2Z0E1NjlH?=
 =?utf-8?Q?sf8Y=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b0b31b-4abe-4d3e-8c27-08dc644ddeb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 11:01:19.0067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRwqZxfWkPxID5Vve9BJ8STsEnwRqj5k+t5yKwHTZcYuYN/P4A+Av2kcUBsFho9kz/PAub/wibit2MVW9LZAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9298

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3VnaCBDaGVuDQo+IFNlbnQ6
IDIwMjTlubQ05pyIMjPml6UgMjA6MjENCj4gVG86IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxl
aWpAbGluYXJvLm9yZz4NCj4gQ2M6IGJyZ2xAYmdkZXYucGw7IGxpbnV4LWdwaW9Admdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlzdHMubGludXgu
ZGV2DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGdwaW86IHZmNjEwOiBhbHdheXMgc2V0IEdQSU8g
dG8gaW5wdXQgbW9kZSB3aGVuIHVzZWQgYXMNCj4gaW50ZXJydXB0IHNvdXJjZQ0KPiANCj4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IExpbnVzIFdhbGxlaWogPGxpbnVz
LndhbGxlaWpAbGluYXJvLm9yZz4NCj4gPiBTZW50OiAyMDI05bm0NOaciDIz5pelIDE5OjQxDQo+
ID4gVG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiBDYzogYnJnbEBiZ2Rl
di5wbDsgbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGdwaW86IHZmNjEwOiBhbHdheXMgc2V0IEdQSU8gdG8gaW5wdXQgbW9kZSB3aGVuDQo+ID4gdXNl
ZCBhcyBpbnRlcnJ1cHQgc291cmNlDQo+ID4NCj4gPiBPbiBUdWUsIEFwciAyMywgMjAyNCBhdCA0
OjI44oCvQU0gPGhhaWJvLmNoZW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206IEhh
aWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBUaG91Z2ggdGhlIGRl
ZmF1bHQgcGluIGNvbmZpZ3VyYXRpb24gaXMgSU5QVVQsIGJ1dCBpZiB0aGUgcHJpb3INCj4gPiA+
IHN0YWdlIGRvZXMgY29uZmlndXJlIHRoZSBwaW5zIGFzIE9VVFBVVCwgdGhlbiBMaW51eCB3aWxs
IG5vdA0KPiA+ID4gcmVjb25maWd1cmUgdGhlIHBpbiBhcyBJTlBVVC4NCj4gPiA+DQo+ID4gPiBl
LmcuIFdoZW4gdXNlIG9uZSBwaW4gYXMgaW50ZXJydXB0IHNvdXJjZSwgYW5kIHNldCBhcyBsb3cg
bGV2ZWwNCj4gPiA+IHRyaWdnZXIsIGlmIHByaW9yIHN0YWdlIGFscmVhZHkgc2V0IHRoaXMgcGlu
IGFzIE9VVFBVVCBsb3csIHRoZW4NCj4gPiA+IHdpbGwgbWVldCBpbnRlcnJ1cHQgc3Rvcm0uDQo+
ID4gPg0KPiA+ID4gU28gYWx3YXlzIHNldCBHUElPIHRvIGlucHV0IG1vZGUgd2hlbiB1c2VkIGFz
IGludGVycnVwdCBzb3VyY2UgdG8NCj4gPiA+IGZpeCBhYm92ZSBjYXNlLg0KPiA+ID4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiA+IC0t
LQ0KPiA+ID4gIGRyaXZlcnMvZ3Bpby9ncGlvLXZmNjEwLmMgfCAyICstDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3Bpby9ncGlvLXZmNjEwLmMgYi9kcml2ZXJzL2dwaW8vZ3Bpby12
ZjYxMC5jDQo+ID4gPiBpbmRleCAwN2U1ZTYzMjNlODYuLjMwNWIwYmNkZWU2ZiAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvZ3Bpby9ncGlvLXZmNjEwLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMv
Z3Bpby9ncGlvLXZmNjEwLmMNCj4gPiA+IEBAIC0yMTQsNyArMjE0LDcgQEAgc3RhdGljIGludCB2
ZjYxMF9ncGlvX2lycV9zZXRfdHlwZShzdHJ1Y3QNCj4gPiA+IGlycV9kYXRhICpkLA0KPiA+IHUz
MiB0eXBlKQ0KPiA+ID4gICAgICAgICBlbHNlDQo+ID4gPiAgICAgICAgICAgICAgICAgaXJxX3Nl
dF9oYW5kbGVyX2xvY2tlZChkLCBoYW5kbGVfZWRnZV9pcnEpOw0KPiA+ID4NCj4gPiA+IC0gICAg
ICAgcmV0dXJuIDA7DQo+ID4gPiArICAgICAgIHJldHVybiBwb3J0LT5nYy5kaXJlY3Rpb25faW5w
dXQoJnBvcnQtPmdjLCBkLT5od2lycSk7DQo+ID4NCj4gPiBKdXN0IGNhbGwgdmY2MTBfZ3Bpb19k
aXJlY3Rpb25faW5wdXQoKSBpbnN0ZWFkIG9mIGluZGlyZWN0aW5nIHRocm91Z2gNCj4gPiBnYy0+
ZGlyZWN0aW9uX2lucHV0KCksIG5vIG5lZWQgdG8ganVtcCB0aHJvdWdoIHRoZSB2dGFibGUgYW5k
IGFzDQo+ID4gQmFydG9zeiBzYXlzOiBpdCBqdXN0IG1ha2VzIHRoYXQgc3RydWN0IHZ1bG5lcmFi
bGUuDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcXVpY2sgcmV2aWV3LCBJIHdpbGwgZG8gdGhhdCBp
biBWMi4NCj4gDQo+ID4NCj4gPiBTZWNvbmQ6DQo+ID4NCj4gPiBJbiB0aGlzIHBhdGNoIGFsc28g
aW1wbGVtZW50IGdjLT5nZXRfZGlyZWN0aW9uKCkgd2hpY2ggaXMgY3VycmVudGx5DQo+ID4gdW5p
bXBsZW1lbnRlZC4gSWYgeW91IGFyZSBnb2luZyB0byBjaGFuZ2UgdGhlIGRpcmVjdGlvbiBvZiBh
IEdQSU8NCj4gPiByYW5kb21seSBhdCBydW50aW1lIHRoZW4gdGhlIGZyYW1ld29yayByZWFsbHkg
bGlrZXMgdG8gaGF2ZSBhIGNoYW5jZQ0KPiA+IHRvIGtub3cgdGhlIGN1cnJlbnQgZGlyZWN0aW9u
IGZvciBvYnZpb3VzIHJlYXNvbnMuDQo+IA0KPiBZZXMsIHdpbGwgaW1wbGVtZW50IGdjLT5nZXRf
ZGlyZWN0aW9uKCksIGlmIHdlIGRpZCB0aGlzIGJlZm9yZSwgdGhlbiBmb3IgdGhpcyBjYXNlDQo+
IHdlIG1lZXQsIGZyYW1ld29yayB3aWxsIHByaW50IG91dCBlcnJvciBsb2csIHNhdmUgbXVjaCBk
ZWJ1ZyB0aW1lLg0KDQpIaSBMaW51cywNCg0KSSBpbXBsZW1lbnQgZ2MtPmdldF9kaXJlY3Rpb24o
KSB0b2RheSwgZm9yIHRoZSBjYXNlIHRvIHJlcXVlc3Qgb25lIGdwaW8gYXMgaXJxLCBncGlvIGFy
Y2hpdGVjdHVyZSB3aWxsIGZpcnN0DQpjYWxsIGdwaW9jaGlwX3JlcXJlc19pcnEoKSwgaWYgdGhl
IFJPTSBvciBVYm9vdCBhbHJlYWR5IGNvbmZpZyB0aGlzIGdwaW8gcGluIGFzIE9VVFBVVCBtb2Rl
LCB3aWxsIGdldA0KdGhlIGZvbGxvd2luZyBsb2c6DQoNClsgICAgMi43MTQ4ODldIGdwaW8gZ3Bp
b2NoaXAzOiAoNDM4NTAwMDAuZ3Bpbyk6IGdwaW9jaGlwX2xvY2tfYXNfaXJxOiB0cmllZCB0byBm
bGFnIGEgR1BJTyBzZXQgYXMgb3V0cHV0IGZvciBJUlENClsgICAgMi43MjQ4MTZdIGdwaW8gZ3Bp
b2NoaXAzOiAoNDM4NTAwMDAuZ3Bpbyk6IHVuYWJsZSB0byBsb2NrIEhXIElSUSAxMSBmb3IgSVJR
DQpbICAgIDIuNzMxOTcyXSBnZW5pcnE6IEZhaWxlZCB0byByZXF1ZXN0IHJlc291cmNlcyBmb3Ig
Mi0wMDUwIChpcnEgMjExKSBvbiBpcnFjaGlwIGdwaW8tdmY2MTANCg0KQW55IHN1Z2dlc3RlZCBt
ZXRob2QgdG8gYXZvaWQgdGhpcyBjYXNlPyBNeSBwcmV2aW91cyBtZXRob2Qgd29ya3MgYmVjYXVz
ZSBkcml2ZXIgbGFjayBvZiBnYy0+Z2V0X2RpcmVjdGlvbigpLg0KDQpCZXN0IFJlZ2FyZHMNCkhh
aWJvIENoZW4NCg0KPiANCj4gQmVzdCBSZWdhcmRzDQo+IEhhaWJvIENoZW4NCj4gPg0KPiA+IFlv
dXJzLA0KPiA+IExpbnVzIFdhbGxlaWoNCg==

