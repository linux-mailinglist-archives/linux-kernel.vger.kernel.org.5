Return-Path: <linux-kernel+bounces-60614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F200A850777
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E59B24964
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734664CE6;
	Sat, 10 Feb 2024 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KfBax3v6"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057396351E
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609084; cv=none; b=CVJT3p6Wkde9JNKY1DX4CpLoRbjcfGJvsrEOjY4XPPuFzyClAtcP6nRMtL8Lgz8DbWpVRJm5Mat75cXXVsgYbRmwRKFSa9mOVNKLIHX8MTvbEEcYCxBfBwmnMoymT/tZiqbyVsdwcGlnEn0vNBYXEijKcyKGioiTCHGE06Vgfio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609084; c=relaxed/simple;
	bh=f4Sac4mEUw0BI5hmgTH6/Jq4sbbkpzY9eNebwB4W+sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyCu+/cHAw/F+MBv6QIi0YsLw2ErTGtzG6zCnRreuN9qIyrSGCJ9oTeE9OLvOfM6pDInoddeKP3Sk1Omlg3E2klaVf9MOsq1KYzCyfwH3yiyaNLoqeTC4ki08mOyuHUYlCYLf9Ij3byCqsaEa3AT6yznW0x0R0XGFr0Vmb2talI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KfBax3v6; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-51147d0abd1so2384698e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609081; x=1708213881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tkxos9dGgcrWJ0r2tCur5eWGm4CQktOnj9qwMEqGt1o=;
        b=KfBax3v623Qv6y2xTCsNLAtCXVY1WlBtL/6MK6mPY0UX13LY9E7yxVD80Rm0y4/TNs
         XOUGfbAy7WxRlmiRVHaZOwYbTrRjXYqj8UDD09NDr/PGocuMtrDl5gjC6CqzW/7h/rLt
         8CKaNdkFXph+Ptft3/wrTiTNxr5oiUrXZBCeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609081; x=1708213881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tkxos9dGgcrWJ0r2tCur5eWGm4CQktOnj9qwMEqGt1o=;
        b=IK2nzkBYlTo0R2GWgLoEdWCLJwAOaDkz/cW882CwzI3yEN2YywsqMOYGng15Y8VLXV
         IuLikfKdBCkwEInYs9G5eK80hH+x02zqhDjL/bo1QahTdP1t7yYa4ScZeioT945qEdbM
         9zJNeB4La8voeZN5SotHXo4NOx6NNDvHE3PjEgtTkU9PPLYYr7ZGIB2iwlmFXvqTF7YU
         uWpAVqGsb58bHfaLsGGnu2N9ckG/DOr1WKQt55PaC5pmCPVvWK5YnkwnGWy9wCALcSg3
         WefXYmjhxeY4jB+RvOP1e98u4qVFRTyXWQompK9FUxrZbW41NbqnbTUpn39wooyApa4H
         SIgg==
X-Gm-Message-State: AOJu0Yw4iMC0l6hkScH3+s7nRDl5LBa1UG4g7OMICBPCa9BtrfPvU7uq
	vKzQ7gDtILupMARqBskVUvJbWGnwzAOdA364fWSxW+ijn7Ye8beFVpdOoh0D
X-Google-Smtp-Source: AGHT+IGHAkCxvMTehufoxRwEMjLHz549p4jij5LRIE4K5aFDrmNzvyIUsQnDtcm9i6vPppoH6FzShQ==
X-Received: by 2002:a19:ca58:0:b0:511:79d4:fd3e with SMTP id h24-20020a19ca58000000b0051179d4fd3emr1597737lfj.34.1707609081180;
        Sat, 10 Feb 2024 15:51:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWps1kpiiPoE6sKwfqYMp+1eXTYtkI0CSuKhz/AReokCMYcZhEKgLbWk0M85iO+BPvrbIcE1EZD323/fyqJE4HjkBNzLdwYDW8J6LsKmB7cK5Bc8z3hIWTcQVnB2aCjxd7EDUFxbyO9+ofJ5tm0VGy+CpAnFkkw3MMDVZ0w968O1DynVEr3W/wuycA4d/bShuIIFH7elM+AH/UC5e3nF04Rx/Wcp97XieL7pLqhmlb9MyRZhL9Vxhaf2n+x1ySra9VH0VSYG9ZXS4V7p9X3juk/8pm080j6HatMrsqzIWqgs2OIPdI6m+9Bk1KGLhg8DLPiEj3SrMvQsY3NQ71qb4N/cFY5WtOstTpgBYVZShOZW60J4xpZTRMbSYV7LjUxpDGe+MlQEpHoSoLlPg3aT4PKscPS3d6eVc96NGMKsiMbnXRWj5E0TpZkL4Wuy7Gluhktd/vnKPvEkvowR1O84kFzqJTGpbQi7r1xbSJwiJo9KfWVp2vBbOGYFynqkJCnXDamL2shwngnxh/xRDk29wZpIXfPU+vh36nwVjhJf8HQkYPUuvgY9KRjE/zjamRdvheQsBnsot+gTu7U81KBjzcWK4cTxfhQhxfRGFdRGgvBdtIuQA==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:20 -0800 (PST)
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
Subject: [PATCH v4 31/39] dyndbg-test: test_private_trace_mixed_class - parameterize modname
Date: Sun, 11 Feb 2024 00:50:01 +0100
Message-ID: <20240210235009.2405808-32-ukaszb@chromium.org>
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

This fn currently is hard-coded to modprobe test_dynamic_debug.ko for
its tests, we'd also like to use test_dynamic_debug_submod.ko.
Add local modname="test_dynamic_debug" to make this explicit.

This leaves the use of search_trace_name for hard-coded reference
content, unfortunately that will take more fiddling.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index d1f447eef4c0..abe94af0f3eb 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -499,7 +499,20 @@ function search_in_trace_for {
 }
 
 function test_private_trace_mixed_class {
-    echo -e "${GREEN}# TEST_PRIVATE_TRACE_5 ${NC}"
+    local modname="test_dynamic_debug"
+    echo -e "${GREEN}# TEST_PRIVATE_TRACE_mixed_class ${NC}"
+
+    local eyeball_ref=<<'EOD'
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
     ddcmd =_
     ddcmd module,params,+T:unopened fail
     check_err_msg "Invalid argument"
@@ -509,7 +522,7 @@ function test_private_trace_mixed_class {
     ddcmd open bupkus
     is_trace_instance_opened bupkus
     check_trace_instance_dir bupkus 1
-    modprobe test_dynamic_debug \
+    modprobe $modname \
 	     dyndbg=class,D2_CORE,+T:bupkus.mf%class,D2_KMS,+T:bupkus.mf%class,V3,+T:bupkus.mf
 
     # test various name misses
@@ -524,8 +537,7 @@ function test_private_trace_mixed_class {
     ddcmd "module params =:0."
 
     check_match_ct =T:bupkus.mf 3		# the 3 classes enabled above
-    # enable the 5 non-class'd pr_debug()s
-    ddcmd "module test_dynamic_debug =T:bupkus"
+    ddcmd "module $modname =T:bupkus"		# enable the 5 non-class'd pr_debug()s
     check_match_ct =T:bupkus 8 -r		# 8=5+3
 
     doprints
@@ -538,18 +550,6 @@ function test_private_trace_mixed_class {
     ddcmd close,bupkus
     is_trace_instance_closed bupkus
 
-    # check results
-    eyeball_ref=<<EOD
-        modprobe-1173    [001] .....   7.781008: 0: test_dynamic_debug:do_cats: test_dd: D2_CORE msg
-        modprobe-1173    [001] .....   7.781010: 0: test_dynamic_debug:do_cats: test_dd: D2_KMS msg
-        modprobe-1173    [001] .....   7.781010: 0: test_dynamic_debug:do_levels: test_dd: V3 msg
-             cat-1214    [001] .....   7.905494: 0: test_dd: doing categories
-             cat-1214    [001] .....   7.905495: 0: test_dynamic_debug:do_cats: test_dd: D2_CORE msg
-             cat-1214    [001] .....   7.905496: 0: test_dynamic_debug:do_cats: test_dd: D2_KMS msg
-             cat-1214    [001] .....   7.905497: 0: test_dd: doing levels
-             cat-1214    [001] .....   7.905498: 0: test_dynamic_debug:do_levels: test_dd: V3 msg
-EOD
-
     # validate the 3 enabled class'd sites, with mf prefix
     search_trace_name bupkus 0 "test_dynamic_debug:do_cats: test_dd: D2_CORE msg"
     search_trace_name bupkus 0 "test_dynamic_debug:do_cats: test_dd: D2_KMS msg"
-- 
2.43.0.687.g38aa6559b0-goog


