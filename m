Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD7790E2A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348573AbjICV3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjICV3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:29:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B4E5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:29:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-500cfb168c6so1443604e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693776579; x=1694381379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aO7JcMbv/31Ao0IItAJcvJ97CXcaD4GQwRMPpX5ISig=;
        b=bKKaQZZ/Nu3YE2Zy3zo6dks4xUeVNUqybvkloqbao2w0+SNsCM5AVTcQZJZPmrLI5s
         qmvA5cgiZBGFMJUHKYPzlCTWsAPdhlgj8mSpRtFRuU7Tlvh6wbzKe14hohlQSI/PLnqV
         lP8R7SebGNSTTp96ioI9ZpGKmRqmk8LMU5Z48Je10ILDI4bWP9LehTcey4O/dMrUFz9v
         nNnNTYQMQ+jFN/1kCDLIIdjkVnEwQ0RbE//SNOfdXln5OjywWSz77xAIghluliZXPveH
         wxtXBuqDBGo+oVRyjNTEE46Pwkn2DfNLFpA6gGieMCHoJmv0Ll13/nHGX2kQaDNaxm4H
         NilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693776579; x=1694381379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aO7JcMbv/31Ao0IItAJcvJ97CXcaD4GQwRMPpX5ISig=;
        b=OXWuNrlYlZAmaatCyYg6xnzD7BSDAB5zb63Q0kVqa1MD48HwDfFj2M2dFKKFc71Fym
         /etk+ks95406385BjHIQ4wDjyR8odG2FQucqpdnLI2ernKE0yztZHp/tJd/Zr9ELbwBq
         Vb9bt34WySuPjfWrUaYDSxZBIPe5eTQ4657Eztp0zTQrJIgJryCNCKDj/4zOboEZ1bpf
         HgJ7qtP7cx6dZHU0cOJ7r+mhpxL9vHvXKm/r9fNPJoCxEtWXN04nfBv5hrXS3HoYMy8z
         JKFuAC7SxsSjfaBxZPvqndVf+UJPs38PHI1UKBAvpn823nqIj8UW8e/iCgnJJEo5G7MI
         1EAA==
X-Gm-Message-State: AOJu0Yzqc5fCdWOmQ0JdxJ3RR1WE21FHNFmeMP5FlBt04fNQqGmMwhA/
        7LLFntmUqv8ERXwTM01JavT2pQ==
X-Google-Smtp-Source: AGHT+IE1TS5PmWbbxqldzYnmj04E5wJiAVQrziZm2fN2wTg0sXGtBtxHtmvZVFyK6YP6ZwgEHbm6eg==
X-Received: by 2002:a05:6512:230b:b0:500:96fc:129d with SMTP id o11-20020a056512230b00b0050096fc129dmr7034864lfu.14.1693776578713;
        Sun, 03 Sep 2023 14:29:38 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id eq11-20020a056512488b00b004ff8d9ed368sm1412352lfb.258.2023.09.03.14.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 14:29:38 -0700 (PDT)
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
Date:   Mon,  4 Sep 2023 00:29:34 +0300
Message-Id: <20230903212937.2876815-1-dmitry.baryshkov@linaro.org>
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
to merge it through drm-intel.

[1] https://patchwork.freedesktop.org/series/103449/

Changes since v6:
- Fixed the fwnode refcount in drm/bridge-connector

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

 drivers/gpu/drm/drm_bridge_connector.c        | 36 ++++++++++++++-----
 drivers/gpu/drm/drm_connector.c               |  6 ++--
 .../gpu/drm/i915/display/intel_display_core.h |  3 ++
 drivers/gpu/drm/i915/display/intel_dp.c       | 17 +++++++--
 drivers/usb/typec/altmodes/displayport.c      | 17 ++++-----
 include/drm/drm_connector.h                   |  6 ++--
 6 files changed, 62 insertions(+), 23 deletions(-)

-- 
2.39.2

