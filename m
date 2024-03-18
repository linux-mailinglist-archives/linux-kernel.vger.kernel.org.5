Return-Path: <linux-kernel+bounces-106502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D115E87EF8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7241BB229EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBDB55E71;
	Mon, 18 Mar 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ARZ9MwKY"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E456445
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785807; cv=none; b=pkh8FFBjp74QpjTwkTltzt0rYTxvot9/R1DUPC87MGuWd7Y2HnL64rNhyoE0qzrfdwRm1VU+T35NulxdcxickRS8O6MCnr0++8njDjYV2MvABFWhuwIPRgMK3ThSBr/hSpAGQlQ3sGnlvgfoVP8N5YchTGsbhjg6Og++cSltv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785807; c=relaxed/simple;
	bh=aK42RSRjeC9IKLretkq6K3mOb1utL1EABlZm0R0jL/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JUQOz3MwXQWxd84W+cHSP7XOXv+5OqN9WVTg3IOVBfbjUppWAeZcVf6FMkd61TRo3h6L48OIDOjDD9yL+kEs4seDhIpVYwTpUVtSm444xPFNky2URf4U81Hmui4JhV97usuf0eayqI0Oc82FN1e9Eoz8oD+sJDsZfP+7fHUDI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ARZ9MwKY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29de4e12d12so3241384a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710785805; x=1711390605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TutCVyAsBBig1tZFwFrMfle0rB3gxmbA8WbdKdW3GIk=;
        b=ARZ9MwKYKqfwMotgwXhfN0L71CEOcemJaTm1tgNV7bwsGUqRUZKFKyzRzFN2s8j9el
         RpGOhzxblG2mg0TPfT8g8dpHlWa4xzhMH0AXR0NL/WFrtQAUJPei63zFghw87PYRWIeE
         NEzRus7BQqQDYMIpGII5wYwud02uWh4iLNLiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710785805; x=1711390605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TutCVyAsBBig1tZFwFrMfle0rB3gxmbA8WbdKdW3GIk=;
        b=lrRGICAPK253U2biLAfPR5rUDG2OkQ+r8S0dhRXVwW3wlB+j8F1ra2IUlGD8GrRBIC
         cb3pn5Anhwl07rurjkfwn5p8uCcVdnw4YXtM4XNc6cHXbKx/1QmlXH9th/fy37x70+kr
         oB885FMyeEme+875aTqFPIgqmuGZYxDMAVLPVO56iCdeaRaK9WAhn8/2pPV6ffd/6U2E
         Bi4bTTdkq3eP6JAipZqklpN8vIg5aBWZFNeHiWVjG1bPlmXlk6jUqqdMqkk7avPxU5j2
         Y+OOeZwuK309TAumec3I53HN1FGsWwRBmMmCGfXoDI9Uq/Z58S2zt22/b9G0rPXHqB8z
         I3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUKVY3uNM2KGlyMlc53wRFprTlosSIWYssrmMvSHtBdwtsTBEdfWK630W9WIwDeslQwkaf2Hi6+97m9UtnBb5RDFEMUTDKS3uPaFRLg
X-Gm-Message-State: AOJu0Yzq7RdIEa5q10ji8SyQLTlGEjnyLsH9THYR1eQ90/Um678D1mZj
	Pw7cIp+RPGd0Fp7BIT4AAjfhiqjM6lYf5cGMJNR61NyrkZh6OB4fUvMJZAi/WD7++3bhDhj12eI
	=
X-Google-Smtp-Source: AGHT+IHL5dp9Je1qIRv0vv1+wAHaevvUv1aqzEk0ER5ggoxg/Bp/e00oDihoqfX4JSsOZSNsvbPZPQ==
X-Received: by 2002:a17:90b:3901:b0:29f:c286:d439 with SMTP id ob1-20020a17090b390100b0029fc286d439mr1818686pjb.35.1710785805001;
        Mon, 18 Mar 2024 11:16:45 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sw11-20020a17090b2c8b00b0029bcaaf2baasm8092296pjb.3.2024.03.18.11.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 11:16:44 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kees Cook <keescook@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"kernelci.org bot" <bot@kernelci.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] selftests/exec: Convert remaining /bin/sh to /bin/bash
Date: Mon, 18 Mar 2024 11:16:42 -0700
Message-Id: <20240318181638.work.575-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=keescook@chromium.org;
 h=from:subject:message-id; bh=aK42RSRjeC9IKLretkq6K3mOb1utL1EABlZm0R0jL/Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl+IUK90DszRxhMIIEkqPYLiLsWPFbVU218DUmi
 cRdTt7eIb2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZfiFCgAKCRCJcvTf3G3A
 JhL4D/98Q/UMkZ6mihjAYLaGdP9nozm50w8mti8CjE1+3V4lGLcP/fN787DQ0T4/Vlhr62YxZzW
 arKmNIeHxt4qqOgbztjGxKx2oaIXOoAslLTRTX3oD29Jf1BaWzfgB6gihYrhwaa1RroIcMdhpeh
 SmJgkZNubnQPgOzDRIbBB26JWcEKn2xNO2cBePzQWY2bCNDkV2pfBVui16V79jyYWFEl9oLvc0l
 PLUoqGnwRjaN7owt/aIbEGS4yPpNLkCK3/r4mPnFjE22gBt8hYIiu+Tp08fI/0WOMvYlUR/lHkJ
 JfYZ8WzbqZYj/RhnRs29Z0yixEJQO9aqR91ITJUJaFY5Z9ibebtCjUEgK/AWUq/Hq4ZrumVDwGl
 6N8yUiD4cE6vDog6YvggkDZcK0PuuasP9smEHFVmy+qjW51qw9xprEcbcncm1FdQyl4L36dDAWJ
 nIBreYuBDIHQgXtwldB0msRTmUGCMmTZZDb3xfpYdOs6F4VaH4YETb6f9JMZHWwicrGJB1SIS2B
 zVqcdb960hKGlfm80/5GYj2wuxscfgjET8yxFXRh5pfZfSmn1snv0U7j/zEBYaisVIL28oe2tVo
 PrGXRgvNWJYSe73k9eWBIJBEh/lKuHNlUFoH5tIRhdAbdv300T8IP7Jtiq4lbroM5e48UPzsZMK
 XJkcOSG Zpxt901A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

As was intended with commit 17107429947b ("selftests/exec: Perform script
checks with /bin/bash"), convert the other instance of /bin/sh to
/bin/bash. It appears that at least Debian Bookworm's /bin/sh (dash)
does not conform to POSIX's "return 127 when script not found"
requirement.

Fixes: 17107429947b ("selftests/exec: Perform script checks with /bin/bash")
Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Closes: https://lore.kernel.org/lkml/02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: "kernelci.org bot" <bot@kernelci.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/exec/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index a0b8688b0836..fb4472ddffd8 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -19,8 +19,8 @@ include ../lib.mk
 
 $(OUTPUT)/subdir:
 	mkdir -p $@
-$(OUTPUT)/script:
-	echo '#!/bin/sh' > $@
+$(OUTPUT)/script: Makefile
+	echo '#!/bin/bash' > $@
 	echo 'exit $$*' >> $@
 	chmod +x $@
 $(OUTPUT)/execveat.symlink: $(OUTPUT)/execveat
-- 
2.34.1


