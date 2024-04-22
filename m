Return-Path: <linux-kernel+bounces-152747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4202E8AC3C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F171C21723
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8F18042;
	Mon, 22 Apr 2024 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Vy8dT/1K"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11431802B;
	Mon, 22 Apr 2024 05:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764208; cv=fail; b=cngFtjRqKgXNfpRWgvnz3UjGgLGt1u9uTIchrXYpjmtG1hj9s2GKFeRuIydU/hysHle3XJPCTrjtv1DXQp0AGYSQgFEUlA2tv1wTibk75KyZqZ6kW2pn8zedpbNkTB8DwdpNdyK9BUe8OzuzVmnOUlgohZxF9XsAt/zJ5GFma5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764208; c=relaxed/simple;
	bh=mao0DYfl4zO/Bd7vEb/HaaQawlDY7ODBifDo4zSOKQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ns2i9xQ0tj6UM6FRcNDA5XTA2LUjT1Fe2pJK1fCMIgxnuhv9jxU1Kzyoe98aUBWfSHMnZ3iImQUE1XRQ0WfBqwP+SOin54IiO3VTyvL77nnox1q6fz0AopZdG86bXeNTvOcs9TdDPTSs9OK4BsvVOK9n07orQdZD2LQaf+b2zmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Vy8dT/1K; arc=fail smtp.client-ip=40.107.105.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnnmdFbQK7yuX595JKjFO7qsrIax7Dj4RyhceuczICotZIGyhXM8gDv2TX8/yEJSX5agn++ovgYh226m4dkR+jRnqB33rsx48/SyBK4GCBbAxNe8I/SybywcVXYfdf2V1pfF2tiYpaYpeI0B0d4lmrhdV2xF9ZmhW3kaC7NeLic9JMloRFxReTmPYkJBDdMaLvGQQwq3C+ZbzTSgZUzVTCvqbg/VFQEEDnv8m0Zvw1wZqSjhSoVEmRlB649xJa0DgxNpM8EHLtaEuaxffDPhotmFXYJhIYHjwhddIC7GaFIwok6O36j9Ze/YmRO7g6WzyWof1/OeIXrTdHH9jMB8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLbU7Nt8WmG9rfuGGxePzrerHXZZM7aDRtHAbgbawyA=;
 b=JSXBMdgCib4KA+4iTM9hyYD/KENNpX3k6IEBCzyt3UripiRznXBJksBLN8rdq1K6DPHMbTRb14XqahqF5l1HToOljTOWLWCBXEZzsL47j1JolROcaJYV+vsweKb5SiIG1pEhvMpGasPJEc4h8mSIpNEyA6dnqZmyoEJry7KWjG4heY6PQ1O596eKSSXsMaoB3XD5oIniiqjhuCe+XWYvDMPFLQz331TUg9x5LjGKnq4lMGxLKOz9fEkzv/uW40BC/WWjv9AVgI8b2wpdK4du3Ls2lO2FMHOYI8LGsfIohBCIezKUtYC614YHug1P9SptwbAG7+scnBnBgrcunFateQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLbU7Nt8WmG9rfuGGxePzrerHXZZM7aDRtHAbgbawyA=;
 b=Vy8dT/1K5Hja8lVql7Z/pY9A87KkPnyawGejgjyoBQ+zex6tyGo7HsDAG9mdNGoWihZq0PREADkVS3ARGyHm/GLv6gcnNODPfUrwKd+x+P5Q8KjiaXgpbXiRqRa3RypnnFqJ02h1x6KaNsbRae0Pcfv6G56BPZUJTUjr8ZqqnszQeI9hu57+mrX9MR1Ied/0DbsuyB9SW1fEXFKYndVGv7s820Qdy0nFJlb3MhPOdGpX8WUlk2vKShKtHAAcvIfxirxQhVkT/I5mfE4UFDrdmrv4veR5XZFSt2GELw9TfufkZQu5/FCmdptIYFIeQqB1FlRlgkX0N9fK8xYYMKJjSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5622.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 05:36:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 05:36:42 +0000
Message-ID: <611a79db-4c4c-4538-a67e-370a777387ab@siemens.com>
Date: Mon, 22 Apr 2024 07:36:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] watchdog: rti-wdt: Provide set_timeout handler to
 make existing userspace happy
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tero Kristo <t-kristo@ti.com>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <4d82b8ce-bc34-e4b2-c5fe-9e883b0db59d@siemens.com>
 <e6e3f905-3de5-469c-a47e-179fe23c66df@roeck-us.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <e6e3f905-3de5-469c-a47e-179fe23c66df@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 52486aea-e74f-4ed4-eaf3-08dc628e30ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NStDTWJRQXRCSURJWHM0OUVyM3dRZklyVmd6VzFuNTRtZE9RV2F5MGM1ak9y?=
 =?utf-8?B?MHloK2hPOUhCSGc0T3NjYmNUdStpbFJJZTVWWjJBdnNRZTR2Y2pFcU1sRStJ?=
 =?utf-8?B?a2tnVFZxWXQrbm5vMDdYamZCb05oMkVyTDBRMk5HRS9zZkFvOHBlWXhhc1Fi?=
 =?utf-8?B?UmQ3VUtlY2M3WTVmcG1QakVpRW4zU3lkK2hDL3lLSlVaSnlEME1RS3F5clhU?=
 =?utf-8?B?TUFxeVgraEV1enpPRE1kZFVsZ0FyNzBRMC9tRVdpZXQzV2Q5V0M1SHpzNzIy?=
 =?utf-8?B?OEVnblVLVkxWalIwQjBveDlQKzA0SkxKR0hwRTJUNUxxU1U3REp0TU5TQXB6?=
 =?utf-8?B?Vkl0VzBQTHZzc3RuVjk5emQ0TGIvcXNiNlBubVhGQTZMODFsY0cwQys3UGNG?=
 =?utf-8?B?NldoeWRiN2JGM0tZeEhocURBOXdKUVJHYW50ZHBVbHc4RUlZdE5qTHl2VWhF?=
 =?utf-8?B?L0gxRHRRTlRxTXJFL2Z6RTMvT3BZUWg1VVlIUGtxdHErSUp6ZUJxdUthbjVx?=
 =?utf-8?B?aTRxUEM4a201Ryt2aUpIZ1l1Y2s0SlphRWUzUnRldGg3dlNxK29MSVpSMHZ0?=
 =?utf-8?B?UmFDc3hnMERVSVUvcEljWmNLVzZtcUZOVEJTVE11ZTFLTUxqaWhsNko1K1A2?=
 =?utf-8?B?Q2xtN0EzbDNobW9VNWNLaDVEZFcvOUdwbDJEVVUwSWF3TFZPa1hHWGlMWkdK?=
 =?utf-8?B?Vm1nYzUwQmxWYUZQRFF4ME0xU0k1ZGkzUEY5cU9XU0FxNEY0L0VsYTV5T1ph?=
 =?utf-8?B?TDVIekZabUloNGlOZFJHNnhFU0ttYi8wRUNINVdoWHJCdG1SQlU3clY2enJC?=
 =?utf-8?B?dk5PM2gvMXNaK01xZVlsWWFHS1ZUdm54TTByeU9QYUYxZEZ3eWN1NUpaVjhq?=
 =?utf-8?B?QjBEWlQ4R2xoWWhBWlNsb24zT1puUHZwWVljaHFJVUJrQm4xdjI1UkRaazcy?=
 =?utf-8?B?UW5KV0lIVVFodVhSb3hZN3RFaytRQ2pDVWxCQnBWNUxZZS9qSlNqaW85cTky?=
 =?utf-8?B?cUdocWdnN1BINDdpa3l4dVhIM05kK2dYcHdtbGc5ZXJmSHc2MUxBRWxnMk02?=
 =?utf-8?B?MDYrTEk4WjdBYnJuRU1sTzhqS1BjVlZuMXdlNWE0czJXZXZVL3RySHh6VlA5?=
 =?utf-8?B?VC9VU3ZWVjdxSjg1OGIwMEI5VFAwaGhYZFh1OHBieGRsWnMwVjBJR29BUXQw?=
 =?utf-8?B?Y1BQVWk5a1dpTkJNbXRyd3NQeS9iT2NvTDlVTFFWQjk1TVR1R2htNFdHV2FB?=
 =?utf-8?B?NTJQWEJ1cmVySjlMUGpST3FaR2RTMzJ0T3BOc2xFeTlFUk5wSS9BSzVrN25w?=
 =?utf-8?B?ZVhPWXNxWXVqWjk5MXNpUzhYcWFoYlQxejdIb2s3dTV6cjJHVnJFRTVWenNV?=
 =?utf-8?B?RkVpTWtXTDIxUnluVzJrL0FaUkxGY1NiOHhXSy9OaGZXNlBKZjhBMDRoTnF5?=
 =?utf-8?B?SUhrTGNiVlltcmhJUDIzV290SWw5RkRNN0pyVURtaFVIRmxMODdna0JnVHB4?=
 =?utf-8?B?R3M0d2hqaWo1eSswckdhNEl1SEU1K3d6WmUyUUZuUnJJcGlBSnZ6Q2ZFUGds?=
 =?utf-8?B?a09NTk1QSk9wWG1Cemh6TWM4UkFxcFZPWVhpU2lEREdPUlhlZldqaGtwcVdm?=
 =?utf-8?B?WTBxaFpnc3hKajJRN3d0a1lBUXRWMzdjS0NhQTdqRlpQeExuVXZLYThFQjNl?=
 =?utf-8?B?U3BpSkNmeFNJSmVZR2JyVndPeFk1UGdDNWxwZ0oyR0FqcjQrQmZYUGRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEplZTU2eGE4VkV2eVN2RmNkTU05VnFpN0hpckxjZTBQTUZaVDFDQWtwamhJ?=
 =?utf-8?B?ZkIyQlBJK1RPaU1XL2RRSXRzaUh1MDE4bWFZQmRBcENUWkoxbHhMYStQRTll?=
 =?utf-8?B?SU1TWTcySVNEMmhQMGp1ZjFkeXRlUmNvM1FKV2FMK0Z5Q2NnRk0wUHA4cHNI?=
 =?utf-8?B?VWlyY1UvZWpZSmtkUU5PRG00U2JGb1ArZ1p1YnE0ZThVYVUvRlBqTlpvNzc1?=
 =?utf-8?B?ekZReUVYYWpDTUY1Wkl2VnA5eDJpbWZraWhESml1OHp1eXJEeTJUVUFQQ1Nw?=
 =?utf-8?B?a0s3OUhvTU83Z0lhM3QraCtZQmZoL0dWS2daZWpVMDlOeDVQeTUxV1RSeHFm?=
 =?utf-8?B?K0hLdXk2SVZqVXM4ankyaWJEcWFScDZaMitpQldpbXFOMFY1U0dOWkU0c0xV?=
 =?utf-8?B?WGlxYUFVT091cklsZGRya1hXL285b3UxVzg2RjdkaUVSL3U0bTV0dWVjeUZC?=
 =?utf-8?B?UEhzYXhOZStpdk1VMlhKbHE4dExiT3Z6bExiNDFOUWlINFFkN2VKb1dVOXZk?=
 =?utf-8?B?MTBWOUNJbkhZWFVUR1oxSi9YcnJTRzduNzBqZ2pTc3hLdE9YS2FCdnRkZ2dX?=
 =?utf-8?B?ZHVnOHdnVHBqTHYvbGNrcVZsWHFZU3hJMDhtd2p3aGh1a3FtLzFHUnl4eWQ4?=
 =?utf-8?B?aG5qQUdJQ25taFRKaDZwK2dkVnF6VE1EZ25TRGxhT0xValVadnhuaWJkai9x?=
 =?utf-8?B?Z3JjSEIrMXQ2Vm9yeXJTM0FsMXBWN2ZpSlJ0bTRPVmFoOCt0UVRiczgvVm1Y?=
 =?utf-8?B?b1pHZ1ZZTkNxektOeUwwM1M2Z2Q0RkI0VnhFZEp6WER6Rmo2ajNZOHM4UDRp?=
 =?utf-8?B?ZVNmeVpEcm1hQktYcHN0bFVqOTF5THkycTUxNUxFVmN6RitZNDh4dHlSWGdy?=
 =?utf-8?B?blYyS0VicitBbnJEOEIzc3VlVnI2NjZWOXU5MENwZ2IwZ2hDZHl6ci9nZlBx?=
 =?utf-8?B?TVhyUmxIVm9BWVRwM2h3RVZDM29WdXgzS05WSi8xNnNYQjUwckNVZlJidjQ5?=
 =?utf-8?B?bE1IRGttRElnZkxvbTBoL2FoVk9PNnBGcEpMaUViYitSeHpRZHM4OUtFaEhk?=
 =?utf-8?B?TWk3TGo1MGtKMTd4Zk1DbTk2WkgyUmc3V3BVNXV6VFN3d2VvSUxweTRzK0lz?=
 =?utf-8?B?MitWSzVMQ01mTytlL1dldDVmZDIzVDIzcWdPYlg0RTNwTHpJWVVxL1BZOU52?=
 =?utf-8?B?RXBWSkNRZEFnRDFaMHo5WXNHNlNWRmZQVXJLNDMzaERrTnViaGFGUm0zTWJC?=
 =?utf-8?B?ckRGeXpidFFkYURHNFVzZ0pmdmZqZlB6TllPdnpqSUNIdS83N3JPckNEODNt?=
 =?utf-8?B?bkZMTUdYTnYvTUpUUlNpMUpyMERLT2ZrUHI2SUR1b081bnFwYmlDU3Baa0Mw?=
 =?utf-8?B?OUdaVkdKTWh0cTRVL0VmRXlhdXpMNDlZYzRNMHVUemtrNnQ5ZnJQWkczQjhL?=
 =?utf-8?B?a0c5WkFNbXYvak85MVZvT2dUVmp6dGxnaHF0bUg3dnFrSjB2M01HbmhGK2pK?=
 =?utf-8?B?RVNrdGcwUVBrVnluSnQ0VER5UTR0SUhramdwT0JhK0FieStCUGdtekt6bDc4?=
 =?utf-8?B?ejI0eVlpKyt6WHdydEQvNTdwTGt6dDNIN0xTUXJsY29xSzh5TlQrMFNvd3U1?=
 =?utf-8?B?Rm56M2grNUJlckVaNU0vZjc3bXpwNllMTFZtaUJqUW5KdjhkakF4N3lCaTNC?=
 =?utf-8?B?NHZINkNrOVRMd0w2UkthOGpydTJzVHd3N0cwQnN6ZFFSZVVLTVIwWVZZSUpK?=
 =?utf-8?B?Q0Mxb25hRk9GcUZ3TlNWSE44dEF3c0Q0dmZKUlE1Z2YvUW5IRVNyTjNoSDlr?=
 =?utf-8?B?WHdSZzJjd3hiQWJ2SzFtc0FZNjlpYkFGb1lraDRLWm9sSDEzVjdWRlE4SU5v?=
 =?utf-8?B?cEc1OWJRZ0V5WTlFemozWHdUUzl3dHhSQ0sxdFpXKzVhd2djOGhJUTBkTWMw?=
 =?utf-8?B?MXZrTXgxRGJNUFRoTnJaR1BEL1N4NXZpNHR5L3ltTUF5OXhPMGFsYk1SVW01?=
 =?utf-8?B?TVFEOVcxaUNwTU9nREVzZFhRVERSMlVYQzhFYzc5WTBsL1hGN2U5bXVtVmZy?=
 =?utf-8?B?YnZQSWw2UzZaOWxSTFY0NjhsYThibm9heitoNEtvYnhwM2ExZWpXZUxrOTF6?=
 =?utf-8?Q?ZJeBRdSG4lMV+HRnW3GGsI9jo?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52486aea-e74f-4ed4-eaf3-08dc628e30ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 05:36:42.7678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01d8S19zvc6voGVkF6k81hYtEyRwe3kyko6ZpJfHHHhvC3JrEO1G5znt9yyXniz8iV7zn77tsnSEsDozGNHd8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5622

On 22.04.24 01:50, Guenter Roeck wrote:
> On Mon, Sep 13, 2021 at 01:41:43PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Prominent userspace - systemd - cannot handle watchdogs without
>> WDIOF_SETTIMEOUT, even if it was configured to the same time as the
>> driver selected or was used by firmware to start the watchdog. To avoid
>> failing in this case, implement a handler that only fails if a deviating
>> set_timeout is requested.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> NACK.
> 
> This will need to be fixed in systemd. set_timeout is and will remain
> optional.

Err, this patch was sent in 2021, and even systemd is long fixed (since
v250).

Jan

-- 
Siemens AG, Technology
Linux Expert Center


