Return-Path: <linux-kernel+bounces-128513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E648895BDC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F9F1C22C85
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA1815B55F;
	Tue,  2 Apr 2024 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oOo9+r1O"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2119.outbound.protection.outlook.com [40.107.243.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6F15B11A;
	Tue,  2 Apr 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083272; cv=fail; b=eaHzo/vEtCzKj7I0lzhUNs2FX4fgftDZPQon26WLYdJ032jHtnbyvwvu3mDTmG1iFKNwCNN4IpELzfQLj4ySbAgYJWTecywQBSgVsou7usFAyvi8Lu3AQO4z0lHHzdh2+goBMBh3TDsWFP7FrHjDLQm0DpvTaveuHyy8HybTRp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083272; c=relaxed/simple;
	bh=bSNJO2J1NijiBtvdWa/2fm+5yuWxvQsb1KSLcIWZgHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JO4ea1LtnvtN1N8VKtLTb76STT1bYuliyYIuASEeU0+WEHGmToVDgfp4ZuU+lSB8Q2SWXa2CG6y7LP0L6VE2Fd4crXTphw/5yhBwFoBB4xBWh/NrapFBnrhtpuXDzB2f/n1ZvhwiWwaBvs/cqHgpN8/QC9UKs+YitIN9Ps7J1HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oOo9+r1O; arc=fail smtp.client-ip=40.107.243.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ep7q/q2BjB+SEOzme8g3OCoEwBrHFrQVGB62TC/8bd7rRlEh5gVbuuszmT6c/kyTtMfbJ699nL43MMSqKvd8YO7vK3itwGUYro4Q6jjJH9qTb6zk8xWpLn8gy2uR4sS8qAsiE54gPP4CAPrAn9cWNgjicjzdSdHPfuZBTGyjD9hvpmz6fz8b55UnAOHPCrZzjhrXIjhO7BFMJtJllb8yJF6HfKec119B4zSPsbq9QqTNsza75DtJ//qCpn718cCn31gQx7HyHZfjDqZN37UT2N/Eg9qPgHb2IsnFbYOrZikLD4Mu3wRkRNdx/MDdjAgUJJZ+Ze2iHoPcA+j+SCp0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJotH683c4BWDwWv+sDPeEpyzYcgWCY46dNh/J9LL+E=;
 b=OvU2JOlDpCF9JJoGk8Jn+NQkzQ1fjw0To1otpeuGYSBMOaTjspBaNbAEI4IrRShBcA7czNovcjmnFLW2a6rdSXkbAMGcWgWEMnbvNRXRPYCer11Z+m0xEjpkyUm059hB2dcgaO8IRR+AtwbdhcSpIAY2giZF/DwrvyqGJHm5usIV8N3dO6n98IBPVjxYX3c9nmQ05d2O3itxFPaVlZD2tRhc6jN9aXBWJghG0n+MH2Q6XBACGpOKHEjrTbNh0rgmRptwsGLBdkvYKsfkiOXoAu/3rrg8YNlu+kyyC6ipogx7Ro/DxT5iQb31qa3TsdcgPaNr/6Em5g/9TEsgOfCtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJotH683c4BWDwWv+sDPeEpyzYcgWCY46dNh/J9LL+E=;
 b=oOo9+r1OAtykp9F68lBKzg47OlrK0QV05qEJFXVNvPAcPbfjTZGafMp9NZfXHzdDeW85B09ip7Ziwi6INCuDRIshXJtG+xT7C5ceKQvHhN2bwiCyp+Pl1Ou8DXbHRzqXA3ksHNKFmSXnMVL5nBieZM35w54IREDjSigvCrz91eo=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 18:41:08 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 18:41:08 +0000
Message-ID: <37321af9-aee4-4ba6-81ac-0df4cef38644@amd.com>
Date: Tue, 2 Apr 2024 13:41:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: bp@kernel.org, thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, michael.roth@amd.com, x86@kernel.org
References: <2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com>
 <20240402163412.19325-1-bp@kernel.org>
 <6f0d2ccf-243c-4073-a470-21e2f404595a@amd.com>
 <359264a1-e4ef-438c-8f24-32848e131272@amd.com>
 <20240402174540.GAZgxERNxsRJUCb1yp@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240402174540.GAZgxERNxsRJUCb1yp@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:806:28::8) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DS7PR12MB6071:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tVlJ4RuhrZDkC9eV6YwVpSgFyZyRpViVSwnlKvD5j/nC/5awWD6CHx4w5h9YRLeNJceQihN+Rq3hklPxjIuV7NdMcSzzYM6wmi+vwLNKHzjIjnnjjWutAg38X6lA8sKSdbal6QV+sVcgMaMYKHE6V9BGnlAo4f3hZth1wkUSbu48zzh9aPOpncZPr6gL+ca1gBbOauVmSjtyHDCP44gO112GzJuYrXKMab0AecsxEmzD9A6RD/7yMoj1cXJJ5ttbxklvTLQ1braUrJIkCQyR20qrDt0DuRPxcTzBx/UR7QMH0a0+yTrcs1cOgnug6dOO+nLykoWTG3fUFyt8G6XobXt38mhcbhayOjIdlydMmCto/ZVarTVmj+02OPFtzWphsZV2w0+ApfonGXgoHT0fx3L4ZOwz4eOwXzpQXXKjW/SuFAs8vR9Tdu9q1f3fbZLnE0ZoWLwrjSC/zu69iUGAkSvtHWUtaX5T8p7PcTl1J8RjywHyfVrRk3Do17jKdmqnFVN6qBXOEInfyPUNfKuV1KpCGH2HH4SuwBSRGDD1D1knnpvLQFfo1gF2NYLByOBvV1Mdsm0qdAxd3QyXZqEovAIOt7yPgYbfFpcNcbb4nUykZlOsupMA1IOaEv2nktBSQGhd3iVTGcQMjaE3nIye6KGv90hhiClLWKSuYzvQWbo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlU2RGpDUzN5MTBEOVo2VmpuaURvc1VIeXZpYTRuRU1VZFhQaW9SVW9wS2ho?=
 =?utf-8?B?OUFWSHFVWTQvNmRVQlZrMXY5TlZxUnMzYmk0QXcwUEtYS2VRdXJQNXpXWVpC?=
 =?utf-8?B?N0l1NVAzcklqaHE4L0hjR1JaVUNjNC9JdUc0YmRzdUwrU2p1TWRCaEtlVWpP?=
 =?utf-8?B?dDE4aFlYblFkeHhVVG5FbkoycnRpUUU2eHFkd0t4UGhLd2tHK3hLMUdGTmVm?=
 =?utf-8?B?MlBWTFhsYmd6d1hsLzNkaUd4alZZUEROUys1WFVxSXRBbC93dDl1akhlZmNE?=
 =?utf-8?B?WnV6M1g3U1Z5a0krRk1ZSGJDUFZJTWRJaXhQVUtNbVFja21JUjZPTVJmbDdO?=
 =?utf-8?B?SktseVNmcGJKWjhrZkV4YW5jblErZW0vK1duMERuaHhDcUdrRXk2MXlqRzgw?=
 =?utf-8?B?OGlEcG94UDNZTjVpeHc4TEVROEx6eDZkeWs2SmhMbXVsa0hvMzRNWFRMNUxF?=
 =?utf-8?B?aG5QREJHdmFHNnoxWmNtZzRIcFd0V21xVlE0VStqd2VEcDNRSDUxaitNUGVz?=
 =?utf-8?B?a3lmell4Y1JIQ0g0RzFIMHk2YkxJT1ZucWU2bTBMNjdtKzJ3aTZYQ2xzT3Rk?=
 =?utf-8?B?RGozc0ZZRmZDMWVDWGNiNjFUK0ljbTFnMjNnUmpWeXlLU2g2Mi9EZFY4QUlF?=
 =?utf-8?B?cVNoTFh5ejFVQVhoek1tRTRORTVCSmhBNm83dXg2dTJGZkk3VGVvTEhieS9l?=
 =?utf-8?B?L0pkS2N0aFlESUs0QU9YSGRJa1BXSjBOdURXR3lsL0Jtb1lzRVVOTzM5ZFkx?=
 =?utf-8?B?NkZtTGpwSE8wZ0tEYXVORTZMK1U5MForZUR3dU93S2FUZ0l2dzIzRnNOMllT?=
 =?utf-8?B?UFpxaW41RmFjcDZQdDlSRWZLeUI5STdpam9MS3V0RHhEWUV4RmVYVEdvM2R0?=
 =?utf-8?B?RUVxM1F4Ry8wZFpUWTRNNWVxaDIvVFdTRldPN3pPZzl6TFRObzFqQVhVYTVv?=
 =?utf-8?B?dkROaDN6bEdFUHUzRmt4UjEydlN0ZW55eXptQThsOENPYW1sdGg5cnplTzk3?=
 =?utf-8?B?MFVNVkxSQkNjMGoyM1R1a1ZTeWQzcDd4bVA3TysyRkk4dHVmVXg4b1h4Vndx?=
 =?utf-8?B?U0FSNy9pdVlkQWdRZjRQbHdIb1RlMzdSRnRZbG5PSklqZDE3VDhHZ1R1Zk0z?=
 =?utf-8?B?cmpaS2RVenY2YzVRK2hicEUzS1krVDVkMlRWeE5oTUpQS0xpTXc3YkZuSmNU?=
 =?utf-8?B?TjN5d3dDWDJSRHV5NjBxV2U2QmNXUmFETmJ2Q2hzZ2lvR2s3VjRUSFh3YmRY?=
 =?utf-8?B?eC9QdnA2ZFZzZWt2amcwbzg4cmpHYTV5enJBenphYmJZS0x4S0lYaE5KMEtC?=
 =?utf-8?B?ZHN2LzkwVTZNYzV4TEZGR2lhV3pWdDRaTVNYSFJsZ3cxeUZQUzRjRDFTTEpW?=
 =?utf-8?B?dk9meldINlNiNEpqMTZkejVLaThLUEI2SEVuSThHblJuelVQQ1ZmNHVabVFP?=
 =?utf-8?B?TXBwZkY4bHh0MVZOOU9zQ21LRXdRUDhjRStORWJTeHNqZXNXZXIyTGNEc3dY?=
 =?utf-8?B?VmxyZ0Qzb3RPRHpYOThKSFBLQW9lQ0Y1WXdpR2xaUUtRRlBTbEQxVVhjZmZW?=
 =?utf-8?B?b2ZzTVYwYzJkOWNFYzViODIxemlMM3czUWFyS1FxaEY3M1hpV3VGWGdBSHV3?=
 =?utf-8?B?UzUwQzRXZGQ2dGFYQWFaR2pzdW9wNVJOb0Rmd2wyam1kNVBaU2loclQvaDdE?=
 =?utf-8?B?b2w0bWpydEYvOVQyOFEwZVN0ZGIzQUIvSktEdnV2dE90Nnd3RXkzdXl1S3NZ?=
 =?utf-8?B?UG9VdmdLdnp0M1YxUlFxZkx6L3hCMWZuTStYSVB1UFNEZE1GSFhIVVg3bHV3?=
 =?utf-8?B?akg2OE1rd0hHT21jVzNsc3B0VTNkOGJ2VTYzUkdmRnRRejdZSU1HMkprdEJ5?=
 =?utf-8?B?OGp4QVNIdjlPeHZ4NmQvM2RSTFhTM0VnOXFUYzB4cldyelFwbExwdDNmdHg2?=
 =?utf-8?B?cHRJdnpUbi9TNU5oUWhVVEFxM01DVjlaelA3eWZPZm00WHFrN2RxY3hjRkZz?=
 =?utf-8?B?WmE1S0k2QTh4MUo1Y2lYTlQ0cEVDcGlRZ2ErMVAvVm1Gc2pVMkx0Y2dPb0g5?=
 =?utf-8?B?ZlVIenNqTjlPQU1pRVJOZm9iWjNPWXdDUS9DS1pobzE2ZmtIbjlmUDAvUmIw?=
 =?utf-8?Q?xpFv+QgL0ZifhbpIQ+I4caLAX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0252f511-9b8c-4138-1f3a-08dc534475d3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 18:41:08.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmr0wzRC7mZ7RsfT5D8A7Tii7ig6mk1matF9pNdu9J4anZ0mFrfISx9tI/cHDnI4EBLMgsNV2pz4Nw0GV82R7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071


On 4/2/2024 12:45 PM, Borislav Petkov wrote:

> On Tue, Apr 02, 2024 at 12:11:03PM -0500, Kalra, Ashish wrote:
>>> And if you mean the reservation in the kernel page tables (directmap)
>>> then that will not help as kexec uses it's own identity mapped page
>>> tables.
> So how hard would it be to *always* reserve the chunk of memory at the
> 2M boundary where the RMP table starts and up to the 2M boundary where
> the RMP  table ends?
>
> In *every* kernel.

But, that's what the e820 table fixup is doing, it is reserving the 
chunk of memory at the 2M boundary where the RMP table starts and ends 
in the e820. Kexec is referring to the e820 table(s) for placing it's 
segments in memory for the kexec boot.

Thanks, Ashish

>
> By default.
>
> Thx.
>

