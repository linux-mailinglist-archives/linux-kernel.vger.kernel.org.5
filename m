Return-Path: <linux-kernel+bounces-156835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DAD8B08E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E111F25CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A372715ADA1;
	Wed, 24 Apr 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eXoBFJDg"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B415AAA3;
	Wed, 24 Apr 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960363; cv=none; b=JJadDkA7vOeEYLga2sMNMB6hggwVN5CY3lAB5wgvm+iBevAacCS1s+nmnxgdmq33XadpjxQUOR/lZ83z33xQfGvzxh4RKPZHGATS1twky/BlI11izVePoJDSfeBTb3kuagejaiLcVCkJprnW2jW6Q6VvMWXIyKbT6Ws8ZESvtAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960363; c=relaxed/simple;
	bh=qTmT8SjUiq5qoWl/PUT6yRzFTQu65wMods7xcZ3FnEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbcWvVu3fPYolBDWtHQ/ugrrWMdmDQwVoaYAaewADDt1guIoTvg3XfD2nK/5yWwCRQ3dmK4CSxac1c5hqL1iUA42gXFYXGVPmGsM+RKqKok052H82RleyAnSq7PaPTa0o6sCdxhWVExDph4NbyjvTyZi66pzxWzIdPHylTSnLCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eXoBFJDg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OBu2Oj010616;
	Wed, 24 Apr 2024 12:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=qTmT8SjUiq5qoWl/PUT6yRzFTQu65wMods7xcZ3FnEg=;
 b=eXoBFJDgkewruQ2TSrXd3SGWw8G8YOCsDsmOzlulr8QlIsQKQAMXB1nURUXxvSsajYVS
 LCynsshjojUM6LXB3NAJZM7NyJCWiaCWDoY3TtwqsEGthq4G23Rq3DVQKW7WVctuzmAy
 C2xSQ4fTGiLYHa7XaR16DaODTkawKNAxTDN+uEXpPwft0GLMz9WkJhKOG7Kg+hFhNBux
 5fY9AVMfiQtzbMga3x90GeNXXcvbajo1gDRp9iRpIsUH3m2A897Fn8cIRO7GtqMQyu22
 HJehC3IkA5ddSuWzNstryyTUattcVezptWx0+RgYG5cbp1Rk1P1tdFyh5cf2m6Qy/S3f MA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq1mjr0nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 12:05:57 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43OB5uon020915;
	Wed, 24 Apr 2024 12:05:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmre03k75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 12:05:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43OC5o4940173900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 12:05:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A10992004E;
	Wed, 24 Apr 2024 12:05:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68F8320043;
	Wed, 24 Apr 2024 12:05:50 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Apr 2024 12:05:50 +0000 (GMT)
Date: Wed, 24 Apr 2024 14:05:49 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>, Jean Delvare <jdelvare@suse.de>
Cc: Jean Delvare <jdelvare@suse.de>, linux-s390@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH RFC] s390/pci: Drop unneeded reference to CONFIG_DMI
Message-ID: <Zij1fJw+Ksrq5iAm@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240423162724.3966265a@endymion.delvare>
 <b5ee24107efbc943cfc8ea59bf0653d2dd6325ad.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ee24107efbc943cfc8ea59bf0653d2dd6325ad.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IVKhr5tMpGNcHdPy8Kw3IszRgPI04iWI
X-Proofpoint-GUID: IVKhr5tMpGNcHdPy8Kw3IszRgPI04iWI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_10,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=639 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240046

On Wed, Apr 24, 2024 at 01:34:49PM +0200, Niklas Schnelle wrote:
> I'm assuming this change should go via the s390 tree? So let me add the
> s390x architecture maintainers to pick this up, but from my side and
> considering that you maintain the SMBIOS/DMI support:

Hi Jean,

Whether this patch is good to go alone via s390 tree or (as Niklas
indicated) might depend on some SMBIOS/DMI update?

> Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks!

