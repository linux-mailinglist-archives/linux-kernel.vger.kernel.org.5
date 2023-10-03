Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7BB7B7088
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbjJCSHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbjJCSHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:07:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA978AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:07:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B712C433CA;
        Tue,  3 Oct 2023 18:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696356439;
        bh=Fd4WUD/vikcPxP0MMTf6MFE3KSLS7O7g3JQDsmMO0jk=;
        h=From:To:Cc:Subject:Date:From;
        b=b2mlhvW2SuqLdPBx5esfF/bKPpYaJhg1WuvY9fCwHyJMAxB6E+E+1piZzkf8VGhc9
         9a1EM4b+0Kz4Qz3pNLJ1M9hEKrW4raqLaFmoFq8qoR2sVBVLmfnmcpIF1OJvtYDrRh
         gJDd7H3RqLN0OD9cL6M5TDL/f6jyNZvDkfYL1XjexlNze00R9/CShUDgz/MzxySeA7
         2y3Tfz2slMTVkIbQhQunWc/2a6dMiIDyrMmQfD/wbyJLr6+VvNC62H3mnIJtqCMQ2H
         uga5u2yPrxmceF4W7UtHnW0QSg7yAXNrHBPQCccHYcS6oimh9pP5a0W25suYceorEI
         +9wrIZQ8SFChw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.6-rc4
Date:   Tue, 03 Oct 2023 19:07:11 +0100
Message-Id: <20231003180719.2B712C433CA@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6223e073db78458f8846c380ccd224a7a73a3867:

  regulator: Fix voltage range selection (2023-09-11 13:51:36 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.6-rc4

for you to fetch changes up to 6e800968f6a715c0661716d2ec5e1f56ed9f9c08:

  regulator/core: Revert "fix kobject release warning and memory leak in regulator_register()" (2023-09-26 17:26:08 +0200)

----------------------------------------------------------------
regulator: Fixes for v6.6

Two things here, one is an improved fix for issues around freeing
devices when registration fails which replaces a half baked fix with a
more complete one which uses the device model release() function
properly.  The other fix is a device specific fix for mt6358, the driver
said that the LDOs supported mode configuration but this is not actually
the case and could cause issues.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      regulator: mt6358: split ops for buck and linear range LDO regulators

Michał Mirosław (2):
      regulator/core: regulator_register: set device->class earlier
      regulator/core: Revert "fix kobject release warning and memory leak in regulator_register()"

 drivers/regulator/core.c             | 10 +++-------
 drivers/regulator/mt6358-regulator.c | 18 +++++++++++++++---
 2 files changed, 18 insertions(+), 10 deletions(-)
