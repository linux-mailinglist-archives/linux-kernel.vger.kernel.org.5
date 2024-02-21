Return-Path: <linux-kernel+bounces-75437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677CB85E8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2C01C2370C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C26486ADE;
	Wed, 21 Feb 2024 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vr/ftxw3"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3358613B;
	Wed, 21 Feb 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545521; cv=fail; b=QshXFuRnQHUz4DsQBY84goUG/Pu0FHbNvl6GH8hO9h01T3MkZPrRPf5HOQIeTyimAGxlhh4bK8cud2oODNgiGOch8OhYAqloXfcUQgvV87/PB6a6FBj8vVI7pjWyhhbMdow3/8UUX9XPOM9Ga+/Un1ZEk0OBiLtUey9VVA1B5c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545521; c=relaxed/simple;
	bh=jy89R86GijhAwtZq4trxMSWk6QVLz9RO+yYGK/sgJRw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pnNacg2QDkB07q4BbyIgw1vNP/5GX7KGxpauzNeMGspb94Di0sz0NEvEXhaOBPf21KDGiyCGZ/sVE+YjGlwkFbmxpmtnk/DM/Poo3tuOkTrL5Qy2AD1Mfk7fi5dSZg60gmlhJ08qwVFPOpZpt+DkBljH5Uro8FlzqfWFXG1WcZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vr/ftxw3; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awipq7Qe3EBdUX4JFddN8FZoOeFErYDkZwG4Z/LqQZkANfuvTY63NCHI7TxBqmtPa1D853+QGtXM+ShUpU+2HwKF23MQ0I2gh6AlnVYHm4N27ICD9/W8nbi50HtzCP9xeX4ZhgHd0uWr/7TieGAnIT+u/tdpFJaxfx532yPA5J71r/SsaygDUzQNjzq98kWfpuax799vD72mi3DGkF299QB49owj/nxRr7CYNeIwsnxUDrVEcBQW8NXiR3RGYl6wvOTViNHa1eMw/vEbeN+yVj1zOA9+xBwRZUIIm4IgYYrzTtmn9eg0b+1oiRUibll9LFrbFzkU/1xGa6in0j06Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytJbochpmx6RQgvTe1+oAD1wA3jykYDxAEZEXKISvYg=;
 b=QbF7SuUzQi+5JHqG53fVw8zAhGOBOe6vzC6eZTn+eCiFhZZiSephQKeGM4XBUmSZo6WeE/NghHPIBtmoZpncEd1+drLQl4i1bt6oIz/B6Mt8aH9bPzS3lx2YCYXjPm50+gvb+uRui7anSBTCMorskZrCbj9lQIoRrilKLQMP2O4Rg0gkBeKZlvT5qeSjXakkT57tzbcxnDP7ia7qY25FKcOnJibaUkTr43A1S5SGaaLwheKaL+cvhdu2oaLQttmAEhIOzcADLxEeZhquMowzsztUHXMeoPXIHuoi/W5Z+BDimD0h4hqgT0jGUhC+VbhqSWZpZ445tDKhjIaj7jJ+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytJbochpmx6RQgvTe1+oAD1wA3jykYDxAEZEXKISvYg=;
 b=Vr/ftxw3vMqBDebmaaXS49Ggbg99z2rD/dn2ar7towss8fInmhOl3aXgXTiHwJDMV23dhlKPqeDApiPXrlndV6SlAnyNEKkpcO55yB/4jMwJYG+KzLOr3xreAIbnXLQ5023dMWkLe5wJkFv7gdipXhjNFq00x2N3oV/4FLJBkjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 19:58:36 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 19:58:36 +0000
Message-ID: <6314de0b-a69c-4e72-9538-8b133fc50047@amd.com>
Date: Wed, 21 Feb 2024 13:58:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] docs: Include simplified link titles in main index
Content-Language: en-US
To: corbet@lwn.net, rdunlap@infradead.org, vegard.nossum@oracle.com
Cc: bilbao@vt.edu, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240109155643.3489369-1-carlos.bilbao@amd.com>
From: Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20240109155643.3489369-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:806:6e::23) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BL1PR12MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: 2936d221-5755-4666-f572-08dc33177da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UedBhlCvPg/nrEybmAi0GSJmAOaRHnVa4YmNkhdvjU5iqy9yf7VjFXuctOVTRgMFukc3dtn2aBRC+4yTBpFxLqRKDetuJdCGdbE0rnn4WBaHihJCQyCAu5nWtz91nYtSxZY28D3NRUlq/QfPsLty1aQ7Z13E4BMZGdeCgYGruFWLO8BixmcZZE4P1nADh/2OYd5PUHGR5b2VOH/tRr/5WuDBFurTBnR7571G1jd8Vlh6RiYHsRT0yrNmRkk7gMul/ETkOBzDFtE774YaQZsENbwjt024+8rH2PT9MZ7070wM8u9He6DAjkf52bK7rvWCCC7jw/WI/VabQ8Ll3DfX+B3GNV/0dJE6miiGEwQL75T3e8UHom29wDkFMw7RJkxSlysAT24N3IkgajtGECa2HftwtE7WyLkYQ/1WJ13WfPMunIh6h7y/R3LILqeBqNVbGOvBpRzZBIIRWQizNLPLiYT/NyMFkc8+L7tLCFMVmalY3rwfSP+oCjpwJOk+hTtnOWE3B/FTHCRxC8F/VlB+bA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnIxMTFVM2VSRDlFbEZqRFNCNU91cUpwWFhOOXBqYm1vRXMydWlLV2dWcUtL?=
 =?utf-8?B?RWd2SXBOZTlIRmZPOXhGSnpYOGI5cGxCblRVMFpGUlh2ZzRobk9seTNob3Yx?=
 =?utf-8?B?VzlxK0NaakpXdEVtS2dFN1ZwZmtGbmxoVk1ZQ1E3T29yRDNvdHhmRzRWSStt?=
 =?utf-8?B?eDhrSE5wYk9yeDRVMGRPRlFrdEZpRXROd3FCMW9VcjQyUklxTkV5WVQ3TTR0?=
 =?utf-8?B?dTF0amNuK2Q4a3hQUXBUOFpkYjlPem9mS2Zma1ExUHkzTHIvUXZiNHJRSnJJ?=
 =?utf-8?B?TDNJNm1kMEE1UDJKWG11WVZSNysra2ZnVUhVNjZJREthVndCU0owcFdaSWpk?=
 =?utf-8?B?cWRTRzFpNm5USWxWRWgvRFJiYWtvWk9maFhaeHVBSDNwUnBaSHdYMGpncXly?=
 =?utf-8?B?aHZHdzJqeTlxaFp1aUJLOUZVVi9oYjU1TlpPVjBldy9pS2N3am9uWHRaMHBr?=
 =?utf-8?B?SlFuQnZkc2lPZE4vVWpjd2FLcHRvc0RIZVM5d2gvRTRSNnB6NmhVbll6Yk9u?=
 =?utf-8?B?UWdSSXd6TjBuVTlOaXpwTVh1RGtnSUsxTGwxcDI1R0RJWkpqcTEydTRxc0N2?=
 =?utf-8?B?SmNWODNtck5McTRTcVF0Z2o5VUVmRjQvQXpoWUZsRDAwbDJwcithMGNMRUFS?=
 =?utf-8?B?dlZxNXI0ZHpNTVJxdTRMc1dpc3pETHVNcVZaL09mKzJnSDRkdGZuNEc4SFVG?=
 =?utf-8?B?Q1oxbi8zclBTVVdCWVNHRWR5SSsvMTRoeWZXYUNaRk4wZ0Erd0Q4K29kYTF3?=
 =?utf-8?B?T0hlRnNteFBocDFZQmZuV3BGZzdIMEN3S21kc2M1WlZzQTE5Wkl4U3dLM0Jq?=
 =?utf-8?B?WmNGb1NHcUtCWi9GVDNpdnJLWVBUcTljTVFNN0FDaHQrNWE3K1hSVDU1dlVu?=
 =?utf-8?B?d0ZGRDBoNDhxaEdudTdodmQvRVJMM0poMEh6cUc1SzdvL01FdHAzQTUyQWpR?=
 =?utf-8?B?cUsyNVhSUTNkNVFIcmZsNTZFOUhST1BoY3JUM1JSTmo4ZUpnQ0hORTUyWXdG?=
 =?utf-8?B?RU9MZUY2T3VnRWtmdjNscmEwS3AvUC85TzJvL1RkN2RQRDhIVEh2bzNpQ1Zs?=
 =?utf-8?B?ajhXNjdCWjl5ajZiblR0NUlrcVoxdy9MSmZBTmZuQkVaRVFid1FvNDFjMWti?=
 =?utf-8?B?OHVNUkR4SXlaZ25MRUxqQnJ2czB2NzR3WnFPR2RLaXdaL2MzbVRFWW96SVA3?=
 =?utf-8?B?STNyVVJXcUdEWGpYdytWcUxsZ3c0L0dranl0K1VrU2FFUFFlTDNxekZTS1hS?=
 =?utf-8?B?d1htKzExUEtNMWx4UE81QWp5UFp6VGk3OFRJMmlQdGtkVkxDT1llS0pIbnFi?=
 =?utf-8?B?REFxdm0xNDF5cTNCL01CM0p4cXlYMWdjNFFCZHVnMzZYTzFJNGNPcDRvZDRR?=
 =?utf-8?B?bkxrN1Z2ZXRtc3ZUWFJhVVltTmxBT215QXJmTEIxbU9Db0t3YzgyZ0tUeHpT?=
 =?utf-8?B?TDNJL0RHcUZHNmZMMkVuNW1UQjhOWDZLZUI3RkNTaGZjK0FPZld6cDlaajBu?=
 =?utf-8?B?T2hRZ09QdXVid2N4Ukp0bVZSUkxLR1RONUtpVXo3MXd6WUxoa2k1SEJseGtD?=
 =?utf-8?B?U3NvVm8ySW1OSFUvQzErYXRONy8rTmk1UzVmOFU4NnI5UnRGdlhnMUxuYmts?=
 =?utf-8?B?NnBmM3ZPcExGU0QrOVdrTzFqazJTZ3c5Q3ZtTzZ1Z1RsOG1nRFMySzE5aGNY?=
 =?utf-8?B?UEtTdEZZaGJnZnlFbHNid1hvdUthT01UMmR4MkhJMklVZWZ3ckRxdG5SeG54?=
 =?utf-8?B?ZG9JWGY2cldNeHUyd2NHaHFkNEhSclpLOS9WU2NFTzhCQ3RDUTdUaVJWQTJK?=
 =?utf-8?B?TURIYURuWmgwN0F6enNyN0V0MmZCYzloTk1GWUxjT1dUcXNaeE1sT1VjaDZZ?=
 =?utf-8?B?L0o2MXlldmt4WUxOekR3T0dyVVZSNUQwZzluT1Ntd2JDVGVwNzRYNnVnVVlH?=
 =?utf-8?B?UDIwcjFGQWVBTjNKcFNSalVpbkQzdHhrdFhYSU9ncCtHYUdxNFY3RmU2a015?=
 =?utf-8?B?TVZtQWI3MWluWjE0QzYxWnhrcVhYeEpJOE1LM0U4cHFOaFlCRXk5OVpROFJR?=
 =?utf-8?B?RGQrSzdvVnNQaGZCWDY3dCtUQlROWGljVldueXZjS3hINWtOMU50TVdNdWd4?=
 =?utf-8?Q?nZRQrrs0vdJNEdMsgbk+qyBtY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2936d221-5755-4666-f572-08dc33177da5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:58:36.6614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KV/2IvlLSfIJg82ksR8sVvrJozIPBZBt5TysZ/1XUiZwxciM5/qpsUZshFgy5UVNZNJiYSCvHq+yKP3G4IGKEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5062

Hello,

On 1/9/24 09:56, Carlos Bilbao wrote:
> The general consensus is that the documentation's website main entry point
> and its sidebar leave room for improvement. Something we can easily fix is
> that there's too much duplicated text.
> 
> To that point, consider the titles "The Linux kernel user's and
> administrator's guide" and "The Linux kernel user-space API guide." We get
> it, it's the Linux kernel. It's assumed that everything listed pertains to
> the Linux kernel, given the overarching title, "The Linux Kernel
> documentation." Constant repetition of "Linux" and "kernel" (45 times
> each), "documentation" (21 times), and "guide" (18 times) are excessive and
> affect UX.
> 
> I propose simplifying without altering actual document titles, the text
> linking to these documents on the main page ("link titles"). For example,
> "The Linux kernel user's and administrator's guide" could become "User's
> and Administrator's Guide," and "A guide to the Kernel Development Process"
> could be "Development Process". This is what my patch does.
> 
> Also, I send a patch fixing the formatting of the title of
> admin-guide/index.rst (The Linux kernel user's and administrator's guide);
> a detail I noticed because the link title would not work otherwise.
> 
> Thanks,
> Carlos
> 
> Carlos Bilbao (2):
>      docs: Correct formatting of title in admin-guide/index.rst
>      docs: Include simplified link titles in main index

Is there a reason why this patch set is currently on hold? It must to be
feeling a bit lonely by now.

> 
> ---
> 
> v1 Link: https://lore.kernel.org/lkml/58e78693-82d1-451d-a546-51fb64ef6eb5@vt.edu/T/
> 
> Changes since v1:
> 
> - Apply feedback:
>    Driver implementation API -> Driver APIs
>    Testing -> Testing guide
>    Hacking -> Hacking guides
>    User-space tools -> Userspace tools
>    User-space API -> Userspace APIs
>    CPU Architectures -> CPU architectures
> 
> - Include patch fixing the title of The Linux kernel user's and
>    administrator's guide.
> 
> - Minor changes: Change "main page's index" for "main index" in commit
>    subject. Also use my work email to sign the commits.
> 
> ---
> Documentation/admin-guide/index.rst |  1 +
> Documentation/index.rst             | 52 ++++++++++++++---------------
> 2 files changed, 27 insertions(+), 26 deletions(-)
> 

Thanks,
Carlos

