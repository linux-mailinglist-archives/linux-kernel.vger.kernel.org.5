Return-Path: <linux-kernel+bounces-13179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0198200C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A083AB21CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53912B88;
	Fri, 29 Dec 2023 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JL459liT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485F12E43;
	Fri, 29 Dec 2023 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTHGLij012282;
	Fri, 29 Dec 2023 17:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=fwcdkaCUij5yMQvB9IpDdOOAZerCcpSDL4LNJpoz8vc=;
 b=JL459liTqPfTX2+BsfTjJO6EhVNcplMwS4nAYAo5aWosnUY8KVUUEahd74dvZhEpGtX7
 EGc4R7GHt7loHpCacTgznhpslV8bUryCHe90nRkAwMhdsluxvYG0iU3+S+U0aSXUmj2Q
 V/7cO3aWpsgjkGzdkoytWVqLmwk/g298pDhRsc4iWpwsgHAwjjv2aHi0+LDoF3kE3T1D
 2izOwtD2usKjjO3JKpUv5ksLpuCZSd2rwSIIEGHqr44hY5mMr5Fha4PYDxGDNHmDgMTo
 uKbtWDlaA79lzVSqH9nJsffsX9EY6MJNzNUApbGFyYtUdn5ZELaN4P56IOlFAyplCos1 nA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v9xdy4tmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 17:22:03 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BTHGQjq012612;
	Fri, 29 Dec 2023 17:22:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v9xdy4tmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 17:22:02 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTETeFN029970;
	Fri, 29 Dec 2023 17:22:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v6avnxn2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 17:22:01 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BTHM0nk5767882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 17:22:01 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAFE358062;
	Fri, 29 Dec 2023 17:22:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8B4F58058;
	Fri, 29 Dec 2023 17:21:59 +0000 (GMT)
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [9.67.64.147])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Dec 2023 17:21:59 +0000 (GMT)
Message-ID: <9d24844f30604f969ac10da456801f594ce72f2d.camel@linux.ibm.com>
Subject: Re: [PATCH] scsi: ses: Move a label in ses_enclosure_data_process()
From: James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To: Markus Elfring <Markus.Elfring@web.de>, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "Martin K. Petersen"
	 <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Fri, 29 Dec 2023 12:21:58 -0500
In-Reply-To: <4616e325-e313-4078-9788-dd1e6e51b9e0@web.de>
References: <4616e325-e313-4078-9788-dd1e6e51b9e0@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qZE7s0ChTjg8c_yyLibzyuaPHFU-U6gz
X-Proofpoint-GUID: j4x9ZtC_ak1gzxcY0GC3qeWNBneBWEmw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_07,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=681 priorityscore=1501 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312290138

On Thu, 2023-12-28 at 15:48 +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 28 Dec 2023 15:38:09 +0100
> 
> The kfree() function was called in up to three cases by
> the ses_enclosure_data_process() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.

Why is this an issue?  The whole point of having kfree(NULL) be a nop
is so we don't have to special case the free path.  The reason we do
that is because multiple special case paths through code leads to more
complex control flows and more potential bugs.  If coccinelle suddenly
thinks this is a problem, it's coccinelle that needs fixing.

James


