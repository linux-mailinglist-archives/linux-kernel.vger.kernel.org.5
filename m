Return-Path: <linux-kernel+bounces-60612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9CD850776
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EE0B2320D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F2E64CC0;
	Sat, 10 Feb 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jtW7e2wz"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1BB6341C
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609082; cv=none; b=DbTyhhbjPezc1KpIKh8ukSWDnde1nbUo5Ughdirt5BEvwbk6l+TM4YM7EidGswrPkCeCORkDNs2fV+4yhNxs4bYiPAVssKl7RBS0SK7apS+ne881fFWUg+KUF+bWTwQvs6KD9M5Np5urxmYzocMsN5AA7z/woRsWLsWFlRxIOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609082; c=relaxed/simple;
	bh=nbUDsmLwwsMGxeLMvq7R51Y+jO4MKjr5+9qcp6CUO+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VeEyJrvgX0P7yBOiXXNkIWqS6KjqJSYwDOQd2NH/+utEICem63jp8+w+Y1Scgd52LEO2qv/tbu6BrdyCvxpAjSp/on0foIyHTrjSv4mM2rX384MsiMCNowQNUVTjFgsOoEqs+/pFgKjLJMUZWjw7YMmisJqIeVqn7icvZOKWB9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jtW7e2wz; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0b4ea773eso27598321fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609078; x=1708213878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5vMxpz6NdPYzucOTTQaEl2B46WXd64LM19Uvka+yfY=;
        b=jtW7e2wzpaDauW0mT8q596XnzlcTFK3Cb2vqKCRY/Mm8oD5CBhM/1o8YNVjJFPwlyg
         FJS+WqiONujHU8qDpBsdXa04pd2+WQB+DS+8Ndjqj9snaf5o//zVWFvK7BsTCF3rssxm
         bR28JgFdvb9MoWJji54Ln8CxFaiMcGaTxbnFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609078; x=1708213878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5vMxpz6NdPYzucOTTQaEl2B46WXd64LM19Uvka+yfY=;
        b=wGYV7uxYMSS7dUw8kbpeRPNuvRzPPtpGzU5B/uAomGWsjfYBaXqkPaaM4WUNI/NQkz
         0Thp6mIclQNhOb5U+fZ3ugjpx/lLHQuCcogLTnULwgmGlQP/huDDjSDCEiyWQxdwWtmO
         2+B2mxO/69vaLZ8lXXyiAqO1k+iIZYk9EwM9Ye59fwZjDCY9qFnuuwT2Cis5XIepxQMw
         h7y+b26nFpXaT/fBmLtUiFoOZ85XNDAeG1FWOQj1wAfkSHT9wCu01YkuNeTbxj66TkZ2
         4iMY75oTrqDesOlpk9mgo69kRX5FX1UcqozWHIlYgPpXcz4QeNfYp/MqpO8ZeGpKueea
         23zA==
X-Gm-Message-State: AOJu0Yz9OCHtnQwCVjrKb0SB5RHlvP2QYeeVnZ9LVEeG5Ion9PUVIwvo
	VVHAvaFxph3LKkZxawCQ5gXdooVagoZ7Azfu4E8qzWCl7fOwXzhU1KZj7Srx
X-Google-Smtp-Source: AGHT+IFQT3Fm9Y8Ny4WFRq7ra/mS8J4uJTr8q9kb6p5z1ytHxriZ58WqFm37BsuCB6PPppatTuqgAQ==
X-Received: by 2002:a05:6512:3c86:b0:511:81ed:394d with SMTP id h6-20020a0565123c8600b0051181ed394dmr2200810lfv.29.1707609077937;
        Sat, 10 Feb 2024 15:51:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQ7hOiZ6JwkCbufK9BXQ2QACZE3he6PydneZlv808cr9hwtC3z8G2M8G1c2Pw+TqWkXnrtes7GopwvNEI3+JVpHkzlM/S2VbBaURhejMb7hg8g53dqq5ez/vd79uVmpzgUSVMWHwbyJ1bfQDkDlMLTrOyPQj5OEZdMbgV8xup0GZXZIdLExwxi8db/UJ9/6dJCMgG7J9TIIRZ5mSCB+ZuBKz0YnXusY238aZBvwyZBqjSwXvpKGZ4D6JMJq1SMkjr2im1p9eKWaD/RFF3ckGVVf+aS7KN7TjaZJHlWq433Z/27J4JWISZyA6uo7jiEC/A7ZwNEcys+rLx0MB7OjM6IDsN2H4vnjHkTUlnLGXpFp9YMTG420JJ4I258opzbftuOHYglVxDqK+QDdAH0FBVs0ferikf8V58wro1gmU9IGv+/4eh1siabwUnNuuFtzSkgel0KDAIgcoqUcqHzuUrNhtrNKBa3XJpk6UJAsmX6BxhlgmFRNlrCZv4PtX2yleiQoEJtQfzomJAqbWFj8rw5EUYES49XvUQb/iauuVDcjyp3unchHG3+qrZPjvRqgvnW/yBuLeLST/F/PGCj+RHTQ4p5vRyY8nR7Synx0d70EBHuag==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:17 -0800 (PST)
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
Subject: [PATCH v4 29/39] dyndbg-test: add tools/testing/selftests/dynamic_debug/*
Date: Sun, 11 Feb 2024 00:49:59 +0100
Message-ID: <20240210235009.2405808-30-ukaszb@chromium.org>
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

From: Jim Cromie <jim.cromie@gmail.com>

Add a selftest script for dynamic-debug, in the extant framework,
with other parts based upon ../users/*

This is v3 of an informal test-script started and developed
out-of-tree by the signers below, refined here for the framework.

As of now it passes basic-tests, percent-tests, etc, and most of the
test_private_trace_N() test-scripts; breaking on _6.

Strategy:

- select builtins to manipulate & count callsites
  file init/main.c; module mm_init, module params, not modular usbcore.
  these should be stable for counting, ref-check.
  params handling during modprobe is observable, verifiable.

- use callsite counts from minimal virtme-ng config (vng -bv)
  test the stability of counts against this ref.

- modprobe test_dynamic_debug dyndbg=$variations for @list;
  this allows to also test do_prints results,
  esp against a managed +T:private_buf. (undeveloped fns yet)
  later: it may allow to enable and validate dyndbg param processing

NOTES:

"module main" also finds power/main.c and module/main.c, which means
it might appear again with any new module with a main.c, and by itself
is not as stable a count as we'd like to use.

Its likely possible to test more of the early tests using builtins,
and avoiding modprobe based tests and the implied CONFIG_MODULES
dependency.  Best is doing the extra modprobe testing when its
available, and not as hard config dep.  For later.

Also rename check_matches() to check_match_ct(), to imply method.

TLDR - for further review, refine, re-edit.

dyndbg-test: fixes to pass tests up thru test_private_trace_5

test-count adjustments to pass test_private_trace_2

For test_private_trace_5 and support fns:
s/usbcore/params/ - prefer builtin to an optional modular one.
s/usb_stream/kparm_stream/

ALSO: trace_5 has some residual usb names I just noticed.
can you find suitable / arbitrary / distinctive renames ?
foo bar yada are fine by me.
We need more bupkus. Or maybe open bupkus!

A few -v's to see whats going on, (dont need to keep these).
Maybe later replace these with $v_normal, $v_private, etc,
with or without the implied -v* option handling.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 MAINTAINERS                                   |   1 +
 .../testing/selftests/dynamic_debug/Makefile  |   9 +
 tools/testing/selftests/dynamic_debug/config  |   1 +
 .../dynamic_debug/dyndbg_selftest.sh          | 672 ++++++++++++++++++
 4 files changed, 683 insertions(+)
 create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
 create mode 100644 tools/testing/selftests/dynamic_debug/config
 create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index b584a8468fb9..2647ce78cbfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7459,6 +7459,7 @@ F:	include/linux/dynamic_debug.h
 F:	include/trace/events/dyndbg.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
+F:	tools/testing/selftest/dynamic_debug/dyndbg_selftest.sh
 
 DYNAMIC INTERRUPT MODERATION
 M:	Tal Gilboa <talgi@nvidia.com>
diff --git a/tools/testing/selftests/dynamic_debug/Makefile b/tools/testing/selftests/dynamic_debug/Makefile
new file mode 100644
index 000000000000..e90c8e70f320
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Makefile for user memory selftests
+
+# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
+all:
+
+TEST_PROGS := dyndbg_selftest.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dynamic_debug/config b/tools/testing/selftests/dynamic_debug/config
new file mode 100644
index 000000000000..ad47b70fa2b3
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/config
@@ -0,0 +1 @@
+CONFIG_TEST_DYNAMIC_DEBUG=m
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
new file mode 100755
index 000000000000..a48cb57aa5cb
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -0,0 +1,672 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#!/bin/bash
+# shell-fns & test-script for dynamic-debug
+# run as: make run_tests, or:
+# vng -v -e path_to_dyndbg_selftest.sh
+
+RED="\033[0;31m"
+GREEN="\033[0;32m"
+YELLOW="\033[0;33m"
+BLUE="\033[0;34m"
+MAGENTA="\033[0;35m"
+CYAN="\033[0;36m"
+NC="\033[0;0m"
+error_msg=""
+v_search_trace=0	# 1 to enable verbose search-trace
+
+function vx () {
+    echo $1 > /sys/module/dynamic_debug/parameters/verbose
+}
+
+function ddgrep () {
+    grep $1 /proc/dynamic_debug/control
+}
+
+function doprints () {
+    cat /sys/module/test_dynamic_debug/parameters/do_prints
+}
+
+function ddcmd () {
+    exp_exit_code=0
+    num_args=$#
+    if [ "${@:$#}" = "pass" ]; then
+	num_args=$#-1
+    elif [ "${@:$#}" = "fail" ]; then
+        num_args=$#-1
+	exp_exit_code=1
+    fi
+    args=${@:1:$num_args}
+    output=$((echo "$args" > /proc/dynamic_debug/control) 2>&1)
+    exit_code=$?
+    error_msg=$(echo $output | cut -d ":" -f 5 | sed -e 's/^[[:space:]]*//')
+    handle_exit_code $BASH_LINENO $FUNCNAME $exit_code $exp_exit_code
+}
+
+function handle_exit_code() {
+    local exp_exit_code=0
+    [ $# == 4 ] && exp_exit_code=$4
+    if [ $3 -ne $exp_exit_code ]; then
+        echo -e "${RED}: $BASH_SOURCE:$1 $2() expected to exit with code $exp_exit_code"
+	[ $3 == 1 ] && echo "Error: '$error_msg'"
+        exit
+    fi
+}
+
+# $1 - pattern to match, pattern in $1 is enclosed by spaces for a match ""\s$1\s"
+# $2 - number of times the pattern passed in $1 is expected to match
+# $3 - optional can be set either to "-r" or "-v"
+       "-r" means relaxed matching in this case pattern provided in $1 is passed
+       as is without enclosing it with spaces
+       "-v" prints matching lines
+# $4 - optional when $3 is set to "-r" then $4 can be used to pass "-v"
+function check_match_ct {
+    pattern="\s$1\s"
+    exp_cnt=0
+
+    [ "$3" == "-r" ] && pattern="$1"
+    let cnt=$(ddgrep "$pattern" | wc -l)
+    if [ "$3" == "-v" ] || [ "$4" == "-v" ]; then
+        echo -ne "${BLUE}" && ddgrep $pattern && echo -ne "${NC}"
+    fi
+    [ $# -gt 1 ] && exp_cnt=$2
+    if [ $cnt -ne $exp_cnt ]; then
+        echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO check failed expected $exp_cnt on $1, got $cnt"
+        exit
+    else
+        echo ": $cnt matches on $1"
+    fi
+}
+
+# $1 - trace instance name
+# #2 - if > 0 then directory is expected to exist, if <= 0 then otherwise
+# $3 - "-v" for verbose
+function check_trace_instance_dir {
+    if [ -e /sys/kernel/tracing/instances/$1 ]; then
+        if [ "$3" == "-v" ] ; then
+            echo "ls -l /sys/kernel/tracing/instances/$1: "
+            ls -l /sys/kernel/tracing/instances/$1
+        fi
+	if [ $2 -le 0 ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error trace instance \
+		    '/sys/kernel/tracing/instances/$1' does exist"
+	    exit
+	fi
+    else
+	if [ $2 -gt 0 ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error trace instance \
+		    '/sys/kernel/tracing/instances/$1' does not exist"
+	    exit
+        fi
+    fi
+}
+
+function tmark {
+    echo $* > /sys/kernel/tracing/trace_marker
+}
+
+# $1 - trace instance name
+# $2 - line number
+# $3 - if > 0 then the instance is expected to be opened, otherwise
+# the instance is expected to be closed
+function check_trace_instance {
+    output=$(tail -n9 /proc/dynamic_debug/control | grep ": Opened trace instances" \
+	    | xargs -n1 | grep $1)
+    if [ "$output" != $1 ] && [ $3 -gt 0 ]; then
+        echo -e "${RED}: $BASH_SOURCE:$2 trace instance $1 is not opened"
+        exit
+    fi
+    if [ "$output" == $1 ] && [ $3 -le 0 ]; then
+        echo -e "${RED}: $BASH_SOURCE:$2 trace instance $1 is not closed"
+        exit
+    fi
+}
+
+function is_trace_instance_opened {
+    check_trace_instance $1 $BASH_LINENO 1
+}
+
+function is_trace_instance_closed {
+    check_trace_instance $1 $BASH_LINENO 0
+}
+
+# $1 - trace instance directory to delete
+# $2 - if > 0 then directory is expected to be deleted successfully, if <= 0 then otherwise
+function del_trace_instance_dir() {
+    exp_exit_code=1
+    [ $2 -gt 0 ] && exp_exit_code=0
+    output=$((rmdir /sys/kernel/debug/tracing/instances/$1) 2>&1)
+    exit_code=$?
+    error_msg=$(echo $output | cut -d ":" -f 3 | sed -e 's/^[[:space:]]*//')
+    handle_exit_code $BASH_LINENO $FUNCNAME $exit_code $exp_exit_code
+}
+
+function error_log_ref {
+    # to show what I got
+    : echo "# error-log-ref: $1"
+    : echo cat \$2
+}
+
+function ifrmmod {
+    lsmod | grep $1 2>&1>/dev/null || echo $1 not there
+    lsmod | grep $1 2>&1>/dev/null && rmmod $1
+}
+
+# $1 - text to search for
+function search_trace() {
+    search_trace_name 0 1 $1
+}
+
+# $1 - trace instance name, 0 for global event trace
+# $2 - line number counting from the bottom
+# $3 - text to search for
+function search_trace_name() {
+	if [ "$1" = "0" ]; then
+	    buf=$(cat /sys/kernel/debug/tracing/trace)
+	    line=$(tail -$2 /sys/kernel/debug/tracing/trace | head -1 | sed -e 's/^[[:space:]]*//')
+	else
+	    buf=$(cat /sys/kernel/debug/tracing/instances/$1/trace)
+	    line=$(tail -$2 /sys/kernel/debug/tracing/instances/$1/trace | head -1 | \
+		   sed -e 's/^[[:space:]]*//')
+	fi
+	if [ $2 = 0 ]; then
+	    # whole-buf check
+	    output=$(echo $buf | grep "$3")
+	else
+	    output=$(echo $line | grep "$3")
+	fi
+	if [ "$output" = "" ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO search for '$3' failed \
+		    in line '$line' or '$buf'"
+	    exit
+	fi
+	if [ $v_search_trace = 1 ]; then
+	    echo -e "${MAGENTA}: search_trace_name in $1 found: \n$output \nin:${BLUE} $buf ${NC}"
+        fi
+}
+
+# $1 - error message to check
+function check_err_msg() {
+    if [ "$error_msg" != "$1" ]; then
+        echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error message '$error_msg' \
+		does not match with '$1'"
+        exit
+    fi
+}
+
+function basic_tests {
+    echo -e "${GREEN}# BASIC_TESTS ${NC}"
+    ddcmd =_ # zero everything (except class'd sites)
+    check_match_ct =p 0
+    # there are several main's :-/
+    ddcmd module main file */module/main.c +p
+    check_match_ct =p 14
+    ddcmd =_
+    check_match_ct =p 0
+    # multi-cmd input, newline separated, with embedded comments
+    cat <<"EOF" > /proc/dynamic_debug/control
+      module main +mf                   # multi-query
+      module main file init/main.c +ml  # newline separated
+EOF
+    # the intersection of all those main's is hard to track/count
+    # esp when mixed with overlapping greps
+    check_match_ct =mf 21
+    check_match_ct =ml 0
+    check_match_ct =mfl 6
+    ddcmd =_
+}
+
+function comma_terminator_tests {
+    echo -e "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
+    # try combos of space & comma
+    check_match_ct '\[params\]' 4 -r
+    ddcmd module,params,=_		# commas as spaces
+    ddcmd module,params,+mpf		# turn on non-classed
+    check_match_ct =pmf 4
+    ddcmd ,module ,, ,  params, -p	# extra commas & spaces
+    check_match_ct =mf 4
+    ddcmd =_
+}
+
+function test_percent_splitting {
+    echo -e "${GREEN}# TEST_PERCENT_SPLITTING - multi-command splitting on % ${NC}"
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+    modprobe test_dynamic_debug dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+    check_match_ct test_dynamic_debug 32 -r -v
+    ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml "# add some prefixes"
+    check_match_ct =pmf 1
+    check_match_ct =plt 1
+    check_match_ct =pml 1
+    check_match_ct test_dynamic_debug -r 32
+    ifrmmod test_dynamic_debug
+}
+
+function test_actual_trace {
+    echo -e "${GREEN}# TEST_ACTUAL_TRACE ${NC}"
+    ddcmd =_
+    echo > /sys/kernel/tracing/trace
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+    modprobe test_dynamic_debug dyndbg=class,D2_CORE,+T:0
+    search_trace "D2_CORE msg"
+    search_trace_name 0 1 "D2_CORE msg"
+    check_match_ct =T 1
+    tmark "here comes the WARN"
+    search_trace "here comes the WARN"
+    doprints
+    search_trace "D2_CORE msg"
+    ifrmmod test_dynamic_debug
+}
+
+function self_start {
+    echo \# open, modprobe +T:selftest
+    ddcmd open selftest
+    check_trace_instance_dir selftest 1
+    is_trace_instance_opened selftest
+    modprobe test_dynamic_debug dyndbg=+T:selftest.mf
+    check_match_ct =T:selftest.mf 5
+}
+
+function self_end_normal {
+    echo \# disable -T:selftest, rmmod, close
+    ddcmd module test_dynamic_debug -T:selftest # leave mf
+    check_match_ct =:selftest.mf 5 -v
+    ddcmd module test_dynamic_debug +:0
+    ddcmd close selftest
+    is_trace_instance_closed selftest
+    ifrmmod test_dynamic_debug
+}
+
+function self_end_disable_anon {
+    echo \# disable, close, rmmod
+    ddcmd module test_dynamic_debug -T
+    check_match_ct =:selftest.mf 5
+    ddcmd module test_dynamic_debug +:0
+    ddcmd close selftest
+    is_trace_instance_closed selftest
+    ifrmmod test_dynamic_debug
+}
+
+function self_end_disable_anon_mf {
+    echo \# disable, close, rmmod
+    ddcmd module test_dynamic_debug -Tf
+    check_match_ct =:selftest.m 5
+    ddcmd module test_dynamic_debug +:0
+    ddcmd close selftest
+    is_trace_instance_closed selftest
+    ifrmmod test_dynamic_debug
+}
+
+function self_end_nodisable {
+    echo \# SKIPPING: ddcmd module test_dynamic_debug -T:selftest
+    ddcmd close selftest fail # close fails because selftest is still being used
+    check_err_msg "Device or resource busy"
+    check_match_ct =T:selftest.mf 5
+    rmmod test_dynamic_debug
+    ddcmd close selftest # now selftest can be closed because rmmod removed
+                         # all callsites which were using it
+    is_trace_instance_closed selftest
+}
+
+function self_end_delete_directory {
+    del_trace_instance_dir selftest 0
+    check_err_msg "Device or resource busy"
+    ddcmd module test_dynamic_debug -mT:selftest
+    check_match_ct =:selftest.f 5
+    del_trace_instance_dir selftest 0
+    check_err_msg "Device or resource busy"
+    ddcmd module test_dynamic_debug +:0
+    ddcmd close selftest
+    check_trace_instance_dir selftest 1
+    is_trace_instance_closed selftest
+    del_trace_instance_dir selftest 1
+    check_trace_instance_dir selftest 0
+}
+
+function test_early_close () {
+    ddcmd open kparm_stream
+    ddcmd module usbcore +T:kparm_stream.mf
+    check_match_ct =T:usb_stream.mf 161
+    echo ":not-running # ddcmd module usbcore -T:kparm_stream.mf"
+    ddcmd close kparm_stream
+}
+
+function self_test_ {
+    echo "# SELFTEST $1"
+    self_start
+    self_end_$1
+}
+
+function cycle_tests_normal {
+    echo -e "${GREEN}# CYCLE_TESTS_NORMAL ${NC}"
+    self_test_ normal           # ok
+    self_test_ disable_anon     # ok
+    self_test_ normal           # ok
+    self_test_ disable_anon_mf  # ok
+}
+
+function cycle_not_best_practices {
+    echo -e "${GREEN}# CYCLE_TESTS_PROBLEMS ${NC}"
+    self_test_ nodisable
+    self_test_ normal
+    self_test_ delete_directory
+}
+
+# proper life cycle - open, enable:named, disable:named, close
+function test_private_trace_simple_proper {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_1 ${NC}"
+    # ddcmd close kparm_stream
+    ddcmd open kparm_stream
+    ddcmd module params +T:kparm_stream.mf
+    check_match_ct =T:kparm_stream.mf 4
+    ddcmd module params -T:kparm_stream.mf
+    check_match_ct =T:kparm_stream.mf 0
+    is_trace_instance_opened kparm_stream
+    ddcmd module params +:0
+    ddcmd close kparm_stream
+    is_trace_instance_closed kparm_stream
+    ddcmd =_
+    check_trace_instance_dir kparm_stream 1
+    is_trace_instance_closed kparm_stream
+    del_trace_instance_dir kparm_stream 1
+    check_trace_instance_dir kparm_stream 0
+}
+
+function test_private_trace_2 {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_2 ${NC}"
+    ddcmd =_
+    echo > /sys/kernel/tracing/trace
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+    ddcmd open foo
+    is_trace_instance_opened foo
+    check_trace_instance_dir foo 1
+
+    modprobe test_dynamic_debug
+    ddcmd class,D2_CORE,+T:foo.l,%class,D2_KMS,+fT:foo.ml
+    check_match_ct =T:foo.l 1
+    check_match_ct =T:foo.mfl 1
+
+    # purpose ?
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+
+    tmark test_private_trace about to do_prints
+    search_trace "test_private_trace about to do_prints"
+    search_trace_name "0" 1 "test_private_trace about to do_prints"
+
+    doprints
+    ddcmd class,D2_CORE,-T:foo
+    ddcmd close foo fail
+    check_err_msg "Device or resource busy"
+    ddcmd class,D2_KMS,-T:foo
+    ddcmd close foo
+    check_trace_instance_dir foo 1
+    is_trace_instance_closed foo
+    ddcmd close bar fail
+    check_err_msg "No such file or directory"
+    ifrmmod test_dynamic_debug
+    search_trace_name foo 2 "D2_CORE msg"
+    search_trace_name foo 1 "D2_KMS msg"
+    del_trace_instance_dir foo 1
+    check_trace_instance_dir foo 0
+}
+
+function test_private_trace_3 {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_3 ${NC}"
+    ddcmd =_
+    echo > /sys/kernel/tracing/trace
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+    ddcmd open foo \; open bar
+    is_trace_instance_opened foo
+    is_trace_instance_opened bar
+    modprobe test_dynamic_debug
+    ddcmd class,D2_CORE,+T:foo
+    ddcmd class,D2_KMS,+T:foo
+    ddcmd class D2_CORE +T:foo \; class D2_KMS +T:foo
+    ddcmd "class,D2_CORE,+T:foo;,class,D2_KMS,+T:foo"
+    ddcmd class,D2_CORE,+T:foo\;class,D2_KMS,+T:foo
+    check_match_ct =T 2 -v
+    check_match_ct =Tl 0
+    check_match_ct =Tmf 0
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+    tmark test_private_trace_2 about to do_prints
+    doprints
+    rmmod test_dynamic_debug
+    ddcmd "close bar;close foo"
+    is_trace_instance_closed bar
+    is_trace_instance_closed foo
+    search_trace_name foo 2 "D2_CORE msg"
+    search_trace_name foo 1 "D2_KMS msg"
+    del_trace_instance_dir foo 1
+    check_trace_instance_dir foo 0
+    search_trace "test_private_trace_2 about to do_prints"
+    del_trace_instance_dir bar 1
+    check_trace_instance_dir bar 0
+}
+
+function test_private_trace_4 {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_4 ${NC}"
+    ddcmd =_
+    echo > /sys/kernel/tracing/trace
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+
+    ddcmd open foo
+    modprobe test_dynamic_debug dyndbg=class,D2_CORE,+T:foo%class,D2_KMS,+T:foo
+    check_match_ct =Tl 0
+    check_match_ct =Tmf 0
+    check_match_ct =T 2
+
+    # are these 2 doing anything ?
+    echo 1 >/sys/kernel/tracing/tracing_on
+    echo 1 >/sys/kernel/tracing/events/dyndbg/enable
+
+    tmark should be ready
+    search_trace_name "0" 0 "should be ready"	# in global trace
+
+    doprints
+    search_trace_name foo 2 "D2_CORE msg"	# in private buf
+    search_trace_name foo 1 "D2_KMS msg"
+
+    # premature delete
+    del_trace_instance_dir foo 0
+    check_trace_instance_dir foo 1	# doesn't delete
+    ifrmmod test_dynamic_debug
+
+    ddcmd "close foo"
+    is_trace_instance_closed foo
+    del_trace_instance_dir foo 1	# delete works now
+
+    check_trace_instance_dir foo 0
+    search_trace "should be ready"
+}
+
+# $1 - trace-buf-name (or "0")
+# $2 - reference-buffer
+function search_in_trace_for {
+    bufname=$1; shift;
+    ref=$2;
+    ref2=$(echo $ref | cut -c20-)
+    echo $ref2
+}
+
+function test_private_trace_mixed_class {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_5 ${NC}"
+    ddcmd =_
+    ddcmd module,params,+T:unopened fail
+    check_err_msg "Invalid argument"
+    is_trace_instance_closed unopened
+    check_trace_instance_dir unopened 0
+
+    ddcmd open bupkus
+    is_trace_instance_opened bupkus
+    check_trace_instance_dir bupkus 1
+    modprobe test_dynamic_debug \
+	     dyndbg=class,D2_CORE,+T:bupkus.mf%class,D2_KMS,+T:bupkus.mf%class,V3,+T:bupkus.mf
+
+    # test various name misses
+    ddcmd "module params =T:bupkus1" fail	# miss on name
+    check_err_msg "Invalid argument"
+    ddcmd "module params =T:unopened" fail	# unopened
+    check_err_msg "Invalid argument"
+
+    ddcmd "module params =mlfT:bupkus."		# we allow dot at the end of flags
+    ddcmd "module params =T:bupkus."
+    ddcmd "module params =:bupkus."
+    ddcmd "module params =:0."
+
+    check_match_ct =T:bupkus.mf 3		# the 3 classes enabled above
+    # enable the 5 non-class'd pr_debug()s
+    ddcmd "module test_dynamic_debug =T:bupkus"
+    check_match_ct =T:bupkus 8 -r		# 8=5+3
+
+    doprints
+    ddcmd close,bupkus fail
+    check_err_msg "Device or resource busy"
+    ddcmd "module * -T:0"			# misses class'd ones
+    ddcmd close,bupkus fail
+
+    ddcmd class,D2_CORE,-T:0%class,D2_KMS,-T:0%class,V3,-T:0 # turn off class'd and set dest to 0
+    ddcmd close,bupkus
+    is_trace_instance_closed bupkus
+
+    # check results
+    eyeball_ref=<<EOD
+        modprobe-1173    [001] .....   7.781008: 0: test_dynamic_debug:do_cats: test_dd: D2_CORE msg
+        modprobe-1173    [001] .....   7.781010: 0: test_dynamic_debug:do_cats: test_dd: D2_KMS msg
+        modprobe-1173    [001] .....   7.781010: 0: test_dynamic_debug:do_levels: test_dd: V3 msg
+             cat-1214    [001] .....   7.905494: 0: test_dd: doing categories
+             cat-1214    [001] .....   7.905495: 0: test_dynamic_debug:do_cats: test_dd: D2_CORE msg
+             cat-1214    [001] .....   7.905496: 0: test_dynamic_debug:do_cats: test_dd: D2_KMS msg
+             cat-1214    [001] .....   7.905497: 0: test_dd: doing levels
+             cat-1214    [001] .....   7.905498: 0: test_dynamic_debug:do_levels: test_dd: V3 msg
+EOD
+
+    # validate the 3 enabled class'd sites, with mf prefix
+    search_trace_name bupkus 0 "test_dynamic_debug:do_cats: test_dd: D2_CORE msg"
+    search_trace_name bupkus 0 "test_dynamic_debug:do_cats: test_dd: D2_KMS msg"
+    search_trace_name bupkus 0 "test_dynamic_debug:do_levels: test_dd: V3 msg"
+
+    search_trace_name bupkus 0 "test_dd: doing levels"
+    search_trace_name bupkus 0 "test_dd: doing categories"
+
+    # reopen wo error
+    ddcmd open bupkus
+    is_trace_instance_opened bupkus
+    check_trace_instance_dir bupkus 1
+
+    ddcmd "module test_dynamic_debug =T:bupkus"	# rearm the 5 plain-old prdbgs
+    check_match_ct =T:bupkus 5
+
+    doprints # 2nd time
+    search_trace_name bupkus 0 "test_dd: doing categories"
+    search_trace_name bupkus 0 "test_dd: doing levels""
+    search_trace_name bupkus 2 "test_dd: doing categories"
+    search_trace_name bupkus 1 "test_dd: doing levels""
+
+    ddcmd close,bupkus fail
+    check_err_msg "Device or resource busy"
+    del_trace_instance_dir bupkus 0
+    check_err_msg "Device or resource busy"
+    check_trace_instance_dir bupkus 1
+    is_trace_instance_opened bupkus
+    check_trace_instance_dir bupkus 1
+
+    # drop last users, now delete works
+    ddcmd "module * -T:0"
+    ddcmd close,bupkus
+    is_trace_instance_closed bupkus
+    del_trace_instance_dir bupkus 1
+    check_trace_instance_dir bupkus 0
+    ifrmmod test_dynamic_debug
+}
+
+function test_private_trace_overlong_name {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_overlong_name ${NC}"
+    ddcmd =_
+    name="A_bit_lengthy_trace_instance_name"
+    ddcmd open $name
+    is_trace_instance_opened $name
+    check_trace_instance_dir $name 1
+
+    ddcmd "file kernel/module/main.c +T:$name.mf "
+    check_match_ct =T:A_bit_lengthy_trace_....mf 14
+
+    ddcmd "module * -T"
+    check_match_ct =:A_bit_lengthy_trace_....mf 14
+    check_match_ct kernel/module/main.c 14 -r		# to be certain
+
+    ddcmd "module * -T:0"
+    ddcmd close,$name
+    is_trace_instance_closed $name
+    del_trace_instance_dir $name 1
+    check_trace_instance_dir $name 0
+}
+
+function test_private_trace_fill_trace_index {
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_fill_trace_index ${NC}"
+    ddcmd =_
+    name="trace_instance_"
+    for i in {1..63}
+    do
+        ddcmd open $name$i
+	is_trace_instance_opened $name$i
+        check_trace_instance_dir $name$i 1
+    done
+    # catch the 1-too-many err
+    ddcmd "open too_many" fail
+    check_err_msg "No space left on device"
+
+    ddcmd 'file kernel/module/main.c =T:trace_instance_63.m'
+    check_match_ct =T:trace_instance_63.m 14
+
+    for i in {1..62}
+    do
+        ddcmd close $name$i
+        is_trace_instance_closed $name$i
+        del_trace_instance_dir $name$i 1
+        check_trace_instance_dir $name$i 0
+    done
+    ddcmd "module * -T:0"
+    ddcmd close,trace_instance_63
+    is_trace_instance_closed trace_instance_63
+    del_trace_instance_dir trace_instance_63 1
+    check_trace_instance_dir trace_instance_63 0
+}
+
+tests_list=(
+    basic_tests
+    comma_terminator_tests
+    test_percent_splitting
+    test_actual_trace
+    cycle_tests_normal
+    cycle_not_best_practices
+    test_private_trace_1
+    test_private_trace_simple_proper
+    test_private_trace_2
+    test_private_trace_3
+    test_private_trace_4
+    test_private_trace_mixed_class
+    test_private_trace_mixed_class  # again, to test pre,post conditions
+
+    test_private_trace_overlong_name
+
+    # works, takes 30 sec
+    test_private_trace_fill_trace_index
+)
+
+# Run tests
+
+for test in "${tests_list[@]}"
+do
+    $test
+    echo ""
+done
+echo -en "${GREEN}# Done on: "
+date
-- 
2.43.0.687.g38aa6559b0-goog


