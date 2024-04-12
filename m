Return-Path: <linux-kernel+bounces-143001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6F08A3314
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABA9B2228A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A5514882F;
	Fri, 12 Apr 2024 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UgBYN6f7"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9593127E00
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937898; cv=fail; b=efj3s2fbrz/E4C2sr/Z/qNjZhtXmsBEsC/yguoRSi6xyxXKihXvXX3OfcNAdCYjvMmTXM3HnRzMWinubekObwGjoj9wwDlXyEJDr20wTcGrsAjc23mgYCAJcp5tsaHn6WUxQEgx/n39FwX+T1OrlAMgM1xKtaFzA86Qtj2BJn2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937898; c=relaxed/simple;
	bh=frUFTINjiPlUfVaud41tZAJ4ifUd2TYWBBf9M1++Ci4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mBrx+Klo4WNkWvqjuwio8BBk8SFLYbkdxPJBKBhL6d+5cRnp5AMWBMsCDumf8nSodCN+w14NGUr1k4XatnAB9AnlQnoeN3fJWoszq3W4TNzRWlrTF+yBWAETJ373cJ+MF+cBFCi6ZiqrR7DkS+gMTf9lScRcbKldlFIlen/IAc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UgBYN6f7; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTAMLelupcMLv0kYbiCH3yarpW6YKYvUcSjLiGGXJCtrYB9YDDMY9zpbl/4I6lH7wjKERPzLaYFlg8UYp72cJSRQQ+gSkI7YQrt1uRVXcHVX3BaPjBmv8Q4XtCb124pEb9koyvxXNZd3Je6QjPKEOUc6m5NRl4WKklLjZtL8RBuXxTgX2KjRyXOrvZziiyi6fllOrwce4YqG9ERBorZALCgK2oT61v4Dd853LCGzX9X9WGgSDc76n1HSZosBT7Sf6VzIyP99NnguU50sFCbsEXto3e9AFCxJGiIAOqCIWKvFSyXfg4CTWq88EwJPNNuIV6vjBA2yh6khuhEuIFfH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd4wJGSHk07/n59+G0e4EJBQdI830Ohk4K30gvGh12A=;
 b=hyK8NzNSdEO0UqONt/VxDbMSWTN7sKJirdECI8SedOkIQpU1rGkafbikDDOGPvyeaNjrk5XfO6dLGY6Tk22rbosi630W65g6HvCAxMInWi5dGT26FPucQamdos7Mj5C/1PnWSVafq+LwmN3PA9KvoBti52/h6zGD9G4ybr6Gnh/bh0Vh212kJOub1C9z6+4yu79GDM8pWuUfBAoZez/5XVvc82MMfE5q2CQXGjGqkPluoQveBsOTGHuewHN5eumydCXJ8rqGw1JgNQMXSRVw3EFl6hAviaGZAelKyvaB3vp4d8pVleHtwrB4O0MF0ht4DMA/wxYRmVxoqEiJOPusEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd4wJGSHk07/n59+G0e4EJBQdI830Ohk4K30gvGh12A=;
 b=UgBYN6f7PhCizj/EgNbPRnYAahROQE5BrkP9c90J7jjPCUVpX7cKnp8TuJ06b6/Unx/ozxZ1q32Qc6qO+6rqduInSXPSl2oI9BgfIIfEr0cC88MqxEiGWlWOf412m46nigjD14eR6MpYinidOY41q+wR7YT4peBTriaDsDaXvIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 16:04:50 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8af6:1232:41ce:24a3]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8af6:1232:41ce:24a3%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 16:04:50 +0000
Message-ID: <351c100d-b41c-9d80-4b8e-2ebbeb54fc14@amd.com>
Date: Fri, 12 Apr 2024 18:04:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 04/14] x86/sev: Use kernel provided SVSM Calling Areas
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <9318f3ebc1f5692bfc90b5b995ef7e936cb31a5c.1711405593.git.thomas.lendacky@amd.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <9318f3ebc1f5692bfc90b5b995ef7e936cb31a5c.1711405593.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5f2677-ad39-4cbb-39de-08dc5b0a482a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wOV9Wsd6bslmcYbK3qx+5kIIN4etOg9yE7YCr/1E0ooT7NlA5XgnWnI9dhkRyCaqfTR1/4560S74rFRSftHypq3HcqO2+QqK+lw7tJ4qX2BQL3w14l3LxbtHMyxWwViW7MlgTc7g1svjDeC7YR13k4Q7uOMzet2p/BtDz5BliLNMtFYBOoYXIZ1xswU/d5YsTG67/EuLqAdqGvoPMqKCINlWyTE9Wqp3uCj1+Y1fMFY8lvP4741UBdFCNJbdBRpMa9FYNKsEZ9k+ThmxzGUvTi9gdCYiEXKQogFNu3ikLOUUPMFyvK6xDLaVhUOMFoHLY0tijN8w3mvo+4rB1/AKh6F+kAMEleyyIQUfni8ygO34P8Ssmq3V78/mnd7FRFLEkfRoGWtG7wM7ib+5hr1FqH3IngHsgnrWRCmxVDX8qCO/2XJhgoDtdt1zsWCoFsRIj2+Db44cxGkNIYQBN+rRfuDWdfjtdY2H6ZQehCSk/AsjccXWxx2ZW3hZZP09mXenS6iiWmQz4zroHbdga0gZh6DhtOWxMNpKSGO3hvqd3T/Jf9MzZnV2P78PeTrmwKOgowB/C7eOsiVG1z+qD2U0Gcw2Aszfmaeqx8ZQcsNJpqKgNYzsVAsc7P1bkG0AFXQS6sBuQiP/mn9cX9ChlgGSm9h3pAEIgM9jj1g4wpAf898=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWRKZ3ZhZk81Q3BTRUpLalF4SGxzcHgrRlBNMHR5U3dFcXdoZG9SbVBCYXJj?=
 =?utf-8?B?dFBiZk5QTm40aFlMMmthUW16Y3h5elhabHdjRGpGVHVCVXJqSmE1THRNK2Rh?=
 =?utf-8?B?WGdxSHF0VnpFMmFJaCtGZ0lGK1pUVmJVSXVXbms5MVdoNUllNGVTMHFqRjJq?=
 =?utf-8?B?cjRxUmRhcTRsS0ZKbVVwalY1enU4b0p3OVlaMjFiOEdqekVTZktnT3NRYzk2?=
 =?utf-8?B?Nk1LMXZOeGprdzV5VEQxcy9ScUdmNDBxVE9BVVFYVmt6aERzb1MrVk5rZTFQ?=
 =?utf-8?B?N1k2REpzejhQLzJqN21TR3pZUEE3MmZWd0prbVlOa1FpY0RyK2M0eU54WjJx?=
 =?utf-8?B?VnVzWlYwWlFMSXhMbnp2TTdFYms1VTlNWE8yakRWSVcvOTd5ZisybWpOR1JD?=
 =?utf-8?B?UmNpNTArL2NhMUliSnl1YVRkbjJSSWNrN2poZnk1NzlBZ28yZFNCUUpGV2Rh?=
 =?utf-8?B?ZkYzSjVmQVFJSGc5aDlSaWpTeE5uR1dYYXgzdkRzcDBaNXUyMll4SWxFbGxh?=
 =?utf-8?B?WU1TbXJ3ZnNDYlUxT1Z6VjNkNkZoUTdkLzZ2dTJuKzJ4ZWpFZmtIcTg0d0ls?=
 =?utf-8?B?YU5kNVdVYTlEbERTdURwNmUyT3o4Q3JoQU5UdHpwWUYxWFRmV1k5Z2grOWVm?=
 =?utf-8?B?ZGlJck5WUDhXamhvY0lDaG4zVzV3V1JjTEppN2V2aHY4eHRQdlBTZUFpZllB?=
 =?utf-8?B?OG1vYzIvVHJhTU1ZRkd3SGNGSG9oVVBSM1QySENjKzhkNmhYazlTbHRtakV4?=
 =?utf-8?B?dld1Tzdwc2d2Mm43NGlBR1NzdVdRWCszTUdzeDJrWnhhQmNTd3pwKzdTS3Fa?=
 =?utf-8?B?aXZYaGkrdU9rWXBFWEJFdUg4T0QzV1FBc1VLMk93V28zU3hEYkR3dUFjajE5?=
 =?utf-8?B?RkNYTm5qcHcyaXVuWTlxNHZ2ZE1zbmZiRmNaSXk0YXg3TWpVUytkR0hYemNR?=
 =?utf-8?B?VUFrUlI4a3pvV2xpY1graWVVQTZqQTgrTDBXa21CRjd4M2tMZTF2dzBkeUZQ?=
 =?utf-8?B?VVMvZWJRNlp5Qzk2S2VtY2NGYjBpUzdRQUxZWG4xY294bXA3MkJBMnc2UjdW?=
 =?utf-8?B?cE1zS2pvVkRrd0dsZ1NWWEsyT2pNMjl2aXFkSjhVaWRMNGlIOWp1ZUl3dUZI?=
 =?utf-8?B?VHFKS2NvM05jT1hNS2hGbVFEN09lc1JrcmQ1c0Rjei9SNkxMRzIvanhRTFZI?=
 =?utf-8?B?WC9uOFFmN0JEVitkaC9PaDFlQ3JpSEY5UllKZUFSbDByeGUyYTdkYnNXMWVD?=
 =?utf-8?B?Tyt6L0Y5V3c2TUR5Skk2eUtUeEViWWZjUk5lcXNkTm82M05ONkZHOEFNamlN?=
 =?utf-8?B?ei9rUkpXaUJrSVQ1Q3NnOENzR2JNSDM5SG41VSttUm5GdlJUWVVLTXJoSmZV?=
 =?utf-8?B?a1N5ME1VTldnMVh0ZnlrVHFmbmFPTXNJUWFwaTdNV0hBN3lQNmRkdjk0RWYy?=
 =?utf-8?B?czU0dkJBZXZPeGhtdGxxNEVNN09rQmlGNWpnUll3YWFBSEFkdWp1L2MydDYy?=
 =?utf-8?B?bG5CdXp3d1p5K3R5dDFaY3FpTEdVYm9hYmJ2WkJZTk1VUUJSMDVBeGNlNzRP?=
 =?utf-8?B?VktNTTlxM3NsYll6NGQyelVtR0dNdHpBT2ZVekVyM3lBcGkrV3o2NmhDQjM0?=
 =?utf-8?B?TEJ2clhlTnRUNVpBd3RlR0lHNnloVGtFUlZJUThjYTRFNEVvaER0ZmNUZ1NM?=
 =?utf-8?B?aWRPeUd6UXpWQ05DYXZacURNb1R0OWtJOHgrUVM0TDE4U0JPdyszbmk5aHVJ?=
 =?utf-8?B?QXdvSTQxTWNncDcrbit4VWtFNTUvRzZIT0dHUmVPTG5GNzFUdjlONm80UXJE?=
 =?utf-8?B?a1FUVVVSbXZnZ3pDMnhpd2JldWh4bTlyQXk5T09PdFp5cXBJalJxc0s5TVdY?=
 =?utf-8?B?bXBPdnNuT2FQTks2ZzYrb3Fzc3prNGNKbnh5Q0lNVldJeXA4THRDbllSQXBS?=
 =?utf-8?B?dFk0U1BDSXg3aXVuV2JvNk5hNHZuWUlIcENrb21nVmV2ZDYwc21jbEd5WW1Z?=
 =?utf-8?B?WElSSmY5WEtESU9DMzJhcjNYOVIwcENIbXhsK3RMR3hjV2VKYVZjNXY0UUhl?=
 =?utf-8?B?SE5CVUtvcitHV3dodTZvV3RWaGFDbkU5c3JYMy90RXc1bkJHVmZ2MjFhdzhi?=
 =?utf-8?Q?jiypfwGcj+Xk+DxyKjimh42Al?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5f2677-ad39-4cbb-39de-08dc5b0a482a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 16:04:50.0616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEIoRy61t0qM6RBHBg4OrCqYC8/XAr8QYu657Kn6ZuOYGeODdrJ9K3Qs8b6mkq3fWYy3WlZSs6VuOcvuMaXfZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609

On 3/25/2024 11:26 PM, Tom Lendacky wrote:
> The SVSM Calling Area (CA) is used to communicate between Linux and the
> SVSM. Since the firmware supplied CA for the BSP is likely to be in
> reserved memory, switch off that CA to a kernel provided CA so that access
> and use of the CA is available during boot. The CA switch is done using
> the SVSM core protocol SVSM_CORE_REMAP_CA call.
> 
> An SVSM call is executed by filling out the SVSM CA and setting the proper
> register state as documented by the SVSM protocol. The SVSM is invoked by
> by requesting the hypervisor to run VMPL0.
s/by/''
> 
> Once it is safe to allocate/reserve memory, allocate a CA for each CPU.
> After allocating the new CAs, the BSP will switch from the boot CA to the
> per-CPU CA. The CA for an AP is identified to the SVSM when creating the
> VMSA in preparation for booting the AP.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   arch/x86/include/asm/sev-common.h |  13 ++
>   arch/x86/include/asm/sev.h        |  32 +++++
>   arch/x86/include/uapi/asm/svm.h   |   1 +
>   arch/x86/kernel/sev-shared.c      |  94 +++++++++++++-
>   arch/x86/kernel/sev.c             | 205 +++++++++++++++++++++++++-----
>   arch/x86/mm/mem_encrypt_amd.c     |   8 +-
>   6 files changed, 318 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 68a8cdf6fd6a..71db5ba020b9 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -96,6 +96,19 @@ enum psc_op {
>   	/* GHCBData[63:32] */				\
>   	(((u64)(val) & GENMASK_ULL(63, 32)) >> 32)
>   
> +/* GHCB Run at VMPL Request/Response */
> +#define GHCB_MSR_VMPL_REQ		0x016
> +#define GHCB_MSR_VMPL_REQ_LEVEL(v)			\
> +	/* GHCBData[39:32] */				\
> +	(((u64)(v) & GENMASK_ULL(7, 0) << 32) |		\
> +	/* GHCBDdata[11:0] */				\
> +	GHCB_MSR_VMPL_REQ)
> +
> +#define GHCB_MSR_VMPL_RESP		0x017
> +#define GHCB_MSR_VMPL_RESP_VAL(v)			\
> +	/* GHCBData[63:32] */				\
> +	(((u64)(v) & GENMASK_ULL(63, 32)) >> 32)
> +
>   /* GHCB Hypervisor Feature Request/Response */
>   #define GHCB_MSR_HV_FT_REQ		0x080
>   #define GHCB_MSR_HV_FT_RESP		0x081
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 891e7d9a1f66..4aa36905b047 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -178,6 +178,36 @@ struct svsm_ca {
>   	u8 svsm_buffer[PAGE_SIZE - 8];
>   };
>   
> +#define SVSM_SUCCESS				0
> +#define SVSM_ERR_INCOMPLETE			0x80000000
> +#define SVSM_ERR_UNSUPPORTED_PROTOCOL		0x80000001
> +#define SVSM_ERR_UNSUPPORTED_CALL		0x80000002
> +#define SVSM_ERR_INVALID_ADDRESS		0x80000003
> +#define SVSM_ERR_INVALID_FORMAT			0x80000004
> +#define SVSM_ERR_INVALID_PARAMETER		0x80000005
> +#define SVSM_ERR_INVALID_REQUEST		0x80000006
> +#define SVSM_ERR_BUSY				0x80000007
> +
> +/*
> + * SVSM protocol structure
> + */
> +struct svsm_call {
> +	struct svsm_ca *caa;
> +	u64 rax;
> +	u64 rcx;
> +	u64 rdx;
> +	u64 r8;
> +	u64 r9;
> +	u64 rax_out;
> +	u64 rcx_out;
> +	u64 rdx_out;
> +	u64 r8_out;
> +	u64 r9_out;
> +};
> +
> +#define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
> +#define SVSM_CORE_REMAP_CA		0
> +
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   extern void __sev_es_ist_enter(struct pt_regs *regs);
>   extern void __sev_es_ist_exit(void);
> @@ -253,6 +283,7 @@ u64 snp_get_unsupported_features(u64 status);
>   u64 sev_get_status(void);
>   void kdump_sev_callback(void);
>   void sev_show_status(void);
> +void snp_remap_svsm_ca(void);
>   #else
>   static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>   static inline void sev_es_ist_exit(void) { }
> @@ -283,6 +314,7 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
>   static inline u64 sev_get_status(void) { return 0; }
>   static inline void kdump_sev_callback(void) { }
>   static inline void sev_show_status(void) { }
> +static inline void snp_remap_svsm_ca(void) { }
>   #endif
>   
>   #ifdef CONFIG_KVM_AMD_SEV
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index 80e1df482337..1814b413fd57 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -115,6 +115,7 @@
>   #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
>   #define SVM_VMGEXIT_AP_CREATE			1
>   #define SVM_VMGEXIT_AP_DESTROY			2
> +#define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018
>   #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
>   #define SVM_VMGEXIT_TERM_REQUEST		0x8000fffe
>   #define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 66d33292eb78..78d2b9f570de 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -18,9 +18,11 @@
>   #define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
>   #else
>   #undef WARN
> -#define WARN(condition, format...) (!!(condition))
> +#define WARN(condition, format...)	(!!(condition))
>   #define sev_printk(fmt, ...)
>   #define sev_printk_rtl(fmt, ...)
> +#undef vc_forward_exception
> +#define vc_forward_exception(c)		panic("SNP: Hypervisor requested exception\n")
>   #endif
>   
>   /* I/O parameters for CPUID-related helpers */
> @@ -247,6 +249,96 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
>   	return ES_VMM_ERROR;
>   }
>   
> +static __always_inline void issue_svsm_call(struct svsm_call *call, u8 *pending)
> +{
> +	/*
> +	 * Issue the VMGEXIT to run the SVSM:
> +	 *   - Load the SVSM register state (RAX, RCX, RDX, R8 and R9)
> +	 *   - Set the CA call pending field to 1
> +	 *   - Issue VMGEXIT
> +	 *   - Save the SVSM return register state (RAX, RCX, RDX, R8 and R9)
> +	 *   - Perform atomic exchange of the CA call pending field
> +	 */
> +	asm volatile("mov %9, %%r8\n\t"
> +		     "mov %10, %%r9\n\t"
> +		     "movb $1, %11\n\t"
> +		     "rep; vmmcall\n\t"
> +		     "mov %%r8, %3\n\t"
> +		     "mov %%r9, %4\n\t"
> +		     "xchgb %5, %11\n\t"
> +		     : "=a" (call->rax_out), "=c" (call->rcx_out), "=d" (call->rdx_out),
> +		       "=m" (call->r8_out), "=m" (call->r9_out),
> +		       "+r" (*pending)
> +		     : "a" (call->rax), "c" (call->rcx), "d" (call->rdx),
> +		       "r" (call->r8), "r" (call->r9),
> +		       "m" (call->caa->call_pending)
> +		     : "r8", "r9", "memory");
> +}
> +
> +static int __svsm_msr_protocol(struct svsm_call *call)
> +{
> +	u64 val, resp;
> +	u8 pending;
> +
> +	val = sev_es_rd_ghcb_msr();
> +
> +	sev_es_wr_ghcb_msr(GHCB_MSR_VMPL_REQ_LEVEL(0));
> +
> +	pending = 0;
> +	issue_svsm_call(call, &pending);
> +
> +	resp = sev_es_rd_ghcb_msr();
> +
> +	sev_es_wr_ghcb_msr(val);
> +
> +	if (pending)
> +		return -EINVAL;
> +
> +	if (GHCB_RESP_CODE(resp) != GHCB_MSR_VMPL_RESP)
> +		return -EINVAL;
> +
> +	if (GHCB_MSR_VMPL_RESP_VAL(resp) != 0)
> +		return -EINVAL;
> +
> +	return call->rax_out;
> +}
> +
> +static int __svsm_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
> +{
> +	struct es_em_ctxt ctxt;
> +	u8 pending;
> +
> +	vc_ghcb_invalidate(ghcb);
> +
> +	/* Fill in protocol and format specifiers */
> +	ghcb->protocol_version = ghcb_version;
> +	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
> +
> +	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
> +	ghcb_set_sw_exit_info_1(ghcb, 0);
> +	ghcb_set_sw_exit_info_2(ghcb, 0);
> +
> +	sev_es_wr_ghcb_msr(__pa(ghcb));
> +
> +	pending = 0;
> +	issue_svsm_call(call, &pending);
> +
> +	if (pending)
> +		return -EINVAL;
> +
> +	switch (verify_exception_info(ghcb, &ctxt)) {
> +	case ES_OK:
> +		break;
> +	case ES_EXCEPTION:
> +		vc_forward_exception(&ctxt);
> +		fallthrough;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return call->rax_out;
> +}
> +
>   static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
>   					  struct es_em_ctxt *ctxt,
>   					  u64 exit_code, u64 exit_info_1,
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 64799a04feb4..af5017ab9746 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -134,6 +134,8 @@ struct ghcb_state {
>   
>   static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>   static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
> +static DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
> +static DEFINE_PER_CPU(u64, svsm_caa_pa);
>   
>   /*
>    * SVSM related information:
> @@ -141,6 +143,7 @@ static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>    *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
>    */
>   static u8 vmpl __ro_after_init;
> +static struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
>   static struct svsm_ca *boot_svsm_caa __ro_after_init;
>   static u64 boot_svsm_caa_pa __ro_after_init;
>   
> @@ -158,11 +161,26 @@ struct sev_config {
>   	       */
>   	      ghcbs_initialized	: 1,
>   
> +	      /*
> +	       * A flag used to indicate when the per-CPU SVSM CA is to be
> +	       * used instead of the boot SVSM CA.
> +	       *
> +	       * For APs, the per-CPU SVSM CA is created as part of the AP
> +	       * bringup, so this flag can be used globally for the BSP and APs.
> +	       */
> +	      cas_initialized	: 1,
> +
>   	      __reserved	: 62;
>   };
>   
>   static struct sev_config sev_cfg __read_mostly;
>   
> +static struct svsm_ca *__svsm_get_caa(void)
> +{
> +	return sev_cfg.cas_initialized ? this_cpu_read(svsm_caa)
> +				       : boot_svsm_caa;
> +}
> +
>   static __always_inline bool on_vc_stack(struct pt_regs *regs)
>   {
>   	unsigned long sp = regs->sp;
> @@ -580,6 +598,33 @@ static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t si
>   	return ES_EXCEPTION;
>   }
>   
> +static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
> +{
> +	long error_code = ctxt->fi.error_code;
> +	int trapnr = ctxt->fi.vector;
> +
> +	ctxt->regs->orig_ax = ctxt->fi.error_code;
> +
> +	switch (trapnr) {
> +	case X86_TRAP_GP:
> +		exc_general_protection(ctxt->regs, error_code);
> +		break;
> +	case X86_TRAP_UD:
> +		exc_invalid_op(ctxt->regs);
> +		break;
> +	case X86_TRAP_PF:
> +		write_cr2(ctxt->fi.cr2);
> +		exc_page_fault(ctxt->regs, error_code);
> +		break;
> +	case X86_TRAP_AC:
> +		exc_alignment_check(ctxt->regs, error_code);
> +		break;
> +	default:
> +		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
> +		BUG();
> +	}
> +}
> +
>   /* Include code shared with pre-decompression boot stage */
>   #include "sev-shared.c"
>   
> @@ -608,6 +653,42 @@ static noinstr void __sev_put_ghcb(struct ghcb_state *state)
>   	}
>   }
>   
> +static int svsm_protocol(struct svsm_call *call)
> +{
> +	struct ghcb_state state;
> +	unsigned long flags;
> +	struct ghcb *ghcb;
> +	int ret;
> +
> +	/*
> +	 * This can be called very early in the boot, use native functions in
> +	 * order to avoid paravirt issues.
> +	 */
> +	flags = native_save_fl();
> +	if (flags & X86_EFLAGS_IF)
> +		native_irq_disable();
> +
> +	if (sev_cfg.ghcbs_initialized)
> +		ghcb = __sev_get_ghcb(&state);
> +	else if (boot_ghcb)
> +		ghcb = boot_ghcb;
> +	else
> +		ghcb = NULL;
> +
> +	do {
> +		ret = ghcb ? __svsm_ghcb_protocol(ghcb, call)
> +			   : __svsm_msr_protocol(call);
> +	} while (ret == SVSM_ERR_BUSY);
> +
> +	if (sev_cfg.ghcbs_initialized)
> +		__sev_put_ghcb(&state);
> +
> +	if (flags & X86_EFLAGS_IF)
> +		native_irq_enable();
> +
> +	return ret;
> +}
> +
>   void noinstr __sev_es_nmi_complete(void)
>   {
>   	struct ghcb_state state;
> @@ -1369,6 +1450,18 @@ static void __init alloc_runtime_data(int cpu)
>   		panic("Can't allocate SEV-ES runtime data");
>   
>   	per_cpu(runtime_data, cpu) = data;
> +
> +	if (vmpl) {
> +		struct svsm_ca *caa;
> +
> +		/* Allocate the SVSM CA page if an SVSM is present */
> +		caa = memblock_alloc(sizeof(*caa), PAGE_SIZE);
> +		if (!caa)
> +			panic("Can't allocate SVSM CA page\n");
> +
> +		per_cpu(svsm_caa, cpu) = caa;
> +		per_cpu(svsm_caa_pa, cpu) = __pa(caa);
> +	}
>   }
>   
>   static void __init init_ghcb(int cpu)
> @@ -1418,6 +1511,31 @@ void __init sev_es_init_vc_handling(void)
>   		init_ghcb(cpu);
>   	}
>   
> +	/* If running under an SVSM, switch to the per-cpu CA */
> +	if (vmpl) {
> +		struct svsm_call call = {};
> +		unsigned long flags;
> +		int ret;
> +
> +		local_irq_save(flags);
> +
> +		/*
> +		 * SVSM_CORE_REMAP_CA call:
> +		 *   RAX = 0 (Protocol=0, CallID=0)
> +		 *   RCX = New CA GPA
> +		 */
> +		call.caa = __svsm_get_caa();
> +		call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
> +		call.rcx = this_cpu_read(svsm_caa_pa);
> +		ret = svsm_protocol(&call);
> +		if (ret != SVSM_SUCCESS)
> +			panic("Can't remap the SVSM CA, ret=%#x (%d)\n", ret, ret);
> +
> +		sev_cfg.cas_initialized = true;
> +
> +		local_irq_restore(flags);
> +	}
> +
>   	sev_es_setup_play_dead();
>   
>   	/* Secondary CPUs use the runtime #VC handler */
> @@ -1842,33 +1960,6 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
>   	return result;
>   }
>   
> -static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
> -{
> -	long error_code = ctxt->fi.error_code;
> -	int trapnr = ctxt->fi.vector;
> -
> -	ctxt->regs->orig_ax = ctxt->fi.error_code;
> -
> -	switch (trapnr) {
> -	case X86_TRAP_GP:
> -		exc_general_protection(ctxt->regs, error_code);
> -		break;
> -	case X86_TRAP_UD:
> -		exc_invalid_op(ctxt->regs);
> -		break;
> -	case X86_TRAP_PF:
> -		write_cr2(ctxt->fi.cr2);
> -		exc_page_fault(ctxt->regs, error_code);
> -		break;
> -	case X86_TRAP_AC:
> -		exc_alignment_check(ctxt->regs, error_code);
> -		break;
> -	default:
> -		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
> -		BUG();
> -	}
> -}
> -
>   static __always_inline bool is_vc2_stack(unsigned long sp)
>   {
>   	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
> @@ -2118,6 +2209,50 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
>   	return cc_info;
>   }
>   
> +static __head void setup_svsm(struct cc_blob_sev_info *cc_info)
> +{
> +	struct svsm_call call = {};
> +	int ret;
> +	u64 pa;
> +
> +	/*
> +	 * Record the SVSM Calling Area address (CAA) if the guest is not
> +	 * running at VMPL0. The CA will be used to communicate with the
> +	 * SVSM to perform the SVSM services.
> +	 */
> +	setup_svsm_ca(cc_info);
> +
> +	/* Nothing to do if not running under an SVSM. */
> +	if (!vmpl)
> +		return;
> +
> +	/*
> +	 * It is very early in the boot and the kernel is running identity
> +	 * mapped but without having adjusted the pagetables to where the
> +	 * kernel was loaded (physbase), so the get the CA address using
                                              \..> s/the/''
> +	 * RIP-relative addressing.
> +	 */
> +	pa = (u64)&RIP_REL_REF(boot_svsm_ca_page);
> +
> +	/*
> +	 * Switch over to the boot SVSM CA while the current CA is still
> +	 * addressable. There is no GHCB at this point so use the MSR protocol.
> +	 *
> +	 * SVSM_CORE_REMAP_CA call:
> +	 *   RAX = 0 (Protocol=0, CallID=0)
> +	 *   RCX = New CA GPA
> +	 */
> +	call.caa = __svsm_get_caa();
> +	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
> +	call.rcx = pa;
> +	ret = svsm_protocol(&call);
> +	if (ret != SVSM_SUCCESS)
> +		panic("Can't remap the SVSM CA, ret=%#x (%d)\n", ret, ret);
> +
> +	boot_svsm_caa = (struct svsm_ca *)pa;
> +	boot_svsm_caa_pa = pa;
> +}
> +
>   bool __head snp_init(struct boot_params *bp)
>   {
>   	struct cc_blob_sev_info *cc_info;
> @@ -2131,12 +2266,7 @@ bool __head snp_init(struct boot_params *bp)
>   
>   	setup_cpuid_table(cc_info);
>   
> -	/*
> -	 * Record the SVSM Calling Area address (CAA) if the guest is not
> -	 * running at VMPL0. The CA will be used to communicate with the
> -	 * SVSM to perform the SVSM services.
> -	 */
> -	setup_svsm_ca(cc_info);
> +	setup_svsm(cc_info);
>   
>   	/*
>   	 * The CC blob will be used later to access the secrets page. Cache
> @@ -2328,3 +2458,12 @@ void sev_show_status(void)
>   	}
>   	pr_cont("\n");
>   }
> +
> +void __init snp_remap_svsm_ca(void)
> +{
> +	if (!vmpl)
> +		return;
> +
> +	/* Update the CAA to a proper kernel address */
> +	boot_svsm_caa = &boot_svsm_ca_page;
> +}
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> index 70b91de2e053..8943286f9fdc 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -2,7 +2,7 @@
>   /*
>    * AMD Memory Encryption Support
>    *
> - * Copyright (C) 2016 Advanced Micro Devices, Inc.
> + * Copyright (C) 2016-2024 Advanced Micro Devices, Inc.
>    *
>    * Author: Tom Lendacky <thomas.lendacky@amd.com>
>    */
> @@ -492,6 +492,12 @@ void __init sme_early_init(void)
>   	 */
>   	if (sev_status & MSR_AMD64_SEV_ENABLED)
>   		ia32_disable();
> +
> +	/*
> +	 * Switch the SVSM CA mapping (if active) from identity mapped to
> +	 * kernel mapped.
> +	 */
> +	snp_remap_svsm_ca();
>   }
>   
>   void __init mem_encrypt_free_decrypted_mem(void)


