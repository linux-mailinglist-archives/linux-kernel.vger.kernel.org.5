Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CDC7B5018
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbjJBKUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbjJBKUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:20:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD11C9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:20:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40572aeb673so134005265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696242031; x=1696846831; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pfv0AtlnvNa/E/C0wmR1XzkqLMulzABmbQ9znMd60Gs=;
        b=sf3/WjS6YXUi2Sfrp8k42vnphJfnnf/LtGYvI433cW28zbBmHPd58q3UqLU8BqI0H6
         aX9ZEbdkkZCxh2lzsJCXN4qUayN3Kz65ooMF9Nk2xos4ps3KVNCAAq+deePnt1nn/70X
         MSaYeGarT/K+hcbjwp1kx8g4WaeGC2kS7ROwLIJm9tWJk+yXk/+ikDsLZUHqZF/T9hQD
         czvZQKQ2NFy92yGs/h16GdVH/fbCvfooz6kC+yZqGma4pWwhNuxwqlBLy17EIDxn850d
         VX9yTSD9/Hp0dvNNKYo1FPW/NNdo8eraaSaHgCO94U/zHaOHh+15Tipik4XUpZHFN6P5
         2JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696242031; x=1696846831;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfv0AtlnvNa/E/C0wmR1XzkqLMulzABmbQ9znMd60Gs=;
        b=h+Q06P7eQBYOFzJ6TTDKa1OLq7vgSASR/czBkkr16W3OhmWoSEDNY/f8HQFlbaJGNZ
         Rn/CSt1V/nue/f+87IG04gGWRoGGJYYhNDnagTQXl61NMWrXoSA2MvgG2gnQzax0bRCy
         /3Ij/27l83GZurGyGU4nEz6jfAUBokTD0YVxEHe6bSpZfVVvNk2mAIsKmehChLVg6VKS
         Du2ekd8T1L8sWfEEKlKJIaWDkVYD3/cDuB4L2gd62g1PxRFrmEd5H6rZW60FVZ87FSmQ
         /iwJWDG1XdzqnG2CxaYQxe+nIZdf+fbVcHZUYZ1xt6QGbTtDyGnMOajmEeUA+1l4oou1
         7/uQ==
X-Gm-Message-State: AOJu0YxyO+o6eqyTpa3ZXg36Orfx+YHlrHAX2ztg/Zl1+olUl0ChuUjP
        3zAKJvL83574K1iLf5opbs8a+Q==
X-Google-Smtp-Source: AGHT+IHKQKBc27yWRnJvsnCQnRfbEPhbVYRxX4qMkNLc/yNshIM4n70R/iHPUBBLejbfbmWcStSkGw==
X-Received: by 2002:a05:600c:2609:b0:405:34e4:e756 with SMTP id h9-20020a05600c260900b0040534e4e756mr9115752wma.36.1696242030644;
        Mon, 02 Oct 2023 03:20:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b003196b1bb528sm27822901wrw.64.2023.10.02.03.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 03:20:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/4] arm64: qcom: sm8550: retrieve USB-C port
 orientation from gpio
Date:   Mon, 02 Oct 2023 12:20:20 +0200
Message-Id: <20231002-topic-sm8550-upstream-type-c-orientation-v2-0-125410d3ff95@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGSZGmUC/52NTQ6CMBBGr0K6dkyh8hNX3sOwKO0Ak0jbtJVIC
 Hd35Ah+u/ct3ttFwkiYxL3YRcSVEnnHUF0KYWbtJgSyzKKSlZKdvEH2gQykpatrCe+QckS9QN4
 CggHPLpd1ZgnIgacaadXYCtaFiCN9ztSzZ54pZR+3s7yWv/ePyFqCBNVYq9CiaYfx8SKno7/6O
 In+OI4vlPwx1+EAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2113;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Qo0f5HDypComny9WssJzstEih7AYlhet2I248Twlt+M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlGplqbypaeMI7QPoC/3sxqXx+ye2lh9NHkExQ2cJx
 WmorGX2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRqZagAKCRB33NvayMhJ0bNhEA
 CVbMRdn6P21VLUf44cwkzQqo1lYjaXsYYdSdPfwWQsZUIStSyQXM0NgZAE6bdLgzwPCVNXQSQU5GJm
 Vfia1K6beM16pmdzcn/xH3SQIcW8hBPQn5gU1HVFfbAsT2l9J2qcdQi3vE88wdKOUlIvsctPehHwug
 xGtKNNY5soumjqrWVfclKgN6kD86X6KS1lFxWpl3T+LRvzDuqrdJf/oWQRnxpFIKk771INk+u+lGu+
 nAPURX/CIk6/z/Tl57qGid/Cwr/0Llb5Q1JniIpFfp+ulKVGY6YeCuDLEi89NFE9/QQUooo+/GEkFQ
 pAPgpMxjGMt26/LzvdaRR4rrT0BS5tzT1VSInoncJAcwivrHQonenbpJDs/N+DRQfzFw45Va2kjGus
 V5th/H1lIRqm2bTFcaqPhiAaykKojfTb646ud7lhAKqWvTIZUDr+EnkLOW5iFLA6fx5dfnd3an7gzH
 QQZxT/+WUtYedNPLPiWrfDGWgz3a+NPKB7uqOr56zqvuAUSnRIrFZg4J+6quc0njXTUb2uKXD/Sxip
 NQUaO8hI7S4oCx/Uj8nx/9PNDO1FFM9qvhGCrFfyYiFcFRGR06FKUNfr9+ONbYhH8Q1hWbQWgoYbZX
 RyEFfusjjRJzhvs6aepmktan+/wEeHEXaf7zQgr5J9oix/mO0e8xrnzwi8kA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is derived from [1], with only the GPIO orientation.

On the SM8550 platform, the PMIC Glink firmware doesn't emit
ALTMODE events for all USB-C port changes like it was done
for older platforms (like SM8450).
This means we only have a valid orientation when an Altmode
compliant device is inserted, but not for all the other devices,
including USB cables, dongles and non-altmode Hubs.

But the actual orientation is shared by the PM8550B by
a signal called CC_OUT which can be read on a gpio of the SM8550
SoC.

Let's add support for this feature by using the UCSI PMIC
Glink driver events to read and dispatch the orientation
to the USB-C connector devices on the DT graph.

While everybody would prefer having a proper PMIC Glink event
for an orientation change, this is not implemented and not
planned for future platforms either.

[1] https://lore.kernel.org/all/20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Update bindings property description to describe how multi-port is handled
- Link to v1: https://lore.kernel.org/r/20230804-topic-sm8550-upstream-type-c-orientation-v1-0-36dd3edec7bf@linaro.org

---
Neil Armstrong (4):
      dt-bindings: soc: qcom: qcom,pmic-glink: add a gpio used to determine the Type-C port plug orientation
      usb: ucsi: glink: use the connector orientation GPIO to provide switch events
      arm64: dts: qcom: sm8550-mtp: add orientation gpio
      arm64: dts: qcom: sm8550-qrd: add orientation gpio

 .../bindings/soc/qcom/qcom,pmic-glink.yaml         | 19 ++++++++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |  1 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |  1 +
 drivers/usb/typec/ucsi/ucsi_glink.c                | 54 +++++++++++++++++++++-
 4 files changed, 74 insertions(+), 1 deletion(-)
---
base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
change-id: 20230804-topic-sm8550-upstream-type-c-orientation-0bbbb360d3f7

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

