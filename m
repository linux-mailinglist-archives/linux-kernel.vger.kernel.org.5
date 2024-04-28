Return-Path: <linux-kernel+bounces-161390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C348B4B6F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B011F21E32
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49C54FA5;
	Sun, 28 Apr 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2MQeKnjX"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB728F4;
	Sun, 28 Apr 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714301996; cv=fail; b=DKji/V/zxBMc4LvFklU8jDp1ZC0QXGqnTf9BNUnaxgDNoMqy2nvmKDDZHzMYxJ6At4tgl1NNmUF35+WrSRwU5e4CFs7gWA1e8tMl+Rlb42oLBLXnuD7nlu49Q4IoXvgA7QD2Us7/SrtvbZdXqUoVfGtRiMijPVlR9wt1Lz6jJjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714301996; c=relaxed/simple;
	bh=WcTQulUc7DsAtZBfXbLdMF3MlJ6c0BrmcuE5h6/t2xc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G7VSqh/x0DAiOUbW2+n1aaxKClP+iMNqCw/UgL9SUTz1919/KecuJD6uiX+6hYIe2TB9s61VEUMJB/K/v4iZO7C1Va232Daw63/OPjyA6gF4DPwNsZ0MD2nxELNDwIWDf1dWQvSsIuHNxUlAPITdazjTr31Ij5RGc7zB5SgwC1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2MQeKnjX; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTxPa1JU89vanl+3RNOlDca5yd7dOMPhAj7CiTprO6iNwZkmglYsk6odAHJxz+a1KCvNLLWSQlX/+9qQA6HjOn11OZy2/NCfb6yTBHWz4mSq2Mt5FxGkY51wBD8nPnRcNxp+Pzj8aP7WRyKwrJxn3T5deb6PT8+wo8yWzg8kGpuivxEwNBR6LF8qg/f+aD+yHh3hS7gxBLCJeT0OJ3jx4gBkKE15tBUW8T4zTZOEpjL61AeEfVfmlzmh1qpHfxWiFYjURC7TbcC6Fi26dshEPY/DIF7wtrb5sDEmGVwNGndV7sc9Qub2V0L0JOLmlIfNDRR586iSubod1D7CCtZSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcTQulUc7DsAtZBfXbLdMF3MlJ6c0BrmcuE5h6/t2xc=;
 b=nmdsKwU1byEiSVOV6OnIVvjuPU0Sq5EcKaNF0Ba363s29qIkrLF2Yb0kdgUQeVhWZ11KwnUVa0DbOtAFOMa7DO5VBrxa4vbwvGNN4NDQgvBHhoDY4Y883V42kwP7yf3q4Cwwj3BFgUHyswhYWVpLrBSC/36K3yxTY8jdUmwgV/4E3nRvlX/NEYksvE3vcYg4phPqH23DUmic+kGAaayNT4eFzP/OlJMS/jK4lgAvGiveLXolkc2fGfbNivN7OUKCvGteIofko0t4eqTrISZ3fp175jd3a7qUQi8awaMKq5sp18uZBFQeWziW0rFfepRPtAYN+gw0TwGKYaKj5Eb/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcTQulUc7DsAtZBfXbLdMF3MlJ6c0BrmcuE5h6/t2xc=;
 b=2MQeKnjXM87qGhHaB39grLGiPyEADNqY8zltsS4kyqk6JqXqTzCwhWNtTfYG6e+7d3pQFk+qB+1Yx5Ktx1n3EcdrpDnLF3kIRDp++pg88iOZaNz+e3aGo6OlzRM42dWIg7Ff4ewJB3R7gFOMZ9yF/s5kIUNjJ8OZ8HVsnzdABXM=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 10:59:51 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::1f7e:5129:cd0d:585d]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::1f7e:5129:cd0d:585d%3]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 10:59:50 +0000
From: "Du, Xiaojian" <Xiaojian.Du@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Yuan, Perry"
	<Perry.Yuan@amd.com>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Thread-Topic: [PATCH 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Thread-Index: AQHamUwezGRESRKTs0ajTFe3DLXdArF9cW+AgAARTuA=
Date: Sun, 28 Apr 2024 10:59:50 +0000
Message-ID:
 <DM4PR12MB5136052EA0F1930B49F91BBCF1142@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <20240428091133.592333-1-Xiaojian.Du@amd.com>
 <20240428095409.GAZi4cwYxRwQGW_WFq@fat_crate.local>
In-Reply-To: <20240428095409.GAZi4cwYxRwQGW_WFq@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f58f43c4-65f9-46aa-91fd-a7451098a062;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T10:56:05Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5136:EE_|PH7PR12MB5998:EE_
x-ms-office365-filtering-correlation-id: 2cba3af5-2337-4b8d-f819-08dc677253a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?clA2Uys2T2VpOUVCa1czSjVQTVpYeTJQL1dNQVlXYmJ0MGdSbW9Sckpwemhl?=
 =?utf-8?B?Y0VSb3hSWktqcFliZitHQkZ2em1rTFlGKzAxSHJCdThsQ0dkY1JWNGZ2QXJX?=
 =?utf-8?B?VTZMd2NQVkdTSlVOazZRUUJPWE1NYlpDRTVwQ2NUdUZVZnd3T1BDdmRMUWpO?=
 =?utf-8?B?QzV5aHdUVm54N3JaNzY5cFp2b21HNWVzMTA1em0vQk1jcC9oYTdDT0dteE0x?=
 =?utf-8?B?TXFUR2lkNXZnNG5mOGx1WFp2V0dsNzlzQlE5QVpZaE5hWGdhSEJiMVkxVjNT?=
 =?utf-8?B?K1dJWXRSdWNIVmZDYlNwT2ZHem1HUlVNVTdxZ3o3aWdDS0dGMldxbmwyZEVl?=
 =?utf-8?B?QStVYzIrRFF1THBFem9rV0VIQktxNmU2V1RMQVdDSngrazk3YWhobXc5VzJk?=
 =?utf-8?B?MGl0M0Q3c3QrZjh6RTR4ZWUwaXVQWGU5bEhjRFI0Zmg5OVNaMVFCOElJT0Ji?=
 =?utf-8?B?bmJQNDk0aEpsV3l4VTk2anZzRnI5QWFnNERKMlVISEVWdkRRRFdWL2VtcTZW?=
 =?utf-8?B?NENrQ0FWTW5XOFk5UWhwTFRJb0FXVENRMGV1MU1Gcjg5aFh5NWNSREVjTDJX?=
 =?utf-8?B?Sm5Gc1VjeGdNWlltd2pGZUdocW1XOHF5dXV4NXBWRGtXbGhkblVhRjN3OWdF?=
 =?utf-8?B?b2JMNHZmVGZnRTNYYkNuQ1p4aUhLWGtZcGNxbDRrZjFFN0ZWNUx5R2dYVWdL?=
 =?utf-8?B?Sk9NYm4rVjBiaTdpQURvd1puNUk5QjRncEhJVmFWSlZ4MllKMUFmRGFTalNr?=
 =?utf-8?B?bE5TTmpOVFNjVnZBZ3pBK1dqeGY4UWY1eFZNTlhTcDVvclJUWUdMK2dhREgv?=
 =?utf-8?B?dFB5WllRZnRXTTR6bHRBVWpxbyt6eWtCcjdGbDVtQjYrVXNaK0xQU0c4NWFp?=
 =?utf-8?B?U1gzUGlQa1B2eDdSNEtiMVk0YStVOUdFVnNRVUhiYzlaL2dxZ2owcmkxUUVK?=
 =?utf-8?B?b0V3U01RZFF1aG1nUmpnUUxkZEpGVjlSY2pOaUd1bEVSYjFOcEVGUFBIRWcv?=
 =?utf-8?B?OVNtdjFVWHoxdmVOb3Zmc1JBVDByUFk4RUJDRWVqditMSS9RTGlVU3lLdzRR?=
 =?utf-8?B?YWpOTVVVaElIRTBUcmdEMDlkNFc2RnZjRjFrQVZOYXNVOWk0cmF4WXI0NFRO?=
 =?utf-8?B?OFJUaFEvSCtPU1FxWEU2QlorQnNxazMvT2NlaERXR1dha2l3UXNEQmE4L21s?=
 =?utf-8?B?RXpVdFQ5aE94YnU1M21GVEt5bDZyenpGcVI4QXJKNmZ1bm9UM09SMHBSc0JD?=
 =?utf-8?B?aW4zZzdFa1VlTXBlU25GbUhhaGhJNUJ1TkQ1WWZLbXYvR0dFc1RrM2drbW5U?=
 =?utf-8?B?RVZObjhmVWdYMThMTktpVEIwU2ZYOTRpSWp2VDMwektkVitqeUhidUxRYWRu?=
 =?utf-8?B?MDJCbEp5ZUVwZDVJS1MyNlhtek1SY1FtMzh6cmVhY1dCYXkvTENUaHJNZnpI?=
 =?utf-8?B?SmluRTRkWG9pZkFUV25jMWpTNm45QjZxUzNtYWF1bFN1TjhvSmsyMDNBN25y?=
 =?utf-8?B?eWtxdzluZmdRbmpRWlV1ZmlHaVhaRGcrb3dKSmVBVFp4blhMcVhMc3I1Z2xX?=
 =?utf-8?B?RVpkbGpDY0xXWWdmSzdKL3FrM2VWWm9HRU1Hc2JwSnRya2VCRHJtOVVCUUJZ?=
 =?utf-8?B?VEh3VXE5TzhMZTJsNFpOK1BkcmpRYytxK2xlY2FCNUVSZVFieUdlQlZQMWhW?=
 =?utf-8?B?THlhU1pYb1RlOXZrVVF0UFNCUFhCbTVRSEtIQ2JId0NZbzBiRXE3cXR4dHpT?=
 =?utf-8?B?U3BuRlRCL0xZZ1ZhamU1c3ZHbUROb2JPYld6TGtDV1RiR2QySmhqbmpZcEdU?=
 =?utf-8?B?RzJEQlk0eGt5TzdPWkNqdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWsrK0pCRlRIM1lWMGxmKzhhc0o0K3ZTQXZNL1g2STFQellUeVZrNzkzT2hx?=
 =?utf-8?B?TnJtSHZuZTJGN3hPamxwM0xENWxnZHIrQmFCcURYYnp2bDV2eU1Lbmh3SmV4?=
 =?utf-8?B?OXoxYk03ZmIyYnBEempqZUhnQXZuR2tZSzdpUC9vV3ZmWUlnOXJxTisrRUF4?=
 =?utf-8?B?N2ljR04yUmd1YytsU1pqT3p5akovaXBpckJYVGFYSXo1NmNhZHJjYmlVU1lM?=
 =?utf-8?B?R1gwSmV1dERpNm02a0gxbWhGTk9WT1cyeGtWL3NLWU5udFpmbkkrMDVOZDBY?=
 =?utf-8?B?QkRqR1UyQk1nNXJQc0M2S01GUFJCRG5mVjBPKytkVlh1VVBiQXR1L0dYWkR4?=
 =?utf-8?B?ZmJFTTBxUkRXVWsrNGlLR1ZSMlNSUW5UdlI3a21YeG5ja3cxN2ZMd3g0a0lm?=
 =?utf-8?B?VlFuQmF4TkI0RzViUWtBbytPeVoxdjN5TkRuYjBSZ1VYV2pWQWRJWUJCdkkr?=
 =?utf-8?B?NUxLdmxPWjIxeXVWRzlkZ0taWm9oekFhY1hldEp6cFRORjN4dlNJNml2RTQ4?=
 =?utf-8?B?ZWx2UUpnNDFYZ0RXQ3N5YTZ5TWd4V0tuemlCY2luNXkxR2c2L3llRlIwRVhm?=
 =?utf-8?B?RUlFUEtjT0F4cnNUbEpYQ2FJY1NxWUhIYnRCQnhCSWFCQ3NmQkl3d3l3eUYv?=
 =?utf-8?B?eDI4cml3b0hER1p0cXZFUkx0Q3lkY3VOazFqUUM1SFBBVEFXK25iZWQ1di8x?=
 =?utf-8?B?TG9ZTzA0T0IzVVl2U0MwSnI0ZkZObWRNYU5majlaRFkzS3R3QUNYNGlpMTRr?=
 =?utf-8?B?NnRYTGRrKy8yTitrSUNVcHRlUXYxYldtRjBvK3BPQXVyWko2L2xCcGVKaHpU?=
 =?utf-8?B?RnFrc2I1aFpMa0pLTzRFclpRdU1Fc3FZeHpZelZwM291alQ1aCtFak1sazlz?=
 =?utf-8?B?RFhvNFBuby9BRVdhR25sYm1qTmJxQkpKc1RNTnVCYTdaWEYxOGR5MXFDY3FL?=
 =?utf-8?B?ZnJHSTFaYVU5SU9ROHFTcFVKWlB4M1dIbU1taXRlTExGZXhRcEprSVBaaDFi?=
 =?utf-8?B?VXA1WEFCWGpTY3YzMy9oUEhDdTlWbS93eFAvRk43L3k3L2YwTmFyK1hVZEtR?=
 =?utf-8?B?blV0RUdzdkg4N1ZuTlVvMFhXZlgvM1Q2MXN0UlBTK2xHcGZkUXdDVHVBTG0w?=
 =?utf-8?B?TUxjTE5rSkdyMzVzMTBJNnJxZHc4WW13bG5jRUJwRjUvb3EwMHYreXFWM3Rv?=
 =?utf-8?B?MHBDZVpKYzRoVjBlNVRmU0QvNzJzWXdKSGZQczNXQXhUOVBvTU1RTHZ0bGFD?=
 =?utf-8?B?S2ZQNDkxVlFhL2RiMmc0TkFBZG9WL1JTSjNOVGN3b04zemovYnl1eldYMU1Q?=
 =?utf-8?B?Y21UU3MvZjVkM0daNjMxM0FLbUoyVGIxOEVLZjRsYktJRnlxdGhFVzBtajJy?=
 =?utf-8?B?S3NNOE83Qkh4U1UrRHYvNmRzSG53TkxaTVZEaWdTQVRPVTM5dWpSMlZza1lT?=
 =?utf-8?B?UVQ1NEZUUkE2enVISkd4UVVsVGgwbVFLUGI2a0YvQlRFTUlhSExWZG5NMkNQ?=
 =?utf-8?B?Uk9TL3RCSzhQaTd1dkdVWmUyNk15b2tVWXkvZERqVWVKZXhBVWYyTGMyM0ZV?=
 =?utf-8?B?cjZHOHVoOHRlYkhSaEgzbllCNnFhZ3Fva3pMbzhlOXg2aVNUYkF2cjhPd3p2?=
 =?utf-8?B?MmJFbHRsVGhGbjlodnBwZXlvQ1g3akF5akRzbitRUnJCelNtaEFtUU9kY0Jx?=
 =?utf-8?B?QnoyeVdEV1o2NWZEVmhKS25Va3FBVW1iSTBJQy9QS2paM2dtQkdHQnUxYklH?=
 =?utf-8?B?Y1RrdUdqRjlXSlVmY3B6bmdoaXRnSnVuRHdlZjlSYTg0cmU1RERhTlBvUG44?=
 =?utf-8?B?aTBFaDBHK1FQYllBbHdTcFdWTUJpZms2ZEhGS1dDb3QvOVNpNVVoYzNBOXF1?=
 =?utf-8?B?c1c4TlFkMkhyUXorSy8xYm1TOW5zS25WWjgyRWg3WjhLeS9SclJFNmc5YnZh?=
 =?utf-8?B?Y0pNekhxWG9CR1N0UWg0cm54cEExcTlwS0MvZG1GamNmK1JVbng5TXdnNzlF?=
 =?utf-8?B?czBSWUNaUXBQMzJUQmtxMnJpeTMzSkgxaVVtbTF5MWM1V0NMSk82VWtTaVpE?=
 =?utf-8?B?TzZDd1JadzY3aTV1ZmQxY1AwdjBEdUtPeW5mbU54enV2K002YlF5QUR6Mnd0?=
 =?utf-8?Q?rPnM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cba3af5-2337-4b8d-f819-08dc677253a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 10:59:50.6975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2FYu3HKpqVEI2r7BXzqttvh6inDt7WVkbi68fZIZt8guK5vpypF65kburdfevFRf0tJKcrVmuDh7CtK1u+wL4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBhIGxvdCBmb3IgcmV2
aWV3LCBJIHdpbGwgbW9kaWZ5IGJlZm9yZSBzdWJtaXR0aW5nLg0KDQpYaWFvamlhbg0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjgu
ZGU+DQpTZW50OiBTdW5kYXksIEFwcmlsIDI4LCAyMDI0IDU6NTQgUE0NClRvOiBEdSwgWGlhb2pp
YW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+DQpDYzogbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBT
aGVub3ksIEdhdXRoYW0gUmFuamFsIDxnYXV0aGFtLnNoZW5veUBhbWQuY29tPjsgTGltb25jaWVs
bG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgSHVhbmcsIFJheSA8UmF5Lkh1
YW5nQGFtZC5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgbGttbCA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSB4ODYv
Y3B1ZmVhdHVyZXM6IEFkZCBBTUQgRkFTVCBDUFBDIGZlYXR1cmUgZmxhZw0KDQorIGxrbWwNCg0K
T24gU3VuLCBBcHIgMjgsIDIwMjQgYXQgMDU6MTE6MzJQTSArMDgwMCwgWGlhb2ppYW4gRHUgd3Jv
dGU6DQo+IEZyb206IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4NCj4gU29tZSBB
TUQgWmVuIDQgcHJvY2Vzc29ycyBzdXBwb3J0IGEgbmV3IGZlYXR1cmUgRkFTVCBDUFBDIHdoaWNo
IGFsbG93cw0KPiBmb3IgYSBmYXN0ZXIgQ1BQQyBsb29wIGR1ZSB0byBpbnRlcm5hbCBhcmNoaXRl
Y3R1YWwgZW5oYW5jZW1lbnRzLiBUaGUNCj4gZ29hbCBvZiB0aGlzIGZhc3RlciBsb29wIGlzIGhp
Z2hlciBwZXJmb3JtYW5jZSBhdCB0aGUgc2FtZSBwb3dlcg0KPiBjb25zdW1wdGlvbi4NCj4NCj4g
UmVmZXJlbmNlOg0KPiBQYWdlIDk5IG9mIFBQUiBmb3IgQU1EIEZhbWlseSAxOWggTW9kZWwgNjFo
IHJldi5CMQ0KPiBodHRwczovL3d3dy5hbWQuY29tL2NvbnRlbnQvZGFtL2FtZC9lbi9kb2N1bWVu
dHMvcHJvY2Vzc29yLXRlY2gtZG9jcy9wDQo+IHJvZ3JhbW1lci1yZWZlcmVuY2VzLzU2NzEzLUIx
XzNfMDUuemlwDQoNClRoaXMgc2hvdWxkIHNheSAiU2VlIHRoZSBQUFIgZm9yIEFNRCBGYW1pbHkg
MTloIE1vZGVsIDYxaCByZXYuQjEsIGRvY0lEIDU2NzEzIiBzbyB0aGF0IHBlb3BsZSBjYW4gYWN0
dWFsbHkgZmluZCBpdC4NCg0KVGhlIFVSTHMgYXJlIGZsYWt5IGFuZCBjaGFuZ2UgcmVndWxhcmx5
IHNvIGNhbid0IHVzZSB0aGVtLg0KDQo+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5
Lnl1YW5AYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWGlhb2ppYW4gRHUgPFhpYW9qaWFuLkR1
QGFtZC5jb20+DQo+IC0tLQ0KPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaCB8
IDEgKw0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9zY2F0dGVyZWQuYyAgICB8IDEgKw0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KQWx3YXlzIHVzZSAuL3NjcmlwdHMvZ2V0
X21haW50YWluZXIucGwgd2hlbiBzZW5kaW5nIGEgcGF0Y2ggdG8ga25vdyB3aG8gdG8gQ2MuDQoN
CkFsc28sIGhhdmUgYSBsb29rIGF0IHRob3NlIHRvIGdldCBhbiBpZGVhIGhvdyB0aGUgcHJvY2Vz
cyB3b3JrczoNCg0KaHR0cHM6Ly9rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL2Rl
dmVsb3BtZW50LXByb2Nlc3MuaHRtbA0KaHR0cHM6Ly9rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVz
dC9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sDQoNCj4NCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmgNCj4gYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9jcHVmZWF0dXJlcy5oDQo+IGluZGV4IDNjNzQzNDMyOTY2MS4uNmMxMjhkNDYzYTE0IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlcy5oDQo+ICsrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmgNCj4gQEAgLTQ3MCw2ICs0NzAsNyBAQA0K
PiAgI2RlZmluZSBYODZfRkVBVFVSRV9CSElfQ1RSTCAgICAgICAgICgyMSozMisgMikgLyogIiIg
QkhJX0RJU19TIEhXIGNvbnRyb2wgYXZhaWxhYmxlICovDQo+ICAjZGVmaW5lIFg4Nl9GRUFUVVJF
X0NMRUFSX0JIQl9IVyAgICAgKDIxKjMyKyAzKSAvKiAiIiBCSElfRElTX1MgSFcgY29udHJvbCBl
bmFibGVkICovDQo+ICAjZGVmaW5lIFg4Nl9GRUFUVVJFX0NMRUFSX0JIQl9MT09QX09OX1ZNRVhJ
VCAoMjEqMzIrIDQpIC8qICIiIENsZWFyDQo+IGJyYW5jaCBoaXN0b3J5IGF0IHZtZXhpdCB1c2lu
ZyBTVyBsb29wICovDQo+ICsjZGVmaW5lIFg4Nl9GRUFUVVJFX0ZBU1RfQ1BQQyAgICAgICAgICAg
ICAgICAoMjEqMzIgKyA1KSAvKiAiIiBBTUQgRmFzdCBDUFBDICovDQo+DQo+ICAvKg0KPiAgICog
QlVHIHdvcmQocykNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2NhdHRlcmVk
LmMNCj4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NjYXR0ZXJlZC5jIGluZGV4IGFmNWFhMmM3NTRj
Mi4uOWMyNzNjMjMxZjU2DQo+IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Nj
YXR0ZXJlZC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2NhdHRlcmVkLmMNCj4gQEAg
LTUxLDYgKzUxLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjcHVpZF9iaXQgY3B1aWRfYml0c1td
ID0gew0KPiAgICAgICB7IFg4Nl9GRUFUVVJFX1BFUkZNT05fVjIsICAgICAgIENQVUlEX0VBWCwg
IDAsIDB4ODAwMDAwMjIsIDAgfSwNCj4gICAgICAgeyBYODZfRkVBVFVSRV9BTURfTEJSX1YyLCAg
ICAgICBDUFVJRF9FQVgsICAxLCAweDgwMDAwMDIyLCAwIH0sDQo+ICAgICAgIHsgWDg2X0ZFQVRV
UkVfQU1EX0xCUl9QTUNfRlJFRVpFLCAgICAgICBDUFVJRF9FQVgsICAyLCAweDgwMDAwMDIyLCAw
IH0sDQo+ICsgICAgIHsgWDg2X0ZFQVRVUkVfRkFTVF9DUFBDLCAgICAgICAgQ1BVSURfRURYLCAg
MTUsIDB4ODAwMDAwMDcsIDAgfSwNCj4gICAgICAgeyAwLCAwLCAwLCAwLCAwIH0NCj4gIH07DQo+
DQoNCldpdGggdGhlIGFib3ZlIGFkZHJlc3NlZDoNCg0KUmV2aWV3ZWQtYnk6IEJvcmlzbGF2IFBl
dGtvdiAoQU1EKSA8YnBAYWxpZW44LmRlPg0KDQotLQ0KUmVnYXJkcy9HcnVzcywNCiAgICBCb3Jp
cy4NCg0KaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0
dGUNCg==

