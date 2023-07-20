Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D94475B3E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGTQLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGTQLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:11:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A56F0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:11:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5834d9ec5f7so33077777b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689869465; x=1690474265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp196USLnAy4LTAkpGzxnXfWsR6U5xBzW1Ke9Zcywm4=;
        b=0xJVu/W/3xHLwIgQt4AdT6cR/YUtiNdLdmQJXkVP0EBEOh0s1C8pMSYPVmVX56g0qL
         iY14aVUZXceX1+sSx47/A3Oz42zFfT6/iI72X+dHAkxW9xroRWzw6ItifadoKfASJ3u8
         hBpU/RpuzpltTY33o0ZEKscU+ZkWmBRLI+L2oSSkqem1In1o/8kvyeLQtZwigN3E10vS
         NgK9xlM5rN/Z00gvjRghEprD9TdNy5Vmx8iwjIOd4Y+GZ8uG8ZEDfW1U7NXUAb9hO2fz
         tMytb0jSh5n09x1tTZWMd313KeCvKYZeX3DaeKAhaFjFGLwW9FuzHttvsRB6eaajnMdp
         HzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869465; x=1690474265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp196USLnAy4LTAkpGzxnXfWsR6U5xBzW1Ke9Zcywm4=;
        b=MtIzwEoyMX/ivxkOaEXTExBVLFekFuWXjQldkhrN66Hmroh6PnaJGaKJCpU7SQHAOK
         3hvuOlcaKa2xLREKVLBL2K3S5odpu+lkMp71N44EKwZ34WeFNNZ5NpUHvDLsmXamxSTS
         gViO8C58NKEIPelZX4kMLY3waNEhanmEmTYma9dirP1TbSHUwnw8dYQ/Za04K2cNK1h4
         2lNtavXRYLNKrpNO4H1xhFrVf34xqGQ1npNJYJcT6zYJTx29ZZnjMUs28SpbR1oVefrX
         NNqIObU+LixKEyAuZKbnLM3nCivBnvNExf/S8DU4KcS5+Gh0Cia95evsX6/dnONXehAv
         K+ng==
X-Gm-Message-State: ABy/qLZBmxVGCDpsfFop3/dKb2J8YG5fJ0ur2Hrfs4iYeyiGPDn/Kkay
        YAmSA4YjTYBKClnP2GchLc3DxIJ6gXXwRQ==
X-Google-Smtp-Source: APBJJlEiVEmuesw68z+x28qFD4ReuJRNuf+WB6wQmhi/bG4Ofb/elfxoE7pV67Grv8RRZAJJig+fwLf/UqbQFQ==
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:209:c4c4:9486:83f9:4510])
 (user=gprocida job=sendgmr) by 2002:a5b:349:0:b0:ceb:324c:ba8e with SMTP id
 q9-20020a5b0349000000b00ceb324cba8emr77473ybp.4.1689869465517; Thu, 20 Jul
 2023 09:11:05 -0700 (PDT)
Date:   Thu, 20 Jul 2023 17:10:53 +0100
In-Reply-To: <20230407203456.27141-2-quic_johmoo@quicinc.com>
Mime-Version: 1.0
References: <20230407203456.27141-2-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720161053.1213680-1-gprocida@google.com>
Subject: [PATCH] scripts/check-uapi.sh: add stgdiff support
From:   Giuliano Procida <gprocida@google.com>
To:     quic_johmoo@quicinc.com
Cc:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, arnd@arndb.de, andersson@kernel.org,
        tkjos@google.com, maennich@google.com, gprocida@google.com,
        kernel-team@android.com, libabigail@sourceware.org,
        jorcrous@amazon.com, quic_tsoni@quicinc.com,
        quic_satyap@quicinc.com, quic_eberman@quicinc.com,
        quic_gurus@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.

I spent a few minutes adding stgdiff support to the script. It's
really just for illustration purposes.

As I think you know, STG doesn't yet exist as a project outside of
AOSP. Nevertheless, this may be useful to you as-is.

STG has quite a different philosophy to libabigil in terms of
filtering out certain kinds of differences. Some of the things (like
enum enumerator additions) are not considered harmless. The reasoning
behind this is basically...
https://en.wikipedia.org/wiki/Covariance_and_contravariance_(computer_science)

However, it does have --ignore interface_addition (and the related
--ignore type_definition_addition) which can be used to detect whether
one ABI is a subset of another.

I am looking at adding support for macro definitions (gcc -g3) to STG
which will then let us cover significantly more of the UAPI surface.

Unfortunately, there are some headers which use anonymous enums to
define constants (e.g. and ironically BTF). ABI tracking these types
would require something a bit hacky. Or we could just name them.

Regards,
Giuliano.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 scripts/check-uapi.sh | 102 ++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 33 deletions(-)

diff --git a/scripts/check-uapi.sh b/scripts/check-uapi.sh
index 755187f27be5..982666b48f3b 100755
--- a/scripts/check-uapi.sh
+++ b/scripts/check-uapi.sh
@@ -32,6 +32,7 @@ Options:
     -v             Verbose operation (print more information about each header being checked).
 
 Environmental args:
+    STGDIFF  Custom path to stgdiff binary - use stgdiff instead of abidiff
     ABIDIFF  Custom path to abidiff binary
     CC       C compiler (default is "gcc")
     ARCH     Target architecture of C compiler (default is host arch)
@@ -270,43 +271,78 @@ compare_abi() {
 		exit "$FAIL_COMPILE"
 	fi
 
-	local ret=0
-	"$ABIDIFF" --non-reachable-types "${past_header}.bin" "${base_header}.bin" > "$log" || ret="$?"
-	if [ "$ret" -eq 0 ]; then
-		if [ "$VERBOSE" = "true" ]; then
-			printf "No ABI differences detected in %s from %s -> %s\n" "$file" "$past_ref" "${base_ref:-dirty tree}"
+	if [ "$STGDIFF" ]; then
+		local ret=0
+		"$STGDIFF" --types --ignore interface_addition --elf "${past_header}.bin" "${base_header}.bin" --format small --output "$log" || ret="$?"
+		if [ "$ret" -eq 0 ]; then
+			if [ "$VERBOSE" = "true" ]; then
+				printf "No ABI differences detected in %s from %s -> %s\n" "$file" "$past_ref" "${base_ref:-dirty tree}"
+			fi
+		else
+			# stgdiff's return code can be used to determine the type of error
+			if [ $((ret & 0x1)) -gt 0 ]; then
+				eprintf "error - stgdiff failed\n"
+				exit 1
+			fi
+
+			{
+				printf "!!! ABI differences detected in %s from %s -> %s !!!\n\n" "$file" "$past_ref" "${base_ref:-dirty tree}"
+				sed  -e 's/^/  /g' "$log"
+
+				if ! cmp "$past_header" "$base_header" > /dev/null 2>&1; then
+					printf "\nHeader file diff (after headers_install):\n"
+					diff -Naur "$past_header" "$base_header" \
+						| sed -e "s|${past_header}|${past_ref}/${file}|g" \
+						      -e "s|${base_header}|${base_ref:-dirty}/${file}|g"
+					printf "\n"
+				else
+					printf "\n%s did not change between %s and %s...\n" "$file" "$past_ref" "${base_ref:-dirty tree}"
+					printf "It's possible a change to one of the headers it includes caused this error:\n"
+					grep '^#include' "$base_header"
+					printf "\n"
+				fi
+			} | tee "${base_header}.error" >&2
+			return 1
 		fi
 	else
-		# Bits in abidiff's return code can be used to determine the type of error
-		if [ $((ret & 0x1)) -gt 0 ]; then
-			eprintf "error - abidiff did not run properly\n"
-			exit 1
-		fi
+		local ret=0
+		"$ABIDIFF" --non-reachable-types "${past_header}.bin" "${base_header}.bin" > "$log" || ret="$?"
+		if [ "$ret" -eq 0 ]; then
+			if [ "$VERBOSE" = "true" ]; then
+				printf "No ABI differences detected in %s from %s -> %s\n" "$file" "$past_ref" "${base_ref:-dirty tree}"
+			fi
+		else
+			# Bits in abidiff's return code can be used to determine the type of error
+			if [ $((ret & 0x1)) -gt 0 ]; then
+				eprintf "error - abidiff did not run properly\n"
+				exit 1
+			fi
 
-		# If the only changes were additions (not modifications to existing APIs), then
-		# there's no problem. Ignore these diffs.
-		if grep "Unreachable types summary" "$log" | grep -q "0 removed" &&
-		   grep "Unreachable types summary" "$log" | grep -q "0 changed"; then
-			return 0
-		fi
-		{
-			printf "!!! ABI differences detected in %s from %s -> %s !!!\n\n" "$file" "$past_ref" "${base_ref:-dirty tree}"
-			sed  -e '/summary:/d' -e '/changed type/d' -e '/^$/d' -e 's/^/  /g' "$log"
-
-			if ! cmp "$past_header" "$base_header" > /dev/null 2>&1; then
-				printf "\nHeader file diff (after headers_install):\n"
-				diff -Naur "$past_header" "$base_header" \
-					| sed -e "s|${past_header}|${past_ref}/${file}|g" \
-					      -e "s|${base_header}|${base_ref:-dirty}/${file}|g"
-				printf "\n"
-			else
-				printf "\n%s did not change between %s and %s...\n" "$file" "$past_ref" "${base_ref:-dirty tree}"
-				printf "It's possible a change to one of the headers it includes caused this error:\n"
-				grep '^#include' "$base_header"
-				printf "\n"
+			# If the only changes were additions (not modifications to existing APIs), then
+			# there's no problem. Ignore these diffs.
+			if grep "Unreachable types summary" "$log" | grep -q "0 removed" &&
+			   grep "Unreachable types summary" "$log" | grep -q "0 changed"; then
+				return 0
 			fi
-		} | tee "${base_header}.error" >&2
-		return 1
+			{
+				printf "!!! ABI differences detected in %s from %s -> %s !!!\n\n" "$file" "$past_ref" "${base_ref:-dirty tree}"
+				sed  -e '/summary:/d' -e '/changed type/d' -e '/^$/d' -e 's/^/  /g' "$log"
+
+				if ! cmp "$past_header" "$base_header" > /dev/null 2>&1; then
+					printf "\nHeader file diff (after headers_install):\n"
+					diff -Naur "$past_header" "$base_header" \
+						| sed -e "s|${past_header}|${past_ref}/${file}|g" \
+						      -e "s|${base_header}|${base_ref:-dirty}/${file}|g"
+					printf "\n"
+				else
+					printf "\n%s did not change between %s and %s...\n" "$file" "$past_ref" "${base_ref:-dirty tree}"
+					printf "It's possible a change to one of the headers it includes caused this error:\n"
+					grep '^#include' "$base_header"
+					printf "\n"
+				fi
+			} | tee "${base_header}.error" >&2
+			return 1
+		fi
 	fi
 }
 
-- 
2.41.0.255.g8b1d071c50-goog

