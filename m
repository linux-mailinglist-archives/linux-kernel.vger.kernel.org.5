Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC276992E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjGaOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjGaOOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:14:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5C691
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:14:47 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RF0Xh2Lw8z6J6sJ;
        Mon, 31 Jul 2023 22:11:32 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 15:14:44 +0100
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <bskeggs@redhat.com>
CC:     <kherbst@redhat.com>, <lyude@redhat.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>
Subject: [PATCH] drivers: gpu: drm: nouveau: fix invalid variable name
Date:   Mon, 31 Jul 2023 22:14:37 +0800
Message-ID: <20230731141437.3280099-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml500002.china.huawei.com (7.188.26.138) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes logic error in function 'nvkm_dp_train':
	argument of function nvkm_dp_train_link might be rate, not ret

Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
index 40c8ea43c..8740978ac 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
@@ -455,7 +455,7 @@ nvkm_dp_train(struct nvkm_outp *outp, u32 dataKBps)
 	if (atomic_read(&outp->dp.lt.done)) {
 		for (rate = 0; rate < outp->dp.rates; rate++) {
 			if (outp->dp.rate[rate].rate == ior->dp.bw * 27000)
-				return nvkm_dp_train_link(outp, ret);
+				return nvkm_dp_train_link(outp, rate);
 		}
 		WARN_ON(1);
 		return -EINVAL;
-- 
2.34.1

