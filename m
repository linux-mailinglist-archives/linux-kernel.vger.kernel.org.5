Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C7A802A21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjLDCDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjLDCDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:03:01 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26350106
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:03:06 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bf1e32571so860036e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 18:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701655384; x=1702260184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AqWyck20cDBBqys7ex+djsjdXdDHAZm2aFpyswHTisk=;
        b=ZqNwbVlm2kLUON2ruW3+bAGbtlvbahN2KURWieHKr8KKLxlsw9aGdGRHNNTK47X9uv
         S1BlTxnXJfG2aNbWhf1apdEq6ZS51r8UA85SgzMlXexcYdcgwyp9KFb9QgO6wCGfUJZi
         1DtkAOyPb1jV9MpYyzrlNcC856rQF4NfZtVpFnUsemwxrsQyVD+drQL+xcsPxn92VcgV
         zO5Ui3uNGR2taXb8EvmX/zjsW2NNKDHorek9/2vA+lbIdSGoukzPfE8W7JBLDCtw+xm9
         MsFc4XGTOM968Pd0IkPrBQhSxk3fI9rRhyL1W+hXhPoacfuxVqhRH5Z08jYMYzBtQXw1
         FP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701655384; x=1702260184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqWyck20cDBBqys7ex+djsjdXdDHAZm2aFpyswHTisk=;
        b=PLCQe4ZgNOZf0CKV/wbiHNfqxXOtIrzKs2qKVXN+Y5tNkxpxT4FBPxLz9sO4Nm64V9
         fbP1Uwo9oWbiM+OvBWSNMUYeqk4+Hp0+CyHxgkR6hNzHv/YYOkdYy1pc2kJ54yDnNUkh
         LvJViw61wpDUTf+1KDXVmoMgfQg/WOedotS0qa7ThZb7EprDwV0dyXCyPxLzT8YkIVAo
         Lxn0ZGByAfNZ5LofI5gBuZNpFXDZv4UEwOoCWMfbPKq5x3c3ZylP497URWUDltGbcRFn
         oVabV+parSjdwIQJ+iWxShkalt52GB5qWMzPCdp+I7EwDdYl5FsVKeY6gQXYlt0RiRdG
         sI4g==
X-Gm-Message-State: AOJu0Ywfa6Nbgc4jRv89dscKBIbtzuNis1tWp/5EzRe1/cAv8ct7rl9t
        no2O/DKpahX3Zm7qmweAg3kRqA==
X-Google-Smtp-Source: AGHT+IHlf5cZZfyZCvGmTUr0UqBGf1nOu2Hl8bZCWwmidyxQGr+3+dIS9AyQUWz1vi/TQW4JbdMBYw==
X-Received: by 2002:a05:6512:24a:b0:50b:e4b4:d4f1 with SMTP id b10-20020a056512024a00b0050be4b4d4f1mr1330691lfo.87.1701655384258;
        Sun, 03 Dec 2023 18:03:04 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512348c00b0050bea5c2850sm525381lfr.39.2023.12.03.18.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 18:03:03 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Mark Gross" <markgross@kernel.org>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v4 0/3] dt-bindings: connector: usb: provide bindings for altmodes
Date:   Mon,  4 Dec 2023 04:02:59 +0200
Message-ID: <20231204020303.2287338-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases we need a way to specify USB-C AltModes that can be
supportd on the particular USB-C connector. For example, x86 INT33FE
driver does this by populating fwnode properties internally. For the
Qualcomm Robotics RB5 platform (and several similar devices which use
Qualcomm PMIC TCPM) we have to put this information to the DT.

Provide the DT bindings for this kind of information and while we are at
it, change svid property to be 16-bit unsigned integer instead of a
simple u32.

NOTE: usage of u16 is not compatible with the recenty extended
qcom/qrb5165-rb5.dts DT file, but it is more logical since SVID is
16 bits wide.

Changes since v3:
- Added enum to constraint atmode SVID (Rob)
- Moved additionaPropperties to come beore the property definitions
  (Rob)

Changes since v2:
- Inlined altmode definitions instead of having them under $defs (Rob)
- Explicity list permitted AltMode names (currenty only displayport is
  allowed) (Rob)

Changes since v1:
- Added type:object and fixed 'description' string in the altmodes-list
  definition.

Dmitry Baryshkov (3):
  dt-bindings: connector: usb: add altmodes description
  usb: typec: change altmode SVID to u16 entry
  arm64: dts: qcom: qrb5165-rb5: use u16 for DP altmode svid

 .../bindings/connector/usb-connector.yaml     | 33 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  2 +-
 drivers/platform/x86/intel/chtwc_int33fe.c    |  2 +-
 drivers/usb/typec/class.c                     |  5 +--
 4 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.42.0

