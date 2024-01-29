Return-Path: <linux-kernel+bounces-43264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECFF84118D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192CC286EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D8158D9E;
	Mon, 29 Jan 2024 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hoaNNWyd"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233A157050
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551255; cv=none; b=HHyX6O7tkN0UTXTlFfY+H43FATQU84IQarZSHWLQ1pcnA+d2JJxKOFxUZ69RWTDnR9HKt9Nf6s/UDHPK9+NLEkCwwoj1yVySzLS+lb8zkSIgDM3GX9P3sPRNcp2OA2Z0tWuoeV+VpZpl9O4ct/YIesxiBdWtZNeKO3xLD76wY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551255; c=relaxed/simple;
	bh=jK+D77ByRXO1IX7WwU8qUvR5ixL79v+nVqcsnlmg2d4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHoN2drz0xMJ2txfrMxXcBGqivVLOP1TjCV/VaIF8X1Idfg4Wr8JLgwK3zTpVnqHnKNwuRjP6QvBPyc0kxgsotazoawHw+ljRPBVPR77O9aQB4yJWJXXIyqfsbEC1hbKYkM3Xh/LbqOTlu+RWTKFWA1MjQdrfi+hTlBNxr1kER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hoaNNWyd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2909a632e40so1464110a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706551253; x=1707156053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2i1VCkuXMuVXp4gDavRJYrrSt5NKbgy/NVoBDThh0M=;
        b=hoaNNWydrTTim36PvAaBUYkg6XpExmm/AJNMQyuHIKOYHMBli1qHr21igRu3CTrqUu
         3+oVsz529DLdCyuN7nJQe2DHyZYncVJuGo4dvEX5f/r94niJBdhLBd2gdlfraXNyDVs8
         kFYPvVYrjd5bg8FF5HWuP5mSKdgUHC582Apas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551253; x=1707156053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2i1VCkuXMuVXp4gDavRJYrrSt5NKbgy/NVoBDThh0M=;
        b=FNvv8mcvqvEWxPTjoPjeWV3ZsENCbLjp0V0ddWg6EZyRZv/AIx2thlkzQ+PmA6eCiO
         czwtxnyZ3YoI9HxFUHcDS/DJoYk2vjTAQo7prxvRmbbERivKLjE5BlRVwEY18uuraMU4
         Xczd/xFG1MVVu3M6M7WfPXsF7o4KoqTrd/PXb6/UTJybzeXE8ytYEWF9CvfkTRi1c6pa
         01xufIMNSlyeJA5PiHIMln6oU9wnSX2wMVmZUKqOHzquSYU9mhuynVimIOaF0xOU7MdR
         K7punQjjz1xqcBuJRg9iaG9ljHDA0QNxXmGWgazs6pKdYWNwirOkSzxNkhNcWpFZ1cYb
         7lTw==
X-Gm-Message-State: AOJu0YzrICIiC0p75OwcvH2qTeIBkocELBwsK31x0+oe9KyjjAcZE9Vd
	q+jFEXXrroLAphjM7Z0KRuPxLiaOnzQd/FdjPsy3P9CvSgH6aevEMor4lwbUwQ==
X-Google-Smtp-Source: AGHT+IEFMuGN+nazKIGePnCBK93B/dcIkGpPVgGGjhO3ldJhS97s0IuMoBP3m6PSrC3bqjW/AXrG7Q==
X-Received: by 2002:a17:90a:6303:b0:290:664f:b52e with SMTP id e3-20020a17090a630300b00290664fb52emr2540818pjj.38.1706551252969;
        Mon, 29 Jan 2024 10:00:52 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b001d8fec31348sm325955plk.294.2024.01.29.10.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:00:51 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>,
	Fangrui Song <maskray@google.com>,
	Bill Wendling <morbo@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH 5/6] ubsan: Split wrapping sanitizer Makefile rules
Date: Mon, 29 Jan 2024 10:00:42 -0800
Message-Id: <20240129180046.3774731-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129175033.work.813-kees@kernel.org>
References: <20240129175033.work.813-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2922; i=keescook@chromium.org;
 h=from:subject; bh=jK+D77ByRXO1IX7WwU8qUvR5ixL79v+nVqcsnlmg2d4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt+fLcstMJILdukRJsh4gmujuHAUYtz++GFAVQ
 hi5nayK60OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfnywAKCRCJcvTf3G3A
 JvEwD/9mLJX/yCioxqHFplE6Sfs88ZUCvIWUegUYyLYqmW8FZNkwvz2hvrM6bY0we9ehQA+GsLY
 DWrfIOOKPYfNhb3K8UFSxHoHG4yQLg3j34ztkhnJt4ft+Toj2Uvn+GK5P349nQUrYAVgyGnmUcy
 pkpCS7FvQQfbQNXWxaWwl94ncIAKRzcYcgCKpxbORR6xqyIUjawjtceNK4N3/uku97s221SyhOD
 mkfjRRfg4DjBr+h+SZMa74boc3Yn5CYHKeNm9YZVAf/MzYCKODkSG0ZvLJTkladg6gDRxCxl6Wf
 YXhx7Tn63ADsL9fYyZNMHLuefXcanHemLC8v8rPqn3niih4BzNKq+8VNdjqhYOmd/RQfkNDe+8+
 AZ/xcu2uIO03enV0eEUuYaO3aMHYHb2k2/MWLh3N99fpivvtStuiIsfJam+PAnkrz+8s/ejwQi6
 CbvYokDbBsnn7Lh859fSJlZ5TbxsZgHHXZ8lhY49nkY4X9eakeAutkx7zmROnu8glrY+8hlrTPZ
 x8k/60vawNSEUHGFVIFaoCYDJ3IfCMkKcfwf1J6qEG3F4Vp9O9AxrBbRbAVHx+Idngc5hzhCw+7
 vQhslezHOkCFdtjb19sRFaAJItaXno6VtYCq3pR3es0iijSSI6E69Lj9FgzQmyuFVbdUF2JdyR+ gg7Rk56aU/LzPPw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

To allow for fine-grained control of where the wrapping sanitizers can
be disabled, split them from the main UBSAN CFLAGS into their own set of
rules.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/Makefile.lib   |  9 +++++++++
 scripts/Makefile.ubsan | 12 +++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 52efc520ae4f..5ce4f4e0bc61 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -177,6 +177,15 @@ ifeq ($(CONFIG_UBSAN),y)
 _c_flags += $(if $(patsubst n%,, \
 		$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)y), \
 		$(CFLAGS_UBSAN))
+_c_flags += $(if $(patsubst n%,, \
+		$(UBSAN_WRAP_SIGNED_$(basetarget).o)$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_WRAP_SIGNED)$(UBSAN_SANITIZE)y), \
+		$(CFLAGS_UBSAN_WRAP_SIGNED))
+_c_flags += $(if $(patsubst n%,, \
+		$(UBSAN_WRAP_UNSIGNED_$(basetarget).o)$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_WRAP_UNSIGNED)$(UBSAN_SANITIZE)y), \
+		$(CFLAGS_UBSAN_WRAP_UNSIGNED))
+_c_flags += $(if $(patsubst n%,, \
+		$(UBSAN_WRAP_POINTER_$(basetarget).o)$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_WRAP_POINTER)$(UBSAN_SANITIZE)y), \
+		$(CFLAGS_UBSAN_WRAP_POINTER))
 endif
 
 ifeq ($(CONFIG_KCOV),y)
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index df4ccf063f67..6b1e65583d6f 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -8,11 +8,17 @@ ubsan-cflags-$(CONFIG_UBSAN_LOCAL_BOUNDS)	+= -fsanitize=local-bounds
 ubsan-cflags-$(CONFIG_UBSAN_SHIFT)		+= -fsanitize=shift
 ubsan-cflags-$(CONFIG_UBSAN_DIV_ZERO)		+= -fsanitize=integer-divide-by-zero
 ubsan-cflags-$(CONFIG_UBSAN_UNREACHABLE)	+= -fsanitize=unreachable
-ubsan-cflags-$(CONFIG_UBSAN_SIGNED_WRAP)	+= -fsanitize=signed-integer-overflow
-ubsan-cflags-$(CONFIG_UBSAN_UNSIGNED_WRAP)	+= -fsanitize=unsigned-integer-overflow
-ubsan-cflags-$(CONFIG_UBSAN_POINTER_WRAP)	+= -fsanitize=pointer-overflow
 ubsan-cflags-$(CONFIG_UBSAN_BOOL)		+= -fsanitize=bool
 ubsan-cflags-$(CONFIG_UBSAN_ENUM)		+= -fsanitize=enum
 ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(call cc-option,-fsanitize-trap=undefined,-fsanitize-undefined-trap-on-error)
 
 export CFLAGS_UBSAN := $(ubsan-cflags-y)
+
+ubsan-wrap-signed-cflags-$(CONFIG_UBSAN_SIGNED_WRAP)     += -fsanitize=signed-integer-overflow
+export CFLAGS_UBSAN_WRAP_SIGNED := $(ubsan-wrap-signed-cflags-y)
+
+ubsan-wrap-unsigned-cflags-$(CONFIG_UBSAN_UNSIGNED_WRAP) += -fsanitize=unsigned-integer-overflow
+export CFLAGS_UBSAN_WRAP_UNSIGNED := $(ubsan-wrap-unsigned-cflags-y)
+
+ubsan-wrap-pointer-cflags-$(CONFIG_UBSAN_POINTER_WRAP)   += -fsanitize=pointer-overflow
+export CFLAGS_UBSAN_WRAP_POINTER := $(ubsan-wrap-pointer-cflags-y)
-- 
2.34.1


