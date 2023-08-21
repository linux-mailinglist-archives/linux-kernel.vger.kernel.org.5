Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71D47829AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjHUM6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjHUM6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:58:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9DFB1;
        Mon, 21 Aug 2023 05:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CBD76356E;
        Mon, 21 Aug 2023 12:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CF6C433C8;
        Mon, 21 Aug 2023 12:58:33 +0000 (UTC)
Message-ID: <c0c40891-416d-5acd-7a9c-d980c6a24997@xs4all.nl>
Date:   Mon, 21 Aug 2023 14:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 0/5] Add Toshiba Visconti Video Input Interface driver
Content-Language: en-US, nl
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230714015059.18775-1-yuji2.ishikawa@toshiba.co.jp>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230714015059.18775-1-yuji2.ishikawa@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji,

On 14/07/2023 03:50, Yuji Ishikawa wrote:
> This series is the Video Input Interface driver
> for Toshiba's ARM SoC, Visconti[0].
> This provides DT binding documentation,
> device driver, documentation and MAINTAINER files.
> 
> A visconti VIIF driver instance exposes
> 1 media control device file and 3 video device files
> for a VIIF hardware.
> Detailed HW/SW are described in documentation directory.
> The VIIF hardware has CSI2 receiver,
> image signal processor and DMAC inside.
> The subdevice for image signal processor provides
> vendor specific V4L2 controls.
> 
> The device driver depends on two other drivers under development;
> clock framework driver and IOMMU driver.
> Corresponding features will be added later.

Trying to compile this series on top of our latest staging tree fails
due to v4l2-async changes that have been merged. So for v8 please
rebase to the staging tree.

I also got a few kerneldoc warnings:

drivers/media/platform/toshiba/visconti/viif.h:217: warning: Function parameter or member 'ops_lock' not described in 'isp_subdev'
drivers/media/platform/toshiba/visconti/viif.h:233: warning: Function parameter or member 'ops_lock' not described in 'csi2rx_subdev'
drivers/media/platform/toshiba/visconti/viif.h:254: warning: Function parameter or member 'post_enable_flag' not described in 'viif_l2_roi_path_info'

Regards,

	Hans

> 
> Best regards,
> Yuji
> 
> Changelog v2:
> - Resend v1 because a patch exceeds size limit.
> 
> Changelog v3:
> - Add documentation to describe SW and HW
> - Adapted to media control framework
> - Introduced ISP subdevice, capture device
> - Remove private IOCTLs and add vendor specific V4L2 controls
> - Change function name avoiding camelcase and uppercase letters
> 
> Changelog v4:
> - Split patches because a patch exceeds size limit
> - fix dt-bindings document
> - stop specifying ID numbers for driver instance explicitly at device tree
> - use pm_runtime to trigger initialization of HW
>   along with open/close of device files.
> - add a entry for a header file at MAINTAINERS file
> 
> Changelog v5:
> - Fix coding style problem in viif.c (patch 2/6)
> 
> Changelog v6:
> - add register definition of BUS-IF and MPU in dt-bindings
> - add CSI2RX subdevice (separeted from ISP subdevice)
> - change directory layout (moved to media/platform/toshiba/visconti)
> - change source file layout (removed hwd_xxxx.c)
> - pointer to userland memory is removed from uAPI parameters
> - change register access (from struct style to macro style)
> - remove unused macros
> 
> Changelog v7:
> - remove redundant "bindings" from header and description text
> - fix multiline text of "description"
> - change "compatible" to "visconti5-viif"
> - explicitly define allowed properties for port::endpoint
> - remove unused variables
> - update kerneldoc comments
> - update references to headers
> 
> Yuji Ishikawa (5):
>   dt-bindings: media: platform: visconti: Add Toshiba Visconti Video
>     Input Interface
>   media: platform: visconti: Add Toshiba Visconti Video Input Interface
>     driver
>   media: add V4L2 vendor specific control handlers
>   documentation: media: add documentation for Toshiba Visconti Video
>     Input Interface driver
>   MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface
> 
>  .../bindings/media/toshiba,visconti-viif.yaml |  108 +
>  .../driver-api/media/drivers/index.rst        |    1 +
>  .../media/drivers/visconti-viif.rst           |  462 +++
>  MAINTAINERS                                   |    4 +
>  drivers/media/platform/Kconfig                |    1 +
>  drivers/media/platform/Makefile               |    1 +
>  drivers/media/platform/toshiba/Kconfig        |    6 +
>  drivers/media/platform/toshiba/Makefile       |    2 +
>  .../media/platform/toshiba/visconti/Kconfig   |   18 +
>  .../media/platform/toshiba/visconti/Makefile  |    8 +
>  .../media/platform/toshiba/visconti/viif.c    |  681 ++++
>  .../media/platform/toshiba/visconti/viif.h    |  375 ++
>  .../platform/toshiba/visconti/viif_capture.c  | 1485 +++++++
>  .../platform/toshiba/visconti/viif_capture.h  |   22 +
>  .../platform/toshiba/visconti/viif_common.c   |  199 +
>  .../platform/toshiba/visconti/viif_common.h   |   38 +
>  .../platform/toshiba/visconti/viif_controls.c | 3407 +++++++++++++++++
>  .../platform/toshiba/visconti/viif_controls.h |   18 +
>  .../platform/toshiba/visconti/viif_csi2rx.c   |  684 ++++
>  .../platform/toshiba/visconti/viif_csi2rx.h   |   24 +
>  .../toshiba/visconti/viif_csi2rx_regs.h       |  102 +
>  .../platform/toshiba/visconti/viif_isp.c      | 1258 ++++++
>  .../platform/toshiba/visconti/viif_isp.h      |   24 +
>  .../platform/toshiba/visconti/viif_regs.h     |  716 ++++
>  include/uapi/linux/v4l2-controls.h            |    6 +
>  include/uapi/linux/visconti_viif.h            | 1800 +++++++++
>  26 files changed, 11450 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
>  create mode 100644 Documentation/driver-api/media/drivers/visconti-viif.rst
>  create mode 100644 drivers/media/platform/toshiba/Kconfig
>  create mode 100644 drivers/media/platform/toshiba/Makefile
>  create mode 100644 drivers/media/platform/toshiba/visconti/Kconfig
>  create mode 100644 drivers/media/platform/toshiba/visconti/Makefile
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif.c
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_capture.c
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_capture.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_common.c
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_common.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_controls.c
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_controls.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_csi2rx.c
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_csi2rx.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_csi2rx_regs.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_isp.c
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_isp.h
>  create mode 100644 drivers/media/platform/toshiba/visconti/viif_regs.h
>  create mode 100644 include/uapi/linux/visconti_viif.h
> 

