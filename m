Return-Path: <linux-kernel+bounces-87950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AE286DB68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604F5287895
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29385F57D;
	Fri,  1 Mar 2024 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q0Qr/4Vr"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB353E0C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709274153; cv=none; b=NHOjflWbyXUN44GrH3AY5OzJvI0BXTIPD02FbxCg7hnL89za2hZD+ir/dTi7tuzS7RZo7WOdD5ytiTk33/tHAYtgT1crmXFX3JlH4uth5cT+TutxBSXJSLfb83spl7x/+GjgNfaoKxioB8MYlP2tzqFTc6QHB/h6oawcJSoKu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709274153; c=relaxed/simple;
	bh=nkDLJ6WB0NLP5FADrDHK2O5eBlSqLx136t+9yu5wrW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ld611OWPpLaaDRNV7Jzk45KErvhJuMOXVb+KV8LZvo8pSnnTZ6QX+vdbJvp3QD61Fw5IGWMHPh9RsnB6PlJUBZ8rZysrxldLPNBstpEORllMPVgCd3ovqBZIeX1MDnIoWEWX6GeBcqhW0bEhYdsRPrsles8XT3fjF+n9pVJRb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q0Qr/4Vr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dca160163dso17255165ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709274151; x=1709878951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYBet8jzEAaXJ8h0cJCdYsDMsMIPeeskBYFvUKsljdw=;
        b=Q0Qr/4VrLHkV6lPtr6dtHNTSX5NWzp+dK+Zy2c91HhubIjjh7+n0wK4S8UEBdkE8eQ
         VWosxPiCP2Q/hJgVJIHYOdbxRDec9+we8lF8H/zsjbps7X7EveRojWdc/8ENrw6zmXzg
         dljZ9Du0VulCspZ3DwjmuMyL4vgweus74diXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709274151; x=1709878951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYBet8jzEAaXJ8h0cJCdYsDMsMIPeeskBYFvUKsljdw=;
        b=uIZ9/YylGnnfmNH+LWo23CEVFOlGNBztEDsLcAw34e4i1o2KkEb2t7AKCUzxmDEzvD
         Yp9c23oUgE3ffaIHtv23faeQPJ/4avFSzBJqJbjAfRKJtSPUFNv2SAMIsDRXzsxaP787
         vMkHXTWDuJ9qnVGcLc88UFAjgMI40ccrrahJlwCMZRHxNxG3rEEiWSQDlndov7gBQkDO
         XWLh3Y9dJHcsukoVz8jbkF7nEaeYb5y4m7oEHcSFAW79M6rspr4j5FDu255fYGUmZtOO
         haXZsr/mRPrTRXoAR5nnILBR78QI2O7+0Dspz/BQUZQ7OJRrRX1OWdYxNUGgdvXDBJXy
         qxOw==
X-Forwarded-Encrypted: i=1; AJvYcCVK/mMzzFf0R4nmWLOKA79FUCOKRV3ssvSexlBCj+hTJ4miCL7SMsjA4TaF99aoauyuiPBA9pKrEa1yubco+CBUa+PfVzOtOW6JP39a
X-Gm-Message-State: AOJu0YwQIl1HWmvoBE1oZJHu5S+aKXQqx0F806KMOpXb9ABt5bBDDXrN
	636aRzvsE8U83rncPY9TgiunqR9hFLFawNgIN1T3jllxF90LcHCcNiwzIyPVGlfPaXVZ9vQsNX4
	=
X-Google-Smtp-Source: AGHT+IF6xsaDxE5PeOnUmCnRARNUUj3wol8fdHdtLBuVUplBwl/BxljbSeJG2KeZ6gR/5K374CrxSg==
X-Received: by 2002:a17:902:d4c6:b0:1da:1c72:2ca7 with SMTP id o6-20020a170902d4c600b001da1c722ca7mr972104plg.29.1709274151096;
        Thu, 29 Feb 2024 22:22:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e5d000b001dcc7f470a0sm2584157plf.96.2024.02.29.22.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 22:22:29 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] overflow: Allow non-type arg to type_max() and type_min()
Date: Thu, 29 Feb 2024 22:22:26 -0800
Message-Id: <20240301062221.work.840-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; i=keescook@chromium.org;
 h=from:subject:message-id; bh=nkDLJ6WB0NLP5FADrDHK2O5eBlSqLx136t+9yu5wrW4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4XQirvuEcoaZvKXWUxnAJrT0HSd08+1DHV4WP
 wHwrtymdduJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeF0IgAKCRCJcvTf3G3A
 JjYrEACWT9teq/GO6cdRiS18Dv3XNRA3r7j3+L3q0UwfknbnaW9bwmW3zFO9pP9sc68hNvRU26l
 hpVoyED7+agtlDIEB2nEatBT9ptgdWVCIPCZa/K6DVEqUrIBNsrbFieCmY/HpLmIUMutW1HlNwc
 LzUMVdHhcL7/myB8AwArbpbKuoC0ma/iiDAymhsJ4xi8o/eTMuLvjBFZRWAQVsmM6jHb10I383v
 moCbC8A5nioRmsIbJ4KCJ/FvQVQdYLQMf7JR/wuxD+AQYrWoyNjhUY/YwzoygnguPO2uustI9JT
 OmZ2TCd2padLKdwI8Uq3LFmcOhspCYfeHasVt8QCoEFSFNDDjOZWk/RpwdGg15HXiXqFS9cZWg6
 ABrdxdHycf2HVN205YvVvHn0BICLKpjBcBg2tIGoHGsDMHXsM/h7PDn5UHQGFdSTh1WsZldxlLV
 +9D5BNV8OdMcfOOnTaXLgg13nvlhFPiCnvzHZPQIdg17M3r6kDNizNtH2ZPnSUkV8Ig5nY7m7Mv
 os+DB1UuDNgocSu2OtaLhgvjLuHno+e1v45fefISYBXio2fwqpR1etRBZnYDavlj51yxTzJkO61
 dyEW0nW/duQrIvt/qTClmXJjUyCj3skhuYmE8V6oNXrGkK+YLneLA9dhpG3GyLXluu/NJ+Umiom
 xZVOk8m 37olJbWw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

A common use of type_max() is to find the max for the type of a
variable. Using the pattern type_max(typeof(var)) is needlessly
verbose. Instead, since typeof(type) == type we can just explicitly
call typeof() on the argument to type_max() and type_min(). Add
wrappers for readability.

We can do some replacements right away:

$ git grep '\btype_\(min\|max\)(typeof' | wc -l
11

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/overflow.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index dede374832c9..e1f4814a2401 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -31,8 +31,10 @@
  * credit to Christian Biere.
  */
 #define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
-#define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
-#define type_min(T) ((T)((T)-type_max(T)-(T)1))
+#define __type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
+#define type_max(t)	__type_max(typeof(t))
+#define __type_min(T) ((T)((T)-type_max(T)-(T)1))
+#define type_min(t)	__type_min(typeof(t))
 
 /*
  * Avoids triggering -Wtype-limits compilation warning,
@@ -207,10 +209,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 
 #define __overflows_type_constexpr(x, T) (			\
 	is_unsigned_type(typeof(x)) ?				\
-		(x) > type_max(typeof(T)) :			\
+		(x) > type_max(T) :				\
 	is_unsigned_type(typeof(T)) ?				\
-		(x) < 0 || (x) > type_max(typeof(T)) :		\
-	(x) < type_min(typeof(T)) || (x) > type_max(typeof(T)))
+		(x) < 0 || (x) > type_max(T) :			\
+	(x) < type_min(T) || (x) > type_max(T))
 
 #define __overflows_type(x, T)		({	\
 	typeof(T) v = 0;			\
-- 
2.34.1


