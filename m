Return-Path: <linux-kernel+bounces-160889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A67C8B4414
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DC41F21EF2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1AD3D54C;
	Sat, 27 Apr 2024 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F+3446FB"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88F3C062
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714191958; cv=fail; b=tjENhOax9Xlcx/BtVOnycCL2nsXRMVvzg1Mtt88E1Fkb8oFooqZjphVfPO2f0Z6Al9DiKFSU5skvGxqov5I4/EVILbuEY9uYW89R4RE1R7nCHwfrnNfNExOd6xWjtxWxNT8t56JQXrllVfjRxXASWRUQivl5B3hG6WjvKb8mrsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714191958; c=relaxed/simple;
	bh=VAWIUTPnL4oRvhYBSmyDTbQILOCq93l8XsOK7oBWWts=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A/wCLyOVBuK3dF+Yd/TxzptwCY3n0c1EQqqbp8bOiBxC4belJNKBvSxcHNrQjWWaCcCrmO6UZSfGiPeZdYIIpG8uBVKv6vPUnlryIhkck0usNLX1Q1cn7qd2ZIYIoYtyoInrKzGtzl3dZE9LzG1h7wAKYcUQBw1Q68Ap4OJ82bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F+3446FB; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvYHJPleX2QdnvhkoA1dMQrFo2hFBTzbBU14/r5bO6YqdWcqjXwiPjVl6uwsb9aFoHW2cUfXpzSsVuDvFJy2ItGniI7NsN5DoCBu4Od+meXhy6TI7SwV4XAWdfAI2UCyDmEQv1Od28NQI0xr4FCBmqpp6GIrr9xwayRqU40SEiTmu8jfUeP0bTtpUIOlvWE+r/9x5+pZOTn1c55qqXEHDi98qLRTeQKCDvTpTlB2DVtO+irR1qGz5sQ1j4h+M5bYvZMTt6UCxzAEQKptADbJwk5o0AJxceVbk8rWfc3djbFZU+5HfNG+RYDN5ojG3EAfG2V72QIndQMgHbD5Hr8+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y84M5Tzl9Ji1aiRLC4wADbZm1Sa7SHMpGyeokxPh7cc=;
 b=c4bThZ/szoWi/pD2Qwk2SSQQMWHtA9rUndR0D+dcEzB2N3MQmF9v6tzS9pjvW+CwPZT7teJBQ5qNCOORmjNHRvCWaYrLSRjSvypixypJb8/2QLofBNdKfZdjLMzB0ib6Jo33YRQk27bKYGgTlnPq7N7GRr2QzjvY9OJxZG/xj5l5uX/Ag0JZo+d73lAafZ9DMAtDnSD1MenM88Bf/LzCXzqSg/qsYsR/Dd3Q3hWGcsrJc274WMnCA5GzsZIsAuCuOgMMuD47uwJj6Av3i+5t1uVLWP3HEBmVFN3KP8Jxg/DUYJgtIeBYy2ayD6Eb44KsQ25qhR5LqKbSPHcSksKuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y84M5Tzl9Ji1aiRLC4wADbZm1Sa7SHMpGyeokxPh7cc=;
 b=F+3446FBYwM6uC0eUra7H8fH45gukw3gZM8VekvGu/ln0s0GgILApyEubo4cS71MnX1G4rtk3NMyKaQweqxl3Y1AyoAkZN8vAQ4K8NaxXLwNGjkqau+8gXwmAmDlmWmGE38cnzP/9N5ZICz1RYuSagtUHKk1bqJGp+UKU081RbJFStXmZN9WcjXEQyKl2aXi3PPvDzOOkm4My6Jf/cwMftRFFVBs3MAasP37SIdfbxSwhyFW4wUgJpeIx2SpEzu2a1VH+5ekLZpy+KviQA1otbatMYFdzQFmZxP9PfkhfJt4QhTmzffpnbaF8z683kSKi4qZHCooLWmW7kSYbgUikQ==
Received: from CH2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:610:57::26)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Sat, 27 Apr
 2024 04:25:54 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::40) by CH2PR12CA0016.outlook.office365.com
 (2603:10b6:610:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Sat, 27 Apr 2024 04:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Sat, 27 Apr 2024 04:25:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 21:25:43 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 21:25:42 -0700
Message-ID: <1734de6e-1bcd-492e-b07b-9ad712967e1d@nvidia.com>
Date: Fri, 26 Apr 2024 21:25:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
To: Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>
CC: Anshuman Khandual <anshuman.khandual@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <39d0236c-4297-4001-bc7e-f516bc674f7b@arm.com>
 <87df74b7-2352-4ad6-b9f9-baed9291cbed@arm.com>
 <80148272-208A-4306-A8EC-98C79BBBDCA0@nvidia.com>
 <D0E6B5DC-6206-408C-81D1-C9B0A85E1D0E@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <D0E6B5DC-6206-408C-81D1-C9B0A85E1D0E@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 208b195e-bd5b-40a9-4e00-08dc6672209e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400014|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1NIckxGWEw3N2w1OC9iVzZ5ZnFZTXAzNGRQYmR0U3Qya2djdDY0anpYMlox?=
 =?utf-8?B?WmRrcDN2aFp6WURGcEJ2WnpPd2x3Wng4Yk1pR0JNS2w0azBJMjlWOGt2elgw?=
 =?utf-8?B?RCsvcGE3cGVMWHRBaFB0dGJQSTJrbytKaVdoSWMvcmhTRWR1YTd5UTA4WXpE?=
 =?utf-8?B?Z0kwQmJJV0JDLy91UlFYZG5xd010UU1DTVlNUTRKRExTWjFYK0hzczREUXJM?=
 =?utf-8?B?VHVEM3NjQUNpTWhyM05nZjM1Zy9yN0M0bnNaZWZWTGNlQzhiRExnOFAzQWZi?=
 =?utf-8?B?WnhhZUg4ZnZLUkRlTDhHN3hhQVQ4Wm4wSkRWQ2k2SjFqU3IxV1I0RVhYd1Yz?=
 =?utf-8?B?bzIvaXZBVTZkVFBYbXZSQmJ1ekVwS2k1TTYwamYwRElMYnUrdEF5TlRZNnEv?=
 =?utf-8?B?aVd4ZnFaNk5mWlVtaXB5alNkRjI0ejBCNGR5Ympxa1l6M09jM2swV01PWmNq?=
 =?utf-8?B?dmMzbFdFMXMxZ1JRcGpsb1RSWCt3UGpRTm9WZkhEN0hMZ3NSRjlzazREelN3?=
 =?utf-8?B?dUZmYzU1M2FML3p4UUo3M281Qmt2Ukkya2NLSkI4RzZ4VitaMjZxOUNHYkJH?=
 =?utf-8?B?eGpiRnl4UktMRjRUWFMrZzRtYms4UDZRaGdNWDRyVytxQkVBRnpqditlNGwy?=
 =?utf-8?B?SGwwQmNVb1hWVmVuUjhCUEl0VDlZT0l5bUtCb3Bab1M0ckpJZ2ZtcXVrTFFo?=
 =?utf-8?B?aTg4bzVFcUpHUVdxbHYvOXVyRkw4bUM0MzBGcnZvSFp4cndlYjZBWkxzMkNS?=
 =?utf-8?B?cHdtVmRFU0hTazRvZmtBSGg3YVM5eGVkVXc0MkxaZExQdlEvdDVxam56Q2lx?=
 =?utf-8?B?aS9PMlNTODNhOG11QkFqZVpNbmduUW9BTkpPUFVicjdldWplZVNCQ0dKTkc3?=
 =?utf-8?B?ZHRYcVdwbDFESFNQeFpQNlVyZjlHLzdVWDV3blNBaklWV1BPSVloYUNQcGxX?=
 =?utf-8?B?bTdwaW45QWRwUDFzbFJ0ODA0eElqN05Ia3pqai9zQTJjTHNWZ01nYnJmRjZK?=
 =?utf-8?B?ZFZVMXdqdG9sejl1ZDJWaHd0RkkyN0JxTk40dTBpbVZqTWpENXhuaFYwV0xv?=
 =?utf-8?B?dE9zbXV0S2tLTHJEVXZhV0ZGSy9vT1VsNWhUMEhnRW05NnJxaWtzQ1BHa3RP?=
 =?utf-8?B?NEowZlI0QzdhWFNZaEZVMnMvL0wwRGJyWVU4ZkVQNUE2MG1kUGIrc3grbkRl?=
 =?utf-8?B?SHBsU1ZjbXFKb3hQaE5YQWdyenI2eW9LZVgrN1ZRbTdlZXhLUWxEeTd1TXY3?=
 =?utf-8?B?MnhtOFJhQ2JZbWdISDdDQ1RYMmNaV0tCMk8xMkZnbnE1RkNvaFQwZ0VsUXlC?=
 =?utf-8?B?TDMwNUhIdWROai9JY2FXMDFIZ1JsNXlLWG5ZVlFta2l2ZjJlZStTQjBQbDdr?=
 =?utf-8?B?MFlDU2tsejdkZm9RRXE0VW1wM2ZkVE03bDNoYzRGNzNKOENJdSs2MW9JNkUy?=
 =?utf-8?B?OVUxOGVQU2lFc0VXSFk5aWQ0QXd5aXJhajRzYXE5bitGV0I1WGZiK3dxNWRR?=
 =?utf-8?B?WEhkOWlsNnBXaFpQaHVIYUd2WkxDM1dvanhlVHpNV1drZVI1RkhqNUFYMnE2?=
 =?utf-8?B?WFhwYno2ODJxZkJkRkhMNW9KSVhURkdnMDU4VTdtUlR4RWlQVnI5emJvS3lv?=
 =?utf-8?B?ejVCOG9qK05EbjhvQm15SXdvdE8xZVlKZGNsMFNBYjZ0blE1SnRuVzJ0ZXBP?=
 =?utf-8?B?Z0FLNmkvdEVUZlhJcGI3RHBOWmROT1dobFViSUhiRlk1Vk9UWk42T1dnb1Qv?=
 =?utf-8?B?UTJkZE9Mb25SbnpQTlBoNFI2d2lEbUtVNDhLZHZvcDRrNDdicXk5RGFJa1po?=
 =?utf-8?B?R0hDSFhHT3hmTHFhZTVuVlk4VVJ0R29Ja1lqNjNQNFVCVjRnc0RZNkdHNGhh?=
 =?utf-8?Q?gKpL4LivVctVx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 04:25:53.7443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 208b195e-bd5b-40a9-4e00-08dc6672209e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484

On 4/26/24 7:53 AM, Zi Yan wrote:

Hi Zi (and Ryan)!

>>>>> lockless pgtable walker could see the migration entry pmd in this state
>>>>> and start interpretting the fields as if it were present, leading to
>>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
>>>>
>>>> Could you please explain how bad things might happen ?
>>>
>>> See 2 places where pmdp_get_lockless() is called in gup.c, without the PTL.
>>> These could both return the swap pte for which pmd_mkinvalid() has been called.
>>> In both cases, this would lead to the pmd_present() check eroneously returning
>>> true, eventually causing incorrect interpretation of the pte fields. e.g.:
>>>
>>> gup_pmd_range()
>>>    pmd_t pmd = pmdp_get_lockless(pmdp);
>>>    gup_huge_pmd(pmd, ...)
>>>      page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
>>>
>>> page is guff.
>>>
>>> Let me know what you think!
> 
> Add JohnH to check GUP code.

Ryan is correct about this behavior.

By the way, remember that gup is not the only lockless page table
walker: there is also the CPU hardware itself, which inconveniently
refuses to bother with taking page table locks. :)

So if we have code that can make a non-present PTE appear to be present
to any of these page walkers, whether software or hardware, it's a
definitely Not Good and will lead directly to bugs.

Since I had to study this patch and discussion a bit in order to
respond, I'll go ahead and also reply to the original patch with review
comments.


thanks,
-- 
John Hubbard
NVIDIA


