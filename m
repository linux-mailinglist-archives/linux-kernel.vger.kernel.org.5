Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A620478E059
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbjH3TUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245642AbjH3Ppy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:45:54 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D2EC185
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:45:48 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Dxg_AqZO9kkiEdAA--.59880S3;
        Wed, 30 Aug 2023 23:45:47 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxviMqZO9kjVRnAA--.12491S2;
        Wed, 30 Aug 2023 23:45:46 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/gma500: Fix the failure to map the stolen memory
Date:   Wed, 30 Aug 2023 23:45:43 +0800
Message-Id: <20230830154546.499987-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxviMqZO9kjVRnAA--.12491S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kry3XF1DCr1rtFW7tryfXwc_yoW8Kr4rpF
        Zaqa1agr4kJFWIyr4UWr1UW3Wak3Z7Ca48Xr13Cryxu3WakFWvqr1Dtay3XFW5Xr1DJr4I
        q39rt34S9w48CagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
        WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
        AVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
        vjDU0xZFpf9x07jz2NtUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When another discrete video card(SM750 or AST1400) is mounted into the mini
PCIe slot of my ASRock AD2550B-ITX board, the gma500 drivers fails to work.
It probably because the UEFI firmware of that board forget to initialize
the PSB_PGETBL_CTL reg, therefore the value of dev_priv->pge_ctl is 0, then
the value of gtt_phys_start is also 0.

On normal case, the value of the dev_priv->stolen_base is 0xbf800000 for
this board, so the value of the vram_stolen_size will be negative in this
case, the calculation of the stolen vram size of drm/gma500 is pasted at
below:

vram_stolen_size = pg->gtt_phys_start - dev_priv->stolen_base - PAGE_SIZE;
                 = 0 - 0xbf800000 - 4096 = 1056764 KiB

Which is so large, so this cause the ioremap_wc() fail, see below dmesg for
more information.

 gma500 0000:00:02.0: enabling device (0000 -> 0003)
 gma500 0000:00:02.0: GPU: power management timed out.
 gma500 0000:00:02.0: [drm] Phys start of GTT: 0x0
 gma500 0000:00:02.0: [drm] Stolen memory base 0xbf800000, size 1056764KiB
 x86/PAT: systemd-udevd:386 conflicting memory types bf800000-fffff000 write-combining<->uncached-minus
 x86/PAT: memtype_reserve failed [mem 0xbf800000-0xffffefff], track write-combining, req write-combining
 ioremap memtype_reserve failed -16
 gma500 0000:00:02.0: Failure to map stolen base.
 gma500: probe of 0000:00:02.0 failed with error -12

Regardless, we want this driver works even there have another video card
mounted. This patch solve this problem by given 8M stolen memory if the
value of pg->gtt_phys_start is zero. And after apply this patch, it works
fine.

$ dmesg | grep drm

 gma500 0000:00:02.0: [drm] Phys start of GTT: 0x0
 gma500 0000:00:02.0: [drm] Stolen memory base 0xbf800000, size 8192KiB
 [drm] Initialized gma500 1.0.0 20140314 for 0000:00:02.0 on minor 0
 gma500 0000:00:02.0: [drm] fb1: gma500drmfb frame buffer device

Sui Jingfeng (3):
  drm/gma500: Print the stolen memory base and size with drm_info()
  drm/gma500: Print the start address of the GTT
  drm/gma500: Fix the failure to map the stolen memory

 drivers/gpu/drm/gma500/gem.c | 10 +++++++---
 drivers/gpu/drm/gma500/gtt.c |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)


base-commit: bb585492db95d4cc7fe3797523ed2bbf5c621d37
-- 
2.34.1

