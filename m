Return-Path: <linux-kernel+bounces-43317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A11841213
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3B11C20B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A9876029;
	Mon, 29 Jan 2024 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Li922uON"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D562E3E3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553257; cv=none; b=TcD579+TvsH4Kgp4M/rOWqg2ni/nQTfwKtAG84+KPXU5+pcKOJsdV/UZiU5BtAc/TRaEXeSVQjCeG7WpP0FPJHholxQIBpv/HMb638GGAYH5pmP5tGFH7NzlAq0BBbqwHAGNdczB6NcgaVN5vhT5kDxZUC48MlE1TNHEoA8r/EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553257; c=relaxed/simple;
	bh=TkGXzhmMsiMa1PWFTpBaFNkI1+hVlr4epZx1ZfDkHH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gueO2lKSoqjimIG2Bs5DHsvp5+uEWtXKkurqkRYXCAFY5dwKu43jJgzXo0w60lORXAEcIvbAuFvkBwZtNqIL/4dhrJVaYS+yw2JvD9f5mk6Dn6kv42I3G1SASk1jLZ5nEsTnGl0VldsDBN0hhx1zJp5F650KFlbVLSq/V7hc75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Li922uON; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d73066880eso25097295ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706553254; x=1707158054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut/mwzE7MYTcOhpnl2PC6RnNQ1hfCYsAwYLh2JA5Y4Y=;
        b=Li922uON9O8oMWgPEWQsvxKbFZLQwJEBrUG1yimGo4zEm4ZHtljzJ9/j3Y7CH5NZod
         vOpFQgbyAWCliGpW1U4vo88Ao9XuiGhqRqgkudge3pjaPs7nLe9TXj1Opv/yxhwCvVfP
         ZDfc1K88tDwFHaKyVcnQawC6GHE7wJAbdmWfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706553254; x=1707158054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ut/mwzE7MYTcOhpnl2PC6RnNQ1hfCYsAwYLh2JA5Y4Y=;
        b=lK/R6IvaEifV96U5K8ac83Kv7/HmRsuNzaHNZep10mRagLmUWSUHexu6a5XHgCpkjN
         oE1P74QYmuf0jfxW0Bg7xwwDug5pZeRR3YPsJoUzs9AyIrqH87QiIewBIz+kNc1TCp4w
         h5jDVds3k4HJaCiP+D/6YzIQaJ0/X+NTecMAv9X8HIpCked9f0xcXmuSD+kuwGDGsKKb
         j2yPKlOyDoeu+y3jjKFKb2TtvPKzJ5SRvZkqFfrhVjGSQMEXhRSt4R+N5EMwgmB7TpRu
         YBgfEoj5FZB87HYoa3eWfXLVaUFilZr2edgLZ7XJKWxarZc/nVuKsNPjV6Ygyrw0QFWS
         1lDg==
X-Gm-Message-State: AOJu0YxVhLBIMLDeWbfSEBMZ9E9cup6vaaB11YUtyYCI9BNK6pJ+jNzi
	cRhSFz5qS9OuW+hQd1IxBLVgg4HvalmcTGg5VUz1VSrc9CT0NtvkeR3UgC8TUg==
X-Google-Smtp-Source: AGHT+IH6dZ1rRXYnhtZTLwkcgh8WtmAvjMTt+D2DxhUfKDmJjP72hTZZRFC8nXCw2WwGEPDnQKqXSQ==
X-Received: by 2002:a17:902:d2d2:b0:1d4:79b6:101a with SMTP id n18-20020a170902d2d200b001d479b6101amr7094150plc.41.1706553254040;
        Mon, 29 Jan 2024 10:34:14 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l20-20020a170902e2d400b001d8d04a4fa8sm2901537plc.300.2024.01.29.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:34:11 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 4/5] overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()
Date: Mon, 29 Jan 2024 10:34:08 -0800
Message-Id: <20240129183411.3791340-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129182845.work.694-kees@kernel.org>
References: <20240129182845.work.694-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3158; i=keescook@chromium.org;
 h=from:subject; bh=TkGXzhmMsiMa1PWFTpBaFNkI1+hVlr4epZx1ZfDkHH8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt++hK9Jm3TCzbDDH51Jo2mzGgDpwMGUkOtuJU
 QUJDdD+M1OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfvoQAKCRCJcvTf3G3A
 JpMnEACIDIfxlXxSvKgaovNDRo06Qwxv/Efu7gcMzMGToUs3My4Fpk+mvZKqS96GiEhsryzwUJz
 fUFJRo7d91i8UzwREV8/bUiDqlG8/AjBo223WzyXsEbFXP6AYFbQZ+u1/kJVGvADUSZQAmEdDwi
 cX1apJQ+L2+mTl3Ea1AjR7g+ZFLZ8L8JQU5roq4qtTbQ5fgNkQ1cZyJHPXszvCiaI6PyZGAhCdc
 xaDQHlk+BWZBu3RZzsFIjCqQmdwMq4ODa2CFPlU24l3ieSW5tLFteFxZ8aV7ROnIyHmCsBKZZwm
 l1aDRPo5Lpodt1XZYje7+Ro8yFC9vhz44EOmYt8KgdN8SrnTayNmB6DmPYIZ50QnJcU1Belr89g
 ya1k/PEjDJkhU9LwKcFaG1YVtwYgqVC/deldCnXjO15DQ/cn41/oklBcahAgX8G7JaPMdIk9o+P
 i8BXn/qNmBkTTEHk50Z508nRQDUON8MPqQACrykwGi4vx5oA1B7liScB/wStIMzvz3qxbEzgWCY
 HgVYns11WdvNW/dSWC+05VrABisC0qj2aZTG1CU+L0+DC6TtH0s2V6Gd1/KY9puh19HRBX274KQ
 jRIq3uBHr2/MuB31EAB3hSn5qmOpxCxgevF+aVX1Z36PGmr+fOGlgxCuUwR7b+wAiAWFayuqa6K x8dUvx838KCDL8A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Provide helpers that will perform wrapping addition, subtraction, or
multiplication without tripping the arithmetic wrap-around sanitizers. The
first argument is the type under which the wrap-around should happen
with. In other words, these two calls will get very different results:

	add_wrap(int, 50, 50) == 2500
	add_wrap(u8,  50, 50) ==  196

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 3c46c648d2e8..4f945e9e7881 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -120,6 +120,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		check_add_overflow(var, offset, &__result);	\
 	}))
 
+/**
+ * add_wrap() - Intentionally perform a wrapping addition
+ * @type: type to check overflow against
+ * @a: first addend
+ * @b: second addend
+ *
+ * Return the potentially wrapped-around addition without
+ * tripping any overflow sanitizers that may be enabled.
+ */
+#define add_wrap(type, a, b)				\
+	({						\
+		type __sum;				\
+		if (check_add_overflow(a, b, &__sum)) {	\
+			/* do nothing */		\
+		}					\
+		__sum;					\
+	})
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
@@ -133,6 +151,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_sub_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_sub_overflow(a, b, d))
 
+/**
+ * sub_wrap() - Intentionally perform a wrapping subtraction
+ * @type: type to check underflow against
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ *
+ * Return the potentially wrapped-around subtraction without
+ * tripping any overflow sanitizers that may be enabled.
+ */
+#define sub_wrap(type, a, b)				\
+	({						\
+		type __val;				\
+		if (check_sub_overflow(a, b, &__val)) {	\
+			/* do nothing */		\
+		}					\
+		__val;					\
+	})
+
 /**
  * check_mul_overflow() - Calculate multiplication with overflow checking
  * @a: first factor
@@ -146,6 +182,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_mul_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
+/**
+ * mul_wrap() - Intentionally perform a wrapping multiplication
+ * @type: type to check underflow against
+ * @a: first factor
+ * @b: second factor
+ *
+ * Return the potentially wrapped-around multiplication without
+ * tripping any overflow sanitizers that may be enabled.
+ */
+#define mul_wrap(type, a, b)				\
+	({						\
+		type __val;				\
+		if (check_mul_overflow(a, b, &__val)) {	\
+			/* do nothing */		\
+		}					\
+		__val;					\
+	})
+
 /**
  * check_shl_overflow() - Calculate a left-shifted value and check overflow
  * @a: Value to be shifted
-- 
2.34.1


