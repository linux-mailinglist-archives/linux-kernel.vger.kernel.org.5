Return-Path: <linux-kernel+bounces-64444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEF8853E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A521F2636C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE8063404;
	Tue, 13 Feb 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWZQLKXQ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C99F629FB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862266; cv=none; b=bMM06wZApENOPZnh9b15GsVj9V6f1nB158mDge5ma02OcoIunAGYWsf5sT9TlEa909BX99sLnlxXYwUwzsHM6enSmwGqN2uyPywrEu6fuNebSMwnFNM3GrWhU5BodFQ3DVOxfOxILwahqIeoy/PPjQNyek/iha3cKZ+y+JJCQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862266; c=relaxed/simple;
	bh=ixNr6X1gB7VeIiW3pk9Za3U1z37zW3zrQNIbl69tCT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SoVnTU0scVA0N/EE8KOzCrLxB6FGA/eryhhqGRSJ+ObhRtouBVaIJetLrPk3VGDpjrz0+L+qfT7KslmkEi6GTE+Gz8iorEL/L8ZpOj2D47xQyzvYAtbYFIzTfvVvnCc6zqduKtCzgBBAq4RCiY0RH2i6fG/ZKZlRLq9TL+xRyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JWZQLKXQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e0a4823881so2008080b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707862264; x=1708467064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RerG7d2KkWMxwjKi3Bk1dJMaOiX+RZ04/h8EQNw22Ro=;
        b=JWZQLKXQ7T5nBIvtqjRlLDOkqLx/3xem2stwSt3WYI0ul4zJVVoGmQpDWVxMnbNK1x
         43EeI1qLFf+mpUjx73fUs0rrot3TBVTpnzqjkDnSlwKgkLAeBtMy78TmxMd7dqm2AVBZ
         xJcvr/eVV5DxuU/DNQd6+VzVdkyC0tY3qC/ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707862264; x=1708467064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RerG7d2KkWMxwjKi3Bk1dJMaOiX+RZ04/h8EQNw22Ro=;
        b=GcDIMtTNbBeJNWISdgVmW/d9IQlBUv7e9k4/TFOXkmA+DuZYoqJY1YtL07hOr+B70F
         sRq99ZWa8MWaof7Ix2E/3seXYqeGEtztM/uU4nDr99xbP1jHXuMEJFumSUayQq8Vg2e9
         HytX3HU6VX3+oqr+B0dBwZMPUpxaWmtcXFyMK2O/M3a9vYz2aExRV+EgrtiMyyZ1ueqC
         ylrGICKYrapw5bL6xFV2nlg55P2RfSqTEUMOQ9qcO4TBaJtn4N3MtIjVRLB7W9wGCGT/
         Pfx5z2BAwxjKkagRIpsL4lBFs94ERySRObuWNg3CzoBLCS41+l2Kqse4EAQPHrrWk0eV
         +Hwg==
X-Forwarded-Encrypted: i=1; AJvYcCW1RasMSZZIiEjnMXSS0/G1zTp2NCAmgEYO44B9MdnnyA6dpepp/a/IsSuZPomYBzFlvk+GGL5pXqy4cYI+Fz2LyCz+fDSBAdjETNhL
X-Gm-Message-State: AOJu0YyyQE2GZ/A9yOAJy8KFFyRitfyt/Tg2TYO1fxX7ZaaUIo7gBEKY
	CEt2JvLUktav9JP1N8la2KO5je9knkx2DwEnRRY7Kb3sFTjCdz1H5wdDG2QUCxfFl/UQbBm93fI
	=
X-Google-Smtp-Source: AGHT+IHOt/XxKr38Z8zmjgu9ESS7Sl6UcSpw18z70Elubc21XGFp3MxCeJpJT90s6fwG5nmVQEDGEQ==
X-Received: by 2002:aa7:86d4:0:b0:6e0:7249:3712 with SMTP id h20-20020aa786d4000000b006e072493712mr570641pfo.30.1707862264512;
        Tue, 13 Feb 2024 14:11:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWG0I05D43cXz6pmvatWee6vACRFos2fSr/9+WHG2nK1f/UYfNW+7eWWIw4eIfWq/vA+HGauyJqPsCZJ80hnxfLFBwBq3uPVnMRdaNPNZB1MyQfy+TXAnLoCuKwSQceiWCYmeaJfuLq15dkX9YXmUqiUQVGNvO5LlrMLHp6kW9Yra5xSBjoL77/d3M9mK06GQur19MMvy1ZDd7MpCRIrsezLNkT/TykNgyFRET2YkS1hB9oEdXd5AA1U+FH9YWgNWhAd8Hga1iJoC8MBs+if20iUnkMVCBxCOPryuc4ZQOs2De7hpJ+grI8PkLNekrn+0FQ3q/sanwR2g==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id du25-20020a056a002b5900b006e09ec7bdb6sm7557609pfb.193.2024.02.13.14.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:11:01 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] overflow: Adjust check_*_overflow() kern-doc to reflect results
Date: Tue, 13 Feb 2024 14:10:57 -0800
Message-Id: <20240213221100.3556356-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220844.it.345-kees@kernel.org>
References: <20240213220844.it.345-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2680; i=keescook@chromium.org;
 h=from:subject; bh=ixNr6X1gB7VeIiW3pk9Za3U1z37zW3zrQNIbl69tCT0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBly+jz2+8A/TrJjsBiIAx2op9/6wn1k5bn1wnZL
 w9hYjTQS5WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcvo8wAKCRCJcvTf3G3A
 Jj3IEACgnAjrCNHfc2TogKvuIOOkNxLx2HcMUaBKVj882SXJHeFdXmSoQGn15EuraVDEmvypDWy
 vrMsFC7cLVtlv9pea0o/Inq44EYlbjVtjqgO+Ze2uYUrsz23WFrrdje1i4cQO6asAow+aGx5NeA
 SPO1aH9lBKCcUwEtrr/qLSYPFuRRs7fbV+uJhF0P6tgf8/Ar2R+yp8Qb/BoXGga8XDix93f8mU5
 BlI47n7ViCdP8wjHAoSKI4dmf2z9WjfReQ/nR2Ls7UQt+B+UCzPc/ChfllIT3iEARSwQg9fyTQy
 urEXQCKa3nvT0FM3Yx2nmum5GgjMpQG9lbXGycGlVAmH8RU4KIj1UAuP3JEYoEwk47HzyoOWyxL
 CfoOG+9nrhjRukZfvZ+K3G4z8t01HcTrFj5L6Q1pdjlCMiN3X7tKU59+l19J8s12ByuXadrEgi2
 eYZP6bgvE7h8wFi/9IOCdiZ45Biji+UalfjNyipfHyaAfaqeabilwYjJWBSDHommvtG0XSOVMoa
 YSVqRRDZz26U6Q4qdL5uMEffUzkyjojKwgN/C/tBGMmo9bnQUazKZCxRfJdbCWtTuJFNel8rPEp
 S5FZcScFTA71DFlOTfU22qn+e2S1BXtEQ/whA12aoZ8NdjA170gMzcDiEO7Kcvja2a4bi1/vwH8 QM1atjqVmuvRSHQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The check_*_overflow() helpers will return results with potentially
wrapped-around values. These values have always been checked by the
selftests, so avoid the confusing language in the kern-doc. The idea of
"safe for use" was relative to the expectation of whether or not the
caller wants a wrapped value -- the calculation itself will always follow
arithmetic wrapping rules.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 7b5cf4a5cd19..4e741ebb8005 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -57,11 +57,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: second addend
  * @d: pointer to store sum
  *
- * Returns 0 on success.
+ * Returns 0 on success, 1 on wrap-around.
  *
- * *@d holds the results of the attempted addition, but is not considered
- * "safe for use" on a non-zero return value, which indicates that the
- * sum has overflowed or been truncated.
+ * *@d holds the results of the attempted addition, which may wrap-around.
  */
 #define check_add_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_add_overflow(a, b, d))
@@ -72,11 +70,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: subtrahend; value to subtract from @a
  * @d: pointer to store difference
  *
- * Returns 0 on success.
+ * Returns 0 on success, 1 on wrap-around.
  *
- * *@d holds the results of the attempted subtraction, but is not considered
- * "safe for use" on a non-zero return value, which indicates that the
- * difference has underflowed or been truncated.
+ * *@d holds the results of the attempted subtraction, which may wrap-around.
  */
 #define check_sub_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_sub_overflow(a, b, d))
@@ -87,11 +83,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: second factor
  * @d: pointer to store product
  *
- * Returns 0 on success.
+ * Returns 0 on success, 1 on wrap-around.
  *
- * *@d holds the results of the attempted multiplication, but is not
- * considered "safe for use" on a non-zero return value, which indicates
- * that the product has overflowed or been truncated.
+ * *@d holds the results of the attempted multiplication, which may wrap-around.
  */
 #define check_mul_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_mul_overflow(a, b, d))
-- 
2.34.1


