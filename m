Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCD17DD954
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbjJaXnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjJaXng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:43:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD98C9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:43:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46646C433C8;
        Tue, 31 Oct 2023 23:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698795813;
        bh=LZidkhmWPd0BPJAPu1EE0DgDhb2QBw5/INdFeh2MEIo=;
        h=Date:From:To:cc:Subject:From;
        b=ZE4TnqtLMda5OZbWOdyjK2DUQI5RiN2h5UgELaazIGvjERXmjacBpI0d0Cva58Xaw
         vS/UI8C/pgX+xsw6144WhiFMP6JMD1SM7d1Jo4l3gPWsmNSCfjjvsscI/+ecsY9PKE
         xb3L0VUVUULfU3ZnPIELZ6v2c5oILhsd8ejPOQc17p/C/RJf407+ph3dxFrErAqatz
         +w3DqCLBVjoJDiEdwr5OS26yGLfIsvuWCjhH5/UWkvUmOoEI+ZxMvVsiInKKZDOEJP
         sQxoNOBwgAHC+oML6paYjGTZBBrhY+HwA9+ZDUQ6DGwYyDa50FhIeyquKBnnRPJd8w
         s+5x4Rp8kJ8/Q==
Date:   Wed, 1 Nov 2023 00:43:29 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID for 6.7
Message-ID: <nycvar.YFH.7.76.2311010039000.3534@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023110101

to receive HID subsystem patches queued for 6.7; namely:

=====
- fixes for crashes detected by CONFIG_KUNIT_ALL_TESTS in hid-uclogic 
  driver (Jinjie Ruan)

- HID selftests fixes and improvements (Benjamin Tissoires)

- probe error handling path fixes in hid-nvidia-shield driver (Christophe 
  JAILLET)

- cleanup of LED handling in hid-nintendo (Martino Fontana)

- big cleanup of logitech-hidpp probe code (Hans de Goede)

- Suspend/Resume fix for USB Thinkpad Compact Keyboard (Jamie Lentin)

- firmware detection improvement for Lenovo cptkbd (Mikhail Khvainitski)

- IRQ shutdown and workqueue initialization fixes for hid-cp2112 driver 
  (Danny Kaehn)

- #ifdef CONFIG_PM removal from HID code (Thomas Weiﬂschuh)

- other assorted device-ID additions and quirks
=====

----------------------------------------------------------------
Benjamin Tissoires (3):
      selftests/hid: ensure we can compile the tests on kernels pre-6.3
      selftests/hid: do not manually call headers_install
      selftests/hid: force using our compiled libbpf headers

Christophe JAILLET (3):
      HID: nvidia-shield: Fix a missing led_classdev_unregister() in the probe error handling path
      HID: nvidia-shield: Fix some missing function calls() in the probe error handling path
      HID: nvidia-shield: Introduce thunderstrike_destroy()

Danny Kaehn (2):
      hid: cp2112: Fix duplicate workqueue initialization
      hid: cp2112: Fix IRQ shutdown stopping polling for all IRQs on chip

Hans de Goede (13):
      HID: logitech-hidpp: Don't restart IO, instead defer hid_connect() only
      HID: logitech-hidpp: Revert "Don't restart communication if not necessary"
      HID: logitech-hidpp: Move get_wireless_feature_index() check to hidpp_connect_event()
      HID: logitech-hidpp: Remove wtp_get_config() call from probe()
      HID: logitech-hidpp: Move g920_get_config() to just before hidpp_ff_init()
      HID: logitech-hidpp: Move hidpp_overwrite_name() to before connect check
      HID: logitech-hidpp: Add hidpp_non_unifying_init() helper
      HID: logitech-hidpp: Remove connected check for non-unifying devices
      HID: logitech-hidpp: Remove unused connected param from *_connect()
      HID: logitech-hidpp: Fix connect event race
      HID: logitech-hidpp: Drop delayed_work_cb()
      HID: logitech-hidpp: Drop HIDPP_QUIRK_UNIFYING
      HID: logitech-hidpp: Stop IO before calling hid_connect()

Jamie Lentin (1):
      hid: lenovo: Resend all settings on reset_resume for compact keyboards

Jinjie Ruan (2):
      HID: uclogic: Fix user-memory-access bug in uclogic_params_ugee_v2_init_event_hooks()
      HID: uclogic: Fix a work->entry not empty bug in __queue_work()

Jiri Kosina (9):
      HID: Add quirk for Dell Pro Wireless Keyboard and Mouse KM5221W

Martino Fontana (1):
      HID: nintendo: cleanup LED code

Mikhail Khvainitski (1):
      HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround

Thomas Weiﬂschuh (4):
      HID: core: remove #ifdef CONFIG_PM from hid_driver
      HID: usbhid: remove #ifdef CONFIG_PM
      HID: multitouch: remove #ifdef CONFIG_PM
      HID: rmi: remove #ifdef CONFIG_PM

 drivers/hid/hid-cp2112.c                           |  10 +-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-lenovo.c                           | 118 +++++++++-----
 drivers/hid/hid-logitech-hidpp.c                   | 174 ++++++++-------------
 drivers/hid/hid-multitouch.c                       |  10 +-
 drivers/hid/hid-nintendo.c                         | 133 +++++++++-------
 drivers/hid/hid-nvidia-shield.c                    |  21 +--
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/hid/hid-rmi.c                              |  10 +-
 drivers/hid/hid-uclogic-core-test.c                |   7 +
 drivers/hid/hid-uclogic-params-test.c              |  16 +-
 drivers/hid/usbhid/hid-core.c                      |  11 +-
 include/linux/hid.h                                |   4 +-
 tools/testing/selftests/hid/Makefile               |  10 +-
 tools/testing/selftests/hid/progs/hid.c            |   3 -
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  77 +++++++++
 16 files changed, 352 insertions(+), 254 deletions(-)

-- 
Jiri Kosina
SUSE Labs

