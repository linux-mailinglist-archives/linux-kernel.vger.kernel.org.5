Return-Path: <linux-kernel+bounces-142806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF598A3055
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596C2B229DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2378625A;
	Fri, 12 Apr 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NPKtwTUa"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519F8614D;
	Fri, 12 Apr 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931524; cv=none; b=bHnOTUPFKNuUdiiD/8T/nRn/kaHNGHN+0s4PeqHaNOIZab7aIVPY247B8KoNCenDItlax5eG449Z5oeQG5yW+8xeQnOTLYmYgzlZiggPMXmgZtrqB20APKpBLFVMYabHZ8NV32ArJEKo/h23jfqPY3VgigbCko51ZPNyXRiRFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931524; c=relaxed/simple;
	bh=vQmIHW35IfACeoF8Y3ELfJZWzuetDxk2uQ38pUrHrDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYDmvPSZyLhYgKFV1CwO3NzEH8OaMAwyXIvXFZTOCkHNtDQnBFdnyhwuiEj0Ba5Hre8Ysl3rbsob5dL6UScMOea2tSalTNRgV4pY6SU6FXa2YYfG8K7QJzVYvnScvV+5fnFwh+MRmvkzbEgA9FmKq5FGz2Gck2+sSGNHjpgaKSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NPKtwTUa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CEIHhw016321;
	Fri, 12 Apr 2024 14:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vQmIHW35IfACeoF8Y3ELfJZWzuetDxk2uQ38pUrHrDI=;
 b=NPKtwTUaichaw0k/dXCTeMspl499W9DVCJru8ytmjqLU3RuxJUjU4z0dPTuj1zSqmlWd
 OpjMKWAImtaqMiCzxmH4FbjSLWEuLGomumTi2RHY5L8fomDESwMqn/mWyp/kREawWDDY
 ofE0hpoCM5KtHn8K710Nky5boUuZQCgcB7s58/Zbl39taR2b1dO/1jHoFqTQK29GKwRL
 5rMDbDgbtLQ76mz/wPlQjUI6bplirrhbIs8UmxSNJQJdVg94GpNGb78sPF7QzV9GJDNn
 YZZ854cy/4IGOmb2JCujheecocpS3fIqDRrxWU+BF7Y8p+PkiSpvSPckxQ8eb6lB3nDn Ig== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf55y072r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:18:42 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43CDTtME013594;
	Fri, 12 Apr 2024 14:18:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbgqu2hf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:18:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43CEIZuB52560198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 14:18:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBC542004B;
	Fri, 12 Apr 2024 14:18:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8146F20040;
	Fri, 12 Apr 2024 14:18:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 12 Apr 2024 14:18:35 +0000 (GMT)
Date: Fri, 12 Apr 2024 16:18:34 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v4 4/5] s390/vfio-ap: Add write support to sysfs attr
 ap_config
Message-ID: <ZhlCuhqpDjUFHW/u@tuxmaker.boeblingen.de.ibm.com>
References: <20240326164706.29167-1-jjherne@linux.ibm.com>
 <20240326164706.29167-5-jjherne@linux.ibm.com>
 <ZhP9qHs6tjPbh1/J@tuxmaker.boeblingen.de.ibm.com>
 <95b551f1-7599-96e1-b528-0701465baf5a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b551f1-7599-96e1-b528-0701465baf5a@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uFIXWrhIja2-9B5Z_Rq8JEpCimc7IlDX
X-Proofpoint-ORIG-GUID: uFIXWrhIja2-9B5Z_Rq8JEpCimc7IlDX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxlogscore=550
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120103

On Fri, Apr 12, 2024 at 08:29:44AM -0400, Jason J. Herne wrote:
Hi Jason,
> Yes, I can make that change. My checkpatch.pl script does not point this
> issue out with --strict. Should I be running checkpatch with --strict?

Yes.
AFAIR --strict produced that.

> > Also, please address other checkpatch suggestions.
> Yep, I'll run with --strict and address everything.

Thanks!

