Return-Path: <linux-kernel+bounces-157920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300028B1898
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19A41F24C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C9E10A14;
	Thu, 25 Apr 2024 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TjsG2mlk"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294D4C98;
	Thu, 25 Apr 2024 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010212; cv=none; b=fpSrtWD1c01FxQkfl1or2lqKARpmKswR19iNd+wP3BLOX4InSVN7CX9wQrszp4Wb7KRJUZM0Bm3xaaH5u3N33sm2TV3h9XjlOvv3HYwgzXjK5ljAXTTA2I+X++afWo3meS1XpHx5j/AJ/lG2EkP54uzAlS1n2v+gwEH3HiLOBls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010212; c=relaxed/simple;
	bh=gfjrH1KAbv5YA8upsZ5/LcGgVEyjGdRb3vo1aoU2LFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCi8T/AEYp/+RMAK5gaNjQ5xG94ebcfBz6QhggKde3RfK0uy4HqGOHUVdOJiWzCynrcV/wDLBKDI7M9sU1N9kez5G6FMqPrQE36ObR51biH7xy/WaTQ/41RJluHLrOSflLJ3rc0JXlRwrzPH4W4b5T3RjiLbrAcae32QRKoRbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TjsG2mlk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0igDa006857;
	Thu, 25 Apr 2024 01:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=wGaal8xBhqYtE5gK/UHf9Sy1XYTXTBV70bwcrv5U3DQ=;
 b=TjsG2mlkJh3040alBLHghAli1zlolbk1hbRIELc8vl/66dsReRxkVlm2NKO9iY1aGEFk
 9UKADMk3CToZyLQnPaDDr3ckPzRhQjW4LVb8VcXZ5kdoiPRQtCad0lo2NAvZq3RfGlj0
 glHg+hR9v9Er2fgRhNz7f6y5tjtAkhAoDTx+QwwlxufPXGyV1ytfvA4uZ78AbfNYbQ1Y
 VjJSStpo2/KTQR0d1el2QjkiUl/oqP6+PSxiZ/bSWMslqSLZjSw0uHs8Ukbdti7fkg/Z
 z61RyPyThbmnwZGctiVioOzH8c1bUuGkxF6ggSPl75ML4R1BEB/K/gOmld6zCgTS/a+k 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2j7x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:56:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43P1Ep8U001851;
	Thu, 25 Apr 2024 01:56:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45aa0qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:56:46 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43P1ukgd009697;
	Thu, 25 Apr 2024 01:56:46 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm45aa0q7-1;
	Thu, 25 Apr 2024 01:56:46 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: jejb@linux.ibm.com, John Garry <john.g.garry@oracle.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: sd: Only print updates to permanent stream count
Date: Wed, 24 Apr 2024 21:56:38 -0400
Message-ID: <171401015348.1237301.14105596479427335745.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412094407.496251-1-john.g.garry@oracle.com>
References: <20240412094407.496251-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_01,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=994 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250012
X-Proofpoint-GUID: f3oPvsK8nWYs3tsJ7Av6fVy2omKfis_8
X-Proofpoint-ORIG-GUID: f3oPvsK8nWYs3tsJ7Av6fVy2omKfis_8

On Fri, 12 Apr 2024 09:44:07 +0000, John Garry wrote:

> Just rescanning a partition causes a print similar to the following to
> appear:
> [    1.484964] sd 0:0:0:0: [sda] permanent stream count = 5
> 
> This is bothersome, so only print this message for an update.
> 
> 
> [...]

Applied to 6.9/scsi-fixes, thanks!

[1/1] scsi: sd: Only print updates to permanent stream count
      https://git.kernel.org/mkp/scsi/c/961990efc608

-- 
Martin K. Petersen	Oracle Linux Engineering

