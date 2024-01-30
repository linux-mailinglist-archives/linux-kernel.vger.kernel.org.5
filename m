Return-Path: <linux-kernel+bounces-45241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5029842D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7672892EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4071B41;
	Tue, 30 Jan 2024 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VurZm3rJ"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACBB6995A;
	Tue, 30 Jan 2024 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645089; cv=fail; b=eCngJLkTpSfn03u9bk8qlC/MEG2ADjVkqnvb+MAz6omFgpOey/ra14+SPOGauvU2PStcCFFELtEnIRX2ubuIqaC6FUgzxDFSXAZEzIfc6RlAqZ7+h7URlq20zvGfO408mTzDiciFTNQlMkU8Utzlr9b143PoDG/H7SpPS2sPGKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645089; c=relaxed/simple;
	bh=dcVEaHeXJYgk4ME/VoRGOdudh3CPxf++HV2MtnjuolI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RwGwdetvNIp1hNApgTl+Enfxgd+NNLDPB3b4rHYfnJ996u2wE/ur1T2JOsLU1TS4wt37tHOLVBC+qo9L2iPAvNt57VdkwdfGvG733AUb8d3duKDNfg83WtyBJkJDEgfmplWpHnF4pQrgSHc69wSmCmeOnwx1XEW4bRven8cWCYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VurZm3rJ; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJedgJNBdH09/4b2I6K6DeA+YBMELMsu4eZtuPFAyaeuJKfikH+uG1VUmueM1yRoy47eWEBSqBVcF+J+JrZGd8KIR0K/fCwk4KEK9/5ydqZaVT3GUaMFdbsgKmnyd+i14B2p1IemWn1N++NUccrNWuQP7seoiNGTgKlW3MATVs04AhZ62h+rU69pa1UokRN+Xj+jTESCmHwZiUkoq4X2uxecn3NkOuljWC3ymDV9j46fgMEo14kpysUH8oB2OpeXlJSRAJUhE2GKwrhaDd4RpoHmFroHmlRz2Tcn6Zp3Ff4p8boLhDLwF7GOeVorshloQ7+rUAwa5tJf/LbZC8nKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sfxPphe3EW7NIi+MYSIJCRUuC6bcKvca6gmM0lMw0w=;
 b=kC/fdxHpqUNf0PbrHIOpua0MeS0H8fRAzN40wV5eTHKM+O5jnMDA+/Kk1cYFbnoz17lF4CF6ZpMgVKKYIWNZKyijHNu9kr9J/qVaD1UqnvS0gTmy67FtNuGEdWNtYUma9nhZLmGaWazop9l6OwpP8tPRSIrIt1wOlIpxV6SOumfoQ+cYcrtTkikUpYkfJyyVz5f2hh0UksW+bHhetmVgD7M8hf5nrwutYYwdp4Sx0ana5eo94TVlEpI66WKFBI/FoYDAfh2Anjqrn825lYozQD+4zVXTN89pzLLKPtBgafNyDMNs8SHHVcThd5j3CXoB1YeLEcbQxVWBpzN7v+RJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sfxPphe3EW7NIi+MYSIJCRUuC6bcKvca6gmM0lMw0w=;
 b=VurZm3rJerDNuQQIkxjhBv7wAEqO3m2ktKJ8FzzrCnEh94YGH8XgNMcCHuEivrcPel1VDIp9MnqhAXUbMVP3Jtm1Yu+s1dY8QlJBuVnXwaqNUB7qS303RL58xlSS0Rbu/5Qo5e4CnI/0OjJD0PSmvjLZNQqh62yzaRHe5I+J04I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 20:04:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 20:04:43 +0000
Message-ID: <4998c0ea-bc06-4550-9309-a7517f2d8f31@amd.com>
Date: Tue, 30 Jan 2024 14:04:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Resend 1/8] tools/power x86_energy_perf_policy: add info
 show support for AMD Pstate EPP driver
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 Borislav.Petkov@amd.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706592301.git.perry.yuan@amd.com>
 <445ff0fcfa7b3c8f8e687819ebbd111e3c1c4b80.1706592301.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <445ff0fcfa7b3c8f8e687819ebbd111e3c1c4b80.1706592301.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:5:bc::47) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 212b0c67-32b7-4536-1177-08dc21ceb2ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PF39bosiC92ewSOl39Me2wT1EPgQ4bEVIdVcTG+D9b5+cGtsHmfjwRY6HP/5sIuthHD6mjnVq7XFvbBCRH7jakdvdKIfJCOXEwliHfMF8gaCAOIp1OvpE4VGglwMDgBiPGoFZ+dtXqBH5mV3YOoS6lvCRS/IiANHaaqJMf/d5kXgBileUdnh3r+RuQInf50UWD50Grc6YAaeST8U9B+6T0uxcByMGh/PEFKYVo9wI094++wYqVgrePienmArIZdx2TFWW8BU9gqyZ6AyyXoxCOqsCVEG26+vCvpgnu5ySYrGQI6Im+lmMYa5Tugk2J1SyUQJSac4WQBYWxak5PRwLR+Z5fQoZ9CpAcDZ6UYcezH8pHrWa3VFq/3sTBc3HRpDGa+TLirF9OCWAYc9hjR24HSK4eIvbLgj5cDYoY/G/9ZT1CZsd9OPITgp8TfpeUaWEmrO1QgK7cvQAx30y6AMDoSGfJTK3e0LyrtRgjHgbLVNuJ/VfX9FT+uxoWrEw9X+Q+zxoRac9xRvGNBY7dWTZ1WvDo3HtJMsixr85KeH1ln8vRH/SueyMqQS46ptvgH/JRGnXBLK4y/ZFb7JRFm2/+byGco3a5qmMHonM9s9PNj1yonO3YmsukdbPGOd8w6qc7nDzEOcRCLVWGfP49y7Yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6512007)(6506007)(53546011)(83380400001)(26005)(36756003)(31696002)(86362001)(41300700001)(5660300002)(8936002)(4326008)(44832011)(6666004)(66556008)(30864003)(66946007)(66476007)(8676002)(6486002)(478600001)(2616005)(38100700002)(316002)(6636002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGJHblYzQ2xRWGFOV2p3Mit5bVZOMW9idnFlUGlNY2hqSXZHT0V3WkdJQzdE?=
 =?utf-8?B?ZmNkdXpZeG1JQ1lUclRReXlySW45ZFo4dXdKb3d2QzVQR2NIQm4vekYwaGdY?=
 =?utf-8?B?ZmZPZG9kS0V4VXZWNkU4MGVtVTk5WHphQUM4clB2OCtKNnFTdmg4QWpTaEFr?=
 =?utf-8?B?MjRFb1NrWG1LUHNVK0xleWh0cURyL3ppWTJuUk5EQ0lKczRkRmRoVFg5djZw?=
 =?utf-8?B?K2U0UXk1QWhKS042aCs3S3hoWVh4MjFZMzZWaGRDY1pManhrM25YMGxNUXdV?=
 =?utf-8?B?S0lVSTZMZ1hSOUdOc1plRlhRT0ZocUxVMUI4VmtDUi9VRE5IcjVTaS90RlZS?=
 =?utf-8?B?K3pId0FWcHAxd3ZMSWd2K0g5LzVZNjdyOTZHVUMySlBPT0VzQ05iSE4vbUpz?=
 =?utf-8?B?bXF6QlRtbjdYVmYzVWd2MW8vRnJCdmdUa3RMRjdUVzJiQUlodEdvUHJyREpq?=
 =?utf-8?B?bFNNMWhPOXhpS28xU2drOFVreDhrSXFaMWJjZlJMcjh2dk5tK0FKU3dpaHg3?=
 =?utf-8?B?ZFE3OGdIMk5wVUhsalg4djBFbjBOKzdvRFNWRmxXWHZEakt1Q3NFWXpJQmZy?=
 =?utf-8?B?Q0JUR1pqaUh4akhBMDFlSXJtUXUrN3ZCRmIwcmxSeXQzekFMQWhkL1FmRDhZ?=
 =?utf-8?B?OVMrYWNVZmYwQmxqM2IxTjJuM2VkUDE3TFpHZE9Na0RQTmZVZWdJT1VJaURH?=
 =?utf-8?B?NzdwMVppVjlGVU9JUnBTYnhEcGZ6U0phY0tSak1td2lWOEJzVGR2RjNZaGd1?=
 =?utf-8?B?U2ZLaHVYY29oOTFTUVNaeE1uVm9LNmdSRTNnd1BLQzhpNU81MkNwK0YyR3po?=
 =?utf-8?B?MVFBZTkxaFIxcm5Ea0tERlYyMTZjamw3allaOWVLcG1wcjRJN3hzWitOQWJt?=
 =?utf-8?B?Tm1aVGJYcXArM21KNzhIMXpqQXI5TlhCTlY0SVZBd3dDT2pJcUQ3ZklzU1By?=
 =?utf-8?B?STlhMmdmcEhBejlrSWFyZ3pzeHFucjdwZjVrK0VUWHI0dWxWUURtNEI5LzYv?=
 =?utf-8?B?NXE1N01YMG9KTURHRlZvcmp3amVJaXJTc2dCbDBVVkVsdXlKRmlvY2FXamN6?=
 =?utf-8?B?SnpRZ3VjMGlqMTRQM3poOGljWHZseE1UUVJXYVFTd1FOOGNoNUJTZkpET1ow?=
 =?utf-8?B?MXpvUmN6ZVNmc3AxTnEvS1FINXpBN2tTSDIyRGlXTTdLRVFWT3VNeTluMTda?=
 =?utf-8?B?VDVGMWc3aUhMYm5CSlY0dXdmM28rWlVXZWtzaWx0QnFTRFBqcGo4ZDJYK1d2?=
 =?utf-8?B?REkvblhoS2hVUHFHTTJhOGRDczNZeGN0YnlnYTFRVk1STkxIUWsvYm9CMjZu?=
 =?utf-8?B?M0xROEI1M0cyTGJYU0VEaUxKUmZJOFVzeldBQVM0WE51emp2dldpUE00bjdH?=
 =?utf-8?B?Zy9mQlVZa2tZQnMvbjYxNDAyMVNkbFBMSFM1TCtZVllsQjFKN2tQOWlFMmhC?=
 =?utf-8?B?bG5YcXh3ckh4QisyZW5UckZML0ZqQ014bExhVDJ6bnBHcDkrcFJ1MjNDM3Uy?=
 =?utf-8?B?YUwzM0xOSXNNYlRxWGR2ZjdRcUJNTkhYQTJ5azRleisxV3FQamRDTHREckxV?=
 =?utf-8?B?NTBjNldZMkdhbE5neGU0QjVRY1NsVWI1NG4vaUFkbkhvck56S29vTVl2d0Jo?=
 =?utf-8?B?MWFDaFpBanFGYjdDbWlPRVkvM3Rwb1ZuVU10bGdjN3NlNSs4SjE2bytGN3Zn?=
 =?utf-8?B?T0VBZElTS2pGQ0tpT3FacnBtZWlMVTF6Z1RPZk54Z1hpanJlSjAvYkhTcVhE?=
 =?utf-8?B?Q0JyekROanQrOUZJaWR2TTBCUTVPSnhXdVRuZjJqV3hzL2k2ZThjNE13OEs0?=
 =?utf-8?B?NGVCbCtqRVdmenRxTlhhRVNGdmJTTHFQWVVib1hUVWxHc2sySEc1ZU1uYXdt?=
 =?utf-8?B?RkxuMU5mdndvT2N5ZnJvV1pxQlBaTUhUVTJ1V3RMUEhjalUzYUNSOVoydXNX?=
 =?utf-8?B?RFZPNVltaFJkQk1uZXhpMDRDSjhZYXo2b3ZkQlc1R3RXcVZpOGNrZkJVZlJX?=
 =?utf-8?B?QlpXYW1HNXRvZlJad3JGeVJPVmpPYkswNmlzMDhRL2FvL2RSMkhtNnVIeG53?=
 =?utf-8?B?eXRGRTkwdmFzQlErYmhKa2VLT0dUOEN5TjJIN3duYmhmb0c1RjRhZ0QwRHNU?=
 =?utf-8?Q?ArQuki4vmV3+K23vIuFpYV6Gy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212b0c67-32b7-4536-1177-08dc21ceb2ae
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 20:04:42.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vT1aG2C9xagPHcJI7nu2NhnIlqhNptEFJgSRZD7nY2EqWJClQ2GHGVuyyb0t+c+eHtX26Qzfd8l2AMPPnL8Nbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366

On 1/29/2024 23:56, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> With the amd pstate epp driver implemented, the x86_energy_perf_policy
> will need to implemented the utility support to display hardware energy
> and performance policy hint information on the AMD processors.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   .../x86_energy_perf_policy.c                  | 211 ++++++++++++++----
>   1 file changed, 167 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> index 5fd9e594079c..5daf1c2bb601 100644
> --- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> +++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> @@ -76,6 +76,8 @@ unsigned long long pkg_selected_set;
>   cpu_set_t *cpu_present_set;
>   cpu_set_t *cpu_selected_set;
>   int genuine_intel;
> +unsigned int authentic_amd;
> +unsigned int max_level;
>   
>   size_t cpu_setsize;
>   
> @@ -724,6 +726,53 @@ int put_msr(int cpu, int offset, unsigned long long new_msr)
>   	return 0;
>   }
>   
> +static int amd_put_msr(int cpu, off_t offset, unsigned long msr)
> +{
> +	ssize_t retval;
> +	int fd;
> +	char pathname[32];
> +
> +	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
> +	fd = open(pathname, O_RDWR);
> +	if (fd < 0) {
> +		err(-EACCES, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, or run as root", pathname);
> +		goto out;
> +	}
> +	retval = pwrite(fd, &msr, sizeof(msr), offset);
> +	if (retval != sizeof(msr))
> +		err(-EFAULT, "cpu%d: msr offset 0x%lx write failed ret = %ld fd = %d", cpu, (unsigned long)offset, retval, fd);
> +
> +	if (debug > 1)
> +		fprintf(stderr, "amd_put_msr(cpu%d, 0x%lx, 0x%lX)\n", cpu, offset, msr);
> +
> +	close(fd);
> +
> +out:
> +	return (retval == sizeof(msr)) ? 0 : -1;;
> +}
> +
> +
> +static int amd_get_msr(int cpu, off_t offset, unsigned long *msr)
> +{
> +	ssize_t retval;
> +	char pathname[32];
> +	int fd;
> +
> +	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
> +	fd = open(pathname, O_RDONLY);
> +	if (fd < 0) {
> +		err(-EACCES, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, or run as root", pathname);
> +		goto out;
> +	}
> +	retval = pread(fd, msr, sizeof(*msr), offset);
> +	if (retval != sizeof *msr)
> +		err(-EFAULT, "cpu%d: msr offset 0x%llx read failed", cpu, (unsigned long long)offset);
> +
> +	close(fd);
> +out:
> +	return (retval == sizeof *msr) ? 0 : -1;;
> +}
> +

I don't see a reason that the existing put_msr/get_msr can't be rsued on 
AMD side too.  Did I miss something?

>   static unsigned int read_sysfs(const char *path, char *buf, size_t buflen)
>   {
>   	ssize_t numread;
> @@ -777,13 +826,21 @@ void print_hwp_cap(int cpu, struct msr_hwp_cap *cap, char *str)
>   void read_hwp_cap(int cpu, struct msr_hwp_cap *cap, unsigned int msr_offset)
>   {
>   	unsigned long long msr;
> +	int ret;
>   
> -	get_msr(cpu, msr_offset, &msr);
> -
> -	cap->highest = msr_perf_2_ratio(HWP_HIGHEST_PERF(msr));
> -	cap->guaranteed = msr_perf_2_ratio(HWP_GUARANTEED_PERF(msr));
> -	cap->efficient = msr_perf_2_ratio(HWP_MOSTEFFICIENT_PERF(msr));
> -	cap->lowest = msr_perf_2_ratio(HWP_LOWEST_PERF(msr));
> +	if (genuine_intel) {
> +		get_msr(cpu, msr_offset, &msr);
> +		cap->highest = msr_perf_2_ratio(HWP_HIGHEST_PERF(msr));
> +		cap->guaranteed = msr_perf_2_ratio(HWP_GUARANTEED_PERF(msr));
> +		cap->efficient = msr_perf_2_ratio(HWP_MOSTEFFICIENT_PERF(msr));
> +		cap->lowest = msr_perf_2_ratio(HWP_LOWEST_PERF(msr));
> +	} else if (authentic_amd) {
> +		ret = amd_get_msr(cpu, msr_offset, (unsigned long *)(&msr));
> +		if (ret < 0)
> +			errx(-1, "failed to get msr with return %d", ret);
> +		cap->highest = msr_perf_2_ratio(AMD_CPPC_HIGHEST_PERF(msr));
> +		cap->lowest = msr_perf_2_ratio(AMD_CPPC_LOWEST_PERF(msr));
> +	}
>   }
>   
>   void print_hwp_request(int cpu, struct msr_hwp_request *h, char *str)
> @@ -812,15 +869,27 @@ void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, char *str)
>   void read_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr_offset)
>   {
>   	unsigned long long msr;
> +	int ret;
>   
> -	get_msr(cpu, msr_offset, &msr);
> -
> -	hwp_req->hwp_min = msr_perf_2_ratio((((msr) >> 0) & 0xff));
> -	hwp_req->hwp_max = msr_perf_2_ratio((((msr) >> 8) & 0xff));
> -	hwp_req->hwp_desired = msr_perf_2_ratio((((msr) >> 16) & 0xff));
> -	hwp_req->hwp_epp = (((msr) >> 24) & 0xff);
> -	hwp_req->hwp_window = (((msr) >> 32) & 0x3ff);
> -	hwp_req->hwp_use_pkg = (((msr) >> 42) & 0x1);
> +	if (genuine_intel) {
> +		get_msr(cpu, msr_offset, &msr);
> +
> +		hwp_req->hwp_min = msr_perf_2_ratio((((msr) >> 0) & 0xff));
> +		hwp_req->hwp_max = msr_perf_2_ratio((((msr) >> 8) & 0xff));
> +		hwp_req->hwp_desired = msr_perf_2_ratio((((msr) >> 16) & 0xff));
> +		hwp_req->hwp_epp = (((msr) >> 24) & 0xff);
> +		hwp_req->hwp_window = (((msr) >> 32) & 0x3ff);
> +		hwp_req->hwp_use_pkg = (((msr) >> 42) & 0x1);
> +	} else if (authentic_amd) {
> +		ret = amd_get_msr(cpu, msr_offset, (unsigned long *)(&msr));
> +		if (ret < 0)
> +			errx(-1, "failed to get msr with return %d", ret);
> +		hwp_req->hwp_min = msr_perf_2_ratio((((msr) >> 8) & 0xff));
> +		hwp_req->hwp_max = msr_perf_2_ratio((((msr) >> 0) & 0xff));
> +
> +		hwp_req->hwp_desired = msr_perf_2_ratio((((msr) >> 16) & 0xff));
> +		hwp_req->hwp_epp = (((msr) >> 24) & 0xff);
> +	}
>   }
>   
>   void write_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr_offset)
> @@ -895,18 +964,28 @@ int print_cpu_msrs(int cpu)
>   	struct msr_hwp_cap cap;
>   	int epb;
>   
> -	epb = get_epb(cpu);
> -	if (epb >= 0)
> -		printf("cpu%d: EPB %u\n", cpu, (unsigned int) epb);
> +	if (genuine_intel) {
> +		epb = get_epb(cpu);
> +		if (epb >= 0)
> +			printf("cpu%d: EPB %u\n", cpu, (unsigned int) epb);
> +	}
>   
>   	if (!has_hwp)
>   		return 0;
>   
> -	read_hwp_request(cpu, &req, MSR_HWP_REQUEST);
> -	print_hwp_request(cpu, &req, "");
> +	if (genuine_intel) {
> +		read_hwp_request(cpu, &req, MSR_HWP_REQUEST);
> +		print_hwp_request(cpu, &req, "");
>   
> -	read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
> -	print_hwp_cap(cpu, &cap, "");
> +		read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
> +		print_hwp_cap(cpu, &cap, "");
> +	} else if (authentic_amd) {
> +		read_hwp_request(cpu, &req, MSR_AMD_CPPC_REQ);//MSR_HWP_REQUEST
> +		print_hwp_request(cpu, &req, "");
> +
> +		read_hwp_cap(cpu, &cap, MSR_AMD_CPPC_CAP1);//MSR_HWP_CAPABILITIES
> +		print_hwp_cap(cpu, &cap, "");
> +	}
>   
>   	return 0;
>   }
> @@ -1330,12 +1409,19 @@ void init_data_structures(void)
>   void verify_hwp_is_enabled(void)
>   {
>   	unsigned long long msr;
> +	int ret;
>   
>   	if (!has_hwp)	/* set in early_cpuid() */
>   		return;
>   
>   	/* MSR_PM_ENABLE[1] == 1 if HWP is enabled and MSRs visible */
> -	get_msr(base_cpu, MSR_PM_ENABLE, &msr);
> +	if (genuine_intel)
> +		get_msr(base_cpu, MSR_PM_ENABLE, &msr);
> +	else if (authentic_amd) {
> +		ret = amd_get_msr(base_cpu, MSR_AMD_CPPC_ENABLE, (unsigned long *)(&msr));
> +		if (ret < 0)
> +			errx(-1, "failed to get msr with return %d", ret);
> +	}
>   	if ((msr & 1) == 0) {
>   		fprintf(stderr, "HWP can be enabled using '--hwp-enable'\n");
>   		has_hwp = 0;
> @@ -1398,6 +1484,17 @@ static void get_cpuid_or_exit(unsigned int leaf,
>   		errx(1, "Processor not supported\n");
>   }
>   
> +static void amd_get_cpuid_or_exit(unsigned int leaf,
> +			     unsigned int *eax, unsigned int *ebx,
> +			     unsigned int *ecx, unsigned int *edx)
> +{
> +	unsigned int leaf_index;
> +
> +	leaf_index =  leaf | 0x80000000;
> +	if (!__get_cpuid(leaf_index, eax, ebx, ecx, edx))
> +		errx(1, "Processor not supported\n");
> +}
> +
>   /*
>    * early_cpuid()
>    * initialize turbo_is_enabled, has_hwp, has_epb
> @@ -1408,24 +1505,39 @@ void early_cpuid(void)
>   	unsigned int eax, ebx, ecx, edx;
>   	unsigned int fms, family, model;
>   
> -	get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
> -	family = (fms >> 8) & 0xf;
> -	model = (fms >> 4) & 0xf;
> -	if (family == 6 || family == 0xf)
> -		model += ((fms >> 16) & 0xf) << 4;
> +	eax = ebx = ecx = edx = 0;
> +	__cpuid(0, max_level, ebx, ecx, edx);
> +	if (ebx == 0x756e6547 && ecx == 0x6c65746e && edx == 0x49656e69)
> +		genuine_intel = 1;
> +	else if (ebx == 0x68747541 && ecx == 0x444d4163 && edx == 0x69746e65)
> +		authentic_amd = 1;
>   
> -	if (model == 0x4F) {
> -		unsigned long long msr;
> +	if (genuine_intel) {
> +		get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
> +		family = (fms >> 8) & 0xf;
> +		model = (fms >> 4) & 0xf;
> +		if (family == 6 || family == 0xf)
> +			model += ((fms >> 16) & 0xf) << 4;
>   
> -		get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
> +		if (model == 0x4F) {
> +			unsigned long long msr;
>   
> -		bdx_highest_ratio = msr & 0xFF;
> -	}
> +			get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
> +
> +			bdx_highest_ratio = msr & 0xFF;
> +		}
>   
> -	get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
> -	turbo_is_enabled = (eax >> 1) & 1;
> -	has_hwp = (eax >> 7) & 1;
> -	has_epb = (ecx >> 3) & 1;
> +		get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
> +		turbo_is_enabled = (eax >> 1) & 1;
> +		has_hwp = (eax >> 7) & 1;
> +		has_epb = (ecx >> 3) & 1;
> +	} else if (authentic_amd) {
> +		/* AMD Processors CPUID info */
> +		amd_get_cpuid_or_exit(0x8, &eax, &ebx, &ecx, &edx);
> +		turbo_is_enabled = (eax >> 1) & 1;
> +		has_hwp = (ebx >> 27) & 1;
> +		has_hwp_epp = (ebx >> 27) & 1;
> +	}
>   }
>   
>   /*
> @@ -1444,6 +1556,8 @@ void parse_cpuid(void)
>   
>   	if (ebx == 0x756e6547 && edx == 0x49656e69 && ecx == 0x6c65746e)
>   		genuine_intel = 1;
> +	else if (ebx == 0x68747541 && ecx == 0x444d4163 && edx == 0x69746e65)
> +		authentic_amd = 1;
>   
>   	if (debug)
>   		fprintf(stderr, "CPUID(0): %.4s%.4s%.4s ",
> @@ -1456,6 +1570,11 @@ void parse_cpuid(void)
>   	if (family == 6 || family == 0xf)
>   		model += ((fms >> 16) & 0xf) << 4;
>   
> +	if (authentic_amd) {
> +		if (family == 0xf)
> +			family += (fms >> 20) & 0xff;
> +	}
> +
>   	if (debug) {
>   		fprintf(stderr, "%d CPUID levels; family:model:stepping 0x%x:%x:%x (%d:%d:%d)\n",
>   			max_level, family, model, stepping, family, model, stepping);
> @@ -1473,14 +1592,18 @@ void parse_cpuid(void)
>   	if (!(edx & (1 << 5)))
>   		errx(1, "CPUID: no MSR");
>   
> -
> -	get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
> -	/* turbo_is_enabled already set */
> -	/* has_hwp already set */
> -	has_hwp_notify = eax & (1 << 8);
> -	has_hwp_activity_window = eax & (1 << 9);
> -	has_hwp_epp = eax & (1 << 10);
> -	has_hwp_request_pkg = eax & (1 << 11);
> +	if (genuine_intel) {
> +		get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
> +		/* turbo_is_enabled already set */
> +		/* has_hwp already set */
> +		has_hwp_notify = eax & (1 << 8);
> +		has_hwp_activity_window = eax & (1 << 9);
> +		has_hwp_epp = eax & (1 << 10);
> +		has_hwp_request_pkg = eax & (1 << 11);
> +	} else if (authentic_amd) {
> +		amd_get_cpuid_or_exit(0x8, &eax, &ebx, &ecx, &edx);
> +		has_hwp_epp = (ebx >> 27) & 1;
> +	}
>   
>   	if (!has_hwp_request_pkg && update_hwp_use_pkg)
>   		errx(1, "--hwp-use-pkg is not available on this hardware");


