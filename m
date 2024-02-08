Return-Path: <linux-kernel+bounces-57487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C6884D9B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81BF1F21174
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8B467C74;
	Thu,  8 Feb 2024 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YL9k4njy"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B067C59;
	Thu,  8 Feb 2024 05:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707371769; cv=fail; b=jZ5adSsw6gGZOz1H6sgJkXj3l1B6weuBAitq1Ze4VvIsIFYuEirn72IPXBwRTPzDn0alAzGLDOOmcodTLQ7eXT95wlYk3vPWqU+xCKaDaM5iHuzGsqwKkqiXKVcySNzpPxF54yvAIuFMGpGxfPfCloYkz5iJYjrNfVnOQCYoe4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707371769; c=relaxed/simple;
	bh=y/XukH5rM4i5nlREjD+My4G+TyXq65Y2BvE0NDrOmRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V1OdP39e/kpLl33vjh/wKiikiZ09sRe7pkuPuqAxsWYxHC9AiwRdJIECymWLfK+c77JmVWvBNd0F01qEFTStuoIIwhl3KimtCOhWO6haOvFMT7uyaKM46XgUOkG9eoKWupQHnBMC/QfGXlkrHiMLD+MT+TvwdQfgN/8niOgXzGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YL9k4njy; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvRgzSScKyBa8IIZjKTExRDam18wCsebQe41tfOgpqEFCb1vz1LEVcYVzzEBgn6N1arJ0O4RUGexHK0ub1fuCTXWjQTI5vgbG3aSuoRDAlL3P6xMzSDQZMedEK6YzfCS7nJ316LNyDOmwGAjcZ6pR7EXKAniJeGrJx3LCMNj3Cr58BDVhr9bfOcO2mJS8hx10HbYCWkuWDqEo1whHgMMoxyo5tDAzr895YcLOSM8sdH1YwShiPfobQsxp2jrmIQAPWBdUUq9URtlNPCGvCNU20n1F/o5/QrL9xrcS2Frk68xmM2MubtiNV9c3G/NTIaHQBkf9+kujOISzN9Onp1Kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+NHS/XHL2Hbz1cmNfxWy/HFRW5JWg5s/KMSXF0D7MQ=;
 b=oJm92sjnTYVjmfrV9t+yxukUxoHMgFO5f8EZKBcj1HY+a1sh2/1/8tScBH/1EiHxGDV4cZLH8J/sLM5MrpXtelM47Ia//iac1+6ZsuS7BOHWqsUhRUpysBX/96vyTEPBtKt479+MjRpKbWLMFzi8tTYyi8mR/nnyFx0dXzBQ8k1DIqmeBmQ8KsZWYv6Nds8cXRNTvD9exohhvCu20SpLwS+O2HFmlpV6TdR8+3sZB9cYsnunmHZx2ELoprxad7wQ9kaqZvpjML3YdwDCzhUyCBuKt6gd6/pGxXCOcMkICPSJpw8/xYnWtRJo5myZJhl9SGaptTFUj6AVvy7/eRcxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+NHS/XHL2Hbz1cmNfxWy/HFRW5JWg5s/KMSXF0D7MQ=;
 b=YL9k4njytMY7UZn2TsL1CiuduIBelzhwczAG/NTMYlDYriNXaZ70PSqOiDQuy7XMWQ6gvGArXZ058xp2agSV4jEpSomyytRS0u9bXfnc8HJ1A10TRpBY2Q2cOnff8AsZycdwwBwitBu1ba9qnUPEa1zCpedFSmYsHgqhFVFuWcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.16; Thu, 8 Feb 2024 05:56:03 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::80bf:841d:6c75:64de]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::80bf:841d:6c75:64de%3]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 05:56:03 +0000
Date: Thu, 8 Feb 2024 11:25:56 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] ACPI: CPPC: enable AMD CPPC V2 support for family
 17h processors
Message-ID: <ZcRs7Ki8dhxCfCM9@BLR-5CG11610CF.amd.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
 <f6ace4124c45e523e984b4eeab3760b95a70b72d.1707363758.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ace4124c45e523e984b4eeab3760b95a70b72d.1707363758.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN3PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::18) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 73bddf8f-968d-4b4c-e40e-08dc286aa22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OaMxQxmuXMp6J3n+KqdIuxO/yXTwY8LyqlvH8MszHKoo/PfNfIcwvhg7DEd261p8LEH74he3oroqUpkTX6qX4AtTG28qm0li3sIqe+BRZSWWtQCtxrcUb+VCHQGrSgmp5Aw+RTqd46P/1AYyTaQs6zknPT/08YwoCQ2Rl6YgH9qsFnUby6WzWXnVsp1yXZXxM5NOjcsl4qfMTB+k0J2fcHAd6IFnZC8/jtrzFeijj0jzy/r26F5mz7Y+qaLWqTjVUdr1ieMXkgAcz5DQcR8Ym1VD00nUFWGns1S0jsY4gl5jTWASyF2xhHcAW5dHj5ZHjVxUr5fX1iDgCSZlCKPM/huRABMQ8m4WHtCmUMGcw5+QJltxiwuB6cjHznllUhqc2gtqzj6FTNH0JM5dsUMoTQkonpdcdhx7OUKJJCGoSK+0eXkZ3Xo9g5JNwk8V1mjaJr4YZppY39By/XhZqzUFB2cLG35vPtrKSxwFm2waYNrKS7lHyF8fe+6aFTFFDL+67zzP57LBftNMZW7F7Sttirwy5Rje09jkTY5icqmCdui2xcWGgTgg1R0mw3UT5/x0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230273577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(6666004)(41300700001)(66946007)(6636002)(66556008)(66476007)(316002)(6486002)(83380400001)(6506007)(966005)(6512007)(38100700002)(478600001)(8676002)(86362001)(8936002)(4326008)(6862004)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PvRUylbwUUIZMVx8kR0coUk6Z6E51zeIp1rSbQnwast5emd/gOYF8aSS/nbi?=
 =?us-ascii?Q?GfyCTY2AnMw0ZEJYYuvkartkyYr9GOXnoNl7s+qrbhuEzNdpQXxchWRZNkop?=
 =?us-ascii?Q?jljTl1gv5Xs5gh2i/uQuOje/+J8o57f/o6YVXQrR9Ex1tVGdtuYRBV2hx3mE?=
 =?us-ascii?Q?5lsYsImfASXPgDRxF87aFipvr+bz9oVo/lDz8GfYy3LwA/ybr2xOsr45zmTr?=
 =?us-ascii?Q?NvR/iWq0L3+80CZGnqVfcmBxxuanC8X6dUc1Lfl0pThfZhuLiP0Gzqa5OMJg?=
 =?us-ascii?Q?zYsEHd2AbO8J/2AIPmU8WFLuxE8Q5nv4IHAuoIdSxIQCjLyq9OUM9PRjEpqO?=
 =?us-ascii?Q?uYLteMW4lxWY6a8JrkX3tZKQYlLF105xrlSZ57Wq9YTOXtEFpBAlnsnpE+wZ?=
 =?us-ascii?Q?dhpo3+Njp+/I60QEmveJwwnFpJUtwMfvdoMIPYxPQwVg/D8cqukCxgWKmBZB?=
 =?us-ascii?Q?fbE5AL02nc6rnKkaNb8Le7779a5saWO17jCr9mXQVEWhVUqwoT9nbPi/0fxj?=
 =?us-ascii?Q?+3DIPyTeek1Tl9DRtpwfzrkocb8yeDHgpYugC9pshN/Uq/MPolweM/ImSp0Y?=
 =?us-ascii?Q?9hrz+FCSi5wdUHesteEUE3GUrD/3/AVw7lHEg/CARJlQc2z9CdI/Si78d9GZ?=
 =?us-ascii?Q?S5vO0jwbEeguo5XBu+6AAfPPi+nPdjxyXbLbOPN6zRNJjjUP4iQkEyDuy8Z4?=
 =?us-ascii?Q?MwRI4E/6Z1vitYT/Y7WNiqU7mD2IQp6rGpotAy+7SrvjZ71erYesOsIzLV9s?=
 =?us-ascii?Q?ngRtrgEs+UkSpt1f+BzlxJYEZkxtxlXVCjqs1S8wjkJhe0kgZOfuqVr6y7Bn?=
 =?us-ascii?Q?OovjsTkaqnh8GZcWHFpZ+h+KdrAgDoL/WKoQIxRJWJgyx1z6aW2JHaiT+UzN?=
 =?us-ascii?Q?vKVg2dPa32yARYYHx3l2pv20ZnfHbO6aB896UodqQ5mMRUesKethIDQrMUJi?=
 =?us-ascii?Q?3AD7+mC6v1nRqjNn9XYDHul4nCu3/qQZtK5RsSzkR6RB4/5s+Aj8XZxQWY2j?=
 =?us-ascii?Q?nfZO6zK6dfq+H8MUNJyFnirV4b0qCuKTnKfPOLgblE+EeudK1OYAQrV9UDMp?=
 =?us-ascii?Q?j6LqQlqJ/AhpyAJK3t4EM0ADqaYuysipm4MykYbFd3PeCexKB6HvqLNZXei5?=
 =?us-ascii?Q?y+Z30LGkTCWQ+XTCs9GURuEGmP8dBbPWvwS8yZogF29Nu2L+sVuNwdT22TOo?=
 =?us-ascii?Q?d5c3bQuwGgACHDrojKMpAKGdcJBzf2Zu0vW2+OG0JdDqPr2Gr7VRVmKg4RbD?=
 =?us-ascii?Q?3BdpUPyDa1q/hErtDRX4d4xLjpHAYNSpO+LoDiv6z9IbFq18TtO8EuQpaZZx?=
 =?us-ascii?Q?wCIPgnOKA9acb5kTb7T0BCvOM346/IU37u/RmOBnPsYVJEzO343yV2iLco5j?=
 =?us-ascii?Q?UGx4yrDqbh8SS8lfdDASdYA+HTpTwk6JmDhECDj/qSDRtmxICWcUIrqSy/9Z?=
 =?us-ascii?Q?IsdG/gdQDsnTKZJYE7sLCZlPkVgZjFgON4oBXAc3MLVHU5BfvQ61NPGVE0Sz?=
 =?us-ascii?Q?0QZcxB/DHIt5LHZEnkTq9A6I2B4Zfh+sTYkTwlErIzaeSVA/s+rSuhDmO3Qe?=
 =?us-ascii?Q?7ZrvSM0rF3dXDA8oXSg0l32k5oGPcM7T8Fm7tbgZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bddf8f-968d-4b4c-e40e-08dc286aa22d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 05:56:03.5850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUQrYoBxQ5zQKhhZPr5jrCnIFKR+V3XSx0ImuYtJnV5+oZbzMyBL5/GEWkOBZcffGtgKm96Geif4Mub07K5QaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425

Hello Perry,

On Thu, Feb 08, 2024 at 11:46:28AM +0800, Perry Yuan wrote:
> As there are some AMD processors which only support CPPC V2 firmware and
> BIOS implementation, the amd_pstate driver will be failed to load when
> system booting with below kernel warning message:
> 
> [    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
> 
> To make the amd_pstate driver can be loaded on those TR40 processors, it
> needs to match x86_model from 0x30 to 0x7F for family 17H.
> With the change, the system can load amd_pstate driver as expected.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reported-by: Gino Badouri <badouri.g@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218171
> Fixes: fbd74d1689 ("ACPI: CPPC: Fix enabling CPPC on AMD systems with shared memory")
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  arch/x86/kernel/acpi/cppc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index 8d8752b44f11..ff8f25faca3d 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -20,7 +20,7 @@ bool cpc_supported_by_cpu(void)
>  		    (boot_cpu_data.x86_model >= 0x20 && boot_cpu_data.x86_model <= 0x2f)))
>  			return true;
>  		else if (boot_cpu_data.x86 == 0x17 &&
> -			 boot_cpu_data.x86_model >= 0x70 && boot_cpu_data.x86_model <= 0x7f)
> +			 boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model <= 0x7f)

This looks ok to me.
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

