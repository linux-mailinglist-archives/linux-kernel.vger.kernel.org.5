Return-Path: <linux-kernel+bounces-147487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B398A751F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233251C22725
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166613956B;
	Tue, 16 Apr 2024 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X9JcWmd/"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB3B1384AE;
	Tue, 16 Apr 2024 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713297185; cv=fail; b=XtuJ/bhrQCU/reVL/RYSSWj5Z/WnVQCrsVl6AzcgBi2iYOlESUFzRmyE61J9cJj+B1EWPOxmsbFMDoqaFx6FVe8Ch62sRaCdAqMkgS4k9V+FIOCr630vASM2jo6GYFwXYpWmsLn8c8MUjCCNAFxsTFIuiDl44LWNFKMUYpTMvLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713297185; c=relaxed/simple;
	bh=rwMPCcBn6tXr4KxTLWXO8iSEp4dGWTm6uxSR7GV1j7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rKrODgejYfq8WidN4V+u2vlIqTkCIppCwGR+yyCjlhc9W8lmTyMOliyYKpc/BvNbWGPJ745IvLOqwDwXcffMv+/LeeuUATm6zWtw6r+kJjD80FvFUCm4lFG0xW92rg9R/7l172K4ql+aOc936FldROuE7UnABaedkVz2n8XsHJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X9JcWmd/; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsJZu5+9n/UpLnxx95MMHwNu4h8ZCAdoMOTtLfntrVetcLLjwwWxcmkcUP8Wvyp+EwlQUkPVpCfkdMIgByhxKait7CKNMh1Y4J2rRUOfFqSgRFcRXpcaYFquLlHcCpHX9lE/XvB67pYIzVKtRtaR0Zg+LNXp+vk4rsGIZj2Y0cEgWHR2J+or5gtGwcKKSrakz8rNcN7r/9yNVMeSG1lQo5Pfg/NJrxa9BzvbW2tfxvSe606223+l0ROfsQXgpcOg7d3uw0KXz0gYavszeQ2E49krr/gfgyabvzfIPZnmvlV2UObNaFvUG3BvSMt/bvYnotu18902+ylwy6rNe6SeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ophsnQ3U5mdRM65iD7JNdqgMpOuRNYV8cV79nIvVu4g=;
 b=HGW9fGsXoppBFPlaOjR3z3ohYa42on+d/J1AY5X3n1HIuomXup+AWukiyvTFLQRnNG7TxzG4onn3261mtkamEIAI2hOpydQbgDh72EhCtnP+RDYMSvuFuvFMfnjAKv7a29YbkpQsEvBduZ9L8Fg6iLYqRdlqg1sIGyROHF6VlfYOqYC5ueCEDzWMFgnPbdsDOUwC5GaVLk0En1VRsbDlwBW4mae15nxqDV7vO+oXfnX3p+kQR2CSv/K393T4wPoYRuBNQwbR74HShYs52yHziZvg00IiQ+cqH07SbewdVMUa1O621zvWqOSA7LQlGX6EKYEUlWGAbK5Q33WxBJpLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ophsnQ3U5mdRM65iD7JNdqgMpOuRNYV8cV79nIvVu4g=;
 b=X9JcWmd/h3bhO8GV9piezfoAKaSYzuZJKFv1rU27qdC3KvOeL+4uqGkPUva9S+qtO9enl7llLGHpF/wI31Np3NCuJD5/MSlaWSFemu0HQT6LQZOwfg0sdWwJBz3UK3020neNw/h3NnWXuf+oxZiRDRGLaU+qc9ti3D6BtBvPsR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 19:53:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 19:53:01 +0000
Message-ID: <6d982d5a-5313-40ff-85b2-aeba5429a47b@amd.com>
Date: Tue, 16 Apr 2024 14:52:55 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 09/17] x86/resctrl: Introduce assign state for the
 mon group
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
 <1a6bc747da259e8b3a85de339bc1d6bf94995c53.1711674410.git.babu.moger@amd.com>
 <CALPaoCj_yb_muT78jFQ5gL0wkifohSAVwxMDTm2FX_2YVpANdw@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCj_yb_muT78jFQ5gL0wkifohSAVwxMDTm2FX_2YVpANdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::35)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: ec03ccd5-cdf6-4419-4149-08dc5e4ed26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ClxwjvB0q45FBQaiGl+QBI2wJX2lSJVL8Oq+u8To+qDghaqWSoddHr100nW/qanXi6oN6QXw9edsLZIX5ar9s4KQMSJCzi6zlyfENF2T/RWdoSZj0TYBwWfsP01FAElM8yGVyBs/oFdI7BUsGgQPLz1xzHeDX+9YmOvZn6yDnorb0ErRcKuJVlWReaexjTXIFIZRjIz1KxRs5UnIVb0TrKDxgKDqwDYrchUhA2/xBek7p2wXBgB9mnexY/VK8xYw2UpSH9/s/F3KND0z8xS4yQRVPMQNwMw0lN3j/wSrsD46d7Ovrb62OhB1kdE57im8NdSyqeDsq3w0PIC63bHPsHfwgx7v0LiVgeMniyj1JDWRl8A3IR9sLAFhKz5Kl2DY9bCoDfIE/WmxknxoDIU1WbkLHIdE61ztxbOhBVqjgLIpNaa0YmHC+y+mwopG7pPHBSqpLJqSjXT7OYsVVKd9leOcvSz/nrwxc7NdiWJuAcXdygS8g5zSlZ/fvmErNuNIcHjppnUb59SfFGI39+etD+qUkXHKcoLZ7GA3I2RPwXmlHsTj4ZAZZcVgceVKIH2Fs3t4mCxRIHjCanJqF2F1iQsUYO1UgZse5XjHlvDsdPb9F3tm0gfavRI5UNHlHqbp8mg+K436gfkGn3jVRPyteoHSkDMyP95boqswwNw8VYI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVRTQVFERHJzc2VFVFFCL2xGd2VaNys1MWh0RVZ6ZXI4UmRtblNhb3hZVzZN?=
 =?utf-8?B?Vm1YSEoyL3hwM2ExcHR5YjhzZFdFYmJObk1hVGRZRmczOEJzYlRCMnpxeXM3?=
 =?utf-8?B?dm1YZUVvODllZVVBd2lNLzZaQ1lFdU8yNk5HdFFFT1JlVVRwVThIQ3lIdmV5?=
 =?utf-8?B?eVdXZzJ1YktDeE1oZUtDbCs5UmlLcG96emp3Zkg4MzVWUHRrUzRydDdRd3Zw?=
 =?utf-8?B?QzQxZ3JkemdSSjJiSE8xTkRXQ1FXZlNzdjNjTU5hZTk2dXJsT20yM1VwUmov?=
 =?utf-8?B?T1g2L3RSaEVLcGV5NkE0OWErM2NMSUJjSG9UMWdSZnBPQ2Rsb2orZjlzbXJV?=
 =?utf-8?B?emFndjlPWUxiT0Z5VHJlc1c3L0x4RVR0SmVKK3FHcm1CRnMxL3g2VllIVzF0?=
 =?utf-8?B?NTQxYzM2ZlQ4R1NybVdQYTBQWEd5ZGJKdE5TWE1odk9qZFQwakthZkdkQXlS?=
 =?utf-8?B?MWphNGY4NnRtQnJhUFFtdUtVUVBhSFYrSXZVUllVL2k2RVoxekNMQ3UxM0Nn?=
 =?utf-8?B?cms2YWxPVlZMMCswZFNhSGI1RnQvRFJrcXVXY1Npbk51ZVdUTXd3aWVpbi85?=
 =?utf-8?B?YUpTbk5nbjJyYjRZOFpMbWd6KzFOY3IwUGsvSFJuNTZwelFzN0kwQ2JROFZv?=
 =?utf-8?B?S0dkdlpWRHJXMnl1Vm11MEhCeWhqbVVvajNocmVodG9QSklGNzFqUklhd294?=
 =?utf-8?B?YUQyd1lPUDVobG1BL29TK0FSNXIzZlhlMEdvR0xMWlNFTCtBY0VsNGhGQmJI?=
 =?utf-8?B?Mk5yK2g0WHBxSkdPYnBwRXh3OS9ZYlYxV2VoRTFDWmh0WXpYbXVadkxjT2lq?=
 =?utf-8?B?R1piaUgyemh3dDZrOForMHFLZFRuVkhlMnV0eGhzeFE0WmNnM29JRmwwQzRi?=
 =?utf-8?B?bnZER01yTURjQzhiMExqaURBQW1naml1UUE4LzIyUG9MWWJVdFB2UjIxMUU5?=
 =?utf-8?B?TVpMWllyNW5zS3pCL3I5N2h3dWdYRkVnZnVkZ0k4SFRNRS9hOW92UlJNZjJW?=
 =?utf-8?B?MDNHNDBlZUNYeWhYc0tieHc0Q0xzZ0JHanJpSWVwWlNJK1ZwZm5lQUdKL2Qx?=
 =?utf-8?B?SWJtSjJkN3FCWWFFT0VXY0ZiMkhsV3BFVTFHWHloeEJPNThsWmNlSlpicDVX?=
 =?utf-8?B?M1UxUHhnNjB5Nzh1aFlPYklVYUZDTlZjb0NzTDhaSDYvSW9yMWp2T0JvV2JR?=
 =?utf-8?B?OFA4T0ltOXJJei9TNndoOFRLUlVqSFQzNm5Xcy9icHRNTmhIL0wyenlnUFpp?=
 =?utf-8?B?SHBOV0dkdnQrYUg2Wm1kaEJtNlFUZUdDSUIvcTZMbHl5cUdYbzJpOURZc3FI?=
 =?utf-8?B?Z2M2VGQ0NTExT0JzakFaenJHa1RmWVM5TGJXcG8wa1dxR1Ura3ZjSlpkbkp4?=
 =?utf-8?B?M2w3dmNLWGJ0TnVSVzM4YXp4aEdaRnRGWmRGSVozQmpMNXE4MEw2anVjRVVO?=
 =?utf-8?B?eTR2NDY4RzB4RlppSnpGTFpDVTRTU1AxcEtxZGs3RVhZYW5iYUpMbmt0ZFJN?=
 =?utf-8?B?c2d0OGdIMlM1K29NWm9VczVjeWFLdzVaMEh3SkEwQlhjbHhDMFJ1UUNYM0x5?=
 =?utf-8?B?TkJ0KzFOMEtxL2Q4c2pyTG9wdjBmL3NjTFVLSVQrK0JmeXFaUHJPUkJMUlli?=
 =?utf-8?B?ZFRwN1FrU1JYZjMxdFBLOUpKNVUrWGdmdEQ5TDZSODFURVFnelFKSkdWY3pL?=
 =?utf-8?B?bTd5VzJ6SDlyL2VtU0l1Y0VFSkN4dGd0NU5Qc0RKNlhOdW1xYzdRajFralBN?=
 =?utf-8?B?RStvMTYxdHpkUTh0VnM2Y29hZ2pGeHRtbXl6MGdXTWk4ek1vNDBwY0JtT3Bh?=
 =?utf-8?B?bWlkeVBBdlArMlYxTVJkTitSNzFUNFpyblV5OC8wNDZsWnhybU5HakRRNmkv?=
 =?utf-8?B?S1Y3Y2dVS2RXMFBZSVd0b3k1RUhxeElVd0p6NVdUbHBsZ09SdCtrSGFCOWlY?=
 =?utf-8?B?dUZVRkovZ2tqQS9uVTdxb2VvT0pUckdMN1VweWxYcytZN2F6ZHdQb1cyVXBK?=
 =?utf-8?B?MHphak9zdVB1N3R5NzhHbUlUb2RnVWNyYVZXY1dKSEVoT1JwSkxCbHhRTS91?=
 =?utf-8?B?VWM4TTFoY0hqZ1pTSmViRys4L1lrUnl2N243WDdJM2phSmJJSjVSRDJaMjJh?=
 =?utf-8?Q?OdUU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec03ccd5-cdf6-4419-4149-08dc5e4ed26b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 19:53:01.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vh1tcC6sz3+QDUVzVAVqkhPxNTpDF6TmGuagFbXC3ljx/gf9F9vFowIX3w7dnlYI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375

Hi Peter,

On 4/16/24 13:52, Peter Newman wrote:
> Hi Babu,
> 
> On Thu, Mar 28, 2024 at 6:08 PM Babu Moger <babu.moger@amd.com> wrote:
>>
>> +/*
>> + * monitor group's state when ABMC is supported
>> + */
>> +#define ASSIGN_NONE                    0
>> +#define ASSIGN_TOTAL                   BIT(0)
>> +#define ASSIGN_LOCAL                   BIT(1)
> 
> We already have an enumeration for the monitoring events (i.e.,
> QOS_L3_MBM_TOTAL_EVENT_ID), which should already be suitable for
> maintaining a bitmap of which events have assigned monitors.
> 

/*
 * Event IDs, the values match those used to program IA32_QM_EVTSEL before
 * reading IA32_QM_CTR on RDT systems.
 */
enum resctrl_event_id {
        QOS_L3_OCCUP_EVENT_ID           = 0x01,
        QOS_L3_MBM_TOTAL_EVENT_ID       = 0x02,
        QOS_L3_MBM_LOCAL_EVENT_ID       = 0x03,
};

I think you are referring to this definition. We need just one bit for
each event. The QOS_L3_MBM_LOCAL_EVENT_ID definition(both bit 0 and bit 1
set here) does not work for us here.

I can change the definition to something like this.

+#define ASSIGN_NONE                    0
+#define ASSIGN_TOTAL                   BIT(QOS_L3_MBM_TOTAL_EVENT_ID)
+#define ASSIGN_LOCAL                   BIT(QOS_L3_MBM_LOCAL_EVENT_ID)

Is that what you meant?

-- 
Thanks
Babu Moger

