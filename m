Return-Path: <linux-kernel+bounces-77434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECDE860551
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155C51F26D22
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564213792D;
	Thu, 22 Feb 2024 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+p407jN"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988B12D20E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639260; cv=none; b=NLiw4+MB1nBxyzSCaJ1n++BwEbhhyC60m/0oYmqifABqqF50Swp1AXZZ1q7P6eN5Io/M5LtzKQoF9enVl3/aeCNYTuEZkwJAKN13k12jmVv3mdt0mvSpAZBbz9V5mkkUp/wDadIlRzFigjCwAtIc7K1t9W42NgNtRZGBXPi9V/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639260; c=relaxed/simple;
	bh=UGxgHq7SGP8k5JaOrHY0DZqOtzZutiNCD5ult3MMLBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=unUwIiATtAXeAT4SMsvJ4MLKeQVYkq5lWYwBejOs4NMYBnOzWq7xK4e/5+zNYXDSyIDdrrxsechllkKIXLRdq2uSt0J5EEDzUDk9xDdwI2ucyENNg5NddpF4TXv9zNQ/gAPPuZY2C+QL+coAA75FXW4Eqr5QVqiEHw3Vf+CXSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d+p407jN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2997a92e23bso239721a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708639256; x=1709244056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3huveT0qUmlhJikw9NWYKFn9utf763+YTzbXHUOY1cM=;
        b=d+p407jNS/kXodWtcM54K9gicgAo2RCVlOeK7QBkwt5cc4ax9oP9QPaUFKeIlbaapW
         7kIl7ee4qPQDOpjAfFaiKt0XtvOBMK3TK+YrruIzdrGJ9w3Te1GGKH59lvwYM4rsWZk2
         B7Wbu5hk3B0v+xCcHEDOvTywvBhsmg5Tm+0Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708639256; x=1709244056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3huveT0qUmlhJikw9NWYKFn9utf763+YTzbXHUOY1cM=;
        b=UIYyGi1Byw11jU/B0APX8cGptyWSe+/R4u6z9zVPDMQMGc6Z3bg2ABIdJ6jCC49UjY
         OnKLBIVTb9/T+8tjDqqSHyitaCCmpHVv5IDpBnGLJZZaRMJhXNRU5tB5TnLsU0UQ8Mxc
         tks90Wupg2WeDXcW/PVRvLOqzugJC2zZ+xd7GYjplotjSdnqngogoIN4XtNIpcBijodu
         2XWM9MUnj4ogzLejz1T24CLCdaVZBVjFoUeHyI9F//Xp+9zFOorqnN/3b4fR13r0E1Uo
         6Nm6gQEcDXkpSWIy2rgkj+oHlDhcE284mWzaTq5EmdMWKdwdupwkMtuAz+GroYQSbyte
         FlwA==
X-Forwarded-Encrypted: i=1; AJvYcCWsxRKiwGSLlG5ml7IFY+VAsOFvwoST9JIanJBK8O7ZTi9Vj+5ZamB6ptNFJqkaotUKNRc47Xf3xWsIK9FeFjhJNYuZIpeD827EgMX+
X-Gm-Message-State: AOJu0YzeLZVNrivNmdqD3EyMz0FtNun3bVkNB47a6Yq0gGvKFnqtIvZW
	twk1TYVFX7DJrkUJyLjJU8BiD/uAYdGKkdil/Y+01+QyEx7y4XgCvhyQywMfM6rdRXpa3hWVMXo
	=
X-Google-Smtp-Source: AGHT+IEdWlhdLG6iclrJsKpOlJCvSNrL2kdJfuiiP0i00MbyLgiP7f0DyRoxwrVrkpzLEpPv+J02Kw==
X-Received: by 2002:a17:90a:e98f:b0:297:17fb:4d79 with SMTP id v15-20020a17090ae98f00b0029717fb4d79mr101708pjy.2.1708639256048;
        Thu, 22 Feb 2024 14:00:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z19-20020a17090acb1300b00296e2434e7esm12555123pjt.53.2024.02.22.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:00:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Kees Cook <keescook@chromium.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	linux-hardening@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] leaking_addresses: Ignore input device status lines
Date: Thu, 22 Feb 2024 14:00:50 -0800
Message-Id: <20240222220053.1475824-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222215755.it.764-kees@kernel.org>
References: <20240222215755.it.764-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3371; i=keescook@chromium.org;
 h=from:subject; bh=UGxgHq7SGP8k5JaOrHY0DZqOtzZutiNCD5ult3MMLBE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl18QTepsFkxDUunQkauTY9LXl/JFwdo6t+IYy0
 EMBYfndTweJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdfEEwAKCRCJcvTf3G3A
 JnjMD/9yj39MZOjlEWxLkUIX/oXvqJMpGF2DoPIdz9/TS7bx9UjR3LCLoODWqkCnMrlzZJXv0Oe
 1UMUwpCnebB8xkbHXRWVMS/Trqpct+hMHW5BcTDzCPa6k3/f5mNIi1McaCwn8GPOjGK2sGMYHBc
 kzJp8uW5a1kO7Qlj3BWzi9H7vehUf2olWjn7lwLZsQFQPtaMWEEgjvfgdNV/HV4EUdplSPue8KZ
 2qA3HNR+Pwo3qNsaz3rMw5yTM1wHK/AmgcPpnnmejB/MJ7DStG4o1xIaN+jIKV8AlESI2K8/OhJ
 +wV13iKTocEFZLjnGkfYN2MBcrOwCLZGBmK8gofm5lTvFw8wSkpPMPPUhc9+lccM4bfd3a5pwJN
 TwwaS20rYLSbnk08V5+Bx72SQ4cyYwqb6OQthxH8VqZF40vmlwu7Y0SPC1wTGlWDlBcWKXdVcnZ
 S1IwH67y/0MMbNJjqf8P2NWIl0SpoMILxBtGV2B6tzqUxuY2lJTTGNpv/1PNkC9hNOT4SD/+xqr
 M0ZJClQciikw3Tx31XnjPYOi4SSfr2vGip/ohsMVMMGWzqwVJe8kEnUF4WkDzU9nzXBDwKNOatm
 auwhPRF49kzemOIeLhzX2GpMO4o3DJn6VeZxqEQCu6ahfpc6KsHkuI8f//D8hV1RFzGPIIzPlzK enNnq/xE8BfARww==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

These are false positives from the input subsystem:

/proc/bus/input/devices: B: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
/sys/devices/platform/i8042/serio0/input/input1/uevent: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
/sys/devices/platform/i8042/serio0/input/input1/capabilities/key: 402000000 3803078f800d001 feffffdf

Pass in the filename for more context and expand the "ignored pattern"
matcher to notice these.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: "Tobin C. Harding" <me@tobin.cc>
Cc: linux-hardening@vger.kernel.org
---
 scripts/leaking_addresses.pl | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index dd05fbcf15c5..73cfcc5c8854 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -284,9 +284,10 @@ sub is_false_positive
 		return is_false_positive_32bit($match);
 	}
 
-	# 64 bit false positives.
-
-	if ($match =~ '\b(0x)?(f|F){16}\b' or
+	# Ignore 64 bit false positives:
+	# 0xfffffffffffffff[0-f]
+	# 0x0000000000000000
+	if ($match =~ '\b(0x)?(f|F){15}[0-9a-f]\b' or
 	    $match =~ '\b(0x)?0{16}\b') {
 		return 1;
 	}
@@ -303,7 +304,7 @@ sub is_false_positive_32bit
        my ($match) = @_;
        state $page_offset = get_page_offset();
 
-       if ($match =~ '\b(0x)?(f|F){8}\b') {
+       if ($match =~ '\b(0x)?(f|F){7}[0-9a-f]\b') {
                return 1;
        }
 
@@ -346,18 +347,23 @@ sub is_in_vsyscall_memory_region
 # True if argument potentially contains a kernel address.
 sub may_leak_address
 {
-	my ($line) = @_;
+	my ($path, $line) = @_;
 	my $address_re;
 
-	# Signal masks.
+	# Ignore Signal masks.
 	if ($line =~ '^SigBlk:' or
 	    $line =~ '^SigIgn:' or
 	    $line =~ '^SigCgt:') {
 		return 0;
 	}
 
-	if ($line =~ '\bKEY=[[:xdigit:]]{14} [[:xdigit:]]{16} [[:xdigit:]]{16}\b' or
-	    $line =~ '\b[[:xdigit:]]{14} [[:xdigit:]]{16} [[:xdigit:]]{16}\b') {
+	# Ignore input device reporting.
+	# /proc/bus/input/devices: B: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
+	# /sys/devices/platform/i8042/serio0/input/input1/uevent: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
+	# /sys/devices/platform/i8042/serio0/input/input1/capabilities/key: 402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
+	if ($line =~ '\bKEY=[[:xdigit:]]{9,14} [[:xdigit:]]{16} [[:xdigit:]]{16}\b' or
+            ($path =~ '\bkey$' and
+             $line =~ '\b[[:xdigit:]]{9,14} [[:xdigit:]]{16} [[:xdigit:]]{16}\b')) {
 		return 0;
 	}
 
@@ -400,7 +406,7 @@ sub parse_dmesg
 {
 	open my $cmd, '-|', 'dmesg';
 	while (<$cmd>) {
-		if (may_leak_address($_)) {
+		if (may_leak_address("dmesg", $_)) {
 			print 'dmesg: ' . $_;
 		}
 	}
@@ -456,7 +462,7 @@ sub parse_file
 	open my $fh, "<", $file or return;
 	while ( <$fh> ) {
 		chomp;
-		if (may_leak_address($_)) {
+		if (may_leak_address($file, $_)) {
 			printf("$file: $_\n");
 		}
 	}
@@ -468,7 +474,7 @@ sub check_path_for_leaks
 {
 	my ($path) = @_;
 
-	if (may_leak_address($path)) {
+	if (may_leak_address($path, $path)) {
 		printf("Path name may contain address: $path\n");
 	}
 }
-- 
2.34.1


