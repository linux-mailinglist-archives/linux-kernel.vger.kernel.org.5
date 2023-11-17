Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E47EFB0B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjKQVvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjKQVvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:51:04 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5173120
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:51:01 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso1768044a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700257861; x=1700862661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swBF5B7pk8gsTpy7ro1S9ZK9Y1Lu98QqRS2h9Xja/h8=;
        b=BdoDuYNG2zI7vgZYVPsMyZWujBszO5p77FRxM7C/L7E0cSQCiIE2Tt5ojQ91tdmE6o
         hZOqvUk5NtRs9CeoeZkAdUMmpvi6DHPNzLV5qHNsFyaY2X01KGK3E1alUSYtgYpfrL2f
         ljMK4/1hfeR65ep8uJV0UswfGN2f1xwr4fapI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700257861; x=1700862661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swBF5B7pk8gsTpy7ro1S9ZK9Y1Lu98QqRS2h9Xja/h8=;
        b=Es0hrQBw3VJXlBaOTjjd6Sw4ux+gsig3NJI4FITESSprYOWLfkTXmH6YVccyYpiPhd
         HwqNfhy//lNAS+NCcDtcyY4tEH49jVjUsfOorHMH6uJYfqqlZ7Eu8QzRr15I2aGYx/zM
         aP825+hVLXOdPnjWw7GFgz+Q0VlHA8cx5hxGnlh23qHkLQuz//0/e1yA+RbUIoa8CP5y
         a0mU4nQQ5pNcZksAP2oRMZClaf1SQnxw6fQJ1KXotIddHmdd4vw0v1JAimweFYHX5Vig
         FFUMas8KUpIz9x6qPKqg9DcU1IaHy4xOPEUc2pc9xu7cxyvHTzVMA46gEs91Mtsy5s++
         xTRw==
X-Gm-Message-State: AOJu0YyJXYAMu4Kdxxx+7jDYuvKEsv9iHCWi6OgEV/C+gqwj5d0d1ZXp
        YcGV+nHki/L27xu0HQaahvlqgQ==
X-Google-Smtp-Source: AGHT+IEUspXo2pTbNwW9zexsuhcFiZyZsalHf5KstkhLjR3XfhaoQzHpDx11A94uCRV3b5EuHixtow==
X-Received: by 2002:a17:90b:384b:b0:280:8544:42fb with SMTP id nl11-20020a17090b384b00b00280854442fbmr842143pjb.17.1700257861154;
        Fri, 17 Nov 2023 13:51:01 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:7ed:b095:f0ba:5801])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090aca0700b00256b67208b1sm3639587pjt.56.2023.11.17.13.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:51:00 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v7 0/3] Use correct mode for edp panel
Date:   Fri, 17 Nov 2023 13:46:31 -0800
Message-ID: <20231117215056.1883314-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains 2 part to handle mode selection for edp panel:
1. (patch 1, 2) Add a quirk to override the edid mode for generic edp.
2. (patch 3) If a panel contains hardcoded mode, skip edid mode.

Previous versions:
v1: https://patchwork.kernel.org/project/dri-devel/cover/20231101212604.1636517-1-hsinyi@chromium.org/
v2: https://patchwork.kernel.org/project/dri-devel/cover/20231102221309.1971910-1-hsinyi@chromium.org/
v3: https://patchwork.kernel.org/project/dri-devel/cover/20231106202718.2770821-1-hsinyi@chromium.org/
v4: https://patchwork.kernel.org/project/dri-devel/cover/20231106210337.2900034-1-hsinyi@chromium.org/
v5: https://patchwork.kernel.org/project/dri-devel/cover/20231107000023.2928195-1-hsinyi@chromium.org/
v6: https://lore.kernel.org/lkml/20231107204611.3082200-2-hsinyi@chromium.org/

Hsin-Yi Wang (3):
  drm/panel-edp: Add override_edid_mode quirk for generic edp
  drm/panel-edp: Add auo_b116xa3_mode
  drm/panel-edp: Avoid adding multiple preferred modes

 drivers/gpu/drm/panel/panel-edp.c | 79 ++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 11 deletions(-)

-- 
2.43.0.rc0.421.g78406f8d94-goog

