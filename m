Return-Path: <linux-kernel+bounces-65415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DBB854CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA6128AF07
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409E5C90D;
	Wed, 14 Feb 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P08HduyS"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735AB5C905;
	Wed, 14 Feb 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924408; cv=fail; b=NqMaDc8OhqZtckx9bzDgA/sQP/oi5LZv24JVfl2QfSXI4mcee9QPeS2unLOTexBRYiwiApPdXC4XA/laK26VTzPOKR+N27X8XxlQjiuvslcyPlfBc9QZX0ESkuRbvoeKJfu6sn9qa149rhM3jKZMA/4ZAfezfs94SYqqLQ3rwJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924408; c=relaxed/simple;
	bh=JDMVDnRjTvftDC+MTqFMBRTN8VgfjVMfvqNSmaFCdNY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fJZHdBgvltJaQ1GcZgy877GyynUA1Xp3wAk/AlB+zFh7TWwRm7LJR910t2xYhFfpV84ORJu1QLTU96ne2K/kxZlpKrgjcfBHS637LVuXAhXM9fsEY9A2RvouHUMEhZ+bDDBgTTQ204WDK6JzlwtW4JZwySrZcDwVXN8AOOzDngo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P08HduyS; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy4MtrI18C2oRQKTaFKkDWkuRbscBrf/pKbohxxRSAGliv522Fwjn8L6Cry4x37AV0A0MV0MxKEiBgBBA2c3FFsVgFUqRuHGb0PY3Z8CqypBruohVUz+bwZ+3ilhJyOeKhZnlyabTWDNZU5HaiWgNBall5w9ahkMc4dhB12kK/+F3lJFCg156vdwCflAHiNqha9WZARN3QPkB9CMKyV2FXDhdffaCp1LdkeJpSr58jE/dxZNPJSHkvOp5KYKASo8kwWj+qBNtNbJTzImp7J1Bl6QpQY/LgCzqpf4sa434TmnaFRlJ2tPaMgxZerUeZzRpfYzoq+zpjU7Fyi/GkqBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEwfvxtOefs5RQWwIaQvBYPxHfoz7++YavP5GquUH2Y=;
 b=BspC16E3fJcrPTcsu6gwaFmKWqtqd4SCHr7s7LknZw7GVupq0FeZUd58cSpgBgoSer+Wg1vN0yjPjZldJn+Kmoou8OeLm52QZIWAz5u+S7Gh6n6WdA8NE/woLvNVM+1WL9b15/kls3X5IvSfmtutxpZlmM4kRnob0j0SkS31FdQXw4JRhbouSdPmSL4fEOrErwZmNpFg6fxi1LrQ6Cf+PNdmZIv0yIPiClfim4z/eZvbHC4gnO0AkcaU9H0duIlT12yZdAa2gGO/7MiO9Hfu5vvIgUU2RSOy5PRXMzVpf2R+CNe6fPxnAYyq6sCosLfKa43Go8DvJRIMYt3H1i8WEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEwfvxtOefs5RQWwIaQvBYPxHfoz7++YavP5GquUH2Y=;
 b=P08HduySwTOxI7tIdXWJbSxjYtrDohUkWgQnVkyYuTcJ86chCyVhEFVVpGA77v4qYrp/IwjW/yzEax2RmEfYsyAyuFdL6QrZnti/oVXzPW92p6ShAv0C6aEIgjGWQK4+O0Xcjczprnonxk2YcJ0ZFDmsjbMjfBLdMwmSvmXC2VA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.11; Wed, 14 Feb
 2024 15:26:43 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 15:26:42 +0000
Message-ID: <4096ae55-62bb-4705-94dc-ccf90ee64988@amd.com>
Date: Wed, 14 Feb 2024 10:26:41 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com,
 sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214113630.GIZcylvp6-m-FNNE7H@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240214113630.GIZcylvp6-m-FNNE7H@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:408:f4::6) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 3976079d-6e02-4a0b-764b-08dc2d7158f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	09Q0lppeHcs8VBsEj1e/lSMqiR7Jaw2oEIrX22DrIcpKxIVY8DMh9CbAbqrm/voxbYz8WEUYHE5AOsZTamQtlwcXh9t5lPZu1QGAQlbtxxbo5RlWj/m//oNff7J6ckUwnNe3FDkXEsQL4KbwdNpbhYB5UWK4qZxfNUvk70jfwXuRMAbd6Fdr6J/aYSziaYxO+oV2oGnIy312X/aYYWIdg5Jasi6rGNalIltNMhF3SqTpVGtKdjukexVFRumxKOgtWhIIPI7ew/5pEN4dUyNlRiaDwzZuzCo6YB1e+zBvdzcglAsx/cvLKurvl3dcgWiL9n7oD90Qj3+s48DTyYNSgnKH2fdtORYqc1aWWjEXfXEaafsMXkEiP2dUz2jAK2XNlGbCcXtHyqDKuMqYh1cerUHpacnkm6r/Y1+v+MedGoDEgqtX5o1GL7UFbBN+zedV+AtWiYQQy92W5VcJs3ZqsyEbLo+63YPYNdzqtlihEagkLVdQCquWKg8BJC7OVALJS8zyWB7hYaxF8AOJIoOi6T5fuehYB+Kc7LQCjErNAwA+dJL+1F9VVO6wTU+A2TDq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(44832011)(66556008)(5660300002)(8936002)(66946007)(8676002)(6916009)(66476007)(2906002)(4326008)(66899024)(83380400001)(26005)(36756003)(31696002)(86362001)(38100700002)(316002)(41300700001)(2616005)(53546011)(478600001)(6512007)(6506007)(6486002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVFqRGpYbjRHTWk2Sko3NWRWam1JNjM3QUlQbEIzQ1VQVjFyNzhmN2FCemsx?=
 =?utf-8?B?cVJTcEZUbVgvcmkvTWZtQzk2cEV3ajVLbFV5aXB1ZXlDVDVBVWdvUUZvYW5V?=
 =?utf-8?B?TlFhTUQwcUJFMEVYc2pjdHVRWmgrZGFqVHJSUDlPNS9iQVNqbHNwMUgrM2x0?=
 =?utf-8?B?a25VL05McWFvMDFnWVpUZEhTemVsb0pmNDdUNG1VbzMvcWVsT2NqSWJsdjNi?=
 =?utf-8?B?WC9WSmFIU2gyK0UvUk1zWFFlS3k2YWhYdmFGc1dxN1ZVWFVEWSt3VXNQVE9o?=
 =?utf-8?B?V0lKZEs0N1FIZ3J1cDJKU0VOZFB2L2YvZjZDSit6WnhuZ0pHSG13U3dvdklN?=
 =?utf-8?B?QXZ4cittdnBjUVU2UlYwalVRM3BabWhSOUhVRWJrNWM5RlIwYlV5dHA1aThP?=
 =?utf-8?B?MnFJOGRkTDZSbkNLNVJYbnB4YmZnQzhmU2RtcUVTSXRlR0VUWm5QTXVkSkxC?=
 =?utf-8?B?MGJOR28xTVl1Q29MaVJBNWdVWFMyNWdXTWZQZU9PWFpLc2E0eXFxV1UzSkg1?=
 =?utf-8?B?U2tObkJpcHZxdi9kWU5sNTJXWDhjU3Z2b1lreXFDSVFqVGVUVVFEOGc5TGg5?=
 =?utf-8?B?NDU0aXAzbW8vZkVFN2FGZkZZUFdnWUU3MmJac0xIU1JIM1NLZUNtRGdneDBt?=
 =?utf-8?B?MXcxeksvY3NCa3prNk1GQSs4VGMxYVhka2hEZ1ViS1Vmdyt4cWlKelJ1NUVz?=
 =?utf-8?B?cEt2RUVtT2FlN1hKeUFxNFhOaWJnUysrMVV4azNlczJHNGpHbkZaZ3BVNlVU?=
 =?utf-8?B?Q1VoNzllM1ovZUJWaXVGM1BKdVozMmJEODBnRnB1c3prT3FGcE1zR2tYbW9h?=
 =?utf-8?B?OG8xNm1sdTgrQloyU0FBS1MwNnN3S2UyK1A2b0dOYzZ5dnFQMkgrUlBEdS92?=
 =?utf-8?B?SnRaWWVTQWxWMFIySUlLbmNZbHl3M2YwRWNDbllNeGx0K1VlUjdVWmtMY1VQ?=
 =?utf-8?B?Y2dpcDVFT0Jja2IrMmNyZmRCeGh4RGg5WUV4cDI2Z2hKNlhqZGI3S1B6TzR1?=
 =?utf-8?B?cVZISzVtZTNBRU1Tb2dvSXpUMTA2WXVJZEFFRHVnVmJsTVlEU2dDc1E0czVw?=
 =?utf-8?B?SGMrdmM4ZzhkVXpDc0c4akpHQ3NHWXpIUyt1VmEzUjVWYXp5L1dHbjlYUW95?=
 =?utf-8?B?RG9jTVdnVk90R2NlS3ROUHozalpWZVNLZURpTmM2dzU5dlZYOHpLRXl3a2lT?=
 =?utf-8?B?QVB1SW1xSDFEYUJYUzM5UHNKTUx4K1MrK3dJL0JUZWd3UzQwR1E0azVKKzZm?=
 =?utf-8?B?YlMyVFd4NldUYnh0N2I3bU1RbytROWFEQjY2Qm5YaEN6bmUvV3hQU1hQUUNL?=
 =?utf-8?B?Z2puUWhLWmV5Q2wyVUEwdTZFRzBhY1lkdUQxbHhwb3lMMWdvWWJmbWFJSVo4?=
 =?utf-8?B?MUp6Ym1jR1FJRVp3QnRtUTl0T0JZeFNpV0c3eUk1MHRKNzI5ajNmZUVRRjhH?=
 =?utf-8?B?d2VXUW1Qci9ZMnB4aWJJZ1lOYkd5dURTTk82NGYwam5tYUNYWVRVV0dRTDZn?=
 =?utf-8?B?SXp6LytUNHdGbnB4dHdJV0hWSmplQk5xMWJMQ1IzbWJ4Zk1uaktCNEFEdk02?=
 =?utf-8?B?b1dycnhaYWFhd1lLM3FuaDRNKzgyR3kwTTFrOElGN093Wk53S05WUDZnSlpK?=
 =?utf-8?B?aVNpTC83R1llcXhvenh1bk9tS0pGaTdIZGFnaHh1NkJjZmhFUG0zTW9GeXpn?=
 =?utf-8?B?TnpzSGU3TGVnZEZQTHk0YU9zbnMzM1VDQWJwNEUvWXRBL1JON1Y3RC9vRXdV?=
 =?utf-8?B?NGhuRlVEOGdVRCswL0F1RTZqdGNBSGxONVJvbEJWVHlpRFNac0gzdldDZzRB?=
 =?utf-8?B?V09OZ3JkU2wzdWRFSzRnTjVWeFA0VlpBV2dzRzJzNFNqRXFKSkNjeHNIU2tK?=
 =?utf-8?B?UmpXczR1TXp5S3I1Zm5iNytEM3AzMnNQNnJNY3YybXcxZFVwV3BLNVR5YnpD?=
 =?utf-8?B?b3I1SUNWVDNLVEpHclowZkg5MHo3bHErSjlTNllubEVYTVR0NmlTNXVPdjAx?=
 =?utf-8?B?bWJ5alNVbE1rSmZGMGwrN2dZWi9Ha01wdmdDM3pKQkRsQTk0MkN1aXlxd05l?=
 =?utf-8?B?bW42SzJ0dzlDLy9Yc2dNc1YvbDRRcTcyTkRjMGZmWGgydk5QWUVseXJkUjBY?=
 =?utf-8?Q?LYMIpZPocaNESN1rJrT/DcPkr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3976079d-6e02-4a0b-764b-08dc2d7158f4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:26:42.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZzS86/lhHR/Irpt5GjA8I46SoLZS6Ljj+n+pbbr/visgSNR4Gwt5OK1FMFDwPfVc0+EId6C/PUKSUgBfRgLnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064

On 2/14/2024 6:36 AM, Borislav Petkov wrote:
> On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
>> +static void update_fru_record(struct fru_rec *rec, struct mce *m)
>> +{
>> +	struct cper_sec_fru_mem_poison *fmp = get_fmp(rec);
>> +	struct cper_fru_poison_desc fpd;
>> +	u32 entry = 0;
>> +
>> +	mutex_lock(&fmpm_update_mutex);
>> +
>> +	init_fpd(&fpd, m);
>> +
>> +	/* This is the first entry, so just save it. */
>> +	if (!has_valid_entries(fmp->validation_bits))
>> +		goto save_fpd;
> 
> Not needed - if it is the first entry, it'll get saved there.
>

Get saved where?

For brand new records, the module will allocate them with the headers
and no descriptor entries (empty list).
  
>> +	/* Ignore already recorded errors. */
>> +	if (is_dup_fpd(rec, &fpd))
>> +		goto out_unlock;
>> +
>> +	if (fmp->nr_entries >= max_nr_entries) {
>> +		pr_warn("Exceeded number of entries for FRU 0x%016llx", fmp->fru_id);
>> +		goto out_unlock;
>> +	}
>> +
>> +	entry = fmp->nr_entries;
> 
> ...
> 
>> +static void retire_dram_row(u64 addr, u64 id, u32 cpu)
>> +{
>> +	struct atl_err a_err;
> 
> Yap, exactly, this should use atl_err and not struct mce.
>

Yes, tried to do *some* things generic.
  
>> +
>> +	memset(&a_err, 0, sizeof(struct atl_err));
>> +
>> +	a_err.addr = addr;
>> +	a_err.ipid = id;
>> +	a_err.cpu  = cpu;
>> +
>> +	amd_retire_dram_row(&a_err);
>> +}
>> +
>> +static int fru_mem_poison_handler(struct notifier_block *nb, unsigned long val, void *data)
>> +{
>> +	struct mce *m = (struct mce *)data;
>> +	struct fru_rec *rec;
>> +
>> +	if (!mce_is_memory_error(m))
>> +		return NOTIFY_DONE;
>> +
>> +	retire_dram_row(m->addr, m->ipid, m->extcpu);
>> +
>> +	/*
>> +	 * This should not happen on real errors. But it could happen from
> 
> What exactly is "This" here?
>

Ah right. The module should have created, or restored, a record for each FRU
in the system during module init. So the runtime handler should always find
a valid record for a FRU. The only exception I could think of, besides bugs,
is if the user does software error injection and a valid FRU ID doesn't get
set.
  
>> +	 * software error injection, etc.
>> +	 */
>> +	rec = get_fru_record(m->ppin);
>> +	if (!rec)
>> +		return NOTIFY_DONE;
>> +
>> +	update_fru_record(rec, m);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block fru_mem_poison_nb = {
>> +	.notifier_call  = fru_mem_poison_handler,
>> +	.priority	= MCE_PRIO_LOWEST,
>> +};
>> +
>> +static u32 get_cpu_from_fru_id(u64 fru_id)
> 
> Fold into the single callsite.
>

Ack.
  
>> +{
>> +	unsigned int cpu = 0;
>> +
>> +	/* Should there be more robust error handling if none found? */
>> +	for_each_online_cpu(cpu) {
>> +		if (topology_ppin(cpu) == fru_id)
>> +			break;
>> +	}
>> +
>> +	return cpu;
>> +}
>> +
>> +static void retire_mem_fmp(struct fru_rec *rec, u32 nr_entries, u32 cpu)
>> +{
>> +	struct cper_fru_poison_desc *fpd;
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < nr_entries; i++) {
>> +		fpd = get_fpd(rec, i);
>> +
>> +		if (fpd->hw_id_type != FPD_HW_ID_TYPE_MCA_IPID)
>> +			continue;
>> +
>> +		if (fpd->addr_type != FPD_ADDR_TYPE_MCA_ADDR)
>> +			continue;
>> +
>> +		retire_dram_row(fpd->addr, fpd->hw_id, cpu);
>> +	}
>> +}
>> +
>> +static void retire_mem_records(void)
>> +{
>> +	struct cper_sec_fru_mem_poison *fmp;
>> +	struct fru_rec *rec;
>> +	unsigned int i;
>> +	u32 cpu;
>> +
>> +	for_each_fru(i, rec) {
>> +		fmp = get_fmp(rec);
>> +
>> +		if (!has_valid_entries(fmp->validation_bits))
>> +			continue;
>> +
>> +		cpu = get_cpu_from_fru_id(fmp->fru_id);
> 
> Pass in that fmp thing into retire_dram_row() so that you can delay
> that get_cpu_from_fru_id() call until the moment you actually need it.
>

Okay.
  
>> +static int save_new_records(void)
>> +{
>> +	struct fru_rec *rec;
>> +	unsigned int i;
>> +	int ret = 0;
>> +
>> +	for_each_fru(i, rec) {
>> +		/* Skip restored records. Should these be fixed up? */
> 
> I don't understand that question.
>

I think there's a case where the record on storage can space for fewer
than the target number of entries.

For example, module wants to have space for 8 entries per record. A record
from storage has valid entries (which should be restored and memory retired),
but it only has space for 4 entries.

So should the module fix up the record from storage by adjusting its record
length and then writing it back down?
  
>> +		if (rec->hdr.record_length)
>> +			continue;
>> +
>> +		set_rec_fields(rec);
>> +
>> +		ret = update_record_on_storage(rec);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static bool is_valid_fmp(struct fru_rec *rec)
> 
> fmp_is_valid()
>

Ack.
  
>> +{
>> +	struct cper_sec_fru_mem_poison *fmp = get_fmp(rec);
>> +	u32 len = get_fmp_len(rec);
>> +
>> +	if (!fmp)
>> +		return false;
>> +
>> +	if (!len)
>> +		return false;
>> +
>> +	/* Checksum must sum to zero for the entire section. */
>> +	if (do_fmp_checksum(fmp, len))
>> +		return false;
>> +
>> +	if (!(fmp->validation_bits & FMP_VALID_ARCH_TYPE))
>> +		return false;
>> +
>> +	if (fmp->fru_arch_type != FMP_ARCH_TYPE_X86_CPUID_1_EAX)
>> +		return false;
>> +
>> +	if (!(fmp->validation_bits & FMP_VALID_ARCH))
>> +		return false;
>> +
>> +	if (fmp->fru_arch != cpuid_eax(1))
>> +		return false;
>> +
>> +	if (!(fmp->validation_bits & FMP_VALID_ID_TYPE))
>> +		return false;
>> +
>> +	if (fmp->fru_id_type != FMP_ID_TYPE_X86_PPIN)
>> +		return false;
>> +
>> +	if (!(fmp->validation_bits & FMP_VALID_ID))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +static void restore_record(struct fru_rec *new, struct fru_rec *old)
>> +{
>> +	/* Records larger than max_rec_len were skipped earlier. */
>> +	size_t len = min(max_rec_len, old->hdr.record_length);
>> +
>> +	memcpy(new, old, len);
>> +}
> 
> Fold into the single call site.
>

Ack.
  
>> +
>> +static bool valid_record(struct fru_rec *old)
>> +{
>> +	struct fru_rec *new;
>> +
>> +	if (!is_valid_fmp(old)) {
>> +		pr_debug("Ignoring invalid record");
>> +		return false;
>> +	}
>> +
>> +	new = get_fru_record(old->fmp.fru_id);
>> +	if (!new) {
>> +		pr_debug("Ignoring record for absent FRU");
>> +		return false;
>> +	}
>> +
>> +	/* What if ERST has duplicate FRU entries? */
>> +	restore_record(new, old);
>> +
>> +	return true;
>> +}
>> +
>> +/*
>> + * Fetch saved records from persistent storage.
>> + *
>> + * For each found record:
>> + * - If it was not created by this module, then ignore it.
>> + * - If it is valid, then copy its data to the local cache.
>> + * - If it is not valid, then erase it.
>> + */
>> +static int get_saved_records(void)
>> +{
>> +	struct fru_rec *old;
>> +	u64 record_id;
>> +	int ret, pos;
>> +	ssize_t len;
>> +
>> +	/*
>> +	 * Assume saved records match current max size.
>> +	 *
>> +	 * However, this may not be true depending on module parameters.
> 
> This must work with module parameters, though. Or, as said and
> preferrably, there should not be any module parameters at all.
>

I agree though I'm not sure which course to take.

Generally, I think the code is *safe* as-is. But it isn't ideal.

If the module expects records with 8 entries, and storage has records
with 4, then we can still get the data. And the "fix up" question applies
from above.

If the module expects records with 4 entries, and storage has records
with 8, then the module will ignore the stored records. This isn't
ideal as the module misses out on possible valid information.
  
>> +	 */
>> +	old = kmalloc(max_rec_len, GFP_KERNEL);
>> +	if (!old) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	ret = erst_get_record_id_begin(&pos);
>> +	if (ret < 0)
>> +		goto out_end;
>> +
>> +	while (!erst_get_record_id_next(&pos, &record_id)) {
>> +		/*
>> +		 * Make sure to clear temporary buffer between reads to avoid
>> +		 * leftover data from records of various sizes.
>> +		 */
>> +		memset(old, 0, max_rec_len);
>> +
>> +		len = erst_read_record(record_id, &old->hdr, max_rec_len,
>> +				       sizeof(struct fru_rec), &CPER_CREATOR_FMP);
>> +
>> +		/* Should this be retried if the temporary buffer is too small? */
> 
> Only when it turns out that it is necessary.
>

Right, but how do we know? I think it is necessary given what I just wrote above.
We don't want to miss out on valid info.

>> +		if (len < 0)
>> +			continue;
>> +
>> +		if (!valid_record(old))
>> +			erst_clear(record_id);
> 
> Where is the check which ignores the record not created by this module?
> 
> Because this clears all records it deems not valid and that thing needs
> to be really careful here and be sure what exactly it clears...
>

erst_read_record() only returns records with the given creator_id. If the
record doesn't have a matching creator_id, then we'll get a (len < 0).

Thanks,
Yazen

