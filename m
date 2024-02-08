Return-Path: <linux-kernel+bounces-57524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9E984DA36
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF8E1F23409
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91067E6F;
	Thu,  8 Feb 2024 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P2nLrBvy"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45B67E74;
	Thu,  8 Feb 2024 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707374088; cv=fail; b=hvmrnIBKFzjsZGWoxWlXAnmQw3fT8PQzPAVrGB8zBaCVoB8gD3zscbDwnXILXIUAe6Wmzc1ab3AynD8B7znlwC3t5wiyYtIRf+PwxGcWbagnayzqfPMhq8KPNKc+H9U2KIUjl5xtiMxcBxgX0RCJTdSGci/0ISq40EJTmd0cJ8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707374088; c=relaxed/simple;
	bh=eSyIUYrli8QG1gWMFczdjw4VK9pzKrxDLn5yULiA3e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I+I5OddS6IZ+Aeu1qbwVmLKQxnVMyX6bXdOItCOMbKf+tay5m6hTZeWFNnPG84i1JXd3XK+mIllYCoAMREPfWAXf4mmFZOYWy70yjw6uaPqjU4wF70HiJ5t5CcL1ZEJMI/ztilQOm1aDEmRjFq3X3MRPAyidYG2Xm4FZ8CIKm2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P2nLrBvy; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnGheZEK/K92e0xExyE+kOgKuxCDMMd72QMtaflVIsUQHZQHtGgvOZHb3N2WSaIpwEK8XlQMiZ8Uj7Y/xSLEfVekKbTBLuZEsXkNQAgtAuarkQFCU6Y23GGbjsERGIcrQyA8BZj+/mKcu6IuJxYohLEq/iD9a/WWlvW0WpXb8Nv3Km2SGXO9yh1c8Pqw3bmk5lYToqpdXNn8w0zX+veswM+dQVZVLzces2nhxUNVr5ZixFTNWWNcMiivRyQpJTC+L8wiYmfPTodFPPZJGUqcws/p9oICXuKhLAtvuSRI62LaaFEuEBkui+CCXSMwl7aejZtqsOAjKB+UuqBX/H18sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTPb7rpzQdpdJ9RvSBK2/N16kirGMlPmzPNO2LGt7fg=;
 b=Epzb1jZ8dXsN2tJcZmC+M4qOJb9Kx572IXpZAx4ytS7AevyYMoeT8hVXMS9ze4qiMgVrVtZswYUicxAoKMqAN1kdJ/AJInCpe6y/WusdU4lMgBQ3susLOyjZJYSzZvXmo718YzYYKnZ8u1TJG1FtjnoEi7bJV956DnpBDXJeIDJQxKhBPGhKWXUB3RrtdsPyP7J6LMHpEpe9YQhJ2S8hGTQ0qUhbs0laBDDvd0L50EyZ3P4pWkSor3U2uLDSBwmGSzmOolpe7YXKn7fq+yfmv3GFFrXoYXZS2jqF6k4R+o8JceJXs3gm8dGQ1gWKSKmZU297wg+cndFv/IuKc0BG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTPb7rpzQdpdJ9RvSBK2/N16kirGMlPmzPNO2LGt7fg=;
 b=P2nLrBvyboRnUcNJrJPmmH+G6rx0rSh7q+/DmJK06MMlmYuTd95bG5PxiVBKmYBFUfajQub9QWGUhL5GkqJDnhp7bu+5mHwefAmNWJk5aIr7/LLKtprmf6z9iwPbvX3vadbeYtBQ4B6zFPfP3mRuSnDj4cIO9O0T0sKmqZd5pok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 06:34:43 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::80bf:841d:6c75:64de]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::80bf:841d:6c75:64de%3]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 06:34:43 +0000
Date: Thu, 8 Feb 2024 12:04:34 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/6] cpufreq:amd-pstate: initialize nominal_freq of
 each cpudata
Message-ID: <ZcR1+kL8ShJdnK5B@BLR-5CG11610CF.amd.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
 <b4fcf3b4c2b5abcf79bbaf9780fe67b4ec697dee.1707363758.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4fcf3b4c2b5abcf79bbaf9780fe67b4ec697dee.1707363758.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::21) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: af8d2d5b-9a85-4377-7ba5-08dc28700930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XBQUBikmSS6bFEMuiOfGir7W/n6nyNJPMaTQr+AnUF9/rElgdd59PTgqD2BhPtPSwT8NSo0T8/ZrJcwrTVED8SJxCqONjzQ9g2GJbghajNLSm9sy9F5jO37dkOTYPTFMV6dI0pOZ/PJJyXK1OcdaXeaYT+ssDieYK+75wgb9RHYI5zsDkTW0vhl80TZGwMWLtA4LwEWJ+skveKypII1wSvVN5eJ9SjVc/l+RZPet6//GT7dgAXCENrHB+m0ozwbD0K4ac/BTKOsaUhZi/lZqpEl69rXUFiiLzg0ukE33iR/0x9Nd2Vgs6GprzMrlqF1VjPH8YpixNX+GT2oiva/6z+VcrmJmJ7t9JP3fYVu3wE0CcdbBfDUzHOTRhU99u2owBV2Qb+51DwfqqQ3kwc0Cx1B7q8/j6Oyh771+nmCCkgaR4v85wDZcOhrURyFfGLz2YuwYN1y0JuwF59fNZ5HCn7zG5S+AMezudAaO566wEvujfCMx2aLqtD8gs/LMT+r8k3RKLw2besb0YPWKoPvQaMAOID5uduOap9hMraIvIg3Y5XRR+FL55RKPYbC6YxkO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6512007)(26005)(478600001)(6486002)(86362001)(41300700001)(6636002)(38100700002)(66476007)(4326008)(5660300002)(6506007)(6666004)(66556008)(316002)(8676002)(2906002)(6862004)(83380400001)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TXC/A58APifh6W6mA5CYsebq2TADR1wYNzQWJsF4ypkoXfl/L+BpdjVWRZO6?=
 =?us-ascii?Q?iQjqdTRly/P8Jsye9XGjzMfS+Dsh9twaJaUSMkPi8fAAyakD954mDMfezMmN?=
 =?us-ascii?Q?HT8Q9Y3x22k30cAF3D/8wJJCihmaz/3fZtcNyNZq2Emvcmg8J5ljZr2Z6T8e?=
 =?us-ascii?Q?G3Kt2p5tv0rPx9UQyNDPrZfHgSUpaNA2VNg0r9/j84h/X018Qn7NHdcHWM4y?=
 =?us-ascii?Q?bw1lUPtc796yoGIE7QzqEZlcPd1IWmNlP47wdhEd5RFQvvYPjabGhsF4+iCE?=
 =?us-ascii?Q?b7Pe1/NpJw7vmP58PBncTemhplZMQS2cAZ7ssc+dpJoIrpeM6NYNfsHHN3QJ?=
 =?us-ascii?Q?v7N9yJr2COW8CayXGXf52PkLja/ycVz/7LRN837NdCJH84U/vMjK3WSKlk8Y?=
 =?us-ascii?Q?Z5Z1q7nB4x5yZIkV62L+Gdgx/ILoYN/LgpGu520TToevvX/se477D+xEsmOQ?=
 =?us-ascii?Q?WbMciNI0RfrGRuVYYZSOyEFzADiO/PdYirr+YfQKdHo5tS2lAK3CqI0TmXYM?=
 =?us-ascii?Q?QMvUmoBK/qGhintIwPTO2c1OLfZ1KC3t6PHYpm6SfbAybj0dHMJtI6b6JH0w?=
 =?us-ascii?Q?acT6w0Lo/ZDD+rJlncVLv7pTNGQF8REKJEF28UMMz+646URT+dtyad7fsYDc?=
 =?us-ascii?Q?tzR/SYPRbDvKk/NOq93u7HDhsSXzDhdTYT9f7oYv8e2TLcyc9C4qr9mi5omg?=
 =?us-ascii?Q?y/TU7LM17PoEydcwxsMdTvToIdgF2WDhSZvESsoVkQbu20chehTFUd/wd+Uh?=
 =?us-ascii?Q?p0POPzSb6jcV9MaHkg4/MxtGXhlwJIr4Uey13CZYl6TRmCAO1Ihekk5mp//V?=
 =?us-ascii?Q?zAZ1kIxjCC6RvUvsgJD97zY3QWBTbgoR+tp2yvd5ItVrU5Vbuzi1eVjwocIW?=
 =?us-ascii?Q?EwI5ye0t8w/ufdZCIGk9DIAlV0bHOup5JquBHmEDdMSO5nTM9YlDDRtHXijd?=
 =?us-ascii?Q?wqCm52IRydx8D4CEkDPnRUZWqu5zcZlH7IPxOMljQrAr0VA10euR2UUvgZHx?=
 =?us-ascii?Q?nntSG+907XXQhPIylpjFGdWpd1dwxazgb/WlCRIFoW0tWHxsRr0ckkHnRDhV?=
 =?us-ascii?Q?n3e4DA3IFOTjH1qxH1x9FRw6MqVQ0chYFN0/a6sEel5PnrL0I2dJpMjfzanC?=
 =?us-ascii?Q?va0de/vVDPrSZ4KYLexxFeNETq2uSeoa00tV8b1RZkDrm2nzkfxtVqy8ypWU?=
 =?us-ascii?Q?cFZ2Lp7b5UsVLxIYO8xJxf6RPtsHdUWQ5zmpbabM+rwrcBRlo4vD+yLiJsiw?=
 =?us-ascii?Q?czA+NeoGiz+l+dqJ9EDG7UDbkom4l11jkFG8D/eLCbSYGMP9Ejx9ALMWQRA6?=
 =?us-ascii?Q?TtVbjNmAQN1yFb8pdCHTxaVu8Zm3mz6A7M/UIWhz98CTOZ3/neh4fHcH9xfk?=
 =?us-ascii?Q?X8WsEtqWrFaivzD3QgW3c7u6oL2eW/cJSPFaeLozie8kxjuGfYFKDvfZLOYq?=
 =?us-ascii?Q?a+cqqzhN0ujOZUdMA9AGcxevdPqGWPttiNjAuGSUkZcsmL63rPj945lZUq/V?=
 =?us-ascii?Q?ETZKTpL853azd5Jjed0eFrQWBYrxSq4kVKYq1NaoD9axRR58uLd+AHY9+zD+?=
 =?us-ascii?Q?piTOh0fM+SbN0vX6ebXizAPM1aHa2IFgrNqNOO9r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8d2d5b-9a85-4377-7ba5-08dc28700930
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 06:34:43.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db14sLH0Gbx/e3/x1Q95noLzaQJx5XCSeTFz8+zMKvCHI6vn22esMMHKnqbyvWdHeDtlwnQJnu333nvoZrgHcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791


On Thu, Feb 08, 2024 at 11:46:30AM +0800, Perry Yuan wrote:
> Optimizes the process of retrieving the nominal frequency by utilizing
> 'cpudata->nominal_freq' instead of repeatedly accessing the cppc_acpi interface.
> 
> To enhance efficiency and reduce the CPU load, shifted to using
> 'cpudata->nominal_freq'. It allows for the nominal frequency to be accessed
> directly from the cached data in 'cpudata' of each CPU.
> It will also slightly reduce the frequency change latency while using pstate
> driver passive mode.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ac7faa98a450..ea8681ea3bad 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -619,7 +619,7 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
>  	if (ret)
>  		return ret;
>  
> -	nominal_freq = cppc_perf.nominal_freq;
> +	nominal_freq = READ_ONCE(cpudata->nominal_freq);

Does it make sense to call cppc_get_perf_caps() in
amd_pstate_cpu_init() and amd_pstate_epp_cpu_init() and cache all the
relevant metrics such as highest_perf, lowest_perf,
lowest_nonlinear_perf, nominal_perf, nominal_freq, lowest_freq so that
subsequent calls to amd_get_max/min/lowest_nonlinear/nominal_freq()
can use these cached values instead of calling cppc_get_perf_caps()
again ?

Because even with this patch, we continue to call cppc_get_perf_caps()
in amd_get_max_freq(), amd_get_min_freq() and
amd_get_lowest_nonlinear_freq().


>  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  	max_perf = READ_ONCE(cpudata->highest_perf);
>  
> @@ -654,7 +654,7 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
>  	if (ret)
>  		return ret;
>  
> -	nominal_freq = cppc_perf.nominal_freq;
> +	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  
>  	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> @@ -848,13 +848,14 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  		goto free_cpudata1;
>  
>  	min_freq = amd_get_min_freq(cpudata);
> -	max_freq = amd_get_max_freq(cpudata);
>  	nominal_freq = amd_get_nominal_freq(cpudata);
> +	cpudata->nominal_freq = nominal_freq;
> +	max_freq = amd_get_max_freq(cpudata);
>  	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
>  
> -	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> -		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> -			min_freq, max_freq);
> +	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq || nominal_freq == 0) {

+1 for the "nominal_freq == 0" check. On CPPCv2, nominal_freq and
lowest_freq are not advertised. So nominal_freq will be 0. It is
better to fail here than failing later at the time of governor
initialization.


> +		dev_err(dev, "min_freq(%d) or max_freq(%d) or nominal_freq(%d) is incorrect\n",
> +			min_freq, max_freq, nominal_freq);
>  		ret = -EINVAL;
>  		goto free_cpudata1;
>  	}
> @@ -893,7 +894,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	cpudata->min_freq = min_freq;
>  	cpudata->max_limit_freq = max_freq;
>  	cpudata->min_limit_freq = min_freq;
> -	cpudata->nominal_freq = nominal_freq;
>  	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
>  
>  	policy->driver_data = cpudata;
> @@ -1310,12 +1310,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  		goto free_cpudata1;
>  
>  	min_freq = amd_get_min_freq(cpudata);
> -	max_freq = amd_get_max_freq(cpudata);
>  	nominal_freq = amd_get_nominal_freq(cpudata);
> +	cpudata->nominal_freq = nominal_freq;
> +	max_freq = amd_get_max_freq(cpudata);
>  	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
> -	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> -		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> -				min_freq, max_freq);
> +	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq || nominal_freq == 0) {


Ditto.

> +		dev_err(dev, "min_freq(%d) or max_freq(%d) or nominal_freq(%d) is incorrect\n",
> +				min_freq, max_freq, nominal_freq);
>  		ret = -EINVAL;
>  		goto free_cpudata1;
>  	}
> @@ -1328,7 +1329,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	/* Initial processor data capability frequencies */
>  	cpudata->max_freq = max_freq;
>  	cpudata->min_freq = min_freq;
> -	cpudata->nominal_freq = nominal_freq;
>  	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;


--
Thanks and Regards
gautham.

