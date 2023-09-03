Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729A3790E56
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349199AbjICVmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348947AbjICVl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:41:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4F2F0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:41:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50079d148aeso1413487e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693777313; x=1694382113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4CGlwIh3CaiNYfDE8T4/N3NKVw9L1KuLHleXxMGA8k=;
        b=sL37z1nSxapwX1ACyQwJD5J17vIMjGOlYzI20UASAIey8kqRxI4mjpOLunNTr0u6KK
         jvpNqVkjoqjPTMONMwLwlzQKkafFdk3xRAB7v7F2C71kjfWv3RZAq0uwdXFBRgW5Ablu
         5qEtusCHwgTRJX0jw35/YtTrrnm483NhEudimhX/Y9mY6b1ypxLsOGIV2NXg1locgBn2
         GT8LylBHFPlCJAw9wBeuHQ564qtXwoDgreruE+BCcep2hASO7HKsC8zNooFIvAMa6b7z
         9wXUeRsY+cFjE1kA3IgrV4pnlZhjm+i9W7t1RIK5ziozF2te0A0ydoVmTyp2VCrfh/M7
         rszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693777313; x=1694382113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4CGlwIh3CaiNYfDE8T4/N3NKVw9L1KuLHleXxMGA8k=;
        b=fjehpdxsRaf/qbIPrya6BMJkvCmxB6NJ4rJe5WVhlU6PAmX0aztgTeOGASWuLfJj85
         dMDdtSn86jCeaxB4XtrnBFySOLTK6yHXRn24zEZjutf8SzeQMfgYbH48xEi7JI0xukM/
         oeIVYRkH51+mFxKx3q5kwezMveIDom0ZHkzdZBbiph4Ne/0Nb3/sNOcgQrQl2mCBgqoI
         Qs/vUEkiVCQVFFfP9qgzGrDChWmJmZy6DQe3mfWbDNENznftTlus43SbwHpaNa4PbWLU
         Wts9xFXO/xQOuog2VEirXQI97uV4mKa769tSNA37v36BnemHr/5KbctfMIMmXlEo4MmG
         EeBw==
X-Gm-Message-State: AOJu0YxtyrHfDo+aS4qG0hgSjRMWLVwqmrAiv73JXPWm7n1qUzrCa8gT
        M5lqiwos9WH9CHSq0QPtKPp0jA==
X-Google-Smtp-Source: AGHT+IHZcZHwPmZz/G9GJYrJdaFt/yh7kFkMispc1XECmMNIp6Mo7eyJQIJfgGNG8gZdXS8BoslEpA==
X-Received: by 2002:a05:6512:3444:b0:4fb:911b:4e19 with SMTP id j4-20020a056512344400b004fb911b4e19mr3890157lfr.35.1693777313473;
        Sun, 03 Sep 2023 14:41:53 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x17-20020ac25dd1000000b004f8555f7aa1sm1422506lfq.52.2023.09.03.14.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 14:41:53 -0700 (PDT)
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
Subject: [RFC PATCH v1 03/12] drm/connector: extend PATH property to covert Type-C case
Date:   Mon,  4 Sep 2023 00:41:41 +0300
Message-Id: <20230903214150.2877023-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
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

Userspace needs to identify whether the DisplayPort connector is a
native one or it is wrapped into the USB-C port. Moreover the userspace
might need to point user to the exact location of this Type-C port on
the laptop case.

Existing USB-C altmode implementations (i915, amdgpu) have used the
DRM_MODE_CONNECTOR_DisplayPort even for such ports. To keep backwards
compatibility we can not change this to DRM_MODE_CONNECTOR_USB.
Therefore the kernel needs some other way to represent this information.

To facilitate this, reuse the 'PATH' property, which was used to
describe the DP port in the DP MST configuration. Use either
'typec:portN' to point out to the Type-C port class device, or just
'typec:' if the corresponding port can not be identified.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_connector.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 05fc29a54801..a326782e936e 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1185,10 +1185,14 @@ static const u32 dp_colorspaces =
  * 	never read back the value of "DPMS" because it can be incorrect.
  * PATH:
  * 	Connector path property to identify how this sink is physically
- * 	connected. Used by DP MST. This should be set by calling
- * 	drm_connector_set_path_property(), in the case of DP MST with the
- * 	path property the MST manager created. Userspace cannot change this
+ * 	connected. This should be set by calling
+ * 	drm_connector_set_path_property(). Userspace cannot change this
  * 	property.
+ * 	In the case of DP MST this is equal to the path property the MST
+ * 	manager created. It is equal to 'mst:baseID-port-port...'.
+ * 	In the case of DP USB-C connector this is equal to the 'typec:portN',
+ * 	pointing to the corresponding Type-C port device or just 'typec' if the
+ * 	corresponding Type-C port can not be identified.
  * TILE:
  * 	Connector tile group property to indicate how a set of DRM connector
  * 	compose together into one logical screen. This is used by both high-res
-- 
2.39.2

