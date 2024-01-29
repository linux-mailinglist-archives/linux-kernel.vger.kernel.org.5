Return-Path: <linux-kernel+bounces-42419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D841840122
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0741F1F2317C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744015577A;
	Mon, 29 Jan 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLeMYATq"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4F54F95
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519803; cv=none; b=VUAVQul8lo/I9WQbiqr3ryTzRam4EnbOKD6jcZUjHLwqBkVbdR6nrTEJqavLQXyPTTRxFhDGuBqm71PJoWUTQoENodSs4bAehvOCp1F2ROajyEFI+klyYi6Fwvwj/tahYVP/W0x839py3vFmluXCZxZtkU6obBSv7V8bKU1eMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519803; c=relaxed/simple;
	bh=P8FhOwT3RapQtFCltomOL1Gs3Uksw6IrqYgNDVsCPNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YKUEShB3njYHTW6nFsuqQeDE5G8MepxlqroQuhyaUQmvKhSP1g8fS7lKaw22Tu2BVW7yQDQD0M3EmyOJfpji4MFm2lsBh5CZdJob1VeJJbY6q6yZQ4a7hO/MjY3ZJdxtonoZ5GJbh1jiWOaFeR1vkdr0hbh37FhiYjn+kNfvXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLeMYATq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cf3a0b2355so29946681fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706519799; x=1707124599; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vgx+V5QogKIYOd2eqGQ9ZKkO/nAGlpRrf+jf3HJVEZY=;
        b=vLeMYATq2uZ7EJrdCNhHMdptMjDD0ioYdqgScA3lodsdv2AiT18jVa7Ive7WoQV3kJ
         bnko5sV3mASOR3C2D7cq7LQJIgNmf9MvBwLVAmMHbZxLjmnVaqBbzQ+ROc93bT0SySZF
         6sP6AyfwOCEMENVvEofGTkkExDMGpKYZ/qrK9Pe5RaYx8yRAEQT3NeYUMpJjW/46sZTU
         IHCnihmVEczC/PxufNP3WQWY3kG3trY44HWuE9A5jgolAjYSpxoa/wFXjiVYoO7tlLB6
         aBXqCNWtOp8/VmZulijq6EIdZc5KG45KTGe+s+96W+tqs7pF4XfIdRq+kMb7C5gQM6Uc
         6JYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519799; x=1707124599;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vgx+V5QogKIYOd2eqGQ9ZKkO/nAGlpRrf+jf3HJVEZY=;
        b=udzYigS7CTaOZbE9iUpNUywUQij1aC1MFppUPfP0Ts+RxfoMwyuQTC01q3xf8jKEHt
         3EJINb7SYY7GNCJDxXxDyZm5w7MkoWvaVOx0I2r8zPqPAp3lodFYCTPwpiytFcNnkcVP
         kLXofGq0w6YwRW3v0RXtLcTdCemUM9bJI3W0rNvwa2ujvSJWObu9UkKhqgw9qmSGiWI1
         hrztCOMnXOiUrEape/+HtXlP7mXU+tR+jkUQbWgYtYKQiHcMhbZuOTfyxpcrLyWrH7kA
         /UwqgjWtY5QpipcDZlNwwlCRNGQA+8eggMTV5068g5nQaToRmnNbDM7uTN5FRPB8yLIt
         MI0Q==
X-Gm-Message-State: AOJu0YwYlyCA7eFbnTSPGbBLCylqd6F245pM4Gz1zMpioTe08LOdy4sx
	rGKE0wMs+O7gcSUOo8VNg4ldDm39kpP3mwyE5lh1hvufRicc9Sa8QPpC5kww9apR7Jq3X7G3Kdq
	3s73Cvw==
X-Google-Smtp-Source: AGHT+IHa5mkWO7VOf4evT8srKsh0GcEjMFBHWd4Kd5nQFUG11+O2VZVZqG/fFYCmg4r9QyZXi3jSxw==
X-Received: by 2002:a2e:95ca:0:b0:2cf:657e:7767 with SMTP id y10-20020a2e95ca000000b002cf657e7767mr2326267ljh.50.1706519799268;
        Mon, 29 Jan 2024 01:16:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b7-20020adfee87000000b0033aebf727b2sm2818198wro.60.2024.01.29.01.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:16:38 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v15 0/4] Input: add initial support for Goodix Berlin
 touchscreen IC
Date: Mon, 29 Jan 2024 10:16:34 +0100
Message-Id: <20240129-topic-goodix-berlin-upstream-initial-v15-0-6f7d096c0a0a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPJst2UC/53TzW7bMAwH8FcpfJ4KUh+WtNPeY9hBkqlEQGYHc
 hp0KPLuo3NoXOii5ijC+Ikm9f8YVqqF1uHny8dQ6VrWssx8QPPjZUjHMB9IlIkLgwSpYIRRXJZ
 zSeKwLFN5F5Hqqczi7bxeKoW/oszlUsJJxOAtOUou6zQwFcNKItYwpyNj89vpxMVzpVze75f//
 sPnY1kvS/137+WKW/Wbt15RgNABrMboAuXpF38W6vK61MOw3XCVz6iSVTlG/hlC8kCNqp5RFas
 ZjLWJwmTBN6p+RtWsgtc2aecjoW1U81AdYKdqNtV6aaRXxnjVqOND9Sg71ZHVqCnloH2Ovt2W/
 VQRoFe1rHKrDGI25Fyjur2qOlXHKlrkRSBImsZG9TtV9s7Vb6rKPATnLJpWRdizvc0ib0s4R5Q
 kGUwQW/cRL8T+eG35Mklb8hZsgvYd4CNgKMH3ulvCKOQcKBoeh2ldtXOxew5bxsxkgxyDoRBk6
 +qd2702vKdMa+OdUXHU8MW93W7/AXs4GaFXBQAA
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
 Hans de Goede <hdegoede@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7406;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=P8FhOwT3RapQtFCltomOL1Gs3Uksw6IrqYgNDVsCPNA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlt2z0eYVyQaBErb9Gc8DfuoARoCnBmO39ywO+ersn
 saLzksmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZbds9AAKCRB33NvayMhJ0fyLD/
 9TGPwov/vI7y9uSEB9Ifatq52LsPLIYa22YaC6uL+7gn+NM0Pu97PhpwtZQwgGLPL9YKym0C46ixvO
 4lth72snOr4aWEtqOl2FMHFlWeZ3IK4QrPXPd59LcZpoYTFVyIq9FXxOCzUF1t3B7P7CyMl/2LRXqA
 7uO2JQ16MdOIC9kiNB0zgYBk7RArCu9U1BI5Rw3IPcOkOWAxgyjAiXPnBZeHJseZYA+6ZHlW0ouNil
 ONlz1gGpf/cjCJ+XhH2w5Khu40YhZ+lBpeEhMzJ/FcPrxPDvFz9A8V5dW6vlVwJ4crN4Org8cThcl7
 FhD8GLNmSBTAEcjB1x6qPyxRlejhpkcqzNuUWUGhGiTjUDyIZrETQlci9MYinKQgWsB2sBBYv05hbf
 g9+fviP87VzK5C49l5Ama+XDs0++Yat8zevCY9aH/Wy3iEbvXTbHWMFER6GTNMyvAkvC2Wt3ZNeuHY
 IFUEI6krkC06UMstrkaM4YZ6GjmMb1bnmbsYmJVEgY32ouPSC2Bx57DTRTTi7sGhDSGxFKzres9Wm4
 IKt9cYnDvgymKzhpOI8udT7xZsxEvedhdCx4460LnEYNDlM78CcjhJJOwLMOO/+zT8XrQvVDVmDnZX
 RuHQW2FAa+Zh1OqEeA3m1ytuhnJwvEHKxpxEbn6wNSxdPXiYeSADkyjj3Jhg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

These touchscreen ICs support SPI, I2C and I3C interface, up to
10 finger touch, stylus and gestures events.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550/SM8650 MTP & QRD touch panel.

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
Changes in v15:
- Applied changes/cleanups/fixes provided by Dmitry:
  - Cleanup status/offsets defines, move in to structs
  - Remove packed attribute when not needed
  - Refactor touch data & header structs
  - Store event into goodix_berlin_core
  - simplify goodix_berlin_checksum_valid()
  - simplify goodix_berlin_convert_ic_info() with macro
  - simplify back-and-forth reads with goodix_berlin_get_remaining_contacts()
  - simplify goodix_berlin_touch_handler()
  - cleanup buffer handling comment
  - clear up status field in case of checksum error
- Link to v14: https://lore.kernel.org/r/20231221-topic-goodix-berlin-upstream-initial-v14-0-04459853b640@linaro.org

Changes in v14:
- Rebased on next-20231221
- Fixed build on SPI/I2S drivers missing <linux/input.h> include
- Link to v13: https://lore.kernel.org/r/20231213-topic-goodix-berlin-upstream-initial-v13-0-5d7a26a5eaa2@linaro.org

Changes in v13:
- Thanks to Dmitry's suggestion:
  - Move core defines and structs into goodix_berlin_core.c
  - Comments typos and rephrasings
  - Identation fixes
  - Refactor of goodix_berlin_power_on
  - goodix_berlin_get_ic_info move to __free(kfree) to avoid leaking
- Added comment explaining how data is retrieved in irq handler
- Link to v12: https://lore.kernel.org/r/20231209-topic-goodix-berlin-upstream-initial-v12-0-eaffaeb53fb5@linaro.org

Changes in v12:
- Rebased on next-20231208
- Link to v11: https://lore.kernel.org/r/20231106-topic-goodix-berlin-upstream-initial-v11-0-5c47e9707c03@linaro.org

Changes in v11:
- Fixes according to Jeff's review:
 - s/dev_info/dev_err/ in goodix_berlin_get_ic_info()
 - remove spurious return instead of goto in goodix_berlin_get_ic_info()
 - added back dropped msleep() in goodix_berlin_request_handle_reset()
- Link to v10: https://lore.kernel.org/r/20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org

Changes in v10:
- Fix according to Dmitry's review:
 - move goodix_berlin_get_ic_info() afe_data to heap
 - merge the goodix_berlin_parse_finger() loops and skip invalid fingers instead of returning
 - remove unwanted goodix_berlin_touch_handler() "static" for buffer
 - only call goodix_berlin_request_handle_reset() if gpio was provided
 - use "error = func(); if(error) return error;" instead of "return func()" when function handles multiple error cases
- Link to v9: https://lore.kernel.org/r/20231021-topic-goodix-berlin-upstream-initial-v9-0-13fb4e887156@linaro.org

Changes in v9:
- Rebased on next-20231020 
- Link to v8: https://lore.kernel.org/r/20231003-topic-goodix-berlin-upstream-initial-v8-0-171606102ed6@linaro.org

Changes in v8:
- Add missing bitfield.h include in core
- Link to v7: https://lore.kernel.org/r/20231002-topic-goodix-berlin-upstream-initial-v7-0-792fb91f5e88@linaro.org

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

 .../bindings/input/touchscreen/goodix,gt9916.yaml  |  95 +++
 drivers/input/touchscreen/Kconfig                  |  31 +
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/goodix_berlin.h          |  24 +
 drivers/input/touchscreen/goodix_berlin_core.c     | 755 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  75 ++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 178 +++++
 7 files changed, 1161 insertions(+)
---
base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


