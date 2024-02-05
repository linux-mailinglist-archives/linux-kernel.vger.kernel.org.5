Return-Path: <linux-kernel+bounces-53023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248BC849F99
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888901F21B70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705BC3FB14;
	Mon,  5 Feb 2024 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tXR99Tx4"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296740BF2;
	Mon,  5 Feb 2024 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150942; cv=none; b=qr5eowrk8NCM06ETNFPs6g9yu1h18uW+wKuvF4dwTtEpxqOViQyGK/dQO9bgqM+TU9PWRAAj50jDVwHmbhGHOkU2nxhxC3x8Mrm00tCdIxztLjgWf42a2n5+xlVIwao1ZKhLogwMCHnYAytyu4GaArEqdm8TQBnOqFLd+u2s+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150942; c=relaxed/simple;
	bh=/2YAkUmHgfDKjyLUDxxGE8WawoMxCtjOugVqT/qykSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPBABQCpc5QbVJWi9J4nJSm5EsOc8CcC+KDrVaOL5Lc8fnY2LzZf5lYtbTnqRC9ifpXiODbtWtoiGOTOIJp3EXtKaKNF9gPvYSU3zu3UfRnYG8qR/N3F7BP0y8ebO+ShRSue/NkGPcjiJPwFHYj54tNW02gQJ4O//I+tXCXUq9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tXR99Tx4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415GWJ4l027671;
	Mon, 5 Feb 2024 16:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=c2p1od8VLdt6z8fIaoW+lmvPl04eZderS4e5z4TqdwY=;
 b=tXR99Tx4IUzGx4VzJ73/8xA62YQOwQF27N/0y55YOkICLS5vCVPo8MWoketPANafWzvr
 E+CwkYk/ouwJeTXp2XsTCBbzz84uerLKONmfgAy9cMCYeYsAiRgWZvF3hTfSxkovm45S
 w35Nb0V07kGfQeYOfGVphFoFGF1OvjP5tiHUjdsL7RlFkqC0m8ugnaBEo/X6XiOS0zj4
 vGmOU6RwurkFjvnlQ/44zdiS/Ws6O3Sc9kmRYMLiEYpoHM6LiHWLRpWI2kId66DKbjWQ
 qh+c0rhp9qRszGGKOuGhk5Iodn3gx8k4P1su8r4Eh2hL+SHx8bEJnv4/BaH18xmyGmY3 MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w339gg4g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 16:35:36 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415GX6u6030887;
	Mon, 5 Feb 2024 16:35:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w339gg4fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 16:35:36 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415G7tU4008758;
	Mon, 5 Feb 2024 16:35:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206y9s4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 16:35:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415GZVFH21037588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 16:35:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 829012004D;
	Mon,  5 Feb 2024 16:35:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3106720043;
	Mon,  5 Feb 2024 16:35:31 +0000 (GMT)
Received: from osiris (unknown [9.179.22.231])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Feb 2024 16:35:31 +0000 (GMT)
Date: Mon, 5 Feb 2024 17:35:29 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390/fpu: make use of __uninitialized macro
Message-ID: <20240205163529.8558-A-hca@linux.ibm.com>
References: <20240205154844.3757121-1-hca@linux.ibm.com>
 <20240205154844.3757121-3-hca@linux.ibm.com>
 <202402050822.E6E6E978@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402050822.E6E6E978@keescook>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lve5dl8hQAIf9s1m1KcmDn2Cwoucg-3m
X-Proofpoint-ORIG-GUID: Xu9yQJQcua6CM73KmegT_NadfuWKKCWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=582 clxscore=1015 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050126

On Mon, Feb 05, 2024 at 08:26:32AM -0800, Kees Cook wrote:
> > +#define DECLARE_KERNEL_FPU_ONSTACK(name)	\
> > +	struct kernel_fpu name __uninitialized
> 
> Are there cases when struct kernel_fpu should be initialized? e.g.
> should the attribute just be added to the struct definition instead of
> marking each use?

I tried that, but failed:

/arch/s390/include/asm/fpu/types.h:36:3: warning: '__uninitialized__' attribute only applies to local variables [-Wignored-attributes]
   36 | } __uninitialized;
      |   ^
/include/linux/compiler_attributes.h:343:42: note: expanded from macro '__uninitialized'
  343 | # define __uninitialized                __attribute__((__uninitialized__))
      |                                                        ^

That's why I came up with this macro. I'd prefer to have this added only to
the struct definition, but looks like this is not possible (or I just can't
figure out who to do that).

