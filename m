Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C2D78873C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244756AbjHYM1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244836AbjHYM1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:27:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9362123;
        Fri, 25 Aug 2023 05:26:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.83.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1E7736607286;
        Fri, 25 Aug 2023 13:25:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692966312;
        bh=REQjWp2zHtrfiDs99kq+h6FJkxnRTdlAsV7mFgtYf4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yd4+NKJOxy5N8Tm6mcZMdl+mvuQ74D5UxsXwSCKscOHz9vuwz3b3bTwaPZ/VgcjXZ
         FJTMdnsF4mV7I0nLA1ldxV1fLEttVn6s8U6izBM+Bppx/D0l5EKx2mbX99n6e9L9PM
         yTY7YAYz2pbkKO4C1butaugpRlvHeuX4KWEq6G1JH7pvXlxG9LmxmfrK7ASb8knF70
         CWmoS+za8k2+l8HIq+TZZyve7Y3auOyZNZAT7Q9gLYNzqnqmb52Ol6+Sov0H2KVpqo
         1VodBSiEz+/VxgynTr87DE3CltOmDByr6/1uu93o1rOwgNxfB9LnKgGkc1IOUQnCCo
         AJSGaLdztKHig==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     helen.koike@collabora.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, emma@anholt.net, robclark@freedesktop.org,
        gustavo.padovan@collabora.com, robdclark@google.com,
        anholt@google.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, corbet@lwn.net, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, heiko@sntech.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 2/6] drm: ci: Force db410c to host mode
Date:   Fri, 25 Aug 2023 17:54:31 +0530
Message-Id: <20230825122435.316272-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230825122435.316272-1-vignesh.raman@collabora.com>
References: <20230825122435.316272-1-vignesh.raman@collabora.com>
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

Force db410c to host mode to fix network issue which results in failure
to mount root fs via NFS.
See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8

Since this fix is not sent upstream, add it to build.sh script
before building the kernel and dts. Better approach would be
to use devicetree overlays.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/build.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
index 7b014287a041..c39834bd6bd7 100644
--- a/drivers/gpu/drm/ci/build.sh
+++ b/drivers/gpu/drm/ci/build.sh
@@ -70,6 +70,10 @@ if [ -z "$CI_MERGE_REQUEST_PROJECT_PATH" ]; then
     fi
 fi
 
+# Force db410c to host mode to fix network issue which results in failure to mount root fs via NFS.
+# See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8
+sed -i '/&usb {/,/status = "okay";/s/status = "okay";/&\n\tdr_mode = "host";/' arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+
 for opt in $ENABLE_KCONFIGS; do
   echo CONFIG_$opt=y >> drivers/gpu/drm/ci/${KERNEL_ARCH}.config
 done
-- 
2.40.1

