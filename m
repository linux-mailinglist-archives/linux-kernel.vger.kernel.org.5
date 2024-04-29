Return-Path: <linux-kernel+bounces-162366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66CF8B59DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9C61C23E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE16F061;
	Mon, 29 Apr 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4jaUHWoK"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13012651B6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397216; cv=fail; b=UDbw76ZN7hwXLEymVQhoBLWkSFzEfrSRsadLKEmGL2R1U1YdnoDmpBVzIOvVo34xH47zD3YmH9auflql3tN+lMvKMnz77JrY+DMJo708+12vMmsldis1feGi6jngZ/H5cIy7XXT+fecOKrfukJlonqBbXAL0eZuz1SzSPeu62oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397216; c=relaxed/simple;
	bh=5uLlIc96AJz0EiIQW522TiYURb6J6QWuJ4C+hur1CBc=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=MxTIah+Yjgp5sw9ycW4B4QGHQDmaVGejNVXJVkn0KhY9EH6rFprCK/Gdry2d5G7+fgyPHhsHgwuhjZN71zTCPJa+W0/7LexCa1ri60xpIUQmrTpFGYu2r82PfSkIQNk3JtNvQZgdL5T5qTwE95DSrZeyjRBoqtszFSyC5kmU6Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4jaUHWoK; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZJGY/on/EYE7p4T5nog5ExT2+xY7e4HNPzILyu9MzN4TsaN1j57uxVuVfRv16x+2Ewz83f2wM078c8E0ybZ8/ljvKiBaLY/3QB+xymgzkkTqkwC2nmqox3IpfOVvj1PKNsYOvUFfitLukhNu8ZHwf4Mzc0MMF4Oo5pY+9O+4yQkflFNFjSL9M8cHh4Bm7fowbNNGS6Adh14YukEL3ko6oszBHX5NDWvjf0C2ILVK/jaVoUAIu+Pkzyq/qAP2lhHkM6ebjuZ7e/TZYgcNBOp6KkTfldomSlPDp4wNtIV8JfI1YDS1UjA7PI8DbCp2HynPDUm5H+X5KNLNofG7XMCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLo8u6qlPWvt0gyKFhT0873gJzWXpBMD9y2XQjtldxw=;
 b=Cx3NgCsPiqC//2m6M75SwJdJBWZD9t63FROjoEZOTU5yB0F2FfQxxhdqwod78wc+goaBveRgxf3XbqmEaEjS493ETRJIBNmcDLX/aBRe3Ofq5ObIPiyN1oVs2JH/spCH0wIsHk434amSr6+WeOeaJrKsu4NE30at2YLqTeVIfnwLstuu9X49hdMh8PatjE9c1n/gUMipvv0CCMlLDnhPbpI/5xuuMCIK9oH8/Jl5Y4n2Hv4TuK3oKV27YTvIx0peiLr6BxTRcAI1j6CPudrgoRM8NwtqtkV5oLnEmBMKi0EiF3guW4dolNhJprNkW8yaCopYU1lbbizYfYfzaB8xWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLo8u6qlPWvt0gyKFhT0873gJzWXpBMD9y2XQjtldxw=;
 b=4jaUHWoKF6HEplvzYEMNCNVhCv0P9fBaRvilQPw6BZiybZK1NdARXX3iw/Lgi7YIuY2lSKgXvyDrc/QrQSiWgVpqidQ06o/M+By1z/zoGb7LMEKa2zEF6vDO/idodqsv+IlCGgKm6o8cFaGwo1mcaPzcSypxeTHCZCL4Ti4GsaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 13:26:52 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 13:26:52 +0000
Message-ID: <4fd88c1c-6100-254e-ceec-98a4bcfa015c@amd.com>
Date: Mon, 29 Apr 2024 08:26:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joel Becker <jlbec@evilplan.org>,
 Christoph Hellwig <hch@lst.de>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <53e67e416fb4da085f32d8a3626c5c6e656554f9.1713974291.git.thomas.lendacky@amd.com>
 <662c2147c4fa3_b6e02948d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 12/15] fs/configfs: Add a callback to determine
 attribute visibility
In-Reply-To: <662c2147c4fa3_b6e02948d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:5:15b::26) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ef3aa3-b22b-48aa-61d0-08dc6850083b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2JFU3ZLc0VhWXN0bFZpeUdlTDFPR21lclorRkk2RllMWEwwTlg5RFc4MU1H?=
 =?utf-8?B?TlpyV0FLNjUxNUdBWFRLU3cwaFpMUUNCbGgvNk9mbzFkMlpWV2o3S25oNW9O?=
 =?utf-8?B?enQxS2xvVjJrc2l1eERrOWcrYkpXZnU5bC9YeW8wdFBJWE1sTGZnTHdHTWFZ?=
 =?utf-8?B?RWp4Rm11VmFZWndWNk5RZGJIZDZNM2Y1RzBLQ2RkQzNPdkUya3p6ckJhVzNW?=
 =?utf-8?B?eDMreVp0bUMxSjJkOHE2M0tCWU9haDZ6OU1nZXAxTmJNd2xQdEVYazZOUTcv?=
 =?utf-8?B?aHllYi8xdUgvNCtMT3NvUFpqQ1pWKy90Yk1peG1yOHJJYWhjZmVaYVltQU5C?=
 =?utf-8?B?ZEF3YVBscjNMS2NMemxzVWpQRUwzeUZYRmxub3hyZEVSY3A2NXNpSmhYWjc1?=
 =?utf-8?B?c1U3bGt3VE96RnBneXBhWmR2bnlpcXlHTWUzTGlEUTE1MEphY01hRzRFQ05H?=
 =?utf-8?B?OG5FVjYzemtnU29TTW1OYTMzYzdHWWpYNjFzaTUvazFkRzA5TG5HeFhnbDRD?=
 =?utf-8?B?c3dmVVYxRjBhb1pFTGZpM1JGT2p3cmVHNVhtenJWZGVDMTN4RHdkY2loNE9X?=
 =?utf-8?B?MFhJWjhPd3FPVzZTbHpudXNmeU5BdUQ2UVk1UElXL3FITlV1Ym13Y0pwYVA2?=
 =?utf-8?B?RzRybkUveVJpMzBTWlQzUTBpOXBMQXU2VEV0aWUvbEFsV0pmTlg0eG51VDlj?=
 =?utf-8?B?QkUrSFZERnh6WHpTMHZETGVsZTY3OC9kWWd5V2RRQUxZbUgzazJWOHR6Vzdr?=
 =?utf-8?B?Kzl6MnFQenoxaTlia1VFYnBqb1NYbU9DUklBbGtjYjJLYy9LNGkwL0VKVWpM?=
 =?utf-8?B?MlJXOXlmTnFnRkFTSFJVajRpRVpqWERXcFNSRHh6a09TUkhJSmE5VVE3Vmdk?=
 =?utf-8?B?djYxYmFwekJQdERwRUQ0ZUtybkVkOXczV1NSSUFDdmRwNm9ITElsdzRONEZh?=
 =?utf-8?B?VVB2Q1Q1T0ljOGZGYnVRU25DUFFRYSt1NWwxcHg5UkowcnV1YndzVU1oS2dD?=
 =?utf-8?B?Mmh3d0JBTWp0dWJFNkhnU0lmVFhITVN4Y3IrWXdlSGtHaTlsNzRXcms3U2Qv?=
 =?utf-8?B?U2poN1V1cUVZalltcm90VWdEV2k4L1Q4UlFoTkpFSk5sYjVxWjlIeTFHVjU5?=
 =?utf-8?B?dWUvZXpjc0EyZ0F2ZmZsdG9wWHBtSXN5QVB6UUkxcHI5UUJCVEwxQ0h0RXBS?=
 =?utf-8?B?czZ0U1pJNFd3STZqaTRVV05IT1FDRnJZQXM4UXZkSW5pV0hWODcrd2ZSd0V1?=
 =?utf-8?B?N0NZRTNGSUJXUk1kZlhQdHd2MlY2d1JUcktSV09lU0xPUFh6SWkzQU9ZZ3ZU?=
 =?utf-8?B?UmxzWUNmZUZpZ1A2d0QzTjdVSlowUG9BRWhDVHcvNU9BNnFVMC9Cbm1TaXJE?=
 =?utf-8?B?dEJEcVhlSnZwQnh1WnhYUXlPU1JtaU9zRjM0a2ZZVVlGaEhNNzh3c2IvRzU4?=
 =?utf-8?B?U2MrOWk1MXJ6LzRCS3VZc2ppZTF1WHdGTFFtK3FIUUV3VUVDRUNMYkNoTEl1?=
 =?utf-8?B?K0pJSkh3WVRkMWl2SHc1MzFaZG9xSDlyY0RlRENFOHRhUGR3ditOaUJxUHh4?=
 =?utf-8?B?ajFNY0U2RWRSWmhQbzBZVFl1RUJrR0h3NWU2eTNIY2swTGlQNlZLclpDYjcx?=
 =?utf-8?B?MXl1d3hwOGdUTWt4M1VxZXZQbXBObUxlWnU4bkFkZTQ4WHBDbUtuYmkvbUpP?=
 =?utf-8?B?WTRsQjdWdFBXZkdZYXRUeDZ6eG9kUnJjOVBrMjdLUG9nOXloZThZNER3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0xKS09Qb0lwWCs3UEM4ZjdlcGVPTk1mZVJpNlFXcHo1YlhDY2JCVFg5c2w5?=
 =?utf-8?B?Snd2UkVra2tETnRUNjFwWlhMZ0Z0aDZCeEFYMHZNZkRObFFJdGNLRUUvbnFB?=
 =?utf-8?B?cy9ZOGM5eGdQeGY2dkZvNnN6cm10ZExGWmRhRGErZ2s0bXc4L2hOZUZhWlRX?=
 =?utf-8?B?MFQ5d2gwSFFjRTdsN2xSOFpPd1VPeHVERVVxTWdEVVljUXRzSEpxM216aXgy?=
 =?utf-8?B?VlZ2aHdyS1RwNFNsTkhlUXg4aCtVSk1lYnhLTHNKOUgyYU84SzN3ajV6RHRj?=
 =?utf-8?B?VURaMWZMbmJwTzhpN1lvOXV5SVVkMllLbFcwcWQ3TU5hKzJXSkdqdStzSWhX?=
 =?utf-8?B?Zmp6SVVsdHorcmNBZUdSc1pkVCtORzVrMlJ1OFlzdGc1b0ppSHBoaUxOYlU1?=
 =?utf-8?B?YzN0dlAvVTB1bEtocWJ4L0NYS1ZQSCtwYzFsT1VXeWVWd3lyQ1o4VE9VUy9U?=
 =?utf-8?B?YTBteGhaRVNLVmh3M3d4VytDQ3R1SFR1QzdGSTU2MWgyM1BpcjIvRGREeHZV?=
 =?utf-8?B?bXNvdU1wSHJXcmNpYmtIb0k0VFlPK2NRVjgxWStQVTlRU1F2WmRhSzFPZTNk?=
 =?utf-8?B?aGtjWUN1ZVNjeGE5NFFjZVBVaWsvSmRzSEVXU1RlL2Z1MW1aODNzVStmOWs4?=
 =?utf-8?B?NmEvVExGdElQVEhpeTBRc1FJL0F4dXYvcWtZbWMrSXJDcW14ZThmYU9IV2dE?=
 =?utf-8?B?emU0dmJCQm1Oa285cDhibmZ1b1JGZk44OVJTNUQwYUJtVzNyakw0WjRMSWpy?=
 =?utf-8?B?TVJYcG50dUp2S3RYZm5KZ2dwTlVVaXNwa2wyOTNsalh5azZNZnZtQnFLTnNH?=
 =?utf-8?B?VHdKTTRTZ3luMHhSazVYb1RQQ2VzbUxDZzRpTzlBSDVPMHRXNDM2R0UzRm9U?=
 =?utf-8?B?QjQ3a1Y1b0U3ZkJLNzVqZk1kSUJEL1FuK2VMQTliVmlveXhqWGdvQUJrZHpI?=
 =?utf-8?B?UDlhMkI4eWVGVWJwRHdlcGpkZ01qNzdONWQ4VnJmOThzYkxEc2daUzhsdjNU?=
 =?utf-8?B?UEFFSGNaYStlVW9VaWkzWWEyVytQWndWd1h2MDJKdU54Wm1uc1hKWFg5amVR?=
 =?utf-8?B?Tis3SVViV2JyeWJTekZsWEtUSXlYMzU3Z1VERHRCblBHZ25Lb1FuU21GUDNR?=
 =?utf-8?B?THFVdUl4dnMvcFlvbkhkUWVhZXFPMDdMYWczMVlaK2lTS3BGclZ6d3FyR1Fz?=
 =?utf-8?B?bitKOVh6TTdHeDRVd1A2Q2ErWnpYTnpqc2lrVll3WWFRZlU3TmkrcU1lSnlY?=
 =?utf-8?B?RG96WnZtQ001S0NkaFljaCtjV2h1RHhwVTNUeEYrZWxGNkNwelY1Z21ySlVw?=
 =?utf-8?B?bUE1RWxRajJZNHRGWExZNEdFSElCVU4wdnBCZU1GWmJPNzFHQmc2NDBxSndo?=
 =?utf-8?B?OVNXdU9SUE02SGorZTJrOEtRcUs2blpxRjNBSVVkL1dCRHZmWFZ1UEM0Nm1n?=
 =?utf-8?B?N2hpWHRwSE16L1cwUW9WWEl1WHN1bENZbWJ4WnJHa1ZXZExlTFp0NlNSUXVw?=
 =?utf-8?B?b3ZNWGR4T3FQN3BJZkh2WUlpN0tFNm1vZDgxVGU2TDFHRDN5WkRTMWZTanVO?=
 =?utf-8?B?b1FoWWtxZTU1dTVWeVVHb04zU2RvQThmUUhXb0N3K21aMHhpZWVOQi9YcE5Q?=
 =?utf-8?B?VjRWN0JiUzNmZ1RtWUc3ZGxiT3pFdUFGQzAwRkdFYWdlSFV6TzdkWXF4V3Fv?=
 =?utf-8?B?aXl1bmk3Wnh5MGJwclBkMnRFemh1MWtHNDgzZVlCeWZxWjEyUGdoYnRiQUpi?=
 =?utf-8?B?eStLMlU5bFdxdGxNekhvMGRMSXBzZytLKzVtNVRsakFueThSVG4rMGpRS3JI?=
 =?utf-8?B?Y08yRlgrY3ZKU1NxdWFxelFqZWk0UWgrbG9mYXpIa1pxTlVWVWJOQkcrYnls?=
 =?utf-8?B?akpKemhtVllnL3p0RXZDQ2xtVm9rVm14Q3NYRVEvMDAwUVM0Z0dNa3hpZnVB?=
 =?utf-8?B?dXNBQUZoVEd5MW1pTk81VVowRFZka1pEWEVUaW9BTW9CYmNJK2U3Um9ld1Q3?=
 =?utf-8?B?cSsxbmtzVUladW1uT0thTlZVTTRYSWFQazdnMXZ2QytTMnFaeHFBMVJNcXJP?=
 =?utf-8?B?VThpZGl3ckNCbUg4dU01Z2dMOTZRVzYzNFd6NVNSL1RLY3NYVzk3SHZOUGdE?=
 =?utf-8?Q?M1NCE1vcqQCZk5cW9ELeuBHjq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ef3aa3-b22b-48aa-61d0-08dc6850083b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 13:26:52.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hbJyCQ1YMjLlkfV/HkyfBeCj8xkYKv5eC0l0+0stJi5uiCNWJ8PZxs2GawY5AATi5CIIA0prsN623gIJRffcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646

On 4/26/24 16:48, Dan Williams wrote:
> Tom Lendacky wrote:
>> In order to support dynamic decisions as to whether an attribute should be
>> created, add a callback that returns a bool to indicate whether the
>> attribute should be displayed. If no callback is registered, the attribute
>> is displayed by default.
>>
>> Cc: Joel Becker <jlbec@evilplan.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   fs/configfs/dir.c        | 20 ++++++++++++++++++++
>>   include/linux/configfs.h |  3 +++
>>   2 files changed, 23 insertions(+)
>>
>> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
>> index 18677cd4e62f..463e66258507 100644
>> --- a/fs/configfs/dir.c
>> +++ b/fs/configfs/dir.c
>> @@ -580,6 +580,7 @@ static void detach_attrs(struct config_item * item)
>>   static int populate_attrs(struct config_item *item)
>>   {
>>   	const struct config_item_type *t = item->ci_type;
>> +	struct configfs_group_operations *ops;
>>   	struct configfs_attribute *attr;
>>   	struct configfs_bin_attribute *bin_attr;
>>   	int error = 0;
>> @@ -587,14 +588,33 @@ static int populate_attrs(struct config_item *item)
>>   
>>   	if (!t)
>>   		return -EINVAL;
>> +
>> +	ops = t->ct_group_ops;
>> +	if (!ops) {
>> +		struct config_group *g = item->ci_group;
>> +
>> +		/*
>> +		 * No item specific group operations, check if the item's group
>> +		 * has group operations.
>> +		 */
>> +		if (g && g->cg_item.ci_type)
>> +			ops = g->cg_item.ci_type->ct_group_ops;
> 
> Oh, I would not have expected to need to consider any alternate group
> ops for attribute visibility beyond t->ct_group_ops. However in my RFC
> example I made this mistake:

Right, that's the question. Do you use the default group ops that are 
created for TSM report or do you require the ops be part of the 
attributes. It is definitely easy to do the latter.

> 
>    static struct configfs_group_operations tsm_report_group_ops = {
>           .make_item = tsm_report_make_item,
> +        .is_visible = tsm_report_attr_visible,
> +        .is_bin_visible = tsm_report_bin_attr_visible,
>    };
>   
> Which in retrospect is the wrong level, and I suspect only reachable if
> you do the the above awkward indirection ("ops =
> g->cg_item.ci_type->ct_group_ops"). Instead, I was expecting symmetry
> with sysfs where the object that carries ->attrs also carries
> ->is_visible, so something like this:
> 
> + static struct configfs_group_operations tsm_report_attr_group_ops = {
> +         .is_visible = tsm_report_attr_visible,
> +         .is_bin_visible = tsm_report_bin_attr_visible,
> + };
> 
>    const struct config_item_type tsm_report_type = {
>            .ct_owner = THIS_MODULE,
>            .ct_bin_attrs = tsm_report_bin_attrs,
>            .ct_attrs = tsm_report_attrs,
>            .ct_item_ops = &tsm_report_item_ops,
> +         .ct_group_ops = &tsm_report_attr_group_ops
>    };
>    EXPORT_SYMBOL_GPL(tsm_report_default_type);
> 
> ..because is_visible() at the g->cg_item.ci_type->ct_group_ops level
> would seem to mean parent directory visibility which is mismatched.
> 
> However as I stare at this a bit more it sinks in that configfs "group"
> != sysfs "group". So I am open to the suggestion that ci_item_ops is the
> right place to house item attribute visibility callbacks, or even a new
> "ci_attr_ops" expressly for this purpose. Either way my expectation is
> that config_item_type can get to the visibilty callbacks for its
> attributes without needing to traverse any other groups or items.

I'll update the patchset to do that.

Thanks,
Tom

> 

