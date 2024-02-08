Return-Path: <linux-kernel+bounces-57533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D4F84DA53
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281B91F217FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13AF67E9A;
	Thu,  8 Feb 2024 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JgmbdM78"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F62692E6;
	Thu,  8 Feb 2024 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707374820; cv=fail; b=OfQqsvjsNK0wNGCcyfgWAlqLKjq1CKDmkMJN4zW0ozhCD8eC22muNm++DS1DLNzvl5/EiuGwfiQdS5EETcqPcOkvp9mVJ9eaY7P5TNc7gxGab6ATHX76QHp6uP/965ndPax3wD167ehFkkXyPvM9I6cQ8kj0NjiTC3BCWLyWYAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707374820; c=relaxed/simple;
	bh=C4WDAl9FKNh8p+KIcphRNLNmiv52jhANSIi8GsiyWW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VPtg3DTWzgwggDQAxs5ZD0plEGW0vNHb3Zo3R5ET8cx3AhUV5opJxuOIsTN9l6FxfOvnkJefCeOhvHRGia/9kxOKReaxSDyasZyvosvAfY6hfyBChEhORTE+lpitU4hSZygpI6YsRquWPRgkixEio5bNjgFGJAyd53qxyms+ul8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JgmbdM78; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK4glv/qFu932eCGnfx3mXIncwSS3DfNznRy+y22+IYQ8nhP8kyzdccwPwxixsJtk5eCVatRulChuHtL8as1dkZd8junN0TRAq7aRPGVg72YNBeGlQgqjeOQwZoO+bERqolteM5KbtB6fkg13EA2eenVubYR1wNr/JqFwnhgtgu6K9Gj1Ay7l9EGN3df0YJGAWLaGU987BigGYEfEa+oDXsVf4z9OOV0jRUl1O0px/aSSanm1i+dEsZer5Iiud3NPrylFl0heDT61qpkGUUg/Jnxx0U3bHAnRMZd+HQEzDH+UKwS/C8QnsUV6xJ1uFg/xfspxCqI3VyCZVXx8wLXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMuWUOyt3Wbk9tXjEMEutHxSIKyZJSaUAxIYscsaqZg=;
 b=lUmWMi+zxCddcq/bSaDtPz1JWsTKC0ItgIONNV8nzB9gH9RdgYXFKPwi/RZRUpxKRYK0gbMAenleZNxPptb33ID/iPZhhrGG0s1NLcM9db/8zdYO4NFMqq8OLrf2XZLt7UOx+o1E5CqnD7mftfe9IY1PEX6vSDnEji/w5EZrVQHpP8OoYUZAXXTXIrN82xqV1wKzedw+plWxWRwMavI+BmGr4sevuite6O5PXBZeXIru6+KhEo79no7PY2NcGVcfgTwULQTg/DCNfPbhR2FKBzX2qBpZZ2UPmlfgbHXYl5geObu5T5sk9jEfQkxHlXyxfpAmkH/V0gTiyMul/hTw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMuWUOyt3Wbk9tXjEMEutHxSIKyZJSaUAxIYscsaqZg=;
 b=JgmbdM78AFXAb4Y10rnoD6BLHXaRtUsRVOSqzsv2CnqQRZ6rGTiWZ5oAmIn6Xp7QonNkPa0K2JDDQeVWfOyPM+W4c/XaLSS0Qz4Dl11MSF360xijUb3aqzlNPuAgogTFVZxl1yhMgEMh0OkZ0kV+O1u43+eghpWXQbfif4lO10I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 06:46:55 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::80bf:841d:6c75:64de]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::80bf:841d:6c75:64de%3]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 06:46:55 +0000
Date: Thu, 8 Feb 2024 12:16:46 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] cppc_acpi: print error message if CPPC is
 unsupported
Message-ID: <ZcR41oeR+VteHznY@BLR-5CG11610CF.amd.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
 <2343f6c652bbcfad9cb462b5fd05fdb49e833e1f.1707363758.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2343f6c652bbcfad9cb462b5fd05fdb49e833e1f.1707363758.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN2PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d4353e-7039-4858-8878-08dc2871bd82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wsQ06t0J3nsAoChITLRTwozQfzFkf2/jpcIWlEUjqZAWe764/VKx/vVxcpWdxImyK4Lll5Y6vtKEiaKQYb9irOKffyD6RFd1219CS97GvAOQzLxtRjAU03WFbVIrVr+MbSCb1o+aS5SgGTdlK6l27brNyQ6zXGyV/wx3bS+l/sGpA+J/xeVEmsRjjPOWn+cJox6FEDA1VeFDYanQvswjOMdpGnNoS/Vh5qfKBllNy+AoqjtAvr1WfKCxQh7SrKnwFft4ZjEw+kPLA2aNtTqcSYcZmlRyB/BVTAJ3yRafeZghrZQXLB2whTrrNv1HO6v/istIPr6TVgeTX7Q0GNXOulRdmi+I8hV3v+lWc4c6mNrWTUh/tbXoBq8tkh1e1hgAATyeWy2uNYFRK34Z8PZqyY45qU8H+c9Q3v8nX9YTI1Lif9Kwg1dgdTTdNhYmgpa8Sy3ACI353bodfchY5OWw3cMCf/RjmZjFdozD9YwP+Dzw4ES+Q33RPnWaEjNEebkKKZ4CCKjKUn3kmtMRPhUPeIHfe4tOsKzdxlEq0kQh8Xazpxes8oQ4GXVlC+3zzaAs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(26005)(66476007)(478600001)(6512007)(86362001)(5660300002)(2906002)(8676002)(83380400001)(316002)(4326008)(8936002)(6486002)(15650500001)(6636002)(66946007)(66556008)(6862004)(6666004)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FRF30mQmKiptTmLCHEI+VJoSMj2zyuwZeqNDYgxkNjhC9LoOfw7Pyh2h24RN?=
 =?us-ascii?Q?psPqQICUymQ3rtxsh+FJQlIJz1mEoPJ942wfFI6bUu6xSoZ+Lks7xerT7W/Q?=
 =?us-ascii?Q?+drwi33dWhtzBHC3tAAzrMsrzdRouCbcWGuaa50+wh3oyUMvWkcZlNw7d/X8?=
 =?us-ascii?Q?S8d2dSJ3Q/0OMA8ksVeyDWHXY3lUXljNwJnq/5cahX+NwDvG1uZPKpknhK76?=
 =?us-ascii?Q?nJ2ewLyo8NJDSwHHsLn4zMSmueioFgCHe+7pehP858FCo4TBUgqUzmQDQEi4?=
 =?us-ascii?Q?VJXgbpV8np619bW1QxjNPsqzad7hmqCGH3PfZjVBf1ZZkRcAc4d5cBd1EILf?=
 =?us-ascii?Q?0+fLVMaFAe7v4Sv5LBHFW8wQsRFSTmjJrex8WA3hGV8Jo/TMgekwvRvy8P1M?=
 =?us-ascii?Q?Mnored2UAat0jPFxD+OJPBqQHqTKBTzTNzRKbCx1YB79vDFlyCKLzzoLM++b?=
 =?us-ascii?Q?UWHkzOda4HpfDfWOIe2jTBn9/XtpDfGDibTyNMmtc2YltEiHoNlXP0lrBv22?=
 =?us-ascii?Q?6nqev0OfmikL1enpxe6ULHKHw52l4xTgT1SAW8PT4wJ4VG4mBhaFaj6dO5pj?=
 =?us-ascii?Q?SuSgPw+oD/Q3igPaX6Z3g8iIZYRed2Hh9iTF6es5wmAOm44aifC9mWv3PWW0?=
 =?us-ascii?Q?hoe9pAoSrf9YEBfPOaySSWzdj2GAZXD2ipZBsSOXcPxTjq5RzcA1JarhFpnH?=
 =?us-ascii?Q?oGXpyYaYyGnJ/8JT3/JXeL+qjM+3aL5pSD1/kEylRiADFm6Kgk4yqjwhVoji?=
 =?us-ascii?Q?8HmEq8GJYG586W+gpiyiFfbrmK3vjXZSuRu0JATS7ruex4DkboVFVVGyXCAk?=
 =?us-ascii?Q?W8XRs1cByv+sefMsBnqGOwcEfNhAhtTNT8vm89i30UJFQVjTfU7MI9roWlHo?=
 =?us-ascii?Q?czyewzM3KRziVeztwLl3p99F8rRi4ToHg+lAfyUg2nUoOd05DlFZvikVrsej?=
 =?us-ascii?Q?zXZWR1lAYsmjn+iTi98emSkMr7SyMHcvUQ7MPfaEz+S5eF4m/EUpu4PuhSt7?=
 =?us-ascii?Q?hnzSCpHfgVAPTDa0PZ/w6Yj0MjFsC6KsJZPdHD0Uz1ImhHeWLvFqvjkMnOe9?=
 =?us-ascii?Q?pDnt07HnX/vHE/qX+VDYP8XYZw8Wo6Gc2wuuWlrhcq8v/bm+egujrXauqr/p?=
 =?us-ascii?Q?5bVqKa/jdfYbNveo9U3dO8hgzH/l2lPzUQdBKvVfTvikQb7IxWlNMt6QaWfd?=
 =?us-ascii?Q?81mfNnNEV1I8fu7x79hS8tiD7yDwxMoPbaUfDfapumiiCjSdRjmWRihZRkSo?=
 =?us-ascii?Q?O2RbTSN9tdC0XroHRSLi7Y0oeMhWKvZAxx0uRADbbTg08wCMWIALNcOdwLtc?=
 =?us-ascii?Q?Y4yJM6Y673cDfAHTudlgucy+IqaxJElBspqKFDtha/VNEt/CurjqnEF5MbIe?=
 =?us-ascii?Q?hskFXbzSscbi/+9LQ5IR/FTeVdXNykcdpylrRzQzi1+K+nl5pWJ6fOnM+u7L?=
 =?us-ascii?Q?yaYeGFMzPA0baV3a/eRlzZXAVE6gnYZbYCpsBzPZODRsSfgMsx8E6o6wtt8D?=
 =?us-ascii?Q?wUxAaVSYhDRlDf74KJI7KyZFNtXpHgSRzG9e6dIS/uA+Y8U2iP3iPSiuuVT6?=
 =?us-ascii?Q?BVvjsVpEWd9Tc1CrrV1TxEQe4Z8ByRw4TX+auYRl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d4353e-7039-4858-8878-08dc2871bd82
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 06:46:55.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqVES7FyP8g42bBfUqBKRNZAHByuowRGqwBq+HzDX8Y97wJBHL9/MDuKRHK7hWAz7y8KipVW7aj+lGTKUa8aOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

On Thu, Feb 08, 2024 at 11:46:32AM +0800, Perry Yuan wrote:
> to be more clear what is wrong with CPPC when pstate driver failed to
> load which has dependency on the CPPC capabilities.
> 
> Add one more debug message to notify user if CPPC is not supported by
> the CPU, then it will be easy to find out what need to fix for pstate
> driver loading issue.
> 
> [    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
> 
> Above message is not clear enough to verify whether CPPC is not supported.

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a50e70abdf19..e23a84f4a50a 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -679,8 +679,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  
>  	if (!osc_sb_cppc2_support_acked) {
>  		pr_debug("CPPC v2 _OSC not acked\n");
> -		if (!cpc_supported_by_cpu())
> +		if (!cpc_supported_by_cpu()) {
> +			pr_debug("CPPC is not supported by the CPU\n");
>  			return -ENODEV;
> +		}
>  	}
>  
>  	/* Parse the ACPI _CPC table for this CPU. */
> -- 
> 2.34.1
> 

