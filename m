Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825FA7A1A48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjIOJVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjIOJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:30 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771D51FD4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:18 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so30564231fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769676; x=1695374476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0f8HYWIP8RQszKUCt76U7MT1CQn8pw64XBqFbFs3p8=;
        b=GzG+AiI9F3ZPWv9UYjBKu54PB7wdgO1D2RQ6B2s+tjXiYhYs+Xd71yZ/JpG+06XDNv
         MQxGKZ6EkGZWNEHZhLnk5G5uzpevGZ+ngcwstSHx18/fKbeaN4Asc6NC9uFi8jeGrzud
         5LYgbCx0mi6748YhoQb+FtqZXdjhJOumJLpOs37WXgIuSUbUAqvFV/hdbsH05FRdRvPS
         d4mGFOtYlCTSHaKCR1gCchjBS2TrBMJeFx9Iunp3fDi/MtSnKrnQV9ZRjcZYLH2q92wb
         Rzqg8KfvJHk0bKzVb3nnisbdv5VdxzawH4xOPID0DlxP2sXlM5jJXZGJGr+JIcse1Jrb
         4qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769676; x=1695374476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0f8HYWIP8RQszKUCt76U7MT1CQn8pw64XBqFbFs3p8=;
        b=sMVQr3wJWFeCjsdeXp7x+bc2E4caQo/JzJAKLbJEf8Yi/e0V+BmHw/JSwIAsXStH9b
         fleG542WxyX713XB3rWTNHYmrDkAuItZH9e9aPltwM2SHyeBJd+mgs8UnvmM90k+pebq
         bI7U3FY41GOJ/FHTgfyZ3zS0yARa3pS/VpUfrNy17h4QeknliwG+VPTc81H3Iz5nB3aj
         zdXn8YkFyNQi9zESb/JzRqOJ9+BvTjvgQMwXNBxTW+YA9QKfgBI9+CXskua0Om54eYrW
         WoVia19woUTnPCAG4PaSxNkggh8yN6pHA7aouhL6saMJRpoUh5Zogbm2KeFea92c0QwF
         OV2Q==
X-Gm-Message-State: AOJu0YzXtbnZ0SDtJdmMUDLhADTC8Th/6khGmeODzMyrhmhxJr0H0QNW
        OTzmxmuY8/mbaxDR7EEPw0XOjQ==
X-Google-Smtp-Source: AGHT+IF3jn2rX7BSo7/mQIQtEFNNUVozn4k4rgi9dwjpA3yU2noJTaFIESdGvNZ9WGO5sODrVSbXSw==
X-Received: by 2002:a2e:8912:0:b0:2bb:b56b:f67e with SMTP id d18-20020a2e8912000000b002bbb56bf67emr1014952lji.19.1694769676813;
        Fri, 15 Sep 2023 02:21:16 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:16 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-actions@lists.infradead.org
Subject: [PATCH v2 02/17] pmdomain: actions: Move Kconfig file to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:19:48 +0200
Message-Id: <20230915092003.658361-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915092003.658361-1-ulf.hansson@linaro.org>
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig belongs closer to the corresponding implementation, hence let's
move it from the soc subsystem to the pmdomain subsystem.

Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: <linux-actions@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                               | 2 +-
 drivers/pmdomain/Kconfig                  | 2 ++
 drivers/{soc => pmdomain}/actions/Kconfig | 0
 drivers/soc/Kconfig                       | 1 -
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename drivers/{soc => pmdomain}/actions/Kconfig (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1c34484c9b2..6b491ebcf790 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1788,7 +1788,7 @@ F:	drivers/irqchip/irq-owl-sirq.c
 F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/net/ethernet/actions/
 F:	drivers/pinctrl/actions/*
-F:	drivers/soc/actions/
+F:	drivers/pmdomain/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/dt-bindings/reset/actions,*
 F:	include/linux/soc/actions/
diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index ac77cf4271a7..e410c4b8071a 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "PM Domains"
 
+source "drivers/pmdomain/actions/Kconfig"
+
 endmenu
diff --git a/drivers/soc/actions/Kconfig b/drivers/pmdomain/actions/Kconfig
similarity index 100%
rename from drivers/soc/actions/Kconfig
rename to drivers/pmdomain/actions/Kconfig
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index d21e75d69294..8b46da40f107 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "SOC (System On Chip) specific Drivers"
 
-source "drivers/soc/actions/Kconfig"
 source "drivers/soc/amlogic/Kconfig"
 source "drivers/soc/apple/Kconfig"
 source "drivers/soc/aspeed/Kconfig"
-- 
2.34.1

