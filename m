Return-Path: <linux-kernel+bounces-71671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8883E85A8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE3F281002
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3D83BB3B;
	Mon, 19 Feb 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pGTQTonu"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80962D620;
	Mon, 19 Feb 2024 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359795; cv=none; b=ovQ4OqebdOtli7kW+4LRdTq7Bo0AnahxtVgU/qonNcTCBfeB4Nj9/HP71rLM7hCzTQkqPFJKE0MRsF/bzD/cn2vDLDP+bQ8iqW35GD9ks+qx/DwajdTP+qn76/vbKyNxIbeKectxkZgtElPLXTLUtbnphaRBC8btkDEY1dghfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359795; c=relaxed/simple;
	bh=mmSPbWQiapCwR2flDPIpWEVVDDLQO2RnQqCCmuow9TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTu7QvNBqr2T4dEZm5yY+1hi3WtsU6Rp9rqyfWRnFdVhu63VEW6vOdPIL11Bxyzp4KKAPRQgQKon0y5EOIuQYEprtpnWcT9qSlP3Dt4ZyQ+vlHF69qiobfTY1ObwRXH4J+dWOS3XtYf7OLoI4JbITowXd7bXbtZsPeowAU9HtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pGTQTonu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JFqjND029351;
	Mon, 19 Feb 2024 16:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=LyWVOHOToYNN6u9Ni+d5jhn9uK1m+RW+rCmqq8zQhUo=;
 b=pGTQTonupdGOayUpihLLA7YE4sXPgIh5PvAllR/s788a811lrWXQ/XdDLht6icl+Svjz
 PHxgYVZbG+PAv56oepWvJzJjk/c3MTkRRLPcTXnLwL3DRWsK5v+CfUVbZyxsX489yTs/
 waGBg5a+559U18rRpf08EMajSL+9cdWDFItJT279p8Y4iVxSUrSdrFXQ7SuoVuHbBl92
 srgOI6FaF8pZQDMzo7JL75oYH+4dw6som7HenQQDkbmrpVHfHG32F4M9MtifSukj8V/T
 TquSl96SPepahnICPjkHHM7A/QgketWG8qFRWeak9vrH6wTuHrZTHkAwVYVNlSx7CkLq Cg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wca0w0vy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:23:06 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JGFvfl014427;
	Mon, 19 Feb 2024 16:23:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u29qv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:23:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JGN0bN59638136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 16:23:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7995A2004D;
	Mon, 19 Feb 2024 16:23:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F145920043;
	Mon, 19 Feb 2024 16:22:59 +0000 (GMT)
Received: from osiris (unknown [9.171.27.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 Feb 2024 16:22:59 +0000 (GMT)
Date: Mon, 19 Feb 2024 17:22:58 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 07/10] s390/vdso: Use generic union vdso_data_store
Message-ID: <20240219162258.16287-G-hca@linux.ibm.com>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
 <20240219153939.75719-8-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219153939.75719-8-anna-maria@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 08hCN1IEk0HWQF-7EYMghrtS7WRqXZg_
X-Proofpoint-GUID: 08hCN1IEk0HWQF-7EYMghrtS7WRqXZg_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_12,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 spamscore=0 mlxlogscore=309 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190122

On Mon, Feb 19, 2024 at 04:39:36PM +0100, Anna-Maria Behnsen wrote:
> There is already a generic union definition for vdso_data_store in vdso
> datapage header.
> 
> Use this definition to prevent code duplication.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/vdso.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

