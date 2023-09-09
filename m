Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510A47996D1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 10:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbjIIIGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 04:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343533AbjIIIGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 04:06:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8F62113
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 01:06:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F105AC433C7;
        Sat,  9 Sep 2023 08:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694246777;
        bh=5zQ+CNrGhdEAING+XXCrQGVDWC8hZ7asL4MON9Vji2c=;
        h=Date:From:To:Cc:Subject:From;
        b=kxd+6aJB9BiHJlI3aH+7Owf6fz1ETC+uA5dVDN/cq3acL3DxoHG2GVA3FQWye42LZ
         yzFXJ2fKreId0i51sNjlQuOmt2ajXVPqauHAsZQYatVd+8R/R222bGvPaRW6oN2HFn
         m9hk/fsqqHkyHTiBPwXw69jE5T50ULMHh/F4Pn+U=
Date:   Sat, 9 Sep 2023 09:06:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver symbol lookup fix for 6.6-rc1
Message-ID: <ZPwndquCWHIicVzt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a48fa7efaf1161c1c898931fe4c7f0070964233a:

  Merge tag 'drm-next-2023-09-08' of git://anongit.freedesktop.org/drm/drm (2023-09-07 19:47:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.6-rc1-2

for you to fetch changes up to 86495af1171e1feec79faa9b64c05c89f46e41d1:

  media: dvb: symbol fixup for dvb_attach() (2023-09-09 08:15:11 +0100)

----------------------------------------------------------------
Driver symbol lookup fix for 6.6-rc1

Here is one last fixup for your tree for 6.6-rc1.  It resolves a problem
with the way that symbol_get was changed in the module tree merge in
your tree to fix up the DVB drivers which rely on this old api to attach
new devices.

As the changelog comment says:

  In commit 9011e49d54dc ("modules: only allow symbol_get of
  EXPORT_SYMBOL_GPL modules") the use of symbol_get is properly restricted
  to GPL-only marked symbols.  This interacts oddly with the DVB logic
  which only uses dvb_attach() to load the dvb driver which then uses
  symbol_get().

  Fix this up by properly marking all of the dvb_attach attach symbols as
  EXPORT_SYMBOL_GPL().

This has been acked by Hans from the V4L driver side, and from Luis from
the module side, and Christoph said it was the correct solution, and was
tested by the original reporter of the issue.

It has passed 0-day testing, but has not been in linux-next due to it
only being sent yesterday.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      media: dvb: symbol fixup for dvb_attach()

 drivers/media/dvb-frontends/ascot2e.c             | 2 +-
 drivers/media/dvb-frontends/atbm8830.c            | 2 +-
 drivers/media/dvb-frontends/au8522_dig.c          | 2 +-
 drivers/media/dvb-frontends/bcm3510.c             | 2 +-
 drivers/media/dvb-frontends/cx22700.c             | 2 +-
 drivers/media/dvb-frontends/cx22702.c             | 2 +-
 drivers/media/dvb-frontends/cx24110.c             | 2 +-
 drivers/media/dvb-frontends/cx24113.c             | 2 +-
 drivers/media/dvb-frontends/cx24116.c             | 2 +-
 drivers/media/dvb-frontends/cx24120.c             | 2 +-
 drivers/media/dvb-frontends/cx24123.c             | 2 +-
 drivers/media/dvb-frontends/cxd2820r_core.c       | 2 +-
 drivers/media/dvb-frontends/cxd2841er.c           | 4 ++--
 drivers/media/dvb-frontends/cxd2880/cxd2880_top.c | 2 +-
 drivers/media/dvb-frontends/dib0070.c             | 2 +-
 drivers/media/dvb-frontends/dib0090.c             | 4 ++--
 drivers/media/dvb-frontends/dib3000mb.c           | 2 +-
 drivers/media/dvb-frontends/dib3000mc.c           | 2 +-
 drivers/media/dvb-frontends/dib7000m.c            | 2 +-
 drivers/media/dvb-frontends/dib7000p.c            | 2 +-
 drivers/media/dvb-frontends/dib8000.c             | 2 +-
 drivers/media/dvb-frontends/dib9000.c             | 2 +-
 drivers/media/dvb-frontends/drx39xyj/drxj.c       | 2 +-
 drivers/media/dvb-frontends/drxd_hard.c           | 2 +-
 drivers/media/dvb-frontends/drxk_hard.c           | 2 +-
 drivers/media/dvb-frontends/ds3000.c              | 2 +-
 drivers/media/dvb-frontends/dvb-pll.c             | 2 +-
 drivers/media/dvb-frontends/ec100.c               | 2 +-
 drivers/media/dvb-frontends/helene.c              | 4 ++--
 drivers/media/dvb-frontends/horus3a.c             | 2 +-
 drivers/media/dvb-frontends/isl6405.c             | 2 +-
 drivers/media/dvb-frontends/isl6421.c             | 2 +-
 drivers/media/dvb-frontends/isl6423.c             | 2 +-
 drivers/media/dvb-frontends/itd1000.c             | 2 +-
 drivers/media/dvb-frontends/ix2505v.c             | 2 +-
 drivers/media/dvb-frontends/l64781.c              | 2 +-
 drivers/media/dvb-frontends/lg2160.c              | 2 +-
 drivers/media/dvb-frontends/lgdt3305.c            | 2 +-
 drivers/media/dvb-frontends/lgdt3306a.c           | 2 +-
 drivers/media/dvb-frontends/lgdt330x.c            | 2 +-
 drivers/media/dvb-frontends/lgs8gxx.c             | 2 +-
 drivers/media/dvb-frontends/lnbh25.c              | 2 +-
 drivers/media/dvb-frontends/lnbp21.c              | 4 ++--
 drivers/media/dvb-frontends/lnbp22.c              | 2 +-
 drivers/media/dvb-frontends/m88ds3103.c           | 2 +-
 drivers/media/dvb-frontends/m88rs2000.c           | 2 +-
 drivers/media/dvb-frontends/mb86a16.c             | 2 +-
 drivers/media/dvb-frontends/mb86a20s.c            | 2 +-
 drivers/media/dvb-frontends/mt312.c               | 2 +-
 drivers/media/dvb-frontends/mt352.c               | 2 +-
 drivers/media/dvb-frontends/nxt200x.c             | 2 +-
 drivers/media/dvb-frontends/nxt6000.c             | 2 +-
 drivers/media/dvb-frontends/or51132.c             | 2 +-
 drivers/media/dvb-frontends/or51211.c             | 2 +-
 drivers/media/dvb-frontends/s5h1409.c             | 2 +-
 drivers/media/dvb-frontends/s5h1411.c             | 2 +-
 drivers/media/dvb-frontends/s5h1420.c             | 2 +-
 drivers/media/dvb-frontends/s5h1432.c             | 2 +-
 drivers/media/dvb-frontends/s921.c                | 2 +-
 drivers/media/dvb-frontends/si21xx.c              | 2 +-
 drivers/media/dvb-frontends/sp887x.c              | 2 +-
 drivers/media/dvb-frontends/stb0899_drv.c         | 2 +-
 drivers/media/dvb-frontends/stb6000.c             | 2 +-
 drivers/media/dvb-frontends/stb6100.c             | 2 +-
 drivers/media/dvb-frontends/stv0288.c             | 2 +-
 drivers/media/dvb-frontends/stv0297.c             | 2 +-
 drivers/media/dvb-frontends/stv0299.c             | 2 +-
 drivers/media/dvb-frontends/stv0367.c             | 6 +++---
 drivers/media/dvb-frontends/stv0900_core.c        | 2 +-
 drivers/media/dvb-frontends/stv090x.c             | 2 +-
 drivers/media/dvb-frontends/stv6110.c             | 2 +-
 drivers/media/dvb-frontends/stv6110x.c            | 2 +-
 drivers/media/dvb-frontends/tda10021.c            | 2 +-
 drivers/media/dvb-frontends/tda10023.c            | 2 +-
 drivers/media/dvb-frontends/tda10048.c            | 2 +-
 drivers/media/dvb-frontends/tda1004x.c            | 4 ++--
 drivers/media/dvb-frontends/tda10086.c            | 2 +-
 drivers/media/dvb-frontends/tda665x.c             | 2 +-
 drivers/media/dvb-frontends/tda8083.c             | 2 +-
 drivers/media/dvb-frontends/tda8261.c             | 2 +-
 drivers/media/dvb-frontends/tda826x.c             | 2 +-
 drivers/media/dvb-frontends/ts2020.c              | 2 +-
 drivers/media/dvb-frontends/tua6100.c             | 2 +-
 drivers/media/dvb-frontends/ves1820.c             | 2 +-
 drivers/media/dvb-frontends/ves1x93.c             | 2 +-
 drivers/media/dvb-frontends/zl10036.c             | 2 +-
 drivers/media/dvb-frontends/zl10039.c             | 2 +-
 drivers/media/dvb-frontends/zl10353.c             | 2 +-
 drivers/media/pci/bt8xx/dst.c                     | 2 +-
 drivers/media/pci/bt8xx/dst_ca.c                  | 2 +-
 drivers/media/pci/ddbridge/ddbridge-dummy-fe.c    | 2 +-
 drivers/media/tuners/fc0011.c                     | 2 +-
 drivers/media/tuners/fc0012.c                     | 2 +-
 drivers/media/tuners/fc0013.c                     | 2 +-
 drivers/media/tuners/max2165.c                    | 2 +-
 drivers/media/tuners/mc44s803.c                   | 2 +-
 drivers/media/tuners/mt2060.c                     | 2 +-
 drivers/media/tuners/mt2131.c                     | 2 +-
 drivers/media/tuners/mt2266.c                     | 2 +-
 drivers/media/tuners/mxl5005s.c                   | 2 +-
 drivers/media/tuners/qt1010.c                     | 2 +-
 drivers/media/tuners/tda18218.c                   | 2 +-
 drivers/media/tuners/xc2028.c                     | 2 +-
 drivers/media/tuners/xc4000.c                     | 2 +-
 drivers/media/tuners/xc5000.c                     | 2 +-
 drivers/staging/media/av7110/sp8870.c             | 2 +-
 106 files changed, 113 insertions(+), 113 deletions(-)
