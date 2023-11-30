Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5077FFD23
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376773AbjK3U4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376386AbjK3U4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:56:04 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D10170B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:56:10 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cb749044a2so1421389b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701377770; x=1701982570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mqH2Bu8VDSZQl/oVmtaFk1bQrPnLFzomfRgzjPU9ug=;
        b=dhoUccPUzLdedFmR72dBLBBf1AwWJCbZWRG/C11ZKHT5/v2loNjYwqyQHWCR/NFqzx
         rGBGX7d51mgrdd6Y3J0GDjJJkU6T6nc8sCL3krUHBrvKyMqmP0Th6gCrBljtEhaoaJyA
         rs747QpY0EkW5QjvDmo1KWIZxDlllhNBVS0qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377770; x=1701982570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mqH2Bu8VDSZQl/oVmtaFk1bQrPnLFzomfRgzjPU9ug=;
        b=B4AB/NCQWiAy7ytJaSL8YtTNKA+BCL9cOFL1zTHe1pD8PUn8RuIVVUzK0jiDtWyptK
         92MBSMN0gH7ilZXKzaZetbF0rUtP2s1siWQQsc5NCUt90dGoyE8ZmrEXPVgY37TlfSgQ
         CAqoIrA69iVw30+ZOMt+riT/XrsDWvVSvU9wGKA5vfOeDvhbUzkj94d4Njei8j5yAAsC
         8w7qkVEi8Eonj5vRuObEbQLtX6AOJ5+l5Vy/1rrpdQrMETnMsD+nzX0LZz7hulGZQ6ZF
         e3t0e6AWoGmAc3qXqU1PKczLwXpDa+Cq0RODJtYcJqVvgIN0aD/Jadl8AZaZ9rJopwVw
         CW4A==
X-Gm-Message-State: AOJu0Yz1PzfLZQNzxHPZWtn/tEIcZly1uuF6T/TMDiensGu9gWXpYOtd
        5FDeDMM9tV1KMpZ3bEunrCiJyA==
X-Google-Smtp-Source: AGHT+IF/p/yWidHm/LXNmEns/hCrvoFxobs9OIzRQhwApsdqdtIkzzRmCesyaYJ3JlISWVm6Hx6nSA==
X-Received: by 2002:a05:6a00:3907:b0:6c4:d76a:68ff with SMTP id fh7-20020a056a00390700b006c4d76a68ffmr28870071pfb.17.1701377769742;
        Thu, 30 Nov 2023 12:56:09 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r8-20020aa78b88000000b006889511ab14sm1649631pfd.37.2023.11.30.12.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:56:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] tracing/uprobe: Replace strlcpy() with strscpy()
Date:   Thu, 30 Nov 2023 12:56:08 -0800
Message-Id: <20231130205607.work.463-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=keescook@chromium.org;
 h=from:subject:message-id; bh=VAQ/FNnq8v9CzAsxQVG8VOQQl1gkuhbx7/nJ2nLij24=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaPbn40MW2pI606YFnUzI2iau9NKfIMFA3hhNz
 i9rV8Xp0L+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWj25wAKCRCJcvTf3G3A
 JphxD/0ccMJyONx88iMeiVBBxhpQxMXLZ3/cgij/f1NWWQtky8CiRVSnmiHuwuHEGRkZvv2H9zH
 /0t6VYWUDc0KsaXIYuf2zRKW2rexz7CdRO+C/HB4EKf0u7AyY1hly2yTRFmSJfIm5iOg9oGmmVR
 ejxK8/epLSsTFuKcCcfcnSGiTrsM8zOGSAAB35wKUazI7JepId+k3bpipXDdTK01v8fpIkabwa1
 KSfC2JLVya7CdOm3kF0fNNu8GEcuYeNGLCVloi1RxLNsey1ND0XZ0wPiL3HDkSp8+Lzm9wpoXQ0
 jQrOQidOcEUCwsHvQ/xMoGzHIq5DgU5S5Xey3WFjPKyVq3EsNs6YRkN/y2AqQxc4CtJIDA7D6nv
 bZkIiEGjX2Aafqf7GYMD6bsqhdQsHccbU7/RbFc6rW2fRcmHnT6h44ht8zPAhXhx28b5+y76JaU
 mOgqxXBxGfOU2H3soJFvAcP5ESM9uT7Zlwq2HDx1RlT74wKg7S9ddsXxQBXKhcn9FopV+VKXYVD
 B+is63bPLIcijjEk0m6B5/UdHl4OwEkRABa+TUEGSBTCCXg8CZxTzOrvVtKbdK9b/R4u3LvH22M
 ZL60zhmY8Cl8gvldvxIQk2CJJRXoyJYkIKcgKDl5e6ej1i9ahR+mrgUGsovY1tzdZKz3TDrGb0p
 bjYwntr ZIx4iwLQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

The negative return value is already handled by this code so no new
handling is needed here.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/trace/trace_uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 99c051de412a..a84b85d8aac1 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -151,7 +151,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 		return -ENOMEM;
 
 	if (addr == FETCH_TOKEN_COMM)
-		ret = strlcpy(dst, current->comm, maxlen);
+		ret = strscpy(dst, current->comm, maxlen);
 	else
 		ret = strncpy_from_user(dst, src, maxlen);
 	if (ret >= 0) {
-- 
2.34.1

