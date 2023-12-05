Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5843B8050FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345028AbjLEKqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346542AbjLEKqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:46:05 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB39CE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:46:10 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso24725681fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701773168; x=1702377968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=izNq30yZOvNNZwGOaMHX1vwLLUveCfNwr6iLqBb8tH0=;
        b=Avzd5itIydUCHBi2+Qzh6VyaCQ1Nna3w5QzJELAJ5P2uIvjOUfivv8CV6lP6XdbcI3
         8y2y0W+Vts913ETpl2m2UfrIdtfBDFgtZHCGbBVOmaLTEWxs6U4bn94vKNv1diAM+4FT
         qwXlVGXbpTssS1Wdz0PlJLMCLb3PmF4XUZ61ixpzcHU7557YjHp4cjlbabwGY+vy9+in
         Okivo7iASIts+NVU5rftre+Di1l1erimrx199AIG7d10SXi37m5lLIRyFWLJpSIW3npO
         hXMBBO4q3zMv/Ne3Pfgcph0jVhI7LcQ5VqFxLXI4DOM/qa4djEBfQuNgR6DE4e2m7fhG
         k6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701773168; x=1702377968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izNq30yZOvNNZwGOaMHX1vwLLUveCfNwr6iLqBb8tH0=;
        b=eRozAirpmvrXZIQE8C5vSRI+zba+QNHlAuL/3DCKGfvkrxPv4YPHyT5nSaUSPMCxJN
         cWtMpoFmiX9Lp+b+Ac141mHZJk988JMhOzny1uOTlSYydOW1tZPgiiLEL1fTyZ/oj8ek
         gv/+On3WFfQdvvZsrNw+pnHgs8VTDkMHzpnGwyMjBZGJXYTgylwabT76yVPkBjD4+fNP
         cGv8nBdfY00WRYTIJaK/GvJcY7WZQgJcTVgQprDbmDo1tWdU1pNFaogcogdDSjzVL+EA
         RZDCE5RVq5ZIBSYk1ghYecgWFDoDWjnCcdf6lNdVaYgzNWLd7UWFz2R3W0X8Py2d3K4N
         SRqA==
X-Gm-Message-State: AOJu0YwLgjGBCCOQBWHv7gw5q4R5n7JfR3nMgvg6NdpFihRqnIB40k4A
        YSq9yWpAmR+7ebhHbW87qOQyiw==
X-Google-Smtp-Source: AGHT+IFO3X/tUoCunOv30KWUPHRPySrj5zZYCL+Fh3EBH/SWO0KG/fXGN1LnUai0yuUD+9nm7U7plQ==
X-Received: by 2002:a2e:82c3:0:b0:2c9:f7e9:6e96 with SMTP id n3-20020a2e82c3000000b002c9f7e96e96mr2189064ljh.17.1701773168241;
        Tue, 05 Dec 2023 02:46:08 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:4988:9c5:5b9:1020])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709062b8700b00a1aad4d92dbsm3813613ejg.123.2023.12.05.02.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:46:07 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH] kconfig: Use KCONFIG_CONFIG instead of .config
Date:   Tue,  5 Dec 2023 11:45:59 +0100
Message-ID: <20231205104559.2017320-1-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using a custom location for kernel config files this merge config
command fails as it doesn't use the configuration set with
KCONFIG_CONFIG.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---

Notes:
    Hi,
    
    This patch helps me to merge_configs with config files that are not
    .config (set by using KCONFIG_CONFIG=<PATH>). I am not sure if I break
    something with that change.
    
    I didn't add any stable kernels as this is a kernel config issue and no
    bug in the kernel code itself.
    
    Best,
    Markus

 scripts/kconfig/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 4eee155121a8..106159e75d40 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -99,7 +99,7 @@ config-fragments = $(call configfiles,$@)
 
 %.config: $(obj)/conf
 	$(if $(config-fragments),, $(error $@ fragment does not exists on this architecture))
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m .config $(config-fragments)
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m $(KCONFIG_CONFIG) $(config-fragments)
 	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
 PHONY += tinyconfig
-- 
2.43.0

