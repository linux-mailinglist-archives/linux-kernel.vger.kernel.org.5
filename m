Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0A976B086
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjHAKLF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 06:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjHAKKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:10:40 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6906692;
        Tue,  1 Aug 2023 03:10:39 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E7FDA24E231;
        Tue,  1 Aug 2023 18:10:32 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 1 Aug
 2023 18:10:32 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 1 Aug
 2023 18:10:32 +0800
From:   Keith Zhao <keith.zhao@starfivetech.com>
To:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
CC:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, Bjorn Andersson <andersson@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Keith Zhao <keith.zhao@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 v1 0/7] DRM driver for verisilicon
Date:   Tue, 1 Aug 2023 18:10:23 +0800
Message-ID: <20230801101030.2040-1-keith.zhao@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a drm driver for Starfive Soc JH7110,
I am sending Drm driver part and HDMI driver part.

We used GEM framework for buffer management , and 
for buffer allocation,we use DMA APIs.

the Starfive HDMI servers as interface between a LCD 
Controller and a HDMI bus. A HDMI TX consists of one 
HDMI transmitter controller and one HDMI transmitter PHY.
(Sound support is not include in this patch)

This patchset should be applied after the patchset:
https://patchwork.kernel.org/project/linux-clk/cover/20230713113902.56519-1-xingyu.wu@starfivetech.com/

V1:
Changes since v1:
- Further standardize the yaml file.
- Dts naming convention improved.
- Fix the problem of compiling and loading ko files.
- Use drm new api to automatically manage resources.
- Drop struct vs_crtc_funcs&vs_plane_funcs，subdivide the plane's help interface
- Reduce the modifiers unused.
- Optimize the hdmi driver code

Keith Zhao (7):
  MAINTAINERS: Update starfive maintainers
  dt-bindings: display: Add yamls for JH7110 display system
  riscv: dts: starfive: jh7110: add dc controller and hdmi  node
  drm/fourcc: Add drm/vs tiled modifiers
  drm/vs: Register DRM device
  drm/vs: Add KMS crtc&plane
  drm/vs: Add hdmi

 .../starfive/starfive,display-subsystem.yaml  |   41 +
 .../starfive/starfive,jh7110-dc8200.yaml      |  107 +
 .../starfive/starfive,jh7110-inno-hdmi.yaml   |   92 +
 MAINTAINERS                                   |    7 +
 .../jh7110-starfive-visionfive-2.dtsi         |   87 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |   43 +
 drivers/gpu/drm/Kconfig                       |    2 +
 drivers/gpu/drm/Makefile                      |    1 +
 drivers/gpu/drm/verisilicon/Kconfig           |   25 +
 drivers/gpu/drm/verisilicon/Makefile          |   13 +
 drivers/gpu/drm/verisilicon/starfive_hdmi.c   |  940 ++++++++
 drivers/gpu/drm/verisilicon/starfive_hdmi.h   |  295 +++
 drivers/gpu/drm/verisilicon/vs_crtc.c         |  365 +++
 drivers/gpu/drm/verisilicon/vs_crtc.h         |   54 +
 drivers/gpu/drm/verisilicon/vs_dc.c           | 1036 +++++++++
 drivers/gpu/drm/verisilicon/vs_dc.h           |   87 +
 drivers/gpu/drm/verisilicon/vs_dc_hw.c        | 2008 +++++++++++++++++
 drivers/gpu/drm/verisilicon/vs_dc_hw.h        |  496 ++++
 drivers/gpu/drm/verisilicon/vs_drv.c          |  274 +++
 drivers/gpu/drm/verisilicon/vs_drv.h          |   54 +
 drivers/gpu/drm/verisilicon/vs_gem.c          |  298 +++
 drivers/gpu/drm/verisilicon/vs_gem.h          |   50 +
 drivers/gpu/drm/verisilicon/vs_modeset.c      |   92 +
 drivers/gpu/drm/verisilicon/vs_modeset.h      |   13 +
 drivers/gpu/drm/verisilicon/vs_plane.c        |  502 +++++
 drivers/gpu/drm/verisilicon/vs_plane.h        |   65 +
 drivers/gpu/drm/verisilicon/vs_type.h         |   70 +
 include/uapi/drm/drm_fourcc.h                 |   27 +
 include/uapi/drm/vs_drm.h                     |   50 +
 29 files changed, 7194 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,display-subsystem.yaml
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
 create mode 100644 drivers/gpu/drm/verisilicon/vs_gem.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_gem.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.h
 create mode 100644 drivers/gpu/drm/verisilicon/vs_type.h
 create mode 100644 include/uapi/drm/vs_drm.h

-- 
2.34.1

