Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DC380CF1F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbjLKPMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbjLKPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:12:35 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7EBDC;
        Mon, 11 Dec 2023 07:12:41 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86562E0010;
        Mon, 11 Dec 2023 15:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702307560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oFE6C0z8xKaeOiZweTxKpiLysfvHtTDmjwGQsIGoKvY=;
        b=Sm95cUORL9q+npJNEYxgVyXxreLziHzhozNYrvKqDq4fiV8Oo8G1fV1lSqxgzBpDmp0Zji
        iDaBgZ8YljiOxQhZgGSo0MNcLS8bWk2gTpJ9FOH+oHXYBCevzl3ULB+8Gf6DGeEDXVU/K9
        BuyBrCTzkOt1dAqmL5FvwvZW6U8wdBWuXwMAzL7rmy1gtXnAKvj6Ba37JOkGyCEoPQeQDc
        3mT7oK3s90ZycJ4FIwSDeg4sQ1Yu7NrJnHnjju+zjuoCiN8PaOCcmreEmvaz3GmTmHXiNl
        HV9XSwdkUB/Jggo926EdmdCEcR82GL049n4y0HwjvsJp/YTOEjXqVnoVoAhkxg==
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Romain Gantois <romain.gantois@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [RFC PATCH 0/6] Add GPT parser to MTD layer
Date:   Mon, 11 Dec 2023 16:12:36 +0100
Message-ID: <20231211151244.289349-1-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

MTD devices were historically partitioned using fixed partitions schemes
defined in the kernel device tree or on the cmdline. More recently, a bunch
of dynamic parsers have been introduced, allowing partitioning information
to be stored in-band. However, unlike disks, parsers for MTD devices do not
support runtime discovery of the partition format. This format is instead
named in the device-tree using a compatible string.

The GUID Partition Table is one of the most common ways of partitioning a
block device. As of now, there is no support in the MTD layer for parsing
GPT tables. Indeed, use cases for layouts like GPT on raw Flash devices are
rare, and for good reason since these partitioning schemes are sensitive to
bad blocks in strategic locations such as LBA 2.  Moreover, they do not
allow proper wear-leveling to be performed on the full span of the device.

However, allowing GPT to be used on MTD devices can be practical in some
cases. In the context of an A/B OTA upgrade that can act on either NOR of
eMMC devices, having the same partition table format for both kinds of
devices can simplify the task of the update software.

This series adds a fully working MTD GPT parser to the kernel. Use of the
parser is restricted to NOR flash devices, since NAND flashes are too
susceptible to bad blocks. To ensure coherence and code-reuse between
subsystems, I've factored device-agnostic code from the block layer GPT
parser and moved it to a new generic library in lib/gpt.c. No functional
change is intended in the block layer parser.

I understand that this can seem like a strange feature for MTD devices, but
with the restriction to NOR devices, the partition table can be fairly
reliable. Moreover, this addition fits nicely into the MTD parser model.
Please tell me what you think.

Best Regards,

Romain

Romain Gantois (6):
  block: partitions: efi: Move efi.h header to include/linux/gpt.h
  block: partitions: efi: Fix some style issues
  block: partitions: efi: Separate out GPT-specific code
  block: partitions: efi: Move GPT-specific code to a new library
  drivers: mtd: introduce GPT parser for NOR flash devices
  dt-bindings: mtd: add GPT partition bindings

 .../bindings/mtd/partitions/gpt.yaml          |  41 ++
 .../bindings/mtd/partitions/partitions.yaml   |   1 +
 MAINTAINERS                                   |   4 +-
 block/partitions/Kconfig                      |   2 +-
 block/partitions/efi.c                        | 478 +++---------------
 block/partitions/msdos.c                      |   2 +-
 drivers/mtd/parsers/Kconfig                   |  10 +
 drivers/mtd/parsers/Makefile                  |   1 +
 drivers/mtd/parsers/gpt.c                     | 222 ++++++++
 include/linux/efi.h                           |  18 +
 block/partitions/efi.h => include/linux/gpt.h |  72 ++-
 lib/Kconfig                                   |   3 +
 lib/Makefile                                  |   3 +
 lib/gpt.c                                     | 342 +++++++++++++
 14 files changed, 777 insertions(+), 422 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/gpt.yaml
 create mode 100644 drivers/mtd/parsers/gpt.c
 rename block/partitions/efi.h => include/linux/gpt.h (61%)
 create mode 100644 lib/gpt.c

-- 
2.43.0

