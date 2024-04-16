Return-Path: <linux-kernel+bounces-147195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971FF8A70D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBAAAB244A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DC9132815;
	Tue, 16 Apr 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kYNb3Xst"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694B131E25
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283336; cv=fail; b=T80qlfwpTlX91+F5Hs2BCP8Z4Zrf2w7n4wj+XMP7n5wWHnkCb1OL273+cGKJfgJVIv6U8K9IRjpPgp4Q97Su4Bv1pB9ZLRBHBZNydQCbUI5H9cOZHnBOStFA4aM5/9MBWDzxlCXimyYCgeu4XfOaLDgX3ooC7yO+5DxJtW3JSdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283336; c=relaxed/simple;
	bh=/oj7IiUQ2+iqNWxOWPV+CY6Nx3Ogpi+J4aUCP3nxWks=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=HedQ8T4rspiv/PyCImY5Hdb1dtSII0gDSFOIEmKQEtsAA77bkMKLISCqKgK4zEzb1C6DVP1p+CVPvNxKCYQqS9VPS0mK0XrrFy8vcYc0wTNg8ghhI2pA38k6wx5WYMWhqKK6Xb3TN+8RTdo3q/O8yz4QkCgvzid3xBV9SAPu/5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kYNb3Xst; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Trgjp0rFuf7oxirOWK4wyU54kFUmIj+3ZtSqellTNyuE4BVZpQXAeYgGmFSWB/+enkf6L9s7AuUzY+diYnUNq/bxCnM1LmsSwvdZ28iK7eh2q5HvkGcYfVo9viErp1mVIjIuxVawu9kWrjuW/Zb3bDOWG6c9t1vU+KTniBRj2+ONRupejlieSaxGIsDK4vu50utb2kH9yfaExpNRMOrbZ7e7HUQQ6SFXtckYDwHa7t53qXhZL8uINtzVXoOfmZSzOqUeU6itse/joGVUZfbktUsS0ZhQErc1/YUduakpNLL4cqG1dlj9ZydFR58ZZWVtieMMLEA6zlQh1cb7DS80GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQFp3gRgjCErYug/KxBw/LCJ0rpibqSukFcizjQGIaY=;
 b=CEZv1kZqw7DNRuq9oE3aL8L4zC/6GeI+cj6YS9PBN5/cbm8Ftct4mdfStln+VwgqWMc0jwxc9sLOyUNpGqTW5T448F/jevJarVbi+9uIDeIB980+VVh5uCOlPsrgEsoXniS8DuhRKTgRJVc5HBf7NyruJ5xayJYw+OjqAFyWBS1dOFGn1aYfKkGEor90iZFlaymoFYKjacKOaz2S2dqcuroEnCCG9M1aYi9dq3crzCkwvDxKG63Mbu95c7cjGO1pI4+zXfciOVghBApXJx2KnrumLNvpeIzKxRSvXJIDd/mWGPxiIdWMGehQ6ArP0Fzn+AQa1fBf1wq6/jP1PE7HvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQFp3gRgjCErYug/KxBw/LCJ0rpibqSukFcizjQGIaY=;
 b=kYNb3XstqmkB+a7QHIRxusTg907sXHNrkP3e4wkkQKrQ/tDx2G4KGM/gcIHJ1DgveYsS58sHMp1adf+7v2d7NsNdhujB0bEYJMkb+Wne3G1SpODj9aJ19nynrkezRgYtozH022+H+iCab6+BCoN0YpSyGRE/99LRQOjPlWVZuek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 16:01:51 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 16:01:51 +0000
Message-ID: <7fc4e7d4-dfa8-b626-76c7-1f8993304a2d@amd.com>
Date: Tue, 16 Apr 2024 11:01:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joel Becker <jlbec@evilplan.org>,
 Christoph Hellwig <hch@lst.de>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <e881a70fda1da98882241fc46fd57c3063fde55f.1711405593.git.thomas.lendacky@amd.com>
 <661e10a01f1d8_4d561294d0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 12/14] fs/configfs: Add a callback to determine
 attribute visibility
In-Reply-To: <661e10a01f1d8_4d561294d0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::29) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH3PR12MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: e16986e0-aeb1-4add-9eef-08dc5e2e8758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TbQwwIT0nqvMJFqqWHnd/+kZpAJ5ANFjFtOg0FIKSuqd/VU6xeDFGih5eLSiSpj/KqP2Us9M4BUO3bD/VnEcCL2Jmj0mSFfSeDr32hvp0qq41u457dhIeIknCT0yQUYkpVyG0TpY5/6b6gdVzE2+fmO0vkgjyPf8XC2YBioMhFC8ojuw1vnwgaKhH0k87G0gM0AINdBJkM1i3q7zPr7MnyAyxmOkVAWAtQUCmnAcUMKE71hwf7Q+HFYbTdck8RitI+CtZtOcgwFvF99KS4GYYa6jGRHIKpem9dKDaRrfmgbCOCg1olpkIKP5rhb9zQJxIcQ7lkfgaWfh4o6HuNBrjPTiLZwNu1/7hg8smQ7Eabra1rBAUPnkLGiZAEI1+onOgIrY3S/i2zKr461VSBVsvnwuevB7+moCQKn3vzafNV4NnMEya16KOFlJ1eDmFLcyiEcXJf8f1z3OyLK0oI94BRKB4zKLgZEqVd7oP+6Pase3vrgRlrDWWmgKZL4A8tQlYUd0UH3K96pu6dCGd+m9RwiySML4Xwh43W9qfXcIqCO47SwtXbkS9NC61xtEP5LafbDIT4DTnwO8PdeQcBlC/Il/dGn0dAgPq8/7/pR+NTYszrWizhZH5Y2bNbT1GkB77SHE33eVpwKAcwdWWquKtikKNKuAd6tl7DS8nr2k0pA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU1SbXh5Z0ZqRVVjVHUyNWhwN1huTStJQTdGNUYvcjBsMi9Id05PRHdRZTlU?=
 =?utf-8?B?OE4zUjJxQVR1a1pXY0tOQmVmQkF2aTFsRWlFdVVUNmp5MzdVREE4WmFOQUc1?=
 =?utf-8?B?bVZJOHJSTDZINFZ6OGRBSlRYTzJIeVQ1NVpTcFJ6U285akZxUml0aGNLLzRk?=
 =?utf-8?B?R09uMG1UK0oyZDA4SHoxenNzbkZUMHgxNzk5b2tLdXZ1TXJGb01jZnZML3ZY?=
 =?utf-8?B?UGE4QmpOOVlKSUw1Q0FFY3pzTEp0Vy9jTXVzeWtqVFc5ay9INU03TFNjb05t?=
 =?utf-8?B?UXA3ZUo0dks0Z0RFY1RnTTlCVzIxUEdnbjB0NkZNcEJPeGJkTHF3amJVNGFY?=
 =?utf-8?B?UlducU5yT29SaHZic21BZ2dRY2s1ZXB0V0NUb3ZkMFIyMXhjUW82aDRTbDU3?=
 =?utf-8?B?RzhBN1dCMUFwSmh5Sm53a25EcENGL3lFWEhiTWNjR0ZPeU5pSlEyZE5weVJC?=
 =?utf-8?B?Z2U3dlhYV015cWdtZFE0QzIyRkd1RGdBR2VWRWIzSWV2Nm9Bd3FkWmNIVGx1?=
 =?utf-8?B?L3NkZUhLV2VDK1U1RzhlNHNUTTVrVmJ1UHhhNTIzU3picHRVQWY0cjdWakI5?=
 =?utf-8?B?N3UwMDYyRkJGOG1IanRxWlJHV2dqRi9ZNm1pSXZ0NkxxTmttSXZUclZUL04z?=
 =?utf-8?B?WUZqcE9QRUU2RCtudzRHck51YzlSU3RSOFF3dWxlVDh5bGFXckQvQ0Q1YU1Q?=
 =?utf-8?B?ZERmOWUwL3hYczdYS1VtWnpoL0hSVWsxblJYbm1DY1dXSzdLYmJHNWFXaHF4?=
 =?utf-8?B?VTBOVjhhbnh0UVl1Q29UM0pRZW40amVVTndodUtBTVNmeGJhU2txSnpwZFdz?=
 =?utf-8?B?TG1QelVHT2RMNFpVZ3RwTmwrQUQ1L0dGdFRLS0lLV2FiVVk4bGFZS3NXeVB0?=
 =?utf-8?B?dFpFcWtMZkV3YWpKbGRLWkxjZm1zSTVZa2swRW5VNGNqYnMrRkpHZkQ1NWlv?=
 =?utf-8?B?aWw0RTZzMkhxcW42S0FSYkVIYThMVW8zNUc5SW9GWXFFbWtqWERxOUdZYTV2?=
 =?utf-8?B?R3FYVmk2WjJVZGYvZDZVRDVGbzYwK3NRVmRzMjVSdnNNc2Uza0dxV2V5M2Vz?=
 =?utf-8?B?bUVPTE1VTmFORk45THFwaXl6Rm9xbTg1aTJ1Qk5CT0JXL2VlbU8wQjk3Q0o5?=
 =?utf-8?B?T1RIVTlubmJtenZYNnM4aE9pOVBySjlJdkwwV3FjMXlIeSt3NkVydnRUdnRZ?=
 =?utf-8?B?MjhMVWpRQWxicGNSZkpTbmY0VlROWHNlUVRObTdtcHFEUVBYVWxHTHA2alB1?=
 =?utf-8?B?T0V2MmVIVVl2U0VvTUJ3aDJIZ21IQktVN2dFaHM4dzhIZ1BoRGFybkVJU1Fk?=
 =?utf-8?B?WHlkbk1DVVBMUUVZTlg4UDZXSXgxSVhDUTF4czhjN1FxdHptWjBFS0lMRmh3?=
 =?utf-8?B?K29yNmJXR1NucXlKcUtzU1hNRGdFemJPQW1QMkFZNWZOL0k3dFVlcnYzd0t5?=
 =?utf-8?B?eGtleE81ZUZBOXltb1U4MXk1bVcvWDVKZ1FOZ0V4Mkl0WGx3QmpSWXdQbndy?=
 =?utf-8?B?SldmaGs3S3VRUjZnZjMrc2tHVW5WK0pwY1BqN0VHeVNCK3ZtaXFvQS9RTnE4?=
 =?utf-8?B?MkFyTmZGOGM3dmJhcnNYSkZ4Y1lKUjIyVkg5UGpuM1ovNlVaOTlIYUdlNmVl?=
 =?utf-8?B?NHd0N1IzRW8ycUszRkErc3p3eFNNYURBZll3b0hQSXBtQk9PclBIREJKUG5J?=
 =?utf-8?B?QTlPdjV2OElYMzVPWi9WQ1Rna1BpOS9jOUE2Qy8yeHh4cmtuS2g5SUt2UTdy?=
 =?utf-8?B?elVIMzVlOXgvRm1BZW81OXRUMGg2a25pOXBnM0krcm1Od2MwWUMvcTZudGNv?=
 =?utf-8?B?MFdaZjFJaEpTaEdBUWMrSURaREJ1alJpU2pCRENlUzdMZWc3VERnT2p0K2Ra?=
 =?utf-8?B?UnNDSWtsOFFnN0pPcE0wcjRsUFJsdmlvakRDdjhaZ0JsTzcwRlVJT1lwUUhx?=
 =?utf-8?B?T0VOeTY0L0ZOQ01oT3lLL0RtRkEvQ05xS0lpVUNtWlNuS1FIWllSUFlhL29w?=
 =?utf-8?B?UUoySSs5Nm9CNjI2WlZKU1JBOW02U0N3U3NDSVIxdXhudnZpczJLeC96aElv?=
 =?utf-8?B?SHd6UHhsQlI5UDdUWWJaZGk5ZjBCSUwxckxMUUx3ZEdZdHIrenlIR09tSnMw?=
 =?utf-8?Q?oFqW9hbqG6uyw4uqBWJCyLhLq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16986e0-aeb1-4add-9eef-08dc5e2e8758
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 16:01:51.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5WcYpLRp40NUjycAxC1eizjA0YwprYHNERquNGjoT5/DsnTIcepZlMYkWeqdkNVTT4esHhvorEFstXlhQvXew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756

On 4/16/24 00:46, Dan Williams wrote:
> Tom Lendacky wrote:
>> In order to support dynamic decisions as to whether an attribute should be
>> created, add a callback that returns a bool to indicate whether the
>> attribute should be display. If no callback is registered, the attribute
> 
> s/display/displayed/

Will fix.

> 
>> is displayed by default.
>>
>> Cc: Joel Becker <jlbec@evilplan.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   fs/configfs/file.c       |   7 +++
>>   include/linux/configfs.h | 111 +++++++++++++++++++++++++++------------
>>   2 files changed, 84 insertions(+), 34 deletions(-)
>>
>> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
>> index 0ad32150611e..a976c183756c 100644
>> --- a/fs/configfs/file.c
>> +++ b/fs/configfs/file.c
>> @@ -451,6 +451,9 @@ int configfs_create_file(struct config_item * item, const struct configfs_attrib
>>   	umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
>>   	int error = 0;
>>   
>> +	if (attr->is_visible && !attr->is_visible(item, attr))
>> +		return 0;
>> +
>>   	inode_lock_nested(d_inode(dir), I_MUTEX_NORMAL);
>>   	error = configfs_make_dirent(parent_sd, NULL, (void *) attr, mode,
>>   				     CONFIGFS_ITEM_ATTR, parent_sd->s_frag);
>> @@ -470,9 +473,13 @@ int configfs_create_bin_file(struct config_item *item,
>>   {
>>   	struct dentry *dir = item->ci_dentry;
>>   	struct configfs_dirent *parent_sd = dir->d_fsdata;
>> +	const struct configfs_attribute *attr = &bin_attr->cb_attr;
>>   	umode_t mode = (bin_attr->cb_attr.ca_mode & S_IALLUGO) | S_IFREG;
>>   	int error = 0;
>>   
>> +	if (attr->is_visible && !attr->is_visible(item, attr))
>> +		return 0;
>> +
>>   	inode_lock_nested(dir->d_inode, I_MUTEX_NORMAL);
>>   	error = configfs_make_dirent(parent_sd, NULL, (void *) bin_attr, mode,
>>   				     CONFIGFS_ITEM_BIN_ATTR, parent_sd->s_frag);
>> diff --git a/include/linux/configfs.h b/include/linux/configfs.h
>> index 2606711adb18..c836d7bc7c9e 100644
>> --- a/include/linux/configfs.h
>> +++ b/include/linux/configfs.h
>> @@ -116,35 +116,57 @@ struct configfs_attribute {
>>   	const char		*ca_name;
>>   	struct module 		*ca_owner;
>>   	umode_t			ca_mode;
>> +	bool (*is_visible)(const struct config_item *, const struct configfs_attribute *);
>>   	ssize_t (*show)(struct config_item *, char *);
>>   	ssize_t (*store)(struct config_item *, const char *, size_t);
>>   };
>>   
>> -#define CONFIGFS_ATTR(_pfx, _name)			\
>> +#define __CONFIGFS_ATTR(_pfx, _name, _vis)		\
>>   static struct configfs_attribute _pfx##attr_##_name = {	\
>>   	.ca_name	= __stringify(_name),		\
>>   	.ca_mode	= S_IRUGO | S_IWUSR,		\
>>   	.ca_owner	= THIS_MODULE,			\
>> +	.is_visible	= _vis,				\
>>   	.show		= _pfx##_name##_show,		\
>>   	.store		= _pfx##_name##_store,		\
> 
> Shouldn't this operation live in configfs_group_operations? That would
> mirror the sysfs organization, and likely saves some memory.

I suppose it can, but then you lose the grouping of attributes within 
the same directory, right? A configfs group will result in moving the 
entries into a subdirectory, right? If we go with the group level, then 
we will be moving the existing TSM extra attributes and the new TSM SVSM 
attributes into new, separate sub-directories.

Thanks,
Tom



