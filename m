Return-Path: <linux-kernel+bounces-54181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E0184ABFD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D941287B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572FB56B88;
	Tue,  6 Feb 2024 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DJNMZTOj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D95677B;
	Tue,  6 Feb 2024 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185355; cv=none; b=QgiIhhSjJ1b5pdxM5MG2w0WeHDnW4Bc5yDv1K0LzGOdeEGvej+4l2mDQuUN2ptHA0ci8pace0/udXkQZRkgobwP4DKxmyNMh8gUNT05qvn4HSl160ieFQN9/R3GT9sSo7qSuVhb/moLUy3Gl+jZAja2SWtRD3pPwKiEzLnzR128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185355; c=relaxed/simple;
	bh=GIY2oK/tga9KjZ/HpYk+cW7YAmDfpfGCvRvywffo7Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xt4//qYckOW+GmQJjkrisCb3ajM+/fqlgL65xzunYh3mraX/+P+3AuozqP0tPILnHqlmOGKmOqV90UaQ+jUmBymbziawXQnz7FuMOucW4GkSC2K3DclueuP/Jx88uyDPZIby2zHVaH4KQVuJ6i9VdwZf5ASEOsU3PAj4jFy+i20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DJNMZTOj; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4161ESxo031611;
	Tue, 6 Feb 2024 02:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=bX86qBrs9kTRXVBpxg7OLAaegBU3rp3Ua/YxvDnw8ik=;
 b=DJNMZTOjLyp/N3lt+geBO1MDTajm9smZLZUcysbJ7Wg5rnVwXG9ihbO7WEZrwdSq/yz/
 Sqql6Dft0jIQYwyKfx1sxilrtRj8sXoTbEnNHyfoFo7LJp0dfH1h+1F0YfHDXZXlBLuA
 PLQF5dIaGiIKzssP7UPbez7wyu7QxBPIvNbyDdFb56ncE1XYzzQhXKQ3Dsr2LPbcsbhC
 LKltsp8nJyMXEDNBIqhaybfB2jKRwS3PbG8Dros2tRILxGQF2c98j4HuGG292F6m8Pfy
 bWba/6K/z6si873JQyc4lU0OLFw1POtLnFctYE+UvkRXEYu3gSsMQVMCHs3Ye5pyRgOs nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbdf57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:09:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4160L5Rg039556;
	Tue, 6 Feb 2024 02:09:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6cegb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:09:09 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 416297CK038970;
	Tue, 6 Feb 2024 02:09:08 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w1bx6cef6-2;
	Tue, 06 Feb 2024 02:09:08 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-scsi@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] scsi: lpfc: use unsigned type for num_sge
Date: Mon,  5 Feb 2024 21:08:56 -0500
Message-ID: <170718504172.1101069.7792604294877571964.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231220162658.12392-1-dwagner@suse.de>
References: <20231220162658.12392-1-dwagner@suse.de>
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
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=552 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402060014
X-Proofpoint-GUID: xrLYDTklL4-zQoXe_zwdiC148QsotFOA
X-Proofpoint-ORIG-GUID: xrLYDTklL4-zQoXe_zwdiC148QsotFOA

On Wed, 20 Dec 2023 17:26:58 +0100, Daniel Wagner wrote:

> LUNs going into “failed ready running” state observed on >1T and on
> even numbers of size (2T, 4T, 6T, 8T and 10T). The issue occurs when
> DIF is enabled at the host.
> 
> The kernel logs:
> 
>   Cannot setup S/G List for HBAIO segs 1/1 SGL 512 SCSI 256: 3 0
> 
> [...]

Applied to 6.8/scsi-fixes, thanks!

[1/1] scsi: lpfc: use unsigned type for num_sge
      https://git.kernel.org/mkp/scsi/c/d6c1b19153f9

-- 
Martin K. Petersen	Oracle Linux Engineering

