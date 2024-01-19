Return-Path: <linux-kernel+bounces-30854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE8832523
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BC61C22CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C33ADF71;
	Fri, 19 Jan 2024 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="bd3E60er"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA584A08;
	Fri, 19 Jan 2024 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650225; cv=fail; b=svcYKfBvqeOACA5P5Y9HtWeGp+T0O6DlxwkB0oKp/dduC1d/e+saUYluZi9jyNjUQP4IsHsv6DYSOCcyw5Rc4m21HuzN060/dEo4TLUWIHSFVaW8xHhFCckv2uV2dqlqBGMttA7UDqJcgNdrkLEUQcZPRW+fFjJL6HTXeyzSdMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650225; c=relaxed/simple;
	bh=80rPii2CNHUNi0Qc6SLc458eyGK2SKkrwI9+fKOL7/k=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=udRVcv7FqmY5cT95EGYR0EedQ2GmOU/19geceZoQQUYoC0sZyi4XUuvdTfzrGIrH7WQWQ9vnzL4RQQq8QjgHCMwOGQn7IhQCWer7hbk1ppehGyo46vntKgOglI/tqh89jWYHeUohrW6EhXC9t9wOZQv3R9XDSpfXo4WINmvnXls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=bd3E60er; arc=fail smtp.client-ip=40.107.14.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPQQOtJdc5SrtgHW2noehQCNT7dFySHu/SGpzc9U4GemlIg/PksOrl/JR9e5FGwjXfrrx3B0OR4Bj0iQWKCT9BaHOQHFo7pVIR8nfi4Y50vldCtdEx4wpxdJ+SFWJExgAu5Na74DIapMsYKNOHHtmEhgEpHTNbPJojKAHSh7RYE0nrDR2thi3CxZPJqBlIQy6AjZ4dOo7jeYMaj9s2AJXrDlHIOiY/JfW4pCCMEQX7iyF3k2oaiN7Jh0U3/i1yo/qsbEPlypcaFNsJDDxFfos6gh4QRto0LCi/U5zX0yZUjMcyewUtIyG1SmOEV4lXcy21nKoJhPklz4OrFr/7X2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LflALFhbXCz79W7FsSWTYhVb0+V9R39KMXmtSB0IQZY=;
 b=QFiz7qEtZOiGVRILdJ7EUXz4+n9n9zyU1d1Raei5hmXEU4ScoieEVZ5ba4VunWWmu8FSwi87mPHUuBT8ZgbBsSTZhMOcRqqPBaF2y4vlJyGpdthv/7U2V9AWdYbujIYxPMGCMC7PwOWdMKwNsTOzmUpe30wEQVk+vsUAKr65OKqFtvV1eR15SbgmZBi+1eFMiUFTF9SEmg4zx+7BVaGD9ng+AxESFsWO8x0izQOZakS1d0Ls9LAWV10R44w+4ZZN1NxgRieJ94r14XbtaJzTwEIp5Lg0iF4JVaiS/LVFGKfOvqJVRp4/XSw4fXFkfLMnOELoJoqHEQjhnhtXSluUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LflALFhbXCz79W7FsSWTYhVb0+V9R39KMXmtSB0IQZY=;
 b=bd3E60erQv4l2XLLJ0f/lnRPLJoCcU7dq1NxSO8iIe3cu/vTr+fyDhQzhVWG4eWQB3SIbCgOgan3x2NGPgqcZV35TupQcRXPgtHl9SxYpA5o6DCB7BGCqWyRCXKuNVxkuX/5FkIkmTrjcvZOpQv9KUrpP22W9T1Ox0fJtm5lKIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM8PR08MB6578.eurprd08.prod.outlook.com (2603:10a6:20b:36a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 07:43:39 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%6]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 07:43:39 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v7 0/4] Input: support overlay objects on touchscreens
Date: Fri, 19 Jan 2024 08:43:32 +0100
Message-Id: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACQoqmUC/43QQW7DIBAF0KtErEsEGIYkq96jqiIGDzVVZUeY0
 laR715Il/WC5QfNGz53tlKKtLLL4c4SlbjGZa7BPh2Yn9z8RjyONTMl1CCMFDyQy5+JeF6vJaa
 84Pv15rKfOCmwRgvnyGpWx9GtxDG52U8NKHDUPHnZrm6JQvx+bH15rXmKa17Sz+MRRbbTjn1Fc
 sGNI0MniV6Bfv5aPsJfg+NMmTW5qF5NVS3AyQEGsk6EXW3o1YaqoQ5og9fo0O5qulfTrakHL4K
 XRCPsaqZXM61pADRejwjnYVeDXg2qNtZvE+ZsjTT/tW3bfgE5Z1mCZgIAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>, 
 Jeff LaBundy <jeff@labundy.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705650218; l=4115;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=80rPii2CNHUNi0Qc6SLc458eyGK2SKkrwI9+fKOL7/k=;
 b=IwvpQHSovOZUdD5+zAPPj0vKG0CBmd92n+1pdEQvjfe8zumWyNq2+2HMg9RIVLEet1I+/RJWb
 AzzojtiRJ26D3yOTbMEe4Nbg9Mo/MIBnLXTOTKK9BU44mJ2ZfeMUiXI
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0102CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::29) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM8PR08MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 36192de0-7805-487a-36c7-08dc18c25a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tEKc66Arxf9yc+eLtV4/fwqXRxC/TLDQ40kZZzwFakd30lqPehp1OaoIBwJ6nk39phxHdW85XqOt/3ksgqe7vVVusDp+uTg5+R1t3I9ng70c0t+35rlEjhTERC1WU0r9veKCNk6hU+j7ImlLjQ5N+JAG2kHkKJJwv6e4/jb31VbgUZqAdyK8An6RIggLOigRYuKE/zQYQupc7ay6Gg0ae1RgRXhyjkAVIjlEelVIFpfgGobYSlnDUtS5eCyJ636PJNrey81ifV2suhrL6hHLJYI1tmTLvo5ZMcEX0YImbmvD9wfe780lAv8B7QSRPwxhwGXFzU1zMXBn14n1jJJbKL4ZOzr7ki81MpDO1gMhDtNU1PID1VejRzmwF037HknlaVLNe8NtnWl3IP8SKwGdeHG6XvzhAjhK4ckNpbje3t3AFKVLPvKNvBuOBkgXEhQUio76qb4DxcdXz9N9/Krw50ix75XiWJaO95RO9FSU/SslrnrGIK7Y+Rx5IjQbByflHhSdpm7AHSppWMptF59QlfecS6fwtHeYzBoohtAhDVSVpTYjg8dCnaaFOyvTYPEiJEnv7ZuLUBynHDnS/vDuNU3afwqMV6M84fZ4i7steGw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39850400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(54906003)(2906002)(7416002)(4326008)(5660300002)(41300700001)(86362001)(38100700002)(966005)(478600001)(6486002)(36756003)(83380400001)(2616005)(6666004)(6506007)(6512007)(26005)(52116002)(316002)(8936002)(8676002)(44832011)(38350700005)(110136005)(66946007)(66556008)(66476007)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0dTdUVJUHcvV0l6SzJ3eDI4M1Rnc3dNcFNaR0ZIZWNIOXJ2TllWM2w2NlBX?=
 =?utf-8?B?RkVjMEljK2FISGZmY2Q1amdHN0M2STdCeFBFSWhta0lWNHZLYk5BcElCQjk1?=
 =?utf-8?B?VE4vQjZmTjBnemZJTWQ2L1h3SVBOallzK1pQbXpSYWlkTDZsMGV4UUFzbmhL?=
 =?utf-8?B?OXMzWlhUcGdsdUVGMWN6WGtSR1Y1UVlNUFVFeExnQytncHFselgxZ1lHUmZ5?=
 =?utf-8?B?M0lBeHBjQkVlVUk0NlcyU1JhUWhLdzg5eXlTZjcwR0NaRlRTdnE5L0hMbitk?=
 =?utf-8?B?aHBGeTlqeGo1U1JiSGpqN2RmSkY0OHZNSzBvdkhpMzZwMTh4NDFSR1BYYldU?=
 =?utf-8?B?U3ZYOUdIU0lZTkUvb21kRkp2VGtHclFGdEFVbjRJRUtKTDRXS0FwNnYvQ2I2?=
 =?utf-8?B?UVZ0ZENtZFN6OHZTOENPbmUvKzI3UnV5WC91cEhrc08zWDhvQUdvaGtCN0Zo?=
 =?utf-8?B?MitmRk1YQlJkL2xUK1dQK2V5U3d6WTdyaFZFWCtadFhFTyttNk1QNjVOeG1T?=
 =?utf-8?B?U3RJQ21NVTZ2VnBqK2RtR3N6Q3RDWGVzOHVEVzd2QnNBb3h5WTBLaHN5OVBm?=
 =?utf-8?B?ZmVjWFNuN0x3djdYN0pIZlZmeU1PSUEwZlhodDJSS3lOMVJ2b2VKbzFCelQw?=
 =?utf-8?B?cW9HdXdlV2pSc3N3dlpvN0ZwbENxYmFnWHBTdWZLalo1bi91ckM4UC8xWFZz?=
 =?utf-8?B?RVZ1YzFHWkVsQ25hQUhiUWhoTTJpdy9KUEFVUTlNWExkUjlTNmxRYmtIZlBF?=
 =?utf-8?B?R0ozUU5xekNLQmpmU1hTcDg3bE94eUJwUE1NcXpUZGQyR29QdGNVVzRzWXNV?=
 =?utf-8?B?VFIxWEordWY1M3JjZHA0QnVyK2I2NHlEQTZkQ2Q3aVA3T1NnZGMvRUo0ckFS?=
 =?utf-8?B?a2hlc0pDNzF5UW5qY3FULyt3TVVjdXk3SHFmTDRQTFJscVNOY05QVHViY2VM?=
 =?utf-8?B?OURDdGRnKzloeGxsbUlOc0hGTlpCOVlYOEE1RkQrZU9rcHVKZ3IrSk1nMDNX?=
 =?utf-8?B?WDhORW1ObHgxSHJ0aHVnZjd6U0l6TWphWU42R0hNN3d5ZzhjM0Q1YU4rMmI4?=
 =?utf-8?B?WEl4WE1Hc3JqQkNGYlFkOU5ySHdiWnljUWpkWTZ2c3MySDMwaXJJY25hTzVG?=
 =?utf-8?B?S3RBN2lLR0pGTUUxL3hBOHRlcGlobFlmTGxBR2wwMW5LWWZPVkkxQW9JWXFU?=
 =?utf-8?B?VUNqQ3Y4aGQxRnlkUTdwQ2dvSFh1YksxcGt1OUtkeEJVdkdvZmh2NEw3Umo4?=
 =?utf-8?B?aklBajRkaWRVUUVjVUc1R3hyREd0dUJxT1JwczFKdnpoYTQ3aDBSYzRYWVlM?=
 =?utf-8?B?b1Nwd1llVjA2Qmc4cXUzYzVOakhvby9ram0wQkJuWDREenMwWGJhWEJtbjFu?=
 =?utf-8?B?QkYzYjlpREd2dU84Y2VtaHBhYnBrQW93SWJMOVZwR0wyS0J5UGpUSnNRdldU?=
 =?utf-8?B?Nm9US3pZK1Y3NkFackRORFpVYi9PTDNEV3IrNkkxTVEyZU1oeHhOd2lERVNk?=
 =?utf-8?B?YWZsRHMvK1NnWTVBVm5pNVdxcnZnSFlXdkxqSkZvNTFuUlp2RTFSVnRDOUZq?=
 =?utf-8?B?aHhlQXEwSmVqZ3QrWmFiVlY4ZVFOTTRqd1V5c0k4MEw0ZUFRMGY5a1hiR3U0?=
 =?utf-8?B?NTIzS3dKUFJFNVBkK2o5ZWZIRTdqeFo5bi9uUjNIM0hBZCtkSHdQdUdIclBP?=
 =?utf-8?B?c0NUclhiT3BsVEs4c1VubXVIOEI1ZFZ3YkhnK21PMU42U05rOStxZHRpTFh6?=
 =?utf-8?B?WjZPZExRNU5BNDhuWDBQZG5OOGpVTDREYTE1cDZRbDErdzdNaEZJZ3NhaUVs?=
 =?utf-8?B?QmtvNmxOdk0wVEdscWhDMVUwNWlNM2JHSWtVdUtaK2VqSkcwQWh2S1hTcVBB?=
 =?utf-8?B?a3ZWOGVxamNnVllWYjg0UzVZS2VZSDdkZHRXaDN5TzFlb1dYKzhWc3NyOHlM?=
 =?utf-8?B?Z3k2M0IxOFAyMXFOTytvem1vZ2k4blVSMGdaSVExYlRDTVRJS3dmZTE2Sjlp?=
 =?utf-8?B?WFJ2VzVjS1U1eFVNYk5UazlaZ1FQTDFGa0x1VGRWenZ3TXpCdUtnTGNjdUx2?=
 =?utf-8?B?RWhUc2VpTHd0THVFaXZkOXdSOHZlVitEcUY0bnBQWkhKT3NxSmdOYzZGYVVp?=
 =?utf-8?B?SVcwSkpZV3R6eTV0QzhxRnBYQUhTRDF0M2Q4bHN1MnhuVGtXNXZaOW1aSzEy?=
 =?utf-8?Q?JCebv1DwRQddB9d3VG9Erro=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 36192de0-7805-487a-36c7-08dc18c25a2a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 07:43:39.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09/dc11qbWyskhuZ0yrdbKirdSzQukAMP3x7GV4KPPmClKXE0+5cLp5jffVQf1afiHVkvuFpouD6iEQbp900sKILo99IzoOgnThpPxGT0Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6578

Some touchscreens are shipped with a physical layer on top of them where
a number of buttons and a resized touchscreen surface might be available.

In order to generate proper key events by overlay buttons and adjust the
touch events to a clipped surface, this series offers a documented,
device-tree-based solution by means of helper functions.
An implementation for a specific touchscreen driver is also included.

The functions in touch-overlay provide a simple workflow to acquire
physical objects from the device tree, map them into a list and generate
events according to the object descriptions.

This feature has been tested with a JT240MHQS-E3 display, which consists
of an st1624 as the base touchscreen and an overlay with two buttons and
a frame that clips its effective surface mounted on it.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v7:
- General: return to a single input device implementation.
- touchscreen bindings: segment instead of button in the label
  description.
- touch-overlay.c: define button-specific data inside segment struct.
- touch-overlay.c: remove fwnode_property_present() and check return
  value of fwnode_property_read_u32() in touch_overlay_get_segment().
- touch-overlay.c: simplify return path in touch_overlay_map().
- Link to v6: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net

Changes in v6:
- General: use a single list to manage a single type of object.
- General: swap patches to have bindings preceding the code.
- touch-overlay.c: minor code-sytle fixes.
- Link to v5: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net

Changes in v5:
- touchscreen bindings: move overlay common properties to a $def entry (Rob Herring)
- st1232 bindings: move overlays to the existing example instead of
  making a new one (Rob Herring) 
- Link to v4: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net

Changes in v4:
- General: rename "touchscreen" to "touch" to include other consumers.
- PATCH 1/4: move touch-overlay feature to input core.
- PATCH 1/4, 3/4: set key caps and report key events without consumer's
  intervention.
- PATCH 2/4: add missing 'required' field with the required properties.
- Link to v3: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net

Changes in v3:
- General: rename "virtobj" and "virtual" to "overlay"
- PATCH 1/4: Make feature bool instead of tristate (selected by
  supported touchscreens)
- Link to v2: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net

Changes in v2:
- PATCH 1/4: remove preprocessor directives (the module is selected by
  the drivers that support the feature). Typo in the commit message.
- PATCH 2/4: more detailed documentation. Images and examples were added.
- PATCH 3/4: select ts-virtobj automatically.
- Link to v1: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net

---
Javier Carrasco (4):
      dt-bindings: touchscreen: add touch-overlay property
      Input: touch-overlay - Add touchscreen overlay handling
      dt-bindings: input: touchscreen: st1232: add touch-overlay example
      Input: st1232 - add touch overlays handling

 .../input/touchscreen/sitronix,st1232.yaml         |  29 +++
 .../bindings/input/touchscreen/touchscreen.yaml    | 119 ++++++++++
 MAINTAINERS                                        |   7 +
 drivers/input/Makefile                             |   2 +-
 drivers/input/touch-overlay.c                      | 250 +++++++++++++++++++++
 drivers/input/touchscreen/st1232.c                 |  48 ++--
 include/linux/input/touch-overlay.h                |  22 ++
 7 files changed, 462 insertions(+), 15 deletions(-)
---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20230510-feature-ts_virtobj_patch-e267540aae74

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


