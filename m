Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E900757BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjGRMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjGRMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:32:26 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45F010EB;
        Tue, 18 Jul 2023 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689683544;
  x=1721219544;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Waw7ZxMMy2yoyoo75Qco+TZX/WtJXKx8nZC30Q6G+2g=;
  b=jsPfg/lNzic1m4HBkspcNWSIqjt/cEw3+9LoEZGEo1WVkEC0LoCJa3JE
   x4cLzJfAOcJ7H3u1aD6F5gUfowf0FN2yVj8lQXXVb7ma6QR5rTuVuPapI
   4QRbSb1FMXQksqIaA9D83CYnws4q1K4WBkIrYoHZgDXtItaOUZ+P79K6l
   AS5nQHGIpcDHY/1vAdj3HEihFCe6LsSHhJ7L4UeDOqGC7+RRggRQ9n0yw
   g7kXZ8EOtd5Xl4ld4gzbkEcfcyJAiFk5+lRl8OaKfQLYy6ApEEXaIW20V
   w1V7+d2txCNHAfSRu83kYN3uzRhHUueefp6Jxcz5uHY+8tNEgZEVj4pBe
   A==;
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/3] Add driver for Murata IRS-D200
Date:   Tue, 18 Jul 2023 14:30:11 +0200
Message-ID: <cover.1689683411.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murata IRS-D200 is a PIR sensor for human detection. In this series we
add devicetree bindings and an IIO driver with support for triggered
buffer and events. Link to the datasheet should be added to the
devicetree bindings, when that is available.

Changes in v3:

[dt-bindings]
* Add "Reviewed-by" footer in commit message.

[iio]
* Use `__le16` for buffers in `regmap_bulk_read/write()`.
* Use `8` instead of `BIT(3)` in `irsd200_write_nr_count()`.
* Rename `val` to `tmp` in `irsd200_write_event_config()`.
* Return `0` on success in `irsd200_write_event_config()`.
* Return `IRQ_HANDLED` instead of `IRQ_NONE` in error paths.
* Return `IRQ_NONE` when not clearing anything in
  `irsd200_irq_thread()`.
* Use `devm_regulator_get_enable()` in probe.

Link to v2: https://lore.kernel.org/lkml/cover.1689174736.git.waqar.hameed@axis.com/

Changes in v2:

[dt-bindings]
* Remove "bindings for" in commit subject.
* Remove superfluous yaml block style indicator ('|') for
  `description:`.
* Change node name in example from `pir` to `proximity`.
* Add required `vdd-supply` property.

[iio]
* Add event enums for running period and count.
* Use `set_trigger_state` callback instead of `iio_buffer_setup_ops`'s
  `predisable` and `postenable`.
* Use `regmap_bulk_read()` in `irsd200_read_data()` and
  `irsd200_read_timer()`.
* Use `regmap_bulk_write()` in `irsd200_write_timer()`.
* Remove comment for macro `IRS_UPPER_COUNT()`.
* Move `IIO_EV_INFO_LOW/HIGH_PASS_FILTER_3DB` from `iio_event_spec` to
  `iio_chan_spec`.
* Ignore timer (`IRS_INTR_TIMER`) interrupts.
* Clarify comment on `ssleep(3)` in `irsd200_write_data_rate()`.
* Only check for non-zero return values from `regmap` functions (as
  opposed to `ret < 0`).
* Add macro defines for operation states.
* Remove fix size in static const array declarations.
* Remove unnecessary `ret` variable in `irsd200_write_raw()`.
* Remove comments in `irsd200_event_spec[]`.
* Remove unnecessary call to `i2c_set_clientdata()` in probe.
* Use `dev_err_probe()` everywhere in probe.
* Remove unnecessary braces around if statement in probe.
* Get and enable regulator in probe.

Link to v1: https://lore.kernel.org/lkml/cover.1686926857.git.waqarh@axis.com/

Waqar Hameed (3):
  dt-bindings: iio: proximity: Add Murata IRS-D200
  iio: Add event enums for running period and count
  iio: Add driver for Murata IRS-D200

 Documentation/ABI/testing/sysfs-bus-iio       |  16 +
 .../iio/proximity/murata,irsd200.yaml         |  60 ++
 drivers/iio/industrialio-event.c              |   2 +
 drivers/iio/proximity/Kconfig                 |  12 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/irsd200.c               | 962 ++++++++++++++++++
 include/linux/iio/types.h                     |   2 +
 7 files changed, 1055 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
 create mode 100644 drivers/iio/proximity/irsd200.c


base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
-- 
2.30.2

