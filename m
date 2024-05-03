Return-Path: <linux-kernel+bounces-167887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC68BB0B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69966B23236
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B27155390;
	Fri,  3 May 2024 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M3epRtc5"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B54AEE5;
	Fri,  3 May 2024 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752886; cv=fail; b=YJk8/Objsg4K6fyrGOorbeh+/PZzlYpBoppgEguJNHcpNQQ/CMqEstQa/40PJmoAE6cpItgtLSlTEztYmgtC1SqKOJ6LiPgSclfqbRpo9YJdZcqO3KTtVnOIw9wirJFXmQbmOgNWT0dG1ynyPPbf4DL7uL+wQRw/Xm0GM76+dEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752886; c=relaxed/simple;
	bh=CKbV4zp+tpMEyDmoGYF0S7JLIRRzCmU/P1T8BmV9uR4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rjdtq3V7xAFUfqbzTionHgw4ABQXM55TxLj4O2Gn0W60H23+uxP6zLzcfAw2vONML9TKzIqSw2tDoU+M8u6L7fCdwH64VzgplC1pXLpicVcxwVsgIe9MrlH5f8vMSSVAyiOqeXLHE9YZNVz1y2EbhBNiqRKXHc8k0VDP6D2y4/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M3epRtc5; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9Boz0PChzIuzkIlc0mhmmTKNq1SQ7NId3byeZ8dvfcNnOroEBeD9NvG85bSbDPf3eTbuFJayDF1d+oRtTnhwDXT8/W9wOjtNVmyYhH4sLmC1hwV3cBevzvW4ziGGwTNMtcov8j7hQKCMpVZFWwJEsZAr6oDMFXsrYgGT6k9GGfhkQqgbZDS4jzSarEOWrBxhADuVEbWdQnZ79REjnILHArUASpyRtWjHa/NDv9SdrIj/Kqmo6+n+E2eawPUnk2ZRL486OyceN2jzrvq9ulEa5WvnJAiOqik0yPCYP3a2m5/e0z/2atEmUamojPcUvpwR6NiGiW6sB9LRA08ItA4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pT2OLljLreaUvvmh3qwadSS/01qh4C+NlniZag/VWi4=;
 b=T3buKtWPGosoNOiAKYOY/bJr4Q+B5+XIBaMAec9JBJ42SQos8LhYIIEioZ/Jr/o6UPv0Yqhh3VBWTwxG00LZimEJlna8X+rg27EgfphpHYYSLS4jMOlIg8w0y5vd9aKo0fXMFpnt4PK3Ch4nJRwwV4GpsWDXNjF0hG3LwtueVUOkctf5Xzqaftlfb/OcP4QdN7xU8o5qlNUkXH5FHEW/2xNTvImdtQ6ol6jSlap/1xROu9RJvWp1s7pzdNbes81rK0kVSxc/XrJzwe+S0jCh+3DApbL12og2+ue35efE/Lf3hyQFXrYi+5jDiBCCEqsGxo/VIRxQKcLn+3mY0CT/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pT2OLljLreaUvvmh3qwadSS/01qh4C+NlniZag/VWi4=;
 b=M3epRtc5WkfXkiHMtZ46r5Y3YBxv0VoO1E1tiZScVnQSq4gjD8pXg7EJNCL8jYiT2EoskLzhrSArh1ypzTO4Ng+tKjpbLfrw4nDAW9l8fusUsQ9vNTVn24JiR4Aje5lnQbRtwEapHX7cwT10DaG/CY6RZrims3Nj9+v/ipWZtC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Fri, 3 May
 2024 16:14:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 16:14:33 +0000
Message-ID: <4cfe9c47-4736-b08c-50a3-5d7a11246b5b@amd.com>
Date: Fri, 3 May 2024 11:14:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 17/17] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
 <CALPaoCihU+mat2A-wNtTm=qbpya8ZqhDURsfZfjuHitch0WrLA@mail.gmail.com>
 <9d59d38b-af1a-46d8-81c4-b426d47d4ed6@amd.com>
 <CALPaoCgFEybS5MhsPx4EaJmsfBe8Es_6QwWBXpoctdaNf0NcMQ@mail.gmail.com>
 <80c56417-3d74-7d68-1228-9cd944567b4e@amd.com>
 <c8a23c54-237c-4ebb-9c88-39606b9ae1ab@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <c8a23c54-237c-4ebb-9c88-39606b9ae1ab@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:806:6f::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 857ef18b-3fc8-47a3-3cfa-08dc6b8c1eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGpBZ0xVQXpRVTh0dFFFYXZMc0V2L1dBcDhOUjRhSzFXM1pqRzRUd0tERk9h?=
 =?utf-8?B?TDVVMkJnVXpad2l5WUpISU9SVEE3V3I5aXJMQnlodS84TWorekMra2tTM2Rt?=
 =?utf-8?B?TmtXNkE0OWdtMGxINVRxUW9FaWZ0OWxuOXZST1VsZDFPOEsrcnFpR2JScDE0?=
 =?utf-8?B?M0JuSU1UN1l2T1QyMS9GMmtPSlM0WS9laFRDMzNkQTEzV05MRmFNVS9nUWND?=
 =?utf-8?B?d21jeDVHT3ZFOFBsSFE0Nmh5SUVMZTROaDBKREdldFNnb1ovQU02K2l3bnNS?=
 =?utf-8?B?VGRMM1llOXNrNnhlazkrZGJXanVKd3poNk9GM0JoVElseWZOcDVEajhXbGRQ?=
 =?utf-8?B?S0MxblNHTW0wb0JLeExTVXUrU2hJcHVEMU9SbjB0T3F0V1lGSHNuYThqWThq?=
 =?utf-8?B?VUJWUHFzWDhWTFI4akRCWkoyMWkxN3NjeVBsOWE3QUJwVHVWeGltYlZvQzd1?=
 =?utf-8?B?K1VpRVpSQXpWZlJJdkJoREQ1Ynk2K2FWaXpUMEovNzVMZ1VVSXdpSmdXS0NX?=
 =?utf-8?B?QWtJZkRkQnhKMi9ZZWFHbUQ0NG44cyt4WkJiajlobFkwNktyMGNzUG5Edncx?=
 =?utf-8?B?TE5KN0M3RFVHaVE0R2QzREU0OGtMQ0t1OGU0QVhzRm9SME90OTlnMm5pWnpl?=
 =?utf-8?B?NHJzbldsS2VjZVViVGwweEM1Y2h4STh4UzBGOXp5L0VLb3IxL3VlREREOVFV?=
 =?utf-8?B?UHJscFNJb0VIcFJIb09oWVpLbjQxVEh2d3krQVBKSXpmSEk2TDl6V01DY1F6?=
 =?utf-8?B?V1JpZFR0Q1ZLSjdTamFNeGRnTTJ4dkxtcWpzaExMV2NsWHBHYUM5VmZPeTNY?=
 =?utf-8?B?YkVjdjB2UW8wb2Zha0ZCYkJkM1EzTnlYdDA0MGtQZGZVa2daTzZqQWoyS3Z1?=
 =?utf-8?B?MGVET2FpS0N4RThCd2gyOEc0TFZ3MVJ4STVidGN6elB2WW82VGNlS0FneFlO?=
 =?utf-8?B?Sm5rR0tjSWNYYzVlZFJIYjd2VHlzbWtEc2FIZGVwKzUrUzdjdUdhV3M2MzVK?=
 =?utf-8?B?TWhSdldQMFVsK01qelNYMzRrTG5mV21xeFptT2ZFTzhVN0hzZkorQU9Na1Bu?=
 =?utf-8?B?Y1paQWNjRmJkNkZLN1RRaTkzaEgySVFINzI1aFhRV25oSUFmMjJLaXRlaFhO?=
 =?utf-8?B?SHdnUGZBU01tZUpNRDBJa1FuVmUxZ3ovcksrVEdmZmZtbHdWQkE1MXhWSENM?=
 =?utf-8?B?NG4vcG1MNHlEUUlvdjJKUnJMZWNwTllWSGJ1OVVTZzNvYXErNFlqaHdzbEN1?=
 =?utf-8?B?Y01tOHZESW1nNjZYY2F3OVdqaU56U01oY3BleThGZVJ1cU9vUDBobFZqL2kz?=
 =?utf-8?B?bFBVRGdQNEc4Qi9ic3BtWkFqL2phSUk2d3VOUWRpaTFlS214bmxYZmN1YThj?=
 =?utf-8?B?UlpvS2FiNXY2Tk9mNzZZOTJKUGxBUUJseG9veVBSYk1FaDRuYUVwQTZtV1pz?=
 =?utf-8?B?dVJNUG1xSnEyOUpBVmtWMnZuRk5wSldqUUZQQWcvc3Jmb0Y1R1JvVGVPZ2kz?=
 =?utf-8?B?OVJ2Qyt1NDJoUTU2NVdDN283NWs0RVF4cnRFQ0ZMaVk3dC81Wi96ZjNmSTV4?=
 =?utf-8?B?YjZjYUg5WXI4TFc2akV4bzBMR1dyeDJqT21ONE1HdWd2MnI1SW1nQUxPTHdt?=
 =?utf-8?B?MVNJdFhpNUZMMjlQNVZTS3NIbUk3U08wQU00UDhZVHlBemRtTmVXZXJWV01Q?=
 =?utf-8?B?a1haR1hEKzBEY2JYbVZ6aXJVemRoTkhqYUJINkFHamxlYnlUcUhKWitnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZURkUkNkUkNjWERNYTFybUFYWUhDYk9iRFVoSk1kQ0tiQlBHYnQ4VFl1NjNq?=
 =?utf-8?B?c2U3bEhYNFc4UTVid084ZlBHdDdiQ2RWc0ZHYmkvUXdHc2o4NFk3SzRaT2pU?=
 =?utf-8?B?Y3N5ZDRydytBbGJGdDQweHVsNm5DTFBTWFo0SW42U0tDZFFtS3Nod21kV1Zs?=
 =?utf-8?B?eCt3bmdoeFlvcHdpQjk5KzZ3T2pMZmZzQURBTkpYWjN1U3V4UUVPSEVDUGFB?=
 =?utf-8?B?Y0h0V2srRCt4dHA0bExmdkVWNjQrWHg2dXBzWFkzdXBnUm4wRzdoeFBoUmNx?=
 =?utf-8?B?NXdEOGV1SVBRQVYvTmZBWGc2U1VuVDdVR2xOYnlrTlgwaStnTk9HTG1Hbjd6?=
 =?utf-8?B?RWxvMXZqaTl4bTFVN2FYenl5RTRrS0IvaFppMWVlS3VCbmtnc3VRRVNLdTF2?=
 =?utf-8?B?elRVTTgvWkdsUEd4akVOVnNoVDc2Nk52dEZzdytEYjhyZEordTZjbHA3S29l?=
 =?utf-8?B?dUYveThnc3EzZ2hiYkF0WkZRR1BOUDdhVDd6cnVqdTg5Qk9pSDFPWE5naU40?=
 =?utf-8?B?azlYL1NmdUk4K0VXNnlDdG1TNmNuS1d5RTdDc0tZRVZ3WjdBNWtZaTU1SGkr?=
 =?utf-8?B?eTk3cjQ1SmJMcmJyd3pRdm9HdDNLSWY5Y0szZW1Bam5hRlQrbWEzeUVWQjFT?=
 =?utf-8?B?Q25BWjNlMHhQdlF1VEoxTG01NU9ZeXU3d1EwTDRvYUdkazBmMGJaS3pDc3Z2?=
 =?utf-8?B?aXFMTWJEcjlDdWZaeFdabGYranNBb0FCMnNtWkROZnAyMmZQSE55M1VIUllH?=
 =?utf-8?B?ZXBJQnBVTDZ5OXk5a09oZEhRUEdoNDFtSlVkQXIwbUFrUUE2N3oyY0Z4dlhH?=
 =?utf-8?B?SjF1RmdYTm9xQUpYZWZVZlpqbFdCaW00Y25KbjJ4SkswNk93K3dGdXdPcE92?=
 =?utf-8?B?NGMvN2hWTUxDb3dJaDJucjNIRTFXWThvT3Njak1adG9EdGdGN3FXVjRNRTRO?=
 =?utf-8?B?UmY5OWRtOEVWeDBXNndrZFN1VGh5czRib1huZUdGcUROazVDZDQ3V1haNlRx?=
 =?utf-8?B?dzAxbWY4SUhzOEJFV2JxdXEreW9KUUcyY3NYOWtrV1REVVdzZzc1eGltWHlh?=
 =?utf-8?B?SzNFK3BhQ3N5dUlTSFpRVGhIRmhISjRrbzV6eDhVM05zeXI2dEg3NGZkVUZR?=
 =?utf-8?B?TnlIc2VwUDFneDhnSG51WjIyWG1wYTJJUWNJcGlhTzlHZVBtRTZyZk9TbHpv?=
 =?utf-8?B?eVIvTWxxZk9zTkRGbVdkcnczTmtoTm9BdFYwMUIrOVN5L3NnSmdWTmV1ZDly?=
 =?utf-8?B?RjI4ZTI3Z0RSeWMzZXZCdkxBcTZEUE1ZT2piZnAycTliczcwYjVyWjFpbFFs?=
 =?utf-8?B?dW5Ec0JEakpXQXVwd1dLU0FCb0NuRWFaSXdwOWh2RHdCK3orTmRzaE1pUjFX?=
 =?utf-8?B?bzlPd0lXTGM4c3lGSTlZZm9iMFNlSi9NcTN6Q3RONW5oRFRHSWN6UndsMUpp?=
 =?utf-8?B?RHhXWElJK2h6bmJDVS81L01idjg3SXNyRDc1WW1hTFg4T1piSnBiUVdFdnB4?=
 =?utf-8?B?L21pZndqUElvRHBvLzdRRElDcWVyV3RzaHJEdFFYOEdEdFRINDlEbmN6dTRB?=
 =?utf-8?B?VHpvTkNXUnAwT1R3SXFaSVpVUG5RVUU1VUtQdlBmeDkxbVViS3U5M2FYQURk?=
 =?utf-8?B?RFkzUUVmMXJOYjcvYlFjOSsvSk5UYTNpazB6T2xjM3RvYzNwNCs4VktobVYz?=
 =?utf-8?B?cWV5Z25qV2k3RVN6aTh1RmlCejhqeFFpOW1MZFkrV1F0VWI1dWJhb1RIMk82?=
 =?utf-8?B?ZnlWWkQydSt5aUJ3dXQvTW0xS093QktUMnRVT2l3dGR1RGJyRkVvNkZuaVVQ?=
 =?utf-8?B?TSt5WVpoRkp0eVM3MWlOK3l3T0puMmNnWk1Fc2pjOVdoSUREci95ZWc2QVRM?=
 =?utf-8?B?OTd2ZnRPSlc5NitsSnNzeGhSVXRpcEYwTnhsQ2tWTmxrbmI4VWE1elRDYmFY?=
 =?utf-8?B?SmtkemdqYmhYLy96Ny9VM3h6cHFmbENZOTFaZHBQU2d1SEszWWoyaUROdG5t?=
 =?utf-8?B?QnRGSXh2WlZmd2lsM1VVWTZpM3N5d1htUjNSVEdHNG9zYmRFYVk5SStMR0dL?=
 =?utf-8?B?VCtwb2RQZjlyTGNtWDdnVlZ3UzRQSE43bDhsa3psZVpGRFR1dnZYL2dCd1lN?=
 =?utf-8?Q?p2yicEG8UqbiO4veMUKxa8rmO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857ef18b-3fc8-47a3-3cfa-08dc6b8c1eb1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 16:14:33.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RW1nDOZP6JAUKXzKT3ElwVNQYMHM/NcnzgpmOadfTJTSu56rykxKpLMgpvD1vyka
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756

Hi Reinette,

Email issues. Responding again..

On 5/2/2024 6:00 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/17/2024 3:52 PM, Moger, Babu wrote:
>> Hi Peter,
>>
>> On 4/17/2024 3:56 PM, Peter Newman wrote:
>>> Hi Babu,
>>>
>>> On Wed, Apr 17, 2024 at 12:39 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>> On 4/17/24 12:45, Peter Newman wrote:
>>>>> On Thu, Mar 28, 2024 at 6:10 PM Babu Moger <babu.moger@amd.com> wrote:
>>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>>>> index 2d96565501ab..64ec70637c66 100644
>>>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>>>> @@ -328,6 +328,77 @@ with the following files:
>>>>>>            None of events are assigned on this mon group. This is a child
>>>>>>            monitor group of the non default control mon group.
>>>>>>
>>>>>> +       Assignment state can be updated by writing to this interface.
>>>>>> +
>>>>>> +       NOTE: Assignment on one domain applied on all the domains. User can
>>>>>> +       pass one valid domain and assignment will be updated on all the
>>>>>> +       available domains.
>>>>> How would different assignments to different domains work? If the
>>>>> allocations are global, then the allocated monitor ID is available to
>>>>> all domains whether they use it or not.
>>>> That is correct.
>>>> [A] Hardware counters(max 2 per group) are allocated at the group level.
>>>> So, those counters are available to all the domains on that group. I will
>>>> maintain a bitmap at the domain level. The bitmap will be set on the
>>>> domains where assignment is applied and IPIs are sent. IPIs will not be
>>>> sent to other domains.
>>> Unless the monitor allocation is scoped at the domain level, I don't
>>> see much point in implementing the per-domain parsing today, as the
>>> only benefit is avoiding IPIs to domains whose counters you don't plan
>>> to read.
>>
>> In that case lets remove the domain specific assignments. We can avoid some code complexity.
>>
> 
> As I understand counters are scoped at the domain level and it is
> an implementation choice to make the allocation global. (Similar to
> the decision to make CLOSIDs global.)
> 
> Could you please elaborate how you plan to remove domain specific
> assignments? I do think it needs to remain as part of the user interface
> so I wonder if this may look like only "*=<flags>" is supported on
> these systems and attempting to assign an individual domain may fail
> with "not supported".

This series applies the assignment to all the domains.

For example:

# echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

User here wants to assign a monitor to total event on domain 0.
But this series applies monitor to all the domains in the system. IPIs 
will be sent to all the domains.
Basically this is equivalent to

# echo "//*=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control


I was thinking of adding domain specific assignment in next version. 
That involves adding a new field in rdt_domain to keep track of assignment.
Peter suggested it may not be much of a value add for his usage model.
Thanks
- Babu Moger

