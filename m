Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929047FDD42
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjK2Qhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjK2Qhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:37:35 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C1C10A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:37:40 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D8B2C0002;
        Wed, 29 Nov 2023 16:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701275859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cd3989JJ1YTbZGbAiSzv5gEynjDTcribeidCsC3rKig=;
        b=FP280pcN2WPI2/1GxNF7TtAkpGdxIwXr0coSrE4zkMFzLBo2KjkX9GNTG7xd2ELiCh9dWg
        gJ+nD1aRgcG7iPzzbejwXQgK4UbTNy46dHWWjWv3NfRFHoGMurPWfVyPD4FsOk98Cctizc
        dj8yZ6IV3fOcswEUL7EXXhe5tPszVw6RkPZx38cdT+o2bVUq4GpArjT7VY0sdr/3opCZ9O
        hLpofxW0J+aSuCuv21Qr8/sLtvYJ0pe6kCiZeRTmiVl0QNLDrXwp0ayuWdETiB13jQKMcv
        84XTB0MW+0SeY3GoLM2T0gi3EI/2n0HlW0RZTN1izxuOEOy1D8HnrBXiue+01w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v14 0/8] NVMEM cells in sysfs
Date:   Wed, 29 Nov 2023 17:37:29 +0100
Message-Id: <20231129163737.698317-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As part of a previous effort, support for dynamic NVMEM layouts was
brought into mainline, helping a lot in getting information from NVMEM
devices at non-static locations. One common example of NVMEM cell is the
MAC address that must be used. Sometimes the cell content is mainly (or
only) useful to the kernel, and sometimes it is not. Users might also
want to know the content of cells such as: the manufacturing place and
date, the hardware version, the unique ID, etc. Two possibilities in
this case: either the users re-implement their own parser to go through
the whole device and search for the information they want, or the kernel
can expose the content of the cells if deemed relevant. This second
approach sounds way more relevant than the first one to avoid useless
code duplication, so here is a series bringing NVMEM cells content to
the user through sysfs.

Here is a real life example with a Marvell Armada 7040 TN48m switch:

$ nvmem=/sys/bus/nvmem/devices/1-00563/
$ for i in `ls -1 $nvmem/cells/*`; do basename $i; hexdump -C $i | head -n1; done
country-code@77
00000000  54 57                                             |TW|
crc32@88
00000000  bb cd 51 98                                       |..Q.|
device-version@49
00000000  02                                                |.|
diag-version@80
00000000  56 31 2e 30 2e 30                                 |V1.0.0|
label-revision@4c
00000000  44 31                                             |D1|
mac-address@2c
00000000  18 be 92 13 9a 00                                 |......|
manufacture-date@34
00000000  30 32 2f 32 34 2f 32 30  32 31 20 31 38 3a 35 39  |02/24/2021 18:59|
manufacturer@72
00000000  44 4e 49                                          |DNI|
num-macs@6e
00000000  00 40                                             |.@|
onie-version@61
00000000  32 30 32 30 2e 31 31 2d  56 30 31                 |2020.11-V01|
platform-name@50
00000000  38 38 46 37 30 34 30 2f  38 38 46 36 38 32 30     |88F7040/88F6820|
product-name@d
00000000  54 4e 34 38 4d 2d 50 2d  44 4e                    |TN48M-P-DN|
serial-number@19
00000000  54 4e 34 38 31 50 32 54  57 32 30 34 32 30 33 32  |TN481P2TW2042032|
vendor@7b
00000000  44 4e 49                                          |DNI|

Current support does not include:
* The knowledge of the type of data (binary vs. ASCII), so by default
  all cells are exposed in binary form.
* Write support.

Changes in v14:
* Fix all robot reports received so far. I also pushed the branch on my
  O-day repository until I got a successful feedback.
* Changed a bit the Kconfig logic to only include layouts when CONFIG_OF
  is enabled, it does not make sense without any anyway (pointed by
  Marco).
* Dropped the nvmem-layout dummy device, it is actually not relevant
  (pointed by Marco).
* Fixed an allocation (reported by Marco).
* Changed the nvmem-layout parent device to become the nvmem device
  (suggested by Marco).
* Simplified the ->add_cells() hook in a dedicated (new) patch.
* Moved and renamed ->fixup_cell_info() in a new patch.
* We no longer try to modprobe explicitly the layout driver, this is no
  longer needed (pointed by Marco).
* Updated the commit layouts with the latest changes.
* Fixed the layouts exit path to regular fixed-layout descriptions
  (reported by Luca Ceresoli).
* Tested and fixed the removal of the drivers. Tests have been performed
  using regular fixed layouts and the onie driver as layout provider
  with an Ethernet controller driver using an EEPROM exporting MAC
  addresses.

Changes in v13:
* Clarifying a NULL of_node situation was deemed irrelevant, so I
  dropped the patch.
* Rename the layouts bus/devices: s/nvmem-layouts/nvmem-layout/.
* Fixed incoherent function declarations returning void vs. int (kernel
  test robot).
* Fixed another robot report related to the fact that an error path was
  only useful if CONFIG_NVMEM_SYSFS was enabled.
* Collected tags.
* We now register a struct nvmem_layout rather than a struct device as
  part of the layout bus. I had to create a couple of additional fields
  in the layout driver structure for that, but the final result looks
  nicer.

Changes in v12:
* Fixed the issues reported by kernel test robot.
* Reworked even deeper the registration of layout devices and dropped
  all the research and matching code that was previously needed as
  suggested by Srinivas. This way, we no longer use the notifiers.

Changes in v11:
* The nvmem layouts are now regular devices and not platform devices
  anymore. They are registered into the nvmem-layout bus (so there is a
  new /sysfs/bus/nvmem-layouts entry that gets created. All the code for
  this new bus is located under drivers/nvmem/layouts.c and is part of
  the main core. The core device-driver logic applies without too much
  additional code besides the registration of the bus and a bit of
  glue. I see no need for more detailed structures for now but this can
  be improved later as needed.

Changes in v10:
* All preparation patches have been picked-up by Srinivas.
* Rebased on top of v6.6-rc1.
* Fix an error path in the probe due to the recent additions.

Changes in v9:
* Hopefully fixed the creation of sysfs entries when describing the
  cells using the legacy layout, as reported by Chen-Yu.
* Dropped the nvmem-specific device list and used the driver core list
  instead as advised by Greg.

Changes in v8:
* Fix a compilation warning whith !CONFIG_NVMEM_SYSFS.
* Add a patch to return NULL when no layout is found (reported by Dan
  Carpenter).
* Fixed the documentation as well as the cover letter regarding the
  addition of addresses in the cell names.

Changes in v7:
* Rework the layouts registration mechanism to use the platform devices
  logic.
* Fix the two issues reported by Daniel Golle and Chen-Yu Tsai, one of
  them consist in suffixing '@<offset>' to the cell name to create the
  sysfs files in order to be sure they are all unique.
* Update the doc.

Changes in v6:
* ABI documentation style fixes reported by Randy Dunlap:
  s|cells/ folder|"cells" folder|
  Missing period at the end of the final note.
  s|Ex::|Example::|
* Remove spurious patch from the previous resubmission.

Resending v5:
* I forgot the mailing list in my former submission, both are absolutely
  identical otherwise.

Changes in v5:
* Rebased on last -rc1, fixing a conflict and skipping the first two
patches already taken by Greg.
* Collected tags from Greg.
* Split the nvmem patch into two, one which just moves the cells
  creation and the other which adds the cells.

Changes in v4:
* Use a core helper to count the number of cells in a list.
* Provide sysfs attributes a private member which is the entry itself to
  avoid the need for looking up the nvmem device and then looping over
  all the cells to find the right one.

Changes in v3:
* Patch 1 is new: fix a style issue which bothered me when reading the
  core.
* Patch 2 is new: Don't error out when an attribute group does not
  contain any attributes, it's easier for developers to handle "empty"
  directories this way. It avoids strange/bad solutions to be
  implemented and does not cost much.
* Drop the is_visible hook as it is no longer needed.
* Stop allocating an empty attribute array to comply with the sysfs core
  checks (this check has been altered in the first commits).
* Fix a missing tab in the ABI doc.

Changes in v2:
* Do not mention the cells might become writable in the future in the
  ABI documentation.
* Fix a wrong return value reported by Dan and kernel test robot.
* Implement .is_bin_visible().
* Avoid overwriting the list of attribute groups, but keep the cells
  attribute group writable as we need to populate it at run time.
* Improve the commit messages.
* Give a real life example in the cover letter.

Miquel Raynal (8):
  of: device: Export of_device_make_bus_id()
  nvmem: Move of_nvmem_layout_get_container() in another header
  nvmem: Create a header for internal sharing
  nvmem: Simplify the ->add_cells() hook
  nvmem: Move and rename ->fixup_cell_info()
  nvmem: core: Rework layouts to become regular devices
  ABI: sysfs-nvmem-cells: Expose cells through sysfs
  nvmem: core: Expose cells through sysfs

 Documentation/ABI/testing/sysfs-nvmem-cells |  21 ++
 drivers/nvmem/Kconfig                       |   1 +
 drivers/nvmem/Makefile                      |   2 +
 drivers/nvmem/core.c                        | 335 ++++++++++++--------
 drivers/nvmem/imx-ocotp.c                   |  11 +-
 drivers/nvmem/internals.h                   |  59 ++++
 drivers/nvmem/layouts.c                     | 201 ++++++++++++
 drivers/nvmem/layouts/Kconfig               |   8 +
 drivers/nvmem/layouts/onie-tlv.c            |  27 +-
 drivers/nvmem/layouts/sl28vpd.c             |  27 +-
 drivers/nvmem/mtk-efuse.c                   |  11 +-
 drivers/of/device.c                         |  41 +++
 drivers/of/platform.c                       |  40 ---
 include/linux/nvmem-consumer.h              |   7 -
 include/linux/nvmem-provider.h              |  64 ++--
 include/linux/of_device.h                   |   6 +
 16 files changed, 624 insertions(+), 237 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
 create mode 100644 drivers/nvmem/internals.h
 create mode 100644 drivers/nvmem/layouts.c

-- 
2.34.1

