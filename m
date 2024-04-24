Return-Path: <linux-kernel+bounces-157318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418CD8B0FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A211C24936
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7821635AD;
	Wed, 24 Apr 2024 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kC/ysrQz"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6416190A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976050; cv=none; b=J7xCld/fHxsDm/l2aqxRHOh5vyH6IDbMlQ4fiJaVAJPMyKeL19EkLm2u6mYwBuNoMctuFe2GIs0ypmZ09rqNFptnCsy1kY94UtnLQgl3kyEsCM6zmtUayXCyptp0iJGLk7FV38CzQSJ0kWXElyshKeuqX3H5LLrAddssMkXpHxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976050; c=relaxed/simple;
	bh=RUQFXdH8cHsUkS7WjlnySjXvh+xuWtYB5a0k0jg62aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=plylf3GTz2Ua81EVGJXXEXuqPON63/gGyjI9zPgRrfdUqJHywmuUWpIip5i56zB5O/f8VGQY0Bb6kQ2ArR5wAfQhFARJMW8hrHfzvZAavig+ORvgOXNZhYnX81m7xcn3e9ZypOJe+L2O5KxNwZQADJ7UnBnrFcgY4agPzHAdJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kC/ysrQz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed112c64beso97555b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713976049; x=1714580849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqVdIKh+FGhuAkF80diaGZNWgnSMw4HuAlHZ0aOXJaQ=;
        b=kC/ysrQzeC2HWDplE6JwbcbitP74A7X7oc62Xp1KOvuEBZO/Uwi+99DPeodb85PPe4
         7ohxcItNZy/clQPJqPyuvQjt5uV/M4kKAXjIS7s1Vhwf7SG/mhARqHE8q//p3NST6U0Z
         4bPHiF3gXHkpohHvsZJbbWJm+7lC5uhrWM76s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976049; x=1714580849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqVdIKh+FGhuAkF80diaGZNWgnSMw4HuAlHZ0aOXJaQ=;
        b=KGKQyk0hPYczw3+Qrv8CQY6aPW8yCv29vZT83eCFosGslJqFAMqps7S2dDJT2lqFrY
         TD2KkPR4ww2tSJLgurgkhVxgW4jp27lZmdT7l/fZUsPmNxuqULD4b3WJiLisUB/V/Is/
         yKIvj3PE1dVSzDDF6bSQs2qclBXD3dzO04E7stmz8qWHGq/9T82QUivBkIykSQP7yUhT
         tr+fcP6CTv/pJfOjpHIpV1xBS3LQrlcYrGODhniLmepKi4Xsq26GxmjU7PHl03aV7RQL
         oEar/qdJeHHKtr1Iy6ds8TZw6KtBdq1HP1TcoktOzra96z89Oh6/pNOtvJgXDvimrgZ3
         1hrw==
X-Forwarded-Encrypted: i=1; AJvYcCWpUNa00PC43ytABiRX3/5TEBBlgdA5ID8zWQ4JZlFBbyPo5lnVgtXBLi4e9a6/V4Zn+fbkD5JkOSoIG8ErmAP5XJSQYKvfMInATsYf
X-Gm-Message-State: AOJu0Yxl4GGXEtsxgYKhmKBORcNWYkImVpgC9XYUyyvDpygwLY/byUMa
	ieNK5fQX93Fs6SMazRlA+NyNulzdPSUJRGyxgUER+LOnqPnU7pgBpp3X5YF3SQ==
X-Google-Smtp-Source: AGHT+IFKjIGKbQ918qemrQZuactvTy19Wo4N7YX9x+pAnt65I+/kRKl3YikmICPFbANqjjaaSMR3ew==
X-Received: by 2002:a05:6a20:96c3:b0:1aa:59ff:5902 with SMTP id hq3-20020a056a2096c300b001aa59ff5902mr2898404pzc.9.1713976048655;
        Wed, 24 Apr 2024 09:27:28 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bq15-20020a056a02044f00b005f806498270sm7830151pgb.9.2024.04.24.09.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:27:27 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add ubsan.h to the UBSAN section
Date: Wed, 24 Apr 2024 09:27:25 -0700
Message-Id: <20240424162722.work.576-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=707; i=keescook@chromium.org;
 h=from:subject:message-id; bh=RUQFXdH8cHsUkS7WjlnySjXvh+xuWtYB5a0k0jg62aQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKTLtBpO5sGKQbNTQQhxZ0ZsYqUs12l6Ughw85
 8Dyfzf7pCWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZiky7QAKCRCJcvTf3G3A
 JoKXD/4pxNwOoTftHBpfo2Stn6qEj5ph8TjzUq5xw0sAvUVgJmxp7K702EyccN/XySiLP+3ZEmm
 9RutTYSsj8CcQBjVrhOLb/xvlrEJaIspTh2p9EHB8piS8HHt6lpQE4YxgkeBiy7tas5vedCTzXa
 1a+mb8j5zAyqx3nIcOVe+QbaQuQob4txxHUJZ/OFqTgCnpZQdi9IFSR2k5ILVhYuoBqyF01ESCI
 1Osrm+i3pe257pYqItAU7opFf1pPETUEUoK/yCZ8oriu7XtP5WSovuV/aBZiCxemqQdqq6FmCOJ
 Yirj9oYJvuhXNEfkyi1N9RNTYWAyAfNuULtzx8BHLDMjtX4AKL31AYH4O/2DqoFb/3y1BWZyKBd
 cppLw0sEN52uyp84/RCvPiapZ7/M5JZbRbdoS7LKI0WQ9DdZsUVB0XJ8t9ckg3gaIGCbyRJmsQ2
 d7krynFko65NOjKREmXj2tWd9ajjgJAY6ASIurcHDqVhUjdbfcCSYjheAlDGbljc3pzaUPWvMdZ
 Iwyt3rCA32x51eV2YP4S7q9XgtONVibEmpI+uCnxfi/c6iReQpCHB2XmiLbIDLdkNo3TDyS0YA9
 S56kXblKN0pe2kQ7dvOsEd/FZzu6Nfn9CChe27WtPhDE6e1v9tVB/qxQOCIx6tHLFHvAYKafkbH
 mZ80ao2M K1vthAg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The "ubsan.h" file was missed in the creation of the UBSAN section. Add
it.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..5acac5887889 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22653,6 +22653,7 @@ F:	include/linux/ubsan.h
 F:	lib/Kconfig.ubsan
 F:	lib/test_ubsan.c
 F:	lib/ubsan.c
+F:	lib/ubsan.h
 F:	scripts/Makefile.ubsan
 K:	\bARCH_HAS_UBSAN\b
 
-- 
2.34.1


