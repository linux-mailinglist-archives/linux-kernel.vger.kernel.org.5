Return-Path: <linux-kernel+bounces-102336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9773287B0DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5170A290A13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0636A8AB;
	Wed, 13 Mar 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TjODz66q"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71760605C1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353545; cv=none; b=lnHqGLMv+O2GHepXfzdtfhI/AqRA38zocdJ3g4yR3hp4vNL6m9YHc1XS60jL98fB5XyI4GvtiC9PLqZoWLvIW4p89FnzCTo0ithuiaNhdZBSNnyJKuWdplhkzGh9jbBVn+2Uk84p3S1dhAgaz1iK5Hh+2xum+eMh9nYJ1g2vdfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353545; c=relaxed/simple;
	bh=Juz30sNn9Vm/o0qmgqL6ej/+Db1FXC/0PH8XbJPugnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mT0QvRPsadeQ13TfveLFmG2H/YMegXsoWUjJ57jiMXJDgQIC3OrNBPWRKQBlZK7OpNGds0fMyzBa9lgE2XOulpWowAMQrUeG3nLQqw6g8g25bVBASqIOceSWdkreCZ/wrT/ZEsIwhs4BjEYrLf+lOK7rgmizOPqxlF5m7mG488A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TjODz66q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dd878da011so707665ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710353543; x=1710958343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zH16D+dx0oQl5CujF1HkbTVT0zJku0/wsGqqINARPF0=;
        b=TjODz66qwSw9FCbT7aXlAYxoSRj85qdomQp2Nzrvnuxhu4DKNXcKTBbQ8MoR0d5VcO
         N99SZPeUYeRI4Ihpt2ZKj/Ks2NnI9szyD/xgXbyMF1bzBB9JB/0l5kN3P4qlYC6MrxNX
         qU4spN/SOHu1FlLyY3pm5HLgrBI7kaIplfJ6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710353543; x=1710958343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zH16D+dx0oQl5CujF1HkbTVT0zJku0/wsGqqINARPF0=;
        b=wSlkumy5yDkOLPVr0/GYH1R9rzEVH32Q8WMHpBcNASdPveRFdhxW8SZuDDXepm9SBw
         m6tJZq/neRov/9bFUnR5Ku1DFqyHC/30O/YnTswBPYEDUIPtMOyPDHqx38atEzIdF6GP
         BDcWe/HyNM7TA2oxmrNjR1LtIb7csHDZicyYQbbrv4KpEBtoPR2i6XgaSGs9jjd7MjMK
         G+/fgoqAdnPzd8o76KkuXdd+NK8yIC9xIgjfmOYJmlpw0EFIEiC6hNkXPBQDqLJBt1Dy
         RdM9rqXZ1tJyVAwKVCZ3rLFUvyDqCPfTlBfo4tBHmZzgrZorjnBmxlGExF/gknwjfUOa
         d9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmDAdqp8ZbUNbsZi2eYc8jw6EQiC+bOwYHIorwj08t6SMhvxrD3N/WoMIoHTbG5bZyS4TSgUyvWke6uPqTLMZKepQPnq0wE44o8Sg6
X-Gm-Message-State: AOJu0YzBpicrkobooBAccZtqRqVeLN2DAXT675APU3HydOCLbnV3U/YI
	Injh03f+ct3hHxOUkjpsqrWAsNZc47ig2/nDpMeUAsUywmbLuj0spDKMM2id+g==
X-Google-Smtp-Source: AGHT+IF4D9+0QB6a94Q1UTugK4FIN2Jw3/2SUxLiLcnoVm4wN+52lZO/YIzJAWgk6SC0iB7flOhkNw==
X-Received: by 2002:a17:902:e849:b0:1dd:5ba0:e0ee with SMTP id t9-20020a170902e84900b001dd5ba0e0eemr6961805plg.9.1710353542738;
        Wed, 13 Mar 2024 11:12:22 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902e74a00b001dda1e9f510sm6006486plf.92.2024.03.13.11.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:12:22 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ubsan: Disable signed integer overflow sanitizer on GCC < 8
Date: Wed, 13 Mar 2024 11:12:20 -0700
Message-Id: <20240313181217.work.263-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Juz30sNn9Vm/o0qmgqL6ej/+Db1FXC/0PH8XbJPugnI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl8eyE9J4yYHWBRmDSdvgZpqfXhVx4eTZnYonIO
 C2r7NDdWBeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZfHshAAKCRCJcvTf3G3A
 JrdUD/9PrK3mREHrrRuyLF4jhJgBAkp5b4PysQdaAjPjzZYkJbyTnujbjqdj8HsfbcKdySR+sQ5
 onBvzW2mCRKGIevgEPgGaRJC+9qZWmUP/EBSa0kkQJAhA/WkPe297pALLimV0ipGDra9dQnJaR9
 AvQE/QiFBgiUxzrnIEwLqsVsdHIjudciaLu4aWyg+CwfuW06MV82wAfjptQQiKIr95CuFOJ4ykm
 lF7cpXA5NH/v5B+wjfh4iJ4r2/zjaDi8TpGU4HQ+oqYCTNH6A3+x6qEXwuOdzPSO4kcJ3AvfOis
 UW7pd7rW8+O25WJaEyMo0Npxvs+3gKMwDx6G/DgM+PcE5swxdcPHZAqIX1UnL+T0KeQdIBEdgKt
 KqopeblJVpbLxic2Okx2HQDLQQXTec0V3igxfc5msTovLOhTkdlprYSH1pwYC7/Mriht7U+TTUj
 cDewZRRncSAgwMs/EMALchw3L1ZtdIYMifMrnHMMpQ8PwPsptTatZ+WxpQ9T7fAezSb5jgNJCgy
 edDaC8i9zMq3eQHCZcP8W9ej8H3sJ4ywMbbnRUTqD0VF9hE5yBQrwo818Rh3+sU3VvaueK3fVV7
 +j/OFiy6wrf5XSH/dPltWckYZlHgYO1pxaoskP/k/XZiTJUOpJY+DN7ISRH6KiOOBmk8gXBvTgg
 88J3E9H MDnG3kmA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For opting functions out of sanitizer coverage, the "no_sanitize"
attribute is used, but in GCC this wasn't introduced until GCC 8.
Disable the sanitizer unless we're not using GCC, or it is GCC
version 8 or higher.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403110643.27JXEVCI-lkp@intel.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
---
 lib/Kconfig.ubsan | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 48a67058f84e..e81e1ac4a919 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -119,6 +119,8 @@ config UBSAN_SIGNED_WRAP
 	bool "Perform checking for signed arithmetic wrap-around"
 	default UBSAN
 	depends on !COMPILE_TEST
+	# The no_sanitize attribute was introduced in GCC with version 8.
+	depends on !CC_IS_GCC || GCC_VERSION >= 80000
 	depends on $(cc-option,-fsanitize=signed-integer-overflow)
 	help
 	  This option enables -fsanitize=signed-integer-overflow which checks
-- 
2.34.1


