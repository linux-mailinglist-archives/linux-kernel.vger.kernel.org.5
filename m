Return-Path: <linux-kernel+bounces-99521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CE9878991
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BC31C21043
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A284D5B0;
	Mon, 11 Mar 2024 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1O69mAc"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDAC1DDFA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189649; cv=none; b=c6EuT/wL0K7E9LMCgO4V8ezd0LpiTjSft63qDBHOk2Z8leziSW3xFcW9Ya+YdNj0Vlt70F90Fvapryf7ZglqLL6aBPEZOhfuSo7NB49vJ4fMejgeIS1miM6gPO9P6/WKAESxMh/DFwbwzLW7Zl7HYkUzk4cbjxTjBfklDBoLQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189649; c=relaxed/simple;
	bh=9OWRJdkAv7cHnWuVRgo+tbzxoUOMQDC00S++Chf+Sns=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4YR9Tp2jCMgHvZx5dxNzlhBrzn+HP34+BH/YwtnHhUUT7CyWZM94N3oGdt2q0V+yWw0F0+SFFgj8nObHeTCT5tR4uTq87yaw6GId+UdaeezQHipQ/ykAqhkm1yYX+bxTIwtOrwASACKJe9tXgR2mvANbkApi8e+f/4+nrPhQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1O69mAc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4132600824bso9902565e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710189646; x=1710794446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTVNNfo5/Y61rhM7u0Y0ocSrSY3U2WS9X7F9mo8CMy4=;
        b=h1O69mAcICA4AHdTcSn77eI6whnFZzh0g9D944iLZDrncQrrKumIj/4H9pJc2Khjup
         MuykPPN16lSto7FXc0fjkhVkZym1A3wLfQoLLvsiDO75RkWgNY8s8zOgtNtHLPqaL9oy
         1IUDIwTAjmj1wj7csMtmG0vQZbJ6j7gzzL0YduqpZbHS+LzzcE41z3N/wdX7xgb3k2b3
         jfB4GJN3CXoDT674p8RCM6JlQ/2QwdbfFQANGbHYDehON9s3HAfvIvdSiTJ/lmpn5txK
         u3xgwbR1DaBE0mJmqPxrcoX2urXDM47ZmOO7Xtvvz1G/eB3c8VlEls2gqbYcSOSoqZwD
         Vy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710189646; x=1710794446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTVNNfo5/Y61rhM7u0Y0ocSrSY3U2WS9X7F9mo8CMy4=;
        b=c9pk5RUaPHCnce1PVdqFjAc+1wP1ZHg7sItPkP5zxA7RTv2vD8E8rO16kstAwAIaag
         8u51L9pioFWM9rDBmMzTQvRpDh0HN8y8B7ZL+hbl5xgj3uvcyUUUR4To0fM/4NAHqbHx
         uLfNTOzSIdKZIpW30i0OkgG/CiFRvKW5Qf7Zv+qkT/imgsKFjsXEB2o629cMYWoVeUdd
         d6S0DFPw5dzK3ujgOr1BxR+R1FLMbJzMK6/U67mCsjq7WBOHN7n5Ryh6Wi7WivBAa7qw
         bdB62te2UpLaO9LNNxlW9FLrIyJAcLGdkBtQAaxc2OH1c5KK0mMIXAzdwqnlVaiqq/dq
         cFIw==
X-Forwarded-Encrypted: i=1; AJvYcCXq9fCya8zSwcidAoV6JD8PrAVT1IPoBGaqaXf/9HWdojlsHUQeFtipnkSyFzC3idabLdV1PR5bzdWz7oRRonp5LHS0jPAw1XKZwhS+
X-Gm-Message-State: AOJu0YzQFlxV/fo13CvFH3LNRJQrOcEhQr6Iul47BbwjxOFlWNkMEGz5
	SxCHPkKOZCxanUF2KUs8NGDgyrRGm1HGKMG3s1gmzLNuq9Vky7H7Z0SGye6Y3s8=
X-Google-Smtp-Source: AGHT+IGvTnmoa5Cz9WQRFC4IZp9WkJ12JdmA9Uz+ctrXAr5ntxnSxjKEA1HkmgAT2KlKBZ3+F2c3JA==
X-Received: by 2002:a05:600c:350b:b0:412:f065:5c4f with SMTP id h11-20020a05600c350b00b00412f0655c4fmr1108683wmq.29.1710189645688;
        Mon, 11 Mar 2024 13:40:45 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b0041312c4865asm14929355wmq.2.2024.03.11.13.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:40:45 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH 1/7] scripts/faddr2line: Reduce number of readelf calls to three
Date: Mon, 11 Mar 2024 21:40:13 +0100
Message-Id: <20240311204019.1183634-2-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
References: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than calling readelf several times for each invocation of
__faddr2line, call readelf only three times at the beginning, and save its
result for future use.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 scripts/faddr2line | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 587415a52b6f..bf394bfd526a 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -87,7 +87,7 @@ command -v ${ADDR2LINE} >/dev/null 2>&1 || die "${ADDR2LINE} isn't installed"
 find_dir_prefix() {
 	local objfile=$1
 
-	local start_kernel_addr=$(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' |
+	local start_kernel_addr=$(echo "${ELF_SYMS}" | sed 's/\[.*\]//' |
 		${AWK} '$8 == "start_kernel" {printf "0x%s", $2}')
 	[[ -z $start_kernel_addr ]] && return
 
@@ -103,6 +103,14 @@ find_dir_prefix() {
 	return 0
 }
 
+run_readelf() {
+	local objfile=$1
+
+	ELF_FILEHEADER=$(${READELF} --file-header $objfile)
+	ELF_SECHEADERS=$(${READELF} --section-headers --wide $objfile)
+	ELF_SYMS=$(${READELF} --symbols --wide $objfile)
+}
+
 __faddr2line() {
 	local objfile=$1
 	local func_addr=$2
@@ -125,7 +133,7 @@ __faddr2line() {
 
 	# vmlinux uses absolute addresses in the section table rather than
 	# section offsets.
-	local file_type=$(${READELF} --file-header $objfile |
+	local file_type=$(echo "${ELF_FILEHEADER}" |
 		${AWK} '$1 == "Type:" { print $2; exit }')
 	if [[ $file_type = "EXEC" ]] || [[ $file_type == "DYN" ]]; then
 		is_vmlinux=1
@@ -143,8 +151,7 @@ __faddr2line() {
 		local sec_name
 
 		# Get the section size:
-		sec_size=$(${READELF} --section-headers --wide $objfile |
-			sed 's/\[ /\[/' |
+		sec_size=$(echo "${ELF_SECHEADERS}" | sed 's/\[ /\[/' |
 			${AWK} -v sec=$sym_sec '$1 == "[" sec "]" { print "0x" $6; exit }')
 
 		if [[ -z $sec_size ]]; then
@@ -154,8 +161,7 @@ __faddr2line() {
 		fi
 
 		# Get the section name:
-		sec_name=$(${READELF} --section-headers --wide $objfile |
-			sed 's/\[ /\[/' |
+		sec_name=$(echo "${ELF_SECHEADERS}" | sed 's/\[ /\[/' |
 			${AWK} -v sec=$sym_sec '$1 == "[" sec "]" { print $2; exit }')
 
 		if [[ -z $sec_name ]]; then
@@ -197,7 +203,7 @@ __faddr2line() {
 				found=2
 				break
 			fi
-		done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
+		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
 
 		if [[ $found = 0 ]]; then
 			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
@@ -278,7 +284,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$8 == fn')
+	done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$8 == fn')
 }
 
 [[ $# -lt 2 ]] && usage
@@ -291,7 +297,9 @@ LIST=0
 [[ ! -f $objfile ]] && die "can't find objfile $objfile"
 shift
 
-${READELF} --section-headers --wide $objfile | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
+run_readelf $objfile
+
+echo "${ELF_SECHEADERS}" | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
 
 DIR_PREFIX=supercalifragilisticexpialidocious
 find_dir_prefix $objfile
-- 
2.34.1


