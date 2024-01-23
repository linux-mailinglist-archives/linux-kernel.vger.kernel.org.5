Return-Path: <linux-kernel+bounces-34480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EDD837CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2512897B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B08C158D72;
	Tue, 23 Jan 2024 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eQHr8rK1"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD23157E9E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969739; cv=none; b=OVsyrpOqiaS9+lYNRGoXFMTPKYjLYVL5k3hkbQ21xgoug6b1Uuwfk0pTzJvQFEvGeEFSJ/C8XrUZJ+wn5MsCdzA0wmcBcwDhlBIxEpW9TYt5hzLcWPj7cAqD9zFbc7O03dDa8AHBqLtV1wYdOKA5CIPvnFWP7D+SWKKSpVuftuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969739; c=relaxed/simple;
	bh=TZe3odnvBVyfJhPUF1EWalH3cmWYwjoOXmYkt8y83LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6k4Bpsg7VXtGfIMDk0U/72Dj9gXfzZPO5MxfKGirOhNUA9GKRRbpg2W/6WKDUpTfkUlJ8zVKeSzGY30hdjJaTFZyvkcm9CbgT5Z87vztwHJ0uofwxhYvE0zHikqcMXE0oNwd24cSaqWCuouoDUiyuh9iseEfMttwJfGe0M2c3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eQHr8rK1; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-290483f8c7bso2818884a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969734; x=1706574534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4oSe2hXJ7pk/KBc8BZUNuxdPjm8v3u2X/zj6TSNySI=;
        b=eQHr8rK1pXHDUT50RVrwiy+mFABk4BVUlZ8EGtAUzckPC8XjwoN3Y/YvOngdCTBAho
         rdgcWm229QFuNWJ57i+i6dI7AVJLhEX/KS77ylf1sB+NuJd60QQuB2lgH9fHTIbPfluA
         sJIq2IBhTOtgVt67ULQxSpbGAzIFfekBCxzBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969734; x=1706574534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4oSe2hXJ7pk/KBc8BZUNuxdPjm8v3u2X/zj6TSNySI=;
        b=DQtjJTqMOLyqpVg/qG/+x7L3+Ud4mGHG7SZXiUlsBTx9syalc/K2DANWR+iIJdi2Rn
         7CJDjTCTz5LkmCdLiABgzHA/B5VoH2F71p5xb4tmX2yYs/2I9qYLarg/+lkjw2P1shsp
         wF6DvZjMGv9b70RQePr53yL0Nw8cnEij87gAK96nOP745h8dwQ0JPmA4vV7XYf5XYZEU
         2lRT9hLR6V0gsKMzLQXVKSoRSbvJYvI+72tUOjFIOaEZutaVZzjuMC1XxJJ0B3/JSvCQ
         XXK0cqyDDVMQzZKMCQcHJ33kbl9Q+hc9P57Zvw2CASdDYNLjmNRqnmbdqyZF4n3GqHID
         wwWg==
X-Gm-Message-State: AOJu0YxjqEcjvmvN9Aft91hWzVCKlJLZOL/H5HSt5NlLE22qAZm9FjFu
	dlqO7ZYnDkO4igsXYTPY+M7SBihnc3wXhaYc97nZc91j8dwwjeUnsf3bJkOtDg==
X-Google-Smtp-Source: AGHT+IHE5VXPJ/SZ+DavCtR+nc5HV020yIw7EPe5k+TCBXO0lsqqdgfChhmXqbcMCwKngkP/Y8KKVQ==
X-Received: by 2002:a17:90b:890:b0:28d:f5db:70b8 with SMTP id bj16-20020a17090b089000b0028df5db70b8mr2628693pjb.37.1705969733837;
        Mon, 22 Jan 2024 16:28:53 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id px7-20020a17090b270700b002905f7b522fsm6607168pjb.15.2024.01.22.16.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:49 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/82] ext4: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:26:53 -0800
Message-Id: <20240123002814.1396804-18-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2310; i=keescook@chromium.org;
 h=from:subject; bh=TZe3odnvBVyfJhPUF1EWalH3cmWYwjoOXmYkt8y83LM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgFt+QnG4/gVyM/p6dahmulSl2Pw5idqpssJ
 WhpHokSfNyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBQAKCRCJcvTf3G3A
 Jl0BD/9Pq5dTMm0CvjsiDWoQ1WYiyg9B+Wl+VgmLFVzKjTb9Vbh+kZ7941xqPmleNwKfc28+892
 k4xn+mthv04qX2uimn/Qxjevj5zYOceZihc2UW0aNLwGjkCTcYf14TAqaqQEzY7CcT24cglyiO5
 sAUegw6S1rR6HqbuscZpd/dXrpaO81EMLwSbRGZi3FqURQTL1lOYbAFnSbaeyjK1T+WvPo3Tvdi
 bPw2D9CRzN8q7pCQ6GsS0KY5B/yrr2zfrDGPaJreRhHTFuSdAZSEkysMuZkh+09ROe0Ss9ZBn8p
 hING4Os64RCt1A1dyf6aoekoS1gD7Bda/KFFuVORIFi+czT3KD7fxOgIP6bzVzJuvzyZr9Qvryg
 U4SmUZ6o20SC8pHtGRXWjFaGRzD6X6vE+C4oyTPPSfSfQWpv2QtBL03gFWxw2HtV0DZ1GGQuq/1
 DvxQN/zBq1TSF0FtacemCsLl0BgDUR/C17WpAzCJ9tGVne9mzmTk9BFdjDKogCgs3z5wmtoWu8j
 kv4pRr+lwm8I1atVSuTFQmEAM5OAJQNbwSe9X9Nsk+2qe1BbHtdiWdWdLpQNwgtq8xk26tFWEnu
 adPmFtAIUM4nZUezpakHIvAcpSJslW4W08o27WMIZYogw/W5ZfRKPfTZ8o+D1TiEUlqygb7gZOE swUqE8VtwkrZLTw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/ext4/extents.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 01299b55a567..aa30b2c75959 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1920,6 +1920,7 @@ static unsigned int ext4_ext_check_overlap(struct ext4_sb_info *sbi,
 					   struct ext4_extent *newext,
 					   struct ext4_ext_path *path)
 {
+	ext4_lblk_t sum;
 	ext4_lblk_t b1, b2;
 	unsigned int depth, len1;
 	unsigned int ret = 0;
@@ -1943,14 +1944,14 @@ static unsigned int ext4_ext_check_overlap(struct ext4_sb_info *sbi,
 	}
 
 	/* check for wrap through zero on extent logical start block*/
-	if (b1 + len1 < b1) {
+	if (check_add_overflow(b1, len1, &sum)) {
 		len1 = EXT_MAX_BLOCKS - b1;
 		newext->ee_len = cpu_to_le16(len1);
 		ret = 1;
 	}
 
 	/* check for overlap */
-	if (b1 + len1 > b2) {
+	if (sum > b2) {
 		newext->ee_len = cpu_to_le16(b2 - b1);
 		ret = 1;
 	}
-- 
2.34.1


