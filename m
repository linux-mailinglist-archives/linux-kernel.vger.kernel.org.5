Return-Path: <linux-kernel+bounces-10345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5408681D326
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415901C21933
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D706C2D6;
	Sat, 23 Dec 2023 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cv4L7O/o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5809472;
	Sat, 23 Dec 2023 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BN6QveZ004273;
	Sat, 23 Dec 2023 08:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=xg3V6wzWAJisYwArjIxtY9uqhJBLV2lPERrot98bpKY=;
 b=Cv4L7O/oLLX8lR5rqzVT/nfeb9jGR/cfDF1c7/hdK0+OXT4vl6sosBHRijlTSYxqmUVV
 /2o9CXNDql0SdRfcCPuytBv4zma7/is96y+wp9M3vF/kDRBwf1P1A4GFhQvFzeWVByBB
 hRpLrXL06iieAFW6lcbq5tDMjq7TRi0qL7c/MghnFAkbAjobY0mayC4LsXQoPS7Ezqju
 5v3rdoQXNU+m0yWBq1F/x3wAUBAxQQxtLePmlNB2f44Orl693iZHqL57Sh5TlJaXlr16
 DPjz7o7x0AoJ2WiZ/BHySp31Y2y43NcvCz2QGgUN1E5FkIf6s0r0HBdKRkbblT+0xUda Hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5pb40c45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 Dec 2023 08:35:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BN5lWgA001871;
	Sat, 23 Dec 2023 08:35:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p03mfjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 Dec 2023 08:35:17 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BN8ZDbD003235;
	Sat, 23 Dec 2023 08:35:17 GMT
Received: from localhost.localdomain (dhcp-10-175-32-220.vpn.oracle.com [10.175.32.220])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v5p03mfa0-2;
	Sat, 23 Dec 2023 08:35:16 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/2] crypto: skcipher - remove excess kerneldoc members
Date: Sat, 23 Dec 2023 09:34:59 +0100
Message-Id: <20231223083459.3025561-2-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231223083459.3025561-1-vegard.nossum@oracle.com>
References: <20231223083459.3025561-1-vegard.nossum@oracle.com>
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
X-Proofpoint-ORIG-GUID: RrAOWwlLqRv5sIX7iqStld5OUIDe4Fm5
X-Proofpoint-GUID: RrAOWwlLqRv5sIX7iqStld5OUIDe4Fm5

Commit 31865c4c4db2 ("crypto: skcipher - Add lskcipher") moved some
fields from 'struct skcipher_alg' into SKCIPHER_ALG_COMMON but didn't
remove the corresponding kerneldoc members, which results in these
warnings when running 'make htmldocs':

  ./include/crypto/skcipher.h:182: warning: Excess struct member 'min_keysize' description in 'skcipher_alg'
  ./include/crypto/skcipher.h:182: warning: Excess struct member 'max_keysize' description in 'skcipher_alg'
  ./include/crypto/skcipher.h:182: warning: Excess struct member 'ivsize' description in 'skcipher_alg'
  ./include/crypto/skcipher.h:182: warning: Excess struct member 'chunksize' description in 'skcipher_alg'
  ./include/crypto/skcipher.h:182: warning: Excess struct member 'stat' description in 'skcipher_alg'
  ./include/crypto/skcipher.h:182: warning: Excess struct member 'base' description in 'skcipher_alg'

SKCIPHER_ALG_COMMON already has the documentation for all these fields.

Fixes: 31865c4c4db2 ("crypto: skcipher - Add lskcipher")
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 include/crypto/skcipher.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index ea18af48346b..8831fcf8f1da 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -108,16 +108,6 @@ struct skcipher_alg_common SKCIPHER_ALG_COMMON;
 
 /**
  * struct skcipher_alg - symmetric key cipher definition
- * @min_keysize: Minimum key size supported by the transformation. This is the
- *		 smallest key length supported by this transformation algorithm.
- *		 This must be set to one of the pre-defined values as this is
- *		 not hardware specific. Possible values for this field can be
- *		 found via git grep "_MIN_KEY_SIZE" include/crypto/
- * @max_keysize: Maximum key size supported by the transformation. This is the
- *		 largest key length supported by this transformation algorithm.
- *		 This must be set to one of the pre-defined values as this is
- *		 not hardware specific. Possible values for this field can be
- *		 found via git grep "_MAX_KEY_SIZE" include/crypto/
  * @setkey: Set key for the transformation. This function is used to either
  *	    program a supplied key into the hardware or store the key in the
  *	    transformation context for programming it later. Note that this
@@ -152,15 +142,9 @@ struct skcipher_alg_common SKCIPHER_ALG_COMMON;
  * @exit: Deinitialize the cryptographic transformation object. This is a
  *	  counterpart to @init, used to remove various changes set in
  *	  @init.
- * @ivsize: IV size applicable for transformation. The consumer must provide an
- *	    IV of exactly that size to perform the encrypt or decrypt operation.
- * @chunksize: Equal to the block size except for stream ciphers such as
- *	       CTR where it is set to the underlying block size.
  * @walksize: Equal to the chunk size except in cases where the algorithm is
  * 	      considerably more efficient if it can operate on multiple chunks
  * 	      in parallel. Should be a multiple of chunksize.
- * @stat: Statistics for cipher algorithm
- * @base: Definition of a generic crypto algorithm.
  * @co: see struct skcipher_alg_common
  *
  * All fields except @ivsize are mandatory and must be filled.
-- 
2.34.1


