Return-Path: <linux-kernel+bounces-108211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA28880786
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BE51F236D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5855FDD0;
	Tue, 19 Mar 2024 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nz8yw2io"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38D5FDB0;
	Tue, 19 Mar 2024 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888833; cv=none; b=sRemjhxM0QPpL3hVDdj+lu4tuIGuJY/Fmms6CmkIN1Tug58Aub51IfstetoG7CJQneI397OnmY7r2/dhLyA0ZflmYcfFx1XMFgKe2Y0asSSqAg/aTsNTITP2xV7Td1mLz3E1uymQ/EEfGLengazJfuKcN2jX9h75kjUy3DX+tvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888833; c=relaxed/simple;
	bh=zZxxTLJXYfrFE1yQ+LInKXJuMo5Lhz7ayYuG+WvJLUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=hCnpq4PyYKbv97ELvOa9Xg4EGnZz2U1aqNeV+SHug5eUMetsYN6SOvbNQVh8C1mdMwU6lfbtGoLhxRNBu9oFunuTASb4WQ3GceSNaaRiS0545qBer0j1tUqIF8fc9Ze24nDcNmV8xriIXbhOHPFwnVkuyGF6zUtUP6EL9irbdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nz8yw2io; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JMOLlV004529;
	Tue, 19 Mar 2024 22:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Ze+grEIfYhcsgvGWobjXDVhltIzOCVH1MLr4JJ04BFE=;
 b=Nz8yw2ioh3fj8XojUywQSpI0YnJt/GBI9gLKfdKAkWGVLH6fnooeV0/HG/IAyMBHYHV7
 W1rvz2qHVHuNvXDX++JtMZRhyy7ZGzsoR0TZtqLp4yBLzQrnl9QjOKRHUpAfHVJW/33E
 UTqHPA7C4joztKbAQQqF7UBWpdNYzzH4aNy15NF70YG4DVMNqQ5OafsbQGJ2cfJrbfm3
 /4bhawZzKoxggJypiism3MqGD5QSteNUA00JFpYU9Ui71abXo81h2fB3PJ3zwiJKmboG
 FFFnPAOudY5Xv3t62ta1+N7AbpLjiMVO7YvksHSooUgZuHnRbR8bCIrdUaT4PIOOorXM Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyhffg8nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:53:29 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42JMrTUt013156;
	Tue, 19 Mar 2024 22:53:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyhffg8nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:53:29 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42JMfAPE011582;
	Tue, 19 Mar 2024 22:53:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8m2gnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:53:28 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JMrPIg42402150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 22:53:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9A6F58056;
	Tue, 19 Mar 2024 22:53:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BBEE5805A;
	Tue, 19 Mar 2024 22:53:25 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.80.83])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 22:53:25 +0000 (GMT)
Message-ID: <b64ceac21e21fa75ddfc41b869140e88544e6519.camel@linux.ibm.com>
Subject: Re: [PATCH v3 09/10] fs: Rename SB_I_EVM_UNSUPPORTED to
 SB_I_EVM_HMAC_UNSUPPORTED
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, amir73il@gmail.com,
        brauner@kernel.org, miklos@szeredi.hu
Date: Tue, 19 Mar 2024 18:53:24 -0400
In-Reply-To: <20240223172513.4049959-10-stefanb@linux.ibm.com>
References: <20240223172513.4049959-1-stefanb@linux.ibm.com>
	 <20240223172513.4049959-10-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: enoN8QEsbw0GsB0Bop9D2GUfHscUK7iu
X-Proofpoint-GUID: Ep_p_0ppdsVaIEPXMv0eMmpO5cpEr8SQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=807 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403190176

On Fri, 2024-02-23 at 12:25 -0500, Stefan Berger wrote:
> Now that EVM supports RSA signatures for previously completely
> unsupported filesystems rename the flag SB_I_EVM_UNSUPPORTED to
> SB_I_EVM_HMAC_UNSUPPORTED to reflect that only HMAC is not supported.
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Amir Goldstein <amir73il@gmail.com>

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>


