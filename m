Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E587F9503
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 20:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjKZTSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 14:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 14:18:48 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34132FB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 11:18:53 -0800 (PST)
Received: from p200301077700a9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:a900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r7KeS-006khO-Q3; Sun, 26 Nov 2023 20:18:44 +0100
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1r7KeR-000Slb-0I;
        Sun, 26 Nov 2023 20:18:43 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        johan@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        andreas@kemnade.info, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
        robh@kernel.org
Subject: [RFC PATCH 0/3] bluetooth/gnss: GNSS support for TiWi chips
Date:   Sun, 26 Nov 2023 20:18:37 +0100
Message-Id: <20231126191840.110564-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of these chips have GNSS support. In some vendor kernels
a driver on top of misc/ti-st can be found providing a /dev/tigps
device which speaks the secretive Air Independent Interface (AI2) protocol.
Implement something comparable as a GNSS interface.

With some userspace tools a proof-of-concept can be shown. A position
can be successfully read out.  Basic properties of the protocol are
understood.

This was tested on the Epson Moverio BT-200.

This is sent out as an early RFC to ensure I am going onto the right
track:

So the main questions I see:
- is the approach right to abandon drivers/misc/ti-st?

- Output at /dev/gnssX:
  AI2 vs. NMEA
  The chip can be configured into sending AI2-encapsulated NMEA,
  or proving data in a binary format.
  Some research has to be done yet for the details.
  A pile of logs is waiting for further analysis...

  Arguments for/against NMEA:
  + Userspace is prepared to handle it
  + Power management can be easily done by the kernel
  - Less functionality can be used.

  Arguments for/against AI2:
  + Full functionality can be accessed from userspace (incl. A-GPS,
    maybe raw satellite data)
  - Userspace has to behave to have proper power management
  - No freely (not even as in beer) tool available to fully use AI2,
    so there will be only a real advantage after long "French Cafe"
    sessions.

More detailed tings:
  - Some live cycle management is left out. Since it depends
    on the decisions above, I have not put much thought into it.
  - Should some pieces go into drivers/gnss?
  - detection for GNSS availability: For now the node name is
    used. But the device should be there if the chip supports it
    and things are wired up properly.

Andreas Kemnade (3):
  gnss: Add AI2 protocol used by some TI combo chips.
  bluetooth: ti-st: add GNSS support for TI Wilink chips
  drivers: misc: ti-st: begin to deorbit

 drivers/bluetooth/hci_ll.c | 154 ++++++++++++++++++++++++++++++++++++-
 drivers/gnss/core.c        |   1 +
 drivers/misc/ti-st/Kconfig |   2 +-
 include/linux/gnss.h       |   1 +
 4 files changed, 156 insertions(+), 2 deletions(-)

-- 
2.39.2

