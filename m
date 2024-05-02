Return-Path: <linux-kernel+bounces-166817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7AC8B9FEC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E421C22169
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649417164D;
	Thu,  2 May 2024 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="U8jQgKAt"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2114.outbound.protection.outlook.com [40.107.15.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F016FF44;
	Thu,  2 May 2024 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672737; cv=fail; b=ZEOMw3vVKYDYX+kx8p4yijQYZEI6etCps1Q5WOj1b3qSdmORThPDJMiqXAX+E20bMrMDgJec9avn3SsFbALfkOrcmrLb5fY6xYMY4j4JKmAwkS551VLXrklwWTgjkRIR3/uspHp1QK3OhCc4AZRwj/QuuotpRPxOFmllTDmXG5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672737; c=relaxed/simple;
	bh=PsitC4n9dowkyG6rX3B4jWFJ7BsVTIDFs9ITYW14PXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d68KT0FdRbadukw69jK22bb3BvtyjgGqrKU1VnBgUfcUv7f/v6sm0xGslPy/w/Az0whaTSJL/pM5mHB/2m3h94Tr7MQThcKK5/KVdPXUMXcxFq/lqILO4AaEQ420p/QmzfN9+zFeEjD3gA/6sQxQbTVGXqu3vYtdvIBbrSiwGc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=U8jQgKAt; arc=fail smtp.client-ip=40.107.15.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0vpGX2QdCczuzaMiJ4+lbFwmeDfV/RW2dIfw09FMM6YWTeN+FweBL5+ncA3pCyA375UOwSCv9PvnmzBwB+fQ2enSOmigeJAdTeq017OYNBALVXlhMKAItVrhV6AdUG9zjZFqbxbueGtJGhyOLt//nwPNDL4tIiWebOZ7sdEaJOwLUiy0pIWVuvzoV0qUZOnQtwFxU8rQ+rtnyTmCvkCAo8MqCZNb56D89kKfQduf7k3xazE4QXnC+G1dnCCvVB/dJ77zuu6gnvcXhBaw0xFXda4gNn3qgMvKsdmKdAmNpyMTW4n+csH6ImybD+Gxku39PgakmKKhCH6Vm04VNeuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jiK9Gn9d6IDSFGOoo0/kIPmFzfhsivLbuFAKNbeDbU=;
 b=gMLgVJeUC9YSd6JGu0JQ8Qm1I+Wlbi3ByBJ8E/lepjdyhy6HJBaqv3z8DZtknaBe7oQREQhXO/nOmRmJAxhny8iqgOKOsAp0dfUVEgaPUBu3rscYB7EfIyk1iOKUtjiOQwiyb/zlBJAtHkK70OAsC/zlxHYNDLTN1eQHxThcJ3+4mAdW1fQ7wCQzyHuWNEBsQUQsCXvMaFFeDk0xoSdGX1rh2GpdwoxDfhK0jaDmOxlJkfNIN/6zr3aSDXfV985GEb01zz//tbm7qaUkblwYF/gTYMS0lwqSYGmaVq6b1k7uZGlIKjROjETqM4B4Kf57LkmkJpL0pw3+91Tr4ZecJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jiK9Gn9d6IDSFGOoo0/kIPmFzfhsivLbuFAKNbeDbU=;
 b=U8jQgKAtskCApTwWzQgkR/Ms3YPYyH2NL32LRqYDbzO0ZCI4NQr0fpBtDMbzhNv9iIL3ihckN32XFix+tDYPCCN6lgYKTDywIyCRR//AEGeFy5xRbRC+yqeYPJY2VOVs5gngiGKgUaUjfFDlJMkwZfZTRs3nS6IKpOLjgf5GZGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB8086.eurprd08.prod.outlook.com (2603:10a6:20b:54b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 17:58:52 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040%6]) with mapi id 15.20.7519.021; Thu, 2 May 2024
 17:58:52 +0000
Message-ID: <6b5571e0-1463-4dd9-9bd8-459d456a6932@wolfvision.net>
Date: Thu, 2 May 2024 19:58:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] device property: introduce
 fwnode_for_each_child_node_scoped()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240502-fwnode_for_each_child_node_scoped-v1-1-868a2b168fa8@wolfvision.net>
 <ZjOybob3wJjisuBL@smile.fi.intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZjOybob3wJjisuBL@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR04CA0138.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::36) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c66b761-6025-498d-c2cf-08dc6ad1868f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YitEKzIwVGpqY1VMaG9oMUx3S0NROWZ2Q3MveHNtK0xzdnVvT2VwMFAwaXpK?=
 =?utf-8?B?VUlnZ2dRRFQxZzNBc0pxQ1FZalQreW8vbjhHTHpwTC9teEhodHJzRjhpWWc3?=
 =?utf-8?B?dTFhMkg2Vk1pd3M5YnRUWmlicHBFRXRCcThKeisrUWE4OG1vcEt1OWhrY2xW?=
 =?utf-8?B?STBrTlVVaGFYZC9LeXhNbktudnZNNWJVMEgxZFlMVXZTTXlUOFRGakVhNGlp?=
 =?utf-8?B?VlBJSmVTYzNUYWRqK2pCeGN2STU0a3FWRDBtY0lxRG1WaGxrQnBiSmkzc1dx?=
 =?utf-8?B?WTYrVmFVeHFsMkYySDJ6cUdrNkkzbFNiM2lGQVhPaTZPbU8wVy9YbkRUeDhv?=
 =?utf-8?B?UDhCU2ZwdXhSQUxNWmRxM0EzQzZIRnlISkJraE9aNFE2K3RuQkh0YjU2NC9W?=
 =?utf-8?B?YkNYTkJMM2F5QjMvdUhUakEzdmNSYVVETjlCcCtzdDlmMVJaUjV0WXpUeDh1?=
 =?utf-8?B?a1NHa3VDUDIyQmxFY0IxcityODJFaEVGeWtZK21kNWlVelhyN3kxekpTOW0v?=
 =?utf-8?B?TXN1UkpkTlhHZlY0dlZvQXhnTHlUZ2RGNlFUdFRXSkM3bTRoZWRwZGwzS1Er?=
 =?utf-8?B?WXdvUHFSZDB6NFVsM1Q2VUl3Z0RuWGppTk1nSVVoaDE0Mi9mTkV6WlZOeGJ6?=
 =?utf-8?B?M28xNCs3VHUwaHFndmFERzJFMEM5MVcrSTdxZEtWTW5JMVpuRmFTTkM1Y1pL?=
 =?utf-8?B?Y3BLb1J3b0xBdFdPcHB3eHZ1ZzhJVERZaVNMOU9sWTBzMk1XZ0xSZk5VSzBP?=
 =?utf-8?B?NkJUbTFMaEgvQk1JWkJZVFhnYkVneTBmSitnQ3gzWkdmQlVqMzh3bnJ1RUhT?=
 =?utf-8?B?NHhWbUdobWxzbUtkRWROWWp5bmFZOWlaNHBvNHVxdXp1VkZCU2hXTmZDSFpl?=
 =?utf-8?B?L21pRW5oWXdsRi9DQmN4ZUx1UGhkRTdhZ0FSZ0ZHUzNjd0Q0cE5ZOEljek5M?=
 =?utf-8?B?WlVBOFN4TFVxNU1peWpROWs5dmRRUHNlVEVYTnBIdFJ1My9xdk5zTGJMM3d0?=
 =?utf-8?B?OVVwSGRVa3BYeHVjY1U4Q09uOEkxN0lzd1J1K1QrQnd0OCtqYzNERUhhM3li?=
 =?utf-8?B?b3JyQUJ0ZlpRRTlLZ3JmMmo4bFdCMC9PbzFnOGJZajFwdjk2QzNyV2VoSVE2?=
 =?utf-8?B?bVdPTFpVVXE1RVNKOHhyMDJWc0xmNjNQaDNHSHY5SlpsQXFMT2NNY0NVdWR0?=
 =?utf-8?B?Uzl5S2R6UzZaM3JMa1dVZUVkb3dla09OckJ5U1lBdzROOFRQUHpOaDB1aURZ?=
 =?utf-8?B?dXVLZitYc21UbzlsWE5od2FDSDNaRVRMeEFpZmRIUURqWVRJUElKdS81ZzZO?=
 =?utf-8?B?akxuN29KS3Foc01nRDZpblFrZ2ZxcnNkOEhDMmFkTFlrSGd5V21heFRFV25H?=
 =?utf-8?B?UTJwNldydDBtUmZxRnI5c1Z1WmVrVGZIOEM2Mzc4cm4xTmlpVnhvck9DOG9M?=
 =?utf-8?B?eDZKeVg2ck5SRDRrd1IyTjVaMHl2MzZRbTVxMXJQK2VjZzM2RHY4UGN5a3li?=
 =?utf-8?B?aXZZUWxOSURzUkZuMUtjZWtxdXBzRiszejdrZEpXZHVydlM5YWJER05XVVBw?=
 =?utf-8?B?R0w3QXlMcTNyZTNXSzl4L2MwTzN1L1ZsYU1XOElOa3Q1OTlSVUxyYzZVS2ZJ?=
 =?utf-8?B?cHJyWUtkMmI5UlVXdEpZdDZNYkY3UTRUZEljUTN2eXBjYlFSQVJjTjBjd2tj?=
 =?utf-8?B?MWVleHRzS3VJeHVEaTYrWU1TR2daTGNPUm5pek9yUnlPaUlFTERYZFBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHFqaEtERW5hNGY1aXR4NUlMaGY0TXVkSjZEYTNOU2QxblZxOHJOMk1UdWsw?=
 =?utf-8?B?TCt5cnlMUW9SakRKWWpVK2NYRENBbTJ5WUdUVHd1T1RVY2JGcXd0TS8vUWRa?=
 =?utf-8?B?RExLZ3d5d1I0SW5xQkI5ck9MNmR2NTJjV05OSzMyU0QxakdUNXhudHpGcTZE?=
 =?utf-8?B?dTNvSjdIbHhuSnVZN1NXN0loRU1xNGhZeUlURHluVEVoM0pIa2tPR3FYUUM5?=
 =?utf-8?B?SXVuVldhTWthZmFmR3JBdXgwRzI3ZlJLZ1ptaE9YS1Y5bGVTTWt2dlNzVmpX?=
 =?utf-8?B?dUJSYW9MQU01akVsNnEvR1NacmUrNnhNRjN3Q0tSNGxjSm50czJlQ1lBOWlE?=
 =?utf-8?B?cHMyWVZBckt3c1VHRFdldWk4ZVhtYWcxSzBQaFFoZmhVSHcyTzlhTVc4RGRz?=
 =?utf-8?B?WXd5d1JmYW5pQmpHVUxtdmJGN2g2ZnlJU3VmTktqeGZjeGpTZzF2SlFRd2gw?=
 =?utf-8?B?RVgxNEhWSmlLQ0lPQ1ZZcFIyaFNlNXVmSXdRNzFnZnlwZjdidnpwc1k2b0JY?=
 =?utf-8?B?OG1kWHZ1S3BidmN2NjloOGtublNqczAvY1h2c2U0RGo3R3VZalpJbTJYS09k?=
 =?utf-8?B?NUV0U001em16QWZHNVJjVlhFdS9qWklUQ0hocE1jMTAxbkphTldPTXZicmNv?=
 =?utf-8?B?VjBnN0g5ZVMvdWMvbi94RGthQ29QU092NDErZXdKb2pSdTY1RnFDcVBicXBT?=
 =?utf-8?B?SVJydmZmd1Avd2xqYlFvT0xuZ2ZlTUoxN1ArTCs2UWlMaTFlUjAxZlhBem4r?=
 =?utf-8?B?ay9GSXBkT3l3VStCVS9xYlVmblFvT2Jwcmlnek9PZzdRUDZHTHJydGptaVRp?=
 =?utf-8?B?NTRFOUZFOEVSMEpJaVRBMGVGWS92N0JGcVNTR1hYNmE0dncwRjdQZWFXLzhG?=
 =?utf-8?B?allXYVdoSDhMemtPVFVrZytjSlc3K1I5eTFyMjc1Y3p5b1BKbEp4M0ZQTFR5?=
 =?utf-8?B?Y1RqdldTQ0R2Ujc1MldmTjg2OVNJU0ozbjdtODgwT0ozWVh5Z29WN1p4K2xm?=
 =?utf-8?B?bk1qTVF4TVAwUWhGRjhFa2hRYWRTcndxOTE1VVhDRitSeTlXV2tESGprVTJU?=
 =?utf-8?B?UlJYU3FLYVlFZUV2MkVXbzd0c0xnZ1dzcXJ4RUwwUDRzU0FoZ0c5QWRvLzE4?=
 =?utf-8?B?eDhTMFpPK2V3eXZWVlduc2tDR3djNmN5NGhzdTBmOUZTNkQ3VWppMW1ib1R6?=
 =?utf-8?B?ZUljN2ZKcXkvYUtCMGN5ajMvdDFvcExjNlp6WUQ5UjBGeVYyK2o4UnJVSVVk?=
 =?utf-8?B?RWdjRmZGb0dreEZaODZEM3B2M21wZkVNRGpXK0pTWGM4Q2pSZVlmRVdmeEpI?=
 =?utf-8?B?R1NwNDNWMm83T0RhSmUrd2REYmtwWHhnaXlrUTVRcHpoanB5UzBmVGlGTTZK?=
 =?utf-8?B?R3kwUnR0dVFXQnVhc1FKNnk0alFxcHp4djZucDZnVUpjSXpHOGwxTlRVTmNa?=
 =?utf-8?B?THVQc1hSei9BcjlIZWsvYk0wcnFtOW4yWlo5bjNadG50VXVYSjZsNk9zcFY1?=
 =?utf-8?B?M3hBRC95MFZ4RVN4dUpRWFJTK3M2NWZxditoejUwS0xjczVwbm5rT29ENXl0?=
 =?utf-8?B?dlkrMU1jSXd3NkwwUkRtMnR3OCtjejJaQ2ZyZ3NEcXR5Y1VveGY1aXVsWE5R?=
 =?utf-8?B?ekNkTHE2cGtqMzllV3pKZis5emVaOW5IUnNjKzU3bDVZK3hhdUxPMWVsay8r?=
 =?utf-8?B?dXA5UGw2OFFTUy9ndmQ3Z3VxM0N3YWJXaytScG8veDFubHFBVUVWdzlVRE1D?=
 =?utf-8?B?Ulo4NndHd1lBSkxId083Q3BSb1gwL211MWdtV3ZHZXM4VWtMTWFkcHJLbjRm?=
 =?utf-8?B?c09GY1hKb0ZHVlp1ZThGVmVRMnV5T3FPYlFMalp6cVpqK2RpMGJrOHlxMXE4?=
 =?utf-8?B?VzRsd2c3UFhqeDNZMmpDWHFlNkI3a2RtMkZSVktyT1A3aDQwb0EvVG0zSC9p?=
 =?utf-8?B?SzQ2bmprVDZHSmxSdzNNKzk0eElhbnZTU3BkVHY4RDBPM2RTVzY0NDAydWtJ?=
 =?utf-8?B?ZVMvTy9ueGZ4YVJIMzVnN0hQaXE5Y0EraTBiekpxOXhmaXRMNE43RXMvamtU?=
 =?utf-8?B?YlNlUTZ0UVdUNnBRd1BuSzJmS2hMZVlDYlM5ZnVmeFFCbS9EZVZ0RUVPS1ZX?=
 =?utf-8?B?Ylcya1RpMTEvc0JNY0ZYRDFBS2VKQmNxZ3NxNi9mcVFXOWxwMUJxbmpoYkE0?=
 =?utf-8?Q?eYQkXOMw2N1DehZXrzTSZVg=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c66b761-6025-498d-c2cf-08dc6ad1868f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 17:58:51.9192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuwGOgW1pf/I5ZBN4skEG9/R41j0craoKSguBUQ+fd6UJozt9X/QjZGHq8wYrlR0OQcOUimeaGJV4pBoQp6tZXYlZdu5uxNj6wbcGYJ4S3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8086

On 5/2/24 17:34, Andy Shevchenko wrote:
> On Thu, May 02, 2024 at 12:55:40PM +0200, Javier Carrasco wrote:
>> Add a scoped version of fwnode_for_each_child_node() following
>> the approach recently taken for other loops that handle child nodes like
>> for_each_child_of_node_scoped() or device_for_each_child_node_scoped(),
>> which are based on the __free() auto cleanup handler to remove the need
>> for fwnode_handle_put() on early loop exits.
> 
> Why not _available variant? I believe most of the code should use that.
> 

That is a good point. I just took a look at users of the _available
variant and at least the LTC2992 (which I can actually test) does not
call fwnode_handle_put() in one error path, so it could already profit
from a scoped version. I will send a new series with the _available
variant and a first use case for the LTC2992.

>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>> This macro has been tested with a patch series that has not been
>> applied yet and is under discussion in input [1], which makes use of the
>> non-scoped version of the loop.
> 
> So, why should we apply a dead code?
> 

I will add this patch to the series I mentioned, so there is a first use
case. Even if the _available variant is preferred, the other one is more
widely used, and having a scoped version will allow for safer code.

>> Based on linux-next (next-20240502).
> 
> Use --base instead of this. Ah, and you do, so no need to have this comment.
> 

Ack.

>> Link: https://lore.kernel.org/linux-input/20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net/ [1]
> 

Thank you for the review and best regards,
Javier Carrasco

