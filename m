Return-Path: <linux-kernel+bounces-96727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C98760AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556A11F22B80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6168652F9F;
	Fri,  8 Mar 2024 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sr8pb2Hf"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB1524DE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888984; cv=fail; b=ssWRNhSTlzJkaoQivv4dnNgH3snurDn3HnZrarSwdEPyOANYgcApTeY7dLOagVcV7FXlzmWzLLYLQAYsTwE9GEmxHbQCdysdfRT2W57Akxk1+IIjqFSfDYEXDI7sZUXlOkTvvvjOR2tb07sEC0YjsZODup1FWOk2kW6qaYZrTZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888984; c=relaxed/simple;
	bh=FdFLc1wssjp0kIR7VA9tU3tYlZ6wHNe2mJc2KIVP9+A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WbmOnOfIZglTpXq5Sk4xP6vR3wlJ0jiUT5gIY8C4a69uV+wCOcrrZdGtqAR8d6bgiOscsnxsiZPnTvi57L5SXKxfVZRxJ697WreuBdCwM1di/SIpkMoEawTPJ74UFirE4C8oG9FC9AgH/QkLGKz2l/5gwjv2ne5pSOJB7w9HdZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sr8pb2Hf; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ddp1veaUjlSKTueYt6II+8SeEsgXrm8Mk7pZpYVkuHKybGNvP6c3qqOzfT17LlXEeTE4uhHGS61UvOKgxX8bHrbOkqxybwJZ+SeXiMP2brSRnuy2+Qk0K+1jA8I0ykfP1hpAQHa70mYJmz9QihsuUuef9p0aEZVNOaGhoZX5bkYB9o0k2XdgqqYoZ8jqzlaCq+Kp9ISoPkLIigaNNeWwWYdbSzPe//xcIgzfJc9mULsIMKGL48MsUUUyfMinIcqdGw1f0n32FA5+qAPMbS2s504ytHstR0rRtirm8rWkP6+q7O0+X5Bb7FwuGUkNBoKqwjaBLKuNOvH2POUk3uo5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ+hgpIpmrgFSWj7zYIadNN5nLbc9kpT9/Y50n6URzc=;
 b=ioCUNtjO02fG6D4Za63kvQvY4olBEVK4rn4oNkGVWYMFgrVoiai1PqR9EyR9+I2fBzyU8+xhsHlzPsd4CrEG+sYwU4496V/Tml/YrpD5iV7AlFf5apLTO6BHxDfw+goOlfJieK8hs4S8ctcwkQ1ICITuN5pqbOV8lB7bKh2F+3bmx5uYoV24o0xkHTYDdvuoqNMspU/ntOHaaRdoxR0Fxb2yB2zEJ2taoGiaOV+FVolHai19ZmNWIuVGPUy8M60aC2btstgdX6l3iVFiwLrI6yGJ97p4RXEl9YGKeMg6+5qZaqR0dDRGzH4EP0zox9PRqweMWQDyfwBeNED4g4tKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ+hgpIpmrgFSWj7zYIadNN5nLbc9kpT9/Y50n6URzc=;
 b=Sr8pb2HfjWGETTMJ2rOS5tVRoL+Bg1ty3qCD985a1GrpDxEG+8KnRDHVlp0WAqiAOcXQDOI6bLJ6qVeqLHQcjrQEqZMNNMe1QMXMXDeGcSA8fsBsxFGTJtxxHGGvAFpeyneOlu8ZooRyW5ai30mxslQiVXCn6aMKAOFbkYg6wXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 09:09:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 09:09:40 +0000
Message-ID: <ab7c8dde-c914-4e07-a95a-126976917416@amd.com>
Date: Fri, 8 Mar 2024 10:09:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: add vm fault information to
 devcoredump
Content-Language: en-US
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mukul Joshi <mukul.joshi@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
References: <20240307205054.3904657-1-sunil.khatri@amd.com>
 <20240307205054.3904657-3-sunil.khatri@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240307205054.3904657-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0c8874-5f29-4e46-84f0-08dc3f4f7c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yeiwqgii0XQ/tw74QmuZNBoAiZG5tpbHMp5r8AiiuYE85GuqrhKtsQSDNCGb34NDbRUPn12P4UmJl0BDiQcRMLcbL5C+wmFHGlvdeZx95CoWJZqhEWdwun6GqXhabH0k4JdsUFZL65qVjr5X7pGpGL5MYza2j2KNLACXg1avRcCTFt5LeYwlPavRWwD6sBx/E/ht+OUcft5PPgoLZhVOWDiO4Mv6A/wYv54DSLKtPF2QkYrQH+pM+EJzlep9ortT096RB0kMjR5Kp7AHDhdBypHjPcnMURlKkI8nbFvKS1Zh2Wrv3Vhx5hH6+dsi9K5/2x5tAfsLLIox5jcrO0bYfkGR4+C+esGlJCKTkRDymuv/TM5ZUctLmWpB3pWYeeY9hSF4exSrnsDI73/1CkFOwMM5MK5mPYhQ2V8zJBHU9i2qjl7oVdIw/lgo+QGaf7U7Ka1SEZWX1YQJ39W54CirlQQ95DBC+8CZEu3mkIAEqpk6SSNXZo4tHdvFOZQmV210NIaMs9xoV1VpQkJoIUz0omwAS/GjloFXpHVDbY1x2jI9Vog852A9SgE6//tvi8Juc9juCaWZIeXQBjjXWq32q1DL6IXlo3jJvkLNOY2VScKPnCox13sG5SRaKKtrR2NF9wj/RPkKenlqCiQfYJi6hothX3i0kxidBnTTTcViltk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUpjaGdUaDI5dTFZMWxHdXRZMnFMZ1YvUlhNNHBYUlBqMjg0R0JlNzEwNEww?=
 =?utf-8?B?YkVHcWVyQ3VTaUpHYmJvVDl4cyt4MDVpNnlUeTVGRGNURThIVEhSMUt6dHpK?=
 =?utf-8?B?L0FmSVNORnVQS1RkakZoakFrVi9uTDdIMTN5amVab3R2R2I5b1l2Y3YrNHhv?=
 =?utf-8?B?RndibzEwSXJGR3pESkg4SWo3bVFiY2FRaGdYWXloTnlESWEvN2c3UW5zblkz?=
 =?utf-8?B?aW02YlFFRUI1enNrdEx0NHZheTk5aWVYM25uNXJ2SXU1K0prem1BTU9DdEtl?=
 =?utf-8?B?eHN2R1Q2bUswaFhYdWVVK2tLelpHditCY0ZjUUg4ejYvOW5XSVdjTTd5c2Y0?=
 =?utf-8?B?NFhxSEdXMUpTNkNjeHkyS0RwOVFlL0NjS3oycmNPY05sMmRVaTlTMHlEU0hE?=
 =?utf-8?B?ZTU3dFd2VUFpalpETEZZMVA5dWhYU0xDVTNwU1F3RXIxU3ppNW40aXByWU5P?=
 =?utf-8?B?TlQzcW9INkJBODIzaTdQWjlGd3JreTVzL2lQbHYzcnhRR0swZ1QwRXNjelNU?=
 =?utf-8?B?UXV0ZkFrbTU0RlM1NVRaTnR6TVJnc080Mm9qeml1TUFiVGpiQ2Fva29rNTA3?=
 =?utf-8?B?Vm1ZMzNXYnYyVE9TcnR3WDJNTTVySWJ4WEkwbVFSMmxMRFVncVhjMWdUN1Bn?=
 =?utf-8?B?UVkrNHZTZGFRMEZrNXpTcXFGSGIremdubzJLdHcxMFlRZlhIU3B6Q2hwbVRp?=
 =?utf-8?B?Um81dWNEdndEeVFKYVUzbU9CREp5V253bkxzM25zNmk4dGpzdFkwWmNva2pn?=
 =?utf-8?B?dEpOOG9GdWN3cWFlbC9WYkpwQW1uaFhHN0F6c1FMcnZYSEs2QzRkYkVjeHJk?=
 =?utf-8?B?VWpVaGhmS2ZoeU5Fa09JdVpySWZtbmx6dFllRG12eU84SEo4a0phK0VFUkdP?=
 =?utf-8?B?MVJuaGdUMUNvajluSWV5U1JVYjQ0Y25aTUcyRXZVUEdxU0NKY3ZjeWhnbnd2?=
 =?utf-8?B?NjBBTzlBblFyVVlwc3RkNU05bGJCZlNHbVJTeGt2MEZadmNKRE1jYTdqbElZ?=
 =?utf-8?B?dlY4SzIvVXJPQWFOM3VZUFNMY1VMeXpTSFdxR25TZDNSMStjZUtmc1FuL3g0?=
 =?utf-8?B?Skt5dEhPY2ZlT203ZHJBa0ZTUGRxanJoMVh6WEo0VWNlRUZYNUpSNkFZTVdy?=
 =?utf-8?B?cFBvdWcxY2htb1NCclJHSFR2K1c4a1NTSTlFRWIxblZmVmFGZ2pEcnhjQVVP?=
 =?utf-8?B?YmZzdFJpMlloMWI0WDVlZjJ0SWlKZjd0RTJVRi8xM0laVk5lZDFFbFRrTXBT?=
 =?utf-8?B?NUkyNnVRZHVZNnlMdW5pMzJEaitrenpJZ1d0bnZha0kwK2pzZ1JxMm9pR1JM?=
 =?utf-8?B?SHBjc04vV0puSjBjaUs1bkoyd0F2MDdSbzBlL01INmpZSjZDTVUzNEEvZmg4?=
 =?utf-8?B?dmJmbXgzZXhoQkJlM1lJajluMFhVZFhiL01aanRxOGgrMmtabEczcnNvZlhj?=
 =?utf-8?B?M0ZYWldBcjNxNHEwd2JFSzBYSDJ1UUhCSlJ6NFBMam1scTFKalNuQW1BUXNS?=
 =?utf-8?B?NVdVTHVmUEJXMXliclByNzFRalFlN1F5SDNPQy9XZElIaFZTOU8xVzN3WHhz?=
 =?utf-8?B?NXNjSDd3TjhqZk1JdllkUHRsUXRXejM1REQxMmY1TXhkQ2JpSm5wZU81WVFY?=
 =?utf-8?B?azZwV3NpNGhqUnRsVHljWTM3R3lEU0tLU2xPenhHZ0tpVTlkWFZzY0o1NDcy?=
 =?utf-8?B?c0dsQm56T2NFUExHTENJc0l3UHFwWkpJVTh0ZHhYNzNmSkd0WnM3WGcvb0Vm?=
 =?utf-8?B?OHY3UWlqV2o2T1J0YzdhcTY5azc0eGpvTGgrK05aQzJPYmRGTzZINUtodTFW?=
 =?utf-8?B?QXV1cWh6M1pGL1hCVUVjN3VKbC9mc1NvbEJXQjM2YkZSVDFaV282Y29BZTAy?=
 =?utf-8?B?ZFpoSjdhNnN0NXl0ODhCa2ZhSFZ5U09LaW9hdHdvM3RaUEJDN2dLZXdCS29E?=
 =?utf-8?B?ZUhWUThqTXd2cE50QThLbW9nOWdscGVnV29MU1N5QlVKaW5kSjdRMWhFVVlJ?=
 =?utf-8?B?QlFubSt0ZHQ0Z254cmZiTkxjM1F6dlFBSk1oQjRMU3NiT3NPbEdVN09JaUVW?=
 =?utf-8?B?enJrNlZSUnpMc2ZKTk43Y1UxbzJhb0c4ZUQ3dWhpTXplQTUxOWlBN28wT0Qr?=
 =?utf-8?Q?g0wBRaCCARAZz4KDRG1RmSy8R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0c8874-5f29-4e46-84f0-08dc3f4f7c69
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 09:09:40.3511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEfB4/Jb/jG5kOdF79+w9vaoW/9943os9NYmSLh+c07M5doKTQcT1CyInlFEemwH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100

Am 07.03.24 um 21:50 schrieb Sunil Khatri:
> Add page fault information to the devcoredump.
>
> Output of devcoredump:
> **** AMDGPU Device Coredump ****
> version: 1
> kernel: 6.7.0-amd-staging-drm-next
> module: amdgpu
> time: 29.725011811
> process_name: soft_recovery_p PID: 1720
>
> Ring timed out details
> IP Type: 0 Ring Name: gfx_0.0.0
>
> [gfxhub] Page fault observed
> Faulty page starting at address: 0x0000000000000000
> Protection fault status register: 0x301031
>
> VRAM is lost due to GPU reset!
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 147100c27c2d..8794a3c21176 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -203,8 +203,20 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>   			   coredump->ring->name);
>   	}
>   
> +	if (coredump->adev) {
> +		struct amdgpu_vm_fault_info *fault_info =
> +			&coredump->adev->vm_manager.fault_info;
> +
> +		drm_printf(&p, "\n[%s] Page fault observed\n",
> +			   fault_info->vmhub ? "mmhub" : "gfxhub");
> +		drm_printf(&p, "Faulty page starting at address: 0x%016llx\n",
> +			   fault_info->addr);
> +		drm_printf(&p, "Protection fault status register: 0x%x\n",
> +			   fault_info->status);
> +	}
> +
>   	if (coredump->reset_vram_lost)
> -		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> +		drm_printf(&p, "\nVRAM is lost due to GPU reset!\n");

Why this additional new line?

Apart from that looks really good to me.

Regards,
Christian.

>   	if (coredump->adev->reset_info.num_regs) {
>   		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
>   


