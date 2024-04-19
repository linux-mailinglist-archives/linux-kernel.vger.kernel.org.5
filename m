Return-Path: <linux-kernel+bounces-151781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559B38AB3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D9A1C215A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CF91369B6;
	Fri, 19 Apr 2024 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXavZ0qh"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72A28F0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545558; cv=none; b=mpcZV2Z2vBJpTxBTowf6b6+CU4vXaijPfQGSsdYs1/8EfkGHVT1g5Qt4Aie+LaDWd+L+Tio41DCRHF4QWsFbUlpMTnGoVZl+BD/obQVnv7DsCKJgNYINeDMA0RQ0Vfd49W5AJz5PDXPYidS0YpV1OLQ9LRFW09MXBa6y8RNL3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545558; c=relaxed/simple;
	bh=vy6aezxOC3efJW/mWXA5YwJTZpDnfjFujpe4G+C4xoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qoDi4FbkTcWWtIl1wTBzVkD7XQt/QSHDcTdartN79/pwp1PenVK2Q/z1lu2XsKo51yc+BcOAugl1NR8LSYsSsjc3dca/PxYRn7FFhxiGtgpDhKRGV/c8NnMxr57RRd/LB0+42542XAlsh83gixyyzU37HzueGSUECBfcTxcQREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXavZ0qh; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6a05f376effso7080126d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713545556; x=1714150356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKzIHJYCP22vx3azSLi3FHmio6HmCt0i5WdVlerY350=;
        b=UXavZ0qh1hQ3Olu6nyGkYNNvYS9x6aXp9lKEx3LC8HYhoYs4mThDRbvCh0bjrxfQAO
         e6zBKSfTJVmmNLDdvvwRHvQS2MPa7VdjRZUwK+qUUhIK+xxO5ZweN0D/tdLEOrodx5fZ
         mbIDDea/1Es78VI5g4tyXbvT36EU21JKRXNFb1mCgl/bqNKDP0CjdPaR5tyKjfv/gB5l
         WNJoaTN68nxZZLkP1YLAmE5fCIRJN2bLwka7LsFbwW7CwKgDXNnHwy7WKEFrBfIVK4dw
         qHSOAdqPHWPZpscOXRxlfVz8tQMMjOm45q9dyIeQ3pAUVhBQxfoOJy4wHzTZ/avfORmx
         B5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545556; x=1714150356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKzIHJYCP22vx3azSLi3FHmio6HmCt0i5WdVlerY350=;
        b=PvhN09tBdNtJnRJ2PWsQbU6GlIPudW/mweyvo4G3+2D8bc4gChqu73ZVOUGtD9+uvC
         Idflm8ag+eY0HsuKLr+0bg5iAniVkSDIfTcL84/A3TgNx/Fo4a5EfmbCJE7CqKLfaNj1
         W8gkCV9KZ/KTv8inLeKJeJ3Dikhg+i/IACCNIq9NP2nBfDDfnRLF9+829kqxs9msjbj3
         kEPbiy+yptwvt+bYsZTszuJxyjLKebxPMDSNvuggfQkRazJWX4GNmMk7eooUxludQC5f
         a1JC0/SNT4sp8U+TTdYd7rpNwB7i44h5TfxUE5S11qM0hef+AistyYyGmdrTwlfuY7vl
         zGkQ==
X-Gm-Message-State: AOJu0YxTg2vg3xRx5yPpn2fLW/gQkaSZNM9aRBXkoUhl2E4xHF9HLIqg
	Np9N44WGGj4YtD6y1lWK5v0Mtq1pwRa+eQInGu3cdKZGMkqtlXufsf4W
X-Google-Smtp-Source: AGHT+IGByohxFi5T8ZwBpAfW/j4AJ/tas0L7ySTnYpBymjEvzG+NIKIHrIYwE25n+G8TuFu4Ek303w==
X-Received: by 2002:a0c:ef81:0:b0:69b:5410:df8d with SMTP id w1-20020a0cef81000000b0069b5410df8dmr2648923qvr.41.1713545555900;
        Fri, 19 Apr 2024 09:52:35 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id g6-20020a0cdf06000000b0069f1c071f1csm1682224qvl.29.2024.04.19.09.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:52:35 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] x86/smp: Remove dead call to switch_gdt_and_percpu_base()
Date: Fri, 19 Apr 2024 12:52:24 -0400
Message-ID: <20240419165224.73859-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smpboot.c is only built when CONFIG_SMP is set, so the call to
switch_gdt_and_percpu_base() is dead code.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/smpboot.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a58109583c47..f752047688ab 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1128,12 +1128,6 @@ void arch_thaw_secondary_cpus_end(void)
  */
 void __init native_smp_prepare_boot_cpu(void)
 {
-	int me = smp_processor_id();
-
-	/* SMP handles this from setup_per_cpu_areas() */
-	if (!IS_ENABLED(CONFIG_SMP))
-		switch_gdt_and_percpu_base(me);
-
 	native_pv_lock_init();
 }
 

base-commit: 7fcd76de8a7bc12e930ef383a157ce99d711715d
-- 
2.44.0


