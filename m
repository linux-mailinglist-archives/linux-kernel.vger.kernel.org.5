Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8691D751588
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjGMAxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGMAxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:53:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E2EE5C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD34F61904
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71608C433C7;
        Thu, 13 Jul 2023 00:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209621;
        bh=DcoEvYheopgrQDi8DNh3R3S9w3R74TioORNRzPvufsU=;
        h=From:Subject:Date:To:Cc:From;
        b=qBedp93f9ec/meBoS/A3SOlbv/DZI+Jb+G5DVOui8AxANEsJ8dOLRfvrMBsoXUMYQ
         TvRGgAggQ0dvLpwbBpnqLx2NhrdWOMPpjV5KfdugKJ77WoSwWvsYhAMHFIptUX4BoK
         BDvFHCzRrHbRjGc/oAbOVTZoh+8gvxF29KNA8ZzorhIH3g+g1NLEufro8WgUWNCAnc
         I+WvFr+qI8hVYNitLBTXNtwFk4zzRa0NX/5cwXTpZy2hPGnI3jQ/Kig+KqPm1WQ7hX
         I2zFZwtU7qDulE/P6k4NKVFYTfNgzP94yUohDU2oYymbdNCa24r9Bs1vF1i7mqa7wk
         PybPo06JOcqfA==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 00/11] mfd:: Update Cirrus Logic drivers to use maple tree
 register caches
Date:   Thu, 13 Jul 2023 01:49:18 +0100
Message-Id: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA5Kr2QC/x2NQQrCQAwAv1JyNlCztYhfEQ/ZbWoD7lqSKkLp3
 932OAzDrOBiKg63ZgWTr7q+S4XzqYE0cXkK6lAZqKXQ9hQwjwMmNfs4Zp5fgl0MdO3DhSIz1Cy
 yC0bjkqY9zOyL2C5mk1F/x+v+2LY/Vx0VmnsAAAA=
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1906; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DcoEvYheopgrQDi8DNh3R3S9w3R74TioORNRzPvufsU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkr0sJ6BvFNMfr6b/z11DVDFKXT92YsUbBF8hTV
 aZQReHc9gKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK9LCQAKCRAk1otyXVSH
 0ImRB/0bh89vd7Y1kkagOtJ9hrsYWv/LfYtlll/I1kStvRUK6h97GJWOEqz9qByUVnPyxxUwoHm
 LYTkzS1lae7cCwcrGtiHPZI7hIv7m+5Q/o5H3wi6I636MpflRzub3ryMUJJKT3HQU2ploTNQvKT
 Xrj+XD/YQqFm+QpSj9s8OqBcnGqPZald5BQLu8qrKrwHs60+tjBqe75UK6ZF/n/LLBe4VTbKHZn
 YZ3KOTWVBsnyFDNf8CCyGMqlvNrktuvZ+X/u11z5rt+oVCq2+/a2preFjupzIdmbc6sicthnSgt
 IKldpz+b0kSOKTkZY9sz9pnqzWO03VPsxVobyRpgIVb/6aHM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the v6.5 merge window the maple tree register cache has acquired
the ability to generate multi-register writes during sync operations,
removing the last major limitation it had compared to the rbtree cache.
As part of a general modernisation effort update the Cirrus Logic
drivers to use the more modern data structure, realistically there is
likely to be very little user visible impact either way but generally
the implementation choices of the maple tree cache should be a bit
better on modern hardware.

Signed-off-by: Mark
---
Mark Brown (11):
      mfd: cs47l15: Update to use maple tree register cache
      mfd: cs47l24: Update to use maple tree register cache
      mfd: cs47l35: Update to use maple tree register cache
      mfd: cs47l85: Update to use maple tree register cache
      mfd: cs47l90: Update to use maple tree register cache
      mfd: cs47l92: Update to use maple tree register cache
      mfd: wm5102: Update to use maple tree register cache
      mfd: wm5110: Update to use maple tree register cache
      mfd: wm8994: Update to use maple tree register cache
      mfd: wm8997: Update to use maple tree register cache
      mfd: wm8998: Update to use maple tree register cache

 drivers/mfd/cs47l15-tables.c | 8 ++++----
 drivers/mfd/cs47l24-tables.c | 2 +-
 drivers/mfd/cs47l35-tables.c | 8 ++++----
 drivers/mfd/cs47l85-tables.c | 8 ++++----
 drivers/mfd/cs47l90-tables.c | 8 ++++----
 drivers/mfd/cs47l92-tables.c | 8 ++++----
 drivers/mfd/wm5102-tables.c  | 2 +-
 drivers/mfd/wm5110-tables.c  | 2 +-
 drivers/mfd/wm8994-regmap.c  | 6 +++---
 drivers/mfd/wm8997-tables.c  | 2 +-
 drivers/mfd/wm8998-tables.c  | 2 +-
 11 files changed, 28 insertions(+), 28 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230623-mfd-cirrus-maple-4b3286352baa

Best regards,
-- 
Mark Brown <broonie@kernel.org>

