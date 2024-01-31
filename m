Return-Path: <linux-kernel+bounces-46617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5056F844209
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CFD1F259C1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E0284A26;
	Wed, 31 Jan 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bdT6UCsp"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE048288D;
	Wed, 31 Jan 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712041; cv=none; b=BY+qbsrdWteNoDJoNd+UAL9f05BeA1YMOMOYwwKr2iRjCN0Q+FzNBkSv4monQOKHPugOxzjEQR07a8TRfrGA4/vwVnvG01OeiVmRJTi4uQI7PlSLeaUShUEt+OiXRS0EBBEZ72v4KGmgQcOCpD6KH7p3CdFyNaEvks8V3Fw1Dmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712041; c=relaxed/simple;
	bh=cf0o7pUczT+SwyHF1r0Vl8rD7xbhYCtgfD5FzmAA0zY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YxF3FXmicsq6NM7G+rbcCxsIhZdyDAGDINUa34wgvWzZUCts+RZO/ng/YfK7BwIR67x3OqefV6j2AVk9XaloSLee/bJEjz5bu5wCsPLFnBIAdFY2bnAR/2y1cB4HsZbInc5zG+HXB17+Uw0tPIVDZu+Kje0eeh6WcPPwjH2TtPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bdT6UCsp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VE03pQ004366;
	Wed, 31 Jan 2024 14:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=CAbY6nnqiJsCB4h73B1JxMOVqr/ABqqEHndIpIGtNWg=;
 b=bdT6UCspzxb9Mkz6mMk0ZRpO/455IgBHJ3YjoaAylVTbLnsfvonqCqN3AZKwFE6Vq0hL
 mvR8Mb47xxHDKdoV/9I0jOTk6eObXEp+/3DTvsploZ025CrJvJ+LwsLrIjBpS+7SwXbg
 VB9dLmySOfrFJ4qAmppcT893z38Y04Qwue1K0k/nWv5jXn6Ceqo6NUqaHdIuzJfhWhDY
 rmRELF0Q84z4nk67p5Q1ET6LXtCgC0quWJogvIBjh2d1WNidY97DXMr37xfP4fUXfqBj
 bNYxVuOUOq+jKm29vBvkwqr0rmQsKIq/0JYpJrxdeUmg8v/Mfa0/7C3VRJhCWtl2t8aA /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyp9y30ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:40:37 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VEP4Yg020970;
	Wed, 31 Jan 2024 14:40:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyp9y30bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:40:36 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40VDXUsC007200;
	Wed, 31 Jan 2024 14:40:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2dh10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:40:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40VEeWkX13042418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 14:40:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98D722004B;
	Wed, 31 Jan 2024 14:40:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BEF22004D;
	Wed, 31 Jan 2024 14:40:32 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 31 Jan 2024 14:40:32 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Nico Boehr
 <nrb@linux.ibm.com>, Philipp Rudo <prudo@redhat.com>,
        Baoquan He
 <bhe@redhat.com>, Tao Liu <ltao@redhat.com>,
        Alexander Egorenkov
 <egorenar@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        "Gustavo A. R.
 Silva" <gustavoars@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin
 Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/82] s390/kexec_file: Refactor intentional wrap-around
 calculation
In-Reply-To: <ZbpXieRZz3BQ6jBH@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
	(Alexander Gordeev's message of "Wed, 31 Jan 2024 15:22:01 +0100")
References: <20240122235208.work.748-kees@kernel.org>
	<20240123002814.1396804-30-keescook@chromium.org>
	<ZbpXieRZz3BQ6jBH@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Date: Wed, 31 Jan 2024 15:40:31 +0100
Message-ID: <yt9d4jetmuqo.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hi5JB6CrT1YccCS8U5iW7QtK_X6slFsm
X-Proofpoint-ORIG-GUID: ZPRMgtNbIfwvBkgv-v1cJY0vDW_eM9Fd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=848 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310112

Alexander Gordeev <agordeev@linux.ibm.com> writes:

> On Mon, Jan 22, 2024 at 04:27:05PM -0800, Kees Cook wrote:
>> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
>> index 8d207b82d9fe..e5e925423061 100644
>> --- a/arch/s390/kernel/machine_kexec_file.c
>> +++ b/arch/s390/kernel/machine_kexec_file.c
>> @@ -238,6 +238,7 @@ void *kexec_file_add_components(struct kimage *image,
>>  	unsigned long max_command_line_size = LEGACY_COMMAND_LINE_SIZE;
>>  	struct s390_load_data data = {0};
>>  	unsigned long minsize;
>> +	unsigned long sum;
>
> Please, use min_kernel_buf_len instead of sum.
>
> @Sven, could you please correct me if (minsize + max_command_line_size)
> means something else.

Your understanding is correct, minsize + max_command_line_size is the
minimum required size of the kernel image.

