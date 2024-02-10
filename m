Return-Path: <linux-kernel+bounces-60618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC97685077B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C72428AD31
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A616B604B1;
	Sat, 10 Feb 2024 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OrY7vkPI"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8595FF1D
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609091; cv=none; b=FFlGdgwa8npbhnxtMCkrYr/DVDW+qN1QTeSZ8+CP9CHCM33iEL1xTYXkRmo/zx9TkVGsffda5ZHb22SEHLv04hE08/119CrW2hlkMiPcg9sZB8lBJpz0jw3yCTcSldWtHyVjCtIih4kzFkJG5nqVXS5So1pZCKrLQcc4j4pNfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609091; c=relaxed/simple;
	bh=1+xODvvWPgW5Ey947YSOiV5Ka4qflMD9dB/LgxDIO4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RL1AZ5/dkBrKzz876r3FYEx+4y/wP+XgKJQZabJDnM3QPNNEm2K0EuKFGeUb37h9mSTCf6PkP5Vz0gYUkA7lUA1jfzIiaEvs6+C+zLU8VVgY5SPhhBIMXsIXBwkdhPz8lnrkOR5BQWtPxXaZCApSLXZNj1rEp7v+5KRL3gc3YXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OrY7vkPI; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0ed7cbd76so5745611fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609088; x=1708213888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHV7suuu0MQVPrlCL4QBuTUyH7QVgFtZQstutgzVcQw=;
        b=OrY7vkPIcbR800yeHVwwf2DWeMWm9OUYTOi5oYfrCbTAojuSH7/ZCZkpXnhATslqRb
         TACahH0GAgwnGrxGU8hB+3EQiAj0keEdBFBtATXyuXuth0y1Efwj0NiOle0YzKY6ubdn
         giL0IvqweQGE7Srn8Knw0ak9CQQy6Rw/n9aOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609088; x=1708213888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHV7suuu0MQVPrlCL4QBuTUyH7QVgFtZQstutgzVcQw=;
        b=EH/IDqbJOjUNNCJqEPL7tWbmfl5KAJYIJoIngb7xJbK01qA7MPIuGC23KHDHvCr8bt
         swbu84WF66cb7eWXkfTlkGtK1JL3PnZJyJs3UNit76uxvBGtiaAIgQdN1zaoZTAXbnbD
         +7Ctlf1WmoiiIb+zgfIvnRTjnmcvQS88ToxwHXOszADb9amiKuonyaYnBZ/awVLRLhll
         0xHN5KOapwqGhamlAzPoQMvCq2unBPXcG0mz2GmxxxiiZzLZ7wvu8VIxR3kwfwBUCkPk
         OlCGqwJaF5t5ucUbmu4sXdM3/xB3YoLSAab7ydKTAJyg5bfsMq6ddQYelgqqtDJuCO/T
         wCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWHuqg2HFiRxS9U258EIEG0k75eA/kcRHG/KLSmmAPI2ulmhJ5MU+JrvovVyQs2mtGmtBDVE29HO7zuoom2d5AaqB9289x7vUKyNXT
X-Gm-Message-State: AOJu0Yz6QjekUacUmVhr1uzbzJ4XvzeLXIwpGE3fCUA72GAFvlWKoDdN
	/1pUeP/zqJPcGXrp0fVHOVQJip6KoLNxgflO85MeA80yuA/brjV7/86IE/rD
X-Google-Smtp-Source: AGHT+IFWEJZC22z4TsTnSP/mkDAKru5/KFhNo1k+gu2IVydBLjS2V2SrSls1GzyfUNLa6+ko/HSnKw==
X-Received: by 2002:a05:6512:694:b0:511:46c0:d879 with SMTP id t20-20020a056512069400b0051146c0d879mr2706309lfe.47.1707609088031;
        Sat, 10 Feb 2024 15:51:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPnn4rYFYIJcNIDuMVlr5Y9w3eMCoHlsJ7HtlfNP0w3XDg1MdZ6/t6dMLiJ6v/K2mJ6ordG5d+sB/AHwS7GynNaBVPaTW/PS9LttOJz9zXSslShef6J2AwAk7ZqszpwTMQ2uacQZRsHyZyUj1XWHdH37aVq3klpfsd4gTQDY1teYqCSjUJG3LH8XMfQ23tgIDmJstg8y70z7MHhvO09U1gbJ5uem+JRY1GlQeSA1MPSwGencRZHPuRekmKubfgDDmhmafqmAB81yQ2rOz62tXwpoeXAzh3bn8OX3COnnsg/e7GC0v6mrfksbzRiyPssWzSH/YIY5KWbS6W6phgZrqA6z7nzEJyLTd2LUeY8d6mdFFw5zX3JPXQVR3MsIrVris3JaeRIo26EJbY/1ipUdwPUaZ6o3RJhk3TVMx4jMwLsMrU+hSgZpDQlwbDCRPgGbcnLlWSZHzr6+bjE4O4gCikdG2Tz5NAGyxYE2X8XlXaIbd22sD8QzgbqeTFWOrByhMyb0jAcRsuo/BsX8BQc6v0rJWjnnWmh+aCLPzS/KJDRYZToutg/UfFFf7ARs0HNzikatOZVlog80cMq1DYcBwA/3wO2KtyUx1+0hfyFr2BrjSaiQ==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:27 -0800 (PST)
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
Subject: [PATCH v4 35/39] dyndbg-test: add test which verifies default dst
Date: Sun, 11 Feb 2024 00:50:05 +0100
Message-ID: <20240210235009.2405808-36-ukaszb@chromium.org>
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

Add test which verifies default trace destination feature.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 4a0340d2c3e8..ae386e4de6a4 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -195,6 +195,16 @@ function check_err_msg() {
     fi
 }
 
+# $1 - default destination to check
+function check_default_dst() {
+    dst=$(tail -50 /proc/dynamic_debug/control | grep "#: Default trace destination" | \
+	  cut -d':' -f3 | sed -e 's/^[[:space:]]*//')
+    if [ "$dst" != "$1" ]; then
+        echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO default dest '$dst' does not match with '$1'"
+        exit
+    fi
+}
+
 function basic_tests {
     echo -e "${GREEN}# BASIC_TESTS ${NC}"
     ddcmd =_ # zero everything (except class'd sites)
@@ -343,6 +353,70 @@ function test_flags {
     ifrmmod test_dynamic_debug
 }
 
+# test verifies default destination
+function test_default_destination {
+    echo -e "${GREEN}# TEST_DEFAULT_DESTINATION ${NC}"
+
+    check_default_dst 0
+    modprobe test_dynamic_debug
+
+    ddcmd class,D2_CORE,+T	# default dest is 0
+    check_match_ct =T 1 -v
+
+    ddcmd open foo		# foo becomes default dest
+    is_trace_instance_opened foo
+    check_trace_instance_dir foo 1
+    check_default_dst foo
+
+    ddcmd class,D2_CORE,+T	# default dest is foo
+    check_match_ct =T:foo 1 -v
+
+    ddcmd open,0		# reopening sets default dest to 0
+    check_default_dst 0
+
+    ddcmd class,D2_CORE,-T
+    check_match_ct =:foo 1 -v
+
+    ddcmd class,D2_CORE,+T      # default dest is 0 but since callsite was already labelled
+                                # then reuse label
+    check_match_ct =T:foo 1 -v
+
+    ddcmd open bar		# bar becomes default dest
+    is_trace_instance_opened bar
+    check_trace_instance_dir bar 1
+    check_default_dst bar
+
+    ddcmd class,D2_KMS,+T	# default dest is bar
+    check_match_ct =T:bar 1 -v
+
+    ddcmd class,D2_KMS,+T:0	# set 0 dest explicitly
+    check_match_ct =T 1 -v
+
+    ddcmd class,D2_KMS,-T
+
+    ddcmd open,foo		# reopening sets default dest to foo
+    check_default_dst foo
+
+    ddcmd class,D2_KMS,+T       # default dest is 0 but since callsite was already labelled
+                                # then reuse label
+    check_match_ct =T:foo 2 -v
+
+    ddcmd "class D2_CORE -T:0"
+    ddcmd "class D2_KMS -T:0"
+    check_default_dst foo
+
+    ddcmd close foo
+    is_trace_instance_closed foo
+    check_default_dst 0         # after closing foo which was default dest we revert
+                                # to 0 as default dest
+
+    ddcmd close bar
+    is_trace_instance_closed bar
+    check_default_dst 0
+
+    ifrmmod test_dynamic_debug
+}
+
 function test_actual_trace {
     echo -e "${GREEN}# TEST_ACTUAL_TRACE ${NC}"
     ddcmd =_
@@ -790,6 +864,7 @@ tests_list=(
     comma_terminator_tests
     test_percent_splitting
     test_flags
+    test_default_destination
     test_actual_trace
     cycle_tests_normal
     cycle_not_best_practices
-- 
2.43.0.687.g38aa6559b0-goog


