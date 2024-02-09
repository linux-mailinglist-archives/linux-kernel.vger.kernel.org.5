Return-Path: <linux-kernel+bounces-60161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B0B8500E5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2BC1C249ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A3239AD8;
	Fri,  9 Feb 2024 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZjqqAPn4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D6538396
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522770; cv=none; b=cSdMziu1pJLMNPzlQru3p7oPRkgjAXVYTvFblhN0TmFpP7FekLOZ4SQBe3yU3IuEaOlsnEGk/M4HlkSbrZw8SzC0tste0qxsr/X93HRwVtzit+XMxQQX+NAx7EWnUk7RBS7jLIiLhTwSoSmNwt5Q63Pb7Amz11WY3xDSs6xtJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522770; c=relaxed/simple;
	bh=86RtvlUtOv2yJ5MZqQNtNb+1gGFhPVwupAonVS5lgek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYpqhL1zrcjGNR9boSMsVs7+UtsaOYBdD25gDQf5sfLT7WHMnGiUoy7LNd36ywod8HUSuXiFts8ISlibM0r27eC5xN0snB3n5FM0zOO48j1El2aXlt05pHLAz4Thcw3T/3fzGxn5cYmDGNKRZI3fsgGlMpqJIT+OvAQFiLkSv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZjqqAPn4; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419NU7KV012281;
	Fri, 9 Feb 2024 23:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=tKoK0Q9aAtzN2xjs9sBHkGxU5TWXySnkJ88ilUR3Q+I=;
 b=ZjqqAPn4leFO4CQ2GxU9q3g8tC3b1qXD+TvQ5ANby/U40kNZJTldT/JsySW4wVPX4/Mt
 isv0hJm3dqkSN8aU1ZwzYEmHZ+fTvGb39kXgzI0Mj9e9zgWwqTAxaaLqmx2qdrCdnta1
 Nmq1PUYthR3FUGSsfxf1443FFMw/9pieLLVMnUpA9qdboRpGCeYuvXMBDksEkKXXWS5u
 clK8KEhlh+yF2mJR2Ts3Drrhh1fgHqg9iUgdDXSuEPWjH402Yb0AppEpLjZRr1kA+Pn9
 5UASAG/wVoQ23VXcO7wPzDU6lX0Eu5uXWEDY3XK4NUU3Nx3fDqUNIuNmhd3t+uNnXMdi wA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w5ws1810a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 23:52:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419NDAVP036762;
	Fri, 9 Feb 2024 23:52:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxcuxjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 23:52:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 419NqYjw036242;
	Fri, 9 Feb 2024 23:52:37 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w1bxcuxha-2;
	Fri, 09 Feb 2024 23:52:37 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: 
Cc: jpoimboe@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
        saeed.mirzamohammadi@oracle.com
Subject: [PATCH 1/1] tools/objtools: tolerate mix of data in code section
Date: Fri,  9 Feb 2024 15:52:30 -0800
Message-ID: <20240209235231.889839-2-saeed.mirzamohammadi@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240209235231.889839-1-saeed.mirzamohammadi@oracle.com>
References: <20240209235231.889839-1-saeed.mirzamohammadi@oracle.com>
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
X-Proofpoint-ORIG-GUID: oR3hXUYY7ByHvRTT7fqP28hwP_ifOb52
X-Proofpoint-GUID: oR3hXUYY7ByHvRTT7fqP28hwP_ifOb52

Hand-written asm files might have data in the .text section and this
causes the objtools to not find the starting instruction. This avoids
this warning.

warning: objtool: n8_SafeDecrypt_RIJ128(): can't find starting instruction

Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
---
 tools/objtool/check.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e308d1ba664ef..9de4881f16984 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -459,9 +459,11 @@ static int decode_instructions(struct objtool_file *file)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
-				WARN("%s(): can't find starting instruction",
-				     func->name);
-				return -1;
+				/*
+				 * Can't find starting instruction likely due to data in
+				 * beginning of the section
+				 */
+				continue;
 			}
 
 			sym_for_each_insn(file, func, insn) {
-- 
2.42.0


