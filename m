Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFC7CD54F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjJRHKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjJRHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:10:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED49FF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:10:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qt0h1-0007Yq-S8; Wed, 18 Oct 2023 09:10:11 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qt0gz-002V9Y-2q; Wed, 18 Oct 2023 09:10:09 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
        by dude03.red.stw.pengutronix.de with esmtp (Exim 4.96)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qt0gy-003JoA-3B;
        Wed, 18 Oct 2023 09:10:08 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH net-next v2 0/5] net: stmmac: use correct PPS input
 indexing
Date:   Wed, 18 Oct 2023 09:09:52 +0200
Message-Id: <20231010-stmmac_fix_auxiliary_event_capture-v2-0-51d5f56542d7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMCEL2UC/5WOQQqDMBREryJ/3RRju6hd9R5F5JuO9YN+JYmii
 Hdv8AZdzjx4MzsFeEGgZ7aTxyJBRk2huGTkOtYvjHxSpiIvbja3uQlxGNjVraw1z6v0wn6rsUB
 j7XiKs4cBt4UFl65sQUnUcIBpPKvrkkrnvk/l5JEc5/KbFNEo1khVIp2EOPrtvLTYk/+zvliTm
 xvguMTjfm/5NUG/c/Sjynr9gKrjOH4vfQ5o+AAAAA==
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>
Cc:     patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, vee.khee.wong@linux.intel.com,
        tee.min.tan@intel.com, rmk+kernel@armlinux.org.uk,
        bartosz.golaszewski@linaro.org, ahalaney@redhat.com,
        horms@kernel.org, Johannes Zink <j.zink@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stmmac can have 0 to 4 auxiliary snapshot in channels, which can be
used for capturing external triggers with respect to the eqos PTP timer.

Previously when enabling the auxiliary snapshot, an invalid request was
written to the hardware register, except for the Intel variant of this
driver, where the only snapshot available was hardcoded.

Patch 1 of this series cleans up the debug netdev_dbg message indicating
the auxiliary snapshot being {en,dis}abled. No functional changes here

Patch 2 of this series writes the correct PPS input indexing to the
hardware registers instead of a previously used fixed value

Patch 3 of this series removes a field member from plat_stmmacnet_data
that is no longer needed

Patch 4 of this series prepares Patch 5 by protecting the snapshot
enabled flag by the aux_ts_lock mutex

Patch 5 of this series adds a temporary workaround, since at the moment
the driver can handle only one single auxiliary snapshot at a time.
Previously the driver silently dropped the previous configuration and
enabled the new one. Now, if a snapshot is already enabled and userspace
tries to enable another without previously disabling the snapshot currently
enabled: issue a netdev_err and return an errorcode indicating the device is
busy.

This series is a "never worked, doesn't hurt anyone" touchup to the PPS
capture for non-intel variants of the dwmac driver.

Best Regards
Johannes

To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Jose Abreu <joabreu@synopsys.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: patchwork-jzi@pengutronix.de
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de
Cc: vee.khee.wong@linux.intel.com
Cc: tee.min.tan@intel.com
Cc: rmk+kernel@armlinux.org.uk
Cc: bartosz.golaszewski@linaro.org
Cc: ahalaney@redhat.com
Cc: horms@kernel.org

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
Changes in v2:
- fixed CC list to also include maintainers/authors of dwmac-intel
- reworded commit messages and removed fixme-Tag as discussed with Simon
  and Jakub. Thanks for reviewing the series!
- Link to v1: https://lore.kernel.org/r/20231010-stmmac_fix_auxiliary_event_capture-v1-0-3eeca9e844fa@pengutronix.de

---
Johannes Zink (5):
      net: stmmac: simplify debug message on stmmac_enable()
      net: stmmac: use correct PPS capture input index
      net: stmmac: intel: remove unnecessary field struct plat_stmmacenet_data::ext_snapshot_num
      net: stmmac: ptp: stmmac_enable(): move change of plat->flags into mutex
      net: stmmac: do not silently change auxiliary snapshot capture channel

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 32 ++++++++++++++---------
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  2 +-
 include/linux/stmmac.h                            |  1 -
 4 files changed, 21 insertions(+), 15 deletions(-)
---
base-commit: ee2a35fedbc942e6eeb9e351a53acb1fe6b101c5
change-id: 20231010-stmmac_fix_auxiliary_event_capture-eaf21ea9c9fe

Best regards,
-- 
Johannes Zink <j.zink@pengutronix.de>

