Return-Path: <linux-kernel+bounces-67647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A155856E75
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95DBEB27C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4883913AA41;
	Thu, 15 Feb 2024 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FKydqjHz"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A7379958;
	Thu, 15 Feb 2024 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028298; cv=fail; b=D3+NeWEaf6e1Mfm7BY2GM88kDj++10xtAP6GyxxIL16VOjCS1oCXWnxnJzQWf3an6OlwK0wPt/E8S4RWDa3D1Y1OzbR5WioSP/nFmur1jQBxHpdhoS5Hol6cAL8Niqjbj4PimUub49sHYGKfuu2YL7l0CMf6jo1jKf2735keHaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028298; c=relaxed/simple;
	bh=hYzWHojqpqooQe/CdJ0w7uES7Wzd/X2cjx1lPwBFVnY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rmrUy1o35SAVlMRJLOzE3vz5nlpmj8dtG0V2jRGH27FBCPqlB93/9pArNHpFEnqDdN1e4SrbTAz7lNNVKPSGoH/L+nvxTGfafpjOEgUIA/Bmc5YXJvF6fBPDEv5Ux+7NDF6oToJ10zCEAkDntYyHDe385obqgmrPawKe7gTnM8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FKydqjHz; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFLA6YHZbBCTp8EXTbggR43Se87rs7lYfYziwCyGad1eLFfl7ctsQw961xWAjdr+354SfRzbvFnUZ9ZqmzPdoQY65uyzC2Oa3U2HX2+0Yhb5AB9KiJVX8yigNPgI4TZz9eBDo2xVNBiCX3VPVRrWE/HDQO+n09mWG7tF7vbTOxjLwINAqKNKfX7xJPg4XSw3Oen2n2XSEqhjEUhZ+ghuHquuUv3edEwgIUsipBu0LgVRjtgR1IP8Vihwko8Sht/vA2IscZnZdG4Mkd0Tto2CCeBm5xHoj0xN1ilcP9TcKsCWw06OxOVdbuXVIZuiz7mqMoNK0bj0pdRjXRVcGK1qwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r9bpqEJL/hqCtY57Oaaq3Rgauzb6E7jZVjnFHTT/hM=;
 b=IpTG1PRS+iecLgB1V21Bs8vSkLrHL0jsu/WwKPRlBbQKtAKojv03rFeCiuZXmtjmqUR/SyePC98NnkUov4yE580vFnc+wk9Y3nFsAIQsNIzE0cRPNpJOc5W/7P11C27iWC7FLoDpf8Io0dEUDRfTUpPi/tROgLkhTMR5JUYROm5Zzlt4sRtpE5sRex0mF6DBLY4HM71IMANWGkCkD7NNQyPigjQmj6FLdBbr2rCBERRi5jGXZxHUrGoBmKBqPBnhPGOlzu0LB/Ct1Q9R9ovm3qysoxh83QAEyWtHwbdX1x4nx+8LfUr4vp0sx7ITFxLLQUvGFHKGwgLGnK9sBFBRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r9bpqEJL/hqCtY57Oaaq3Rgauzb6E7jZVjnFHTT/hM=;
 b=FKydqjHzq4/m5cqyiT5+/ntqGZm5bMW1Rfh088PYonIGC0vxKXqNJVq++cbZc99qGdbU+8cpYIPEdp4ubX1PHF3t31UTZfuGLnRK86ol1EyzYgLQLzAaMRSnE9FGxWIW0mjPZ/hnqi6jYLS5FdnPj9qMisFdr/heyve5cHWp/h4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Thu, 15 Feb
 2024 20:18:14 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 20:18:14 +0000
Message-ID: <b730968b-6d79-4eb1-84b9-d1bb1d2031cb@amd.com>
Date: Thu, 15 Feb 2024 14:18:12 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] x86/MCE: Add command line option to extend MCE Records
 pool
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
Cc: "Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
 <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
 <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:806:f2::17) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: c914d6b9-0318-414b-ef3f-08dc2e633d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eAleqt8LavmqqrnNqKBeXx+h4Iv8PaqVGmlYGXni7pIgcG4NKc8DlZRZkX9h2/snguNlluB8CBxqegl51Tb3jc0kQlkeGQ3atSKvfKhFw/Ybmb31mm76JaewMKVKV5nwJWqDlTRel7BVI4HBxTKaHmxDTjdP8R2D7KdaVs5jzxWnzVdgpHsFNQltxCkiI3A7KoBA9O9qFjCDsUIQ65MhBv9MbQ3KI8S1JxzNko+vpY0+IIpkdA9sfYg3mT9S/wUutCHzYOBIrjGMz5fxQo/AibB1DlKL6ZTXGATM5jlEDZbJrHGqHD6SuEkMolySluJkf6dMqAXgOw4WX+F7SIrucdJA2/GfoAOXKZ99jUjbfZ9yihIQ2ptyJDmYkzpQWcGzva9YN/XE2kfWFpCfNmwDaS93jmFcr8KIxS4EHh6mRCGBYcfQikuRkGzgci2LfQrEQCW6xUtsSkv3FBxjATzzK2v+lX1UJofZSwrVg/4Vccbr3svzqMrX/PQ7iZliZWuFIG2o/zG8aebv+bLjb6ZVK/GQ4fWGirj/8fmz188rae28+z9iRMJKmYJPmjjk9sVo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(54906003)(110136005)(316002)(41300700001)(2906002)(8676002)(66476007)(66556008)(66946007)(8936002)(5660300002)(4326008)(83380400001)(31696002)(6486002)(478600001)(26005)(6512007)(36756003)(53546011)(6506007)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cklXRDk2ZkxPZ3FOSkpkcGczZXFvNVdPbTk3QTRwNUxSQmtqeVFJU2ZkTlNF?=
 =?utf-8?B?NmVZbURObmFzUEFPejFSTHVXdERnSHNWaVc3M2hlZW9qaWRtR25Lb3ZZZXha?=
 =?utf-8?B?Y0V4VzFZOFo0VVVXc0hPMW1ObUlES0Roa29wRlE1RmVnRzNNU0NuKzhVVEla?=
 =?utf-8?B?NzVodWM2Z1M2TlVtYlljU3cyMUtDVlFCL0x0b2lWb0tpNlFxOTNIYmo5aDdR?=
 =?utf-8?B?S1ZYOENRTG56M2lTekJEVXN2WnpPcm0yMDJFR0xKTG9idVpwSEgzcXF3K3BD?=
 =?utf-8?B?ZnVHWXhsS3M3S0dHYmJ0eEJrclFsRWt5aVlsaVdRZkVVTGk1cGpMVC9TZkFS?=
 =?utf-8?B?a1lQUEhZUG5kS2cvSEpkb21tQU1URXVtL1M0ejlpMksrMWZoZ2phSXVQdFZa?=
 =?utf-8?B?dWZSaGZPR2o0QjRDOUZBcnJwdlBVWHpyM0xjRlRJU1U0NGtOQ1pxNGQ0QjNJ?=
 =?utf-8?B?UlRlMXN3RURHRTFSZFpia2hoTVU4cTgxRm15Y0FLZmxZb2krTDVDQWV1VFBs?=
 =?utf-8?B?aURjSExJZzdBbkkvMTlEZVVrTk1Ka0ZxcUxYYVI2R2ZhL3pkcHdTV1RPRVpE?=
 =?utf-8?B?NTM5NTlCbExSWmxtODU0bzErY3MrYS9Pc3N1T25NeElBKzVGYmU5YnVQTzdQ?=
 =?utf-8?B?R0NlQktCWjQ2Q29waHBnTlRKNVcvbktiQktrd1F0L1BSYmlRVlRBSTRDTWVs?=
 =?utf-8?B?MWhOczB2UCtxK1Q3akdQejZ2WFBkUUJaMS82V3hDVmh4RU4yUlJMcEg0YTk3?=
 =?utf-8?B?THlwNVNuZmdwcGdhbE5qT05BUElwNnhmUzAyeFVQNlNZeFgrS0ttMXlTeWV1?=
 =?utf-8?B?NmNJYmJJUVdacG1GeFRKZWp0Y21WTHN1WDQzNkdNbGVSanZsTGZRTEJBRmFN?=
 =?utf-8?B?ZmxnODd3WXZTUXBINWlCSXVpZTlMOVUvbWF4NFZtaVRXekp4WkRMbGErUmdO?=
 =?utf-8?B?bEw1eGhhY0s3czhFdmFwY1FuTUpLZ1QzZDdITFlXMEFReUxabEhlQ2VCU0xX?=
 =?utf-8?B?NTNvN2ZOQVNGSitBUkZtUURGMzFJamZ3MEZ5TUVaYmYvUk9qdEZRZjRjTEZv?=
 =?utf-8?B?U2p4WWlxMTJJVkdWTnJkVHRxbzBmZEdXd25vZU5wQ1lYVGkzT0daaXVGMytM?=
 =?utf-8?B?d1pTQzVwSGdhTEViTEtRSFNWTVdCc29hb0g2RGRaRkIweWs5TW5NRlNNR21P?=
 =?utf-8?B?UWQ0N2JUVnhCemNaNi84ekE3Q09jUTljOTg0ZlVDNldKeVJ6K0VBK3hKRk83?=
 =?utf-8?B?bDVTVk40QldZbWhvb0JBWEhWbEQ2R0Q4c2RUa3Z6YWZvaVEwSGpNV2VvNmdO?=
 =?utf-8?B?L1pqT2xCT0FWRldYaENPZEpmZW9ld1pwRGdIbEZUYnRsQzdUWExZSm9HNENq?=
 =?utf-8?B?MFhVWlhmWHhTYUhRWjRlQ1J2MjJ3czNJajdBSkJPV295NWpjTDdOb3oxMzFM?=
 =?utf-8?B?dkJRbldicTFrSjNaOHY1bDd0dCt2S3h1bzN6R2kyWE5wa0gxNW16OFpLQWVv?=
 =?utf-8?B?L0IyWHdhbWw0WjVpTnVLKzRlYkdEc0FNcEdBV0pYUkR1S3YvM3d0cWVqcnlG?=
 =?utf-8?B?YzF0dGFKWWF3eGpvWVFFR3BYMEJEQ2tUQ2wvZVFJK2VrME5UNitIbEdMa21R?=
 =?utf-8?B?cXVEb3VPRy83NEphOU1hK3RyYjFLN1RaQVcvSzEyZGVlUERobENPSFRzRjRx?=
 =?utf-8?B?dGZHNHEzWDAwL0hIMUFJS2JOVjREbnZWNUthU0ZHdmRpVnRCS1Vnek9rU3RI?=
 =?utf-8?B?R1RLNFpyT1JxKzdkTVVsTUtKLzRzNjRRUXlHLzVFTzd3ejVFR0FMVFNPL3pw?=
 =?utf-8?B?V3A3Vk4wcG9nVjZJR1N3UzkyZnVCNjYwM3lydTIxcTJjMGdEY2NNcUtwOFph?=
 =?utf-8?B?S3ozeEkvY1oyTTNoT2J1Vms5YWVKVWdKSjJzUVRpL0JPb0VReG5OMCs4Uk9j?=
 =?utf-8?B?cU5mTll3cGNoZFJ3Rjd1c1FiNVRBRmZJZDM4NVlPa3F1RGMvMjQxenN6L2ZU?=
 =?utf-8?B?VjM2S0lxSVJQZzhaWk03bWJrNWh2WUh1Sm5XbldmTVpFZm1DWm5SODVkZXFZ?=
 =?utf-8?B?V2EzSXIzNURiYjhscFhqOGkxQk4rRWV5RjN0dXdrRnVnV3F3MVBqR0F3c00z?=
 =?utf-8?Q?8VpNPvTvZd2f9FXHjhMq+5T/f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c914d6b9-0318-414b-ef3f-08dc2e633d49
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:18:14.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiEXcF3pz3FrAU0+1uD31bmnFcffopNBKzIgNbQZF1eH28i2VtyYdkhnO77UOVLDjWRozTv8hcNBk0sKFffr7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587

Hi,

On 2/12/2024 11:54, Borislav Petkov wrote:
> On Mon, Feb 12, 2024 at 05:29:31PM +0000, Luck, Tony wrote:
>> Walking the structures already allocated from the genpool in the #MC
>> handler may be possible, but what is the criteria for "duplicates"?
> 
> for each i in pool:
> 	memcmp(mce[i], new_mce, sizeof(struct mce));
> 
> It'll probably need to mask out fields like ->time etc.
> 
Also, some fields like cpuvendor, ppin, microcode will remain same
for all MCEs received on a system. Can we avoid comparing them?

We already seem to have a function mce_cmp(), introduced back in
2016, which accomplishes something similar for fatal errors. But
it only checks for bank, status, addr and misc registers. Should
we just modify this function to compare MCEs? It should work for
fatal errors too.

For my own understanding:
The general motto for #MC or interrupt contexts is *keep it short
and sweet*. Though memcmp() is fairly optimized, we would still be
running a *for* loop in MC context. In case successive back-to-back
MCEs are being received and if the pool already has a fair number of
records, wouldn't this comparison significantly extend our stay
in #MC context?
Had discussed this with Yazen, IIUC, nested MCEs are not supported
on x86. Please correct me if I am wrong in this.

-- 
Thanks,
Avadhut Naik

