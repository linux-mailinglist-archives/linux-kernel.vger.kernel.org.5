Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023BF7D57D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjJXQTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjJXQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:19:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E39EE8;
        Tue, 24 Oct 2023 09:19:36 -0700 (PDT)
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2345E6605769;
        Tue, 24 Oct 2023 17:19:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698164375;
        bh=gG1wa+QK44vc5DoGN8jxvkVeaZvhmJly0NBZ+F4cHfs=;
        h=From:To:Cc:Subject:Date:From;
        b=hRGvAocZiHFegacKg4KCrNHzcZlUbLVwGqB8nI+I22CZYBWvP01fsOzPbhCaSPV13
         hYPQTPSkKODQ5zmZZDyi7dfR60xTRPXL34/Y/tfBMdSd2S4pbd0QlI3I3F7Lnoio0c
         TDyDA4REntMF2NuByrCMo1C2bo4fw4osPDaCi9Dl8mXYKHxGAbQUM5iPFColCuWMWF
         WIr2Sarlsc/axTL2/lDR4QcPyvV55oM48pTyeORiia40u1EXv6MjKRN40NDtEHXPog
         A1C9JN998UyoE23ctRdpCYUz1oKJbdn/tYIMiga5dNkNo5HIUvdz8tG3EkiqghIPSL
         n7881mWaL9pcg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 9A7D4482AD9; Tue, 24 Oct 2023 18:19:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 0/3] Fix clock division overflow problem
Date:   Tue, 24 Oct 2023 18:18:14 +0200
Message-ID: <20231024161931.78567-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed the overflow issue while debugging an issue related to the Rockchip
RK3588 eMMC. It's not an issue on that particular platform and it does not seem
this has been an issue on any other platform so far, so I did not add any
stable Tags. Considering 64 bit platforms are the standard nowadays and 3GHz is
a reasonable small value, I expect this to become an issue soon, though.

Changes since PATCHv3:
 * https://lore.kernel.org/all/20230630183835.464216-1-sebastian.reichel@collabora.com/
 * Add some people to Cc, because similar overflow issue came up during s390 pull request
 * Split DIV_ROUND_UP_NO_OVERFLOW into its own patch
 * Add patch replacing open-coded abs_diff() from the previously applied patch

Changes since PATCHv2:
 * https://lore.kernel.org/all/20230526171057.66876-1-sebastian.reichel@collabora.com/
 * Drop first patch (applied)
 * Update second patch to use newly introduced DIV_ROUND_UP_NO_OVERFLOW

Changes since PATCHv1:
 * https://lore.kernel.org/linux-clk/20230519190522.194729-1-sebastian.reichel@collabora.com/
 * Add Christopher Obbard's Reviewed-by to the first patch
 * Update the second patch to use DIV_ROUND_UP instead of DIV64_U64_ROUND_UP

Greetings,

-- Sebastian


Sebastian Reichel (3):
  math.h: add DIV_ROUND_UP_NO_OVERFLOW
  clk: divider: Fix divisor masking on 64 bit platforms
  clk: composite: replace open-coded abs_diff()

 drivers/clk/clk-composite.c |  6 ++----
 drivers/clk/clk-divider.c   |  6 +++---
 include/linux/math.h        | 11 +++++++++++
 3 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.42.0

