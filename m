Return-Path: <linux-kernel+bounces-153151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E438ACA40
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BA91C20E29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC513FD8C;
	Mon, 22 Apr 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="wNLZ4o8t"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2130.outbound.protection.outlook.com [40.107.22.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13B13E021;
	Mon, 22 Apr 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780473; cv=fail; b=iPLwM1qb+xgpqYlfrxMU5I2hCIO8lwOElIYmxe4PMKqR/lPfUshydaTBVEZNmhthpvY0mTLe4B6n4q56KR43F0b9gAu1GXH/a285piytcjVCwHoxA3QI4+QJ3BAbn++5HRAQ6WvC9PyPBHcn05wiUoy8cjV6YRCu12V1mslhlYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780473; c=relaxed/simple;
	bh=QN7FQA0Mrk3ueSx5uaFvLMxedIgNWxDjvIjBIP9Jc8o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Vaz7GQp96CTCnMBVBa0Mp6x7uXNXzYe34uoY4Ajv3nkzCY5GttcKf/fBKjttGvg08hHux2wgqSvrkp5Mq3lEGPOzIe0lBwktTwHyniwq498D6YeF/TGaeDZ3Hnet8sWSRjdvHOiDbpxqBLD3+iVSTRtED5tXfWapsQ6zx9oofds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=wNLZ4o8t; arc=fail smtp.client-ip=40.107.22.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRueilaxrTgjcm3pK5OcodbaliNtvwHMW9GxtMa6GdevkTXIw0MtDKNhO4ftT3WUmWblmV88sOlSVMILZCVe+ZcwvsKS/haCXHD925GT5zbCMGW4ZkIrqyL8wRdfZZer7cGzIup6nqmnghP+Ed7UJbmTBw7PYS6afl5tu2edK9AUtuIj9Ocf39cSxIrKYpSf/uJXKxJSHmctCeTkQtYnAa/G12Td8D90mm2emYa7x0zqLUsDyjoZC+2B9xS2+D/24SaWyVywQ49RGZmK2M9tK8LlMElRFocgR8gUOz/GEe3xmttFrE37B7YsRPxsTKP2GReGcbBsxJPVAuMiYsLCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRGBZxb5HWY1Hd8a6DnjerU8+6I4KbJy1lyTPsgbDlY=;
 b=XlPGGVfQGZIeLFpIVWgOs518ptLFCt5xk52g4k94NZduJsBPPAaOkOk7ds+4poRjOt8//CfaZkyTHBa8rK9XHwM+vohY0TlefQk/lKMpaQSJNNPKOPhwdrEV+8zZ6a7a8IKGgR6GfygT4ovb5aFPSAwC1lzb1hy5sk0rCA0vZJv2oU8Dl0ByGEexrT3ejlytG9KAuHxj+imEkZi1/w3x3BqozZhzoccXfsZz2LSAvPkiolfy0Bb1ZXMBtZhjvuICgB8UavavJZrG9H+p7NAK+uA56Gf3YfgxOnsCLahj76/Gga/kKZx6J+oFPPMBwS5knKIPJH6Ck2Sjcb19lo7KSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRGBZxb5HWY1Hd8a6DnjerU8+6I4KbJy1lyTPsgbDlY=;
 b=wNLZ4o8t6btfevFnIEs9uNuVHVHeTPt55uZTUTB43aKfxyQ9wqzn4FeYKjiRLZqJ08ELL2JzqU0RtYDRdLRFyILQlgFkfWJtjxM62F+QzOSfbxF3ngfYMVL+fn/jMxPH0CgHds8zfZ7z0As/eWW0dTMFIT7MYtjiUrHOaPQKgu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB7885.eurprd08.prod.outlook.com (2603:10a6:20b:508::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 10:07:45 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 10:07:45 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 22 Apr 2024 12:07:38 +0200
Subject: [PATCH v9 2/4] Input: touch-overlay - Add touchscreen overlay
 handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-feature-ts_virtobj_patch-v9-2-acf118d12a8a@wolfvision.net>
References: <20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net>
In-Reply-To: <20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Jeff LaBundy <jeff@labundy.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713780463; l=10914;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=QN7FQA0Mrk3ueSx5uaFvLMxedIgNWxDjvIjBIP9Jc8o=;
 b=GvRLG4J01whX6SzbRf7+dMUnIcFjy3M3vUtJ+XIWvTRh1SPzoNCA5Fd3tnskCGHh26JEGgjnI
 zmFo2/vWq0BAycxVg9MgeOJioaY18BhkXis2JZ2KYdaA1EVzASt8H03
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR0502CA0004.eurprd05.prod.outlook.com
 (2603:10a6:803:1::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 04118b2f-6482-41ed-3738-08dc62b40dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXRzQTI3b2NpZXhMZmJoTjFqTE1kSUU0TldnNnJlQlhSVnp1TmZxNXdxV2dW?=
 =?utf-8?B?cnZkUmVzUE1OS1laZnMyQkVhM245SmNLQkM2QWtRZ2V3dmhtcE1XZ1Y3V2w3?=
 =?utf-8?B?SmwxRjRURFNjVnZIS2NicHM0bi8zUFZkSGxLRWFHMWtwcmRvalJiWmRlY0wv?=
 =?utf-8?B?SUE0S0tjWldtSmxUZlR6dHBKSFJmcG9NbjF6ZzJLUC9LZG03cE9uS0ordWZj?=
 =?utf-8?B?RzNUQ1J2QVhMd2hYWWFjOUdmbDE4Nk94T2tsWCsyeStQUm14aGx3eHFUNmh5?=
 =?utf-8?B?MmdGZkFhQkNrbndtZ3lrWGdSMGxwY243ODJrQ01ENGVzTlNCamF3ZFlBZ2Vo?=
 =?utf-8?B?U3lPSTV2eWpmSXhBNXEycFgxa092cURWZGVMenVta3R2UGlLVVFCOFIvbXR5?=
 =?utf-8?B?VGxRYzA0UUN0ek9oMi9iblUxUTdWWHZDOXJib1NxTWt1eUw1MW5lYVpiTkYx?=
 =?utf-8?B?ZWhDdkdUSGJtZ3QwSDZtTUZmUGFZS2ptMHl3enJKMkdMUUpuTnp2a2JJWkR0?=
 =?utf-8?B?RjczK1JkVURuMGYvMWVTc00xQ1pDWGRTZG5Ud3l6RnNyNGJpZDVqbDhHQUtk?=
 =?utf-8?B?TmxraDVCeUx3WnRyNFdraXVLSzllem5mblpoSjdtN2UraEFlNjFzNnhTRDMx?=
 =?utf-8?B?Zk9FZ0R4ZWR5cHBEclNmZzEzK09ocFlqNmIzS2N6M3VETUpaaUhQb21MbUpH?=
 =?utf-8?B?bkRaYU5pMjNRZytUUXdieSt1T1htdTBBNmxNSlJZNURrRHdzSkJJOFVkWEFp?=
 =?utf-8?B?UDFEQkpRSlk1b3ZUYnRGUUxaRWlWUk95dk5ycWZhZVcweGZHdThsSkJzTks4?=
 =?utf-8?B?c2FCdDl6TEt6OG44TnpnWklnWEtBL1hXRVBkejUrRU1qcktLRW9JUWtqVWJl?=
 =?utf-8?B?VG9OL09WaWRIY3RaOFdwdHJrcVVQc0hwRm8vbVJKMGE5K09zVTN4UUg1VUtE?=
 =?utf-8?B?Vi94NWJsdjdlRCtwNkhzT2RqQWJQaGQrUW0rMTRRL3FCRFRFWmtqRTdOSUNm?=
 =?utf-8?B?dUg5WURoajlqYkdLRUlqT1NhMFg5a2UwUko1ZkptSS82Rk1sU21YL0wvay9Y?=
 =?utf-8?B?ekRIdGFrZ3FyOHJEelFZcFVscGdIR1ByM3RRakUwQjR5QTZhQ3QwazhmWkZm?=
 =?utf-8?B?dWNMUVo0N21qM1MzMjQ1WWtTRnkrZXA0eTlOYzZ1aXF3Q3FnQWUyUzVMb3NY?=
 =?utf-8?B?OElKM1lpVis5L0VuSGxiM3Ivc3M4aS9SQ01rZlFleFp0dHZHZDJNYzdhS2o5?=
 =?utf-8?B?RWRtN1U2OWNmdVJsYXM2S3gyV1pKenc5bmJWMzkyYitWdGVnWEgrclJFcGxk?=
 =?utf-8?B?aFBkRkFYZ3R5Y21LbC9Mc0p0eXRSYzFQWEEwcGtCUm5ZRklSYkUzQ09wK0V1?=
 =?utf-8?B?ZDQ2VVV6VXQxcTM0Q1N6UDJzS2lqL2Y5N1Y3MVA4eDhYRENsTW9tZzZGSE9T?=
 =?utf-8?B?c2tLVkVTTm4vT3VOQ05lYVN2bjFnTVg5L2VrYjZobU9YRXNCZ3k1Q2RBZWZN?=
 =?utf-8?B?SHdsQkh3N1lQVFdMZElEcTlHTmN6cm5id29uckxCK1JrWW4wR1ppSC96Snp3?=
 =?utf-8?B?SmlVcWZ5eTlReFliZld2WkZvRDA4S2FyMGt2MlBhQVZsOTBLdWl0ODFCSWVK?=
 =?utf-8?B?NDROVGNnUm9pbnVlKzFiM01BbTRxZzFiTEJQaGpmeThTeWR6ZzBWRWhjWEE1?=
 =?utf-8?B?bWZ2T25rRXdrZUx4K2pVYlQ4Ymx1RzFvWXd5SGt1SXhhK2gvd3lsWUhNUUhN?=
 =?utf-8?B?Q0N1N25tWm5qZzN5dWxxSEZNM3paMW5HQUZvYzExL1VUSkdPbVdxVXlrYWNW?=
 =?utf-8?B?NGlORHdPZnBnRXh0NHp4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWpWMEwwZXE4cTQ2MjBiK09oWWFoeE5LemJHTHpDYU8zL0VneVJPTDU4S2hj?=
 =?utf-8?B?dGNXbTRUK1NIUXpmd0FCb2duY1BSallvM0RUeVpoclNVUXQ0aVJXdS9WS2x6?=
 =?utf-8?B?czNDZFl2S0FQU3pQRXUxc29zdW5oTEQyOExSeUNyQU92Q1ltMVZhcHJHVVlM?=
 =?utf-8?B?Q09HY25QSjZ0czBHK1JCNFRXL1AyTWxSelRKMmdmdXRkVEp2YnRHZmNXVVdY?=
 =?utf-8?B?WHR0QWNCdUNxRy9SMFB6QXc2aXJ1UUQrZDJUbmJrYmJtT20weGVWZ3hLOUNS?=
 =?utf-8?B?K2MzenRRUXJpSmRCd3VnNTljSHY0OTNCR000dmlFekVwTUZrb0NsQm5LK2Iy?=
 =?utf-8?B?R3FDeGZSbC9HZkJTVW9pRFA3UWhDZzdNL2ZkcHlVWGZMbkJZNmJCSm9TbzY5?=
 =?utf-8?B?VVVqWEZuQXNtbWF0bUt5TktudWtQc3NJMk5YOW5aKytoWlBRRTJMcllrazJH?=
 =?utf-8?B?UmpWM2hZWEdSaVpjQXFWN0FRL04rMFJyVnYwbnMyejQ1Q2dHYlZOazN1emh2?=
 =?utf-8?B?RUlXa3NZK2EwSjFJWnV3aHRXb2xrMXh4alozK2pzcG0vOWd1UC9JTldGOHda?=
 =?utf-8?B?MzRxVUtHM0kxRjhFNG9JbFFlMldvOXgxK3J0Q0t5cTZsTy92VGdlMTZQangw?=
 =?utf-8?B?ZjJtR3JxMi9ab3gwZlpIMjZkQXI2SnNtRXhudXZZbUM0elAzbVNtMFRoSWhh?=
 =?utf-8?B?ZkN2eGliaUxZTTlZSU1jd3JTb0VXeGtFOUsvdGU5WVJPanFNclRtMWQzdVJr?=
 =?utf-8?B?MDI5c09IcEhDNTZZV1R5Ry9LYUh4UlZOWUZzTGU2cWMrUzZWeEtQZytVYklK?=
 =?utf-8?B?MW9jbHlUK1ZvYU9OeU81Sm10cVFyTTYxV2lBbml1Vm8vd1M4NWg5SW5jWVhS?=
 =?utf-8?B?elYxZWR6REtNWVd0UElMMnZBQ0NOUTk5elhUVlhQVHNJb2s0TTlLSUpCZ1Nw?=
 =?utf-8?B?NjZGc1VNN0RkTXJ2b3d4NnBRV1hKbDJyMDdWZHNvY21VN0o0Rlc5em5vcnpY?=
 =?utf-8?B?OFpWdXpmZ1I0SklFVnVnY2ZVMVZkcm5admliZUx2d21SNFNVOS9WOHRwbUN3?=
 =?utf-8?B?Nzc2N1R5ckFYazVLN3pWaHZFR1JFdy9kREdOYlFEWmdVTzdkZk9VRXExbW95?=
 =?utf-8?B?UkVVSzBrT3ZJZUY5ZHRHMnZpLzJYWGt4NHlLaHBnUFJZb0pIeXlpMGl4bGZl?=
 =?utf-8?B?MzdrQzh6MXpibEFxZ0lQMVBPeFAyM0NqL0FTeEs5ejNTS01wZ3FOakVzeTlO?=
 =?utf-8?B?MFJ0cGdrVlIrYXFZMk1NTTlZZGZRM1dXRkFvR2lsbFAzdkNEZ3Q3OHUrck4v?=
 =?utf-8?B?QVZBZVNjYWtrWnE4b0kzQVBHbHNLZWphVjF1QWNBSG0rejgwNW85ckJWNGtv?=
 =?utf-8?B?akpMUWE4RC9XWWNzUHZ2aWh3V2VGUWlGZ2c0eExKTnY4cjh5MnBWMUxWSFBz?=
 =?utf-8?B?QTJEeHI0OCtuVys3c0dYL2ExU1laNGZ0TTVtK2RBcFpOeG8vWTlLeXVxWUp3?=
 =?utf-8?B?SFBQcjB0b1dmMWJ0c3ZxVm54UUVRVGdwa0graWRrMmdCdHNnOFJyTjU0blJt?=
 =?utf-8?B?cmtMbm9zWGtEN2JUR3p0QmNPLzV4c1hUWE5wR2FuckU4bzZHTTREVFZMbWhI?=
 =?utf-8?B?d1VQRGJsODRMcGZ3eDAyeFNtdThXWnIxRXAvaU9nZmxuSG9GaUt3UVl6WTFM?=
 =?utf-8?B?NTBTVDJWYi9lLzBGeGRabzlMbURCMXdPM1l2MUloRkMvaWl5bUFFNFdqbjNF?=
 =?utf-8?B?amVrK0xtQ1dxMnlSN3Q0bjZLZkZad2VpV2MyNHVxTGRkNTNkanpodmlhNmpF?=
 =?utf-8?B?akI1c3lDb0wvZXc4TERnWENUYllDbUoxYmdoTDNFb1BoZjF2M3U3QzVQMjEz?=
 =?utf-8?B?M25PbDdnektxcHFyNG9tMjFPbVpDSUE2OFlkU05NZVlnUXBVeGpnNERRQy90?=
 =?utf-8?B?MmRJWTNselNub1FuYjJqaTVpTjZvbHgxQ3FSU0JnbXlJNkVma0RHbnZOa3Na?=
 =?utf-8?B?djJiS25wcmdKL09qZUVrNDlTQ0FDbFpBTDNCY3pjQnVNTVpaUTRLVUthTlhR?=
 =?utf-8?B?KzM0SHV1WG14bkJremdac2R2anNPcnVCMTZrWW9RSVVVM2FtdmxRZzg5SHBR?=
 =?utf-8?B?TjY1UGNSR1FNbWRSR21saU1GU0FsQ3lTd2Rlbk04YVZ2aUpyTGZQaU0xQ0Jw?=
 =?utf-8?Q?5hYvvyi5nKKrv6zeG8TRM7E=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 04118b2f-6482-41ed-3738-08dc62b40dde
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 10:07:44.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2Q/u8BuZtUmUx41iYW0/HmhWhf1Chd2RtdZcR+N8BzEjs4ecIqyESqLXpdU9uau3H2tDRjL1L/MOfyphKWcxN9b0IhL1FHJubROecsJ+HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7885

Some touch devices provide mechanical overlays with different objects
like buttons or clipped touchscreen surfaces.

In order to support these objects, add a series of helper functions
to the input subsystem to transform them into overlay objects via
device tree nodes.

These overlay objects consume the raw touch events and report the
expected input events depending on the object properties.

Note that the current implementation allows for multiple definitions
of touchscreen areas (regions that report touch events), but only the
first one will be used for the touchscreen device that the consumers
typically provide.
Should the need for multiple touchscreen areas arise, additional
touchscreen devices would be required at the consumer side.
There is no limitation in the number of touch areas defined as buttons.

Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 MAINTAINERS                         |   7 +
 drivers/input/Makefile              |   2 +-
 drivers/input/touch-overlay.c       | 263 ++++++++++++++++++++++++++++++++++++
 include/linux/input/touch-overlay.h |  22 +++
 4 files changed, 293 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c23fda1aa1f0..7ccda28e12ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22414,6 +22414,13 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/toshiba-wmi.c
 
+TOUCH OVERLAY
+M:	Javier Carrasco <javier.carrasco@wolfvision.net>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touch-overlay.c
+F:	include/linux/input/touch-overlay.h
+
 TPM DEVICE DRIVER
 M:	Peter Huewe <peterhuewe@gmx.de>
 M:	Jarkko Sakkinen <jarkko@kernel.org>
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index c78753274921..393e9f4d00dc 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -7,7 +7,7 @@
 
 obj-$(CONFIG_INPUT)		+= input-core.o
 input-core-y := input.o input-compat.o input-mt.o input-poller.o ff-core.o
-input-core-y += touchscreen.o
+input-core-y += touchscreen.o touch-overlay.o
 
 obj-$(CONFIG_INPUT_FF_MEMLESS)	+= ff-memless.o
 obj-$(CONFIG_INPUT_SPARSEKMAP)	+= sparse-keymap.o
diff --git a/drivers/input/touch-overlay.c b/drivers/input/touch-overlay.c
new file mode 100644
index 000000000000..5e05dab003cc
--- /dev/null
+++ b/drivers/input/touch-overlay.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Helper functions for overlay objects on touchscreens
+ *
+ *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touch-overlay.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/property.h>
+
+struct touch_overlay_segment {
+	struct list_head list;
+	u32 x_origin;
+	u32 y_origin;
+	u32 x_size;
+	u32 y_size;
+	u32 key;
+	bool pressed;
+	int slot;
+};
+
+static int touch_overlay_get_segment(struct fwnode_handle *segment_node,
+				     struct touch_overlay_segment *segment,
+				     struct input_dev *input)
+{
+	int error;
+
+	error = fwnode_property_read_u32(segment_node, "x-origin",
+					 &segment->x_origin);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "y-origin",
+					 &segment->y_origin);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "x-size",
+					 &segment->x_size);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "y-size",
+					 &segment->y_size);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "linux,code",
+					 &segment->key);
+	if (!error)
+		input_set_capability(input, EV_KEY, segment->key);
+	else if (error != -EINVAL)
+		return error;
+
+	return 0;
+}
+
+/**
+ * touch_overlay_map - map overlay objects from the device tree and set
+ * key capabilities if buttons are defined.
+ * @list: pointer to the list that will hold the segments
+ * @input: pointer to the already allocated input_dev
+ *
+ * Returns 0 on success and error number otherwise.
+ *
+ * If buttons are defined, key capabilities are set accordingly.
+ */
+int touch_overlay_map(struct list_head *list, struct input_dev *input)
+{
+	struct fwnode_handle *overlay, *fw_segment;
+	struct device *dev = input->dev.parent;
+	struct touch_overlay_segment *segment;
+	int error;
+
+	overlay = device_get_named_child_node(dev, "touch-overlay");
+	if (!overlay)
+		return 0;
+
+	fwnode_for_each_child_node(overlay, fw_segment) {
+		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
+		if (!segment) {
+			error = -ENOMEM;
+			fwnode_handle_put(overlay);
+			break;
+		}
+		error = touch_overlay_get_segment(fw_segment, segment, input);
+		if (error) {
+			fwnode_handle_put(overlay);
+			break;
+		}
+		list_add_tail(&segment->list, list);
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(touch_overlay_map);
+
+/**
+ * touch_overlay_get_touchscreen_abs - get abs size from the touchscreen area.
+ * @list: pointer to the list that holds the segments
+ * @x: horizontal abs
+ * @y: vertical abs
+ */
+void touch_overlay_get_touchscreen_abs(struct list_head *list, u16 *x, u16 *y)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (!segment->key) {
+			*x = segment->x_size - 1;
+			*y = segment->y_size - 1;
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL(touch_overlay_get_touchscreen_abs);
+
+static bool touch_overlay_segment_event(struct touch_overlay_segment *seg,
+					u32 x, u32 y)
+{
+	if (!seg)
+		return false;
+
+	if (x >= seg->x_origin && x < (seg->x_origin + seg->x_size) &&
+	    y >= seg->y_origin && y < (seg->y_origin + seg->y_size))
+		return true;
+
+	return false;
+}
+
+/**
+ * touch_overlay_mapped_touchscreen - check if a touchscreen area is mapped
+ * @list: pointer to the list that holds the segments
+ *
+ * Returns true if a touchscreen area is mapped or false otherwise.
+ */
+bool touch_overlay_mapped_touchscreen(struct list_head *list)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (!segment->key)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(touch_overlay_mapped_touchscreen);
+
+static bool touch_overlay_event_on_ts(struct list_head *list, u32 *x, u32 *y)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+	bool valid_touch = true;
+
+	if (!x || !y)
+		return false;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (segment->key)
+			continue;
+
+		if (touch_overlay_segment_event(segment, *x, *y)) {
+			*x -= segment->x_origin;
+			*y -= segment->y_origin;
+			return true;
+		}
+		/* ignore touch events outside the defined area */
+		valid_touch = false;
+	}
+
+	return valid_touch;
+}
+
+static bool touch_overlay_button_event(struct input_dev *input,
+				       struct touch_overlay_segment *segment,
+				       const u32 *x, const u32 *y, u32 slot)
+{
+	bool contact = x && y;
+
+	if (segment->slot == slot && segment->pressed) {
+		/* button release */
+		if (!contact) {
+			segment->pressed = false;
+			input_report_key(input, segment->key, false);
+			input_sync(input);
+			return true;
+		}
+
+		/* sliding out of the button releases it */
+		if (!touch_overlay_segment_event(segment, *x, *y)) {
+			segment->pressed = false;
+			input_report_key(input, segment->key, false);
+			input_sync(input);
+			/* keep available for a possible touch event */
+			return false;
+		}
+		/* ignore sliding on the button while pressed */
+		return true;
+	} else if (contact && touch_overlay_segment_event(segment, *x, *y)) {
+		segment->pressed = true;
+		segment->slot = slot;
+		input_report_key(input, segment->key, true);
+		input_sync(input);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * touch_overlay_process_event - process input events according to the overlay
+ * mapping. This function acts as a filter to release the calling driver from
+ * the events that are either related to overlay buttons or out of the overlay
+ * touchscreen area, if defined.
+ * @list: pointer to the list that holds the segments
+ * @input: pointer to the input device associated to the event
+ * @x: pointer to the x coordinate (NULL if not available - no contact)
+ * @y: pointer to the y coordinate (NULL if not available - no contact)
+ * @slot: slot associated to the event
+ *
+ * Returns true if the event was processed (reported for valid key events
+ * and dropped for events outside the overlay touchscreen area) or false
+ * if the event must be processed by the caller. In that case this function
+ * shifts the (x,y) coordinates to the overlay touchscreen axis if required.
+ */
+bool touch_overlay_process_event(struct list_head *list,
+				 struct input_dev *input,
+				 u32 *x, u32 *y, u32 slot)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	/*
+	 * buttons must be prioritized over overlay touchscreens to account for
+	 * overlappings e.g. a button inside the touchscreen area.
+	 */
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (segment->key &&
+		    touch_overlay_button_event(input, segment, x, y, slot))
+			return true;
+	}
+
+	/*
+	 * valid touch events on the overlay touchscreen are left for the client
+	 * to be processed/reported according to its (possibly) unique features.
+	 */
+	return !touch_overlay_event_on_ts(list, x, y);
+}
+EXPORT_SYMBOL(touch_overlay_process_event);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Helper functions for overlay objects on touch devices");
diff --git a/include/linux/input/touch-overlay.h b/include/linux/input/touch-overlay.h
new file mode 100644
index 000000000000..cef05c46000d
--- /dev/null
+++ b/include/linux/input/touch-overlay.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#ifndef _TOUCH_OVERLAY
+#define _TOUCH_OVERLAY
+
+#include <linux/types.h>
+
+struct input_dev;
+
+int touch_overlay_map(struct list_head *list, struct input_dev *input);
+
+void touch_overlay_get_touchscreen_abs(struct list_head *list, u16 *x, u16 *y);
+
+bool touch_overlay_mapped_touchscreen(struct list_head *list);
+
+bool touch_overlay_process_event(struct list_head *list, struct input_dev *input,
+				 u32 *x, u32 *y, u32 slot);
+
+#endif

-- 
2.40.1


