Return-Path: <linux-kernel+bounces-110131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F236885A75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821CF1C21399
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463E38526B;
	Thu, 21 Mar 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CketFXJS"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905CA84A5A;
	Thu, 21 Mar 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030490; cv=none; b=RBJIwH7d9Bsjs/DlzvAfhogDwHQt7tt8a4BrwnUCJreRRDViYo2pYmUOq8wDy5Zr3rWoK8WBgESDX1vCPnPed7+yxz/q9ArdOoUNqXCnlu11cJM/kucp0BLkvQ2KMM2XXWt2YTx5BVdsKs95J7VWFt2gJ1lZAsn/xsuC5thOkw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030490; c=relaxed/simple;
	bh=wD6LyJTQ9goo3Gaon1B8xPpMlT5oxf5mSAJ9izqkd9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0m91es3O45g79rrKGXNQSCF4CXKuQqgVaR7C2QupXIdHgQZPRd2/KQ8usS56iyLzlDFywOl6egu+DSTAFrx1HNjhxxEqlSBz+r8u5YyTltPd30epBtGzlofka9CYYmwXyGuzaa/YDkpX+zMKHsHf3+Vv352/oSoUF2/0v3yfis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CketFXJS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LBb7GO017956;
	Thu, 21 Mar 2024 14:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KAcR5OX5lSECjL2mgzu4R0hmNFSKZNmHgRH6L7IhkKM=;
 b=CketFXJSb5ew3lLE4xNk2+k9p7LtT/ICmMd8hPXXKKf6VfMVtge+k6q+GtgXSKhANuIz
 DQe2GTWw8I6WsWMPh7fsfuoSm+5FNj7DApBmMAjfeSlm/WBGuzBSL+/mpmURS3V3gyhx
 IfTi3JrB3HwGwH66TZLIvnvelzr1wXZrJt2uLEiOLGuOnZBUHR5Yr6/k2JBwTvu1h9Th
 Cdi3va7pro0mmGvGP+POIYKqz9CB+iriYevNMpBaKoYF9DxMpSjy5cNGs5ss9Fhwfnba
 eaP8mg9PgUnpbyWaEuvGDISyJOFp6Y5xKjXFQu25vgHMdYe+M+ic9No7Ytgth2rdTOWf jQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0hwv0uh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 14:14:46 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42LBusP9017242;
	Thu, 21 Mar 2024 14:14:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrtnw29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 14:14:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LEEfvE22872820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 14:14:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD2D558065;
	Thu, 21 Mar 2024 14:14:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2216C58069;
	Thu, 21 Mar 2024 14:14:41 +0000 (GMT)
Received: from [9.61.82.208] (unknown [9.61.82.208])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 14:14:41 +0000 (GMT)
Message-ID: <7307842e-769e-92df-800a-0bf78fe0b70b@linux.ibm.com>
Date: Thu, 21 Mar 2024 10:14:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/5] s390/vfio-ap: ap_config sysfs attribute for
 mdevctl automation
To: Heiko Carstens <hca@linux.ibm.com>,
        Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, borntraeger@de.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com
References: <20240313205807.30554-1-jjherne@linux.ibm.com>
 <48d70b2c-788c-4ff0-9a03-c063aabdec07@linux.ibm.com>
 <20240319111233.23303-D-hca@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20240319111233.23303-D-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rJHCnxYpA2e_UWChX_m7okg_0qw1DJJn
X-Proofpoint-ORIG-GUID: rJHCnxYpA2e_UWChX_m7okg_0qw1DJJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210101


On 3/19/24 7:12 AM, Heiko Carstens wrote:

> With gcc gcc 13.2.0 / binutils 2.40.90.20230730 I get this (defconfig):
> 
>    CC [M]  drivers/s390/crypto/vfio_ap_ops.o
> In file included from ./include/linux/cpumask.h:13,
>                   from ./include/linux/smp.h:13,
>                   from ./include/linux/lockdep.h:14,
>                   from ./include/linux/spinlock.h:63,
>                   from ./include/linux/mmzone.h:8,
>                   from ./include/linux/gfp.h:7,
>                   from ./include/linux/mm.h:7,
>                   from ./include/linux/scatterlist.h:8,
>                   from ./include/linux/iommu.h:10,
>                   from ./include/linux/vfio.h:12,
>                   from drivers/s390/crypto/vfio_ap_ops.c:12:
> In function ‘bitmap_copy’,
>      inlined from ‘ap_matrix_copy’ at drivers/s390/crypto/vfio_ap_ops.c:1672:2,
>      inlined from ‘ap_config_store’ at drivers/s390/crypto/vfio_ap_ops.c:1696:2:
> ./include/linux/bitmap.h:253:17: warning: ‘memcpy’ reading 32 bytes from a region of size 0 [-Wstringop-overread]
>    253 |                 memcpy(dst, src, len);
>        |                 ^~~~~~~~~~~~~~~~~~~~~
> In function ‘ap_config_store’:
> cc1: note: source object is likely at address zero
> In function ‘bitmap_copy’,
>      inlined from ‘ap_matrix_copy’ at drivers/s390/crypto/vfio_ap_ops.c:1673:2,
>      inlined from ‘ap_config_store’ at drivers/s390/crypto/vfio_ap_ops.c:1696:2:
> ./include/linux/bitmap.h:253:17: warning: ‘memcpy’ reading 32 bytes from a region of size 0 [-Wstringop-overread]
>    253 |                 memcpy(dst, src, len);
>        |                 ^~~~~~~~~~~~~~~~~~~~~
> In function ‘ap_config_store’:
> cc1: note: source object is likely at address zero
> In function ‘bitmap_copy’,
>      inlined from ‘ap_matrix_copy’ at drivers/s390/crypto/vfio_ap_ops.c:1674:2,
>      inlined from ‘ap_config_store’ at drivers/s390/crypto/vfio_ap_ops.c:1696:2:
> ./include/linux/bitmap.h:253:17: warning: ‘memcpy’ reading 32 bytes from a region of size 0 [-Wstringop-overread]
>    253 |                 memcpy(dst, src, len);
>        |                 ^~~~~~~~~~~~~~~~~~~~~
> In function ‘ap_config_store’:
> cc1: note: source object is likely at address zero

I believe that this is a bogus compiler warning. I cannot reproduce it, 
fwiw.

gcc:     gcc (GCC) 13.2.1 20231205 (Red Hat 13.2.1-6)
binutls  binutils-2.40-14.fc39

make W=1 modules

Here is the supposedly offending code.

drivers/s390/crypto/vfio_ap_ops.c:
1670 static void ap_matrix_copy(struct ap_matrix *dst, struct ap_matrix 
*src)
1671 {
1672         bitmap_copy(dst->apm, src->apm, AP_DEVICES);
1673         bitmap_copy(dst->aqm, src->aqm, AP_DOMAINS);
1674         bitmap_copy(dst->adm, src->adm, AP_DOMAINS);
1675 }

called from drivers/s390/crypto/vfio_ap_ops.c:
1695    /* Save old state */
1696    ap_matrix_copy(&m_old, &matrix_mdev->matrix);


Definition of struct in drivers/s390/crypto/vfio_ap_private.h:
113 struct ap_matrix_mdev {
114         struct vfio_device vdev;
115         struct list_head node;
116         struct ap_matrix matrix;
117         struct ap_matrix shadow_apcb;
118         struct kvm *kvm;
119         crypto_hook pqap_hook;
120         struct mdev_device *mdev;
121         struct ap_queue_table qtable;
122         struct eventfd_ctx *req_trigger;
123         DECLARE_BITMAP(apm_add, AP_DEVICES);
124         DECLARE_BITMAP(aqm_add, AP_DOMAINS);
125         DECLARE_BITMAP(adm_add, AP_DOMAINS);
126 };

drivers/s390/crypto/vfio_ap_private.h:
76 struct ap_matrix {
77         unsigned long apm_max;
78         DECLARE_BITMAP(apm, AP_DEVICES);
79         unsigned long aqm_max;
80         DECLARE_BITMAP(aqm, AP_DOMAINS);
81         unsigned long adm_max;
82         DECLARE_BITMAP(adm, AP_DOMAINS);
83 };

drivers/s390/crypto/ap_bus.h:
22 #define AP_DEVICES 256          /* Number of AP devices. */
23 #define AP_DOMAINS 256          /* Number of AP domains. */

The source object seems to have a well defined size.

A quick web search seems to indicate gcc throws quite a few
Wstringop-overread warnings for valid code. I suspect this is
another example of that.

