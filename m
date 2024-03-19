Return-Path: <linux-kernel+bounces-107445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D6C87FCA0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7CA2827E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501BD7E766;
	Tue, 19 Mar 2024 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F9wHfG4r"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB55C54BF6;
	Tue, 19 Mar 2024 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846766; cv=none; b=RLNrAL1V4UvE6oiXYLPf0QCG2QcvWTUDJghZROQhpT1aevANKsL4dPhA+OsoUjfD9ac7iCODUlG0Cr269E2LrltAW4d+rflO7LhrGBAiMbqBiUCXePIAmGtQSmBM/Tq1Pisbr+0VJh/ErCJGi0/EdeWFWOA6ZffsmFykVhhlMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846766; c=relaxed/simple;
	bh=F4aL7ZCH5j2X9PldDt7w2jAq1k9YFTM5qx/ObLef7hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6bQgf1zYaGk+vxxIMHgY30d95iGCQCt1WZvIvoYVpAOp/Ma90it7uto1mfnGufayM//QFBY/Mc334MOGDejI2ojT+LOuNKHCasbQynP241feFfRxClcsfIqXyB+H2PFynFk3KeDORKKEXX6lu2oF/mmNnhzQLjAh7HbiC7jczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F9wHfG4r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAfIha022693;
	Tue, 19 Mar 2024 11:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=V47fqHBz9Xe7fcRc0znVyKCEtLm+U7XW5YZvF5YtiQ0=;
 b=F9wHfG4rJ7i5P600+XcDlW/Xh0tAcOEO/dGvvQfoEBkIaSUxRyJ6eFMT/KrcnSey9Djo
 373rxlZkEgphG+YTDnODe06cBM/tVAxxcrsChUi0bVYaKiy9a12X6rbUl0e5wmVeT9X0
 gdK3Ow/c1N16FKt5W4IwuDCYjWDt1ioWFeNaag1S6VkEHt+b0m4Fs1RDmCfEfQJ/AHgp
 tVki0SF8Y4qkFnr+7T11d1+JZsq01IXup5l1YEzj41nedNxsYZW73sFtKnkz3q31jvRm
 ViR+gEv9rB8QBPz35RylTsbTueYXSotPgVdS0b/efEJYVNBXQxAxfMz0g2lG5PDLnZzD EQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy91ng8gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 11:12:42 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42J9maoT010061;
	Tue, 19 Mar 2024 11:12:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvauuxbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 11:12:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JBCZ6Y10158412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 11:12:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C247A2004B;
	Tue, 19 Mar 2024 11:12:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44D302004F;
	Tue, 19 Mar 2024 11:12:35 +0000 (GMT)
Received: from osiris (unknown [9.171.33.131])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 19 Mar 2024 11:12:35 +0000 (GMT)
Date: Tue, 19 Mar 2024 12:12:33 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v3 0/5] s390/vfio-ap: ap_config sysfs attribute for
 mdevctl automation
Message-ID: <20240319111233.23303-D-hca@linux.ibm.com>
References: <20240313205807.30554-1-jjherne@linux.ibm.com>
 <48d70b2c-788c-4ff0-9a03-c063aabdec07@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48d70b2c-788c-4ff0-9a03-c063aabdec07@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SiixsjTxscVYE_fl_pSO20DqcD7Zvkwn
X-Proofpoint-GUID: SiixsjTxscVYE_fl_pSO20DqcD7Zvkwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=794 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190086

On Fri, Mar 15, 2024 at 10:48:44AM -0400, Anthony Krowiak wrote:
> Unless someone else chooses to review these, my opinion is that they are
> good to go.

Please don't top-post.

> On 3/13/24 4:58 PM, Jason J. Herne wrote:
> > Mdevctl requires a way to atomically query and atomically update a vfio-ap
> > mdev's current state. This patch set creates the ap_config sysfs attribute.
> > This new attribute allows reading and writing an mdev's entire state in one go.
> > If a newly written state is invalid for any reason the entire state is rejected
> > and the target mdev remains unchanged.
..
> > Jason J. Herne (5):
> >    s390/ap: Externalize AP bus specific bitmap reading function
> >    s390/vfio-ap: Add sysfs attr, ap_config, to export mdev state
> >    s390/vfio-ap: Ignore duplicate link requests in
> >      vfio_ap_mdev_link_queue
> >    s390/vfio-ap: Add write support to sysfs attr ap_config
> >    docs: Update s390 vfio-ap doc for ap_config sysfs attribute
> > 
> >   Documentation/arch/s390/vfio-ap.rst   |  30 ++++
> >   drivers/s390/crypto/ap_bus.c          |  13 +-
> >   drivers/s390/crypto/ap_bus.h          |  22 +++
> >   drivers/s390/crypto/vfio_ap_ops.c     | 220 ++++++++++++++++++++++++--
> >   drivers/s390/crypto/vfio_ap_private.h |   6 +-
> >   5 files changed, 262 insertions(+), 29 deletions(-)

With gcc gcc 13.2.0 / binutils 2.40.90.20230730 I get this (defconfig):

  CC [M]  drivers/s390/crypto/vfio_ap_ops.o
In file included from ./include/linux/cpumask.h:13,
                 from ./include/linux/smp.h:13,
                 from ./include/linux/lockdep.h:14,
                 from ./include/linux/spinlock.h:63,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/mm.h:7,
                 from ./include/linux/scatterlist.h:8,
                 from ./include/linux/iommu.h:10,
                 from ./include/linux/vfio.h:12,
                 from drivers/s390/crypto/vfio_ap_ops.c:12:
In function ‘bitmap_copy’,
    inlined from ‘ap_matrix_copy’ at drivers/s390/crypto/vfio_ap_ops.c:1672:2,
    inlined from ‘ap_config_store’ at drivers/s390/crypto/vfio_ap_ops.c:1696:2:
/include/linux/bitmap.h:253:17: warning: ‘memcpy’ reading 32 bytes from a region of size 0 [-Wstringop-overread]
  253 |                 memcpy(dst, src, len);
      |                 ^~~~~~~~~~~~~~~~~~~~~
In function ‘ap_config_store’:
cc1: note: source object is likely at address zero
In function ‘bitmap_copy’,
    inlined from ‘ap_matrix_copy’ at drivers/s390/crypto/vfio_ap_ops.c:1673:2,
    inlined from ‘ap_config_store’ at drivers/s390/crypto/vfio_ap_ops.c:1696:2:
/include/linux/bitmap.h:253:17: warning: ‘memcpy’ reading 32 bytes from a region of size 0 [-Wstringop-overread]
  253 |                 memcpy(dst, src, len);
      |                 ^~~~~~~~~~~~~~~~~~~~~
In function ‘ap_config_store’:
cc1: note: source object is likely at address zero
In function ‘bitmap_copy’,
    inlined from ‘ap_matrix_copy’ at drivers/s390/crypto/vfio_ap_ops.c:1674:2,
    inlined from ‘ap_config_store’ at drivers/s390/crypto/vfio_ap_ops.c:1696:2:
/include/linux/bitmap.h:253:17: warning: ‘memcpy’ reading 32 bytes from a region of size 0 [-Wstringop-overread]
  253 |                 memcpy(dst, src, len);
      |                 ^~~~~~~~~~~~~~~~~~~~~
In function ‘ap_config_store’:
cc1: note: source object is likely at address zero

