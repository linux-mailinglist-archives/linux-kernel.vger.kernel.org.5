Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3751B781B7F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjHTAKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjHTAK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EEB88CF9;
        Sat, 19 Aug 2023 13:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5007060688;
        Sat, 19 Aug 2023 20:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6275BC433C7;
        Sat, 19 Aug 2023 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692476358;
        bh=4/t2jts6p6tQNRZ7+L8pRVJDvnflHKxYRG/DkQZtZYM=;
        h=Date:From:To:Cc:Subject:From;
        b=D/kDHDnzlgkL+1wK3iLNlwFOsawd7fKXVS3YiVuci+uQolGfo4/Aqtk4VTwu5X4Fs
         +fbb9EQ/Q5WsfIoYAONGK05Oxad9kn0iYn0rsMRroQh9kD+weL7PnZ9YIVRcOY5u6n
         0uwh/zJaerW2WEMNy5Mge+zuyJ36qT6HtZowlo/Y=
Date:   Sat, 19 Aug 2023 22:19:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.5-rc7
Message-ID: <ZOEjxOkOhH7LseG9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.5-rc7

for you to fetch changes up to 04c7f60ca477ffbf7b7910320482335050f0d23a:

  serial: core: Fix serial core port id, including multiport devices (2023-08-11 21:19:22 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 6.5-rc7

Here are some small tty and serial core fixes for 6.5-rc7 that resolve a
lot of reported issues.

Primarily in here is the fixes for the serial bus code from Tony that
came in -rc1, as it hit wider testing with the huge number of different
types of systems and serial ports.  All of the reported issues with
duplicate names and other issues with this code are now resolved.

Other than that included in here is:
 - n_gsm fix for a previous fix
 - 8250 lockdep annotation fix
 - fsl_lpuart serial driver fix
 - TIOCSTI documentation update for previous CAP_SYS_ADMIN change

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Günther Noack (1):
      TIOCSTI: Document CAP_SYS_ADMIN behaviour in Kconfig

Jiri Slaby (SUSE) (1):
      serial: 8250: drop lockdep annotation from serial8250_clear_IER()

Sherry Sun (1):
      tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms

Tony Lindgren (10):
      serial: core: Controller id cannot be negative
      serial: core: Fix serial core port id to not use port->line
      serial: core: Fix serial core controller port name to show controller id
      serial: core: Fix serial_base_match() after fixing controller port name
      MAINTAINERS: Merge TTY layer and serial drivers
      serial: core: Fix kmemleak issue for serial core device remove
      serial: 8250: Reinit port_id when adding back serial8250_isa_devs
      serial: 8250: Fix oops for port->pm on uart_change_pm()
      serial: core: Revert port_id use
      serial: core: Fix serial core port id, including multiport devices

Yi Yang (1):
      tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux

 MAINTAINERS                          | 15 ++------
 drivers/tty/Kconfig                  |  3 ++
 drivers/tty/n_gsm.c                  |  3 +-
 drivers/tty/serial/8250/8250_core.c  |  3 ++
 drivers/tty/serial/8250/8250_port.c  |  4 +--
 drivers/tty/serial/fsl_lpuart.c      |  4 +--
 drivers/tty/serial/serial_base.h     |  1 +
 drivers/tty/serial/serial_base_bus.c | 70 ++++++++++++++++++++++++++++--------
 include/linux/serial_core.h          |  3 +-
 9 files changed, 72 insertions(+), 34 deletions(-)
