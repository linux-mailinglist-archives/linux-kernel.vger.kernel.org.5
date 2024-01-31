Return-Path: <linux-kernel+bounces-45743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958278434D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF9E1C22504
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9CE17570;
	Wed, 31 Jan 2024 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iEIHXKpu"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2012.outbound.protection.outlook.com [40.92.15.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF1816435;
	Wed, 31 Jan 2024 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706675247; cv=fail; b=BC0SE0GePGTmQbQVV/Ehv1NKS7d5IWPEoXLaixcDf5o3KcOrC7OfWEvtanTKwlF1K82Jup7z4dvvI0Q8IcQ9m7LFsFEF/V5ATlUDkWql16FW8Md85EXA9b+SCWY3oiyj7kFsZxRkgrtEUeRW7PfOVaXscEby/BjSCTVlB1YsvAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706675247; c=relaxed/simple;
	bh=fUq63NdDabv+5OZ2KkP5PMdLgULgNHcXvZSlX9Kfx/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a7B5aSuWJir96Sz+j2Sd3dcY/LfcHs2xxLppw22IaIZG4eXlkNaKTz/q2AhQJ38M1aCuVbhGfAK3L6bjnPBndIxY+UYhcDFB+t1NUPPyCsXyhs4OF6/3mEZh9+RGvQuP7eIq5bWv6aayd9HYsBxAKwUTByea2OHgam2Xi7NfM1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iEIHXKpu; arc=fail smtp.client-ip=40.92.15.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k53LH6J+8Pqc1MYF4Igqf7YpJQJI5+G6xj+5jwY20Vr0UJQcZDCepMjq9qkvdUsjyKD4aGwZwHwFHgR12lK1B5Urcurh5GXcEG0T9rx+gcCmZgNAOSxwrtxbbU/Cqepn6zvgNLxB1O/w5XozY5rCSrevgIlBhPiaOaxBE+QcD+Qsv+60yTW8VuJRpkV6Yegi6efhmsfkvTJKywSL80NdTDPVIfgJGYD1dOKmp6xL6t2b8DX9X2NdDiltSIv8KZDBVtwsKyIW7ax2FQpzTBlXfTLmW9+yyIC7bc1y6jQl/4w5z8aaUCbX0861ttq6nnWtUlLLvt85hudFkHyLZIL73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUq63NdDabv+5OZ2KkP5PMdLgULgNHcXvZSlX9Kfx/4=;
 b=GyHuEh7yg8vxnqd5T2V/3GCRugeqYY3D3VfhG60TGvSgrL/VXBtB9yN/1xDFg6vFm+tg+CiAtjUQt3TuwHrDGn5iGEhyDGIjUS8D0OlJrRQ4fN0jD3u4PcwiWnupndZtSeEXtUxcI8Gj4ur6L8cQWQBlCENsITFp2ZxpjIQWiELBUSsct/ys+VXzOp+zEfQKM26ejxf0nWUfNPB619R6IOEf6l5ho3s67Gzx1WoU9ALL5B4RSaOoXUMVIv0togh9Frv1zpFCOpA/KBp5asOGZPYKwPWBzzbgfID1UZOVtVeHbIrIvp0a2ami/Q9RnfmdyiUrDRIGdrs132rtqrpxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUq63NdDabv+5OZ2KkP5PMdLgULgNHcXvZSlX9Kfx/4=;
 b=iEIHXKpusv974WJLw8BN8rqg3K2puLoJUkDVe3mcPG933li98cGZ5wZfiWtZ9wMJCsGlLsw2QNdh6ulNXqLcsQOKKmU/P60nl/8T90CYEjb1Ml4xyNpdCZwmb/m+hF3LpfffaI8s+ht2NuL8ZOP4fbsrrGFEShf/R83iyQHlCTWCX0jU+RQDgbKFIc3OSjM5GWqjoiEvrT8JWfEwGk3y3pLsU4L8Z+XL+0Fj0EkUnKKN10mF7WyRaPocRtpVacEfGh6S2ipcmj95ET30xcgILyi24pFmbxMACjg2hrV4us9jRzOva48yWAJrjWpCGF7UaOrQx/6PbmOFDb/0h/SB8w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB5663.namprd20.prod.outlook.com (2603:10b6:8:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Wed, 31 Jan
 2024 04:27:24 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7228.036; Wed, 31 Jan 2024
 04:27:23 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 2/4] clk: sophgo: Add CV1800/SG2000 series clock controller driver
Date: Wed, 31 Jan 2024 12:27:21 +0800
Message-ID:
 <IA1PR20MB4953D6A4BBFD5BC20397BC6DBB7C2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49532B54FE5A2A5B79B2B530BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49532B54FE5A2A5B79B2B530BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [EH7USrChPJnZzNS8ufMNXWg4bxx2xYSGD88zh5JZFxlv7E22MLki7TZ5X0P4lZbG]
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240131042722.391137-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afc81ea-cd20-4aa1-d4be-08dc2214ec02
X-MS-Exchange-SLBlob-MailProps:
	rYPt1fhvLTV0r6TllvNB5XnTXj1A0OUyedcpiRcIjIEq9fRzGxLf+ATQWQh/txafzUclW97KVcwLsz5uM7e1HYfzqnQ9lFEHT4j90b5FsFz4/4HDFv+7mwzCVXZA7n57cmBUdAO3RVhq5/QrBcydZEr0vzbVWnaJPqUxumoddPLfof6mzo9Mh2N7/X/vkjV69Zh/2U2dLz5hiP6eVnl4jtwQbBhrmaMXCmS8PdCk5dfekbQG0QA9Ry/rIdkHqpHSi0hq4vcrPWISaGToij46PAKRSfRQWrZ/FAftjyyfQWMqpOwvT052Uly0J3AY21rRR4Bh/sxDf/BzEmHCW9EHW+KLyXCVCKbiTUcHbk2njy9+42MG6+Z55C8JizvqPdvKpsUTR4Qbb776gKBpKSGimY66VDmMf61ZDR0BLOGaTRRdZqMzUMjPtMVevNYbTSjyNjPOtz+gAAk348Ee7y3/KxTL9rVn4EvI0b2C8qWgz3Doac+ub1+RwialjAAP9vrJZptLCHTzOSaDHRELOZn3S9mufNpjYjtD+OuKDjbFMTRy55tel04mMLJYYqyhwgQLzBkZ2xMSMx/TulhATRpOYdNvb4EBLxL4N1B4Cew+Fx0hPdMKqWVx7iRmHWO8VDkV5bVJrmySMVtJhKHJ9r2wUhJpGgXtPKtV0yUs9ATsYeyGFskKgatD7CNkLFBtBRPvSiSM82dvppRZs70XAUCEYA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Un6azTDigYtJ+N/XP1HEXOZlKPndri+w4a+cj/Zvnrj3bk5Et4SClZPDOIm+rR6TP/yGKjxsxA/6zZg2t/oj/DNyBOVBxq2rG0pz5wM6EBrF8odCXaWjBzbfPSTnW7vMiUxV3KZ20pXXXDA3dVHe+MovrnFBXj1dfB1jI3euqvHO/tu2L+utjON3xIbhfIYHXTZPnq5Ol6TGUqFJ0RKx6StByUYnmP6wJWGiQ2biO2s9TshEHQDqflj7NwJyt0TWuY2i5xLmnoLHHfi0kmXanAZQWrAw5G0Qv5a1wb+zrftHVEoZGnAqmbzQ/OFB4d03+Y6oWuXqoXnqOi8/hX0qdHFLXZoiStvNt3hutV2U44cgM30HWD0OGiBe4X04qqzTWEgNdifdpDCqXjLjeMtQlYdjZiy62hzACanFKKgb1mUs3z5VVjSOoaI6GYuLcuRXQ8o11jCdpQIzO50LXwJ+WSDX2wUx7bV6emmAIc8XuuG8t0Y99w3ZEL2CxVkSw4I/1Gmykc6U5SEEIMGcwj8YPXxgh2JW0AeViAkhIG0Z2bKbci+8gJAb0G7tiZJJMz6kKgSYRnyaMMiqdlRCwSjojWBe+Zi7C63fFar/o8faL0OwRWkmocBtMI83iTH+Xx0k
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FxDZ9oL9pDK8h6U19x8RKRXLAy7CLMFoEnukd8j1m9VNJvMsYEVoAsOd4maL?=
 =?us-ascii?Q?BG8q41xW1fX+x3kuaR+NiS9lJ9FVUvYW0AmHJPaznHfBcWQzoMGYkQszJjOp?=
 =?us-ascii?Q?mPpOygi5iZ1qSl6S8w+ZHXjSji/xU3LgEbHDt1XYFVcN/e8R5v4yV5b/P0I3?=
 =?us-ascii?Q?BbNWUyRU3KnGi6/tcsuwIGLjbIBo2oLrQsmvQejK9NkQe30Rr5ppnpNbSzTE?=
 =?us-ascii?Q?1P0iXVtLvB9izWsj0Ra10hvz7C62vsrQL0olzo5doZye3I8ncWXT1wOFBW8N?=
 =?us-ascii?Q?6sygzbtL7MoEJJTciOKia2vVMGxypmoC4cR8FxGVkgOKue1mxvGJDNppQskk?=
 =?us-ascii?Q?bjzJKXOyFEK52Y06dnmhHbUsGrxtrRnceIpKhLX7+4lCmnX24k3LM2sg7CHI?=
 =?us-ascii?Q?jMueCN6Uvg0Av4rN0Q8lUFJ6+VjGRH2tr+ZnTR5tM5YikRfhILKTTcSIz35/?=
 =?us-ascii?Q?DxEcjG7I+UQlwypMXQm7zvEaaBXBuptsHv5Rq1e0vUKxkfKKIgfa0CAQ5Lh2?=
 =?us-ascii?Q?lRFC6Qqe/mbEyAltW0Y7lTwap140XVYBNaYQ0FH86813i0CXN3mqTODlDm9v?=
 =?us-ascii?Q?XbZkv4nhSAJw5p6t5UrvUTgXu2O6zKrU8Z7KBPftckJ8K3ItgyNvm7PDMLvx?=
 =?us-ascii?Q?uJVVPQDTx9kzayXKEJtpuzcrtYZjQrhX6tfS1OwVyzLLlnvvwJRxwQVHR3A9?=
 =?us-ascii?Q?74+WIY87M+8s/vicuYYSbvUfy/MBaVheTSmWPSgimoWZpunK7XtgYRIadvpA?=
 =?us-ascii?Q?nRG72sbZO74EU06WSNTK3991vwQKg5aJgphS01mchnVDGKtasUAoXC9gx4ot?=
 =?us-ascii?Q?g5bOKwSOP6U+In+svjt3/O6Bsqo+w1OSu6hmmupXazt5Sgz106yjPNKzUhiD?=
 =?us-ascii?Q?vX0pq2Kz9tA9ztQdWF7Ku+RFSmjXAdzcszeqUh52PpsHMPjmBDOy4ZGh1Fia?=
 =?us-ascii?Q?sZF0cRwiSNryWv17XqLBrjs6Yt6I+QwQtFd+D+pYAlPRHEmZMD+ePSfK2WWg?=
 =?us-ascii?Q?S09oGlq2KIYYocEs9qTyd+YVjLF/KjpLsmxE22nT4rkaF9iDLD5gk+mvGcgb?=
 =?us-ascii?Q?OfFQ7VW5GKT5QTu0WM2RnHAz3wFVqm3HhWMFaAyMyQ2iZde4dAaJB50q3WEQ?=
 =?us-ascii?Q?mgWpodHjP9bMXEaReAOzzXA5UP3aO4zxm8JOVC3LqRmkGqzuIqRYyJjTEXeh?=
 =?us-ascii?Q?zzI/0l/UXSLWsh7EWNKfUJVi4+XMNFk9McyoWGLeZXHMUycWgx4ah956T5mn?=
 =?us-ascii?Q?JJJZ8hBgXXvr5YTSF+K/9ysMIJK1m3/Vy5SXI0pzKA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afc81ea-cd20-4aa1-d4be-08dc2214ec02
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 04:27:23.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB5663

Hi Stephen,

Could you share some comments on this patch?
It has already been evolved month ago.

Regards,
Inochi

