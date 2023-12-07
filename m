Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F243C8082AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjLGISD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGISB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:18:01 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26952DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:18:08 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d03fb57b69so4708955ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701937087; x=1702541887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ogWC6aXr0co7496xG70uhIqQbvQeFN6t7NUTqWYnsUU=;
        b=gRgVIUnnOCFEbRy0L0mlrTedbAFafY99xMmeIxZtFNsBF8ZqngVDzdZMXmukuuVfoc
         y1rOksAw1csZh5Hx31wtN7thMqtl6457FiIL8Hofp8ciINK1RAQm6UZKHzaW1A3K60e4
         s1f3BJPrTk/nrQluxNczycqoocvrpsAS1YaPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701937087; x=1702541887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogWC6aXr0co7496xG70uhIqQbvQeFN6t7NUTqWYnsUU=;
        b=EhiUayqH+/cA+FyUsfPwxG7M5JE7FO3levlt22SJk3J4rAt0RP7t8y4FEsCtpp/J5V
         oeMwoZVsKHXQmpT40mOnP7VpuZdU/4WaN0PCZmI8ZXCbQZecAh+WfKq+vQYYollvtIwZ
         HtV9n32jlUvlu/xYjwt370uUrYtyAkGms0EZiBNQa74ZmfnmkndT2dS1f+cRIh4mxldZ
         25meapNnZrHTjiRemqmpeYekcyYlxzMNIBEWBbIaIZgX4xfQ/0mMT7M5UkuCpWYJ9E15
         f6erdF65BthDUsb21ofY6fgWYmJJ04kzjciVKwsuV2gf33/CAC8oSHO4ZUc1iayDHW7D
         pMVA==
X-Gm-Message-State: AOJu0Yw3GAUdfylCngeF5hoo7zVpAYqNMt7z4ZBMu5ITH9sSr/C1uZyF
        twNLN/RCmODnbW/WoxEarzFELCn/2cvyuiubIRY=
X-Google-Smtp-Source: AGHT+IEp5hKQQmDxI/X5QAOIPteQpG71UFyE9a+2u0kC/L1w4+IZsOjIHgenhOC+1H8dt+CmwGJL5g==
X-Received: by 2002:a17:902:740b:b0:1d0:6ffd:6e4f with SMTP id g11-20020a170902740b00b001d06ffd6e4fmr1551434pll.71.1701937087564;
        Thu, 07 Dec 2023 00:18:07 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:663f:6f8e:5f2d:e06c])
        by smtp.gmail.com with ESMTPSA id t23-20020a1709028c9700b001d09c5424d4sm748128plo.297.2023.12.07.00.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 00:18:07 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 0/4] Support panels used by MT8173 Chromebooks in edp-panel
Date:   Thu,  7 Dec 2023 16:17:34 +0800
Message-ID: <20231207081801.4049075-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains 4 patches:
1. Sort the panel entries as a clean up. This one has no dependency with
   other patches in this series and can be merged separately.
2. Add a new panel delay to support some BOE panels
3. Add panel entries used by Mediatek MT8173 Chromebooks.
4. Add panels missing data sheets but used to work in older kernel version
   without any specified delays.

Changes in v2:
- Add a new patch to sort the list, and rebase the rest patches.

Pin-yen Lin (4):
  drm/edp-panel: Move the KDC panel to a separate group
  drm/panel-edp: Add powered_on_to_enable delay
  drm/edp-panel: Add panels delay entries
  drm/panel-edp: Add some panels with conservative timings

 drivers/gpu/drm/panel/panel-edp.c | 93 ++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

-- 
2.43.0.472.g3155946c3a-goog

