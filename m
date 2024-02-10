Return-Path: <linux-kernel+bounces-60617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A900185077A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FC728AB85
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFAC6025D;
	Sat, 10 Feb 2024 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ogpwh+Dg"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF22657A7
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609090; cv=none; b=ZjetD+5wo5RevkgT6DiOXBjq3Arfqogc3GqqtXURJ5Hpyg69xBJk7pOtsE0E0oM1IG6j8ONv1tTx1IcOF6fQ1kCEtFLBMk4ivgy2nSbButm5BqjRFIcPlR+571LHQdanhiSqX24VHkCWRaGu3P8vuJVkZayCmfYWmMMRzcLY25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609090; c=relaxed/simple;
	bh=kCsv7vv1AbWR4ZMJc32afytj9AUqcxNoHWXiEW8VA/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBY/hLM5GHC8dYA4nvLjsrcxOG7ZxlTicBGhgI4+IfS4z3Lur6ASMJAs8kM2s8ilKWWkv48O7pIqlvDUxvQ2o/uLFak3+9p1C2sXyJ6IcVE7xTcMOp3i++BHqzJdx9PRGqoxnSiVZXei5o3CgxMhb3npPIMTAiNVnvtv0newlgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ogpwh+Dg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d09bdddfc9so25214821fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609086; x=1708213886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ushDYT9CMHkS5PpHOvPlq4e4r3P7CHzI6mMqFnTGQ/g=;
        b=ogpwh+Dg3ovn01Z0O5MsTrXqQ/aL6JMEOyherfUGqKdMSDMe3fzTYvG/OR0gpH9S85
         KqmVLpIT4vMo/3Y9fMDrH4Bx+hSSRvd3enyRKwTWZig14riTMk2Q4k7BGs8uupY4iuH5
         N+4LhHXfCcnFc+0xDyPqXIpC5hEyKPreAkmf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609086; x=1708213886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ushDYT9CMHkS5PpHOvPlq4e4r3P7CHzI6mMqFnTGQ/g=;
        b=JCRWvDa+XG68Iw//hcjnUdxVXSIPWbyQ3+Inbw7XapFvibFCkOKK1GYsx9QZLQRfYb
         5SOMmkV19aD5D8kXA7PI++tZVXGiXCzJRO3hJPIrIZdAVyaYiyJPGeO03G9LYCEeYru7
         MAQXK6QkU151pB3sw/YuZU35FS6Ot9HqjOxffU2ssgAI6wZQ1rvgjJD9WXx816z+7CVm
         jGlGUodlpl/B3m4JC9J9gBQ57u8ppGOCIfVW28EolY/fw1+5dDEP9loAx+ZYNPj0us3n
         adw05fQ1oB2SPupA7/plho0uHPPDa2L/pz1YIOctDibeCJWlJX1N02hPJHecwHOHjQIV
         jaxg==
X-Gm-Message-State: AOJu0Yz4LY5ho7Cz+qAZ2OXaiVaYxXHkOF6RiqqFz7mS+t5o6xsaT7oB
	4tK6DcZ4JiJ5EnKGeRau1ZYO55g4FFY5TPJjCtjQEqlLhZzQhiPTNnvlLGK3
X-Google-Smtp-Source: AGHT+IE9T5MhJ6FECbR+Iend4YQUEYeB3Zrn614YIjwekbquiiPQbDzst2PaXHgxLee70R7AxRhi2A==
X-Received: by 2002:a05:6512:3e0d:b0:511:8619:1f6 with SMTP id i13-20020a0565123e0d00b00511861901f6mr1309374lfv.13.1707609086231;
        Sat, 10 Feb 2024 15:51:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/I8yFK7IqI6IrHueBJu/5ttBCX0HoUJ1hN6lh+ps6lkXSMvmNTANYTbPoDrIP4klS70KM1YytT+GV9Xtoc7/hevPDYEWjqZErVhbR3I5zXbJWPfhQJJ8JV45oSuG27E5/ebiKxqs/5sTwqgXMDsBQn4qxgtg/2c5L0ugz9RuaUJVRWKF0elXKcGQDgFqHeyWYlSkwPhD3C0VTFzpooyyiRjyx62qjB2dUKws7zsoKfHX4o5IWcCFkHapAYfw8CghPy6elpOzFQX8MJtVDkSa0do65smDZ8Z8L6yZOrvx6kYIqkaCF5hzyB6m2E/AOEv/LJEFKUot47yhzlLwzdvV5z9DjnjxderZkDpShdqkZEI2UASfHX8IKVLpviQ6XMCMcMTzsxUFlZGyV8Pp1HSE4zzjdG+crsXZhEM/qMtlIGd8Ir+6G4JrLbKfFo4C4Ng1Nv2lkdjEJ+ajZcY9E43Zs4VhjTQhWDGmZx+UwpyztPbwUm7TRS83zIVpJ5v/tnAplj29pNTGBFo1rL1xkF3fW3ntt1/CQurg0gm0/XAlYRHbFQbVFQ5uJKsH1rCD7lZ+feJC3eZ4mQ7vHi48vGQDhV7eHby6PvbsZXpzifHWsipCOBQ==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:25 -0800 (PST)
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
Subject: [PATCH v4 34/39] dyndbg-test: add test which verifies flags and dst
Date: Sun, 11 Feb 2024 00:50:04 +0100
Message-ID: <20240210235009.2405808-35-ukaszb@chromium.org>
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

Add test which verifies different combinations of flags
and trace destination.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index f8b81e8a3bd6..4a0340d2c3e8 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -246,6 +246,103 @@ function test_percent_splitting {
     ifrmmod test_dynamic_debug
 }
 
+# test verifies different combinations of flags and trace destination
+function test_flags {
+    echo -e "${GREEN}# TEST_FLAGS ${NC}"
+
+    modprobe test_dynamic_debug dyndbg=+Tlm
+    check_match_ct =Tml 5 -v
+
+    ddcmd open selftest
+    check_trace_instance_dir selftest 1
+    is_trace_instance_opened selftest
+
+    # invalid combinations of flags and trace destination
+    ddcmd module test_dynamic_debug =Tm:0 fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =Tm:0. fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =T:m.:0 fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =T:m.:0. fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =:0lT fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =:0lT. fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =:0.lm:0 fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =:0.lmT. fail
+    check_err_msg "Invalid argument"
+
+    ddcmd module test_dynamic_debug =Tm:selftest fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =Tm:selftest. fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =T:m.:selftest fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =T:m.:selftest. fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =:selftestlT fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =:selftestlT. fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =:selftest.lm:0 fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =:selftest.lmT fail
+    check_err_msg "Invalid argument"
+
+    ddcmd module test_dynamic_debug =Tl.m fail
+    check_err_msg "Invalid argument"
+    ddcmd module test_dynamic_debug =T.lm fail
+    check_err_msg "Invalid argument"
+
+    # valid combinations of flags and trace destination
+    ddcmd module test_dynamic_debug =p
+    check_match_ct =p 5 -v
+    ddcmd module test_dynamic_debug =T
+    check_match_ct =T:selftest 5 -v
+    ddcmd module test_dynamic_debug =_
+    check_match_ct =:selftest 5 -v
+
+    ddcmd module test_dynamic_debug =T:0
+    check_match_ct =T 5 -v
+    ddcmd module test_dynamic_debug -_
+    check_match_ct =T 5 -v
+    ddcmd module test_dynamic_debug =T:0.mf
+    check_match_ct =Tmf 5 -v
+    ddcmd module test_dynamic_debug =T:selftest
+    check_match_ct =T:selftest 5 -v
+    ddcmd module test_dynamic_debug =T:selftest.mf
+    check_match_ct =T:selftest.mf 5 -v
+    ddcmd module test_dynamic_debug =_:selftest
+    check_match_ct =:selftest 5 -v
+
+    ddcmd module test_dynamic_debug =:0
+    ddcmd module test_dynamic_debug =:selftest
+    check_match_ct =:selftest 5 -v
+    ddcmd module test_dynamic_debug =p:selftest
+    check_match_ct =p:selftest 5 -v
+    ddcmd module test_dynamic_debug +_
+    check_match_ct =p:selftest 5 -v
+
+    ddcmd module test_dynamic_debug =T:selftest.mlf
+    ddcmd module test_dynamic_debug =:0
+    check_match_ct =Tmfl 5 -v
+    ddcmd module test_dynamic_debug =:selftest
+    check_match_ct =T:selftest.mfl 5 -v
+    ddcmd module test_dynamic_debug =:0
+    check_match_ct =Tmfl 5 -v
+    ddcmd module test_dynamic_debug =_:selftest
+    check_match_ct =:selftest 5 -v
+
+    ddcmd module test_dynamic_debug =:0.
+
+    ddcmd close selftest
+    is_trace_instance_closed selftest
+    ifrmmod test_dynamic_debug
+}
+
 function test_actual_trace {
     echo -e "${GREEN}# TEST_ACTUAL_TRACE ${NC}"
     ddcmd =_
@@ -692,6 +789,7 @@ tests_list=(
     basic_tests
     comma_terminator_tests
     test_percent_splitting
+    test_flags
     test_actual_trace
     cycle_tests_normal
     cycle_not_best_practices
-- 
2.43.0.687.g38aa6559b0-goog


