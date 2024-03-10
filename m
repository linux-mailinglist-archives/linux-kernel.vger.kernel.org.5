Return-Path: <linux-kernel+bounces-98356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C2587791A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A601C20DB1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5502B3BB47;
	Sun, 10 Mar 2024 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PDjySKlu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4C339ACB;
	Sun, 10 Mar 2024 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710111878; cv=none; b=qkRFiRcS6oIPrm31cFMa/1xsOqLRG7UIVQ7knuYWK836sZRJUALdMP93VPGmgcPwyhWvRxF68V821v7B/KqB5JcVkysH7xm2SxLE5yfvDSay2Xqu3ws9TfLRG6h4HBPVVqu1BZI3Qt2p11cLCU0Bb2xqq+xNXtMOKs+tj4Z2oe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710111878; c=relaxed/simple;
	bh=lH/Jp7ESCADbqCJsFB99XCv8PsOxcsFauR6QOrh4J44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNWg1jF3cUJ3qzBdhKIQ8a02P9AtO2vSsrLYKSEqp3UYF1dFd2AXrGKdmeK1H7vm8hj5XuV5hgKHWbb6ClGti24Hxa9nyCVvUVh6B4bCP1ul8mLfSYmn/U6CUm/Wy1juG1q1iatnNV+fDiexOjEM33FVf/6jJVoiuKHb135l1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PDjySKlu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42A6Tfin001221;
	Sun, 10 Mar 2024 23:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=T8LBDFDL9edL6RmoH5IkHNkbJBvEiJGFqkdJUpUnXe0=;
 b=PDjySKlu4xkUlesSeImL56bnloDb0cZDOg3t31TLnIyWcWgHH7gQqDhe9Hpf2JgcSBhr
 dcAItVmAmUt7bfZwOHGPyX4MrurXiM+UJXflke42D1lAJB75q8HOR8b6roRxSM2g3Vc/
 +qYQ8TYOeKJtasDNkvWaHYiZ9NQfWToO5cpwe2PEXYv0P2Kmhaz4etHcKjwtWzyqQMGN
 1qNgUHXot5M8Q0pzi8wumqBjmEMMSclWtV1N9QBfS2JgdpK+ON9LBblXcJ2xEZAeg7/g
 EgUq3e3HOYEukfI7Z5713o9tnXSYZuB/F1CJ3yi/bYvJGYHvYxEDJMY9Nj9DQ5GJWD8Y qA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfnbht2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 23:04:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42AIIgf6005094;
	Sun, 10 Mar 2024 23:04:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre750ne9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 23:04:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42AN4TSE006839;
	Sun, 10 Mar 2024 23:04:30 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wre750ndq-3;
	Sun, 10 Mar 2024 23:04:30 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: lpfc: replace deprecated strncpy with strscpy
Date: Sun, 10 Mar 2024 19:04:19 -0400
Message-ID: <171010474753.3838281.7887660962913388218.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240226-strncpy-drivers-scsi-lpfc-lpfc_ct-c-v2-1-2df2e46569b9@google.com>
References: <20240226-strncpy-drivers-scsi-lpfc-lpfc_ct-c-v2-1-2df2e46569b9@google.com>
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
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=882
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403100187
X-Proofpoint-GUID: cX-UyxdzohLwY-fU8XjeGg6G-FlOd1oc
X-Proofpoint-ORIG-GUID: cX-UyxdzohLwY-fU8XjeGg6G-FlOd1oc

On Mon, 26 Feb 2024 23:53:44 +0000, Justin Stitt wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect ae->value_string to be NUL-terminated because there's a
> comment that says as much; these attr strings are also used with other
> string APIs, further cementing the fact.
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: lpfc: replace deprecated strncpy with strscpy
      https://git.kernel.org/mkp/scsi/c/e100c01efa85

-- 
Martin K. Petersen	Oracle Linux Engineering

