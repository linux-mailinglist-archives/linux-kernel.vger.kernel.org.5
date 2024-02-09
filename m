Return-Path: <linux-kernel+bounces-60160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C768500E4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E75928C571
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E93238F96;
	Fri,  9 Feb 2024 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="opjyvS3U"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78DA383BF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522769; cv=none; b=qYxjnzu87MSNTsSZjL/WrfllbJ6QGl8nfIQCuRNX3cJpkwFY4TnXmgFkXja8GlvdaatDOO0/m/Ibz8QqBu9gdAF96CYC+6eh5lWNo5Tc+p7ByRt12JZl9svfuqzy02jA2Tt0LVhXhLOGCOpfmg2OB/wx0EkJvW0JlVLDT3WsfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522769; c=relaxed/simple;
	bh=AN5My5HlnIvwHGZwbyhIZnsxUM58NR9ZDjEv/LkSqDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4xo7e1UJQ+O5h5x+sv34uWmPD5pJgGbAtFMXhTnaCJLBdulPJCEurIFYA2RKD2rrqji1Mk39cBI561rcRDgLO1hme9lI5UkRFZ0efs6gcsynQjXcYwdRL4xEYWKGktOyYKhysisMoNsmPpiIzh63ZNeyfHgA+w47rlXUUuhMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=opjyvS3U; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419NJngu005557;
	Fri, 9 Feb 2024 23:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=g0BnnngOn5pn1SI4o0/ILAlt/8duIgNRRe2MgHfHJAA=;
 b=opjyvS3UzN8oMgBf6ElxE2q3YMN1YJnrAdFte52626Y55K6BYyR2eYo6B7lBGz/N2ew0
 xqKPCrrCgWH4cshQHPZiiD/wUMRQBxzGCxdq2odaBUiY9kk0LuzLu1Rzj1zrF2F8lbG7
 W3+/zzk6fYcPzcVt3ATJOurVXwZbBvztxl1eCqxXvtbD/ASn3Is9vB03hUwd1YiLntDh
 ptnzQWwe3B+mWDoDCmzmiE76Uanit/VhmJj+GlbK/zQCc8r7vIYNYB7b42FsnyzcfYGh
 0Vpcz0lK9RICOQla9FJ5VqAk/nlOxWJhdiWKQ2VAYk9zLGMW6PacEjv/acQVR2r7P86/ HQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w5wm781hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 23:52:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419Lu8XW036819;
	Fri, 9 Feb 2024 23:52:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxcuxhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 23:52:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 419NqYju036242;
	Fri, 9 Feb 2024 23:52:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w1bxcuxha-1;
	Fri, 09 Feb 2024 23:52:34 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: 
Cc: jpoimboe@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
        saeed.mirzamohammadi@oracle.com
Subject: [PATCH 0/1] tools/objtools: tolerate mix of data in code section
Date: Fri,  9 Feb 2024 15:52:29 -0800
Message-ID: <20240209235231.889839-1-saeed.mirzamohammadi@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_19,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090174
X-Proofpoint-GUID: OmFDth5n1qolkCgSgtBNfAr09WHt1wtp
X-Proofpoint-ORIG-GUID: OmFDth5n1qolkCgSgtBNfAr09WHt1wtp

Any data in code section will cause objtools to fail and not process the
rest of the symbols and sections. This patch is a suggestion but any
better approach is appreciated.

Saeed Mirzamohammadi (1):
  tools/objtools: tolerate mix of data in code section

 tools/objtool/check.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.42.0


