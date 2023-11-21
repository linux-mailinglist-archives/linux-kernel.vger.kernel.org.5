Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF527F28A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjKUJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjKUJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2534DE8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508DAC433C9;
        Tue, 21 Nov 2023 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558583;
        bh=2JJEl9qZRNXTp7V/aOBIfQzLTFERSRdjiQ6fUrNoPtw=;
        h=From:To:Cc:Subject:Date:From;
        b=iwSgrfytuw8hnUaoDVzv7qtXXWU4WyVhfAxblRHJchTAK2tSuyagK2rZEAi4gBIQJ
         JdocksuBYkgUph7bj/c+wEoFOHcc3mx5yv0ulIMutaTqvd69qDJ3ls8ETbky0PqU0E
         27lnClMCcoXqMRGdTmqr4DFb3ohg3WPkH6aRY6j8dwwx2B9S6AnrQROeGShCw+RJLR
         w55DkZMcZvy3rNVUXblSJBJX8OSJQ2yYlqaOtr9ZzqAQ5LmSVsO/3Vpw2l8IpAxzOc
         2qy0KjAcwBxe+38uvGAZom6klSDhE7z+KWs85WHzIboLzUobKTeQsMSkOkMehbqfmj
         0+91yF/EkPigg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-usb@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 00/17] tty: small cleanups and fixes
Date:   Tue, 21 Nov 2023 10:22:41 +0100
Message-ID: <20231121092258.9334-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series to fix/clean up some obvious issues I revealed during
u8+size_t conversions (to be posted later).

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jan Kara <jack@suse.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-alpha@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-usb@vger.kernel.org
Cc: Matt Turner <mattst88@gmail.com>
Cc: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>

Jiri Slaby (SUSE) (17):
  tty: deprecate tty_write_message()
  tty: remove unneeded mbz from tiocsti()
  tty: fix tty_operations types in documentation
  tty: move locking docs out of Returns for functions in tty.h
  tty: amiserial: return from receive_chars() without goto
  tty: amiserial: use bool and rename overrun flag in receive_chars()
  tty: ehv_bytecha: use memcpy_and_pad() in local_ev_byte_channel_send()
  tty: goldfish: drop unneeded temporary variables
  tty: hso: don't emit load/unload info to the log
  tty: hso: don't initialize global serial_table
  tty: hvc_console: use flexible array for outbuf
  tty: nozomi: remove unused debugging DUMP()
  tty: srmcons: use 'buf' directly in srmcons_do_write()
  tty: srmcons: use 'count' directly in srmcons_do_write()
  tty: srmcons: make srmcons_do_write() return void
  tty: srmcons: switch need_cr to bool
  tty: srmcons: make 'str_cr' const and non-array

 arch/alpha/kernel/srmcons.c   | 29 +++++++++++++----------------
 drivers/net/usb/hso.c         | 11 -----------
 drivers/tty/amiserial.c       | 10 ++++------
 drivers/tty/ehv_bytechan.c    |  7 +++++--
 drivers/tty/goldfish.c        |  7 ++-----
 drivers/tty/hvc/hvc_console.c |  4 +---
 drivers/tty/hvc/hvc_console.h |  2 +-
 drivers/tty/nozomi.c          | 18 ------------------
 drivers/tty/tty_io.c          |  8 ++++++--
 include/linux/tty.h           | 12 +++++++-----
 include/linux/tty_driver.h    |  5 ++---
 11 files changed, 41 insertions(+), 72 deletions(-)

-- 
2.42.1

