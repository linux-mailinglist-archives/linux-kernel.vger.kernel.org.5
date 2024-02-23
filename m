Return-Path: <linux-kernel+bounces-78790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674738618DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD3D1C22642
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D351D12BE98;
	Fri, 23 Feb 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VYF/VkRH"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC32E3EB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708113; cv=none; b=dhcEuW9m8SY//mUh8LW818YNjhTLpQT5wD7nQPg0M/w1OgJPMWj7fqg61oSbZ7Nw7dML8s0PWGzFzvzyza01PmzzRx8U/FovYCQ2D9Rj9273ukjfqZ8vi/B53VutpXzursdaQT3Z4ZuIWYq4Tf19lRNfqmGu0TiprLJ6m/B4QEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708113; c=relaxed/simple;
	bh=RpPzyUdBMHw+e6c2w/zSbIImslWkeJsD/hfLbs5EbQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=es/rjtMIobFV1xGcNsI+qaFzkwyoKHHU6wDOe7kNRNFJpDKhUAoFs5trLbblRcOThQK5fPUCMnv9cUerkoOlFgHWZVbAgHdILZ75gOVnqCFxX/sVzaO+J7xOjTxWJ4qyJzXY+rOb74QFFbjUkn3+/NBETO4IuZNdbirOTsjWblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VYF/VkRH; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e4751b97eeso431798b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708708111; x=1709312911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXvSc66LmdizGZD4epGGkU6zC2BImPYnyN6VRPIWMFA=;
        b=VYF/VkRHEQMJjT+8i/SKyug/XbU7qo5K9o74XgmYj90UFOwKWk6Rku5cEKtxcp97UP
         g5r+MCW/XoqjiVL77ePVvvgSFxQPeRN9zCIrPmrFk9XvGWSiVPEWOG9eE4jPMNCj7tZy
         /cesk59yd24nwEx5QE9GlSRv85Y+VfKBHYoqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708708111; x=1709312911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXvSc66LmdizGZD4epGGkU6zC2BImPYnyN6VRPIWMFA=;
        b=alWWEu6TyV8bQU2ArxKSOZUma3j6AwMwdU4ib5YhgY1GM1/2ONc0Re5rVMyh+GEhix
         Mjx+wMSo72WfpkKcEeHJ+cdU+D3ccuGB9Oc8w19R0hQW3jfrHH75SqZcLSgkhtlhwitl
         bvRR4ppfzemWrrTFiST7r6Tn3LM1UzmEy4/2TNE3+dzf7xOUo1YGvqXaKJtQ+X830a+e
         CqNGWOp6V+j7tKphinx7n3GZVCl2Fa8VhDZ4NJ2pQln9h6sKQ88b6dB/AWDleCztCv3y
         53d/j3LhIPnG2uxnd7GrqO8fIh6c5UVZbBJGwIneuxb5/IMMTyfzku91P97sHaAAlLoV
         pEkw==
X-Forwarded-Encrypted: i=1; AJvYcCUkZ0+2L0RIkdRoS4CnxO0l7nqXGASbarbyDabUNb2Od0Fbcd6Ak7sAAd55dfJLf01ZTNXywh/sNIq7284kdlwDTMNyJm3Suqbydqz0
X-Gm-Message-State: AOJu0YxLJ3rY8Hs49LOBDnMIoLvkqhvibj55aA0nWnQOWkFe8J1BmZ9k
	pPwTmvyuBhWRZ86Nd2/2fPLZqpNTl2HjXcqfMk/3Qz3XAOgPYvhXeHYwTZEhEg==
X-Google-Smtp-Source: AGHT+IHFW/iUeNLUozR223PAOpx6Oy4hwmjAHdcEZV0VxryiJP+lYZS4yikAD2OSHNobuSJ6PmMdmg==
X-Received: by 2002:a62:6342:0:b0:6e2:d162:6315 with SMTP id x63-20020a626342000000b006e2d1626315mr383813pfb.29.1708708109770;
        Fri, 23 Feb 2024 09:08:29 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y14-20020a62f24e000000b006e25d4085b4sm12654312pfl.27.2024.02.23.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:08:29 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Lu Yao <yaolu@kylinos.cn>,
	Paul Moore <paul@paul-moore.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	=?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] init/Kconfig: Lower GCC version check for -Warray-bounds
Date: Fri, 23 Feb 2024 09:08:27 -0800
Message-Id: <20240223170824.work.768-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811; i=keescook@chromium.org;
 h=from:subject:message-id; bh=RpPzyUdBMHw+e6c2w/zSbIImslWkeJsD/hfLbs5EbQ4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl2NEL0zsDJYYB06VoCsoWg3N7+Cdx8Q75NiD6H
 r+wnxUbt96JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdjRCwAKCRCJcvTf3G3A
 Jp2eD/wKURtgCmOGso2RwQSmy+gv7/r4iAPC+JLwA+vYHD6qvZuXgUGGAjpeqZX+A70NpwCAVoO
 vFKkrsN4JjdJ6CJTvCPkbze2+dqgLX3uvDPOs/HsuRYByFTh1sJjogogv9EtXs1iDMDRaLSwH9w
 Gmz+N7Qydd/XxBpf/v+ttsfEJ6uO4qIKd0OdYDlJYO8p20vVy4o7gdLV31Z3kaux4/MtyEUyQWB
 KLJrTC9vJcWlgJYTJsiLm49jW0/fvu6AxPcjNeYWCLjFAhG515K0HIcLFIG0Sj8nVGp7pyuiJBM
 cbk8Y9atz6Otapq6IZ0LKFkj2aDhSGkhYcm5NB6+m8u40IPl8Bh+dCceimTAFn0j/dHwsyW5cka
 kz7j+jx7QS8ZGgtG/zH14NclTtbRNydyJkejzZ3/NKcWuzah9rpZbo1Zk2DYTVgqp3fVwHiPKSc
 6bXXDCOvvdo9wjrIqSw/xhwFR+lI3o+ABrTVrpBi6VY9tNIPxKmYvJpsJD6FpMG1O+K2cYNd902
 RUYBxJ0NqHk3zwTCxWJ+j5KnR5SDW8icgJVwosC5zhYe+lbh+Ep0y+5t8Lmd+k3iXQTqziCCfXe
 QrBkL5uU3xqcvSxj1ZsIVLV5ykvjmnzeFqFoToDl+yTqV05H85citCy/ycSfk69UpbRaJ1gkIme
 WLlUqFH f+Yjh/AA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

We continue to see false positives from -Warray-bounds even in GCC 10,
which is getting reported in a few places[1] still:

security/security.c:811:2: warning: ‘memcpy’ offset 32 is out of the bounds [0, 0] [-Warray-bounds]

Lower the GCC version check from 11 to 10.

Reported-by: Lu Yao <yaolu@kylinos.cn>
Closes: https://lore.kernel.org/lkml/20240117014541.8887-1-yaolu@kylinos.cn/
Link: https://lore.kernel.org/linux-next/65d84438.620a0220.7d171.81a7@mx.google.com [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 init/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8d4e836e1b6b..7b352f2943f2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -867,14 +867,14 @@ config CC_IMPLICIT_FALLTHROUGH
 	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
 	default "-Wimplicit-fallthrough" if CC_IS_CLANG && $(cc-option,-Wunreachable-code-fallthrough)
 
-# Currently, disable gcc-11+ array-bounds globally.
+# Currently, disable gcc-10+ array-bounds globally.
 # It's still broken in gcc-13, so no upper bound yet.
-config GCC11_NO_ARRAY_BOUNDS
+config GCC10_NO_ARRAY_BOUNDS
 	def_bool y
 
 config CC_NO_ARRAY_BOUNDS
 	bool
-	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC11_NO_ARRAY_BOUNDS
+	default y if CC_IS_GCC && GCC_VERSION >= 100000 && GCC10_NO_ARRAY_BOUNDS
 
 # Currently, disable -Wstringop-overflow for GCC 11, globally.
 config GCC11_NO_STRINGOP_OVERFLOW
-- 
2.34.1


