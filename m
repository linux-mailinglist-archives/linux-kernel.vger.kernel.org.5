Return-Path: <linux-kernel+bounces-43315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B929841212
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE1628B7EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD94E1BA;
	Mon, 29 Jan 2024 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NPsXFw2f"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BFB4C631
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553255; cv=none; b=hDiYND2ULGdSKOZIAawKVuWlGu5okkJAEFtp7hE80yYumrZzI1s7zM8gbm/VzMOdk/w1Gz8wp6qdRPulkkrGO37HZsZWflnU042LEn4fwYALkdUwe1vlBNgs7gwiEK4DnA4N22XhuZwEaS2JyYBEvBL3tNsAnM1fmwkcFiHxPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553255; c=relaxed/simple;
	bh=bPuN//AdVknGbgllRjlIvn/Clq0xqhyiE00zUL59Fq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eKsEwXpWj3cmj8KnHDlLaMMWwVp/QDFELq59mzjc6K6C42R4oIbQUNOC4H23GuJQC3WPQ+SdnHuh0oP9hHg4M7YKkQaD2awQYM+1zVCx864vWKzmeF63UhXVGisJpRz1xO3iGYHCQlnPZY8pNn11mALvQn7TzcHSq+Zz+wdIkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NPsXFw2f; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2901f9ea918so1371203a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706553252; x=1707158052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOC5Nw8kgCRPY/TogcFWVqqwyFHXk9SdP+vcbO78i74=;
        b=NPsXFw2fPXTOshQRm1YEGETUwVYV2QlfccKBMZ/aAqpKciuwc7B3ERQ4UQKZVfZ2P5
         LYZLbAl2Naj5qM8CGR95y5O3QR3d3FYTT7PcfLrQmcdOP4MVp9dSLw79iIXz10L8SbDB
         i2lPivOuGLLMWUrWQJCjJC5b4wK1ueT+WILT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706553252; x=1707158052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOC5Nw8kgCRPY/TogcFWVqqwyFHXk9SdP+vcbO78i74=;
        b=RvmSVjCa7mKmgNeCoRLkt7ArRaDp1fR15RV+6hBp5W3hzc8bcJu+LwDelAbw3c8Y3q
         jefKiWFA0waFBfEHkyqmhJb2s/h72Omg3Iu53GnS8wbZtzyNwcfmgO96u1ryunk79NlY
         9FdRZMF/8I0dXtL/Pe/sPPfWggBErRDJKCY8Jp1Z8TJgVPnY8+CLTMVt12Mn+MYLhWvP
         2FyDImKfrI4zL1Ve1ePSebiQ02fGZmPwR1fcMvQ7tZHmVbqSLzZysBJLt+GX24YaggWg
         8t5IDEP5j+moq0uaUP42x4UNdSpwK/LTUikmystkdUZJWzG1myMkflWbGDwZQKtD+eic
         +uPw==
X-Gm-Message-State: AOJu0YxhTHMAoQ4EQbizPAknV+zRmiNefK5/jEzsbQpkrGv7x/VpHTV9
	EVbcu0HCm+YdClXFTWeeU+k9YJ+fhbpmjc97pdXOSHPl6qSkFpKI7pQfJ5jIAA==
X-Google-Smtp-Source: AGHT+IGpulB1h95wCZNgeE0YqSN75HDcPqLFOCVFNmMHOObgO00KDlFvIqI9rq48V9BQ+gfN6S5NSg==
X-Received: by 2002:a17:90b:3cd:b0:294:f682:b349 with SMTP id go13-20020a17090b03cd00b00294f682b349mr2609635pjb.1.1706553252119;
        Mon, 29 Jan 2024 10:34:12 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gj16-20020a17090b109000b0029072c64439sm8930803pjb.5.2024.01.29.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:34:11 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 3/5] overflow: Introduce add_would_overflow()
Date: Mon, 29 Jan 2024 10:34:07 -0800
Message-Id: <20240129183411.3791340-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129182845.work.694-kees@kernel.org>
References: <20240129182845.work.694-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=keescook@chromium.org;
 h=from:subject; bh=bPuN//AdVknGbgllRjlIvn/Clq0xqhyiE00zUL59Fq8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt++h2FKZ64lhvgMVubeJc2zcQ8AiATcuXgzT3
 N2+Ojy6lfmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfvoQAKCRCJcvTf3G3A
 JsB1EACiRI4ou3Zupww8pxGpDJGKw0Mzmo0sXE1H89oQSQhBTuWnITC0KCLQ0+7gJlrdiPNk/qs
 trLpEQhdhR4HM3mQzWWlinUrzp/Q9sWMbwGycyA6FYjVmj2rHqjUkxVTWwTZfUP11KhNFzZaDl8
 m7EFhbTKe2FXbxWXhIvqjEB3w8H5KIODSEdIZvogFq4zMfOOo95nQNqRKAPDlAWU/Mwp3yIm4WY
 Rr5MBfXvkqB0GhtP1yudXc1H5Zt+aoNTUxgkVc8H0Gsi1hZtgkqfY92HjqMiBDD4f4+cd+YOz7G
 ZFlytqR6CA7U+HqGI83MolTXQi5O7MLs6tcRlG+fngeL1XONXC9XBfaB6sivScBLMAcPtN4wE4u
 rvMHeNcgWDPBZJtAdB19kL2a6YjU5a+yXEuW2hMc3nkgODqT02HJxgPBYjGVwCVMzfbQs5LSrMn
 X/kFqaAODLc2TysaBWAipvjIEQbD+by3K1EXviNpmeH8j41LmdlDvRa/ps5E5IJxDs6fZUputvS
 QSu6YOoUvrS3pCl6N/TQ3N6kP+9zrENcBIl7O6kg0+uOjVCK6TerDtMy+rPBBIzfBKDhyEbDBiJ
 MAaR36vxCNu73DVFISrdoqkhNiU1IyLTm4OExzpjcyFm/ZcdQZGxvf6FWFPRsdpCLYmf8jisLW2 U74ZK2xMeH/Bbdw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For instances where only the overflow needs to be checked (and the sum
isn't used), provide the new helper add_would_overflow(), which is
a wrapper for check_add_overflow().

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
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


