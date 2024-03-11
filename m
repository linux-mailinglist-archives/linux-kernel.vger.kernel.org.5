Return-Path: <linux-kernel+bounces-99523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F12878993
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29461F21E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9863F5677A;
	Mon, 11 Mar 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjO8NYQI"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F73C482
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189649; cv=none; b=ZvFzHdt0/1ylr6sztj6ThvbUnt7ehNWBmwols8VjX4DLDvPgPTub3El/MmeobPCInF9uGR2edDhR37NHMfuULnAyf945pavnvu2t6b6eRyrVO0yLOcFbSkOEblcAr5CUgyc+BOjZ/KtSG/xCr240BZmoHD5TCiqqmkPDT5p1TSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189649; c=relaxed/simple;
	bh=pXQbxd5ujUmK1VVLnK8kdd1NphI/TywkGB3WoCJTJQ8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e2kkxeXtJ6aAlRbdTe3b/Wdvg/yRuS0ndERmCES1Lnmd5cGcpmq8y500J4gFInbgTrwhql9ZvEf86jkA+vV6DiE2GN9yPP9h4dSQTLdIxW4iuyANKwjWHheTwqCMyXS0T+9V8wG8wnHYba5yKfWCTH527Ngwe3vEzJON7aIJ17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjO8NYQI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4132cc37e21so6994515e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710189646; x=1710794446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4lmLduepyzOAbsVFho4Xvkct1BwmBvnsIf9kusvzWM=;
        b=cjO8NYQIAN13N+QZ2t6yBs6+ON7XySj+3+luGnBZfP+OjWJEo3lt8viAOPYpPI8h+c
         16HbVnfRO3JJ6dcU/jOynwTfom1LVkBm6qxXEz+oAElN9FzWx3qls70vvHCPXo8Thtrg
         GO5ILc9FSQVWVIMyuu2AQCqoFn3ieVKLjOztwqUHi4NMlWcXysw88VAihvDwblM0FJgQ
         ibUfnp6E55xiVlJierrU1Y2+bckG5KD983gHaLes4isnlSSVASlbqQdV76PldGUkKpgj
         FV4n2hxNC6vZcaiSnqQH6qB2LqDEfeLc1wjKamHX86QnOKrmVZ7pMM5EdCxLKQExIMN9
         P+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710189646; x=1710794446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4lmLduepyzOAbsVFho4Xvkct1BwmBvnsIf9kusvzWM=;
        b=SvaM+alGUzNEgRP9x/CQNKi4KxsNXILPW+wI5n4yvcVth0jVN8BfElij0YzarxfD2S
         OBANK5F2SZN91TdVMcoBvwgF0f+JF6nmjEr++qSMVHUg7QYrVF+gv24nHpcoha5WinIR
         0h3ZhC+1Q4ToN3qptJqk8v29BULoxzdcRhpNXOIH06qEFGRxh4j9jrkFvU83tYRNzrZ4
         DgOOjYQ7w/ne+2g3aCGHatxZFrztxFm1eZo5Y+vyVWCg5MZXpZG252nn5+JgvwdSRu3H
         PiQElKVN009UhUEQxQxQ8c5CQP3L0eBqU22FU65W/YaJpQblf/FVqHsLI+U5HmBXbZti
         E+Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXn6uhv+So0Txiw6r4yF+GYf3gLCbm1RJTDyVRizqAevwAC4tX8xeuaXVQUIFjNZgWSAjqjAyZIOGLtn4GniwHhBj8vO7TT+Nze/RL4
X-Gm-Message-State: AOJu0YzcP5Q6z11WLkfiYkv6bE7GzrkKG6NyxcM+WrY6g21ADbva1ysk
	wJj01/M2wECLsKkss9wxY45qtZwc5bEccF2CWdlWu0id1EjPfJGy
X-Google-Smtp-Source: AGHT+IE/k9nNpWaDh7aTcG9ytU2aYoM4t2KZQYJh/+tsjpCmWqscXxxPX72z7ce7dJ3mKaR9EFjXjg==
X-Received: by 2002:a05:600c:4e05:b0:413:18d9:f5ac with SMTP id b5-20020a05600c4e0500b0041318d9f5acmr6334511wmq.9.1710189646470;
        Mon, 11 Mar 2024 13:40:46 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b0041312c4865asm14929355wmq.2.2024.03.11.13.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:40:46 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH 3/7] scripts/faddr2line: Check vmlinux only once
Date: Mon, 11 Mar 2024 21:40:15 +0100
Message-Id: <20240311204019.1183634-4-bjohannesmeyer@gmail.com>
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

Rather than checking whether the object file is vmlinux for each invocation
of __faddr2line, check it only once beforehand.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 scripts/faddr2line | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index f011bda4ed25..bb3b5f03f4ea 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -115,6 +115,17 @@ run_readelf() {
 	ELF_SYMS=$(echo "${out}" | sed -n '/Symbol table .* contains [0-9]* entries:/,$p')
 }
 
+check_vmlinux() {
+	# vmlinux uses absolute addresses in the section table rather than
+	# section offsets.
+	IS_VMLINUX=0
+	local file_type=$(echo "${ELF_FILEHEADER}" |
+		${AWK} '$1 == "Type:" { print $2; exit }')
+	if [[ $file_type = "EXEC" ]] || [[ $file_type == "DYN" ]]; then
+		IS_VMLINUX=1
+	fi
+}
+
 __faddr2line() {
 	local objfile=$1
 	local func_addr=$2
@@ -125,8 +136,6 @@ __faddr2line() {
 	local func_offset=${func_addr#*+}
 	func_offset=${func_offset%/*}
 	local user_size=
-	local file_type
-	local is_vmlinux=0
 	[[ $func_addr =~ "/" ]] && user_size=${func_addr#*/}
 
 	if [[ -z $sym_name ]] || [[ -z $func_offset ]] || [[ $sym_name = $func_addr ]]; then
@@ -135,14 +144,6 @@ __faddr2line() {
 		return
 	fi
 
-	# vmlinux uses absolute addresses in the section table rather than
-	# section offsets.
-	local file_type=$(echo "${ELF_FILEHEADER}" |
-		${AWK} '$1 == "Type:" { print $2; exit }')
-	if [[ $file_type = "EXEC" ]] || [[ $file_type == "DYN" ]]; then
-		is_vmlinux=1
-	fi
-
 	# Go through each of the object's symbols which match the func name.
 	# In rare cases there might be duplicates, in which case we print all
 	# matches.
@@ -260,7 +261,7 @@ __faddr2line() {
 		# Pass section address to addr2line and strip absolute paths
 		# from the output:
 		local args="--functions --pretty-print --inlines --exe=$objfile"
-		[[ $is_vmlinux = 0 ]] && args="$args --section=$sec_name"
+		[[ $IS_VMLINUX = 0 ]] && args="$args --section=$sec_name"
 		local output=$(${ADDR2LINE} $args $addr | sed "s; $dir_prefix\(\./\)*; ;")
 		[[ -z $output ]] && continue
 
@@ -305,6 +306,8 @@ run_readelf $objfile
 
 echo "${ELF_SECHEADERS}" | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
 
+check_vmlinux
+
 DIR_PREFIX=supercalifragilisticexpialidocious
 find_dir_prefix $objfile
 
-- 
2.34.1


