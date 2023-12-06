Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBCE806C70
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377588AbjLFKqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377576AbjLFKqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30316D6D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13FCC433C7;
        Wed,  6 Dec 2023 10:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859567;
        bh=MP5Osqlk3WWNvfz1umQL4sknHomsrrNZ86F+mX66gqk=;
        h=From:Subject:Date:To:Cc:From;
        b=Vv8bVqp2O73pOUsQgqYfaeWi+3TOeCIJt97guWPdh9zct6Y6R1QAWpa3khsidJCQJ
         f6C++TP6HtzbWRI7TSTbsz+SfBuJa4L3Gpwtel6yd1PDTr46b3r/eNnEb73w11a5cy
         vIAW486Cq5wgeDtTEwiJ3XkVQRbc0n+UNU2MPJo1Y0c0ZJgGpMuLOjt21h01k04pXn
         7PqFMnUbZUZso+VsI7DG4FBNi10PEPlpOsg99SO6nN3Q4vnDrX5D1zu/k1oMXPHA/4
         7BgLlxAAjo0tDlbFfvvrHMBeKUXcH4GoLjXtlnnHSBOxJBD94igHQ0vGTilgBtQuoN
         iyWd52/MeHgGQ==
From:   Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v2 00/15] selftests/hid: tablets fixes
Date:   Wed, 06 Dec 2023 11:45:51 +0100
Message-Id: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN9QcGUC/13MywrCMBCF4VcpszaSiXdXvod0kbaTdrA0JROiU
 vLuxoIbl/+B8y0gFJgErtUCgRIL+6mE2VTQDnbqSXFXGow2O0SD6smzEhpdJImitEbb7s2J9Pk
 I5TMHcvxavXtdemCJPrxXPuF3/UmXPymh0qqxeLDoCBvd3R4UJhq3PvRQ55w/jlbesqsAAAA=
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=2588;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=MP5Osqlk3WWNvfz1umQL4sknHomsrrNZ86F+mX66gqk=;
 b=yRG7lL0VsLWZfjQjVIZklm361Zje0ATbNRtCMBXruossTn9s51/kgTVezacnjtazhcOJjaZkV
 5JZMgPzMqo3AaOi3Ew/NYH3WcFjwgDJgzT50o4hikvwTwsRdUYja/l+
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Note: I got the confirmation off-list from Peter that his
rev-by applied to the whole series.

[0] https://lore.kernel.org/all/nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm/

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v2:
- took Peter's review into account
- Added a few patches to make mypy and ruff happy given that
  I had to add a couple of type hints here and there
- Link to v1: https://lore.kernel.org/r/20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org

---
Benjamin Tissoires (15):
      selftests/hid: vmtest.sh: update vm2c and container
      selftests/hid: vmtest.sh: allow finer control on the build steps
      selftests/hid: base: allow for multiple skip_if_uhdev
      selftests/hid: tablets: remove unused class
      selftests/hid: tablets: move the transitions to PenState
      selftests/hid: tablets: move move_to function to PenDigitizer
      selftests/hid: tablets: do not set invert when the eraser is used
      selftests/hid: tablets: set initial data for tilt/twist
      selftests/hid: tablets: define the elements of PenState
      selftests/hid: tablets: add variants of states with buttons
      selftests/hid: tablets: convert the primary button tests
      selftests/hid: tablets: add a secondary barrel switch test
      selftests/hid: tablets: be stricter for some transitions
      selftests/hid: fix mypy complains
      selftests/hid: fix ruff linter complains

 tools/testing/selftests/hid/tests/base.py          |   7 +-
 tools/testing/selftests/hid/tests/test_mouse.py    |  14 +-
 tools/testing/selftests/hid/tests/test_tablet.py   | 764 ++++++++++++++-------
 .../selftests/hid/tests/test_wacom_generic.py      |   6 +-
 tools/testing/selftests/hid/vmtest.sh              |  46 +-
 5 files changed, 567 insertions(+), 270 deletions(-)
---
base-commit: 4ea4ed22b57846facd9cb4af5f67cb7bd2792cf3
change-id: 20231121-wip-selftests-001ac427e086

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

