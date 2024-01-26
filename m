Return-Path: <linux-kernel+bounces-40279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F283DD81
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229981C21200
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2D1CF9A;
	Fri, 26 Jan 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AkwGDV6p"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3406D1C68A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282945; cv=none; b=Go1PmVGkBJOxYzfmydHvfazfxzKXiK7tKDvOcn9pVZxk4CXqXE3cYIQjGnCfT//M+A0Ft/9qdpvN3YH+AJaf7YPHZiM76P2K2uFZ5qnWOSuly3vNcjzKXcZu7G9TRWpPSdJfZQqTQGt8wZeQTh5LRJeDdNJkD2/Fet0HMvKRKuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282945; c=relaxed/simple;
	bh=IDmnKs4KXoXn6lftKlwke8vXRewjXDmMhjWvV+QJ43s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZOyh/ubmQQEHibK/FZjks0XGpjI/6Uo3ZSUhxM0fTLqJjpEOPHDpI8H+TYAEr04UMJDYJNQPMi/OP/+TTMc/0tfDrqI3Lg8DTgL5RksimCUP1/MVkf2Y8/x2X/3ZMMy4QkmoCxpETzFPpaPPwMae9D73pFXY9EECy935vJEuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AkwGDV6p; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so1288148b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706282943; x=1706887743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KDpycj0twAw6yoH+p28gix4mRkksTB474idsqfyTR5s=;
        b=AkwGDV6pCk1LRoKnWrfbYT0iKc34uG2d66T19JFCa55N9TVRuNf1Ty3lrhPY/jfAm2
         ZaWYpzzJ3+AKEYQ2CLVAGoffiTogA4EXH68Yd/+Ut0NTh4TWSiiGKlRL3VyX6/jPzS0C
         Xsr9ERns2ucePSn1vIDOIUP1nEHRRDd769kSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706282943; x=1706887743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDpycj0twAw6yoH+p28gix4mRkksTB474idsqfyTR5s=;
        b=TZS6ARlRUR/L/BST+xFLyNDFaXJIcnFiph36PIVda8VT+wSIKsvAdi1IX/ph3bMozZ
         hX2KJw4R1xguzQCkxt3gdXs9Ela7/Gu3yo5CVgd6LT4dcSwwDao5sGz0yIC61hJdBRMc
         TezDgfviz4uAGRAkJ3qRdAcEPs84Knbqcgfo2j4x0YmL7bbXPAVJlUvXAEwOjfVfn6bK
         ywwYGEwQOnt3fJBR0yrKSB2vGOioTbCNE1Mrw9FlCxqJT1rDA5ZLyK1glKrbJSus8gLP
         e+W06qf9VkE2ol78mLChnBcmUa/2uGQZda+GCF1IkPKGZno2XO+JxmsXogT4cOOOfhD8
         bmNQ==
X-Gm-Message-State: AOJu0YzdgkIGsFO2XnpXewyDgbBzQY7u+0T8xdmyDEA2NBeqREno6FId
	7SA4L814v/sdpOgs0j0pPxheoeFN/zonhjnHakHm8Syn5oUj+BeqjEVLA+oeBg==
X-Google-Smtp-Source: AGHT+IG9pu4dsuIMBVO6D7n+zRLG5fIhHfaJd6I9yFebEFRnTlFuxUM1X0By2myfJg9j4+BgP2aNAg==
X-Received: by 2002:a05:6a00:c92:b0:6dd:c0a5:3f2e with SMTP id a18-20020a056a000c9200b006ddc0a53f2emr1456979pfv.25.1706282943253;
        Fri, 26 Jan 2024 07:29:03 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:8218:45d8:d8fe:f7f2])
        by smtp.gmail.com with ESMTPSA id a22-20020a62d416000000b006d9be279432sm1267169pfh.2.2024.01.26.07.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:29:02 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Kees Cook <keescook@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lkdtm/bugs: In lkdtm_HUNG_TASK() use BUG(), not BUG_ON(1)
Date: Fri, 26 Jan 2024 07:28:53 -0800
Message-ID: <20240126072852.1.Ib065e528a8620474a72f15baa2feead1f3d89865@changeid>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit edb6538da3df ("lkdtm/bugs: Adjust lkdtm_HUNG_TASK() to avoid
tail call optimization") we marked lkdtm_HUNG_TASK() as
__noreturn. The compiler gets unhappy if it thinks a __noreturn
function might return, so there's a BUG_ON(1) at the end. Any human
can see that the function won't return and the compiler can figure
that out too. Except when it can't.

The MIPS architecture defines HAVE_ARCH_BUG_ON and defines its own
version of BUG_ON(). The MIPS version of BUG_ON() is not a macro but
is instead an inline function. Apparently this prevents the compiler
from realizing that the condition to BUG_ON() is constant and that the
function will never return.

Let's change the BUG_ON(1) to just BUG(), which it should have been to
begin with. The only reason I used BUG_ON(1) to begin with was because
I was used to using WARN_ON(1) when writing test code and WARN() and
BUG() are oddly inconsistent in this manner. :-/

Fixes: edb6538da3df ("lkdtm/bugs: Adjust lkdtm_HUNG_TASK() to avoid tail call optimization")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/misc/lkdtm/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index d1222d3eda2f..b92767d6bdd2 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -298,7 +298,7 @@ static void __noreturn lkdtm_HUNG_TASK(void)
 {
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule();
-	BUG_ON(1);
+	BUG();
 }
 
 static volatile unsigned int huge = INT_MAX - 2;
-- 
2.43.0.429.g432eaa2c6b-goog


