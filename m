Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060357D2EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjJWJmm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjJWJm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:42:26 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8CAF5;
        Mon, 23 Oct 2023 02:42:22 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9674b5d38b=fe@dev.tdt.de>)
        id 1qurRv-003GsW-2T; Mon, 23 Oct 2023 11:42:15 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qurRu-003GsG-5m; Mon, 23 Oct 2023 11:42:14 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id BA66C24004B;
        Mon, 23 Oct 2023 11:42:13 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 18EC8240040;
        Mon, 23 Oct 2023 11:42:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 8C6AC216D6;
        Mon, 23 Oct 2023 11:42:12 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v5 0/2] ledtrig-tty: add additional tty state evaluation
Date:   Mon, 23 Oct 2023 11:42:03 +0200
Message-ID: <20231023094205.2706812-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8BIT
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1698054134-FA0CB49D-5E1EB346/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5:
==============
- Update commit message as request by greg k-h, to make the commit message
  more generic and not focusing on my use case [1]. Thanks for that.
- Removing PATCH v4 1/3 from previous set. This has been already applied to
  tty-testing [2] by greg k-h.
- As requested by greq k-h. I have also made the following changes to
  PATCH v4 3/3 [3].
  * Add a comment to the enum that this is already used for bit evaluation and
    sysfs read and write.
  * Renaming the variable 'unsigned long mode' to 'unsigned long ttytrigger'
    in the ledtrig_tty_data structure to make it clearer that the selected
    triggers are stored there.
  * Using sysfs_emit() function to dump the requestd ttytrigger to userland.
  * Also using the kstrtobool() function to write the selected ttytrigger
    via the sysfs. This values are booleans.
- I also removed the function ledtrig_tty_evaluate() from my last patchset.
  PATCH v4 3/3 [3]. The new API tty_get_tiocm() function is only called once
  now and checked for each ttytrigger bit. Previously this function was
  called for each bit, which is not necessary.

Links:
[1] https://lore.kernel.org/linux-leds/2023102115-stock-scrambled-f7d5@gregkh/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-testing&id=838eb763c3e939a8de8d4c55a17ddcce737685c1
[3] https://lore.kernel.org/linux-leds/20231019112809.881730-4-fe@dev.tdt.de/

Changes in v4:
==============
v4: https://lore.kernel.org/linux-leds/20231019112809.881730-1-fe@dev.tdt.de/
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
==============
v3: https://lore.kernel.org/linux-leds/20231016071332.597654-1-fe@dev.tdt.de/
- Add missing 'kernel test robot' information to the commit message.
- Additional information added to the commit message

Changes in v2:
==============
v2: https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/
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

Changes in v1:
==============
v1: https://lore.kernel.org/linux-leds/20230926093607.59536-1-fe@dev.tdt.de/
This is a follow-up patchset, based on the mailing list discussion from
March 2023 based on the old patchset v8 [1]. I have changed, the LED
trigger handling via the sysfs interfaces as suggested by Uwe Kleine-König.
Links:
[1] https://lore.kernel.org/linux-leds/20230306094113.273988-1-fe@dev.tdt.de/

Florian Eckert (2):
  tty: add new helper function tty_get_tiocm
  leds: ledtrig-tty: add new line mode evaluation

 .../ABI/testing/sysfs-class-led-trigger-tty   |  54 +++++
 drivers/leds/trigger/ledtrig-tty.c            | 187 ++++++++++++++++--
 drivers/tty/tty_io.c                          |  28 ++-
 include/linux/tty.h                           |   1 +
 4 files changed, 253 insertions(+), 17 deletions(-)

-- 
2.30.2

