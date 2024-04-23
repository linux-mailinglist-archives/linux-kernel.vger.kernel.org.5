Return-Path: <linux-kernel+bounces-155812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AF68AF777
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A95B22AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768441420B6;
	Tue, 23 Apr 2024 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZjHJl1hT"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF213D532;
	Tue, 23 Apr 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901250; cv=fail; b=rrJHeAKDcfZApbGPgMLg/9eQ7luNMzuK9KWbils/Wpz5RK/yw1QhtEPGuEJbuRpNFYkKatFgF9N2UHH9Gk6IKW/PiPUjDsOYl5UHeYuRsi8x1G+oXL/8g6N6jqRQgrSjaLsYHqjbC8MNNaWkUd/XVhFI01ao03xkbiS0FxFWO4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901250; c=relaxed/simple;
	bh=H6KKoRn7LduTrGVrZSMn0nL9AXeqmlOWiy0i1uG4x58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IjFq4dKHDfUZ/D8IHQpSHb3F79/CygseGVD6aAtMdtqSHcQHDfD+jHvt+XeFQYHjWX4119imsaz3sYXAGd9y/+Fge9v9wPCSRednArcz87yR0cNJmpS2G8u7yP9GovN6mfuSQWngNVQVbE1Y1mavX38+cxRoNDfoxenZm1DzNk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZjHJl1hT; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq5n4uioLNW5GRXwX/+9dn5dwoML/PJxSToRhIUJ0QBWLBKfmHK0rjx6oB9fyEUQqUmHu4b2VR+KpPM+Mrz4JuhBuKoJyYhzyEZB2g0c48zOJVfg6hnsFdo4tAObfP2lm88FDPkupBefjGFB55jDyxl0XUaQ1sqfb6RB0e7qjBoUfLwfp6Ms8w7mJ+gLG5F4+JSgPHuSuS7c++Syp14e3X/dfOFH6MhGPwc4i78rG6WEnvUz6D1RlB//k3J+KSDS4EzlfUqjxSAX4KsXcwFU+PT0f4SSnR0/RaPgCFyTPVKW0CNIIE2/Guvc/dytisbIFyUXlc5hqq+3vBGRb6z36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/Dc+hC4kWuccSWIgg9zcf7rwMNkxcY3/x+ATqmp120=;
 b=Ef8u9l+IlhsajhKkbyC4VywoIJltfMLMc8O2Pd7bsF9wXK9lV5UCVn/uIvvyTrnBMT2X0fa3EJLKn9VHLO3WDZrU58XMFztZMj/xy9gFUIK2arJDDaVplenoHyMtX6oMDxbMu8L+7et7p1J1lqg0s0okj8trrQbq/JdDNyn5FHS4cBymBAUtgePMa4KTdnm+MOQ27pQLDlTbwXzU0Du+db1v9b+Q5h+KgqGzQJ5nRIBmKKZ+ydcqh4mhBOz5bz9UkX9qbdy7Gc8FdUuLiRE7tpB1Uo+IXh5gjl+jAfa0ccXIUjdTJ6ZzSzX5YpRpK666tmH6sVUQLVnKiM3zHUVlLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/Dc+hC4kWuccSWIgg9zcf7rwMNkxcY3/x+ATqmp120=;
 b=ZjHJl1hTmZDcO8KbbNpnl96PmF5oKtxYqHLSKaRTFfn0/5RpzpHVkRq6CxYuOjLu/l/XZHsyuvUZ2+FgCArthG5fUFIO0SlVIVT9ziZ9H8x4B/HDa+7pfCYSExjwaNHkBQVxxFDeHcsDnOoj50rTRrIsUMHk1oSMi31FQEmIdK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 19:40:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 19:40:44 +0000
Message-ID: <08742373-ca86-47e5-ab6c-e2e3189eb9fe@amd.com>
Date: Tue, 23 Apr 2024 14:40:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: PM: s2idle: Evaluate all Low-Power S0 Idle _DSM
 functions
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Mark Pearson <mpearson@lenovo.com>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <12427214.O9o76ZdvQC@kreacher>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <12427214.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:20::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: a392e9b6-2f5b-43d8-87ec-08dc63cd4432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1p4Y2hvaTNGNEhWVkdwMGVjN1RpWjVHeStPQ2VDNmd3Q1ptZC9uUklCcGw1?=
 =?utf-8?B?cEVFeC9HNnJFSDNMaGZHcTZ0dG1pWUptclA1RkNQU1loWU5TZTI2d0pzL1dM?=
 =?utf-8?B?Ui9sZGtpVExlT3lLTFQ5K2l0U0ZCWXZPWXdrWFhiK24yS3NSWGRVMGxYeWFp?=
 =?utf-8?B?Q0kzd1F5QVNWTUJxaWdKSkhUckhBN0FDcG1JQnptRkdDUEw2WFlnOGJOOE1n?=
 =?utf-8?B?RkQwM2YxL3NhbG5QSHJPL092Q2pXdmNQSlBMMkVOYU5Vall5S21hanVqL1NG?=
 =?utf-8?B?ZGlHRUNidWhvMzFLVVFsQ0VYemliM1g2clpNZ1JXSFQvUUU2bjY0U0NhSzk0?=
 =?utf-8?B?RmJXbnVxTzB3MmRldnAwYU9nSUY0WlJ3Q0doU2d6VDRCRnNVZHJEN3UxenJw?=
 =?utf-8?B?T3YycnZPcDU2THBnR20xejFJZVgxdTJZd2gxcDJYUlAzQ3FEMVJieUo1b0x1?=
 =?utf-8?B?WWJyVVB3MXB2b3pwNDY2Q25sNEZOcUh4QnhGQm0wVkJ3N3hPdkdtQ0c0K2Rp?=
 =?utf-8?B?TS9UU2tQRlRTeWM5RHpBKy8zcjIyRGRJaDUrT3JGL0tpekE3aXR3WFVwVnRP?=
 =?utf-8?B?bnN4L3Fnais5SDg0SDRwVVp6NlhHdExMT1NMSlRFTnpSL3RnaGgvTW5ZRnAz?=
 =?utf-8?B?ODJ0dWRkWkpDbWJ6SVVKYU5rNEZWU2RDWDFSU1lQMWlsVHNaRGdQdW1VT3hE?=
 =?utf-8?B?SktYdW5WbnZlSFFWUmNsY3VLSFRzQjZYSDNkMWdwa1hJNVRrN1FrK29VYUJk?=
 =?utf-8?B?WmpvUktmU3RuYm1CUlROdmxZNXJDTFp2TTV0Y3IrRjNDT08wbjZDOG03Vmkr?=
 =?utf-8?B?MWZ4ZE12MU5KL0gwMFE3d3EydHM3YjNmMmdhTTFXZWZGcVBhMnhHRFR5Z1BH?=
 =?utf-8?B?cVdyMG13Vmg3MGo2K0dvR3piVFNmV21nR1UreVJTcDdnaVdyWCtqNzBXZUxz?=
 =?utf-8?B?cFVEZVBWWURSQ0lac3MxaVZNRys0dnBmNWJiTmJPSlJJeXkzQ0FWSVlobjhU?=
 =?utf-8?B?SDZudEZaNmdYRHcwMGJXQUM1S3ZnVnFvZU5zaW9rTzRsZ1pYa0JSbkwvQnpT?=
 =?utf-8?B?UFQ5MGFneFd1NUFHbm41TU5XQllYeTVOMGhpQ2ZwVW5BelBZNG9XQjBCeUts?=
 =?utf-8?B?ME1rcXRaM1dMOVBtR3ZBNjU4bEpFNUxwTWF6M2JHM1M4NzJlQTJnTW1lMVVO?=
 =?utf-8?B?RlBqd2ViWjZsS0srNnN1eGloVHRkdUs0Nytaakx1UXE0QmNmTXExb3JMSHdB?=
 =?utf-8?B?R0pETytvVW93MzUxOHlNQlR3cko1VDEvRDk5eS9SblU0N1JVZk5UWEFOd2Vh?=
 =?utf-8?B?V08xS0k2eGpBTUNndnptU1phakE3R0dQZ1RHMUJPcFNqbi84eGhVQW1WTWhF?=
 =?utf-8?B?SGpseXN6bUdJdTh4Mkk0MzF6VEUxQXA3SUtvbURhcG1oTkY1VDhVTFpnZXlI?=
 =?utf-8?B?YVZSWTJTUHRRMUJXaSsvc01kT2JmNzlhdnlYVDFCWWtxZzJzQWJ4SnNDUVVj?=
 =?utf-8?B?MmFFemlkdlVFRzlraXBSN2ZuS3c5dVFQalR5bXk0SzFDLzRxcVVtZE1sUy81?=
 =?utf-8?B?RUhOZ3N6aHo4Z0VzRVMxaTlWcVRRNFVDNFV4eG9CKy9BdkxydTdvSzYrNDVJ?=
 =?utf-8?Q?Q6DTGfIl9Fvc+XIXdwK/J7KyfDVSudPVU/Fm2ghhL+p4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEtpbVB3ZkVOM3k0RDBWVzRmcHZac3AzQ1Z4TWp2MUtOZWVVaXlhL1ZhbHh2?=
 =?utf-8?B?NWw4ekt3RHFlR1FGS3V1VnB2cUZtcUI2amdiaEYxN3NmSTFIb0dNTk02NGV6?=
 =?utf-8?B?M3p5clZHT2JpMmNsd0lsazVkSVgzNEFtUEdYZ08vc1BpU1Fmb0RJd1JzeURN?=
 =?utf-8?B?QkdSbFlNQmUrY2lKeFI2anRRL2JYL2dJV2lraHliM3NwTSs5V2hpT0w2UU9t?=
 =?utf-8?B?WjBITWFHZ0ZLSXhXVm8yT2ZJYXIrSldkRkxLdXh2SHk4R1pSb1A5RVVOOFdJ?=
 =?utf-8?B?Qkw1cFJ6RXJWay9ZU281QlYyY3loK0g0RmV3MXljcGZhN0hIa1lvWFlwbkxs?=
 =?utf-8?B?ZEVQMnd0aEhpOWc0TVREdnFuL2c3RlFjVTcrWXh6THRkb3NJVU5kQXF3Smh1?=
 =?utf-8?B?d1NwaS9HRjJiWUpHWHNlWVFZVW4rUXI2TFExd2plL3hzZTdZem1XOXZ4TnpH?=
 =?utf-8?B?cTBiZytBeUVVY21uc0RCckhacW9MQlcreEZHNWpVL2hkTXJweElwNHBIbUo5?=
 =?utf-8?B?QXlTd05BNkVzb2RuUDI3bU05aThZaDduWXB5RENqYmVmV2RpNjlJSjJweHZw?=
 =?utf-8?B?Zm5XY0JXRXpZbWIxaVJNRWw0RlBKYTUwZGc3Ym5NdGZxRmRrelhHaEtwNUVZ?=
 =?utf-8?B?Mm00eWs3MmtONlI5SEU1UkRJV1dReFNBcW9pdnUrWU4vT1dHTDBlb2w0QlBw?=
 =?utf-8?B?YU9JYW9lYlZwQXlUWVUvM09hdzVFSzh2a3N6SzlPazhxenlSUk55S1hpTFB1?=
 =?utf-8?B?Wi8rNHR2NitpbVFuaWlLN0JHQS9OSzFZdHh6NGt1WXI2RlJpaXFCQ3AxMmFV?=
 =?utf-8?B?Q1RKdWI1QTNJQURKdVFETGFlbGNlczdDcEtVcUZnQWg2UDdoR3ZtcFlrMmFI?=
 =?utf-8?B?bEJzVWp2enQ5cGhOWVoyclpDYkZ2aFYzSXVTdzg3Zmh5d1I0K1dnMDRaSmpM?=
 =?utf-8?B?dERHN1hsVFc1ZENzUVNtUER4VC9odzl4Q1FaOUhSdUlTcndRTFIzTTNoVjJk?=
 =?utf-8?B?SG1LMVErM292aUJZSSt5R0o3L2VqcG5paDlBUEZuQ3dzcVlBS1ZMMjY1bGtq?=
 =?utf-8?B?SFovZjdWNHl5aE95Y0pSbEhKNktEbUd1MDBQeTlQSjlSb3I3eldGZjhmY2pJ?=
 =?utf-8?B?VWdUSENhL2kxQkhEcGloM0E5WnI5NkxiNVdtdFdadlV1eStZK2RDTTh5L2sv?=
 =?utf-8?B?SGNXLzZoK2lOZyt4enNIaG1FbzNuRmNjd25KYkV6N1ozOHFPMU9XSlJyUXJN?=
 =?utf-8?B?YXJPNXFoM3JLN20xNlNvRG1uajRMUUxGQ1dDOWt2dXJKOHZxc2x3d2w1Yk40?=
 =?utf-8?B?ZGRqcklQTmFJamJRY1BTSkJJRkxFVlpQWE9zbE5hOEYzWUR1b2IwZFBRZlZh?=
 =?utf-8?B?R1JmcTM2bzRnM2hhN0gxUzcwb0VleTlWVFVMSXFJN25uSGlKa29vYXlId1dl?=
 =?utf-8?B?NnZ2VGU3NGtGVTk5NW5IOWx1WlpJbm0rajdRNDFvUWdHR3FhVzlwcFBuS01Z?=
 =?utf-8?B?U0RFZmxqYWUwZnNVYXpZeWdVbEpTc2tCWGRMdms1dXJJclVHcWFGa0lsOFRJ?=
 =?utf-8?B?VlhFYmp0dktoZktxNis3MVNOa0NoYW83Y3NhOXh0anpXTGRITDJuVElKaHNu?=
 =?utf-8?B?N0txRytFbGxJZzlhVzBOMVdVeTc4N3hFZmF4WG9MVUlQWVh0NXNJZ2tJcDdh?=
 =?utf-8?B?d1F1d1k5ZEsxNXp4d3JPby9Ccm5ZSExod3dUL01PMXBtYXV6V3NrMWgvL2FQ?=
 =?utf-8?B?ckdLZjg3SmZmL3RTTzBmTHFRSTBTZDQxZzJ6Sm96Q2N4dHBLY09kZWxwVFpX?=
 =?utf-8?B?YlRRYk95M3diS2VjWWlZKzZiVSswSVU2ZzExOUdtQzAxSHBYRk9RYXFWRTFi?=
 =?utf-8?B?aSs2ZDYrWGY0YzJZQmlyTkhHalRkSmJyWFlvRlA2L3RBVEZMYWo3b0xLNTJN?=
 =?utf-8?B?OGFrbnNUcDU1UysxaW5aVnJjek5FTzh0dWJUbkIrWjcxcjVQUXUvV0pBcno0?=
 =?utf-8?B?dVAwMit1a28wTjRXVXlUWFh3d1l1SUlHSmdNRlV4b1BuczAvbTFsblpaY2pR?=
 =?utf-8?B?SXp5T293c3ErNWp6ek9OV3ZxcE5OWnpHVTYyeFR6WjkyOC9wSUdMNE8wa0VR?=
 =?utf-8?Q?qyVawAe/Jt3tsW843WfcvXVjv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a392e9b6-2f5b-43d8-87ec-08dc63cd4432
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 19:40:44.4704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdDxCyhLI6PztpkVkAqmGQhsXcOD64e50yzaxFWuJDfzEtdEUycPDW4VZT6XZChuAqX6yjf3EpSvKTZ7aYZcog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

On 4/23/2024 14:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 073237281a50 ("ACPI: PM: s2idle: Enable Low-Power S0 Idle MSFT
> UUID for non-AMD systems") attempted to avoid evaluating the same Low-
> Power S0 Idle _DSM functions for different UUIDs, but that turns out to
> be a mistake, because some systems in the field are adversely affected
> by it.
> 
> Address this by allowing  all Low-Power S0 Idle _DSM functions to be
> evaluated, but still print the message regarding duplication of Low-
> Power S0 Idle _DSM function sets for different UUIDs.
> 
> Fixes: 073237281a50 ("ACPI: PM: s2idle: Enable Low-Power S0 Idle MSFT UUID for non-AMD systems")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218750
> Reported-and-tested-by: Mark Pearson <mpearson@lenovo.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Ah glad to hear that my idea worked.  FWIW we saw the same type of issue 
on some AMD systems when we first introduced the MSFT UUID.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/acpi/x86/s2idle.c |    8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/acpi/x86/s2idle.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/x86/s2idle.c
> +++ linux-pm/drivers/acpi/x86/s2idle.c
> @@ -492,16 +492,14 @@ static int lps0_device_attach(struct acp
>   			unsigned int func_mask;
>   
>   			/*
> -			 * Avoid evaluating the same _DSM function for two
> -			 * different UUIDs and prioritize the MSFT one.
> +			 * Log a message if the _DSM function sets for two
> +			 * different UUIDs overlap.
>   			 */
>   			func_mask = lps0_dsm_func_mask & lps0_dsm_func_mask_microsoft;
> -			if (func_mask) {
> +			if (func_mask)
>   				acpi_handle_info(adev->handle,
>   						 "Duplicate LPS0 _DSM functions (mask: 0x%x)\n",
>   						 func_mask);
> -				lps0_dsm_func_mask &= ~func_mask;
> -			}
>   		}
>   	}
>   
> 
> 
> 


