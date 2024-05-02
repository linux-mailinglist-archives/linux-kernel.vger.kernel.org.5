Return-Path: <linux-kernel+bounces-166897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058CA8BA178
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283E21C2143E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C23A180A9F;
	Thu,  2 May 2024 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3whWTIrk"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737D15D5B7;
	Thu,  2 May 2024 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680885; cv=fail; b=WdCWx/uEaRynAz9aWQSEvWqZJrLIKIIqawZmRW2DnmpG7zQJnvPBdmcFqgjgJjqAB0flFQfc1PVkh6d29lSJkA1dDIASV5KnD19yFwmSrgbdl0ZhpjTJsdZvWA07qbwv1mp1+AvoOysRmIHq0VB9tB1joFVd14MUs7tPdw8CTzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680885; c=relaxed/simple;
	bh=zsdEQGAPhbmpoQ9THB7ElxMJeN0R+PnUZ1hjvbiK/x0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bZnx8dZoZz8V33f9isPweLRlJ1FsDKCdXWbocYhFP04QLw1qcZIERkiLmMHX42615MetqJXty8SoGrhYqux5DGrGnE76InPUBDnD7zwaVDNNI2tSR8H4Zmfbki6FtyWz3fVBBoXhmDodRZw/QwvrO/xhYuUo+vnlNn/Twk3p+yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3whWTIrk; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2+FRPPzt9BbTslESdM40+bdFwaBxyjbPQRItu2BE1xkv+29KWXUbj/MTXfBReKF6nAqJTFHQqGPjdBamITWnefBVJ4o8EGAXwFVfyS2pnlJp2JQ5sxc4egIpMSgeuBGrv8cdvxHCXJZOtsAIswMkjL0BFIgnjzJceJX+HRPe7Mg5Qkus8njfUsf0HT8bQ2kPQbedXQjODkQO/FOPhiYg9beFxHNUSymdmcrrlMNpK/PwsRqio0OXNa7j09TmNGD/2H/VlBJ8f5WD9Zy5oV6RB58ZMYEUk1SE7FuY7je7XojboGnUXcicrclIzDtRtnTaSl+ohUX7w3x0eBlrIN5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvcDiPbxRDpaLPiQDLSJkgsZDrQBizpoe4KQpc/7pfk=;
 b=UzWTcfFqLg1dH5rHLAOkfA2u9itc3b5jyNzex4Fyc52cCduUhLURIepLTCJNBkqJ1RsLbsK7eaF8hgb7eQW59/45OFF61Q0NlrJ+IOreA+c+e8gboxscuvxUiFggrSS1KCmWNHtaNoFf46aC2hO4lb26LQ/fPpI7zMwe2GKgmptKAo2jmpYbyYCZkhr59l+V2NU6E6FNxr9SflnjjHrkUFvedwkz/ITtG/AfxAofbVlQF2X7FFtIMtq/PRhh8P3PdBC27AHF9uOkADvYa6PKfC+JPdgy+6wD77gq25tWY35BqJvXiRlfu7D50Rh1ZkO8QCn1wm/bXkQG6pbRmMKwWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvcDiPbxRDpaLPiQDLSJkgsZDrQBizpoe4KQpc/7pfk=;
 b=3whWTIrkWitTj00OxurQ1u7vzq3O74/A9RHAr4YOl4q93S50euwNmLsWXgpcEW+JXUfNPV8HaOqKv2BsFkJuxjxaNvZioQFuAvSjRN/+vgPkLyXalfnEw8TJGZb6ANQ2KrZm1s3Ex1II+xs5lAktF7XNk2FMjoRNmFIYpjon0xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.26; Thu, 2 May
 2024 20:14:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 20:14:38 +0000
Message-ID: <6edffe1b-e9a9-4995-8172-353efc189666@amd.com>
Date: Thu, 2 May 2024 15:14:33 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
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
 <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
 <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com>
 <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0032.namprd11.prod.outlook.com
 (2603:10b6:806:d0::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 275c24c0-b58f-4fa2-008d-08dc6ae47dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGxUM2RPc2M3MnE4dUx1M1RmNUVqWFlPNllSQWNBUUMzaCtCZ0MrdTkwMFUy?=
 =?utf-8?B?RWYrY0ZsT2tlU1ZuYlFsbHFwK1JoT3l4cTVtQkpuSmxJb1ROUFRFbVdYdHFq?=
 =?utf-8?B?Y09VMFdrUk1VL2NQU3J5NXV6dEYzWkgybFFUS1VyaitZYVFMZnNwbVR5bU5W?=
 =?utf-8?B?YllZKy9zQ0dtcnhSYjIyVkxha3RVRTVCejIzZG1tK2l5dXpiNG5pVUtMdFgv?=
 =?utf-8?B?bHQ0bi85YkhCNUU3ZE1rQnFCaUIzQ0tVS2xzMmlEc1Vwczd0M2QveGVqaU9k?=
 =?utf-8?B?YWZvQWhCSjEra2lpbkttNHJQeHM1OGZLeDdEdnhab2NEd2hvY0xqNnk0a2dG?=
 =?utf-8?B?TFltdSs5TkVOU2NNRGlOZThqbEEvWEg1eFZadEJkams0cEcwMmtKblZTSC9I?=
 =?utf-8?B?dGxTMWdyc0ZZYUV0K3h0K2lXRlpzajVaQklxRzdvVlJGVVdacHczMDhBUko1?=
 =?utf-8?B?Y3E4M1BWcjQ5eWVybm1FQXk5d2NBOVdscmdRbXg3TWdvbjZGalM1NGp3eVBQ?=
 =?utf-8?B?ZzgvTkJreWp6WG5MV29wN0ZIcTlPckFrZktIWGZHVGl4SGtZYm5vamxmczM5?=
 =?utf-8?B?RktSem1PV041bGVpY0YwS0hKTCtUQzltZ0prTHRPck5LUWRSQlBiNlNMbEtr?=
 =?utf-8?B?OE1YUjRPeXZMZGZ4azFsbnhiQnY4cHhRdXh4NGFLaml3OXlVaU9FZ1dtQ20v?=
 =?utf-8?B?eXBvRDltSFA2R1packk0dUV2c3JqMThXMzVrUm5QaGNQMHhiQ2ozNGlBT1Iv?=
 =?utf-8?B?dzJCbVhreHFyN3ErN1ppOFdGWmNXOHJTSldIdjV3K0VQKzBUYkVrbk1zV204?=
 =?utf-8?B?Zk5QSS9sMk5iTjZRK3lxL3lHMWFsQnRGL3ZFOG53bDFlRlVreXpkVC9iajY2?=
 =?utf-8?B?QVd5aVZVdDhxeWVHc3dZZGpUb0U1czNmMjNnb1JuWDdWdDVHYTRodlpJc1Ni?=
 =?utf-8?B?TDNwZE11KzFQRXFQckRsZjByVjRKQnU3NVRSYUZKNm93RDFVaThUU0ozRkpG?=
 =?utf-8?B?bVhiVVl0LytUeTBxOGd0RlJrT0VlVHhMVk9xaldzSlpUMkFaOWF6MXp6VVpn?=
 =?utf-8?B?NVVQL1dFRWFGYUVoSHVKRlBEaGlITTRBQko3dXAvNEtBcEFTb0QxRjQ1ZnRh?=
 =?utf-8?B?bVFwUktuc1U5NWFyRjFDR0FoRWVCVlZsR05pRm53cnpiN1c4MU9YOEpBV0hN?=
 =?utf-8?B?T1o4bVFCb0dDY1FuUHNIYXBiVmUrRUFqZDZFdWRpNE9mR3VPb1dtZnp6T2c2?=
 =?utf-8?B?dXEwOU93eFdGUW94RnhpakZwUXNHZ0xNUmJZQVMxU2RrRUpLMjQwbkhTendV?=
 =?utf-8?B?S3l5bUJoalFmbXhQNmVta0daN2kybS9TZ2RaN0tBeUJ3T0pnL2NnZVVIckl5?=
 =?utf-8?B?QVhFdEhLS0JLL2o2VDdzUVlQd2l2cGVoWDZpNTUxT0tsL0pDaUxRVFI0bmNo?=
 =?utf-8?B?Z1VwU0RRNGVkR3BQL2NLWDR2eG9TbHNWYTBGL1RpT2pXOHFqclNJUmYrNTZW?=
 =?utf-8?B?bHVzZ2l1bjd6anZDWW9URkxBRlVzamtoNTRZRXpDQi94WFF1VW5hd1ZCTnV4?=
 =?utf-8?B?MFA0dElCVEEyTEVWWE9aN3gya2VKYVl0UTVxZFU5a3hoVFNPSHFrZkFaRExt?=
 =?utf-8?B?MzVLTTRtMjRvajl3ekJkdjRvTW5QQWVtSDdDcFJmQ3psSFQ4bjhMaVpSN0Q2?=
 =?utf-8?B?RHhlUjFYTnlBcjMrR05jekVvNUpWOE9odWVSZDBrbHF6ZXpqdVFqRkhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVV6TGpLZzJkRXFla2RIV1hkTCtzUFJOS3IvcXFMaW53RmMzcE5zTFR3UVRk?=
 =?utf-8?B?OUllK1E4VTJmVjI3Y0pIZk5LSW9LWElRRmJXdmRNNDZtd3ZIUVpJd3Z6bUdz?=
 =?utf-8?B?QXRzL2FJaTVrYVpFeG96MlFCTlJCTUcrVXZleFdSaDV3UjFSYURGbjY3TEU4?=
 =?utf-8?B?aHhRTE5ibjJacExobjA4TzlQd3VGREcyd3AyN1dPUnFpOTJOMXgxWkRYcHVI?=
 =?utf-8?B?T1UwSmZSb2IvRWx2RCtieW1zV01OUG5UaWptRjNwTDFCMDBGUTYrWlF6Szls?=
 =?utf-8?B?dmdvQjlMYlJHb1RZcUtUQVZLWUNDbG1nd2ovbUVaNnZ2NUxudnJxU2lJQzBC?=
 =?utf-8?B?ZDFtZm5WZ1g0b3J6SzZRM0w2TzdDRGljSW0yNlpaUlpxNE5yeW9zUmJhSTRl?=
 =?utf-8?B?TlRndi9MOGxLR2ZtUmhqN2tNMnBNdm9YOXB4a1BENlVrYWdWeWJkbFYzRmtu?=
 =?utf-8?B?OXAyUUVtcEhQd2VLU2FJNG90SHJQNWVRQzI2M1R0dGJVTjdRZDQrMnpTa0xo?=
 =?utf-8?B?Y1U1elB3VjZxSWZLVTJOY1plWTBmL2U2SFNQd09ESm9BekRzYituYmxCbkRP?=
 =?utf-8?B?bU5nc2t6OURFcEhxM1pBYkNzSFlxQlkrTEcrMWFYREVrSG51d3NzZUlxVEFU?=
 =?utf-8?B?RzZXQUpIcGpTY3BJTHBwMEs5TndWcHRIaVVQSE5xbTYyVjZyaW9iYjROWHJS?=
 =?utf-8?B?Um9Pa3B6bVcrWnJBcGNPMS9sSnFwSm8rS3plWlljL0YrR09uMHBaVFJOL3ZM?=
 =?utf-8?B?RVVyQmR4eEczVVdjb2pvem1Ib094WXhJdlM5MEdBZ3c1UGZmNERWcnFDMzJP?=
 =?utf-8?B?bjRWUnBNNm9HT0NjdEhGdkRXNmJNcVYvVk8rcWxxSkoyYnZHODM0YzJHRnQz?=
 =?utf-8?B?VGpnSllCaDdjNDRsdnZKSi9aZWp1Q2lkYThac2NOMFI5Z08zeU1FT0RlV2lu?=
 =?utf-8?B?azIvVzBSbjY2bG9BTkZQTGRHeGpJTnRGSWtWVmozamtLL2d5UGt6YjhkUmJG?=
 =?utf-8?B?L1NJeWhWbnhQVUFXSDlGWmtvZlhCWUVjYnhseDVqMEJXUmJBbFI0S1NsdXR3?=
 =?utf-8?B?TDNXZStNbG0wQzVUOXJVbzhFZjRUL0xWUVc1NjEwbWxLRWZ2K1IyRHFxL2Uz?=
 =?utf-8?B?NURlcWxGOEJLWThCRUcxajR1VnIzc2VWZG5jMFZVZkFGbTB1RERjd2t5bjk1?=
 =?utf-8?B?ZGN5bzdvQnJsR1lwMEZRUXBLRldudHFFaUd1N3pEQm1pejRXaGYwMXR2VVhu?=
 =?utf-8?B?R3JRUFl6R0FMU2RhWnUwdm1jd1BteEZGYk1CbTZTVEtBaVpEL3lBL0EzZmhr?=
 =?utf-8?B?RlJjclhTQjJIN29SNW5kY0JtVkNlV2ZGa09XY2piQktlZUFpMmc1R3VxVkZt?=
 =?utf-8?B?YUM1TkFnY1hKYWJtVFlJQy9oM1ZRblVjYjdpZVZycE82cVZzUzlMZ0FCa2ZK?=
 =?utf-8?B?SmhVWmU4SURSS0JoSk9pRUFyRGh5RE5vd21DcnpQT1dwK1dGRUhkMkZwa3Qv?=
 =?utf-8?B?NmQ2NFZJWmNHaWM1ei9IY1RZWmhtdEIyMkx0c1dNY1V6bVI1UUsxcmtzMjUv?=
 =?utf-8?B?aUlqVjB3bi9ON25DTnRwMVFPanhvUFdtTThKdlNMTmZqRTVlWTE3RkUyOW1O?=
 =?utf-8?B?VXlVT2pUK1pHTS9XMnFmVmM2cXo2MXFmNTZVajMxL1gwdURnTjVLd0FlaTA4?=
 =?utf-8?B?SWNZZmh6NnBWQVFtQmx4b0hVV2VWZ3Z4YkZBQ1NqR3NVclp2NVFQZDFSd0M0?=
 =?utf-8?B?RDErMmNCMWJUUDE3L2tJSkVLTUdkU2hFcDhsdnhETUJITElqZWlkdTlsaXlr?=
 =?utf-8?B?TDYvbVl4dzRsVEpyKzJhZ3ZqdjBJQ0ZEZHIrdmVhZ21haW8wMklDYjJqK0Zn?=
 =?utf-8?B?OGkvM2pueDBpK1VvbktDeEFUSEdtMHdyUGNVN1VPYTBHdlZ3VVFRMXhyZGt0?=
 =?utf-8?B?cVFQYjNMZXErWjd2eXliaVRZelZuZjhIZC9BdzhIWlc1SVRFcnQ5OHd4TEdw?=
 =?utf-8?B?b1BLbzRXeWhleHYvVG5UcVNvSEVxOVNkRDBlQTVlUWJTcTVIWGszdTJlYnUx?=
 =?utf-8?B?WXlQVTQxNXdtdUFySi9KclEwUTNxQ1dGUEJLNmMwenhlNThKYnB5SCt5dWNo?=
 =?utf-8?Q?D+lk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275c24c0-b58f-4fa2-008d-08dc6ae47dec
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 20:14:37.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDQH1ahkrWGC1MdMerZQ0Xi+dxMBDwcxPu9aqzaUp4VIWO5t2Bvh+JQwlG6J56QZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550

Hi Peter,

On 5/2/24 12:50, Peter Newman wrote:
> Hi Babu,
> 
> On Thu, May 2, 2024 at 9:25 AM Moger, Babu <babu.moger@amd.com> wrote:
>> On 5/1/24 12:48, Peter Newman wrote:
>>> The FS layer is informed by the arch layer (through rdt_resource
>>> fields) how many assignable monitors are available and whether a
>>> monitor is assigned to an entire group or a single event in a group.
>>> Also, the FS layer can assume that monitors are indexed contiguously,
>>> allowing it to host the data structures managing FS-level view of
>>> monitor usage.
>>>
>>> I used the following resctrl_arch-interfaces to propagate assignments
>>> to the implementation:
>>>
>>> void resctrl_arch_assign_monitor(struct rdt_domain *d, u32 mon_id, u32
>>> closid, u32 rmid, int evtid);
>>
>> Sure. I can add these in next version.
>>
>> Few comments..
>>
>> AMD does not need closid for assignment. I assume ARM requires closid.
> 
> Correct, MPAM needs a CLOSID+RMID (PARTID+PMG) to identify a
> monitoring group. The CLOSID parameter is ignored on x86.
> 
>>
>> What is mon_id here?
> 
> On ABMC, the value is programmed into L3_QOS_ABMC_CFG.CtrID

ok.

> 
> 
>>
>>> void resctrl_arch_unassign_monitor(struct rdt_domain *d, u32 mon_id);
>>
>> We need rmid and evtid for unassign interface here.
> 
> From my reading of the ABMC specification, it does not look necessary
> to program BwSrc or BwType when changing L3_QOS_ABMC_CFG.CtrEn to 0
> for a particular CtrID. This interface only disables a counter, so it
> should not need to know about how it was previously used when assign
> is able to reassign, as assign will always reset the arch_mbm data.

Yes. That is correct. We may not need to set BwSrc or BwType for unassign.

But, we need evtid to update the monitor state of the rdtgroup.
> 
> I do not see any harm in the arch_mbm data being stale while the
> counter is unassigned, because the data is not accessed when reading
> the hardware counter fails. In general, resctrl_arch_rmid_read()
> cannot return any information if the hardware counter is not readable
> at the time it is called.

Ok. Le me check about keeping the stale arch_mbm data after unassign.
It may be okay.


> 
>>
>>
>>>
>>> I chose to allow reassigning an assigned monitor without calling
>>> unassign first. This is important when monitors are unassigned and
>>> assigned in a single write to mbm_assign_control, as it allows all
>>> updates to be performed in a single round of parallel IPIs to the
>>> domains.
>>
>> Yes. It is not required to call unassign before assign. Hardware(AMD)
>> supports it.
>>
>> But, we only have 32 counters. We need to know which counter we are going
>> to use for assignment. If all the counters already assigned, then we can't
>> figure out the counter id without calling unassigm first. Using the random
>> counter will overwrite the already assigned counter.
> 
> I made the caller of resctrl_arch_assign_monitor() responsible for
> selecting which monitor to assign. As long as the user orders the
> unassign operations before the assign operations in a write to
> mbm_assign_control, the FS code will be able to find an available
> monitor ID.

How does assign_resctrl_arch_assign_monitor() selects the monitor id (or
counter id) if all of them are assigned already.

In this series the monitor ids are allocated using assign_cntrs_alloc.
rdtgroup_assign_abmc()  calls assign_cntrs_alloc() to get monitor id. It
reports error if it cannot get free monitor id.

Expectation is the user to unassign an event from another group(or the
same group) before calling assign.

Are you expecting something else here?

> 
> 
>>> I chose to make this a mount option to simplify the management of the
>>> monitor tracking data structures. They are simply allocated at mount
>>> time and deallocated and unmount.
>>
>> Initially I added it as an mount option.
>> Based on our earlier discussion, we decided to use the assign feature by
>> default if hardware supports it. Users don't have to worry about the details.
>>>
>>> I called the option "mon_assign": The mount option parser calls
>>> resctrl_arch_mon_assign_enable() to determine whether the
>>> implementation supports assignment in some form. If it returns an
>>> error, the mount fails. When successful, the assignable monitor count
>>> is made non-zero in the appropriate rdt_resource, triggering the
>>> behavior change in the FS layer.
>>>
>>> I'm still not sure if it's a good idea to enable monitor assignment by
>>> default. This would be a major disruption in the MBM usage model
>>> triggered by moving software between AMD CPU models. I thought the
>>
>> Why will it be a disruption? Why do you think mount option will solve the
>> problem? As always, there will be option to go back to legacy mode. right?
>>
>>> safest option was to disallow creating more monitoring groups than
>>> monitors unless the option is selected. Given that nobody else
>>
>> Current code allows to create more groups, but it will report "Monitor
>> assignment failed" when it runs out of monitors.
> 
> Ok that should be fine then.
> 
> However, I don't think it's necessary to support dynamically changing
> the usage model of monitoring groups without remounting. I believe it
> makes it more difficult for the FS code to generically manage monitor
> assignment.

Are you suggesting to enable ABMC by default when available?

Then provide the mount option switch back to legacy mode?
I am fine with that if we all agree on that.
-- 
Thanks
Babu Moger

