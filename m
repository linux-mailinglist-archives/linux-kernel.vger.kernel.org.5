Return-Path: <linux-kernel+bounces-43318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9786841214
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17801B242C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3741C76027;
	Mon, 29 Jan 2024 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N/+623SB"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0231755
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553257; cv=none; b=JO6zSt27ubf/Zvaq3ZGhncpF50Cvw3ayh8TRz0ll6u3YSRNQQf3eiWqqNn7NO9KJpCe1bOWGCU/015NE5zLj3v2pBT0cQfcZbIg6JOFwU8ik2Yns+oa5DdKCaWoxFaK7mzgMEDW+4R523/IelxweYEKnqRag0L66g3h+IAK+3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553257; c=relaxed/simple;
	bh=sykIKnnrM/Tq4GsiYgDxejFBimKJxMarhf8XS35G4kY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NicPm0L7MbM49/gG0YPQ/QAIYgMcU5mLN4Zowse2G5opcMwpKIx82Hc1tkZ2AS8KnUn4U9o0UWUi5/HJJwbxMCvFda3ZS9yUxGDZn96RIHdZLrz3N372Uyn0CaMbmnrACRaiySJVsY7dOYsNzU/yfIiypYOx27MaW1QMbZ80sIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N/+623SB; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e0f43074edso1634363a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706553254; x=1707158054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tQZMalWykTk3vgtbbEE7gYZKbUCrVNjRysAePpbg1wY=;
        b=N/+623SB7aluoP8pSVtnMQcYXPZ9EUOAxT1uLt5wTwP+BDJzBIb4pWZMm8kPOUxuCO
         4KxDO1JkR41FzeeUjQd3cDeHt2i+KyNaHpPW01fm5YYlGIRMLCW2aNOGcm+IzhHvD7TP
         kjOxyPZXq6nu63d6IRBmACDmIXbn+bkx/HjAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706553254; x=1707158054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQZMalWykTk3vgtbbEE7gYZKbUCrVNjRysAePpbg1wY=;
        b=qV4HNrkdsTtFnUFGuLYTMTsyLikpX3i5yhj7FlvAoiGPSu3sKrZ+yfNfzkZdijgNNh
         1MT30jZipYVo1uUGWTHGxTz4DnryutUqTdwjWxABNN7oDIkT004dUKpxU6HZlHjGXJKE
         7tqBiqY7kSQzZYjvDqDBm6ofPdRTsBsfnOba4MDse3uJiBPy1MSfJXxByojtOfTXTEFn
         gv9xgXODxCOkli5Zemc1mDqxZ1r7i0HacgFRivdYufjjK9qNFf4/mMtqR3ZkPrAFX4ts
         vKmyJsOZK/a+zqjJH2yhgwzRGqDqwY4X2TkqTwf9WDLq2TtJhNnhDQSIwLlHyoy3CPda
         cjsA==
X-Gm-Message-State: AOJu0YwMpYg3F7apOsF9QUypfj8JPkNs/JF38m8o+bdxIOPqg4yMsQZO
	Mr1V17DGwniOViDrbqWvggMb2zWkufTcoHv/WguBPmyYFZ1jgF/sa9IPYatPjg==
X-Google-Smtp-Source: AGHT+IECBsbS7u7XFHZmnkWqyadB34otpS52vGei0xLV1m4FuHE8ysocX+XH291pfSc1gBPJjyrtDg==
X-Received: by 2002:a05:6830:4c2:b0:6e1:1501:58a5 with SMTP id s2-20020a05683004c200b006e1150158a5mr2470636otd.13.1706553253796;
        Mon, 29 Jan 2024 10:34:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b005cd86cd9055sm6444096pgk.1.2024.01.29.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:34:11 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 0/5] overflow: Introduce wrapping helpers
Date: Mon, 29 Jan 2024 10:34:04 -0800
Message-Id: <20240129182845.work.694-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=keescook@chromium.org;
 h=from:subject:message-id; bh=sykIKnnrM/Tq4GsiYgDxejFBimKJxMarhf8XS35G4kY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt++hEJVKpFdvCiAx8Q/mObx1CgrX0Lw0G78CF
 DG+RYHob8mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfvoQAKCRCJcvTf3G3A
 JubpD/4uRX6VWoyTmO/bqAhPykYcb0ySLPFMApmFO5Iaubx5mG2oUdJM668VghQpIv/0cjKMfSo
 RUxnR+dWYSUgf9EzEIhvSKIB65MD9SLIOfri4IUimE/NZg0sYPPCG/9gSGwrFh2GA1sPMCZ9U+i
 9yw/YXFoX0NIc13TV2nr5aDk20+AyGKA7kujacCfZUNsGD/eg8gXb8t+79xoeYJyL/itFh3DsCE
 v4wmBQCihgO/HmtxsfSgzhLGzEC/m/UqIzgcZnWcqEWyKsJefKsBC4YHayOr6zsiozCxmJkEKtq
 vtNagEbkVgUvp72KgRGjXaRuFPW1Bcx6B+XGXgUT9UpQXB7jz/gFlTsexIGI9I9ptNVDGOOK8K6
 5Y34FNYRVpUPpeG4WZ8IWFxwc0r07D5yp5tYmrpIWBmuEIBo6K2Uc1Pp36Zz2m8yGba8RjxXdCP
 9JZZIbqTUYUpQwxdykmFu/cjCLRtuH7RX+R6c7JBqumO7a44/wfuU4zx1JpGy8Hgy24WXCYn204
 WYkbECDYnf1VQhOINJuJPoR6qziknXMfdbew6RlPR6ZSNkBFk8ngRo29gcSd2Y7++1WiJ7zllT6
 REpmSDuaq54hmvH2OixfMppYMymkGJI9rEn8QKfSnNORdL1ja4V6wnGCTOwfRpKT7vRZJ/NCvM7
 ObdqLaG AqGQSPDg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

In preparation for gaining instrumentation for signed[1], unsigned[2], and
pointer[3] wrap-around, expand the overflow header to include wrap-around
helpers that can be used to annotate arithmetic where wrapped calculations
are expected (e.g. atomics).

After spending time getting the unsigned integer wrap-around sanitizer
running warning-free on a basic x86_64 boot[4], I think the *_wrap()
helpers first argument being the output type makes the most sense (as
suggested by Rasmus).

-Kees

Link: https://github.com/KSPP/linux/issues/26 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Link: https://github.com/KSPP/linux/issues/344 [3]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/overflow/enable-unsigned-sanitizer [4]

Kees Cook (5):
  overflow: Adjust check_*_overflow() kern-doc to reflect results
  overflow: Expand check_add_overflow() for pointer addition
  overflow: Introduce add_would_overflow()
  overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()
  overflow: Introduce inc_wrap() and dec_wrap()

 include/linux/compiler_types.h |  10 ++
 include/linux/overflow.h       | 164 ++++++++++++++++++++++++++++++---
 lib/overflow_kunit.c           |  77 ++++++++++++++--
 3 files changed, 228 insertions(+), 23 deletions(-)

-- 
2.34.1


