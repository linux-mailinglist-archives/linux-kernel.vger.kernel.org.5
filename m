Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA9798EB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbjIHTHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjIHTHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:07:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7456EBC;
        Fri,  8 Sep 2023 12:07:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA137C4339A;
        Fri,  8 Sep 2023 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197208;
        bh=RViSFHNgKCvbQtgCDKZHDJ5vfqcmzA/fOe4L6CvC2rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSE0gVgpkrXkaGOsLF+RcPlrva6yaavV9NC6E+EUQzRlVqqpScxmRrft8FOwFh/aJ
         tzbLybEz7KnZRfDkxpRBlJ5ubDewSk3zxClzA1CyEKC7JsN313/jJkIGdQS7BzMlup
         XDNIpBi7KG1WvCL2PwwZTRVzbmNncltWBeVustghZBWnw60HD8FdTSeI4ecZJ6IxhN
         mtFnJbTPQLFdizqR7CyQHKGkPy8On7/y9fEjnXdcImrgWVJTERKo3u433kfv1CFUju
         P8AJSOIQZJDfkgRyEiysjMS52kTGrHE+fI2sbuMextHxxWGHqF+kvXLTqlEV8UePF1
         0xp3TaE0PBuRQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/14] crypto: lrw,xts - Replace strlcpy with strscpy
Date:   Fri,  8 Sep 2023 14:19:49 -0400
Message-Id: <20230908182003.3460721-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908182003.3460721-1-sashal@kernel.org>
References: <20230908182003.3460721-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Azeem Shaikh <azeemshaikh38@gmail.com>

[ Upstream commit babb80b3ecc6f40c962e13c654ebcd27f25ee327 ]

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since return value of -errno
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/lrw.c | 6 +++---
 crypto/xts.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/lrw.c b/crypto/lrw.c
index bcf09fbc750af..80d9076e42e0b 100644
--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -357,10 +357,10 @@ static int lrw_create(struct crypto_template *tmpl, struct rtattr **tb)
 	 * cipher name.
 	 */
 	if (!strncmp(cipher_name, "ecb(", 4)) {
-		unsigned len;
+		int len;
 
-		len = strlcpy(ecb_name, cipher_name + 4, sizeof(ecb_name));
-		if (len < 2 || len >= sizeof(ecb_name))
+		len = strscpy(ecb_name, cipher_name + 4, sizeof(ecb_name));
+		if (len < 2)
 			goto err_free_inst;
 
 		if (ecb_name[len - 1] != ')')
diff --git a/crypto/xts.c b/crypto/xts.c
index c6a105dba38b9..74dc199d54867 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -395,10 +395,10 @@ static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
 	 * cipher name.
 	 */
 	if (!strncmp(cipher_name, "ecb(", 4)) {
-		unsigned len;
+		int len;
 
-		len = strlcpy(ctx->name, cipher_name + 4, sizeof(ctx->name));
-		if (len < 2 || len >= sizeof(ctx->name))
+		len = strscpy(ctx->name, cipher_name + 4, sizeof(ctx->name));
+		if (len < 2)
 			goto err_free_inst;
 
 		if (ctx->name[len - 1] != ')')
-- 
2.40.1

