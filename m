Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B625767F7E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjG2Nns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjG2Nnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:43:45 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E40CA;
        Sat, 29 Jul 2023 06:43:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so1875697b3a.1;
        Sat, 29 Jul 2023 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638224; x=1691243024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciRtavySnNRvWTW6m7wEJWbFm9H9lBrob3UvT53cbMk=;
        b=nQppanP04bpL78aHtwk1eGvNfRWZnpKI/wcyk/hpyZilHwhTYZ/Mp3bsffodBPnY/m
         QwAZ4xIlBDpFY68+f1thPtpcaQk5lqoUX0qZ/rKhGHGzuogHZ1McSYpaRbL4f4Fg2NLE
         CESDbuzG1wzM0sW4BCJYmjdPalpPugdKxYxL8EuMSC4oT2DJHxNT5ZcWtJekXtqhMuVD
         C2tbh67s5vfg2M8AwJZfukSw5fPWhZmfY9Twjiz5dDobR7L5qjd7jETfNRCG3m20/2Um
         Iyx8785xGqCAXTL5p9FZl7RIYK1Jy5G3vRedE4kcVNUm/SeaeioPQRs7mHoSWym/dVMX
         l2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638224; x=1691243024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciRtavySnNRvWTW6m7wEJWbFm9H9lBrob3UvT53cbMk=;
        b=UA4rX+8D43m42g7qA0cp8jmct/yqCGP2Z6AdytjSZ1o6Uh8Xci/xt4rljA8it8O1yZ
         eMF29vPOgFrkn76jHURO9q1dkJ7c4eWZ1Vifa5JyS3l17nP8nqsd2B3qaonrjjf/2Q4F
         v+l5EXMrq6jr1S7qVjxT32GiVa0baseJdxpYUuwjE8nudmlIKm1fIqCFtGy272k+LfSm
         19yvljWfQuJT5nmGvs5vWvEKoX4hkGLyMzoHIBVt+0rIwFWnb6xqBVGUnmrpEpGdHeg4
         RQSz3sE7NfBJJTAEyDGRsSvkDQvjHWIWQWVGY6ey+/Gnf39HNHD5YMqr7A103DKLxeN9
         bKNg==
X-Gm-Message-State: ABy/qLYA/N/uWvtmhv43SSZg5cQE4ZE+Vsr/9B6+gDth+NbHNSqDOrLL
        ctZEDgSwexdv3nFD0esaey7FD0520hAojg==
X-Google-Smtp-Source: APBJJlF40wdlIg/tigMeWMnK/tFt1/h8qhJAN6iwnB3fddXB2wcs4Vp9DN2T4rSME4rncXtJORk+yg==
X-Received: by 2002:a05:6a00:17a8:b0:64d:42b9:6895 with SMTP id s40-20020a056a0017a800b0064d42b96895mr6959015pfg.5.1690638223992;
        Sat, 29 Jul 2023 06:43:43 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:43:43 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 02/17] MIPS: Modify the Loongson1 PRID_REV
Date:   Sat, 29 Jul 2023 21:43:03 +0800
Message-Id: <20230729134318.1694467-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because LS1B and LS1C share the same PRID,
it's reasonable to rename their PRID_REVs to PRID_REV_LOONGSON1.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/include/asm/cpu.h  | 3 +--
 arch/mips/kernel/cpu-probe.c | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index ecb9854cb432..4163b22c0a9a 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -248,8 +248,7 @@
 #define PRID_REV_VR4181A		0x0070	/* Same as VR4122 */
 #define PRID_REV_VR4130			0x0080
 #define PRID_REV_34K_V1_0_2		0x0022
-#define PRID_REV_LOONGSON1B		0x0020
-#define PRID_REV_LOONGSON1C		0x0020	/* Same as Loongson-1B */
+#define PRID_REV_LOONGSON1		0x0020
 #define PRID_REV_LOONGSON2E		0x0002
 #define PRID_REV_LOONGSON2F		0x0003
 #define PRID_REV_LOONGSON2K_R1_0	0x0000
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b406d8bfb15a..a5ec05f719ab 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1287,14 +1287,14 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		set_cpu_asid_mask(c, MIPS_ENTRYHI_ASID);
 		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		break;
-	case PRID_IMP_LOONGSON_32:  /* Loongson-1 */
+	case PRID_IMP_LOONGSON_32:
 		decode_configs(c);
 
 		c->cputype = CPU_LOONGSON32;
 
 		switch (c->processor_id & PRID_REV_MASK) {
-		case PRID_REV_LOONGSON1B:
-			__cpu_name[cpu] = "Loongson 1B";
+		case PRID_REV_LOONGSON1:
+			__cpu_name[cpu] = "ICT Loongson-1";
 			break;
 		}
 
-- 
2.39.2

