Return-Path: <linux-kernel+bounces-34722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ACD8386BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A801F2481C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391DD4417;
	Tue, 23 Jan 2024 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XmsY9em8"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E441123D2;
	Tue, 23 Jan 2024 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705987855; cv=none; b=d9mx5DSWZllNUU5IbcCvTsiOg65rNWk7ryQssM/FBO4HrPAa6ugOmIvy9JK6kIJM3U80nNVdHdAP1qvpfhNRm+mRiCikKJ+dV3sgFYCj0x9mqgaHmX//OBZO8hI9Mtyy42cOTJlrhQ3sgIieFHHuer0o6h0atjQRJY+YovCNQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705987855; c=relaxed/simple;
	bh=JchXkml1pvgnzKfjVxkD4WAT9NFX+0B5qrQETYJtzuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sBzQAjV/x8RwRgSFcTAeHhdcPFaSgZSI7U1i7aztq4+ET7W9W8hgC6M09Hf1792/gg/JaXwNAGbNFx9F0GMW1uT0bcyPIoYUHRKKcllgu+D4IVRdmc+Ra/j1DuOE3ccbNugj94Itvp5H0TZx4I7HlDscKSbUzf8PQLRoxquEK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XmsY9em8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N4CQg8012977;
	Tue, 23 Jan 2024 05:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=c3fY0fdNOtVS3dg71XW9+tcghfHsu7IinDH2uN6dRYI=;
 b=XmsY9em8T1q335xq4B56u4f7ImfheH7WTKLFFHqxU+97e9+9D0dlyNapAR48iDTOdmy6
 TQfMagMzdEQy1JQBdHWR3IlxzAMXiJdnQSOTnt9kDO7MNIRTmeEM3BNNK6SPFY5ZfVAx
 6MdB9KWCebQ0tdbI83EiVIJOQvv+eDSpV+fY8Dop8cFrJpgBUidfm0oE5YKOp2mNgsIV
 KwzaVgGOKu/BqJwA2eg7NvK+wnHdBfxJCPvH4vK0GhTgo8iwU5vXI0J12SnYbLjRvqGk
 neOS3EfqjANd8K7jr7e0uzNDjgDbTsBVEfmoq+f6aBGNq/sfRykCUGxYLAclesoQYNwx 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vt5bnjb8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 05:30:29 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40N5USi9011993;
	Tue, 23 Jan 2024 05:30:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vt5bnjb85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 05:30:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40N5JqHo010841;
	Tue, 23 Jan 2024 05:30:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrrvynbgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 05:30:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40N5UPYh14746114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 05:30:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CDC720049;
	Tue, 23 Jan 2024 05:30:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0979B20040;
	Tue, 23 Jan 2024 05:30:21 +0000 (GMT)
Received: from [9.171.39.89] (unknown [9.171.39.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jan 2024 05:30:20 +0000 (GMT)
Message-ID: <6ace2f9f-b073-e22b-0dd6-69c52814d49a@linux.ibm.com>
Date: Tue, 23 Jan 2024 11:00:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3 0/7] Clean up perf mem
To: "Liang, Kan" <kan.liang@linux.intel.com>, acme@kernel.org,
        irogers@google.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
 <a0abfee5-4dcd-3eb5-82fe-1a0dcdade038@linux.ibm.com>
 <befb6acd-86be-4255-af96-38865affc56c@linux.intel.com>
 <8bfadc86-e137-4a9f-a9ce-0bc62464c195@linux.intel.com>
 <057a1c19-3117-1aec-41d6-4950c599b862@linux.ibm.com>
 <692e16f9-062c-4b3c-bd66-a16bac68216c@linux.intel.com>
 <cd7dc93f-ade9-6403-a732-2daca8e6cff9@linux.ibm.com>
 <a0540796-1933-4057-8282-aa219ddda4fe@linux.intel.com>
Content-Language: en-US
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <a0540796-1933-4057-8282-aa219ddda4fe@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qRDAdeiGpe7JYugVvI7p3djwvBYyEjfA
X-Proofpoint-GUID: o9agsxK2HZei6elcqPqL8Jq2C1rlcthN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1011 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230037



On 1/16/24 22:07, Liang, Kan wrote:
> 
> 
> On 2024-01-16 9:05 a.m., kajoljain wrote:
>>> For powerpc, the patch 3 introduced a perf_mem_events_power, which
>>> doesn't have ldlat. But it only be assigned to the pmu->is_core. I'm not
>>> sure if it's the problem.
>> Hi Kan,
>>  Correct there were some small issues with patch 3, I added fix for that.
>>
> 
> Thanks Kajol Jain! I will fold your fix into V4.
> 
>>> Also, S390 still uses the default perf_mem_events, which includes ldlat.
>>> I'm not sure if S390 supports the ldlat.
>> I checked it, I didn't find ldlat parameter defined in arch/s390
>> directory. I think its better to make default ldlat value as false
>> in tools/perf/util/mem-events.c file.
> 
> The s390 may not be the only user for the default perf_mem_events[] in
> the tools/perf/util/mem-events.c. We probably cannot change the default
> value.
> We may share the perf_mem_events_power[] between powerpc and s390. (We
> did the similar share for arm and arm64.)
> 
> How about the below patch (not tested.)
> 
> diff --git a/tools/perf/arch/s390/util/pmu.c
> b/tools/perf/arch/s390/util/pmu.c
> index 225d7dc2379c..411034c984bb 100644
> --- a/tools/perf/arch/s390/util/pmu.c
> +++ b/tools/perf/arch/s390/util/pmu.c
> @@ -8,6 +8,7 @@
>  #include <string.h>
> 
>  #include "../../../util/pmu.h"
> +#include "../../powerpc/util/mem-events.h"
> 
>  #define        S390_PMUPAI_CRYPTO      "pai_crypto"
>  #define        S390_PMUPAI_EXT         "pai_ext"
> @@ -21,5 +22,5 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>                 pmu->selectable = true;
> 
>         if (pmu->is_core)
> -               pmu->mem_events = perf_mem_events;
> +               pmu->mem_events = perf_mem_events_power;
>  }
> 
> 
> 
> However, the original s390 code doesn't include any s390 specific code
> for perf_mem. So I thought it uses the default perf_mem_events[].
> Is there something I missed?
> 
> Or does the s390 even support mem events? If not, I may remove the
> mem_events from s390.

Hi Kan,
   I don't have s390 system to do testing. But from my end I am fine
with the changes.

Thanks,
Kajol Jain

> 
> Thanks,
> Kan

