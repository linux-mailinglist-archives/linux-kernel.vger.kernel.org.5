Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4497D1200
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377616AbjJTPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377537AbjJTPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:00:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDE2D46;
        Fri, 20 Oct 2023 08:00:27 -0700 (PDT)
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 560AC660734F;
        Fri, 20 Oct 2023 16:00:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697814026;
        bh=AwagkB7kAuEMuWURdRVLbW91QS2Ae+qwHCvRYF46Ugg=;
        h=From:To:Cc:Subject:Date:From;
        b=WEAoYkuL7lFNdZh+IcbZUMdC/mvevTa5/DlHI+shC14FlvvjJWH25iXG41QRmzmwO
         iHLIecb8gLhTo2DROa/2q7asIJpqP3SEDjmMSpLyM8u+BPaL9/IFU59r62RrLVcJxg
         zYa3YnYnKox2LKJdq/3qOZDgd7GmufDfuEq2dQn1IZlbVZXfE/RFe4nqVyYZ4iHlUH
         KSDWeE1iX7ZVKDWUf/de8N+mBVF/dPRxu3eV1mkAS+ZUy6qSVMozMPFMids25Dk3Bc
         eQ8XnClzDQ71KFXcjlcfwy59BfywoXMQAAiE4goQjvdDifZjVCnpBjIucyDUjYxa4I
         trr2gTlkBC9nw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 04FD74800CB; Fri, 20 Oct 2023 17:00:24 +0200 (CEST)
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
Subject: [PATCH v4 0/3] RK3588 USB3 host controller support
Date:   Fri, 20 Oct 2023 16:11:39 +0200
Message-ID: <20231020150022.48725-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes since PATCHv3:
 * https://lore.kernel.org/all/20231009172129.43568-1-sebastian.reichel@collabora.com/
 * update binding, simplifying "rockchip,rk3568-dwc3"
 * update binding, no need to specify min/max items for "rockchip,rk3588-dwc3"
 * add driver inline comment, that "utmi" and "pipe" are RK3588 specific

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

 .../bindings/usb/rockchip,dwc3.yaml           | 60 +++++++++++++++++--
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 21 +++++++
 drivers/usb/dwc3/core.c                       | 28 +++++++++
 drivers/usb/dwc3/core.h                       |  4 ++
 4 files changed, 108 insertions(+), 5 deletions(-)

-- 
2.42.0

