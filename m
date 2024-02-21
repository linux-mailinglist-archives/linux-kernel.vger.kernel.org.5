Return-Path: <linux-kernel+bounces-74066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3620F85CF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BA1B22AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FC339FEB;
	Wed, 21 Feb 2024 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DIWu+iB3"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23E3A8C5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708492603; cv=none; b=sbqbaXrmHEpxtP491c+bWDDdWairQbzrngNp/I9IKpFmUb+egR160HGML1YW0lQMKs63KadJsuoM4yM+/MfSfuKVmobui2B3GlZYnXKqWQBohiA1DJEH7whUbaqZJJ7m+eDcoaCb7N69zQh4tB6zEcRrD0sXSH3TPeI8EZW0NFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708492603; c=relaxed/simple;
	bh=cY2KqIQK1pcG7S9aS/1nKIllmRZnaU4rHJB4e+mP73E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RrnBLGMA9811vch0AZRf/Ct/gekLpws/L7AzAkmZEiz/4g/Mkp510/7NA9He0jake+bHcVMMkVwwmQiLWTQouqcEeUQ/41jU7SDmZ0WeN17XxeunFHJjCnD+BPnXDxojw0zo4k6CwKGWWKaCQrEs+66f+RBYOA9m9iTeChDEf48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DIWu+iB3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29954bb87b4so124036a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708492601; x=1709097401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mCX15b4uTdTDs85v9N/M2uNmy7WTmpFalSMszsfCM1Y=;
        b=DIWu+iB3CM+PzhJHuWGzGTuqKlqYiNQfcvLJ/PX4RDaStF1syeqm9USB64pTxtWrfw
         tMYWa7OPzOgwO731w/znoT7+gKujH7rNgpEFK/IFTTVHisQkJLeholXXWgKz72Y21N8X
         OGwqeZtw8JewE/1dnQIrhqO/JTDlUGBrgsw38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708492601; x=1709097401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCX15b4uTdTDs85v9N/M2uNmy7WTmpFalSMszsfCM1Y=;
        b=wQbd77zSZQmRrUKArK7b3qS8D6AH1EGwfK2Be866F4cI49f7fXATeA/gPqXBvIDetA
         032a2YPvCjBeMURlyF3txuK/Dd0yNL+Lsu1GkaEbdfrSvBOKWYRisLi24wMHAMZd9LSR
         KzqPPcq7d/qNBUQspss0j0ZUIS/AjSEgDM+5BX00yKLBEwQNTkkvO9r2+TKMXeWt7cxL
         bkWiuQH5StIrK8KIsYislY0ora/aoj7Kela8CmuwZu22DxUWKfYLQpYoC0+MTbrFOIpC
         7qT04ENt0SjyolW+dQucqdHpIhVxQCWwtCGy4nhKPfWMSRYhW7JrMLOGi0BxH8zdQZL3
         pPEg==
X-Forwarded-Encrypted: i=1; AJvYcCVMaAtg9gUmunjFV63EiGOiAhnnnT1Zid2lXnJMzuKioAzwoCN6Aapjc/DjCHMn1bIYrw8SgBa3C2ci0fJ/h13AiJS2T0Hh5n3SAgPG
X-Gm-Message-State: AOJu0Yy9x7CoNbA/eK5XMqEhg6HycCAc96ZBsxbtk1rhai0i216atjD8
	WD2LH/3HJwoePYtmIyZaqEDVg0KEhVPk6+UyamPx3lFr6lp62AqMy2bxaoeKMg==
X-Google-Smtp-Source: AGHT+IH6vlBc4p680bubCDZNA0oNP0RifAfPX6oWVT4hfOMxVEtRMhKGR1BWhGFV7xIsCkGgOuR3oQ==
X-Received: by 2002:a17:90b:1094:b0:299:1c53:113f with SMTP id gj20-20020a17090b109400b002991c53113fmr15169117pjb.0.1708492600737;
        Tue, 20 Feb 2024 21:16:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w9-20020a17090aea0900b002997cf20314sm656146pjy.28.2024.02.20.21.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 21:16:40 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] refcount: Annotated intentional signed integer wrap-around
Date: Tue, 20 Feb 2024 21:16:38 -0800
Message-Id: <20240221051634.work.287-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035; i=keescook@chromium.org;
 h=from:subject:message-id; bh=cY2KqIQK1pcG7S9aS/1nKIllmRZnaU4rHJB4e+mP73E=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl1Yc2qj2v95a8MncuEjOaS6rwqcyJ0914acvqi
 04tQHzd1KGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdWHNgAKCRCJcvTf3G3A
 JohaD/9NCQi7lx5d6xm0eljAyda1wjpSCLIW9ZrSFIcwGwuSrjOwJdCQBMVDt6CoGY3thuTRjNq
 y2IZey2D3DGPvnD7qvmd6HZ376YLAaslABETK5wtg8Qa0cVlmFNggME4eE8nM5lsKpOZa8cPKjq
 5J8jbjXoiry5uQWQAwdLJT4yKeGN1avAV6l2YcivLs6hlQwZxDOBVKFwW8cNaSCsVO9P4fnUWwJ
 756mKPpceBnLMjD/yNr6BZT1in/bbAbvV811UxhlctNROrVG41LkyiAZu2AH688nhDu9LrGl5fe
 z3mfF3PDrjOnoTATm70EAvMfMYQhCLfVl/Lbtihm8yYftYZa6f0pGaHVi+qei4mRDR30ScEMqYd
 nAiwJc1Cpl0u2s4NMV9ZMbZU+qxfd3xiKpKsLaOna45NSA1tholfS7n8iqaai60GByG+y1UwDX6
 MGww115zQ2qAYwJZufEu3jpaUAlmraW52SQH+ZAOBy2nhAXAvHqz1+hTADGXu4BAIn9zPHvqUoj
 r13N6N3TFg6dmnKnM4a1njm+SjsLMeEbA1AeH0zd2Xq8Ilsx0cyVwwngrcVu7M+k37w1N1GU/2p
 gMkBPyJb8BAzuEgE1Mc/PPEorXmxLZsxMhhYYcXvV3XrhdaPpTWdsQdXzqETHvNz5ziav6HujsG
 DutSAQG AbCs3NlA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Mark the various refcount_t functions with __signed_wrap, as we depend
on the wrapping behavior to detect the overflow and perform saturation.
Silences warnings seen with the LKDTM REFCOUNT_* tests:

  UBSAN: signed-integer-overflow in ../include/linux/refcount.h:189:11
  2147483647 + 1 cannot be represented in type 'int'

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/refcount.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 85c6df0d1bef..59b3b752394d 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -136,7 +136,8 @@ static inline unsigned int refcount_read(const refcount_t *r)
 	return atomic_read(&r->refs);
 }
 
-static inline __must_check bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
+static inline __must_check __signed_wrap
+bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
 {
 	int old = refcount_read(r);
 
@@ -177,7 +178,8 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
 	return __refcount_add_not_zero(i, r, NULL);
 }
 
-static inline void __refcount_add(int i, refcount_t *r, int *oldp)
+static inline __signed_wrap
+void __refcount_add(int i, refcount_t *r, int *oldp)
 {
 	int old = atomic_fetch_add_relaxed(i, &r->refs);
 
@@ -256,7 +258,8 @@ static inline void refcount_inc(refcount_t *r)
 	__refcount_inc(r, NULL);
 }
 
-static inline __must_check bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
+static inline __must_check __signed_wrap
+bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
 {
 	int old = atomic_fetch_sub_release(i, &r->refs);
 
-- 
2.34.1


