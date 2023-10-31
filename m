Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D267DC711
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343591AbjJaHRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjJaHRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:17:43 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B6D1C0;
        Tue, 31 Oct 2023 00:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6VOEl
        ouc2GMG6bSXp2UcAdff2CtTi6AX9Q0p7itVxKA=; b=hNxmtqR1fN7BA3q1g2ICx
        VRxNm0SfZHNYL8L8HAhhbgtHVZzrPE1itUvu7NgCwp0KV49XJXkpVznmWmoByFuM
        ZYiUfcvatLYHhxg7N8z/1ySEFYA3dV9lQPRlnpf4eOujyUP0z17QjALMBAKvGuE9
        +Wfd3c+X9AnW5EUCrnsBaU=
Received: from leanderwang-LC4.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wBn3ojfqUBlwMj4AQ--.51864S2;
        Tue, 31 Oct 2023 15:16:48 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     dmitry.osipenko@collabora.com
Cc:     Kyrie.Wu@mediatek.com, bin.liu@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        amergnat@baylibre.com, wenst@chromium.org,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v2 0/3] Fix use-after-free bug in mtk_jpeg_dec_device_run
Date:   Tue, 31 Oct 2023 15:16:41 +0800
Message-Id: <20231031071644.20086-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBn3ojfqUBlwMj4AQ--.51864S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4xJry8Zw1DWryDtw4DCFg_yoWkArX_WF
        9Y9wn7uw18G3srJF4ayFy5ZrW8GFy7KF45GFZ8KFs5JFy5XFZIqF1vyrZ3uan3Wa12vF43
        Gr4FqF4UXw1j9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_1v3UUUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBdgAaU2DkptftmgAAs9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This v2 series fixes the use-after-free bug in mtk_jpeg_dec_device_run.
It inclues reverting the incomplete fix before and make the right fix.
Also,it fixes the error of timeout-worker-schedule in multiple-core
devices.

1. Remove cancel worker in mtk_jpeg_remove for the worker is only
registered in single-core device but we try to cacnel it in both
single-core and multiple-core devices.

2. Fix use-after-free bug by delay the schedule_delayed_work only if
mtk_jpeg_set_dec_dst runs successfully.

3. Delay the schedule_delayed_work in mtk_jpegdec_worker as it has same
code logic in mtk_jpeg_dec_device_run.

version 2 changes

-put the patches into on series suggested by Dmitry

Zheng Wang (3):
  media: mtk-jpeg: Remove cancel worker in mtk_jpeg_remove to avoid the
    crash of multi-core JPEG devices
  media: mtk-jpeg: Fix use after free bug due to error path handling
    in mtk_jpeg_dec_device_run
  media: mtk-jpeg: Fix timeout schedule error in mtk_jpegdec_worker.

 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c    | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.25.1

