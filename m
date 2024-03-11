Return-Path: <linux-kernel+bounces-99525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B435878995
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1C41C20BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF4C5810A;
	Mon, 11 Mar 2024 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXRyM176"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA90B56B85
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189652; cv=none; b=BSUEhP1y7y+TY/DU1SxZ7YLxYRspyelbP8a8sTKcx4BTlYHWbTQK76TnaK4keKeMEmQIJv+wvQrjIKEnpEjm1RFF/mYeLJ478UTTu+vOqKmuTZeEJlZtvtydYvO9vuSdvQ1/RSLL7qIKlAaVYHqxMaknwHripT0y1y7tU7EwF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189652; c=relaxed/simple;
	bh=OahGgLwn1WruEUcGd+tWfxyPUOLyjubgiXZOePzWu+g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ClU8y3XO7KfgkKnNrvd51gLL6OLmZaF89PiD1G1ltjEKsODn1Qk1gAhwjsBK0tzjxvkVgKkAI4+wwNcjbgIWj2p7IWs5TSKisqwRML1lnu2YvVUVDuHp6RzFAVG+6M41eZVtAu89FjBFVsOi0vj2UVVpEhpw5N1Pm425DDshngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXRyM176; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4132a4b0971so7225165e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710189649; x=1710794449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sp2H2ET381pFnni6E350xwNwIeOypPbNT863TXJ2TvQ=;
        b=NXRyM176CV2yIqQl+P1MP+w0ukdvv5GIHwT/ytEacVpN0Md2oJ3vqfYr0VCFkb4q5B
         oMUzQfHhpEtbQJ/TXf9Yn43AIWJb6ggFY5cG+tcRcdjCQv7asSP59RzBTjXVc/RHfu/h
         9K0NeslZMx/H2EWFun+OaAatRAU1eerDgQekR+b1LeCV2gVzz4jmeYk3+CWdqWG6VF7d
         ZtAM0HZgrgBD1/+s1AU2R5Npfe5paYOYBa3b+2vKwfLQuaFUzQB9i91e4A3iTOqL9S18
         eXNcxFEX+BxGSK/lE1VbcI1l/LJ1MVFBBaimrKE+rlQXu//UgWU8sR8sFrFY7sc8/f3L
         zPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710189649; x=1710794449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sp2H2ET381pFnni6E350xwNwIeOypPbNT863TXJ2TvQ=;
        b=OHCVErhbMlDfUeDiRUO1uG5IqoecXMS2q4qIW6uTafUyRNuE4K0CVwyMwIosI7v2ad
         veVA3udRvn6MAa7AsI/zvMGg1cf9rb6FNP8eagzoaiCIKAlDeJbZTlTZh2f/0d9n/Nnw
         etK5jWhjaeKFJg6vEErSUTSeR4s2soKJ0pZEDbZVn+0ihZRMtoj9Vei1z389iSB4UkPu
         XO0BZSo5rgjgX0+1kyEVR4yhPETZjFm4976OI8Beiec5Q2OQ6z6ZFL2itZ+1d7oqp6Ih
         T9kYmbryPzC6nQfQM4RtfAUGviAsU3Mou3VJ2W3kEh7lAMqmJPct8NTMyMi7MyupFLjG
         M9fg==
X-Forwarded-Encrypted: i=1; AJvYcCUOqj7tf3cBYuI4EKnvUjgCRE7ujixMTsep8YZtygpp5pqBeIsPYmuBd0Mmv1zejluMTAVMQ/A4LPw4g1FDYUdlkulf0s459DcFsXx8
X-Gm-Message-State: AOJu0Yxar7F429iV7q5zQzICn5S/VqOs1Eiy7Z1waTu+CscPIHGTRY8W
	cH/OGOf3Bn8JAYmHhwZ3QERF0oPe346kRO4OssT+mgf+L3BwqJ2Q
X-Google-Smtp-Source: AGHT+IHRrjPPv/xgojeoeEzLF4rYCcuxVrt70i875S2vX54csiZ0R5lKjsdvEP4YCfYUCbXPQCcysA==
X-Received: by 2002:a05:600c:3c9e:b0:413:c1d:af44 with SMTP id bg30-20020a05600c3c9e00b004130c1daf44mr6925185wmb.41.1710189648903;
        Mon, 11 Mar 2024 13:40:48 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b0041312c4865asm14929355wmq.2.2024.03.11.13.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:40:48 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH 5/7] scripts/faddr2line: Invoke addr2line as a single long-running process
Date: Mon, 11 Mar 2024 21:40:17 +0100
Message-Id: <20240311204019.1183634-6-bjohannesmeyer@gmail.com>
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

Rather than invoking a separate addr2line process for each address, invoke
a single addr2line coprocess, and pass each address to its stdin. Previous
work [0] applied a similar change to perf, leading to a ~60x speed-up [1].

If using an object file that is _not_ vmlinux, faddr2line passes a section
name argument to addr2line. Because we do not know until runtime which
section names will be passed to addr2line, we cannot apply this change to
non-vmlinux object files. Hence, it only applies to vmlinux.

[0] commit be8ecc57f180 ("perf srcline: Use long-running addr2line per
DSO")
[1] Link:
https://eighty-twenty.org/2021/09/09/perf-addr2line-speed-improvement

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 scripts/faddr2line | 52 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 820680c59a39..48fc8cfc80df 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -126,6 +126,48 @@ check_vmlinux() {
 	fi
 }
 
+init_addr2line() {
+	local objfile=$1
+
+	check_vmlinux
+
+	ADDR2LINE_ARGS="--functions --pretty-print --inlines --addresses --exe=$objfile"
+	if [[ $IS_VMLINUX = 1 ]]; then
+		# If the executable file is vmlinux, we don't pass section names to
+		# addr2line, so we can launch it now as a single long-running process.
+		coproc ADDR2LINE_PROC (${ADDR2LINE} ${ADDR2LINE_ARGS})
+	fi
+}
+
+run_addr2line() {
+	local addr=$1
+	local sec_name=$2
+
+	if [[ $IS_VMLINUX = 1 ]]; then
+		# We send to the addr2line process: (1) the address, then (2) a sentinel
+		# value, i.e., something that can't be interpreted as a valid address
+		# (i.e., ","). This causes addr2line to write out: (1) the answer for
+		# our address, then (2) either "?? ??:0" or "0x0...0: ..." (if
+		# using binutils' addr2line), or "," (if using LLVM's addr2line).
+		echo ${addr} >& "${ADDR2LINE_PROC[1]}"
+		echo "," >& "${ADDR2LINE_PROC[1]}"
+		local first_line
+		read -r first_line <& "${ADDR2LINE_PROC[0]}"
+		ADDR2LINE_OUT=$(echo "${first_line}" | sed 's/^0x[0-9a-fA-F]*: //')
+		while read -r line <& "${ADDR2LINE_PROC[0]}"; do
+			if [[ "$line" == "?? ??:0" ]] || [[ "$line" == "," ]] || [[ $(echo "$line" | ${GREP} "^0x00*: ") ]]; then
+				break
+			fi
+			ADDR2LINE_OUT+=$'\n'$(echo "$line" | sed 's/^0x[0-9a-fA-F]*: //')
+		done
+	else
+		# Run addr2line as a single invocation.
+		local sec_arg
+		[[ -z $sec_name ]] && sec_arg="" || sec_arg="--section=${sec_name}"
+		ADDR2LINE_OUT=$(${ADDR2LINE} ${ADDR2LINE_ARGS} ${sec_arg} ${addr} | sed 's/^0x[0-9a-fA-F]*: //')
+	fi
+}
+
 __faddr2line() {
 	local objfile=$1
 	local func_addr=$2
@@ -260,12 +302,8 @@ __faddr2line() {
 
 		# Pass section address to addr2line and strip absolute paths
 		# from the output:
-		local args="--functions --pretty-print --inlines --addresses --exe=$objfile"
-		[[ $IS_VMLINUX = 0 ]] && args="$args --section=$sec_name"
-		local output_with_addr=$(${ADDR2LINE} $args $addr | sed "s; $dir_prefix\(\./\)*; ;")
-		[[ -z $output_with_addr ]] && continue
-
-		local output=$(echo "${output_with_addr}" | sed 's/^0x[0-9a-fA-F]*: //')
+		run_addr2line $addr $sec_name
+		local output=$(echo "${ADDR2LINE_OUT}" | sed "s; $dir_prefix\(\./\)*; ;")
 		[[ -z $output ]] && continue
 
 		# Default output (non --list):
@@ -309,7 +347,7 @@ run_readelf $objfile
 
 echo "${ELF_SECHEADERS}" | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
 
-check_vmlinux
+init_addr2line $objfile
 
 DIR_PREFIX=supercalifragilisticexpialidocious
 find_dir_prefix $objfile
-- 
2.34.1


