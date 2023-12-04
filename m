Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA04804146
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjLDWFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjLDWF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:05:28 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D8D5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:05:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAH4G-0003EL-JY; Mon, 04 Dec 2023 23:05:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAH4F-00DbXx-MO; Mon, 04 Dec 2023 23:05:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAH4F-00EMWz-D6; Mon, 04 Dec 2023 23:05:31 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 0/3] w1: gpio: Some cleanup and simplifiction
Date:   Mon,  4 Dec 2023 23:05:20 +0100
Message-ID: <cover.1701727212.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=738; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9M6T1gHGqUr1qLRH167CfGLn2mtygFahUYc5c6/LKb8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQ8X/mWtxWau6d+ftj+MvmLe5Ed/wW/veebiq0OXYyM2 NS18s/yTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmIrSd/X/g2tKw5SFWUssz nmyb4rFe08NW62KyY1RPqJVv5PGZ769nJ/b8O9Sc4dvzJL+Fa3v0LzWbK8JhhxyYWl9vZ/hYUq4 SGm5e1GEe83nWj4n+k/4wbxW4eJz93Rw+tqTfBRv1jaxss3xPcO9UlpesuBw1t7e6lnHOwycX5a 9+963yn7S1/pi37AUlG2c1bY4MK8ezLsrNzkJufdu1lMvun7YvS790V+/mVgcnOfN1XxuzDnrKc 0r3qqYe6I2IPaRUnZT49QDb9PJXrVGrhCR7Lhl9+sl5X0LixHfVM1pZc+tNay0erLxZveLbujPJ Exusf9TwazPONTrhPoN1XoXsZPWa2kDJU0vMt0vo5JQDAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

v1 is available at
https://lore.kernel.org/r/20230525095624.615350-1-u.kleine-koenig@pengutronix.de.

The changes in this v2 since then are:

 - Fix a build problem in patch #3
 - Rebase to today's next

Best regards
Uwe

Uwe Kleine-König (3):
  w1: gpio: Don't use platform data for driver data
  w1: gpio: Drop unused enable_external_pullup from driver data
  w1: gpio: rename pointer to driver data from pdata to ddata

 drivers/w1/masters/w1-gpio.c | 118 +++++++++++++----------------------
 include/linux/w1-gpio.h      |  22 -------
 2 files changed, 42 insertions(+), 98 deletions(-)
 delete mode 100644 include/linux/w1-gpio.h


base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b
-- 
2.42.0

