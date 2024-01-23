Return-Path: <linux-kernel+bounces-34486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69A837CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB01A28C291
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BFD15AAC1;
	Tue, 23 Jan 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fwYvh+of"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A932C15A4BD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969749; cv=none; b=XZs20F0KXYmSoDe58sxlUSWS7vsn3ipj5S2psqYaaCZMchjdwEaV0LlttsxGHXysJpKuAMf8gzGVKRzInKvDhY+cBOr9SCp4d81pUvh8lju8OTGpDA8HDiCfwIIzdZfIkldz2Las36PSCY34wDbsoa/dyG73oUuHGraFwWJKlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969749; c=relaxed/simple;
	bh=nfo7Pn+Yi1zHl6gAcNSHg7VhEroNaouSkiXnEe5ME0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IP8Rpu7z6hsUndpzPpT7SfrAlRXxosmVl3dpi2IFOxYUUQ2xrcZu3/Fk3+XE2Mij4FBEn8Wg7vQZjNwij991vHPocygVNX2R3v1gCR0CLY1XfeU+K0IdbhrsTI52+fhQJwdHpzC/Tb8+XqgDmi25nWULfttXMrmfAISsEbA3ZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fwYvh+of; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd884146e9so3101834b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969747; x=1706574547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqOzYThsddRc/TP1ywPfEse4mdjcUMW6abmNPQSgVtA=;
        b=fwYvh+ofGDhJHVAXDPoztSdcYdb/g5pTbPhWug/P5ohZEGmUPv6kMUjzqQUbm3e5GC
         6e+yxFc2cXyo/JVStGJUQ5UjOJZfMjc7kFV/1aW/WPSSAvbgu5iOoSw1llPsvHe9AaGf
         s/3rl6A6JqT13f1NSBu4SQ3qt21dGP/xinBtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969747; x=1706574547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqOzYThsddRc/TP1ywPfEse4mdjcUMW6abmNPQSgVtA=;
        b=w+9nn3t3RRhcXAdf40DhKB65XT+5Hzv2diAjfJR3sPF+0cnF9bzy6CE5AHgPoHYoER
         VSfOXZp6L0gNd5RMYk0fB7f9YJhpJDlr7vwkgoHgbMocX/uBFAWaMfq1NFVT2iNogv7Y
         2Gyaent9+y2nNdhwbWt03hzYKoMY6BMACeoJt3jiuOv5iJJsKK5Ib2afEtu5QoFlv2CL
         xuNCfrjs6Wyb0hXr6wjhr1TyplcwLsd7qR5ZR3fRTby0HNyJRqzp+m2Uz91BSNTl6+/x
         wJNjP45jNh4Hl9hy0dYfXKTEiR4NMYFV0cojjyYtqhmBxFUs6PMPknpthZNi0bnHCIAX
         3LBQ==
X-Gm-Message-State: AOJu0YxsFHftCd+TK6HIpjUX+ZURfwD4qeEQqJ4V008LlG3MT/8Ylrr7
	zQqjFMvuvRMNTDFwbt6BOB7nc27oxcvvhiTj6PyQOWHm2cwqzfIAaUoJ+KaloA==
X-Google-Smtp-Source: AGHT+IGWOLXCTwPI6j3GBh9rWczj1tm/GwWsrgoWZKK4I8jNyHd+KA4KE2ZFP1l8jjKQE1E/jOjvfA==
X-Received: by 2002:a05:6808:1916:b0:3bd:8201:f5de with SMTP id bf22-20020a056808191600b003bd8201f5demr5861585oib.33.1705969746846;
        Mon, 22 Jan 2024 16:29:06 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y18-20020aa79e12000000b006d9ac45206bsm10198867pfq.206.2024.01.22.16.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:00 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 53/82] fs: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:28 -0800
Message-Id: <20240123002814.1396804-53-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=keescook@chromium.org;
 h=from:subject; bh=nfo7Pn+Yi1zHl6gAcNSHg7VhEroNaouSkiXnEe5ME0I=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgJNnJ/s6Wgv/6AhsrzLX4ud+nwKsZVT6phE
 9TF2kTHZzqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICQAKCRCJcvTf3G3A
 JqgLD/9/8tepsjDo0cRyL40X6tIYA+MlThX9khW3Oe3bkhpOGQukol41PQ55NX8DKADGKtJeVXE
 zid5B46i5QDXe4vObMddWL03qTDHEu+NBMnj6IS1gcFy+ACV8M9LiMAjU+pEhRxIO7/NpMLI68u
 +AvCayzHQGjHq1qTfG2nYMi4TLZ9cRFbeZIun8kIm1YGDXWBctkqy3INiE/sR5MPcNpkAmIFxNz
 1dKrxf1i211L4BkQyoO/InMUKRrYVDF78PVzluyJTqSgLEc9D5qCcI+Vo0VaBO0R75DEIiOHfY5
 EViF1CVo/kpW4J3j3IS4RJlVmPbxL2UClAa7Vg9/z5dkuosRHRTVxdcPB4z3SjJCBZ7dUo3GpAq
 74GHlOV9yNPXB5VjDSPKEds9yYRy9c+44VGtmKxNAUBhCBJxwQPcb6wIcNvO27WVOZpYvbzamLc
 30PjGfsUiWxGN5uukY0/ckbaiG4dAIAPEo/KMSr/hNLub8qeGb/aSDQeu6CE+XPZqzPl1xtqHj9
 L7vkoaCthNao7p9MqU/e6qIIXd8gDyd4llaE0p2GQBBzc+FTEiugOeUj8qUCemSX2UK9Ykiy0Rt
 1tlwqyKloM/PgeSniTn79DIp3Uli7PmcwSwFFwomCXODyt8mGRBPw94d4JOAshi4fsjy+LsFTua Zx1eyKoK6bRm++A==
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
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/remap_range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index f8c1120b8311..15e91bf2c5e3 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -45,7 +45,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 		return -EINVAL;
 
 	/* Ensure offsets don't wrap. */
-	if (pos_in + count < pos_in || pos_out + count < pos_out)
+	if (add_would_overflow(pos_in, count) || add_would_overflow(pos_out, count))
 		return -EINVAL;
 
 	size_in = i_size_read(inode_in);
-- 
2.34.1


