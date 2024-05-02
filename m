Return-Path: <linux-kernel+bounces-166124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0078B968B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABEC1C21F40
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FE346544;
	Thu,  2 May 2024 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e5nifDY2"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250C37E;
	Thu,  2 May 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638902; cv=fail; b=V5NCs2wInoneyPjUnFeTbc86LwD3AEJfF/LBq85UnA/sZjKm9t4xAAfTHpA6mnQmD1gCEa8QgW8W9ZjQlrjtYTTu48Esn+2KQyLSzfpDV9ELwnSJwIOmdeVhFTJvq2nMTROXP/lgTIK8xlFFZ9v3cD9+nvO4HCsosVCnIl0Zk1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638902; c=relaxed/simple;
	bh=JxjE0Uz+gO2duELsIxfk7mOWxMn/tEkRfxcrxakolhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHjNJOHFbjjmFJmrwnz25aKeedu1+7FLkPxECnZueyUCp1hmDZcIREkjzrG4VATwFdAAcqJ7FVPvy6WqnlTH9E0mIWuHxy3cnpbkfrAiEHjYdt8txZQ7qE0qcKoga8g+veYk8PIRAFfFOA2YELK2QRgTNTbGg7CcvphyrDX1LwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e5nifDY2; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcCcQevSRpTHVTT280rVRSbNYqLCtldhItTJY3eCSuFTx2awzoaIogqkXeicgBvyuc0lOqnb+xaj9g4+5qQRWis3Etf3Czi1PNGtx2P9rEJr13z6F4LxBIyq6CwYfCxx1E7ibiFrgGB4Wi3s5CSEZQLue0IRMvchO6qhJlKMHUfZylOpibzdI2rER1awDrwNQjYdjB21St0SwodEaB/k7HqJnnwk+sPhSN6sQZKpniNWF4U4VQW1DsDKk3eamh76vBRshhDmPz9c9EMOkrSNdetPnNefs9s4tKVD4O2UVemSb18tX5ctxbeFxeRe+UVcI/kNnjGO0vCSKgWJl4PdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxjE0Uz+gO2duELsIxfk7mOWxMn/tEkRfxcrxakolhI=;
 b=mpjQ7kue3HM1fcJr8r3T4XrnjSGVj3BMh011BmkyBgle9N1l9vvFMwMNWzozvbRnUt+qGjZc17EF0UJbhfHD2LJHFyQN1Xxij33kVyQmxqZe4LsQ0SqSdQkDVtCWWitX9SZqPZ6cgL9tLbPGkcHDfckrqlfWEvp2kHEH8y1Ul83yJ1d4y7o9shi2eGs7ZS0qS61shlbsX/wq+xypqs2saW9n3sLM4wkl/pGA6cf1N8T7695RUvDjYQeR0MyFOUISSCD7PU/hpP+0I9X+P0GC3TMbPIzzXIeI0mCEp9LuF9ZXXz5Bir4rKg00AC1v+rHo2/w5u/xGRlUYThmvMS3zUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxjE0Uz+gO2duELsIxfk7mOWxMn/tEkRfxcrxakolhI=;
 b=e5nifDY2GYOlHyRJ+e9t6I9dO5zJEtxtsYUGoXJRelWdtzZsah7eFsNPWykFr/4SUcpinntpSgNijd1znn3eVk/DJT/d6yO6MS72qFq+iqjlzw/pjlhEhY3qvdIz8nuNRX3lx3QS9wpjFR6nuio/4g3cfldXkGKNC6f9CXeD3xo=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB7976.eurprd04.prod.outlook.com (2603:10a6:20b:2af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 08:34:55 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 08:34:55 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: Marcel Holtmann <marcel@holtmann.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kalle
 Valo <kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete
 Hsieh <tsung-hsien.hsieh@nxp.com>, rafael.beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index:
 AQHakXD8ZSzvjLENHE+cjdiIi3WD9LFu+PhwgAEpDwCAA9ThQIABL2MAgAH0wQCAATIZwIABfIwAgAnpxRA=
Date: Thu, 2 May 2024 08:34:55 +0000
Message-ID:
 <PA4PR04MB9638F35B2FF70A1E514C25D0D1182@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org>
 <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZiLlPOvKlfCySZwF@google.com>
 <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <C8F76484-1359-437B-85BF-C646A21F7BCE@holtmann.org>
 <PA4PR04MB9638670FD6768AD8A69F5125D1172@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXNhkHi47=d-TMkjy3oebsK_NvWuC9CQtEEQYN-nHHbx-g@mail.gmail.com>
In-Reply-To:
 <CA+ASDXNhkHi47=d-TMkjy3oebsK_NvWuC9CQtEEQYN-nHHbx-g@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS8PR04MB7976:EE_
x-ms-office365-filtering-correlation-id: f64e2874-7359-4e07-da65-08dc6a82be97
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXVxT3pmL0lTUk1hTW52Q0d0ZVFEMmNqeWpmMS9tQzF6L0Z1b0hPQnRpNkZy?=
 =?utf-8?B?THRsV0JKcWxCVW1qelJVVlJ3NzZzWVRuRGlKcHA4amNRQkgzcm9hQ3Vzb1FO?=
 =?utf-8?B?NEx4NFlnUlNncjNRY0tSUGZhMUJ3ZGRWM2Y0bzg3MVN0RFErQ3hKWGZPcm1S?=
 =?utf-8?B?Q3hYL1pvcE5IWWZCODUvMFZJQlZEN0J6ODdFV21ISHdOZWR1VTBHeWQvNGxR?=
 =?utf-8?B?QStvVHBHaVhQQnNQMDZjUTBlWWF1Q1YwSzVPZGVMRUdZamtFSlU2SVlIelBB?=
 =?utf-8?B?eHpDbkRjQldDUHpmMC9SQnpQbnpaTGYzYTZ6ZlhjbURFVHNTa1IrelhRcWJk?=
 =?utf-8?B?OVltTGZNaHJLY2lQTWtyQ1NvRU13YVRoc2NhQ04wc0hUNFExYTI4VUc3R3JU?=
 =?utf-8?B?RWJYNnhoalV2d0k4OGpiSXgwNFFXMk84S2NIbDRwNFZPYU1JTWJ0WUMxOFVj?=
 =?utf-8?B?K0NEOGo3WVZkOTNLWnZnVDFPdnBIU1oxZWFMcXhqMjN2OTU3TFh2b3FoVVBu?=
 =?utf-8?B?VnYwd1hVMVlwVUJuOFRld05sL2E5eHZFYTAraUhuSmtFc3gwUUE0REpkR2JB?=
 =?utf-8?B?NS9LVHp5UGFQUG5acE9pR2RRLzgzY1lvem1PMGhZL1lqQzFKT3AxN1dHUnF5?=
 =?utf-8?B?UWpSeHhjc05pcVVCaytnc0VqZXJBQkpPK2l5a1NpR083SktqQlNISzQxcHlh?=
 =?utf-8?B?TjhYaXF1QXFuc2E1WEJCNnlhM0xrSWlac05NL2lNVHBhbmpvSjBPeFJmTzNU?=
 =?utf-8?B?NFprZmE3MUxydU9XYVVpWndHVEhWQ1kzcmdvTzVpcDZtYnVWTVUzdWRkOEJ0?=
 =?utf-8?B?dTR0ZkRURFhsUTVYR2JtU1Vpa1lwM0QyaTN2eDB1YzB1ODl5eHMvVmFRWmxk?=
 =?utf-8?B?RnNJWnpGZUVGVDR0K1VjcXVFTXRIb0dKcFdNRWZIVmRRSkNVSGQzR2Q5LzY1?=
 =?utf-8?B?VGQvRnR1dk10c3NYZ3FDNDRDY1JzallEeUJGUU9zYUgrMFZtaU54d2dIRksv?=
 =?utf-8?B?WU9PVHRCZytGV2RidFp0NWdGYm9LY1VRV0UxN0ROYnR6ZXFYQWJoZkg1ZTdn?=
 =?utf-8?B?UEh5S1VXeC9tZGVTNE90YThEYSthc0N0Qjl3YmlXSzhjaHNJNzNpYlVLYnlU?=
 =?utf-8?B?K1lYMzJHUDZqWDdNNU14OGFMUnEvUzAvelVuU2J3blJISlFKcm0wWFBBdWhK?=
 =?utf-8?B?VW9MVjJNTTR5aGpmdHVuTFc1cnZKejJUYVI2WTJJS09idkxuY2MrenI5a09W?=
 =?utf-8?B?SjB3NllUZElLTXBZOWFMb2ZtM1ZkVG5vOEZHcjNHQmlnQmFyNytWZ2hORmRJ?=
 =?utf-8?B?NExyMThSR0NGeldwY3pBYjNmVnJnYTRMSE4vdlFnNDF6K2hjd1hsSGR6dTB1?=
 =?utf-8?B?Mk1qeFQ3U3RoRVBhWTBkNGl0SUcyVkE4a0xvQkV4K3NoWnNFUThTY2V6ekh5?=
 =?utf-8?B?TjRoOXpEY3pSbDBuSEh5SUxhcXVTRGpYVlRaSmJ1OHQ0eUtHdDVESXhUVlVx?=
 =?utf-8?B?MWx5cndxamxlUk9RZ3JvakRzelY0V0E2cmVUMFl4ZzNSUndwNDdEZFhmQ2Vx?=
 =?utf-8?B?dnlqRTZkTWIxeERnZm1EcXlOVFZZWTVaVEJBSG9GUGEzdXVnWU5VV2t4UjJ0?=
 =?utf-8?B?a0ZQRnIvNzJCMDVBSHJwOGc3akljR1NHTXczWFpHbFBJMHEzZVEveG8xeWcv?=
 =?utf-8?B?dGo2dTBHUy96S0xXbEpsUFc2K3RObVVYcVRXOTlPSFpwUlBzbHdISDB3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmVwUVJlUVpueTQ1aktubUF1TUx1SmFZYmpZYkdEUTFUQXBsZTlGMEErOGtp?=
 =?utf-8?B?aVlETVBGdTM2RzE1MGN3NXNkTU56MHhaRTRiNHp0UlVzYTF1M3g1Sml5aDFB?=
 =?utf-8?B?R1lvWHpaZFFtN3RKZUowT3lTZnYrRFRzMzFsdjBHdXN0eFA0QkNlNnQxbGxk?=
 =?utf-8?B?Y3RaUVpXMTRaMVJ1MkdKUXhybElvMkcrM1VUaXA0M1U2b1h0YktJS1BsWERl?=
 =?utf-8?B?MlRDRVM1MGlrRTRKNHk4TFc1SFVyczhFMDdER0E2WFNwUmJiMGUycS9YYm5J?=
 =?utf-8?B?bEdzR3lUNG9NUDZLQ05rQ25tUjlxTEhxK2hBVng0WkN4bFlVMjlZRVgrUHky?=
 =?utf-8?B?M1pIRDc0OHpqYXJNVEZNcXlnbkMycUhRUk1FVDU0R3BGM2JlK20zNi9iUVMv?=
 =?utf-8?B?RGt2akJqdlRsVEE2a29uakF1VjJiS2ZVMWZWSHhZMEdEVmViVkgxWjZKSXQv?=
 =?utf-8?B?eVJpc0R6bkpvYWhPZ2c4eXpJOVpNdTRqMnhCbWxMdFFqa1AyNHNMdGFvZ3d0?=
 =?utf-8?B?NFU5Ulp4cXdneVQ5MHJYZHF6bVRKNUJEQkJHZVNBbm52YlFxak0rb3pEYjlT?=
 =?utf-8?B?WDZ0Z0l6U0hURytYb0tYNklaNDRSNDNIbGV2MGJmTml2SitlU05xUVRUaUhN?=
 =?utf-8?B?aWZHZGNaVVY3UlRHUmtQTEhzb3N5NWRERVFaRjUySjVtN3hEUG4rYXNwQ21W?=
 =?utf-8?B?K29WUW5mUzI3VmNQSityK1lJRWJPeE0zY2NSM2J6WmMxS042UVA4OTVvQTFS?=
 =?utf-8?B?ZXNybmVrZ2prRVNKaTRKU1VBanQwV1lPdnMrRTB5Y0ZNYTc3RWR4T1JaNFU5?=
 =?utf-8?B?Q3gyb0E2VTk2NmVma0FFeEVKZ1F3VjRGeVVQWUFqQkgvNHFheitzY3ZkbjBx?=
 =?utf-8?B?S2hIUWlMdFdnS1hveEpnUExvcHJMTytxUWFqRmhWVWYzZ3VmZDE2cHd2YXN0?=
 =?utf-8?B?VVUySFNiSnJ1b2Q2SjQ2dHRxSUUvZHhRV3lpOE9PUTlHRmZ6K2c5Z0l0d0E2?=
 =?utf-8?B?WjFHZzN1UWdFdVZsUjU2Y0wzQ3g3c2xORlBsMDIrOVRna3dqczFpclpDUTBM?=
 =?utf-8?B?akVNaDh6eWR4MmlsMi9qOWthUnQyVVdXLzV1QXlWZUNxUFl5KzJJQWlIVDM2?=
 =?utf-8?B?eUpxQ0U4ZmM3TVR6NjBWdjJ3WEhxZFJ3czRieGtML21vK0ZvNnoxbnFJS3hU?=
 =?utf-8?B?RHZmT2YrVDhHOHpOWGEzd0x2cTJhOXo4TjZ4WUFxNWRDOGMzbkVjVUxnWEk1?=
 =?utf-8?B?TlBZU3BEQ0hpaEFtTjI1SE5kVGJvVDBGdFNCRXErTktwakVOZ0dzU3NscDUw?=
 =?utf-8?B?YzN2b3VES3hYMUVYdFlPSEdJVDgwYTNDcTdHM0hVWjcwR1ovRmV4RkhVNUhY?=
 =?utf-8?B?TDNpOFBjVEdhZTV2UTJRZU5zZ05HVUw3RmRSN1ZGS1UwSUE0aGdTdmpGOE9p?=
 =?utf-8?B?WUxwN3FXOVpWeExQYnBMRzcwWlI1THo4TS9xMWJ0UUlnTklpS09ROEdoSzJt?=
 =?utf-8?B?MGxCLzhRV08wQjdGTXJEQ0xKZlhOaW0xM3BsaFZPdEZmUzVtSGJabjFWMVZT?=
 =?utf-8?B?L3gyaVZBZEFrU1hBZ3JkdG5xZUVubHF4N29BZlJiK2M4bHBlbGZJOVpzMy9p?=
 =?utf-8?B?czlPN1NpeVZ1bkgzYVc1Q0h1V3dXUHNuZ045WStNUnRMemNwTzJTNTkvbGhs?=
 =?utf-8?B?bk4vYnZRWTFXZnFiMzYxeTRWTkZBZW5DTUZjL2NIbXZyT1ZxTkZicmZWUCsy?=
 =?utf-8?B?KzhSUWxkRnFWTzJRSms3WGlEWEJLanJ2bHhlK1hPcnR5K1ZIV25VMUpneTdW?=
 =?utf-8?B?TUFlZU9NSEtldXpvQVFFdXh6YjA0ZGtjQmlVYVpZU0U1SmVOSjJzMVdZMGw5?=
 =?utf-8?B?dUhJSFdtMThRdEk1ZEkwdEF6Wi9lWXRGbmUybTZKdnJIczdiL2VTckl5L0Fm?=
 =?utf-8?B?V2ZXM3RGaDdaVlZQcEUxV3Zvb1drRXFCbFBGWHhnK29iWE9saktOMExmZFcz?=
 =?utf-8?B?VVhQMUhpUjdUZklnY3YxZjNkaE1jS1Uvd3luSGZMNkZ5UTlqOHg4dHZHcWZu?=
 =?utf-8?B?MWtCT1l3aTJKdnE3MVBKdFpnWTU5UXZHamZzN3dVWmMrZGMxeGs1Umt5bjJQ?=
 =?utf-8?Q?pb5PS87bguaVVw8GNrzSsKu55?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f64e2874-7359-4e07-da65-08dc6a82be97
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 08:34:55.5659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fOJCHFhyexHOSfkTcIKW/uqJpk4jqPKGu28FlHk5BbCV/QTQmWGlis9O1egjgwoSD658UUzCyhFRSrkmqFSqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7976

PiBGcm9tOiBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9yZz4NCj4gU2VudDog
RnJpZGF5LCBBcHJpbCAyNiwgMjAyNCA5OjA5IEFNDQo+IFRvOiBEYXZpZCBMaW4gPHl1LWhhby5s
aW5AbnhwLmNvbT4NCj4gQ2M6IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz47
DQo+IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgTEtNTCA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz47IEthbGxlDQo+IFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+OyBmcmFuY2Vz
Y29AZG9sY2luaS5pdDsgUGV0ZSBIc2llaA0KPiA8dHN1bmctaHNpZW4uaHNpZWhAbnhwLmNvbT47
IHJhZmFlbC5iZWltcyA8cmFmYWVsLmJlaW1zQHRvcmFkZXguY29tPjsNCj4gRnJhbmNlc2NvIERv
bGNpbmkgPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiBTdWJqZWN0OiBSZTogW0VY
VF0gW1BBVENIIHYxMCAwLzJdIHdpZmk6IG13aWZpZXg6IGFkZCBjb2RlIHRvIHN1cHBvcnQgaG9z
dA0KPiBtbG1lDQo+DQo+IEhpIERhdmlkLA0KPg0KPiBPbiBXZWQsIEFwciAyNCwgMjAyNCBhdCA3
OjQw4oCvUE0gRGF2aWQgTGluIDx5dS1oYW8ubGluQG54cC5jb20+IHdyb3RlOg0KPiA+ID4gRnJv
bTogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPg0KPiA+ID4NCj4gPiA+IEhp
IERhdmlkLA0KPiA+ID4NCj4gPiA+ID4gSm9oYW5uZXMgYWdyZWVkIHRoYXQgY2ZnODAyMTEgaXMg
dGhlIGNvcnJlY3Qgd2F5IGZvciB0aGUNCj4gPiA+ID4gZGV2ZWxvcG1lbnQgb2YgbXdpZmlleA0K
PiA+ID4gPiAobWFjODAyMTEgY2FuJ3Qgb2ZmbG9hZCBhc3NvY2lhdGlvbiBwcm9jZXNzIHRvIGRy
aXZlci9GVykuDQo+ID4gPg0KPiA+ID4gdGhhdCB3YXMgbmV2ZXIgbXkgcXVlc3Rpb24gaGVyZS4N
Cj4gPiA+DQo+ID4NCj4gPiBUaGlzIGlzIHByZXZpb3VzIHRvcGljIGRpc2N1c3NlZCB3aXRoIEpv
aGFubmVzIHRvIGNvbmZpcm0gY2ZnODAyMTEgaXMNCj4gY29ycmVjdCBkZWNpc2lvbiBmb3IgTlhQ
IEZXLg0KPg0KPiBUbyBiZSBjbGVhcjogZXh0ZXJuYWxfYXV0aCgpIGlzIGEgY2ZnODAyMTEgZmVh
dHVyZS4gU28gdGhpcyBwYXJ0IG9mIHlvdXINCj4gcmVzcG9uc2Ugc3RpbGwgaXNuJ3QgdmVyeSBy
ZWxldmFudC4NCj4NCg0KU29ycnkgSSBtZWFuIGV4dGVybmFsX2F1dGgoKSBpcyBhbm90aGVyIHdh
eSB0byBsZXQgd3BhX3N1cHBsaWNhbnQgaGFuZGxlIFNBRSwNCmJ1dCBpdCBkb2VzbuKAmXQgbmVj
ZXNzYXJpbHkgbWVhbiB3ZSBoYXZlIHRvIHVzZSBleHRlcm5hbF9hdXRoIGZvciBTQUUuDQpPdXIg
cHJldmlvdXMgZGlzY3Vzc2lvbiBoYXMgY292ZXJlZCBob3cgY3VycmVudCBwYXRjaCBpbXBsZW1l
bnRlZCB1c2luZyBjZmc4MDIxMSBpcyB2YWxpZC4NCg0KPiA+ID4gPiBUaGlzIHBhdGNoIGlzIHVz
ZWQgdG8gZnVsbHkgbGV2ZXJhZ2UgU01FIG9mIHdwYV9zdXBwbGljYW50IGFuZA0KPiA+ID4gPiBo
b3N0YXBkDQo+ID4gPiB3aGljaCBjYW4gY29tcGxldGUgdGhlIG1pc3NpbmcgV1BBMyBmZWF0dXJl
IG9mIG13aWZpZXguDQo+ID4gPiA+IFRoZSBwYXRjaCBzZXJpZXMgaGFkIGJlZW4gcmV2aWV3ZWQg
YW5kIGRpc2N1c3NlZC4gSXQgbG9va3MgbGlrZQ0KPiA+ID4gPiB0aGVyZSBpcyBubw0KPiA+ID4g
bW9yZSBjb21tZW50cyBmb3IgcGF0Y2ggdjEwLg0KPiA+ID4gPiBJIHdvbmRlciBjYW4gcGF0Y2gg
djEwIGJlIGFjY2VwdGVkIGJ5IHlvdT8NCj4gPiA+DQo+ID4gPiBJZiB5b3VyIGhhcmR3YXJlIGlz
IGEgRnVsbE1hYyBoYXJkd2FyZSB0aGVuIHdoYXQgaXMgdGhlIHBvaW50IGluIG5vdw0KPiA+ID4g
c2VwYXJhdGluZyBhdXRoL2Fzc29jIG91dC4gSXMgdGhpcyBkb25lIGp1c3QgZm9yIFdQQTMgb3Ig
YWxzbyBmb3INCj4gV1BBMi9XUEExLg0KPiA+DQo+ID4gWWVzLiBPdXIgRlcgY2FuJ3Mgc3VwcG9y
dCBXUEEzLCBzbyB0aGlzIHBhdGNoIGlzIHVzZWQgdG8gaG9vaw0KPiA+IHNlcGFyYXRpbmcgYXV0
aC9hc3NvYyB0byBsZXZlcmFnZSBTTUUgb2Ygd3BhX3N1cHBsaWNhbnQgYW5kIGhvc3RhcGQuDQo+
ID4gV1BBMiBpcyBhbHNvIGhhbmRsZWQgYnkgU01FIG9mIHdwYV9zdXBwbGljYW50IGFuZCBob3N0
YXBkLg0KPiA+DQo+ID4gPiBBcmUgeW91IG5vIGxvbmdlciBhIEZ1bGxNYWMgaGFyZHdhcmU/DQo+
ID4NCj4gPiBZb3UgY2FuIGNoZWNrIHByZXZpb3VzIGRpc2N1c3Npb24gd2l0aCBKb2hhbm5lcywg
Rlcgc3RpbGwgbmVlZHMgdG8NCj4gPiBpbnZvbHZlIGFzc29jaWF0aW9uIHByb2Nlc3MsIHNvIG1h
YzgwMjExIGlzIG5vdCBzdWl0YWJsZSBmb3IgTlhQIEZXLg0KPg0KPiBGb3IgdGhlIHJlY29yZCwg
dGhhdCdzIHRoZSB2OSB0aHJlYWQsIGFyb3VuZCBoZXJlOg0KPg0KPiBodHRwczovL2xvcmUua2Uv
DQo+IHJuZWwub3JnJTJGYWxsJTJGN2EwOGRiY2FkZWQyNWVjMGQzMjg2NTY0N2Q1NzFhZmJkNjYw
NjJmZS5jYW1lbCU0MA0KPiBzaXBzb2x1dGlvbnMubmV0JTJGJmRhdGE9MDUlN0MwMiU3Q3l1LWhh
by5saW4lNDBueHAuY29tJTdDZDVmNmVkYzQNCj4gOWY4YjQ1MTcxZTg1MDhkYzY1OGQ3NDRmJTdD
Njg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJQ0KPiA3QzAlN0M2Mzg0OTY5MDU0
MzMxNTk4ODclN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzQNCj4gd0xqQXdNREFp
TENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzAlN0MlNw0K
PiBDJTdDJnNkYXRhPWVSdVVWQVhIJTJCJTJCMjdMZU9vJTJCSG1HeiUyQnljMVFidVdsOGYlMkJi
dFNrRQ0KPiA2U3hVZyUzRCZyZXNlcnZlZD0wDQo+DQo+ID4gPiBZb3Uga2VlcCBzYXlpbmcgdGhh
dCB5b3UganVzdCB3YW50IHRvIHN1cHBvcnQgV1BBMyBhbmQgaWYgcHJldmlvdXNseQ0KPiA+ID4g
dGhlIEhXIHdvcmtlZCBhcyBGdWxsTWFjIGhhcmR3YXJlLCB0aGVuIGV4dGVybmFsX2F1dGggc2hv
dWxkIGJlIHRoZQ0KPiA+ID4gd2F5IHRvIGdvIGZvciBoYXZpbmcgU0FFIGhhbmRsZWQgYnkgd3Bh
X3N1cHBsaWNhbnQgKG9yIGl3ZCBmb3IgdGhhdA0KPiBtYXR0ZXIpLg0KPiA+DQo+ID4gQWx0aG91
Z2ggZXh0ZXJuYWxfYXV0aCBpcyBvbmUgd2F5IHRvIHN1cHBvcnQgU0FFLCBidXQgd2UgdGhpbmsg
aG9vaw0KPiA+IHNlcGFyYXRpbmcgYXV0aC9hc3NvYyB3aWxsIGJlIHRoZSBiZXR0ZXIgd2F5IHRv
IHJlc29sdmUgdGhpcyBpc3N1ZS4gSW4NCj4gPiB0aGlzIHdheSwgb2ZmbG9hZGluZyBTTUUgdG8g
d3BhX3N1cHBsaWNhbnQvaG9zdHBhZCB3aWxsIGxldCBhbnkgZnV0dXJlDQo+ID4gY2hhbmdlcyBi
ZSBlYXN5IHRvIHN1cHBvcnQgKHdlIG9ubHkgbmVlZCB0byBjaGVjayBpZiB0aGVyZSBpcyBhbnl0
aGluZyB0aGF0DQo+IHdlIHNob3VsZCBkbyB3aGVuIGNvbnZlcnRpbmcgYXNzb2NpYXRpb24gcmVx
dWVzdCB0byB0aGUgYXNzb2NpYXRpb24NCj4gY29tbWFuZCBzdXBwb3J0ZWQgYnkgRlcpLg0KPg0K
PiBQZXJoYXBzIEknbSBtaXNzaW5nIHNvbWV0aGluZyAodmVyeSBsaWtlbHkpLCBidXQgSSBkb24n
dCBpbW1lZGlhdGVseSBzZWUNCj4gbXVjaCBkaWZmZXJlbmNlICh3aXRoIHJlc3BlY3QgdG8geW91
ciBGVyBBUEksIGFuZCBmdXR1cmUNCj4gZXh0ZW5zaWJpbGl0eSkgYmV0d2VlbiBleHRlcm5hbF9h
dXRoKCkgYW5kIHlvdXIgY3VycmVudCBzb2x1dGlvbiAob2YNCj4gaW50ZXJjZXB0aW5nIGF1dGgo
KS9hc3NvYygpIGFuZCBjb25zdHJ1Y3RpbmcgeW91ciBvd24gQVVUSCBmcmFtZXMpLiBJdA0KPiBt
b3N0bHkganVzdCBtZWFucyB0aGUgQVVUSCBtZ210IGZyYW1lcyB3aWxsIGJlIGNvbWluZyBpbiB2
aWENCj4gTkw4MDIxMV9DTURfRlJBTUUgaW5zdGVhZCBvZiBiZWluZyBtYW51YWxseSBjb25zdHJ1
Y3RlZCB3aXRoaW4geW91cg0KPiAuYXV0aCgpIGhvb2suIFRoZSBleHRlcm5hbF9hdXRoKCkgYXBw
cm9hY2ggYWN0dWFsbHkgbG9va3MgKm1vcmUqIG5hdHVyYWwNCj4gdGhhbiB5b3VyIGN1cnJlbnQg
c29sdXRpb24uDQo+DQo+IEhvdyBleGFjdGx5IGRvZXMgeW91ciBzb2x1dGlvbiBtYWtlICJmdXR1
cmUgY2hhbmdlcyBbZWFzaWVyXSB0byBzdXBwb3J0DQo+IFt0aGFuIHdpdGggZXh0ZXJuYWxfYXV0
aF0iPyBEbyB5b3Ugbm90IHRydXN0IHRoYXQgd3BhX3N1cHBsaWNhbnQgd2lsbA0KPiBwcm92aWRl
IGV4YWN0bHkgdGhlIHJpZ2h0IE5MODAyMTFfQ01EX0ZSQU1FIGNvbnRlbnQgeW91J3JlIGxvb2tp
bmcgZm9yLA0KPiBhbmQgeW91IG5lZWQgdG8gdHdlYWsgaXQgdG8gbWFrZSB5b3VyIGZpcm13YXJl
IGhhcHB5PyBZb3UncmUgdGFsa2luZyBpbg0KPiBleHRyZW1lIGdlbmVyYWxpdHksIHdoaWNoIGRv
ZXNuJ3QgbWFrZSBpdCBlYXN5IGZvciBtZSAoYW5kIHByZXN1bWFibHkNCj4gTWFyY2VsKSB0byB1
bmRlcnN0YW5kIHdoeSB5b3UncmUgY2hvb3Npbmcgb25lIHNvbHV0aW9uIGFuZCByZWplY3RpbmcN
Cj4gYW5vdGhlciBwcmVleGlzdGluZyBvbmUuDQoNCjEuIFRoZSBwcm9jZXNzIG9mIGV4dGVybmFs
X2F1dGggc2hvdWxkIGJlIGFzIGZvbGxvd3M6DQogIGEuIGNmZzgwMjExX29wcy5jb25uZWN0KCkg
aXMgY2FsbGVkIHRvIGVzdGFibGlzaCBjb25uZWN0aW9uIHdpdGggcmVtb3RlIEFQLg0KICBiLiBJ
ZiBhdXRoZW50aWNhdGlvbiBpcyBub3QgV0xBTl9BVVRIX1NBRSwgRlcgd2lsbCBwcm9jZXNzIGF1
dGhlbnRpY2F0aW9uL2Fzc29jaWF0aW9uDQogIGFuZCByZXBseSBjb25uZWN0aW9uIHJlc3VsdCB0
byBjZmc4MDIxMS4NCiAgYy4gSWYgYXV0aGVudGljYXRpb24gaXMgV0xBTl9BVVRIX1NBRSwgRlcg
c2hvdWxkIG5vdGlmeSBkcml2ZXIgdG8gY2FsbA0KICBjZmc4MDIxMV9leHRlcm5hbF9hdXRoX3Jl
cXVlc3QoKSB0byBvZmZsb2FkIGF1dGhlbnRpY2F0aW9uIHRvIHdwYV9zdXBwbGljYW50Lg0KICBk
LiBGVyB3aWxsIHdhaXQgZm9yIGF1dGhlbnRpY2F0aW9uIHJlc3VsdCBwYXNzZWQgYnkgY2ZnODAy
MTFfb3BzLmV4dGVybmFsX2F1dGgoKSB0bw0KICBkZWNpZGUgaWYgYXNzb2NpYXRpb24gc2hvdWxk
IGJlIHByb2Nlc3NlZCB3aXRoIHJlbW90ZSBBUCBmb3IgdGhlIG9yaWdpbmFsIGNvbm5lY3Rpb24N
CiAgcmVxdWVzdCBhbmQgcmVwbHkgY29ubmVjdGlvbiByZXN1bHQgdG8gY2ZnODAyMTEuDQogIE5Y
UCBGVyBvbmx5IHN1cHBvcnRzIGFzc29jaWF0aW9uIHdpdGggb3Igd2l0aG91dCBhdXRoZW50aWNh
dGlvbiwgaXQgY2FuJ3Qgc3VwcG9ydCBleHRlcm5hbF9hdXRoLg0KDQoyLiBIb29rIHNlcGFyYXRp
bmcgYXV0aC9hc3NvYyB3aWxsIG9mZmxvYWQgU01FIHRvIHdwYV9zdXBwbGljYW50IGNvbXBsZXRl
bHkuIERyaXZlci9GVyBkb24ndCBuZWVkDQogIHRvIGludm9sdmUgdGhlIHByb2Nlc3Mgb2YgYXV0
aGVudGljYXRpb24ganVzdCBsaWtlIGV4dGVybmFsX2F1dGggZGlkLiBUaGVyZSBpcyBubyBlZmZv
cnQgZm9yIGRyaXZlci9GVw0KICB0byBzdXBwb3J0IGFueSBmdXR1cmUgbW9kaWZpY2F0aW9ucyBv
ZiBhdXRoZW50aWNhdGlvbiBwcm9jZXNzLg0KDQpEYXZpZA0KDQo+DQo+ID4gPiBOb3cgaWYgeW91
IGFyZSBmdWxseSBlbWJyYWNpbmcgdG8gYXV0aC9hc3NvYyBhbmQgd2UgY2FuIHJlbW92ZSB0aGUN
Cj4gPiA+IHN1cHBvcnQgZm9yIHRoZSBjb25uZWN0IG9wcywgdGhlbiBsZXRzIGRvIGl0LiBIb3dl
dmVyIEkgZG9u4oCZdCBzZWUNCj4gPiA+IGFueXRoaW5nIHByb3Blcmx5IGRlc2NyaWJlZCBpbiB0
aGUgY29tbWl0IG1lc3NhZ2UuIFlvdSBrZWVwIHNheWluZw0KPiA+ID4gV1BBMyBzdXBwb3J0IGFu
ZCBub3RoaW5nIGVsc2UgZXhwbGFpbiB3aGF0IHRoZSBuZXcgS2V5IFYyIEFQSSBvZiB0aGUNCj4g
ZmlybXdhcmUgd291bGQgZG8uDQo+ID4NCj4gPiBXZSBnaXZlIGEgZmxhZyB0byBsZXQgdXNlciB0
byBkZWNpZGUgdG8gdXNlIGNvbm5lY3Qgb3BzIG9yIHNlcGFyYXRpbmcNCj4gPiBhdXRoL2Fzc29j
LiBXZSB3aWxsIHJlbW92ZSBjb25uZWN0IG9wcyBmb3Igb3VyIG5ldyBueHB3aWZpIGRyaXZlci4g
TmV3DQo+IGtleSBWMiBBUEkgc3VwcG9ydHMgbW9yZSBrZXkgc29sdXRpb25zLg0KPg0KPiBUbyBh
ZGQgdG8gdGhpczogQUZBSUssIHlvdSBkb24ndCBldmVuIGhhdmUgInYyIEFQSSIgZmlybXdhcmUg
cHVibGlzaGVkIGZvcg0KPiBhbGwgY2hpcHMgdGhhdCBtd2lmaWV4IGN1cnJlbnRseSBzdXBwb3J0
cywgc28gZXZlbiBpZiB3ZSB3YW50ZWQgdG8gY29tcGxldGVseQ0KPiBjb252ZXJ0IHRoaXMgZHJp
dmVyLCB3ZSBjYW4ndCBkbyB0aGF0IHRvZGF5Lg0KPg0KPg0KPiBCcmlhbg0K

