Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447DA7BE7B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377526AbjJIRVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377398AbjJIRVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:21:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E5A9D;
        Mon,  9 Oct 2023 10:21:35 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-211-168.ewe-ip-backbone.de [91.248.211.168])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B2B0660576C;
        Mon,  9 Oct 2023 18:21:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696872093;
        bh=S3Q3wy3S+Hlg0M67reAdf08JdB1Ll1t/5ni1XvqOXYE=;
        h=From:To:Cc:Subject:Date:From;
        b=D6SkAtHwOoXNxqzVn/7sMVWmnmHRbRZ/USejYVfZ264H+7yfrFBHrElQIqgTSPTdp
         Z8D6WuFZQT3XyF98CQ+juDjeRGHbtSOIQODxWR6UyVHZy1bmNwV+Ar1WXByeFMPWPu
         bGran28Kk15KiGDQniX6OSdyc6xUh4wPp9cDtTrDAcpX+E5KzsrWZQ2jfB5DZznM8Z
         aIr9iRFhCbVO3UMx45ie0gbMxbcgPAYqR0i7yfwYPJRkJKpTVOMYDcA7hctVQpSGu7
         iWoCf1WvkVLtd1HzNDmuw2Sn6CUEyOrEXq7/9oV1+aHPoQfQnKKBtRT6yEwoLVm9cc
         iekRuMlXC/NNA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1ADE84800CB; Mon,  9 Oct 2023 19:21:31 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 0/3] RK3588 USB3 host controller support
Date:   Mon,  9 Oct 2023 19:20:08 +0200
Message-ID: <20231009172129.43568-1-sebastian.reichel@collabora.com>
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

Hi,

This adds RK3588 USB3 host controller support. The same DT binding
will be used for the two dual-role controllers, which are also DWC3
based, but using a different PHY and don't need the extra UTMI/PIPE
clocks.

The series has been tested with Radxa Rock 5B, which uses the controller
for the upper USB3 port. The patch enabling &combphy2_psu and &usbhost3_0
for this board will be send separately once this series has been merged.

Changes since PATCHv2:
 * https://lore.kernel.org/all/20230720173643.69553-1-sebastian.reichel@collabora.com/
 * update binding, so that "utmi" and "pipe" clocks may only be used on RK3588;
   at the same time do not allow "grf_clk" for RK3568, which does not have a GRF
   clock for USB3.

Changes since PATCHv1:
 * https://lore.kernel.org/all/20230719174015.68153-1-sebastian.reichel@collabora.com/
 * use same compatible for USB3 host and drd controllers (Krzysztof Kozlowski)
 * do not update reset-names (Krzysztof Kozlowski)
   - note: I dropped reset-names property, since there is only one reset line
     anyways. Binding could stay the same, since the reset-names property is
     optional
 * use "ref_clk", "suspend_clk" and "bus_clk" instead of "ref", "suspend" and "bus",
   so that they are the same as in RK3568 (Krzysztof Kozlowski)
 * rename handle name to "usb_host2_xhci" (Michael Riesch)
 * use RK356x style DWC3 binding instead of DWC3399 style
   - required adding an extra patch, so that the DWC3 core supports enabling
     the UTMI/PIPE clocks

-- Sebastian

Sebastian Reichel (3):
  dt-bindings: usb: add rk3588 compatible to rockchip,dwc3
  usb: dwc3: add optional PHY interface clocks
  arm64: dts: rockchip: rk3588s: Add USB3 host controller

 .../bindings/usb/rockchip,dwc3.yaml           | 66 +++++++++++++++++--
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 21 ++++++
 drivers/usb/dwc3/core.c                       | 26 ++++++++
 drivers/usb/dwc3/core.h                       |  4 ++
 4 files changed, 112 insertions(+), 5 deletions(-)

-- 
2.42.0

