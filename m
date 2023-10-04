Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716687B97E1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjJDWWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjJDWWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:22:48 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4207D7;
        Wed,  4 Oct 2023 15:22:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C84DA1C0006;
        Wed,  4 Oct 2023 22:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696458161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5K8QplFQ57sQhVbN/dIE83RWR/O0r6O2Z07hmV2gtJc=;
        b=XchKfmi1Vcw2fTrLWBRVK9rrHhT9EajmiDnXodWlVgkp4GUUWRvDkDGwQLtbjEq7/05Vkg
        TsuPpgmLx7Pz22InyEGf4YHBefaZ5YNYm9zefXvIW8qJvBtAHeGkf77oz9yljN/TytwfrK
        i0p8xwY2k1SSPW0SpRzwk5Xmn21FfqVprEOqDqo6mVfDJjiw+wIbwEkpyFysuG/KpTw3kR
        dvigZ5P1YtrxCeNR8SwlGXTN9e2Pr+9aa1EpM+kf1tutN2iiAjgtaP9W139HjYbriHiBB5
        CR7qgesPvGj6T7SCE0bnSy4Y92iYAJ22WADEoAO44vXBA3itCrXSVIGZHQ+UYQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v11 0/7] NVMEM cells in sysfs
Date:   Thu,  5 Oct 2023 00:22:29 +0200
Message-Id: <20231004222236.411248-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Miquel Raynal (7):
  of: device: Export of_device_make_bus_id()
  nvmem: Clarify the situation when there is no DT node available
  nvmem: Move of_nvmem_layout_get_container() in another header
  nvmem: Create a header for internal sharing
  nvmem: core: Rework layouts to become regular devices
  ABI: sysfs-nvmem-cells: Expose cells through sysfs
  nvmem: core: Expose cells through sysfs

 Documentation/ABI/testing/sysfs-nvmem-cells |  21 ++
 drivers/nvmem/Makefile                      |   2 +-
 drivers/nvmem/core.c                        | 308 +++++++++++++++-----
 drivers/nvmem/internals.h                   |  40 +++
 drivers/nvmem/layouts.c                     | 171 +++++++++++
 drivers/nvmem/layouts/onie-tlv.c            |  37 ++-
 drivers/nvmem/layouts/sl28vpd.c             |  37 ++-
 drivers/of/device.c                         |  41 +++
 drivers/of/platform.c                       |  40 ---
 include/linux/nvmem-consumer.h              |   7 -
 include/linux/nvmem-provider.h              |  38 ++-
 include/linux/of_device.h                   |   6 +
 12 files changed, 614 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
 create mode 100644 drivers/nvmem/internals.h
 create mode 100644 drivers/nvmem/layouts.c

-- 
2.34.1

