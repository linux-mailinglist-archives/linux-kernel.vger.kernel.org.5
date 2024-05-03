Return-Path: <linux-kernel+bounces-167368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006C68BA87F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BFB5B23536
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4619F14B075;
	Fri,  3 May 2024 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y0kp2JTU"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1467152DEF;
	Fri,  3 May 2024 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723973; cv=none; b=d+RfczYqARF8OqDKrzIstooxmMX7fViqc3Oqo3EDePrMiuHllGU7p65OspRZ/2nvCG0/jMepM8A1O7lmgxT1xNF8r0JMtJ+CebizOxGzBQ+F9vHub58yHhPxhGJKWlGc6sxWZkNXX1mn1ycNVk/lUhH24cB05AZQDhe3pwxV6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723973; c=relaxed/simple;
	bh=QZm50LfxX74Q0RCzgp1rmJwHhtcbEzxrqdeqXqB9UBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNWgAGLXxk+jtQnK+3etrBOQUgE62pqVJtZSQko6YQFrMTokhTUdEZbLTvBpw0jqZ3hIC5TDD/t8GpSf07RHFsB0/Ea0OfsrpC4G8BILQxH+YJ6WaVhK9dSDPLhOkG9hIKbfjaUjtHpgcg1nwILtvZ5mukbGeXHPHFmyMDKPXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y0kp2JTU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44388Pj0027155;
	Fri, 3 May 2024 08:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=xouXEvtuJF9d2JJUX/Hzu3OmM1cwaprRf4hmkOr75E4=;
 b=Y0kp2JTUM8R4AxTCtApwSt3sRNIzOJ8IfV5Nw7FCdL7swXyZ9NC082y8eUbp9wFCtbLE
 t8iXmXVzgGXm3he1rBaYW9Sgyc1YUCCe7IuPQXEqggCiLpTEenNNzdbDXi1P0vyZpY8L
 sbfydf41SgRXewsg165hyX4WTp0cy5W190Fgyf72yqN9SYascZd8qKEavFltqIkuhmJW
 aJeCni6sMCa6Bjn1F+F3evH7sfzFeVLhmbpeFKMPcwdeBO3s8t3qaHwL1cXeBvodP1/q
 QHoz9uNh87TuTb+cI+uL3Pb6eaygG1BtEBntgpUV9wyGpwCk9CwZLFjH9+ZBW2D2UR82 Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvv51r0dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 08:12:49 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4438CnHc032402;
	Fri, 3 May 2024 08:12:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvv51r0de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 08:12:49 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4434aiWf015530;
	Fri, 3 May 2024 08:12:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsed3c5h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 08:12:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4438Ch9W54329840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 May 2024 08:12:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D1EE20043;
	Fri,  3 May 2024 08:12:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1AAD20040;
	Fri,  3 May 2024 08:12:42 +0000 (GMT)
Received: from osiris (unknown [9.171.17.237])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 May 2024 08:12:42 +0000 (GMT)
Date: Fri, 3 May 2024 10:12:41 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v2] s390: Remove comment about TIF_FPU
Message-ID: <20240503081241.9139-D-hca@linux.ibm.com>
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
X-Proofpoint-GUID: zJw3EaDEMGZjUQgAQO67RWUd_wLI3s-s
X-Proofpoint-ORIG-GUID: paS8_DM4l8CQbu70yDNv-oggZNOjwccS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_04,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=457 lowpriorityscore=0 impostorscore=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030058

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

Acked-by: Heiko Carstens <hca@linux.ibm.com>

