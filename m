Return-Path: <linux-kernel+bounces-160129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EDB8B3987
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1822B233DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F201487FF;
	Fri, 26 Apr 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ViHS9ISC"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB27E573;
	Fri, 26 Apr 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140682; cv=fail; b=Nk53y/KUuP8dcsjus/xVZqSCNHkrX56Pecm3A3ii7hc4g3awS3RFJwpIveiI5eNlBhZJjcVQccsUkIlQcIXKj9T5/gL0Z6uz3m77W6zVAWYXoPRs7yMPAOvg/Iqwx2FrIfqnmOvRxC6gqUXICkDvY8pu+3tpuXpvHRbmUTtWZ5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140682; c=relaxed/simple;
	bh=P1imC3OyUwG5gj2e7JGBYPsqIH5YPOoNnG5AjNJCDaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jnCFTBn/tcSyxZfnXFtcRVzv+3SIomlD6mbGZDlSv+4FZ2lKBFa+krtYb/BF/FUwGcwOzzvMGP3HNcpTZFlXr1L6kLQZ3rh3Ulq8QoX+NDRS4xIIajumXqDSXaBgZIqiPr73Ocxfle9Dh1uc530YQFDYavOM13xmkJwQYswyYcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ViHS9ISC; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGiNRByy6qTlJl2ewT+M+FCm8KGEIfS1WvvpRfbPnLvL10nsSRUZhgpCUM7g4QAwMC+4Vn13dUbAGYI1Tgak9pST3ZT+Oi7bPwwINNz1zPqk7aDFlvX1ezvrLeRMFehvlzytjRD+V/pQ/Ac7cVvZ5c+TcPHTHA1zH1/ptMgXZYwR3C7l/GKP3N09UqQJapH76lBOLn6UzI/lsmKohao5e++5ZM9wrFkTdWGzLnOc9dhAgvuhQHozQhCo7md3q4k5ySzlYuRnCtFMEX0xOZ6l2Zx9D4mpYSieGV/yBzRnb0/he3rgGsVzkyV50bNdZKCGOqFvk1T6v2EdbPqOOLNUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm3vFCnIe9mk3koDe+qOx2RlmmTUUiMNEH0VwXyJ3SI=;
 b=GGznpndSbQyBkZR4Jl9YQrOr4MlYa2Zy0Q7/RUAg8mC7dhuPtRZ99EctRbLl2EQw4AK+h+Cdk6VVNbulTfZY8IH00PlFcQ4voex2StQFFJFSBBdJNAZoOrlyf6ahfEiuYlvQ0HXN3twB1YqzWqlooNb4XzjVijSTpj4lJGEwHMiuJFeB44ZS9Tac18+n4IknQJy3N6lQZMkKKGbjM87qIGyN//zcJV7waQ9ikN5UsHZLarYgIpU2C4xUaVyzDSGgoMwBEUWb/IG/OKZaDxC28o4k9F94nVE+0RERkPHR0kcqa4HO5sLtNTOiK4OvCWQ0JzObq1OaEHKyw9vM9f20ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm3vFCnIe9mk3koDe+qOx2RlmmTUUiMNEH0VwXyJ3SI=;
 b=ViHS9ISCOEua85kLJCCqywzdeXwbyfVlai2Xh4eKOoUHfA+q/lgdLWythcYXKFQINVThSNkXAY764iCEGgoI1jk/tKzRvWEKrc0NOiWCUsIq/tuvRXLQj5Ak2PH1Uu8TJ/jQDmMVWO7qvaacutws6kzftFVg5xEHUjmFu3p/TUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 14:11:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 14:11:17 +0000
Message-ID: <a63897dc-11ec-44af-a3d5-0dc6768a8510@amd.com>
Date: Fri, 26 Apr 2024 09:11:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/6] cpufreq: amd-pstate: fix the MSR highest perf will
 be reset issue while cpb boost off
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1714112854.git.perry.yuan@amd.com>
 <1d623d592548c7349254cb7dbea8826bb8a99eb3.1714112854.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <1d623d592548c7349254cb7dbea8826bb8a99eb3.1714112854.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0115.namprd05.prod.outlook.com
 (2603:10b6:803:42::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 554f8827-b79b-4930-2279-08dc65fabd83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnIyWXhObXBCemNCUnpnRzFoNGY1QS9GWkNIMzMrbmxoQVZHRXVZMFFhMFIv?=
 =?utf-8?B?amQwcjVoWjdwK3piUEZtMFJPS09pdnMvZ29nQkZRNFhxZHpzN1l2NSt1Q2NV?=
 =?utf-8?B?VS9KUjh0aVhEUXpHdkw1SVBTeHlOQ3VYamwrVWM2RHhzbG9nbDBQSXVjMUdv?=
 =?utf-8?B?R1c1VVB4c0JJcGJ2M292MVNFNVY2MlI4eXdaS3NQU3ltbzdlU04vZ2JRWkgr?=
 =?utf-8?B?OGJWNlJCNzZBTUdwVjJFeXVHd0FtMTVXUTNrclhNeWFvZFlSbzZHTGQzQ2tV?=
 =?utf-8?B?ZlVycDRvWjZ0eklCVHdBKytrUDJUTk80b1dmNXdhK3QwSGlQK0J3TGI3SkZ6?=
 =?utf-8?B?UW9EWGVuRWpGN3AxbDNwdXJjYmVQVmlVQkNhV1lrN0sraTZ5Tkx4cmxINWtL?=
 =?utf-8?B?bTJFSlRPdzQrZjBBdW5SM09zNk9YY3ZTMGhlK0ZCMTlPUzhISVNpdjEwOWVC?=
 =?utf-8?B?Q1g0Q1NiTGo1Z2xHOGpzSnYxd3kzeUR1ZzU5eDUyUkRjTDk1SnRnVVlFVzVh?=
 =?utf-8?B?enQ5SG1EcGM5UkFzZU05UFdVbE4vSHFReXhDdDRWb0VrUmNsZmYvamVtZ1hD?=
 =?utf-8?B?ZzZmcHZhVjhsNjdHMXVUbWZNRXczRTNiSFIvczBXU0VvWmxOa3E4NlJzdDhu?=
 =?utf-8?B?ckE1YTRLY0IxWmVJZ2tZbnd0TVAwZkdHMDE5enU4NlNIOG50cW04N09pQVM5?=
 =?utf-8?B?UXJjMzNLdTY4Wm9XV085M3EvRE14dHNSYzdJQytNVFM1NDlyYytwQWVNSlNa?=
 =?utf-8?B?L1ZHaXVGd3BsOUJsMWhQTUVMcFgrTklkbWk4L0RoUUQ3OU4vRVBZS3ZmSTJD?=
 =?utf-8?B?Nm1jYWVJeG9HZitsWHBoc24xY245ZGZDOUh5eEkyTVVSeS9teHNyVktVcTFk?=
 =?utf-8?B?Q2RmS0lkc2Q5TWVHUnAvL0F3U1crUmcva1VQMUdCcnBTc1UwamlraXJzcGZw?=
 =?utf-8?B?WFpPc3VxL1dxdHF1TXBCcXJ3RWxSV2hNdFJJRnVQVXloSzNiTG5jblBiSWYy?=
 =?utf-8?B?WlU3RU1kTGhwN1FrS2xzSENnL1RjNm1DLzh3RDZuaDY1Uko5Mk5BWlM1UmFU?=
 =?utf-8?B?M3pkR1VNNEF1K1RqeVBwOFgxcjZLbmRFanN6YVdwMnpKaVo5QWdlV0NmcFJL?=
 =?utf-8?B?aGNTSUdEN3dWVmRJNGY5TE56Y0xIUjJXQWlZM1ZYdUpiZFd2Vk1pMmtiQjZ3?=
 =?utf-8?B?RkQrWEl0Wk1jYXdIWVJKRVM3S3lUV2N0MGpIcjNXbWFEbTM1dVdrQUkwL0Er?=
 =?utf-8?B?d2tQY0E0U2o3MzNzenowekZGeUcxVnptWU1PeEEwUG5oU3M5UU5DK3R5U1Zo?=
 =?utf-8?B?dmFnNzduS1M4NUVSZkdBVEpGemZnaGV1V043V3VWZXVCcmM5NXNYd2lQQTFs?=
 =?utf-8?B?TWRhMGVzWVI5U2lLdXg4cnZaOTZOOWFSZlFMdkQ1azFKVmZ1UVhDTk00L0Mr?=
 =?utf-8?B?MjNpdTdlanY2OU1WSTZGcUZTOG5kQ2VwMlV6S3hiVklCOWl1aTNPVXhRWFh5?=
 =?utf-8?B?OFJpcktEb3hrMjZUQVovOXFabXhTV0o4MVBsZ0FTemZ4MmN5Zko2TDRmVVhZ?=
 =?utf-8?B?aFZQUUhKSG55aW5LNWFyOUlGdmhjZ0VVM1ZwU3VvSVNwTTY4TDFqbHROK091?=
 =?utf-8?B?RVdpd1k0WnZVc0dYMWJsU2hnYkNONHpjWElLbklRSTZTM3JkWlFmaVkrZUxR?=
 =?utf-8?B?eFBCZVI5UzRSTnRIdXh0L2Q0cTVPYmNCVHNIaVhkTm1xMXJXa2JNb2l3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkxtTTNZakI0dEE1THFzbnN1cUJGcmd1SFBFMGRSeW5YTHpMZFV5bDQvM0Vm?=
 =?utf-8?B?SjJEak44WllDNlZFMXhmMW1KL2d2eGxkdlhKcFFMWDFXZm9rN2dRNVE4RHRk?=
 =?utf-8?B?b2hVWitYd3FuODJTVkNtSnZDK3JLakhjbXBuaVMvYVRLblpQcHZJcWRkSWF4?=
 =?utf-8?B?ZTgzLys3MVFlYjF4OXQ5YWFBbWdoRjlsSlZzSmlZQWthK29BK3pscmhJeW1N?=
 =?utf-8?B?QTFXU2NwV0lNeDdwdG1vZFlkdkozKzAxU0xQRVVqNXUxcFR0djN6MVNlMGgx?=
 =?utf-8?B?RTRFRjVHSER3aU8xZzN3a3h3eCtLWkFqUUNNbURwdzllWmsrZ2dEaFM5Y3Av?=
 =?utf-8?B?NE5wTU5FeE85YWJkYzFQZU1IUGxWb0tBYnhnZnVsZTRVU0ZEcGJRaDdxWlNK?=
 =?utf-8?B?dmFkTy91Zkc4SGxWZ2FaS2ErWm5wSG9pK083ZU9JK2pGQTUxdVZTRExndE9Y?=
 =?utf-8?B?c0x4ajM4d1hGOVlRSjFqbDBnVlpzSlFMa0NNSG53a0xsNGtpejU0NjZMQm1r?=
 =?utf-8?B?NHpuQk03c3l2cFV5ZnJXbFVhWTN4RkpYcEJZMStwcnNXQi83aHpPL3d6MUJT?=
 =?utf-8?B?cEdLdXBJc0dJajc5TTkzQlc5ZElKUTRoM2lNV3hBN3laSmRmbVpYZ3FHTkNG?=
 =?utf-8?B?bG5TMkY0a1ZzNzlqWXdycVVtR1hMUytWdGNjOGdHUktVWFYwbzl5ako1dGNs?=
 =?utf-8?B?OTA4UVQzWnFBUVR1TURMVmZFU3hmNjBBZU01V2dLblNkR3dXYi9XaFdNM2RF?=
 =?utf-8?B?YUZrcnR2OFdmYmZGejBvdFZWTUVjUHRlcWRzRVc3a0Z5TVE1S3ZoNVArQ3My?=
 =?utf-8?B?V0JZMWV4bHNJaFUyNGVkSUZBMVZlUkF2TWcwZTlNcm8rOXcwa05Ha0dLNnpr?=
 =?utf-8?B?U01hVVF4UzBMU1ppbDdBZCs1eVpQc1BtT3djbXRrejRBeDJ5UDg0S1dVdFBy?=
 =?utf-8?B?WWVxZTFJTEVIZThHeHRvRjR4eENqRnQrcjlNZTd4UjRsdGxGbDY1d0FZbVhM?=
 =?utf-8?B?YzJHNHBDNmhRYjYzTnNVQ05ZK0ZRK2ZpYThMNkhxQWZwSnM4WThCT2F1eTR5?=
 =?utf-8?B?TzZFWGpZT1NKR2kyVHZPQ2pNa2x2NWIxQVJVYXR4L29nbWxwNHNOUVZCVUJZ?=
 =?utf-8?B?KzhxelRnZS95YVo1VFhhUFhVVjhqRVEvNW5lMmI1b1NEeGRnYTBOb0JyWDE5?=
 =?utf-8?B?VDZ2cC9IZmVJVTYxV3lhdWxNZGNlYkZuSVkzZHJEcVQvckhxVWtGcENRZkZz?=
 =?utf-8?B?Zk4xVzZ1dVpvRWR4T0dOMHRaZGt0dkM5cFdjZ2FtU1lFcjlNYndtVGZzVW5j?=
 =?utf-8?B?WGN5WnhjcEJOU0M1ZGtWazhKM29BcmN1U213NGtaS09Sdyt4RDdrOUZrMm9Q?=
 =?utf-8?B?aFpIWHFxNzhDV0REYktDM2IxV2lnRzdVRUFKcGM0Q2lHbEp2aXhIS0VtUzNC?=
 =?utf-8?B?N29jY2JIcUJ6TnR0cnpJazVJY2Nvb0JmMkE0TEVaOHY4VzNPU2kwQ2Fmajhv?=
 =?utf-8?B?ekM4WngrU1pXNWlRcTY2SzFZMnFIRStiMkRZc3h6YzlHajZONkdTMFd3ZVdK?=
 =?utf-8?B?QlJCSXZkTVR0SmI0RjdIOHhUVm94V2kwZHFxK24rZFM3Qk15bzg5U2I3amJU?=
 =?utf-8?B?UVFrS2xoT1NHWFJHSitrMVdsTTRLQUNNUUpkbHRpS0dTclY4UDRrdFB3K1ow?=
 =?utf-8?B?Nk54SHRqOURkZGJvWFpETG53OTVNMUt2Q3U3R1BPRmdMTGdDektvR09ZZlRz?=
 =?utf-8?B?WDA3OE5nNkFEMHlIWkZaZ2I0TXE5OVNGRmh4MEtiZnRUSUJORFJTU2RvNjZH?=
 =?utf-8?B?aFE5OXp5NVU2RkhFaFdmWkN6RC9lZllsaXJQTW5tZFF4NzVFOXhuZVBoRXZW?=
 =?utf-8?B?OFJDR1F0S0FKOGFtUXQrZzA4R0ZQZDNjcVQwNzljT3JWUjdCWDhtVGVXR0FW?=
 =?utf-8?B?MEszckczOHVhV1QzZW4rdVBVeUZsSC9NU1gvREVTK1N6ejBlc2dJZDZpZHAy?=
 =?utf-8?B?UjdaTXhzUitYZlkwZXY2TjR2WjdUZ3lZa2RaNlJaYUh6SVRad2JPNkpyVnZh?=
 =?utf-8?B?VFNlaTRwb3FOcWQrUFBzellmUFMxN3JOZXhEQkw5WUFDaGpXMWZWZkFPQjYw?=
 =?utf-8?Q?gOY5QBGcZwaPaMO6CXR6OawKV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554f8827-b79b-4930-2279-08dc65fabd83
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:11:17.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Cd3uhezxufpDEvRpCaVZ8TQaWJZzmSN63qrJPIvdLs3DeSwbwsj2EiwsmfcaecU+TbCUnNgaz1yc7qjEbO55A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667

On 4/26/2024 01:34, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Select the min perf to fix the highest perf value while update pstate
> CPPC request MSR register, here we need to limit the max perf value when
don't use we in a commit message
> CPU boost is disabled in case of that highest perf value in the MSR will be
> reset to original highest perf value which cause the BOOST control
> failed.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>

With minor nit fixed in commit message.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 53ef39c6dbfa..993e3e6b6609 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -476,6 +476,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>   			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
>   {
>   	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
> +	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>   	u64 value = prev;
>   
>   	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
> @@ -495,6 +496,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>   	value &= ~AMD_CPPC_DES_PERF(~0L);
>   	value |= AMD_CPPC_DES_PERF(des_perf);
>   
> +	/* limit the max perf when core performance boost feature is disabled */
> +	if (!amd_pstate_global_params.cpb_boost)
> +		max_perf = min_t(unsigned long, nominal_perf, max_perf);
> +
>   	value &= ~AMD_CPPC_MAX_PERF(~0L);
>   	value |= AMD_CPPC_MAX_PERF(max_perf);
>   


