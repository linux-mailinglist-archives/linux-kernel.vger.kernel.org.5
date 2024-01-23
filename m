Return-Path: <linux-kernel+bounces-35480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F38391D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E8C28780A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E25F55F;
	Tue, 23 Jan 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BLG6Fqvi"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED715026F;
	Tue, 23 Jan 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706021912; cv=fail; b=nR9PgSe0kjqZM8acq3XeJnlvULE49CQIOk03/nYkyKsC/ge8tvcYgGmSqzmX+vpZ535N/PCqnoIUtV48jnMmSMWErEth/Rrc0PZX0DBWWUcx1CU+lcWgzY/nPxss0azkPyRlX/sgiUw9rh1yQ43jqmxJYmJm0QIYzDFRTmAUM8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706021912; c=relaxed/simple;
	bh=lkjuoN57MiR1suFntNTGdTFHV67dcAuNKJ6C+DJK+ao=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ew33bl2L2JiJ3mI8eHRm5Ru+Ca2SM/xhNv+GZwgzO2iR6BfWiEb7ooDVRF2wvzNNQtwmPZxW5lK0aRgFHnxOopJh4kLlmpIX5iKmjPgv6w/5X47ilmmXATnLL52q5DqF414RcZkAcGt64biLI3QGbodyhZEZ3DAkNbyZgKmYoi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BLG6Fqvi; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh6LP29N8/UhAkcnvIHWVhtEDdmLlaICtlzywURRtGsCOu42VK4Bg2oOoelONxJgxGAkYtYPP9O2jq9pSMQ6gyT2Y19IhbzloeXSKYlzHtWfAYwQFj/446mKOrZZV+e8j5B17bHdcnEYIIsWM79W9FxdSdHnfeiltPkV7rnjeDU/ihJndhU6a+HRgM7bpqyAWXf1DEE+XaU1arFOUAwVmJqnH3NqxOIhW62Ntj1ZCY5uuaSO2Q46lYItcGalxohPNk2ycxMYlIhjibAqJiotOIZHSA8rcB0xxtHU1B0jv6YS4wMrwaXMuiceSrkEc6+ps1J65louWzghnhml07kHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Map9aaTuwz3wHYR7loSLnisuK+tFi8ceP63pgLexVNY=;
 b=ceuvW6JtnzriyQJ4WektWaG9iSyhNUdFpzslhsMXqyyJxuDop6bM7muxOoQjM/glPTP8chVzTcT2nmcGWK+Ld+qAeGNhiL4G6oxzSi4SBJY6pG0WIHdJQUhXz1r1vOYpql5ac8khXuUlqgXVXX4v2GXKbV5luWPzI97oqU5zoccgAPp9q9zY070X8ZtI2DUVT7ZVsrTeESel/fa9r0VV6jzBZ0wyu3EA680HToAhqpanrjMoeKDWgJHlAW454iuXZXMumleKQZG+a2s4rb0FZglaerJZb2AMeOFyjpOj02Nn/f/fAOsSzIfN4FOhOfjThn+ClRrOo+pQC08CR9zq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Map9aaTuwz3wHYR7loSLnisuK+tFi8ceP63pgLexVNY=;
 b=BLG6Fqvi8offdmnvKSLLy/byZ124d5Hqi8l/nerlIbo4NeUonDyrG0lWmnDtShccq+4IqfzreO1/O29RnSJjGejW8VkXAK/Yr0e0uXlzX9LoL17ydMugp6AhCanpMEVlE8mvTahl2/EaB8CWpCEcBEWQaJ5TBPGtFdl1UG9h578=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 14:58:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%6]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 14:58:27 +0000
Message-ID: <8696e53c-2787-4c19-a673-626434460015@amd.com>
Date: Tue, 23 Jan 2024 08:58:24 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 1/2] x86/resctrl: Remove hard-coded memory bandwidth
 limit
To: Borislav Petkov <bp@alien8.de>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, seanjc@google.com,
 kim.phillips@amd.com, jmattson@google.com, ilpo.jarvinen@linux.intel.com,
 jithu.joseph@intel.com, kan.liang@linux.intel.com, nikunj@amd.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
 rick.p.edgecombe@intel.com, rppt@kernel.org,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, peternewman@google.com,
 dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <c26a8ca79d399ed076cf8bf2e9fbc58048808289.1705359148.git.babu.moger@amd.com>
 <20240123103623.GAZa-Wp79DMgeArPJz@fat_crate.local>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20240123103623.GAZa-Wp79DMgeArPJz@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0320.namprd03.prod.outlook.com
 (2603:10b6:8:2b::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8f8c36-8b6d-4982-f33d-08dc1c23c191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UDbX/hP4s9Ud/X5Xgyok2UlV98FlrN2JfFoM7qLOEWncnC3aph7VD7mJluy/B726vW+XqJE1P59edThfrumoj3OGV+atV3Xpvv97coTIPdoaVA80s5KQfixmuJ0XsfYEK5z2GcNmfk8lHPCWO2KZQ+o/b6RZneOCEafLWGv1ydwykHHNv3mklx1/MYgkx1VH6Tk8yFcNVo0xvGPFAm4wW3TODrd48HnJiqueJLWoHQa3uH5elD9MMYPLfZdd4zoT5PjKmgJgzR+4c4pInIPRPDHMJ+V6m/zB6quq3wZY6JS9wDTVFcFHcBlUXCV1wNVeNHqFk8OfGeHzVsP9B5/FASpiyuOTqgGbF133fUO35Zc5zEEdTeOoskf+BX8+G/J+olWjdc2ijC3bdQ85W6y27aaGULVmx1ZJwXz+DGlduOIVHrlKHEaDbN41B2U/3abWuA2dE0brSv0rjYxTNH08kcUn2i5P72NUO35FhMTmJs38uzmpE4K0XSzi24KKPkr9oxiSlNV21CwTG7nEG3H+UTljU94UfD/AVeP5h7n16hPCqy8WVBXdzF9RwKi+S9E9PFBxiBbpgSw6dqkG9MxSxaWpYFhRA/yLeyioUDHeMPkoocVmDB5/4qeXm2GeGFliMqrgXgueBv8C+hI5NsWPwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(38100700002)(86362001)(31696002)(36756003)(7416002)(26005)(2906002)(316002)(6916009)(66946007)(66476007)(5660300002)(3450700001)(4326008)(8676002)(8936002)(4744005)(2616005)(66556008)(478600001)(6512007)(53546011)(6506007)(6666004)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjBoY3QvMVdBaW12UHprdGlpTW5rR0s0ZDhVK0oyVGNzV3Q0bi9iNzRLRUo4?=
 =?utf-8?B?ZXA1Z3FoNXFDMHhpRlNqaTF3RGNzNGFnbm9sd21BcFhXazJiYWR6alF3M2hW?=
 =?utf-8?B?T3BOd1pmMm9JRDlkNGdldm5XRXdOVVlaVERDTHNHQ2xiMm4zdHRxREY5NnFU?=
 =?utf-8?B?Qnh0anFobWQ4a1l3WEk4Y2wyaFdMb1NrTkd0M3Q2T2QyaDBOaGRZUzhXcnRn?=
 =?utf-8?B?NVBhd2RYU2ZVK0Jkek1jL1E1MnV0bDNLZEFrU0N2Nm83ZU40RXI5YzkrOVA1?=
 =?utf-8?B?cldiOTZJN2VlQTZrMDVZTmw0UjJ0RThrMmFtaXFJV0g5RzBVcjdVakh3Uzhn?=
 =?utf-8?B?eHpHNVc5Z1Z6SS9JRzZ3Rk1CY0dRelc5bXRNeG9EVjFVVmJpZkNUNkVDM2Fz?=
 =?utf-8?B?VER4ZS9zbS9FRnd0NDdCMTh1U0czNFpMUjdYazF0QzlvaHl3N0hoS3RYUUhn?=
 =?utf-8?B?ODM5T0RCTnVldERpTWxCR3M4VDZhTXUzaXFNVi9wbkViZ1dLVGdYb2l5M000?=
 =?utf-8?B?My8zMnhXTWtiM3U4ZUJPYkNMeURhdEZ0MGNWZnE3dDJFQmxtVzdsanF4VEdS?=
 =?utf-8?B?eEgrZ2tmRVEvemJPOHdXQTRkZUdCcWg3WVJ2V3JhWEVWQlNUeW13bmxOS1o3?=
 =?utf-8?B?STlVcGJleHprV0ovbVM2NDZMT2NaUWxSTTRoWC9YcCtKMDk0NzFlVGV3N2VZ?=
 =?utf-8?B?aDQrNXpaa1dPUmFkVlBlQ1gydXg0WHJNaURUOVMrMEFza1BtR0I5aWNPdXdM?=
 =?utf-8?B?Y3A4d0toQ3UyWjRBaVBBa1BDc1RtZ2pOQVNOb0g2UWc3OFZhTjZBZytLTmRy?=
 =?utf-8?B?YU94NTI2VUpHRHpRVm1uUjNrRzNLMU5hNDQzaXBhMkZtKzRoeFR4UEs0aXU4?=
 =?utf-8?B?ZXZnRGd6OHpSZ1dVanNuZTZDdEM2UEM5OHpZV0dSd2xpUGhpTG1NTzNqODla?=
 =?utf-8?B?aEcxamUraXl2Y1BtdHBWd2dkaGc5N0JDNE83SXNzdFI3TFFtbGxlWWluWnBV?=
 =?utf-8?B?RVNSUFhRLzlFTUtsMjdLbVJpOWg5Q2pXK0FtaG1KMzFESGZNekZQTFl0TkY2?=
 =?utf-8?B?cDU2eTZnN0pUUE12Vlk2VitoYmVRRkZ5RWgxN0JReXNPRmhHSkF1R2NQd1Nj?=
 =?utf-8?B?ejlmVlBEbFA0bk5VZGpJbEFsWEhlZG9KbHl1SUxEMTdsdmdSOW41NzNzRU5j?=
 =?utf-8?B?dEoydDkyVGZYN015Q0tFbmQ1Uml1akZVWWZ1TTBIaEFxM0N3Sm9lSTBtYjF1?=
 =?utf-8?B?VnFRWEI3U25uU3RxcEV4bk1vcWZGSFE0eHltQ1hZWWFJNEMwVG5LbnJXemVi?=
 =?utf-8?B?a1VVdmhVOElXa2JJMFZqWFdFbWY4WXM4ZVQwOVRXNUxnVG5icGxUbk4vays2?=
 =?utf-8?B?akx6UVVhUWdwN0Eybk1UamFwcWFSUnVleHBSOUJzUGdpNFJoKzM1MWVWNmhM?=
 =?utf-8?B?RTNwVEVpMDcybVNJc216SSs4SzdyZXFNSTB5VExpS2FOUFVRaXZOUmloWGU0?=
 =?utf-8?B?dzZMUnhiTVJvc1Q1YnVBdzVxcGExS0tBUTFGQ1dYUU5xYVBaQjdTZ3VIT1N4?=
 =?utf-8?B?TFZ6SEF2bGVTbUx4TkRiYkVRR1VzMkdiMytxNGZmMlIzZ0NJaWJaOWRFb3gz?=
 =?utf-8?B?TjQ1Y1BrUDFKczVyM25nU0FPb1lWWlJYV29tSVRBaGdjTkJFNHdtUXkyWURq?=
 =?utf-8?B?L3RlQXptWmVxT0ZHVWJqd29TdXl6RGJaNU54Y0Z6Z25jR0h2amZIRXNFYS8v?=
 =?utf-8?B?L2FZRjNaaC9kcVFTWTBKdThib3l1LzNtZStaa2JRV3NITHZjMkpVa1BTbFkw?=
 =?utf-8?B?YnBjZ0JabWFXa1h5SHdXVEpFUDlWcnZRWGVMWDhNQTVwM0M5aVVjNFBzKzZ6?=
 =?utf-8?B?RDI1YmNXeG85MTEwR2YvcXJFalJNZVVzZDlhMXNELzM0WUlHQzlvOHhvZ093?=
 =?utf-8?B?TVBUMnoyNzJWTWFwd2ZwZi9tVEZscllOTzBoT25OQ09WQkJrT0dyY1ZGaEg2?=
 =?utf-8?B?TU5TV2FaZ3U3Wmx5U1gxTG5FR29DTlBxMlJJUWN5emcwT2JMaGI4NVp2aG1K?=
 =?utf-8?B?QTNhZXkxTTJTZFFqNlFvNjIrck9ydnY2Mmptc0NGTDFJVFBjLzNLUzdIY2VF?=
 =?utf-8?Q?/2RI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8f8c36-8b6d-4982-f33d-08dc1c23c191
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:58:27.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbUL1u2aqt15IfqV0OtRlg/sbJMTl8oi/EBI8N28R8AjF5a7hSYel7MKRtttFeUx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160

Hi Boris,

On 1/23/24 04:36, Borislav Petkov wrote:
> On Mon, Jan 15, 2024 at 04:52:27PM -0600, Babu Moger wrote:
>> Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
> 
> What's the point of this Fixes tag? You want this backported to stable?
> 
Yes. That is the intention. This applies to both these patches.
-- 
Thanks
Babu Moger

