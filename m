Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA23E75FEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGXSVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGXSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:21:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4DD10D9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:21:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666edfc50deso3006171b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690222899; x=1690827699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QEUjvqdRzTdfDkwicizCwRYFy04Vl/AY1lqkB/hOCjo=;
        b=br9RkcEvcXtV0Fil4emk4TsED2K9yy2SzHENve3KeNHExIgHdCbjnC7ECrSJxbGkss
         IXu/FL0dtAPTyX3fc7pdybmCRarz1i585iMUk1BPPvhaZtAAwZE6uEFtx5yd9Vh43MS+
         432ztBbXleTVkWeyoX3Tc3juGLyr7Sb6cq4iVADmVSRKoKkB0zHB8x35QWgNX9xNYfMM
         iRPJzwjK/0KUEdZYXxkCea0gHJx2VNoJDgjKMVnNmKsTnG7gwEdLiujzmsl3xuwSzBDe
         ObPIjRoN8rYKPf+nV1MFbUloIZSKjqx8Q8355INOVgvYkZgMHKXccf4hCxYtfyygE+bf
         PMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690222899; x=1690827699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEUjvqdRzTdfDkwicizCwRYFy04Vl/AY1lqkB/hOCjo=;
        b=OSqHV5ASI/fN9xx2vQSqHO14o0ZOg7Y0XWbQt8Ai5kHQtrjeP0lCj1XDSDEoUIEzVL
         IOGGQ5smygOgUWV/mAYvepA6TjvzAuOU1eCMJM8jEl9bD/HVw1OQUsLJCUM6L6WKNDb5
         zBVGjQMqyLHfze2BHsXunjZCtEx3rKdTV6RfgXPXnw8RoEtTMdice2XQza82eBf9RNmY
         CKByXSirzqa3aVEKqIwPtRGX+7Z7db/IjEN6QHKWG2i6mc9nurm7UHQrsbdZ0yxU9/3i
         4VYE9iYnm4+KtUdzyMmGQc63tcXmVbY1y8pVUMJC5rrv0FEz8UjCaC/2EN9KqpeoRsah
         rDIA==
X-Gm-Message-State: ABy/qLYTsDLMMwq+0PLHp/e2FaQdKfm7iinqo/DMfAPobXMh/6lLDPld
        RnfDzKx7kcOso3movRaBJZ7wxg==
X-Google-Smtp-Source: APBJJlGkIVhru3kteceAqIxz/2TdYmq94CKwcauG2anD7zgAdek+sul734EOBuPyGbjhwmrL16qKyA==
X-Received: by 2002:a05:6a20:6a11:b0:12e:caac:f263 with SMTP id p17-20020a056a206a1100b0012ecaacf263mr13293078pzk.20.1690222899380;
        Mon, 24 Jul 2023 11:21:39 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:b55a:eeb0:a3a8:248e])
        by smtp.gmail.com with ESMTPSA id g20-20020a62e314000000b00682b2044149sm8007620pfh.4.2023.07.24.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 11:21:39 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Drew Fustini <dfustini@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: change TH1520 files to dual license
Date:   Mon, 24 Jul 2023 11:21:29 -0700
Message-Id: <20230724182129.843687-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the SPDX-License-Identifier for dual license of GPL-2.0 OR MIT.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi | 2 +-
 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts      | 2 +-
 arch/riscv/boot/dts/thead/th1520.dtsi                  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Jisheng Zhang and Guo Ren - I thought I would post this patch based on
the discussion in the thread about the BeagleV Ahead patches.

Message-ID:
20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com

Thanks,
Drew

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index 4b0249ac710f..a802ab110429 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
  */
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
index a1248b2ee3a3..9a3884a73e13 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
  */
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 56a73134b49e..ce708183b6f6 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) 2021 Alibaba Group Holding Limited.
  * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
-- 
2.34.1

