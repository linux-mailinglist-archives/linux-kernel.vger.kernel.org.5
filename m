Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BFC78427B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjHVNxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjHVNxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:53:09 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41554199;
        Tue, 22 Aug 2023 06:53:06 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a8586813cfso395787b6e.0;
        Tue, 22 Aug 2023 06:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692712385; x=1693317185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUAyNhHHjj0WcujVEsYxPFAUzDk5eBXvhPo6SFEKtaM=;
        b=Rla/dJXVNy4uTzBAu3nCj7VODrKHI563p/wJFaZ3Rs/CfTGruLwyZDlLGV3dlep4eT
         +jAZqUbM9AS+nE7lODPJELB+px+vtnwleuVzIn8+PHMzhXFvHzIh/aVVUsFMoa47TLk3
         zEa4ocoK8iIb7voVM+1FBptozhARvj29V9WSdFdyCyghUiE1Uk/v20OCuYi28XjOWhPs
         lEZbQlH0iiKWd0WB1fV5IS1kl6tSGUkzf+7EUVHxx0B+gg5c7VbW8HnDBcmVFeCRaB5t
         83e7WslSCgKGB+vov6YaYsUe6CR/AgpJpbbNY3b+gWyCv4h20HhtuTURdIMBzzE+86jd
         hKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692712385; x=1693317185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUAyNhHHjj0WcujVEsYxPFAUzDk5eBXvhPo6SFEKtaM=;
        b=XUQPsCoRo4J7ZNf83rmFFgQvV1XZnKPtokGnUVVJP7gKA/5e5uh34IJGoZi0Tnsn1t
         k5RZpA8e/kdcQoWpMTwBaM8XnTZ1n8ikILGmaWUOjl2sYw8+vnG1+8VwSOHBbTBV6+5e
         ocLalsMUwhybsnMmXWNhKsk1N1CdVnfdzCr4lPlXl5aa+Ok/5pKtfs29Vrqq4brwCLqt
         36sOPW8hg+aTQro7CyRfmOmny0XHGcnCS9d+3A4v77TaSWPdLi0Dz4VDLSECLehNYrPt
         5MtDjRhyPnaIAxZKWE3061FF5LLHaVtZcVPh98AH7D/pzJD4ZpkVM207JdS+B0RGxb/q
         oLrA==
X-Gm-Message-State: AOJu0YyQ9ZiO57KGjhqIqU5rJ6rn1iHcuQSEtkpRXdMHJeZezcHkLV9P
        evVjLxQPpBTL8XSceN55cEOFfX1wRPE=
X-Google-Smtp-Source: AGHT+IFDwo4GyAD2+fH758iGqG52sn5UaBOzMqbh53vVy44JtfDbxgZKT39kzyFx58/7IRbNEikNaQ==
X-Received: by 2002:a05:6808:2e99:b0:3a8:4311:3d6e with SMTP id gt25-20020a0568082e9900b003a843113d6emr10645925oib.2.1692712385356;
        Tue, 22 Aug 2023 06:53:05 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:dfef:4d99:c082:3e8c])
        by smtp.gmail.com with ESMTPSA id n3-20020a0568080a0300b003a463ded3a3sm4773166oij.53.2023.08.22.06.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:53:04 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     linux@roeck-us.net
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] watchdog: imx2_wdt: Improve dev_crit() message
Date:   Tue, 22 Aug 2023 10:52:55 -0300
Message-Id: <20230822135255.1013981-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

After issuing a "poweroff" command the board goes through the
expected power-off sequence and turns it off completely:

systemd-shutdown[1]: Powering off.
imx2-wdt 30280000.watchdog: Device shutdown: Expect reboot!
reboot: Power down

The "Expect reboot!" message is misleading because in the
power-off case, no reboot is expected to happen at all.

Avoid the confusion by removing the "Expect reboot!" message.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/watchdog/imx2_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 1a27665a2f53..42e8ffae18dd 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -374,7 +374,7 @@ static void imx2_wdt_shutdown(struct platform_device *pdev)
 		 */
 		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
 		imx2_wdt_ping(wdog);
-		dev_crit(&pdev->dev, "Device shutdown: Expect reboot!\n");
+		dev_crit(&pdev->dev, "Device shutdown.\n");
 	}
 }
 
-- 
2.34.1

