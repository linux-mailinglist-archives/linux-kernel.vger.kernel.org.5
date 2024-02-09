Return-Path: <linux-kernel+bounces-59945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A184FDBE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C136B29D2E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32FD1EF01;
	Fri,  9 Feb 2024 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K6LjmmXP"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC21DDC5;
	Fri,  9 Feb 2024 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510920; cv=fail; b=c+Talj9mPYa07kp3L6oZPd5rMK+JBsRRLvjTPF0+rIYdI5em+VZqT8qx7eJJ5k28RtUaAF2AGwpUspRzyf0RauENc9Th+ZGWrRMxZiP3cUSp94whbzsNl8sNfNEMeHlIMUcwFh7TRqh6nP0vNf6dWtJ/GPZpSgg9ktEGHyzm5C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510920; c=relaxed/simple;
	bh=l+KgR7ETxkQyV/vFWtKYNe7w6eHA1G6Tey31G8DYz7s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VM2NOlPVBGFpPqKj/tk6FiszfdHQIWQUzprGwzUNxFkNPE6MDIj2uLrybGOxb2fsOqh7ajtHTvp2W4OGexgRYiXGtT0z9Ar7c1Oc3NG+WxslFPlm+mnvOHB/KUTFF2E8SrlfjNHPbxcrDPePWRTTjA198KYQkBoLRIAP3on0RJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K6LjmmXP; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYCe1sy5IyKEYxRJMMAFmjvLYb4PeQ1dYfiGVgF0opUBIoOWGTXalSCfTQqN1lLUNiDPGqLSHuQzMSr9UqSEPxMgK+wfgbLiRE1decc32480JDSA+cFA5hh91hvQ1KcjmSmP8gDPE6W2MRjinDYZibd8YfL5GX2rsL4J0VdOm7qiICLNVApxfN5V0gut+bfzCXX7ydTMJUxgfCSL9ErEB1MACR8c6NGybrYU9kCHA/UAuKm51d/kNFaD21QbFy6IDt5IMCY0IxCEmRDy8M3qr3GICkRaH7lL3VUW4K0ex59ZlGHIkTLCqhu+oNUL/8Ax9WHPoUD5IEjoXCAS5X3xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTklqYitBO9VS6hxOvGXSChsyivJyv6ayh+ar4AVzzo=;
 b=XSo3vgAYAGfwjN54fTE67rTEpufy1tYQsC6nn8n/CP+nCDg6e7m2qq7vt0nXN+8Q0d75PsTkWtBWAwxxifGht7mgodwhH6ux20KWSLzd25k4EnHMMpoyyNwYDAlCIUGbOUqBpVKKC7yOIUUbd7CJ8YafnccBAAjtmjDw9NY5a2HZ+PkGWokn1aR3bbghdXUNPXUNLhmDEbndvQnTqUQ35UTyWc2q0P/Hr7/tq+rRf6C+jsnzJ9tVB035tsfqLtpIvlx5cZZK/FSkjfXg09wo7GGbB4eB55GcwEEakTd2aj3JlYG+aYL5XsoU0i1lfNUcAXxyn0qn1GWbTkxwj3o5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTklqYitBO9VS6hxOvGXSChsyivJyv6ayh+ar4AVzzo=;
 b=K6LjmmXPjBIA27ZuaBJO11B8YjHPlHYjq17Ox7OJgdGKpyDBWSQ31DLEWUWQdNgBvyBCtZpK3knL0+NpUE62YWotjkd/KcC9mNz4rkmjUNe2PASIsFQ5StQzopOiC8Xrr1JNHR6R/KBXv4Vet3bWGIiVr0zpnJYPYw+rOFtXi7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.12; Fri, 9 Feb
 2024 20:35:15 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7270.016; Fri, 9 Feb 2024
 20:35:15 +0000
Message-ID: <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
Date: Fri, 9 Feb 2024 14:35:12 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] x86/MCE: Add command line option to extend MCE Records
 pool
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-edac@vger.kernel.org, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::22) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CH0PR12MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 3767f697-6e3a-4eee-eaf9-08dc29ae9f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kpBL8uPl1XvqcG9/hERzvfnDy7iguakMOgkMTVF+Nu182sbxs1CsUPlBlDUhYlhWeNu++uWBeuliRDTZiw5Cr1VLNty8bBqDG6iM3q7/FlQrisFfxMcVKiAIUD+dnJ601HjxN2R2QioOWr/K76hcour3B1NacgIVUBX7z9gb9Qy3AiVbG67GTV0fMEhYx/ZlpciePCvCAwSVnzuRN0q9RQ1wWTeLjQ7xE7tPM/fCgiB8ouOXnupMa//UmJPAsMx1H9wSpKl/FjkqknquVXlJT6mK/PfZdyM90Mw93KUvKGB0fgrNq+bj7nonUNhiBTinr/YasetLThHIBeTfV9b8vGi4SZE/39OOADkRMbgA8uLWjBP5sPr4vlT7a3ffKbQ3MpRXbS770hm7M4sXRjCYZ2zfjbr4PXKpvFpGDh3Mjt8gFXbJQBpNcT947W9jK4CxEJnTbVg58V7w9EjwDM8eZOGVi79uRM2PEXbFNbqLQUq1wgC96rY9jeZ/BWZixe6h46h/OXT2tddFNeZdN7RNJ3bRu9jZ/9NFwKsAZGUzPuR17SVbGXoMLSyyhpJ9Kacf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(4744005)(6916009)(8676002)(4326008)(8936002)(66556008)(66476007)(66946007)(2906002)(26005)(38100700002)(36756003)(31696002)(54906003)(6666004)(316002)(478600001)(6512007)(6486002)(2616005)(53546011)(41300700001)(6506007)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1JQckRuR01WWnkyc1BrMldQeXVycDJoWW12RUQvVGZzZWZXNm12Mkc4WGxv?=
 =?utf-8?B?cVhZU1JTRCtFSVM3SmVSN2grWWNjUktIYkxNZVBNNTltTFMwYitudnRwTG1H?=
 =?utf-8?B?bDJxS1NQV0JBQjBXTE1Vakl1cVF4RFY1TGRicGw3dmlsL3gza3gxN1RWRklN?=
 =?utf-8?B?bGYrUWMvK2xOVDJ6RUdlNXJreUQ2WDdCVVVIRnRtd05OT1g1YzI5RFN1WFB4?=
 =?utf-8?B?NktCaE90SDlhRkN2Y0k1UEJPQ3A4eFU1MGcxM1l5cUwxQ0VuT3pnRVcrWGFx?=
 =?utf-8?B?UWs3bEJJYlI5b01WTUY3YTZSaGJiQWhzZ3ROT3M2U0VSNkVXZzVOL2pLaERS?=
 =?utf-8?B?ZjVvVnhxTDA4NFNnMzdEMnlHbFR5ZDFMN1NQMmMyaUw3bnJBYkw3a0JkRUh0?=
 =?utf-8?B?YUowTjB4ZXR5YzVpT1VpYnBEczFPQXdwRlFucm1jNFdOUHNZRlRMM3dWWFJY?=
 =?utf-8?B?dnJLSE1KazY5azQraTZaNko1cytZUTkvOEpXRTRUd1dXS2hRNkRvRE9tV0dx?=
 =?utf-8?B?SXpJc2FPOFVkSDU0aTZSd0htZkpjelIyN3pReExHVGl0VzNpWHY4dk9QZ0I5?=
 =?utf-8?B?cVc4NHhLb0dWdHpqUnplSDdWamZ3b3RXY1Q5bmJZeHZTdFR3dGZ5OXRHOWM2?=
 =?utf-8?B?dWlaaUpIWU8xYW9WTjg5bnBUbko0dFJaN1l0UytISVNEclNtdzZRUy81aUZF?=
 =?utf-8?B?QkJhMHlodVBlR2NLR253OGIwVGVvelIvZkpGSmZORDdQcVVwcXVxUEZ0QjJk?=
 =?utf-8?B?R2pYSURGcThVTmpLRXIrYkZiZ2MwRk5sbFRkanBlQ3BSU3A4NkZETmNEc2Qr?=
 =?utf-8?B?TmhVSk9UbEZxUEFPcjUrNlpQWUhaZnRuOWQycS81TXR0TmVKaXF2cWYvTlRH?=
 =?utf-8?B?anBEZWhpc1FxRFRKeCtZM3RmNUxyRm9KbFFKSWFkc29MR2JJRHdVZUVsMkx6?=
 =?utf-8?B?Wng2NHZGNVErQTRMMkUwcTMyWGUyalBOREhpZTZ2WEF5T0Vnd3N3NjBWSVd3?=
 =?utf-8?B?VEpxb3MrZ3M4ODlxYTRwQ0lzbnNuZStHTjJpQUgrUnk4QUZvRnVXRjF6czR6?=
 =?utf-8?B?bXVOOCtDTXNic2lYOXZVd2p4a1RSVWpoQnhwNS91QjFOZjB6NURuZ295UXRo?=
 =?utf-8?B?a0loc05EWjFLMCtCZTBoa0ZkdVJjMWh3bjc2ak5ZZzlmKzZZWUY0SVVxczZL?=
 =?utf-8?B?bzdQVEt0TWVwUy9qMUpTSEVrUnRPVFd2bDZWSi9aQVBFTHVFd3ZaeUs3Njdz?=
 =?utf-8?B?M3d0VndrM29NV1ZWSzNmUVVqR2k3Y21EeE9WalUzN29CTlJRdERydnZ0bmdp?=
 =?utf-8?B?cFJNMjhscFVWL2R5UFJOSEVaNzB6R3dIVlhDWmE5cFNsbkthdWc2RGxSZXM1?=
 =?utf-8?B?bmljQVJkZDRsZ3hPbS9RUDN5ajhsZVpMZHIwb005SUtmelAzK3A3VnJtM29r?=
 =?utf-8?B?UzNnRXZqenlBT2paQjdMNlR5Skg3S2g5NG8rRUVDaVNsMFNKaVVFTXc4N2Va?=
 =?utf-8?B?cjZESEtPNXo3cC9HYWxtOW5IMzhOZVRwQzZlcDJyWkx2MGZ1UjV2U2NMWkNT?=
 =?utf-8?B?eWw3ZDNBSWJxeWJyY1NCb3pDdkx2KzMvazVxM1RCM0tScUtWSnZFd0ltL2Rl?=
 =?utf-8?B?MW9PM1VHVmdIOVZRWkpRTjFVY2oydGU5MGd4Y1NhYkpqOEJlQ1pEOThpenhy?=
 =?utf-8?B?ajZseTBGYUFBN1BQTGNFNVM4ZkZDUWRyRkhpbWNLNTZtRTNSek5YczNyVWJj?=
 =?utf-8?B?NDVJSis1dm1CQ0xMYUNDbHZ2cksrZloxSE42dWEzRkFEdi9XdzJTeFZSWC9w?=
 =?utf-8?B?ZGVVYW1SY011RU5oM0RIVWEweUdvYVZVWmI1L2V2bU5wMjJ5Y2s5b2hjRk9B?=
 =?utf-8?B?NlRKZEtuYVk4NE9hYTlPWm5Sa0l6R2RNUG1Vb212NktrNmE1dU5nN1JNSnpI?=
 =?utf-8?B?dmp4elZZVnFxUFVwaStGNkxFcHpoemQ1bFRPM09WNlFaQk5hakJScFZFMXA4?=
 =?utf-8?B?eXVrUmZOdnFWaGdFcW5wZUJ3TElRbXVvSHNOajh4ZkM4TUVCaVROTmIrR2pK?=
 =?utf-8?B?eXluM0ZCVWZKVTc2b1JhRzN2cXkrNG15c3BieXBCdC8yenN0WTNkNmNZdFA2?=
 =?utf-8?Q?Na9anD/PIXOVUthiRHUb7ti0/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3767f697-6e3a-4eee-eaf9-08dc29ae9f55
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 20:35:15.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U03KcDBBJib25wZAXrfyvUn0Of0sk45+D0q++cCF6yJnZKhbzhuO5YC1JPo3s+58Dqer4P+aGGi8zVtEgc/LdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027

Hi,

On 2/9/2024 14:09, Borislav Petkov wrote:
> On Fri, Feb 09, 2024 at 02:02:49PM -0600, Naik, Avadhut wrote:
>> Is it safe to assume that users will always want to increase the size
>> of the pool and not decrease it?
> 
> Why don't you make the gen pool size a function of the number of CPUs on
> the system and have it all work automagically?
>
IIUC, this is exactly what the first patch in this series is trying to accomplish.
Please correct me if I understood wrong.
 
> Burdening the user with yet another cmdline switch is a bad idea. We
> have way too many as it is.
> 
> This stuff should work out-of-the-box, without user intervention if
> possible. And it is possible in this case.
> Okay. Will drop the command line argument.

-- 
Thanks,
Avadhut Naik
> Thx.
> 

