Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4857F895B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjKYInK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjKYInF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:43:05 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C4093
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:43:11 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfb3ee8bc7so2948795ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700901791; x=1701506591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPPxIVkRMPlLUxZMsEygBEBjgDTLIaOmfxI6JWnloIc=;
        b=pRBffyQrCwf4oKhvTAqwDsql81Gi1ZUG1TrWWb6Th9wByymCvZ4X4bzpp/9PDyFHGb
         JmdQhjCkn7EtugvsHui0i2ssEtCDYTd8z1fElK0aM/ar8YXaqvCuXiGIlud47tTtebc/
         E3CA4FM2z4dZmUjPX8X1wtv+VyAfON7Zm3JDIQZEoQ3JQf8+S7RgUq9/BMI8BTUB0oRj
         kUfC7HIugLwA/ZSj+ifnjYyeBQxHnKX6pMeLK394C9+iS1BFK/W3kafNRnEBwK4ThjeY
         /ofKbPaRIuRdqkfj24IYDyXAbJkKu08h6EhVO27TDEzpTNj9N6hTphqY893bNlUtGjMB
         /WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700901791; x=1701506591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPPxIVkRMPlLUxZMsEygBEBjgDTLIaOmfxI6JWnloIc=;
        b=iRFiLI2u6UWDRLLOuGTumkXo/+d5gG2sgG2OTDBqRKdEU+ZJpz0yFRboioUxgQB6No
         nROycaYeF45tOTnRlTd/4kO/L4q62X9sOrHHTeojiVOqvXKb0q8b9gSOt5aAEZauY+N+
         aKOaf7UBb1AHAKkk4UePeZ/kqElcb0tAs2pAVh5Op8RpwguR3+WvcltuchzBSuP/ISw5
         JYffFc4HPWhi9KO/6ZamxHJXhcYzi6pVykiLIcBKr+X+mLAXaWuq65hR44WVHmWAHDv3
         4NVg8PiKlSD4sbKXyP00XWJd1GVwKnq9W3JGPJ1B74uorkv8agrHFlLyp9FuodKn9SOt
         BD2g==
X-Gm-Message-State: AOJu0YxArIkOedCZiIHGANXChxZDYD3G2WOtEU+TMh1XOfgDdxCnkAMp
        PfQMhRQqwBoUD4V38LE3HvKvtQ==
X-Google-Smtp-Source: AGHT+IEVVpVFIcUVQouFS95iWEttXau5YwBJgu8W9QjT7uKgsVIqZzxbtoETCuWtg/ws4lKe1JRV9g==
X-Received: by 2002:a17:902:f68d:b0:1cf:6704:4340 with SMTP id l13-20020a170902f68d00b001cf67044340mr6468913plg.22.1700901791152;
        Sat, 25 Nov 2023 00:43:11 -0800 (PST)
Received: from localhost ([157.82.205.15])
        by smtp.gmail.com with UTF8SMTPSA id h12-20020a170902748c00b001c9d011581dsm4432500pll.164.2023.11.25.00.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 00:43:10 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Nick Terrell <terrelln@fb.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH bpf-next v5 1/3] selftests/bpf: Choose pkg-config for the target
Date:   Sat, 25 Nov 2023 17:42:50 +0900
Message-ID: <20231125084253.85025-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231125084253.85025-1-akihiko.odaki@daynix.com>
References: <20231125084253.85025-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pkg-config is used to build sign-file executable. It should use the
library for the target instead of the host as it is called during tests.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/bpf/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9c27b67bc7b1..94825ef813d5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -18,7 +18,7 @@ else
 GENDIR := $(abspath ../../../../include/generated)
 endif
 GENHDR := $(GENDIR)/autoconf.h
-HOSTPKG_CONFIG := pkg-config
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 
 ifneq ($(wildcard $(GENHDR)),)
   GENFLAGS := -DHAVE_GENHDR
@@ -219,9 +219,9 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
 
 $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 	$(call msg,SIGN-FILE,,$@)
-	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null) \
+	$(Q)$(CC) $(shell $(PKG_CONFIG) --cflags libcrypto 2> /dev/null) \
 		  $< -o $@ \
-		  $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
+		  $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
 
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
 	$(call msg,MOD,,$@)
-- 
2.43.0

