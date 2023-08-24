Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E0787C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbjHXX5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjHXX4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:56:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC27919BE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:56:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso23186e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692921398; x=1693526198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TD8UWO92SORs7p32tv6N7DK3UyRUfiGcxfa7tlZpBYw=;
        b=a8pCukFl7eG+Vb/nwewp2va+m5wRrJ5s8ShbgWtMpDGO4LuNWAOG8ItA+Zrbbd4wNH
         xdxRobZnNPaXaWbxm9ULMJIrjQ6SNQ/oVGmOH5EBK7XJ9JNynG8VTaWEwkk2Tlg08qNx
         RzQRWLyXW7qf/10rNgEQ5S5XG+8SRvPrubMoSbbD2xJYcHB5badu2XTfz9NKVoHI/u5w
         Bz3GHP8M6sYlRcwEWIrJwPS3WkpjHuOOad0SYySKKquBEwxBBNww1hQIxmtRp8RWlH+A
         oXJWn+eNRY8+9afu2w/ohRQsPRUn6gETC96UHegdzj0RtvGeB3hNsKRQpRYrfzoOCAJh
         TYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692921398; x=1693526198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TD8UWO92SORs7p32tv6N7DK3UyRUfiGcxfa7tlZpBYw=;
        b=F6Y9xFbcXfB3dzatGT77VH5ldzyP9028gXlJCxT4oDB3ubeLiq5018hIMauY8hIK/D
         l2dzO6iIDTB5jpicrFveUOmZdL9PwQg05OSvs3W2Ue4cSlSSCrgcQU1JDNRk2/AMCAm2
         LY8cmnS/peqSbnyQIcq7KpnsRrB8hIh6+TX6hXN0jNv1JQQ56zDYLpL/CN2TV+gfOZE2
         QLnEh4HKOtRczBvvwUs/oluE/MvG5DW92HPQtWnaygdFj1l+cP8Pc6IqmyB/wFUcMSMp
         LadYjG+ZzUKtq5ysPp10PJrkRv37MauuWCgN8OkqWYgby7MWdg5VCxzSmTmpn9FioDC3
         L09w==
X-Gm-Message-State: AOJu0YxmK5ONpqo3qnKYuJhgbhlJhC9xLxf1xVS9Fa9z1j5PJrdlDBFv
        8YRwyAzStu6PB+PkgeStit2Hww==
X-Google-Smtp-Source: AGHT+IGyk/WN0XsmZwuvxJEVmOV2xPJ/f/SBynzEJljKTG/YFpOiRWHseqihocuDideMtROIEoTV6A==
X-Received: by 2002:a05:6512:12d6:b0:4f9:6842:afc with SMTP id p22-20020a05651212d600b004f968420afcmr15403132lfg.64.1692921397540;
        Thu, 24 Aug 2023 16:56:37 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j15-20020ac2454f000000b004fe5688b5dcsm57900lfm.150.2023.08.24.16.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 16:56:37 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v7 0/3] drm/bridge_connector: implement OOB HPD handling
Date:   Fri, 25 Aug 2023 02:56:33 +0300
Message-Id: <20230824235636.1436665-1-dmitry.baryshkov@linaro.org>
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

Note, numbering for this series starts from v5, since there were several
revisions for this patchset under a different series title ([1]).

USB altmodes code would send OOB notifications to the drm_connector
specified in the device tree. However as the MSM DP driver uses
drm_bridge_connector, there is no way to receive these event directly.
Implement a bridge between oob_hotplug_event and drm_bridge's
hpd_notify.

Merge strategy: since this series touches i915 code, it might make sense
to merge all three patches through drm-intel.

[1] https://patchwork.freedesktop.org/series/103449/

Changes since v6:
- Rebased on top of linux-next. Fixed the freshly added
  new drm_connector_oob_hotplug_event() call.

Changes since v5:
- Fixed checkpatch warning in the first patch (noted by intel-gfx CI).

Changes since v4:
- Picked up the patchset
- Dropped msm-specific patches
- Changed drm_bridge_connector_oob_hotplug_event to call connector's HPD
  callback directly, rather than going through the last bridge's
  hpd_notify
- Added proper fwnode for the drm_bridge_connector

Bjorn Andersson (1):
  drm: Add HPD state to drm_connector_oob_hotplug_event()

Dmitry Baryshkov (2):
  drm/bridge_connector: stop filtering events in
    drm_bridge_connector_hpd_cb()
  drm/bridge_connector: implement oob_hotplug_event

 drivers/gpu/drm/drm_bridge_connector.c        | 34 ++++++++++++++-----
 drivers/gpu/drm/drm_connector.c               |  6 ++--
 .../gpu/drm/i915/display/intel_display_core.h |  3 ++
 drivers/gpu/drm/i915/display/intel_dp.c       | 17 ++++++++--
 drivers/usb/typec/altmodes/displayport.c      | 17 +++++-----
 include/drm/drm_connector.h                   |  6 ++--
 6 files changed, 60 insertions(+), 23 deletions(-)

-- 
2.39.2

