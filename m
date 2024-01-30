Return-Path: <linux-kernel+bounces-45364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A598D842F59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3034E1F24AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DEF7867D;
	Tue, 30 Jan 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZQonWnMl"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54017D40F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652379; cv=none; b=GS7agVTM6woajWPa6nboUvf2tBYYLBGbHs75I7foW4VJhT11TTjuGs0woumA4Jxo+LYsEg21YQm4EH1BVEV+Fi+c5cTxK4Q/BXPF9rEqWzodTBJEBauTIMj/rAJ0/tus/hLMHRH8H1H1LvC46bOjj1Gr3MMJ0eVDtXEaq9IVmFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652379; c=relaxed/simple;
	bh=WUwqmJoFZQeyqmuC4k6x7kK2L9hMV5zmyghrfRiNqjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2WNKwMYoP/NnQSqvL+HZiH7ai+4jrwHY3yPKYFqnxNtaE+BlXDPhIj9aOWWbN3tI5jAEu/FDChXRWK5iAfuiYkMFG9OaeSEkU6eTw1MzAWRf5qVFKFHrZ8DGzbSVuEA6gokPVKyKxkyzspbUkkZoBsxWy8lXvSZSXBKhVRjuH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZQonWnMl; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e141ee9c14so396647a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706652377; x=1707257177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NouAp6ATROls5AjgSHn6FMH+dDN0Afdv78yAag0W0U=;
        b=ZQonWnMl0aC168QCaVQM8PAMVAq8b+Ruf4hbCJRwMHFvTR/UbyNpIr+wL8rBSxVrTs
         ucN+sdVB8sW5jhhUKshT9KwfwLydFuNAJ56NeU/hzATn30TKvKmKYJCFBf8k7lWHgQSh
         aPMh2Q2p9GBI0uYwHrxPdqB+KhTUo1veFen1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706652377; x=1707257177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NouAp6ATROls5AjgSHn6FMH+dDN0Afdv78yAag0W0U=;
        b=qQrSlu6egjDah/E4IYlGfS7bWYv/xr+E4Hz3J1bZVzi+Yt7MLS7Yp5bUv+wJjBPQon
         vPtlZB7r60uZYi3bo2iDjfPIIsW7Y7p9E+oRpZ4v4UqSQe0g6k29YAKfA++bqRO0P4Q9
         2LTLD3YfwRazDjcNEYe7DrxGb0pqnuuu/ltLnKBAEmZUKgERaHyM7dXNAh/52p+5R6FP
         Qt/0zb8S9I2tKMEuDtfflmKVW+ttysPw5v5E0+zyw6NcekpINalB/Ye2N0v01OSYjMHZ
         p8Cy71p1rHZAeiy6UNfE06x2NXw3unm/vqa/JpA/HFjKR7DuJMbca9aUpBxxpG3yup95
         tXBA==
X-Gm-Message-State: AOJu0Yw8JGVwmvCfGI2zcwWhiLrQt4XTTmOW23e9a2YKdv9URojT//3C
	t5bVp8Ym8vzLwgpFVaGEEHo/9Z69pMrY+PWRvgKEJpU5JJ9tbeRUi67BUNMoaA==
X-Google-Smtp-Source: AGHT+IHM5CIjGnaWPVQJbefnPzKTqkXb953lJjgYmVucTvoMoZOsWJbs69yFvunQXf+9oTJH3ef9LQ==
X-Received: by 2002:a05:6358:4318:b0:178:8ab7:e338 with SMTP id r24-20020a056358431800b001788ab7e338mr3080332rwc.22.1706652376816;
        Tue, 30 Jan 2024 14:06:16 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e20-20020a633714000000b005d8e280c879sm2373723pga.84.2024.01.30.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 14:06:14 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 3/5] overflow: Introduce add_would_overflow()
Date: Tue, 30 Jan 2024 14:06:08 -0800
Message-Id: <20240130220614.1154497-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130220218.it.154-kees@kernel.org>
References: <20240130220218.it.154-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484; i=keescook@chromium.org;
 h=from:subject; bh=WUwqmJoFZQeyqmuC4k6x7kK2L9hMV5zmyghrfRiNqjc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBluXLSKrOGOdtE6GxGZsc08FzWIhOaMnOeNq/p8
 lHKmLHU8x2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbly0gAKCRCJcvTf3G3A
 JsybD/9hil900CeIkSDVu7dEhGUU7Eh3jgkpN4uvXxQKhpz1xxwIYnxerdxt4kUhSZ3PU7Wn+a8
 y2tMl38HSeHfTMijx0VTRIz766tSzidw/km095DK7xlLqc1C7p0bOe1fXmjDJjZMo/h+B4iYAUP
 786UqO4ZLOPpSWWjbEoirC1DSpvbcZbf9v7z1W8wRV1v25gyUBQOvYrUMm1YCOaMm0RQGLfuLPC
 9VVUdvY4jETXBTpUlKQ7apR4LH+2R5ioDpI9ZaCEuIoZfny7BG9mJBkmXZuvWSrXUzwoqvhEQOi
 d/JwwmkQ97OSBCj3vYl/eYqvSADKpwdPKlHA1/LuyVDmqtbvEF5Zpvy/BxkFgcPvwProrebcWtj
 4Kc0aWfaId1UDIVNhDIbt2cGolemw66t7obWCVe59lXAAxjT5g1SQpAbVmnvDU0Pq88Ty4chzEN
 a5B1zUIWzfXejwU/U02FFfpn6jzIxuavta2dAkaqF57YIfzdaiKfCqE6G78qg7/EIUwJ1qsKJlD
 NtnqoqDMkGYOdmKSvMerFSc6HJuJAPskCMyoatyDAXt3Lors/XN0qMiAFiPxyW1JE7Q/EvtUcer
 2tuf3HJSurwaeE4R4tAEbTLHd0N57a495U5UbSpkLEwag6gPdKC/6sH5j119nzxFUVW0AxTv/+S YGphMUzZKOqjzuw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For instances where only the overflow needs to be checked (and the sum
isn't used), provide the new helper add_would_overflow(), which is
a wrapper for check_add_overflow().

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 210e5602e89b..3c46c648d2e8 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -104,6 +104,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__builtin_add_overflow(__filter_integral(a), b,		\
 				       __filter_ptrint(d))))
 
+/**
+ * add_would_overflow() - Check if an addition would overflow
+ * @var: variable to add to that is checked for overflow
+ * @offset: value to add
+ *
+ * Returns true if the sum would overflow.
+ *
+ * To keep a copy of the sum when the addition doesn't overflow, use
+ * check_add_overflow() instead.
+ */
+#define add_would_overflow(var, offset)				\
+	__must_check_overflow(({				\
+		typeof(var) __result;				\
+		check_add_overflow(var, offset, &__result);	\
+	}))
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
-- 
2.34.1


