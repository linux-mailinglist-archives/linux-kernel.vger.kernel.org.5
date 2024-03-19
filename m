Return-Path: <linux-kernel+bounces-107450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF02C87FCB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9550C1F23595
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AEB7E77C;
	Tue, 19 Mar 2024 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c1cxIKWE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33B7E586;
	Tue, 19 Mar 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847096; cv=none; b=I9pSPcXoD90EBfupFaWNH7AB/SM5JMZqheb9kDEwBgQle2Y7434o0xcU+NVWmsaPl6fmErz/OHGRFcSUN3Ms3Xy4z+eFHcEfsUVgB0ekDWMzWfOrr1lpmVPMFmkhA3/rmb73uxDTGN5IKWZR6UzdfvLbPqDZ6ZszF8HiByv6cp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847096; c=relaxed/simple;
	bh=m+H0KA5nCWiconiv95w6H27brgFiAtSdm/hSpOIX4N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GelwYl9I0UYoMJj5Y1jIyD+cmFA+LR6wO5lHugIXY6SW1mhLuiiCLM/sJDdjzpLzThHL2IpJF5KBbusJEta47PZxU7Kb2RUw9gm7oF/9Nndyh0mQcKs4QRcIDvnO3hmZ+hLruptxRh/J5F9SoyPG8n0iXgr3iAg8vjRDdNN2QqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c1cxIKWE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAjvL2004341;
	Tue, 19 Mar 2024 11:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=Y+una7k+ujlpQWzyvteLpzJZsZGHX4ZCn548C358cCQ=;
 b=c1cxIKWE392Y/78ob+sDyvqhwjQXmW0Ycq8xGyfFhokhAFadiqTSyCyQLbX30CDxkWg1
 9vgzw3ocBUsdpyeu0LAdwFsL0Vx1B1MVGJ3R8QcxmDuqoVSMpQB9C0uLgt+gdchMowP0
 aevKHfYLVFeAYoL6/vKe9vAOWvK7xtuMw3Eb7Gdpy3fy2pSb2xbXHNuCj3+efCxJp6oz
 leMMwCVdPWUur16xh5vyJ3cx0IbqkYwYi6ExTakZrvDfaaxKoPSHk3rao4lJgQ8RXJrT
 eXlqI/FnzVnniFI5WQ+QmnNGMvR+fLhgaN0ldWs5efQIUvkiVk5lvpBNPqmxOJO3P+5J sw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy8nxgcn3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 11:18:10 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42J8RKZP011594;
	Tue, 19 Mar 2024 11:17:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8kxtrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 11:17:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JBGwBa44433860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 11:17:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63BE92004B;
	Tue, 19 Mar 2024 11:16:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7BC32004E;
	Tue, 19 Mar 2024 11:16:57 +0000 (GMT)
Received: from osiris (unknown [9.171.33.131])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 19 Mar 2024 11:16:57 +0000 (GMT)
Date: Tue, 19 Mar 2024 12:16:56 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/cio: Convert sprintf/snprintf to sysfs_emit
Message-ID: <20240319111656.23303-E-hca@linux.ibm.com>
References: <20240314095209.1325229-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314095209.1325229-1-lizhijian@fujitsu.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x1Zq21fjDM7KhpiRWE0TCuLRjVMWeHsC
X-Proofpoint-GUID: x1Zq21fjDM7KhpiRWE0TCuLRjVMWeHsC
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_01,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=820 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190086

On Thu, Mar 14, 2024 at 05:52:09PM +0800, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
> sprintf() will be converted as weel if they have.
> 
> Generally, this patch is generated by
> make coccicheck M=<path/to/file> MODE=patch \
> COCCI=scripts/coccinelle/api/device_attr_show.cocci
> 
> No functional change intended
> 
> CC: Vineeth Vijayan <vneethv@linux.ibm.com>
> CC: Peter Oberparleiter <oberpar@linux.ibm.com>
> CC: Heiko Carstens <hca@linux.ibm.com>
> CC: Vasily Gorbik <gor@linux.ibm.com>
> CC: Alexander Gordeev <agordeev@linux.ibm.com>
> CC: Christian Borntraeger <borntraeger@linux.ibm.com>
> CC: Sven Schnelle <svens@linux.ibm.com>
> CC: linux-s390@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
> Split them per subsystem so that the maintainer can review it easily
> [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> ---
>  drivers/s390/cio/css.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, but...

> @@ -396,7 +396,7 @@ static ssize_t pimpampom_show(struct device *dev,
>  	struct subchannel *sch = to_subchannel(dev);
>  	struct pmcw *pmcw = &sch->schib.pmcw;
>  
> -	return sprintf(buf, "%02x %02x %02x\n",
> +	return sysfs_emit(buf, "%02x %02x %02x\n",
>  		       pmcw->pim, pmcw->pam, pmcw->pom);

..please make sure to fix such whitespace / indentation errors if you
plan to provide more patches. I fixed it this time.

Thanks!

