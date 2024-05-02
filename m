Return-Path: <linux-kernel+bounces-166496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F108B9B76
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0517282C3F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ECB84A35;
	Thu,  2 May 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kcoQC4lC"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0496EC8F3
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655876; cv=fail; b=gfvhJkO6g3t1cInZatY8K5JlKgzZZkvVqOiT/Vku/kRX0ab+d+/k5/LdoQ/Krsfc8sLXV8/Aob+8ZcTJUnm6hvLVOb7Za8fj1L4HF9WFDcZcAMsR+TBHM4Zb3CgKx0xStpeVkegcwfp2bqDf/c7yw0gXjLl7dRWfdkIeurrg1As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655876; c=relaxed/simple;
	bh=33NfOVa7RLI7l770gAo15nvoQQN0gu5j7q6bb61A1vM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VH8c2nfbao9Fdo0eKygSngZn3WnstdxX8XUec2FZKBGtHfIYJkYuAcBT7hv1dkX+Zq17RRELghpF3/guuQICbIzzczggMcz0w8CQWTWhT9DqZoChQyNWa/djfE97rpKUs7692iCXH+tFLvXIMcHVB/bpbUL4ttsjDmiuscMOJa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kcoQC4lC; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7jeSiq9B3c093VJuxjIRCUlszARV9wHDWx8UQxFrNHQ7+8UkxDFVxDTyvXCCsEkY2kdYk6gja04AOx/r9C3A1gGcNn1Ml6QgvYpNPQsA2Ub4rs7mrtEPyMdOwfF1KZmWQNl/ge1fj94OAB0ayN2ExprHDudx0kVd7w6qOms/Yvj9WKU4InU2yV+UP0vFT4cbcQu2xn8fXHsjL2QeR9pucF4B/M1EY6/u7HY4aOY+3kcWWaQDIyD6hwixrIOsI6N0yPst8cz5BHYr82+QjPM7CNBdlcR+my60R2A7UkJuJ4QSvv7NSJf/5AoRhGcUe5sQcrfHEwjSnp7eGB9OnurvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q0+xtbNDJli4JekY5bDyAcujxuoONlicjHDZ0LhzCI=;
 b=R0TlPEdeGJBcq56dP5LaJ93G9hvzgCSCtGsPQbq0NGa/xYSREzSKlOLWKdXRYfCnZGmFLB8U1ast3mJtSK8ojZz1kCig7cAyOiADrBrrwL812YRE/tAvD0LNDg2JEnO/fnrigdFF7Zt7XSLeFM+omRrsoX7XyM2AfjR3vBVZTunokeW8boTfnoSgquEMT6KqkgaBv8Q1Gdj/d7TLID59+1VPwhq6622m9wNFV32M6c6N148m0C2Qlrv89irYKvnJB7i/88qBvORNxWpWh0tCTNF0xHwp+yFG3XTlHLNKA9lfmOxNk4ZTlJd6E4dyn1JJ1TDwH6c9uczNHUdfL6gbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q0+xtbNDJli4JekY5bDyAcujxuoONlicjHDZ0LhzCI=;
 b=kcoQC4lCQte7Ff/BAFvChklPkEw8RpVUXsHTklnaJ5BAOVOVC1L14BvwZupf2K8qXBRbs/FocFOCulOxP7oSjlNcY6beBEgLuIS9ULpp/FNBbJjvEzz8P9rNvX1cJg6vDSLmSOTW6iFq81eeM7MJ+v4oP0PZBncOVr6AFwjYHdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 13:17:52 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 13:17:52 +0000
Message-ID: <36973db8-30c3-60e7-b2f4-505c76bf01c4@amd.com>
Date: Thu, 2 May 2024 08:17:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [svsm-devel] [PATCH v4 10/15] virt: sev-guest: Choose the VMPCK
 key based on executing VMPL
To: Jacob Xu <jacobhxu@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Peter Zijlstra <peterz@infradead.org>,
 Michael Roth <michael.roth@amd.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dan Williams <dan.j.williams@intel.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <b8508f57712e3194484aa8695494eea26abe1b73.1713974291.git.thomas.lendacky@amd.com>
 <CAJ5mJ6gEd4SXtbhRhBowqVNgqqDspvtSC-NLPzNcoE=xHkZ6YQ@mail.gmail.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAJ5mJ6gEd4SXtbhRhBowqVNgqqDspvtSC-NLPzNcoE=xHkZ6YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:20::22) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce0c6a2-fbb3-467a-8f2b-08dc6aaa4569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXJjQU82WUozUklQNnY1dERhNVFnSVFuRDJkV083V1N3cVhGWFdEb3Q2Y2gv?=
 =?utf-8?B?V3dmUXhmZ1hUeExscm1MdHlkT2xFM3FGZGRrazhIWXRMWUtEMDVUTlNFWHhX?=
 =?utf-8?B?TUFqT0I5UzJ0dkNtd1NoS2J3ek5pTllMYUhPZXZsV1FqUm1TWlFZWlkyeWYx?=
 =?utf-8?B?QXFZcVhnMnJPOWs3cFg4eHNYMHFmNmdhSnAzWGt1MVUxRmp6bVNIVUVmWVFU?=
 =?utf-8?B?c3ZFNWFTUFRVZm4wOEJjMUZubTlyWXRNazdjMFNPbGp0d3lGWkdUMVlsTUQ1?=
 =?utf-8?B?eFZ4b0dxRlN1cVVnQmlxNnI4QTFvRWIwYTF3NnFWcGZPUUNhTlZJSXBKUWRw?=
 =?utf-8?B?d09hdC81TUxkUTRMSjE0MWxSZXpORlZNSzFqaFl6UXYrVzU1UVNMR0puaGQr?=
 =?utf-8?B?ZS9qVmlJTmg4NE8xN2ttamVPRlFJMnQ2bGNnVUlCb2Fsb1Vxbk5EZUJlU3k5?=
 =?utf-8?B?eGhUSDJmMFZ3WnNwZ0loby91MVM2bmNjdmFKUG1EWkw5a1kyNit0b0xsNVFM?=
 =?utf-8?B?M1VjZ2Q0VGJ1SFpzemdxdE5aU2hWOWZST0FST1BFRk9Rc0pYVFExVE9WczJF?=
 =?utf-8?B?VFMvODdyckphTDdtTTJ2eURlWUwxU2VJd3pzNFFjYXY4M1ExOXpmZ1RmQUVJ?=
 =?utf-8?B?OWs5Y0VqTXVnODI1V2x3QzdYQzF1ME90MVlyRktETlVOTEYyM3BXbVNua3B2?=
 =?utf-8?B?ZExXL2NuV3Y4RDBPVXpRVklVTHJYdnd1Ynh6bi84N3pqOXVOaGlLSEd6MVZi?=
 =?utf-8?B?NWZJK1dCMWRFMHpsQnh4VzM0ajJaVlpSL3ludEROUVRYL1VOQ3Rnb2hCVENo?=
 =?utf-8?B?cmJOd3hsU3hXc0Jvd1dLYUEyWUE5SmJPakhTclRaaVBPMFpFWjByNzR6OGYw?=
 =?utf-8?B?dEVKZUF1UldnQUlIZkNXNDdHdjNNbUtFZmY0bXJFLzMwOEVuZlhNYXZyamI4?=
 =?utf-8?B?ZmJzMDFja0w4Yjl3NytyWEtSSDk1MTQ1RWpxUlR5ZVRlV0pBNTFuRFVxaHNa?=
 =?utf-8?B?ckw4UDBuWFVkWnUwS0I3bmRNazg2QUhVNnZMRk9JWnVKNU9zd1JLTDM5NlhG?=
 =?utf-8?B?QVV5L09kREM3YXUrRlE5OGVDS2JQUXAwN3J5M1lUb1VadkM1SzlnRmJjMzJW?=
 =?utf-8?B?NHVEbUk2WWRnNXFIUGF3ZG41VnFraTdvMkJ4ZzFxY0NkVGxzS2NlK1RxVmhN?=
 =?utf-8?B?L1JGK3g1Snphc1RiWU92R01PQjhzTHpXRERWTjhLWEpQL1FWTGYrMmE1am1M?=
 =?utf-8?B?ZitMcUlIQkNSd2dRcUVTOGhYcVQ2U2paQUs5cVZXWGdoVWdkOFpwV2FZU256?=
 =?utf-8?B?dXBpZkNyaHN6RGNQTnNFcDBZZjRLN2lRazIxVWVqc3pUM3FpQWppSTJxRmI2?=
 =?utf-8?B?RWZuUHk5KzNxY0VFV1lOcVJWL05UUWdxTjJaSGU1QVBMMFVid2lMRUJHcEMw?=
 =?utf-8?B?cXcvS3p4SXdKRDdlcmtDN01VSFVEMUh4N2c2ZTlQaHRzeVdDN0JFa0FxWlli?=
 =?utf-8?B?RDd2QXg1OVNVbGVsVFJCbG9VV0VoTHk0SjE5eWw1cmZQZE9YWTV3RHhLQk5i?=
 =?utf-8?B?TG40ZXVvaysvaC9Jdk50MGVlTjN2bWJNcHdCdWVaMFlxU2lQN1phUTd2M3Np?=
 =?utf-8?B?YnpqRnNHOUYyOXNHY1o2ckJ3czRLWHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjZ4Mkg4b3NYVTRPUDlPTWo4Qi95QVNZUnJDVGhSd0N4SEZ0R1FtSmxnVFdB?=
 =?utf-8?B?SXJLa201bGE1SkdndEFCRG4vdEpqNlI4d1lJTHhTUDMwTjU5QTZSRndzWndz?=
 =?utf-8?B?SXFZZ0V3NjFIUUE0dzRpNVhvK0VZNzlGTWlnZ2lWNkZmR1RDdG1RNU9palls?=
 =?utf-8?B?L3FtN2NQZDlSS0R5b3BBUUpwcStCYUVFcXJBYzE2YUd6UGNFN0hyc0ZTb0hl?=
 =?utf-8?B?Z2FZM0xRdjdjZFM5eWEwUVFBWk9XWkVIRHh2SU1TYXFwUFpmN2xvSWRyczlE?=
 =?utf-8?B?Mkl1YUZhU0doM0NISFErSGFKekVPak5QMS9Kb0k1NVU0YWJaS2ZIQ2RLRTR4?=
 =?utf-8?B?N1N4dHdKdndkTmNiaTdIRnl3VDdjOUNMSnhTN3l2NDBSc1hSTmZ4T01jM2lS?=
 =?utf-8?B?dVNJRDNYai82RUVrcmp5aTNsQWl5MzRvV2xRVTV4SUpYRGlCeUxheUw2ZHph?=
 =?utf-8?B?eDZoSElBYlJ0Q2Z1cW9JcnZMSGtBTUg4SlZDQUhlWFJkOUJpbUY1VkQ5STlX?=
 =?utf-8?B?RnBKZXFMWi9GQVdMclBSUTRraXNyb0loNnpWSytWN1V2ZW1IWWU5a2UxZi9n?=
 =?utf-8?B?QloreExHbVE0UTBiMWIxUzl6NGVMS3NqV0N4Qm0wdHNWSFdacVF4SmZFMTdh?=
 =?utf-8?B?cFI5Sk5ZTVVOb3d6OFE2NVpwYlR2RE5Td3M4eDEzMkthb2VJb3J4Tk5KZ3Fo?=
 =?utf-8?B?alBSeHYwZkg1YmQ1VmJWSDdEWU9DVmR1SVkyT3FreWJpbGQzR2RaaHg2Z2FV?=
 =?utf-8?B?TUFObGFUSmFaZFlqd0RQcDNnbG1jdEdZd0NJaUw5MXpPQnFoT3RSNHRPMTZK?=
 =?utf-8?B?b005UFZpb0lNMXBnL0lQS2tKRG5LcGpnb094R1FMbzNjdlZkWUtJVktCdzB5?=
 =?utf-8?B?VHc1cDJVRis0a2kvNWowOXFPdUhaQnBEbVRYNUJRMVFmQUNXbHZDdHl0L1Jo?=
 =?utf-8?B?ZnZLakNTU2NoR0VYLzlCOEhMS2JaMTZPOGhkM1NkYm16YytNWnk0cUdpVVlq?=
 =?utf-8?B?SjFWbXdWc1JYQXNrcVQyRlpHMzk2VG9VVE1IUjhGQUpIZHNkYWFJZ0wwNE54?=
 =?utf-8?B?Wms5NzVDeE1lZTNEejhWcTFuZ0xuRkZYVm9TeWVjRnpzY3ZQaDNSRjdpenpI?=
 =?utf-8?B?WXhsM1dkNkVNQllUZElsTExveHNlVGdHL2NkQlQvdlNXdE42NnpvYWdzTG5a?=
 =?utf-8?B?K1NGTmZ4NDVSK2lPSDdaamxKcmFVTnpublFCY2dNcW41L2JGNkNzWHNnVnZJ?=
 =?utf-8?B?a3VhT2pFc3NHS1U3T3M2cjNQRWVwS3FkcldvM2xyWnNCemw4TXVQMmJ2SXVJ?=
 =?utf-8?B?REF1eW5uMnFUSGpKQWxUb2FycndRS3lYRndWMm56TTM3elQ4RHpOR3JNam5O?=
 =?utf-8?B?RmVDdkh1ZVliYWdzdHRIZXgzR0tkanRBUTU5SHZ0ZFFaZmo4K2NocWZsbHBG?=
 =?utf-8?B?M1FTZ3Z1SGUwY2pRWUdWM0czMkJsWGRZQTZlSGJEd3YrMlNSU2plalE3amI5?=
 =?utf-8?B?Z1RDNVZNbzFybVVsQ3JLbWhYWENOdVdTVHBoYndjUXpGWE9NYU00enVpQi9K?=
 =?utf-8?B?eXoxNVAwWDdjWjhzaDU2N2ExUkIvT09Ib0J1b2ROaWZJRXR5WHlObFUxS3dS?=
 =?utf-8?B?RURGclRxZExYeEdNL2xwT1JVSDVBbVJqN0Q2YjEzVmt1QURJMk9MN3M1N01Y?=
 =?utf-8?B?VzYxdUpMT3hlb3Z2K2ZQN3VRVm4rNmo4dENVOXc2VzRGVnVmSjMwQVBjVUtw?=
 =?utf-8?B?Wko4dW9YSWNuamN6emZvYU5YTm1FS0l1TUZsK1JQN2N2NCtCRHk2a3o0T3hi?=
 =?utf-8?B?WDI3K3hzZlFwa09QMnBqY25yOHhnaythLytHZXZmUHBjL0tBOXhaVVRpWWhH?=
 =?utf-8?B?YzdoaVRmSzZ6Q2ZuR2p6NjRZbDI5MG50UlN4bk1OQ1p6bmIwaTIrNnJtTDlT?=
 =?utf-8?B?aGxKaWdTWklmdCtiNkRFRmgxdWsrNnFiN0JCbUlqMlFDSU00VXUxOFpDNkZk?=
 =?utf-8?B?ajAvcStscWRlRWtWamE5S3dCUnBiOG02Q25YTXJuUVpEdkl4OHJhWk11eUhx?=
 =?utf-8?B?R1hvcXhhZ3NTbjB4dnN2Q0VnZ3NJbVJQcGJuQzdnUG8vcFlINUU5NVFFV29E?=
 =?utf-8?Q?asqlSjJg0ynC0ytwG4t20daF3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce0c6a2-fbb3-467a-8f2b-08dc6aaa4569
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:17:52.2866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GueVqlV1mAwSy8RZP4AM6lgVEj57zqpDRW1C0hiZoJ52My9cglvoCIltNkSjPwhqgVDi0nMNzbcewmri1e85Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588

On 5/1/24 18:57, Jacob Xu wrote:
> General question on VMPCKs: the secrets page defines them listed all
> together one at a time, does that mean any guest at any VMPL can
> observe all the VMPCKs? Or is SVSM running at VMPL0 supposed to clear
> VMPCK0 before it hands off control to edk2?

The SVSM should clear VMPCK0 in the copy of the secrets page provided to 
the guest BIOS/OS.

Thanks,
Tom

> 
> 
> On Wed, Apr 24, 2024 at 8:59 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> Currently, the sev-guest driver uses the vmpck-0 key by default. When an
>> SVSM is present the kernel is running at a VMPL other than 0 and the
>> vmpck-0 key is no longer available. If a specific vmpck key has not be
>> requested by the user via the vmpck_id module parameter, choose the vmpck
>> key based on the active VMPL level.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/include/asm/sev.h              |  2 ++
>>   arch/x86/kernel/sev.c                   |  6 ++++++
>>   drivers/virt/coco/sev-guest/sev-guest.c | 10 +++++++---
>>   3 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index a7312b936d16..64fcadd6d602 100644
>> --- a/arch/x86/include/asm/sev.h
>> +++ b/arch/x86/include/asm/sev.h
>> @@ -307,6 +307,7 @@ u64 snp_get_unsupported_features(u64 status);
>>   u64 sev_get_status(void);
>>   void sev_show_status(void);
>>   void snp_remap_svsm_ca(void);
>> +int snp_get_vmpl(void);
>>   #else
>>   static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>>   static inline void sev_es_ist_exit(void) { }
>> @@ -337,6 +338,7 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
>>   static inline u64 sev_get_status(void) { return 0; }
>>   static inline void sev_show_status(void) { }
>>   static inline void snp_remap_svsm_ca(void) { }
>> +static inline int snp_get_vmpl(void) { return 0; }
>>   #endif
>>
>>   #ifdef CONFIG_KVM_AMD_SEV
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 8edf7362136b..75f11da867a3 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -2454,6 +2454,12 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
>>   }
>>   EXPORT_SYMBOL_GPL(snp_issue_guest_request);
>>
>> +int snp_get_vmpl(void)
>> +{
>> +       return vmpl;
>> +}
>> +EXPORT_SYMBOL_GPL(snp_get_vmpl);
>> +
>>   static struct platform_device sev_guest_device = {
>>          .name           = "sev-guest",
>>          .id             = -1,
>> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
>> index 04a7bd1e4314..e7dd7df86427 100644
>> --- a/drivers/virt/coco/sev-guest/sev-guest.c
>> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
>> @@ -2,7 +2,7 @@
>>   /*
>>    * AMD Secure Encrypted Virtualization (SEV) guest driver interface
>>    *
>> - * Copyright (C) 2021 Advanced Micro Devices, Inc.
>> + * Copyright (C) 2021-2024 Advanced Micro Devices, Inc.
>>    *
>>    * Author: Brijesh Singh <brijesh.singh@amd.com>
>>    */
>> @@ -70,8 +70,8 @@ struct snp_guest_dev {
>>          u8 *vmpck;
>>   };
>>
>> -static u32 vmpck_id;
>> -module_param(vmpck_id, uint, 0444);
>> +static int vmpck_id = -1;
>> +module_param(vmpck_id, int, 0444);
>>   MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
>>
>>   /* Mutex to serialize the shared buffer access and command handling. */
>> @@ -923,6 +923,10 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>>          if (!snp_dev)
>>                  goto e_unmap;
>>
>> +       /* Adjust the default VMPCK key based on the executing VMPL level */
>> +       if (vmpck_id == -1)
>> +               vmpck_id = snp_get_vmpl();
>> +
>>          ret = -EINVAL;
>>          snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
>>          if (!snp_dev->vmpck) {
>> --
>> 2.43.2
>>
>> --
>> Svsm-devel mailing list
>> Svsm-devel@coconut-svsm.dev
>> https://mail.8bytes.org/cgi-bin/mailman/listinfo/svsm-devel

