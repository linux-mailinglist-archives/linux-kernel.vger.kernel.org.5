Return-Path: <linux-kernel+bounces-45782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E323843630
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D77B25754
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3803D994;
	Wed, 31 Jan 2024 05:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AvKBCnHY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACECDF9FA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680044; cv=none; b=g5BAcjy/UqHvzh/vG5Kj3t+BDLilW6Ju3+Ir7EAXIj/s4U98oS9JaXK2ny7dEej1vjHiTjRG2t6o9oaiKRR40Eo9VOePLAMt4Rw8x6RrYKufZBNtu5e3clmgnAfW2yxVoah+1KQ2EnYg3wszwzpoeLi7vNLKov6eREDBUEOrgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680044; c=relaxed/simple;
	bh=cAMtA7F+b0u14xld0PJ45zy3KKRoP29cHeo3ob1zSZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kOvS9pvUkZiKI9cV6i2tBjDvnwZYCcQnqBIWwn9wxxB8ApCTcpGckyTZVt6yGO6WDvVdZaUui0PbIOnPdoQlIU3H/DcudIsNnZ42CjQjUYVn59cWHG3onQyoO+V8FVRKdLkq38da/+49hJBlqCHNAEJS5QDzvfSBCYSAFvY1Yu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AvKBCnHY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V4j1rx004745;
	Wed, 31 Jan 2024 05:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iH+66EVVnAKr8sJnfftBirH31lcIWWz93E7oMTVQpLw=; b=Av
	KBCnHYvjMieAFXnI4Fjmb0xCSY8l88W3CjpwwWyo2gTJvgp91731OfSf9iHvWwLK
	+nCJ72BLFp8Oor1uvsfllU9h3Ycy5XACqTuofAToBZ7dMYAwqOiYi9I8kuyi47DF
	oWlpb7p0wDWH5zswMlYFJ6yoXFzXBIj8XkxHYLTO5M570hde3FykJqWx4iLnd1c0
	vPKjz/Vux4F2+75ebWrlWfot4vL6Z2I/ouQYUuPKlDkQe9gpQ5dV5MACS7MTHL3L
	3w718cL0xv4m76zPG/TC5Kh/OmGZowR2u14GTeb/3LwyN+r1C6XZZ144FzyXRg/N
	hPXywrsg7kTJFijHQ15w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyb0crkqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 05:47:04 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V5l3Dd004166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 05:47:03 GMT
Received: from [10.110.3.44] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 21:47:02 -0800
Message-ID: <5e9041b7-0e84-6906-32d3-815c29e03233@quicinc.com>
Date: Tue, 30 Jan 2024 21:47:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mailmap: switch email address for John Moon
Content-Language: en-US
To: John Moon <john@jmoon.dev>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC: Elliot Berman <quic_eberman@quicinc.com>
References: <20240131034311.46706-1-john@jmoon.dev>
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20240131034311.46706-1-john@jmoon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WeeKOC_-0iqLStT7W-vVy-z4VflJ625B
X-Proofpoint-ORIG-GUID: WeeKOC_-0iqLStT7W-vVy-z4VflJ625B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_02,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=749
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310042

On 1/30/2024 7:43 PM, John Moon wrote:
> Add current email address as QUIC email is no longer active.
> 
> Signed-off-by: John Moon <john@jmoon.dev>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 04998f7bda81..8ae00bd3708a 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -289,6 +289,7 @@ Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
>  John Crispin <john@phrozen.org> <blogic@openwrt.org>
>  John Fastabend <john.fastabend@gmail.com> <john.r.fastabend@intel.com>
>  John Keeping <john@keeping.me.uk> <john@metanate.com>
> +John Moon <john@jmoon.dev> <quic_johmoo@quicinc.com>
>  John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>  John Stultz <johnstul@us.ibm.com>
>  <jon.toppins+linux@gmail.com> <jtoppins@cumulusnetworks.com>

Thank you John. Looks good to me. 

-- 
---Trilok Soni


