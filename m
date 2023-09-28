Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4253E7B1E46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjI1N04 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 09:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjI1N0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:26:47 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754F819D;
        Thu, 28 Sep 2023 06:26:45 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=8649084492=fe@dev.tdt.de>)
        id 1qlr2M-007Wbe-KI; Thu, 28 Sep 2023 15:26:38 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qlr2L-009JBq-Is; Thu, 28 Sep 2023 15:26:37 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 0DF2D240049;
        Thu, 28 Sep 2023 15:26:37 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 601D5240040;
        Thu, 28 Sep 2023 15:26:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 0DA0632071;
        Thu, 28 Sep 2023 15:26:36 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v2 0/4] ledtrig-tty: add new state evaluation
Date:   Thu, 28 Sep 2023 15:26:28 +0200
Message-ID: <20230928132632.200263-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8BIT
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1695907598-3EC89A8C-CDBCAF2E/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- rename new function from tty_get_mget() to tty_get_tiocm() as
  requested by 'Jiri Slaby'.
- As suggested by 'Jiri Slaby', fixed tabs in function documentation
  throughout the file '/drivers/tty/tty_io.c' in a separate commit.
- Move the variable definition to the top in function 'ledtrig_tty_work()'.
  This was reported by the 'kernel test robot' after my change in v1.
- Also set the 'max_brightness' to 'blink_brightness' if no
  'blink_brightness' was set. This fixes a problem at startup when the
  brightness is still set to 0 and only 'line_*' is evaluated. I looked in
  the netdev trigger and that's exactly how it's done there.

v1:
This is a follow-up patchset, based on the mailing list discussion from
March 2023 based on the old patchset v7 [1]. I have changed, the LED trigger
handling via the sysfs interfaces as suggested by Uwe Kleine-König.

[1]
https://lore.kernel.org/linux-leds/20230306093524.amm7o4ppa7gon4ew@pengutronix.de/

Florian Eckert (4):
  tty: whitespaces in descriptions corrected by replacing tabs with
    spaces.
  tty: add new helper function tty_get_tiocm
  trigger: ledtrig-tty: move variable definition to the top
  trigger: ledtrig-tty: add new line mode to triggers

 .../ABI/testing/sysfs-class-led-trigger-tty   |  53 ++++
 drivers/leds/trigger/ledtrig-tty.c            | 280 +++++++++++++++++-
 drivers/tty/tty_io.c                          | 130 ++++----
 include/linux/tty.h                           |   1 +
 4 files changed, 396 insertions(+), 68 deletions(-)

-- 
2.30.2

