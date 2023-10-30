Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA37DBA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjJ3NXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJ3NXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:23:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CA8C6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:23:06 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 46B82660297B;
        Mon, 30 Oct 2023 13:23:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698672185;
        bh=TxpERrHKvTXLv7m6DqA8hS2RM5V93+V2vFmeraHSOl0=;
        h=From:To:Cc:Subject:Date:From;
        b=MgC3ld0hp1ucNJ8hYE/CQB6rOFdkGUDdh5aNHd2Yf+ZDPyfrt0QEoyArU9WLoirI3
         dO3j4ke8OcVsxL6DZyMGBJs1tjnk3pZs2I7NAc8aVCis5bzn/V2iiqmfvxNKn1D9xh
         6EXM5NPAlIlVBdjROTAgeaQ26D6X1RxJB+zjhbV7xgdYPwlFoKccoEYZ3K9egQfRQc
         PSSWjG+eIhcR3qqn/bSI+4Wk3LmXfwStmus2Yh2lVpsQvZAhjhuqhE0vTww5FyoM9I
         fjuEgX/yFxSnjAGQU1xrkkVRlLQkh/RFV1GcBXXE2oMf8rrCFuPYCxbvM46xDDLq2p
         AMhuZnN1yMRdQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     boris.brezillon@collabora.com
Cc:     robh@kernel.org, steven.price@arm.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com
Subject: [PATCH 0/4] drm/panfrost: Turn off clocks and regulators in PM
Date:   Mon, 30 Oct 2023 14:22:53 +0100
Message-ID: <20231030132257.85379-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
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

At least MediaTek platforms are able to get the GPU clocks and regulators
completely off during system suspend, allowing to save a bit of power.

Panfrost is used on more than just MediaTek SoCs and the benefits of this
can be variable across different SoC models and/or different SoCs from
different manufacturers: this means that just adding this ability for all
could result in unexpected issues and breakages on untested SoCs.

For the aforemenetioned reasons, turning off the clocks and/or regulators
was implemented inside of a capabilities barrier that shall be enabled on
a per-SoC basis (in the panfrost_compatible platform data) after testing
of both benefits and feasibility.

In this series, I am adding the ability to switch on/off clocks and
regulators and enabling that on all MediaTek platforms, as I was able
to successfully test that on multiple Chromebooks featuring different
MediaTek SoCs; specifically, I've manually tested on MT8186, MT8192 and
MT8195, while MT8183 got tested only by KernelCI.

Cheers!

AngeloGioacchino Del Regno (4):
  drm/panfrost: Implement ability to turn on/off GPU clocks in suspend
  drm/panfrost: Set clocks on/off during system sleep on MediaTek SoCs
  drm/panfrost: Implement ability to turn on/off regulators in suspend
  drm/panfrost: Set regulators on/off during system sleep on MediaTek
    SoCs

 drivers/gpu/drm/panfrost/panfrost_device.c | 78 ++++++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_device.h | 13 ++++
 drivers/gpu/drm/panfrost/panfrost_drv.c    |  3 +
 3 files changed, 90 insertions(+), 4 deletions(-)

-- 
2.42.0

