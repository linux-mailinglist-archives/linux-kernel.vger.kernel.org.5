Return-Path: <linux-kernel+bounces-60616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 330DA850779
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5775D1C21A19
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D795FF08;
	Sat, 10 Feb 2024 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZgGtHSlM"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913864CF6
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609088; cv=none; b=J1SsMQwokzk3Zx6v0nUNMoRu6giY+Dbr/tpc3CYUkwpPyxT0HXMyXxyBaS/bezYYpJ6o2aoHfJ7P9g8we6WON0e+vBft8td1OT9w81u7t92hWVUU/WhYPMe4zYnDd+sikqN+LtibDg+G/wbqAAHJnUNbjaSAVGUZJP7JGti8LQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609088; c=relaxed/simple;
	bh=BgpJuFbGh1uswlxIaHPo2wvw9RKXh2Tg8JfjcMwd1b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bV18MIlZFDCV/lzYbTe22VDdK4RUHYqrCPaoZWSVgQSbspHmfyttOm9wHgmZ1rtS9nxpFr7RalX8EIm/CNST+z/rMLw8psHNEInFpgIzbrJwFQnqeV/0oDfnZa1uM6TcAoKNToH7uUgroPNNl6apCkfXVrFrHOhDJSyFaTlLP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZgGtHSlM; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-51168addef1so3887340e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609084; x=1708213884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fePKdpvwVIgbzeITeSRDnfaI3pNosmqbiOFvtjCGd4=;
        b=ZgGtHSlMBHdlXSSArbiLbydJUD17HeurhXehlb2xa1YwEdiThxXw9oju9fgkStt+4S
         ZRxH8mg4k7ofhhy9d5fWt+b/EtM/SSoCXOb9hZZmZOfq+q1aP68cP0bbyQdP2bqP5McT
         QxbDVpQOoZXSdnO5+PFE7pPIc4ayqxWcVzyk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609084; x=1708213884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fePKdpvwVIgbzeITeSRDnfaI3pNosmqbiOFvtjCGd4=;
        b=uKOIp/vg4ucD25aGyIXsnlfSqoKMBxMNfjoNQw/4jgNwfy1c3jHdBQkGoT1JFIOqws
         yFG9LHdAuwHyLWPXx/iTytHClxqwGNYtcefEml0r/WiYvK4ZsPCChiC+fhoqh1mtPvi+
         bW7KxHDLdssYgEvkJ3Per6yHKBFBmECqrac9ul9336+Yc8GO9I4dLNFwkjHQbNPnd9QI
         SQWadNVlZ3ojpRg+grnPK5IGpMhOGlvBgHHA3Im2OGDN+cXVQsXIkjGgZMKe22FqhNdI
         7ZTdBak1eTvUfUJK9b9jHhgYMurNXFXMsM4YHy+2S4N2zt9EJQ6Fs7WX2oB/D+0lJeBc
         Gm4w==
X-Gm-Message-State: AOJu0YwFMyI0Cvs+498ZtKlHtrHUNnCXEnJ+Lbv4pwik/Lp0WL1VqtMn
	FgZ6iH0wB2w+XOXE/i7nrP7Fw1+AQBSGPLc1b/8Q44XxV/tTWa4eNpLjIjs+
X-Google-Smtp-Source: AGHT+IH3kiLAVwUDBpnlLlB///1mHF0xSi63b3pr/4UHDALv0F6GrYXIgV6pYsrUTvTSpTU6m/hvvw==
X-Received: by 2002:ac2:485b:0:b0:511:5ef9:ebb0 with SMTP id 27-20020ac2485b000000b005115ef9ebb0mr1792496lfy.25.1707609084554;
        Sat, 10 Feb 2024 15:51:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVe25uHF/Y6h5rhYjF7VhDkIljr93LL8p0J1F3LUwmAn/7U9VPhzTn/QCvhBXbjahw0V3qcMX0aw1kZU658PZh4oLCCYR3KmuEiJJw9a6XaZJnicBA2Ly4oilWLX2VKAixMLmou78F1vdvwei+pM8GGFvCxBWbXns8SJNbNabpmt23RsdMn2Lf7iRGISBK1xPHAJcK+/2q6lA8DhRUZBeFEfIzOk1FfSzhqKkw/ivPY4pQA2GJAS9jGs3XmewRKzxa/IgASN651oYd8S9Vp0QXUEgXy5m89gXVpS9h4xyZJWAGGULs1HPUpTWui+Q09vsa3462QT+Gykelb8HkZ54eiQB82x8f8pR8fbaMMc5Ees2dRUW/5udtR7dOghbogBsBplVQSGYSFrVQ9v2J/TG1IIIurutHekjF3Cxfw80Atlpvl48Cu3S7DAorBIqU8juja95tCwpijBiLQ25MKJlFMhLjlRtWpvwC7U19TJyeLZaGEJV8PnqHtvmU8FXaWRhiW2jZNOvvOBDJgkV6HTfFM2D8LYaxBdltM1Yn2nJNFcJavYekToXJu+lb/C4Jlj2Xk7zqhVpYxiI9nPZG1xHOxWpbnVnp/2cyhmec3Jo6iJGN7eA==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:24 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@google.com>,
	Yaniv Tzoreff <yanivt@google.com>,
	Benson Leung <bleung@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simon Ser <contact@emersion.fr>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@semihalf.com
Subject: [PATCH v4 33/39] dyndbg-test: setup environment for tests execution
Date: Sun, 11 Feb 2024 00:50:03 +0100
Message-ID: <20240210235009.2405808-34-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210235009.2405808-1-ukaszb@chromium.org>
References: <20240210235009.2405808-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add function setup_env_for_tests which prepares dynamic debug
and trace environment for tests execution. This is to clean up
previous settings or leftovers after a failing test. The function
setup_env_for_tests does the following to prepare the environment:
- unloads test_dynamic_debug, test_dynamic_debug_submod modules
if any of them is loaded,
- it prints info about all callsites which have flags != "_" and
sets these flags to "_:0",
- it closes open trace instances and deletes their respective
directories.

The patch also refactors ifrmmod function.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 36 +++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 86bb039df4a1..f8b81e8a3bd6 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -147,8 +147,8 @@ function error_log_ref {
 }
 
 function ifrmmod {
-    lsmod | grep $1 2>&1>/dev/null || echo $1 not there
-    lsmod | grep $1 2>&1>/dev/null && rmmod $1
+    lsmod | grep $1 2>&1>/dev/null || ([ "$2" == "-v" ] && echo "module '$1' is not loaded")
+    lsmod | grep $1 2>&1>/dev/null && rmmod $1 && [ "$2" == "-v" ] && echo "unload module '$1'"
 }
 
 # $1 - text to search for
@@ -657,6 +657,37 @@ function test_private_trace_fill_trace_index {
     check_trace_instance_dir trace_instance_63 0
 }
 
+# prepares dynamic debug and trace environment for tests execution
+function setup_env_for_tests {
+    echo -e "${GREEN}# SETUP_ENV_FOR_TESTS ${NC}"
+
+    echo "MODULES"
+    ifrmmod test_dynamic_debug_submod -v	# unload test_dynamic_debug_submod module
+                                                # if it is loaded
+    ifrmmod test_dynamic_debug -v	# unload test_dynamic_debug module it if is loaded
+    echo
+
+    # display all callsites which have flags != "_"
+    echo "CALLSITES with flags != \":0\""
+    cat /proc/dynamic_debug/control | grep -v "=_" | grep -v "not set" | grep -v "^$" \
+	    | grep -v "#: Opened trace instances" | grep -v "#: Default trace destination"
+    ddcmd module,*,=_:0 # clear all flags and set dest to 0
+    echo
+
+    # close all opened trace instances and delete their respective directories
+    echo "OPEN trace instance"
+    output=$(tail -n9 /proc/dynamic_debug/control | grep "#: Opened trace instances" \
+	    | cut -f3 -d":" | xargs -n1)
+    for dst in $output
+    do
+        echo "close trace instance '$dst'"
+	echo close,$dst > /proc/dynamic_debug/control
+	echo "delete '/sys/kernel/debug/tracing/instances/$dst' directory"
+	rmdir /sys/kernel/debug/tracing/instances/$dst
+    done
+    echo
+}
+
 tests_list=(
     basic_tests
     comma_terminator_tests
@@ -680,6 +711,7 @@ tests_list=(
 
 # Run tests
 
+setup_env_for_tests
 for test in "${tests_list[@]}"
 do
     $test
-- 
2.43.0.687.g38aa6559b0-goog


