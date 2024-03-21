Return-Path: <linux-kernel+bounces-110164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05450885AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89DE8B250E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA8A85277;
	Thu, 21 Mar 2024 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AlwEQxo6"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594401E876;
	Thu, 21 Mar 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032117; cv=none; b=A2KOrU4Bj2Bp2F5Oqj9PwWcWg9O5Ndk4el1dO92cePBZWWmn7GPisp/tAfZEGk3Ntxkp80EC/CP5hbvVd6BAhgYl48c4dbwTDaHbOsW5GauCEs6QXiZCvFo5r0t3NQopXLeizOavCNCkmz9Lk033LjPQiK1ikFGd9qqSflD56ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032117; c=relaxed/simple;
	bh=5c0e1gE1hGMRlizHU23/mf1df5lXbfw7eMJyT/uu+XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjxMMSUQ2Qx5P1ioRX7buJEztBy+BjCTLXmh+HELD965YZIIxeu5TF9rFsNU9astr1CFwCTtRZyv4nSnPfBGCXUqq/Iw8FPFlNkUtn59xA+jzyQTXMbhI5CFSmP3lO99JvdrrbQQacbaFOIctQMVu6NE10nOrb49Ty52FCKV7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AlwEQxo6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LDp75e019628;
	Thu, 21 Mar 2024 14:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=IpG8mJMwkfTbkB0zhSurrzy99dnKtzM5MxtyjDVwNG4=;
 b=AlwEQxo61lG2qjxm1TZYGcIDYlzcdMtapt4MyvZMfGae4L4Prws5AM/twrMgYbhUeibQ
 x8qLW6Ec07dit+qKMHpECRnsFBDVbHT2tV+s/f0clfgUNpbT+fQ8lLaPL3zpxj5aA8ge
 f/LCNsQECVy8heUl6wNftQrksy1BRdOc4HZscEkis7OCAT1pcP550JbRognjMiwqPGD4
 yrKgFOCwyx3yZVDHtYRL1KtfDM2z7Og4peef6uwmzAEl1JaLSynO1iNri74Hs1iuUAr/
 3TUykUkPHibxlHW+MQljf3mjmNTXHLozmllsCWJ6vumHr9Ezkj6rXJwoCpgGJ3SEfA+/ eQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0ne0r8ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 14:41:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42LDGY1f011582;
	Thu, 21 Mar 2024 14:41:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8mdpwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 14:41:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LEfhFj52101464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 14:41:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B91862004B;
	Thu, 21 Mar 2024 14:41:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96C8420040;
	Thu, 21 Mar 2024 14:41:43 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Mar 2024 14:41:43 +0000 (GMT)
Date: Thu, 21 Mar 2024 15:41:41 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v3 0/5] s390/vfio-ap: ap_config sysfs attribute for
 mdevctl automation
Message-ID: <20240321144141.6215-A-hca@linux.ibm.com>
References: <20240313205807.30554-1-jjherne@linux.ibm.com>
 <48d70b2c-788c-4ff0-9a03-c063aabdec07@linux.ibm.com>
 <20240319111233.23303-D-hca@linux.ibm.com>
 <7307842e-769e-92df-800a-0bf78fe0b70b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7307842e-769e-92df-800a-0bf78fe0b70b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _LZCa5j9iQd2y1n883_FOPog967_dO8b
X-Proofpoint-ORIG-GUID: _LZCa5j9iQd2y1n883_FOPog967_dO8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=519 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210105

Hi Jason,

> > In function ‘bitmap_copy’,
> >      inlined from ‘ap_matrix_copy’ at drivers/s390/crypto/vfio_ap_ops.c:1674:2,
> >      inlined from ‘ap_config_store’ at drivers/s390/crypto/vfio_ap_ops.c:1696:2:
> > ./include/linux/bitmap.h:253:17: warning: ‘memcpy’ reading 32 bytes from a region of size 0 [-Wstringop-overread]
> >    253 |                 memcpy(dst, src, len);
> >        |                 ^~~~~~~~~~~~~~~~~~~~~
> > In function ‘ap_config_store’:
> > cc1: note: source object is likely at address zero
> 
> I believe that this is a bogus compiler warning. I cannot reproduce it,
> fwiw.
> 
> gcc:     gcc (GCC) 13.2.1 20231205 (Red Hat 13.2.1-6)
> binutls  binutils-2.40-14.fc39
..
> A quick web search seems to indicate gcc throws quite a few
> Wstringop-overread warnings for valid code. I suspect this is
> another example of that.

This might be the case, however the code has to compile without
warnings also with plain gcc 13.2.0 (built from source).

