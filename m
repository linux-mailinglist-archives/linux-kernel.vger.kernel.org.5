Return-Path: <linux-kernel+bounces-153552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F228ACF85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7783D1F21D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDD8152192;
	Mon, 22 Apr 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NZocnFUL"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA61514EC;
	Mon, 22 Apr 2024 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796452; cv=fail; b=Ebr7MDKvC9iu85IgZ2K2NoSXLi94N2wMgt5hEFbl25rPHwOyrNy0K1orNT+YO0BUrkrfUbYjT1SZ00uRWoC83fByq/cEKk8BKL4HaGb0oY+zlofUs7ax58eeK1XbQoe6dnsIsg3+qnMMYPwHTRflhaahh4rd4MNAhShsaDhJzTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796452; c=relaxed/simple;
	bh=1HKJYIJRKRXWEnyBrtaL0U6Y98yumc3x8uEaxQ5Mr5A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BmuFXQDt4tNF/p0NIvIZgbZwmdroKFPHbrsHcFPlICNjMKytu8XxXk5Hq8pz5UarPi0PW6rm1oSiO0fRmFRgm9CzQWP0EQwN9Hv7ceCSlO6FHXZNNcSDycMUGn9V/D/Ksja+KJkKXaPIa9qDGI10Ks8x3xTynGuhH4EZePRzYVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NZocnFUL; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGlDWhWn2wnnuA8fS29FVRT5mNjNchVSp0l4JLzGDkX5r5WQphKhGMcdvHGwiWnTlsz07WT/t0O7yVZmKNatRfG3JL42iEJ9hYXJNyjVGFN25tgyH0nbYxxGxN7hJgkcNt7gnOXWA70cQ0eEiC4G2H1FmRWjGEJsc5K4/PwO1JW7psGvg9AZCBZl+XNnGzGCqLoewUV7isMXV/hwGbb86EP3xzxLhZx/1oJwILlPptA5orv6bWsnzUXsiIwR1Cf05ffhyE317UrrcVvnCCfakrrzND2ZjvMssyTAcTu+V8jPMTAxm7FLBQbUfXfEAAF5qPx+d1lNT9GSo6eAbp4JrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2bEJapc1BqzGI5bsSqfBI8qODv/FhGdwKZvNo6fqCo=;
 b=SviSd3M9ha6X6HbqZt3QUMRFLfA7IvaYTN+GAknd+znk/cBvj+7wcKodlEjUmjcXCsLfHd7bSDFf/68kXsytvDQASN9zqyN1TIMHM/lwTR3EaAzH5ffsbtNYgKHmpocgzzZu+N5RpUpkyv6NKR51OBNBUxucleReiPRACK8wqztSXBXGx4l+UuoNF2T17ocTkwQ5UPt0NuRrPLUb4XoPliVs0Ttl/cHcxGAiapMGNwA7s4NRbT3VH/EMX0qhoHd3jzkpOQtjWhXpf8ztDWWmDGV27sAsEJTn97N0rJL1HdqCGbqqSATHPqSif+IdbfoPOU/s7Df9xFtMEB35z84VbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2bEJapc1BqzGI5bsSqfBI8qODv/FhGdwKZvNo6fqCo=;
 b=NZocnFULHPMrareH2it7Wv7ib4o9mdcE1ArmJ8RHWqMgkxzBPoZ/X9gCqz9ydP17F6wg5JbGLWvW01GVhCl+M/FINE3DucVkwChEO4kUqRtuqqPFVkBT8G8gDtXxDuWom7ncBrX+A51M3HVpyQjIh/3L6VscMEZ/Wf3ikrBvAnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 14:34:07 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:34:07 +0000
Message-ID: <84eb39a1-60dd-40cb-8c7c-dfd9a988732d@amd.com>
Date: Mon, 22 Apr 2024 09:34:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] PCI/RCEC: Introduce pcie_walk_rcec_all()
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Li Ming <ming4.li@intel.com>,
 rrichter@amd.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-2-ming4.li@intel.com>
 <d69c2157-a0da-4d8c-8684-d42afd285191@amd.com>
 <661e00eb808e4_4d56129429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <661e00eb808e4_4d56129429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0113.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::27) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: df033453-a221-4fe2-3f18-08dc62d94433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkpjR3RDSzdyRHBZUlQyaG9tSm42TW5pWkdpSGdCOW1IYm1PRFlzK3Q1NkJ1?=
 =?utf-8?B?elQ5a3ZXNTY5V29vRldLVW43TU0wSTh6ZHBlY3ZOQys0WVZSai9tR2M5N2ZV?=
 =?utf-8?B?M2VQMTU2clN4Y2h6VnlVdFg5RTdDTzZvdUEvaGFIdXZGRGxIdzNKTU1ucVRn?=
 =?utf-8?B?ZkVNaE4rbnlFUXprZldnYzIzalpiOXVhN29CRGNnbHJTMS91dWI2YTE1L1hF?=
 =?utf-8?B?N2lFL2x1ZmxBUEZ4YUZuMG53OUV6RFJnY245NjJ3dmk2MkgzQjNJa21QT1hU?=
 =?utf-8?B?b2dxVTBtcXdsaVFBOHdiUlE2SmoyLy9Bb3ZGUHFvQzl6TFBWM3FONlRveW95?=
 =?utf-8?B?emlSdkUwSmpCYVBvK0lWeFRlamhQaDVPeDAyWmQ2bW5UYldLeklqaUxDWWli?=
 =?utf-8?B?c3U4UEU1VWdDZ1JFTGN2TkdyZlM0ckswR2xBZEVuVThOYlFtNXZUZFFFSEdy?=
 =?utf-8?B?ZUw5V2VyYy9VMG42SzI5ZzNGUFFJUFBCZlZ3QUE0SERBdmRYVTlxa2h0elZG?=
 =?utf-8?B?ekcwVndaSUpiZWpCYVU0OXZjOTdSNE05RWZlYXI5NEZoaVVpVzIwTk1hSUZF?=
 =?utf-8?B?RmJFc1FZSno4WHVtRWJTYlJsbzFTTEFxVmFlUkRIK0JId0cwWGFweEJXdE43?=
 =?utf-8?B?QSthMzFxVC82S01VMnhsT1RGRW5rekliL2ZxckNIdFF3MFFnMHhobXB0Mmc4?=
 =?utf-8?B?SkJGaU5wUWJNSExuSlZBWmpQa0FwUmRvQ3BVM08rbGFiemt5cktETm1MQzB3?=
 =?utf-8?B?SjQrdVM1VUZnQzB2c2kwTnp6YUxjYkdUMlV2dzBoZ1Uzdk91M3E0SXJ0c2NJ?=
 =?utf-8?B?QUhZUTFTekdVbWdnR1FsbzRYNUI0NTlOSEc1OVI2MTc1aThlejhUcTNZSGgr?=
 =?utf-8?B?NTFvTmlaRml2Q2NvNGpKT3BvZjFyVzArRHlNRE15TEo4RkU0U2lNR1ZCOXRM?=
 =?utf-8?B?aDJ1MFNyYlVka2F0RWRuSjJvRzY3WHZ2cFdvVVE3S3RRSjdRdWJ0SllPNDdW?=
 =?utf-8?B?QnZFNFUrTDZSczhnOGxORE5GbVFXSjJuYVpiMEFnbC9HMHcwWGN6Wlo0dTZK?=
 =?utf-8?B?c2hSdmpFRFcyclVvQVJJcCtsSW9US1lEWnZ5eGIydEpBWnBhYWVRNVhsS3Q0?=
 =?utf-8?B?cWp0d1UrYmovUXA0MGQ3YXNqYXVjMXRoTDFuUFpiUDdzd0tNSHVIbWFRN2RL?=
 =?utf-8?B?ZnJKK3p5NWZFdjJ5cnRFM1dOTUlJNUpSbkUxNjhwRFd0eE1pNjJTZnl0eWhs?=
 =?utf-8?B?cmlWN2JaYTltK3c3Vjh5RUFGZ012TkhYM2FiUDlPdHFTeEkzcEZxYll5Wk8z?=
 =?utf-8?B?M0xjNVhPMTk5cUlaVzZkQWpjM0VpVHdzeDRKdVh4STY4d1NTNldmYWVleWRx?=
 =?utf-8?B?RkFDL01ncjFIVWQveTlROFFvWHhmcHNwdGxocXpMRjlxYXg4V0phR2duRklE?=
 =?utf-8?B?UXZVbTIwczY2NDN3TStNVWZxTnk0cnVicjY2ZUhZeVlNVUE2R1Y4dHFIN05z?=
 =?utf-8?B?TnJZUEdiemp5TUNpVDNjUTY1Q1NWUEdxc2ZGaEQrdzBBWkdHU1VEbWdYMmpS?=
 =?utf-8?B?TWd4WjVSMFVyOHl1d3BZMmFBRERxU0FZK0NERXk4Yi9oSlNsWk0yaUpaWU1t?=
 =?utf-8?B?WVZwTnpSSlBzOHJtMUplaE5rSVRIWkxVdnZ6eWdoWGVGQTFTWWpoa2V1N21q?=
 =?utf-8?B?NVNKdVlWZVdzMXo2VGdNUXQzU29nUld2em85MGVqRFNyNHBDTDc4ejdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWZNakpyamxEOTZwc2gxRTMydEhmTHVJaUJDWk9XdzhvK0YvZUw0TVFIK0Fu?=
 =?utf-8?B?ekc1S1Y2Z2haWHlUb2VXM3QzUlBMYUlCVkpDR3FHaXVoYnN6akdZZzRVdFAy?=
 =?utf-8?B?Sys2WmtkT0RySWhmSEQ3ckgzMTkzb1hlNWdZSzRXSEhiUkoreGhwN0xpNHUv?=
 =?utf-8?B?dFFydXNPdjkxZi9mTGlKT0tLT1pSYVdMMUYzV0VPRVI4T25wSDB1TnYzYVMw?=
 =?utf-8?B?STZFWE0rbzJyUUhVUGdpaUdVR0U2RUdscG1MU3gwby9VSGFuTi9hdnVOLy9Y?=
 =?utf-8?B?TlRCOTVZK0I5T1gwMkxjT1gzcjdXeHBpbUk0bUFXcGxFbHFTcFdTekJXYXQy?=
 =?utf-8?B?QWQ3ZGRCOGNBR1BhY2ZTMldiekdpV3pQcTZJTGdNRFd2WHYxOWpUY0grRnVv?=
 =?utf-8?B?d2JSVWVmY01JRnRkMytZTVdJaVVTckQrQU02bGhhTWE0MjdiL0lHZnNDSDRa?=
 =?utf-8?B?R00yUWNZbkR0V2EyY3JYUWF5Yk1kNnNQcTdlU3dRY1pDUWdaVGZXRG16RlMx?=
 =?utf-8?B?UzhOb0lsOXRXVU1YZkpuQUtvWCtPUFQybW0vWllLWmVZUDI4bXNRbTloSHhI?=
 =?utf-8?B?TER1bXNpVmlnTktDQWJuSCtGU3VENXA3cWpLanV4aG9uMWdmeEdFaURoYklM?=
 =?utf-8?B?ZEtEdFdhOUQzZHdlZUNNaDl4T2p1MUF5SVlkcGdMMWtlWHJjL2xjUWcvVm5G?=
 =?utf-8?B?TW9uYnJ3V2lKc1E0akNpUXZaaTVxZCtWWk9kdjl5b0dTTDBQem9KaVk3S0hk?=
 =?utf-8?B?dFZtVDkrcEhsOGo4eElwOUpINndBOFA2bDUrTVlId2ZuNHZvSjBaSVlCKzJu?=
 =?utf-8?B?Tkk1cytVNXBPRm9nT21DNitMR0dYRUFuZ2JWdFhpOE1uRHUxOXBnR3d3WktE?=
 =?utf-8?B?T1VzQzFDYVd5MURsQks1czhhQnRMSXk3VnRLUFVTVHJMaGtyWHAyODJjQ0Yz?=
 =?utf-8?B?Ty96czBUMm5xcUdZUHJqL2tVUUt1aW5UMEF0OXZPd1VqczJna0pxSnZwMnEz?=
 =?utf-8?B?WnJPYitaZnJyY3VzZEtLWWw1aGhad1Y5NmNOTXdmSFR5WWZGTkJqUDdoWVZp?=
 =?utf-8?B?ZHpPWHVPdUFvSkRPM2NON1BGL1FIWWtEbXJ3YTVjUC9RbzZnbDNpWUYvaXkr?=
 =?utf-8?B?eVZQQXNpaCtHQW1HQ1Jxc3BsMUtEUExVQlJ6THVHMXQrWEZ4d1VkaU9OS3Mr?=
 =?utf-8?B?bjRZSjdkTEhYL3RxTXovN0w0dktmMFZTKzlSeW9LV21JUE9PTjJOTjZ3Q01H?=
 =?utf-8?B?VXM0aTBqd2dNZkNvQ1VGaGFwaGVMYjA0K3kreHpiR1crV01tRFpFam1yMVJT?=
 =?utf-8?B?Mm9HbloydlZXSkhyRWZwODIwb09CSWloZ3hXa3Y5NG9KTm5OWTJiQ2JYVUNY?=
 =?utf-8?B?SXBjTDBEb3E4MFpkS3p3MVQ4eXBIRllqcXE2SU5mcnFvWkRSWm5HTE9HOU9P?=
 =?utf-8?B?eUNzaExMYXdrS2tTSFR2bldGTElvOEs5MmY5ZGsra0k5Z1BwM0Z3cUZZUGcv?=
 =?utf-8?B?N1JyRVR6VFRTV0xoUVVNWmhCNTRWZGtiQWkzN2hQdHV4Y0VmTFd2bllGZG9P?=
 =?utf-8?B?WVAweldTQjZNSFZmU3BQaHh0eTNpVFZINlZoVnl3cUhIcjFoVUlvTFYwMnJS?=
 =?utf-8?B?aUc5cVF3OEVMWWVRSDVIRzBsZ0pDZlY5aHdWTUVvY0ZSb2UzaGZxZExEV3lp?=
 =?utf-8?B?cW9sTFJoa3JmbExxQ0VYRnpySi8wVzdBQ0dFUW8wZHAyVW1SaFZFMTNUenIw?=
 =?utf-8?B?d3JnQXhMTDR0UnRyV2EvdlViY0RwdDRmcVZtZ1ZBcmwycWt2UlIrS1BESktp?=
 =?utf-8?B?MEFxZGtqa1lqa0NEb2NwVmxSOWZnemJiMVFZbGVCb0F5bVppcVc0SUJJb3JE?=
 =?utf-8?B?NTBYcHhxNEF0N3hHVE5yanhsRTloSTRneFcwU1UwT3d5TFkraGtmTWNUK3Jl?=
 =?utf-8?B?N0huTm1IdkpUbXpPdytHKzh4NVgyYU5wNHhGdzlVbjF1MFJ5ait5ZWZtdjcx?=
 =?utf-8?B?WXN0Y2dVSWQ4UE9hUGtnUlF6alJTb201Mm1GV09HalRUTXpNYVZsd3NXOEt1?=
 =?utf-8?B?ZGNCOUllckJyd1h3aVJqYzI1YjhBbjIxMUxncWFhaEc2aytKODhxWEdweTU3?=
 =?utf-8?Q?4LNYHPMETr5TjFC62K8QORqP5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df033453-a221-4fe2-3f18-08dc62d94433
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:34:07.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAmIQ4WtgXjV+JS04h+Km4Ottsz6qEz/FedPQu4D8bubNwERv3WptgUF4d3+eIOGCxih8iTyTxmZ8LDeF26xUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743

Hi Dan,

On 4/15/24 23:39, Dan Williams wrote:
> Terry Bowman wrote:
>> Hi Li,
>>
>> I added comments below.
>>
>> On 3/13/24 03:35, Li Ming wrote:
>>> PCIe RCEC core only provides pcie_walk_rcec() to walk all RCiEP devices
>>> associating with RCEC, but CXL subsystem needs a helper function which
>>> can walk all devices in RCEC associated bus range other than RCiEPs for
>>> below RAS error case.
>>>
>>> CXL r3.1 section 12.2.2 mentions that the CXL.cachemem protocol errors
>>> detected by a CXL root port could be logged in RCEC AER Extended
>>> Capability. The recommendation solution from CXL r3.1 section 9.18.1.5
>>> is:
>>>
>>> 	"Probe all CXL Downstream Ports and determine whether they have
>>> 	logged an error in the CXL.io or CXL.cachemem status registers."
>>>
>>> The new helper function called pcie_walk_rcec_all(), CXL RAS error
>>> handler can use it to locate all CXL root ports or CXL devices in RCEC
>>> associated bus range.
>>
>> The RCEC-root port relation you mention is new to me. Typically, not in 
>> all cases, RCH-RCD has a RCEC. And a VH mode system has a root port 
>> instead. The RCH RCEC and VH root port are both bound to the PCIeport 
>> bus driver that supports handling and logging AER. This allows the PCIe 
>> port bus driver to handle AER in a RCEC and root port AER using the same 
>> procedure and accesses to the AER capability registers. 
>>
>> This is oversimplified but are you looking to handle root port AER error 
>> in the RCEC from the below diagram? 
>>
>> RCEC <--> CXL root port (bridge) <--> Endpoint
>>
>>>
>>> Signed-off-by: Li Ming <ming4.li@intel.com>
>>> ---
>>>  drivers/pci/pci.h       |  6 ++++++
>>>  drivers/pci/pcie/rcec.c | 44 +++++++++++++++++++++++++++++++++++++++--
>>>  2 files changed, 48 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index 5ecbcf041179..a068f2d7dd28 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -444,6 +444,9 @@ void pcie_link_rcec(struct pci_dev *rcec);
>>>  void pcie_walk_rcec(struct pci_dev *rcec,
>>>  		    int (*cb)(struct pci_dev *, void *),
>>>  		    void *userdata);
>>> +void pcie_walk_rcec_all(struct pci_dev *rcec,
>>> +			int (*cb)(struct pci_dev *, void *),
>>> +			void *userdata);
>>>  #else
>>>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>>>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
>>> @@ -451,6 +454,9 @@ static inline void pcie_link_rcec(struct pci_dev *rcec) { }
>>>  static inline void pcie_walk_rcec(struct pci_dev *rcec,
>>>  				  int (*cb)(struct pci_dev *, void *),
>>>  				  void *userdata) { }
>>> +static inline void pcie_walk_rcec_all(struct pci_dev *rcec,
>>> +				      int (*cb)(struct pci_dev *, void *),
>>> +				      void *userdata) { }
>>>  #endif
>>>  
>>>  #ifdef CONFIG_PCI_ATS
>>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>>> index d0bcd141ac9c..189de280660c 100644
>>> --- a/drivers/pci/pcie/rcec.c
>>> +++ b/drivers/pci/pcie/rcec.c
>>> @@ -65,6 +65,15 @@ static int walk_rcec_helper(struct pci_dev *dev, void *data)
>>>  	return 0;
>>>  }
>>>  
>>> +static int walk_rcec_all_helper(struct pci_dev *dev, void *data)
>>> +{
>>> +	struct walk_rcec_data *rcec_data = data;
>>> +
>>> +	rcec_data->user_callback(dev, rcec_data->user_data);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
>>>  		      void *userdata)
>>>  {
>>> @@ -83,7 +92,7 @@ static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
>>>  	nextbusn = rcec->rcec_ea->nextbusn;
>>>  	lastbusn = rcec->rcec_ea->lastbusn;
>>>  
>>> -	/* All RCiEP devices are on the same bus as the RCEC */
>>> +	/* All devices are on the same bus as the RCEC */
>>
>> RCiEPs are not guaranteed to be on same bus as RCEC. Details for associated 
>> next and last busses:
>>
>> "This register does not indicate association between an Event Collector and 
>> any Function on the same Bus Number as the Event Collector itself, however 
>> it is permitted for the Association Bus Range to include the Bus Number of 
>> the Root Complex Event Collector."[1]
>>
>> [1] PCI Spec 6.0 - RCEC Associated Bus Numbers Register 9Ofset 08h)
> 
> Hi Terry,
> 
> This patchset is responding to the implications of the implementation
> note in 9.18.1.5 RCEC Downstream Port Association Structure (RDPAS).
> That says that CXL.io and CXL.cachemem errors in Root Ports may indeed
> be signaled to an RCEC. Do you expect that implementation note to cause
> any issues on platforms that do not follow that CXL spec behavior?
> 
> My expectation is that it may just cause extra polling for errors, but
> not cause any harm.

AMD platforms in RCH/RCD mode consume protocol errors in the RCEC's AER driver. AMD 
platforms in VH mode consume protocol errors (including root port errors) in the 
root port's AER driver. The exception is the VH mode host with CXL1.1 endpoint and 
RCH downstream errors. CXL1.1 endpoint and RCH downstream errors in a VH host are 
consumed in the RCEC.

I don't believe these patchset changes would affect this behavior. But, I will need 
to test to confirm.

Regards,
Terry



