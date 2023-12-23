Return-Path: <linux-kernel+bounces-10346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162E181D329
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC501F229E1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D291CA78;
	Sat, 23 Dec 2023 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fd0P1YEt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F552946D;
	Sat, 23 Dec 2023 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BN1v9Hw021930;
	Sat, 23 Dec 2023 08:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=wYElaZP0jYvrtQvw/F9wl/AViI12hWXfvWUUyi6xrQQ=;
 b=fd0P1YEtuIqoufODQozUfoT64nwDjrwmBRkQrz6ZPidqonEMWzuGVibSKZHawWmh/DCO
 5FWLSn501MV+s5jCfDZ87tIFNRkezXZpAlHxUfCTDXSJt/qggUf7TdWW1WeHXbzAEeQr
 8pSbunrnVUxTwqT/X0/8nH1wgzDnkX6kTW6bBzhizp9t2DrBSFsLYdGu6yYWoyVKZGIu
 j3i/FpOhU7nCDIv+Wu07rZgaqRo0B/7H58h66WFYfsQbb+H8JwokVGelAvdfRrdlLlKr
 SZ1lcT2F1ZWymRcBdNsQYco6UMb97lrzD9WWaMgJ5JZ96O6yqoF+lV4RkOe85a91kOp2 sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5pb40c43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 Dec 2023 08:35:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BN60WMA001881;
	Sat, 23 Dec 2023 08:35:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p03mfek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 Dec 2023 08:35:14 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BN8ZDbB003235;
	Sat, 23 Dec 2023 08:35:13 GMT
Received: from localhost.localdomain (dhcp-10-175-32-220.vpn.oracle.com [10.175.32.220])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v5p03mfa0-1;
	Sat, 23 Dec 2023 08:35:13 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] crypto: shash - remove excess kerneldoc members
Date: Sat, 23 Dec 2023 09:34:58 +0100
Message-Id: <20231223083459.3025561-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_15,2023-12-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312230065
X-Proofpoint-ORIG-GUID: IRiAeJPyUxWjBP9iwMOCIFNSXoS2H3o9
X-Proofpoint-GUID: IRiAeJPyUxWjBP9iwMOCIFNSXoS2H3o9

Commit 42808e5dc602 ("crypto: hash - Count error stats differently")
moved some fields from 'struct shash_alg' into HASH_ALG_COMMON but
didn't remove the corresponding kerneldoc members, which results in
these warnings when running 'make htmldocs':

  ./include/crypto/hash.h:248: warning: Excess struct member 'digestsize' description in 'shash_alg'
  ./include/crypto/hash.h:248: warning: Excess struct member 'statesize' description in 'shash_alg'
  ./include/crypto/hash.h:248: warning: Excess struct member 'stat' description in 'shash_alg'
  ./include/crypto/hash.h:248: warning: Excess struct member 'base' description in 'shash_alg'

HASH_ALG_COMMON already has the documentation for all these fields.

Fixes: 42808e5dc602 ("crypto: hash - Count error stats differently")
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 include/crypto/hash.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index c7bdbece27cc..5d61f576cfc8 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -212,13 +212,9 @@ struct shash_desc {
  *	      This is a counterpart to @init_tfm, used to remove
  *	      various changes set in @init_tfm.
  * @clone_tfm: Copy transform into new object, may allocate memory.
- * @digestsize: see struct ahash_alg
- * @statesize: see struct ahash_alg
  * @descsize: Size of the operational state for the message digest. This state
  * 	      size is the memory size that needs to be allocated for
  *	      shash_desc.__ctx
- * @stat: Statistics for hash algorithm.
- * @base: internally used
  * @halg: see struct hash_alg_common
  * @HASH_ALG_COMMON: see struct hash_alg_common
  */
-- 
2.34.1


