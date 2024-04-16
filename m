Return-Path: <linux-kernel+bounces-147529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C808A75C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39CE1C2150B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845FF3C47B;
	Tue, 16 Apr 2024 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G2cdjuBH"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951839FD7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299644; cv=fail; b=SWjbM0eqml0MPhL0hfMZE1QlEYuPtNe6/ZDu+8fitZZUK2b4/lgZm4PVqbEYnyEjjwcrYspl+/0SALq3LaI7mvRMzPnSGhrud8iju7/6p6UFTH5YTOQ4YtKUj+Ghm2M1A+KqtpMsTQ+9/42Wjbns7W2VFE+mnwjsBFXEiFIbWwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299644; c=relaxed/simple;
	bh=OigiJmq90AAhWLsYeD7E4pd9O6vVi2heZ88SFegMpfw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c8bv7xmATSBU5H83NOtA6tXepwg2ERBbi2oTg2MC8qTsqKpeBoqYvBuFj0Ul1Tvt3IP3P0DcF7+x3XFHE1Y5Xbnn0HJIh9x7vM6Q5SR9IZG3SYHKJY416VlnWO4HTqB7g5ZWRtKbxx7AW226HDMi+ya/fRqS9KIB7n78gnkFlXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G2cdjuBH; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocg013CN6pHuGVILG5+WoepG5lPPAa00H6Hyv8SHGFUls3BU7rawUS5f+iL5NFEA1L9Q+o0B1ru/dPwlzUfAgaqS3hXWWvLMs47CLyrQ6rT786FYn92CP/b40lHMBTJLsa0rSoS07bA2VVxnA8w3gQzelvKBWbez2lCl6TX801+9JseM8JJ2pGapB11C83EC3Jx0FW7cz1SKUM9Iv1Z3QX9gdCpfDj0k8ctlBnzrYDafKnYnsNgc6ogkQjuT5gjWresQvuWM6A2s9fI0Zjm1b6D45YSVTf7PkuTcKyaoS/3NuG8hC1zqPcFn2cgnjRERimS4oBbK2IJAHMlZSGMZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTrdPTotxTJdIFLFGtYWFZM4XqkD101T7l44Qh7TgCY=;
 b=JHS5giS2nAy7hbWCnZacDbMHelNjTszwTuynxGxXtwhnSj4FWsOK8eHJmWxOz7PO3qMRB1jdvSmHAYkEE/G/bEAziD8ad5bqDLaBu/TYT7mQIDzlvPBcydvk6gQdEXgvldY578Fhq7hIJzkWdgxXVL4RFWLTiIgkQZXoFFHDrLEMUy71UPxcVf/vWcsa31WwAnd+Fpuo1vsVTZGZtU670C6R4BPN7lAXxs06SPMUBpKHm6m64VfTTM+QWor4MCbfsw/K2gyKJhqCt7WQJV1yzlMLA0QQ2KVGdU6YjM9THA8AIF20Gs+O5mWjNgfdLPw4iVDMFktR1v4eHXBL3HNekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTrdPTotxTJdIFLFGtYWFZM4XqkD101T7l44Qh7TgCY=;
 b=G2cdjuBH4WS7pyWGtE9Mj3k2JYyWDigNZj83ImKos93imjOtOOL/7f0hJxBhBwWTAfHVaFXmdQgrPc0M7atXloUv8LSBHyg4StWsbZ/1hbp1EBrML8dGKvLbUHOt0pKxnybcAgjhzxnIASAdp5P+ej5fEsD3UEAwDdDiqNK5tHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 20:33:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 20:33:59 +0000
Message-ID: <c754bf86-2c3f-43fc-86d9-0cfd306b50da@amd.com>
Date: Tue, 16 Apr 2024 15:33:55 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v1 01/31] x86/resctrl: Fix allocation of cleanest CLOSID
 on platforms with no monitors
To: Dave Martin <Dave.Martin@arm.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-2-james.morse@arm.com>
 <36bdfb3c-2828-4188-88b1-b9d01b2a114f@amd.com>
 <Zh6jtYS0mu9xdwgS@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Zh6jtYS0mu9xdwgS@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:806:d2::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: e5af71bc-5a79-44fb-26d1-08dc5e548bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9eevL/ZADjYVSUON+Wi2xR89pUJzmo4FTvgaJqStTu54ogQ47APdxxQUxovAzStZlXe6sFS8Ur6bMGSaUNQxTINLyZ2qWNPDSjfIV3GBnHlcVMhX4ZgiFJCnVdR07HKCFnKeKLpI4KA2Mnorr/CinKOgj9ufBH/sBxIe+UjktwTBku9AgmFyHVgKO4UX08OjTO6sxeQJU/dBhIbT2/ZwGkZ2OXDvq5PM/e9RO6nCW8Ie+MajPAfi8X5ZBtkf+H/VnUl5ySOrWPyjM/nkt//QDZ1Kilix+HUwDSqQqqfgbuRBc6KINHsvEbYvx13nk8fqKP7EV/aW1Oei5pzZXSesSrngn/baxRigdVjDCP+SyO2d+g26HqohAW64yUP2tPwWwoIYisS1Twu5iH1eG1pn/inOcr2DuqkZbj5d/0lmooDGz0PUXpupBC2XujF6Juc+BuxusdZGVbyuTqTkM0k+r4QQwzIzrn1SyJ24Xx7fFPNvRpnU4/ZyFEM5I115vOLWqOBX9GV2pmZ8C6lTSdhJ91j1grlzLk8jEQTCDBv0fjDIiLSx4SU7sxZvzcqLsR8wwbkGripHVDTVWtdkQhltP+AM+TJ9Wz6oPwfHYBMdWtKFk8KRJjAozWlPXrcyjgJNh0i5ShYZOzwmVAoxwZuLpa9YwtYppuu5JdX8JYpdmXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3lYTm9mZDVKMXZEOWhldHQyZ2NlWVBiaUhYQWNTeFBPVlE5SkxGK1l6Sjlw?=
 =?utf-8?B?SWkrTDl5QmFuZk5ZVXIyL3ptTmRnZXlKaG1ZZmJaamR2UFhQOWhHZnNBeXVz?=
 =?utf-8?B?TmY3azhIVXB2Z2VQU3hVR3AyMFVvbmIvL3U0dEFnbzZBRW8vOGt6cmZxbTQy?=
 =?utf-8?B?MFBKaHFwamcxUVpwcjlyWmpYelhYWnI3T25Yb3djUEZOZTRNNjQ3eGxBOEt0?=
 =?utf-8?B?Szgwa1Brc0lSR0VwU2FSRzdkL0MyTUkxL05IVFJHYlFubkJPSmtrb3E1Yytu?=
 =?utf-8?B?ak5WTHZ0Y1g5dUVZWlVJb1ByZ2p5S05zbWZkT3NkSHdZbXZHUzcxeHVzWUVt?=
 =?utf-8?B?U1NuRWhtVFRnb1RWZVd1WmVRUWFLRTdvZXpDUzdsTm8yQ0FaRjRCNEJCdFVL?=
 =?utf-8?B?bEswYlBzOXhqeldHTmxMSDdMUFJZaE0xTWpoMjNiTklmMEFzMVdKOWxOU0Fz?=
 =?utf-8?B?VVlIMHVQRG5lZFJ6cW5JTlhGWmYwVis1cldCYkxiVzJxOGpxd2YzRUkxendj?=
 =?utf-8?B?aFVGNFI4dFIxQm5EUjN1NTE1a2NLV0xRNzJJRE53SklqNGRITVAvakcxTCts?=
 =?utf-8?B?RnpRWjRNaThCb2pnOEFSaDVVd2ZtY2hBTjVwNkdjZU5RRENlR250dDh0MUZk?=
 =?utf-8?B?MHRqZTR1WWlzalZzRDFrNUovS0N5WWhibGtlb25haS9Ta1BLVG5vQnRtQ00y?=
 =?utf-8?B?ZjRXUWtDZWg4WVdkRVZBVDdWeVIzWmJsRG8xNWdRanQyVUtTc0QyN3BQSENq?=
 =?utf-8?B?QzE0Q0prQlo5R0ZMZEYwMnpoRDRIUXV1Q29rN3hVKy9qQUJBbzdQVDEwTE14?=
 =?utf-8?B?d0Z6cXdlTHBBTmZtNkJnTStld3Z3WGQ2S245ZEZFT0I3cWlETUJFSGtucm5Q?=
 =?utf-8?B?eHVSSU1ibUh2L0Rnc0FVa2puQ1FBL2tlMDhqK3BKeGtvTlB0cWhXRXI4QVNE?=
 =?utf-8?B?YjZnb3lTNUZ6KzRIMHhJakJkTEozVnhiY0YwM3Z1S25xbFFXWFRxMFEvUUJQ?=
 =?utf-8?B?b2JwV2RZdm5ZajlKenVQYWhNcFhlTXNiNno3M3lQSUNIenBSYlRsYnNWTDB2?=
 =?utf-8?B?N21kL2NpZnFqREZEdGNabWw0SmU3VnlQUVlTY1RwUVVwYWprOUw0azJFVWZt?=
 =?utf-8?B?MEg1akt2RC8vOWRUeUVVTVRHWGJKa3VtQ1N3bHdqWW1EYmpXYjZoUm83bTlk?=
 =?utf-8?B?UXlsR2RnY1hHaFNrZjd0STVLc1ZlVjdmT2VqUXowOFowdTd2Vkl3RVVDM1hZ?=
 =?utf-8?B?aHhPbm1xMHc5cXJRQVF5b0Y0dlhqV2hjTHNFc1Z3b3B4TGZSNFN4bG1HQUhI?=
 =?utf-8?B?U28vN1RRUVRFYnlQb2p3NFdvRGp4dDZ5S3d6VnBDV0Z6eHVCbEUrUkxXLzRS?=
 =?utf-8?B?NlZnbjJLanhWdXl6WGhHVVV0VksxUHdIMVRVNVB1NjNYMTdhNnhiMVFQcGU2?=
 =?utf-8?B?UStBQnpXQ01yRHB3MDd2dHhoMXhuV2lhekgyOENjaVBydGNVQ250WW43SlU5?=
 =?utf-8?B?eS9qK1NOV0tvZ2JyWVdoUFZNeVV6L3BmMGJocHBtbWNhakIzM1NnK1dtOWdO?=
 =?utf-8?B?TXFCQXp0Q2ZwTFBtSzBiRUcxQzhqVzgzcThOMVN6WE02WVA2L2lNMnJNUTk4?=
 =?utf-8?B?cGVITEQvNzM3MzlrOFJ3L2U1RWlHeXUrNFVPY0pxVXJiL3lRV2tLUzNVcWk1?=
 =?utf-8?B?WmFWdDRxbTMwcHZ4Z1VBUGV3RjFBWDdlbytnYW91Tit4VzNNd2p2cWxPNFh5?=
 =?utf-8?B?NDU5bXZGSlg5Y0pBQk1SaW4xRFNCaUdKV1gzZnUxaVBzbzFvdURpdlhHTDdZ?=
 =?utf-8?B?TlRYcUJjT1pwQm9idWI3NjRBOTNvSUtSdTZOTGZZNHV3Y1V3aWhvRVJSdVpm?=
 =?utf-8?B?WmdpTTRKdG1EM0ErZmtiVGJlRlNCOHRxUzRmbEdhQ1VEdHBMOWtCbzRQYmlh?=
 =?utf-8?B?UWR2NFhaVms3d0VKM1hjbG0yNGc5M01NVzdoM1ZwTmI0VFB1aDA2V3Zici81?=
 =?utf-8?B?WnJoUVE2bitnZFpsWENQaXNhbzNjdTllMS80K0FwMG9KNHV6ajFaeVNlK0FH?=
 =?utf-8?B?eHNkNHUxRERRczJSalNZcG13NU1sbUNVNEtpVkVRNDEvU25FVWRRZVgrNXpi?=
 =?utf-8?Q?endo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5af71bc-5a79-44fb-26d1-08dc5e548bd6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 20:33:59.7831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOCM5v5fDcRS3rz0KlfU8XqFTBBPVW0bw6EYzj3J7RdxSMuf0cnt0pYHcosoPiYS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862

Hi Dave,

On 4/16/24 11:13, Dave Martin wrote:
> On Mon, Apr 15, 2024 at 03:27:42PM -0500, Moger, Babu wrote:
>>
>>
>> On 3/21/24 11:50, James Morse wrote:
>>> commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
>>> searching closid_num_dirty_rmid") added a Kconfig option that causes
>>
>> This is not true. The Kconfig option is never added. It is added later in
>> the series. There is also comment
>> on this https://lore.kernel.org/lkml/ZhecyLQsGZ9Iv8wU@gmail.com/
>>
>>
>> Shouldn't the Kconfig option added first before doing this change?
>>
>>> resctrl to search for the CLOSID with the fewest dirty cache lines when
>>> creating a new control group. This depends on the values read from the
>>> llc_occupancy counters.
> 
> See David's comments and previous discussion on this patch.
> 
> You're right to point out that the description of the original commit
> does seem a bit garbled though: CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is
> not present in Kconfig here, but already referenced by other code.
> 
> We seem to have a consensus that it's OK to have a dangling IS_ENABLED()
> so long as the option is added formally to Kconfig later, but it looks
> like the commit message here should be reworded.
> 
> Does the following make sense?
> 
> --8<--
> 
> commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
> searching closid_num_dirty_rmid") added logic that causes resctrl to
> search for the CLOSID with the fewest dirty cache lines when creating a
> new control group, if requested by the arch code. This depends on the
> values read from the llc_occupancy counters. The logic is applicable to
> architectures where the CLOSID effectively forms part of the monitoring
> identifier and so do not allow complete freedom to choose an unused
> monitoring identifier for a given CLOSID.
> 
> -->8--

That looks good. Thanks

> 
> 
> Although it would probably have been better if the Kconfig option had
> been added upstream, this patch does not create that that situation and
> the series (taken as a whole) resolves it.
> 
> So I am not sure that anything would be solved or improved by changing
> the body of this patch, but if people still have concerns then I guess
> we can look at it.

> 
> 
>>>
>>> This support missed that some platforms may not have these counters.
>>> This causes a NULL pointer dereference when creating a new control
>>> group as the array was not allocated by dom_data_init().
>>>
>>> As this feature isn't necessary on platforms that don't have cache
>>> occupancy monitors, add this to the check that occurs when a new
>>> control group is allocated.
>>>
>>> The existing code is not selected by any upstream platform, it makes
>>> no sense to backport this patch to stable.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> ---
>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 011e17efb1a6..1767c1affa60 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -149,7 +149,8 @@ static int closid_alloc(void)
>>>  
>>>  	lockdep_assert_held(&rdtgroup_mutex);
>>>  
>>> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
>>> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
>>> +	    is_llc_occupancy_enabled()) {
>>>  		cleanest_closid = resctrl_find_cleanest_closid();
>>>  		if (cleanest_closid < 0)
>>>  			return cleanest_closid;
>>
>> -- 
>> Thanks
>> Babu Moger
>>
> 
> [...]
> 
> Cheers
> ---Dave

-- 
Thanks
Babu Moger

