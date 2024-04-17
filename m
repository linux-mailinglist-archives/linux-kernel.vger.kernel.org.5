Return-Path: <linux-kernel+bounces-149195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E18A8D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E4CB21208
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842233D966;
	Wed, 17 Apr 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mbJxmXZ+"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA1381BA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386164; cv=fail; b=dr9DO/kbPndRWMNYUQV/iZXxn+VkGXiLI+gHVEIowryRYv+EfrmOa4Cj2Jmm2lqafFIK+PiWbU+61H8PzPbEFyvB1RxOeGurUUoqJmsaksKRY8U500KSvDm7hgOQztysCtNdcu1gFZG34EYrIPyVdRD0vgM8AohXYCd7A0sODcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386164; c=relaxed/simple;
	bh=gJBierSqvnU+1R910Es/b4Iza7d3J6T9oW33xcWPjyU=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=kjrnTmDd4p3zApb5NHCTShoCRXxW8AwZNU5A+z2E6/QK7Bo3asUPtqG+K/DfJW2M9U4Ctd1i5ApEGKPIHzQ0vc5Ji6fP2fj+5jg44ANBX6Coo9MUktWmaPUBIFdeKjqwmuqfueEkewUlnAkXqz3Mr/LW8SIfQnHxGDAucQHishw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mbJxmXZ+; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QX9hjDX6nMP6VQPmx6UrapyfLHlJfDz4MEfnxmtwrbws7of0KKqXKHJzg8pgWMPehgn8s09c5J2jxWmSdmkPqE3zjipuQzvuggLqNXFC4mE1QvNNTK182g2BxWSt6LMDrxDXYPClM7Spmdtp6TW5pAFlNUoNMtRahmaFvLv0DAZekOv8nNBZOa2B0tWCiB+CY2tANwLtxXYpLgiaVXJ+6TuY/oLxyvaKSn2bX2/O28Iw0TBUIih4P0ZOM6Y5moVyht8Bs1lsSRn32Ck5ybSYYTxi3r533HJNRq0dAKy8BqkvUYjTc95nBV7JeTwgWpVkbvmm/fHweoymQ8m+u+8Jvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h71yltihMqnyoSsYcitF85Pw54bxFG2ag21jUjHnIc=;
 b=gQMY4bSTdDPuDwEFv4Nsa9h6Sb8u0dqgcp7gA0uWDiYCBNEQTR14WyUyFO91HbsuoSHDlbKJ0rAVoKR7TqqKbxMUfEd2v2AFRgHzGqHU3T1g3kENG837UawTy0mgTVeV4XCXsgJB3svkuGe+TpVmUVMqMUNYL3N89EIkYQTHArC+fiZSmhy1dPwl4NIJhuoZbnrUkGmWg7tjrHtIbWeoGCVaYVWeD7aL2SVuw2fgtH7romiaQGYNqn8ZPxytkU0Y18kDTdmIGVD38yBCP6v5YcDsQOi+aOFPHGFJ1n4z4UHMi+jVsqTPS3WdUXmDj9H1TUuim0zeiWI/HuOyUUrEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h71yltihMqnyoSsYcitF85Pw54bxFG2ag21jUjHnIc=;
 b=mbJxmXZ++vUA/WokuEotYEEPrGkZnlatnwHJdjzBtdN7DkLe5YA0FWABdV04PE7HywPHq8+uW5I23DlFYTrBlNYw7uV01GPR7cEOpqS8qAX8NxO4KXqiuaQXMKNYK8w+O/AohkI7cL3f8wumCeAZn5b7cRW27zV6xD40/o6wmpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 20:35:56 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 20:35:56 +0000
Message-ID: <505dcf34-93ff-643c-b149-8ef9ce90c023@amd.com>
Date: Wed, 17 Apr 2024 15:35:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 02/14] x86/sev: Make the VMPL0 checking function more
 generic
In-Reply-To: <20240417114658.GHZh-2sk47TZgCp4Mb@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:806:126::29) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: e441ee85-4feb-404c-caff-08dc5f1dfb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	metTf7xLpIOZkKWso9YgkMeyQHkUlW8v+tH0Jl4mPQg6EHVYP6Zxx//HTM2huRIL7IxI+5daHMrdxNGpzWqLL7cmKQKXnYtsvqAMfmtDjg8fC2Co3ra9VOzE5/M59Kfo421sboCfJpSIoXx6eye/pC8LjcFt5P9J+KqhOfBh3O5vGtApHuCD1KWQV9RvcXSr7aD/49p2abzuEMgQ34ebq95lCAGQ4DNETuCTGvQsSvGYnLD2SATCnEO8AY2JLDG845LD/YUERx22C3X9ZwPwFK54SWNArbmdwucW7KId+FOza3Xog44oyL4gQuEajD7M/uIpfPQfQYJD2gMC5XZjNnPsu6ltXoRiNB8wqcrbf7OQGo7tK8lBEUWisyRpi962SjLl98Hzzhs5cp/jzvSQlzPYpiq8rHrT/9sZHPZUY/2g2qQROIiVim6+vju/xrRqukaHZrrFKi3YdINNcrShIXdGXoVX5DLdJlrF5kz19iedZUkfwE+v2RTUP8hQjBiUq/g4BkJ22pvIIrGbDFOSKAP1OK8emNqrNGxVDESiB9VZqj0JP0xpo1JZb14hKPing2KnSHw8cDZqx2YzzZZmDmqKaYwGClZ5UaeLMahYh3kM3NWQtDPkzE3fpDUwN42kNkXgM6B0m0KPw+06sCaqGvStO6IKpM1u6Gya5uO4rSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEtiRjcvQmFRZjQzYlh5M3FGS2JIb1ZOd2VLaE8xREtuakJXMXEwcXg4czlZ?=
 =?utf-8?B?cnZycXZqd3dVNUxuQVc1ZzhmVWlvYm8vbXNBcHkrZnlGNnVNblZCYSt2dDBE?=
 =?utf-8?B?aFhGaFlLVmZsZ1NKL3NSMUxwMTVSNGtla3RvNUVIbjdPekdHVmI1dXhjejhU?=
 =?utf-8?B?VmJQVWVMN1NoNTZYRVVxc1ppdGhlM1JqdDROWGtBQnlOQkkvejJlWXYvSjE1?=
 =?utf-8?B?UzNobmxVdlltZFZxbDZwVXROVVYrRnl2MENkN29vSGtMbW83dzBmUmhITnhw?=
 =?utf-8?B?UmNickFtVjNYeU1XY1h0MWdMWE9JbHdFZ2UyZldYNXBiVzljWUNjVTcyam1O?=
 =?utf-8?B?VVdPdWxzZ3JhTmNRbW1zMnBrdGZRblgxS1hDVktHQ2JwYWIwTm9nU1RZVk9I?=
 =?utf-8?B?Q3k4b1BtL1BtdEUzdTdLZXgzMThnYlFnZXEycTYxaFlJSmFpZjFUZXRrQkph?=
 =?utf-8?B?OTdkOXBtSzhpQlBWWkVRTzFhdW5oTzZiMGJzZmhnWDZIVE5QVlgraDZKSkFL?=
 =?utf-8?B?NmdKc2ZpU2h2T0RUVEZvRUViZHhpVGhqT3FhTll6enlMSXRmTmp0b01HVjhT?=
 =?utf-8?B?bVRKSVZybFp2cWd4elJ3REt4Tk9mcnpZc2tENGUwZWw4ck5WSGtVTTBTbEFU?=
 =?utf-8?B?SGRWL0hZVmRXMjJTWXVSV21neWFpYkF6KzRVeUtKeHNLU2hTRFNBdUFsMFdG?=
 =?utf-8?B?UGFBSE9YVVBlOHBjWVk1VVBFNTN6ZGxnRFIvbnAwRUM1RlBSQ1BpeUFMakVB?=
 =?utf-8?B?UndkQ1NEV2RwczZBc0FJaTVvVU5wd0FTd1ZoSUd6WjNTQzJwV3ZwTklXZW0v?=
 =?utf-8?B?T1hkOW9jdmI1US9ORHJZSllPZVJyRlRsbXJlNmdhVS80TTNiWXVzK1dNbEhU?=
 =?utf-8?B?d1dZZVNxRlN0TGFjYU50ai9FNmJvNDRuQy90RnNsdnNJbFp2TVN1K1pWRkta?=
 =?utf-8?B?T0k0dU9nLzArTEZ6d2NKRmhrRGZCM1d4NHBkeDU2ekVBZWpCamFuTlA5K09a?=
 =?utf-8?B?M3p5UWxOOWgraVlMQTBHQ1BmUm9XUFFJNW00a2VJNm9WYTYyVWpTMnNadlFn?=
 =?utf-8?B?L2hoZ1JxUXh2VG5EY014SGFFYUxmVm5zR3l3Z3NCOHdlT1VjblB1b29Ha3d4?=
 =?utf-8?B?aVUwT2swSkZQZkZsR2hXVUxFZUVONVpPSkVwd0R6STNsU25GUkEvaHZHWDR5?=
 =?utf-8?B?blR1SThYdXRIanFva0NmQVlPTGxSK2ZPbTUySDBOZDRrU3RsVE9MSXF5NkpD?=
 =?utf-8?B?QU1yTXhBR1htNC9HcFJnTlY1Qk1wd0dOZHdIRnN2dmtYWnJhblVZTmZKVFFS?=
 =?utf-8?B?M2h0cWxYbkF2R3dkY3I4R3BkV0ZoMGNsdFJjc1FvaDhQbWdNSlBmWmw1cUtt?=
 =?utf-8?B?R3B2b1l5RDNiL1F4NU5FK1dsbUQwQnE5c3JlcDh1WGJ2aiswNDlxNDd2dmRF?=
 =?utf-8?B?WFFyVVJIY21sYmQvZS9Tdm81OGJZTU4vdkd1M1kvdTF2QW94VXJaNjR3UFRn?=
 =?utf-8?B?WHZIbHEzcXUrY0hsZDVtTi9jTzhMUGJDNFJwZmFMRmNuNG9HbGY4WE9EL2Zo?=
 =?utf-8?B?ZjRWOFpMNDFJalk1RlRTMWdab1d2RnpoNElYajB6dmJGNGxIeUZpcm1sNFJp?=
 =?utf-8?B?ZGVWY2RJY0p3bWU5M29FM0YzaFdZazZ6YXRyUG9BenJzU1F6a042a28wK0sr?=
 =?utf-8?B?cnFaZERtQzl5bm9wWkFGWStmOXlHNHNCWHNneHZZMm9JMmtOeitYaTlrb2c2?=
 =?utf-8?B?MG1WeVJlemhsSnBwdG5saElZanJ2bkJ1dHB1bDl5bThUbkxCQUo5c1k5bllI?=
 =?utf-8?B?QWtHcDJGWnRMTmlhclZ2UEZJRmY3N1dQUStrdDhGMFFDakdIQWxCMUpQcXRR?=
 =?utf-8?B?S0dpeUkwSXRxYm5vSUR6eGVNRmJHd1NpSU5qMy9MdkFsL3JpUENmMnRCc1V3?=
 =?utf-8?B?OFQ1dHZsSjdXcUVuMzI0dHNZSWd5L2F4Q1oxVGtpWUw2SktISzRuWlIrSmNz?=
 =?utf-8?B?YmNCTy9abFl6VEVTWXJGZ3haajBxSGRjUTJ0dzQ3Mmd0Mzd1ZFh2aHlRZWhi?=
 =?utf-8?B?SWNuQ0JKYnNaejQyWTFSTkZuU2NhUGhNV3oxd2xWekh3QTd4L1Iwa25RTGpi?=
 =?utf-8?Q?mJJUQLokzBaaboX170h0QEXx8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e441ee85-4feb-404c-caff-08dc5f1dfb79
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 20:35:55.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRQlpChL7l7C6tZ9JmwzJVySQgMb3bd4wNXNXCmmE3HNJbAAWvbMn4GCCh5tTC1pAxOgpRRWUYLt4xJJisF7mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786

On 4/17/24 06:46, Borislav Petkov wrote:
> On Mon, Mar 25, 2024 at 05:26:21PM -0500, Tom Lendacky wrote:
>> -static void enforce_vmpl0(void)
>> +static bool running_at_vmpl0(void *va)
> 
> Not too crazy about it: you're turning it into a function which runs in
> boolean context but takes a void *?!
> 
> And the boolean result is only a side-effect or what it does to the
> argument - modify its permissions. Which is weird and not really
> obvious.

Well, it doesn't really modify any permissions that matter. It tries to 
change the permission of a lesser privileged VMPL level. Since the 
kernel only runs at a single VMPL it would never be effected. The 
operation performed here is to update VMPL1 permission levels (which can 
only be done successfully at VMPL0) and return the result of the 
operation. A success implies running at VMPL0 and failure implies not 
running at VMPL0.

> 
> I'd prefer it if you made it into
> 
> static void vmpl0_modify_permissions(void *va)

I guess this confuses me, since it sounds like you're trying to modify 
the VMPL0 permissions, which you can't do. Maybe calling it 
modify_vmpl1_permissions() would be better. And a void return doesn't 
tell me whether it was successful and, therefore, whether the kernel is 
running at VMPL0.

Thanks,
Tom

> 
> which basically says, modify the permissions of @va in vmpl0, which is
> a lot closer to what the function does.
> 
> And then do
> 
> #define running_at_vmpl0(va)	vmpl0_modify_permissions((va))
> 
> because then through the indirection is at least clear how that "am
> I running at VMPL0?" check is being done.
> 
> And later, if we need other VMPLs, we can extend
> vmpl0_modify_permissions() and even do a more generic
> 
> vmpl_modify_permissions(unsigned int vmpl_level, void *va)
> 
> and so on and kill the silly macro.
> 
> Thx.
> 

