Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFBF76B200
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHAKgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjHAKg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:36:28 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB2FA1;
        Tue,  1 Aug 2023 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1690886187; x=1722422187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8CQkOodeAX2v+3iqUQV0g8XdgU4PFpg9fwufh1/EOFo=;
  b=OZptjQ+t8XbduEcEIRtci9QdmTj4v3+30Nscp6kh3oKKKtGEAMo4/Pbf
   JfwyJjdDD5rXIq4YoxpYf8XeB7dLjJUEwZVV1i3iOuR7ZVfimNYouIpBz
   PYgL91WJ5uGs8l2Ea7pc3xfRlVtDB1mhkdQJv0qhqAvKRBk1b+bEymbMR
   CRpFHrSGiIWMD/rXr2bXE+itYKouoZyme7GExPaL+lqdplKHRFqAnY9kt
   k0kdOdVyPSCv6l74ooa985o1g/lKjAg/wP5N09coOD42+bFxqrB+geAVD
   HftOvfpyD6Nboyq9RSgmtIlOG5d40THCZy6/bO2VeXPjG/xgCxvhv/li2
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,246,1684792800"; 
   d="scan'208";a="32226638"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Aug 2023 12:36:24 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id A02B3280075;
        Tue,  1 Aug 2023 12:36:24 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jai Luthra <j-luthra@ti.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 0/3] clk: keystone: syscon-clk: fixes for audio refclk
Date:   Tue,  1 Aug 2023 12:36:06 +0200
Message-Id: <cover.1690885413.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver uses of_clk_hw_onecell_get() for all clocks it
manages, but this is incorrect for the audio refclk, which has 0 rather
than 1 clock cell according to its binding documentation [1]; attempting
to look up the clock when referenced like this in the Device Tree leads
to errors, as uninitialized memory is passed to of_clk_hw_onecell_get()
as the index.

The actual fix is in patch 3; patches 1 and 2 are preparation and
related cleanup. I've added a Fixes: tag to all 3 patches, as they
need to be backported together.

Matthias Schiffer (3):
  clk: keystone: syscon-clk: use struct instead of array for match data
  clk: keystone: syscon-clk: specify whether a parent is required in
    match data
  clk: keystone: syscon-clk: use of_clk_hw_simple_get() for audio refclk

[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/clock/ti,am62-audio-refclk.yaml


 drivers/clk/keystone/syscon-clk.c | 73 ++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 25 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

