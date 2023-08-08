Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ACF774332
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjHHR6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjHHR60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:58:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0B1C3BEC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:26:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-56433b18551so3509298a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691511966; x=1692116766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQFUtOqa2Nuhn55ogQXJygZpI6oY6Vmrz17l7AHTGDA=;
        b=F3706irnCSu2+LNU7v78iqqJf8mD2eEkHIAU87U84StncQZ78FIU2CS9X7yI+jym2h
         xt1l//2Tg6ow5KDICKM8k+IVr72p0ST84q0c+eoeG3rwgTM0/HWNcpSbzeKvS1IYMfKY
         eYqOf3CXqIUoUsatdNdJ+qKsPKXVEpfnTMw1X2d1+D5QoMlkitjcWIJ+VByk05Dooq+Q
         6aVXAC5yNUnXPWjeDZWiAkjpQNJntKpje0U8DaXsYsGZfa8FOVqo6snGOJewAxszKCvZ
         y3si8UuQusvg3Hm27hW9hdxBsFSw0hyWaoGsBCDZheiMnUO94kBw97/LhMw8PDGWuC03
         iNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511966; x=1692116766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQFUtOqa2Nuhn55ogQXJygZpI6oY6Vmrz17l7AHTGDA=;
        b=BSeI7/oLSZ4CC+B9CYwJSG8C4IC8ZG3bNkVupi7ARQB9EGdls6e+ooOidNHSlcZ3M/
         ikhTnrdjgLwJPPPr8+gwCGfVBdqajywD6WFkv7fH7bKX52Vo4yUTqfA0qvHkDOTFPq+m
         FXCgzFUe3D8klD/XGDHt7Q5F+4DSnmpDercY5lCTuMXRCLTHqrXjSABtIrjbbBLxtvZW
         2gTXJ5bZqbwVE1dDtxaNDM7pjNAlLOL8vVxPw+Enxy0xFi+qYy624cY9XFBs+nUlwjBc
         M5Wq2lKzslpZaHHc8/IpdDr4azTgeC0541tMMqN4FHLak4xmGS31wzW6wxvhrtU9Tm2K
         Im4g==
X-Gm-Message-State: AOJu0YwV12c6ql/l4MMrGcVs193XrtdurQ7ceUZWcqLZLe1/4Tw7uBHb
        S6U7iGh1OfMTgvK3Ajq0crAgVtXMDcKBNGnib9Wy4g==
X-Google-Smtp-Source: AGHT+IFn9Tv/1Wua6tBM7YiRpsrFK5gtBkXS5hRzWJuEds2zGjCrzk2Zh5O6jxInrCtOG/wLVGM/yg==
X-Received: by 2002:a17:902:c20d:b0:1bb:9bc8:d22d with SMTP id 13-20020a170902c20d00b001bb9bc8d22dmr9696186pll.16.1691479591137;
        Tue, 08 Aug 2023 00:26:31 -0700 (PDT)
Received: from work.. (1-161-169-231.dynamic-ip.hinet.net. [1.161.169.231])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b001bb24cb9a40sm8357436pli.39.2023.08.08.00.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 00:26:30 -0700 (PDT)
From:   Nick Hu <nick.hu@sifive.com>
To:     nick.hu@sifive.com, zong.li@sifive.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/2] serial: sifive: Add suspend and resume operations
Date:   Tue,  8 Aug 2023 15:26:25 +0800
Message-Id: <20230808072625.2109564-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the Sifive Uart is not used as the wake up source, suspend the uart
before the system enter the suspend state to prevent it woken up by
unexpected uart interrupt. Resume the uart once the system woken up.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/tty/serial/sifive.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index a19db49327e2..87994cb69007 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -1022,6 +1022,31 @@ static int sifive_serial_remove(struct platform_device *dev)
 	return 0;
 }
 
+static int sifive_serial_suspend(struct device *dev)
+{
+	int ret = 0;
+	struct sifive_serial_port *ssp = dev_get_drvdata(dev);
+
+	if (ssp && ssp->port.type != PORT_UNKNOWN)
+		ret = uart_suspend_port(&sifive_serial_uart_driver, &ssp->port);
+
+	return ret;
+}
+
+static int sifive_serial_resume(struct device *dev)
+{
+	int ret = 0;
+	struct sifive_serial_port *ssp = dev_get_drvdata(dev);
+
+	if (ssp && ssp->port.type != PORT_UNKNOWN)
+		ret = uart_resume_port(&sifive_serial_uart_driver, &ssp->port);
+
+	return ret;
+}
+
+DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops, sifive_serial_suspend,
+			 sifive_serial_resume);
+
 static const struct of_device_id sifive_serial_of_match[] = {
 	{ .compatible = "sifive,fu540-c000-uart0" },
 	{ .compatible = "sifive,uart0" },
@@ -1034,6 +1059,7 @@ static struct platform_driver sifive_serial_platform_driver = {
 	.remove		= sifive_serial_remove,
 	.driver		= {
 		.name	= SIFIVE_SERIAL_NAME,
+		.pm = pm_sleep_ptr(&sifive_uart_pm_ops),
 		.of_match_table = of_match_ptr(sifive_serial_of_match),
 	},
 };
-- 
2.34.1

