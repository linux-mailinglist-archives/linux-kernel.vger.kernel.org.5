Return-Path: <linux-kernel+bounces-56604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B38DD84CC72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6DB1F24A8D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2067A72F;
	Wed,  7 Feb 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ONDApOWB"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152076911;
	Wed,  7 Feb 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315313; cv=none; b=ssEleauHaoFPOx/CSaUtcuKU153pix9uQ2B1GLOeIsQZgcm5AL8+tQ6KArfFwLqJHgz0HtLhH+u8xyHXcYWXANzcuVVAjqtyYzxUSc4qsSfae2DNsCrTnex3GN8NapbkcM8wHePwZn/yBNCHH2cDZZ2VhWnVfPQGHDOi56IrxIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315313; c=relaxed/simple;
	bh=rcFES4rU82Y628BCfdg8FB0Fv2CEpDLuZf6D3HeDmWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1ymbk9CegQ8XPI8kHUQyAWWjZu6wopzlsbX/QptkfXxuAryVHi8HNyCNyVAbZ92DHq5ASaVsTDQ2eOrkQTyZgQ734GR/sFtC/6I6vhhEOCTtJTb0z9vCCNfrtjNXxhUj2jsXMlSjWY2Jx8xkrUM9dzUwc41zFQIDUE9fQTgWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ONDApOWB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417DRK4i024733;
	Wed, 7 Feb 2024 14:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=M7VY3bsanvzSPuzOMowwnwqXYsUsv2q9/y/knc+OF04=;
 b=ONDApOWB+CkBmtwnnrXx6SkUxdZPi/jvq2kA4RgwXzzT59PZgrgSpWUSf3T7AgIbaLnV
 dKeUqduQCegSZZhMIOTmY5lxo34H5DkQG+Ichg2wDidWhzh2HcZzzKnm8y4q9VflI0kL
 qfSyhhUiYGTFh4q0gQ1gcEK3cRLp46W1weVLRbTm9eEVdv1nx41qHuQUNNmeDziO82YF
 zFv1ELWokMX1r5pshDTNYMgDGqxj7gTrZTelM9Q7Rv4SPQX2H9NtBJ1Yw05atCuyYxch
 YIH4+aKK8PDx//ui2NUPtpS3LMUy+dkJHG6kQsCK2LS8r3cJnlqRT9t2q6KWzLuDXSon kw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4arnsgfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 14:15:03 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 417D19rM020234;
	Wed, 7 Feb 2024 14:15:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytt6d07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 14:15:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 417EF0io11666036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Feb 2024 14:15:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FD5C2004E;
	Wed,  7 Feb 2024 14:15:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D041A2004B;
	Wed,  7 Feb 2024 14:14:59 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Feb 2024 14:14:59 +0000 (GMT)
Date: Wed, 7 Feb 2024 15:14:58 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/5] s390/irq,nmi: do not include <linux/vtime.h> header
Message-ID: <ZcOQYn7G+lE7sR9W@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
 <966148629217b56139f40c38ffbb45ca229bd489.1706470223.git.agordeev@linux.ibm.com>
 <20240129095144.6722-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129095144.6722-A-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wQvamkGva6TInDfEiSrAYE_sclmi_aAF
X-Proofpoint-GUID: wQvamkGva6TInDfEiSrAYE_sclmi_aAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 adultscore=0 mlxlogscore=188
 spamscore=1 malwarescore=0 clxscore=1015 mlxscore=1 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070106

On Mon, Jan 29, 2024 at 10:51:44AM +0100, Heiko Carstens wrote:
> It is confusing when the patch subject is "do not include.." and all
> what this patch is doing is to add two includes. I see what this is
> doing: getting rid of the implicit include of asm/vtime.h most likely
> via linux/hardirq.h, but that's not very obvious.
> 
> Anyway:
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Thank you, Heiko!

Whether this wording sounds better?

s390/irq,nmi: include <asm/vtime.h> header directly                         

update_timer_sys() and update_timer_mcck() are inlines used for             
CPU time accounting from the interrupt and machine-check handlers.          
These routines are specific to s390 architecture, but included              
via <linux/vtime.h> header implicitly. Avoid the extra loop and             
include <asm/vtime.h> header directly.                                      

