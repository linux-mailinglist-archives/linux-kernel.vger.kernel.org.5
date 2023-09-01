Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E778FECA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349921AbjIAOMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbjIAOMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BA810EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693577501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/g+xuJSJTHYapv7WY6W6kzRywq8rg8ys+f2/vq8yK10=;
        b=KX9WEC4WdWtV4x/NEAkQd/xYIW6p6uxZmS3us8OKqcwyE14vxRD7pDDtXFPeIteua10epQ
        5Ug0RLnAE59G9WVzfA8GpWm4nINznJUKldrg6giity/dLlHiQDB5ZDOyTozb+YQ8Cc0pki
        eZJRZaHKxDNIU8wb+YlTIQhdpa7sXik=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-nGZ7AK73NVqK0feNQDXKIg-1; Fri, 01 Sep 2023 10:11:33 -0400
X-MC-Unique: nGZ7AK73NVqK0feNQDXKIg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6ff15946fso27900201fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 07:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693577490; x=1694182290;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/g+xuJSJTHYapv7WY6W6kzRywq8rg8ys+f2/vq8yK10=;
        b=aXowTbrNl/uVOR3kXqVkgK/IO2wuB7+seBPM22YuKHOKIg3ddDV7DCXxnLni+VD2Sh
         vubqAXxNG60M1/dqlz53c3pnEOtFJjD7Q240oShDoKEKhJagwsZRfeLKhjrWRY8x53SI
         iH3ehtmnJRfx5lp9mwjMBtrUu8sJfY6q85A2jDCTmOh4RXu/ZZXgibgZMDUDzHXOFquc
         UUUK5OZZDGRb2J97+6BZG+rKHMOViD2XyB2mJtQqK4Ld4UKXjPlNQq+3HthX6TJtOMr1
         sqX3w367J5y8QBpWsWpSl8ILAvUDAI0XLYggr5CyZ61kNey1Rq5Z5Dn4PGT4Ykpin1CC
         eC7g==
X-Gm-Message-State: AOJu0YzoFpmGH8YSWingihhVK+rmrE02c4TReQ4wk8NKAIpnPqv/k3QM
        bHnUwrDFtkDO5ACpJWTPH4IX2ZpAeh4Cex3ny/S27NNnLWlC14VxYm99SlU2o4xJEn6ZXK4Areq
        BrhI6a6PgA17DmDwjTwUwKRYr3pgRozwS
X-Received: by 2002:a2e:9d8d:0:b0:2bb:b01a:9226 with SMTP id c13-20020a2e9d8d000000b002bbb01a9226mr1781626ljj.7.1693577489966;
        Fri, 01 Sep 2023 07:11:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKPg0wlepwuk0D2vDqTm34CbDhwD/fa53fen6rHjBdem6EbEy3FFWa0JC2k8hO8d98gfGR+Q==
X-Received: by 2002:a2e:9d8d:0:b0:2bb:b01a:9226 with SMTP id c13-20020a2e9d8d000000b002bbb01a9226mr1781603ljj.7.1693577489518;
        Fri, 01 Sep 2023 07:11:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170907984300b00992b2c55c67sm2016445ejc.156.2023.09.01.07.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 07:11:28 -0700 (PDT)
Message-ID: <81a2b354-1967-d647-34b2-9721af85bde6@redhat.com>
Date:   Fri, 1 Sep 2023 16:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.6-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for 6.6.

Highlights:
 -  hp-bioscfg:  New firmware-attributes driver for changing BIOS settings
                 from within Linux
 -  asus-wmi:    Add charger mode, middle fan and eGPU settings support
 -  ideapad:     Support keyboard backlight control on more models
 -  mellanox:    Support for new models
 -  sel-3350:    New LED and power-supply driver for this industrial mainboard
 -  simatic-ipc: Add RTC battery monitor and various new models support
 -  Miscellaneous other cleanups / fixes

Regards,

Hans


The following changes since commit 0848cab765c634597636810bf76d0934003cce28:

  platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifications (2023-08-23 17:13:36 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-1

for you to fetch changes up to acce85a7dd28eac3858d44230f4c65985d0f271c:

  platform/x86: asus-wmi: corrections to egpu safety check (2023-08-30 15:25:18 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.6-1

Highlights:
 -  hp-bioscfg:  New firmware-attributes driver for changing BIOS settings
                 from within Linux
 -  asus-wmi:    Add charger mode, middle fan and eGPU settings support
 -  ideapad:     Support keyboard backlight control on more models
 -  mellanox:    Support for new models
 -  sel-3350:    New LED and power-supply driver for this industrial mainboard
 -  simatic-ipc: Add RTC battery monitor and various new models support
 -  Miscellaneous other cleanups / fixes

The following is an automated git shortlog grouped by driver:

Add SEL-3350 platform driver:
 -  Add SEL-3350 platform driver

Documentation/ABI:
 -  Add new attribute for mlxreg-io sysfs interfaces

MAINTAINERS:
 -  Add entries for Siemens IPC modules

Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-hans:
 -  Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-hans

Merge remote-tracking branch 'pdx86/fixes' into pdx86/for-next:
 -  Merge remote-tracking branch 'pdx86/fixes' into pdx86/for-next

Merge remote-tracking branch 'pdx86/platform-drivers-x86-simatic-ipc' into review-hans:
 -  Merge remote-tracking branch 'pdx86/platform-drivers-x86-simatic-ipc' into review-hans

Merge tag 'ib-pdx86-simatic-v6.6' into review-hans:
 -  Merge tag 'ib-pdx86-simatic-v6.6' into review-hans

Merge tag 'ib-pdx86-simatic-v6.6-2' into review-hans:
 -  Merge tag 'ib-pdx86-simatic-v6.6-2' into review-hans

Move all simatic ipc drivers to the subdirectory siemens:
 -  Move all simatic ipc drivers to the subdirectory siemens

asus-wmi:
 -  corrections to egpu safety check
 -  Fix support for showing middle fan RPM
 -  expose dGPU and CPU tunables for ROG
 -  support setting mini-LED mode
 -  add safety checks to gpu switching
 -  don't allow eGPU switching if eGPU not connected
 -  add WMI method to show if egpu connected
 -  support middle fan custom curves
 -  add support for showing middle fan RPM
 -  add support for showing charger mode

dell-sysman:
 -  Fix reference leak

doc:
 -  TPMI: Add debugfs documentation

hp-bioscfg:
 -  Update steps order list elements are evaluated
 -  Use kmemdup() to replace kmalloc + memcpy
 -  Remove duplicate use of variable in inner loop
 -  Change how password encoding size is evaluated
 -  Change how enum possible values size is evaluated
 -  Change how order list size is evaluated
 -  Change how prerequisites size is evaluated
 -  Replace the word HACK from source code
 -  Fix uninitialized variable errors
 -  Fix memory leaks in attribute packages
 -  fix error reporting in hp_add_other_attributes()
 -  prevent a small buffer overflow
 -  fix a signedness bug in hp_wmi_perform_query()
 -  MAINTAINERS
 -  Makefile
 -  surestart-attributes
 -  string-attributes
 -  spmobj-attributes
 -  passwdobj-attributes
 -  order-list-attributes
 -  int-attributes
 -  enum-attributes
 -  biosattr-interface
 -  bioscfg
 -  bioscfg-h
 -  Documentation

ideapad-laptop:
 -  Add support for keyboard backlights using KBLC ACPI symbol

leds:
 -  simatic-ipc-leds: default config switch to platform switch

mlx-platform:
 -  Add dependency on PCI to Kconfig

mlxbf-bootctl:
 -  Support sysfs entries for MFG fields
 -  Support setting the ARM boot state to "OS up"
 -  Support the large icmc write/read

p2sb:
 -  Make the Kconfig symbol hidden

platform:
 -  mellanox: nvsw-sn2201: change fans i2c busses.
 -  mellanox: mlxreg-hotplug: Extend condition for notification callback processing
 -  mellanox: Add initial support for PCIe based programming logic device
 -  mellanox: mlx-platform: Get interrupt line through ACPI
 -  mellanox: mlx-platform: Introduce ACPI init flow
 -  mellanox: mlx-platform: Prepare driver to allow probing through ACPI infrastructure
 -  mellanox: mlx-platform: Add reset callback
 -  mellanox: Cosmetic changes
 -  mellanox: mlx-platform: Modify power off callback
 -  mellanox: mlx-platform: add support for additional CPLD
 -  mellanox: mlx-platform: Add reset cause attribute
 -  mellanox: mlx-platform: Modify health and power hotplug action
 -  mellanox: Modify reset causes description
 -  mellanox: Add field upgrade capability register
 -  mellanox: Add new attributes
 -  Explicitly include correct DT includes

platform/x86/amd/pmc:
 -  Fix build error with randconfig
 -  Move PMC driver to separate directory

platform/x86/amd/pmf:
 -  Fix a missing cleanup path
 -  Use str_on_off() helper

platform/x86/intel/tpmi:
 -  Add debugfs interface
 -  Read feature control status

platform/x86/siemens:
 -  simatic-ipc-batt: fix logical error for BX-59A
 -  simatic-ipc: fix logical error for BX-59A
 -  simatic-ipc-batt: fix wrong pointer pass to PTR_ERR()
 -  simatic-ipc-batt: add support for module BX-59A
 -  simatic-ipc: add new models BX-56A/BX-59A
 -  Kconfig: adjust help text
 -  simatic-ipc-batt: fix bat reading in BX_21A

simatic-ipc:
 -  use extra module loading for watchdog
 -  add auto-loading of hwmon modules
 -  add another model
 -  drop PCI runtime depends and header
 -  add CMOS battery monitoring
 -  add another model BX-21A

system76:
 -  Handle new KBLED ACPI methods

thinkpad_acpi:
 -  Switch to memdup_user_nul() helper
 -  use lockdep annotations
 -  take mutex for hotkey_mask_{set,get}

tools/power/x86/intel-speed-select:
 -  v1.17 release
 -  Change mem-frequency display name
 -  Prevent CPU 0 offline
 -  Error on CPU count exceed in request
 -  Support more than 8 sockets.
 -  Fix CPU count display

watchdog:
 -  simatic: Use idiomatic selection of P2SB
 -  simatic: add PCI dependency
 -  make Siemens Simatic watchdog driver default on platform
 -  simatic-ipc-wdt: make IO region access of one model muxed

wmi-bmof:
 -  Update MAINTAINERS entry
 -  Simplify read_bmof()
 -  Use device_create_bin_file()

----------------------------------------------------------------
Andy Shevchenko (3):
      platform/x86/amd/pmf: Use str_on_off() helper
      platform/x86: p2sb: Make the Kconfig symbol hidden
      watchdog: simatic: Use idiomatic selection of P2SB

Armin Wolf (4):
      platform/x86: wmi-bmof: Use device_create_bin_file()
      platform/x86: wmi-bmof: Simplify read_bmof()
      platform/x86: wmi-bmof: Update MAINTAINERS entry
      platform/x86: dell-sysman: Fix reference leak

Arnd Bergmann (1):
      watchdog: simatic: add PCI dependency

Asmaa Mnebhi (2):
      mlxbf-bootctl: Support the large icmc write/read
      mlxbf-bootctl: Support setting the ARM boot state to "OS up"

Dan Carpenter (3):
      platform/x86: hp-bioscfg: fix a signedness bug in hp_wmi_perform_query()
      platform/x86: hp-bioscfg: prevent a small buffer overflow
      platform/x86: hp-bioscfg: fix error reporting in hp_add_other_attributes()

David Thompson (1):
      mlxbf-bootctl: Support sysfs entries for MFG fields

Frank Ramsay (1):
      tools/power/x86/intel-speed-select: Support more than 8 sockets.

Gerd Haeussler (1):
      MAINTAINERS: Add entries for Siemens IPC modules

Hans de Goede (5):
      Merge tag 'ib-pdx86-simatic-v6.6' into review-hans
      Merge tag 'ib-pdx86-simatic-v6.6-2' into review-hans
      Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-hans
      Merge remote-tracking branch 'pdx86/platform-drivers-x86-simatic-ipc' into review-hans
      Merge remote-tracking branch 'pdx86/fixes' into pdx86/for-next

Henning Schild (11):
      platform/x86: simatic-ipc: add another model BX-21A
      watchdog: simatic-ipc-wdt: make IO region access of one model muxed
      platform/x86: simatic-ipc: add CMOS battery monitoring
      platform/x86: simatic-ipc: drop PCI runtime depends and header
      platform/x86: simatic-ipc: add another model
      platform/x86: simatic-ipc: add auto-loading of hwmon modules
      platform/x86: simatic-ipc: use extra module loading for watchdog
      watchdog: make Siemens Simatic watchdog driver default on platform
      leds: simatic-ipc-leds: default config switch to platform switch
      platform/x86: Move all simatic ipc drivers to the subdirectory siemens
      platform/x86/siemens: Kconfig: adjust help text

Jorge Lopez (22):
      platform/x86: hp-bioscfg: Documentation
      platform/x86: hp-bioscfg: bioscfg-h
      platform/x86: hp-bioscfg: bioscfg
      platform/x86: hp-bioscfg: biosattr-interface
      platform/x86: hp-bioscfg: enum-attributes
      platform/x86: hp-bioscfg: int-attributes
      platform/x86: hp-bioscfg: order-list-attributes
      platform/x86: hp-bioscfg: passwdobj-attributes
      platform/x86: hp-bioscfg: spmobj-attributes
      platform/x86: hp-bioscfg: string-attributes
      platform/x86: hp-bioscfg: surestart-attributes
      platform/x86: hp-bioscfg: Makefile
      platform/x86: hp-bioscfg: MAINTAINERS
      platform/x86: hp-bioscfg: Fix memory leaks in attribute packages
      platform/x86: hp-bioscfg: Fix uninitialized variable errors
      platform/x86: hp-bioscfg: Replace the word HACK from source code
      platform/x86: hp-bioscfg: Change how prerequisites size is evaluated
      platform/x86: hp-bioscfg: Change how order list size is evaluated
      platform/x86: hp-bioscfg: Change how enum possible values size is evaluated
      platform/x86: hp-bioscfg: Change how password encoding size is evaluated
      platform/x86: hp-bioscfg: Remove duplicate use of variable in inner loop
      platform/x86: hp-bioscfg: Update steps order list elements are evaluated

Li Zetao (1):
      platform/x86: hp-bioscfg: Use kmemdup() to replace kmalloc + memcpy

Luke D. Jones (10):
      platform/x86: asus-wmi: add support for showing charger mode
      platform/x86: asus-wmi: add support for showing middle fan RPM
      platform/x86: asus-wmi: support middle fan custom curves
      platform/x86: asus-wmi: add WMI method to show if egpu connected
      platform/x86: asus-wmi: don't allow eGPU switching if eGPU not connected
      platform/x86: asus-wmi: add safety checks to gpu switching
      platform/x86: asus-wmi: support setting mini-LED mode
      platform/x86: asus-wmi: expose dGPU and CPU tunables for ROG
      platform/x86: asus-wmi: Fix support for showing middle fan RPM
      platform/x86: asus-wmi: corrections to egpu safety check

Mario Limonciello (1):
      platform/x86/amd/pmf: Fix a missing cleanup path

Michael Shych (1):
      platform: mellanox: nvsw-sn2201: change fans i2c busses.

Rob Herring (1):
      platform: Explicitly include correct DT includes

Robert Joslyn (1):
      platform/x86: Add SEL-3350 platform driver

Ruan Jinjie (1):
      platform/x86: thinkpad_acpi: Switch to memdup_user_nul() helper

Shyam Sundar S K (2):
      platform/x86/amd/pmc: Move PMC driver to separate directory
      platform/x86/amd/pmc: Fix build error with randconfig

Srinivas Pandruvada (8):
      platform/x86/intel/tpmi: Read feature control status
      platform/x86/intel/tpmi: Add debugfs interface
      doc: TPMI: Add debugfs documentation
      tools/power/x86/intel-speed-select: Fix CPU count display
      tools/power/x86/intel-speed-select: Error on CPU count exceed in request
      tools/power/x86/intel-speed-select: Prevent CPU 0 offline
      tools/power/x86/intel-speed-select: Change mem-frequency display name
      tools/power/x86/intel-speed-select: v1.17 release

Stuart Hayhurst (1):
      platform/x86: ideapad-laptop: Add support for keyboard backlights using KBLC ACPI symbol

Thomas Weißschuh (2):
      platform/x86: thinkpad_acpi: take mutex for hotkey_mask_{set,get}
      platform/x86: thinkpad_acpi: use lockdep annotations

Tim Crawford (1):
      platform/x86: system76: Handle new KBLED ACPI methods

Vadim Pasternak (16):
      platform: mellanox: Add new attributes
      platform: mellanox: Add field upgrade capability register
      platform: mellanox: Modify reset causes description
      platform: mellanox: mlx-platform: Modify health and power hotplug action
      platform: mellanox: mlx-platform: Add reset cause attribute
      platform: mellanox: mlx-platform: add support for additional CPLD
      platform: mellanox: mlx-platform: Modify power off callback
      platform: mellanox: Cosmetic changes
      platform: mellanox: mlx-platform: Add reset callback
      platform: mellanox: mlx-platform: Prepare driver to allow probing through ACPI infrastructure
      platform: mellanox: mlx-platform: Introduce ACPI init flow
      platform: mellanox: mlx-platform: Get interrupt line through ACPI
      platform: mellanox: Add initial support for PCIe based programming logic device
      platform: mellanox: mlxreg-hotplug: Extend condition for notification callback processing
      Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces
      platform/x86: mlx-platform: Add dependency on PCI to Kconfig

Yang Yingliang (1):
      platform/x86/siemens: simatic-ipc-batt: fix wrong pointer pass to PTR_ERR()

xingtong.wu (5):
      platform/x86/siemens: simatic-ipc-batt: fix bat reading in BX_21A
      platform/x86/siemens: simatic-ipc: add new models BX-56A/BX-59A
      platform/x86/siemens: simatic-ipc-batt: add support for module BX-59A
      platform/x86/siemens: simatic-ipc: fix logical error for BX-59A
      platform/x86/siemens: simatic-ipc-batt: fix logical error for BX-59A

 Documentation/ABI/stable/sysfs-driver-mlxreg-io    |   53 +
 Documentation/ABI/testing/debugfs-tpmi             |   31 +
 .../ABI/testing/sysfs-class-firmware-attributes    |  101 +-
 Documentation/ABI/testing/sysfs-platform-asus-wmi  |   88 ++
 .../ABI/testing/sysfs-platform-mellanox-bootctl    |   66 ++
 MAINTAINERS                                        |   41 +-
 drivers/leds/simple/Kconfig                        |    1 +
 drivers/platform/chrome/cros_ec.c                  |    1 +
 drivers/platform/mellanox/mlxbf-bootctl.c          |  505 ++++++++++
 drivers/platform/mellanox/mlxbf-bootctl.h          |   27 +
 drivers/platform/mellanox/mlxreg-hotplug.c         |    3 +-
 drivers/platform/mellanox/mlxreg-io.c              |    1 -
 drivers/platform/mellanox/nvsw-sn2201.c            |   12 +-
 drivers/platform/x86/Kconfig                       |   31 +-
 drivers/platform/x86/Makefile                      |    5 +-
 drivers/platform/x86/amd/Kconfig                   |   16 +-
 drivers/platform/x86/amd/Makefile                  |    3 +-
 drivers/platform/x86/amd/pmc/Kconfig               |   20 +
 drivers/platform/x86/amd/pmc/Makefile              |    8 +
 drivers/platform/x86/amd/{ => pmc}/pmc-quirks.c    |    0
 drivers/platform/x86/amd/{ => pmc}/pmc.c           |    0
 drivers/platform/x86/amd/{ => pmc}/pmc.h           |    0
 drivers/platform/x86/amd/pmf/cnqf.c                |    5 +-
 drivers/platform/x86/amd/pmf/core.c                |    3 +-
 drivers/platform/x86/asus-wmi.c                    |  646 +++++++++++-
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c |    9 +-
 drivers/platform/x86/hp/Kconfig                    |   16 +
 drivers/platform/x86/hp/Makefile                   |    1 +
 drivers/platform/x86/hp/hp-bioscfg/Makefile        |   11 +
 .../x86/hp/hp-bioscfg/biosattr-interface.c         |  312 ++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c       | 1063 ++++++++++++++++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h       |  487 +++++++++
 .../platform/x86/hp/hp-bioscfg/enum-attributes.c   |  457 +++++++++
 .../platform/x86/hp/hp-bioscfg/int-attributes.c    |  418 ++++++++
 .../x86/hp/hp-bioscfg/order-list-attributes.c      |  441 ++++++++
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c       |  556 ++++++++++
 .../platform/x86/hp/hp-bioscfg/spmobj-attributes.c |  381 +++++++
 .../platform/x86/hp/hp-bioscfg/string-attributes.c |  395 ++++++++
 .../x86/hp/hp-bioscfg/surestart-attributes.c       |  132 +++
 drivers/platform/x86/ideapad-laptop.c              |  118 ++-
 drivers/platform/x86/intel/tpmi.c                  |  399 +++++++-
 drivers/platform/x86/mlx-platform.c                |  374 ++++++-
 drivers/platform/x86/sel3350-platform.c            |  251 +++++
 drivers/platform/x86/siemens/Kconfig               |   64 ++
 drivers/platform/x86/siemens/Makefile              |   11 +
 .../x86/siemens/simatic-ipc-batt-apollolake.c      |   51 +
 .../x86/siemens/simatic-ipc-batt-elkhartlake.c     |   51 +
 .../platform/x86/siemens/simatic-ipc-batt-f7188x.c |   87 ++
 drivers/platform/x86/siemens/simatic-ipc-batt.c    |  253 +++++
 drivers/platform/x86/siemens/simatic-ipc-batt.h    |   20 +
 drivers/platform/x86/siemens/simatic-ipc.c         |  236 +++++
 drivers/platform/x86/simatic-ipc.c                 |  151 ---
 drivers/platform/x86/system76_acpi.c               |   74 +-
 drivers/platform/x86/thinkpad_acpi.c               |   58 +-
 drivers/platform/x86/wmi-bmof.c                    |   26 +-
 drivers/watchdog/Kconfig                           |    5 +-
 drivers/watchdog/simatic-ipc-wdt.c                 |    9 +-
 include/linux/intel_tpmi.h                         |    2 +
 include/linux/platform_data/x86/asus-wmi.h         |   19 +-
 include/linux/platform_data/x86/simatic-ipc-base.h |    5 +-
 include/linux/platform_data/x86/simatic-ipc.h      |    6 +-
 tools/power/x86/intel-speed-select/isst-config.c   |   51 +-
 tools/power/x86/intel-speed-select/isst-display.c  |    2 +-
 tools/power/x86/intel-speed-select/isst.h          |    2 +-
 64 files changed, 8318 insertions(+), 353 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-tpmi
 create mode 100644 drivers/platform/x86/amd/pmc/Kconfig
 create mode 100644 drivers/platform/x86/amd/pmc/Makefile
 rename drivers/platform/x86/amd/{ => pmc}/pmc-quirks.c (100%)
 rename drivers/platform/x86/amd/{ => pmc}/pmc.c (100%)
 rename drivers/platform/x86/amd/{ => pmc}/pmc.h (100%)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
 create mode 100644 drivers/platform/x86/sel3350-platform.c
 create mode 100644 drivers/platform/x86/siemens/Kconfig
 create mode 100644 drivers/platform/x86/siemens/Makefile
 create mode 100644 drivers/platform/x86/siemens/simatic-ipc-batt-apollolake.c
 create mode 100644 drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
 create mode 100644 drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
 create mode 100644 drivers/platform/x86/siemens/simatic-ipc-batt.c
 create mode 100644 drivers/platform/x86/siemens/simatic-ipc-batt.h
 create mode 100644 drivers/platform/x86/siemens/simatic-ipc.c
 delete mode 100644 drivers/platform/x86/simatic-ipc.c

