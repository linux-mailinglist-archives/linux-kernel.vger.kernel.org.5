Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42F479C471
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjILDxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbjILDw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:52:56 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C540F9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 20:52:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-563f8e8a53dso3659805a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 20:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694490772; x=1695095572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5oCh29dNG53YPBrevCBLLA7b+PR4G3Y0Y/glnMTMB+s=;
        b=bihZMKzsVhB6ge+aNPIWjmRdGiNc5JS4OxQgcQgRS8RH8cGw08VeGGLjPAYCK9I80p
         u9PdNb1vOOa2OKJFTG2DPP6VfcEy+Co2P3m2dY0sVNlHQMXtjNY4pQOSRRvutLoQkwCy
         DieM3mHxr0YCmE8zS8+StXd+4LUJzFeafwkzj1hM0j3bPwP0dM+YLrz8yHwN3fnVfmll
         XQlqsC4w+5b4kl+vKb/CbJtOqtFbUa5S3LpZsknjvStdIuixmwaNLshyzsMSxwbiS2Xx
         erC/GO3lWwfNlMmkRpi6w7KKz0hMs+SZG1LtRKZCz+5f1C3DO/hvbpVX87UW5Re8+Xsn
         waKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694490772; x=1695095572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oCh29dNG53YPBrevCBLLA7b+PR4G3Y0Y/glnMTMB+s=;
        b=nFFBXObakBp+ez4tx1CZ0XOlb1KW24dBFPwqmJ6GpssEV9+Y0EJjv7lBajhQIbUO1L
         Bmcu55n+NzFYccBasiqml0bywcVSX+pDW8A4AvAMKqKWR0d09AALddobJ+5/bPjGHApb
         54rSmkqtHIU9y0WhwnvGDdS9sjloVyaJDxV1hO/51IF+rSZmJF0gZvPsVLLV+4YXmHDD
         bDAWayBzTQYfSh0hMWEXoZNSpSX55Ry7qkNTPvF/BbQAWTf4ODSZ8XtBATKsihnUOXam
         sqnX747jkyX/8D/hB2EJgTRLBPKIzBlt1g5mwfqpdi/mbLiS1eTfirRGZm6wMTMpNfKZ
         bDUA==
X-Gm-Message-State: AOJu0YwxApgs3XAPZ4M1UABQi7Qp1jlcilXI7K5dqyDfsuBv0vLDWWXc
        tGE5yNgSRPSu+/0BsZdy+ULJ/g==
X-Google-Smtp-Source: AGHT+IGv7n9Qk8LL95am93uMO7ORRR6YO7G5aEk3DFrxw3mDyN9HG9CEabvmanHSbSJ8lG0wVGdEVA==
X-Received: by 2002:a05:6a20:3d82:b0:13d:bf07:7444 with SMTP id s2-20020a056a203d8200b0013dbf077444mr11879280pzi.0.1694490771834;
        Mon, 11 Sep 2023 20:52:51 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id pc16-20020a17090b3b9000b0026d4100e0e8sm6343923pjb.10.2023.09.11.20.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 20:52:51 -0700 (PDT)
From:   "guojinhui.liam" <guojinhui.liam@bytedance.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     lizefan.x@bytedance.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "guojinhui.liam" <guojinhui.liam@bytedance.com>
Subject: [PATCH] arm64: cpufeature: Expose the real mpidr value to EL0
Date:   Tue, 12 Sep 2023 11:52:09 +0800
Message-Id: <20230912035209.1687-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In EL0, it can get the register midr's value to distinguish vendor.
But it won't return real value of the register mpidr by using mrs
in EL0. The register mpidr's value is useful to obtain the cpu
topology information.

In some scenarios, the task scheduling in userspace can be
optimized with CPU Die information.

Signed-off-by: guojinhui.liam <guojinhui.liam@bytedance.com>
---
 arch/arm64/include/asm/sysreg.h | 3 ---
 arch/arm64/kernel/cpufeature.c  | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 38296579a4fd..1885857c8a22 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -901,9 +901,6 @@
 #define SYS_TFSR_EL1_TF0	(UL(1) << SYS_TFSR_EL1_TF0_SHIFT)
 #define SYS_TFSR_EL1_TF1	(UL(1) << SYS_TFSR_EL1_TF1_SHIFT)
 
-/* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
-#define SYS_MPIDR_SAFE_VAL	(BIT(31))
-
 #define TRFCR_ELx_TS_SHIFT		5
 #define TRFCR_ELx_TS_MASK		((0x3UL) << TRFCR_ELx_TS_SHIFT)
 #define TRFCR_ELx_TS_VIRTUAL		((0x1UL) << TRFCR_ELx_TS_SHIFT)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b018ae12ff5f..6e18597fdcc3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3450,7 +3450,7 @@ static inline int emulate_id_reg(u32 id, u64 *valp)
 		*valp = read_cpuid_id();
 		break;
 	case SYS_MPIDR_EL1:
-		*valp = SYS_MPIDR_SAFE_VAL;
+		*valp = read_cpuid_mpidr();
 		break;
 	case SYS_REVIDR_EL1:
 		/* IMPLEMENTATION DEFINED values are emulated with 0 */
-- 
2.20.1

