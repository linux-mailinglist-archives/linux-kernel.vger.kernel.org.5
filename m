Return-Path: <linux-kernel+bounces-162440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A7F8B5B39
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081721F2145E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDC47BAED;
	Mon, 29 Apr 2024 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ixXLpb9U"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85757441F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400911; cv=fail; b=St2c4MWa1ShAJUYRl9CWhK7YYOjHqsvcxIxi0iWV1sjIRy1GjCq8YoIPkxTK+zMdewKYDUrBys6Z925Fhu16WA4V/vdItuzMq4UjmqYn/2C2AB2wb/aLfbfE/3mTWH/uuFc4gC2Sy58Sp9MUg34wl+LKXqiv9+g0+1qnSgnOpBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400911; c=relaxed/simple;
	bh=+dgFW6HxvpijPHT+/GHobVywc4/isDcv0EeP1Yy0Kjg=;
	h=Message-ID:Date:From:To:Cc:References:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=FJDEE01lYlS4bnyI/uc3qZt7q8VLF6359CnWZdiX1TAOwfpdDaVoLKcKon7zL8D0tiAdSsJRewN/bf5xoFO7gKYgaxsswesB+7ZX31jHBLz05LxTND8OKn/NQNW/TwzdPNkZU+m6xjStuN3Dh/ZSLrllwu2gyAHf8+eCONmzOv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ixXLpb9U; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QohhOxlYswcwR+mPMITRp93HVBpVlLrhpxyC8X1j4vcPToUV03t5abOtO7L/HCaqZBWxT5XScfr6QjxkDaM8TGcUPm/GNU6rdOQ5WST0ssrLAYQfUEd34XcAEEMKfqp0unaKsKh8y1JvkQJXJVzqC4XAKvO/R2XzylX0PPrKD+IAGCZ2EL4vBkiv7Dx9j4hMJz6A4C2WyM0BW8dGFVzTJzJl8Pgqpv4JRf62E8x3tbYbZ7Z7InOEdqcUF8vBFE6K9dhO9QMB/sVBvN+9sUJT4sQEFYDX+VNFk8smvzljwEEzx1FB+antJVqr/i4vbopG8mtrwOnGJUgWX7sWAqrr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qowei5uThCsh+f0MlB4N5K1mPCTsTQmdzJHy4sHaxds=;
 b=ShnLaiYe76LBrpwODV4RM7zBZZLy7ilsTcix63pLQVzHGvu4DxbU5+Tr5RbrgerQwK0VB6pbUEkp1gsZYu904xPFPfldLc2AiCnghGY3hcvrLvdBptFUI1867Iz0YxCs7q/Oif7yZd7X5WTxy9pOLCeASktRzrHUdJkNA6NFBCYX5W0vY+6H0edbtMRkUIutG0DgHjVADdwW9IYjP8qzfFn1rjPxTfP7ehyuO1XlcLJQpZQdGi8szZTCVm0/Bz5hWRG4c/GvIMvWMeaK3kfQVTc6qNBhjMv1ARH7opniEtSa9l+c0/uCzCuh49mchNykd6l4z8XTdXj4IRW27Ww67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qowei5uThCsh+f0MlB4N5K1mPCTsTQmdzJHy4sHaxds=;
 b=ixXLpb9U7J1DrzCTnJMHZ3UVzZSXTHaBZcwrs2SDfbmt4qExrQJo9zpSAxQk8OOZFLxZdgrnyqsyFqcOpI6B0Y/km7PaXYDj1OzfL4H1njVYgXokPfQJfNk6UJyWseyDmxQ0m7qFbvZ2PysEfBGKiEnw8lJStbJyxfMD+lusLQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:28:26 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:28:26 +0000
Message-ID: <33620512-a456-aa87-25d3-e15f2d3d256f@amd.com>
Date: Mon, 29 Apr 2024 09:28:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
 <662c239680842_b6e02944b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f6af3a35-7ddd-7f56-d7d9-34c77647614d@amd.com>
Subject: Re: [PATCH v4 13/15] x86/sev: Take advantage of configfs visibility
 support in TSM
In-Reply-To: <f6af3a35-7ddd-7f56-d7d9-34c77647614d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:806:24::10) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 3441ec25-e392-4d62-653b-08dc6858a131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnZpeUM5YWhIWlh6QnF0dHpUaURrclRTOUxKYlp0cVlnSm5MWmVBQWVrQ0tB?=
 =?utf-8?B?RDF5dUxDRGxxNk9uVnQ0MnhxdUhKMTkycnNJUlhwTklwVUw1b25SSExXak1z?=
 =?utf-8?B?bURHM1lGdTVEOVZxM3d0alI1NHpoV0NVTUxJVVZoMjNkNHc1end4NVBYMGJw?=
 =?utf-8?B?dXU5MGhhRTlUckp5RThkZVpRUmZIeTVQRnRvcFM1czdHNk1wNktKOGhxY01Z?=
 =?utf-8?B?N3I0V1g5ZVUxSlk3UDE3Rjc3am03V1c4YmladmRnQVVjQXBQSXdNenR6YzFs?=
 =?utf-8?B?QjlKVjUySTBkTFR4d2VZRW41ZEUvdTFvNnltZjF6NE0zTVFoTGhYaW5jQlVH?=
 =?utf-8?B?QTBYMWIreEc3R1NFOGtKZ0c3R0dVK0pDM3lubnhVTDhvaTA5VHZmOWdybEpn?=
 =?utf-8?B?UmVSd09Mc1A5OUhMVk00N2RWYy9DTlRMbjQ3MEVTc1hDWG1yamUyczZ4V1lt?=
 =?utf-8?B?ck42aUg5OFZUS2pMUjdUdFZvdU9ldzErdEpacnRCMmZkUnFNTitsTzhmS3dy?=
 =?utf-8?B?dFB4S2I4VlJFbGkzbjhLT1lxMStMdFhEb3lySHBvOXNwMEZnVHZYQk9sZEtQ?=
 =?utf-8?B?Q2pybDdLZHFEcEFBQVVNWWN5bDZncDR4a1FVcFJqaUlWYUg3Yi9Nbm5iTXpD?=
 =?utf-8?B?ZzlIeGttWVRjWCtldllZZFg3QkFsODFmWjFOTXFNMm85THYzcGN6QkVScjA3?=
 =?utf-8?B?SUo5NzBzS3NkaGRkTHJuNXpFMlM1RWdwMFlXQnNKeDNNelZMdDA1cUZpbTdH?=
 =?utf-8?B?UVVEL3Z3b3h3bVUvVmdDcys2dGxoMTJkaCtDTVdoYXYyRjh1d0h2OW9PRHJv?=
 =?utf-8?B?TFJraStvNFlIWWNhN2c3MVdKNHZZL2pVRFNzWXNhbi80ajVhWVdCQ3JETTJh?=
 =?utf-8?B?T1MxYTUwVEhoaUxzbEJLdnkxNnFHRzBaVUJsNk9jL1IwTVVsUThVNkgwVnZN?=
 =?utf-8?B?Q05MNzZzTWF6M1NpQWVjSDhXQjJhNnFDZ29SNURyUUd6VmFkM3YrYWJ3NTd5?=
 =?utf-8?B?aE5ZdU9jMzdDbVZlK0ZHaXR6MFNRUzVLSTVFOE9JZzZpaS85UUVERU0wNW80?=
 =?utf-8?B?KzhLVXA5RmgxaUFaN0prWEVIR0RKdWt4blQySG10OXAxSWUyQm5Rb1IvYm01?=
 =?utf-8?B?THpYYU9xYzNKNWhvNGZEUUJnTmRBMXpqcnhSK3FITStJRk1zWXE1di8zVjFN?=
 =?utf-8?B?YkNTajRGblNvTU4rNitaaXF5SlEvNVpwTE54YjFLc2hlRFFRYVBXWmdsUW5K?=
 =?utf-8?B?clRacThjZjZsV204eVQ0cm9YU1JWN21ZMllFaDh1QnRVR0h0NTI1QXNHRUFt?=
 =?utf-8?B?a0NnUnlybS9LTlNEU0gwTmIxVWJRc3Irb3ZTUjZRcmZrbGRVT1Q1QjN4MXVK?=
 =?utf-8?B?b3J0L0hMTlQ3eFR3Zys0L0p2VTJtVFRVR0R3Wm9IOEFXY0xaTkZLNGJnWkpm?=
 =?utf-8?B?Q2loRnRNV2F2YjZGVGZhWWpXZUxCNjhPcU1sMVhEQXZUWXNjZTFJL2gwVGR5?=
 =?utf-8?B?MzZEeG1MZ0pIZVZHSzVJN1ArM280cmJiMXpGdVlCdkh3c2MySG40dzE4TUlI?=
 =?utf-8?B?TlF0K2s1RDhSMHo5d1hKTU5VYjQvWkN4Yy9LWTBoa0pydHZmZUdwYk1aSVl4?=
 =?utf-8?B?aHFONlg2dERWUm5SemRXajByVmdkSjZ4NkVveGN1VEhwL2dsM0dlOVJGVEZ1?=
 =?utf-8?B?Nk9DSWFpYzJLdDkyNUloUEFwMTZRWlpScUNNb0Z0eUJuQXR0MzRvN0d3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym9ZM052TGRpK2llTGVsMVRDNWw0STd3MzNrSHVqUGhDQ2JqeWFBNHVLOHpp?=
 =?utf-8?B?bnVwZHdlR0VpRkg4MXViVkgrRFJSQ2x4R3p5MVZyN0VJOU5YWlZZQ25hTUdF?=
 =?utf-8?B?bVBkNlIwdSsxY0J2cGxLczBUV3Mzckd0ZDdCcmd3ODhrVjhNdDhBMloyanVt?=
 =?utf-8?B?aTc5dE0vNzU3Q2VwWVU2TlorbXVYdlU1MTV5ZmppZmxZN1owbHl0c1plWFZD?=
 =?utf-8?B?OTdOY2lpdmFLK1ZHaEYzT2RVb1JWQXJHY2JyT0ZKSm9TbXVubnV2RUpEUDdL?=
 =?utf-8?B?YWJ5S0EyMXloTkZjU2IzTEt1aWRrSkg2U2VZTG5kZVVPcm9CcmdUUFpjSUpP?=
 =?utf-8?B?bmlkT2pDS21kV2NlQXJianJwM3lrVUFFdzh5UzNNemd6QXFTemNJQkhnRjBr?=
 =?utf-8?B?THltUWxXbUdidkc1ZHltMHp1aFA0NHJUcFlXTHJQekxtbDlFK0oxRHZzdmdZ?=
 =?utf-8?B?ZG45TlJYUnNLbUxzMHdwUUJNZHBTdDRUWHUzSWZuUm9kNHRFeUZRTGFnOTZZ?=
 =?utf-8?B?K2FrbVNUWkJkUXBCU3BPYnc0d3A2NXlUbmZUdDUzU3haOEJsemNSNGR6dWJv?=
 =?utf-8?B?SVFBbTZCNDV3WS9NcmQwNTQvUk0xZjBDQkd4MVRKMHYyYWtUOFI4SjdQQUZB?=
 =?utf-8?B?bU4wSEVER0Y4ek4ySERjcG04RGlUWVEvdU8zYmsrbWpHa3Z0R251ZEhTN0VZ?=
 =?utf-8?B?ZFhKbXJGb0NOQ2l0OTB6TlByZ05VVFppYnJFaVVsVkM2YWZ6RytYeldIdWZ4?=
 =?utf-8?B?TDhFbVczN0JYdU1WUXBhMmxscmxPSk93Q01aNS9nRTNOMXM0bU00eHpTTEZW?=
 =?utf-8?B?V1luTzhJZ1JMSjdGQXoxT2VoQkg0L3BwVk9CNGxONjU2OS9ITjk2djZ1OEw0?=
 =?utf-8?B?Ti84SHF1MnFmZXE2VVVxMVArSkhZVENxb2RIUjlMR2JnZTVyTG03SGJSTmVp?=
 =?utf-8?B?ZFBaUUJ6QUlseHRhdHdWbjB3dUkrT25UWGVvMVlKZnMvbUpGeHlwMVpOa0JK?=
 =?utf-8?B?TGdreVFpTWEyT0xucHY4Z0U3Z3pUUk1CMGZmdnhVcVNXY2s3OEhEeHlPTXI4?=
 =?utf-8?B?MDFBY09zaUdsTjJVS2MwUmcyekU4UTZpZS9RTTdwUWc4Y1RkaERhS2tjdTdM?=
 =?utf-8?B?bWJRZWR6TmF2T1phbUVMTlgzSGVuVEVvRFJxcXc0T20rZE1EQlpNcHpoTFBT?=
 =?utf-8?B?TDU2V3JyRkp3Zkx0M2JyUThVeldIeFVlanp6MUhUT1doZytXNmFCb05OQ0F2?=
 =?utf-8?B?aHJPcld4bHRObU5RMFBOVnB0cnV0Slh0SElBbkF1NWpPdXNSSWI2SHNwMVBq?=
 =?utf-8?B?akxmcW1KYXowc1duWUdHRUlRVzU2Q3dLaE0vTGV0SjhSNlZyaDZtbExGMHFM?=
 =?utf-8?B?WXdmSThVZGZEN0k5NS9Na2NTSUV3OGxjMHE4dEM0YXdaOXdhWW51cmdpaUNV?=
 =?utf-8?B?Ky9ZS2lPK002N3ZSQkM5akZWdE0rYW83dndEY0JYMnBGNVBBZktwaFNDRnVH?=
 =?utf-8?B?WHZnd21sUi9jT0JuelNGL1NIa3psRGlVSnU5YVdRbCsrSjBlYjZpdVRDOXJn?=
 =?utf-8?B?bFplK0VwOWpRcEMrSW9BczVqVDRzZ2pxbEdZMEk0NHdvRkljdTd2bDV0dEIr?=
 =?utf-8?B?UXVMSXNVMUE3ODAvb1d4NjQrOWY3c3NTVElHdm9pWkdZcFBoRlplcWNRR3Vx?=
 =?utf-8?B?SHBvNkcxYkZuanRDMGFRMDEwVkYwdExnZjV1bjFxNVdyNExPdCtuVm9FWVhN?=
 =?utf-8?B?VnFxUVlSZHh5Vmdpa01YSHBlKzhzYkJaSzF2bHgvUEk1RVJmNWFZb0dOQnBJ?=
 =?utf-8?B?bTNrdjVkNENsbDVreTdZaXcwTmU0L05XeHk5NmNWYTR1VHViSjgwTjVULzJH?=
 =?utf-8?B?c1h6ekVBL2hiYUcrSTlRN0V0NDA5NHVzMFJDQTNoOUc1WnF1a3llb0pCNC9T?=
 =?utf-8?B?dnlTSmxBUjJ3TG9GbFdSU0dIRnozUGpmYWNhTDJWY24wMHJOQnpQMExtQ3hB?=
 =?utf-8?B?MEFrd0xwZHBvSXNHL1k1NkJKVEhGakZsbnlWYkxEOXMzT1NzMmdyajlyTFk0?=
 =?utf-8?B?RktnYUp0dFlFcmdMZnpmekpRZWJvZ0poRjhzZTRwaUh0MlYwMG5IYk5zd1BO?=
 =?utf-8?Q?DBaTkhVUqtk7jO3GAoaMLzr5S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3441ec25-e392-4d62-653b-08dc6858a131
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:28:25.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bKihxGEMPCLJi+BatvMvF04Uqyj2g1rrjyPHw7uiYAr5h1wRF2y8XXMy8lp0CSs3/Kp1AlblQ2OsSXbSTeTyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501

On 4/29/24 08:35, Tom Lendacky wrote:
> On 4/26/24 16:58, Dan Williams wrote:
>> Tom Lendacky wrote:
>>> The TSM attestation report support provides multiple configfs attribute
>>> types (both for standard and binary attributes) to allow for additional
>>> attributes to be displayed for SNP as compared to TDX. With the ability
>>> to hide attributes via configfs, consoldate the multiple attribute 
>>> groups
>>> into a single standard attribute group and a single binary attribute
>>> group. Modify the TDX support to hide the attributes that were 
>>> previously
>>> "hidden" as a result of registering the selective attribute groups.
>>>
>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>> ---
>>>   drivers/virt/coco/sev-guest/sev-guest.c |  3 +-
>>>   drivers/virt/coco/tdx-guest/tdx-guest.c | 29 ++++++++-
>>>   drivers/virt/coco/tsm.c                 | 82 ++++++++++++-------------
>>>   include/linux/tsm.h                     | 41 ++++++++++---
>>>   4 files changed, 102 insertions(+), 53 deletions(-)
>> [..]
>>> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c 
>>> b/drivers/virt/coco/tdx-guest/tdx-guest.c
>>> index 1253bf76b570..964af57f345c 100644
>>> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
>>> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
>> [..]
>>> @@ -249,6 +250,30 @@ static int tdx_report_new(struct tsm_report 
>>> *report, void *data)
>>>       return ret;
>>>   }
>>> +static bool tdx_report_attr_visible(struct config_item *item,
>>> +                    struct configfs_attribute *attr, int n)
>>> +{
>>> +    switch (n) {
>>> +    case TSM_REPORT_GENERATION:
>>> +    case TSM_REPORT_PROVIDER:
>>> +        return true;
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>> +static bool tdx_report_bin_attr_visible(struct config_item *item,
>>> +                    struct configfs_bin_attribute *attr, int n)
>>> +{
>>> +    switch (n) {
>>> +    case TSM_REPORT_INBLOB:
>>> +    case TSM_REPORT_OUTBLOB:
>>> +        return true;
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>
>> Why do these callbacks need @item and @attr?
> 
> It is a generic callback from configfs, so outside of TSM, an 
> implementation may find it useful to have these. But, with the code 
> change to require the callback at the attribute level, now, these can be 
> eliminated.
> 
>>
>> [..]
>>> +static bool tsm_report_is_visible(struct config_item *item,
>>> +                  struct configfs_attribute *attr, int n)
>>
>> Per the comment on where to find the is_visible() callbacks for a given
>> item type, I expect the need to pass @item here goes away when this can
>> assume that there is only one way to have is_visible() invoked for
>> @attr, right?
> 
> Yes.

But as I look closer, there is only a single ops callback pair 
(is_visible() and is_bin_visible()), so as long there is never another 
group / subdir defined under the TSM report, this works. But if another 
group is added, then the item parameter would likely be needed or the 
ops callback would have to be updated to differentiate for the vendor 
(SNP/TDX).

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>> Other than that, this conversion looks good to me.

