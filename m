Return-Path: <linux-kernel+bounces-52991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB03849F3D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65456283A30
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB7E33CCC;
	Mon,  5 Feb 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NF3suySk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD532C91;
	Mon,  5 Feb 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149104; cv=none; b=r5550po5ee4WPvBu6WRYriqdZiMbKxB2g1OccKRecStoDT+g/6nE+NJzWXgqsRPRvQUmKzvEs3HWhlDnRpWQwSMt/AnQlt9rT+6N1nkoL6Ek4bYGUOy6ILfuUGyF5WPZwKJUxBB4wIvjyXCGeFD9P1uO6I3RsCyMn07w3spGuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149104; c=relaxed/simple;
	bh=lXKYpTmLgw1j4/d7GG6QE+sU+7ac5YLlDTZEayRbTUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKAO4oGUlwCucEu98oTy6xgYR6HQgCNUZqHwm3/kxGaMNXmMwIgLbslntlV/9lCKgbuo/VwZVe3mV1zyUEAP3JZ9jhGD+M8oWvrOPIPHkoiKRhFskto1yL5UhkMavbsBadqPeusTOSakpBrg5VooDDjopqbq8T5veMuI+MzhaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NF3suySk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415FvDcC021156;
	Mon, 5 Feb 2024 16:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=pG8rij9LxfwOI9nuObj/Zow5GL3EBeLTwBmCRKr65Zs=;
 b=NF3suySklPjAoPPHYcDVr7iRUxTAtG1uVOaRs1e9obGV0yMl9+xin/Y/Lm5CmC20Nfok
 KK0aO+bK3fpCcPZdTeT6ArnGNzyPCWW2RYqCMZuVL2XvNmF1GImDRoDQJKYeOd6lRLVd
 0VuhXBb9/UtdPjHWZh45Cs8SPRV1Qt7km+/XHM20EN/TnOwSSA8O0l8fLYAXm4ET1hdv
 NBxia0KRdQ4AN7mJUbELgRnSzjcOaQu881Gg5xZeU0zfDbUag5roEoYkW6/kuGdNgLlY
 qN/UBsR+VAPMrthZsRHZeT3t2/EbjQPOhS1c8tA1f6UjofHnJORL1unQFkyza3JNpSXH Zw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w32s107ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 16:04:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415FU9Lu016184;
	Mon, 5 Feb 2024 16:02:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h1ry6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 16:02:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415G2WlY45482532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 16:02:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 058C32004D;
	Mon,  5 Feb 2024 16:02:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3057820043;
	Mon,  5 Feb 2024 16:02:31 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.87.217])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  5 Feb 2024 16:02:31 +0000 (GMT)
Date: Mon, 5 Feb 2024 17:02:29 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Tony
 Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 6/6] s390: vfio-ap: make matrix_bus const
Message-ID: <20240205170229.44871ec7.pasic@linux.ibm.com>
In-Reply-To: <20240203-bus_cleanup-s390-v1-6-ac891afc7282@marliere.net>
References: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
	<20240203-bus_cleanup-s390-v1-6-ac891afc7282@marliere.net>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XsotM_IhRkLdQwHgXc0_CguzKQy-sX08
X-Proofpoint-ORIG-GUID: XsotM_IhRkLdQwHgXc0_CguzKQy-sX08
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=751 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402050122

On Sat, 03 Feb 2024 11:58:03 -0300
"Ricardo B. Marliere" <ricardo@marliere.net> wrote:

> Now that the driver core can properly handle constant struct bus_type,
> move the matrix_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Acked-by: Halil Pasic <pasic@linux.ibm.com>

