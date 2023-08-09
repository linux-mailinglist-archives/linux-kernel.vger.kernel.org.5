Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A7A7761AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjHINvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjHINvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:51:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98712106
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:51:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-268299d5d9fso3604600a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691589078; x=1692193878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8zD96bw4rkncguyqlSPtv0gB2rgXdSIasM/kJ2Pb24=;
        b=Dxbp2YMn7sEEInQkq3Tx3bNagvXpt51+BczEsYwWdT4h8B5cSftkC0XtHfDYAH0/ND
         jBpYPBHSCCAoV2bu3BiweHCvfH+Mc514Dwc1B0vXXbVboRfRmYsawGlJi9eECwZAgF2e
         aV9POh06RhXEIm3jLfHDBpXKeM0Jy8s8LpwNDAYdTWkxYYh3sNy/ycHvABG0AoE6WiuM
         5qWH32aJERfsumUVzLLBTManicMF7gHyJ+LMEOBi+mWokJ0/EnGJUFnaaSQvEURCPfpY
         rKFHLOyAZFZkr/xpM2sYkmBte/3qwLrhgZgltS+0voR81ELbQBfSrd1CE/rFOY3FHCTY
         QHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691589078; x=1692193878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8zD96bw4rkncguyqlSPtv0gB2rgXdSIasM/kJ2Pb24=;
        b=kIMXJ1Rshhes1fZ7oNjtMbx7VGMjQXqITTZDH4rqMW3Q+EHx9fI9ZL/5LzqugqmcCJ
         XtYE63wCv3SQoKFKChPTH1jW4RqGE7UZaKW6Ekv5TwVF0f9p4fedwZhouzxKwl73xE6I
         vvkfDmmpm+p0syzny6f+ynftqJC3q6H9UZmQiN5AdBjUvVUDmDXWcQuE46DWpwC2FMlv
         NhCtzqJmseQeXiZvXL1DU7kufi4bQ+WYvLj7A4gykwS5LvCHC6dgTuZWWJmZteCleji/
         PDWWR5Y4o2drsHSmA166WQm1JgU5bFMSb7fkYjBzA4yVql6zM7TEYJKwE5MA0525qQ5J
         j07A==
X-Gm-Message-State: AOJu0Yw+QmsjRaORljPmB/OcEnSlVbmPJBfWPXfdt/S+WVPeRcQBeslc
        FjHvh2BPsaOalJdt9jtbOSB5QQ==
X-Google-Smtp-Source: AGHT+IHYcoVWEhh4an7XhURJt/MotBxsKv0tKy0BQcpQiO1VXx695G6yZqnzgZHHjn3G5lU5gk+Q9Q==
X-Received: by 2002:a17:90b:3444:b0:268:c569:f2af with SMTP id lj4-20020a17090b344400b00268c569f2afmr2005669pjb.7.1691589078233;
        Wed, 09 Aug 2023 06:51:18 -0700 (PDT)
Received: from work.. (1-161-169-231.dynamic-ip.hinet.net. [1.161.169.231])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090a284c00b00262ca945cecsm1542677pjf.54.2023.08.09.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:51:17 -0700 (PDT)
From:   Nick Hu <nick.hu@sifive.com>
To:     nick.hu@sifive.com, zong.li@sifive.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2 1/1] serial: sifive: Add suspend and resume operations
Date:   Wed,  9 Aug 2023 21:50:42 +0800
Message-Id: <20230809135042.2443350-2-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809135042.2443350-1-nick.hu@sifive.com>
References: <20230809135042.2443350-1-nick.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the Sifive Uart is not used as the wake up source, suspend the uart
before the system enter the suspend state to prevent it woken up by
unexpected uart interrupt. Resume the uart once the system woken up.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/tty/serial/sifive.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index a19db49327e2..939dd351a058 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -1022,6 +1022,23 @@ static int sifive_serial_remove(struct platform_device *dev)
 	return 0;
 }
 
+static int sifive_serial_suspend(struct device *dev)
+{
+	struct sifive_serial_port *ssp = dev_get_drvdata(dev);
+
+	return uart_suspend_port(&sifive_serial_uart_driver, &ssp->port);
+}
+
+static int sifive_serial_resume(struct device *dev)
+{
+	struct sifive_serial_port *ssp = dev_get_drvdata(dev);
+
+	return uart_resume_port(&sifive_serial_uart_driver, &ssp->port);
+}
+
+DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops, sifive_serial_suspend,
+			 sifive_serial_resume);
+
 static const struct of_device_id sifive_serial_of_match[] = {
 	{ .compatible = "sifive,fu540-c000-uart0" },
 	{ .compatible = "sifive,uart0" },
@@ -1034,6 +1051,7 @@ static struct platform_driver sifive_serial_platform_driver = {
 	.remove		= sifive_serial_remove,
 	.driver		= {
 		.name	= SIFIVE_SERIAL_NAME,
+		.pm = pm_sleep_ptr(&sifive_uart_pm_ops),
 		.of_match_table = of_match_ptr(sifive_serial_of_match),
 	},
 };
-- 
2.34.1

