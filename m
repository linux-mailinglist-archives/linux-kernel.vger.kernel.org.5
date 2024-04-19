Return-Path: <linux-kernel+bounces-150997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599528AA78D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D957728750F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3841946C;
	Fri, 19 Apr 2024 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bd7GARMJ"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAC8323C;
	Fri, 19 Apr 2024 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713499223; cv=fail; b=hdKV7lNC537c9Zo7okmUYbQVIDU1b7EmoWAirIEde9Q+oWoEWVT2dKaMpYD/PyxY2knA1GuHOHNBLQJLmZ1uc8zrS+2pJkSt4pMLAVdZUyslYDgUMbv3tAyUi1nVUn8dFiwOQmGCRlfznpW2ff9tEGWyEsizPPoGfcQRIBCU6OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713499223; c=relaxed/simple;
	bh=kuuRIBrYDJBU5NGyQkWEsCEBneJWHoui/ozGrsPvbjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ibUaCMr0cJlu+9tT5/g06MiLWCqHm1gPSFtuywJmYGg/sRmQDJ9zbSMp/8srhHWe/uO7Ej4/pyJnZfsdWz4WZcuVVr9nezGY0FqIKnvsRTLz2aYmCnVSQQ274Hiv7NDhJsAddz6NMrHxYajFGynreDbFUcMjSXzmSCMdWnpBJLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bd7GARMJ; arc=fail smtp.client-ip=40.107.247.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uvyyx5/r6sLVpNZXGUGVFhcUC7fkFGcBdj0ta///vV1gIYD6MQEKgO0hNDMbABI6qH1lSxez742Gjx6j72Nlzyx0/HbJ1/mV7x6oY535f1DfSvm+z7FqGXHzu8zHDV2bmfzdV2cIcIHnUnxROsbMa5jQcaKzOwryX2PqOVjDQKBsBCeL2YTei0Eu+mttMeExzOZYUFs/zNPsNWUMEhslC5kX17OKIA9sdC9vMOAj6ob2ryOFqldxfxUARjrAaRGIhicvs0Qyj4hO7r4inWry5hY5FCBxvPcE2ZvcHumJOZkrt8YHXcmSml/6gdAAbxcbFWkThGUqGThTiDtW9ftxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuuRIBrYDJBU5NGyQkWEsCEBneJWHoui/ozGrsPvbjo=;
 b=aUtE7g/XcAfmO7aPEGyyNix/6t3pOEFJdI7X6bA+PAlyz+aiL2fbDB9krICy9luHbej296JQa3R948W9AjD0qLZ0+/GKcaosr/6qCTML3GRIR43qSflu2k5LvC466OAawqWUvl1Z9B47Tzu6GhusCkbj8Sl9qyLTt3YqItee6ABDYmItKWa/+fbWIFW7VCrYtI45D+yYMKrmOV+wruMOYA9UG8977KAhm0yi/S2RrCRo5UO3nDpd46B2usVS3x1bAA5la/fsXa7zPsRTfMqiI16efrpgMgUeTHWkn7PvPtEgdr+QjwJ5FsKz74uxmnP7sQH+HGJjxFLhJ1MxlFFFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuuRIBrYDJBU5NGyQkWEsCEBneJWHoui/ozGrsPvbjo=;
 b=bd7GARMJg5YQfZoAV91pQ5da5kJNr5z45Q1I95r8k045xi1JWje+jmaOmJ2JfPiIjNh9iBWvE8LuCN4AnO2zuxnw3jmVetOp8S7wgC/FZAKsyEbExk3vQu4EoiTDJpBBAM6i4fhPi8BqM+xd2RHFrC5YOKcfbts6HVqm96z7UQM=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB8PR04MB6985.eurprd04.prod.outlook.com (2603:10a6:10:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 04:00:17 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 04:00:17 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "briannorris@chromium.org"
	<briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, rafael.beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHakXD8ZSzvjLENHE+cjdiIi3WD9LFu+Phw
Date: Fri, 19 Apr 2024 04:00:17 +0000
Message-ID:
 <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org>
In-Reply-To: <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DB8PR04MB6985:EE_
x-ms-office365-filtering-correlation-id: 14ffe243-7c6c-4ae0-1abe-08dc6025394c
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?STVlNjg1U0lxc2U2M0NjZWQyWUhRMmFYUmFkT1lyZ3pYdisyUTNtK2FCWmJQ?=
 =?utf-8?B?d3ZMUDBUMmJDZnF6dy9XMFpSM0FUOTBpZmJuMkIvVXZvUDkyK3JwVS9PaXU2?=
 =?utf-8?B?Zml3Umc4anl3b3FDN3F3SGxjcWlYWjgxUUdiUFViNDB4QzB5S0ptMnJCR291?=
 =?utf-8?B?WGErc1ozTElVY29OT2lucFNTcDJzOGduY2o5YnoyTWNkQ1pSbXZ3Q3FpZCti?=
 =?utf-8?B?ZFhnRjdjK3VORWo0Z1V5YjhVSFB5U2l3R0tvZHZvZDVFWDBUZytYOHBYK1J0?=
 =?utf-8?B?aWdHUE56U1hIZzJqMVVnZW5VY2YvRkJqa1lSUlFuMjA4SGZDUFRDeksrWG1D?=
 =?utf-8?B?VG82THhVRGVzMmdPVmNhU2dhenpVaHh4OHU3aS9sT1FxdEtMcjBOMW9Kay9O?=
 =?utf-8?B?VzBuS0kvUThRc0h5Y21NT0xMcVdwTmhTRWQzbjY4UUxXb0ZLV3UwMmhQU3Fs?=
 =?utf-8?B?TlhodlpMUXJ2NTdtbklTNzZua3N2VHBqQ3BveGhqNi9OdzE0anl2YlVFZVph?=
 =?utf-8?B?a1BVa2pXUjUvSVIvSzhZelhzWEdkcjlRWEl4RExYaVFCQzhwYXh6U1Jsc0I1?=
 =?utf-8?B?V3dhSTJrQTNKMnl0cGczUFFxbDlpcjgrR0k1STZKQndKbzBLTzFmT3RXYVQv?=
 =?utf-8?B?b1VRWFBFb3hnYkJFbmFCbi9odk5VeDEwT0J0N0hQV25uRmdjTVZhdjlWL0RC?=
 =?utf-8?B?bmJLc25IRHZUVmRiZm43eHF4dXkvYW5MTDk1RDFLekt4KzhLeUNGSFhjVzFm?=
 =?utf-8?B?Q0xZTm1KVzZlK2VPUEFwcStGRGxpaGJoTnNVcFRhWjkwM2s3cUkzZ1BRdmZq?=
 =?utf-8?B?R2w1REJYSUlnMlBXM3VzVkNqbk9Cd09XMjA0Nm52R3BqRGd4ZUgyV2ZOSkhR?=
 =?utf-8?B?ZjBSd2lZK2FLSmNnUE9RSDAvT1Zxbks0bHJNYUJvQjNKMHdnbFowQ1ZWV0pq?=
 =?utf-8?B?RExsWWUrb1lOVFZzdXQxYWJOMEZwVG9FSGZBMG1QZHFBRHF3YWVvVEpEMlQ2?=
 =?utf-8?B?MkhjZndnQU1aanlKOWYzVlBlL3pyYXhtNm9DdS9oL2dVTksyVEdFUkVFNTlD?=
 =?utf-8?B?WTVDaHcxb0k5UlRWOGhaVU5pR1FiemFLRm0ydHc5Mk9TemM3aFVNZjJOQlRl?=
 =?utf-8?B?YnEybXFCM3h6Qm1wR1dodUM4YXRFSlBSQXBsSmNwc1ZRc2NOSEt1OEIzT1Ay?=
 =?utf-8?B?bGlidXp1ZlVib3R3WWZEVHRLU2Y1OVVEMit4RzdUeWxzRFE2RFkwdFc4SzZG?=
 =?utf-8?B?blhsZmNmWVhGQ1pEYlVwSGVUYkFXcStSbndnQUFZRFIyb25oZTNCVHpETnFi?=
 =?utf-8?B?eE9WZ3NTSDhFVCtHUHpmcXBRQU0xYmQ4YkVFdEVqVXNZZnNobGo0SHBoUGpC?=
 =?utf-8?B?TkZydktwUldLN29KSDN4RWdKS0ZNNS9BSHlKR0NMK2pvV29ENGl1UVgxdFNW?=
 =?utf-8?B?ZWZlOXM1Zm5mcTFNZlZGcXlqbEVFODRjOGZWZUtJMjdhZ2hmbzZ4VFl6bC9E?=
 =?utf-8?B?NzNBZFQveDh2NlZ5dG0xK3BjV1FScHBXWU1YbzhleG9iNDBMVTdrTGFCckY2?=
 =?utf-8?B?SHlVUnVob2s4dzBhTDgzNHFyMW9iSlpOMm1QczVhblZ3RDRjTjVKOGh1VDhl?=
 =?utf-8?B?MG5rTmFYVng2bGNNc2IrY3dQZ0ltSEZWVldDbkwxb2FKdGhxY1p6UjVoeE54?=
 =?utf-8?B?TDhzMlBDbFdGdmpFTkk1RUIzTmFYTC9UbkJUMUprM0p4b0ozOWRsRDJ0VTZu?=
 =?utf-8?B?WFNDMFh4b0phVWJhTk9nZElBdGFXRjVlTlU0dWlmZ1dEdHFKTXNRSlhqZWJ0?=
 =?utf-8?B?alRLOElmNlFwdUN4YW8vQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ck5qN01Qb0tmb3Y3bkFnZUpZUUpSMVpaRHJaMFFRYlB3UzYvaUF3TjdVczFH?=
 =?utf-8?B?bXVuY1pkNTFpZW94eVl5cDlTOFc2UWhvT2MxMDkxWXNZTE5kdHoxNng3Rm1x?=
 =?utf-8?B?U29uS2dCQU9nQ0tUZE5odnk3emhEclVjYVZJZUpOZWVPOUM2c3p3amZ6cSs2?=
 =?utf-8?B?U0hURUFuYzNJbkVzbTBzdUFNQW12MXZ4MUJvMzU2MkhTazVmYU1FM1JDV1dO?=
 =?utf-8?B?RDIvWW9TblQ5SzZpTnJqVDhCZm90WXl1UlU3K081VEtGeGZwY0dOdnlWSUpY?=
 =?utf-8?B?UCtvQzluSVJldTFqSXovM3kxUHQ1Q1h0NkhNVi90OEM0VjA2RWh4ZEdWTHZ3?=
 =?utf-8?B?eXphSUR1SUdkWnIzZVZXeitnVHhpc2lFaWs2dUtXaXlRSGphdVVBZWRLbEJi?=
 =?utf-8?B?bVZ4OGFGTDd1MWVCMmo0WGNBdHgyYmtwaEFJZEhDVFYveU5WUWo3R2F1Y1Mz?=
 =?utf-8?B?YlNIV25OY2xjK0hvSDhzZ3VsVGVhcjY1T2JGMnAvT2VHTEVjKzFtYS9odzVG?=
 =?utf-8?B?c1BVUC9tb3RxMWtlWjlEYVJtN2w4S09UbXYzdWZCQ3J5MUlSbldNMHUwMm81?=
 =?utf-8?B?K0NaaVJodkJsai8zNDdmSTJycW9tMVNpV00xTTN6VDhkU2dhZHBUZko0U1BD?=
 =?utf-8?B?bWdkODlUbjdPMW9KN2Rtb3VMZW41SjhnTEoxeGRvQXI0dzc3M1lsdS82ekRh?=
 =?utf-8?B?RXRkdkpNYm92dVpkR2diM1NQZWZEUDhjQktzWnV3dHcvK3E0QVFLWWcvaDFx?=
 =?utf-8?B?QTRydGF3cThFcjBrdURjRVFRUmpXTkdiS1NuYkRHS0tDRFdOQ1orTXQ5SFJk?=
 =?utf-8?B?eThFWFB4SmMxckJTbjZUTnJmTC9TNXhxQm1GOWwyUVorSmdwbk5WdUJ1SWF4?=
 =?utf-8?B?ZU44TDlkNWEyU1Q2L3kvNE1UWSsveWo2Zm1BcHpSeTBGbDJNVGMzQU1HeUVV?=
 =?utf-8?B?dVR5eHdFN0JhenhyVnJ0dWFPMEpFN0k1eXpDK2V3NW1DL3VEeGZhQlMxcDdx?=
 =?utf-8?B?NURqazhDN3FybWViaUtwWlRZdkhxWHdURW9BY0VDMTFiL2xOZjhKV1U1MnlZ?=
 =?utf-8?B?ZktVVUNJMHlWMGdhRUo0bkVYZUE0bUpTMUE1R2RvMjZXTlZHUGgyUDU5b25J?=
 =?utf-8?B?dXhxTUZyOUt6L2w1ZlYyRU9UMnMxdU5PYjc5eEw5bkQ5QzNmS0tvVG15MlZL?=
 =?utf-8?B?amRVNGEvMjZ6bzNhM2VGSUVsaE9lRURDZ2dXNWFpcEFPMDAzL29ZbTFLRmdu?=
 =?utf-8?B?UTBrWG1EeHlWclVvYjhRaUN5aWhWdnJ0ZEtHT3Y5LzA4N1cxRHYycWRkdFZC?=
 =?utf-8?B?dnBUTVFxTVc2SzdENzF0YnYwVjhjZzl1a1ZvY0VWSnVzS3VlYXppRnJ1U3RG?=
 =?utf-8?B?K0tUcEsvR0NKQmhPa0RYS2k2MGlGcXk4YjZPbjdlSWJ3YlNYdEMxNy80Yks5?=
 =?utf-8?B?TElscGd0UVc2dm9YdTg5MHZhbkJvZnI5TEVSNnB4WnV0Y0NUSC9QSlBtQ2lt?=
 =?utf-8?B?TGdwWUI2d0xOKzd4VWE4Q1U4UmdZd2NFdmJ2dHRsMFNER3hrUHhJMTBIRHE1?=
 =?utf-8?B?amhpMkZ6MjJzT2d6YmZSelZDUU5DUlNsSTB1WFBUMGc2R1BQMFcvNU5sWEUr?=
 =?utf-8?B?dkNiSmJHcEJlZHpUZnJEUTNRT0JZOG1zUGFudUFmVTNwcTI4dW9qdlgrTnZV?=
 =?utf-8?B?NTRXLyt6OXVUVVJheXI2MWwrdVBzTEtoZDg2bm00Vm0vYkdlTWRRakJoVU9H?=
 =?utf-8?B?bTlaODhZVDlLSUVxaiswZHNtczc4aVpiRitlVTNTeDhCZTY4NGZMclI0SzhP?=
 =?utf-8?B?L0QzeS9LSjFTc1lCaDBYNTFxK0FScU9aOVd3dmc2Vnc3bUhkZWRJeUxMQmZy?=
 =?utf-8?B?Q1BDTlg0UkRoWitDOUF2ZUtPV25BcVc1d21LZi9yU0VwT2hKSWJSNFYzUm9n?=
 =?utf-8?B?M0dxc3ZhU3hvajA0bzUraWdaUk42ZEtIWWxkM1ZrcklWK0Q0Nmx4MVQ3QUI3?=
 =?utf-8?B?ZkhTZy9PUGdHbCsyejJIbTN1TFMxNS9FU1VHV2FNdytBL0U5VGcvWGRVU3h1?=
 =?utf-8?B?R0ErUDA1OWhNamo2VXlMdEkrMnBNOGp4ZVFZSnBodFl5VGViYSt0QTk4U0Ns?=
 =?utf-8?Q?sb7M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ffe243-7c6c-4ae0-1abe-08dc6025394c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 04:00:17.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXL7uAKfRvI3N7DA1X/5YhtU+MbO0rs6b4OCiTorLROQFzXxuEl5KCPaV/KcDbh9j4OsBSuq0FrbYUXoY6TZLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6985

PiBGcm9tOiBNYXJjZWwgSG9sdG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBBcHJpbCAxOCwgMjAyNCA1OjE1IFBNDQo+IFRvOiBEYXZpZCBMaW4gPHl1LWhhby5s
aW5AbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgTEtNTCA8
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IGJyaWFubm9ycmlzQGNocm9taXVtLm9y
ZzsgS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47DQo+IGZyYW5jZXNjb0Bkb2xjaW5pLml0
OyBQZXRlIEhzaWVoIDx0c3VuZy1oc2llbi5oc2llaEBueHAuY29tPjsgcmFmYWVsLmJlaW1zDQo+
IDxyYWZhZWwuYmVpbXNAdG9yYWRleC5jb20+OyBGcmFuY2VzY28gRG9sY2luaQ0KPiA8ZnJhbmNl
c2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBbUEFUQ0ggdjEw
IDAvMl0gd2lmaTogbXdpZmlleDogYWRkIGNvZGUgdG8gc3VwcG9ydCBob3N0DQo+IG1sbWUNCj4g
DQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUg
d2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRv
dWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcg
YnV0dG9uDQo+IA0KPiANCj4gSGkgRGF2aWQsDQo+IA0KPiA+Pj4gV2l0aCBob3N0IG1sbWU6DQo+
ID4+PiBUZXN0ZWQtYnk6IDxyYWZhZWwuYmVpbXNAdG9yYWRleC5jb20+ICNWZXJkaW4gQU02MiBJ
VzQxNiBTRA0KPiBXaXRob3V0DQo+ID4+PiBob3N0IG1sbWU6DQo+ID4+PiBUZXN0ZWQtYnk6IEZy
YW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbT4gIw0KPiA+Pj4g
ODhXODk5Ny1TRA0KPiA+Pj4NCj4gPj4+IFRoaXMgc2VyaWVzIGFkZCBob3N0IGJhc2VkIE1MTUUg
c3VwcG9ydCB0byB0aGUgbXdpZmlleCBkcml2ZXIsIHRoaXMNCj4gPj4+IGVuYWJsZXMgV1BBMyBz
dXBwb3J0IGluIGJvdGggY2xpZW50IGFuZCBBUCBtb2RlLg0KPiA+Pj4gVG8gZW5hYmxlIFdQQTMs
IGEgZmlybXdhcmUgd2l0aCBjb3JyZXNwb25kaW5nIFYyIEtleSBBUEkgc3VwcG9ydCBpcw0KPiA+
Pj4gcmVxdWlyZWQuDQo+ID4+PiBUaGUgZmVhdHVyZSBpcyBjdXJyZW50bHkgb25seSBlbmFibGVk
IG9uIE5YUCBJVzQxNiAoU0Q4OTc4KSwgYW5kIGl0DQo+ID4+PiB3YXMgaW50ZXJuYWxseSB2YWxp
ZGF0ZWQgYnkgTlhQIFFBIHRlYW0uIE90aGVyIE5YUCBXaS1GaSBjaGlwcw0KPiA+Pj4gc3VwcG9y
dGVkIGluIGN1cnJlbnQgbXdpZmlleCBhcmUgbm90IGFmZmVjdGVkIGJ5IHRoaXMgY2hhbmdlLg0K
PiA+Pg0KPiA+PiBJIGFtIGEgYml0IGNvbmZ1c2VkIGhlcmUuIElmIHRoaXMgaXMganVzdCBmb3Ig
V1BBMyBzdXBwb3J0LCB0aGVuDQo+ID4+IHdhc27igJl0IHRoaXMgc3VwcG9zZSB0byBiZSBzb2x2
ZWQgd2l0aCBleHRlcm5hbF9hdXRoIHN1cHBvcnQ/DQo+ID4+DQo+ID4+IFJlZ2FyZHMNCj4gPj4N
Cj4gPj4gTWFyY2VsDQo+ID4NCj4gPiBGVyBjYW4ndCBzdXBwb3J0IFdQQTMuIEluIG9yZGVyIHRv
IHN1cHBvcnQgV1BBMywgZHJpdmVyIHNob3VsZCBsZXZlcmFnZQ0KPiBNTE1FIG9mIHdwYV9zdXBw
bGljYW50IGFuZCBob3N0YXBkLg0KPiA+IFRoaXMgcGF0Y2ggaXMgdXNlZCB0byBsZXQgTUxNRSBp
cyBydW5uaW5nIGJ5IHdwYV9zdXBwbGljYW50IGFuZCBob3N0YXBkDQo+IGluc3RlYWQgb2YgaGFu
ZGxpbmcgYnkgRlcuDQo+IA0KPiBhcyBJIHNhaWQsIGlzbuKAmXQgZXh0ZXJuYWxfYXV0aCBleGFj
dGx5IG1lYW50IGZvciB0aGlzPw0KPiANCj4gUmVnYXJkcw0KPiANCj4gTWFyY2VsDQoNCkNhbiB5
b3UgbGV0IG1lIGtub3cgd2hhdCBkb2VzICJleHRlcm5hbF9hdXRoIiBtZWFuPw0KDQpEYXZpZA0K

