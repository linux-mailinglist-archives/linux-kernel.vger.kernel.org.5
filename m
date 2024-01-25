Return-Path: <linux-kernel+bounces-38858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5902283C75B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2BD1C23054
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6574E03;
	Thu, 25 Jan 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CKulAUyI"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167687319D;
	Thu, 25 Jan 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198189; cv=fail; b=PM73bK96so6PE6df3h95EVV0G1LoE0opZ/PqujLeAt/EAMURWB2cXXtDP9B/P/xGbz0lUq237u4tcYInfMdW0I9HJ2x5NJFMWzPDMAPAZTeYvqkEE6TFdutpIeGnQMayXgyzTmRxhjevjheTN+qoeb7M8gaiw4qGIn1mmuqRHrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198189; c=relaxed/simple;
	bh=010TTgu4RACjLBJzR5kmWlI73ObVbiJeK26fHJqMdvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AlYas4lSIHlymf60HWRpTA3r9pkLw36u9m9+gSb7i2oBuEX9xgprmWfew0hovEDKSUI//9e3u5eEnme5a/QDPoJSCzQwilHndoi2MQpM4ttaIAnjKzNgeMEmPZsXOGh7gf4C6tXNq++rgVcFR56+0WJ4/1THUT7kiUkxkoesWmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CKulAUyI; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSxBJbtspT5p5mP/FlZPzZWwU0Q0fW2DrrzKIU9m2h/kcXHOCKqh/5OFen4dr8Cpcxjpqt77jbXYeT5k6wGTM98kEsP/e2YzD1Hv1Jwe0lXRUx6IsHlmDj4auJCc6HZ6CXPdXmtJB7yvEAlDK7sQ8m7/DqWTcgQnk2a20AqCaZMhR+l8+ovMIkE5frWcpYIVcwKXyTRTszr+e9bHL9FbZekq0Yd6DpcucJteQ22dm9YlseGcwCRxMzo/cUs17XFRJWcW+UJvEVULAXXzY1dVgu00JjKySZ9ly/fsN4LGEu/KmNTnGZWlWsuSnh/CyG7CLn5nqe1z8597op2HIkO6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB3lIAqb3pltzsRO/mbFcZOL1sHNLUEdeKNHg+kMyt0=;
 b=KBvwnbpDCy5W9+V91LYDwSKvTLoQtBLXr98mlD7LY9fKMZYNm72TM4c2DRkTvtrlFjW4+Xe4vrwhACpkE9clNFyO7LeUrdM5VbWjDhnFiqRgLjmo/ipMFy+llLv0xoDz6WFUcr0IpEbJI8Bp0CZqY2wKCa/u3nzhkRbpwKDdjy06rBpLaL5Ve9IOt17LkCiCCnypZxFIF8Lti2sXL8HZHfUrWOndIzPtD/rPxU8GFPJBC7jMHa9gjrc9ZS2v5vpZ/TILQlXO526BhuSeMmhZKfNMbolv4Bgm/KLKSG9efq4kFrtj/wSfdImM7ibqBW/G3CIz+EOmEtjasdzssmQeyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB3lIAqb3pltzsRO/mbFcZOL1sHNLUEdeKNHg+kMyt0=;
 b=CKulAUyIfPt/+KlNg7HYdMblxzXDpraWC9Jc348Yem6t2dVFnVC1AYue5JHZFE0996S+8dHEGJpbxIlnlLcOv5t4oU/XHTyTR9rtINYRfxAKXlpEqJ3b5ukWPOTQYSdRpzT9islJYs815aiSAJRbD6r/bgUTL3uiWl6vx/E8934=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 15:56:24 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1%4]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 15:56:24 +0000
Message-ID: <05156615-8dcc-41ec-aa6a-aa41c515d25b@amd.com>
Date: Thu, 25 Jan 2024 07:56:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH net] octeontx2-af: Initialize bitmap arrays.
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>
References: <20240123051245.3801246-1-rkannoth@marvell.com>
 <cf035125-d7fb-4423-8f64-a5be7505243d@amd.com>
 <MWHPR1801MB1918035FC2D71BD916DE716ED37A2@MWHPR1801MB1918.namprd18.prod.outlook.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <MWHPR1801MB1918035FC2D71BD916DE716ED37A2@MWHPR1801MB1918.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9a7830-2471-41b1-bdeb-08dc1dbe2eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ecr1cQ83z7MvBwNclJi4z62gJ8PBQI4ugefEnUoC8aAl2Yc/weRwcsjjPguJpDbw8zLuavXFMApyi9t/2wk6o40G5h0OzzZ3WPXegsfn6WhaBu4tqAR2XCchZn6Z6+ADOQxpmoqjNE2BM9b24ccRdXbIsckbgMpY7tLK6mmB6lQLEJWdCU1YzefQBRsrhHGPzPAqcA4HLgT7q3qWdYRl2LFyDomFSaSZLTWkoBa43ykrdeUD0cFVno9TP/f+m+OVX4lNn2t7jko4ar5RW6F+Xqi01kRDBmlrtSkVbcGnXXB0hQhtSqU889kN7ZcQQvbF8HeWdynJDJBeza6yOEv/g/AwSbfRI68REZHqQ5GC8At8M7IHiozPspJ6YWDEHACQVWf5DMBoGOeHl5a4rUwlJgr0BVVYPXaA34buWE0OBtazBWTHFnlCWgkToxUkEVYDxDA0RJT91ZNa3dVCI9GfdSzWrgtUdOuHTL1keoj1UkqS3nzuwUuTD+nUzAYHdQtSkddR3zQ11tJ1BKiyHC8/wZT1EsCb4AVX/R9uHUo6Bau8oR8SBTU0s6TOFfCqfFMmHRnsmD2lVvu6/jxOdBmQrPWISjARk2AdOt3OASmbnQuj/SWCSFXhIoJ4/FacfD+g/raNxS74oii6Hoa50+RbNC70vTsVNTTnUSFjlNrwS4wtX9cFXV8ozxMVDCvu/VG1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(4326008)(8676002)(38100700002)(7416002)(31696002)(36756003)(4744005)(2906002)(41300700001)(8936002)(66476007)(5660300002)(66556008)(66946007)(110136005)(54906003)(2616005)(31686004)(316002)(6512007)(53546011)(6486002)(6506007)(478600001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE9LNUQvUCtVNngxMzB0bTUrMVdrODZ1dVIxRFU1eXJRNzhZUjZLT3pZdWJr?=
 =?utf-8?B?WjRvRlpDN0F1MGhlcWsrYkVZY1B3TnpOYzdxWnNQa0VCZG5KQmxMcDhqK3Nm?=
 =?utf-8?B?SWMvM3hDek9kRkJqQmx4NzI1OWh0ZlNCenVzaEd0SWdVcUdUWG8yM29FNUJ2?=
 =?utf-8?B?b0RvcmdUOXJJK3ZsY2hwZ3JYS0Y1QWFIY1pMYTNpcDBGV24wcEtDQWJwUlZE?=
 =?utf-8?B?OGxsOXdkb0tjbVd2SlZOZXR3NTdJclhrU1NuNmJNcndGUlE5d0JDQ0gxem5B?=
 =?utf-8?B?TFRHTGJnbnRvT1lsSld0LzVCV3BnN0xDNWZhQlFVd0RhSHhiQmJwS0p4Qy93?=
 =?utf-8?B?VVRCVjFXVStCd0UzVUROUkx0eHZLT3ljQmJuZmlsNVNxbGdscDdUcitZRElP?=
 =?utf-8?B?Q2kvRVl3SXBYbGJlWHdYTThMNE1tUUtUNHU1bmZ4QmJiTkF4dlJYUkpnRFZt?=
 =?utf-8?B?MlNLZW1UR0F6T2lZeVBQaUJQeFBVY09USS9INkozdENpMlAwZFlFcHhSRzRS?=
 =?utf-8?B?YUhYSHpwZk5zcmpYNmNmcU9rY3p5ekJ6Zzl4UThQT01jYlJsTDRPNG1Eenhh?=
 =?utf-8?B?UHptelVSem5xVEljckRCMnp3YkIxSnczK0h6d3hORDNQb3J6anUwQnZHMVNs?=
 =?utf-8?B?ZHl4aFNVVi9vUnczTzFYWkZUb2l5MTd6MzBPeEZSY3h2NTJ2Vk5YUmRzUkkr?=
 =?utf-8?B?dG10MVhTdWNVR0dBYjlYaXJXQ25SQzg4bEhvdVUxTUs0d203ZkorcGlHMzEy?=
 =?utf-8?B?QUxQYWFzaDhHa1VoR055NXRtdTkxMEZCbEFBdW5qVVoxTS9oekZtY2dvV081?=
 =?utf-8?B?b2pOM3MyTERydndGWU5DSE9kWWllbkZyUjZXeXJ5OWdyc0Z3NW5lR1lLTlBN?=
 =?utf-8?B?QVBwU0I5OXdiZ3lmQnY2dm5zSWs5OUdMSVFDbkZrSmc3K211bTYvRW1YZTd5?=
 =?utf-8?B?MlZ2bWx6dFFPR1hoMFlXR0lJN3FNWU9KUTBEdDRTekoyVCszYTNRZFBDMHNX?=
 =?utf-8?B?NzU4SVplOWlPRlNxM25jd1B6UlV3dWFaRzltV2RLZXZ1UnppMGRUQjd3M2RJ?=
 =?utf-8?B?eHp0Q3R0K1o2WVRXVXJNTDlacHZuNU5NaEptbE11ZXo4MnBtQXNPSUxQVzNm?=
 =?utf-8?B?T2FZaHBaaXd3UEg4Z3dia0JsVER2SmVSUjk1eHl1QXNaTDdNRzBwQnJVS05N?=
 =?utf-8?B?QnpId0Q0RVNNandGTUNpYU9VVW1qZStrNUU1eUVKcU1IMVJHSWQ5TDZ3dzcz?=
 =?utf-8?B?ODNGSEJ4M1FZOEJDNWY4UzI2L01QSTM4ZWVySVdDWU1hQjRUUWwxWC9FTmJz?=
 =?utf-8?B?RGhpOHhLQ1ZvVkpsWm5rR0o1MThoeUgrTVl6NE9SYjJ0KzFxVVJGUWh0Wmhv?=
 =?utf-8?B?Y2RMZEtteDhIVXV6T1FvMGN3RkxWZmt1clp2Mm8rMGV4dnQ4bHpROHFyb2hy?=
 =?utf-8?B?YzhySjJrOFdRVm9KTjBZVVl1WFR2ektsYkxCYzd0aWxkaWRnVUFadjVMZW9u?=
 =?utf-8?B?OW9ISVNQQU1UdXdSNFBjVSs2NkFTL2RWQ0ZCSXNWOEZsbVE1YytST3FVVGE4?=
 =?utf-8?B?V2FUY0cvbkZYMDRYZTVNNXZYc3FpRE9hSmJuZlhpNThvckRjWHBsM1N6a3Rz?=
 =?utf-8?B?a1JYcnhtSmZ6OXFPTWRxc3I4MWN5WGpCQ0VtUnMrYVJPdmozYzFpQlFrdExB?=
 =?utf-8?B?SUNHNm9FQisvK1ZkMEdPSHJRZnZLU3VyQmZGR0JmWSs5d3l1UlU3OUVYR0JX?=
 =?utf-8?B?cWRZV3RFdXd0N08rcFRJRzdpaU56UjR4NWZadGozK21hWnBLVDNZLzhmNEtF?=
 =?utf-8?B?TGJ3akw0ZUcxeHFBNWhmRkZROHRNbGlHYVN3RS9TOHpYZlVvSUtHQnNtOVdF?=
 =?utf-8?B?Z3lmNHN4Umo1VVlQZ0JlclI1bGlzdVI0Y1JFN1VxcDZNeHJwemhkbUlnemFw?=
 =?utf-8?B?QlZEZHhubjJqaU9uS2czQzVCS2c0UlNCclBpcTJrenpndGlNWGRDSGFTYnkw?=
 =?utf-8?B?SkJxUnB1TzhWalNiMFpISWEvWTlqejcyemdNTXdjL3U3SFZmeVloZ29aMktK?=
 =?utf-8?B?dVkyQVUrdnNHemFINW44bzJsS0E1YVlnb1ozTTEyZWJkR1NlV1hsZHFaUnZ4?=
 =?utf-8?Q?tvPQP2puNomovFsTlWkAaNzmZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9a7830-2471-41b1-bdeb-08dc1dbe2eb6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 15:56:24.5722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ufgpCQGHVQvUq92RV49PYV2sMvRrJ0q/H8jq4HyIzjxg2PliPzf8dIn9ktfqIr1XlyJNfkbgpddR0xutmSrcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213



On 1/24/2024 9:06 PM, Ratheesh Kannoth wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
>> From: Brett Creeley <bcreeley@amd.com>
>> Subject: [EXT] Re: [PATCH net] octeontx2-af: Initialize bitmap arrays.
>> Is there any reason to not use:
>>
>> bitmap_zalloc() and bitmap_free()?
> Will follow simon's suggestion to keep patch diff minimal. As bitmap_zalloc() does not give any advantage over the other.

It does make some sense because in multiple places you are open coding 
bitmap_zalloc()->bitmap_alloc() in multiple places.

For example:

         mcam->bmap = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
+                                  sizeof(long), GFP_KERNEL | __GFP_ZERO);

This is exactly what bitmap_zalloc()->bitmap_alloc() are doing.

> 
>>
>> This is pretty much bitmap_zalloc(), except with devm. As Simon is asking, is
>> devm really necessary?
> Will use kcalloc.

