Return-Path: <linux-kernel+bounces-52773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCEA849C84
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1773E2830F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22C823753;
	Mon,  5 Feb 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nz4VkZIP"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F762377D;
	Mon,  5 Feb 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141698; cv=none; b=gu1KaPDVcT0uCqB53lfSYdgkXUzPTfHzOuH+rNMEVj2Y7ck7HzGr/QhYaHh8bh+P9Dzv+cND8a3Ra7eSpS/ccRIzwHMMYqqep9qfj64I4IVWDDl64MicQN9OCgy/mtEEj5DFKyBbtL1NmkW35NkF/Ab1VieZWSRGhPv82+rthRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141698; c=relaxed/simple;
	bh=VjwcTrRbgbQdtBVGJv2qQZZwAnRarTA5v9OzMoyv8EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxZ6YD8xShsPCkW+FQzJI1TqAZ+Qu4c5MwxVWGam4TGZP9uYaImrmWi3FdUpjDArflsCV+ceZYQUIIu6BZTpYP79R6f3Lk2zUyN/I9V0lidpnpmcmz3HLbVyyQpPePv7YqNdGN1kwkGr9mAtLpCHUaSvZYss1QWk2gbtgZ0IPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nz4VkZIP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415DW8lt022589;
	Mon, 5 Feb 2024 14:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EyHV+D44dUN71LSIbdMpw6Vb/v4sGSMQvbKPjifT+EU=;
 b=nz4VkZIPF6IJKYrn5fiidPYEjvwjOlgHo1kaP+/ZY9V5hDsceOGYBLcIjiCe0iE/GV9f
 o/Ns3ZG470batILXaKs3GW9PnqurkxyZ/D9UFJiePC0MpX8hFsMGGWJyWLx8F0uK/OU7
 Ond56waLmw3kYz7bYiExIyga44sFugWaO+x7L6WCY+QpTzWTQFh181LEtoIsuosrmq/+
 8KAQZOd5t7Y9eHStmHXeCSvQVrSBx5ZcqHFiMaYQuEvrs+AiCxcXCkqkUpaALbm0BsaS
 mlcvpFxlPv/nBQQxThxdY0JoWOWc5acbSjB5v938V170GIOjxyb6Nb/Lydv11wSe82xS Nw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2y4833mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:01:02 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415BMGWh005458;
	Mon, 5 Feb 2024 14:00:48 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21ak8phm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:00:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415E0lZT13632104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 14:00:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1798758043;
	Mon,  5 Feb 2024 14:00:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39D4658059;
	Mon,  5 Feb 2024 14:00:46 +0000 (GMT)
Received: from [9.61.155.228] (unknown [9.61.155.228])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 14:00:46 +0000 (GMT)
Message-ID: <d1916f5e-8d89-6f94-c562-8ed6d52f706f@linux.ibm.com>
Date: Mon, 5 Feb 2024 09:00:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/6] s390: vfio-ap: make matrix_bus const
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
 <20240203-bus_cleanup-s390-v1-6-ac891afc7282@marliere.net>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20240203-bus_cleanup-s390-v1-6-ac891afc7282@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1b6_ZgLgjBCaRQxDwVWwHZT2PyKDcg_W
X-Proofpoint-GUID: 1b6_ZgLgjBCaRQxDwVWwHZT2PyKDcg_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402050106

On 2/3/24 9:58 AM, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the matrix_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index a5ab03e42ff1..4aeb3e1213c7 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -60,7 +60,7 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
>   	kfree(matrix_dev);
>   }
>   
> -static struct bus_type matrix_bus = {
> +static const struct bus_type matrix_bus = {
>   	.name = "matrix",
>   };
>   
> 

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

