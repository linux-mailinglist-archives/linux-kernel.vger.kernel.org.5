Return-Path: <linux-kernel+bounces-4584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B79817FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80C82854A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD29468F;
	Tue, 19 Dec 2023 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YvpUkopQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325F17F7;
	Tue, 19 Dec 2023 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0IuIi024926;
	Tue, 19 Dec 2023 02:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=VBi4CX7JSD+IbYztt/gl7jPd41RMH3AJ88KC8ULNVRg=;
 b=YvpUkopQpRyXaLDixPR2Fl6laXclfji0yWdD333zTVXnAN98qURe7Cxju7vX4XC8cLjA
 w1Q4P6rc8q8ptju8Pdy84flT0ffZ6t9ASdmwPfLeOFezuP1SJMVEdOreis0kZwotmB6k
 C6Gmc8tiVQ9atzrr0yGk8qysDDC682K1Uzod5KAXMZz6hvPoRpy0QH6iu+gbKjPgkihp
 7CBfuW9a1SvuNhIqK/qs53OrSRE4xPWbp6pgLl3RE3oRUqhOt2y05xWZZwEP3p9x61Bx
 Idkn6TYeqt/2oqSTwyCEA/Xz6Ota8DNF/vrZDD6dCTD7X+QUS9T6P/QkBQB+8NiEAAzQ Xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p44un3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ06vpr020925;
	Tue, 19 Dec 2023 02:19:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b69t50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:07 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJ2J7Z3012682;
	Tue, 19 Dec 2023 02:19:07 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b69t3t-1;
	Tue, 19 Dec 2023 02:19:06 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Chandrakanth patil <chandrakanth.patil@broadcom.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ranjan Kumar <ranjan.kumar@broadcom.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpi3mr: fix printk() format strings
Date: Mon, 18 Dec 2023 21:18:45 -0500
Message-ID: <170294822162.2675590.18169081255954498195.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231207142813.935717-1-arnd@kernel.org>
References: <20231207142813.935717-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_15,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=996 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190017
X-Proofpoint-GUID: edWrbASjnAZiOoMb-SnwSD77lGHArauP
X-Proofpoint-ORIG-GUID: edWrbASjnAZiOoMb-SnwSD77lGHArauP

On Thu, 07 Dec 2023 15:28:06 +0100, Arnd Bergmann wrote:

> The newly introduced error messages get multiple format strings wrong: size_t must
> be printed using the %z modifier rather than %l and dma_addr_t must be printed
> by reference using the special %pad pointer type:
> 
> drivers/scsi/mpi3mr/mpi3mr_app.c: In function 'mpi3mr_build_nvme_prp':
> include/linux/kern_levels.h:5:25: error: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t' {aka 'unsigned int'} [-Werror=format=]
> drivers/scsi/mpi3mr/mpi3mr_app.c:949:25: note: in expansion of macro 'dprint_bsg_err'
>   949 |                         dprint_bsg_err(mrioc,
>       |                         ^~~~~~~~~~~~~~
> include/linux/kern_levels.h:5:25: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
> drivers/scsi/mpi3mr/mpi3mr_app.c:1112:41: note: in expansion of macro 'dprint_bsg_err'
>  1112 |                                         dprint_bsg_err(mrioc,
>       |                                         ^~~~~~~~~~~~~~
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] mpi3mr: fix printk() format strings
      https://git.kernel.org/mkp/scsi/c/fc1fbd13a205

-- 
Martin K. Petersen	Oracle Linux Engineering

