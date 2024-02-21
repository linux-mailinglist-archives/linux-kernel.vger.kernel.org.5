Return-Path: <linux-kernel+bounces-75196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B71685E488
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECE01C2272A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA8683CBC;
	Wed, 21 Feb 2024 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LcsXboYF"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F2280610
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536494; cv=fail; b=oNQkosbp8ytJ1OeUNfq71UkeByDfaE4HFtiBHNB1mpNesM7RiYRZJ/Pz3WMxu6I/f6OZFsLIGo1H69UBdAwGPza1q0XkUKUe5dZ8IGjR92t6+dLa1AmWib6t3zsUQFIDadlqPjNLilqVc9GJgT58VlNZz8+fEL+HdTBNaRz8Zd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536494; c=relaxed/simple;
	bh=sv97NikMxtn3agQbhkCW4OIrGOWJ1UIkybzhCfueORI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sFM50YcJmT7Z05jHyyCgG1l/BpFenObOq6C6w5rte9JNOBCn2GVXOsXO/N+RTEa5U7XluCYQzRcGSsXc77vU4EzlF3U6yq2i3ORyvUoz7aW4XlHaTVpG+oeHzLR+xIqEML1MK/rC7ZlDH/PRsLLkkcxXapRKloKApMC8LZj8JJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LcsXboYF; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkV6estLjWKyx3X37eoPOUwUiNDpL93SIIbbNacXg23mcjDURXTsHyBeT2iKXT4g9wPJpVGTWU1h8sZWr3BL1dY4mI1WGrBOEf0KtQNqB1rJAEMJ5zPJlFK701ld4TKX2jeQGRybPt2DHIeYAinoXKUxPWc2pMpMf55T1QpBZkem3fFB0zxU6QV/WbkLiSPxH9cz4c0jypNTdfgwf9EFrq7UmiNksQxec95c8TiwBNgka2TPqv3yF3N+FtArmTATGxqFm0FeBGt2KmSBmw8IN1irBNnqMH8KR3lmE6i5DpFmahICXSuYHJVYdfUsNfFYMpqhgeFer4MVEW7MNH61Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoBNGj3DD5l1RrNFwS4u9DAzdQLKZEKPhA/vP87qUSQ=;
 b=gCV3SCjzIanAUJfA/p5bejBk1j8ctrgVN+ptHhQG44uke+FSFqrvitPGNQzd2UzgT8eBJGqAq/RzqQdMKAbidBl6+iI+U9VO02O/WyTLEAaz7L/l1Fem+SMQNQORqu1GsZD4dVoulh90FDXNIgiS4pU7JTCZj1Bp24TFqYX9+fIiZnOR+XZFZY6KOtomPE7GKjK/p7RnG+CscA/5m2GUQO4M9YdN5hcP3JkUi49Rg3UQ9SAY3QetnHs751hppSzmWAls6xKgjKhEpj0Hv43MilMvtT1XvctZa8X9Voim3O4EG6i7m9kTggAp4rGxFI+qt4sLGOFV+j0vYiOQAljRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoBNGj3DD5l1RrNFwS4u9DAzdQLKZEKPhA/vP87qUSQ=;
 b=LcsXboYFDZ2KIU81wnogslhf5ASoJWYU9vaY3NWo/kYhOPr0WaibUUABlqFJZ8upIvIfd234pks3+Z1xulQR3gGjaCe2/NkVC0Yi5bpFp57ukQv32+sa9kflBgyweuuiP7B2iQwaV/tVY30tRWyJ5bfZis9t6zFseTMl1eeBrEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Wed, 21 Feb
 2024 17:28:10 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::7bca:b335:5e25:753a]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::7bca:b335:5e25:753a%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 17:28:10 +0000
Message-ID: <f1a5fe09-f4bc-0dc5-edda-6b3e690bc0e3@amd.com>
Date: Wed, 21 Feb 2024 22:57:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
 andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <15fcf98c-58c5-fa08-2e21-f3b0baf058e6@amd.com> <87zfvtg2mh.ffs@tglx>
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <87zfvtg2mh.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::32) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: b29e7911-a783-440b-663b-08dc33027960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9yVL34BXR5rmuKRscaVfCCIbCaFG425f/sDkODcvUjl2oaUry/J8MwWGNRprRGiih3s3PKvHsMEasI103jVzmBl0NkB7k+aXEweYM12WSRmcBir3+DX6if0Fs7frJVzvbpK+H3VkrpF5WvjQSG1giyJbPXNJJ5kLtAWG8mXpqDXJn5Hl3qrTlDI1hZKLvtWm2pdwKdVmUWszbaU9t3X1PoxVl10oPGAGezswLEk7coPvK+VUVJ0uU+2eQhGxnjYY7TsOnt6yiW61ishMqQtxCV6PFZCRMKLtcRgvurRP8VF3kRapX1wKiNwfUdnXKb4XKLYFVwXsjUvxBSLM0D/yS1MUV+wuS55rZdSjSH8BPGVP6NL6mp7qZOcnfuop3BOXGazb2JPqqevKerc1mN+GbEobz+aDtiRrWyj84tjqB3DQwjDHs7m9s3YrwG+YnAmWfZ3ie6iypJL4V6heXxe+0rvkha85Dk7Te4gdNV2nG7mAV1upAaRETgH7cJ+W6g4k2i4yFTMwImuYIILnan2TJhOwMM0vGyiqbo5rwd571dA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW5hb1hULy91NDFLMUVUN1RBWVdFdDdMZjBOVFRhQm4xRC95SVRLclJtUkwz?=
 =?utf-8?B?eWFSelkyQVZjMXZCS1pGejVpMGkrcXczUTBOY0hZeWZYNTNwdi96ME1BTW5x?=
 =?utf-8?B?TlVvYUhuNm1OdEQ5N2RLYXg2QThGMW90aE9GNldmVWc1UkErVE5vWkV5VWNW?=
 =?utf-8?B?SExmUzRqbFBHSW5UYTlFRHBlc245bU1Qdk5rRUVxaHA1SkFDTTVTSTVnUFlI?=
 =?utf-8?B?U3UraldSbzRjZHZXcXpOU2NPRVZ1WGF2aDVNSVI1dW96M3o1d2g3V1hoc3J1?=
 =?utf-8?B?MHVHblpYMXE5OTdKVFJ0djl4OEJUbnR6dWhIQ0RmRG5xVTVmdGxvL1gxYTl4?=
 =?utf-8?B?dm9mcW1mT0QrWWdMcmRaR1lVdDU1SHZCTTQ5c1pUbTk5Y21DUDh6VkViRm1u?=
 =?utf-8?B?VFk3UWhNdXh2cEFxeTVLUTY5K1pyemZ3eUMvcitvS2R4ZEJWMC9TMjRqOVpO?=
 =?utf-8?B?UWdKREFaWE92aTdYUGxVaDNpd1o1UWV5TnRYc3Fna3lVNVNFV1JvVW1RREJ2?=
 =?utf-8?B?bk9JNnpGNUlJM0J1NEM4VUJ2R1U2R21JYXpOcGF2NEpjQWFkV1R2aE03aTVl?=
 =?utf-8?B?TGlWTFIyTmoxUGhHMkpXRlZzclRkalQzSTZlZlBESi95ZTN5NVpRUXcyOGRH?=
 =?utf-8?B?c1JWcnBWdERabFU1REZ2REFDcjlrY1c5dlZ6RkhKQXJkZURLTExZeHBCTG1l?=
 =?utf-8?B?QmFnL0gvN0ZqS2hMeG12NldyTTA0NWFVSlhrdXV3dGt6OE5VSHRVNDAzQ3g4?=
 =?utf-8?B?azdaMXA2SWlMaEVtUW9wNXZpdEQ2THJRd0cwcW0yMlFOTWlscFoxdnE1NHlK?=
 =?utf-8?B?VmQ2eXl2KzZFRDJVSktwbC83My9vM3NmYlZaR3NSVnRVVkhiNlRnclZ4eit3?=
 =?utf-8?B?RTZ0Mmc3SWYyb0RrbXZJVHNCTUZkWWNEQlZ0VWwwY3JxREhITnZNV3FIWmhH?=
 =?utf-8?B?S2FES3FIc25NbHM2OFJIU2hQc3lsb0lGcnN0QjI3RzVXUUZSbXIzQnlzL3lR?=
 =?utf-8?B?L0w3dWNEdkR4WmtOczB6UVV4WU8xYWMyZ1BFcHVUWnFwbE5kNENVbmZqWTN5?=
 =?utf-8?B?dHlVMkl0TzQyQ0dXK05SVTFSZ09qWUFFZ1cvS09XTnhxMUkxVFpEZUFPOTNC?=
 =?utf-8?B?cy9KVkRWa2QvS2VraVZlSEV0ZnJwdFIvcS9FSkl0VlZVV3pHMElMMTBRTDhw?=
 =?utf-8?B?anZMYkJ0eEVVS3NKUER4bzliRDJlWjhPVHh4MEk5YUpEZ1dkRGFNMmdwK2Np?=
 =?utf-8?B?UDBEQUd0ZmtYSEpBbDB3U1dNYWJOMkM3WXd5a2lPdnl4cVEveVNKZWh3Y0Jk?=
 =?utf-8?B?cWJDK2owM3M5VHF1dzFXaG40dHFEOVVIem1nSm82QWJGMURxdU01Tjc0T0dw?=
 =?utf-8?B?RHROK0FxeFluWkw0b2JZSzVpdW1vMDhCU1RTSWxxL2lycHI1bmVtcWVoWHgv?=
 =?utf-8?B?TFF5a1Naa1pZRVh2dDNpK0Vma1pqbTMxU2QydjZLVzEzQnBJSXRPbVBGV1kw?=
 =?utf-8?B?VklGUWM5cmc5T0JXT3pvNWhYZVl1d0dqTzNDTXBmdWc4ZHFnYWs2Q3JSdHlE?=
 =?utf-8?B?YkhVb3dyTTVNaXlTTExWUEFtaTM1cVM5OTJJZ0NxNnFOdWR2MWY4SjgrdHZM?=
 =?utf-8?B?Mk9RMW5zZEw0RFNuMWF2TnNHZWhkYkdhZU5od1hjOVYzMkFFUlhoUXovZ1lL?=
 =?utf-8?B?d283cVRsU0JBR1dPT1hFMkQ1aGc4OEZ0UUwvblN3UmJzdXY0MkRLem8yWmV2?=
 =?utf-8?B?UVowV1Job2lBU1ZNZm9SM2R0MG85a09YblA4OUllWmFPcUo4RkxVTFNoMXls?=
 =?utf-8?B?VXkvNG54VzhnR0d1VENmbUVuV3NTUFo4Rm5ta2xQNGdVMGZoVkpiVmdUTy9y?=
 =?utf-8?B?RzlPUHVQUFdIc1hOZUpGUWNzbUJXTGR6QUU4a3cvaEJOQk1FMVRKL1hub3lM?=
 =?utf-8?B?czlZMzlvRDI0Q0U5SjdaM2FyNmtnTTFuZXMzd3A1dXB2L1lYdWpkdnpXTVFX?=
 =?utf-8?B?WVBiVEpmeVE2Slh5TkY2WHdraXV1SXA0dTJBQzB6OCtXbXZWN0hIUEhCWm5C?=
 =?utf-8?B?VStaN3RkNzYxbDVrdDZEQ2hIaTFZSFp0QXAvWGNpYUg1NTQ5L3o2dnRHZmdN?=
 =?utf-8?Q?Bf+X6brc4jvShOKQgxiVrXcAi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29e7911-a783-440b-663b-08dc33027960
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:28:10.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVljjil5DQ5V7wnoH1MJDp4DfqE8Mzd76ZplfwER85bghOVaKZfCh6r35139KlECt9guldixDLFQLp9VICvCVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803

On 2/21/2024 10:45 PM, Thomas Gleixner wrote:
> On Wed, Feb 21 2024 at 17:53, Raghavendra K T wrote:
>> Configuration tested.
>> a) Base kernel (6.7),
> 
> Which scheduling model is the baseline using?
> 

baseline is also PREEMPT_DYNAMIC with voluntary preemption

>> b) patched with PREEMPT_AUTO voluntary preemption.
>> c) patched with PREEMPT_DYNAMIC voluntary preemption.
>>
>> Workloads I tested and their %gain,
>>                      case b                   case c
>> NAS                +2.7                    +1.9
>> Hashjoin,          +0			     +0
>> XSBench	     +1.7		     +0
>> Graph500,  	     -6 		     +0
> 
> The Graph500 stands out. Needs some analysis.
> 

Sure. Will do more detailed analysis and comeback on this.

Thanks
- Raghu

