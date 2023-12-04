Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130A48032D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjLDMdg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 07:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjLDMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:33:22 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C4F114;
        Mon,  4 Dec 2023 04:33:23 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 00B9481BB;
        Mon,  4 Dec 2023 20:33:17 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 4 Dec
 2023 20:33:17 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 4 Dec
 2023 20:33:16 +0800
From:   Keith Zhao <keith.zhao@starfivetech.com>
To:     Keith Zhao <keith.zhao@starfivetech.com>,
        <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <william.qiu@starfivetech.com>, <xingyu.wu@starfivetech.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <p.zabel@pengutronix.de>,
        <shengyang.chen@starfivetech.com>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>,
        <maarten.lankhorst@linux.intel.com>, <suijingfeng@loongson.cn>
Subject: [v3 0/6] DRM driver for verisilicon
Date:   Mon, 4 Dec 2023 20:33:09 +0800
Message-ID: <20231204123315.28456-1-keith.zhao@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a drm driver for Starfive Soc JH7110,
I am sending Drm driver part and HDMI driver part.

We used GEM framework for buffer management,
and for buffer allocation,we use DMA APIs.

the Starfive HDMI servers as interface between a LCD Controller 
and a HDMI bus. 
A HDMI TX consists of one HDMI transmitter controller 
and one HDMI transmitter PHY.
(Sound support is not include in this patch)

This patchset should be applied on next branch.

V1:
Changes since v1:
- Further standardize the yaml file.
- Dts naming convention improved.
- Fix the problem of compiling and loading ko files.
- Use drm new api to automatically manage resources.
- Drop vs_crtc_funcs&vs_plane_funcs, subdivide the plane's help interface.
- Reduce the modifiers unused.
- Optimize the hdmi driver code

V2:
Changes since v2:
- fix the error about checking the yaml file.
- match drm driver GEM DMA API.
- Delete the custom crtc property .
- hdmi use drmm_ new api to automatically manage resources.
- update the modifiers comments.
- enabling KASAN, fix the error during removing module 

V3:
Changes since v3:
- Delete the custom plane property.
- Delete the custom fourcc modifiers.
- Adjust the calculation mode of hdmi pixclock.
- Add match data for dc8200 driver.
- Adjust some magic values.
- Add a simple encoder for dsi output.

Keith Zhao (6):
  dt-bindings: display: Add yamls for JH7110 display system
  riscv: dts: starfive: jh7110: display subsystem
  drm/vs: Register DRM device
  drm/vs: Add KMS crtc&plane
  drm/vs: Add hdmi driver
  drm/vs: simple encoder

 .../starfive/starfive,display-subsystem.yaml  |  104 ++
 .../starfive/starfive,dsi-encoder.yaml        |   92 ++
 .../starfive/starfive,jh7110-dc8200.yaml      |  113 ++
 .../starfive/starfive,jh7110-inno-hdmi.yaml   |   82 ++
 .../soc/starfive/starfive,jh7110-syscon.yaml  |    1 +
 MAINTAINERS                                   |    8 +
 .../jh7110-starfive-visionfive-2.dtsi         |  134 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |   49 +
 drivers/gpu/drm/Kconfig                       |    2 +
 drivers/gpu/drm/Makefile                      |    1 +
 drivers/gpu/drm/verisilicon/Kconfig           |   21 +
 drivers/gpu/drm/verisilicon/Makefile          |   12 +
 drivers/gpu/drm/verisilicon/starfive_hdmi.c   |  849 ++++++++++++
 drivers/gpu/drm/verisilicon/starfive_hdmi.h   |  304 +++++
 drivers/gpu/drm/verisilicon/vs_crtc.c         |  208 +++
 drivers/gpu/drm/verisilicon/vs_crtc.h         |   42 +
 drivers/gpu/drm/verisilicon/vs_dc.c           | 1192 +++++++++++++++++
 drivers/gpu/drm/verisilicon/vs_dc.h           |   67 +
 drivers/gpu/drm/verisilicon/vs_dc_hw.c        | 1022 ++++++++++++++
 drivers/gpu/drm/verisilicon/vs_dc_hw.h        |  580 ++++++++
 drivers/gpu/drm/verisilicon/vs_drv.c          |  323 +++++
 drivers/gpu/drm/verisilicon/vs_drv.h          |   46 +
 drivers/gpu/drm/verisilicon/vs_modeset.c      |   39 +
 drivers/gpu/drm/verisilicon/vs_modeset.h      |   10 +
 drivers/gpu/drm/verisilicon/vs_plane.c        |  301 +++++
 drivers/gpu/drm/verisilicon/vs_plane.h        |   39 +
 drivers/gpu/drm/verisilicon/vs_simple_enc.c   |  195 +++
 drivers/gpu/drm/verisilicon/vs_simple_enc.h   |   23 +
 drivers/gpu/drm/verisilicon/vs_type.h         |   69 +
 29 files changed, 5928 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,display-subsystem.yaml
 create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,dsi-encoder.yaml
 create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,jh7110-dc8200.yaml
 create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,jh7110-inno-hdmi.yaml
 create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
 create mode 100644 drivers/gpu/drm/verisilicon/Makefile
 create mode 100644 drivers/gpu/drm/verisilicon/starfive_hdmi.c
 create mode 100644 drivers/gpu/drm/verisilicon/starfive_hdmi.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_simple_enc.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_simple_enc.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_type.h

-- 
2.34.1

