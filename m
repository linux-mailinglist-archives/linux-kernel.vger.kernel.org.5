Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CD5764190
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjGZWAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGZWAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:00:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7477E1BF2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:00:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6726d5d92afso997497b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690408800; x=1691013600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmO8f5N+/Wc0ClX0Q4hB54MuVMgQHt4gjqV/2VzUoJM=;
        b=IRheo1VcS17JRchWvrxtHhXbdTmCAHaaaMFvWr7HxzXgp/f+zpdEeRiicU5YVpXF5O
         fqxPZ7YCFduxv1q8b0/HLyrWvvb3Su1hY17PYxYOiCuHUwjqKHH0TSYWpgsZsnCCuKJ/
         93h83WY9D0JzgNxc/8DbJePLzoXjFCZYFcb3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408800; x=1691013600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmO8f5N+/Wc0ClX0Q4hB54MuVMgQHt4gjqV/2VzUoJM=;
        b=X8fd+KaZlWPu9XC3ZPLfi7Ij8i0KRGORTGUyoQh8rjbTqMAfzH5SqYaaQpJHvVpzQL
         I4kk3YIn90LdPVEPqsS+pNbqiONw1fljV32zjJXtjg5jRrdNkRvboqXfi+T6a8pmdNhi
         MvLNVLjZ8DsG20fsZCnO8m1JLnH2qTd8vI1wzNAiGGx0vY000XqeqDqk2JqfQRdLC8z9
         LKChtMXzCBWInh6aTHs7B4HAIjZurQ7rkxOgmj7yXDwZL+31ii+IQrLgz1YNLDQZlVxQ
         QE6adsgjJ/0JkBizMMRy3tRKMauxz4CTzkbaCQp4zLqMN7DbOD1yGtrif0c5gtshAd5C
         yt3Q==
X-Gm-Message-State: ABy/qLb82i1dloggzNRxkBuPzbr1JmFhODEa7Px5388lJtILo4BO80+I
        1WUlyCv+ou57e4MG5ygjeM7Mgi3hMQ1Wv9sNZbY=
X-Google-Smtp-Source: APBJJlH/69ywQwqCkAR2/MreH6J1rI/63xswua4ciJr3DWARS2iDAxUtHlK0kRIqwXl0/iOjK2tZ5A==
X-Received: by 2002:a05:6a20:3d8b:b0:128:ffb7:dcfe with SMTP id s11-20020a056a203d8b00b00128ffb7dcfemr859241pzi.1.1690408799887;
        Wed, 26 Jul 2023 14:59:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j25-20020aa78dd9000000b0067777e960d9sm70369pfr.155.2023.07.26.14.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:59:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] seq_file: seq_show_option_n() is used for precise sizes
Date:   Wed, 26 Jul 2023 14:59:57 -0700
Message-Id: <20230726215957.never.619-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=keescook@chromium.org;
 h=from:subject:message-id; bh=5SG2UTPOhvYfjLu1GmFk1JjaJdwmNUKnlU3NSz2ezqs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkwZdde36GoULThoErTSucEyxJhlW0LYit40bsm
 ZxXjkmRXoGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZMGXXQAKCRCJcvTf3G3A
 JvX2D/46MlSRKOZrRkZWdErmLSLB6JVxuSpANsljamLtuYJybYwdTTB0FWf7OwGlmEi9NpC+o4k
 O9q/f3yPK1/wv+iFiNSrYzeUvnnD1FWQlVSX2ktFhPL61zUitEjUKbyATnEnEy7SVIg86FfiYvz
 tNkdTtU6QaXSU6B2kiir4wnNxt0k7FpE0orAqIy8iTe5wJTERBnDPkvdg3OPqIa7UtlFzrw9MGF
 gUEwUOzSU7T0b3/Bo49+rjlHfEjmqMTc1GfLX+M6KB7UK57ucIWzAMcXuVMgpagZo3/OKej1EeH
 35hPiXkmesiRd/MEa1VwJYPzs1xKHfkhnsd/5vTINLwBG2fcMSDTx/I2RWcip//oQSY3T0CaqkI
 pmh7K/u8cEKZydD66d7A7cZ7amu5t4x7A84Iol+d/wRwYRluCyjW+mkpgo/zmmlUGkMzLBvJS8P
 lJOPcdKXb6vj1LJzFIoBYFsX9vXYXpCxCbX3kgs+gcDC4HdM4yqhy6S/NsvmpZUM8c8/9e8Xngf
 23sotyX5AKaubcL2cuf953pSQ1AyAot9i7JC66zaW9quZCcnICCbzjSajaA0Ai/sdG9Cl04lXHR
 uDIdgkmvTfHiaOkHcWD3zkbHFXQ50baLiOEVNveTNVKd8XF8JZykTEmjxitI0kP2Uz/zt7Wc+bO
 2ox8Mby q0xyXc1w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When seq_show_option_n() is used, it is for non-string memory that
happens to be printable bytes. As such, we must use memcpy() to copy the
bytes and then explicitly NUL-terminate the result.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/seq_file.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index bd023dd38ae6..386ab580b839 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -249,18 +249,19 @@ static inline void seq_show_option(struct seq_file *m, const char *name,
 
 /**
  * seq_show_option_n - display mount options with appropriate escapes
- *		       where @value must be a specific length.
+ *		       where @value must be a specific length (i.e.
+ *		       not NUL-terminated).
  * @m: the seq_file handle
  * @name: the mount option name
  * @value: the mount option name's value, cannot be NULL
- * @length: the length of @value to display
+ * @length: the exact length of @value to display, must be constant expression
  *
  * This is a macro since this uses "length" to define the size of the
  * stack buffer.
  */
 #define seq_show_option_n(m, name, value, length) {	\
 	char val_buf[length + 1];			\
-	strncpy(val_buf, value, length);		\
+	memcpy(val_buf, value, length);			\
 	val_buf[length] = '\0';				\
 	seq_show_option(m, name, val_buf);		\
 }
-- 
2.34.1

