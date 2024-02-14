Return-Path: <linux-kernel+bounces-65891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A4085536B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C763A1F22198
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28BC13DB8C;
	Wed, 14 Feb 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D8xuBx7I"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98F7E767
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939969; cv=none; b=ckcy5KLpRLHP9unlRNDEnQQ3WMAxdQ+j7YZ0wzDevG26DHe0uefltw8IppE2HoEZUaZvrR3Tj6mISVAJIxQ5o5FiB8vnx4ltoMVuP54J/1wtD7md/1KsHxkCdvH/9snlqNvbOgRTReC3uQQ2NAjpYFpEFEKJSv//JyvQCeYVark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939969; c=relaxed/simple;
	bh=uQwFw+Mvb5FS+5R3O7Kh53oqRz4mjeatqrTjC8hEZtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FAZqtf708+4OoO2DGQUN4EjR686qE/99g7SqJ3IYBcuULOIYworQAq+20zwb6S/6nbjoSFc1y1YmaQwN7NY1b8Pc1eiBg4OYrrEKNKII6KmSvS2a1gwXfHTRoDbOXHRKJnDFOrAdCDSaS1R4gcMsEvNE12zSvaUbPlESDv6PA5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D8xuBx7I; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-296e8c8d218so130903a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707939966; x=1708544766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQAKDqTR0lInodj89i/VDK6/vi1P72VYaaN3v1N7SL0=;
        b=D8xuBx7I48V/7OH6w4xZnEVtQbXRC3j0733USZL7WMhODA5jIUVts65t01IL2BY1YW
         Oewqdf+mEgrWBtiA7ENKCnz7Q9HXYiWYsMgDneRW3PaKjOnA+Rm4DkkuqieGSBcdEcqA
         AELFNBNXNt59AARNxYSfIkNgOTxholfTyljuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939966; x=1708544766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQAKDqTR0lInodj89i/VDK6/vi1P72VYaaN3v1N7SL0=;
        b=enZMwA82/Oo0B/F6A/p3hoqpEQI50LbfG/jCSC8UemgDHASnpRVEB1trVYgZfGiz76
         5h+VLSOhHfF4Rni2tC/Us1gnLYyUy16/kfjfYdmjcXsZjW8SfWgjAMJTxwxbCMRHh5FH
         mMVOEVEuYaAloqT6S0hFw6L6mmryHw3gkAMjM5dNOsEqAXmrblemnRogtm+nUuMa4rsI
         uGIEVL29NsA/v98yPE/ID9IxMWHdmq/g/h8W6c+9caTmhVwdE/eFAfejibXnDuV6mpxP
         nqU+pYV1fnLjPb26rfGvqNPXJGTnGLOeXF0EvTvKa/zNj9DVTk6b3HqyC2UZieKwbR3f
         DkHg==
X-Forwarded-Encrypted: i=1; AJvYcCXSBFz79410uonoaqqH3R3lVej542pmGKmNA86saeD1VEw6aBfQuTBGlKixjVAU/TfQNF/MuX1D2J0LlF8yzeUJYZ4F/o3kViMfU12u
X-Gm-Message-State: AOJu0YwraUVRbqyVcvxmQwI6ua6sJOkPibgMHtnzhTNoHxK3qBkoXWRS
	Br+SawdfoZmvdrDki+J37xILGgww922c2z0bNacg9LKsP3Dd6lh35Xuf1F1qsw==
X-Google-Smtp-Source: AGHT+IF9qlzQklsSyZNtmLwxche6bOfOb3xCXDfoNNolp4ROMfcVflxY1nID27Av2N8l3L+CYXzzZg==
X-Received: by 2002:a17:90a:c204:b0:296:e2bf:3936 with SMTP id e4-20020a17090ac20400b00296e2bf3936mr3585859pjt.36.1707939966221;
        Wed, 14 Feb 2024 11:46:06 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a34c600b00298b9f662ccsm2035619pjf.1.2024.02.14.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:46:05 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v7 0/3] overflow: Introduce wrapping helpers
Date: Wed, 14 Feb 2024 11:46:00 -0800
Message-Id: <20240214194432.makes.837-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=keescook@chromium.org;
 h=from:subject:message-id; bh=uQwFw+Mvb5FS+5R3O7Kh53oqRz4mjeatqrTjC8hEZtQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlzRh7JItobawvLT4rE2d1cpdHERzHGwXC9I9xs
 qRALXG1AQSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc0YewAKCRCJcvTf3G3A
 JhrrEACQsJK01x9xNqIWqiN+g7wsA5PyZYBoCWe2XUFapCLB759/GdDKBEKBcOJLG45k2wkbClT
 ImuFShGbsHTl146bYDt+tB05yrXftONqA2LJ4PO88nB+0Y8vhYjobHFU41qPz0ga5E5Dcv/7RpB
 1Rl0vZ5gNzI50wj0G8/f2sb1MYCn+b2zcFbbL2mowb87QmXk8GYNsGxVxWkX4QpDWIx+5hwtUeD
 JQ6heHQ4X1MtO5XLu3c755Wc/OhRBR1ery6Gj4fjZVX2+up4rv9Jjqzz9Bil9M00+rBUjjMS9CS
 bjSX0twnUU3vicu5H/18FPuYE0hoG5t0UMtabOtaKWFfl5P63QS1aJwR6tjh7vi9dOuz7zYkrdy
 Ylrnr2sRbU+XlvilOVJiC45SNabbgBIugLp+3tVTt5WARekcIEKEzG9y2klvWErdKSQneNaIqOL
 D2RVGimkB1Pcc95fKDWRN0J9xiChzvjy4GS/dLpcIT/uD6TfGnc1Dg+AaHcdhYIDQXsSNKLe8WW
 DmsGg5ISbmZrIDEhxttKAjxG5eheHZ5SPW67FSXFiAcahYfV1uwvu7HnZb6KFivGz/PZNTUmNbp
 nwxqFLc52D28c6stg0+IbBh8zrtIAWOLkSjrU5mMSIexoPyujbeatubSBQKbeStf9oZ2JJhCvt7
 vFL0ycE knLSqdrg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

v7: - further kern-doc cleanups (Mark)
v6: https://lore.kernel.org/all/20240213220844.it.345-kees@kernel.org/
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

 include/linux/overflow.h | 101 ++++++++++++++++++++++++++++++++++-----
 lib/overflow_kunit.c     |  67 ++++++++++++++++++++++++--
 2 files changed, 152 insertions(+), 16 deletions(-)

-- 
2.34.1


