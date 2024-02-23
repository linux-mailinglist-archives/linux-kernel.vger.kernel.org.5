Return-Path: <linux-kernel+bounces-79079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5247E861D50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2B2B241BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38845146E6E;
	Fri, 23 Feb 2024 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ti/DZzyy"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA5145B33;
	Fri, 23 Feb 2024 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719088; cv=fail; b=IzRsLNI9LwGj9eFoGHWfnMjGNlW77Ug2yY6uAo0+NTx6hcDkVWQcnWPMwvvtEsp+r5fwR0dxN3iCSj1YnWPQwbrHHaU+52u59HYgYpDya9uu9UqMy6MoZw2O2srVqcXOVTdQsS+Gq0o9u3URdwKAv27RJ7ryVdkOhWwJxMdU5uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719088; c=relaxed/simple;
	bh=Lkt86Sb7ksqk7Q/b3fe6BzPi3orsGBQ3fqYW3YeuJls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U0x30K+w2EoR5TJMbBtRoNYmWTfYaEWEjn2aJ9j2XyWb+IF2g79KtpbHEDKTsJ0Ai++xXO5LGxdy68rklJ+JRe8ckZxPQen48ecbmbmJj9Z9MgmrYQNiLx75NpQ9fB7tYFnju2rtaoru/tZpfJ2c4LmIef4texCQwyTQQERhp6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ti/DZzyy; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig66DA9QzWAnZKQg2F+2lZjlpqqMX9fo7L7XxbS0CJUTcsVagEDULjxqqlp5A6OYCSlAzXnfTL5cc+N48NvSCYR4mrCP51pSnyh7q2pqcsCFonjfIXvfDlO+3mUS5kurXS0X3h5w/7v7RY0+F+HMUgWu3ISZud4YDb15jdKvMaYO2znoCMiAbzt4Bo+QZJpqNrbUofc2k0mJr34oXuo4q7ii+dRXY947quyKwh43izsdSs1VCNtIX45e/3mrqD91BHyrLtqU/JIhWctQrn2GKNW1FqCAFNpM+PpCCZPFWQXCab86TFQ6y0Uo5zMjrsncAEGj93Y3UN+3l1nil+MHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+juKTOJcZMhkPqVxmDILCZvi5XUU2Dl+V34rvefBOI=;
 b=jkELoxz4PJylsdkg7448P0ia2l/UPHq05OZk8oP2IUfa3zYfW6ctzmujczA1aUSHLc+Eu+DDMD+guOLorRrdc5ygJIIDJB0LulTKcYnpTOH5tXjhRZq/SqCge55fmw835uHWQE/gcmWrXKdy205Ukz3IL3B8K8my1sKXcc2MSDZ+58yHh+KHRDFi8OdHTOoI3CaULZnppdN5GuKVZS2F9cSwP37xadQyGfh/sUW30PmoLCrKyfl9+xyRHdMDwuvc1AIe4gchXeWo53cEKy72XOkPMkASusyurxQ6Y+4vrUFqyfXl1oAius5CHD8FcgEcJoav9awUbB4vCGyyzoawuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+juKTOJcZMhkPqVxmDILCZvi5XUU2Dl+V34rvefBOI=;
 b=Ti/DZzyyQ81IB+G7LtHGG5WoTSJNQrd5+8oSb8Py5ByoziuYsOXn1uPIAfftR65iLEwjKXFqdc5OBb32bU6b3uQrV1W9VMEniuQtjkwQv7S9Zb72zPwvGrDAU9NygilN+FYr09OYezeO0ABpM/oDZrTlY3naTJeCmq9rp70zSfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 20:11:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f4aa:152b:b46f:80a0]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f4aa:152b:b46f:80a0%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 20:11:20 +0000
Message-ID: <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
Date: Fri, 23 Feb 2024 14:11:15 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:806:a7::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: b838cb8b-443d-4ba0-72b9-08dc34ab998a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	738J4fuGOtlLfplhw6eAmSaHSmXUs5RUhBM4V9hf92Bwpz+N1HUuE3n1wRaq5HR5+OktG7EpK3Q4/gSEQDmIakwAloxKHOYHOJLn+FeDA96zmMIcpQ9sS39K9V06lILTBD4VREPYcsUz32rhiwI1X16JydNgEAQN6pHrvcVegFCDNnb2WVnreE8HqQnA9xWs+DpqZA0Oj5Y6Wecrmtajb0b8uBXl6uDGLzHNn+r/Mn7rxeL000JRm7OTJt+1HLkVn52Z3lfChGHklKWksDuu8VwGW8DL4Hgvc3yMFoZ/ZANNwFx7sMciG2LQuVB9MIk2LSvoMzVOWYjGjmLaasbTPpMQNTn2+jNBd1RqM5YtuwckCh73XcfZVS7I1PjcgWh7z6Os5hYao2zCLI11FKmkhhMMfEAT1KCvpYTWfmGpbNwVulE7NKLFRsoT4/P49DJWzbaAaO1azsVNo+9oCvnz9DuDuPtfGxctQthtwwog1w692vEVOXKm3yhI6T85QHGOsO7qS96vL0i0EDlKtkIsfijUy/WiSTSzKe2gNUFq9hU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXI1RDlPZHFzWnhrazlpNlZidWhaYjU0L3BVY0VkVzJMMHR0VFg1OG5hYVBO?=
 =?utf-8?B?a0NFdHh0OUgwOFFZMllGYlRvTDBmZS9OTG1TcDR0VmZsdXNtb1k4SkVDYjhl?=
 =?utf-8?B?TDZtc2ZmMUYzZDVXeWZuYzllZEdod1FWQmpoY0lGL2kvSHhYd2hZRlJiejlU?=
 =?utf-8?B?WEc0SVNWemMreGtHUlJoYU9rWDJRV2xUa2RvOFkxTkQxWGhzcTV0MFAzSStN?=
 =?utf-8?B?b3dHcDFwV0tEY1Bnd1lDS2ZzMUtheDBxNGM4eENqNGc2L0lxNWVMOXNGZW1D?=
 =?utf-8?B?TDdRdWlremdCVllxdEVqY2ZUMjd2RGJ3WUYwbmFzMEU0OGF5ZXZiNnhRZ2xQ?=
 =?utf-8?B?L1E5RkZSTGZMQXMweVY5NXpWWDNZN0hvQis3eEduTll1UU1KUjVMNFpVQjNv?=
 =?utf-8?B?ZTdJSjhOVWo2MzJ0c0pWdUlaWGpnK1pZSWJrc0VOVjcvb1cySlhjWnR6dzFH?=
 =?utf-8?B?WjBmV1Jhak9PYlFnWFVJZmZsRXBvRnRoMmYwcW9KQlFiMGhKWWhZWXd1UUFn?=
 =?utf-8?B?cVhGSEVOS0xYZkRFdG4vejkzTE9ZaHJaT3JRNXdBelNSVlB5dGV1N3luTVFq?=
 =?utf-8?B?Y2duS3B3QWdiVXV4T1YyeEE4UGQ5UWs4bURwZW5lcm1WYndLbkFjejc2dmVi?=
 =?utf-8?B?RFZqUjJwKzEvdU5xTU41TU51RTJMVFVPajEzd3hRaStGbVVIMlZGR1czTE5D?=
 =?utf-8?B?MXg1azd1NU9jbmtnVDBOYnovS3RONUZDaEx5cVdLK2p5WDFlRkQ1cmlOVEN4?=
 =?utf-8?B?dWRsL1UzWnpxVDdQdzRSSjQyejV2YkU1Vyt5WUR2M0owNitHUEcwdXMyeVd3?=
 =?utf-8?B?WHo0ZEszQkRwemwrUnNRd25RcXZJaDk0WWRvSzBrcDNUcWtpbnJxOVdZaWRi?=
 =?utf-8?B?eEtUUjduMUtqTjNRMmFERnVoNytQeld1QXlBdWxGUkxWRndKMTN4OStDSFJr?=
 =?utf-8?B?ek1uMW9wS0FSV1c3L0JUblZSNWxtTlN5eTRZOW1IdmE0VlN5aDkxMHQyaTFF?=
 =?utf-8?B?ckdwL1diQ0xITHhhaHBNSUVPZjkvdlBGOFp1c29mRTZ4eklaSmRrd2JXVzlY?=
 =?utf-8?B?c2VZWDhPZ0QyWi8vbEFuaE1oZjVkNHNGZUxJcStVS2hoUW11VWkzK0hReUF3?=
 =?utf-8?B?UkZVWTJwVWpIeUR1TFY2NWRGVmxkVkIxaWprTEx4b1ppNDFYUVZRakY0dEhI?=
 =?utf-8?B?d0dTU0tIUEVBTmlkVkd2WXNpa1JqdFdrdXdpNnNkUGZlSjRNaHNaWmtJU0ZI?=
 =?utf-8?B?WWVlQVNNV3hPcndpelc2UTMrdDFZTkdlSTRkQW9OTWJhZSt5WVpzVVpQQnNH?=
 =?utf-8?B?a3dwRkdpaU50RlFKNk56V0s0azhhb2toMENzTHpmYXU5VGV6TE5jSFQyNS9H?=
 =?utf-8?B?eFVpRlJzVTdFRUpXRlM1eUU2K3ErWGRCbG1uNnY4Nlk4aUd2UEdNWGRiQWdn?=
 =?utf-8?B?azF6OXZ6Szd1OUhaUWJxeWo4YTEyM2svQzlEckMzSXhuc2J6T3pGeEpVb3FR?=
 =?utf-8?B?SEFaMUw2N2pBMmJ0M1ZqS0JjdFJibGZTNWRhK0NNREdwOHRYT2VtV0p2Um9G?=
 =?utf-8?B?ODQyMHZQK0cyZEdZRFZKVEpFeVNySDVjbldpeUZrcEhhQmVwVjNDU2ZjN0lW?=
 =?utf-8?B?TlBlYTg4Y3lzeUt4WUIySGdLR0RyQytKZW9xS0dKUVVQWjJDUk8zcFk3anIy?=
 =?utf-8?B?d3I1ekIvN0VwUVVJQzd5czRTUUUycHQ3N25WNUpTUEdyWC9tejYzVUkrRGVx?=
 =?utf-8?B?Z2N2UWxSMmt5OVhuRUtIU2FJc2tWZG15TjVPYUR1bERLSUhWenhJZmt6S0pC?=
 =?utf-8?B?ZkFmZjhlY0N5ZVJBbEhPejNWYUJwT2ZXd3ptangzMFd2Q1JwZE43bjNKZlVF?=
 =?utf-8?B?K1E2NTQ2cFdFU3NCemFLVUpJWXJSNWFUaXNaa0tNblpwd0Zmd3JWVjhBWlI4?=
 =?utf-8?B?bGhvNC9lOU93bkJ3ZmNJbm5IdVk1RHNDSUtNTGJHOXNiT1NvODJucGRVVkdK?=
 =?utf-8?B?UzljUE1GZzJ5UFlXaUlSd0ttaVBlMjJrbzhOS2ZVaG5vSjlHeG1LSzJjTTZx?=
 =?utf-8?B?UUYvUVJJaTlLck80QUp0eUhuQm1KZ1EwNmpXNnE4QWllNW1URzlkTS9DdVBW?=
 =?utf-8?Q?DDsc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b838cb8b-443d-4ba0-72b9-08dc34ab998a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 20:11:20.1320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fxb3z/VoZlVfCeXi8JPPi4MkcSdjwJKBtMQKSqFkqgyIT4HVxT9R/2MOFiMXOxHV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193

Hi Reinette,

On 2/23/24 11:17, Reinette Chatre wrote:
> 
> 
> On 2/20/2024 12:48 PM, Moger, Babu wrote:
>> On 2/20/24 09:21, James Morse wrote:
>>> On 19/01/2024 18:22, Babu Moger wrote:
> 
>>>> e. Enable ABMC mode.
>>>>
>>>> 	#echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>         1
>>>
>>> Why does this mode need enabling? Can't it be enabled automatically on hardware that
>>> supports it, or enabled implicitly when the first assignment attempt arrives?
>>>
>>> I guess this is really needed for a reset - could we implement that instead? This way
>>> there isn't an extra step user-space has to do to make the assignments work.
>>
>> Mostly the new features are added as an opt-in method. So, kept it that
>> way. If we enable this feature automatically, then we have provide an
>> option to disable it.
>>
> 
> At the same time it sounds to me like ABMC can improve current users'
> experience without requiring them to do anything. This sounds appealing.
> For example, if I understand correctly, it may be possible to start resctrl
> with ABMC enabled by default and the number of monitoring groups (currently
> exposed to user space via "num_rmids") limited to the number of counters
> supported by ABMC. Existing users would then by default obtain better behavior
> of counters not resetting.

Yes, I like the idea. But i will break compatibility with pqos
tool(intel_cmt_cat utility). pqos tool monitoring will not work without
supporting ABMC enablement in the tool. ABMC feature requires an extra
step to assign the counters for monitor to work.

> 
> The "new feature" could then be viewed as adding support for more monitoring
> groups than what hardware can support concurrently.
> 
> Reinette

-- 
Thanks
Babu Moger

