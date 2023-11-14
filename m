Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11FE7EB313
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjKNPJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjKNPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:09:37 -0500
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992DD1AD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:09:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699974115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aSK3PhR7N6sZarhUbzOpQIf2xDy+MEi2YkvSFf8r3Lk=;
        b=ZETvjTr/XoDUk1cALkokOKwWkjnYzpn+7hVWxVNdT9D8sYNONctRfHkEHuSBSNWYpvVaca
        One6lWWPF3vAxPEkZ19n1MKps/UJ16JOpyTi3fEZdzDyJ9K3sNFo6976rZNa7gcsPT4Zi0
        r7t23nPYD7WdzKYoyk0LpAJEREJAES4=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 0/8] Allow link the it66121 display bridge driver as a lib
Date:   Tue, 14 Nov 2023 23:01:22 +0800
Message-Id: <20231114150130.497915-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

The goal is to make this driver usuable on non-DT based systems, while
without introduce duplication and preserve code sharing. The first seven
patch just doing trivial cleanup, the last patch try to solve the mentioned
problem by allowing static linking. Tested on a ACPI-based platform:

$ dmseg | grep drm

 ACPI: bus type drm_connector registered
 loongson 0000:00:06.1: [drm] dc: 264MHz, gmc: 529MHz, gpu: 529MHz
 loongson 0000:00:06.1: [drm] Dedicated vram start: 0xe0030000000, size: 64MiB
 loongson 0000:00:06.1: [drm] Loongson VBIOS version: 0.3
 loongson 0000:00:06.1: [drm] Loongson VBIOS: has 8 DCBs
 loongson 0000:00:06.1: [drm] VRAM: 4096 pages ready
 loongson 0000:00:06.1: [drm] GTT: 32768 pages ready
 loongson 0000:00:06.1: [drm] lsdc-i2c0(sda pin mask=1, scl pin mask=2) created
 loongson 0000:00:06.1: [drm] lsdc-i2c1(sda pin mask=4, scl pin mask=8) created
 loongson 0000:00:06.1: [drm] DisplayPipe-0 has DVO-0 connector
 i2c 1-004c: IT66121 probed, chip id: 0x4954:0x612, revision: 1
 loongson 0000:00:06.1: [drm] DisplayPipe-1 has IT66121@4c attached
 loongson 0000:00:06.1: [drm] Total 2 outputs
 loongson 0000:00:06.1: [drm] registered irq: 40
 [drm] Initialized loongson 1.0.0 20220701 for 0000:00:06.1 on minor 0
 loongson 0000:00:06.1: [drm] fb0: loongsondrmfb frame buffer device

Sui Jingfeng (8):
  drm/bridge: it66121: Use dev replace ctx->dev in the it66121_probe()
  drm/bridge: it66121: Add bridge_to_it66121() helper and use it
  drm/bridge: it66121: Add a helper function to read bus width
  drm/bridge: it66121: Add a helper function to get the next bridge
  drm/bridge: it66121: Add a helper function to read chip id
  drm/bridge: it66121: Add a helper to initialize the DRM bridge
    structure
  drm/bridge: it66121: Add another implementation for getting match data
  drm/bridge: it66121: Allow link this driver as a lib

 drivers/gpu/drm/bridge/ite-it66121.c | 340 +++++++++++++++++++--------
 include/drm/bridge/ite-it66121.h     |  17 ++
 2 files changed, 258 insertions(+), 99 deletions(-)
 create mode 100644 include/drm/bridge/ite-it66121.h

-- 
2.34.1

