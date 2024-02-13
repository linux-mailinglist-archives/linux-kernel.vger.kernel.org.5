Return-Path: <linux-kernel+bounces-64443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAED853E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF632866B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11F062A01;
	Tue, 13 Feb 2024 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L6j3IBWe"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C55629E3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862265; cv=none; b=u0hNBJuZKuBc4OBw1eTbF+r2NKT97z7AS42hv05FlBK5zZ7cAk6Prvh6kB+XgGqKB8ZGzjquVcy9Qgu4dLtYXKj/TzYGBtM4iFRgdILniFnnst92ye9Sksp/4jrrHPglK02EvY2ZGVfyHCFUCZbJyzDAKWnPtnRGVZYbG8RWWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862265; c=relaxed/simple;
	bh=gk9Sm9RrNWP7qFVWwHlEux51dUehEpnRcBtAM29pgs4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pS3MPwNf3V7WSltzTMYlvHQ1w+JWai5kdnbO3fylOSLsH9nzgw/lHgmsH2sd3yuLZLNKB+ALiky5TD6B9nLIuTfkhfNgvXHkxYd2wYZVa5daWEc3WsAIDCumd+O683L6D+lLxFy0/Y30yGLmrgwTzpd8RtpdXeZbyfArXP51ZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L6j3IBWe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d93edfa76dso39214615ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707862262; x=1708467062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6/l7cYejTBwG/ZbXfVuNOUK+p83wyeqabIOdAUG0DV4=;
        b=L6j3IBWef2o6ehNBNeBtrHiATS/+L4t2oXT0QZo3mDE0j6FGufyPLphJC3RAvJWuhD
         6gjgAFNq3eTJV8tC+Dgtu+jKjVwQU8pbGa9lOcBewVPo7vunEbV9MG7/S/qwzx2/2UTb
         A7lpTW6H0Smmrz4guT9sAWiwm/8qPipmTpXrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707862262; x=1708467062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/l7cYejTBwG/ZbXfVuNOUK+p83wyeqabIOdAUG0DV4=;
        b=udUXPay1fs7KPH/G+FkXrwGZg5kc6b0IT03f5OiXISglZv3tvN4+fgnmjl02nhxmDL
         bc5KTG+2Y4kS5gH/yobNNDjVWZTOHl5Mz4UwesEkzPCmBjvTxjMH9wdiH99VBFAjxXAY
         bVj6W07NfC7ZEl7kblRHtgtP4hf1EHh/y7n8QmcDmzzva5V2jXCef1VWZTiGckw19CYe
         LlJPT01GYZ+cjIsDmmkwVq0lSkoMwlSssHB5jqUhHT9fN23xTGjYq6sruLkv1aaMnEEQ
         kx1U0tDZGtMSGVzxekdg4QdTkpUvQZG3j9PeItYXTWRDv5zwv8LyfE/bRpU0IIrILfJT
         oI3w==
X-Forwarded-Encrypted: i=1; AJvYcCWHcwItHjLg7+mbgt3TULqzqE+QaAq/5r91gEoI0JpUc9m9n+qe18N1r82feyejQV33TUubBiSwzKUi+0QimjRLaWmBfSUJK46wdsa5
X-Gm-Message-State: AOJu0YwF4PuoXQhEA2HZMnQbqksdfhRRAAvr70rAKkIMJjZns3abgiEp
	LBDKwUoC6Sn81mJBM7ShNTorQ67IsYwY7NyEN9Y7p4+5aBq9ZxAcZqPE7E8D8g==
X-Google-Smtp-Source: AGHT+IGscCU141CmwJ2WYvkJl7vsKDQXUtAWyU4SDUKZc2g1xeH1JVOVpz19E/aw39LMpLEKmeO4fw==
X-Received: by 2002:a17:903:280b:b0:1d9:a4ec:c5b2 with SMTP id kp11-20020a170903280b00b001d9a4ecc5b2mr775828plb.48.1707862262652;
        Tue, 13 Feb 2024 14:11:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtoxK5uvAlsQt2axOXVYoFte05bc2pnd1mWStQ74cxgrpyY7px//7+H1hDsFtVk4D4PiphUeDXk/DmNqffhGRz9g/4wIj3lsU4f8eqVRGIkYfP5wWMybFBecEMONYfIVdn1VlZIJ+/Fhl2eUSaaUStMU0TisdvdRpPo159ASIR64ymwCvionKnMl3yIAep+On4dWq2sRY2CxfIgkgniuXW8jBWGloPXopzP7RwVoATJQToHDvfIzBGqltODSzuPtkr/0mv2iNROiLD2Ba6VuYUZcnGsqZjJnBuODvG24B6MV3Nqy6WbYUGfZXmDoLtVuibWaD7d+49wg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b001d7222d8caasm2508776plg.50.2024.02.13.14.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:11:01 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v6 0/3] overflow: Introduce wrapping helpers
Date: Tue, 13 Feb 2024 14:10:56 -0800
Message-Id: <20240213220844.it.345-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656; i=keescook@chromium.org;
 h=from:subject:message-id; bh=gk9Sm9RrNWP7qFVWwHlEux51dUehEpnRcBtAM29pgs4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBly+jzxdRJEY5FqMROusW/9i6Wzp3o1ypZVJb7h
 YkSj1ZNhcSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcvo8wAKCRCJcvTf3G3A
 JgH/D/4vgtaPXk0KWcLTLiJHtP/4BVDnRMBnnjHRKPNZJTzFtr0xrvrvitXfOBUYmJ+Lx8HifKS
 He4LRsgMd/CYZOK9jKUwcXvby63qMhJBK1w1KIdbJ4Lw2BV92OSMkNSkGNsqA9uqEOVc05tlF2Z
 wQ9JpNsGUqMZUHXYMZrBXJbGMq3/E56iNAuokPIw77Ikofdl5wDgajp/nCUAEYUSoqW5sAnetJE
 stN6XyFY8TnPeBcSO7fWb9T28zKzLBcqpyBPM1u1U6w7F7l69XxwjifGQ8bfcQ7Bmge84Dz8smA
 JvURngdGXHC2hlHLEOxCuDWxgSAbEwDQDJwivzItmmLU6SG4qkNzOG5bc4ZgGyrzMiyqf8H008A
 4r6h+woAQSQhuYNOWPGdZxHHO7r0bLdc2nfBIvKZ6JIxDy3P+9kynO3prHF7r/1KS2FiqxrFEJn
 QvEdsGBfjlqtG/5KMYy5owi91NA1jyRxlBTVnceQmxxdx1nwBqxtqtQK8OU51t2sK3TQ0lo7Z/X
 WPTxXk9O0LAJOkPoQvoC4HqMQrMJxYWA5bu2y2Ov4HsRExZL8qdWHIRQcniKlCZWwlC8MlEur8g
 u3DlvtXpA9lk4vLzGpf6di0u1AZq+pDdj/bFqGjqJcV+v0Z9+IkJKq94fDgXRL9SRpLvt3//7+u
 gVDUv70 hieHnvTg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

v6: rename wrapping_inc/dec to wraping_assign_add/sub (andy)
v5: https://lore.kernel.org/all/20240207152317.do.560-kees@kernel.org/
v4: https://lore.kernel.org/all/20240206102354.make.081-kees@kernel.org/
v3: https://lore.kernel.org/all/20240205090854.make.507-kees@kernel.org/
v2: https://lore.kernel.org/all/20240130220218.it.154-kees@kernel.org/
v1: https://lore.kernel.org/all/20240129182845.work.694-kees@kernel.org/

Hi,

In preparation for gaining instrumentation for signed[1], unsigned[2], and
pointer[3] wrap-around, expand the overflow header to include wrap-around
helpers that can be used to annotate arithmetic where wrapped calculations
are expected (e.g. atomics).

After spending time getting the unsigned integer wrap-around sanitizer
running warning-free on a basic x86_64 boot[4], I think the add/sub/mul
helpers first argument being the output type makes the most sense (as
suggested by Rasmus).

-Kees

Link: https://github.com/KSPP/linux/issues/26 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Link: https://github.com/KSPP/linux/issues/344 [3]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/overflow/enable-unsigned-sanitizer [4]

Kees Cook (3):
  overflow: Adjust check_*_overflow() kern-doc to reflect results
  overflow: Introduce wrapping_add(), wrapping_sub(), and wrapping_mul()
  overflow: Introduce wrapping_assign_add() and wrapping_assign_sub()

 include/linux/overflow.h | 98 +++++++++++++++++++++++++++++++++++-----
 lib/overflow_kunit.c     | 67 +++++++++++++++++++++++++--
 2 files changed, 149 insertions(+), 16 deletions(-)

-- 
2.34.1


