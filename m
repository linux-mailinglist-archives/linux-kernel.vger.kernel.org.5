Return-Path: <linux-kernel+bounces-116904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ABC88A4FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAEF1F3708D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BFE131BB5;
	Mon, 25 Mar 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNQmhMTm"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCD131BB8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364496; cv=none; b=V61aN6VTZOhRHOR67hEp4M/SfwPfVrK8fU0XJgS4T4KuTVv1xr12/pbw+OQ+G7l4IEqsO1G1q8juze5GZGXh8hrTgFLQKIUXPEXD9Tehjbpk7pPw2tp9jZVUCEO25CDx2BXMYrZ3zU+c8tt2SPMN1oswW2HNad+CsN/cCr4Xnm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364496; c=relaxed/simple;
	bh=w+tFws1Bi1xV3hntGpTyALeY+3d+ukcMl4+G4jlt5Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERAaqYV15Te8yDZ6UR4NBRexKY7yI3dsOjJZw5Sw2wZtFgiNhr8UC+Lov+HQFW39E9vnSi36XHOGqnUe1Oc4Ws7FBV2gcLpifoMJ7RhUFht9KPAQQ3FkQ3ZNhJ7rYjieje24+6T9epEi7B5J7Co37J3g6gLgbPd9KMbF8tSM39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNQmhMTm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c0d1bddc1so1018069a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711364492; x=1711969292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zToQ2s3VZ1f9ao1pi2MnYEMv2dwpUwcL76sBj0wUmpc=;
        b=GNQmhMTm3SDKGbKL0NDUCTWaoxlTgYWa1r1FQGkpHxLgS2eULuUNyXHPf1fRwna42c
         SBGJYqoMN0Qju9isQbLxvOJQAAIbgIcRTSmlZNpZsTOaXf2edilFl0n1waMte4b6zZYP
         zhJqwsBJd+SiytEkZ5NOkK8BpcE6lIRaPsqWokJGS5o0Tt1+V99wL+rr+Jbrcg8b8V/v
         5pMmjr9Dg9skE4/QcLIneKQrm45XeQbRKXpYfY8ugzB83PrGwmh0Ykys5p+/33CB1ISW
         wBdtv1Xf+U7XkIhlXubDNe/s2MmX8iSBi+B5bqihs3XHUAt+6v9u4puVyO/pz1wvGAb5
         3Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364492; x=1711969292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zToQ2s3VZ1f9ao1pi2MnYEMv2dwpUwcL76sBj0wUmpc=;
        b=fn1SaLhY4Qe8cP9cVHwX4sZ/2YORaJLuBnD5TbTjAnmgmrWmbRxBwyymw52O0wXjWF
         peVI7nWs2OEFylmm2iWQVHwimsw2m66uU1WagRlIGDuTlkBm9tsmZEjEmsodu4CkYjOe
         tFTtA26StSqxi4V8l+GePxv1JYLzSztPMIoSN32TRJdPecwzCynMGpCZBpQ0JmVZJEA/
         k/VvKdwJIj8NNzQzE+bXKhAcScz2+12bTVLA3Y76pCwO3eCGYs6s7fmbM0wUqwAFAYoX
         fju+6dseX8+kR/eAtTYsHM1h2yBCmtNuaMcokmFNDAd0oGfu5gMJiMxdLIKq5IwLH0D+
         X8Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVwvraVBd2NsQJGpCYmgoQDPZiYhQ2jFO3zi3iVFqbvY2V6Ounce7T0Hokx+pqXx8HJLNLedxkbwMpeubzwiAlrM+wZ9c3JQ3+NJMQ2
X-Gm-Message-State: AOJu0YxkFxARpRrPzr05i6RVEOwk2R/8aOdlv7LCWzTM4dH76RSt2weu
	oYzSeNelFse+SC9xBVU1UX3iKcuHzh9ZpoxGVDCl/IbkXQTaP9MU75EFDJSe7aN4Ng==
X-Google-Smtp-Source: AGHT+IHiPDCwvlzf2VtcAn3yr7PW/gRpWwYiJT0EbMof00PUJPWFxJ95qrebJTL4OYsS3Upd4MXIow==
X-Received: by 2002:a50:9341:0:b0:566:e3c7:921f with SMTP id n1-20020a509341000000b00566e3c7921fmr5580729eda.22.1711364491654;
        Mon, 25 Mar 2024 04:01:31 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id y17-20020aa7c251000000b00569a2f698d7sm2891787edo.49.2024.03.25.04.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:01:31 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	kernel test robot <oliver.sang@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/percpu: Disable named address spaces for KCSAN
Date: Mon, 25 Mar 2024 12:01:09 +0100
Message-ID: <20240325110128.615933-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-fsanitize=thread (KCSAN) is at the moment incompatible
with named address spaces in a similar way as KASAN -
see GCC PR sanitizer/111736:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111736

The patch disables named address spaces with KCSAN.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>

Closes: https://lore.kernel.org/oe-lkp/202403251658.8e92a8bc-lkp@intel.com
---
 arch/x86/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39886bab943a..4fff6ed46e90 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2439,6 +2439,8 @@ config USE_X86_SEG_SUPPORT
 	# with named address spaces - see GCC PR sanitizer/111736.
 	#
 	depends on !KASAN
+	# -fsanitize=thread (KCSAN) is also incompatible.
+	depends on !KCSAN
 
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)
-- 
2.44.0


