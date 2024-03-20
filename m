Return-Path: <linux-kernel+bounces-109151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA7288155D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D825E1F21AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D47B5644E;
	Wed, 20 Mar 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yas7dPUI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAFA55792;
	Wed, 20 Mar 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951393; cv=none; b=eNMOFRqo6eF+apXO/iEtiQn941+4tXAAG2cgY5zqlG4JAZtQ5ciyMK8ZnUtlssof7GbQ1ap+zo9PVodkr+IwORac4SjN1+1BX+g7NvFKTuGtZKclxxEg0BeA7vVGFjq9kn5TELEdJOV6a+4NwYPm7YkOxGckyt3zVlwrXz4EaKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951393; c=relaxed/simple;
	bh=0RvBV5HPHCypiG8/1C2bPVwFxUctq8TGU6kkO100MJQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZzuUDm/HAHDIn5uiIQ2sJNNb2GZVn3HZRsEIiOpYkXVe1Kc+DlDRPQ+PGCDROcq+cf9hw0TR+ffhfjHu7pSPRhxiLB1HtOrAvApNz+nvo09n9BE8vawMSH2iGMTknmFjNkQM/HchQZ6rp1uWWE1x9IKAaEPf82NQNcgCyQtQFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yas7dPUI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KG0ATk020257;
	Wed, 20 Mar 2024 16:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HfuSXD61T3jEkncOiw8gApr3+P2Z8+cmNdGxNiRWng0=;
 b=Yas7dPUI7lofd074WfRo3wi04lnUOmlek1xutDTWtXuumYq7/0q4W/wuhxUeBJIA+Ime
 F50/+zSAVt87cOCp19vpzy9iU/4M41QrBQ1wY9GYeR5dNGsgCuXyayqYkCEesPlY9Qj0
 hP5TWJFESbXp9NPtaFNdLPP35suFIRFkG2CYUn2BbREmVcmpmLlbeVN/6rk+pBhxyunM
 nJyfNbxgjwNtOF7mhf6NdJ8Z9VBh93VvaQcansoUehkl8hc7NUcws+dC0HAPmpgjpcl+
 ZumydteDpUz7MfBt0bToYqif3oIV9qoyNPL0SsP+SK0Phd/FF+H6b0bba5gLW3jNtPc+ Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x008rgg24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 16:16:05 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42KGG5rQ012184;
	Wed, 20 Mar 2024 16:16:05 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x008rgg21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 16:16:05 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42KE9wci017231;
	Wed, 20 Mar 2024 16:16:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrtfhps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 16:16:04 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42KGG1Vd40174240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 16:16:03 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0F795805B;
	Wed, 20 Mar 2024 16:15:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE40F58065;
	Wed, 20 Mar 2024 16:15:58 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 16:15:58 +0000 (GMT)
Message-ID: <afc9471c-1c28-4384-82c1-29464ca1fb1f@linux.ibm.com>
Date: Wed, 20 Mar 2024 12:15:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: tpm_tis
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
        "Daniel P . Smith" <dpsmith@apertussolutions.com>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
References: <20240320085601.40450-1-jarkko@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240320085601.40450-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G6cDu7hnCJlnPlQMBwAxaYs3jmZHVtef
X-Proofpoint-GUID: 0WxVBd-OTimkKLLzsWkImZ5r7x7NwVMt
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
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403200130



On 3/20/24 04:56, Jarkko Sakkinen wrote:
> Based recent discussions on LKML, provide preliminary bits of tpm_tis_core
> dependent drivers. Includes only bare essentials but can be extended later
> on case by case. This way some people may even want to read it later on.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> CC: Daniel P. Smith <dpsmith@apertussolutions.com>
> Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> Cc: keyrings@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> - Fixed errors reported by Randy:
>    https://lore.kernel.org/all/aed28265-d677-491a-a045-24b351854b24@infradead.org/
> - Improved the text a bit to have a better presentation.
> ---
>   Documentation/security/tpm/index.rst   |  1 +
>   Documentation/security/tpm/tpm_tis.rst | 30 ++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
>   create mode 100644 Documentation/security/tpm/tpm_tis.rst
> 
> diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
> index fc40e9f23c85..f27a17f60a96 100644
> --- a/Documentation/security/tpm/index.rst
> +++ b/Documentation/security/tpm/index.rst
> @@ -5,6 +5,7 @@ Trusted Platform Module documentation
>   .. toctree::
>   
>      tpm_event_log
> +   tpm_tis
>      tpm_vtpm_proxy
>      xen-tpmfront
>      tpm_ftpm_tee
> diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentation/security/tpm/tpm_tis.rst
> new file mode 100644
> index 000000000000..b331813b3c45
> --- /dev/null
> +++ b/Documentation/security/tpm/tpm_tis.rst
> @@ -0,0 +1,30 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================
> +TPM FIFO interface Driver
> +=========================
> +
> +FIFO (First-In-First-Out) is the name of the hardware interface used by the

FIFO is the type. I am surprised you call it a 'name'. I would say TIS 
is the 'name'.

> +tpm_tis_core dependent drivers. The prefix "tis" comes from the TPM Interface

tis is a tla -- a three letter *acronym*. You aren't using it as a 'prefix'.

> +Specification, which is the hardware interface specification for TPM 1.x chips.

It's also available for TPM2.

> +
> +Communication is based on a 5 KiB buffer shared by the TPM chip through a

I thought it was typically 4 KiB.

> +hardware bus or memory map, depending on the physical wiring. The buffer is
> +further split into five equal-size buffers, which provide equivalent sets of

equal-sized MMIO regions?

> +registers for communication between the CPU and TPM. These communication
> +endpoints are called localities in the TCG terminology.
> +
> +When the kernel wants to send commands to the TPM chip, it first reserves
> +locality 0 by setting the requestUse bit in the TPM_ACCESS register. The bit is
> +cleared by the chip when the access is granted. Once it completes its
> +communication, the kernel writes the TPM_ACCESS.activeLocality bit. This
> +informs the chip that the locality has been relinquished.
> +
> +Pending localities are served in order by the chip in descending order, one at
> +a time:

I think I know what pending localities are because I have worked with 
this device but I am not sure whether the user can deduce this from the 
paragraph above. Also, why this particular detail when the driver only 
uses locality 0 and nobody is competing about access to localities?

> +
> +- Locality 0 has the lowest priority.
> +- Locality 5 has the highest priority.
> +
> +Further information on the purpose and meaning of the localities can be found
> +in section 3.2 of the TCG PC Client Platform TPM Profile Specification.

