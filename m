Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B7B7D6E24
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbjJYNpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344243AbjJYNo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:44:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4F2132;
        Wed, 25 Oct 2023 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698241493; x=1729777493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qsWPpHChbj6eevlntikLCMGGhKdN1IGjbsMPO1RBLKc=;
  b=PY8ftMQntozJ0/f8L2mcaKYHC31SMUTiTVa4erJlsDjlP2tegtE5sFq/
   B+bd9aVLKRMd1wtq2v2GW8Uz5cojnSMnJLnDFOJ21e4F6a2NxQnkWAzuQ
   P4BWCGSmKzyH+QJEsDjefkq7bBUR6kx4BAYztryeq5iDY1NLbaDr3pKLu
   LiIourrMk/Q/uBVh7sdcQgexL8HmKvnKEPDbUo6IeDDlYkspDoLefc16Q
   himC232jzmsrSeCZBo1Y4lzLqVM5Nl4ZuaZMFJCR+/T0dw7Zqhwj2LuU0
   QVLa0+f5MPHZBXMhzoZWg7JQ1nY43AE25znhpE+d6fzORF6VG20Q6ac9B
   w==;
X-CSE-ConnectionGUID: hKESaP82Toq6NENXDanU3Q==
X-CSE-MsgGUID: jFhgmQrLQFStVJ4OPoGYxw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="177743696"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 06:44:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 25 Oct 2023 06:44:16 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 25 Oct 2023 06:44:14 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v2 0/2] adding support for Microchip PAC193X Power Monitor
Date:   Wed, 25 Oct 2023 16:44:02 +0300
Message-ID: <20231025134404.131485-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

Adding support for Microchip PAC193X series of Power Monitor with
Accumulator chip family. This driver covers the following part numbers:
 - PAC1931, PAC1932, PAC1933 and PAC1934

Differences related to previous patch:

v2:
- fix review comments:
  - change the device tree bindings
  - use label property
  - fix coding style issues
  - remove unused headers
  - use get_unaligned_bexx instead of own functions
  - change to use a system work queue
  - use probe_new instead of old probe

v1:
- first version comitted to review

Marius Cristea (2):
  dt-bindings: iio: adc: adding dt-bindings for PAC193X
  iio: adc: adding support for pac193x

 .../ABI/testing/sysfs-bus-iio-adc-pac1934     |   15 +
 .../bindings/iio/adc/microchip,pac1934.yaml   |  146 ++
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/pac1934.c                     | 1775 +++++++++++++++++
 6 files changed, 1956 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
 create mode 100644 drivers/iio/adc/pac1934.c


base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec
-- 
2.34.1

