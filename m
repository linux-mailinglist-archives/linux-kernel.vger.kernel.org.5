Return-Path: <linux-kernel+bounces-140747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713BE8A18B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212C1B2A812
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663AD175BF;
	Thu, 11 Apr 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mmZz+WKd"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591B15E97
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849180; cv=fail; b=hWYWN3pxQHZGapRdD8zvLnTf6Jgxrc2By57oIbBS5NctwJ/yBt7f+RWxIDqerDoNcxWYGwI7pDc/sSn3xgzf/gpbschz/ENc9b40EbuSwuoNzid/TeDzxMUpKj5pMoWy7GezRVpo6TcCnQ1CoUmY/jxKH6SQ9bR4laYB7TsaNfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849180; c=relaxed/simple;
	bh=Ly+4vglXvDsUA9sXFbMylaeHZKJKwIRCLfhmuMVSgK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jTztRDfrwfCottOSK9atwRobZ1cyvHX1+d+fy7ArAxebN/0hhWwpo71kVXeibz7GfpL5GVkjJn1o0i14raeoHsNAV0+joGnLVHrk0WXRVeNZ8541RvOa0Y7NjL7Sql7ZF8C8xZfXK/Rz3HhXS/gNNbo16E8Oxd0Og43DKaPs5y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mmZz+WKd; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO6sQlznzBttOwwGeI0zGXDnqqA3l1EJVnhryOI/+19hxyUKKPm+lRc8vra2o9HRWeLbjGTZrGovcG3Q7SMSIrVTbij2TITNJII5u4E3wIpvSEiSz+ARr14C3v7IuJqeuhurEW0qPDfGi4ukdlwVuAGEZR4UDIXWX71z+h2PWmfvFPhZv+/+A6SvIFtpJFXubkZRWK9HOLFHwa0nlzX0O2xC1Cw7bMH+RL45MBSzJKwHX0HuL1EeqMgD1EdF3TKrcWPj/+GFDlBbqmsUKzOIZBv0isiJc402E4RPOA5b6YbcX9IVs154+QOWe7uGx1p28ZmIFfG+li/gsfMAZCtD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfMafOy+/HWmlZ/c505nfexOb8nMx6QuJl1F1hf+zYw=;
 b=PjbTYD1aIRaAS1UTjAHAEYM3fKsEH32tksSBHcFiu6GWFvxOok99zOl1mHeivoWbNIEY1dtWp9IuF5iCt7ljfxhk4kPtKmODWZ8qnsyK/2dCkLlld/6KCWPk60YoPsq/6jqdmOxWXSRB3gjBdsVlRdiMnlvu96Fr7SXJbioCAS124bzD4AAi91h9oQ7RrRrZGJtUj20US+cv0fL9w3Zq7N8Is7+0g3ASIpmpdJHtJwghoYXCXSrb0eiEDMo3CSa8Fbd1eLlh8fy2j/TJ78mqHYWK4NY9RTl6Lz4rlKeDJzyB5RmGEWbpMFlDjCmgXp8O/pvC7mXkR6XPd20N8PxJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfMafOy+/HWmlZ/c505nfexOb8nMx6QuJl1F1hf+zYw=;
 b=mmZz+WKd1UoFUjAQUJMTiNXxBXhi0ErapsFae9Hq5atL3ncyRELtFKdlMQZDbEyohZwUd6yUZ7W/n2+RP2DMStd/UjOGWu8wp/+DYcY2N3se7C0i5K7+s0CGJjlcCQeuY7LIdBoHFNXtp/vVfOVUbqvR6Y0PIQ+uoLQnOnKvfgY=
Received: from MN2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:208:a8::24)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 15:26:15 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::94) by MN2PR12CA0011.outlook.office365.com
 (2603:10b6:208:a8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Thu, 11 Apr 2024 15:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 15:26:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Apr
 2024 10:26:14 -0500
Received: from [172.21.251.124] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 11 Apr 2024 10:26:12 -0500
Message-ID: <74465ac2-0060-4047-97d7-acadcdff4cd4@amd.com>
Date: Thu, 11 Apr 2024 11:26:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] x86/pvh: Make PVH entrypoint PIC for x86-64
To: Brian Gerst <brgerst@gmail.com>
CC: Juergen Gross <jgross@suse.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr
 Tyshchenko <oleksandr_tyshchenko@epam.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <xen-devel@lists.xenproject.org>,
	<linux-kernel@vger.kernel.org>
References: <20240410194850.39994-1-jason.andryuk@amd.com>
 <20240410194850.39994-3-jason.andryuk@amd.com>
 <CAMzpN2h6S69bOLXCUhmkVJErvoKxq-wPmfoaqR7eGHYLgirn+Q@mail.gmail.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <CAMzpN2h6S69bOLXCUhmkVJErvoKxq-wPmfoaqR7eGHYLgirn+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bcd1676-4bda-40f5-8697-08dc5a3bba2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ho85NdNUr7+6PUovuj7DKzkiCbbcQu1xT1W9IqSqD5ZFs7kgMEGAEwUYAUWK46aEkp3B3dhfgCX+9j2YUftcHoVzRu6jVy1ECJKTvyh8YzXkTzFaYjjeb/sTi1lEIfSHi2XOI7s7WWOg5zg0YQuEo6lgPLa9ZPfgkPpUmyRmy/CGYUW10mMxtoEpfg3ETndUVJSpPAay602gz2+k8IAvppWUaHBiRdR0RQrCFuVVWuVretTmguiQf+wk1fIJNzobyvGRmb4ZsP/OjiMkJ/NcFqCVq2MEH6XOuQvsq1vhfYI4dGGD/I4NOZOJyY47miw9FDg51RNh3d+z33a55Dxgv3+nCwquMFtG9BM4hV12FgzxdZ5WKFMCqD0TUL0h66+mPTOQRUr32ru1b8zNUUFfbkXx6TB3SiJtNWx4lVBSddhwLhZlJ3N5QH6pQuoQwjBUkSn9/hjsQAQk16rB2s95+vQuAy+zZ8pXa/6FW3o7wwAinfMoQIsFGXeAuCxebw059Vk5j7E2nsufOOhVvt2Ei9xwOpYyF+mWi6njzFZu0RuS+1+wlTkQc0N3VsaWzIJVmBmlRMCoQsx2W92jQ+VfHnPb2Gqcl0bj2J2UJX3ZBqCS0F7b9GYtPUVyncdIZ82SNcZcJ9LtJNO/C8Et4Weaa/AIgd1po1qwHO2zp5VV9BE88YgmOk1sj5+PAQT7xQUsBfDRNkjUBPWrULope+EGn+vYE6pRSF7uIzpPq1bHICPF77gR7irvKeuzZg7NL5MF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 15:26:15.2440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcd1676-4bda-40f5-8697-08dc5a3bba2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401

On 2024-04-10 17:00, Brian Gerst wrote:
> On Wed, Apr 10, 2024 at 3:50 PM Jason Andryuk <jason.andryuk@amd.com> wrote:

>>          /* 64-bit entry point. */
>>          .code64
>>   1:
>> +       UNWIND_HINT_END_OF_STACK
>> +
>>          /* Set base address in stack canary descriptor. */
>>          mov $MSR_GS_BASE,%ecx
>> -       mov $_pa(canary), %eax
>> +       leal rva(canary)(%ebp), %eax
> 
> Since this is in 64-bit mode, RIP-relative addressing can be used.
> 
>>          xor %edx, %edx
>>          wrmsr
>>
>>          call xen_prepare_pvh
>>
>>          /* startup_64 expects boot_params in %rsi. */
>> -       mov $_pa(pvh_bootparams), %rsi
>> -       mov $_pa(startup_64), %rax
>> +       lea rva(pvh_bootparams)(%ebp), %rsi
>> +       lea rva(startup_64)(%ebp), %rax
> 
> RIP-relative here too.

Yes, thanks for catching that.  With the RIP-relative conversion, there 
is now:
vmlinux.o: warning: objtool: pvh_start_xen+0x10d: relocation to !ENDBR: 
startup_64+0x0

I guess RIP-relative made it visible.  That can be quieted by adding 
ANNOTATE_NOENDBR to startup_64.

Thanks,
Jason

