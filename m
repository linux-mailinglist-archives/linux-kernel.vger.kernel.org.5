Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED87FDB30
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjK2PY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjK2PYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:24:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0447C90
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:25:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241E9C433C7;
        Wed, 29 Nov 2023 15:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701271501;
        bh=cZBkVWd4/6X6QdhqP9qGKmaGIqbyGs6bbXMaN3ewrnE=;
        h=From:Subject:Date:To:Cc:From;
        b=QhX2ObSP4vuiRN89P3DObSkygZj45XzBHq0O57ay8hpLuz5qJM3jzw1br1tonuGM6
         U4mtnbvtDNL20/7q18PRF+qQ4asBaD71fkpzgZy2BXwVGsHJqlwBJWQlcEZ5Htijr7
         LigfN2aX4Pd5kYkZ7GP3kIoBtkzYOJj/hd0NrTZGkE43xtz/ceqs94MWHOh3mTB+u2
         JgzrKS6xJR1/NJFlY/w8hS2dV6RODrdJCRCIdaAz/s6QsCPPsLmRJcEXUaA18J88cY
         CKXHXhYSrWEOxmo04eJHvaOGJlzuW+aesKSW8eTmH3cnq/AL6T+QqMOom0nIsGCZJZ
         Ntp5bte5WOf2w==
From:   Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 00/12] selftests/hid: tablets fixes
Date:   Wed, 29 Nov 2023 16:24:25 +0100
Message-Id: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlXZ2UC/x3MMQqAMAxA0atIZgtNFBWvIg5FowZEpSkqlN7d4
 viG/yMoe2GFvojg+RaV88jAsoBpc8fKRuZsIEsVIqF55DLK+xJYgxpr0U01tWy7BnJzeV7k/X/
 DmNIHXPFSuF8AAAA=
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=1942;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=cZBkVWd4/6X6QdhqP9qGKmaGIqbyGs6bbXMaN3ewrnE=;
 b=sAY39EC2SafO3vFoESZlRu2bryuijrK3ykmpRUQU/H9rmM2cLfZt1Y+vBZSgqfpI1hDW4or2b
 kF/NgbmL04wDPW1m3dNaZx6nhX6BwGZPQ7wdd8xJUP1p+qLGRWH2DuO
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the main trigger of this series was the XP-Pen issue[0].
Basically, the tablets tests were good-ish but couldn't
handle that tablet both in terms of emulation or in terms
of detection of issues.

So rework the tablets test a bit to be able to include the
XP-Pen patch later, once I have a kernel fix for it (right
now I only have a HID-BPF fix, meaning that the test will
fail if I include them).

Also, vmtest.sh needed a little bit of care, because
boot2container moved, and I made it easier to reuse in a CI
environment.

Cheers,
Benjamin

[0] https://lore.kernel.org/all/nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm/

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (12):
      selftests/hid: vmtest.sh: update vm2c and container
      selftests/hid: vmtest.sh: allow finer control on the build steps
      selftests/hid: base: allow for multiple skip_if_uhdev
      selftests/hid: tablets: remove unused class
      selftests/hid: tablets: move the transitions to PenState
      selftests/hid: tablets: move move_to function to PenDigitizer
      selftests/hid: tablets: do not set invert when the eraser is used
      selftests/hid: tablets: set initial data for tilt/twist
      selftests/hid: tablets: add variants of states with buttons
      selftests/hid: tablets: convert the primary button tests
      selftests/hid: tablets: add a secondary barrel switch test
      selftests/hid: tablets: be stricter for some transitions

 tools/testing/selftests/hid/tests/base.py        |   3 +-
 tools/testing/selftests/hid/tests/test_tablet.py | 727 ++++++++++++++++-------
 tools/testing/selftests/hid/vmtest.sh            |  46 +-
 3 files changed, 525 insertions(+), 251 deletions(-)
---
base-commit: 4ea4ed22b57846facd9cb4af5f67cb7bd2792cf3
change-id: 20231121-wip-selftests-001ac427e086

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

