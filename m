Return-Path: <linux-kernel+bounces-78676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F811861714
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67E428A21A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1773B84A24;
	Fri, 23 Feb 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G+MssmDS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F384047;
	Fri, 23 Feb 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704465; cv=none; b=JF+05oEHfnyL70d6loJrZ8r/6/JPbLq7VQN/NSn/qwUqc6c82esWP9yFvrta7IfqrIDPqr5etlnKdSWolZBujJOms2xgLOAjIXpiNTCN/AAU6s8/t35rj7uUewGYLTAmrTIYSLHC/wrlFP7S7Umhz4JGDjMV4tcZowPj+S8oeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704465; c=relaxed/simple;
	bh=x6MP3eJoAiWhUJ80Vtf6eZUTTsZqo5dnOoTbzEKncWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDoBCRGlC2UGkmUvUQAo9fN4GWHqFtzwwR/CxB99e33xyZrYiAiE/2VpOg+I2RfwoOCVrttQNG3uYG+vIBZZ/Vnp3Vq5ccEVUEC+Q04soOkKc1wswMpZ7jPK0/wALDDPBwZQnhEd2PAkX0RGqBAPvZRxqx7C5EMWCn9lYMgOZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G+MssmDS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NG2KHa025576;
	Fri, 23 Feb 2024 16:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=EA8REWowfVeSXktaGtFknZiGaShYWXiwehS7sDUZxp0=;
 b=G+MssmDSZbvsZi+eh7kA06M0RCww/g4lqKzx2KFX8ITZBeitYloiainkMJjX8ZUnqEWZ
 hF9UQhz6JezL+BZBbv6pUpQL3XauxXoAHwsjzEdwQv12h8sR/9c4/6Ms89HNqOtSNdCd
 k06SbX8pcUKjuErXqhTrQns1BEXId1pG8uqAY3b0jICVm3aFXRKcXmFKw5HPJc5KYpv5
 Giil35yMwvC4Guv0xnBT8g9GdPOcV4FhItYxI86Wda0faJYx7FnYaqWGRLcS15Tf7iJX
 GTLUhC7i9+cBvGKmIX3FTZctcWPjA9LhtOQGCX0ME90a+0rOV9UEBcfbkgfIijI/GgFQ CA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wexhdg58s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 16:07:42 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NG2sGD014339;
	Fri, 23 Feb 2024 16:07:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u35uuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 16:07:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NG7Ztk43712954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 16:07:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 817072004E;
	Fri, 23 Feb 2024 16:07:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1217C20040;
	Fri, 23 Feb 2024 16:07:35 +0000 (GMT)
Received: from osiris (unknown [9.171.74.183])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 Feb 2024 16:07:34 +0000 (GMT)
Date: Fri, 23 Feb 2024 17:07:33 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] s390 fixes for 6.8-rc6
Message-ID: <20240223160733.36568-B-hca@linux.ibm.com>
References: <20240223155220.36568-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223155220.36568-A-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jw1XqAXHwLemUbiuZtXj4RhrK8-3kLBb
X-Proofpoint-GUID: Jw1XqAXHwLemUbiuZtXj4RhrK8-3kLBb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=550
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402230117

On Fri, Feb 23, 2024 at 04:52:20PM +0100, Heiko Carstens wrote:
> Hi Linus,
> 
> please pull s390 fixes for 6.8-rc3.

.. still no time machine, so this should be for 6.8-rc6.

