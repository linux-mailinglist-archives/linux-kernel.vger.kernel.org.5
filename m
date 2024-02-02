Return-Path: <linux-kernel+bounces-49609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C0B846CE1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A703528C1F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E865C7CF0D;
	Fri,  2 Feb 2024 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J8pwgki4"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02B18E14
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867160; cv=none; b=PurcjgHZv5ADZFKNi0XPDkBjQ7R0mqn6Jt6PstzwS5n/9SEsPyu9pelt9rIhPRiASLgq/gL7d2QnI8DPDM/LvN2TcF8dmqRE8Hz+gSHBEzfCL5b3/RRJanxkS+fuwZrY9F2NIUcVsiueWj8/G0lxfjA1+YtvXMJcvzInRcYtr1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867160; c=relaxed/simple;
	bh=LHaeZi49H8+c8GUjIT1hBKOFneGMYEW1V17K53sBiZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TyEisANj7wdKDcXChlOz6Ey6nn1HNzd+qQcJDYztije5WZKrfku4mO/n/jeRJMvbVGXcN4740UG6jVD6zDgRYO8D+KG9INGXlJ6TCTFmmYvC8qZN1zrCsbWkOu4/fokYol8v/C25rPX7ZIVZowmvd/2+EH+l4AVZH5wrjMHbiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J8pwgki4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6de0ba30994so465769b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706867158; x=1707471958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6Mh0KgYXz1dfRa9WvoxBlQAZ2AaMDjAGTo7uoUxXAI=;
        b=J8pwgki4ICyCdHiWdApI8VX/lsuZRAeV5Z9SzB+YdGR3ZvOTPSrMp2qC/0q7UFuKog
         ywbm2dDuRrv3L9IUCvqnKWQZbB1IbpziMcU4Kq8G+aS1a1wqq9a2XffWtC+rWSi189oc
         abgnZ0UtQWVic6GwYMVdYMR6Ew3jGm3wx0gU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867158; x=1707471958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6Mh0KgYXz1dfRa9WvoxBlQAZ2AaMDjAGTo7uoUxXAI=;
        b=DNrt839RPSK4epJF8+MGw12ihZ7R3dsg3/XNKv70oLhUJ6gXzSIXCDicGiIk51WmrE
         g4gwc37GtxLqetv+z8ybgZA9od/lI8jrHPZh0fkFO8jUrnJ8R6niteKTl1sngP0ufCxj
         aMe88XxLXCCix37Ia7w7F3E8jSUBdBgYC6G03zvZTsCviL4TM4K9N02f2f2/W3B2z2vU
         cSKZWX5qapXedsj/pbJyTS4IJ/XqDE0mh7tMT5hQzGyMQ8BnaDaSper47ED+4eM17Yjh
         zev7EivMz1+Wku/oDpSrj2zJn7EC24pj/HEa+a/FDvG/o1A8r4pa39Vz3/CeVCwuanty
         gGug==
X-Gm-Message-State: AOJu0Yy3vk0zT59erdbZgfsA46myF2POJjYyipT12/aspJY8q2h5GiwQ
	1gUDx5tkGcK8Y5Lwcut44DEXvbMB4nAhXZIP/jiJRO93f5R+Yn0i1tZCqQa9tA==
X-Google-Smtp-Source: AGHT+IG+CATR3cbNaVfXbuWt+rSwjJxbCafqQL5dAfB1tLVD4SIHCp1MzZNb2H6JcVigGXhySs6mfA==
X-Received: by 2002:a05:6a00:21d2:b0:6d9:a074:659f with SMTP id t18-20020a056a0021d200b006d9a074659fmr2429702pfj.13.1706867158001;
        Fri, 02 Feb 2024 01:45:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXKcgtLHB+AwS0CybkSAPWSSH8KbGA+dQUGzv1pahiZEgIEA7Zogbqh0xKPbMqKIOvRRPJRmPHx7ec8yWLhe0BrhK48z6qwpUfCi6BZ/5tBrQ7z6AG1kpwU7mids1sJrih8eSKmA05SdLpydUtvcp+Obu6dno+nFqz/fFAO
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i63-20020a62c142000000b006dff2eb3a59sm1226975pfg.126.2024.02.02.01.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:45:57 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ubsan: Silence W=1 warnings in self-test
Date: Fri,  2 Feb 2024 01:45:53 -0800
Message-Id: <20240202094550.work.205-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=keescook@chromium.org;
 h=from:subject:message-id; bh=LHaeZi49H8+c8GUjIT1hBKOFneGMYEW1V17K53sBiZs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlvLnRQt2lu0i5tjqpOkba/8mR9VJb/odFYtu03
 FdvbjACtROJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZby50QAKCRCJcvTf3G3A
 Juo+D/43EhPw/7h9hbGja5DHnoBaUE5+CK9V+boNO4S9I066D6BYWc+kIHS0Glpa7Cb2ZP9pm/H
 AE4hSmtV/8QMDGFOwVN9SEA9tImP0BqaCEWIS7HjmY9jqCF6wzYbm1nQYpgMl4FW0+LL0P4UFvG
 6qLt8t2eWQxlmux3vCc/rGOVhetPp8FM71AzeWTiHeK0buf8XIxMb7L0+bfw/2PIOARu+pu9gLz
 Qgm9ImTC7u4KMSQCPGMNOTQQbq2sg9jelI2wTMiFwCadLlwCk1XAKJ4m303sWsqy4zf6rljNhcJ
 gD/FC09zLpUcN9F9b9NuzzM8US1Ki8MOaDIGZOogdlEnSOQDvyyNJWSFCEM8uKJWd4qpGvv9xdu
 fstZjgyp9o9NHe4QsWs22MIUn75xyczgjGuC0FWaNGkfqjwrbHFqVIgjxR0OLWi0j6aAZ9E6+DW
 BMFScZUoZHLYdXzICbilErcD0STSMSI4Fvlk31WIrVxZUyyxg04WRiwVhEHNJBZFjTxqvNB+MtV
 WorewOjshIM1u9ZtROceI7yFKgHDiWomqVsoWiKKEpvh9m9A4D0+z9yXCVe0X6ESO6skBRuSKV0
 ONKG9nFFSSd6FXOy/iGSlWmvPy4tnueiNeGU/R48NSHZLD8L5Pc1SR+EEfSVV/6EklNqmH/Ghqt
 Gr6eJgg 43Fjdluw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Silence a handful of W=1 warnings in the UBSan selftest, which set
variables without using them. For example:

   lib/test_ubsan.c:101:6: warning: variable 'val1' set but not used [-Wunused-but-set-variable]
     101 |         int val1 = 10;
         |             ^

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401310423.XpCIk6KO-lkp@intel.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..bc36a5c167db 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
+CFLAGS_test_ubsan.o += $(call cc-disable-warning, unused-but-set-variable)
 UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
-- 
2.34.1


