Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30575B5BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjGTRgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTRgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:36:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B294E52;
        Thu, 20 Jul 2023 10:36:48 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-215-153.ewe-ip-backbone.de [91.248.215.153])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D9EA56607089;
        Thu, 20 Jul 2023 18:36:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689874607;
        bh=PYnYFsjDgSWv1EwJcbzjMpywQhwMfYgpRkS0GFAn/0Y=;
        h=From:To:Cc:Subject:Date:From;
        b=MAgE9R+MY8Ybrr//WKrqO3ktijxYYYw6ulVQMFSqIhQc7ncs0b4Z3HYL9xBCM8K44
         imZUvIQSoy5WeqCmNBUQPmyKupE1JmrCanZYpO2C7I6hdrBLWewxPel1UUoVAbd40J
         u6cHDF9QkhNcHXYcZ3LaoXx250PhcPtlxNrDhIiOEgewg58OaYbpNtpUd09GnJM1JM
         Rs8yFqlPawCMX3+oevwnvrh3m5dY2CnzlzicdtEiB9wcr2y/F/mtk1nxE9AgUzDRJK
         2FzgChdy54VLkQGTngzQg7KwD7REVSpGI0cFPoiIoxeLF3dVJRif9Rc8bsL1dqDJh8
         O4NHYdk7xFeGQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id E3E18480E63; Thu, 20 Jul 2023 19:36:44 +0200 (CEST)
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
Subject: [PATCH v2 0/3] RK3588 USB3 host controller support
Date:   Thu, 20 Jul 2023 19:36:40 +0200
Message-Id: <20230720173643.69553-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

 .../bindings/usb/rockchip,dwc3.yaml           | 11 ++++++--
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 21 +++++++++++++++
 drivers/usb/dwc3/core.c                       | 26 +++++++++++++++++++
 drivers/usb/dwc3/core.h                       |  4 +++
 4 files changed, 60 insertions(+), 2 deletions(-)

-- 
2.40.1

