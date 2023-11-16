Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2079B7EE214
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345294AbjKPOCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345286AbjKPOCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:02:01 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDC111F;
        Thu, 16 Nov 2023 06:01:56 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E37DD2000B;
        Thu, 16 Nov 2023 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700143315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8P6FjfFpdrn/J0iPOo/tPROLgmPLagA4WGaPrF9h4CM=;
        b=C1tm/7LN72uCg3Ac230rwIqUW4UQb9rhtwN8CbfmUgsas86tBFkdv6CkRia/TZ9g1k5oFU
        6j63na4cfgUwXLxSW6ZwzgFOjYYU/lSVED3Pkxb2lwPF+m/FojMEDtBlKkiPLHSIpFWFDi
        T7ePixahMl9nQvEBYpc5oW/10yKuSh/O0XWhkL33WqKL5vWOP5g6WOpm3z+eNGa+NWp+LF
        BLZvSgeIs+ZCnxw3In8lWddRxbea7gjYrApifgOXFAmpDc1FLiQZaYMOPFieWC4W7O4FEi
        3yxKIl12nYMQ8tkg9ERSgEvvKNF5IfjydZdVzwtVwvGveJ97CMZyjRgjX/Gyhg==
From:   Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next 0/9] net: Add support for Power over Ethernet
 (PoE)
Date:   Thu, 16 Nov 2023 15:01:32 +0100
Message-Id: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALwgVmUC/x3MSwqAIBRG4a3EHSf4gqitRITUb92JhVoE4d6Th
 t/gnJcSIiPR0LwUcXPiI1SotqFld2GD4LWatNRGSW2Fh8tXxHweEMr0tpfojJWGanFGeH7+20g
 BWQQ8maZSPvqLrwhnAAAA
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims at adding support for PoE (Power over Ethernet),
based on the already existing support for PoDL (Power over Data Line)
implementation. In addition, it adds support for one specific PoE
controller, the Microchip PD692x0.

In detail:
- Patch 1 to 6 prepare net to support PoE devices.
- Patch 7 adds a new error code to firmware upload API.
- Patch 8 and 9 add PD692x0 PoE PSE controller driver and its binding.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (9):
      net: pse-pd: Rectify and adapt the naming of admin_cotrol member of struct pse_control_config
      ethtool: Expand Ethernet Power Equipment with PoE alongside PoDL
      net: pse-pd: Introduce PSE types enumeration
      net: ethtool: pse-pd: Expand pse commands with the PSE PoE interface
      netlink: specs: Modify pse attribute prefix
      netlink: specs: Expand the pse netlink command with PoE interface
      firmware_loader: Expand Firmware upload error codes
      dt-bindings: net: pse-pd: Add bindings for PD692x0 PSE controller
      net: pse-pd: Add PD692x0 PSE controller driver

 .../bindings/net/pse-pd/microchip,pd692x0_i2c.yaml |   70 ++
 Documentation/netlink/specs/ethtool.yaml           |   33 +-
 Documentation/networking/ethtool-netlink.rst       |   20 +
 MAINTAINERS                                        |    7 +
 drivers/base/firmware_loader/sysfs_upload.c        |    1 +
 drivers/net/pse-pd/Kconfig                         |   11 +
 drivers/net/pse-pd/Makefile                        |    1 +
 drivers/net/pse-pd/pd692x0.c                       | 1049 ++++++++++++++++++++
 drivers/net/pse-pd/pse_core.c                      |    9 +
 drivers/net/pse-pd/pse_regulator.c                 |    9 +-
 include/linux/firmware.h                           |    2 +
 include/linux/pse-pd/pse.h                         |   35 +-
 include/uapi/linux/ethtool.h                       |   43 +
 include/uapi/linux/ethtool_netlink.h               |    3 +
 net/ethtool/pse-pd.c                               |   64 +-
 15 files changed, 1332 insertions(+), 25 deletions(-)
---
base-commit: 23dd60286589d9d49c8135dee937fd54efa5643c
change-id: 20231024-feature_poe-139490e73403

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

