Return-Path: <linux-kernel+bounces-128689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56926895E32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A35F1C2248D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E615E207;
	Tue,  2 Apr 2024 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yx0Sf5Wn"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2100.outbound.protection.outlook.com [40.107.244.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD52615E1F3;
	Tue,  2 Apr 2024 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091610; cv=fail; b=VTN2mUiSSjnppWTtuGfIocmRsK4ZQDhMcOIk0TRwG7ZQuBROvbwY0jXVsisnjAP3HIpLUFjwIgYMfykOWU2UuFbIo5ScNEuqgmBQqNT3kpDJ5okK4Cw47B1WwdabczBUurG42JmocHEy/fM2pQoTwkdDP5stzoHjeyeApqEnDmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091610; c=relaxed/simple;
	bh=Dk99323jKGsaUgETdSVcAX+NUvJJhGmNKIGy3m9Ue1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lbT55pHEHdSwOnJycCkqdMolINpobXBrlFXAL4NfP9cyryb2KTalXGgPme/sJnlnHQTh9sww9ChiJe3rxXcPjbEaKX+hLgQ5t6JguKTSsbmSOzhN8IeWymRq/8t4MRSkw8q0axPj00f1bLfd5v0uivXG0C2HJaVzQSLYxDfxd1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yx0Sf5Wn; arc=fail smtp.client-ip=40.107.244.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRQmIH6RmDjgQoCiiE4XEb7p3Rrnj2tAAHSDfkFMIEB8iogU4VD0qxMNp24SnJMnaG/Ubr15atJysQOJ62Nen7M7xZi9YuX+D4ofgmiMCQtScKaV8IGBdGLxMem1Pn1hA9JEPqRGb4T/LJ9pjB6Zz2+xHeu3TzrZjWDx3cRzBBauJ0f9DSHhS7jdx8VVLYAJKhAprpjMO24lWsvv6UYFlzzFzDK3bCh80pCxnEqYLMug0ImIj/kEBcXb7eKYL7znJ/ev0pk+eDl/9onebgWSQ4pljDnyi2G+ctYUsrfDHnfIBd89B9pTTxaSNkMUZZoslLGuLydauwrYGdwSXt1HOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YjDAH5o0cBBoh+WGxhhvNsQh78231Wtuvs4/itBUik=;
 b=Rcw1gK+dV8EwLrcFbCBhDOsvoydlGThPODVNN6YdGB+4rt5dwAHMymgJLWVipHbCsU1G4dQVnPta+puL79WkzKVEnwWxv+IysGHnOuW4nMWYRfnt/m99fYmL1Cj3V92nhq36KQ9emZOzQFYt2OMWm2SNNyvGfrMuT6BS9fvZyf/ZCZALQmT3R4NSWR1H9Z5sMUMY8wgwkjWm10lPb/lipeAZc7Uw5TvMY1jcKfv48tHjL6twoeutQLSZr+QcO/kht+znD/fJyxypnwY7tf9j2fusXhVIAbWV5ITSrN9c0nA8XN1vFjZCCZAKtJGa0G+o1Rjn+vD41ctbLC8nIoInyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YjDAH5o0cBBoh+WGxhhvNsQh78231Wtuvs4/itBUik=;
 b=Yx0Sf5WndYrsOuYrVzh8oJw3iEqNbvl1wFzRyF+3IRFXfdyeV/0Slnzc9Foz1g6aO+hTyMRU0z9RSa0wSzV98T0Ig2PCm1inVUgqyt3JDGpyuwZj7yyG3BdC7LLFuLs7aiuI6igKIgT1xLmn8bYe+OvbFYFb6xhzjoBaqgoTRZs=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SJ2PR12MB9237.namprd12.prod.outlook.com (2603:10b6:a03:554::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 21:00:06 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 21:00:06 +0000
Message-ID: <6fdb98f8-b4e2-474d-b8e9-c3092e77e56e@amd.com>
Date: Tue, 2 Apr 2024 16:00:03 -0500
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
 <37321af9-aee4-4ba6-81ac-0df4cef38644@amd.com>
 <20240402185039.GBZgxTfwvEP45OxVjm@fat_crate.local>
 <8daf448f-eb52-4b1f-9f98-099a83665321@amd.com>
 <20240402202118.GCZgxovu-pgPKYvner@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240402202118.GCZgxovu-pgPKYvner@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::8) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SJ2PR12MB9237:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	831GsIJ5UZjAhl4G0VNFYUcpjKDq+xYmCbrtQPoh1y4G3l+x7puWAHmuZdTB4xKsvyQmIDDX8QVaNnTXxvmF80V3G719lqXR2OlcLybSx43sFK1dfxbibPhCbjub13/uO9BYJhJ0kJ2gRSTRle1tH3iKKQvukvuxpxaB4fgwAdJCx1jifjlpEB3ZLEJaC2Mt276R91M/zgX1CSgJsjG3bIdIohtJRSgZE+6AJConc7aRjArhYG9dbPyv+UM0YqZtlJhk3qFl3nKOdId7OHu4XS9OrlVsa29NRsUff+s8foTS9Nt6b/0LNJZdvM0S5l8txrGZJ83iZcKyesnvyGstsn99m9I1bY1zTxrTfJ3vSQqWumsTP9RD9OBr3pxDfXw7CPF+60/c3YDVTAITouZ/ITanXWusMCRLHjn2Hcd3oBm3GScJT3EZ/wd0ppVIl13cwn837oeB5w+4loGMPI01esOLVCyBbWu3E51DrGgg9IvupxJaqgmOXvMI5kHoUm8lYcP/8quE2tDZemeieBb7b0y7A9meMqpvxEb6oKftZnbX6kUwMzQC1zH+7iGqm6Da1Zy7QSmh+A7N2FfQS8xnJnEmOe0pofX558NCtnyFjm6RtRcG90ZkwvJutMtet8wMz6xLSdC/kcoUXYaUa6hCPX2Q76SAK/UfnpUJYAyZUcA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rzl6Qmx3VGkyY3pBUDhtVVNMR3VjSWdBbDF3elBrdFVXTTVLY0Fwc2VHRHlK?=
 =?utf-8?B?bUlnR2kyWFo2UXhnSS9FN2xRWDRzaEQ1dmtVUmdQRStoQnVZUDdITDRDYk5h?=
 =?utf-8?B?Nm9lNjNFYlhQS1p2TktVeExiODNLL0drYkJ6TzdvL3A1bTdUakkxclpiZlk5?=
 =?utf-8?B?YjBDU284cTN2MUZRVGdXc0xjQlJCOEhCR3hnVVNZOThIZmovbENtY0Y2a0RQ?=
 =?utf-8?B?Y3g1a2NLQ20rdForbjRVdG9icXpZVzRtY2R2eXdKcVAyWit2UVhHQ0VhVWs1?=
 =?utf-8?B?T0ZUZC8yQUlmQzhpOEJiZHFRV202Z2JVSCs0VWo3bWN6ajJJcWp2SnhhSFJj?=
 =?utf-8?B?VnpVd1paQStqTzVaaWc0Tkd3ejhKUndzY0UvOGpnTUNuL0UwT3g4RnNQNlhr?=
 =?utf-8?B?bE4zLzRSMjlBNTBodmRST2w3Z1NMVWsrMTNPMGZHa0o2dHZnNnJReXNqY2ZX?=
 =?utf-8?B?eStDdmZFM0loT2xyMTN4NzdHNWt6eTJYUVpEaFdxT2Z3TXl0MXhiMEkwUUpF?=
 =?utf-8?B?SHZrRGpheEFpbG1lZmZKckM2Ujl3WWNtL0dnOENOaTEzYjBETFl4Ni80b01Q?=
 =?utf-8?B?cTFyc3lsaHE5SHZzbXBoeU9UNk56VzcxaXVWMnd1RW96ZENveE5xMGJuc1FG?=
 =?utf-8?B?Mk0vb3JONkYxeE9TcFR6c3E2bkxjRXQzSFdqdW4wQ3ZEM09aWUw3bSs5SHB4?=
 =?utf-8?B?ZUR1dUxETTNzWTJWR2lZNFNTN2JqeTdvcWxJNHYxV2JRR1RZTklqUVcybENV?=
 =?utf-8?B?TlVESWEvUFJRem50MWlWRFRFV2hZKzFIRGRma0lPMENPbG5pL0Vhb1lHeXZp?=
 =?utf-8?B?UGhYSW83L3FuZS9YbTJ6b0NyN2hhQStGMlRIUlFEbDJiQXM5WnBWL1dOc3g0?=
 =?utf-8?B?OTVCNFdxaUFyQWRRUUJPNXcxblBhRWUwN2FVUnpRbmt0Q0QweUZqd0w2N1ll?=
 =?utf-8?B?NjhYYVl3SCtoQ01HYVhJUU5xREJsRmdtMDBRcFZrallqamovWEo2eWtjYVd5?=
 =?utf-8?B?V083V2VxZTlmU21tQ3luTkxsWTNoNXhVejF0TktLUjdBRmZ6R1BEdGl2YnR6?=
 =?utf-8?B?SjhsUTBpNEIwY2FzM1dXWWU1NURoSWxhbkJ3ZTNwa0JHaTFyNDhDQ2pSb3dU?=
 =?utf-8?B?eVVoSkNTby9zTm53UkttaTM2RC9udU9zUWxvMDhERVJNQmlKOUR6Vkt5Vm1O?=
 =?utf-8?B?NFkrK0xVY1NQMXBTUlJuVi9HUTUzWTV2Ly9yM2ZidGR2UHhXc3NOdjFuMnFW?=
 =?utf-8?B?TzZJMzhIZk5vQVBvN2k2Q0VVL3RjQ1JsMEpyaVdZRjA0MTEzcnUza3VORlVk?=
 =?utf-8?B?OVVCV0RMTVFUYk1qajZJU1lLc0JKS3ZETytOemxMWFk3b1J2MGwxSjFOQ3ZB?=
 =?utf-8?B?ZXNlaWVVaXlJMWhRRytkb21QRHEwNFF4WUFkVlgxd3JHSTlrMi9BYXNZcGEx?=
 =?utf-8?B?Mk5Ed3YrZFh0U1lTKy9WQzI2VW9pbENlOGFWdG5JSHdidi9CNEswMWJ2MHpt?=
 =?utf-8?B?aFZndlovUUJvSW1UODUzYWNHWmY0U3ZjdlRkeU1yTVhrUVhKeE5SRkM5YU15?=
 =?utf-8?B?RllBdUdURkdQQ0xFbWFLWjZGUXN5bnc2SjhqMkN5YkJzdUtJaWF3Vjdoc0hF?=
 =?utf-8?B?bnRpY080OTJIYVZ6RndLaVhUQVljekRNVU80RTlUQW9jbm0wVHltVlpjWWpi?=
 =?utf-8?B?UnA0UGEzZ05hZy9YdFhHbWtLdXVtV0dSUnZ2WloxQjVaVVpYMWlsZzc3NGtl?=
 =?utf-8?B?d2x6MVpxd3RhdjBJdzhpVnd2bjFmdDhTZ3VZOHVHVWlOdnNkWUovejB3QnBy?=
 =?utf-8?B?T1lrcUV6RWdIUkZyeFMvV0ZZMkNUY2pXanlPNFlxaDRjdDBIMFNrenBkd0pT?=
 =?utf-8?B?dlY2cjVQLytvTG9jTm1xNDlpT0thQ0FRMWtiUldVYnd0b1ZwdVB1bURDdnpj?=
 =?utf-8?B?MUdvMXY4Tm1penRDdm1nRmRrNEFVaDl1THlnT0REb1BsamtvV3IrSWxWNnF2?=
 =?utf-8?B?K0VxN21HR2E4TWFUWExyaVhveS8yNUhFeGNETnNkMWxTRGVuazRvUjV3cUg5?=
 =?utf-8?B?RVBzWHBsdXNadkdSdVNBUlRuZk12YUozR1JEWG1Pd0ExTUppNHEwYTlXUHll?=
 =?utf-8?Q?8lNvT6Hu7k+eDuqfv9+aywBSp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ade39d7-94b1-44f9-8f6f-08dc5357e00c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 21:00:06.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvEDgs2U/yXFOW6g8La4qNvz5q9t456FNuKdI4YSDwPXQjQjIF2Jqp67nZxzdXeN5tY9iGbkHbKi6jqyNL5/WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9237


On 4/2/2024 3:21 PM, Borislav Petkov wrote:
> On Tue, Apr 02, 2024 at 02:33:44PM -0500, Kalra, Ashish wrote:
>> And we can't do this in snp_rmptable_init() as e820_table_firmware can't be
>> fixed at that point and by that time this table has been mapped into sysfs
>> (/sys/firmware) which is used by kexec -c variant.
> Well, you have to do something here because if snp_rmptable_init()
> late-disables SNP, your RMP table fixups are moot and invalid.
>
> Which means, your RMP table fixups need to happen at the *very* *late*
> step after we know that SNP is enabled and won't get disabled anymore.
>
> I.e., in snp_rmptable_init().

The main issue with doing that in snp_rmptable_init() is that there is 
no e820 API interfaces available to update the e820_table_kexec and 
e820_table_firmware and e820_table_firmware has already been exposed to 
sysfs.

The e820 API only exports e820__range_update() which *only* fixes 
e820_table.

The important point to note here is that in most cases BIOS would have 
reserved RMP table start and end aligned to 2M boundary and setup the 
e820 table which the BIOS passes to the kernel as such, so even if the 
kernel does not enable SNP or disables SNP later, these reservations 
will remain aligned as such. So what we are doing here in-kernel fixups 
is doing the same alignment fixups which the BIOS would have done. The 
summary here is that e820 table adjustments for RMP table done either by 
BIOS and/or kernel will exist/remain even if SNP is not enabled by the 
kernel.

Thanks, Ashish


