Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C01876E362
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjHCImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjHCImD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:42:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D346DB0;
        Thu,  3 Aug 2023 01:42:02 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7D645EEA;
        Thu,  3 Aug 2023 10:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691052056;
        bh=X/zAB0Jj0qtm9fUujGG3j4YnlOSerudhleIY+ZFE7Pk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qH1DE64u4YxQCM+dwmrEBINgZ/TmMqlH24BICuVvHn12qvLSOxkSGGIqR9Yglz8vS
         Sdrq0EeescYNU2YxfqFdqhoSWg74ap6eSCvglBOzdxUjkFozQmtRCwJoDfCYGoXr4b
         TkzgtFHLBERyr29hO43Bv94Q1EDORIDSLshTqyg4=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 03 Aug 2023 11:41:39 +0300
Subject: [PATCH 2/2] media: i2c: ds90ub960: Fix PLL config for 1200 MHz CSI
 rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-ub9xx-uninit-vars-v1-2-284a5455260f@ideasonboard.com>
References: <20230803-ub9xx-uninit-vars-v1-0-284a5455260f@ideasonboard.com>
In-Reply-To: <20230803-ub9xx-uninit-vars-v1-0-284a5455260f@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=958;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=X/zAB0Jj0qtm9fUujGG3j4YnlOSerudhleIY+ZFE7Pk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBky2hVH4mzodkwHQDT/qFB0cXR6NAIPQ86YdBFQ
 KAmu7DI6SqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMtoVQAKCRD6PaqMvJYe
 9R2BEACAlP22T4NNeiUW0lczthwN5yziGaJMShZlaAoa/AvhqHDrFqEAMBQVNj40TgcWmf4nZBF
 7lG4B1P7tOKiZC+4iDylMUQXCDd0wEqFfuqhvQ00HxLIZfR5gKnZ8CsufqRmY4a4qJZRVd9JAle
 3Km9ubgxQOA1hNFk2Cgf0lHT0jn+nNKNk0asKXQ2EYJem+JKfvB5Y/C2jKhR3/h++R1hdXcPeg6
 7aHc30rZ6IJ/Rllijgp8kCRXSm2HZzfj5rPM2a6SecNBQyyy5xBQRWUlS/wTRKtoOS64Ovzgsbd
 WRQtoUyfafxDLO4zQ+tt06K7+IIghRS2G7cYqQY3YswpZ7fXt42LXdBvhF/zYhKZIBGRgh1umAs
 PuLAjcldLmgeJx6AsIXu3cJj59HzmHzjLthzr+bRp3KvF6MLaWZJ9nAPDGQtyC0MS9AOFQEHqi3
 lliSJ9jLgmiH6chImqyIcf0LRoDan5m99d3FUuuOvm3tJCagC8Jf7kRwSyUGeEomIYvYTyl4j89
 Bk3JRvVBsw39SfBCT47IO2UeX/jIAvJlO0sJVzaf0zn5CwjUqFkPJxiQ51nQog4zU99i4oKFWNe
 2KJ5lNJDejaV7C9KEXkBsTiIOiFBYfQnCpb24TJNnuLfDawrKX8cg7iaDfO33mr4g0iXsMTLL9z
 hdhXW5f7UGYTT8g==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports:

drivers/media/i2c/ds90ub960.c:1788 ub960_init_tx_ports() error: uninitialized symbol 'pll_div'.

This is caused by 'pll_div' not being set for 1200 MHz CSI rate. Set the
'pll_div' correctly.

Fixes: afe267f2d368 ("media: i2c: add DS90UB960 driver")
Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Closes: https://lore.kernel.org/all/8d6daeb1-b62a-bbb2-b840-8759c84f2085@xs4all.nl/
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/i2c/ds90ub960.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index 4833b39b9178..4ab45e326d80 100644
--- a/drivers/media/i2c/ds90ub960.c
+++ b/drivers/media/i2c/ds90ub960.c
@@ -1763,6 +1763,7 @@ static int ub960_init_tx_ports(struct ub960_data *priv)
 		break;
 	case MHZ(1200):
 		speed_select = 1;
+		pll_div = 0x18;
 		break;
 	case MHZ(800):
 		speed_select = 2;

-- 
2.34.1

