Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0387EB82B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjKNVIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjKNVIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:08:15 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A891C8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:08:10 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41cd97d7272so36683681cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699996089; x=1700600889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uci5Rd8hU8lrREOeKMYxmj/9fXU4uXy75tEQ4ik3o2A=;
        b=l0xNgb/0CoujKqf7eP6AWhYcZUS1d+z9jkyJm4Ec/F0kZ7S037aBuyaIKfcw9RmWTX
         cc76G8MeKvzxhnyJR0Tw73r2QuDEGMwD374RsMmlj7/fdOIA0LdctVP1utzAgVqZxCih
         P6MZ4cvhOx9aZZgnxpOT72ulyZqaVZnwoZh2xyC/hWwBQQJJ+987pg0qdr/NdTiQpg8z
         fcjlPCr7jgcdTRETlvAI0dZ61Dbf6zWIQOEnbgwKGja0bw/KXMOrjPEzGBiyIzqdGuXH
         c/teHU5nI7NUIWvG9vxxViv/k8vmh3DL0Jd/SLeqrLrkkLH434em2xw90QTKW/GBXsyD
         A83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996089; x=1700600889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uci5Rd8hU8lrREOeKMYxmj/9fXU4uXy75tEQ4ik3o2A=;
        b=uSL6okhOH9CTFwangp8WFandCqyjimDo9bZgjZ9UOXvqs/pMEe6N70bs8FQycIZYXB
         07woBkoLRCQJnzmnS2RVZTRMVyAeEw6ZWQPSOVckXYs2R0LbdIkCfG0ZXT4hWkgVdQDX
         Ckc2oyl199JhHcyYNXNTQIfaKjvhE9v0r6f/MUAzOZDJ2dBIRSExmOGDYjST2iNiTfeL
         ILJvtPVo5Og4yM7mPRVJwyvjoE3HLKezAlsf4Jo5Oy2vnZfbW6MYXLUeAp/ttAH2ed3C
         7NeHE1CcP6RBiMwb8R/Phtya/89MpVT/EdE/JopICO2D2fXOhwXx55CbRcjorGY+qpD4
         pVBg==
X-Gm-Message-State: AOJu0Yz2lE4iGZxZwJqRrR7C8s2pYVHuWOYd4SaTELZJ2tm26VLzvHp3
        1zS0zq0136De0QlUsrOcMlkE0Q==
X-Google-Smtp-Source: AGHT+IELtqGcseH9KGtg5Xky3bC4PfTr1MH+ebRmkZREUQ7jadX9iY5D5h/57CmyMzuvsnZQd+4kcg==
X-Received: by 2002:a05:622a:1ba2:b0:418:1059:dfb9 with SMTP id bp34-20020a05622a1ba200b004181059dfb9mr3732919qtb.1.1699996089212;
        Tue, 14 Nov 2023 13:08:09 -0800 (PST)
Received: from [127.0.1.1] ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id x16-20020ac85390000000b004198d026be6sm3027549qtp.35.2023.11.14.13.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:08:08 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Tue, 14 Nov 2023 16:07:56 -0500
Subject: [PATCH v6 2/7] mmc: sdhci: add __sdhci_execute_tuning() to header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-th1520-mmc-v6-2-3273c661a571@baylibre.com>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
In-Reply-To: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699996085; l=2108;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=vV7D9g0JyI+aykknduEYFaEeV4K8xwyLfp1qBkgVUvA=;
 b=s3dUn2Hh07UVvYFGxNma4xcng0hYj7RWmtp2h1rfXLw99h7dYdaL/Q4EakZFW3TOJ0DyhdBUC
 ig7y03po7UOAsJW3fKAM449ixnj2l7tl2CDRB9Y2jlFoxPYweKmd06/
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose __sdhci_execute_tuning() so that it can be called from the
mmc host controller drivers.

In the sdhci-of-dwcmshc driver, sdhci_dwcmshc_th1520_ops sets
platform_execute_tuning to th1520_execute_tuning(). That function has
to manipulate phy registers before tuning can be performed. To avoid
copying the code verbatim from __sdhci_execute_tuning() into
th1520_execute_tuning(), make it possible for __sdhci_execute_tuning()
to be called from sdhci-of-dwcmshc.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ff41aa56564e..c79f73459915 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2841,7 +2841,7 @@ void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 }
 EXPORT_SYMBOL_GPL(sdhci_send_tuning);
 
-static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
+int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	int i;
 
@@ -2879,6 +2879,7 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 	sdhci_reset_tuning(host);
 	return -EAGAIN;
 }
+EXPORT_SYMBOL_GPL(__sdhci_execute_tuning);
 
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f219bdea8f28..a20864fc0641 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -793,6 +793,7 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
+int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);

-- 
2.34.1

