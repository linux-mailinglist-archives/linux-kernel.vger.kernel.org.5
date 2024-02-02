Return-Path: <linux-kernel+bounces-49663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7316A846DC0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A285294683
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8467FBA9;
	Fri,  2 Feb 2024 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DToJVy9J"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A97D414
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869013; cv=none; b=SBHyJFALdSHKr0Blc8uqqLvj9UMX+n5ymp5/dwHvVlj/tluhBSJNb9HtigD5uVykVt7aPflmtFRvllPZdS27CQRxKBDREV6gR93uozGYmVQRef0L6I233OMOSIg8MnCuIqrAWS019Cu8PsPMiVTip4Nsx6cAGk2iHpxyy6+pOec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869013; c=relaxed/simple;
	bh=jK+D77ByRXO1IX7WwU8qUvR5ixL79v+nVqcsnlmg2d4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YyDpE0YvSZXzrWkUKe67XM/MQcRC6JsxGIUaPa16aeEsD02RyBw+h85vWbhxmoHe1l1MnycQVWnBU1ibLwSAalEMkbGIaLL07mRs2mLCsMIwh34/MO5++ZlzDLYVs58LYB9X2jostsYetojwYB1GVT9DSFUCMz9qTHPjZzWK2WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DToJVy9J; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6de2f8d6fb9so1451897b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706869008; x=1707473808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2i1VCkuXMuVXp4gDavRJYrrSt5NKbgy/NVoBDThh0M=;
        b=DToJVy9JYCtrCC96zDO/XFXd+2XZ7vTOU/D22H0eUEQMVwUUigSuiBgNsV8c3L4Ala
         FOKeN895NiWPA2MU80K+f480mpVj+oTP7IZVTCftaG7ZLVAFBcfr94HfgeJbI3c2XgvS
         TVMtupYT4BU2zas5pSLm2W7+LbZPw3eWq2+uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869008; x=1707473808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2i1VCkuXMuVXp4gDavRJYrrSt5NKbgy/NVoBDThh0M=;
        b=bw7OkDpoU1l5S2789/EorfHW3Hvyjh4w/QPLguOKRud0mDtpR6w98uyB6TTmG28/ow
         Vl/Xb+6La+xsLWBBaxoQY5eUjF5QNKuAoA9px9Izbas1h8WnqhSuohrSbt0NUMkEaxhY
         hl9QDNzvmTZMDD21KhYerBRQ5ZLRXWN5HFfd0xvaHoeMjxUG7e2VdRyMb9bIdG3rVciH
         xVOLytgm5B3Cq+L3wF4YzpM02swZQ8f5kYMYz2oqf9up3+fTSMO/UrPF49IL4OdcVJUD
         4NdfzZq/650Zi+w0KABeJnjksgKuKNMH1LMTlZNiIKCQ1+lY3gS1bbeBNn3bDseR42PR
         rFcw==
X-Gm-Message-State: AOJu0YzMrDS/RMGUPH3VGjczXo0onem6dtwtKw2goNMVaO4vfYU8cuDd
	0MXbUYTknN1kTb/bDUamDMgYpE+PJSIFvovSccRLkBJmRe9qE3bw2MTcKYD72g==
X-Google-Smtp-Source: AGHT+IE4S08XvfJsnJFtMBd87a+nUF2KOBr7nFdXVk6F6tJ0kBV/x0WzTPI9O1rVBFaaUS2xgrt8Dg==
X-Received: by 2002:aa7:91ce:0:b0:6dd:dc11:8dc2 with SMTP id z14-20020aa791ce000000b006dddc118dc2mr4100538pfa.31.1706869007910;
        Fri, 02 Feb 2024 02:16:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDF/5dB62m/sOjIqROZhnkW89FEkANVVRCSsiN/ECr+FkD/dgzhBxf+QOf9Bopcsha5T9PxAHFUDi3QZWoMBiC/pX77aRBJUfzZxheSKG9/0eOmFQCqXOQUzCEEdEhwbSw+zKV6uLqk3vdhPxP14K3DR9aELUUi6rQjbiBopkV4FYXxJEH8tuRgBjiPdjsYHIdSCXFLFdm8bItwabPBnLxcyhozafogQgFWE2oKxWm/bO97nDtoIdk8pJSEn5H5shYVIMLAw2Lo7psd/ru+eRDTxXxyJZOBMzd6eFuhmLEXFYJqFip7UWZt8IX9IKmnLy+s5GgNwfO6ixvMFckrJfpN2sTdxxiaHdMZQ5chuVmbyIVB9Ymkq/owWzUq9AvlOlI/lP7F7ONWYRCRYAIsGLehIvhVXP2kFvJhdDcOLxCq4KAXZxmu7WmJNDbW/lHEuHnhzHdgW80lkvnNGxDxduqiHvIWrq8VdIx+zae64TdojhtWt74NvdU/jiAutJBSj9XfXrzslGQ6hcf8iwp29Gp32w3/ZWL4bRSviEJaJ2boN/RxgS9W5wsHGvgWF4Iipq46c2DXvwUxpJyDHgV6lYB/RAQa4TRCTYLE0E=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e13-20020aa7824d000000b006dff3ca9e26sm1239888pfn.102.2024.02.02.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:16:46 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	Fangrui Song <maskray@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 5/6] ubsan: Split wrapping sanitizer Makefile rules
Date: Fri,  2 Feb 2024 02:16:38 -0800
Message-Id: <20240202101642.156588-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202101311.it.893-kees@kernel.org>
References: <20240202101311.it.893-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2922; i=keescook@chromium.org;
 h=from:subject; bh=jK+D77ByRXO1IX7WwU8qUvR5ixL79v+nVqcsnlmg2d4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlvMEHcstMJILdukRJsh4gmujuHAUYtz++GFAVQ
 hi5nayK60OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbzBBwAKCRCJcvTf3G3A
 JowaEACziZiRMYcrf/X9h0kVApciR6BUA2ipAJztgKdBqXSmqSmN+Y6Mb6YdFdkhaeZXUGVuYtt
 6JibThi3e5zQSYGkwCG90aHZ/eoDTqApfT1HU538snWRN2mcmXHdCpXmZdVluThECFpOcYvyZyQ
 tWw6/AN9BsGeXsis0CO4wEdlk/n6BjoiRyi4g9X6IpD1Y4q0nJI+Cq2BlzpIBWdL2jOZ5JpQ9Nk
 DpgnFT3xUV/0Povx7yOkoC+ZEGCAOzJUfZ99G0kBxs0H3FwS90IH6U4hXYyN+ZANHRI/O4bsRjH
 VYaBIzURtbJdVzaK5UDpLoKaY+J8NtdBQWfldHf2YABl0wzsJjAL9Q3Fbg0Oom40WoNUVwa8QNF
 oL86NjJxmkhWR+j6NMy25VPdYgu9UHUWjB8VQ8+1kk0QZZbJioYe8aWYCyGbbq8KIwGKbaQ8f7R
 /GldqBleFNBG5HmKyGW4pfxBBInKcQb+SkFoavF5uzC3W+0U7f0xfPP3uJ/J6UTPAMORvuVoW8v
 XBgHMkiZm1kHFRDBB4HVC/ABM5/Hu3zHQOhOd3rMX5vJFZHEHWcjxC5viK/WZ/20O60lfOi7M5M
 hHYncOQDEHnVl92cC50LrnbUP29vgrq7u5RwdpAjzX2Wy1u8NGYLAIeGVG9B5QeiKKJtK1q1QGU tbcygIg9nEmuM8w==
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


