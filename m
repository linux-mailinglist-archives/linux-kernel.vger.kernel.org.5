Return-Path: <linux-kernel+bounces-167413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC08BA937
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83C81F22D69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFB75914D;
	Fri,  3 May 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KQZv1N6i"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591979CD;
	Fri,  3 May 2024 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726112; cv=none; b=KPaOl90VvbvIINo+U9G3iaMJBhA8eyafV1sQYwL/E/bS/QOy39klPHGthexC1wEIMjJlh9iNlUaZOcMMn9RepvxFAkya4ueTX1ejerjo3uVvTxraU1TnRLR6VgcxxBtwXkwoWrDzHMbvkbXLmG0b9k2CfkC39qQjUBK3HFUiV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726112; c=relaxed/simple;
	bh=4LAK9etsRaOQZ6Axh1wlzY3z93PBUnIV4rktOBkXROg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjmL9IEZC1rZqdJ7KZWK62e2gGTkoKpfLdYYxJKPO6UMFdMolRaMS/jOMezqT6c6JMaEKViM2zAaFuWgpwWaxNBxxY8LagYMuDEzzbVZbzCrpMdroPBeizngKmMGSqG/J4KW/XX8puPd/MFGZnY8QyIwWRctcCSTMO3XA7meT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KQZv1N6i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4438jcMi004089;
	Fri, 3 May 2024 08:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=bXFb74UHnqadsLdb0RbUOARUSWrSSEa7RZIBYJ2ApO0=;
 b=KQZv1N6igTzVOXlu+fPckpGSkDaGUDXRXtgoYQw48gP+gfUaKl9MT5yV2n6bdGcgO0zy
 oBBRHBtSbs5/ZqYNa1b2ZJWz24TXWHtQJYfDJqu3hIwwGTEymb4hducuasbCh561tEoE
 4BCRsdjEU6/r0mWQ5ZlG0/Ts/dudMG5IRq109QHumJ61T3h/6EhfO3qOLLbd+Mh00qoB
 ayF0byzT55SThP9NPAD7WxKZmUSQGJeGoqOOblRXldrZ4LjNosqWxEGNtQErb/YAjlEx
 /dVI3/aV5xhj+z33auPCAURZiGGc6NTuZtQEZJBJP9fkT4pd8u8j9a7/eKQIHPN2OPzj 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvvgbr15p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 08:48:29 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4438mSQv010418;
	Fri, 3 May 2024 08:48:28 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvvgbr152-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 08:48:28 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4435WPhe001509;
	Fri, 3 May 2024 08:21:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsbpucux0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 08:21:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4438L9ID17105312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 May 2024 08:21:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE71620040;
	Fri,  3 May 2024 08:21:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28C6D20043;
	Fri,  3 May 2024 08:21:09 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.68.221])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 May 2024 08:21:09 +0000 (GMT)
Date: Fri, 3 May 2024 10:21:07 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v2] s390: Remove comment about TIF_FPU
Message-ID: <ZjSecweC4gCRa80x@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240503080648.81461-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503080648.81461-1-thuth@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sPleoafmuW_otZpaQspvGUpoJAdV0bK-
X-Proofpoint-GUID: kd5mTUzxk5t5o-Y645cKcDvwLJ0aHOZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_05,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=514 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030063

On Fri, May 03, 2024 at 10:06:48AM +0200, Thomas Huth wrote:
> It has been removed in commit 2c6b96762fbd ("s390/fpu: remove TIF_FPU"),
> so we should not mention TIF_FPU in the comment here anymore. Since the
> remaining parts of the comment just document the obvious fact that
> save_user_fpu_regs() saves the FPU state, simply remove the comment now
> completely.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Drop the comment completely
> 
>  arch/s390/kernel/process.c | 5 -----
>  1 file changed, 5 deletions(-)

Applied, thanks!

