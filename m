Return-Path: <linux-kernel+bounces-102797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76587B768
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BC21C22489
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA2CA6F;
	Thu, 14 Mar 2024 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DlkQ3Zq4"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E94EDDA7;
	Thu, 14 Mar 2024 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395357; cv=fail; b=ZYn6W+Hvz3bfzLUZ73x8b/OURriUTdOztX41nAAhungB6A8pn2kTVZP/v/xdMEREG4gtMWKX7oV3UHzoinz2zBUqpbdYfXlmmuLOnWyNDaZ8pXcq38m3W5tqi1E9uCt4QLq0POpvTJBJ7+L3v7MkNwOc+ms44I2d9iNnf6YD/Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395357; c=relaxed/simple;
	bh=r/By24lABu5jdUrBwn6vUbr+2BHVSLd6j3pA3p8mrDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=piXpfotlg6wGV/00Rt7fuhH9kcU737mAN8HfUnnb+fL3OigRZ4Lj1lAN8i7B08KAES200WfarxSnmDuh6I8ni9zbjesA+rV6E4kYF6/fSwJ76V/xVHMkzBWfAj1FIQS4kqYMsWMh7l+KvNIfmimovqKQtSFim8pODLRCXJ09Zb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DlkQ3Zq4; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GimwvIQBTehQJATT/2CSFZvu1O6+D9oczfZRxCcpyzmB8CKmJQSnSZSBMYq8uv3oUqN6lHo6xFN/HxdzrJDPmCWRP5UBX+9/SwNo+rE43UFENilXvLZM9qQ9FV7L0GXkIqkt9h2RX7nPvWTo9RSSEPRBfmNJYdaEhxKgLFIFO+LpjvDh2h4iTkkHfdU6NPzt6AKfaj1py3HdXXEAgOpSo1lNC6RkrGYUy+TOY44tPLciJ8BZPUnXB/YE4rR+wdaqki0hEFW7BaIJk2Pekl4yvGO8guGUPNm57mfQj1g3xntbg3vjNy/s75bktxc+/xwaeD0p8hiOQJV3IgSz2Idb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKndpez55Av8aku0r5Feg71TwRZcee2AtyjfhkC+P18=;
 b=SnrMitckroQy0bAI26BpvbwYkcG7UjnS1KcIgZ6hLphmtbTCBeNs6AvW8xhC8EJNlaIdDSY8tE8qrxhgUjjGPpwYHHfIOM/jCStvHeswwbf9B4Rlf1Wdcwn1gio7pDVaS/zuizOmzTHBFBGBx0zj5S8N84035+hm3esunXim12KbXapC0oLKxzkTpC9A3tqvtpzX/g/6ufi+0xLeh2yIxEPOpcm7pYci+NBRVb4gwZcmzZZ19slSAa4TwMfMjBZ99I84BNxdsJeYp9CzJOqJvwNQMx3fH+JqYG/QF9Nqh94pnAcsPCkOd7l33VyzQehQVsRkkF06wi2gZEUnTTwTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKndpez55Av8aku0r5Feg71TwRZcee2AtyjfhkC+P18=;
 b=DlkQ3Zq4Jyx95tE9kPNoNGm/JVtOqWPdcpVZJCwRrYiGYD4cxF+LJaWye3mzY2nafT+FqRRUvk6l6EHe72Z/QbuQkDcIw9ECPmwzFXYmEa3EcsvdH6n2aD2J54730JEmo+qsGAgux93mqHPg4XxfKZRUhqEvWqAgJIdO8zTdx+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.21; Thu, 14 Mar 2024 05:49:11 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 05:49:10 +0000
Date: Thu, 14 Mar 2024 11:18:59 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/6] cpufreq:amd-pstate: fix the nominal freq value set
Message-ID: <ZfKPy7hlwiYm++AM@BLR-5CG11610CF.amd.com>
References: <cover.1710323410.git.perry.yuan@amd.com>
 <08ed1f9f76a6a1c401efd8f426bdeb9681c4b4e9.1710323410.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ed1f9f76a6a1c401efd8f426bdeb9681c4b4e9.1710323410.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN2PR01CA0215.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aecf057-2618-43da-3d15-08dc43ea78ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ifu+3E376IhfV7jtdJi0BF4GijrZinKbnOpggN/KXdcNpQVI36qADEJS4WmyK1yo6gKbTMNTzb3uFleOCh/hy2HU8Rd6wpkJhDGKdksPgQjj0Lo/pPgqkdyvKG8CzvqxIPg5tBlEsuGjCoYOniuo27C9vYAcWs+pLemWn1xNc04bato/8Dg3YxGeLesTlpOc0hdlRH0hJgR1uRqWI1xiBhyk94OkOtj1CerGTjnz3D7VuEEtTlau337JWONk8TP9dnJFY/IppgdRHpu6Zc8Spm/+deghxzhJOUbXFKGD9+0EjvXOVXvCluQFoEFRgxLbPPFMvMypivwnG7tUoIHog39HNwnsce4QKO529bYWWTM3v2aMwO3OQ3hvei4KS0DHcm92GfgZWAGObjlG5NNrFUkCklfc7NdoTGz7D0HtuQ+KTPMG3AgXgRd56+Ua+w9nUpoot9+p3RaX8u+GECf6zWX1j6YoznJ5pkiHdZ3ey2RMC/Q3MfAwhknB4wa9+CvgsmFeuhpzAnR+fTSPe2lbpNtkkUXQkNjqg3pBuEC/wJmQpL23kRpgmxiKdjPP90RYr0pcOrCW9H6/NnKW+YBPom50zuHZRLAMei2pbDh1cd3nHS80tnF22F4RwVygi3yI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nan/JIyQabBHaaTwp0mol9AnUg6HS0sodsuylKDqETFEVpzmX6AfHMsPRL/3?=
 =?us-ascii?Q?/cgDypkzxKxPYcw40uuAvJNXJjtzgDKsIosHwgWCgyejacQfuRe4Af+GQQfn?=
 =?us-ascii?Q?0Xti9mdB0nxE6RUz0xn+evsb8VkZK8XLz/b5ioVi7DZIrWw+TjqDBXkWyYsP?=
 =?us-ascii?Q?2A1V3G8spiV+hD5YIlHdmCFSZ9rzzo1mOZW8jSRftcLCPv1YjxmjZ8E9pZo7?=
 =?us-ascii?Q?6IUZemOTXvWgpbmdFFOGbZnwFETMdIQlAz0pprxuYFaIOATGQCDUcuXhnq6S?=
 =?us-ascii?Q?7gQ857xINBXE5uBB52upvV0Apdd7RUz0chSQ5YEu4jX5WIq9D3K9Nl0/8Rwt?=
 =?us-ascii?Q?k+tCBoiZn/oerP2/q0OVURs6TYvOneRtgFoS8vDQEAgEPSFUePYKL+GfTdZ6?=
 =?us-ascii?Q?dT5XoJuagZQq0/tl99gnb8E9iIM7dwU+KcDvbFdGX1khwSl/wWH/m8K8tobt?=
 =?us-ascii?Q?YKmikazVbpzWNKA7F5n3TS2p2nHTaKYy839W5uu6QnQF6B6xWH7iB9IVVn9s?=
 =?us-ascii?Q?EDYHZE7Scj9xSROaFjJrzDP4c6OYiVkdNItDK+dZdc5ZU06SItWUYfMvFQLG?=
 =?us-ascii?Q?eD/3h37UzMdUAlNkwKmJX4U+1+N1oO7WNFmh9JT2EFAun1/prQ739YOVzW1n?=
 =?us-ascii?Q?pheCNqlWi0RyrvFJwDHhTACt1HpYAvLaJ+F8xMpp/rwGW4ReEd0fZdbwqLdr?=
 =?us-ascii?Q?98/VXrSjQ/lbk37IzG09dM40ansXPQoyek22MomTUJiKkrXcNd5P53ShGXt8?=
 =?us-ascii?Q?2+1+3wbUDTYQTxkuBkQmgqbHE1oN2dU7JWF8eKUEnyg8T+cDxIr+BkBXsKfv?=
 =?us-ascii?Q?AZqemeM/OGsLYsOHTb09/Yv3qqQK8E11MorDWlg4QXz//AuTilkSrGeArJQn?=
 =?us-ascii?Q?LVfHMUjj9dJl4ci2dsMZsVABVV7EpO4HnpG8SdcjR5E4NStZwt02uUcE/XRS?=
 =?us-ascii?Q?Lv4B5PNQ+I8juAmDvlPe9obL2ThNFzODlcK4q9rtENiqSjC8NFAz8kdVEwe9?=
 =?us-ascii?Q?tBn9xzKGMh53A2vQ4Oia2WQT7E3B6x0PWzdQb1GiqErpDfVzmzLoueAD+2Pr?=
 =?us-ascii?Q?pPqBSpmNbXiUb/aiwFiVYkrK6I4g2wmWC8U/Gal5dgnF0arJHSffBg3RpIRB?=
 =?us-ascii?Q?8mZCqtAyL0fAY+xfqgLcYbj2l3ePWqv0obtO/QiZvWtBO4/HOyCIxa1QF9JR?=
 =?us-ascii?Q?OpF4AYlkTXxrhAzvdc2Gmusd3wP/OicEwtP+eK+IWx5ZFlHJBm6EG3Jl79tm?=
 =?us-ascii?Q?L/TkdENxI5MTDOdbTu3RDCBFwl/DrrXBFaibXE5iQ7L0WwtpzyJQIlcOI65j?=
 =?us-ascii?Q?dOIuH9Tq25RoEFY2vyv9wexwtNywVBPSmZzMj7QnAdaeNgJI5Yk1NfdbTdhh?=
 =?us-ascii?Q?YgThLG7uahxWDE7CGjfsfO4hGB/1EMcopWqQJ58uMc4Nq7WTcszzSmlZV0WP?=
 =?us-ascii?Q?p1rzFkbnzdCjg9iEs556wj3IosY+dz8MxJX5CcLSTEMJnZVfAuNKkVRgCMgr?=
 =?us-ascii?Q?UUFcRWsr/TX2EF4QBpZ36A3p5Iun4oKhezcSQW2eSMF5t9NUyvi1psLpxKLf?=
 =?us-ascii?Q?dF0ggiBm25LFTkMjDIo7fCnsVEnaYvEIKYHvZ8DE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aecf057-2618-43da-3d15-08dc43ea78ae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 05:49:10.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19XfhQ6SRllHtkAu/WPApmvo9WTqA0DF6ssOqk/V/8IzECY/FfIx0XXE5tUHWJmAlGpqYalToVVYe9RiG6YKIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672

Hello Perry,

On Wed, Mar 13, 2024 at 05:59:13PM +0800, Perry Yuan wrote:
> Address an untested error where the nominal_freq was returned in KHz
> instead of the correct MHz units, this oversight led to a wrong
> nominal_freq set and resued, it will cause the max frequency of core to
> be initialized with a wrong frequency value.

As I had mentioned in my review comment to v6 [1], cpudata->max_freq,
cpudata->min_freq, cpudata->lowest_non_linear_freq are all in
khz. With this patch, cpudata->nominal_freq will be in mhz.

As Dhananjay confirmed [2], this patch breaks the reporting in
/sys/devices/system/cpu/cpufreq/policyX/*_freq as some of them will be
reported in mhz while some others in khz which breaks the expectation
that all these sysfs values should be reported in khz.

[cpufreq]# grep . *freq
amd_pstate_lowest_nonlinear_freq:1804000   <----- in khz
amd_pstate_max_freq:3514000                <----- in khz
cpuinfo_max_freq:2151                      <----- in mhz                 
cpuinfo_min_freq:400000                    <----- in khz
scaling_cur_freq:2151                      <----- in mhz
scaling_max_freq:2151                      <----- in mhz
scaling_min_freq:2151                      <----- in mhz
[cpufreq]# pwd        
/sys/devices/system/cpu/cpu0/cpufreq

What am I missing ?

[1] https://lore.kernel.org/lkml/ZcRvoYZKdUEjBUHp@BLR-5CG11610CF.amd.com/)
[2] https://lore.kernel.org/lkml/1aecf2fc-2ea4-46ec-aaf2-0dbbb11b5f8b@amd.com/

>
> Cc: stable@vger.kernel.org
> Fixes: ec437d71db7 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

--
Thanks and Regards
gautham.


> ---
>  drivers/cpufreq/amd-pstate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2015c9fcc3c9..3faa895b77b7 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -647,8 +647,7 @@ static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
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

