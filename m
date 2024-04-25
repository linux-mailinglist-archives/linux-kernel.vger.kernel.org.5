Return-Path: <linux-kernel+bounces-158299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6068B1E08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AB3284AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A6084D12;
	Thu, 25 Apr 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+d9jwsz"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024FA6BB48
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037348; cv=none; b=Eiz2CKAfKPh+8cRVlQH1t30JTF4On7+fNeRzovRxoJ650eXo4zavdoUGJwZJQC3jQJAm+caX9d4UA0yVks73sdvrGKTQSLAN2nzdrmn1wEXhyhL1mR2hcrJz54i/ZxnekxKiiUyD5zKJ/hQcfrt3oI5XJO/JOgKZz+GtUKphKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037348; c=relaxed/simple;
	bh=bHYLFgsNSpBC5G8LSh4asIkQzCruyTt2NslAboXMSyQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hBQrz+nmdV03Yk8bzZjFFK+uzU4HP3aKd2EXTbwoaIhMnlMRQWM/9vzIknTnfcjOGBvdmg39ih1b+zlAQKdM3XNWNxnU2FBE3gpCbQCBwsvIzbBrILrCqce/t17murelj6u8hCSLbzriEdyT2Ck4i9z0OP8aI43TFu1p8/bDiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+d9jwsz; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5722efee02fso225671a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714037345; x=1714642145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ekXrdxgsgLB9DZfBB9nJ5MWu9x1dRAv+tEq0T2dGKM8=;
        b=b+d9jwsziLhOzHAf1+XAJ+gZEGC0Xnl34ZSh668UijhnHkeBj2Hh6ad+HBAweun0DE
         NMYVYyh2TE3FOH/NLtTg4BgR5SeOhnnBfdnM1HfbtHWG/ZsjwYetn3i8ZpKQqqvPrWXH
         58d4MD8oAgfDYAVbFFFdxdDtJLPv/pIfLfmLZNLdE2OykFXisFptNKRya3Zs6/9mjlRM
         ml22wsi0MIffz7+e2NeYwj5ORyvnInGKzRrmVoKCH87cWlcufiBUQGDGEXyhPI4i3jO+
         EEq/VTidk82Gd2XFHoH3W8mrIN8UJxL4p4BZYQc32kkbvyUWAJtZTsqSl4YIXRrJgwLZ
         rQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714037345; x=1714642145;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekXrdxgsgLB9DZfBB9nJ5MWu9x1dRAv+tEq0T2dGKM8=;
        b=WP/2RnoIbjnsgg6KekvjyAUWG6pVVXtpTzZpABGC3nEU2UnXq7oBvligBsnmRkKGQr
         rLvKyfV0iUTOm8Jvy5cakSizNtjPRM1hi9Ux/9k683HqyJozJ1Nnp6aOQWD788wn+fSj
         xSVnqyljS3CZCau1qll+pULzP7a631L9upYMSYoICYtCys3hWkFupDt2F6w1P7lOVjA5
         KEVPVthPK11aZZ+aWkMGPAcCfGqJuWJAgbUkUkuPcJ5bxDIq/NggU6tSpcnl5vwGDoQ7
         HOriynITqZ2Yq8vufcPCxZoy2hVc8NG13DsGH5RmhAnx+vP/4NIjp3vr/mvk190nMq7C
         vMXA==
X-Forwarded-Encrypted: i=1; AJvYcCXFal8PhceomWsjpwhv79uQx9ku7pzpXT3KRZJpjF7Du4+7nTYGIGMcd0SmvrqfMTaoWOKnB3vI9xEtkJ6IE1AW2NXo/O3XLgIesvW3
X-Gm-Message-State: AOJu0YzrL91u7iGcCZ9kyNEOTSaS4zKW3Kkl3F8t//MRzEV0podRuFIi
	bvgsjPOyPNKAziiXA7Jxn/iYBHO5fVnJAzcxVK2HEGkSNxJU2A7lcIa4yDH46cihE9BumzY2wfy
	z6Q==
X-Google-Smtp-Source: AGHT+IFNZjP+bk0FmJHhFl5v71ayEd4aDoEzYxpx2wokkSCwcAoyPwu91xHwhieZvZjmaOJnU1NI8YHI4JU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:7464:847c:5c22:b888])
 (user=glider job=sendgmr) by 2002:a05:6402:3819:b0:572:308b:f7a1 with SMTP id
 es25-20020a056402381900b00572308bf7a1mr5051edb.4.1714037343991; Thu, 25 Apr
 2024 02:29:03 -0700 (PDT)
Date: Thu, 25 Apr 2024 11:28:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425092859.3370297-1-glider@google.com>
Subject: [PATCH] kmsan: compiler_types: declare __no_sanitize_or_inline
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: elver@google.com, dvyukov@google.com, akpm@linux-foundation.org, 
	ojeda@kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

It turned out that KMSAN instruments READ_ONCE_NOCHECK(), resulting in
false positive reports, because __no_sanitize_or_inline enforced inlining.

Properly declare __no_sanitize_or_inline under __SANITIZE_MEMORY__,
so that it does not inline the annotated function.

Reported-by: syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 include/linux/compiler_types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 0caf354cb94b5..a6a28952836cb 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -278,6 +278,17 @@ struct ftrace_likely_data {
 # define __no_kcsan
 #endif
 
+#ifdef __SANITIZE_MEMORY__
+/*
+ * Similarly to KASAN and KCSAN, KMSAN loses function attributes of inlined
+ * functions, therefore disabling KMSAN checks also requires disabling inlining.
+ *
+ * __no_sanitize_or_inline effectively prevents KMSAN from reporting errors
+ * within the function and marks all its outputs as initialized.
+ */
+# define __no_sanitize_or_inline __no_kmsan_checks notrace __maybe_unused
+#endif
+
 #ifndef __no_sanitize_or_inline
 #define __no_sanitize_or_inline __always_inline
 #endif
-- 
2.44.0.769.g3c40516874-goog


