Return-Path: <linux-kernel+bounces-94231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACC8873BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C948D288AFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1203135A6F;
	Wed,  6 Mar 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RXPwStUE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE94135401;
	Wed,  6 Mar 2024 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741317; cv=none; b=eCJwb52rY4kB7GZeLSB7hDaUGH7HUJoeLwbLGk8BQ48APTL9+pI7Xi1DtbQt/vqWiTlzCzRUpESPWxIc3VLKqp3YyD0ehjZaSAnKfHTwu/v4Y10XAGQtohrDn9or6wz4PtwAHDUN3MLmMayqKdWXb0XDg23c8p3VAWkmlVU1odc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741317; c=relaxed/simple;
	bh=LGcNDDbG42U9lX5rQysNgwS6e76I7h8OyMh9iGSYW80=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k6S/4v/jjvquP4f3qKyAfie8YAcWpwsZIPv8OR8659ak5PXCUdV1CY+y4BVb70id9z60hQn1IA0O1Bx5PyUcS62caWoE9BWaQ/17O80kBLpWi3gMs6Q0fTiTJW9Rfo1y5EiR40Ie7Dqq0+W3G0Ms4/fCLrY/5WaQ1Zis8G3D7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RXPwStUE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426G7fqJ022425;
	Wed, 6 Mar 2024 16:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0j9gJbumXd6zptHGYG2RBhG8qWhL+f6Mp6U0BlqtkhY=;
 b=RXPwStUE1l4/wZgEkrc1LzWck6QKS+znwOCma8fT0r5vBCSy1tkjh1omF5jozzzHx1fY
 TuPU0IzL4BQ+sKYx211xuc6bE0/0eUkluujE0PkEX6w/AbaghM3wvuGDE2X6OYdYjrxc
 bsT2OfPsOOjGA/UenXqpzouYbvyODCdn84Gvgd34WxGsGGcKgOsTYvZyrgAvWXvyjQdy
 YIWWGJVr5AMypETus7hGk7sH+JKpeU4ojN2qoT8LZQR15UXjsrDu5vVwzGBpGQ7TAwqD
 TccavYQpS3hPgliUeZWgMNEQ4zxCJH6G4fCzPMiG1tc0SMQOr/HSCjoGxPcbg0PXC9Q6 sg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpuqn01fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 16:08:26 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426G8JD7025311;
	Wed, 6 Mar 2024 16:08:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpuqn01f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 16:08:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426FtCAc006067;
	Wed, 6 Mar 2024 16:08:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeet7xj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 16:08:25 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426G8L8W27459926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 16:08:23 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69A5158067;
	Wed,  6 Mar 2024 16:08:21 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0BF558052;
	Wed,  6 Mar 2024 16:08:20 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 16:08:20 +0000 (GMT)
Message-ID: <b6f74cd0-d1c8-4a6f-a05d-364595c5b079@linux.ibm.com>
Date: Wed, 6 Mar 2024 11:08:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Preserve TPM log across kexec
Content-Language: en-US
To: mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, rnsastry@linux.ibm.com,
        peterhuewe@gmx.de, viparash@in.ibm.com
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240306155511.974517-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CizILsSMrSfNKbP7kCQ9XhxIyaOzFfT8
X-Proofpoint-GUID: Vt9-ZaL_JWo0hGOQxy1b3juNtgpFLarn
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=895 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060130



On 3/6/24 10:55, Stefan Berger wrote:
> This series resolves an issue on PowerVM and KVM on Power where the memory
> the TPM log was held in may become inaccessible or corrupted after a kexec
> soft reboot. The solution on these two platforms is to store the whole log
> in the device tree because the device tree is preserved across a kexec with
> either of the two kexec syscalls.
> 
FYI: This was the previous attempt that didn't work with the older kexec 
syscall: 
https://lore.kernel.org/lkml/4afde78d-e138-9eee-50e0-dbd32f4dcfe0@linux.ibm.com/T/#m158630d214837e41858b03d4b025e6f96cb8f251

> Regards,
>     Stefan
> 
> Stefan Berger (2):
>    powerpc/prom_init: Replace linux,sml-base/sml-size with linux,sml-log
>    tpm: of: If available Use linux,sml-log to get the log and its size
> 
>   arch/powerpc/kernel/prom_init.c |  8 ++------
>   drivers/char/tpm/eventlog/of.c  | 36 ++++++++++-----------------------
>   2 files changed, 13 insertions(+), 31 deletions(-)
> 

