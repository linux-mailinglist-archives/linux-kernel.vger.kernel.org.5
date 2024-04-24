Return-Path: <linux-kernel+bounces-157590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1E38B1345
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7056EB26050
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B0E208BA;
	Wed, 24 Apr 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cE8GXJKI"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4CD1EB35;
	Wed, 24 Apr 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985840; cv=fail; b=T7T7dGHFsO0hL5IM5bpQ4wm5CD6byRLxWF23Q3oVxq3at9sxIY8Jcq3QnMBlKB2Gu153tAIEZJPIy2jo4oT4l4EuVItOUWszioSQ1cvwgyh/DFjfGlcHmdwVbKrXbGHQdbZ25Gwvc1Z8D8c0wvJPJwmQfR92yBOslFAEyZ6FSwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985840; c=relaxed/simple;
	bh=UqwsGVmq0LDcajm1NZLwWhpQKQ5OZ1RmtGC+wvG1KIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QFl0/KOBrE9CfapwgW/sbsvz+dbGANL33Kmr386mOO1HrttPapkjYpaHBhMJbxUkhJYQ+/g59BDmtqG9IP/CjkQODYb/J/3vha5krZFZn7g9G7MRVs3kBc6bV2jLsVAiuX2nG6zu+uOswYKLD1QVcsgcu1cHsIgrF3fJOTJc45A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cE8GXJKI; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZLfIWrQAHkdm04D1vjttGQCys6scYZ2CjiVonPZbe9kAg2Xg4ds4ajt8NrFf4Yx0FLsu3YV1dXf6jGvb9eUr/x5c/cpoxW+apU5HjRZmbP7vpI9P/GkYsWP3XscWcnEpcnhjcHhv5kuwQeFa7UgmTXSGZd1la39dfT/pXexPoedTF4cQUstwy0DjdZXDXK192DPn4BS/WX6emN6e6nq9gxKzAzJ4qBiVvhXWP1bE26uUghs3qD1/u7kUIbdPHG8NhtFy+A924JfUZBJctNjtekEz3GhXxJDmfS5o3CkhH3p4up6vJoRdm0WH4B5T2C9vCY+5O2v3ygFbb/xkbeyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAg2KQi50JVxuGJQYCMWdpXkXG6zoWKS4w4k9gqjiz4=;
 b=QPUnTdg35XAFu6UFZuvYnL5zyNw9OYsy8Bw4PPWfE9aKTJtOtGQZuQ6ndiGaGsXEzsjqewYirpNmeLnbSREv7b+9Sj9mGp2FbTfN0yqDJDLtDyMujIUo6gqHBDFPbMnNG4L+mamJCiQz95C22sPErJqL8w3OjqPM4TmKzLbdBqbhzuJc4/Ai6Ag7D4ZhrHudDGcz54DR43meso+8MyRgcVpw2ORDKEFs1+9SEh3R9dmxD/Zy50Ydh3gDQWndeuZhp+LQg3c1agDklG1TIBb/Bssr1k5iqlnaxVPoeLStz/jwa2QqJjRz/xzT55FXQy6mkhxTQeXUPRYQOtDOJyDkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAg2KQi50JVxuGJQYCMWdpXkXG6zoWKS4w4k9gqjiz4=;
 b=cE8GXJKIN8jPi+VqzWOPRMmCyOiNT1WRy3BwQtC1GnG9W7a2TaULUMgTAZKpINaZxdVvZo7q2dO/n2AcWGa4RCWmkEBLtcciZ+Ez6fav2VyDMGUznyAfYnbzdvrRvEdRVBNlLcY8hM2d0BdEB7omUY0fbMx8zpvUZ9WgsL5TVjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 19:10:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 19:10:36 +0000
Message-ID: <d524bc5d-b81f-4c99-960f-3087f0e2760c@amd.com>
Date: Wed, 24 Apr 2024 14:10:31 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Dave Martin <Dave.Martin@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: Peter Newman <peternewman@google.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCheW=Jz2R3gMKcgwQe6ONDrRqu3tUxeg=A3USg6BC8buA@mail.gmail.com>
 <7ccd59b8-9fe3-4d1f-82f5-f33d96dbf5ac@amd.com>
 <ZiaRewZJnLaDSx3m@e133380.arm.com>
 <004dcaeb-30ae-4b27-895a-4025a670fcbf@amd.com>
 <ZierjRNDMfg5swT8@e133380.arm.com>
 <a5029ad6-3e5e-46bf-881f-950a8a393956@intel.com>
 <ZikULOsS+AtXaeQG@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZikULOsS+AtXaeQG@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:806:24::9) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: f07098ab-776c-420f-a8e8-08dc649238bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2k3VVFrVDk4dHY3N0o5U2tmS3FjT1pScGN6WWZLQW9obFdmTGpKbGJ0ek5V?=
 =?utf-8?B?akZ5cjJVU2lTalVleTVwZ00rSUpqQ2swSE1McE9RY1pYK29aQkNKQmViUDRi?=
 =?utf-8?B?OHhyd2NjdVlBckZNR0g3clpUaW16N2JaMHlSL0N4VEhFMnJ3ekNKS254UFBU?=
 =?utf-8?B?RXFud3NNOEdrWTZIQ2liaFcrcHgxUnBrMW1EaU00SGxnWXMxamx1RUhuOHNZ?=
 =?utf-8?B?ZEpsWDFuK0p5VjZlblViZnZDRi9ER21tNE5ZdnI1bytWdWtzTnpWK1BpUWJq?=
 =?utf-8?B?amk4MGZVck9iUDhOemZQSjFqSEVCUmJrV2NnK3pWMTRFUDZJZUU1UUU2M2N0?=
 =?utf-8?B?Y05Cb1ZkK3RCTHl1dVRUUEN0d2tsd3RZUXdIOEIxbjREZkhLVVFQNmo0bTZW?=
 =?utf-8?B?K1lQcEZROVNyUTA5em13Y2R0a3k5aUxvREh6SHowY0tGbEtnMWozT0JMZWZt?=
 =?utf-8?B?VVJSN3ZzaDhHRkNVY3E0VUFnVHBCRTIrclRkL2RyQmRtczhlUFdPWVlyeDRo?=
 =?utf-8?B?TE5iZHV4NUQ1OHBvZDFRYnYxRzBUOGQ3UU1qWmJ5aC9LV1hKYXViaFI3a3BO?=
 =?utf-8?B?SDZUVzRuVU5EdzU2M0NrNUo4MlBQbE4xVVhNOWxHQ0ozc2FyRmh2RERxbjB4?=
 =?utf-8?B?bFdzc0Q1bXo4RXQvbnI4MXNKS0MvMmtKOWc2alF5OTM5OXZ6TTlWaEJpd2pv?=
 =?utf-8?B?R1lYZXZuYjJvTXJVTkt3aHZnOWM2d1UrczNhSklXQkIwbzJLMGRwS0plS2JI?=
 =?utf-8?B?QVNwMjNWT3RReDhTR0JwRmhoK0g2dTdMdXo1SkJPKzFDTlFQZStvdjU5NGxr?=
 =?utf-8?B?eU10MzExdlV5Vldzc0huQ1hHRHROWURoU2d2VHhiejZpbUJYMnpTMUwvNzNN?=
 =?utf-8?B?MXlWL3RMZDFybW1IallES28zdm5Qb0ZCWHQ3S1RNeUhKbUFPdlZibEdkTXlS?=
 =?utf-8?B?Y1diMFRQSXVJM09sSHN5bTBTV1BMSmRKdjJ4VmEzUEFONGJ5bFVtdFlHYUFo?=
 =?utf-8?B?MytCaXhFR0ZVQS9DeWllT0YvMUJtVzRNc0JXenV2dVZDOHIxZU1uMFdOTWxa?=
 =?utf-8?B?TStVSTRmOFloOTVyNlpwYVN6YlZUUVdDbWFENVJ5NHRzMHdhazZTNklmdnM3?=
 =?utf-8?B?dW1PZitHd0lQY3hWdzM2V2JObkYvZ1hzbG82cVpJMUtQb1IzdGxDV2x4R3U5?=
 =?utf-8?B?UERpOXV0MjJCUllvY0VaVStsMHJ6Z0lCcVBUekJFWkk1bGs4NGZBaUpZZUJC?=
 =?utf-8?B?eGpNVWVMRHBQaDVTWHNlV1RFUDhsMWpkRzZVV3pQTGkzNC9KTWZJeSs1KzhR?=
 =?utf-8?B?YTJIbmo4SnR5L3U3eU5EYnpRcS9IK01USWtpWHJ0UWxJeDB2c3JUcGR6eHla?=
 =?utf-8?B?bFM1dmVDb2wvWW16WkpqOHVQZUVrOWh0ZHA1amkyOHYrWDFxT05YdmYxeDJn?=
 =?utf-8?B?ak5kZzhYbDRJZU1VNjA5aVdmZ04rSUxpeTB1V1BsTFBtQW80UjZJTG5aazNu?=
 =?utf-8?B?bVRCdGR6NlZwWjI3Nzh6bUMrQmx3bWNKZ0ZhTFVCMFRydzhKWmJPaXpvVGhM?=
 =?utf-8?B?MGRBNVpRTk1yK3krdEx0TFZ4UFNXb1RlUGltL1lvYnZHa3VubG5BM2FwaVpP?=
 =?utf-8?B?MnYzYkJyWlJjOWlPYzdUSkJTRlN3VFZqUm82K3ZaSHVwUDk5bFNLaHI0R3hM?=
 =?utf-8?B?UUVOem1lMnhyZWNKUDdaVnpET1B1TWc4SHk0QTJjQUsweVVUT1pBODVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2NXa2c1cTErVmduOFJXcG9McEVEeUhJL0szZ3kyNlpMUWlGU3FuUkkwRWUz?=
 =?utf-8?B?Z21zRlp1NXIyaGFHeEZWR050emoxRzFyNGljenhxaFk2b2ZhbGpvVU1ibHpV?=
 =?utf-8?B?eTFnV2JkRkJYSjR6UmJWaDU5aXZMRktWWGNLMXk2M3NRM1JIMW5pR3RtRmc5?=
 =?utf-8?B?UGNHQlZUR1R5eWZ6MXJ1bS90U0VaWEdldGxhakRYS3JueFFyM2ZtU0grV1c3?=
 =?utf-8?B?Zk80OWdKdVp5bkdkSjZuYm5sVjBtdzdUdDFDY0Nia0p5a0tOckVDT3hDOGdY?=
 =?utf-8?B?clNhUk5lZ3BEU0x1dXZkdlUzclA1RVNHcXd5cC94TVNEcFFqMXhLNXBxNWQ1?=
 =?utf-8?B?U25qTlFPd1NZa2VxdnpXcHNKdzY5MkxZTVN4SllQWnBjMXlLTHFQcHBQNitj?=
 =?utf-8?B?a244QzZQUmJBdXRWRHpacExjNDJGcjcyS2JlV3I2Y25vQkxKRXdPdU9FZXg4?=
 =?utf-8?B?bEpKYXdwM0RWeFY0Kzcwc2RjVU4wUFVjbnh2M3pjeWpna3d2eDdXZXBqWXA2?=
 =?utf-8?B?K0FjZEZyNTh3Q1RkeExtWEJveDFrdEFpOXZ2TG0vMlpNLytqYmxaVGZmU3Uz?=
 =?utf-8?B?WCtubTBmYWR5aVlzUWNMVDM4aTlPRUJQbmhuRU5wYWZXRUk2K0FkdzIrSVgx?=
 =?utf-8?B?dWoxNHo4aGsxSElGVWFYRzdJbEFTSUdxTlFLbEw5eU9hd01ZQ0M2a2FheENz?=
 =?utf-8?B?U1BxaGFJSVpmQm0vdlZMRWJ0UkRNSnkwOE1XQVk1dzU2dFArNzlrak5KN05E?=
 =?utf-8?B?dGQzNHN1cXF5cWVYUUN5MC92SDBjdHVaRlY4ZmJWOFROZlpNczdKRzBqTFZU?=
 =?utf-8?B?L1JLUjRHVkNuc2N6Sm5kUFpXS1ZYeDBiN1BqeDhwenRXRnNCQVd1TXJSSTBV?=
 =?utf-8?B?SHJPZ1NpUVpPS0s0M2R6NG5HR053aWVFSGJkOXFGME5ERDVTdTh2R3JsN3N2?=
 =?utf-8?B?V3doZ3RJa2RLMXpZbHRLTVhORlZuN1ZmWFl4QXVEa1ZKQXM2T3V2TVBWRTNP?=
 =?utf-8?B?YU9VL3B6N2p4bGRWZklWaXBrVnFaK1hlQzgvc3QvRWFlcjB5TlFFZVExNHNU?=
 =?utf-8?B?b2VLN1c3NGcyMnZrRmNOczdwNzFZQWhUTmgydFMzVldWOGNUeVdOckFiUVV6?=
 =?utf-8?B?R0NUMkZMVm43Si82R3BZeU9zWXhvOEkrMFY0RXdCQytRVkM1VFdjeEpTdGwr?=
 =?utf-8?B?TXpkRjd2Nk1TM0k2ejZONWdDcVQxc2NXVVpxOWNRaWt0ZEF5RGtiV09oQ2U4?=
 =?utf-8?B?T05pT0p5RGVQRWlseVNkbHNPQnRLWGRYeTRUdTB1dHY4b0RwK1JNTUZiemc1?=
 =?utf-8?B?STIyVWs0aGRSNDVKOVpCNnNxdHQwYmlMMUMyNnhkb1hORkk0Tlp6eWhoWjRr?=
 =?utf-8?B?aGFwUUY2NmFnS256VU5jU25IUlVRS3BYbDlVeExCYzJ5VnF0MFNwZ1I4M3E2?=
 =?utf-8?B?clBOYTM2WGZzSWdzR3V0UVBKTjVUamM1RExwckJLTjVpNDRCeTJPRXdkRzBF?=
 =?utf-8?B?cXllRVpoYXZUL0F0OUljOHVDRTZYQUZDblgyLzl2R3lYdU1UNlY4Z092VWsy?=
 =?utf-8?B?OFNmYjgzWTNHUzhFSXNzbElkcFVmcndwdUlQZGFQYkUrRjI0L2YwQkkwY0Zh?=
 =?utf-8?B?TnNNWTMzZE93Ulc1dVM2UDFIN1lFQStmYXFXMkpaSWZWQXFZa2hmNEcvV1li?=
 =?utf-8?B?NG0xQUdCZ2FJMG9TZmVjN0NwTmM2TytFdEdPRVE5enlXek9nZjhiRjFmbW9i?=
 =?utf-8?B?N2FSZlRpOXk3NjRKc1ppY0gzRUNiejBHQ1EzdTdIMnF0TjZRMzNoSWlTM2h3?=
 =?utf-8?B?RS9ITldRVU9LcWY3REZ6Q1pQL1BMZHlhbmxDeDVqL3dsSHZBMysrd1NGWTFP?=
 =?utf-8?B?eWkrOTN1L3kxeTN2cUtZUUc5Q25OUzVzOTZPckpMVDVVcDJGcUJpNjNqQVJs?=
 =?utf-8?B?R29ZRi91L0o1QmQwZXVzRGtsbWVHTVdLdk1GSGtGYlh2RndZYVNHdGVIQ0Z6?=
 =?utf-8?B?dmhoaHpYcjBxaWREQlBMK1RnOEFnOTdHSUVGbmRNNFVwQ25kc3Z0THZ4Z0k4?=
 =?utf-8?B?bmlmYmRKeXAyOHREM1hYUVBENjBSY3Z0cDR0cGZaaGZGdWdva3BiSFE0bzJ5?=
 =?utf-8?Q?e42Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07098ab-776c-420f-a8e8-08dc649238bf
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 19:10:36.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcVDh1YiDcn0g+woauxLJSzhLTgHXItIbg/p+/1X70m4/rMUJ+ujN9FqfuScwsTz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389

Hi Dave,

On 4/24/24 09:16, Dave Martin wrote:
> On Tue, Apr 23, 2024 at 09:15:07PM -0700, Reinette Chatre wrote:
>>
>>
>> On 4/23/2024 5:37 AM, Dave Martin wrote:
>>> On Mon, Apr 22, 2024 at 03:44:26PM -0500, Moger, Babu wrote:
>>>> Hi Dave,
>>>>
>>>> On 4/22/24 11:34, Dave Martin wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On Thu, Apr 04, 2024 at 03:02:45PM -0500, Moger, Babu wrote:
>>>>>> Hi Peter,
>>>>>>
>>>>>>
>>>>>> On 4/4/24 14:08, Peter Newman wrote:
>>>>>>> Hi Babu,
>>>>>>>
>>>>>>> On Thu, Mar 28, 2024 at 6:07 PM Babu Moger <babu.moger@amd.com> wrote:
>>>>>>>>    The list follows the following format:
>>>>>>>>
>>>>>>>>        * Default CTRL_MON group:
>>>>>>>>                "//<domain_id>=<assignment_flags>"
>>>>>>>>
>>>>>>>>        * Non-default CTRL_MON group:
>>>>>>>>                "<CTRL_MON group>//<domain_id>=<assignment_flags>"
>>>>>>>>
>>>>>>>>        * Child MON group of default CTRL_MON group:
>>>>>>>>                "/<MON group>/<domain_id>=<assignment_flags>"
>>>>>>>>
>>>>>>>>        * Child MON group of non-default CTRL_MON group:
>>>>>>>>                "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
>>>>>>>>
>>>>>>>>        Assignment flags can be one of the following:
>>>>>>>>
>>>>>>>>         t  MBM total event is assigned
>>>>>>>>         l  MBM local event is assigned
>>>>>>>>         tl Both total and local MBM events are assigned
>>>>>>>>         _  None of the MBM events are assigned
>>>>>>>>
>>>>>>>>         Examples:
>>>>>>>>
>>>>>>>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>         non_defult_group//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>>>>>>>         non_defult_group/non_default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>>>>>>>         //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>>>>>>>         /default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>>>>>>>
>>>>>>>>         There are four groups and all the groups have local and total event assigned.
>>>>>>>>
>>>>>>>>         "//" - This is a default CONTROL MON group
>>>>>>>>
>>>>>>>>         "non_defult_group//" - This is non default CONTROL MON group
>>>>>>>>
>>>>>>>>         "/default_mon1/"  - This is Child MON group of the defult group
>>>>>>>>
>>>>>>>>         "non_defult_group/non_default_mon1/" - This is child MON group of the non default group
>>>>>>>>
>>>>>>>>         =tl means both total and local events are assigned.
>>>>>>>
>>>>>>> I recall there was supposed to be a way to perform the same update on
>>>>>>> all domains together so that it isn't tedious to not do per-domain
>>>>>>
>>>>>> Yes. Correct. Reinette suggested to have "no domains" means ALL the domains.
>>>>>
>>>>> Would "*" be more intuitive?
>>>>
>>>> We could. But I don't see the need for wildcard ("*") or ranges and
>>>> complexity that comes with that.
>>>
>>> For "*", I mean that this would just stand for "all cpus", not a generic
>>> string match; apologies if I didn't make that clear.
>>
>> (reading this by replacing "all cpus" with "all domains")
>>
>> This sounds reasonable to me. It may indeed make the parsing simpler by
>> not needing the ugly checks Babu mentioned in [1].

Sure. Will plan to address "all domains" (*) option in next revision.

>>
>> Reinette
>>
>> [1] https://lore.kernel.org/lkml/7ccd59b8-9fe3-4d1f-82f5-f33d96dbf5ac@amd.com/
> 
> Ack, I meant "all domains", sorry!
> 
> Note, should we try to detect things like:
> 
> 	<resource>:0=fee;1=fie;*=foe;0=fum
> 
> ..?
> 
> Either we treat conflicting assignments as an error, or we do them all
> in the order specified, so that assignments on the right override those
> on the left (which is what the schemata parsing in ctrlmondata.c:
> parse_line() seems to do today if I understand the code correctly).
> 
> In the latter case,
> 
> 	<resource>:*=fee;1=fie
> 
> would set all nodes except 1 to "fee", and node 1 to "fie", which might
> be useful (or at least, convenient).
> 
> If we're worried about that being exposed as ABI and used by userspace,
> we might want to disallow it explicitly.
> 

Sure. Right now we are not planning to support domain specific
assignments. But, will plan to keep options open for future support.
-- 
Thanks
Babu Moger

