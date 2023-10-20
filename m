Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B957D0B50
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376615AbjJTJTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376523AbjJTJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:19:44 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A9DE8AB;
        Fri, 20 Oct 2023 02:19:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 2FE38604F6624;
        Fri, 20 Oct 2023 17:19:40 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     pavel@ucw.cz, lee@kernel.org
Cc:     Su Hui <suhui@nfschina.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] leds: lp5521: add an error check in lp5521_post_init_device
Date:   Fri, 20 Oct 2023 17:19:31 +0800
Message-Id: <20231020091930.207870-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lp55xx_write() can return an error code, add a check for this.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/leds/leds-lp5521.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index 2ef19ad23b1d..f9c8b568b652 100644
--- a/drivers/leds/leds-lp5521.c
+++ b/drivers/leds/leds-lp5521.c
@@ -301,6 +301,8 @@ static int lp5521_post_init_device(struct lp55xx_chip *chip)
 
 	/* Set all PWMs to direct control mode */
 	ret = lp55xx_write(chip, LP5521_REG_OP_MODE, LP5521_CMD_DIRECT);
+	if (ret)
+		return ret;
 
 	/* Update configuration for the clock setting */
 	val = LP5521_DEFAULT_CFG;
-- 
2.30.2

