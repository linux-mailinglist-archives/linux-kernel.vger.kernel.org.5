Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7467BE871
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377307AbjJIRk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377937AbjJIRkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:40:53 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231979D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:40:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so59778201fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696873249; x=1697478049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AVumlMvgURvTABPGEb+yEOR7ydtBlb2XaUShMA2Jpso=;
        b=iiCjnnVANQjOENWFFIIywqsc/TzMBMoBUJP4NtkuyRXOF/JsBxmkzPrp6kxPdhxNkn
         UY8G03h/yVZx0zdATS2+DZQL+FtpRCm1XT+iw2Q/ndmmxA/GMVtr50uKcZbCdilFUkYv
         Pg9M7tWTKlO1qnKa7IgtWHfgBHlbmAY9uGxU0VnR+WrbOh3v3ae1KkTGrHt2q3uk6qPn
         ghKLR5PYoFPFDtahQkr6FN90YIkR3pWUKtwurYglWS2jysjYBe2+8N8xXrW8bzIwPET6
         x/p5f7xqRZ3jlVUpHPTIv6kH8bV77HS3Zl8Hrcw7+tHfbHmpKfW+0shtwU3bdtANUwly
         2XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696873249; x=1697478049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVumlMvgURvTABPGEb+yEOR7ydtBlb2XaUShMA2Jpso=;
        b=sETlXkksytuMWmNw0Z4m08yizas/hP32xktHUMmzzVdH0ebAZ63Xj5oFaCYQborzmL
         ohpJ1EMuE2Ypu5WUziz+A5y/Op//fFae1xpdvc+LZKxROEv2F+DM9QqhpN3RExVGasGN
         5tqE4tvpF2QZr8SUG5ii1geVEN+MwhyhVvtsexiBS0N+lWy8Jn3/zRWNmtR2YxAMkAT9
         T1v8sz7JuiaAVdbqCNy4GMQigYoyMyBLj6mA732yTcl4z95w3r52TgxGetyguiNV42/t
         vQDY+E/iTl0hRzr7NDnM2MW9hLDB8qm8vFbc6HdBTR7MHSBQccbGa2hVmZOoTlb4hyuu
         rYTg==
X-Gm-Message-State: AOJu0Yzb1dW0Ib4K0msXXFGplFANW6iBNxbVDnaNFArT6mCTCAY5ziJR
        6W3rXV1FVR+oMtpBLdQeIlnz/A==
X-Google-Smtp-Source: AGHT+IHU1ZtC1U9QIDj0DA0FvUiZGB5mZ/YjYMp0hB0XPdzaikqfzWD/AfIvyIaceBBsA6KeQPDGrg==
X-Received: by 2002:a2e:8744:0:b0:2bf:ff53:556e with SMTP id q4-20020a2e8744000000b002bfff53556emr13590224ljj.23.1696873249322;
        Mon, 09 Oct 2023 10:40:49 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id z5-20020a2e3505000000b002bcbae4c21fsm2128988ljz.50.2023.10.09.10.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:40:48 -0700 (PDT)
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
        freedreno@lists.freedesktop.org, linux-usb@vger.kernel.org
Subject: [PATCH v7 0/3 RESEND] drm/bridge_connector: implement OOB HPD handling
Date:   Mon,  9 Oct 2023 20:40:45 +0300
Message-Id: <20231009174048.2695981-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend, since the previous submission got no responses. The
patches have been reviewed/acked by several maintainers. Can we please
gain some attention and either get it merged or understand what should
be changed / improved. This series is required to delivere HPD events
from altmode driver to the MSM DP driver in the sane way.


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

 drivers/gpu/drm/drm_bridge_connector.c        | 36 ++++++++++++++-----
 drivers/gpu/drm/drm_connector.c               |  6 ++--
 .../gpu/drm/i915/display/intel_display_core.h |  3 ++
 drivers/gpu/drm/i915/display/intel_dp.c       | 17 +++++++--
 drivers/usb/typec/altmodes/displayport.c      | 17 ++++-----
 include/drm/drm_connector.h                   |  6 ++--
 6 files changed, 62 insertions(+), 23 deletions(-)

-- 
2.39.2

