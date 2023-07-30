Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2648768664
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjG3QTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 12:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjG3QTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 12:19:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCC31701;
        Sun, 30 Jul 2023 09:19:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe37809e4aso161069e87.3;
        Sun, 30 Jul 2023 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690733955; x=1691338755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWuKg9zpt17KCtcGuwrlwWZjFJZG3AMLApNVFlRq2o4=;
        b=XvuoMuLqpu3Q/W4Q2sBe2toAAYRC30M2uvNFYU1u38zyyP+f9Vo35hdCsqx7mUsB9R
         IdA4xn7ICx4Ctc23CQhfvkG29HkrDAIhQY33IiPF0fbKUmc6xFznUr2VeFEa3+5z2yGU
         /R2An5QG25nSVxsIpOll6p5El2chnaGRnEPQmQtjQJBm/kvH2gyZnVnadrcDDWF+w4T/
         9s13YIC5OBeKpGCRt+WLYJn+3Bwf6M+Mf0Q6oxjHhiM679l7msgHI9xo0cTa89+CukBl
         IKdy2qCxIUuT0hWgyOQOSYRd1gPWXIdBRwm+lhbQz67r587TOQmvctWvjFGVS6Jb5C4V
         GGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690733955; x=1691338755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWuKg9zpt17KCtcGuwrlwWZjFJZG3AMLApNVFlRq2o4=;
        b=EyjRqihi19qUegoRAZ3gzfTH66JjFkvnqIq7DJzglXfMjC0VLN86OdLPCuRFaDqDOi
         mDu1HNbeYi545KZRL5yq+wNxECaU8dmfLw0cv+TxTZxlLGEaX09B9A3nvPG2lLH6qavo
         V9P59jCEiyHcp4+Tt3iDGkPM0FSPt0CwieoQxKCp2jSqnCYvbrEgAeCS8o84RMI+LtPC
         0WVOUIamDXfQ3Iu7NYYi9NQZtSV/poZtgTK9R7dm/JoRYNnuMf/taqq3FMlGcjBDKKna
         rK+b7aJRN7PTDM1Jz05yBYnMpoFf9Md0QEeQ/W3icU4KkrKrdwmL4cHhZdNkRdcMxKtO
         KW3A==
X-Gm-Message-State: ABy/qLbuaT/cY1rHIOzI/N/Pfj85MMPIZIcE4OdVrKkdSl3zIm5D2t9I
        yc9TZk69OkWQmKA17T7JHTM=
X-Google-Smtp-Source: APBJJlHd8V6OjKgWth7WV5Rc2tPypWhHcyoduvf96qHGL8J6+DApJc7hRzTPDkkClYm8iITkQ1KY3g==
X-Received: by 2002:a19:7401:0:b0:4f9:69af:9857 with SMTP id v1-20020a197401000000b004f969af9857mr3109479lfe.51.1690733954765;
        Sun, 30 Jul 2023 09:19:14 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id va16-20020a17090711d000b00992aea2c55dsm4858798ejb.153.2023.07.30.09.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 09:19:14 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] lib/ucs2_string: Add UCS-2 strscpy function
Date:   Sun, 30 Jul 2023 18:19:02 +0200
Message-ID: <20230730161906.606163-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730161906.606163-1-luzmaximilian@gmail.com>
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a ucs2_strscpy() function for UCS-2 strings. The behavior is
equivalent to the standard strscpy() function, just for 16-bit character
UCS-2 strings.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v5:
 - Add ucs2_strscpy() instead of ucs2_strlcpy()

Patch introduced in v4.

---
 include/linux/ucs2_string.h |  1 +
 lib/ucs2_string.c           | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/ucs2_string.h b/include/linux/ucs2_string.h
index cf3ada3e820e..c499ae809c7d 100644
--- a/include/linux/ucs2_string.h
+++ b/include/linux/ucs2_string.h
@@ -10,6 +10,7 @@ typedef u16 ucs2_char_t;
 unsigned long ucs2_strnlen(const ucs2_char_t *s, size_t maxlength);
 unsigned long ucs2_strlen(const ucs2_char_t *s);
 unsigned long ucs2_strsize(const ucs2_char_t *data, unsigned long maxlength);
+ssize_t ucs2_strscpy(ucs2_char_t *dst, const ucs2_char_t *src, size_t count);
 int ucs2_strncmp(const ucs2_char_t *a, const ucs2_char_t *b, size_t len);
 
 unsigned long ucs2_utf8size(const ucs2_char_t *src);
diff --git a/lib/ucs2_string.c b/lib/ucs2_string.c
index 0a559a42359b..b608129fcbdc 100644
--- a/lib/ucs2_string.c
+++ b/lib/ucs2_string.c
@@ -32,6 +32,41 @@ ucs2_strsize(const ucs2_char_t *data, unsigned long maxlength)
 }
 EXPORT_SYMBOL(ucs2_strsize);
 
+ssize_t ucs2_strscpy(ucs2_char_t *dst, const ucs2_char_t *src, size_t count)
+{
+	long res;
+
+	/*
+	 * Ensure that we have a valid amount of space. We need to store at
+	 * least one NUL-character.
+	 */
+	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
+		return -E2BIG;
+
+	/*
+	 * Copy at most 'count' bytes, return early if we find a
+	 * NUL-terminator.
+	 */
+	for (res = 0; res < count; res++) {
+		ucs2_char_t c;
+
+		c = src[res];
+		dst[res] = c;
+
+		if (!c)
+			return res;
+	}
+
+	/*
+	 * The loop above terminated without finding a NUL-terminator,
+	 * exceeding the 'count': Enforce proper NUL-termination and return
+	 * error.
+	 */
+	dst[count - 1] = 0;
+	return -E2BIG;
+}
+EXPORT_SYMBOL(ucs2_strscpy);
+
 int
 ucs2_strncmp(const ucs2_char_t *a, const ucs2_char_t *b, size_t len)
 {
-- 
2.41.0

