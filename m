Return-Path: <linux-kernel+bounces-77830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33371860ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6068D1C21013
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5912B68;
	Fri, 23 Feb 2024 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ab5SS05t"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2019.outbound.protection.outlook.com [40.92.41.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E46BDF62
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669359; cv=fail; b=qAivPAwQul+deb9Xdl/zl+7o4ADBmUU/yztPEKQE+RdHSpkImQIL2Ik8PG6r/K78qRBX0D6bOJ0eLLnMwsSSA7OxpCgDo+PS0gHj2v1v3PZcWnDXiNKJf4xoZe105nZ3RI+bSMRB25Z691SPIUW+yKrukUKfg3i2OUdKipph91M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669359; c=relaxed/simple;
	bh=LugKMLnbjNhlM2aRswY6R0/Z+fjv9AG2fYiDeIJN5XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IUxSgeDHdbby+nn5s1V/tqy/RT1eW0MieYC7CxUtIvmKPylvOMLmO0tzVCm1v8u4m8MQqEMnTEXeirP4gpiCTy/iFkug29rwRXt1eQGIsOJHhFP/tYbC1luD6MlXpywFMbnX1GJHFdl0IzJdBmC0SS+3gf/6ZDWZAoh9u+pMLEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ab5SS05t; arc=fail smtp.client-ip=40.92.41.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEyTs2hPhjPfRum8CcNj6UsjzaZw9MsodsUsRac8cm1+Y27neQMRz1CNXLRG0EmQbyFrE10KNTUJeuQkldyLlY45otwEzlC3C2meISlZpS9tuXX3250/R3BAbB8Z6hxi0hnDtO2zqL4VvqbqhVAQPaPRYLHdRRqgO6Fq58n+4gLK098Rvg0XCaxVoFmo3ujX/srlsM3DFdcA+kFmb+tMtO8p92B5PI9arW4sj6nnS1xwW+uh2M7411NL6O0Bli18LsaXIYaub5qNy8fPie7VRUX7RqUa4uDPhlbLPSekcBSFbJVUpy/buvHX3UtH60KjxtSQFzTiej2IhmhPGrKvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqSridJMXPFKunDrW1ANSV0J8pNUt+gGcMuXiwqj+/U=;
 b=ZCKAKLR9RgbAC0Mt5eZy/Umd25iJRPAM6viATw4fo5agXm+YbYc0z3YQO9uTMNoKtCmcU3L3oYp9QxbXVJj3E+yFok2S4qrKWJhQ9edp0P7zIGv/Fp/C2BZQ7zqXC6kpzRY6MTrlosKU2wLvlw5MNenaBVk93uWIsHHKjHCmF7vS9PF9BJ6fyMeflGiEOfacEzoN6Qab5vEKo3IwpqOQpsxG6HnEnd8D32xOH1pQTL9n1LSnGxjlSGU5R4TNEx1fr9r7mvcosHzN0qzmqMbzDeDG3BVt5GQ4OV0p+AwVuVbz5mVkbMrSezSTY1SUjObY8n2moM9mPTgefqp+sc6QvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqSridJMXPFKunDrW1ANSV0J8pNUt+gGcMuXiwqj+/U=;
 b=Ab5SS05tMpvDyWOix0btRcnkXS4btgKAPDxGuiFZdxJ67KTkyJZM6YOFbcFAGu+xNPF4uXaLKSKNNg8UkX37GuJTf9lNCYW9suyoWkhjAvKWxI2fkuOjky6iatrtPIMMZgw8oxx0psuZ74L1DD8ZJASzA3c2x70DZsXV5i93bqnSZecFv5SJzIN6GLo4fxPC2U5KI7tRbj6HDA11YF3XKSUA6oUV0fQpqmRSvS9abW5IMj4A851kqIDXgmT5nV4oRJa7zO4kGYvSFj28py+tW25gtbvDfrpf342CdcVlPgq/PY7ce6AeW8895p87ojjR5HygDfQWRZ0iseasty5SjA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BLAPR20MB4129.namprd20.prod.outlook.com (2603:10b6:208:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 06:22:35 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 06:22:35 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Conor Dooley <conor@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] MAINTAINERS: Setup proper info for SOPHGO vendor support
Date: Fri, 23 Feb 2024 14:22:38 +0800
Message-ID:
 <IA1PR20MB4953991E1042FF0057AFB83DBB552@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <IA1PR20MB4953B158F6F575840F3D4267BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953B158F6F575840F3D4267BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TMN: [MFXvf2xN+zPvoyZo41kA+CeQwC9b/SCQ58fXtGjBi44=]
X-ClientProxiedBy: TYCP286CA0112.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <170866929772.213456.12954850815385987104.b4-ty@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BLAPR20MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaacf49-b961-4254-bd91-08dc3437d348
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iA3lJ9naNaCSRgN+9HtjVWNJv2qt5qHg3/BpQv1QRkBhBAHaavQUMX6BHWn57TmVlOeX6TzKOrl1oqdA/yQzgikE30U+ghmvGFyjPSrpLrEWLLAlX7lSVDvUHJuMAqJBbC8bKfEuyx9gFjswcVKhGqh9Kj+veTUyW8E1iQoOOqtNEuVNxFwuXmQ4sB8vdPek8Im+Dom/areGL1jdP1VFZrDJUrZIkP+p0Met68/CuW1DFXlQoMbRQWg1hYzV1GFHWVY8iAoR9SQLZZT4ctP0sssC33LwzKHyt0biSUhOmHck+5+/eoA0MOkR2rPly6lYFyWf4BVaUpEgyLBV1vqX2KpTW4lrCCi1nDe8U53JJmEJzTqG0w074MbJhq72PFNQBLurkkaQ/qTDWczh+cHnuRnU8kvTNq5d9WRtp5dlx0KxJNmpMvjrIZpwgpxxqr7l4ovMxHYYuTAI2BFDUKbMKLKGg8MMbeKcYgZtt2Z5nhuAI7TAHFUH2EeET3dPE7qPYU3Mb59bqO/1JjdTiuT+MC5DkaWnCiYN2+t9V4wws75On0yXPJbqS9fYWoUOUbNbcgoqeeTpessB0Mh9ZSMVSQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amJLMDhCbGJDUGpHdXd5OVlFWVA5VndZankzZThHaVgwK3I2dGttTWdpdHFz?=
 =?utf-8?B?bVp3cHBKcnVWZ3Z0SWcxSHJwMUFSNGFXM1FrNWs0M2RqRzJDU3dWY1lWeHQy?=
 =?utf-8?B?T0JqT2V0Yk9TSlB0TEtqSVJ3UnJjTUQ0TUFnUHhaV0hJVXRlNEFKVU53Zmpn?=
 =?utf-8?B?Qys2UVdqNzFNYnRvdFhXL2tUUWk1ZFRsK00wVVN6OE5SSTcxaTJVK2lrbzhM?=
 =?utf-8?B?WU1YYXdxSzViRE4xa082MWZnYmEraFk3MkpqbUREOTI5S2prWjE1R2F4ai9h?=
 =?utf-8?B?YW9Gb0dCT0dNTW1XZXJIdmpwZVRERXc4KzJEdjlxWFlBUnFBUnRsNGY4TWtL?=
 =?utf-8?B?WFlub3BGVEhreDJnTGp3NHJuRkFUTkpRZm5UWVl2dFdyUGNjcWgzb2U3TGlx?=
 =?utf-8?B?eHM1UkpMT1l1YW5CWHczWUZUWHRQcVg2cFhxSjZaL3NwTU5mRFZTYkI5M0Z6?=
 =?utf-8?B?aFNWWS9vckZwUzM0U2JzaVFLVUtvN2JNalcraGx5Z3lCRnZwekxndXVEZXhT?=
 =?utf-8?B?bXB5VEdhWnJHQ1JCOWR6V0l1eHMwY3ZteXhVMzV6S2Nka3IyNWNJSnhyN2RP?=
 =?utf-8?B?L1gyTy8xOEU2YTA5MVFieWFEeXY4VzRUUzVrNUN6dHFNZGNQNlEvb1lRMzB3?=
 =?utf-8?B?NWw2b1RaejVZeVY3VElaSjNHbURMaWMwbFFSOHFkVmdSS05tT01oMVpXby9n?=
 =?utf-8?B?U3EraXpsOXhlL3dwL0F1eU56Z0lvZUZaNFFCNG03YWY2NEh1UlozTTJCL3k5?=
 =?utf-8?B?YXFJZHo4ZWxnK2RDcmdnck0wbDNSZW84U2F3cW9Pa1BybTdBbzVkSWdFVFZN?=
 =?utf-8?B?dGs0S1hENVRRdHcyVzNxNC9wWlRvUmNPcEhhdTFTZ3BDMGg1dU9abUhNTFdj?=
 =?utf-8?B?UVArLzlHbmR2NGVvYlFPMWNPMFBWUUp3dTczR2lNTUd4RVR3Ym1LS1lnSDAy?=
 =?utf-8?B?UVkyd3o4bCtwOXlBWHJ1TG9yOHVGbkhDQlRxcEE2Z2ROZklIc2N2TnVNdnU4?=
 =?utf-8?B?K3VNVzdUYmEzNzZMdlM5WWxTbVNOWVYyL1dwYXd0ZEZ0elk0bTdOdmpwcDFG?=
 =?utf-8?B?MGdDNzlrVm93Rzk3Ti9yand0K2FlQVBGT241WWVhN0ZrMXZwT2UxYXorbnNH?=
 =?utf-8?B?bS9aZUdFeWp0dG5kWXJhSVlvZ3Nub0FERUluTW5wSkpSZ1lEeHV1emVMY3k3?=
 =?utf-8?B?bGxiZ3NUazNEODlxZ0tyWkYwV1ZJU2lPZGQxaGJUNk9GWUx5YnhITkg4TUdu?=
 =?utf-8?B?b0NOTUVBd3FOZ25xWGNodkIyRlVPenRKWlNERGtocy9VeER6bUJGOVZ5aUtX?=
 =?utf-8?B?RUJTNW51Vk9rOE40eXJzOHBvM3JhOHhFZFppZjJZWStRNnp1c1RJVkdDd0t0?=
 =?utf-8?B?dS9XNGd4dXh6Nkx5VzR4SSttdmtSL1JPU0Fsc29hRis5ZG5LVTB6NTdZTUky?=
 =?utf-8?B?N0NnSHpXVzJPOXdqUjFqNUtBdEJTTXl4QTNmUWg2WW9mWEJmQ00zWEwvc1dk?=
 =?utf-8?B?YkxScnRhdDRVbDdRSEJHVzd4U0hrdkJ5N2x0UVMzWFgwc08rdWhlZ3AvOTRE?=
 =?utf-8?B?eFcwcGk3dThDNXprbVBLUnlvQWVFVE5sd2U1dnN6NVRlSHcwL25ybERaSDhG?=
 =?utf-8?B?ZkEzSDlKRU9LRWtSSTdtOUlvSU1nL2xFTzczNkpQQmo5bVloY3hnRk5ZV3BK?=
 =?utf-8?Q?0KuN/eE/8oKytsoGjfWO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaacf49-b961-4254-bd91-08dc3437d348
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 06:22:35.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR20MB4129

On Tue, 30 Jan 2024 09:40:42 +0800, Inochi Amaoto wrote:
> Add git tree that maintaines sophgo vendor code.
> Also replace Chao Wei with myself, since he does not have enough time.
> Since sophgo vendor code is maintained, remove itself from
> `RISC-V MISC SOC`
> 
> 

Applied to sophgo/for-next, thanks!

[1/1] MAINTAINERS: Setup proper info for SOPHGO vendor support
      https://github.com/sophgo/linux/commit/0f46e1339ef113f0dedf7ad376452cc722dbcfe6

Thanks,
Inochi


