Return-Path: <linux-kernel+bounces-34497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24594837CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACFF1F2935F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1CD15DBB2;
	Tue, 23 Jan 2024 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VUAKwByd"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8615CD7E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969761; cv=none; b=KLcQ9dc6Nl8UCys0zj2//SKDfIhYQcXShtibR0Vzkb/GTpSERb+88L0GhMqTkTuqI5tKOjHvFFg0oSefr6wuyNlw8Si69QIwIWEMWxV8ipqYnAscvFmOEbB0RQy6kSrvdFNgxCtKZyVnP85Vm61f7wKm2SbW5dJJ0hVy7XgSITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969761; c=relaxed/simple;
	bh=IYGzuP/zbxp+fClF7wd/omCSj0Nxp5Np0wtMoITSwGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qdyivr44Rc7SQx9MsUM/FXxB8QvxzSRVvtZ/2fW9xaQ3IbfSEkswkhIgO5p0O8dd8gJ/A2GMGxWPpv1b4ua3B9chLvjytuUa5xjlj5FxCTDP3T7oLzh+o4oloDNUug3yVcLbDoGEwpy48f4n3JzicH7LKG6xhAQaSZXFGodTdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VUAKwByd; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1873118a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969758; x=1706574558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQMc6LYHhhvfAhiKIOUC5BbUkraaT6seSDCXTI3gkRA=;
        b=VUAKwBydeDXMX+0O3f3aF3wB1K9OSDyO+3tWQEoOHa2ptgPUdjLlnE2dVMyMj4HnaM
         yFO1rW1srrLz1uIYntxbWZc1HUP+ACkeDLJiw8id/HZKHiJwL2pJ6daHJA53KDlgjET1
         VoADxHxQokHgfmTMZZJZVVGecN4aRm7XqO18o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969758; x=1706574558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQMc6LYHhhvfAhiKIOUC5BbUkraaT6seSDCXTI3gkRA=;
        b=LV7bz0utoFyOta+r5M31U0WrNjD4eRkjs/csFuCeei2IhnbNWuAYoqs39sT4cMLX/G
         79F5gb21Rh0FzaT410CmzhVbV+r++3MPfNdiHkbtvqZsWJxyul9ThfPSr0R8XTbp114u
         7Fj5p3YB3fH0XXOW7lDYQ+81Twh0+PhWGyAeX7GQYYa/0urId/xEzcUK4rXA/kYBnNDh
         1zfv6apz75LvuGXYkdta9P8IGz3DZouc/io5wm7sg4qiVL0wKN4Nv9YLMebF5hj+3av7
         gTHXDOHUnj92k+2UHmZ8rEAbxXleiX3wF0MxvXW4GFqd2jBzO9PYwBoVTdzNS5TKi7us
         LMsA==
X-Gm-Message-State: AOJu0YwlbucC39DGP9jXZO23xFkoOjqcwp6w/Wr6hYUqnRPquz8thGgp
	qgcd4e7G/t1kcfgTtpDOm9uMt7KZAfLpIgnF6Dd7VOIJlaSYQwcIaTyL7dKHBQ==
X-Google-Smtp-Source: AGHT+IEpujyvF8ZBIrjLlmz8z5ihm+ZtEPZnFLaeE9eUMT6Wm7BDVE7X0cfAZ38X01e/nZbuABoGKA==
X-Received: by 2002:a05:6a20:d38e:b0:19b:5c69:cfef with SMTP id iq14-20020a056a20d38e00b0019b5c69cfefmr3286788pzb.12.1705969758648;
        Mon, 22 Jan 2024 16:29:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mp11-20020a170902fd0b00b001d75ea44323sm1403806plb.21.2024.01.22.16.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:14 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jann Horn <jannh@google.com>,
	Ley Foon Tan <ley.foon.tan@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 65/82] nios2: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:40 -0800
Message-Id: <20240123002814.1396804-65-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796; i=keescook@chromium.org;
 h=from:subject; bh=IYGzuP/zbxp+fClF7wd/omCSj0Nxp5Np0wtMoITSwGs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgKMiALMxRVyvOwDduElZdyTxYkqj4GeVA+a
 y3wk6N3AgyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICgAKCRCJcvTf3G3A
 JhCUD/wIVTUQiqiCpHFrR06gPF8QmgTtiayCbewZJyiRbeVMW9KWTSVqZeeS/W4FujOI+kuefUl
 c1iRvHycbTJB+ZegE3DX5fbkBfC6gtwdiSKMuU749fbJ0MEvMeb9mJsjJGWVuyOtRO6EY8034cz
 xXpbMjqbgS9a9IxRFrBpuWh/LwZjHC8Cvoytga/Gh6anYLfvSXRkShgbRdyqy6UJD5dg4yZUz/C
 lgYYsrVhnk7oGPlrHJwfzMRHKTi64faA4BBGAf83/FOkcHMJJXgFJXJoTSsuuvw0nsNGwZR09Kw
 gHNjbedjRX1SFnP11Zy859gKsdZGWFLpVdxgd+10v8Ply5UzSe8jr8boGKRBXAv4001kBg2iD+f
 9GQ/2oqlQ36bbYPJTCCbf3d5oeOB7ZhQYgrJPbKEA9n5IShs+fLviPgmTrszr94BVxrab/1txf7
 QDmlS4I+0dnZTGaX5mPPMkOJNmfVrUt6SiCuTwV+jNjz9mirPTlKWt7RHBXvWg+MBWfr3foA2Jm
 wIwx3GImSqoaVALimD4EI9/xINZY52KGFz/wNuANU/5LFBOr3rp7QZWpYVzH3lHPhvEFjD1kU1F
 xrWkywBh3VHMXGHRTB4XgqsiwnpgoAlN5FNbsJPFpuGIQeReKd5FMPdrTu79eZQ31jpqmDGxlxt WMYUiNesncupVEA==
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
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/nios2/kernel/sys_nios2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nios2/kernel/sys_nios2.c b/arch/nios2/kernel/sys_nios2.c
index b1ca85699952..df53efdc96e3 100644
--- a/arch/nios2/kernel/sys_nios2.c
+++ b/arch/nios2/kernel/sys_nios2.c
@@ -32,7 +32,7 @@ asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len,
 		return -EINVAL;
 
 	/* Check for overflow */
-	if (addr + len < addr)
+	if (add_would_overflow(addr, len))
 		return -EFAULT;
 
 	if (mmap_read_lock_killable(mm))
-- 
2.34.1


