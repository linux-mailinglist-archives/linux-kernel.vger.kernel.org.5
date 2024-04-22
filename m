Return-Path: <linux-kernel+bounces-154005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2115B8AD608
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5932283A68
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E801BC41;
	Mon, 22 Apr 2024 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FPPvEGlS"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DB12F5E;
	Mon, 22 Apr 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818674; cv=fail; b=Ly/rIPkETJuRUhR4LGoy8LTUvta1Uyu1cn46fzoMn/Zu8xFBhgv6P3+ibtmt/OrGq4eHD1xqV60S6zNmhi/Gar7NUBQSB3DyY4kyA2R2n4P5YHeMlCa6sa+wbzke/XG70/bLh3HvjWgp9a1aKDUtW7DFgkfFQqb/J0T4vBTrmF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818674; c=relaxed/simple;
	bh=IaXkoj9wjJ9ZNvA/EF1aotfBV3gsf7DG1H3pmOpS/Cg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j9jFQWp3qPY/tQgTWfExzNb39derGOp/q6oSj95y3y5P9XmMgWjqgR02DcTZ+d+A9vSAcbHydM3pcSc9tlQsGRBrQcfl3fnl8XpmwF0TSXWjgGkXj5a5B9CB764eY6a22YemuEmRJHaIDDepWdD13CZT6hslsEo7SHYsWr2Ne14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FPPvEGlS; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6tc+IrF00KZicUKYScKT0PspH7NvqdDUBR+cLFQbPn59X/Hunj0z25Hy2lq81REMvXnKpfc/9gvKi2m4ZQrnxGJe67dOnOpc/PsyoVu1Tkkrwj0kGgRguIWUj6WAmhbUhqB2hM7cSNMSYHKH3TsfyBlQBK8F1P35t5QVnAL6klKNArpP2JnuCH/esPgIzt3Sak5HzX4QTczWaM0aysPa6tbznT83ICUGr7r1Ya9IilIDbmioU3ugiSiLScAQJVI5MjbmzflDx/PzVuE0v8Qj65YWJAdxKJKfX253WJah5Zna4Idad0W+hnX7VUA99D0nrP2pg0HyfzO7oK91LYI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8yRbE1Sklw45RSmRXYZbJCs9dxEAaXVPVayw5fy14c=;
 b=SMtV9IH8/2Xbi3g9h/dT06ynuLZ50gbK/MV5bKdONirCDdKZbirwZBnFQdtstedDoQAT55+l22cwSfJYFC2F4P/z1PYYJzkzJhSGRWUVvQ3Rv1Xv96+d0QrqRWcsfMi5sIM3xvq+3QCkAxuiEHMMIwqW+oT8l0l3coyMF/PxKCjL1i65w6oFBkHaIWzK3C9c7LQC63vKYPlg0keTxe+lOR58EJDeB+ImZ4KrkKhkNDJ8tWNAmMTIpqxeHVbjzFz6P9NwnNo5Wku6rtEDW/KJu16PY6tIB6QglUqoONVPDlCWadv5DVrohED5AVGH8XX2VYVfbkf1ZueDKzE0Xk7spg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8yRbE1Sklw45RSmRXYZbJCs9dxEAaXVPVayw5fy14c=;
 b=FPPvEGlSURlrZdDMfS0WDJRJ+4tQbicDi3sIoqcjQvk3OZrural33UGCMAXAPtvKaeHRB5tnUgYoO5P2kzmXAG9E7XzoJzGc7Bc2wGeT64r2giWDKtuPC9TtHpoIXYpBjskVExXCyST7RvNRp4X0FQ4dJdFD8aIE4qRN2vUWFqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 20:44:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 20:44:30 +0000
Message-ID: <004dcaeb-30ae-4b27-895a-4025a670fcbf@amd.com>
Date: Mon, 22 Apr 2024 15:44:26 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Dave Martin <Dave.Martin@arm.com>
Cc: Peter Newman <peternewman@google.com>, corbet@lwn.net,
 fenghua.yu@intel.com, reinette.chatre@intel.com, tglx@linutronix.de,
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
 <CALPaoCheW=Jz2R3gMKcgwQe6ONDrRqu3tUxeg=A3USg6BC8buA@mail.gmail.com>
 <7ccd59b8-9fe3-4d1f-82f5-f33d96dbf5ac@amd.com>
 <ZiaRewZJnLaDSx3m@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZiaRewZJnLaDSx3m@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0056.namprd05.prod.outlook.com
 (2603:10b6:803:41::33) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 6923ab73-85ca-45ad-1d7c-08dc630d0239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXFRL2MyNmJ4MVh4MHBUcUlZZm8ybTdJNWJoRkJKb3ZwK1JFSVNmRnVGV1ls?=
 =?utf-8?B?RTljbnJwK094cHVtaUpnUFJFWUlya3ZVNUxodnB2dURSUkJsQ1VzUFBTYTQ2?=
 =?utf-8?B?WkRpbkdKdm5hVlBRM0FzdjVqcE5KRktaaEJZcGZsb3lnWktQNFh3WVREcDI2?=
 =?utf-8?B?U1Y1RStheXpQcEVEUVBXTUViUlpRL3R4a0lXNHUzNFZsdGlDelhMeEx2dWRj?=
 =?utf-8?B?NWV6aERLaVJxOUlEZHJhUXpMb3V4eTVUT2o1Z0tIenhvbkZQbVVwMEM4WEZI?=
 =?utf-8?B?T1VXcjZWaWxkbExRT2M1SXRocWo5VW9KNjRER3dwVjIvcm9xbFRSQWJISmY1?=
 =?utf-8?B?UThGalNBWEJIR1hOdEtRZml4T1hKKzFXeEpoaTVveUNOblpvc2VXcWJSYTI2?=
 =?utf-8?B?ZHNib2htclRoZHFPNUtjSTQ2SkJMNTI3WHVLVnZxUWVIUlhOdjFvdHEyUFUy?=
 =?utf-8?B?RzV2SUFXRWJxcU9WWkZ0Z3VwblhnWExIcFJNTkErdG5VZzBkalMvU2RFdXRy?=
 =?utf-8?B?RUt0RnN3YjBNUFFlbC80ZFVPeForaHZ3a0NXTG9vbGtqcTRhUmVwVEloaVBq?=
 =?utf-8?B?NDlGbmtlQlBFTTZ1QVFrOEhFZHVXazJiR0NEOUcwRW1USDNjWHUvOWZhMElN?=
 =?utf-8?B?TExlbjVwUjliWXJUMDZwMDRPc1pDOU5DOVhIa296aXlJbHpNbXpGZ3JVTW1E?=
 =?utf-8?B?SThzK0Qza3VVMm92c3lqbEJtUnNSUE8zcUNLbDE0SUtJNk1VVkE1MUZjOXdM?=
 =?utf-8?B?QjRmNk4yVVJMVW1oT0FBZkhWc25DUUN5OE5lRVFMSHhOTmlvdmhxWkpPTlZD?=
 =?utf-8?B?NnZaKzdPdmIzQVljd2MxbUFSVW9lRnpaSnc3UG52L0NCM1YvQUtuenNmYW9v?=
 =?utf-8?B?S1haR2JQYVgzeHIvR3JDaTQ1TGt1bDdlNm4yNnNpR3h2UkYxZ1NpSUZZQ2c3?=
 =?utf-8?B?UUJOQlJkdzR6WWhGd2JZbUNhU09vZTRqR3hFQkQ1eHR4aXRad3NWV1A0OEFx?=
 =?utf-8?B?QktPYWxCY3ZpZ01vNGlJYmNhUy9hRHZHN3pObENXbmF1c3hOTm5CaGVMc203?=
 =?utf-8?B?WUpXVkpCNlRlOWZFbk16SUlka2hpTDRPZzlKMnJjNU5tVUg0aUhsL1R2elhU?=
 =?utf-8?B?K3JkOWw5SkpVclV1MmdRRDhWY1dHQklCR2RDRXhBZVNKZWtIMjlGQXdUOSs1?=
 =?utf-8?B?eFdKUDlqdi9kTkdTUzZjVEhlVVhGbXM1QmNKRlBVZ25QaDIxVmZDRnhheGZM?=
 =?utf-8?B?bjFhSkpoV3lXMDd3c1daVVVNSS9XSHkzVHd3Qy9ydHpDZHo1R0NiUk95RHk1?=
 =?utf-8?B?NU9MdmxsZWk3UjN2L2lhYmNHNDJ6byswRmxscUpWNmtHS09xWWJidUJTMm9H?=
 =?utf-8?B?cXBEYnUrWEtzWGtVRUpxemVMLzlYeFRwbWlGc0xkcGZaRUtWQSsxSWN4RVNM?=
 =?utf-8?B?b0IwMXNEMFpadHBoN0JUMmhrTElBNzJCbUhLSnRXTXNldXhQaitOS2IrMkZJ?=
 =?utf-8?B?TjI2eDk3cC8yalJvY0ZQNkwzVWZWeVV6bElha2tlMXRHYVJxamhNazBuSTdD?=
 =?utf-8?B?L0FpSjMxaVV5NkVzK2hNWDVyQTMySlJzYTlnNTIzUDIwQzVtOFF0RVhLaVQ0?=
 =?utf-8?B?VXlEcTlVYjNSdDVWcDNyVDFoaUVteE5WNUs2VTRhT05MVTZDVXVIbmJxaGhV?=
 =?utf-8?B?SEpYRzFSdHFtazlGSjlVZ1BJZTlIWHc2RFFzVnUxejlLM2ZGQXYwaG5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzFzWjFkc2Zqc25Gekp6eU1USktrMnBEZjJyZWFBR0JLZzlhRUZDN0tybFF0?=
 =?utf-8?B?aXpXdmxmZWFWc2t1a01TL0FzVTczYUpzc1J0MDBiQzg2MHFXQnhuamlvMklm?=
 =?utf-8?B?cTJ1R3ZldUt4ekZxSUcxMzlJZjhXNmcwaUN5di9oa0E2c0RFZGlLa3BFUWNS?=
 =?utf-8?B?M2Y5bDk2UjhNOHNnVkRLVk56cEpQb2gyc3BVaStGWmpYZW5xZUlKeDRRVDBM?=
 =?utf-8?B?NVd1VUYrd1Fnb0NFYWRKbUlPUkxOSFB2cTFMalQxNW03SlpubktpSmcyMHF6?=
 =?utf-8?B?UlgzWExWbDl4dW9jTzhyQ1Fza1p5MlNaWDUvZllERENSQUZJMW5UYU5KQzZQ?=
 =?utf-8?B?QW5BVmFoWWhucWpSdUtqcjl4b1VLSmNyOXAveHpuY214ckgzVDFVbGgzWkxm?=
 =?utf-8?B?VEp6c3lCSG53dHlnK09Ja2pvSWg3RFo5ZzVrTEFZYTFKVkZzNEhTWStuV0x0?=
 =?utf-8?B?RE8rMzBxczdFUzBNelNxSFN2d1l3TEFILzgzUHY2dVRSMXVlb0NMZHpIZzQy?=
 =?utf-8?B?b0s4ZzVVM3lQY3R5M0Z3ZU90QVI5a3I2ckxkTExDTFBYSlhSa1BQdDZVaWVK?=
 =?utf-8?B?TUFZbVdXUlMyN01HYXJobk0vbVFqLzlhaS91N1pveGpQSnY3bkVQZnVQUE5K?=
 =?utf-8?B?SkpIeExtV0lIZDZXSWJvN0haZzhoMXVVU0VWcXpEWitldE1Fd011OVJsOHBu?=
 =?utf-8?B?YlVJMUJWa1F1RTk3anR3RmJXeDZqNy9UdFdvcU00bExQSFlaQW9yVnZGRHZY?=
 =?utf-8?B?aHJFenloWXZscTFTZzUyM0VCVVlYQ21FckUrUFRsaGlJUXVLdURxSDRqZ1F5?=
 =?utf-8?B?MzhvSGdpeE10R1JLUE9BR2V2c0Fsa21LaDFwYm03d0gvcjhSM0JXTFphTmJu?=
 =?utf-8?B?b1VkZDI2SmN5bjZEa1VZMEVXcnZUdFY1a0RSalpoSHUwVFdjS21RVzZIaVEw?=
 =?utf-8?B?S3Y4M3BDOGdER2tXNFdIOEIzbXBodXRpZXcxdDBSMVloT0pXeHRtSGVqTnA5?=
 =?utf-8?B?RFRnN2NsVGRsTGtwUTI3VmcxTVpFbXJGMGlxblNoRXo0VkhieFBDbEhjYk93?=
 =?utf-8?B?ZFNmbDFWcU5FOElyWmpCWXhxMWZYcDB2dUxKSFpmT0NOaC9jUHRSWEUwdm1w?=
 =?utf-8?B?anFaRWtCL3B0MHQ2cUZhOHlyY1NvSFFmbml5M3JpU2VlcHowNVBkMm9RZDhM?=
 =?utf-8?B?MmVuMlROUEkvdC85cnVvTFJTcHY5dklzN3Y3UFBFbGk1ZktGaFBSME1SaG9M?=
 =?utf-8?B?QmFld0ZlQVM2bEU3bUZubzRKSCs1WGVHeFQ4c1ZGZFU3Sk5KQ0xhckllNlJE?=
 =?utf-8?B?MDJCRkVRcGQ1MTFUYnhOM2tjaURRbDUrbUJTTm1lNjlKQ2tIT293ejI5cUlH?=
 =?utf-8?B?cnVSdTM0RUVuUk9mL1A3UldXc2dlWlQyWCtNdE9HUXBDaWszZm5FQ2FRMjZr?=
 =?utf-8?B?YjNTWFJZN2FuTDZwSDYzdkpBcW9OWGhnc04vV2pZMnBKNUxRVkF1VHM5Y3dT?=
 =?utf-8?B?TmFXdHpXNW1LWlZCY3lCTWlnZmtuQmNHdmVYQXRicG8vVlYwdVhpalNtRG5Z?=
 =?utf-8?B?b2VFM1g0aUxWSnVHb0JpQWRSbndVdzZRWkRpNlZWdGhHUU5vYUI3V000UFhO?=
 =?utf-8?B?NVBoT1J0dFI0YVM1K29GcEdBaTBtU2J3NWNTTlozL1VBTDY1ZEdtdEVMYXcx?=
 =?utf-8?B?Z0JVVm1xekhUNmlyYmdTRnh3MU5Ub2JuT0pEaldhMnZsaUw4dVU4aExIUUg5?=
 =?utf-8?B?aWJVTDdGalk3VnphdWQ2WDkrR2hmUk5oWWVWNUJ0R0NXM3BpV1N0U0dJV3FU?=
 =?utf-8?B?WmJlWGJUenQ2Q1VtTzJSOGJjU1dVdWFvb2tmQTh2cmEycERYUDkrZXBGaXh5?=
 =?utf-8?B?N21SZ2pDa3RaeEI1aFZNSmd2TWN2Tms4bmdreGZzUnk0S1lHNVBTTlF0SlFn?=
 =?utf-8?B?QUE5ZmIyQTFaenRNeTVtUVRKb2Q5U1lOUmFIZUNBc3BIQVhtdVpoY0ZXY0Na?=
 =?utf-8?B?WGQ2UDZYR0xvSDk2Rm5HaTB1TlhRdkowTGppM0FIak5jM2ZFL3IrazRMM1Bt?=
 =?utf-8?B?UU9MS05FSHVzaUowQmM0QjZlTUZGTVFoWGxvR00xWmlRdi9GZWUyeWxURHVL?=
 =?utf-8?Q?DoJA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6923ab73-85ca-45ad-1d7c-08dc630d0239
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 20:44:30.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny9Dsan/HU9fbgN5xQAJQuA+MJSLWDlwvqa3/25EkoVV6YOjSFOKGyJWN8c8vEOq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490

Hi Dave,

On 4/22/24 11:34, Dave Martin wrote:
> Hi Babu,
> 
> On Thu, Apr 04, 2024 at 03:02:45PM -0500, Moger, Babu wrote:
>> Hi Peter,
>>
>>
>> On 4/4/24 14:08, Peter Newman wrote:
>>> Hi Babu,
>>>
>>> On Thu, Mar 28, 2024 at 6:07 PM Babu Moger <babu.moger@amd.com> wrote:
>>>>    The list follows the following format:
>>>>
>>>>        * Default CTRL_MON group:
>>>>                "//<domain_id>=<assignment_flags>"
>>>>
>>>>        * Non-default CTRL_MON group:
>>>>                "<CTRL_MON group>//<domain_id>=<assignment_flags>"
>>>>
>>>>        * Child MON group of default CTRL_MON group:
>>>>                "/<MON group>/<domain_id>=<assignment_flags>"
>>>>
>>>>        * Child MON group of non-default CTRL_MON group:
>>>>                "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
>>>>
>>>>        Assignment flags can be one of the following:
>>>>
>>>>         t  MBM total event is assigned
>>>>         l  MBM local event is assigned
>>>>         tl Both total and local MBM events are assigned
>>>>         _  None of the MBM events are assigned
>>>>
>>>>         Examples:
>>>>
>>>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>         non_defult_group//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>>>         non_defult_group/non_default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>>>         //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>>>         /default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>>>
>>>>         There are four groups and all the groups have local and total event assigned.
>>>>
>>>>         "//" - This is a default CONTROL MON group
>>>>
>>>>         "non_defult_group//" - This is non default CONTROL MON group
>>>>
>>>>         "/default_mon1/"  - This is Child MON group of the defult group
>>>>
>>>>         "non_defult_group/non_default_mon1/" - This is child MON group of the non default group
>>>>
>>>>         =tl means both total and local events are assigned.
>>>
>>> I recall there was supposed to be a way to perform the same update on
>>> all domains together so that it isn't tedious to not do per-domain
>>
>> Yes. Correct. Reinette suggested to have "no domains" means ALL the domains.
> 
> Would "*" be more intuitive?

We could. But I don't see the need for wildcard ("*") or ranges and
complexity that comes with that.

Even in schemata processing we don't use the wildcard or ranges and also
there is no mention of that in documentation.
https://www.kernel.org/doc/Documentation/x86/resctrl.rst

Domains(or nodes) are processed one by one. Some examples.

 # cat schemata
    SMBA:0=2048;1=2048;2=2048;3=2048
      MB:0=2048;1=2048;2=2048;3=2048
      L3:0=ffff;1=ffff;2=ffff;3=ffff

  # echo "SMBA:1=64" > schemata
  # cat schemata
    SMBA:0=2048;1=  64;2=2048;3=2048
      MB:0=2048;1=2048;2=2048;3=2048
      L3:0=ffff;1=ffff;2=ffff;3=ffff



> 
> Whatever is done here to describe the "wildcard node", would it be worth
> having the node field parse the same way in the "schemata" files?
> 
> Is there any merit in having range match expressions, e.g. something like
> 
> 	0-3,8-11=foo;4-7,12-*=bar
> 
> (The latter is obvious feature creep though, so a real use case for this
> would be needed to justify it.  I don't have one right now...)
> 
> [...]
> 
> Cheers
> ---Dave

-- 
Thanks
Babu Moger

