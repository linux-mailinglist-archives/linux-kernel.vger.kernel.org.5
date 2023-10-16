Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA157CA03E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjJPHOJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Oct 2023 03:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjJPHNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:13:55 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D66BFF;
        Mon, 16 Oct 2023 00:13:52 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=966793e2c5=fe@dev.tdt.de>)
        id 1qsHnH-002Nhz-Aj; Mon, 16 Oct 2023 09:13:39 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qsHnG-00ADhL-9f; Mon, 16 Oct 2023 09:13:38 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id DB2B424004D;
        Mon, 16 Oct 2023 09:13:37 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 38533240049;
        Mon, 16 Oct 2023 09:13:37 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id D30732BD62;
        Mon, 16 Oct 2023 09:13:36 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v3 0/4] ledtrig-tty: add additional tty state evaluation
Date:   Mon, 16 Oct 2023 09:13:28 +0200
Message-ID: <20231016071332.597654-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8BIT
X-purgate-type: clean
X-purgate-ID: 151534::1697440419-4E731C7C-B86B7ACA/0/0
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
- Add missing 'kernel test robot' information to the commit message.
- Additional information added to the commit message

Changes in v2:
- rename new function from tty_get_mget() to tty_get_tiocm() as
  requested by 'Jiri Slaby'.
- As suggested by 'Jiri Slaby', fixed tabs in function documentation
  throughout the file '/drivers/tty/tty_io.c' in a separate commit.
- Move the variable definition to the top in function
  'ledtrig_tty_work()'.
  This was reported by the 'kernel test robot' after my change in v1.
- Also set the 'max_brightness' to 'blink_brightness' if no
  'blink_brightness' was set. This fixes a problem at startup when the
  brightness is still set to 0 and only 'line_*' is evaluated. I looked
in
  the netdev trigger and that's exactly how it's done there.

v1:
This is a follow-up patchset, based on the mailing list discussion from
March 2023 based on the old patchset v7 [1]. I have changed, the LED
trigger
handling via the sysfs interfaces as suggested by Uwe Kleine-König.

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

