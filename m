Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C71E80AC8B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574629AbjLHS7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjLHS7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:59:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABE310C4;
        Fri,  8 Dec 2023 10:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GYqIcq7k1BexZ75pZaJri8Df3+NwQa4Ekej7E/CCgjQ=; b=Dgk6lOT66iX0YgA4niOMVPOTpa
        37QOONyoOP/+OtqgLeWrfCzDhgx6r2gwA6gn+7fJNB5M5KNVs4f1rEUd42XxqKzF+mMBwP8ZPYwwH
        0vARyyjnMUb3mNlIthEmOtW2DjokEuq4dL4ZKDW0evsFnB9URLRrXAheq97aRx9lPDcRDQcG7Oit8
        mkjapYQWJQ1TuDccghs4LknQvTwCCN1q3SiotMtK1NDKgZzz6eRQQWaFDn5JQgj6jA9OCq5qLmedX
        4nhS0P8d3OvGnVspHA6/satXbg1sKDjAGB/ckfP0Gl4MiblHNJtSbK7vGCTMPfq8RM2LMZ2oJlQky
        RHW2k14w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rBg4N-00GLbH-3D;
        Fri, 08 Dec 2023 18:59:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH -next] spi: mpc52xx: explicitly include linux/platform_device.h
Date:   Fri,  8 Dec 2023 10:59:27 -0800
Message-ID: <20231208185927.14124-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since linux/of_platform.h had included linux/platform_device.h
and since that inclusion was removed, this driver now needs to include
the latter header file explicitly to prevent build errors:

drivers/spi/spi-mpc52xx.c: In function 'mpc52xx_spi_probe':
drivers/spi/spi-mpc52xx.c:396:20: error: invalid use of undefined type 'struct platform_device'

and more like that.

Fixes: 0d18bcdebb2f ("of: Stop circularly including of_device.h and of_platform.h")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
---
 drivers/spi/spi-mpc52xx.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 
 #include <asm/time.h>
 #include <asm/mpc52xx.h>
