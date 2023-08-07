Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB86771C36
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjHGIY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHGIYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:24:25 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4F41708
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:24:23 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4B8EE0004;
        Mon,  7 Aug 2023 08:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691396661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8iHm4mNu7uajtf3yMZO4aI/WL3b/VoNqJwaEaQWiVsI=;
        b=aoVYjWReoK1pD28BeL0kt8mxBYEbK++xyBC7GjYbbUW6WEgfV7uocMFQop5CkjgtHQvOgh
        GHu0+1d6VUzz+BHFRgwRhszKQihoRsdu+P9IBrZW/YMXm2Hg0vd1Iqd3HX/WsewpdGSYeE
        dDtaZEciDqVcDB+KyzGOOqeUTvyp1nWzpkAC3sWErhHRwDUbDlDkQo9iXfjUykqJURTfaE
        iQ0Viej1igbsUMlO09G8Tk06WSu+DqjqzKA+OAbA+R5SrqXemqyJGnDckpWkmLcv2mZZKs
        Dv6aXo7b6RdiQGLl4t+U1GeNOi1VA4Yg1FFHR23US4FCSG7Si4PAU7WrKmwqIA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v8 0/8] NVMEM cells in sysfs
Date:   Mon,  7 Aug 2023 10:24:11 +0200
Message-Id: <20230807082419.38780-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

This layout with a cells/ folder containing one file per cell has been
legitimately challenged by John Thomson. I am not against the idea of
having a sub-folder per cell but I did not find a relevant way to do
that so for know I did not change the sysfs organization. If someone
really wants this other layout, please provide a code snipped which I
can integrate.

Current support does not include:
* The knowledge of the type of data (binary vs. ASCII), so by default
  all cells are exposed in binary form.
* Write support.

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
  nvmem: core: Create all cells before adding the nvmem device
  nvmem: core: Return NULL when no nvmem layout is found
  nvmem: core: Do not open-code existing functions
  nvmem: core: Track the registered devices
  nvmem: core: Notify when a new layout is registered
  nvmem: core: Rework layouts to become platform devices
  ABI: sysfs-nvmem-cells: Expose cells through sysfs
  nvmem: core: Expose cells through sysfs

 Documentation/ABI/testing/sysfs-nvmem-cells |  21 ++
 drivers/nvmem/core.c                        | 269 +++++++++++++++++---
 drivers/nvmem/layouts/onie-tlv.c            |  39 ++-
 drivers/nvmem/layouts/sl28vpd.c             |  39 ++-
 include/linux/nvmem-consumer.h              |   4 +-
 include/linux/nvmem-provider.h              |  11 +-
 6 files changed, 329 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells

-- 
2.34.1

