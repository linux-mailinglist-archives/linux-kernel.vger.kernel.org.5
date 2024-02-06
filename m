Return-Path: <linux-kernel+bounces-54692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299E84B287
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A03D283087
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0595A1EB24;
	Tue,  6 Feb 2024 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e7Fe3LiJ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782C33EE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215525; cv=none; b=UE49bkU6sxEYD/wfwafTYIGuiPZ5oz2rhpVOrzfvGQFKP1wt7fDdkpBQqif0jO1p2PK0ssgidHhFUAjw4MzbljHgJt9c+oCg9EHT73TfsxO5pHA0/0NSfzdb49+4Wa+LcdvWmwP+GkYKlLklhsUNjRGODw0YMkkh0EMl2mf2ALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215525; c=relaxed/simple;
	bh=6Jgp3vxxK3Vk/XDvje4qMUZMER6LkaJQhb8c5Sf9IQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ciuA66VJJuw2HIhcIdlWdUiOKtUHY/3mfNYNdHO0j93l5cV823IW4QHd0iEqMN6NMiz+SBbxI1d7v1s6wq9KyZVwDLyO77xEoKHw46opZd46yVWCQuOi8JTDiOXpTYqexTsnfjCD21ZRG3k0HI7Xqr3QxTHNukeA2gOQlSNovEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e7Fe3LiJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so5229245a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707215523; x=1707820323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QphZTJ2YkJ63c2lk2h3jm8PAaMKsJdXhMlN0zVjn/Jc=;
        b=e7Fe3LiJ+u+HN07QeS+PBl4pdMYJdzrp9SYc5hKp5068XOjOCROeyucoUivJAv/2jg
         YeaMQ1U+SSzXcWgWs/rL0tMoz3HI6Gs6AQYSgVHS+W0msQlUpELBY+h+Ca8Hr4oUi1LR
         9Fo1NwN1+ho/G7+aKRtqUTPeA0f7bfaRfywOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707215523; x=1707820323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QphZTJ2YkJ63c2lk2h3jm8PAaMKsJdXhMlN0zVjn/Jc=;
        b=aMZos4Pva5dBSwz6dhMtsMEZw1wKBxdZ2YwTxpMCHvSbbMi9KUNZCAcHTT6QLzh34e
         qD0JN+sddyKnQyIgiSqEcjepM+aH6S+ONgXfS3SmMnkhi8J0GEE6ZZQA6W6tBzqP/jYz
         tLc9xv4dnX4KSAo3qVdBteBQkAncb9ssjVL8whZBMzlhcmIpmDZ2fFE7Hzt1vX0oQYdv
         egA2Vv+vKOgTCDhd/o+qH76tGaxvPQVCqcMdiPGIn2gjReDsRQFwtLJD9YhzezEleKA5
         mH2sjy0rGYPP+cNNmxR/65shS9SeJ5noO6gX6+4mn6YfJqh+wJbAq00LgVRTwCIJGEnb
         nuhA==
X-Gm-Message-State: AOJu0Yx7SP82VTRFVfDQElIoHBKWSWPzGGSYagl689Zyle+SmluDSPfy
	ADU2EGbbZRM2NdzRRt3GQCFYfdUy/6Bg8In/R6oj2fVlUy8PURsOPuD1r9ik5Q==
X-Google-Smtp-Source: AGHT+IGnNcxzPIbgqnBw46Vcy6cSy+rHKyDhyh+6nEHAskrzfXSk8Pba+caqTs8eFtX82lVoc0UkSQ==
X-Received: by 2002:a05:6a20:4294:b0:19c:8bc7:c82d with SMTP id o20-20020a056a20429400b0019c8bc7c82dmr1281941pzj.40.1707215522983;
        Tue, 06 Feb 2024 02:32:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVZ08SRVjb0/BRWQtEe0sMgtIsd0pJXgjb1JJOKV/fs8H8l2wXG5WzYVMiQNiW4XOV7ukVKqVdSrnlZSST5gwYsI9tthgnKdzhrOzNjIpQd8GntKZ7g6fKl3GDmAJ1N34U3n05S+DTKk25mEMfnt7Hc1Ll+vBqX0Oqj+WFDlVeb/F1EA97PJU4N9nKU9387uMQPpwefA66sVj7Ah3S2U6/OQLJVUVUlsXhz/I6RtG5+zG+YQAYX6vpv1TsVW8h8DbEMLfsj8+qD9V1ZSsAfT4Z/tBwF+ASbfLaJT4k8
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y28-20020aa793dc000000b006e033804fa8sm1497952pff.101.2024.02.06.02.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:32:01 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] overflow: Adjust check_*_overflow() kern-doc to reflect results
Date: Tue,  6 Feb 2024 02:31:54 -0800
Message-Id: <20240206103201.2013060-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206102354.make.081-kees@kernel.org>
References: <20240206102354.make.081-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2673; i=keescook@chromium.org;
 h=from:subject; bh=6Jgp3vxxK3Vk/XDvje4qMUZMER6LkaJQhb8c5Sf9IQw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwgqcMG0B/D0l8I3Zre9ccIWewGWghw7fRDA6+
 Ex6geHfWP6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcIKnAAKCRCJcvTf3G3A
 Joz+D/0cfyydT7lF4BjFsEbIOJCxDYkkLmOjtUQN7/LCKYtVZm+DLMpe3xQlqQ5642hnqrHlwvW
 vbBhB4FtiAAmcgYL1tSSVzwAKiYZHRjg9/TGsZzYfHuCx7IZmw+bjwONCr0xGQQ7ECB1/9owrH2
 DBesL91WSyxI+bxbU6d1oPB+8xsJ1QG1FPLRJAqAlmD0reEby+mINShrJTMfzvwG7KGUWK9MaCE
 5idH7bzvD3u23dl6N5X/Gk83T3JNAcQbSZN/PCmcASTFABWLJeMRzhbnoZrqdEyAnU/GVRrmkH+
 7UQHA75exvR8iRTk699l61Kfvl+iT6ieWXV3zgw7mluq5BzKRlav6YRy9hECMP3DAiD40WkFnsV
 1wZB2B2doRYnAN99/20Woo0U+F0qG7L2xEvNXdkk/luDZSF19iGV4C1PvzmXlWakqmTD21WgEBn
 QBZIINqi7eDUime2W+T7JDAmNlIPRjD+8GrVsGZ0KOJ5oG5SZfwk98JGI08tWyrF2LD62r0Uzh4
 kVUzw5clpopb7ORRQ90x5ldF8N8UE2bnVBJF5pFUQOcx1wzds1rm6bR/WWIgKCFK/hZRgBrH7PZ
 /+FNbKQba2rqh+XHg+My84GC3PYtbU/1raU3g9lx1d2zDVe5EzthoHelVjcU8GhAPTtWTmRQ6yF VUBItL7K5+oHnbQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The check_*_overflow() helpers will return results with potentially
wrapped-around values. These values have always been checked by the
selftests, so avoid the confusing language in the kern-doc. The idea of
"safe for use" was relative to the expectation of whether or not the
caller wants a wrapped value -- the calculation itself will always follow
arithmetic wrapping rules.

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
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


