Return-Path: <linux-kernel+bounces-154702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2F38ADFED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AB228229C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7B454FAD;
	Tue, 23 Apr 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Yg3+oDS+"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2105.outbound.protection.outlook.com [40.92.42.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F056B79;
	Tue, 23 Apr 2024 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861615; cv=fail; b=q4R+PicU/wW/GRnsJ4e435obIzXzLUDpYvhsGLtezD07azW+kc73b0ja4Mj9T2OUVMrVDkxi7YpUYzHH8OwM30F0nSA0Cj1FX8JlX7hlSVgSePmBjDeiBhTlgYW44JMQ9yg9y62hfedU7rCVAmJPef6GoxNnZHJEj+oqaUf+//4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861615; c=relaxed/simple;
	bh=9ecqAseZazkZOSp/DwoNVmlWLvP1iqroSQchSk8S6Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pJiOVb2Qsm+w5jEQIcOb++AKDWr1N0ANyvHtKz/lm3EVHg+Qj+Z11QS46zZucFXy6tcjufiYOHxnXvCwmOepoGqAZctf3TLORoSjLTdx8nblHAQUPxukDCmewWqIX8MxSUri5/tN891ZCrhTSlFYtHEqudaLzmoDVuC8Ghl3/6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Yg3+oDS+; arc=fail smtp.client-ip=40.92.42.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1mMOT/cX09U3Uh+grUiFuYmbMe4zCmul/lJtpq8gXHvjCawRrpxipqLAomJVGgFrZRz0LKGkkgO8kMs2UijnAzIzzTxUnsKrSON0PvpwLW+vhwUchZ7GcmAjgPk5OykD+uIxXUEtS34MBNCKqkkahSvWkop71ovXpmnHQnP/uJD+LSZLPG6CowgovsI1UFgMktvXGwrx8zy6NfaprQtHgROvg3nzGmsU513OoYEf2u+mxF1cVbIf2AU5C9leTN+Z/Cec1qCdnS1uJNfcGCloWLlrF4C8QomSGyivWaZmF+OEXestoDeErtfGXbFyI0XhBOEVi6WmomhukrvpMEoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFSZ0vtxkwn16nyxP7zOjZRu5mD2GuA6Bfe08Gmsu50=;
 b=cw7iaixiEWtxnIXv+Ykq82uEqgRIQ1Fl0cpqKGMQt7/qtNtLEyqeIysGqtcTg/WUGqRYNROOABdWbXlsOCa0Gdm078YHE8X7gdT0PLiFi2WAQqh0+brMJIuHrRKJZtcEhQ9XfZCQ+OUOyLuQ8uG3V4QBgl8DQhK8OwpfHvN3A2nI6sgONuNPl1aWdJnVhtDI2ssw9+R7bHq/2aoIFYaZMz7NAhiqDdnGMD9eCYL5Cvzk/O2w65zzrBJ1xtNKf6CGlnyW7S0J6DoBBhflxDb2RchuOyKd825inVywz7nMH8tY3STeWIKUtKcSWhJO/1b65pJZNVqL28M06MP5FrZwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFSZ0vtxkwn16nyxP7zOjZRu5mD2GuA6Bfe08Gmsu50=;
 b=Yg3+oDS+Vd7zKYJ0w5kefXxCvhsTnV/p4irtXK/2san4dcuVxjfuJJErpRm58MfpTUNmEFLLp/CjJ01E7BGUDLU9Ok8Gt4yhDX5GJ5BCBf24T6oLdHvWUBKmKWQVB5Xwzzywm6q3VT7hexscKOoC1B1YM3iqQ85J9I+xfd/cLaC1bU6Gl/XmVBaFNlsS8Wz3/6GSqRhp5EXB3kt6xlybPvGiIJkp7SuZ5w+qI1NkyPqBhU7xKwVmZmdYXpHjKaznMvWSqZLvk8k2OgAUoz5htwa8M1AOTR4BI07DxyYbp/oGUqrKrVQi1qqiWJXpH2IkTJv7WCSBP7W4nQVWDOUqtA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN2PR20MB3335.namprd20.prod.outlook.com (2603:10b6:208:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:40:11 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 08:40:11 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Drew Fustini <dfustini@baylibre.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: add reserved memory node for CV1800B
Date: Tue, 23 Apr 2024 16:40:28 +0800
Message-ID:
 <IA1PR20MB49535871D139131CBC913036BB112@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB49531F274753B04A5547DB59BB052@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49531F274753B04A5547DB59BB052@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TMN: [IWhmVXR4aNR3H7qlrgSJGd+KDvij3eF6iHjzHsSeGjE=]
X-ClientProxiedBy: KL1PR0401CA0024.apcprd04.prod.outlook.com
 (2603:1096:820:e::11) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <171386151250.888417.16344348642120969607.b4-ty@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN2PR20MB3335:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e94995-7cbf-472d-4ea7-08dc6370fd07
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0jY5PXmrAMa98EFNxkxFA3gwSn2HkdrJXBKphS5XPPg2stAn/5KOojiNKLEABGaTLS6s/kfIB/7PSE4mtJCGnGTs1HZ2/qRao/e29l0h5YYmQ8Y4h4E6ehslQLWfd6i1eg0GQB+vEaESNHcya2mfRpba3IsZNESTQPY6D0YaktFkmBq8kPhejiIj6EJ45kXUtAaCxZIGxv8hPPnFBO4oSbQX0UT7lE4j3qmyHp2hak5PqOMBdhZZu8WlWMzsWt8++KkfaPD3SJtqrxwpyGa0BA3vwZztCB2EC3RR1qD/HhuovHNdQZZ0rwv+fhMOKkFz4Zxs5w2oOx2jHL3ilwMCZS5QZvX9GxeleMZTXnIzqqLZ9tsOMDH0/zHdxs7lT9T5lS0dA57+CQK/4Z9nmklkA+QerdD6RAMs67i//0BKwqGbkEiGAwiX9xxRJQH5D+0sgrw4mJWV9FNbnMAv1Oc2QYZCmOyQPg5InmLCPgdk2pnDPZ/JVvrQH/FPYMxilmJDpCQEg61cDiGRDuhndSQ5QhLvGL2mYJXmgPdWCt1Q9zO12vTPSbN+q/zA1JuCFF0/JTRXSMHTmjB12DwOTZ08Bf35eamFshaTSC9c9uDf5h/upp6BRFDZrOCReypp8VadyB82IKWVXma81dKX7IvZ9EKO+6QVFv7GWjSVyzNfgepqC15+1qslddDP7/jwyWdR
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFpXY3d2VnQ3aWhxOC9iTHhpK3JyNWFUSnpsblluYlgrSFJTbzJPRDdyOGlT?=
 =?utf-8?B?dDZoWTZxVFFmK2tvbjkzaGd3em5ZOTBHNkxTRzBRM2oxckZRd3hKZnRiMGFt?=
 =?utf-8?B?TDZxeXJ3Z1NpZDJ3bWFnRnk2cThZdzRuQ2NJM29aOUNpTVVnUmRNcTZuMmlS?=
 =?utf-8?B?Q0NJcEFVSG9wcnVaQUVMeGFVM3RLdGNzVXV3TC9GeTdxM0RxWXpqYXZwOWlm?=
 =?utf-8?B?WklsOXFVcmI2WThabUhtTHZQSW41NnB0TnNYb0xzbmhhdHlka1IwalZwVURr?=
 =?utf-8?B?WTFvdi9mZUJZa3ZSSHNmSmhyR0tkQzVMd09XV09Qd3VXanVLYTBpdUxXK1hm?=
 =?utf-8?B?UWNUcFFXaHNNSFJYdWlGSmNqcGpVMk5MUmNSYjM4WWw3RDFwdCtqbDl4Y2FC?=
 =?utf-8?B?SnVMMFR2bjgzbXF4bzQwNXlnTy9oRXZzYVdMS3hLajlTTUJGYzJEa1dqeU5n?=
 =?utf-8?B?dXV6dzJJZHRkZ3lXRVhGb2E0SW0yOTMyVkpoZTlDOW5Kb0ZYVjBnK05qaUlP?=
 =?utf-8?B?bzlGU2drWlh1emVpeG9zdlREYUxMcEtnL2V4MGlESkRhSndKYVYvU0dDd1Ns?=
 =?utf-8?B?ZWo4UUIxTlVpcnFXRk9TTHhkdlFja1VVSXhXWjcvQWNaR3FZeC81RWdQcEE4?=
 =?utf-8?B?NW52cjVGWFpKVWdXWjBDeTkwbHdtUWNyMjJaRTdNQ05RWEF6NXRhbTlPTFJ1?=
 =?utf-8?B?WUREYWpNdzdjMWcwSG5DR3ZwdytMQWNJTW80R0Q5emVFVlcrLzB3bEFNejJJ?=
 =?utf-8?B?dzZxL2IvL0NsZ2JlMUYxTWt4LzBiMjhDb0VmbVhRSFdOdFZLRU8rT1pPMjB5?=
 =?utf-8?B?c1pad053aEdMblhTRlNHcGJiakpwd3Bwd0F4Y3FMbzU4TjZhSHRvSmJTNkFJ?=
 =?utf-8?B?UldRTUd2VEFnRDM3QXZzY0Y3SW5udzBYSlZVZzJnY3BQQVFzU0hkanZIUG9E?=
 =?utf-8?B?RGxFRzcvRExLaHhJYnFhVWZuNSsyYThsVDc5Q0hJRWhFLzVtNFJkYXNiM2R1?=
 =?utf-8?B?SzlERUNnMExyUVNjVXBjeWtjZlBYS1oxMkpVTHcyY2NKY0IweS96Q2psaDRD?=
 =?utf-8?B?K2M4cWdDVVZkcStac29DUy9mb0NDVEZqcVBLTkZ3L2VXSDBSOFNDQlU2b3pp?=
 =?utf-8?B?NmpxeG5laXRDR0Y1L3JUaEJpTmdjV2FjWTB6ZTRUcVh6TGtaZm5hSkdTYXdT?=
 =?utf-8?B?OHUxQ1FVMVl0YjYrNHpyN09EeUFpTDVKVE5RQlAyaGk4RXJ6c2FPZ1VtTnM5?=
 =?utf-8?B?NEZkdWF1bHE3bWJjcFJnOHlQMVpQRmliMFBHTHl3aWtlTWNPQ1hpZW9PRVpF?=
 =?utf-8?B?c1NlYTVEZVhjRmdzVzdzYTU5d09EN3J5aDdkc05aVU1iSWk0VFpXRE4xN084?=
 =?utf-8?B?VysvTUhXWU9jd2tSbG1naEloUU5sclg3ZHY0cTFZdnNBVXJCU3MveEl5QTRO?=
 =?utf-8?B?R25zS2RmQ0dMa0NlRWEvQytnQWplNlBRcWNrc0hYeEl0YzNEM2lKaTNkWmta?=
 =?utf-8?B?WjFQNzA4UzdGeXdnQ0t3cVo0VkVtZGs3R25jSkpSZjdmNUtSam8rNUNSckN6?=
 =?utf-8?B?SjY4VElZN1B2c2x0Nk9WRlF2RzU2eHZ6RkVQdWF3TC9nQ1Bod1N6M2x0dFY5?=
 =?utf-8?B?K2IxUXZ6MHJWZVpGaTZwbENRYjhUc3AyTnh5U3hBOWV1WXlVVUl5dTUvWVhO?=
 =?utf-8?Q?2I1j+QFBqStsoWQqm1e+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e94995-7cbf-472d-4ea7-08dc6370fd07
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:40:11.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB3335

On Thu, 11 Apr 2024 08:45:00 +0800, Inochi Amaoto wrote:
> The original dts of CV1800B has a weird memory length as it
> contains reserved memory for coprocessor. Make this area a
> separate node so it can get the real memory length.
> 
> 

Applied to sophgo/for-next, thanks!

[1/1] riscv: dts: sophgo: add reserved memory node for CV1800B
      https://github.com/sophgo/linux/commit/1eba0b61be72506549e79dd11a132b5d73aed094

Thanks,
Inochi


