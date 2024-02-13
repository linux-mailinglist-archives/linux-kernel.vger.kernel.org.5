Return-Path: <linux-kernel+bounces-63129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDE8852B48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0684C282D49
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A37218AEA;
	Tue, 13 Feb 2024 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EVoz4Dn5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DB114271;
	Tue, 13 Feb 2024 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813357; cv=none; b=jZJE6NzLIRhENVEvDbakDfJLThUEbNLrwpH9vKfXENtYugLiuXutPQ1Oc9WeamVAdZAf3rwtBKih/0iYM1Ae/nTSqTY+OcxWl/YiqTAsVMxBLI+6lxJuCwZ1hBl504wWuLu06RguMu9C24TZnLiTvSZGYSRQqUurAEddE4TN6rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813357; c=relaxed/simple;
	bh=3hSD/Ts4z8au2F6bCOeibfMwFtuh88HvEP7ks4mhQB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LHKykn/SaDPKy+wgQcaMNQ2QXd0CVvPA3SNBx3so8VpTW15w3+CzJI/cEnGDEaHtwGoIH19h6R1zE3H4IWjohulg1Te0L14WxbFdPke3VYszPuTVn6P3kDm7yYFarhsstaUx/jSkfhGDouwWw+6o55uwjrh53VegP5Yqyixufq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EVoz4Dn5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D5Bt0w018721;
	Tue, 13 Feb 2024 08:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5VlOp9s6RWEnlxHGCNNtLxbUChTO7sBk0SVwHCFI4Yc=; b=EV
	oz4Dn5XvoFZpaXNtrGusPvh06dPsJU5wGPfPlGNgNceq5D+ac2oVNdIyRT3OlpNs
	e5j2MGqq/+ijWSm2fwiMvqGgD0DCoawTCvPDSmmkCG0HndafLkWL+lwI8+Fo82+s
	dT781rAAf883omT9xRuM0F3l3MzavpHXfPgRMezICSY1WnThjYZvCeXYBCrBAXOa
	0y7E6vGpMZvffIzrAK0rxw8L0q2DJlbekU1dxROg43mpccBzDJ+Rnao8pdjjcqrK
	Loj/LbzZ+Z2eRXRUVLxMyqFQ0dLk3Lt9xpPk3Uv8XAYGNOF1TK91JLcKlI//pPqr
	MG8FhFXa7xxkiKnaghsg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7q2y1jhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:35:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D8ZiZ4009545
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:35:44 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 00:35:40 -0800
Message-ID: <01b3d0ed-3fd3-86c6-7b0f-48d34a5d9ba8@quicinc.com>
Date: Tue, 13 Feb 2024 14:05:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] cpufreq: scmi: Add boost frequency support
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sudeep Holla
	<sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <morten.rasmussen@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240123060827.a3vszziftj6pszt3@vireshk-i7> <Za-RtBrSxI-j4Jdx@bogus>
 <e968092a-dc2b-4351-9489-acf874bbc7b6@arm.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <e968092a-dc2b-4351-9489-acf874bbc7b6@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A9k6MrupdilpPwfFiwx62WxJAfh9gT_v
X-Proofpoint-ORIG-GUID: A9k6MrupdilpPwfFiwx62WxJAfh9gT_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130066



On 1/31/24 20:37, Dietmar Eggemann wrote:
> On 23/01/2024 11:15, Sudeep Holla wrote:
>> On Tue, Jan 23, 2024 at 11:38:27AM +0530, Viresh Kumar wrote:
>>> On 17-01-24, 16:34, Sibi Sankar wrote:
>>>> This series adds provision to mark dynamic opps as boost capable and adds
>>>> boost frequency support to the scmi cpufreq driver.
>>>>
>>>> Depends on:
>>>> HW pressure v4: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240109164655.626085-1-vincent.guittot@linaro.org/
>>>> scmi notification v2: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240117104116.2055349-1-quic_sibis@quicinc.com/
>>>>
>>>> Sibi Sankar (3):
>>>>    OPP: Extend dev_pm_opp_data with turbo support
>>>>    firmware: arm_scmi: Add support for marking certain frequencies as
>>>>      boost
>>>>    cpufreq: scmi: Enable boost support
>>>
>>> Sudeep, please lemme know if you are okay with the changes. Will apply
>>> them.
>>
>> I was planning to look at it once Lukasz/Dietmar confirm that this concept
>> doesn't change anything fundamental in the way EAS related changes work
>> today. I know I suggested the change as that seem to be right way to do
>> but I haven't analysed if this has any negative impact on the existing
>> features as this change will impact all the existing platform with OPPs
>> above sustained performance/frequency advertised from the SCMI platform
>> firmware.
> 
> I was mostly concerned about the settings for the CPU frequency
> invariance implementation in [drivers/base/arch_topology.c]:
> 
> #define arch_scale_freq_capacity topology_get_freq_scale
> 
> But per_cpu(capacity_freq_ref, cpu) is still set to
> 'policy->cpuinfo.max_freq' in init_cpu_capacity_callback()
> which stays the same.
> 
> With some extra debugging I get the following on Juno-r0 [L b b L L L]:
> 
> root@juno:~# dmesg -w | grep -i "freq\|boost\|noti\|OPP\|cap"
> 
> [    1.768414] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
> [    1.793084] [1][LITTLE_CPU]:: Registered OPP[0] 450000000
> [    1.798624] [1][LITTLE_CPU]:: Registered OPP[1] 575000000
> [    1.804131] [1][LITTLE_CPU]:: Registered OPP[2] 700000000
> [    1.809552] scmi_dvfs_device_opps_add() sustained_freq=700000000 freq=775000000
> [    1.816971] [1][LITTLE_CPU]:: Registered OPP[3] 775000000
> [    1.822392] scmi_dvfs_device_opps_add() sustained_freq=700000000 freq=850000000
> [    1.829800] [1][LITTLE_CPU]:: Registered OPP[4] 850000000
> [    1.835268] enabled boost: 0
> [    1.838173] init_cpu_capacity_callback() cpu=0 max_freq=850000
> [    1.844032] init_cpu_capacity_callback() cpu=3 max_freq=850000
> [    1.849886] init_cpu_capacity_callback() cpu=4 max_freq=850000
> [    1.855743] init_cpu_capacity_callback() cpu=5 max_freq=850000
> [    1.866324] cpufreq_update_pressure() cpu=0 cpufreq_pressure=0
> [    1.872178] cpufreq_update_pressure() cpu=3 cpufreq_pressure=0
> [    1.878026] cpufreq_update_pressure() cpu=4 cpufreq_pressure=0
> [    1.883874] cpufreq_update_pressure() cpu=5 cpufreq_pressure=0
> [    1.890633] [0][BIG_CPU]:: Registered OPP[0] 450000000
> [    1.895892] [0][BIG_CPU]:: Registered OPP[1] 625000000
> [    1.901129] [0][BIG_CPU]:: Registered OPP[2] 800000000
> [    1.906286] scmi_dvfs_device_opps_add() sustained_freq=800000000 freq=950000000
> [    1.906381] [0][BIG_CPU]:: Registered OPP[3] 950000000
> [    1.917377] scmi_dvfs_device_opps_add() sustained_freq=800000000 freq=1100000000
> [    1.917468] [0][BIG_CPU]:: Registered OPP[4] 1100000000
> [    1.939237] enabled boost: 0
> [    1.942134] init_cpu_capacity_callback() cpu=1 max_freq=1100000
> [    1.948078] init_cpu_capacity_callback() cpu=2 max_freq=1100000
> [    1.959003] cpufreq_update_pressure() cpu=1 cpufreq_pressure=0
> [    1.964853] cpufreq_update_pressure() cpu=2 cpufreq_pressure=0
> 
> root@juno:/sys/devices/system/cpu/cpufreq# cat boost policy*/boost
> 1
> 0
> 0
> 
> root@juno:/sys/devices/system/cpu/cpufreq# cat policy*/scaling_available_frequencies policy*/scaling_boost_frequencies
> 450000 575000 700000
> 450000 625000 800000
> 775000 850000
> 950000 1100000
> 
> If I disable system-wide boost I see the correct influence on
> 'cpufreq_pressure':
> 
> root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > boost
> 
> [  439.466682] cpufreq_update_pressure() cpu=1 cpufreq_pressure=280
> [  439.472797] cpufreq_update_pressure() cpu=2 cpufreq_pressure=280
> [  439.478889] cpufreq_update_pressure() cpu=0 cpufreq_pressure=79
> [  439.484852] cpufreq_update_pressure() cpu=3 cpufreq_pressure=79
> [  439.490843] cpufreq_update_pressure() cpu=4 cpufreq_pressure=79
> [  439.499621] cpufreq_update_pressure() cpu=5 cpufreq_pressure=79
> 
> reflecting the max frequency change from '1100000 to 800000' on CPU1,2
> and from '850000 to 700000' on CPU0,3-5.
> 
> root@juno:/sys/devices/system/cpu/cpufreq# echo 1 > boost
> 
> [ 2722.693113] cpufreq_update_pressure() cpu=1 cpufreq_pressure=0
> [ 2722.699041] cpufreq_update_pressure() cpu=2 cpufreq_pressure=0
> [ 2722.704962] cpufreq_update_pressure() cpu=0 cpufreq_pressure=0
> [ 2722.710842] cpufreq_update_pressure() cpu=3 cpufreq_pressure=0
> [ 2722.719644] cpufreq_update_pressure() cpu=4 cpufreq_pressure=0
> [ 2722.728224] cpufreq_update_pressure() cpu=5 cpufreq_pressure=0
> 
> What doesn't work for me is to disable boost per policy:
> 
> root@juno:/sys/devices/system/cpu/cpufreq# echo 1 > boost
> root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > policy0/boost
> root@juno:/sys/devices/system/cpu/cpufreq# echo 0 > policy1/boost
> 
> Here I don't see 'cpufreq_pressure' changes.
> 
> BTW, what's the use case you have in mind for this feature? Is it to cap
> high OPPs for CPUs in a certain CPUfreq policy?

Yeah, that's exactly the use case for X1E. Boost frequencies defined in
the SoC are achievable by only one CPU in a cluster i.e. either the
other CPUs in the same cluster should be in low power mode or offline.
So it's mostly for book keeping i.e. we wouldn't to intimate incorrectly
that the CPUs are running at max possible frequency when it's actually
running at a lower frequency.

-Sibi

> 
> 

