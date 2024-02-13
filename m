Return-Path: <linux-kernel+bounces-64556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411FE854042
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB0C28BE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DFC63412;
	Tue, 13 Feb 2024 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="anNxmPUW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195C633EA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867736; cv=none; b=ZUbYpNm9Oy1RNEmdSp+VNF0cLoJEgK5EXg1typMs3STF1q68OT8+Pm/FBvQpqJVkIC7ePRF0RDxJJmlGJPQNfGdWJaeiAPuLXbc+GpArJvT74a5sNJoMY4fUM6eaJgGEhXyBoxKKXmZfcbob/nEH1woJgaekfGQQCehWV86XANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867736; c=relaxed/simple;
	bh=Vl4fdN5cpGUJaEVd/d0wmt2xUmRLpJ113oXlwnbICno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKAlUX/DE9/0adPkKFOK3TruM+bP3Xu5YGzno7Zg5RCxq8ZWcg+MZlmvrPsvwjNOnEfg5fnWMpu6YWuceJweGWag+7ojSK3M7/m19D2HS9OShGj+AUtb2sevjE0L1KzSRvj6UbWuAyE7BlRAWCuRr0sdyNwzyn+WBlZD7WTj2dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=anNxmPUW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d94323d547so43245345ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707867734; x=1708472534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl2LWzzN8MyLhz/HbCD4r7+bt4+VkpQDGtXfFs0staE=;
        b=anNxmPUWkU3k1Bjt6yqXzcrBgXBU/ObGoY2T/aIAOR1B9z16vYkTAlUFm+TwSigNp4
         ztI/roP6UEbWOb3qZsZbu569DPRmQb5aFwUeNxmn7WGjpC6kl26r/6w/67dPVCtAwHSI
         RTO0Hvnz5t5/RNg61LmRekTikwsUtFVu0NCAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707867734; x=1708472534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kl2LWzzN8MyLhz/HbCD4r7+bt4+VkpQDGtXfFs0staE=;
        b=v6mKDc7Zu1/JxJUt11//cTVl40sHROLmf1GnbM9hndwSQE+5cNfUmUP56ivhaKA98u
         VbFDa1GpI9JC4WmOMN5zdNUt4YlZ+0LDgp7YcVQCpzz74/PE4/yN85ka7vSCGNoesxKR
         Yj5RWd/YIOungjX/Z6mIZmUxBdqguekL2tmgk0XqxtXkuHyn/nRgwjzoUBEI/Jeo1mPi
         +RSvxFDMvETmwj1ToOaR2WmJWix9Z236Yh5jQAVa62eeq+4EanaTBKtfRyM+Z1V4NMm6
         KdmRTQjLTpSHWnw7Bp3zBktUR/qybyUcN+F+yBthE2ubVw8aqC1viX+e1xbwClNv3SUy
         Z6fw==
X-Forwarded-Encrypted: i=1; AJvYcCXr+6Tezc7bENbPVWgpcp1/KMBojLYYWrF8+KB13cABdKwH3VHlfMllDBg3XWyyBO6sXDPIHpWiR0WPhHrP4iY/tGjg9GOepr3Su+zT
X-Gm-Message-State: AOJu0YzSYoyhU9PY6/RaJxikJvsjZSK6W+a1GDH3ahtX9oOoHp+icPY7
	tnfof0WMKoGFjPP6VKmP5mDzNGmAqxmPj+WEiY4YhgH6wXjf24lCt0xwzImZJQ==
X-Google-Smtp-Source: AGHT+IGtSgnWyCSH3qiLiPQZFC2sSoW0AvKsvDJfLvbHlsqg7pCLSM5fOCksbb3s9CdwRIlw+Fhesg==
X-Received: by 2002:a17:902:bcc4:b0:1db:4213:41e8 with SMTP id o4-20020a170902bcc400b001db421341e8mr1065887pls.69.1707867733891;
        Tue, 13 Feb 2024 15:42:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWz2viB/lB71RPgqINheT2b5dsUoRzdQFbqLreZCRsMJA1WJTSmCqzNAXQ8vLgFxvOITSdL2S4gjMc4StKNV/JfvxTXTTXrlo5SSaausKtQswwku7LybJtVCBL29himU7p5+kc08BeX+Ws+9mnpIIBnuU66RCW0Rp6mdgPvcP1ILo0SOqJXDhYYLpxVqYLq2wyrno0lCVhb/xijD9bMYp7EjFbnCazl0Zl1vNYijxJjmeJqYQ3Q4nevYmj3dT7wYeGjD038BIWd/Xb3aMJuzSuD3XoacGI29/SWgAgY/xggmiXqFSJLfx7VYz1n1qhh1M6aSWgB0SAwuGE/irr8fxB2j9Di/AnLTwC9zwV8F4rcp2VwvXkE3XK1Ut29nN18l8Q6T+YGpSSCNZHX1E0qfVvC6mobsbSFo7/HPP/fgsJIw+DSUGp+qucHlCLcTdwycYSQMws88W+NzCNCrkkaWUujD0WgNQxcwvRKki35FgBqofesb5nitL/dTtZv/jIQ
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902d10200b001db5432449esm220101plw.18.2024.02.13.15.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:42:13 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Packard <keithp@keithp.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] stddef: Allow attributes to be used when creating flex arrays
Date: Tue, 13 Feb 2024 15:42:10 -0800
Message-Id: <20240213234212.3766256-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213234023.it.219-kees@kernel.org>
References: <20240213234023.it.219-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745; i=keescook@chromium.org;
 h=from:subject; bh=Vl4fdN5cpGUJaEVd/d0wmt2xUmRLpJ113oXlwnbICno=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBly/5TQc6E64Lzj29qmQN4Jwy7MrKuI/F1MJFh2
 tmtoHAY6iKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcv+UwAKCRCJcvTf3G3A
 JrCAD/9dUQyB4Kg2htW/OtV1/JApegYxWNiu0BRZxvGYS5pHECr/K3BxDugfXOko4/zESjBoXjf
 oKne0LTCU+n6HuPlWp6zmQdUyux22FU/GI1RK+CAPWxrDo7Eoaak9k5mVZlkyE6LD8Ur6gpQnYQ
 5spQWCBBmJPZBxZEbArwX9oIAyueehEhaKnNnpuOwLwS2n3uItshYSU0dl7bHLiykxU9IhDOTS0
 Addl13oIkvwVsAGt5fSXKor/Yl5ngDyBFQIImhm2IyFU2lGqVhjJLrEA5y86fHBxIwzpNQLn1BF
 b3VUXrW7G/SWYh/zz8T2miyJkQd68mFy0Qg8LOYVe+dlxtCoaq/TCB0mL1aFBOsSces26kbUWGK
 KydqjzrCcM0VZ7KlMxbCydJB6nQEEDt/PvalBi0LVIor3+9kPuOV1lzkMK0GBDM8ZdhG3GtbWxq
 /yQA8FhQA8og1cCFordZak+S9xid/nf2DXzA1/pa8ZkwJyMfOMAKvz3pNgKLfFSER+p2CSY8+Hq
 HWrc3oXSv5OmGw4mxX7QFe28Z89lG1Zx40NxOU7khlU4GWSK04QnxYjfxLwcF3HEHNhnBHuGjnw
 10bvJcrtCAtn7+5deAIUPhecENMUcoNsCrhff7IvMnLS45PKWWnb5SVt0DCqvUxFHcmG/wPnyPF PQc/zLP/3RX7jkg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With the coming support for the __counted_by struct member attribute,
we will need a way to add such annotations to the places where
DECLARE_FLEX_ARRAY() is used. Add an optional 3rd argument that can be
used for including attributes in the flexible array definition.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Keith Packard <keithp@keithp.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/stddef.h      |  6 +++---
 include/uapi/linux/stddef.h | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 929d67710cc5..176bfe8c0bd7 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -82,15 +82,15 @@ enum {
 
 /**
  * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
- *
  * @TYPE: The type of each flexible array element
  * @NAME: The name of the flexible array member
+ * @...: The list of member attributes to apply (optional)
  *
  * In order to have a flexible array member in a union or alone in a
  * struct, it needs to be wrapped in an anonymous struct with at least 1
  * named member, but that member can be empty.
  */
-#define DECLARE_FLEX_ARRAY(TYPE, NAME) \
-	__DECLARE_FLEX_ARRAY(TYPE, NAME)
+#define DECLARE_FLEX_ARRAY(TYPE, NAME, ...) \
+	__DECLARE_FLEX_ARRAY(TYPE, NAME, __VA_ARGS__)
 
 #endif
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 2ec6f35cda32..028aeec3d7f1 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -31,23 +31,23 @@
 
 #ifdef __cplusplus
 /* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
-#define __DECLARE_FLEX_ARRAY(T, member)	\
-	T member[0]
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME, ...)	\
+	TYPE NAME[0] __VA_ARGS__
 #else
 /**
  * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
- *
  * @TYPE: The type of each flexible array element
  * @NAME: The name of the flexible array member
+ * @...: The list of member attributes to apply (optional)
  *
  * In order to have a flexible array member in a union or alone in a
  * struct, it needs to be wrapped in an anonymous struct with at least 1
  * named member, but that member can be empty.
  */
-#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME, ...)	\
 	struct { \
 		struct { } __empty_ ## NAME; \
-		TYPE NAME[]; \
+		TYPE NAME[] __VA_ARGS__; \
 	}
 #endif
 
-- 
2.34.1


