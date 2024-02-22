Return-Path: <linux-kernel+bounces-75949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB5F85F10C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70F01F22838
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84E10A12;
	Thu, 22 Feb 2024 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EpdSbFdc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE3B79D0;
	Thu, 22 Feb 2024 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580653; cv=none; b=rhHaBHG4TQzsgwosh5NkfT0U8j9bDrZRHD4AbKt8YUpXzc+xItYYPU4G7cUQzAeqda3a2KVpcdYV68NZYqOyUJ7PP0NLLUf0BeVk/T/2claI4306X82d9DRrZjSOhHOXxfxexxCQpKLVzlQ4HNMRjyUw4/vR8bfdEnJyOPa91vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580653; c=relaxed/simple;
	bh=fNkY2cGJB7TOrIUY+d6j/l7H2SX/i58LD0oTMcpbeLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EtDRxd5abONY8yjvSJr7u2JrQqWd6rfUq2gT9gu5Sy8An1Hj4irpa2988CacQ9C5iHlJBtdCuX70atNXjDO/+jAl5mU++lGBs7OA/E7VDnfqfA6CZthFOZ3jSmuMs7C39iTRfcPkq1krFVQ4qwrRAP6qn3wx8DHY7ck72U4ueJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EpdSbFdc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M3uHrm025369;
	Thu, 22 Feb 2024 05:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oCC3QGnbRxCLzx4KRoEqeteCKzjPTUEElYcaAwDBXsA=; b=Ep
	dSbFdcHg36DzMP+JDwlh8qUWQsDI5VNBZ77uN0CcNosWOQiqoPVRIwaRo04yegZa
	s6SXEz3LzZSmD1m4zEucXUXc1VmPodUKofzy9JNs4r2+iBJF1VH2i7lIeox9ndHm
	B4mphwC+1WHT8KzJ12+JBi25nXePzQ7szJ61v9/2nd2+r4IFs+opa3wY1L6S+CkZ
	f9MpsVg/s0srg209fAAEbSsZBayBSG+jRztc4EwDydf78ThCRadzqqAU3cc4jQaS
	P6D2CS6bc4kv2G9dZLR+73nuwlm4EL0Q6nPx2vh9DBLaIx+OktUVECG4k6pa/W7D
	1R5te5KbHh9CyynxSvPw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdpjn95rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 05:43:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M5hqFj004786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 05:43:52 GMT
Received: from [10.214.82.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 21:43:48 -0800
Message-ID: <fe4ec29f-7521-4369-a382-bae50dbf0ee5@quicinc.com>
Date: Thu, 22 Feb 2024 11:13:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Introduction of a remoteproc tee to load signed
 firmware
Content-Language: en-US
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens
 Wiklander <jens.wiklander@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>
References: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
From: Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -lkiXDkqUkLoLXNDx0na_5iwoAA8Refh
X-Proofpoint-GUID: -lkiXDkqUkLoLXNDx0na_5iwoAA8Refh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_03,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220042

On 2/14/2024 10:51 PM, Arnaud Pouliquen wrote:
> Updates from the previous version [1]:
> 
> This version proposes another approach based on an alternate load and boot
> of the coprocessor. Therefore, the constraint introduced by tee_remoteproc
> is that the firmware has to be authenticated and loaded before the resource
> table can be obtained.
> 
> The existing boot sequence is: >
>    1) Get the resource table and store it in a cache,
>       calling rproc->ops->parse_fw().
>    2) Parse the resource table and handle resources,
>       calling rproc_handle_resources.
>    3) Load the firmware, calling rproc->ops->load().
>    4) Start the firmware, calling rproc->ops->start().
>   
> => Steps 1 and 2 are executed in rproc_fw_boot(), while steps 3 and 4 are
>     executed in rproc_start().
> => the use of rproc->ops->load() ops is mandatory
> 
> The boot sequence needed for TEE boot is:
> 
>    1) Load the firmware.
>    2) Get the loaded resource, no cache.
>    3) Parse the resource table and handle resources.
>    4) Start the firmware.

Hi,
What problem are we really addressing here by reordering load, parse of
FW resources?
Basically, what are the limitations of the current design you are 
referring to?
I understood that TEE is designed that way.

> 
> Then the crash recovery also has to be managed.For recovery, the cache is
> used to temporarily save the resource table and then reapply it on
> restart:
>    1) Stop the remote processor, calling rproc->ops->stop().
>    2) Load the firmware, calling rproc->ops->load().
>    3) Copy cached resource table.
>    4) Start the remote processor, calling rproc->ops->start().
> 
> => This sequence is also needed when TEE manages the boot of the remote
>     processor.
> => The rproc->ops->load() is also used in recovery sequence.
> 
> Based on the sequences described above, the proposal is to:
> 
> - Rework tee_rproc API to better match the rproc_ops structure.
>    This allows to simply map the function to implement the load ops, which
>    is not optional. The tee_rproc_load_fw() is updated in consequence.
> - Remove the call of rproc_load_segments from rproc_start() to dissociate
>    the load and the start. This is necessary to implement the boot sequence
>    requested for the TEE remote proc support.
> - Introduce an rproc_alt_fw_boot() function that is an alternative boot
>    sequence, which implements the sequence requested for the TEE remoteproc
>    support.
> 
> 
> [1] https://lore.kernel.org/lkml/20240118100433.3984196-1-arnaud.pouliquen@foss.st.com/T/
> 
> 
> Description of the feature:
> 
> This series proposes the implementation of a remoteproc tee driver to
> communicate with a TEE trusted application responsible for authenticating and
> loading the remoteproc firmware image in an Arm secure context.
> 
> 1) Principle:
> 
> The remoteproc tee driver provides services to communicate with the OP-TEE
> trusted application running on the Trusted Execution Context (TEE).

s/Context/Environment?

> The trusted application in TEE manages the remote processor lifecycle:
> 
> - authenticating and loading firmware images,
> - isolating and securing the remote processor memories,
> - supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
> - managing the start and stop of the firmware by the TEE.
> 

Regards,
Naman Jain


