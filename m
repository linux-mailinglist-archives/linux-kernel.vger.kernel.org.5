Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF817A535F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjIRTwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjIRTwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:52:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C06B1B1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:51:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHB-0003kL-K7; Mon, 18 Sep 2023 21:51:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKH7-007I8N-8m; Mon, 18 Sep 2023 21:51:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKH6-002mBz-U1; Mon, 18 Sep 2023 21:51:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>
Subject: [PATCH net-next 00/19] net: mdio: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 21:50:43 +0200
Message-Id: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3333; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ci0IQrSWXNAJYKg8fc1qgrDF2J0dg2FQPcKK5IFoxug=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKn/qrkWkMR4vATlu8+A8buQtn/uucJFCz2Je IMvpamj1JiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQip/wAKCRCPgPtYfRL+ TgI/CACwpYaVqL2xrOfAhNBLFfB1xVWtYI9VnYPr9stjtL6MTwB9J8cCGV9AZ3kzuvv+WH2Q4rZ 5FI4J3XS7U+/FYU0H3YQQc8TeWJY7Ox15+3DAeFd/J47vAxI040iarzF8Lk1UibG4xlKxeVr/74 7OMIbUZCi0mjPMQzdIUufaXP2vm7IHBsNE5VYDr7pvT1vJixcOEeTtR39oDZmpUGLmjXxJ4FFoZ 80e2dl5Wg/6Lwr0APE2IqAMytjXfRhdW1z8fS7axIlH1JcZePE2Vpwf3V62ohnleM1St4kJJ40I D0TiIGRs/l1V3FjneArpH8rCY8lPmB0ET/0iO0ny4VYL9Wy8
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series convert all platform drivers below drivers/net/mdio to
use remove_new. The motivation is to get rid of an integer return code
that is (mostly) ignored by the platform driver core and error prone on
the driver side.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

There are no interdependencies between the patches. As there are still
quite a few drivers to convert, I'm happy about every patch that makes
it in. So even if there is a merge conflict with one patch until you
apply, please apply the remainder of this series anyhow.

Best regards
Uwe

Uwe Kleine-König (19):
  net: mdio: aspeed: Convert to platform remove callback returning void
  net: mdio: bcm-iproc: Convert to platform remove callback returning
    void
  net: mdio: bcm-unimac: Convert to platform remove callback returning
    void
  net: mdio: gpio: Convert to platform remove callback returning void
  net: mdio: hisi-femac: Convert to platform remove callback returning
    void
  net: mdio: ipq4019: Convert to platform remove callback returning void
  net: mdio: ipq8064: Convert to platform remove callback returning void
  net: mdio: moxart: Convert to platform remove callback returning void
  net: mdio: mscc-miim: Convert to platform remove callback returning
    void
  net: mdio: mux-bcm-iproc: Convert to platform remove callback
    returning void
  net: mdio: mux-bcm6368: Convert to platform remove callback returning
    void
  net: mdio: mux-gpio: Convert to platform remove callback returning
    void
  net: mdio: mux-meson-g12a: Convert to platform remove callback
    returning void
  net: mdio: mux-meson-gxl: Convert to platform remove callback
    returning void
  net: mdio: mux-mmioreg: Convert to platform remove callback returning
    void
  net: mdio: mux-multiplexer: Convert to platform remove callback
    returning void
  net: mdio: octeon: Convert to platform remove callback returning void
  net: mdio: sun4i: Convert to platform remove callback returning void
  net: mdio: xgene: Convert to platform remove callback returning void

 drivers/net/mdio/mdio-aspeed.c          | 6 ++----
 drivers/net/mdio/mdio-bcm-iproc.c       | 6 ++----
 drivers/net/mdio/mdio-bcm-unimac.c      | 6 ++----
 drivers/net/mdio/mdio-gpio.c            | 6 ++----
 drivers/net/mdio/mdio-hisi-femac.c      | 6 ++----
 drivers/net/mdio/mdio-ipq4019.c         | 6 ++----
 drivers/net/mdio/mdio-ipq8064.c         | 7 ++-----
 drivers/net/mdio/mdio-moxart.c          | 6 ++----
 drivers/net/mdio/mdio-mscc-miim.c       | 6 ++----
 drivers/net/mdio/mdio-mux-bcm-iproc.c   | 6 ++----
 drivers/net/mdio/mdio-mux-bcm6368.c     | 6 ++----
 drivers/net/mdio/mdio-mux-gpio.c        | 5 ++---
 drivers/net/mdio/mdio-mux-meson-g12a.c  | 6 ++----
 drivers/net/mdio/mdio-mux-meson-gxl.c   | 6 ++----
 drivers/net/mdio/mdio-mux-mmioreg.c     | 6 ++----
 drivers/net/mdio/mdio-mux-multiplexer.c | 6 ++----
 drivers/net/mdio/mdio-octeon.c          | 5 ++---
 drivers/net/mdio/mdio-sun4i.c           | 6 ++----
 drivers/net/mdio/mdio-xgene.c           | 6 ++----
 19 files changed, 38 insertions(+), 75 deletions(-)

base-commit: 7fc7222d9680366edeecc219c21ca96310bdbc10
-- 
2.40.1

