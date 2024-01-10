Return-Path: <linux-kernel+bounces-21667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5E7829295
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6E41F26CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB70F63A0;
	Wed, 10 Jan 2024 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n331NUM2"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103345CB8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9b050e88cso1829910b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 18:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704855523; x=1705460323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3neAR9V7SIBmjNce2CVYMk0Vegme33FSuElWc3JPGc=;
        b=n331NUM27r8xZwfRoR3DrIFoYN5BqAYr67wCFVw3+SGhWyTGaD0bIBEg0Q7T2PfRkG
         ainR1c1sh/DAjrenGge/5WsnWxNZ9WzFuS/CSz6Vllg7IVV0WYtv9lshrehs2H5GJZ29
         OJLFxbd1UBLYLv5Hu/1mJc1YJC+5lmy8sDdNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704855523; x=1705460323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3neAR9V7SIBmjNce2CVYMk0Vegme33FSuElWc3JPGc=;
        b=D6eKVW3YxchKZ4GTg46bn0wLflXrBxhsNW2y79XfLhgWSObrG0oCAnzY0IkRS5KOUF
         zCqW+EXAdCM70y6D7fe7Zur0iUB6Yb+2vgdB3zSF1dY7hV0rlQB6idQm2I+SPQGN0Prs
         Y14YWxfQsyfOatrO8Vzo/5J3mQSF0YIRdMRovuQ1m8cZX6pKI7h04Y5dX8fel8zqBa+X
         593RuqkQzn5MdDjjG00jD5X7jl3PT3FyDIZ5H70saoxFzjY2nqW1Hss41o7hbyS22G+r
         muvEQB9TtcyM3UDH9sdFwjrY6enPKthkdbTSEpZCyisjwizjjMYCqB8qElI+FSGIkGED
         0i5A==
X-Gm-Message-State: AOJu0YxAY2UxIwuYU0Pbo0w6/0GGjegz0vz9EjiUg5LpGaOaKrcpgIfz
	BOrwBC384MRT3O+9dVvFDdJBeFTbyDXM
X-Google-Smtp-Source: AGHT+IH8bbDJ5xLW2acZCKAyYc5JWcPVJDrlF6nPr34oNRP6dXZS4eXiLrf4slgEBNuPk4K9NyDWCQ==
X-Received: by 2002:a05:6a00:3014:b0:6d9:9f8d:ad2f with SMTP id ay20-20020a056a00301400b006d99f8dad2fmr433902pfb.41.1704855523372;
        Tue, 09 Jan 2024 18:58:43 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:b1d0:e755:54c2:4518])
        by smtp.gmail.com with ESMTPSA id t185-20020a6281c2000000b006d97f80c4absm2467521pfd.41.2024.01.09.18.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 18:58:43 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 2/2] Compiler Attributes: counted_by: fixup clang URL
Date: Wed, 10 Jan 2024 11:58:18 +0900
Message-ID: <b7babeb9c5b14af9189f0d6225673e6e9a8f4ad3.1704855496.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <e1c27b64ae7abe2ebe647be11b71cf1bca84f677.1704855495.git.senozhatsky@chromium.org>
References: <e1c27b64ae7abe2ebe647be11b71cf1bca84f677.1704855495.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The URL in question 404 now, fix it up (and switch to github).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/compiler_attributes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 215882a1341a..289810685fc5 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -99,7 +99,7 @@
  * Optional: only supported since clang >= 18
  *
  *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
- * clang: https://reviews.llvm.org/D148381
+ * clang: https://github.com/llvm/llvm-project/pull/76348
  */
 #if __has_attribute(__counted_by__)
 # define __counted_by(member)		__attribute__((__counted_by__(member)))
-- 
2.43.0.472.g3155946c3a-goog


