Return-Path: <linux-kernel+bounces-5857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C292E819063
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012441C23E60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E5A3985F;
	Tue, 19 Dec 2023 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G1Ok62v8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344139860;
	Tue, 19 Dec 2023 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJIxESM032432;
	Tue, 19 Dec 2023 19:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=BAgQ0Lp+HbRnsXuAGK5/SDgCDww0kPm0UoerrC0cBqU=;
 b=G1Ok62v8FRPOFddENpsp1QhbXpyATRT3unr8ghb7G9krx52zraqdtofvsJkbI8c48zHl
 fgSDRcXCFWzyRCy7nrW7BZCYmF0jkMJ38s9CsQanAuptm/cgjAH/x3GapnoSmeM6SatX
 8U4/PuqXYcBO8gsQZO3QEfSoc+hyr4obb4wHTLNt15br+iq5UkfhBBmusQfHifohFnuz
 NOZiqAlPTxyyzfnb3FkY2Z9TACL2EV8fe8/EWGDc8Nq83UuUoBCWXojxzsB9lOXSMtt7
 rWaYbRP4c88rAiFGaCrCZjFhyL6LPQcPVbEA2Iul2McYSS50AFss1f4rFr9/bVxemsGT vw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3gx8r7mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 19:10:02 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJJ07Ja001973;
	Tue, 19 Dec 2023 19:10:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3gx8r7mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 19:10:01 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJGnkAg012418;
	Tue, 19 Dec 2023 19:10:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1rx1seew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 19:10:00 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJJA0I214877352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 19:10:00 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16C0A58055;
	Tue, 19 Dec 2023 19:10:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 173185804E;
	Tue, 19 Dec 2023 19:09:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.158.57])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 19:09:58 +0000 (GMT)
Message-ID: <ddff6449a57ef38e503fcaef759fa37ed391d134.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] evm: add support to disable EVM on unsupported
 filesystems
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir
 Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Date: Tue, 19 Dec 2023 14:09:58 -0500
In-Reply-To: <20231219175206.12342-3-zohar@linux.ibm.com>
References: <20231219175206.12342-1-zohar@linux.ibm.com>
	 <20231219175206.12342-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QQtRf1kxr3cCt0XJq2Z6AsC8PNndlhlj
X-Proofpoint-ORIG-GUID: M_nvNiy8IiHSYXstRByU11Ro2u3EtHUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxlogscore=554 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190142

On Tue, 2023-12-19 at 12:52 -0500, Mimi Zohar wrote:

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 98b7a7a8c42e..db9350a734ef 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1164,6 +1164,7 @@ extern int send_sigurg(struct fown_struct *fown);
>  #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
>  #define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
>  #define SB_I_UNTRUSTED_MOUNTER		0x00000040
> +#define SB_I_EVM_UNSUPPORTED		0x00000050

This needs to be fixed.

Mimi

>  
>  #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
>  #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c


