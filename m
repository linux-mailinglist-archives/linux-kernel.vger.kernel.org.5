Return-Path: <linux-kernel+bounces-34493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFAC837CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B130B1C23ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B43315CD4D;
	Tue, 23 Jan 2024 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lf8yIIY7"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26B15B31C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969756; cv=none; b=Rbp/UVqdvVaHfjeeVGJikZds+xjN/pdIrTC8v1SeZEBHcNeDSyr2FAR4y3RuxHA2BQGoPY6Q9DqsovznIlFFuUlV2OVorklxvsy/GtkQ5q3COuDpIvFo+qmNEow+fM3yj5d+REhVRrACtk82wTuxl4FebrbCttqy7uAitLVJyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969756; c=relaxed/simple;
	bh=6qOMhh3G8d7Y+vBH+FchTOnAwDno8ofs9WTRkK8e+v0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mOHIOr9DeYplsbpowvofocHc/uf5cYB8Z3+8RoFYdkD/sHClfhRaNJ6FWvDh9kSLFMQgpw3f4G0LdauSE2JvDEebfcNzz1dMA4I5QJekoo1QZ1r7Py3g65dNpLGXpY4HdKFMelfOBrmuuBuyCBne4r+eIkhFF27DpMFJXsQewRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lf8yIIY7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d75c97ea6aso8724385ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969754; x=1706574554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNWz3k2XvGRlF46qJEs9zgm+bcxMnCT9t6UFjEF9Av0=;
        b=Lf8yIIY7UiKA8mjS+9c1rETlaPqJOr0a7m4eiX7x9aENpkNdmL6Mdmq/6c13fzphO9
         oHyRJjy6djzQ/ucVuY1+opqOoRIRvZVTXVznvdMEvDq6hdlNuucuBOvJ/hzcj0oVgEzc
         c56yKPFVG893PTC/qbEJGxDbq0NCt1KHdE2Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969754; x=1706574554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNWz3k2XvGRlF46qJEs9zgm+bcxMnCT9t6UFjEF9Av0=;
        b=SCu8h2qNxBG9WXvYblFhmSdV0t+iKgFJW9A/JS5T7a3L3Txb0acGZ1k1HhzBymyDQL
         cc1PNl1Ypdameunlp5WSDxbimIjiIjPBwAq1BUg82k5gNjE8NYizV8JHumnYXdRTY/ZI
         QU2yMLBx8RhHES+CwjxByQoVG9ZXON21C+b9/D57t7ILW4P1Yalc311NcWOAA+lkmpHR
         2KEBLEhXY/imD8nv7HvVsKtb0qxCuA+vECrlCnqLH3RmOwym0iGRf1XKU9Ptbc60e15+
         ktYMpjAi0Bi4x0ywrTi3+sxiIki4CjPfJbymBsO1xuZKT2CLalpJRKLTc86twG38cLPv
         BrIA==
X-Gm-Message-State: AOJu0YwUmOQua29RTSeYfJRFwQRHt6oWBZe4eRDONEpUMkAiobUgViFe
	ZUnYQQ15Rte2SkutV08Rq6edSU9CP1AlwJkbZ77f2W3POpZTPaIPYbO6+UTcOw==
X-Google-Smtp-Source: AGHT+IGk12zskdqlbqb5d9/uS1ti1uac3FysGuFpOh6Y0g8EhOVnqrhzaYTVMUmTV/zjIhj9HOnRUA==
X-Received: by 2002:a17:902:76c8:b0:1d4:52f6:e046 with SMTP id j8-20020a17090276c800b001d452f6e046mr4743580plt.58.1705969754414;
        Mon, 22 Jan 2024 16:29:14 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902f21400b001d74ca3a89asm2622159plc.293.2024.01.22.16.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:08 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 55/82] kasan: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:30 -0800
Message-Id: <20240123002814.1396804-55-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2504; i=keescook@chromium.org;
 h=from:subject; bh=6qOMhh3G8d7Y+vBH+FchTOnAwDno8ofs9WTRkK8e+v0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgJb7T0nkCbfHMK37KL55oiDeDfmOiEx7q5q
 XThjlEKQk+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICQAKCRCJcvTf3G3A
 JoqqEACE/4PoGFKLHpVkenKHgiwQeIuxCim9QWJGC+MdId7RYwearFTzkOQl8zglCUIZNl7fW9d
 KYyBu2j590qTJ3ins8G5kTpojs3DwiSG7NIjlDCuYemtfGOEDj4muFXpG5DpNNB/SXKfge3xXDy
 5WYmb/fU/J7+bo64TYtiSNKLR2K8Gp8i7ImUFx3yHYAWZufYCVg181wkAjQdVE9QDYyvZ7sGJoD
 mZvg2FSl8NJ5gNh6/n8lFHjoebiowaqz9rHfRIb9H0ruQMkeqFkKXhx4aTH16qMPf0eWME+Y+7J
 ogiYkcB141OqPEDQ2iR46G4NeG4lrsoMCZKzlBhmUT7RxPtYuZcvsCqZSAzAa3UF1RWmwdNOHWT
 QKCM3+s+mU5c7hXehiPzTXpwMMhUbnuW9WVWuFQzVH5K8RvofBCN7bnZZCKdDAoEN9Cc/sKYxEr
 q/BRzB2azJPyZ7AETk4B2xCLsuXEYrgz4hMVtO0QV6idTMpfIjNn4IgVm1nNoQUli5kyJqdcnf8
 gpz7+LeZbIwoIm4heS/k35pUDdcJOIRgPHC9zHqEIgxOE5/Jcu/+iMwplKoCiC7xP29btiDDmns
 OugXywD0SNhQjOaJt1krhL+j3HJZvwk7kx1o6FV+/GJoBK7sRO3WFjkmaJ8winj+Z4BPzvkMYuJ +inWzkA20S9t7Pg==
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
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/kasan/generic.c | 2 +-
 mm/kasan/sw_tags.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index df6627f62402..f9bc29ae09bd 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -171,7 +171,7 @@ static __always_inline bool check_region_inline(const void *addr,
 	if (unlikely(size == 0))
 		return true;
 
-	if (unlikely(addr + size < addr))
+	if (unlikely(add_would_overflow(addr, size)))
 		return !kasan_report(addr, size, write, ret_ip);
 
 	if (unlikely(!addr_has_metadata(addr)))
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 220b5d4c6876..79a3bbd66c32 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -80,7 +80,7 @@ bool kasan_check_range(const void *addr, size_t size, bool write,
 	if (unlikely(size == 0))
 		return true;
 
-	if (unlikely(addr + size < addr))
+	if (unlikely(add_would_overflow(addr, size)))
 		return !kasan_report(addr, size, write, ret_ip);
 
 	tag = get_tag((const void *)addr);
-- 
2.34.1


