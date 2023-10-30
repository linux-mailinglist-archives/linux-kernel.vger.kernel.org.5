Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF60E7DBADD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjJ3NeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjJ3NeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:34:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C2EA2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:34:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256A7C433C7;
        Mon, 30 Oct 2023 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698672844;
        bh=Myt5og+pg1HfyOP6hyyy1jAtd0jLpMjg1qLJ4J0X1Po=;
        h=From:To:Cc:Subject:Date:From;
        b=sjfNx8oLyx2JrW2DnCneYandzUUtyZRzqaTmpv9pbmZcNlgYd1bvxuvschwuQuLlf
         Fdj2nCWVby7p3jROxBVk4D1zwlgzNLEJOeOdiTBvoSiyvtShYoe7d0jb2tt43KIHqx
         N9NfM0k1dM4veomxdRyuWbv+juIr23BDW7V+wvdmXG/T4ds06fr+7SvMuZXvOaLh2q
         yZ0YA5WiOsto+xZIGXhxRI/fLcDIg4+1Z4cn+24qbxVccl9kHZ8D54RLjqDKL/gxZ0
         Q/1j4LzpgBryU6QRi/ZqqMJyvhyBRN1ma8aSnj4epNqg+HHrHvUZT1VUbVKU9NEAeV
         pe2VxZmof/2kA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.7
Date:   Mon, 30 Oct 2023 13:33:54 +0000
Message-Id: <20231030133404.256A7C433C7@smtp.kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c6df843348d6b71ea986266c12831cb60c2cf325:

  regmap: fix NULL deref on lookup (2023-10-09 13:13:53 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.7

for you to fetch changes up to 6bbebcc11a69aef269eb2a33212f76992a4cfb1a:

  regmap: Merge up fix for window/paging issue (2023-10-30 13:05:15 +0000)

----------------------------------------------------------------
regmap: Updates for v6.7

The main change here is a fix for an issue where we were letting the
selector for windowed register ranges get out of sync with the hardware
during a cache sync plus associated KUnit tests.  This was reported just
at the end of the release cycle and only in -next for a day prior to the
merge window so it seemed better to hold off for now, the bug had been
present for more than a decade so wasn't causing too many practical
problems hopefully.  There's also a fix for error handling in the
debugfs output from Christope Jaillet.

----------------------------------------------------------------
Christophe JAILLET (1):
      regmap: debugfs: Fix a erroneous check after snprintf()

Mark Brown (4):
      regmap: kunit: Fix marking of the range window as volatile
      regmap: kunit: Add test for cache sync interaction with ranges
      regmap: Ensure range selector registers are updated after cache sync
      regmap: Merge up fix for window/paging issue

 drivers/base/regmap/regcache.c       | 30 ++++++++++++++++
 drivers/base/regmap/regmap-debugfs.c |  2 +-
 drivers/base/regmap/regmap-kunit.c   | 68 ++++++++++++++++++++++++++++++++++--
 3 files changed, 96 insertions(+), 4 deletions(-)
