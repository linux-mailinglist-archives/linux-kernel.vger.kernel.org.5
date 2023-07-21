Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286F475D510
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGUTde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGUTdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A43830FF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 12:32:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF04A61D76
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 19:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F05C433C9;
        Fri, 21 Jul 2023 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689967948;
        bh=jnHwog2XWGt7cS5tRZm6XBtcLY1vyrk1kzdNWLRN5yk=;
        h=From:To:Cc:Subject:Date:From;
        b=trnPyC26lE0IZ6VomrbeEQZPRVIdJb1OMwbxhdRQDA+gmy4yj4VBDt6QmET5t8PG+
         ktAMru03nQRi34Uq+zKLOXeHcZItDZzHJ5UTWJtjZjHBSrYa94LFeS1CfCYBosYxcC
         mi/pBOVyw1stW38yy/UCx/6Rm+zjXYpZ9QRms71FfA8vAvS+CaltNAIbVmHzVeXFbz
         T2SUq4mN45gXAqPt60Dvw9qd51lEq43UI1z575eLy1W18McaNkcBqx4MgG+xdxyl76
         GXLipd35oSVXzkTHo5IeIMNWU4MFY6sPOqhFWp6VoXiXjbqj92oRraaJJeBvIGpIZz
         eTJbAKgbtE4Ww==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.5-rc2
Date:   Fri, 21 Jul 2023 20:32:19 +0100
Message-Id: <20230721193227.C8F05C433C9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.5-rc2

for you to fetch changes up to a9e26169cfda651802f88262a315146fbe4bc74c:

  regmap: Disable locking for RBTREE and MAPLE unit tests (2023-07-20 13:57:01 +0100)

----------------------------------------------------------------
regmap: Fixes for v6.5

Three fixes here:

 - The issues with accounting for register and padding length on raw
   buses turn out to be quite widespread in custom buses, in order to
   avoid disturbing anything drop the initial fixes and fall back to
   a point fix in the SMBus code where the issue was originally noticed,
   a more substantial refactoring of the API which ensures that all
   buses make the same assumptions will follow.

 - The generic regcache code had been forcing on async I/O which did
   not work with the new maple tree sync code when used with SPI.  Since
   that was mainly for the rbtree cache and the assumptions about hardware
   that drove the choice are probably not true any more fix this by pushing
   the enablement of async down into the rbtree code, probably this also
   makes cache syncs for systems faster though it's not the point.

 - The test code was triggering use of the rbtree and maple tree caches
   with dynamic allocation of nodes since all the testing is with RAM
   backed caches with no I/O performance issues.  Just disable the
   locking in the tests to avoid triggering warnings when allocation
   debugging is turned on, it's not really what's being tested.

----------------------------------------------------------------
Guenter Roeck (1):
      regmap: Disable locking for RBTREE and MAPLE unit tests

Mark Brown (3):
      regmap: Drop initial version of maximum transfer length fixes
      regmap: Account for register length in SMBus I/O limits
      regcache: Push async I/O request down into the rbtree cache

 drivers/base/regmap/regcache-rbtree.c | 4 ++++
 drivers/base/regmap/regcache.c        | 3 ---
 drivers/base/regmap/regmap-i2c.c      | 8 ++++----
 drivers/base/regmap/regmap-kunit.c    | 5 +++++
 drivers/base/regmap/regmap-spi-avmm.c | 2 +-
 drivers/base/regmap/regmap.c          | 6 ++----
 6 files changed, 16 insertions(+), 12 deletions(-)
