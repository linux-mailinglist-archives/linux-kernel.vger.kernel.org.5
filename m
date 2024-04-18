Return-Path: <linux-kernel+bounces-150636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC08AA221
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BAD1C2160D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D8F172BD0;
	Thu, 18 Apr 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W3U0jHv0"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0C16F919
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465539; cv=fail; b=Z2FJflRlSguWlf1Dh8Re+OzO3DYAE5vP3RNiGtp+gdoWXjNu8StjRMA+yfj02Umv1RSU/RBRu79PHnqfZHPWyDjNxv760X+oSiswPtOFdB1VWPQM3QshED4GbENy+vSEwirHkPzcgjBjvQS/32PRWzJ4AGgX9nMaDLrx4okCbp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465539; c=relaxed/simple;
	bh=yu5CVsNxLrg26MXLBoIa0xHhyz9kK31Sor8RSi2fw7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NPHzm4Szzq5FSC4mh9CN/lZZm0k1qO8BczPW+LDKc5QNE9M4ragoA6XmObi0CyEtPmEXutz34kdYp2W+6AXbyIRdtnJKo6NTcObMNPg+LqFpQJ0QAFTwndXUQB7ipWbwHoP+F45wL70XWy7aDm6485x7P1rdBWLxyYpqFU494m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W3U0jHv0; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1L6jx3G5xd8zI78SQ3RLOPwQGpWl5MiolYcPaPv1/9VpcAoFI5ebUSno4YwZU3aKq+cfCDIJDDjEzJuEX0lKDLuzajNkFc75be9ubJUcrh/p/K4HqmB9YqzD2qlXgSNUIHdg+Kho/4zRGhloIxl8Z/wnafFZzCvtmZiRSZhoy5M0mTWw5NO1Z60xtkaAToxiQPmj2kB9m8hrRWTHyfvBmBsYLRzaR+LTAeu3NYxZ2fNyf4xUocOcb/cwiQDWDORz8NM1lTzp9Ax1/DKyWkx5rIX75XsS3lfe+QIDZ+qWCN8YG1NksiJslh8Yx1oecLNKGKllV+SsL7O22dmmyxv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu7GGKlAphx157M7g3TJ7xVPvvmaS0iXl5nsbRBqHIc=;
 b=YlQL4MT1xuTvg1DlHf3+SLtGV9M1bdv839VOKOULahcMQDExPp6PUIDF7q9ISbYLD8i8Gxi7lHywE+Ic0apxh0IpgeVpMuT7XlpxOZIVVy9VAn7WGz4pQNi805CLgyRBtwvFiQ2aCyMPJYH5aIWkPYZknv3y8dlmfFqvzZ/X4HM20qP2eLGC7B5DQOFUkSQP9k1cGVlRG7BOmJ0KeI/BKPJ7ijHqJEGgBzXCrTyDqyqYQh+kwAYpwZaiWdkubTcGieUJD4dsLJZq53k2VdYVDAth2P5+xqaSMjcXah6T2/gmOxwsLtpgB7PtH3qxhAfvBE+yw44C5Li5dXdZEg/SwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu7GGKlAphx157M7g3TJ7xVPvvmaS0iXl5nsbRBqHIc=;
 b=W3U0jHv0esJHoVK/Z0klBCAvUTsfZggl2+LgFo4EErsPO9C+2EQkR4+zrkc7YeycNo00JaDzVS7D9JMlMT89O5zukFsfEACW4NFkcfY/Cgsc7C/+UDIVpQwNeMHwpDhgV5iwwvxeDSAkoZfGwuunW5lhoDYXE1WvpwmMYMUKB78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 18:38:52 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 18:38:52 +0000
Message-ID: <36453f2f-3a2f-ae8b-215f-da9972f14d6d@amd.com>
Date: Thu, 18 Apr 2024 13:38:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 02/14] x86/sev: Make the VMPL0 checking function more
 generic
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <1b0d8ec8e671ad957a2ad888725ce24edeedf74a.1711405593.git.thomas.lendacky@amd.com>
 <20240417114658.GHZh-2sk47TZgCp4Mb@fat_crate.local>
 <505dcf34-93ff-643c-b149-8ef9ce90c023@amd.com>
 <20240417205048.GHZiA2KGbFFTQFyTAM@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240417205048.GHZiA2KGbFFTQFyTAM@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::6) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8bed4c-bfda-444a-17ca-08dc5fd6cb8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Q8lqZPz1NreAER8Dpc/aEK8mUM3eJdDtnTvnZSVzyrxpdO2RSuFGo4DONV0jNgqInDSV8QeCIJbhspkPvtHYnB5FgvIlnaMtma7oXk6zk2P7YXfLOZodz2LcKni0I0tFh+CPuEriYQSTkRiFWRoZNgvBKDbInzldAxsun+LEhyfXVz3Jzqz05sLnYbqWjU7IqiAZ06qkMzPeayBJ+vmH3Ukl9fbrcYXOIluJ3p4A5b4QgR1WCRTvtc6prhi8vYZLveNj81pyjkxA0ysRF4Uhu60AUCH9IVZ/Ts4d2gIxXH7DDDR4hnC2mzGr6cfHRHLVifKMHLWW6u112acsCZE6dsMd/LDc9KVoFLAOBU3ZtTsIMvgQCLmHC9uSG8cCAy9XMkFfTf/mlTz1hgxq17Qqj/fhH+1gK4y54NGzFDVGK6JyjMnZOaS7r7l2EFuh2YhMynh9hzAt+oWh4dcy6G/LLkenPITHkZWyyGBybwWBZ7wuKq5V3fbjk6BElcNVQHeFrJtm2vYfIGFbyfrEV4HVTPs9bzWxmNY6M+K5aYrsHlLJBJuzPfYaCAVuhLzHnYvr72xWAJSchLV9HHqdu1OtlNAmpUDvknu5FGjQxEZoLeKa7+wgEwa1iB9FEDhMFUB8FncOpWauNBxUjFr9L1xfC8QieiS9s0t4AlbH2+cBjs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkhZaW9ieXB0Rlp4ME9OVU1jbmNYLzE2NS90aGU4ZTdhRnZQekhDMHhiN3ZF?=
 =?utf-8?B?M21UVHNpNlFoQ2pOMEpXVnRtdjhMZGNVcEhjaFhpNk5NOERIQ3MvSTV3NllL?=
 =?utf-8?B?QVJLcmxxeFFuWDNsYkl0VnlqZHBwZlc4TkZmcFBLK29PWHgxTGRjRWdHcnZr?=
 =?utf-8?B?TWk0bkEvYlFNZXpsVVhnakorV3VqKzRWN1dOUThPbGV4emFSYytnSWluME1t?=
 =?utf-8?B?dXgwcERHSFUwWjI1Nmx4cGppV3gzK0VSN0N1OXlsbFhOUVpGcjZzc01UVFlC?=
 =?utf-8?B?Ni84akQxbEV5OGFqM1RFVWkzeTAxZjB4ZXVFamlVUWw5V0VLaTZnNWUzaXZj?=
 =?utf-8?B?WWtNYXdKS0tvdWhvY2ljWFRqcm14U2szRXBuUXg4aXp1NTJjUjBXMnJnZlUz?=
 =?utf-8?B?ZC9IeWpvb3NFVDA5aVBCL0p6V2tEdEJpZjliczl6WXc1cnY3VnZNSWxpRzlJ?=
 =?utf-8?B?Yzk4VGpBcXlhVWVzVEwxc3I2TkFlY3dEUlNsaGRiTjN2ZVlXYWl6dDZPRVlP?=
 =?utf-8?B?TXJCc3BrT2dSZGhJSlBlY0JoUk4vS3AvdkhhOEJaV0E4MDJSSVFDalFjLzFE?=
 =?utf-8?B?SC81TDF4QjQrOFBIZmJDWmlxeEJ3Z3NlMmNydmY4Sk9sUHpYcnlJYUN5dFMr?=
 =?utf-8?B?OHVyNDUvT3RseDNGQmFyNkwzM1pkRzBKSFozeXBBN01JN3NySktIVE03amJI?=
 =?utf-8?B?WFUwMi9tbGs3WHdBb01Mclc0SERnQ2xMd1JuTW1rM2gyNVYyaEd0VzdFZjdN?=
 =?utf-8?B?VUprYnRzaDEySDU5SldlNU1SemhxNm9yRnlzbnJEQWs0eDBHSGFUWlJTaFNx?=
 =?utf-8?B?bTBsdXVlTUVITzU2TktwMnFDN1BsaDd3elc0QlZxK0RtQ1g2NURXU2F5S2JF?=
 =?utf-8?B?MEhjNlN4MTA0Q1d3dVYzOEtkS3ZaZXVGeEF3V3E3MVFzcXFwTi9Wc0NwMU9k?=
 =?utf-8?B?cENwRWJ4VkRicUdDakRqL0NsYXFzaVViRkNpZFNFVEZrazFzMkZLcWtaN3dJ?=
 =?utf-8?B?ME5TNTBMRzNjUFNOS0FvMlBvUElhV1JhbUltNUNCeWJhc2xCVkt3cUoyeVQ4?=
 =?utf-8?B?UkFzVngyQzJodWVEYUtmUDJUWkdxdU1kUTRaM2VqcC8vM3NnTy9wbG5hdU9D?=
 =?utf-8?B?S05oaVpFd1hyT3c1U2liNVMwckZxYjBKYVg0UFlGcEx0VWZKcjhTRG9KOC9z?=
 =?utf-8?B?eUIvTDllU1lsUUhHVlRPSjZWQ3FvR3lqZ0RhTjlhb2F2NjdKaFVMZTBjN0Zw?=
 =?utf-8?B?YUpKUVBTVDJESnZCTDFlWkxFeXp1VDZ6TjA2VDd2M1NlcURqcm8wemV5WmZK?=
 =?utf-8?B?QTBMRTF6Z044Ukpta1lXYkl5cU5SRmx2S0FmSVVsS25CdWZKS05GSDV3aFE5?=
 =?utf-8?B?RTFRakpMKzBDTDBZSWNxUXdLUjVzeWNvYXZpZENrcTkwelJTbng3K1UxYytl?=
 =?utf-8?B?RlYwV1J5SHQweDhvNzNodDA3RnpDNUxNYjRzeE9hb0tkeUpXOXhybjI1eUFT?=
 =?utf-8?B?SHk4cjNTUWFnUnNUWks4UGgyQ1FPaENTNWRlbzVmM2IxN1k4WVFnVmxNVDY3?=
 =?utf-8?B?UnB3UWRtTGErRUZmMkl1SjJ2UGVvMVNqYmJRbld3eGxPNXN2TTZER2tvRFUz?=
 =?utf-8?B?akIyRlhiOUtBMXpheGtndUZGMFN5N0hkaDVFYjhHQlc3bmcrQkRpKzRWbjhO?=
 =?utf-8?B?OVlDNXhJOFhPS0JNRkp3K0hNb1VmOFZ5V2lETFdqS2JJa0pkUHVNL0d5c2I1?=
 =?utf-8?B?cnBsbXJ4NTZMRnN4UGd3V1RBMmlqY2xuQXBPOWhHaWJtNWExYmhIaDBoWjJU?=
 =?utf-8?B?M2NaTURiaHFOcU1WakdRaU1nb1RuaFVLVGRaL2JRaSsyMEJyb3NxSlhnWVdT?=
 =?utf-8?B?ZlNFa0lxRDQ2Y252SU5qcUJHeXpxeGh6SzhOZEhrZ1FrdWNLZFdRNWI3cHdr?=
 =?utf-8?B?dERaMW1IOUkyTE5NcERUMnBFclhLZnZpbXZHSndTUVUzMGk5dC84Z2hNRTZD?=
 =?utf-8?B?NE1kUDRtWjgyRzFEaTJneHJOZDM1UlNCdHhVb2kwMTBWbDVnbXZwNzFyQjFr?=
 =?utf-8?B?YTdRSHJoY2FMa3RvbE9qcTR1dWZKMytJWWxwWjI2cllaSmE1dmpHTlg0YVFk?=
 =?utf-8?Q?hKhFXurtBrVYSPT4Dr4pPzEVj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8bed4c-bfda-444a-17ca-08dc5fd6cb8a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 18:38:52.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLKLcALUofcjOPF9S1VyOa39XsfW+33drnYp2V6U8TcGE8S7sgOS0eVgZmyoeg18AkPyeuXybLBonZUC0wwzNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

On 4/17/24 15:50, Borislav Petkov wrote:
> On Wed, Apr 17, 2024 at 03:35:53PM -0500, Tom Lendacky wrote:
> 
> Yap.
> 
> The point is, it is calling RMPADJUST. And it does modify RMP
> permissions of a guest page.
> 
> Thus, if you prefer, you can go all out and call the helper
> 
> 	rmp_adjust_permissions(unsigned int tgt_vmpl, void *pa)
> 
> and make it generic from the get-go.

I think I'll just eliminate the function then and call rmpadjust directly, 
that should make it clear.

Thanks,
Tom

> 
> And then have the macro wrap around it in order to explain that
> particular use with the macro name.
> 
> If it is still not clear what I mean, lemme know and I'll do a diff
> ontop.
> 
> Thx.
> 

