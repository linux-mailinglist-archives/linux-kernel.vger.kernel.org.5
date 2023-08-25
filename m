Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6605E7884AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbjHYKUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244206AbjHYKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:19:38 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57F2270C;
        Fri, 25 Aug 2023 03:19:00 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2A66340737DA;
        Fri, 25 Aug 2023 10:18:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2A66340737DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1692958726;
        bh=uryXDS4nqyFR9SOXfKBV4jwGs2+MiiKOcdfzM+yQBHU=;
        h=Date:From:To:Subject:From;
        b=fXucNdLeXndyUqCDYugj424bpQr3cuRMDdbS8ufn/BaTq8IiBXHuwj3UE+ZMDfWhX
         NWRToZ0JCpB2+AXgORxsFUu9cIhEt2+9n0n25UvguWQ/xGsmCAuPv3QVdC9ZTubY/u
         7EJWYVAtF/mEC6RGK2fNNhGrD2he4mnfr+6YM0zk=
MIME-Version: 1.0
Date:   Fri, 25 Aug 2023 13:18:46 +0300
From:   e.orlova@ispras.ru
To:     p.zabel@pengutronix.de, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, lvc-project@linuxtesting.org
Subject: [QUESTION] drm/crtc: precondition for drm_crtc_init_with_planes()
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a830685d8b10a00cfe0a86db1ee9fb13@ispras.ru>
X-Sender: e.orlova@ispras.ru
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for drm_crtc_init_with_planes() in
drivers/gpu/drm/drm_crtc.c states: «The crtc structure should not be
allocated with devm_kzalloc()».

However, in drivers/gpu/drm/stm/ltdc.c
the 2nd argument of the function drm_crtc_init_with_planes()
is a structure allocated with devm_kzalloc()

Also, in
drivers/gpu/drm/mediatek/mtk_drm_crtc.c
drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
drivers/gpu/drm/logicvc/logicvc_crtc.c
drivers/gpu/drm/meson/meson_crtc.c
drivers/gpu/drm/mxsfb/lcdif_kms.c
drivers/gpu/drm/mxsfb/mxsfb_kms.c
drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
drivers/gpu/drm/rockchip/rockchip_drm_vop.c
drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
drivers/gpu/drm/sun4i/sun4i_crtc.c
drivers/gpu/drm/tegra/dc.c
drivers/gpu/drm/tilcdc/tilcdc_crtc.c
the 2nd argument of the function drm_crtc_init_with_planes()
is a field of the structure allocated with devm_kzalloc()

Is it correct or can it lead to any problems?

--
Ekaterina Orlova
Linux Verification Center, ISPRAS
