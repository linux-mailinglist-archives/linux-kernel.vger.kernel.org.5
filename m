Return-Path: <linux-kernel+bounces-55616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F184BF07
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBA41C23C46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20361B949;
	Tue,  6 Feb 2024 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZUYQxhYd"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B28B1B942
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707253485; cv=fail; b=a+Bmqyfujz9aNNLbBEylfLS9ADUsTcF196u4fB+UsytIez3o+TtF1qkHakTJK3X8TDY6HpgOW5TOQrZTKQ69hObgqeZyvtBofGKg16a0C/ZdFcDWVz4oVPsk/T+tlw8+4qIzz/tzpSEtpaCE3z5tVlcxdWSrsFiTDomIVAg6N5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707253485; c=relaxed/simple;
	bh=NKHbNrD7gA8fb743HsC0gYVY+WXwzAcMlNEZXptUG3I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=ZWqPqNB3V5NmNkmCAo38uSM2n/gh4sAVYqYF5bGhpjdvvpc5aXTXfyYRyyl59w8JXVFYCtP7s83GBbOCsWMGQPH8im2Snn3vUDeQIbkZaiPOragH1EVxEB4VKKCs5vC89DbX9RdXFXl0JWbk++TijbQ1+gakWZAG0kan2z/05U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZUYQxhYd; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrVm/YgCkD0hjgkGuQhdwR3cVCB3sckdq2kGGj9a6EGpaxdBRv+DHvjk/w8aaVk8231WUgSRcTO16Iyr0cT4C0+Mi3kCAiOzzsT8a0dZs5iwM2PhMbDvUkgwLC5tOWPaF2HIQ7z+Zf9Kx9qnmmInsDIuynL5FEIGpwpXinJKoyjHBxiTcqURoZNFwJuUnsYfDq1dLZQkltFvQSdSCPF7WVHxpkYkoTOjqlzZBj9E7Y+ZeSFogI3CO4PgwdWU734bLgKMaSdCAkMo0lNfqooypoT9bX6/zKgNV3YqHoS86nvnFFCJMnbU/osov6Cxr7zxdTya7qKJBaGJj8DeOQAjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHmh6tQqGzBBvNhWtHFWnuBR5XZVY9BTzqtgXYpvMIU=;
 b=TOT2OgDcli1fHklSzyekx5xgEdCcee+v9ZCxeLSiKpEYPX4kRJvGy/b1HSn5TdxoKts8HDyziQAHjgLqC288FC5j9tlGJACRKbuRJIiITeqhxHhl7lZVrPVvUiJunc/RH+JJeS+fOUKBsZW3lH01k9QqLF4F8U9Otxg667KMUG6FPuLIapbsFO1tRoNl01BJW0jgtEA2zH8Z+edlOYd3CdUAMSxicGSf7rrmCg86zM8iEJuSkJj9PnpbJ90ICa9Wh5egzh29y6b6gx1whLvVcL/gDCZRMfr9tajka+AU1PTtiuWsyEysS8t5s9jPQ0eA2MOxZX3guigp5Z/13susxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHmh6tQqGzBBvNhWtHFWnuBR5XZVY9BTzqtgXYpvMIU=;
 b=ZUYQxhYd3XflUO176dn205sKV26AEZBWoOuF9+8R196oFfYT4HeLZ0C62XGJVA3XbidpjOlDudjylMhid4kfTng6wsnRWFLxUlvcvEfTJlgrDthrr3eXvAa8gSGzW2MPStrMOGxQonhuEQspaX/PwB6qkumKLUEo5yOvSehAaAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 BL3PR01MB6851.prod.exchangelabs.com (2603:10b6:208:352::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Tue, 6 Feb 2024 21:04:39 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf%5]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 21:04:39 +0000
Date: Tue, 6 Feb 2024 13:04:27 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1
 (incorrect child count)
In-Reply-To: <dd862d7a-11bd-482a-b248-60d4616fb6ef@arm.com>
Message-ID: <8bf2275a-dea7-1817-731a-7d47d3b01d13@os.amperecomputing.com>
References: <20240205194655.1567434-1-ilkka@os.amperecomputing.com> <dd862d7a-11bd-482a-b248-60d4616fb6ef@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:610:4e::39) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|BL3PR01MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fb871e-ad79-413c-baa7-08dc27573b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fvFnXJBKsuVPLt+f1xaDZ+xAv75gbqaP+0xYhjzJiZYmQmKOYeq/+648r2Vu2s/RqP6WNbzF059UPpE2jXX+HEc1qHKQAvXNHPNQDgL6hYYwOGvFYa5YrLzRo/Hzq5Q8p83/C/Y8YkfyVi9o6JuIFWiQGNkO4uRq+Z8lz1kebFwgCrdoTWAQgNUuHEsqQc6yFN/MZF8TXEOsHG5EPMJprOFhBX0PBkxlcYH7Pv5P+DQQApqwmGGhm7AwcIzHKd1ydHR9o/8krsZ91W0VtNaGjS7EY7IPHH4AOE0Qy6NCNlx8hl5oeNxwClgh1j9U873WtC9swbZQdZWqhE1AMtizX2EfN9A2CPpXTP1RV9pOrcj8OooUY9FtzG4Gaf0Bu8KygGJeKDOqCfDsZrlpE4l/FkNUesPeLXOf6ZEkd3reH45fVS13KMk4L3/39BGhqEgzS2iBmMluBcJTQIEgb/jqRp9TTigJk/XoXUFvbc2JGOD8O+nYkqCvOcnjcsYRkfe1efjomc9XcXMPKxfquC0PP0oKnSIoNnEr/uu6BUwQDwmaEzzjsz6alQ+YItpBv9Tc5xTdP4WEdoBGkWVt8gVMVfQdSyVvHx3+uxFMpoi56grInbH3diYTTJiRs9LraCrM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(376002)(346002)(366004)(396003)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(83380400001)(2906002)(38100700002)(41300700001)(26005)(66476007)(38350700005)(6916009)(54906003)(66556008)(66946007)(316002)(8676002)(4326008)(8936002)(86362001)(31696002)(6506007)(53546011)(6512007)(2616005)(52116002)(6666004)(5660300002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t1SCVkeFDNhXwRJObiqH9tXH/4e/wpq31hEBQLXVVR/Jw3qLSbSNwLusKKD8?=
 =?us-ascii?Q?8MCvA4cTP85f2RKZxasXPOvGZyGE/k/fMj8AUPJGGKhd4jLeyThcfyD13zio?=
 =?us-ascii?Q?34U2x1i+La3z+KAZtpq0w5hge0sj5cyVHGaQDk59MO8j2Zvfjz+AIfgoZWJB?=
 =?us-ascii?Q?3KkmDCaejwln2BLFzOWDykSSPIzkle6dauXPZc+TUWO9nkJyhqjLJIB9TyR3?=
 =?us-ascii?Q?JSrKOjQFRdS7TNS5AlxXeBaz9+YUHNXW9DjfkCqnBoVC00NlOrBC1Jy2Ztok?=
 =?us-ascii?Q?zWT+S/cYkZhBXrPBqZc7xtcoUjZIgdN4dsLCJQbeyqtJO69ODW/cthysHi2J?=
 =?us-ascii?Q?PxgoDWDqU65oe1SExW716PgcRhTHDmBahn906Swkclqexk7Iy0T1XFGG0Y1K?=
 =?us-ascii?Q?k+BToXDCR9e75Tm6IpumzT+fVk4rmRypWCs5rKtEJb51YdiWrHgUiS5rVqJX?=
 =?us-ascii?Q?lhWVDRgeXFuTtzL7QpD0vs0hLQCKD2OuYlfBHd08ObvJ0z4+QLdwPlrGh/TO?=
 =?us-ascii?Q?ljZbcH66nLTCF1icFUkGfxlyGBaWUHgjOH4pk1QHDHfbmTQKyzuQH1Uulkd0?=
 =?us-ascii?Q?uASlR2za5bzT7RaEKzBazkJZ+nCGv0G8e/Nm8B8mtqAGN3VtJ74brBF7NpkX?=
 =?us-ascii?Q?IeEoRSwY9WeS6csPtiTpR5ZZew9+HC7n1Wld342R7g3Hzx4jKtKyAeKN5bc5?=
 =?us-ascii?Q?69SsR5FME+JR2spRRjUGM4vmoqHM3Ee7EIR8R74yiIrlLIknFhGaeUIsjxvi?=
 =?us-ascii?Q?1fFvrQDZBC620jvvLuRvYAHsbpTrIPPu6Mnk8zIKz74Ya80De1NTsgJyC0fH?=
 =?us-ascii?Q?9qWAinmcmPXDKSkVFdb7OpfgKmxqs78McgcoK1kx5vXdFa3CWHL2q/y8+hwh?=
 =?us-ascii?Q?KyChjOfqDsY+GOAhrfchwf6vAidfVkByAIW3J2NgH3T6ip6v2wHyNoZprVaN?=
 =?us-ascii?Q?p2IWAxz4hvgBegcafAZPTa+NgGwSLTXxwFTCb5JLDmWHJB7u33Lh05j/Bcuv?=
 =?us-ascii?Q?BTvSz3/sxJqinf/LW5E/z9TTiEKNmDtL6+uutv6IcdyZLiE2HzI1E/rDvIGK?=
 =?us-ascii?Q?toixYD5Mt9WTb5wChEGPkJkFGaz9mDbc072Ervxio0RvmRy3WTPBedIiPeAU?=
 =?us-ascii?Q?m22sbPzxldieBzC6puqWxELqi/pqCSM4ihQUbzbcsiXiTcOnklixNVAA1Ea3?=
 =?us-ascii?Q?6r+UWVQbyExljPpVNB6d8JVjcgqvLbredmLgiV5bDvkHRtvLVuOndthn35uK?=
 =?us-ascii?Q?WQJc0ps6V5KBkhdbHt8RAZGr2yoN44vQ1UInzAURuEnYaHrcp6Mp1mlKqcS/?=
 =?us-ascii?Q?2HyNMZDBxtrQMxgkWqgDIHlrOYB707V3TQPUo424w9YMXMd6Jtc7FCV5PzVP?=
 =?us-ascii?Q?gHK1F5cGsVNmPsYoaDIpWi4hK+k65NjKaY8K1wRXEDwRvcczIALKtl74Ybn4?=
 =?us-ascii?Q?RbVE+GlrvuAOWWy92l5aT1pw9yPeCkAFjD31GX/CV5l1/fAZ1d8JSXis42lZ?=
 =?us-ascii?Q?uS8GFyuTOGcQLeGk6CPRMsAC4XfMgTaPIKxnwf8T/7c1neKd4kXcAuxGRag4?=
 =?us-ascii?Q?7IyNzMRxS3/Y7RUbXzl7I29WYwDU6j7jSxkJlY6EHSuGAOw9uD9jwlG9kX3o?=
 =?us-ascii?Q?34OVzH8rMHzUqWfZY56XTGY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fb871e-ad79-413c-baa7-08dc27573b36
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 21:04:39.0398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzgHtSIEfDYX8eSN+43HaMdTXXtKctzMtHIiiDcLZlgXicT97pVzt7BLYCdwiIKUopO/jivK4fBO8gY/wb4bBO5r4k5IDkpF67FxokuxoskCvLAIkCVFywVzIKCdiy94
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6851



On Tue, 6 Feb 2024, Robin Murphy wrote:
> On 2024-02-05 7:46 pm, Ilkka Koskinen wrote:
>> AmpereOneX mesh implementation has a bug in HN-P nodes that makes them
>> report incorrect child count. The failing crosspoints report 8 children
>> while they only have two.
>
> Ooh, fun :)
>
>> When the driver tries to access the inexistent child nodes, it believes it
>> has reached an invalid node type and probing fails. The workaround is to
>> ignore those incorrect child nodes and continue normally.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   drivers/perf/arm-cmn.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>> 
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index c584165b13ba..97fed8ec3693 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -2168,6 +2168,23 @@ static enum cmn_node_type arm_cmn_subtype(enum 
>> cmn_node_type type)
>>   	}
>>   }
>>   +static inline bool arm_cmn_is_ampereonex_bug(const struct arm_cmn *cmn,
>> +					     struct arm_cmn_node *dn,
>> +					     u16 child_count, int child)
>> +{
>> +	/*
>> +	 * The bug occurs only when a crosspoint reports 8 children
>> +	 * while it only has two HN-P child nodes.
>> +	 */
>> +	dn -= 2;
>> +
>> +	if (arm_cmn_model(cmn) == CMN650 && child_count == 8 &&
>> +	    child == 2 && dn->type == CMN_TYPE_HNP)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>   static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>>   {
>>   	void __iomem *cfg_region;
>> @@ -2292,6 +2309,14 @@ static int arm_cmn_discover(struct arm_cmn *cmn, 
>> unsigned int rgn_offset)
>>     		for (j = 0; j < child_count; j++) {
>>   			reg = readq_relaxed(xp_region + child_poff + j * 8);
>> +			if (reg == 0)
>> +				if (arm_cmn_is_ampereonex_bug(cmn, dn, 
>> child_count, j))
>> +					/*
>> +					 * We know there are only two real 
>> children and the rest 6
>> +					 * are inexistent. Thus, we can skip 
>> the rest of the loop
>> +					 */
>> +					break;
>> +
>
> TBH I don't see much harm in taking an even simpler approach, so I'd be
> inclined to not bother being all that specific beyond documenting it,
> something like the below:

Sounds good to me.

>
> Cheers,
> Robin.
>
> ----->8-----
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index c584165b13ba..7e3aa7e2345f 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2305,6 +2305,17 @@ static int arm_cmn_discover(struct arm_cmn *cmn, 
> unsigned int rgn_offset)
> 				dev_dbg(cmn->dev, "ignoring external node 
> %llx\n", reg);
> 				continue;
> 			}
> +			/*
> +			 * AmpereOneX erratum AC04_MESH_1 makes some XPs 
> report a bogus
> +			 * child count larger than the number of valid child 
> pointers.
> +			 * A child offset of 0 can only occur on CMN-600; 
> otherwise it
> +			 * would imply the root node being its own 
> grandchild, which
> +			 * we can safely dismiss in general.
> +			 */
> +			if (reg == 0 && cmn->part != PART_CMN600) {
> +				dev_dbg(cmn->dev, "bogus child pointer?\n");
> +				continue;
> +			}
>  			arm_cmn_init_node_info(cmn, reg & 
> CMN_CHILD_NODE_ADDR, dn);
>

Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

