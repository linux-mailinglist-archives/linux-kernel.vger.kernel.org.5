Return-Path: <linux-kernel+bounces-159854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26728B3527
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A561F21D93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77951448FB;
	Fri, 26 Apr 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="msW2IDHk"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D014430A;
	Fri, 26 Apr 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126567; cv=none; b=TNiYNnLtHOT0Um9idrCGQwDh2WPh+OBbzEcV5G0KSdMW5qre4aOXxQFTeQxXYAKjcSdgP/tLvw3+B+ZulLLBubQnYyrrx4vGgg4KqiopD6t2M+Fwn0XntboflBM/R4XFqa9yHHRcvKQeMhZ8qHGO4O8DyyifTQp0YOQQUpsCUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126567; c=relaxed/simple;
	bh=Aaok4akx8+JwelwN/ppsY7WbWfpSN8p1AaPa1nlurvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wy7hX/Is9hEnnXtk6hHBewqkAQWPc2qxlj5Ofi5j78a2PWD0haGXim6atmRsE5NSzUM8R5AwVmGne21imm6mexOfRQDJCGYqm51ftYNom4Cj8+9PnDzcTvqkcLGPtZsq2IVIcQrvzENNDEHtBtOkD/eVEMo6qSU9EA0WxbWhslE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=msW2IDHk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QA3CRq012436;
	Fri, 26 Apr 2024 10:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Aaok4akx8+JwelwN/ppsY7WbWfpSN8p1AaPa1nlurvo=;
 b=msW2IDHklridPA49V4Yn6HHDnEqXh+aKAz0bWIaNe0idSkv7PvIbkpYeYc9esxhPabzW
 4X4CMusBRpMEzG4/LmnYXrL8IcwCVKFzFskC5zzdH2qnizCHK2kPsASdowEkMCp76sba
 BPKCL33+JNzpY4IS+CeFNJIpUjIsTAqpHs0bdkzjH+Lu9h7Gyv7Ldlr26w8/ipvnUjha
 VbM2+zZdSp6jDJZiWyk0gzAIth9gkvj65KKHMrf/h6nXkToaBxgJhQtK/N/8afpfZbY1
 N39Pacl5FM+QS2nAxapGZLI981J2wF2FwIZVAOfPxb41EJjC5iqsoWHhwM2T6AGDOpS/ vA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xra62g0uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 10:15:48 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QAFllU030841;
	Fri, 26 Apr 2024 10:15:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xra62g0uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 10:15:47 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8N5Sn021021;
	Fri, 26 Apr 2024 10:10:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmre0f8u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 10:10:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43QAAeZn30540508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 10:10:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8446420063;
	Fri, 26 Apr 2024 10:10:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3285C2004D;
	Fri, 26 Apr 2024 10:10:37 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.4.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 26 Apr 2024 10:10:37 +0000 (GMT)
Date: Fri, 26 Apr 2024 12:10:35 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
        Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Fabian Frederick <fabf@skynet.be>,
        Saurav Kashyap <skashyap@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali <nilesh.javali@cavium.com>,
        Arun Easi <arun.easi@cavium.com>,
        Manish Rangankar <manish.rangankar@cavium.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Saurav Kashyap <saurav.kashyap@cavium.com>, linux-s390@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 5/6] cio: ensure the copied buf is NUL terminated
Message-ID: <Zit9myOJp0SYFL1F@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240424-fix-oob-read-v2-0-f1f1b53a10f4@gmail.com>
 <20240424-fix-oob-read-v2-5-f1f1b53a10f4@gmail.com>
 <ZikiZsSTGUUM69GE@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZikiZsSTGUUM69GE@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nwzmHa-XFUQKTaw4oYDH1K-dtAII8FVL
X-Proofpoint-GUID: fy_d-znjR1XF0iGIbw_36HPeZjIuI1Lh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_09,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=721 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404260067

On Wed, Apr 24, 2024 at 05:16:56PM +0200, Alexander Gordeev wrote:
> Applied, thanks!

Hi Jakub,

I just want to make sure you do not have plans to pull this patch
via the net tree, right? (I schedulled it for the s390 tree already).

Thanks!

