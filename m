Return-Path: <linux-kernel+bounces-46589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C48441BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CF51C22777
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FB082867;
	Wed, 31 Jan 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IPuPXHmy"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC323762DD;
	Wed, 31 Jan 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710968; cv=none; b=r0jSBpZpsiwfMfpff686S/MfHRJEjU3Vosmw4uD6Yk+ZmNbqIlzi2JFosNIUZcg6N/cdZ9B85OcWMSiw5gN0PIG9dxAPX5sK2QRp7tCBwJXWmA/Nxvf05ug3o3UzJZLJ32ODCf5y+T4jAB+EnrKrXtpGt4TadpbCF73TrIikuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710968; c=relaxed/simple;
	bh=6chJSECzyBok9hP+9kH8w9JfX3+F3jiudYuJ0Ny9Qek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PU+0n2D94clgb9vkGbip7gavPOv7HuqDqeP7zi6pZmhpfZ1uwe0MfDwDWm4K2/SaC+grc0yu0lWflg7BO07mtUiFNwxtz+FWH8bz2zw0YYr+H5jtCsNCxpDN8oMfP9jHt1WDLQkQDESWqOP0cViJ46QOnxJE0JStUEuFW77Ry3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IPuPXHmy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VDe2d5019083;
	Wed, 31 Jan 2024 14:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NURNavrQCbE1M4DE6lDNv9GMg0m1c/OPkCD3hDPJjKI=;
 b=IPuPXHmy2fWaXEk2FX2iBAM4ocaRnFE0bkd4Nal4ZznVgYNQQlcpj5Achynw9Qpg1eER
 6ExuUFv35kRum16fH10BExWjOCDlhNLGLpON5IIdjlSEMbZk8rdf/0CFg4iO1rXp18xE
 1p7jsIQRaZEseBh06G8zkWf+KD6s5X+Mp+lqc+g7tT3Ah1+7UDXZBD4+GprNt7OOmck5
 o74fxGgzUFII6ZyuBZMbvNsAzoOTTneO33Ov193AzO8afTPBewY+5HxuKYZPBb+NCckt
 GEvNYApg4JbX1aIGbb2HzWNmVi461ZFNK3uoDd5+ZGB+YGQ6JHJAeLeNa305rMZLuoN5 wA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyq9jsa4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:22:35 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VDnxkn011863;
	Wed, 31 Jan 2024 14:22:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyq9js9rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:22:34 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40VBAvxl002199;
	Wed, 31 Jan 2024 14:22:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwc5te4sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:22:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40VEM38J66584886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 14:22:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53C2F20043;
	Wed, 31 Jan 2024 14:22:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05D5E20040;
	Wed, 31 Jan 2024 14:22:03 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 31 Jan 2024 14:22:02 +0000 (GMT)
Date: Wed, 31 Jan 2024 15:22:01 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kees Cook <keescook@chromium.org>, Sven Schnelle <svens@linux.ibm.com>
Cc: linux-hardening@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Philipp Rudo <prudo@redhat.com>,
        Baoquan He <bhe@redhat.com>, Tao Liu <ltao@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/82] s390/kexec_file: Refactor intentional wrap-around
 calculation
Message-ID: <ZbpXieRZz3BQ6jBH@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-30-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-30-keescook@chromium.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XKrjlcZMqfTd1Gq83J4rhjVO3nie3sDL
X-Proofpoint-ORIG-GUID: bEVkfbCxjQ-zHyL5jTJ7NNsbOLh1Xldw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401310110

On Mon, Jan 22, 2024 at 04:27:05PM -0800, Kees Cook wrote:

Hi Kees,

..
>  arch/s390/include/asm/stacktrace.h    | 6 ++++--
>  arch/s390/kernel/machine_kexec_file.c | 5 +++--

Subject does not match. These need to be two separate commits.

>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
> index 31ec4f545e03..3ce08d32a8ad 100644
> --- a/arch/s390/include/asm/stacktrace.h
> +++ b/arch/s390/include/asm/stacktrace.h
> @@ -34,11 +34,13 @@ int get_stack_info(unsigned long sp, struct task_struct *task,
>  static inline bool on_stack(struct stack_info *info,
>  			    unsigned long addr, size_t len)
>  {
> +	unsigned long sum;
> +
>  	if (info->type == STACK_TYPE_UNKNOWN)
>  		return false;
> -	if (addr + len < addr)
> +	if (check_add_overflow(addr, len, &sum))

Why not add_would_overflow()?

>  		return false;
> -	return addr >= info->begin && addr + len <= info->end;
> +	return addr >= info->begin && sum <= info->end;
>  }
>  
>  /*
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 8d207b82d9fe..e5e925423061 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -238,6 +238,7 @@ void *kexec_file_add_components(struct kimage *image,
>  	unsigned long max_command_line_size = LEGACY_COMMAND_LINE_SIZE;
>  	struct s390_load_data data = {0};
>  	unsigned long minsize;
> +	unsigned long sum;

Please, use min_kernel_buf_len instead of sum.

@Sven, could you please correct me if (minsize + max_command_line_size)
means something else.

>  	int ret;
>  
>  	data.report = ipl_report_init(&ipl_block);
> @@ -256,10 +257,10 @@ void *kexec_file_add_components(struct kimage *image,
>  	if (data.parm->max_command_line_size)
>  		max_command_line_size = data.parm->max_command_line_size;
>  
> -	if (minsize + max_command_line_size < minsize)
> +	if (check_add_overflow(minsize, max_command_line_size, &sum))
>  		goto out;
>  
> -	if (image->kernel_buf_len < minsize + max_command_line_size)
> +	if (image->kernel_buf_len < sum)
>  		goto out;
>  
>  	if (image->cmdline_buf_len >= max_command_line_size)

Thanks!

