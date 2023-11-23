Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD017F6710
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjKWTWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjKWTWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:22:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A919E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:22:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AA2C433C9;
        Thu, 23 Nov 2023 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700767363;
        bh=+DnfYw9L0OuHBRrJMLhZjl50FM6MJZ9pOeWDYd/DFnk=;
        h=Date:From:To:cc:Subject:From;
        b=G+/QOiHCYmgMcdzGaJ9KUrZuc+710L9mfrlVQZn72UyrGTs1LCsMCX0XW4O5l9R8J
         q6ZBBNKJTwrs/4xZ4gDV+V6lIBHP3tGX6cbXLRb3S92V1rht1JwY7cS+8gEcruw0eV
         8eeOnee/zlDj4zIQHqiKZuGtr5KA5AdlGGawNbskqC6XtGhTi245QNqqyUA9ZIuamh
         Pfy/iOIzUNwRuX+f4XRcbMnKhP2DEx/xfJtD5yjEiNJXk80BbIuori/X+n3j9ZCku9
         A2wVlygPiKzpt50g+N8PuJYjbPg+ipPpnZiTO03r+JLyETi+4OaMcrWMMBfPi7FcAG
         WJw1qJFcB4h4A==
Date:   Thu, 23 Nov 2023 20:22:39 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2311231302250.29220@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023112301

To receive HID subsystem fixes for 6.7.

=====
- Revert of commit that caused regression to many Logitech unifying 
  receiver users (Jiri Kosina)
- power management fix for hid-mcp2221 (Hamish Martin)
- fix for race condition between HID core and HID debug (Charles Yi)
- a couple of assorted device-ID-specific quirks
=====

Aoba K (1):
      HID: multitouch: Add quirk for HONOR GLO-GXXX touchpad

Brett Raye (1):
      HID: glorious: fix Glorious Model I HID report

Charles Yi (1):
      HID: fix HID device resource race between HID core and debugging support

Denis Benato (2):
      HID: hid-asus: add const to read-only outgoing usb buffer
      HID: hid-asus: reset the backlight brightness level on resume

Hamish Martin (2):
      HID: mcp2221: Set driver data before I2C adapter add
      HID: mcp2221: Allow IO to start during probe

Jiri Kosina (1):
      Revert "HID: logitech-dj: Add support for a new lightspeed receiver iteration"

Oliver Neukum (1):
      HID: add ALWAYS_POLL quirk for Apple kb

Yihong Cao (1):
      HID: apple: add Jamesdonkey and A3R to non-apple keyboards list

 drivers/hid/hid-apple.c       |  2 ++
 drivers/hid/hid-asus.c        | 27 +++++++++++++++++++++++----
 drivers/hid/hid-core.c        | 12 ++++++++++--
 drivers/hid/hid-debug.c       |  3 +++
 drivers/hid/hid-glorious.c    | 16 ++++++++++++++--
 drivers/hid/hid-ids.h         | 12 +++++++-----
 drivers/hid/hid-logitech-dj.c | 11 +++--------
 drivers/hid/hid-mcp2221.c     |  4 +++-
 drivers/hid/hid-multitouch.c  |  5 +++++
 drivers/hid/hid-quirks.c      |  1 +
 include/linux/hid.h           |  3 +++
 11 files changed, 74 insertions(+), 22 deletions(-)

-- 
Jiri Kosina
SUSE Labs

