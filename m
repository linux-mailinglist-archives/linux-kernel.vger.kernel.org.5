Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925107AB82A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjIVRvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjIVRuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:50:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E9CCC5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:39 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c453379020so21078565ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405039; x=1696009839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMOJXPHQhZA0yS0fHoLI/plMshH0rTXOliwF499/DWE=;
        b=aebPsJKwSZViAED+uUauf6NIKp9lGVxeLAaNeiQb0qEOO146GyTAUY37+HL1N1w/Bn
         QtS74Aa9xYXWMrKI91SrSXqH+bFB1BswMloZL7so5d/6VsVk+UVmK4tG0N983U0GoqAC
         ZgAeUyODVVX/3yEt0c1WtVs0m9JshJj6WZnwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405039; x=1696009839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMOJXPHQhZA0yS0fHoLI/plMshH0rTXOliwF499/DWE=;
        b=A5cyPFXc8bl8VWXKv0ac/GG0AtUgNKybKZvjrXBs5QRHAt+9HmG2PLNvkIiG8K7TMk
         OajETVc1VHwBe4criHp5d5J1kSgessVj9lDlA+b4+0poW6SaCmMYwGrTtsFjVzpDoHBy
         Cr+OBri0blXU0AGA1xwynPp9QpTM/EZimHstPZZxBRHc7tMGKB8RBkdut3nIdWBTKEvs
         tnzG32XidS9NofRrUBP4oBmsAqZV8Hrx51d/kgAO2WUloTwsO5CR+H7psId73jAaw6Az
         OHWHkBdTQ7nfr0iAGrPu0W+vwtQoozQv84r+fEEJOskVlUWocmUOvcmQvKzOuCUBAILe
         gnHw==
X-Gm-Message-State: AOJu0Yxni5PosOID3ggbdhYZRFQ12mICo6kybssyIv7+mij6KzViJBN+
        a40dncjGCAAr08GBVPttMleZ2A==
X-Google-Smtp-Source: AGHT+IGaIyx2bOgCC7mrztEEIfqHLjz9L9iLu8LZRcOyBfuSv77bh1GHVC2OQn0kqgo7aKfmi4Ad+Q==
X-Received: by 2002:a17:902:9892:b0:1c4:72c9:64ef with SMTP id s18-20020a170902989200b001c472c964efmr180522plp.40.1695405038816;
        Fri, 22 Sep 2023 10:50:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b05e96d859sm3777350plb.135.2023.09.22.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] input: mt: Annotate struct input_mt with __counted_by
Date:   Fri, 22 Sep 2023 10:50:37 -0700
Message-Id: <20230922175036.work.762-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=keescook@chromium.org;
 h=from:subject:message-id; bh=LEWy0l9zrvVMRn8ts7PWj/kuD09dSrXj4WnAazmlq9A=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdPsQMKXeJm0ZhCGVnQLsQjIil2uivmvEwwNv
 Rzm0/Jc5EeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3T7AAKCRCJcvTf3G3A
 JmKlEACd7wdpTzCBhXNjMStZK0q7mpoWAr0hNvgGleGXtkF7ihbchHc07XOV5oi29vSWQxoCGK+
 A7UqilH4l+s+SjoKasEgekNpcsNlUXnd5SyTJu3U6W75mUkecgGQTjckkOPMaA9J/CvHpHVgW3X
 8MzJRaI3wxLRetGWsIe/dJ05u4kqLqfR0dbRv5CS3V9N8qTARLC+X3xfasNxO4nqzjALnb9UZng
 fWkUTE1dyh6MN0wJGLszYB/snY2r4SUtv8XGRyLAVck/Sh65NPeGwMITGT/bzc0w0Zsvq/E/4BI
 Lpl0hEYbOGDbqjmsoNfA6pVOrPQCAgHT5C2nUlHDCqqdTL3mvsv2+Pf9o8kFi9hQUQumpSgo1Eo
 qbSrXyd/LG+ys3iOt1WL8Rs9+/Mc8M8LmCLvUE2cDXnYmJm7c56wkolM+b3GuFE0AQrKc9jnMrj
 AXxSWEKzMB48nHsnaaOLnB8IO876orcAGoJvPCPzEa67LgSTjV5eqROX10kIz8l+4Vz5YsaQp/m
 0yisfYjudZ8duUFfShH58IS6W3CxWKuNVW7x+d68ao2hstJlKFbk/V+mJrUC4QriWao69tsBd+D
 NtdrU7nVOR4lk9udHmUznHVvxi8YN3pje3duKPp+5O+bnFoh2ptu3/33bWMqKkHemMLKstvXYsf
 3iIwQc2 vWZX8QZg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct input_mt.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/input/mt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/input/mt.h b/include/linux/input/mt.h
index 3b8580bd33c1..2cf89a538b18 100644
--- a/include/linux/input/mt.h
+++ b/include/linux/input/mt.h
@@ -47,7 +47,7 @@ struct input_mt {
 	unsigned int flags;
 	unsigned int frame;
 	int *red;
-	struct input_mt_slot slots[];
+	struct input_mt_slot slots[] __counted_by(num_slots);
 };
 
 static inline void input_mt_set_value(struct input_mt_slot *slot,
-- 
2.34.1

