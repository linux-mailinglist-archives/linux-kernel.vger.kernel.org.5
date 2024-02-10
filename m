Return-Path: <linux-kernel+bounces-60619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C2A85077C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240191F28986
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E50660881;
	Sat, 10 Feb 2024 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lLHrWrQl"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F4560268
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609093; cv=none; b=RmF50JJ2ipMYwnZwRPXdT8r1/nje0FGlRMfev2/0/c32JH93+NOmC9F0rntJutOcRgHbewMzHGl+klhuUOnMK/jqS1+ZY5MNuCblvlLw/hOe7tUFGo3gfsNdp6fSS1dGozSyXBuuP5tQ76FGMyjF6UP8MjMj/q8A5DYG6uqe02E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609093; c=relaxed/simple;
	bh=zZEwM/gqUeF4NTMAOJeq2huREDQyznDrJFeANKDhZqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utvmsoxdNqf5U3A2DIykmf6Z1v4H+OxhnGvwNoTFzP/cd3r6UK/GJhKZaNUSojjh6e7TOfZlp/kGyo85PMnCWwmvB2/wtjfH3eo0wO9Gyu5BpjLDxUE9iUFlbwW7BuU7oPgbeT43gUUjAorpiG3Y00qRffscvTRHwUGhCruso6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lLHrWrQl; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d09cf00214so25712131fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609089; x=1708213889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04DOjNYx+ySJBUJN4jTjo32xTfHUemVAvm6ro2HWNnI=;
        b=lLHrWrQlNGBL5u9JL8URxZdXFL6SAVDnkA+4cPvXj88TdSkii/Zy7qFM8Xh0k2PFqX
         Jw1W3lABS+XjcHMeUQ+airch34fCjAfwg38WJP0VBMMEVcGrNE83MN0SDTLZ2zvt9WBw
         NODQPliXihVeKthiAIDL65Rm3mkT3H86twPpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609089; x=1708213889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04DOjNYx+ySJBUJN4jTjo32xTfHUemVAvm6ro2HWNnI=;
        b=Ke9ggIYwBckhY6uZZDGgyOqUypC4CVVZgLnaH3QHGiMX9ucfRuobhIIA4r5d8keFXL
         TM4giVjnpoZo173NKpVw8PXX5kDE7KhFuI2ewPsqgJNh5xrA3dl2IRMigacf7eFtGUZ8
         FXaykZa8ns6RIQLw58cPHsvfixTIRX8GCSdCJkQBki7cR4kakXUeThyGWLbCjh1rQ8yU
         zBSxG+JqAeghFWY/7JkpfIBmXqyDvFuRwa3sgkJSLnBXBQpnVWkbrCTTYe+TMsDaeTEF
         iBxIt/4ffJoIXKx8BUFBrxha36pJI0Je0c82kaTM3DXubgRAi52kvRou27VlcbmFza0P
         E6vw==
X-Forwarded-Encrypted: i=1; AJvYcCUrrRtSZUG9g/BWOs3trEZIu+uninuJLrsMWhl7zMSdzoqD3Sd/m2SrIyZh+67dK3wJY4QWXdiboUuZ5sTqYiyhGxx8/Bo5zkzG5KNO
X-Gm-Message-State: AOJu0YyzZkWkdI5ne4J3Xa1Q0rdHTUSJxywfc0HW07hz+C6eR26dmUOZ
	muCB7B+Uxc3khjeyj+ue2YaF9hJ+v2Hk5p2BTFET+svqhOGcxS5Y+DJaRCKO
X-Google-Smtp-Source: AGHT+IGGyzBouU5aBKag2uDdVT1DhOQTJAUyE/22kb9mMbn5vgu2e+hTYO6i987dgG0RuaP2HQaiMQ==
X-Received: by 2002:a05:6512:10d5:b0:511:89b4:a6d9 with SMTP id k21-20020a05651210d500b0051189b4a6d9mr226162lfg.61.1707609089606;
        Sat, 10 Feb 2024 15:51:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5zw0fod6VLEAkrTkP63z8GZddxUioVyVS4dNaAUulOR68xdgwJobIbWqWlk1PDLToFRTsDjpcCnFzCY1W9J4wkqynom8YYYz2MfseauRbIKNqwEOsOcal3k6hm17tuY0xErYOffc86e2CcAjrKoSvqlwjw3idn85acNMQCEbpMC/UqFlFXXjYW54YVZhKyo7isr0q56/TRwOe6CAxekdW1Qk3FJTvHVjZqAsjL4kRhIuKZ43zjvSbuGeMeu0mXUABf3IPtWP5EOPdu3p8cctiwvFearSCRKhRpBvwpuxZ1kgGcmkYcFA6Q2wdDoicOA0VdLbda3RVKCCeLwzEhIvnJtmYQyzXW6/TLZi2N7VrXTuaL1k8UbKHRVBdz8ugslZAQSYKtBaXnSKye/u+MqDoljpS7YHi9ArfcA/8iQ+yVbWmgTF7uAMRlgjXx2HBhCR7we//HVvC3VFtIq3+Pd1aDE7qIY1FlbCnmAG4TQNYxELAG/kbJzb95ld4FDao+a8B+F+6SU+Su4iqkT1bi6/yXNbNFfz3nysoYr74+qTrkPcqdcRH2qB2M2DrlJOya/hWTbl2jR+J7vUejDABHZBRZvFj6am43ML+Q0xJLPdrp0Srmg==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:29 -0800 (PST)
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
Subject: [PATCH v4 36/39] dyndbg-test: add test for label keyword
Date: Sun, 11 Feb 2024 00:50:06 +0100
Message-ID: <20240210235009.2405808-37-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210235009.2405808-1-ukaszb@chromium.org>
References: <20240210235009.2405808-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

Test the use of the label keyword by selecting, labelling, and
re-labelling a handful of prdbgs:

4 in module/params.c -> param_log
  these are labelled and enabled prior to modprobe test_dynamic_debug
  trace output to the instance is verified

4 in test-dynamic-debug -> param_log also
  2 class'd, 2 un-class'd

After modprobe, all param_log labels are relabelled to new_out, then
doprints reruns the prdbgs, generating new trace output to the new_out
instance.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index ae386e4de6a4..c6d428a58889 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -859,6 +859,69 @@ function setup_env_for_tests {
     echo
 }
 
+function test_labelling {
+    echo -e "${GREEN}# TEST_SITE_LABELLING - ${NC}"
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+
+    # trace params processing of the modprobe
+    ddcmd open,param_log%module,params,+T:param_log.tmfs
+    check_match_ct =T:param_log 4 -r -v
+
+    # modprobe with params.  This uses the default_dest :param_log
+    modprobe test_dynamic_debug \
+	     dyndbg=class,D2_CORE,+Tmf%class,D2_KMS,+Tmf%class,D2_ATOMIC,+pmT
+
+    # check the trace for params processing during modprobe, with the expected prefixes
+    search_trace_name param_log 5 "params:parse_args:kernel/params.c: doing test_dynamic_debug"
+    search_trace_name param_log 4 "params:parse_one:kernel/params.c: doing test_dynamic_debug"
+
+    # and for the enabled test-module's pr-debugs
+    search_trace_name param_log 3 "test_dynamic_debug:do_cats: test_dd: D2_CORE msg"
+    search_trace_name param_log 2 "test_dynamic_debug:do_cats: test_dd: D2_KMS msg"
+    search_trace_name param_log 1 "test_dynamic_debug: test_dd: D2_ATOMIC msg"
+
+    # now change the labelled sites, by using the existing label
+    ddcmd open new_out
+    ddcmd label param_log +T:new_out	# redirect unclassed
+    check_match_ct =T:new_out 4	-r	# the module params prdbgs got moved
+    check_match_ct =T:param_log 2 -r	# CORE, KMS remain
+    ddcmd label param_log class D2_CORE +T:new_out	# must name class to change it
+    ddcmd label param_log class D2_KMS  +T:new_out	# case for class D2_* (wildcard) ??
+    check_match_ct =T:param_log 0
+    check_match_ct =T:new_out 6	-r	# all are redirected
+    check_match_ct =T:new_out.mfst 4	# module/params.c prdbgs still have the flags
+
+    doprints
+    search_trace_name new_out 2 "test_dynamic_debug:do_cats: test_dd: D2_CORE msg"
+    search_trace_name new_out 1 "test_dynamic_debug:do_cats: test_dd: D2_KMS msg"
+
+    check_match_ct =T.new_out 6 -r -v
+    check_match_ct =T: 6 -r -v
+
+    # its not enough to turn off T
+    ddcmd -T
+    ddcmd class D2_CORE -T % class D2_KMS -T
+    check_match_ct =T 0
+    check_match_ct =:new_out 6 -r -v
+
+    # must un-label prdbgs to close the label
+    ddcmd label new_out +:0
+    ddcmd label new_out class D2_CORE +:0
+    ddcmd label new_out class D2_KMS +:0
+    ddcmd close new_out
+
+    check_match_ct =T:param_log 0	# ok, but
+    check_match_ct :param_log 1 -r -v	# pick up the D2_ATOMIC
+    ddcmd label param_log class D2_ATOMIC +:0
+    ddcmd close param_log		# now it closes wo -EBUSY
+
+    ifrmmod test_dynamic_debug
+
+    del_trace_instance_dir param_log 1
+    del_trace_instance_dir new_out 1
+}
+
 tests_list=(
     basic_tests
     comma_terminator_tests
@@ -878,6 +941,8 @@ tests_list=(
 
     test_private_trace_overlong_name
 
+    test_labelling
+
     # works, takes 30 sec
     test_private_trace_fill_trace_index
 )
-- 
2.43.0.687.g38aa6559b0-goog


