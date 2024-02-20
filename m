Return-Path: <linux-kernel+bounces-73193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0729785BF15
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09642842E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF966BFC6;
	Tue, 20 Feb 2024 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LhmDjdlZ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673BB6BB3A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440481; cv=fail; b=C+9SuOgnMFvEvI7cFXT7dOnS0ExpYkph1eGRnp8N1+deYa2DUKAon8UCy4UC7Ev70Xe18u+WldtraAWvSe6uDmJDWhMnjF4PEvUX7WLpnvJguOFzmfDSaPZIcigkekMRmeQ8/EWkMi2MZ9SL/Ixuys6p3KCNbCjnnX3H3LDOPrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440481; c=relaxed/simple;
	bh=5AHWFnFl947oJtZ7y2rpPzIVdFTgNvmlJT8rVQEM1c0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qcIXRJ5wddb5r+R6u7HYAigmSH+3Ls5BMNboyu8t6XiGKwgdYTIeshoR21SdXdmMNW4o0NZVc98UulwbpK1rKIMbzrTzvTknI4UkCuYm4orlXknAd5uDxagOigChD+dDhgvMRLPPUOA/7a8iDr16ZTgAVuulAI67VzPHJEIh5jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LhmDjdlZ; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIaK3UqqAJyz7Mqv3w7sNWkZYSjVzxeT1Xv1miOFXtYhfB7g0TjOXnb0GO+HIA9OWYZH5mF/nkHTKiF8dMwlz5abSnyo5jcC1A2DeWBjBS/ahY46w0anHVdncStbrNugE/hHzYnxCex/3naFYL1tVSQhAlXLozW11JNXCcduw7q+7Kz5VVPMyIMhxBgfNqIz3IluvbPiLwECOhsVjn/hCrge8x8zUHdIhyfGvfOnajAbALEVAndRna72goFVwgO/dtdNlmgzwZDG1uh8dm+SSgRlyNYOIaJUgrwi4oxMc/lDHPGKBEmnm+JthBjzOQwcnPdIi2PAtlnVIuDKWVHd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGeV64RyBrvE1543G6yvIyF4boehtdTZt/W/vgbNnr4=;
 b=c668NOM+SuZrwnGr2VwfMBMAGhHjHkytAvdjZbxIFsA7yyiCsH2owkIGuzJy6gp4/YDWzwYlcYwIPFbgNrEU4Kl0v4G/JcVkvbNarR6riUDXUzZVBJQ8ItLjnt9ivukNMGlKg6krq/mP21ZKhIip/lnvo+1AlKHPHlw7H5a1fAtTo2tgVWqkdp52orUeE+3g1uWMkMDx17ehwiBrABwLHydep5PGcd+Vx7mOihFkB3THefoU7IkVaTJPu6lM7f4M+E77cQE1jol2+ING3KpkMBUaJn8BHN4Poh1yThUQENPxwPxPJt5bnEllD2mi7UAnBZb3XNjfwkUtNSIsWmvcrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGeV64RyBrvE1543G6yvIyF4boehtdTZt/W/vgbNnr4=;
 b=LhmDjdlZ0Gd+eElP/4a01sgNT5P+EQjiDTzr2B0I6Dy5QTsNJvdt+NNkJD2ZUkdxGJjd4zJWyMior58+77TJGp5kCxo/K03AFHTQ6qZ0R/wL3FNElzMqsdMqdx8hzeFhWkcGvCDlMph21Br45iOvZnVDpgbjV/SkjSiF+oPqkbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 14:47:56 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 14:47:56 +0000
Message-ID: <28a494ca-3173-4072-921c-6c5f5b257e79@amd.com>
Date: Tue, 20 Feb 2024 08:47:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache flush
 during kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: "Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
 tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, chao.gao@intel.com, bhe@redhat.com,
 nik.borisov@suse.com, pbonzini@redhat.com
References: <cover.1706698706.git.kai.huang@intel.com>
 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
 <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
 <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
 <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
 <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0141.namprd02.prod.outlook.com
 (2603:10b6:5:332::8) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ae9ec4-05e3-48fd-5267-08dc3222ecdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1iYmxIuEIjwCofqy2dpnhTkRB2439wZX/cN6OsKHIt4//oLXX8TdhEnA6Ryg2giOvIc1eY4DOxYnsoS5KsUaSDYWTkmeFUuvdmVltqIJPcvXuLTa0NG0j2ExWy624csibR/8bAudWXg0g1l/OiTUeCYzRUJoSU+K7oKXW9fyzFNtOurKInDJ8MHqVBLhtBMuZIMyjUEpEK3GYVfQWbINvnYakX3nFsIpb0UiImcTm7HFCJaSKqt2nVL0zrVECSyw+OvNVZYo2WdrUTBU+Cau/ypIta/6YqIKMqwe0JCoQxNYiMPnr9WPDbgs3tQspgm2Ijnj+Mqxt2HMZxCmHSf/UJuiCZGtwWbZSDS4bF6EgOrrMpVKGwu4W4quNXvlvKuJILN5cpJwKjmWB0/fsWFkRqaJVo2KEFyYTVoyFfJEmH9BL+lm/i7OokrGendQ8l++8n/UNDraJK3bQrHXEzoYve9Rz1mcNI8aKx1tI3kfKAYClmezNpkAD/cDH41lsew4eFYJ2lO88rxv256+UMEUjl5iXez4umrY0xzRpslLedc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXMzTzdqRmwza1dwWFYyOSsvL1JZdWI5SjN6bWVMcEkyT3NVL09XZzl4QzZw?=
 =?utf-8?B?NGJjTnpLOTR4WTdMRE80SmROM2JoSkF6eFViNVNOL3lISVVQYkx5NU05SWF6?=
 =?utf-8?B?NUZRMkcvQ3ZmN0VPN0YxcGlHM24zYktPY1IxTGVLN2lXK2N6RnB2MDF3VU9E?=
 =?utf-8?B?c3BpUHVsL2tHN2hIZkJnN2NmL1Fvano3Z0h1N0IrQlVGZHRTbWRJYTIyUHdD?=
 =?utf-8?B?VDR3MUgxSGVHTTFaZUJianNnRm1KM25PdloxTk41Q1ZqT1g0MzdvNll5YTRL?=
 =?utf-8?B?cXd6ZE1pTXNNaGtSdUdIOVpSQi9Wak1vVXNISUZsaWV3cExNRldydUJrckY1?=
 =?utf-8?B?dXNNdGlPS0dzV0ZTTW82aDU0UTd5Nm51RTNCUiszdzdqKzdxZTlXSlI0TS9Z?=
 =?utf-8?B?UzdlVjBnN2xCdGtHVWZ5YXRSQVdteTBTR3NndzdJNWU3eFU4QndkYkFqUjVM?=
 =?utf-8?B?RkRIV1U2T3doeFdkQ21oUG44bXRBRm5IbFFIcG9SdUVkRTR6ZXNseVlwRHg4?=
 =?utf-8?B?bmFZL3R3MVVFQ21zU0RDdWxHQnNWd0ZuQlVHNm40WFQreVh1QXcwaWZPRDFF?=
 =?utf-8?B?aFErYnJ0YkhBYjZVV29iZWFMWC9GaWhkRENhRmFqTldUc3l0dlYxNjUrZkRC?=
 =?utf-8?B?L1JkeXRrSzlUaUNYcHdXeEJQUGw2R2tueVVnUnBadVRwTHBMajA1dC9RUEUz?=
 =?utf-8?B?K3VBcUwvZUM5bEZKdlM1TXZmVkZXa2Q2bk1VMUVyRFhqK3BtQ01TUlNZN1Fu?=
 =?utf-8?B?UllMZW9IRVNxeVFmNytINTBwanMwUXZibTNXRE9EcWo0Z0hjTEw3QWg5RDN1?=
 =?utf-8?B?bmhiNmJwd0VIOWFvVS9lN3kwbDdGVmR1U1J3ei9NR1VnT3JvdHkwTEw1RzV2?=
 =?utf-8?B?L09RQnJiNDFERlk3dXphcWZ2clBCT1JFSUJWUm1mVUpzVlJEM0hQc1Q3ZmN3?=
 =?utf-8?B?NXlGMnNmcHhuVlRLNVhEci8xWk5YN0VONGtkenN1dFpqdGwyWVZ6a3FWTkVp?=
 =?utf-8?B?NTc3NWdSKzV4bWRPRk5UcElSQWNpbkNrY2xTRDZJd2hnRHlHN1hqR0xjQ1Rr?=
 =?utf-8?B?U1QrR3grOURMUEcvQzhCSUltM0UwN05aL1dVaVA1RkJ5OWJ5WlRZYm15UmU3?=
 =?utf-8?B?WE4yWGhzQzVmNWNxSHV5WEFrRXFDLzltUXNaQUZYaXZIUG9Rc3JJV2Y2R1h6?=
 =?utf-8?B?TFlVSWQrODYyRU8wQnF1Wm5LeG5hWE9VajBSVUJrUnVxVVgyeHpYN1JUbzZR?=
 =?utf-8?B?VGlhUUtIUzRoZlFOOWd3QVZ5VFBtTm03UENBemdxbHpxRUg0RmJKaWZhMkJi?=
 =?utf-8?B?SWRiSnhOcG1IUndtZS9SQWVtaEN6K3ltZjNSMXFkYUhQMWM5OEMwMktIejJm?=
 =?utf-8?B?eG9zRVJjbmFRNjZJRlR0UFhucUxoZ1ZxbEIrRzJXemFMNXFaSjBKOFEwZXBr?=
 =?utf-8?B?SXhqN3RDaWhMeDBheWNFbWlBbDFaaGFzYjYvZlRCVEZ3R1JuVWV3L251aFFp?=
 =?utf-8?B?UTVmb2dGS0FrUDY3bmJobkQva3ZTYU44ZUxNZXRXeGJxRUtVNjZBbTZEY3RS?=
 =?utf-8?B?dUVjalJXVFQ3Y0JEUENaa3NLSWlFTTVuYTZQS0o4dWx4a2t6U2MxMHNmWGox?=
 =?utf-8?B?a3MwKytBNGZrWlBmQ2ZNMEhReXZkeDhSRktLdHA5SS94M2FkeEZ2RWxTSldU?=
 =?utf-8?B?dDQzaU85OWpmbElSTVhIVkpwVUc2czVqRGM2NncwRlJmdDF2TmdHRFI1V1RK?=
 =?utf-8?B?bjZkNktUVE12TWNmYnVqL2t2M1o1N0VsdXNUTDBZbGlZT2c1VW5pcTJPcGVa?=
 =?utf-8?B?VCtnWFVOaUJWelZwUnR3UXRnY205Y1ZnbU9icEhOV3Bhd0g4ek1CTStZL1dj?=
 =?utf-8?B?MXRtZDNPYll5SUd3WGFOT2IxM29WRHRrOXB5REdzcDFIUy9qQVdwTWFBekRa?=
 =?utf-8?B?VDY4aVZrVE5wOGtsNHlVeXRtcTB5NW1lTlA1RkNobExxSmJXNXhBOUxRM0Qx?=
 =?utf-8?B?b1ZXUzlCUXBSSkhEOWc3RDUvSmp4Q3dLeXhqQzE0cm5RM1BxcERsVS9BNjhW?=
 =?utf-8?B?Y1BrZUNJN2tJeXBRQStWS1A3enVCek83TDhVelllTnV1Y082aDNvL3Y0cGQw?=
 =?utf-8?Q?Af0WxKAxtHg/axVVHnFglP8zM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ae9ec4-05e3-48fd-5267-08dc3222ecdd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 14:47:56.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okMqB8W093WYhKsP6v4bcXaU9VQSFsJZYp+2jIC7PpswFceW0lFOXZ4tl8pnS0V2UqinxQCROBT9gvP7UQzVaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134

On 2/20/24 08:28, Borislav Petkov wrote:
> On Mon, Feb 19, 2024 at 04:09:47PM -0600, Tom Lendacky wrote:
>> That's why the '!(sev_status & MSR_AMD64_SEV_ENABLED)' works here.
> 
> I would've never figured that out just from staring at the test. :-\
> 
>> Basically, if you are bare-metal, it will return true. And it will only
>> return true for machines that support SME and have the
>> MSR_AMD64_SYSCFG_MEM_ENCRYPT bit set in SYS_CFG MSR because of where the
>> 'cc_vendor = CC_VENDOR_AMD' assignment is. However, if you move the
>> 'cc_vendor = CC_VENDOR_AMD' to before the if statement, then you will have
>> the WBINVD called for any machine that supports SME, even if SME is not
>> possible because the proper bit in the SYS_CFG MSR hasn't been set.
>>
>> I know what I'm trying to say, let me know if it is making sense...
> 
> Yah, thanks for taking the time to explain.
> 
> Here's an even more radical idea:
> 
> Why not do WBINVD *unconditionally* on the CPU down path?
> 
> - it is the opposite of a fast path, i.e., no one cares
> 
> - it'll take care of every possible configuration without ugly logic
> 
> - it wouldn't hurt to have the caches nice and coherent before going
>    down
> 
> Hmmm.

That's what I initially did, but errors were reported, see commit:
   f23d74f6c66c ("x86/mm: Rework wbinvd, hlt operation in stop_this_cpu()")

But that may be because of the issue solved by commit:
   1f5e7eb7868e ("x86/smp: Make stop_other_cpus() more robust")

So...

Thanks,
Tom

> 


