Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42B6752E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjGNBiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjGNBiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:38:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C142D64;
        Thu, 13 Jul 2023 18:38:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CD6C61BBA;
        Fri, 14 Jul 2023 01:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2F5C433CC;
        Fri, 14 Jul 2023 01:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689298681;
        bh=9TI9J6mC1lCJpPc8yugRRuczYXnteaBnSfpK07oP/rw=;
        h=From:To:Cc:Subject:Date:From;
        b=iBXhPgcriMJ1+XItROFvnpDxNjY1K+s4THIVfK4o36kH1expG9OZZ+RQMu0ZVMj7n
         XHOhNIvHHsRas+cnh0my5HI0IfnuuRNH6CYaMa9A6J20I7JThbvU3W//+IgxVXibOY
         6Kd4G1xAoma53alLiT6jIYw+OKzpBrHMiTvIBEV+r859L+UCwqhTJXPn1Ob5MUAlXF
         zIf3oUR8N5Rl7t/1QZKKC/70m6WY2Pc729Dy5TUR0zovKYd2+cxLFxBjfSvmszeOD2
         dfpYGMEraP9W1feXMVfyypVUjTudO3JvPhP97zMZemX7af7feuhNOMXuL/TiCD0fPm
         eIw+QTEWuGQXw==
Received: by mercury (Postfix, from userid 1000)
        id C9628106766D; Fri, 14 Jul 2023 03:37:58 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 00/19] Sitronix ST7789V improvements
Date:   Fri, 14 Jul 2023 03:37:37 +0200
Message-Id: <20230714013756.1546769-1-sre@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi,

This adds panel support for Inanbo T28CP45TN89, which I found inside of a
handheld thermal camera. The panel is based on the st7789v controller. All
information is based on reverse engineering. I also appended the series
from Miquel Raynal adding EDT ET028013DMA panel support, so that I could
easily test it with my SPI_NO_RX setup. They are slightly different due
to rebasing.

Changes since PATCHv2:
 * https://lore.kernel.org/all/20230422205012.2464933-1-sre@kernel.org/
 * https://lore.kernel.org/all/20230616163255.2804163-1-miquel.raynal@bootlin.com/
 * Add Rob Herring's R-b for the DT binding
 * Make panel info "static const"
 * Add Michael Riesch's R-b to all my patches
 * Rebase to 6.5-rc1
 * Append Miquel's series

Changes since PATCHv1:
 * https://lore.kernel.org/all/20230317232355.1554980-1-sre@kernel.org/
 * Apply DT binding changes requested by Krzysztof Kozlowski and his Ack
 * I changed the driver patches to avoid code duplication and splitted
   the code a bit more

Greetings,

-- Sebastian

Miquel Raynal (6):
  dt-bindings: display: st7789v: Add the edt,et028013dma panel
    compatible
  dt-bindings: display: st7789v: bound the number of Rx data lines
  drm/panel: sitronix-st7789v: Use 9 bits per spi word by default
  drm/panel: sitronix-st7789v: Clarify a definition
  drm/panel: sitronix-st7789v: Add EDT ET028013DMA panel support
  drm/panel: sitronix-st7789v: Check display ID

Sebastian Reichel (13):
  dt-bindings: vendor-prefixes: add Inanbo
  dt-bindings: display: st7789v: add Inanbo T28CP45TN89
  drm/panel: sitronix-st7789v: add SPI ID table
  drm/panel: sitronix-st7789v: remove unused constants
  drm/panel: sitronix-st7789v: make reset GPIO optional
  drm/panel: sitronix-st7789v: simplify st7789v_spi_write
  drm/panel: sitronix-st7789v: improve error handling
  drm/panel: sitronix-st7789v: avoid hardcoding mode info
  drm/panel: sitronix-st7789v: avoid hardcoding panel size
  drm/panel: sitronix-st7789v: add media bus format
  drm/panel: sitronix-st7789v: avoid hardcoding invert mode
  drm/panel: sitronix-st7789v: avoid hardcoding polarity info
  drm/panel: sitronix-st7789v: add Inanbo T28CP45TN89 support

 .../display/panel/sitronix,st7789v.yaml       |  10 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../gpu/drm/panel/panel-sitronix-st7789v.c    | 262 +++++++++++++++---
 3 files changed, 237 insertions(+), 37 deletions(-)

-- 
2.40.1

