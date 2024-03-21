Return-Path: <linux-kernel+bounces-110406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02223885ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D68B25266
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618518592F;
	Thu, 21 Mar 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgoxSTtT"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066BA24A11
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039633; cv=none; b=l+t/kxiWyGazaAX9iOv06zHPshpJBWI95bGXgBw3hwuXT8cyPzJdbALYRpLxuyVRONoibC6WFy9djudVqE5xgF0iorSvbraRXBDV60qRNzaAedVzXkIxCympvhM494/0fQtOvcSKw2ra6HATAjuUZUmYR3Zl/2n2m37CRxnpoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039633; c=relaxed/simple;
	bh=6hQb+5MC6V7N8F2R3h2eh5BgzYqYZcc5K1Let0XcNHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4gFngqiWpH80eD0Zxb/ytOi/fqn4qSM96B0atjVKbzxqwXEM2Sn2OnaXicyUVHsadOHQAUr6gs2RTTG7lzuypJUx++MR0pYzrz1TY+ZfB9ErpnZ0t0larCTBHBFG5gcSsdISvg5+ih5Vb4W79QQfIvOVR3yP61mUJU6rA/uPuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgoxSTtT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41400a9844aso13656005e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711039630; x=1711644430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zBjb7t6MjmNwbN/X8h6EXbiMXQqTy5/eHrgGpuiEnNU=;
        b=RgoxSTtTXXyNXrnYk9FoaFx1r6bbEKFI5z9mfEnyhG+b16fyaekXSFlQYX7VZfPA0a
         lkyjutTlZ7KjrgAdrzxLHyhaV79fWUQu2db/OmHfyPXYMEOWgUoz7XGuN9NFhk4zr/Co
         JEwvtpXSVZOkYdivKhleawut/UjPeFE36QOARRQt0YGDZFVqIOoKJ/W6Nf0fIDzucOxq
         tOutYLFmTzhAWjCbocZxbR9C2GoXheh9w/EzQWkoLpgMkV2gZS2xDI/vb5qEAwj2dNHK
         0DOr/NDvL0gHoSuHdNHBVggvL/utWK4B3IM9gnQEN/acTcnen9S3tXtHB2pLYpZCrHvw
         guug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039630; x=1711644430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBjb7t6MjmNwbN/X8h6EXbiMXQqTy5/eHrgGpuiEnNU=;
        b=RsZee5yAdV+mZgT2/MnRcW8vySX/F4pitsO9RVBMSUfpYKoQLCPyvpTqMWnicr2CiI
         zG1Ck5kqZdU7V14KHL2Vx4qoPKNvlrnO1L7DotmHR3OWatF87nWEhHVmCe/Tt7+MTOoi
         sT5IHCBjMOytXspfW/Dmk/oM38dtbcVqOmR1qE5dZPOTbERjxyoejZ0bD3rKjfPMS2hM
         sOhPuyE6DrrbMv3edZE2ROrcpsVuOHgXxn8vbg+X1OqnoDcUllGwhAfroLkszUxtFoxs
         M0DQVwJW1tEEQ1N9tcyoyk6aIOu/LxPhPV6cxy2EcaLp6aGzXvEu7VkJH8dAlTef9cSv
         j5sw==
X-Forwarded-Encrypted: i=1; AJvYcCVXsHTIpkpSeIQkk7y8zf+AFVIRJfhCW51bcjjJgM7Ae+yGGTwETAQiVi+H297YdNCrFDb2v/Wi1GpwnT1QZfj8V+W2U6lX17nVOCRk
X-Gm-Message-State: AOJu0YzK2+BSk6NVtqs+dKmmrP7xRN5NuxBhUWcJM+9f6jhRYP9Ra9vA
	8bcno1s9qPViA42OCKqXlif8etsA/jFeIuQbpRoL5Y1lmiEu/x9s
X-Google-Smtp-Source: AGHT+IHLe3dSyU8kpr4d/IwcJOFAsOV6Tv7VXJSRasKUnNGu8lgrs6zh7e39UxePQ7/LPpNSBQDSWw==
X-Received: by 2002:a05:600c:444b:b0:414:5e9b:804b with SMTP id v11-20020a05600c444b00b004145e9b804bmr3205770wmn.10.1711039630166;
        Thu, 21 Mar 2024 09:47:10 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0041401eb021asm277697wmq.24.2024.03.21.09.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 09:47:09 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH -tip] x86/percpu: Enable named address spaces for GCC 9.1+
Date: Thu, 21 Mar 2024 17:46:41 +0100
Message-ID: <20240321164647.289879-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable named address spaces also for GCC 9, GCC 10 and GCC 11
releases. These compilers all produce kernel images that boot
without problems.

GCC_VERSION cutoff is arbitrary. It is primary a risk-reduction
cutoff, older compilers will be tested and enabled in linux 6.10
release.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 09455d93b947..03c9d1100f09 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2433,7 +2433,7 @@ source "kernel/livepatch/Kconfig"
 endmenu
 
 config CC_HAS_NAMED_AS
-	def_bool CC_IS_GCC && GCC_VERSION >= 120100
+	def_bool CC_IS_GCC && GCC_VERSION >= 90100
 
 config CC_HAS_NAMED_AS_FIXED_ASAN
 	def_bool CC_IS_GCC && GCC_VERSION >= 130300
-- 
2.42.0


