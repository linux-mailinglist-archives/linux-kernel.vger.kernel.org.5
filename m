Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FEF7E21C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjKFMez convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 07:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjKFMem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:34:42 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6E0B6;
        Mon,  6 Nov 2023 04:34:39 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=068806c1c2=fe@dev.tdt.de>)
        id 1qzyoG-00HTwm-Hc; Mon, 06 Nov 2023 13:34:28 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qzyoF-00HTwD-JJ; Mon, 06 Nov 2023 13:34:27 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 26378240050;
        Mon,  6 Nov 2023 13:34:27 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 78626240040;
        Mon,  6 Nov 2023 13:34:26 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id E36B82225B;
        Mon,  6 Nov 2023 13:34:25 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [Patch v7 0/6] ledtrig-tty: add additional tty state evaluation
Date:   Mon,  6 Nov 2023 13:34:09 +0100
Message-ID: <20231106123415.3365732-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8BIT
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1699274068-86F347EA-7F6C23C5/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v7:
==============
- Patch 1/7 is no longer included from the previous patch set v6, as it has
  already been merged into the master branch [5].
- As requested by Maarten, I have added a 'Fixes:' tag to patch 2/6 of
  this patch set, so that this commit should also be backported to the
  stable branches, as it is a memory leak.
- As requested by Maarten, I added an invert flag on LED blink, so that
  the LED blinks in the correct order.
  * LED was 'on' in the previous round, then it should first go 'off' and
    then 'on' again when it should blink (data has been transferred).
  * LED was 'off' in the previous round, then it should first go 'on' and
    then 'off' again when it should blink (data has been transferred).

Links:
[5] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/tty/tty_io.c?h=next-20231106&id=838eb763c3e939a8de8d4c55a17ddcce737685c1

Changes in v6:
==============
v6: https://lore.kernel.org/linux-leds/20231030100447.63477-1-fe@dev.tdt.de/
This is a paritial rewrite of the changes to make the function for
setting the tty evaluation configurable. This change was requested and
comment by Greg K-H at the last review [1]. The main changes are.
- Split the changes into smaller commits to make reviewing easier.
- Use a completion to sync the sysfs and the delay scheduler work on
  shared variables.
- Adding the base-commit to this overview, that reviewer know which base
  commit I am using.
  Base branch is:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
Patch [1/7]:
  This patch is already included in the tty branch [2], but it is still
  included in this patchsset, so that the following patches of the
  base-commit branch could be applied correctly.
Patch [2/7]:
  Add a new helper function tty_get_tiocm(). This got already a
  'Acked-by: Greg Kroah-Hartman' [3] and is not changed.
Patch [3/7]:
  Add missing of freeing an allocated ttyname buffer on trigger
  deactivation. This is a memory leak fix patch and should also be
  backported to the 'stable' branches.
Patch [4/7]:
  As requested by greg k-h this is more a 'dev_warn' instead of a
  'dev_info'. This could also be backported to the 'stable' branches if
  needed.
Patch [5/7]:
  Use a completion to sync for sysfs read/write and the delay scheduler
  work. I hope I am using the completion correctly. I wasn't sure if I
  should secure the sysfs read and write access at the same time via a
  mutex. With this change, the work is also not stopped as it was before
  when no ttyname was set via sysfs. A tty should always be set when this
  trigger is used. And is therefore not a problem from my point of view.
Patch [6/7]:
  Make rx tx activitate configurable. In the previous implementation,
  there was still the ttytrigger flag variable. This flag variable was
  replaced by individual variables in the data struct. Now these variables
  can be accessed without masking. The commit was rebased and cleaned up
  to use the completion implementation.
Patch [7/7]:
  Adding additional trigger line state sources. The commit was also
  rebased and cleaned up to use the completion implementation.

Changes in v5:
==============
v5: https://lore.kernel.org/linux-leds/20231023094205.2706812-1-fe@dev.tdt.de/
- Update commit message as request by greg k-h, to make the commit
  message more generic and not focusing on my use case [2].
- Removing PATCH v4 1/3 from previous set. This has been already applied
  to tty-testing [3] by greg k-h.
- As requested by greq k-h. I have also made the following changes to
  PATCH v4 3/3 [4].
  * Add a comment to the enum that this is already used for bit
    evaluation and sysfs read and write.
  * Renaming the variable 'unsigned long mode' to
    'unsigned long ttytrigger' in the ledtrig_tty_data structure to make
    it clearer that the selected triggers are stored there.
  * Using sysfs_emit() function to dump the requestd ttytrigger to
    userland.
  * Also using the kstrtobool() function to write the selected
    ttytrigger via the sysfs. This values are booleans.
- I also removed the function ledtrig_tty_evaluate() from my last
  patchses PATCH v4 3/3 [4]. The new API tty_get_tiocm() function
  is only called once now and checked for each ttytrigger bit.
  Previously this function was called for each bit, which is not
  necessary.

Links:
[2] https://lore.kernel.org/linux-leds/2023102115-stock-scrambled-f7d5@gregkh/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-testing&id=838eb763c3e939a8de8d4c55a17ddcce737685c1
[4] https://lore.kernel.org/linux-leds/20231019112809.881730-4-fe@dev.tdt.de/

Changes in v4:
==============
v4: https://lore.kernel.org/linux-leds/20231019112809.881730-1-fe@dev.tdt.de/
- Merging patch 3/4 into patch number 4/4 from previous series, because
  it fixes a problem that does not exist upstream. This was a note from
  the build robot regarding my change that I added with previous series.
  This change was never upstream and therefore this is not relevant.
- Update the commit message of patch 1/3 of this series, that this
  commit
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
trigger handling via the sysfs interfaces as suggested by Uwe
Kleine-König.
Links:
[1] https://lore.kernel.org/linux-leds/20230306094113.273988-1-fe@dev.tdt.de/


Florian Eckert (6):
  tty: add new helper function tty_get_tiocm
  leds: ledtrig-tty: free allocated ttyname buffer on deactivate
  leds: ledtrig-tty: change logging if get icount failed
  leds: ledtrig-tty: replace mutex with completion
  leds: ledtrig-tty: make rx tx activitate configurable
  leds: ledtrig-tty: add additional line state evaluation

 .../ABI/testing/sysfs-class-led-trigger-tty   |  56 ++++
 drivers/leds/trigger/ledtrig-tty.c            | 263 +++++++++++++++---
 drivers/tty/tty_io.c                          |  28 +-
 include/linux/tty.h                           |   1 +
 4 files changed, 306 insertions(+), 42 deletions(-)


base-commit: d2f51b3516dade79269ff45eae2a7668ae711b25
-- 
2.30.2

