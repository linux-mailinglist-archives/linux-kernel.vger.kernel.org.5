Return-Path: <linux-kernel+bounces-57492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738F684D9C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A9E1F22954
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37ED67C5D;
	Thu,  8 Feb 2024 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DV8Frx95"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA567C59;
	Thu,  8 Feb 2024 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372467; cv=fail; b=u43JPLq7p0S4iK151mLDswUKqcn1lLb8j0NoZm46xtyKV/5NOBxlNsxJdfs4ljzPGW6RHzq0HDPY6CJdPqL5xJvihH/R86N5PVSBFjgjMhZ7T48fi59omHwX3KbJ6L4epdJl68dbxsZ9UVOzHT1auMR8+thXRlxuFl9LXyeAN6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372467; c=relaxed/simple;
	bh=xPCiPZ3r6wB2dAdu9p2HDU+7xjPr+ggrmvwIPK4K71I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oOjxsvHQa07JuA6GtuQoh0leVRNuctpLuG9PZc/C6+80QK4JTBycUUM/091ANFOp27LVxf6sZzMwtXfFHWG5yJHNq82fKlI3iZHWqL63yqZTV3H8Jc1wGrRa+sFzKwT4tS9gGLzUu0ag1JREX65erUkZ/1zTn0UegbOt4WaVHz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DV8Frx95; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiPjeVrB3xI3FwrSE2mTYzQ7+eQZcGINNrwVL+EaNULIMul//cw1jg9DH+sQNDCp2IU/waQuSFgyNFpXMPmav90Jn30q+dU/LMFEB6b7+CEvw9O2whV9dM97TirCjukQPYUPsWNC4U7clepSYouGLnWoTAp+58qfv/uRznnZ1qg5JpHP0t8lHM1EBF2M1/2TOAWJYNySzODUYv3fo0uzOvR501Ce3MAu20O8AtcBfwIt0ppOKr1waEbIoL6MxQpPCZFGztxk/XNRwVlXQouChHlgdCmXrGOiL0UGXAtf0EHClHSX6d02PtMciUj2wXMi5fb3NIgdzCYd5bGfEF9+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ11YTQjrMDBjiEGjkBRWiXzHIptmO1mcDYFDefNz7Y=;
 b=eeLescEx8A+mHEOeVPpiinWZOPD4eM5gm9nzWfURHoJ0+Ti+LjcfvPFxBpumxTdbYn75myXA3t4PgknoImCj2p6QPV2eem5PZnaqhnvpldi7JtMgRIbRqbhcOhCsiIOXfvTHZ5DxxmKFu2ASSJGCZo+7E9uRbudpxakOBsYpPrC2/oEY8UL9hsJAVfP3xUHx4XL62S24CYrOFM2yVlI7lPdLTWWhJUCkRkvFpka/nw3q6/Ob6x/oyyMOvD+MHCo52BNonV9Thz4uuVmAQdjhGx8qm4wRPwrfGmSTyA6M197hpSEXPhGhfOHICTkWr5+/JHyUd9WD9wX6wBmzTRlVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ11YTQjrMDBjiEGjkBRWiXzHIptmO1mcDYFDefNz7Y=;
 b=DV8Frx95j3bIKsCtxoboKNlg0VM5Vjwm8UVnYmQ5JyOqlnTdBmpySflSIiyO8bAZXH8YsdLGPjAmS2IJ3h/nzdWUoaQ298fxJUQ9G4JNOOgS5fYlZRyzoZQ8VoSYBp5/ZK826AOyh2myrgd1WryUtMtcD8kBNOJwNcqg/nOWc84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Thu, 8 Feb
 2024 06:07:39 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::80bf:841d:6c75:64de]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::80bf:841d:6c75:64de%3]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 06:07:39 +0000
Date: Thu, 8 Feb 2024 11:37:29 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/6] cpufreq:amd-pstate: fix the nominal freq value set
Message-ID: <ZcRvoYZKdUEjBUHp@BLR-5CG11610CF.amd.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
 <ebbe3741501a31b1ffcea208393cdd8929df6455.1707363758.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebbe3741501a31b1ffcea208393cdd8929df6455.1707363758.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN2P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::19) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a879a62-af03-4071-4c63-08dc286c40c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vFKzBOs9muEy9jT2bzC58u9wWTz65V9gAMnfNOVUjk3KUAlxcAxMuVjojuaCp7YezUmYVZfQwX34kn7hFcuh+X+0EHJpGkC2z57JRerkQgIzZamtXYaTga3W7s/0FhZ3WUeG4BqF375DHk7ojJ5HZwy6rTbqj5ovZD4+IGKGEdaTPuFEWVfRGJX3ANXNp3GHtD9glfN3+sIT7a9mbzJhsprtBIBdz8nhiH1xHuCwccoJU1sb7Vic9h71vePlc/sWEiGUWax+D5TEWM5AF5wXRsoaUwpa8J8lk0G77fFs4uZFTX+GzqLfEGQu6ZODeyxvxAk2jmUOaCwBzgouvngDI0CeuC6PcaIWnPXvXozQRJFhIws5POk+B4MQJRuZox/bD7p+OTMhcbXWhLs8k0zQnM2OAp7AoDkjU6q6xN7s64P6mJ8poy3L8KmWm9Z42A3SPOZ+yMTjmuEitdljxNhA7WG7RwdbkKAxQMJJ2yW8+V/cRvhzQDEhv6N2vc52FFn5zijn+lYaoANaFNRf4f4oq5nU1qDDpqbNdS6jsKpyNtKGsds6hIIayYT7x5YCvcCR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(6666004)(8676002)(8936002)(4326008)(5660300002)(6636002)(316002)(6862004)(66946007)(66476007)(66556008)(6486002)(478600001)(26005)(6512007)(86362001)(41300700001)(6506007)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I27UkG6PXkpojh3Prdh1XtdycUl3bqPRQsVHHXlkgNhJBQ3rVokOENSb2Oo+?=
 =?us-ascii?Q?zoqz1Vtavj2DTaDDIT49Etxe0OcGMHxCiZ9rZ9KNjzB5me1gHvahvpQxypLm?=
 =?us-ascii?Q?6mW+dUUwq/yfatp5GPn6xNuioxQ0o6O+VTIHJpin1+kZebzkUVo0fPBctnrV?=
 =?us-ascii?Q?UkGclKeHEuEG+2Rlu05G8hSgxRlngUfimZHV0utbNgkvhvIeYmSZ5ZRXZxBj?=
 =?us-ascii?Q?FcAFqkxHKEwAy9t0X0fJWxkBDVYP6WiMQ8ixlvJODQaZHT3/mZE3pKJ3DK2c?=
 =?us-ascii?Q?wcG6yTqseWaqB7AcxzXvfjE9ULoRwBWpHlUQOh6fDoNepq0sjDerlnloIbGB?=
 =?us-ascii?Q?kJEI8bVPVXdyhFYzuhwto8Tzd82gB0za65D00sinN6mvHAlDqTg36OJVsKIx?=
 =?us-ascii?Q?VLpI9PiXQV8Zs5bmwqgDDtH5oCPtyEVT4qFQp8gY5aQRqtP4Vro7c+UWgtTg?=
 =?us-ascii?Q?Q9+4U0ZdQW0U8IDiKyzAUTrUZePA7hN8vz4gG+k1D+PwH8FES64mxDGF0GIm?=
 =?us-ascii?Q?JSiTAOJF/2UF7JG2Ca1jxLu/JWegd9MWPiKhnG1nxADEOop1THss00bNVaC6?=
 =?us-ascii?Q?mR031uKJly9mv7zz8dH45pS+ZnIKa4jchFgQIe5bcQ4U6gd0VBU9MFcRJ2ga?=
 =?us-ascii?Q?bpUXxEPDNaBOZLwTyEe8OFkqTEhc9mqDykz6D77XIkfOO0BQRxRfsWaVo8ci?=
 =?us-ascii?Q?gtBDYVwtmMCOk3dD6Rzh/QPFr4kvezy8CXe1z7vD0zj/Mdx+GQnGuWPeWUPN?=
 =?us-ascii?Q?Eo3DCwJ2glT9YSXb9WS2L4Wds01Ug5kHuqLzCIORuv7rlsbrF+unQ0GywkOg?=
 =?us-ascii?Q?b6R/EOBQDic9ItX0VDKESs3ZXknM1qod4qFycLZfLm8Pq4WLB3DjDBJiRLWF?=
 =?us-ascii?Q?9VeVOR/+kXFVoS7u3ZGsaVIDZsCDTHOc3Uu07au4DnLOWpI9R/waqPSIcrRj?=
 =?us-ascii?Q?rGVGWC6nXMochTQQCcxjU7zlSLU7vt/ZYscweoUXFnPa/AnQaUc2eoG0F1Rj?=
 =?us-ascii?Q?4n2KNNEPSE6FUIZ6noQPaukZNreL3umBuf57W2XjhKrAMAe2h5ms4BgKmhEC?=
 =?us-ascii?Q?g3BM1t6hR7SQYoZgmMCO7bPyVceJ1Qba5yOIbdPsdjPnSx3kjsRtPg51OD/3?=
 =?us-ascii?Q?jdtpIA86uPBT0WxtdTcaK6vXROC1Yqa6dngQEnyxSRr5oYhe5T2fx2hykGQb?=
 =?us-ascii?Q?fyGqZFBT7ZL182b/zNOt743yujfjdcrDIikIa+bKwC5SmCvffoDxsNGp9R+V?=
 =?us-ascii?Q?iu2sev0mnDDRsujSn+Sc0qZ9H3H5p37asRtJ8Wz1eAhFZsXXoVq5APdbTRrH?=
 =?us-ascii?Q?8zcWmVLscotVquNucI541i3/6VtqRTvbWWWH0uP9CjXS0R0UxdCmVr00P6j7?=
 =?us-ascii?Q?9z+emYusW9Ikm8sjryb5pPjhfoHkp9jPJP3QTqorJFDPFTzI8iihzW1q639e?=
 =?us-ascii?Q?ds5zvZJeRWwy3CGwyn1lYNwPAbxFZzm4UeV4oX0b3k+q6cF3JtZazUSJq41E?=
 =?us-ascii?Q?gNd6VFb/Vq9kM+oS5PbWFyDeSUKXotZF6uVGP75YHCouxtSe0ratQhoquijW?=
 =?us-ascii?Q?eOqPteso0KHF773YKaKybyud6SWAh4r7jlkUEL2/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a879a62-af03-4071-4c63-08dc286c40c2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 06:07:39.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGjBVfe2WXUANuuYWCfXKaosaCRxg3iKs7aDPp23CeF9afGPwe1sEZaib+RYz+HU/oN1VJLkHaKllLCFZ8eHsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113

On Thu, Feb 08, 2024 at 11:46:29AM +0800, Perry Yuan wrote:
> Address an untested error where the nominal_freq was returned in KHz
> instead of the correct MHz units, this oversight led to a wrong
> nominal_freq set and resued, it will cause the max frequency of core to
> be initialized with a wrong frequency value.

The _CPC object on my Zen2 EPYC server which has CPPC v3, I see :
            0x00000190,			//LowestFrequency 
            0x000007D0			//NominalFrequency
        })
    }
 
where 0x7D0 is 2000 Mhz. Thus the value returend by cppc_perf.nominal_freq is in Mhz.

In this patch, we are changing making amd_get_nominal_freq() return
2000 (Mhz) instead of 2000000 (Khz) as it was doing previously.

amd_get_min_freq(), amd_get_max_freq(),
amd_get_lowest_nonlinear_perf() -all these functions return the
frequency in Khz units.

These functions are used the initialize the value of
cpudata->max_freq, cpu_data->min_freq, .... all of which are in Khz
units.

In, amd_pstate_set_boost(), we have:
 
 
	if (state)
		policy->cpuinfo.max_freq = cpudata->max_freq;  <---- In Khz
	else
		policy->cpuinfo.max_freq = cpudata->nominal_freq; <--- Now in Mhz

Since policy->cpuinfo.max_freq is expected to be in Khz, isn't this
patch introducing an error ? Or perhaps this patch series is based on
another patchset ?

--
Thanks and Regards
gautham.

 
> 
> Cc: stable@vger.kernel.org
> Fixes: ec437d71db7 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 08e112444c27..ac7faa98a450 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -640,8 +640,7 @@ static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
>  	if (ret)
>  		return ret;
>  
> -	/* Switch to khz */
> -	return cppc_perf.nominal_freq * 1000;
> +	return cppc_perf.nominal_freq;
>  }
>  
>  static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> -- 
> 2.34.1
> 

