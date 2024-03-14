Return-Path: <linux-kernel+bounces-103390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3B487BED1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B69CAB23CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C365A6FE0D;
	Thu, 14 Mar 2024 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FZ+UWYMf"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E445D8F8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426235; cv=fail; b=EIBVfNzDS4r1ySD0Hd5dy/RPK1Mp45qqUGGkt8XgO9/gB3v67N7YLixsh/QdC5d3OaxDTzfm62X0WUUpZ/WoKS1mK7T8t0b+vRzNnVO/UqG+fxjXBPVT/dn4XLwly13AFvKBHUeo5c//9RV5cBoSVBgq3amBPu9ROVgMNl4/RD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426235; c=relaxed/simple;
	bh=Oqd+U2h++lXk8j/Ys9NT5yEHdYXtLPnE+puNzd1Rg+I=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q2xy2U0xPbP1KZLyjXZygNlcMIbzTJUzQ2xiponIYkJ8PoANwvpXK+pFcyJ87FMIt39AGtzR+WN00WSsOWk7qVgtzNHIX3XIXXleJHWytxvGEzySlLHPkKr62S7xJy/30AJvmZ+xxTHt2XGKu1+jtjhBUluQ0c4VExeAwpaQXgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FZ+UWYMf; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mknv1z07d6Z6fmElu/i3BtCjDCGPyhEW41RbxvH83yWT7Z+lnuROuWHKrp/+cbWkIzWAmXflxHoeZLi4G1xXayYtvHjn94zpo2e66rfk4kbOtl4P2JiULDYs2rEk2Pi4hd/3tj6J9xSAxuCIPccKors3UWzp5bdCrJ4NIQffFU70wwraIKkBKEZ8Oc4ovA3VjkWgRBf2JsrbqaIcfIL+An08BLi4lLbns/EVw4QHq6Lt7AZXW3WXeyzy2Q3wyVIVR01NqKcn1SNcaHrUYNbRj/wvPs/knmiwA8Mqya+QClfPNGl/nRrC8SqoshdBOKP+hYskcNEN/FJKSnkQH44UaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnhfkz8ylUPBKV5n/nvjVoNeIrVjjYoFyv334BMVBYA=;
 b=KUE7tF57vhQ2JJL322B/hgFTsQmSZUNMAW7XlEACnyX/aC6QRBT3CzA9jkEWJ46I1jSgz7+1yX2nWg699PciY84PiCw7ojBq/6qzqQZJM7ryvwOgThz42lgJb/xAYBH0oJJsWRWOO9xGTIiOMq3fPofYV2rwQzdhQj01fkAX3p3e18CHQ8RRsWN1Cz9ez14ggZbRrvjO55Q31bTvhbrtcaC/fNCuuH/Mf+wJ3cuACP1fdhI2ZOedVLD/yO4ticuCuTuBi5oHECNoyCLeB4Ceske1um2AbGJ8/sih5h4sauF6/n5GmJ0pFhV1zgTAnxPr7SBzPhaYrwkvTk0RUrFG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnhfkz8ylUPBKV5n/nvjVoNeIrVjjYoFyv334BMVBYA=;
 b=FZ+UWYMf0Sgjn9ibMmhTLbQyKoFLngYafFGaGsAilZm02NdbHmr1OfLs4UuQAkuK2l4htEasJSBjFkc0UmGdZ21TiWr0N1EVSaDo4T+hY9vxHSun2AT0zT9ngjXjEjybVs1GeA4qzH/YL5O1Kxo3joxdLpzYLyohpDYELb3R3Wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 14:23:48 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 14:23:48 +0000
Message-ID: <9ddaa371-2e42-456f-983f-1bd8d42d029e@amd.com>
Date: Thu, 14 Mar 2024 09:23:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] fs/configfs: Add a callback to determine
 attribute visibility
Content-Language: en-US
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Christoph Hellwig <hch@lst.de>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <b851e5f74398141bda2f5e6e1f0308cd13b39aa1.1709922929.git.thomas.lendacky@amd.com>
 <ZfIcjeIWaB5RzNye@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <ZfIcjeIWaB5RzNye@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::22) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: e174f505-e830-4f98-bd32-08dc44325d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lpD89YC4TXbaQidVq7e/4C0jWcjPkf5rPWBHUAe/kjhlaJWC7nIicD9c9ImC4zk75NKF52BvHsi9aM4HhFj0Wk5v+a2wvCGhpNeQHxLpHWy+de1HhNWz7sTn2K9ZvF1h1BXc9FMNKtDIvN+SvovzwwqQnmJRBpYQu7JhCdu6ZL7kPab4IMSA+QtYO9jJdYw6ze9Ngbd5N8Q1Tl34LQt1VcBdNjWMWp+fy/SVYKe3tq9bsHeqxMSoPaWS//xEZZnyrTWDhFwkLQFQB2JFBnAXmKUK8Da+YLr5Gg1/OxmBhHoiuUr+mP+QZNXcdKi6sXHSgEMAp0Ezi8ttrOfAUWJ3zbBr3RSow7e3YzWSBVAvijxhfMr6zPf3HZAITJj+0eAG7bcJlsrutKZtuKQgv2H58u9W0sll8Xt6wKdj5DyelbAY2Sv1QPmeGPEBy1Bs/ouRPqf7/t4o2h4cRl9DvwOZB1QzULov0/x7/a+Xr1O/2zLDrad4kV9Roy9Gy9zNPnZHfvFXgzo+VU0rpSVSkvSYFwJjpx9nh9v7TNP3JS7Tf1hEkQG79kD6M6e5H/3KkhYuQrYr2wDvoyRfOXMfEvrQ+jNMKgUvkWwKPHwQyq9lMheoxfB0hPviDqvhUzyiqbwk090UrlaIomSLz6o5PRMv8aqwvclfJYCz86jqfszrMu5K77lnPQrSPllcr//i5pPD+2qlQ880mB17pEQc31SDrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU9vdUhyUTlPS3Q0SEZMTmlXeXE2eDAvamZ0VDNHTzdydExUaU0rUkUzSVJE?=
 =?utf-8?B?OUwrNk9qclZ5WnluWjlGZ1ZycUx6Sm92TXVTY2E2a0R0cFZDSHZQT0pTbVlU?=
 =?utf-8?B?aUFLQXoxenJaMXdPVEZtQkFpSU1KU2J6Z2xUSVJWZ1RINHpzWDZaVlcxQVgw?=
 =?utf-8?B?TDRlNExXYzhFR2kwSDlOOEt2RTB1UnR5Vzl5c2Z2OUoxNWs0OWxJR2IybHdn?=
 =?utf-8?B?OEtvUm96a1BnS1YxVk9VU293MEI4dzAyTjZDeDFFZE84SW1pTDU0VDA4MjQv?=
 =?utf-8?B?ekpGWEZUM2Q4VWRURGV5Q1g1MUk2am5kUDB5cGUzVXY0N1VSVEZEU0t1YVp5?=
 =?utf-8?B?RVU2U2lnNCs5VXNuVWJ1TlBkbjlaZnFnTTJ3OHk4VTFHUkE5MXBncVJ1L2tM?=
 =?utf-8?B?RSttUWg0UXhiTjVQdFZLNTh1Mk5oak04WldzZjZXNHdpeVRLWW5hd2FhNkxv?=
 =?utf-8?B?UFdGT1ZCY3E2ZWNVQitySFQ4dUUxRC9NTkNlclF1OHQzYzNiUC9lWERFRnRh?=
 =?utf-8?B?YlZoMFFRNEQwbmdaZGJvMUdMTkFPVEFiV3V0eHR0SXNHek9mRXBPWitOVitz?=
 =?utf-8?B?SWUrWlkxd2g4QjVueDNpL25oU2NEaFRPS0lENjhxZDkyandxUTNDTUZOcjNN?=
 =?utf-8?B?aUZFbUNnNW1LUlJHZ1o2YTZtdlJ6aWJxQ1lGZ25BUUkreTVJSVVrU09xdlE2?=
 =?utf-8?B?Y3NhcnhiNFV3czRHYVprMVIzZ2hsMTFPQUpYaWlxSjhYQm80ckxJSWR3VVIv?=
 =?utf-8?B?VERKdGxVai96ZFJxYktJR0krazN0QzJKY3ZaK2l2a01tblRrNzNzQVI0OVFO?=
 =?utf-8?B?cEo3aThFOHdMUUgyMEY5Wm1yUHJRSTVmcEZRdFV3L28zRjV1Zjh6V1A5N0pY?=
 =?utf-8?B?WjhpVW8xa1UxK3ZldUp1c2ZWU3A1RWt2OE1IcE5sUHE5QlI2VFZuT0VwTGcr?=
 =?utf-8?B?NkJrdjJYZk5COEU5RGNISGVLZnVxSGYrRWFJR2pxL2UyZnAzVStkMU1ycS9m?=
 =?utf-8?B?ZTJReHdvWDVHdE1DYXBvcGFSNG1jN21pVXYwZUU1ekNpR0dzOERvRHMrZXBI?=
 =?utf-8?B?dFlBRm5leDkrZ1MwcHFyM1g1dHpSejdKN1g3VHN2OGx4djQzMXNuaHF1TExm?=
 =?utf-8?B?MzREMXhWT2VtR0JYSk5sTFRRNXZpYkJFTkQxQWp4TUIwVHZoYklIakJKeGNE?=
 =?utf-8?B?ZzFIM1dELzJPTVdyRFhGc3ZMazBtTzF5UjJTZ1Jjak1UaUNGWCtpT2VFb2lr?=
 =?utf-8?B?OFpRQm43Y09lTmtoYzBScU9qelY3NXMzcTJwNjBZUkhEaHJua2hYWEZQTE40?=
 =?utf-8?B?WUZVbk1DMjFRd1V1aDBjZXdSUGkySGJncGxoQkYvV2RJcVZITUw2UDk4MVpN?=
 =?utf-8?B?aGVDVDFRT21BeGFhLzZJSTJYMXVxRG41QVd2VmJzR1JpQzVZTTAzNTRGeGZw?=
 =?utf-8?B?N0tTZDVaejI5cmxKMXh4ZXZSNmNpVVN4eGtHS3VqV05lb005dmpLK1kvRW1O?=
 =?utf-8?B?eU9hRVpuN3ZIQ3RGRExHc25xV2JGWXFtMEJ1RjFSSDMwNnZEWHpsc2xOTTlw?=
 =?utf-8?B?RlpEY2E5V0tXVDJvcUV0ODRvbFFHcUdwTldPVEF6QURJVCtvV2JwR3Fjcm1I?=
 =?utf-8?B?d1J2RWhYVDNyTGI4WkxWS3Y5TlcvbmloOSs4a2hIaDI5RlEvczBqcWZkSndY?=
 =?utf-8?B?Z2VKVjdtbmRMUklUSzhUSXE2L043Nmw5WkRDRU94aHJDZ2I5WHkvZ2t4enpD?=
 =?utf-8?B?V1BYcHErU2c5c3NtSHhRUzNlQ3BsOTdqYjcxQkdTa2hRZmxHUW9IT0toSU9T?=
 =?utf-8?B?V1Y3azlKSUJoSDV5eGhyU2hQVG9sajB6MkRmVFNEcHUyZnB1ejErN3IrMmNy?=
 =?utf-8?B?dFgrUmZVWC9SRUV4UlVXSEU2aThKZDJaczRkdklZL3hSak1yQ2sxTXNUNlhR?=
 =?utf-8?B?UW1CZmJHK3JETHVXUVl1NUxwbnJ1eHVyQXZMYkNCaHFJbzdhNlQzMkdrWHdD?=
 =?utf-8?B?MkY0ZkVrZjI3MVZWWlFseDRwLy9RdC9ZYkpNZFVHRTFUOFZacTJ3aVJnYlhU?=
 =?utf-8?B?TEI1UFdjM003QWVqZGM5cVdDZzAvUEl2bVZucFZBcG5LVFZtc1I1VXgzOVJL?=
 =?utf-8?Q?PaXqTpi1/ZqO0LTzwY9phc5E8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e174f505-e830-4f98-bd32-08dc44325d63
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 14:23:48.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67BHlXv+6GrV7PFeNlmMNd1kKo7mSatPu8RXMEdcosI101ej4zo+6U3ZZYdUKj/Ga3wpGrGMmPb0M3jSoITkbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172

On 3/13/24 16:37, Joel Becker wrote:
> On Fri, Mar 08, 2024 at 12:35:27PM -0600, Tom Lendacky wrote:
>> In order to support dynamic decisions as to whether an attribute should be
>> created, add a callback that returns a bool to indicate whether the
>> attribute should be display. If no callback is registered, the attribute
>> is displayed by default.
> 
> I'm curious what the strong value is in this extra callback.  As opposed
> to not generating the attribute in the absence of a TPM (why create a
> config_item at all?), merely having an empty response from the attribute,
> or having `->show()` return -ENODEV or similar.

The value is to reduce the complexity of registering with the TSM support 
across multiple vendors. There is a base set of attributes that are common 
across vendors and some that are specific to vendors. Creating this 
structure in the TSM support can get unwieldy. This would make it simple 
to determine if support is provided since the attribute will either be 
present or not.

This would also make the support similar to sysfs in the ability to 
dynamically hide or show attributes.

> 
>>
>> Cc: Joel Becker <jlbec@evilplan.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   fs/configfs/file.c       |  13 +++++
>>   include/linux/configfs.h | 114 +++++++++++++++++++++++++++------------
>>   2 files changed, 93 insertions(+), 34 deletions(-)
>>
>> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
>> index 0ad32150611e..c758bcc11235 100644
>> --- a/fs/configfs/file.c
>> +++ b/fs/configfs/file.c
>> @@ -451,6 +451,12 @@ int configfs_create_file(struct config_item * item, const struct configfs_attrib
>>   	umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
>>   	int error = 0;
>>   
>> +	if (attr->ca_is_visible) {
>> +		mode = attr->ca_is_visible(item, attr);
>> +		if (!mode)
>> +			return 0;
> 
> What value do we get from carrying the mode through here?  The API
> proposed is "visible or not", which is a boolean.  Overloading that with
> "also set the mode" is confusing, and it also can lead to the divergent
> codepath problem you mentioned in your response, where
> `->ca_is_visible()` fails to return the mode correctly.  If this was simpl
> a boolean hook, the code could read like so:

A boolean would work. There was a request to make this similar to the 
sysfs attribute visibility. I certainly can make this a simple bool 
function if that is preferable.

> 
> 
> ```
> 	umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
> 	int error = 0;
> 
> 	if (attr->ca_is_visible && !attr->ca_is_visible(item, attr))
>     		return 0;
> ```
> 
>> diff --git a/include/linux/configfs.h b/include/linux/configfs.h
>> index 2606711adb18..18011f78ffde 100644
>> --- a/include/linux/configfs.h
>> +++ b/include/linux/configfs.h
>> @@ -112,39 +112,64 @@ static inline void configfs_add_default_group(struct config_group *new_group,
>>   	list_add_tail(&new_group->group_entry, &group->default_groups);
>>   }
>>   
>> +typedef umode_t (*configfs_is_visible_t)(const struct config_item *item,
>> +					 const struct configfs_attribute *attr);
>> +
> 
> We don't use typedefs of op functions anywhere else in configfs or
> frankly the entire filesystem API.  Adding one here would just introduce
> confusion.

Sure, I can remove that and do something similar to show/store.

Thanks,
Tom

> 
>>   struct configfs_attribute {
>>   	const char		*ca_name;
>>   	struct module 		*ca_owner;
>>   	umode_t			ca_mode;
>> +	configfs_is_visible_t	ca_is_visible;
>>   	ssize_t (*show)(struct config_item *, char *);
>>   	ssize_t (*store)(struct config_item *, const char *, size_t);
>>   };
>>   
> 
> Thanks,
> Joel
> 
> 

