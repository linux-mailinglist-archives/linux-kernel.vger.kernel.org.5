Return-Path: <linux-kernel+bounces-60615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C8C850778
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E3E1F27B37
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D50E651BD;
	Sat, 10 Feb 2024 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bs3wjCUC"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061564CC3
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609086; cv=none; b=q1ozbVhvneK3WULzo/xWvC1IqB2ziE5QaFr5QAk9/Z+jT4I2T2133kP/sJWXGZW5Q0wQ1tUX8JHNHPvgK/lN72dUBTEoMIvXzBsssiX2Z+b0cYcyPjmRqqM4EHahm2Rdboyfv+Fzl8Nv7j8gHW52uQ0nCEDpUQfIG4++FnUWaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609086; c=relaxed/simple;
	bh=kmZcLZgcgEX3HM4KUb42z75HpNdgZ+0ModW5/sGCGLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EH6opupXBwYjFhfKMQvjeykvuZvUQGaXRYrmUwQwsoZyCr5JR5mAub/7H6/v+6JXIWSLwut1/HU8mBqRhSgYcckHYxpS1D5o3qDkgCy1o1P2ej4s/ybCsYeD1a0/HFO1CzoCPCEjihg++h39sTVMWA5dSR/k+12MK7McSGZiX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bs3wjCUC; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5101cd91017so2348672e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609083; x=1708213883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrA8jGQtE53SdlKFSoEE35NMqUSa28VzU3mFn5v5MeM=;
        b=Bs3wjCUCR/EaCidgEUrFrMLOwSXsuZGmwjyAoZdJ3i1Jhz4Hxp/JiBy3XsoBR29fd4
         wLjQt0n3zJ72naHFcjTUr8sNfq4ipt0ytjiYA5mBA67V4vZNwChwUrevtfQviy5zm0Ht
         SPnpyUGbtabW57rrQ/D7igkH79zJrNxGEZiqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609083; x=1708213883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrA8jGQtE53SdlKFSoEE35NMqUSa28VzU3mFn5v5MeM=;
        b=iWScpy1bbVqwbJhgxFHOjbrsG70USBKQj+6FyTqTrplQU8eGkF2bE/ctjjqD423SkY
         J7J4/FM1JjpFUIiza6ObxsN1j4wJEGMO6bdZsgvkT31Ln7hvEYvvO5vZ4yNd22j06AUP
         UxWcTnXxzWGKKVCZCMySW1Golq/W1v5DSoAaQK4B+7EA2qViwqg56SHhJ7pCdyYEhRau
         yjHUcFbsXvKrZN5lQLO1vlLjr57aSgSsG/rEiwBn/EsAPJ13RvEZFJNK6XoU1iJIG3wO
         qsZhcphnLB9guJISmkGUr1x+8J0dBE+vLTSkcKV+xZaaaBYKCVQT/btCi1bEwACayQPx
         XVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgcDm9QxCuHizNfhZC9kB6wUJEesns1DknGJ0KogVeU26uBppVeEEkGVbM2swH9DvxOG8BoVKJPFZpISNEJr0+lVAl5GRx8IHvq+ZZ
X-Gm-Message-State: AOJu0YySnng9PeH7dEJBKqtJwFJwphGCMHenwNFTFakcKtOoKk8QryZD
	O6xPQeVD48sITLrJTzi7ofJPXgSFgBpiYiYgH7bkQb8tSpCRV3D78nxdCWmn
X-Google-Smtp-Source: AGHT+IFcTNTifmM62cjQ2W+LyReFJ3MwvhjUonLFs4bO8E7h3oi2iP+28+Ey8sNPTmPMULR6zuZ/bg==
X-Received: by 2002:a05:6512:3246:b0:511:882e:aa2f with SMTP id c6-20020a056512324600b00511882eaa2fmr249640lfr.50.1707609082914;
        Sat, 10 Feb 2024 15:51:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3mlDLq60lZ+NQEvPkQnjMfS4Fx6p94KKHuhw4iVhbze76KzL8h0q4rnB2n2XNVhbVtuVpi6RDDiWiX5z+zS75Of2+y4wnwKoz/rNQ8tbHN+8teb+9Japy+4XkrsH6KW9XfFNit3dTGUbFimCLl3IKxduJkXx3VocU4FDvhT8UntjZLPE3Nb2DJuhx9ITuy8sA/yBFW5Io3Avc3NdwktWkagDcBceon+nyRDTI36uX2AuzfmIYomsEhYsIgD9oYuZ02WV1S8wwE2bTeAnuCHFEMXFVlfqRB5ZIWuYoM45OfC7Uur6YpNpE7o1rS3/AK3yI4A6+QrNeHyQwzsN9rka4nCa6XHBYmhsuNdnEAk0935RA1LE+xaoN22TiwkUb5phNOmq3e/pLYAjJAhRAXAOnxUETmpOr295SU1N00xYn9LPNZGBgZ20BEMrm3qP8gybUC8L4Gu9s5m1cTDg6x9IBw1pFrJT1eAh702YJnZOiNSnz2uLTXYhn2J63ue0Vq735+cT96yLr+J0hCKpn0uEEFr2hKzVOpXf1NfBg3F7cGZjHx22RYgwUs/BGk1BaiwrtdWCLA+kCpkRjryv6a4SHItL+NRSrEyPyXcyJP+KBgSlTEg==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:22 -0800 (PST)
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
Subject: [PATCH v4 32/39] dyndbg-test: refactor test_private_trace_* tests
Date: Sun, 11 Feb 2024 00:50:02 +0100
Message-ID: <20240210235009.2405808-33-ukaszb@chromium.org>
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

Format, commment and add meaningful name to the following tests:
- test_private_trace_2 -> test_private_trace_syntax_close_in_use,
- test_private_trace_3 -> test_private_trace_syntax_rmmod,
- test_private_trace_4 -> test_private_trace_syntax_delete_in_use_rmmod.

Also update formatting and description of test_private_trace_simple_proper
test.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 127 ++++++++++--------
 1 file changed, 71 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index abe94af0f3eb..86bb039df4a1 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -357,19 +357,21 @@ function cycle_not_best_practices {
     self_test_ delete_directory
 }
 
-# proper life cycle - open, enable:named, disable:named, close
+# test verifies proper life cycle - open, enable:named, disable:named, close
 function test_private_trace_simple_proper {
     echo -e "${GREEN}# TEST_PRIVATE_TRACE_1 ${NC}"
-    # ddcmd close kparm_stream
+
     ddcmd open kparm_stream
     ddcmd module params +T:kparm_stream.mf
     check_match_ct =T:kparm_stream.mf 4
+
     ddcmd module params -T:kparm_stream.mf
     check_match_ct =T:kparm_stream.mf 0
     is_trace_instance_opened kparm_stream
     ddcmd module params +:0
     ddcmd close kparm_stream
     is_trace_instance_closed kparm_stream
+
     ddcmd =_
     check_trace_instance_dir kparm_stream 1
     is_trace_instance_closed kparm_stream
@@ -377,115 +379,128 @@ function test_private_trace_simple_proper {
     check_trace_instance_dir kparm_stream 0
 }
 
-function test_private_trace_2 {
-    echo -e "${GREEN}# TEST_PRIVATE_TRACE_2 ${NC}"
+# test verifies new syntax and close attempt of trace instance which is still in use
+function test_private_trace_syntax_close_in_use {
+    echo -e "${GREEN}# TEST_PRIVATE_SYNTAX_CLOSE_IN_USE ${NC}"
     ddcmd =_
     echo > /sys/kernel/tracing/trace
     echo 1 >/sys/kernel/tracing/tracing_on
     echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+
     ddcmd open foo
     is_trace_instance_opened foo
     check_trace_instance_dir foo 1
 
     modprobe test_dynamic_debug
-    ddcmd class,D2_CORE,+T:foo.l,%class,D2_KMS,+fT:foo.ml
+    ddcmd class,D2_CORE,+T:foo.l,%class,D2_KMS,+fT:foo.ml	# test new syntax
     check_match_ct =T:foo.l 1
     check_match_ct =T:foo.mfl 1
 
-    # purpose ?
-    echo 1 >/sys/kernel/tracing/tracing_on
-    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
-
-    tmark test_private_trace about to do_prints
-    search_trace "test_private_trace about to do_prints"
-    search_trace_name "0" 1 "test_private_trace about to do_prints"
+    tmark test_private_trace_syntax_close_in_use about to do_prints
+    search_trace "test_private_trace_syntax_close_in_use about to do_prints"
+    search_trace_name "0" 1 "test_private_trace_syntax_close_in_use about to do_prints"
 
     doprints
-    ddcmd class,D2_CORE,-T:foo
-    ddcmd close foo fail
-    check_err_msg "Device or resource busy"
-    ddcmd class,D2_KMS,-T:foo
-    ddcmd close foo
-    check_trace_instance_dir foo 1
-    is_trace_instance_closed foo
-    ddcmd close bar fail
-    check_err_msg "No such file or directory"
+    ddcmd class,D2_CORE,-T:0
+    ddcmd close foo fail	# close fails because foo is still being used
+    check_err_msg "Device or resource busy"	# verify error message
+
+    ddcmd class,D2_KMS,-T:0
+    ddcmd close foo	# now close succeeds
+    check_trace_instance_dir foo 1	# verify trace instance foo dir exists
+    is_trace_instance_closed foo	# verify trace instance foo is closed
+
+    ddcmd close bar fail	# try to close trace instance bar which is not opened
+    check_err_msg "No such file or directory"	# verify error message
+
     ifrmmod test_dynamic_debug
     search_trace_name foo 2 "D2_CORE msg"
     search_trace_name foo 1 "D2_KMS msg"
-    del_trace_instance_dir foo 1
-    check_trace_instance_dir foo 0
+    del_trace_instance_dir foo 1	# delete trace instance foo dir
+    check_trace_instance_dir foo 0	# verify trace instance foo dir does not exist
 }
 
-function test_private_trace_3 {
-    echo -e "${GREEN}# TEST_PRIVATE_TRACE_3 ${NC}"
+# test verifies new syntax and removal of module
+function test_private_trace_syntax_rmmod {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_SYNTAX_RMMOD ${NC}"
     ddcmd =_
     echo > /sys/kernel/tracing/trace
     echo 1 >/sys/kernel/tracing/tracing_on
     echo 1 >/sys/kernel/tracing/events/dyndbg/enable
-    ddcmd open foo \; open bar
+
+    ddcmd open foo \; open bar	# open foo and bar trace instances and verify they are opened
     is_trace_instance_opened foo
     is_trace_instance_opened bar
-    modprobe test_dynamic_debug
+
+    modprobe test_dynamic_debug	# load module and test new syntax
     ddcmd class,D2_CORE,+T:foo
     ddcmd class,D2_KMS,+T:foo
     ddcmd class D2_CORE +T:foo \; class D2_KMS +T:foo
     ddcmd "class,D2_CORE,+T:foo;,class,D2_KMS,+T:foo"
     ddcmd class,D2_CORE,+T:foo\;class,D2_KMS,+T:foo
-    check_match_ct =T 2 -v
+
+    check_match_ct =T:foo 2 -v
     check_match_ct =Tl 0
     check_match_ct =Tmf 0
-    echo 1 >/sys/kernel/tracing/tracing_on
-    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
-    tmark test_private_trace_2 about to do_prints
+
+    tmark test_private_trace_syntax_rmmod about to do_prints
     doprints
-    rmmod test_dynamic_debug
-    ddcmd "close bar;close foo"
-    is_trace_instance_closed bar
+
+    rmmod test_dynamic_debug	# remove module whose callsites are writing debug logs
+                                # to trace instance foo
+    ddcmd "close bar;close foo"	# close bar and foo trace instances, if usage count
+                                # of foo instance was not correctly decremented during
+				# removal of module then close will fail
+
+    is_trace_instance_closed bar	# verify that foo and bar trace instances are closed
     is_trace_instance_closed foo
     search_trace_name foo 2 "D2_CORE msg"
     search_trace_name foo 1 "D2_KMS msg"
-    del_trace_instance_dir foo 1
+
+    del_trace_instance_dir foo 1	# delete trace instance foo and verify its
+                                        # directory was removed
     check_trace_instance_dir foo 0
-    search_trace "test_private_trace_2 about to do_prints"
-    del_trace_instance_dir bar 1
+
+    search_trace "test_private_trace_syntax_rmmod about to do_prints"
+
+    del_trace_instance_dir bar 1	# delete trace instance bar and verify its
+                                        # directory was removed
     check_trace_instance_dir bar 0
 }
 
-function test_private_trace_4 {
-    echo -e "${GREEN}# TEST_PRIVATE_TRACE_4 ${NC}"
+# test verifies new syntax and combination of delete attempt of trace
+# instance which is still in use with module removal
+function test_private_trace_syntax_delete_in_use_rmmod {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_SYNTAX_DELETE_IN_USE_RMMOD ${NC}"
     ddcmd =_
     echo > /sys/kernel/tracing/trace
     echo 1 >/sys/kernel/tracing/tracing_on
     echo 1 >/sys/kernel/tracing/events/dyndbg/enable
 
-    ddcmd open foo
+    ddcmd open foo	# open trace instance foo and test new syntax
     modprobe test_dynamic_debug dyndbg=class,D2_CORE,+T:foo%class,D2_KMS,+T:foo
     check_match_ct =Tl 0
     check_match_ct =Tmf 0
-    check_match_ct =T 2
-
-    # are these 2 doing anything ?
-    echo 1 >/sys/kernel/tracing/tracing_on
-    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+    check_match_ct =T:foo 2 -v
 
     tmark should be ready
-    search_trace_name "0" 0 "should be ready"	# in global trace
+    search_trace_name "0" 0 "should be ready"	# search in global trace
 
     doprints
-    search_trace_name foo 2 "D2_CORE msg"	# in private buf
+    search_trace_name foo 2 "D2_CORE msg"	# search in trace instance foo
     search_trace_name foo 1 "D2_KMS msg"
 
     # premature delete
-    del_trace_instance_dir foo 0
-    check_trace_instance_dir foo 1	# doesn't delete
+    del_trace_instance_dir foo 0	# delete fails because foo is being used
+    check_trace_instance_dir foo 1	# verify trace instance foo dir exists
     ifrmmod test_dynamic_debug
 
-    ddcmd "close foo"
-    is_trace_instance_closed foo
-    del_trace_instance_dir foo 1	# delete works now
+    ddcmd "close foo"			# close will succeed only if foo usage count
+                                        # was correctly decremented during module removal
+    is_trace_instance_closed foo	# verify trace instance foo is closed
+    del_trace_instance_dir foo 1	# foo delete works now
 
-    check_trace_instance_dir foo 0
+    check_trace_instance_dir foo 0	# verify trace instance foo dir does not exist
     search_trace "should be ready"
 }
 
@@ -651,9 +666,9 @@ tests_list=(
     cycle_not_best_practices
     test_private_trace_1
     test_private_trace_simple_proper
-    test_private_trace_2
-    test_private_trace_3
-    test_private_trace_4
+    test_private_trace_syntax_close_in_use
+    test_private_trace_syntax_rmmod
+    test_private_trace_syntax_delete_in_use_rmmod
     test_private_trace_mixed_class
     test_private_trace_mixed_class  # again, to test pre,post conditions
 
-- 
2.43.0.687.g38aa6559b0-goog


