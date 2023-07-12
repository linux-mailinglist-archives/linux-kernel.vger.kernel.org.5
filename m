Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1C875106E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGLSY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjGLSY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:24:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FEE1BE3;
        Wed, 12 Jul 2023 11:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAADE6189F;
        Wed, 12 Jul 2023 18:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E98C433C8;
        Wed, 12 Jul 2023 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689186294;
        bh=oiL8B5T0SF7z89hecNy7VIEQawHKk0jVhieQ+mQfndw=;
        h=Date:From:To:Cc:Subject:From;
        b=BDqP0+ogAMJEpRGdPK3N+vTGpYBYsDyQIiifRNqv1xyWIUnXS3Whnp/ZJcxMD2PzU
         vcnya0Umb/RBkCNhcsI3/lriYJj1y6EGBvV5eX2jPXEIOkzioX0cNlCIN0euhDdDaE
         b2YxwZstHOlImIXjFY4e4F21Lar4uil/Z7OADLfv/z9ijlutaAr8203dJOk3nuB6iR
         w6+P6iDVfAWyy80OnY//7/8FR/CaJ6DLY05pnt9FizZSo/4BPZnJphQ6FZkugVA0bE
         +dWjugeNq6++3Boy/w1UrlQ+9hi0z7+vOVo3teNTLZksBtxctr7D8Di8S6bHl1i+HW
         Alz75aGcJBmPg==
Date:   Wed, 12 Jul 2023 12:25:45 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] udf: Fix -Wstringop-overflow warnings
Message-ID: <ZK7wKS0NgZPfqrZu@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use unsigned type in call to macro mint_t(). This avoids confusing the
compiler about possible negative values that would cause the value in
_len_ to wrap around.

Fixes the following -Wstringop-warnings seen when building ARM
architecture with allyesconfig (GCC 13):
fs/udf/directory.c: In function 'udf_copy_fi':
include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
  648 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
  693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
fs/udf/directory.c:99:9: note: in expansion of macro 'memcpy'
   99 |         memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
      |         ^~~~~~
include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
  648 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
  693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
fs/udf/directory.c:99:9: note: in expansion of macro 'memcpy'
   99 |         memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
      |         ^~~~~~
  AR      fs/udf/built-in.a

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

Link: https://github.com/KSPP/linux/issues/329
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/udf/directory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 1c775e072b2f..93153665eb37 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -95,7 +95,7 @@ static int udf_copy_fi(struct udf_fileident_iter *iter)
 	}
 
 	off = iter->pos & (blksize - 1);
-	len = min_t(int, sizeof(struct fileIdentDesc), blksize - off);
+	len = min_t(u32, sizeof(struct fileIdentDesc), blksize - off);
 	memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
 	if (len < sizeof(struct fileIdentDesc))
 		memcpy((char *)(&iter->fi) + len, iter->bh[1]->b_data,
-- 
2.34.1

