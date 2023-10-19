Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A133E7CF6C5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345375AbjJSL2d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Oct 2023 07:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbjJSL2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:28:30 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FCE112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:28:28 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9670043017=fe@dev.tdt.de>)
        id 1qtRCJ-00GiEP-Pv; Thu, 19 Oct 2023 13:28:15 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qtRCI-00ElGy-Rk; Thu, 19 Oct 2023 13:28:14 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 7241724004B;
        Thu, 19 Oct 2023 13:28:14 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id C3699240040;
        Thu, 19 Oct 2023 13:28:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 1CB822062B;
        Thu, 19 Oct 2023 13:28:13 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        ansuelsmth@gmail.com, m.brock@vanmierlo.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v4 0/3] ledtrig-tty: add additional tty state evaluation
Date:   Thu, 19 Oct 2023 13:28:06 +0200
Message-ID: <20231019112809.881730-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8BIT
X-purgate-type: clean
X-purgate-ID: 151534::1697714895-CEEF23D8-7DBE2A5B/0/0
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
- Merging patch 3/4 into patch number 4/4 from previous series, because
  it fixes a problem that does not exist upstream. This was a note from
  the build robot regarding my change that I added with previous series.
  This change was never upstream and therefore this is not relevant.
- Update the commit message of patch 1/3 of this series, that this commit
  also changes the 'ndashes' to simple dashes. There were no changes, so
  I add the 'Reviewed-by' that the commit received before.
- With this patchset version I have reworked my implementation for the
  evaluation of the additional line state, so that this changes becomes
  smaller. As basis I have used the staged commits from Christian Marangi
  that makes this changes to the netdev trigger. This has already been
  applied to 'for-leds-next-next' by Lee Jones. I adapted this to the
  tty trigger.
  Convert device attr to macro:
  https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/commit/drivers/leds/trigger?h=for-leds-next-next&id=509412749002f4bac4c29f2012fff90c08d8afca
  Unify sysfs and state handling:
  https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/commit/drivers/leds/trigger?h=for-leds-next-next&id=0fd93ac8582627bee9a3c824489f302dff722881

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
  in the netdev trigger and that's exactly how it's done there.

v1:
This is a follow-up patchset, based on the mailing list discussion from
March 2023 based on the old patchset v8 [1]. I have changed, the LED
trigger handling via the sysfs interfaces as suggested by Uwe Kleine-König.
[1] https://lore.kernel.org/linux-leds/20230306094113.273988-1-fe@dev.tdt.de/

Florian Eckert (3):
  tty: whitespaces in descriptions corrected by replacing tabs with
    spaces
  tty: add new helper function tty_get_tiocm
  leds: ledtrig-tty: add new line mode evaluation

 .../ABI/testing/sysfs-class-led-trigger-tty   |  54 +++++
 drivers/leds/trigger/ledtrig-tty.c            | 192 +++++++++++++++++-
 drivers/tty/tty_io.c                          | 130 ++++++------
 include/linux/tty.h                           |   1 +
 4 files changed, 309 insertions(+), 68 deletions(-)

-- 
2.30.2

