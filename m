Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623877659E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjG0RSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjG0RSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:18:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4820930E9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:18:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686f090316dso813597b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690478310; x=1691083110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKU1yBs0msHXwREPYd0SDWl2QoMQpyRkOYWlocB0jV8=;
        b=hrjc6QVjkTWq756/oBU5TwOfxXFlfrddRZA3xgCdnzV3H8TGz7rkhyiWq26zrqPRy4
         dUbD98OflDDDsAwomLX59QoDRh2aBaZ6gDfSuQPxPNA61kkKhjuO1MR9BECRlWkGujeC
         PFGzR5Ye6qlpD1WUGuSmfDuHJJxFGc3WklA5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478310; x=1691083110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKU1yBs0msHXwREPYd0SDWl2QoMQpyRkOYWlocB0jV8=;
        b=U0xzhmKIixMz3Q1nCntQsxzDT5QPGF2Me3D1mYdaan1ZA+c5nf6Row3aNqJPSWTsJi
         /w+GSUx0GZEYy5Mi7CewLQ5udw9jBOkRJt8cgjcpKTbXY7zPjslNK7VhofUj+pnkZU7G
         HQaEkcIKCBXzBgPboQG2V+BGdVj0Kjj6OYFIK6LElC3oGHg6WL5CPi4hI2Zl85BHxnxQ
         Dpzbo57ITM3Vb1Qhk6+S+n/OPc08IZtrS/WfyQfEHmMoz6vobulBvqH95K+NSuvMQv28
         9E4Nm31+wedWxwsC3cLDK1xnpZyXLHGk4+9JLCYy6N94WBYKxmXcGpzlU7Wrpqd4y2xT
         v6Sw==
X-Gm-Message-State: ABy/qLY2T+SKePH6d0pIhvzlqy7GT4seqsLikyqqgtDlmxcSOfy8NvKh
        ukC9KBSA1lTpE8mfUuRHBQNW+Q==
X-Google-Smtp-Source: APBJJlGl8SynkgJTMJXL2V6Y++i5cfJeXPU6WuoXupbSwRd2SlAsHeaos+4AwL8PeR0DpLWnchlWNw==
X-Received: by 2002:a05:6a00:14c4:b0:686:49b0:21ca with SMTP id w4-20020a056a0014c400b0068649b021camr6341987pfu.7.1690478310361;
        Thu, 27 Jul 2023 10:18:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:2339:954b:b98f:611a])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79111000000b0064f76992905sm1702524pfh.202.2023.07.27.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:18:29 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-arm-msm@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        hsinyi@google.com, Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v4 00/11] drm/panel and i2c-hid: Allow panels and touchscreens to power sequence together
Date:   Thu, 27 Jul 2023 10:16:27 -0700
Message-ID: <20230727171750.633410-1-dianders@chromium.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The big motivation for this patch series is mostly described in the patch
("drm/panel: Add a way for other devices to follow panel state"), but to
quickly summarize here: for touchscreens that are connected to a panel we
need the ability to power sequence the two device together. This is not a
new need, but so far we've managed to get by through a combination of
inefficiency, added costs, or perhaps just a little bit of brokenness.
It's time to do better. This patch series allows us to do better.

Assuming that people think this patch series looks OK, we'll have to
figure out the right way to land it. The panel patches and i2c-hid
patches will go through very different trees and so either we'll need
an Ack from one side or the other or someone to create a tag for the
other tree to pull in. This will _probably_ require the true drm-misc
maintainers to get involved, not a lowly committer. ;-)

Version 4 of this series adds a new patch that suspends i2c-hid
devices at remove time even for non panel-followers to make things
consistent. It also attempts to isolate the panel follower code a bit
more as per Benjamin's feedback on v3 and adds an item to the DRM todo
list as per Maxime's request. As per Maxime's response to my v3 cover
letter, I added his Reviewed-by tag to all 10 patches that were part
of v3 (but left it off of the new i2c-hid patch in v4).

Version 3 of this series was a long time coming after v2. Maxime and I
had a very long discussion trying to figure out if there was a beter
way and in the end we didn't find one so he was OK with the series in
general [1]. After that got resolved, I tried to resolve Benjamin's
feedback but got stuck [2]. Eventually I made my best guess. The end
result was a v3 that wasn't that different from v2 but that had a tiny
bit more code split out.

Version 2 of this patch series didn't change too much. At a high level:
* I added all the forgotten "static" to functions.
* I've hopefully made the bindings better.
* I've integrated into fw_devlink.
* I cleaned up a few descriptions / comments.

As far as I can tell, as of v4 everyone is on the same page that this
patch series looks like a reasonable solution to the problem and we
just need to get all the nits fixed and figure out how to land it.

[1] https://lore.kernel.org/r/gkwymmfkdy2p2evz22wmbwgw42ii4wnvmvu64m3bghmj2jhv7x@4mbstjxnagxd
[2] https://lore.kernel.org/r/CAD=FV=VbdeomBGbWhppY+5TOSwt64GWBHga68OXFwsnO4gg4UA@mail.gmail.com

Changes in v4:
- Document further cleanup in the official DRM todo list.
- ("Suspend i2c-hid devices in remove") new for v4.
- Move panel follower alternative checks to wrapper functions.
- Rebase atop ("Suspend i2c-hid devices in remove").

Changes in v3:
- Add is_panel_follower() as a convenience for clients.
- Add "depends on DRM || !DRM" to Kconfig to avoid randconfig error.
- Split more of the panel follower code out of the core.

Changes in v2:
- Move the description to the generic touchscreen.yaml.
- Update the desc to make it clearer it's only for integrated devices.
- Add even more text to the commit message.
- A few comment cleanups.
- ("Add a devlink for panel followers") new for v2.
- i2c_hid_core_initial_power_up() is now static.
- i2c_hid_core_panel_prepared() and ..._unpreparing() are now static.
- ihid_core_panel_prepare_work() is now static.
- Improve documentation for smp_wmb().

Douglas Anderson (11):
  dt-bindings: HID: i2c-hid: Add "panel" property to i2c-hid backed
    touchscreens
  drm/panel: Check for already prepared/enabled in drm_panel
  drm/panel: Add a way for other devices to follow panel state
  of: property: fw_devlink: Add a devlink for panel followers
  HID: i2c-hid: Switch to SYSTEM_SLEEP_PM_OPS()
  HID: i2c-hid: Rearrange probe() to power things up later
  HID: i2c-hid: Make suspend and resume into helper functions
  HID: i2c-hid: Suspend i2c-hid devices in remove
  HID: i2c-hid: Support being a panel follower
  HID: i2c-hid: Do panel follower work on the system_wq
  arm64: dts: qcom: sc7180: Link trogdor touchscreens to the panels

 .../bindings/input/elan,ekth6915.yaml         |   5 +
 .../bindings/input/goodix,gt7375p.yaml        |   5 +
 .../bindings/input/hid-over-i2c.yaml          |   2 +
 .../input/touchscreen/touchscreen.yaml        |   7 +
 Documentation/gpu/todo.rst                    |  24 ++
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |   1 +
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |   1 +
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |   1 +
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |   1 +
 .../qcom/sc7180-trogdor-quackingstick.dtsi    |   1 +
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |   1 +
 drivers/gpu/drm/drm_panel.c                   | 218 ++++++++++-
 drivers/hid/i2c-hid/Kconfig                   |   2 +
 drivers/hid/i2c-hid/i2c-hid-core.c            | 349 +++++++++++++-----
 drivers/of/property.c                         |   2 +
 include/drm/drm_panel.h                       |  94 +++++
 16 files changed, 617 insertions(+), 97 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog

