Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC29A7E2794
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjKFOtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjKFOtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:49:06 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C304F4;
        Mon,  6 Nov 2023 06:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=h6TLW
        B9cdUKq7s1SXHoFgVVhZtXcumU4Vs0W88ItZxg=; b=ZPA7OufnOu36o5kXXHolF
        yHmqXp6ZOcgHEsclhhnuF4IXQ9/p5EpzgU603j7f+uYDb89cUabY7AFYi+rS5UWC
        asp5dZ/d38Q5NhDcz0+OO/J1GO/sdZysYrs3YaD4UCJzWFtHQpM/Gb/r6JX+UZ2A
        3SPNGLoWv8CwvY4yJwV9SM=
Received: from leanderwang-LC4.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wAXH5Gu_Ehl9FmbBw--.1952S2;
        Mon, 06 Nov 2023 22:48:14 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     dmitry.osipenko@collabora.com
Cc:     Kyrie.Wu@mediatek.com, bin.liu@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, hackerzheng666@gmail.com,
        amergnat@baylibre.com, wenst@chromium.org, stable@vger.kernel.org,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [RESEND PATCH v2 0/3] Fix use-after-free bug in mtk_jpeg_dec_device_run and fix schedule error in mtk_jpegdec_worker
Date:   Mon,  6 Nov 2023 22:48:08 +0800
Message-Id: <20231106144811.868127-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXH5Gu_Ehl9FmbBw--.1952S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw45ury8KFyktr4DCry7GFg_yoWktrX_WF
        9Y9w1kuw18G3s8JF4ayFy5ZrW8KF9FgF45GFZ8KFs5JFy5XFZIqF1vy393uan3Wa1avF43
        Gr4FqF45Xw1j9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_rWrJUUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBmwggU1etjJUS8wAAsi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This v2 series fixes the use-after-free bug in mtk_jpeg_dec_device_run.
This patch fixes the security bug in chrome-os.
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

