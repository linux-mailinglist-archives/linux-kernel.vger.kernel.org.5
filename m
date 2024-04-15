Return-Path: <linux-kernel+bounces-145398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2EA8A55B3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D8C1F21922
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170DF7F490;
	Mon, 15 Apr 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSQVhoD7"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0878C8B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192951; cv=none; b=qnO2rj4b9k9FRKsQ2CjbpqpoFhG5CXkYt6PRDo5TTl7fT/tK2rn5PMKybNXHwHcxp41e9syoDu6Cf0cGpqM/09yJHF7fzU3P/nvVNJUGqVVZ1lwvvbOE/4KWPTem7rsHoFYhPOKWiSHmd9bxw2vrS9wgYPRN7+/jhRKIRPgjkGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192951; c=relaxed/simple;
	bh=OahGgLwn1WruEUcGd+tWfxyPUOLyjubgiXZOePzWu+g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIkOD97VQfn1yIj+j8I5lIgO1XWP0lLWX9fR0PO3s0xYR5G22W4A5Djr2LjE2iKxfQgNwf1w+3LY3fZm7h/ixQGKjlb/fBbCSCvu0ZyMGZDLfhdJ+udHJ4u+Pq7eWYDDVnUm/jk+LaC/AOToGnQ5jCQLzGwVsnZQNApVh/7kVkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSQVhoD7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso5231211a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192948; x=1713797748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sp2H2ET381pFnni6E350xwNwIeOypPbNT863TXJ2TvQ=;
        b=HSQVhoD7fqkI23Z/5tZw1Nueg99vXX670qZXFESbj4zFnLcDtnLCzL7+sjWSc31Yrs
         EgzPqy2zjl5IGlaMOPmQzoCCkq+OyW/ygx6QuniwYNiQ5DT06IJD6p9ngFrP/zTmhKTN
         YFdUdWldCjISl5dSAdExkGfYJmDZulAFuncUp+Z27mQADI8LOmlBWDtR5Nj6z0cNKROO
         NIZHTqFSowpozlnOT8G0jW3HJa3BfiWXM/bBq/4bZhakXbxCgdB8odSVOBhXVlphhamz
         fLft+by27onUlQ2KiAoDCx8wdCktpPHEkTuskHkG0h1gEadhrrFHq2Y5chYgrQ7APtLR
         Lvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192948; x=1713797748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sp2H2ET381pFnni6E350xwNwIeOypPbNT863TXJ2TvQ=;
        b=W4SAmyOKMrqzcOmtXo2/HC7ZjI6H/FkPYy/jvlXHf70TbIQXJ0nZwKLDdCCzazw15N
         RzZu3oZud5QKd8b4iihWJHbbmPwbzA5FXWb8I0ew65sd+STEa9DxpmvKBTS5BPKAEkBn
         Uf8IudHWMXDfIYT0Fq+g3O7mB5HJyc2WrUIbnpmg8PoG/RObHxtPhaxuYmXt7u5eafdp
         SPsx9OOqOL3aJZGUUuGuLsw9wW1NKHqrytVBixnKjarQHRfawZbtDlAcpBZBI90F4ljH
         fZ6iYDoQIk+7FoMNF88VAIovXgoDY7l87zgUnFB5RuyE/5myp/74n4yQ13io/Q1RGS3M
         C+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVzsyUB7/bHdNu833DOQoWSi9FmBQ9lDinEcxJZThO19q8fHWTfeBHWMf722hS/HYtdTlOA1xmb/Or7kA21W8X4d1bblqntuj77BAtH
X-Gm-Message-State: AOJu0YypOuNcoUi2B8qkrecnUcWSRuhuYWuP5GOLQnEG4mQikFGlpACO
	sePxnoyQHsTFvliOE+0Qr2FD/dLoXSXseNM75hLOXWExPNylnPkq
X-Google-Smtp-Source: AGHT+IFizmWo4Lb1btI5ptwlOy2njpvjVXh+D4maTTjLEIDZQ60pCHU2Dp/6SCKytP0DP4HVC3s2HQ==
X-Received: by 2002:a50:d598:0:b0:566:f5d6:4b4 with SMTP id v24-20020a50d598000000b00566f5d604b4mr6818230edi.12.1713192948220;
        Mon, 15 Apr 2024 07:55:48 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id s13-20020a056402520d00b0056bf6287f32sm4893415edd.26.2024.04.15.07.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:55:47 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH v2 5/7] scripts/faddr2line: Invoke addr2line as a single long-running process
Date: Mon, 15 Apr 2024 16:55:36 +0200
Message-Id: <20240415145538.1938745-6-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415145538.1938745-1-bjohannesmeyer@gmail.com>
References: <20240415145538.1938745-1-bjohannesmeyer@gmail.com>
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


