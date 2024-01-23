Return-Path: <linux-kernel+bounces-34520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05437837DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251361C25AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A391161580;
	Tue, 23 Jan 2024 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LArPicDy"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7315FB2D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970179; cv=none; b=KNn1KWLQFvjLWNr7OEMuZGkum5kVQGEwyvfC3q2NUjqI5tI1cOplGnMW+vvLC79oaqvAVheP3ROpXHLNVLysGh4i06aPbwBfyUv7QLwRCiy53xV85EVpFcrAh3Y1n4QAjdyJxZwLO6ECuWBWxj4G0yCQKHt6fEt9HG8gNxZqaDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970179; c=relaxed/simple;
	bh=u012BkgUEdp0Yfa+JP9ayO0CuZmd0xQIxgTb0lW/0m0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifj68nXXjWlHFxPXjCuoIbtNLPoN4nzZweE3cHq9Z2CePJfmzqftxBf6tZXV2d7Fr4S8vht5ZJqwPWpur9iOwTHDqHcqh3Vy74DCOBrngedicnOQtgquY67B0Im+JRb3bGNeJcOsqLlV6RcmPE1OXwuMv6fF3Cq28rZjJCOGHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LArPicDy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6dbd65d3db6so1285455b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970177; x=1706574977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJHm0DC5rLzBB/eoWG0LMkWC0jMm/6XONFH952XC3EE=;
        b=LArPicDyQhwwdWiK/B97sN/mCpmSi+kj7GgoQmLbwy+tvV3gCVURsxmdVU/80RnjRb
         qoXG17CDmFrIPIbD7Czh6RhlN2ZUrNCfwwG9nA6detde4UND/PLOwvD46sw8ruw82XY8
         bUybefWqTKq52Yz2tScwSKBf5C6FHFh14C5kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970177; x=1706574977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJHm0DC5rLzBB/eoWG0LMkWC0jMm/6XONFH952XC3EE=;
        b=IPmAOisSKl4OvdXGfEKYbBGtxC1l4RDSvCDG0y3ftywEQhTHddCwPnGpXPbPoWciw2
         oLukwfHHqTGO7VbeA1XYiqdlGYhy6y3XTyxK29ft62dTATq7gR/+Ae0if2pGacgs6AhU
         kMXykvqY/HhdyDvuodKMfKEL3Jqkg12efoT0DwtE694qsrmKI16UhRNVH5hWtXJLLwq5
         jouA5s6Ui8HgacFzco9K9RO4VmXKS7ncNt/+Lo3KM6fzteT4Anhmw7NBGqfLLG8fDbZ6
         OxxFroCQ5bi1vovAzMvlrjsLqWDehnD9nPhk2+4N1EWj/eH3tm+7dT8dlpWxxUrEGuNL
         WSDw==
X-Gm-Message-State: AOJu0YyNRiVYZ+qZ1+XbpKgvXcZRojTSGY2Qv643O7XIUBIz71CWVI4Z
	G2qSHRHDkCEnsj+ewYNPi+cGOpxmAe0rKfhQf1qW6+CyfvE5jaUF7E3Tg0TzdQ==
X-Google-Smtp-Source: AGHT+IF2jDWV0WLFADq1O4kywaaalWkhYddlxpOSZoqASjCeALQZwDVPUM/x899kva9FC18kpSJEpw==
X-Received: by 2002:a05:6a00:1942:b0:6db:cd50:a579 with SMTP id s2-20020a056a00194200b006dbcd50a579mr2606158pfk.5.1705970177108;
        Mon, 22 Jan 2024 16:36:17 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c32-20020a631c20000000b005c259cef481sm8967545pgc.59.2024.01.22.16.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:09 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 47/82] dm verity: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:22 -0800
Message-Id: <20240123002814.1396804-47-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3422; i=keescook@chromium.org;
 h=from:subject; bh=u012BkgUEdp0Yfa+JP9ayO0CuZmd0xQIxgTb0lW/0m0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgIOH/C9Swkckzh3c++V1FoaT4oWWLnIKzVK
 4ltn8zkF5aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 JmvnD/0b+Rlt+XJZK9q9byfYiA6awzBQkEEBdvuff5J9TBXpg3VgQqKvmwtxq0KAQ9l//zFEftq
 hIPzxFKu1d1NMiA9nNDx+HJTCSyH1/m6o1ipRM1kFQXmsc8kAnaTredMX/k7i+O/yDU5zs8Yrwm
 N7WW1ES8SIb5ANGi0jjOb0JGh9skCpUIOrxFbdYxWZIXFcGqFCzk57dT+ht74zNglySj8BttvgK
 XmZOnsrrgWyLqk7ssmfOEI92EsPIW21myf06U7/lm4hWRpna+zKlcZKj75+u+0rlIzY28aKGYKW
 YWJbXs/QCIFQFggWFD9fYNWKihQV1A3L/SSiMr7A1rQkQN3CevDh915CdIBiZT1/qjWkPVZGNca
 aFG8RuC9Z1b5/yyqFbSyqCHoheLU787NI9N+GEWF7LAdDjrRgus7+LULlmWpthe4XQY6o8tM2yQ
 HnoYeb2w162/qgvyXNQtgW/EEfb5nFybzcjE86jAPwk7aIghD2qVVkrYEzfJTxxIXTAT5qZ8e64
 /iVq6X5Ha8bMhMmO7r0gtwUMnTUbhz0zf19cYNJhkS/DY9vZphO38oEdVHuNLb/3vr7uLXNPJPj
 GF3+/usmLgU4WSakssSLDGLybbl0j6oIUPgLtkWAuGxWgp6aTN6i1i6GIOnaySjbgvmOtm4wisg TnZZ4zy5rEgGyMA==
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

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: dm-devel@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-switch.c        | 2 +-
 drivers/md/dm-verity-target.c | 2 +-
 drivers/md/dm-writecache.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-switch.c b/drivers/md/dm-switch.c
index dfd9fb52a6f3..9053d7e65603 100644
--- a/drivers/md/dm-switch.c
+++ b/drivers/md/dm-switch.c
@@ -410,7 +410,7 @@ static int process_set_region_mappings(struct switch_ctx *sctx,
 				       cycle_length - 1, region_index);
 				return -EINVAL;
 			}
-			if (unlikely(region_index + num_write < region_index) ||
+			if (unlikely(add_would_overflow(region_index, num_write)) ||
 			    unlikely(region_index + num_write >= sctx->nr_regions)) {
 				DMWARN("invalid set_region_mappings region number: %lu + %lu >= %lu",
 				       region_index, num_write, sctx->nr_regions);
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 14e58ae70521..f2676c8c83c0 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1392,7 +1392,7 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		v->hash_level_block[i] = hash_position;
 		s = (v->data_blocks + ((sector_t)1 << ((i + 1) * v->hash_per_block_bits)) - 1)
 					>> ((i + 1) * v->hash_per_block_bits);
-		if (hash_position + s < hash_position) {
+		if (add_would_overflow(hash_position, s)) {
 			ti->error = "Hash device offset overflow";
 			r = -E2BIG;
 			goto bad;
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 074cb785eafc..45e54edd24aa 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -2631,7 +2631,7 @@ static int writecache_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	offset = (offset + wc->block_size - 1) & ~(size_t)(wc->block_size - 1);
 	data_size = wc->n_blocks * (size_t)wc->block_size;
 	if (!offset || (data_size / wc->block_size != wc->n_blocks) ||
-	    (offset + data_size < offset))
+	    (add_would_overflow(offset, data_size)))
 		goto overflow;
 	if (offset + data_size > wc->memory_map_size) {
 		ti->error = "Memory area is too small";
-- 
2.34.1


