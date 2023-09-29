Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053BE7B2AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 05:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjI2DtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 23:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2Ds5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:48:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0D819C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:48:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8134eb83so176408567b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695959334; x=1696564134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lK8fb8SVkX3dYfemv0Fs8dWHGfBfDbWTSi3SV9bwElg=;
        b=ZrsGuLMk06Lc3eaVi8BWj6hl+veQ4o/+vkUWZdhrFEXtz6dwoWlrg/100aMAQkyK/L
         RcZcAeExZ1fqwhZJzYI/Qe1xKv5jvGn1AYf3AQ+b6UYXZUtJn2CLqmuM8r5j/k82FIgZ
         4x4za2v8TwjQzwvUykX5JPWp2XcLC0UQHjF1aTLOyLZpTuQDQLG/rngb22t8JZduEp0+
         MWXMr5gb+m5tJlycxjFeQ9DPQJbX6AsekLNwy+N1wNJqrr82mUAyTyhNhfkxojo6Nls6
         ONTUmAs+wxkU+Seiuc7CVCF08xEV+MKqpZ3UPGu7h9o07rOymJ8jUj8waY+N+MRFSfF+
         PrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695959334; x=1696564134;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lK8fb8SVkX3dYfemv0Fs8dWHGfBfDbWTSi3SV9bwElg=;
        b=sfW0nt/a2IMB5o00+e4UCCKv7Bf32+/hHuTgcVDYSOjXg+qE1CTdpkYGvP2S8YLK3d
         kKDENAID4H+WTfbnUJUgSz+PopSkVrdYCnVqI8RhWmNnDLhTqVpwoyZ8oPuWvT1c5byh
         tMmjRIsWOFF7jcxyKqq4+aBSSn5OFvUjc8/h9j3nspDoCRhcSUH9Kh65J4FMSFz19m4I
         GETYvuatOL+sQ44RmRTWU3gqlt4CToAXOV+KjN7jxbt+wUBuwQZcAVCBEJjl5fkGJWnR
         2VP1dR9SHUCn+bY7uxsdfdeg9qE2cvBXiXJAd1D9JvSchkW7A/5MIlMUCwwsDpIGLTz2
         l1Rg==
X-Gm-Message-State: AOJu0Ywhq8Okd4KqiXPLCxHCqC3p4OTLECA0CX0rIIQRZFoV5rvplgsQ
        Q2zJNEEfWAsSeYOtiVr/xn08w/Pk2rsIvg==
X-Google-Smtp-Source: AGHT+IGbcc9CvVBvC6LRxnef2I69dprSb2lh6bSib8bKP3bPs7uq+ucfBJ5uCswKLlG/+MfNBrKorhaFJNvfGw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:abe9:0:b0:d80:19e5:76c8 with SMTP id
 v96-20020a25abe9000000b00d8019e576c8mr38367ybi.12.1695959334231; Thu, 28 Sep
 2023 20:48:54 -0700 (PDT)
Date:   Fri, 29 Sep 2023 03:48:17 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929034836.403735-1-cmllamas@google.com>
Subject: [PATCH] scripts/decode_stacktrace.sh: optionally use LLVM utilities
From:   Carlos Llamas <cmllamas@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Carlos Llamas <cmllamas@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        John Stultz <jstultz@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GNU's addr2line can have problems parsing a vmlinux built with LLVM,
particularly when LTO was used. In order to decode the traces correctly
this patch adds the ability to switch to LLVM's utilities readelf and
addr2line. The same approach is followed by Will in [1].

Before:
  $ scripts/decode_stacktrace.sh vmlinux < kernel.log
  [17716.240635] Call trace:
  [17716.240646] skb_cow_data (??:?)
  [17716.240654] esp6_input (ld-temp.o:?)
  [17716.240666] xfrm_input (ld-temp.o:?)
  [17716.240674] xfrm6_rcv (??:?)
  [...]

After:
  $ LLVM=1 scripts/decode_stacktrace.sh vmlinux < kernel.log
  [17716.240635] Call trace:
  [17716.240646] skb_cow_data (include/linux/skbuff.h:2172 net/core/skbuff.c:4503)
  [17716.240654] esp6_input (net/ipv6/esp6.c:977)
  [17716.240666] xfrm_input (net/xfrm/xfrm_input.c:659)
  [17716.240674] xfrm6_rcv (net/ipv6/xfrm6_input.c:172)
  [...]

Note that one could set CROSS_COMPILE=llvm- instead to hack around this
issue. However, doing so can break the decodecode routine as it will
force the selection of other LLVM utilities down the line e.g. llvm-as.

[1] https://lore.kernel.org/all/20230914131225.13415-3-will@kernel.org/

Cc: Will Deacon <will@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 scripts/decode_stacktrace.sh | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 564c5632e1a2..bfe5a4082d8e 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -16,6 +16,21 @@ elif type c++filt >/dev/null 2>&1 ; then
 	cppfilt_opts=-i
 fi
 
+UTIL_SUFFIX=
+if [[ -z ${LLVM:-} ]]; then
+	UTIL_PREFIX=${CROSS_COMPILE:-}
+else
+	UTIL_PREFIX=llvm-
+	if [[ ${LLVM} == */ ]]; then
+		UTIL_PREFIX=${LLVM}${UTIL_PREFIX}
+	elif [[ ${LLVM} == -* ]]; then
+		UTIL_SUFFIX=${LLVM}
+	fi
+fi
+
+READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
+ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
+
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
 	basepath="auto"
@@ -75,7 +90,7 @@ find_module() {
 
 	if [[ "$modpath" != "" ]] ; then
 		for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*") ; do
-			if readelf -WS "$fn" | grep -qwF .debug_line ; then
+			if ${READELF} -WS "$fn" | grep -qwF .debug_line ; then
 				echo $fn
 				return
 			fi
@@ -169,7 +184,7 @@ parse_symbol() {
 	if [[ $aarray_support == true && "${cache[$module,$address]+isset}" == "isset" ]]; then
 		local code=${cache[$module,$address]}
 	else
-		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address" 2>/dev/null)
+		local code=$(${ADDR2LINE} -i -e "$objfile" "$address" 2>/dev/null)
 		if [[ $aarray_support == true ]]; then
 			cache[$module,$address]=$code
 		fi
-- 
2.42.0.582.g8ccd20d70d-goog

