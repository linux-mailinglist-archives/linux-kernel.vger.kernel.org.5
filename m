Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62A18134BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573788AbjLNP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjLNP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:28:16 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07477120
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:28:23 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so7571433b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702567702; x=1703172502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9CkKINM+/aPcMo5tRDcD7LWm4cDJht/J5IJH55/f6lA=;
        b=LlgTXha5kYD/PE1A05SmmEYrpecOG2jiAqHCsK8KLlHXl+2mrIRG3IlDpg6AHvD05l
         1pe/zMfm/wYNdppz0nOWQ8MBcD/8eRZaat2itoeAERMq/ijWZrqfHAxbMTkMkRx6BuTs
         HuhmX6doSLp/ZNRQibArF7Pw9De0541flXiNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567702; x=1703172502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CkKINM+/aPcMo5tRDcD7LWm4cDJht/J5IJH55/f6lA=;
        b=IMUq/LGOwkR7lw8GxjGyXpLuNCXAZKhv4O36wbbJvnj2ESfhiYvsqYr8tRAYLRORvY
         LtageiXv7tRCWfH5SM9E3urmQaKCZzVHtcfnQmWgAorXfwvosWXuE173Jx8CDB4j1S4g
         VpJlAhTFPDMv6V3kWUJhoznMBPRKo9o2LBl/m2t5nKQhgTjEbAe4CDEuWsxbH7z8Z41B
         N3FIv+IkE/yaqkWS+aaw+k5BeItA6azsZwwrZlB92c9NR66vOGYWecqzfNdL41WI05Eg
         B09TgvY7O2rWB6d4X55SiptEBNn48HbAydLr15QsCjmujyit1LYgS6qkwOMvx1PlSUB6
         fjYA==
X-Gm-Message-State: AOJu0YzNOs55Y6bcIXYvRGjxhofIw0Ar1hDbvfDzI8COS9aGQfqRwUJn
        lvmTnnfqMnwEUaBoENYubcv6bQ==
X-Google-Smtp-Source: AGHT+IFVpd7HM90GGPHMDCXvLlO+AseYoQy9SqoZkiiBOJY7xvw6IVDAwUP+f1hTU7nY4fn5zSUY8w==
X-Received: by 2002:a05:6a20:3b86:b0:18b:fc33:a617 with SMTP id b6-20020a056a203b8600b0018bfc33a617mr10380206pzh.1.1702567702487;
        Thu, 14 Dec 2023 07:28:22 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:6530:8349:4ba8:984a])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78108000000b006ce7bd009c0sm12281179pfi.149.2023.12.14.07.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:28:22 -0800 (PST)
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
Cc:     Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3 0/3] Support panels used by MT8173 Chromebooks in edp-panel
Date:   Thu, 14 Dec 2023 23:27:49 +0800
Message-ID: <20231214152817.2766280-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains 4 patches:
1. Add a new panel delay to support some BOE panels
2. Add panel entries used by Mediatek MT8173 Chromebooks.
3. Add panels missing data sheets but used to work in older kernel version
   without any specified delays.

Changes in v3:
- Collect review tag.
- Update the commit message.

Changes in v2:
- Add a new patch to sort the list, and rebase the rest patches.

Pin-yen Lin (3):
  drm/panel-edp: Add powered_on_to_enable delay
  drm/edp-panel: Add panels delay entries
  drm/panel-edp: Add some panels with conservative timings

 drivers/gpu/drm/panel/panel-edp.c | 90 +++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

-- 
2.43.0.472.g3155946c3a-goog

