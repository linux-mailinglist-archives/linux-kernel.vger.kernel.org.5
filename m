Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B3F7C84D8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjJMLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjJMLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:47:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC9FBD;
        Fri, 13 Oct 2023 04:47:48 -0700 (PDT)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c8:b70a:ae01:c2e1:3bb7:ed5c:6a0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2144A6607357;
        Fri, 13 Oct 2023 12:47:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697197667;
        bh=qnEq8Sp9V5HwTo+4/aFGw2RoRPviwf6K6ml/tXqx2No=;
        h=From:To:Cc:Subject:Date:From;
        b=JiQL9f4Ayn30azENa7+igcoAIQ8NfZVhzBwjA7B8zBOpHkw9R8ycMAMRXIWUYryBg
         VRBJ0ZOJtlCJ6kUaCmoVLgZaQiSPluFz7xJ35xZRN2t75JRsHHxLl3s+mj0eIDhxfn
         emLlFw+8Jc08eZnnb4vLxWhAj7aPYPNrzL2m5ZPgTBgCcnWUgyco0iszgf5QKUCHOp
         6+7l+LDfaaOlOZd5U5ZW3yI63AS2dTrvUi/BklPTjSL9QA/Jbx4NyawVidQlJs3GdG
         akgQJL1VjiHa35R+2KxAaeUUXUWRkht6v0K6M6GXzStP/+6gIwgpu+wbletEp4Pp8C
         TWiFjyZcNFl/w==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yogesh Hegde <yogi.kernel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Fix i2s0 pin conflict on ROCK Pi 4 RK3399 boards
Date:   Fri, 13 Oct 2023 12:47:25 +0100
Message-ID: <20231013114737.494410-1-chris.obbard@collabora.com>
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

i2s0 fails to probe on my Radxa ROCK 4SE and ROCK Pi 4B boards with:

    rockchip-pinctrl pinctrl: pin gpio3-29 already requested by leds; cannot claim for ff880000.i2s
    rockchip-pinctrl pinctrl: pin-125 (ff880000.i2s) status -22
    rockchip-pinctrl pinctrl: could not request pin 125 (gpio3-29) from group i2s0-8ch-bus-bclk-off  on device rockchip-pinctrl
    rockchip-i2s ff880000.i2s: Error applying setting, reverse things back
    rockchip-i2s ff880000.i2s: bclk disable failed -22

This is due to the pinctl attempting to request a GPIO which the boards
use for a different function.

The first patch adds a missing pinctl node i2s0_2ch_bus_bclk_off to the
RK3399 devicetree.

The second patch sets the i2s0 pinctrl to use the new node when idle and
fixes the issue.


Christopher Obbard (2):
  arm64: dts: rockchip: Add i2s0-2ch-bus-bclk-off pins to RK3399
  arm64: dts: rockchip: Fix i2s0 pin conflict on ROCK Pi 4 boards

 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |  1 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 10 ++++++++++
 2 files changed, 11 insertions(+)

-- 
2.42.0

