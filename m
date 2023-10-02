Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF27B4BC1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbjJBGy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjJBGyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:54:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75907A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:54:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405497850dbso141929375e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 23:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696229690; x=1696834490; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ywk8nGHEw4GucEAKjJ/sjNmj6lHgQVRi4e4eQSAyRDk=;
        b=vXuX8WAKUJw4V7yngWJHhIyZ99FROzgd/K9Y0yjC08rWtJYTh3qqyMxxFYCj+KXFp6
         o7n+1/f/nl/m4kDFd5rCA8EBzzUdqRQeFtcb/tmh/4yijJXt7/bHoAC7pqf13SARSSxJ
         K1TmNsjbmp/F4CuHCHdHm7yacm+1hTDlGNwc8bQrmctu5gmmdBoStnrxhF2aJ8mRX5Co
         hF/B6vhaPLjGgnxcY0ifKMk7gDEkdAQmosdgBu8/EkXm+oYTrAWYYdsq5jAfR+VR/sE5
         nUAQpU5QsY1HqxkGXoX7j3xdBE9zILf3ZHAok6l3AIKs/Jh19+GVdgUdGPvvxgDhvhVx
         FETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696229690; x=1696834490;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywk8nGHEw4GucEAKjJ/sjNmj6lHgQVRi4e4eQSAyRDk=;
        b=UupDgbnLDADiUpSsBCJ9fjHeu1ls/yYpLWezdykaQ9UEMZE3tuiZmgiL1Z3fKMQuoe
         A1TkT5UtkVs++3cjqozZv2YGhr6rpS4YUBvwJUEeBEDOcaFBYaszubULc7zXZ88szXNu
         JBfDvbSiQf4QQT7iKlpTFYeGN8XeoJqL0uRy2lZaqbuOosA6U2WA/xyBnFcpiZY5y6at
         SLZvRUNnuBCnfv9ssexDtDW/5Gpa2SJ7gzfxiZMi1RQcKMUG7Q7sMOuUf2qMPCGio+SO
         g46SI2nduc/aA3cEOtBeVTS+XYhpHKeggb8ShcWFEYrGZ2q5dEX5uGH0sUrLfWWf0DyS
         zvCg==
X-Gm-Message-State: AOJu0YyVL0Hl9Haoco7r/fQUCIR7PzJ0ASZISkpzSuIePVAlkuzPFUXv
        v+tj+BuhAzTBuW0l+mFw8KWUOw==
X-Google-Smtp-Source: AGHT+IGTA0vxPVAlmYyOhbIpEDM0zX8GBJi5vAQJ3vBY0l09CdVCh0+Ev5qOHVFEEwxoykXTlkv0YA==
X-Received: by 2002:a1c:4c1a:0:b0:401:23fc:1f92 with SMTP id z26-20020a1c4c1a000000b0040123fc1f92mr9276114wmf.25.1696229689951;
        Sun, 01 Oct 2023 23:54:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b004063cced50bsm6601815wmi.23.2023.10.01.23.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 23:54:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v7 0/4] Input: add initial support for Goodix Berlin
 touchscreen IC
Date:   Mon, 02 Oct 2023 08:54:43 +0200
Message-Id: <20231002-topic-goodix-berlin-upstream-initial-v7-0-792fb91f5e88@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADNpGmUC/53RQW7DIBAF0KtErEsFGIzJqveougA8OEguWOBYq
 SLfveNsosqb1Ms/Qu8PmjupUCJUcj7dSYEl1pgTBv12Iv5i0wA09piJYKJhLWvpnKfo6ZBzH2/
 UQRljotepzgXsN40pztGO1FmjoQPfBekJUs5WoK7Y5C+Ipes44nAqEOLt0f35hfkS65zLz2OVh
 W/Tf7YunDIqLdOSu85C6D/wmS35PZeBbA2LOKIKVEXr8DPAwTDYqc0RtUE1MKW1B9trZnaqPKJ
 KVJmR2svOOOB6p6qn2jH+oqo2VRuhhGmUMs1ObZ+q4eJFtUXVSfDBShOc+XutdV1/AQ9GKg+cA
 gAA
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4560;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mEF4b451wAxW2lomW04Yotf5mxiPpSBOUkoIVcjxxK8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlGmk2wMX74ReSN3Dvqig2Vpm4/+BYBV8LlimvpWUn
 VyV7TISJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRppNgAKCRB33NvayMhJ0ZRpEA
 CBRdA/eta7AvVSafZlTEil/XGoft6eEbWIxEc3Mj/pQLdZJtTzHgDfC7womCtIC+XnMsJkwcMyiW3g
 ZTmBnS8TUR9z/BKmi9nOI/I/Wb+t3MNmnIG+swXsTu4F4KXrG9HW/l5FwmNhwyYAtmXsXnFab7qaGy
 yvyrbrsrLS1cJcNsl2WXu2oI+k/l28UrDp9fXp8a6ZVqESSEoxMg0J99R/RZlrehG5wYteNbmWSX8E
 yaHeukFD0JVcSILLp0myXLNnuYVwpMNpB/wmoZmcDzNnabTyqNjGCQBGi6cSYXTY8xAWaGKBfyKgL9
 tCZXORuJ1oODNeoxx0YGBWpwOtUCcsK95Bv0sqlUAlKGbdBPeHxIo/39gkUCg/VL46/3IHNhevzy3B
 82fev4hlKTvf+DchzMr1UZqBraVdMti8+CosNCEqUFdmaSq8br5E1PS1fcFIpxIIiqHe5HhN1laXI0
 elxrmGbDGNMtKUjWcVWFdymR0qAZEati/LR6EjZYUU/DydCkorm9fUqmnzidTxI0XEzmTmYggwVBA0
 wT9qs3gHMfVP92ZxVm30E/1Qw8cK9L88Ew6HipsLlvjlSymtKUiMSiixME7c+F6dT8CBynD96xDB8e
 zogWfFBMu8VlL9S8kyjV5S0VIA0cw5lvxquczIJM51PoSME1so+TaT809T+w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These touchscreen ICs support SPI, I2C and I3C interface, up to
10 finger touch, stylus and gestures events.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

Support for advanced features like:
- Firmware & config update
- Stylus events
- Gestures events
- Previous revisions support (BerlinA or BerlinB)
is not included in current version.

The current support will work with currently flashed firmware
and config, and bail out if firmware or config aren't flashed yet.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v7:
- rebased on v6.6-rc3
- Link to v6: https://lore.kernel.org/r/20230912-topic-goodix-berlin-upstream-initial-v6-0-b4ecfa49fb9d@linaro.org

Changes in v6:
- rebased on v6.6-rc1
- changed commit message prefix to match the other Input commits
- Link to v5: https://lore.kernel.org/r/20230801-topic-goodix-berlin-upstream-initial-v5-0-079252935593@linaro.org

Changes in v5:
- rebased on next-20230801
- Link to v4: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v4-0-0947c489be17@linaro.org

Changes in v4:
- Core updates:
 - drop kconfig depends, deps will be handled by _SPI and _I2C
 - change power_on() error labels
 - print errors on all dev_err() prints
 - remove useless default variable initialization
 - switch irq touch checksum error to dev_err()
 - add Jeff's review tag
- I2C changes
 - change REGMAP_I2C Kconfig from depends to select
 - add Jeff's review tag
- SPI changes
 - add select REGMAP to Kconfig
 - added GOODIX_BERLIN_ prefix to defines
 - switched from ret to error
 - add Jeff's review tag
- Link to v3: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org

Changes in v3:
- Another guge cleanups after Jeff's review:
 - appended goodix_berlin_ before all defines
 - removed some unused defines
 - removed retries on most of read functions, can be added back later
 - added __le to ic_info structures
 - reworked and simplified irq handling, dropped enum and ts_event structs
 - added struct for touch data
 - simplified and cleaned goodix_berlin_check_checksum & goodix_berlin_is_dummy_data
 - moved touch_data_addr to the end of the main code_data
 - reworked probe to get_irq last and right before setip input device
 - cleaned probe by removing the "cd->dev"
 - added short paragraph to justify new driver for berlin devices
 - defined all offsets & masks
- Added bindings review tag
- Link to v2: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org

Changes in v2:
- Huge cleanups after Jeff's review:
 - switch to error instead of ret
 - drop dummy vendor/product ids
 - drop unused defined/enums
 - drop unused ic_info and only keep needes values
 - cleanup namings and use goodix_berlin_ everywhere
 - fix regulator setup
 - fix default variables value when assigned afterwars
 - removed indirections
 - dropped debugfs
 - cleaned input_dev setup
 - dropped _remove()
 - sync'ed i2c and spi drivers
- fixed yaml bindings
- Link to v1: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org

---
Neil Armstrong (4):
      dt-bindings: input: document Goodix Berlin Touchscreen IC
      Input: add core support for Goodix Berlin Touchscreen IC
      Input: goodix-berlin - add I2C support for Goodix Berlin Touchscreen IC
      Input: goodix-berlin - add SPI support for Goodix Berlin Touchscreen IC

 .../bindings/input/touchscreen/goodix,gt9916.yaml  |  95 ++++
 drivers/input/touchscreen/Kconfig                  |  31 ++
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/goodix_berlin.h          | 159 ++++++
 drivers/input/touchscreen/goodix_berlin_core.c     | 581 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  69 +++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 173 ++++++
 7 files changed, 1111 insertions(+)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

