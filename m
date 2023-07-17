Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBB3756379
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGQM4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjGQM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:56:36 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A724B19A8;
        Mon, 17 Jul 2023 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689598568; x=1721134568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6fIrxn0+T/UT77ovNwjs4GlglBbK1dzH+ora1KGfoUw=;
  b=jlAm9MvaR5RA4UisvBmcadCDym3Dzh+PSKNIikjOL8FvEy7z5VMIhMG8
   qPtv3svgkKiEAbQdTWweSsfCix53glwYrnLAjCnHU7ksmnmwVygTFPUvI
   gnnNwNelILJGepYT5dkEkwk1taCFMn2zA2fI73I0kaAUFRFue8iHxdn2e
   4=;
X-IronPort-AV: E=Sophos;i="6.01,211,1684800000"; 
   d="scan'208";a="227224119"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 12:55:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id 52530A42D5;
        Mon, 17 Jul 2023 12:55:39 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 12:55:36 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 12:55:36 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 17 Jul 2023 12:55:36 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
        id BECC0DCC; Mon, 17 Jul 2023 12:55:35 +0000 (UTC)
From:   Mahmoud Adam <mngyadam@amazon.com>
To:     <dhowells@redhat.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mahmoud Adam <mngyadam@amazon.com>
Subject: [PATCH v4] KEYS: use kfree_sensitive with key
Date:   Mon, 17 Jul 2023 12:55:09 +0000
Message-ID: <20230717125509.105015-1-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key might contain private part of the key, so better use
kfree_sensitive to free it

Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
 crypto/asymmetric_keys/public_key.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 773e159dbbcb..abeecb8329b3 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -42,7 +42,7 @@ static void public_key_describe(const struct key *asymmetric_key,
 void public_key_free(struct public_key *key)
 {
 	if (key) {
-		kfree(key->key);
+		kfree_sensitive(key->key);
 		kfree(key->params);
 		kfree(key);
 	}
@@ -263,7 +263,7 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	else
 		crypto_free_akcipher(tfm);
 error_free_key:
-	kfree(key);
+	kfree_sensitive(key);
 	pr_devel("<==%s() = %d\n", __func__, ret);
 	return ret;
 }
@@ -369,7 +369,7 @@ static int software_key_eds_op(struct kernel_pkey_params *params,
 	else
 		crypto_free_akcipher(tfm);
 error_free_key:
-	kfree(key);
+	kfree_sensitive(key);
 	pr_devel("<==%s() = %d\n", __func__, ret);
 	return ret;
 }
@@ -441,7 +441,7 @@ int public_key_verify_signature(const struct public_key *pkey,
 				sig->digest, sig->digest_size);
 
 error_free_key:
-	kfree(key);
+	kfree_sensitive(key);
 error_free_tfm:
 	crypto_free_sig(tfm);
 	pr_devel("<==%s() = %d\n", __func__, ret);
-- 
2.40.1

