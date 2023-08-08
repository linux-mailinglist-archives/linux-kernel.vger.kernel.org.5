Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2297743C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjHHSJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjHHSJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:09:10 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76CE64814
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:10:48 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKv7p0JCzz1hwHG;
        Tue,  8 Aug 2023 21:25:26 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 21:28:14 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <broonie@kernel.org>, <daniel@zonque.org>,
        <haojian.zhuang@gmail.com>
CC:     <liaoyu15@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <liwei391@huawei.com>,
        <tiwai@suse.com>
Subject: [PATCH v2 -next] ASoC: pxa: address unused variable warning
Date:   Tue, 8 Aug 2023 21:25:19 +0800
Message-ID: <20230808132519.637452-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
sound/soc/pxa/pxa-ssp.c:594:15: warning: variable 'acds' set but not used [-Wunused-but-set-variable]
                                            ^
This variable is not used so remove it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308040619.BEismjFv-lkp@intel.com/
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 sound/soc/pxa/pxa-ssp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 430dd446321e..d19769dde139 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -591,7 +591,7 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 
 		if (ret < 0) {
 			const struct pxa_ssp_clock_mode *m;
-			int ssacd, acds;
+			int ssacd;
 
 			for (m = pxa_ssp_clock_modes; m->rate; m++) {
 				if (m->rate == rate)
@@ -601,12 +601,6 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 			if (!m->rate)
 				return -EINVAL;
 
-			acds = m->acds;
-
-			/* The values in the table are for 16 bits */
-			if (width == 32)
-				acds--;
-
 			ret = pxa_ssp_set_pll(priv, bclk);
 			if (ret < 0)
 				return ret;
-- 
2.25.1

