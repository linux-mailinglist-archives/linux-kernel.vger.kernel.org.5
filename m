Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD137790E45
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348902AbjICVl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348545AbjICVl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:41:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4C7CC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:41:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-500760b296aso1010956e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693777311; x=1694382111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V8+6hRoyuo0w27wr7qjZ8oFHPY2yc7kx8FAgPsdCc/g=;
        b=bgdLT3RL/PMlpcAJWfPMgES7q8a9vMHTyWNLFVnLJl+4e/lH9W6yce7u3a0JnCqW6T
         azCjfaNmXgpam0zH6DCqVi4Mv5xf7W6OEhWSvZ8i4qxl5cSJF1L7iuLhkEqNxB56YGkf
         xKLzSio0Ote9+ZVg3I2VqVs9Q5L5auDt5DUdji/htfRVILW1kfZu22f/UKC4aD4OF+y6
         lZ6vvqQoZRWK/mqfUgpNfJnwK4J6csWT/KEah1S1mpsyrlZf4Zv1GLiZBruPC6Y7m6N0
         anLA8K7ajBT8RDhYraGdnkW4Tdzyxvqze/QxtFYbAZo+vzzrgS+nqOFLpHQAAvpLZJt0
         /x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693777311; x=1694382111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8+6hRoyuo0w27wr7qjZ8oFHPY2yc7kx8FAgPsdCc/g=;
        b=cCcOQWccCa485AwqPg7SX14JnW7GdkolHTomQnZIDn0wyK3ldVvmQHTUYPiM5IqLjQ
         02Tkz5T8nDhhE0ykdm2JX3Gtdj9SpS7SLOC6KJnsR3Pk6sntFiR1UlcxuVCHx/4n/VzY
         /r0YkqYZXzDwD+WWRvNhMhySbUZ3QUFnV+hSmSafgfzJN77U3tkYLe+00OP8UBX+GbWM
         UI/WB6APfDTO0RFf/Aa/Zupni33OixEQ3zXRGdn6bFTATmaJPCsbYDPWnWzvtqADCjFV
         gHYl4Mw61sQSB91G7xuZ1mVovxKVyThFN5cgJXX6pajtJdXSL6SFtIgIzRnUWWfB5mPi
         gjLA==
X-Gm-Message-State: AOJu0YzZMOjpKBqrTfyVmCQbfr2C27Ql5sgi7QHk7Ziw/gevHB9zzLIu
        glzZ5NSXiweCiZJN2AM0AyXYFw==
X-Google-Smtp-Source: AGHT+IGtFPj/i132V84gFgb+9UX2XVd1+6zrpeCc6Tu4V8tR6EXyMighkqxBy2CLmJBokzxnUP+RZQ==
X-Received: by 2002:ac2:498d:0:b0:500:91f6:f129 with SMTP id f13-20020ac2498d000000b0050091f6f129mr2178545lfl.26.1693777311128;
        Sun, 03 Sep 2023 14:41:51 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x17-20020ac25dd1000000b004f8555f7aa1sm1422506lfq.52.2023.09.03.14.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 14:41:50 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [RFC PATCH v1 00/12] drm,usb/typec: uABI for USB-C DisplayPort connectors
Date:   Mon,  4 Sep 2023 00:41:38 +0300
Message-Id: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the discussion regarding DisplayPort wrapped in the USB-C
connectors (via the USB-C altmode) it was pointed out that currently
there is no good way to let userspace know if the DRM connector in
question is the 'native' DP connector or if it is the USB-C connector.

An attempt to use DRM_MODE_CONNECTOR_USB for such connectors was
declined, as existing DP drivers (i915, AMD) use
DRM_MODE_CONNECTOR_DisplayPort. New drivers should behave in the same
way.

An attempt to use subconnector property was also declined. It is defined
to the type of the DP dongle connector rather than the host connector.

This attempt targets reusing the connector's PATH property. Currently
this property is only used for the DP MST connectors. This patchset
reuses it to point out to the corresponding registered typec port
device.

Dmitry Baryshkov (12):
  Revert "drm/sysfs: Link DRM connectors to corresponding Type-C
    connectors"
  drm/sysfs: link DRM connector device to the connector's fw nodes
  drm/connector: extend PATH property to covert Type-C case
  drm/bridge-connector: set the PATH property for the connector
  drm/bridge: remove conditionals around devicetree pointers
  soc: qcom: pmic_glink_altmode: fix DRM connector type
  soc: qcom: pmic_glink_altmode: report that this is a Type-C connector
  usb: typec: support generating Type-C port names for userspace
  usb: typec: tcpm: support generating Type-C port names for userspace
  usb: typec: qcom: implement proper error path in probe()
  usb: typec: qcom: extract DRM bridge functionality to separate file
  usb: typec: qcom: define the bridge's path

 drivers/gpu/drm/bridge/panel.c                |  2 -
 drivers/gpu/drm/drm_bridge_connector.c        | 14 ++++-
 drivers/gpu/drm/drm_connector.c               | 10 +++-
 drivers/gpu/drm/drm_sysfs.c                   | 42 +-------------
 drivers/soc/qcom/pmic_glink_altmode.c         |  3 +-
 drivers/usb/typec/class.c                     | 14 +++++
 drivers/usb/typec/tcpm/qcom/Makefile          |  4 ++
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 56 ++++++-------------
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c | 40 +++++++++++++
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h | 22 ++++++++
 drivers/usb/typec/tcpm/tcpm.c                 | 14 +++++
 include/drm/drm_bridge.h                      |  9 ++-
 include/linux/usb/tcpm.h                      |  2 +
 include/linux/usb/typec.h                     |  2 +
 14 files changed, 146 insertions(+), 88 deletions(-)
 create mode 100644 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c
 create mode 100644 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h

-- 
2.39.2

