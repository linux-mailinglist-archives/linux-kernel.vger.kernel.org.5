Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AEF7F1966
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjKTRJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjKTRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:09:56 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EE4CF;
        Mon, 20 Nov 2023 09:09:51 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AKCtC3m028529;
        Mon, 20 Nov 2023 18:09:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=NhxGKxA
        rFnG+1VnD4g8lO/0sVZPdg8w3eovmR4BAePU=; b=rU80Hcc5PhsQ/BFWcsRTBCG
        YlSrcldyUFz7+0/dPgtk9nNQDS6jJYADjYlPae3Aj90Sm0jILXuN85IMEohYHnpj
        ujcttRRm5eaqRwqPirK3GzmKiq50IuYS+l6ajaky0W7UHarnB87jlokBdDPr5/B/
        chsVQ+gf7GfyFF9ROBXhbi9vLh7PFkCEhC/677mNyez6NjNIgfc8UMsc3NT80tx8
        7pk5JlAPkAw+CsdcpKvPPVYe5d4s1NnwPOHnBD7Be063bTJRglmdvO8FsmMIpcFF
        0P0yxE72n/yaBSV1cRdm2w69xVFpVDBbfXIqWemUPy7xSF2C/8lDThQXQKGmmyw=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uekjkg1mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 18:09:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A876210002A;
        Mon, 20 Nov 2023 18:09:07 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D0CE236958;
        Mon, 20 Nov 2023 18:09:07 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 20 Nov
 2023 18:09:07 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/5] Add support for DCMIPP camera interface of STMicroelectronics STM32 SoC series
Date:   Mon, 20 Nov 2023 18:07:56 +0100
Message-ID: <20231120170809.728941-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_17,2023-11-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces support for Digital Camera Memory Interface
Pixel Processor (DCMIPP) of STMicroelectronics STM32 SoC series.

This initial support implements a single capture pipe
allowing RGB565, YUV, Y, RAW8 and JPEG capture with
frame skipping, prescaling and cropping.

DCMIPP is exposed through 3 subdevices:
- dcmipp_dump_parallel: parallel interface handling
- dcmipp_dump_postproc: frame skipping, prescaling and cropping control
- dcmipp_dump_capture: video device capture node

v7:
  - correct byteproc set_fmt handling and compose/crop/fmt handling
  - replace few v4l2_subdev_get_try_* into v4l2_subdev_get_pad_*
  - correct ordering within dcmipp_remove

v6:
  - correct copyright year in all files
  - correct Kconfig (removal of OF addition of select
    VIDEO_V4L2_SUBDEV_API/MEDIA_CONTROLLER
  - add missing mutex_destroy in error handling
  - rely on fwnode_graph_get_endpoint_by_id instead of fwnode_graph_get_next_endpoint
  - rely on device_get_match_data instead of of_device_get_match_data
  - use local variable for pads_flag initialization

v5:
  - removal of dcmipp_frame_size & dcmipp_frame_stride and use
    v4l2_fill_pixfmt
  - correct typos & avoid check of available buffer at start_streaming
    time since this is done by vb2 framework
  - avoid set of pad format in dcmipp_par_ent_init and
    dcmipp_byteproc_ent_init since done via init_cfg
  - reorder bound functions
  - use v4l2_subdev_get_fmt in parallel and byteproc subdevs
  - correct struct dcmipp_ent_device comments
  - removal of dcmipp_hdw_pixel_alignment in bytecap subdev since not
    applicable in this byte mode pipeline

v4:
  - rework of mutex / spinlock handling
  - addition of dma mask setting
  - removal of __maybe_unused, use pm_ptr and new declaration macros
  - driver now only generate a single stm32-dcmipp.ko module instead of
    several as before
  - removal of the component framework usage
  - various small fixes (function names, lowercase values, indentation,
    print formats)
  - register name removal in register access function, only dev_dbg with
    address & values are kept
  - removal of VB2_READ and CAP_READWRITE
  - usage of subdev active state mechanism and removal of locally stored
    format/compose/crop
  - addition of port { } within the stm32mp135.dtsi

v3:
  - Have same To & Cc in all patches emails of the serie so that everybody
    has coherent view of the serie
  - bindings: correct wording, clock-names & label removal
  - driver: replace of_graph call with fwnode_graph
  - driver: use defined bus-type when calling v4l2_fwnode_endpoint_parse
  - driver: remove clock name
  - dtsi: remove clock-names property

v2:
  - removal of pclk-max-frequency from yaml example dts
  - codying-style fixes
  - correction in enum functions (format, mbus, frame_size ...) handling
  - drop of v4l2_pipeline_pm_ calls, and specific open/close handler of
    vdev
  - video dev s_stream handling updated to call s_stream of remote subdev
    instead of loop until sensor subdev
  - code update following media_pipeline & v4l2_async_ api changes since v1
  - removal of IP reset call upon error
  - removal of link_validate handlers
  - addition of V4L2_CAP_IO_MC device_caps
  - removal of the frame skip control for the time being, will be added
    back in another commit once control method will be agreed
  - change byteproc entity type to MEDIA_ENT_F_PROC_VIDEO_SCALER
  - various fixes from Dan & Sakari remarks

Alain Volmat (2):
  dt-bindings: media: add bindings for stm32 dcmipp
  media: MAINTAINERS: add entry for STM32 DCMIPP driver

Hugues Fruchet (3):
  media: stm32-dcmipp: STM32 DCMIPP camera interface driver
  ARM: dts: stm32: add dcmipp support to stm32mp135
  ARM: multi_v7_defconfig: enable STM32 DCMIPP media support

 .../bindings/media/st,stm32-dcmipp.yaml       |  89 ++
 MAINTAINERS                                   |   5 +-
 arch/arm/boot/dts/st/stm32mp135.dtsi          |  11 +
 arch/arm/configs/multi_v7_defconfig           |   1 +
 drivers/media/platform/st/stm32/Kconfig       |  16 +
 drivers/media/platform/st/stm32/Makefile      |   1 +
 .../platform/st/stm32/stm32-dcmipp/Makefile   |   4 +
 .../st/stm32/stm32-dcmipp/dcmipp-bytecap.c    | 914 ++++++++++++++++++
 .../st/stm32/stm32-dcmipp/dcmipp-byteproc.c   | 565 +++++++++++
 .../st/stm32/stm32-dcmipp/dcmipp-common.c     | 106 ++
 .../st/stm32/stm32-dcmipp/dcmipp-common.h     | 216 +++++
 .../st/stm32/stm32-dcmipp/dcmipp-core.c       | 604 ++++++++++++
 .../st/stm32/stm32-dcmipp/dcmipp-parallel.c   | 440 +++++++++
 13 files changed, 2971 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/Makefile
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-byteproc.c
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.c
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.h
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-parallel.c

-- 
2.25.1

