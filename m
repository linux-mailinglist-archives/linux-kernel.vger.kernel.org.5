Return-Path: <linux-kernel+bounces-148312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208BA8A80CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49D21F21C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C989113C698;
	Wed, 17 Apr 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SlGgvyop"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04213AD1D;
	Wed, 17 Apr 2024 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349223; cv=none; b=CV+brkzLy3y6NimzN0ch6mF0xbiomvk7V1gzGm52nRHLWRbShfhF7clBVBXtGqKRJ5aBobVomoWz2yUPsJjBNE/RmiUIJFoTCUU5cylPD+wPzao0xv5hRdj7lmRVs9kB1st3pr51FtcttSVRcjEJ/JE+N+KZrND43XzY4bHbisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349223; c=relaxed/simple;
	bh=BL9sVr1FX2Bl7U7DH4Ih8dPNhWgEwo/nV1rJcFVOilg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPpbNU6xXN5bCUvF1ACBxPcKjGl/xK1TiTNZ7WJeYdRVut9QTbraeSmqD5ZQyHWfiFPVpmVSBJDN6FF9qH1lKBio8BeQKmweDJs+X136jW8f30rb0U11XWUqye6CnwIsnKMFpgTDqZQkmhZQadZGr4fmgPDrWw22cG6J6ddhGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SlGgvyop; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43H9sgAb031215;
	Wed, 17 Apr 2024 10:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BL9sVr1FX2Bl7U7DH4Ih8dPNhWgEwo/nV1rJcFVOilg=;
 b=SlGgvyopI8pehtw2KLxtPHePnESLMfJCSbBzmAOQ5hSWXcQ1aAY0jC3EXXkxk43qjdfL
 55d0MgDgF9WR9d2McwmKCkW9bI1ezvOE6xAtkdYUAKM0vcbwuuXopkdP0AhV/Lj/VYIH
 NSOy1GoHFTNIc/LHP/X3IxBg+1iKYbPpR39rCgyq+8oiq2sPaRLe8HxFaDQThwaK8YQj
 dOHCcHW140EBkmu0SzmIwdZnLoMQa9I/UNjle7VUhjiUOS67JnireicYzi2eEuEalpY8
 fq6x6pa7lbiP6tHT61VpTrje3PQ92yeeiAS0evaBlcvI9wD4isJpLmofNIDDTVyuW0BC YA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjbc4r5xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:20:15 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43HAKEdb017897;
	Wed, 17 Apr 2024 10:20:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjbc4r5xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:20:14 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43H8Umm0027323;
	Wed, 17 Apr 2024 10:20:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg4s03tt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:20:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43HAK7Q131588628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 10:20:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32D6E20063;
	Wed, 17 Apr 2024 10:20:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BE422005A;
	Wed, 17 Apr 2024 10:20:06 +0000 (GMT)
Received: from [9.179.14.55] (unknown [9.179.14.55])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Apr 2024 10:20:06 +0000 (GMT)
Message-ID: <5c1ef62610506524763bc2d4f673279e0cb624b6.camel@linux.ibm.com>
Subject: Re: [PATCH net-next v6 02/11] net/smc: introduce loopback-ism for
 SMC intra-OS shortcut
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com,
        jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 17 Apr 2024 12:20:06 +0200
In-Reply-To: <20240414040304.54255-3-guwen@linux.alibaba.com>
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
	 <20240414040304.54255-3-guwen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-2.fc39app4) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nq42N4N8rAnD0oGf9Kk5FcUB5bWQ0kOK
X-Proofpoint-ORIG-GUID: xEYjGSR6ovHWU4xcYSmlh8GzMhk0EH_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=937 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404170071

On Sun, 2024-04-14 at 12:02 +0800, Wen Gu wrote:
> This introduces a kind of Emulated-ISM device named loopback-ism for
> SMCv2.1. The loopback-ism device is currently exclusive for SMC
> usage, and aims to provide an SMC shortcut for sockets within the
> same kernel, leading to improved intra-OS traffic performance.
> Configuration of this feature is managed through the config SMC_LO.
>=20
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
> =C2=A0net/smc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1=
3 ++++
> =C2=A0net/smc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> =C2=A0net/smc/af_smc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +++=
-
> =C2=A0net/smc/smc_loopback.c | 156
> +++++++++++++++++++++++++++++++++++++++++
> =C2=A0net/smc/smc_loopback.h |=C2=A0 43 ++++++++++++
> =C2=A05 files changed, 224 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 net/smc/smc_loopback.c
> =C2=A0create mode 100644 net/smc/smc_loopback.h
>=20

Thanks Wen Gu,

this looks good to me now. A W=3D1 compile-test of the whole series with
SMC_LO undefined showed that there were no additional unresolved
symbols introduced.

Feel free to add my
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>

