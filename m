Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D657A5CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjISIwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjISIwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED71C102;
        Tue, 19 Sep 2023 01:51:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEF9C433C7;
        Tue, 19 Sep 2023 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113519;
        bh=EGdFlqkD+vlY7L5vgcGbMnI6v2mlEiUAySZsdwIVni4=;
        h=From:To:Cc:Subject:Date:From;
        b=Dscg3sCrByunT9FE+/aoWOmQ37YUrdW/HuFZJn8d1BF9wXVjdnyl28sE5Su4fb6vQ
         p/aTiVDjNu4POeQvaCJvsL2GlffvHlqiXXaCf8RVdBwmbVE4FVZZIFp4VHxAsbyI1W
         coYs1CKUCX1LxMdmBmQjJxxGavc4+2zWSYwPojloF67R5VjcmGjbtP9Qy+9ByJzScW
         iXHWW9RFl+I91k6RIHw/kEjQ7uHo3Xjs3K4mE6ynD+RYgGV+qYqUgCY49+zbsny8+m
         x7fA86z7puGo5yOjgpG7Lw/WjRjhiyjt4R3HTOeEs162QSyizdPM6uIHLxAuGFfR1A
         jB1y++u2RHgjw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 00/15] random tty fixes
Date:   Tue, 19 Sep 2023 10:51:41 +0200
Message-ID: <20230919085156.1578-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a collection of random fixes for tty I did while crawling
through the code. Mostly done for readability and understandability. No
behavior change intended (except for Documentation fixes).

Jiri Slaby (SUSE) (15):
  tty: n_tty: use 'retval' instead of 'c'
  tty: n_tty: rename and retype 'retval' in n_tty_ioctl()
  tty: n_tty: use min3() in copy_from_read_buf()
  tty: n_tty: invert the condition in copy_from_read_buf()
  tty: n_tty: use do-while in n_tty_check_{,un}throttle()
  tty: switch tty_{,un}throttle_safe() to return a bool
  tty: invert return values of tty_{,un}throttle_safe()
  tty: fix up and plug in tty_ioctl kernel-doc
  tty: fix kernel-doc for functions in tty.h
  tty: stop using ndash in kernel-doc
  tty: tty_buffer: use bool for 'restart' in
    tty_buffer_unlock_exclusive()
  tty: convert THROTTLE constants into enum
  tty: early return from send_break() on TTY_DRIVER_HARDWARE_BREAK
  tty: don't check for signal_pending() in send_break()
  tty: use 'if' in send_break() instead of 'goto'

 Documentation/driver-api/tty/index.rst     |   1 +
 Documentation/driver-api/tty/tty_ioctl.rst |  10 +
 drivers/tty/n_tty.c                        |  77 ++++---
 drivers/tty/tty.h                          |  13 +-
 drivers/tty/tty_buffer.c                   |   5 +-
 drivers/tty/tty_io.c                       |  36 ++--
 drivers/tty/tty_ioctl.c                    | 234 ++++++++++-----------
 drivers/tty/tty_port.c                     |   6 +-
 drivers/tty/vt/consolemap.c                |   2 +-
 drivers/tty/vt/vc_screen.c                 |   4 +-
 drivers/tty/vt/vt.c                        |   4 +-
 include/linux/tty.h                        |  25 +--
 12 files changed, 209 insertions(+), 208 deletions(-)
 create mode 100644 Documentation/driver-api/tty/tty_ioctl.rst

-- 
2.42.0

