Return-Path: <linux-kernel+bounces-98358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B7487791F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C303E1F21704
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E883D57D;
	Sun, 10 Mar 2024 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nB/RdRDq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F5D3CF7D;
	Sun, 10 Mar 2024 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710111885; cv=none; b=i/Kk7Gxnj7G7+y+PV3LTf0YVCvtaxZPBp/gaY9ATSHukBy18EeCXoyTeaekbQrfRFiqHJbNcH+FUZlqQy9AaKGirEhbARvy8k86SATRzhJvA1CBVN3tvrwN8QCDhwg4fZARaq4BnnXL0untQvZAYcyXL0zK21pALMi5phPBHks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710111885; c=relaxed/simple;
	bh=MumzQ3IsWvimTKAo3jDk2dgNf1hA91GXx5qNhG6fKc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKX+FkbrKJbqk/77tvF3wMGFyJ3HQaOgk9ypOPS5NKMCvlKh/C3cHGibBrNT/E77yS358NOXl02j5VOOG/JoZtYqfLJYoeUbnEVzcNgjP0ovQ/pR0kNlCLw2B88E5NoSA4/bjd0oq9Gj2LJu5d/PPe3y7xCFiOIrGv5WRjM2/y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nB/RdRDq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42AL1Ppb030905;
	Sun, 10 Mar 2024 23:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=Am0zrIX5u09VdN+5NR+B1MgFOehy3Kyxjqn1fkhhUNY=;
 b=nB/RdRDqT8vG5mSIYl9qgGbxuiukKHhyu6JchchA9hy6LVG2tQJ7RXkEa25Rn1Zv1BV7
 7qeRkJBBhd1on/NqO8+AAF+FVBa2QFK6Z6gG1xg6A80YFYWBIue/by92RemSPkkeeI3F
 Clu6T3KifGxwfmjiDZqjhqkT8Q3RvMTbUI42pzvpV/elqXXt8YrXHPBwQzVsGoxzRNDZ
 Wym3UB9mhr8+PNStQyWrutnQgRsNnbSbuvsRXQH/oB641Qbroe4j+IGExZqIYH5okijY
 Kg6rXwifNRXcPyxBj+NWyOl/oCJt9GnZ3KfJQFpQoEwNqj6EmDc80vH9oj2iUFr6sJt1 8w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrgauhsh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 23:04:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42AJ4ntP004737;
	Sun, 10 Mar 2024 23:04:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre750nee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 23:04:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42AN4TSG006839;
	Sun, 10 Mar 2024 23:04:30 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wre750ndq-4;
	Sun, 10 Mar 2024 23:04:30 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] scsi: constify the struct device_type usage
Date: Sun, 10 Mar 2024 19:04:20 -0400
Message-ID: <171010474755.3838281.2449680609899297619.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240219-device_cleanup-scsi-v1-1-c5edf2afe178@marliere.net>
References: <20240219-device_cleanup-scsi-v1-1-c5edf2afe178@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403100187
X-Proofpoint-GUID: cefgvOFomSyys2DMh0mPnSly9OyQn3sR
X-Proofpoint-ORIG-GUID: cefgvOFomSyys2DMh0mPnSly9OyQn3sR

On Mon, 19 Feb 2024 08:45:53 -0300, Ricardo B. Marliere wrote:

> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> scsi_host_type, scsi_target_type and scsi_dev_type variables to be constant
> structures as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: constify the struct device_type usage
      https://git.kernel.org/mkp/scsi/c/517bcc2b4db4

-- 
Martin K. Petersen	Oracle Linux Engineering

