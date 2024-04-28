Return-Path: <linux-kernel+bounces-161224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A9F8B4938
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 04:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA622820E8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 02:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F3C15C9;
	Sun, 28 Apr 2024 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZKcTzSHg"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43C110A;
	Sun, 28 Apr 2024 02:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714271468; cv=fail; b=bZcpJODJJKDa/gJYL8YsRg8IpB+mO++M8dUHXN7G09rsCR2vV7ggPgjtfKV5hi4SulMsgWxzV/cuu/HpuYH43SezMgoYpbCqWPOvIOnVzDZMbxvPQHB+nZ/3rErEgKnnvtQEpVwASv/KGcJSGvipEOONWrnJPDkZkk2bSgi5Jec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714271468; c=relaxed/simple;
	bh=6gp3qyqtDL7rheCgZTjj2BGOrNOzTVdz8R/g8t5OLyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WxIM5mIOjo3c0JhXjLS/Hu0RyLtDcxdX3VNq5s/TkbDM3xudD1aNhKfeUbtvOk0Sw94b4L26zjO3+fiCuBXNX3il4SrfIWEd2tithC5B9dawoq/4I8lMMH1Jnt3NVlbV4Cb+yTr1pceb7+7kkhc3WBgaak+IvFqWx69qGxHJ02g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZKcTzSHg; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQXBZ2KNdgfJQivUNso7oiC9UPKUI5MHboCoTVTKzedwRnPaeeKj+wxSN137VwgzhawEHhvZFFUWwWoUTHfPHjQ/Rg/Rwo14JWMFaGNqni0uZDJ2YYxLte5ErK9tPhTGoZ4dAu3tqbBYB4+nL8vRdSv9hWLHjfeqUxNDSp99UEpPfep1xZkA9E7fc+qtN7Iy/IXfoiW2zhud8Whjdfxg30ngGokPTOGXZgFuMMpMFn7fKlJE1tpf7PJ9luv6wbzAl+dcIMLJndr5AZCWZLum6taF8NTeKVq8CXifNjGCPNRMBKzBtaLAeTajhwR8JWYLcfoaR2ElojDxEU9TbPpEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gp3qyqtDL7rheCgZTjj2BGOrNOzTVdz8R/g8t5OLyM=;
 b=QGHNhKYoLpDJBGSfLxFefGE7MWXMGiPKVYzYR8FmezTKSvpvSpWDtdIW/YB3NfjDWNAqPgwjOFy9gdAm36tx61T1lwZ42YimyNoLk9l8u+cw1vAooulyd0PvrkVw0XCcisSyr4UTYz8K/acNOQsPkKRyDc7kpZPwtmu2k8TXUQFZIz7MCJTq/4A8OKadK0HUrB/mID2Lj6m6/ZUOfNBuI3bycrjx88zTFcUPxrN8Jguyl7LGtnXGH+4n0gBxqO5f4KblJ2+yDcvlhdvYi09X/aVrQ26RJVxpjQvyu/UheSA0PBR7L2iZmZ3d091bZsNDTPW8NRToztMlVdCUD9h4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gp3qyqtDL7rheCgZTjj2BGOrNOzTVdz8R/g8t5OLyM=;
 b=ZKcTzSHgniT6euUgnc100LkezoRehCQYwz2gJPHkoStT/0qJMxcFhqJhAzYWap2HRlnRQDUkzldwgG8C6kL4KnpZxEpW0xv9GtIPZoLzyrPg2CQpWhLKJWQJQUHyOQ8So9eTDB2nsqGNqUIN0Qwv9iGQ8Tsn3P4++5n9bTM5JcE=
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10415.eurprd04.prod.outlook.com (2603:10a6:102:444::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 02:31:01 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%6]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 02:31:00 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] gpio: vf610: always set GPIO to input mode when used as
 interrupt source
Thread-Topic: [PATCH] gpio: vf610: always set GPIO to input mode when used as
 interrupt source
Thread-Index: AQHalSX3LJYhygbqkUe2wC+6G48jP7F1u+eAgAAHv6CAAXxfYIABuIeAgAQFA6A=
Date: Sun, 28 Apr 2024 02:31:00 +0000
Message-ID:
 <DU0PR04MB94965CE7D3BFBA35887A5C4190142@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240423022814.3951048-1-haibo.chen@nxp.com>
 <CACRpkdaRxoEZT1_KyJ3QMDgBcciw1XUXKr=cEiPxbcwSnpmyiA@mail.gmail.com>
 <AS1PR04MB9502BE89834E7F9DA3E8D70B90112@AS1PR04MB9502.eurprd04.prod.outlook.com>
 <DU0PR04MB949691D7F68E2F32371B604F90102@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <CAMRc=McQtohbuUSrhH8LiF6EWUzRKyHSObBv4D6VeE87NmdZQQ@mail.gmail.com>
In-Reply-To:
 <CAMRc=McQtohbuUSrhH8LiF6EWUzRKyHSObBv4D6VeE87NmdZQQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|PA1PR04MB10415:EE_
x-ms-office365-filtering-correlation-id: c7c3d85a-fb46-4047-063d-08dc672b3e57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0dRUTVlc3JNYW1hZWZkNlZ0L3BxLzVKY2pZVjZGUVNxWWxSRlNvVEsyYlU0?=
 =?utf-8?B?bVl5QW5aNjZ5Zmt3VVQ0Wm91ZVp1QlB0MEpqNDJTcTcyYjdzMUJ1SHJQZFJq?=
 =?utf-8?B?WHhndzBQY1dQQkRReEptV0JBdU40N1JvYVN5NFN3R2diRVkyRzV0V1Bmd2p1?=
 =?utf-8?B?WVRmdEYxR3FpUXJMT01zUlZjWjN5aitxNm1JNFVKWllJMVUvWEtOVWVpRmc3?=
 =?utf-8?B?Tk8ydUxvWW8zWkZYL01rU1RhOS9IVU15SHVZZ1QwRXhOVTV4aVp3Nk9zU0p6?=
 =?utf-8?B?VmR3aTljelZSMmIyakI3eURTRUxyS2Q2SzhtRGN0VXFBcHRJY0RCcnVocHhy?=
 =?utf-8?B?R2NXUTg4WVA4Nm1SWnJjRGNsT3hCNVVCT3VBNHczMitVcDZFY0FVVE0zM3dE?=
 =?utf-8?B?K1NyRkhZRGx5clBNeHdIa0NOc280RDAwM2FOdmRkNTZyamJ1Yy81SXJLeHhF?=
 =?utf-8?B?bjAvNHBEa0wvMVZGcXFBbDd3dzZQcWZVOXFjVmNzS3lRNld4TkFhWEFrdyty?=
 =?utf-8?B?S2E5TUxyM1diOGp0QlpWNmF2S1U5ejBVOUIwYWZMR1pqTTE2MEp3SEdRc1hw?=
 =?utf-8?B?dFlCbW0wVnZmb2szTHlmdkdCT0RXZklEQVVNT0hOZFNPYm9janZwaWV6ZWlz?=
 =?utf-8?B?dEFlQTI3cUo2U05lU04rVWNMcUh4aVZKTHNUSlRrYTE3ZXAzR0pxdG9vcFJU?=
 =?utf-8?B?SkptTmVtN2h4NFp6bnJYV2NxVGxra3EyTHA2UzQzK1hGMWtoY2tuSHE4N0Ja?=
 =?utf-8?B?UDJtcmxsYWNyMVdoOW0wUzlyYk5hTkVvdE1VUnVUdTN1alp1MzZJUFRFWW0v?=
 =?utf-8?B?VGVPQitjcXVtRXdFVGhhNEMwd3J6MkVWSnVrUkV6Wm82MG5GRkNWQmRkWURC?=
 =?utf-8?B?SEtwcEhqa2xCQ28wM1FaZWR2WHFjMzVlVWp4Q040T0R0ZEpuYXZ6eHBDUm5Y?=
 =?utf-8?B?WHF5TU93eVIrZFdKSXZiSUwxZDhNaE5Rbko3eHgxeEx3R3dBSFV3SFhjd2t1?=
 =?utf-8?B?N2xhdm9ES2o1QjdZU21vcXJvd2I2eW1XVENzZTR3NTlJYSs5RVYxei9ZOE55?=
 =?utf-8?B?WHBDdG9TM01IeVZyMENlbTlaYVVVWVFYOG1SMDJqZ3RzMWU3NklhQ0dQZU5m?=
 =?utf-8?B?VGtpUTl2cU4wNlRvUlFMQ1dSUndNSzVQcTRPTWU5THdzNGYwc01qMnBsVkZF?=
 =?utf-8?B?ZWRsWU1KRTZ2V1B1eFlURFViODUxSlNGY0lod1VoM1RSS1A0dVdRc3FjdkZk?=
 =?utf-8?B?OWZpZ0tMc3l6WmNNOWMvOElBVVdLVWJXRk9DVW1pQjJOSVJkQVBYVEl1YkhG?=
 =?utf-8?B?ZytBaTVDTmx3Rlh6UkhxVjRzUkNTbnMrcmpONGNId095Y3RWUGYramtPVUFr?=
 =?utf-8?B?dGdIVUlqR0sxWWdycHVyR0dna2dhaStWQjB2USs0U21EY2J1Qmt5ZHRTelhR?=
 =?utf-8?B?aGp2dEFWeXhhOVVHUVpkMTdENzcvSkRETEFLRVUrTmZOWG0yNjlZdEFhZVp2?=
 =?utf-8?B?SWF2QW4xR05OZ2hxeUtGRVFoM0t4WFZoNlkrTGJMTmUydmFrUHJRVmRzWTlI?=
 =?utf-8?B?YlJlaUpwSEVLeHV4RHFlY1FUYzNuMFFlekgrK29qVUo4WjI3MjAwN0sxcXFr?=
 =?utf-8?B?T0dPZUJSNkpLK3RRRmg4UHpHTkVyZ1BpaVNoZEd2Lzh5RzFPQStYQmF1SDQx?=
 =?utf-8?B?L2I2SDgrcVFiempncnBEcXZkMU8vUDhFRjhNNjJsMFZhdCtIQ0ZJZmZnYTM5?=
 =?utf-8?B?d0hTUXpoeVd3OXZCWHpvK1RWNUJGbU1jQmZxaVpvMml5Q1VhY1JBNzVaUjBL?=
 =?utf-8?B?WDBsMEIxRGswWTJuOFFKdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFZKWHZPVjJvQVBEeEhQZkpyNzRrVklZSFc1QXNhem9uU3NCeU5FTnZvcDFD?=
 =?utf-8?B?TWtsKzE1NVNiUldYMnY1M0Y0bUpEMWhGWjZLcWZ2VmdWRWhoMWRIOC96V2lL?=
 =?utf-8?B?ZHdaeFNQOG83SmNoMm1QVXRCeERLcy9DeGo5dnRrZktOZVJRSHBzTzFQcmp2?=
 =?utf-8?B?MitkT0RtOWk2Z0lYb2pRQkswNzgrdU9ZMFAzb0VNSXExQmVsQ0RFSXc1alli?=
 =?utf-8?B?aGZCZ3hsNGNqMFJOUzQ0SkE3V0Fla0VrWk9lbVNCOGQyL3hsUlVnTm9LWjBy?=
 =?utf-8?B?bk5QbGdta0tiZUJ6R01CZVZEL0YwWVk1Y2MwZFkvVzdYNFIvL1RJSVFOMEV2?=
 =?utf-8?B?S1k5UHIxbkY4QmhXeHNsWXJib05WY2I5Yy8yL1hsWXhFQkJYcDZXdHZpRmRK?=
 =?utf-8?B?WkVsQVRFek8zZ1pXbjJpcHltRlFEdm1yUHRhWk91REVHSzdRU3VjTTkyUG5K?=
 =?utf-8?B?dDlha2x2OUpTNlBCeDh0S2p1b1FMZTBtK2lPcUx3Q013NkZxdVc4dnpLMzRo?=
 =?utf-8?B?NUpuSlIvL3V0WVVtNUluYVlhalJkMEVzN0Q2NklDRXJieTNuZHRVazM4VEtJ?=
 =?utf-8?B?bFVoSFE2MkVSbWdjaEJpQmxFVnBhOEovWkxZNitvK2tSTDlnQ1p5eUxlUC9w?=
 =?utf-8?B?dWN5eGYwQ3E2TG5NZWNnd05WUy9XZW1xdW5EMi8wa3BqUlpEdVF2aWE2VUlH?=
 =?utf-8?B?RUE3ajlBNGREZFlGYkJEOWhxTTJ6MmNVQUppVEZoYjdoSkIrd3NId2hEN1Zo?=
 =?utf-8?B?UFE1MmFEL1BKTENWc1ZlWGgvVUpiUnNTdHJBaWswenNHcGZrZ0lHWFRIM1o2?=
 =?utf-8?B?aVdRMlBwSjZRMjJHUUxHZXE3YjJVMWdEdlNPQlBGWWpCU3VxYU1jNGJEQTZC?=
 =?utf-8?B?MFpqTVo2eS9ucXRYUEdVc1ovRTVLWmlndkVNWFZYS2dXL3hQM0ZLa0lyUEI0?=
 =?utf-8?B?cm1hQjhFWWdHMlBMd0lic3NKS1N2eFJ6NHVUTE5qakdyMjlpRE1LRVFiNGVL?=
 =?utf-8?B?NWdjTHVhdytLeDh0TG1rMUxVWUNQdUU1Sis5alBib0JpN2ZlOGdXVndPTEE3?=
 =?utf-8?B?Ump6QVhkZkprWFk4RWZzZ1FLMW15RmNoN3RLTjN6NVdGbU1ROTJOU1dHMUNI?=
 =?utf-8?B?SlV1UnN3eFZGRGNvOXFMSktkbktQc2FZTjc0VnlBSFNoOThrdHFaTTRlVEww?=
 =?utf-8?B?aTgyOTEwTFpkQ2tlNjVBTXI2alNUQWtkd2E2bmNlaEtaekJOWDV2Vk9NSzJX?=
 =?utf-8?B?N1F6cGUrenBpTlo1eWhuMDRGVk5FZGljZk1Gb21pY25MT3czb2VFaG5XdnZ6?=
 =?utf-8?B?Q3BqS0IzS2cwTHA1YzlmSHNTRHRnbTV2NWl6NVJHUHZKYUtzZjRlSGt0ek9w?=
 =?utf-8?B?WldxZGlTWWV5Z0xsc1VoNC9zeGNNbHlDSG1qQjY1YVRDQ3lyN3lwbjZna0lE?=
 =?utf-8?B?OExad010cEdOK1hnQk1WWEs5WHNiK2t5dFVBS1dLalZhZnhMRHlFVTdzS1dp?=
 =?utf-8?B?NkhwaVhqNFYvNlNnNEtJbjlIRm9VTW9Va3lYMFFtSWNVbmUzTWJ6Z0FxNUh1?=
 =?utf-8?B?SUo4MHpQV0RZR05hNXN2bmtKYndLemt5SGJpdlpJeUdBTHVHN284RUFqRnkz?=
 =?utf-8?B?TG85cEM0THNaeklYWDVNajRqUi9CU0VLUDgrTWEvNUVtZ0JTOVdha3hIRFhM?=
 =?utf-8?B?V1dVcTRMM0s2eHNPamd2NEx3cndLcmU5eVFFS2VuckY5bTF6eVZFWmNOY2ta?=
 =?utf-8?B?RkhzNkJ1Z29YR1I1LzNEQktLRVBVWHA0Nk5aTklqL1NHMWVJSHQ4TmlPTnlL?=
 =?utf-8?B?dHNiQ21WK1FPeWxMZTV3YmE3ZHZsZ1E5N3EvRktudzBtTytleFNRazIybW1P?=
 =?utf-8?B?bVJSN0hwV1BTZ2p2eHExMzE3TG00eDNSdkR1d1hTMTg0WlFSQllCbVhBdlo3?=
 =?utf-8?B?bUU5TlB6UXdjSUtwTnZTcWFvNkFyWDBIclVKZEpXZDZUdTZBbmNlSlAwM2pT?=
 =?utf-8?B?Y2l0L05GN05UR3lZbmpEYjVvN2ptaDQ1VS9KbGpHRDJ0YlllejdwenNzbkFh?=
 =?utf-8?B?c0NkSkxrSXlMbkRid1lGbjdYd0lBTEcvV0h3S3BxcUhhZjhuOVd5VnBKbDZ2?=
 =?utf-8?Q?4yWw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c3d85a-fb46-4047-063d-08dc672b3e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 02:31:00.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kohkszFi+9fvDQINZ9j1OdcpfRu1ak9mapPhhfqCr8B0HNSOZ+bd5Yv7UpnGjP1mDqtm+xpuAJr8DmTExAJmLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10415

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCYXJ0b3N6IEdvbGFzemV3c2tp
IDxicmdsQGJnZGV2LnBsPg0KPiBTZW50OiAyMDI05bm0NOaciDI15pelIDIxOjA3DQo+IFRvOiBC
b3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+OyBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBncGlvOiB2ZjYxMDogYWx3YXlzIHNldCBHUElPIHRvIGlucHV0IG1vZGUg
d2hlbiB1c2VkIGFzDQo+IGludGVycnVwdCBzb3VyY2UNCj4gDQo+IE9uIFdlZCwgQXByIDI0LCAy
MDI0IGF0IDE6MDHigK9QTSBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQm91Z2gg
Q2hlbg0KPiA+ID4gU2VudDogMjAyNOW5tDTmnIgyM+aXpSAyMDoyMQ0KPiA+ID4gVG86IExpbnVz
IFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCj4gPiA+IENjOiBicmdsQGJnZGV2
LnBsOyBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gPiA+IFN1YmplY3Q6IFJFOiBbUEFU
Q0hdIGdwaW86IHZmNjEwOiBhbHdheXMgc2V0IEdQSU8gdG8gaW5wdXQgbW9kZSB3aGVuDQo+ID4g
PiB1c2VkIGFzIGludGVycnVwdCBzb3VyY2UNCj4gPiA+DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpA
bGluYXJvLm9yZz4NCj4gPiA+ID4gU2VudDogMjAyNOW5tDTmnIgyM+aXpSAxOTo0MQ0KPiA+ID4g
PiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+ID4gPiBDYzogYnJnbEBi
Z2Rldi5wbDsgbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gPiA+ID4gU3ViamVjdDog
UmU6IFtQQVRDSF0gZ3BpbzogdmY2MTA6IGFsd2F5cyBzZXQgR1BJTyB0byBpbnB1dCBtb2RlDQo+
ID4gPiA+IHdoZW4gdXNlZCBhcyBpbnRlcnJ1cHQgc291cmNlDQo+ID4gPiA+DQo+ID4gPiA+IE9u
IFR1ZSwgQXByIDIzLCAyMDI0IGF0IDQ6MjjigK9BTSA8aGFpYm8uY2hlbkBueHAuY29tPiB3cm90
ZToNCj4gPiA+ID4NCj4gPiA+ID4gPiBGcm9tOiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5j
b20+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaG91Z2ggdGhlIGRlZmF1bHQgcGluIGNvbmZpZ3Vy
YXRpb24gaXMgSU5QVVQsIGJ1dCBpZiB0aGUgcHJpb3INCj4gPiA+ID4gPiBzdGFnZSBkb2VzIGNv
bmZpZ3VyZSB0aGUgcGlucyBhcyBPVVRQVVQsIHRoZW4gTGludXggd2lsbCBub3QNCj4gPiA+ID4g
PiByZWNvbmZpZ3VyZSB0aGUgcGluIGFzIElOUFVULg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZS5n
LiBXaGVuIHVzZSBvbmUgcGluIGFzIGludGVycnVwdCBzb3VyY2UsIGFuZCBzZXQgYXMgbG93IGxl
dmVsDQo+ID4gPiA+ID4gdHJpZ2dlciwgaWYgcHJpb3Igc3RhZ2UgYWxyZWFkeSBzZXQgdGhpcyBw
aW4gYXMgT1VUUFVUIGxvdywgdGhlbg0KPiA+ID4gPiA+IHdpbGwgbWVldCBpbnRlcnJ1cHQgc3Rv
cm0uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTbyBhbHdheXMgc2V0IEdQSU8gdG8gaW5wdXQgbW9k
ZSB3aGVuIHVzZWQgYXMgaW50ZXJydXB0IHNvdXJjZQ0KPiA+ID4gPiA+IHRvIGZpeCBhYm92ZSBj
YXNlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFp
Ym8uY2hlbkBueHAuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL2dwaW8v
Z3Bpby12ZjYxMC5jIHwgMiArLQ0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwaW8vZ3Bpby12ZjYxMC5jDQo+ID4gPiA+ID4gYi9kcml2ZXJzL2dwaW8vZ3Bpby12
ZjYxMC5jIGluZGV4IDA3ZTVlNjMyM2U4Ni4uMzA1YjBiY2RlZTZmDQo+ID4gPiA+ID4gMTAwNjQ0
DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncGlvL2dwaW8tdmY2MTAuYw0KPiA+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvZ3Bpby9ncGlvLXZmNjEwLmMNCj4gPiA+ID4gPiBAQCAtMjE0LDcgKzIxNCw3
IEBAIHN0YXRpYyBpbnQgdmY2MTBfZ3Bpb19pcnFfc2V0X3R5cGUoc3RydWN0DQo+ID4gPiA+ID4g
aXJxX2RhdGEgKmQsDQo+ID4gPiA+IHUzMiB0eXBlKQ0KPiA+ID4gPiA+ICAgICAgICAgZWxzZQ0K
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICBpcnFfc2V0X2hhbmRsZXJfbG9ja2VkKGQsIGhhbmRs
ZV9lZGdlX2lycSk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAtICAgICAgIHJldHVybiAwOw0KPiA+
ID4gPiA+ICsgICAgICAgcmV0dXJuIHBvcnQtPmdjLmRpcmVjdGlvbl9pbnB1dCgmcG9ydC0+Z2Ms
IGQtPmh3aXJxKTsNCj4gPiA+ID4NCj4gPiA+ID4gSnVzdCBjYWxsIHZmNjEwX2dwaW9fZGlyZWN0
aW9uX2lucHV0KCkgaW5zdGVhZCBvZiBpbmRpcmVjdGluZw0KPiA+ID4gPiB0aHJvdWdoDQo+ID4g
PiA+IGdjLT5kaXJlY3Rpb25faW5wdXQoKSwgbm8gbmVlZCB0byBqdW1wIHRocm91Z2ggdGhlIHZ0
YWJsZSBhbmQgYXMNCj4gPiA+ID4gQmFydG9zeiBzYXlzOiBpdCBqdXN0IG1ha2VzIHRoYXQgc3Ry
dWN0IHZ1bG5lcmFibGUuDQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciB5b3VyIHF1aWNrIHJldmll
dywgSSB3aWxsIGRvIHRoYXQgaW4gVjIuDQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBTZWNvbmQ6
DQo+ID4gPiA+DQo+ID4gPiA+IEluIHRoaXMgcGF0Y2ggYWxzbyBpbXBsZW1lbnQgZ2MtPmdldF9k
aXJlY3Rpb24oKSB3aGljaCBpcw0KPiA+ID4gPiBjdXJyZW50bHkgdW5pbXBsZW1lbnRlZC4gSWYg
eW91IGFyZSBnb2luZyB0byBjaGFuZ2UgdGhlIGRpcmVjdGlvbg0KPiA+ID4gPiBvZiBhIEdQSU8g
cmFuZG9tbHkgYXQgcnVudGltZSB0aGVuIHRoZSBmcmFtZXdvcmsgcmVhbGx5IGxpa2VzIHRvDQo+
ID4gPiA+IGhhdmUgYSBjaGFuY2UgdG8ga25vdyB0aGUgY3VycmVudCBkaXJlY3Rpb24gZm9yIG9i
dmlvdXMgcmVhc29ucy4NCj4gPiA+DQo+ID4gPiBZZXMsIHdpbGwgaW1wbGVtZW50IGdjLT5nZXRf
ZGlyZWN0aW9uKCksIGlmIHdlIGRpZCB0aGlzIGJlZm9yZSwgdGhlbg0KPiA+ID4gZm9yIHRoaXMg
Y2FzZSB3ZSBtZWV0LCBmcmFtZXdvcmsgd2lsbCBwcmludCBvdXQgZXJyb3IgbG9nLCBzYXZlIG11
Y2ggZGVidWcNCj4gdGltZS4NCj4gPg0KPiA+IEhpIExpbnVzLA0KPiA+DQo+ID4gSSBpbXBsZW1l
bnQgZ2MtPmdldF9kaXJlY3Rpb24oKSB0b2RheSwgZm9yIHRoZSBjYXNlIHRvIHJlcXVlc3Qgb25l
DQo+ID4gZ3BpbyBhcyBpcnEsIGdwaW8gYXJjaGl0ZWN0dXJlIHdpbGwgZmlyc3QgY2FsbCBncGlv
Y2hpcF9yZXFyZXNfaXJxKCksDQo+ID4gaWYgdGhlIFJPTSBvciBVYm9vdCBhbHJlYWR5IGNvbmZp
ZyB0aGlzIGdwaW8gcGluIGFzIE9VVFBVVCBtb2RlLCB3aWxsIGdldCB0aGUNCj4gZm9sbG93aW5n
IGxvZzoNCj4gPg0KPiA+IFsgICAgMi43MTQ4ODldIGdwaW8gZ3Bpb2NoaXAzOiAoNDM4NTAwMDAu
Z3Bpbyk6IGdwaW9jaGlwX2xvY2tfYXNfaXJxOiB0cmllZA0KPiB0byBmbGFnIGEgR1BJTyBzZXQg
YXMgb3V0cHV0IGZvciBJUlENCj4gPiBbICAgIDIuNzI0ODE2XSBncGlvIGdwaW9jaGlwMzogKDQz
ODUwMDAwLmdwaW8pOiB1bmFibGUgdG8gbG9jayBIVyBJUlEgMTENCj4gZm9yIElSUQ0KPiA+IFsg
ICAgMi43MzE5NzJdIGdlbmlycTogRmFpbGVkIHRvIHJlcXVlc3QgcmVzb3VyY2VzIGZvciAyLTAw
NTAgKGlycSAyMTEpIG9uDQo+IGlycWNoaXAgZ3Bpby12ZjYxMA0KPiA+DQo+ID4gQW55IHN1Z2dl
c3RlZCBtZXRob2QgdG8gYXZvaWQgdGhpcyBjYXNlPyBNeSBwcmV2aW91cyBtZXRob2Qgd29ya3Mg
YmVjYXVzZQ0KPiBkcml2ZXIgbGFjayBvZiBnYy0+Z2V0X2RpcmVjdGlvbigpLg0KPiA+DQo+IA0K
PiBDYW4geW91IG1ha2UgdGhlIGRyaXZlciBkZWZhdWx0IGFsbCBsaW5lcyB0byBpbnB1dCB3aGVu
IHRoZSBkZXZpY2UgaXMgYmVpbmcNCj4gcmVnaXN0ZXJlZD8gUG9zc2libHkgYWxzbyByZXZlcnQg
dG8gaW5wdXQgd2hlbiB0aGUgbGluZSBpcyBiZWluZyBmcmVlZD8NCg0KWWVzLCB0aGlzIHNob3Vs
ZCBiZSBhIGJldHRlciBtZXRob2QsIEkgd2lsbCBoYXZlIGEgdHJ5Lg0KDQpUaGFua3MNCkhhaWJv
IENoZW4NCj4gDQo+IEJhcnRvc3oNCg==

