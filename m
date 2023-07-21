Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F0275C3E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjGUKAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjGUKAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:00:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470713A9C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:00:16 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6lQP6nvYzrRsG;
        Fri, 21 Jul 2023 17:59:25 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 18:00:12 +0800
From:   Wang Weiyang <wangweiyang2@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next] ALSA: seq: remove redundant unsigned comparison to zero
Date:   Fri, 21 Jul 2023 18:31:24 +0800
Message-ID: <20230721103124.18522-1-wangweiyang2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since struct snd_ump_block_info::first_group is unsigned char, comparison
to zero is redundant

Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
---
 sound/core/seq/seq_ump_client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index fe21c801af74..f26a1812dfa7 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -298,8 +298,7 @@ static void update_group_attrs(struct seq_ump_client *client)
 	}
 
 	list_for_each_entry(fb, &client->ump->block_list, list) {
-		if (fb->info.first_group < 0 ||
-		    fb->info.first_group + fb->info.num_groups > SNDRV_UMP_MAX_GROUPS)
+		if (fb->info.first_group + fb->info.num_groups > SNDRV_UMP_MAX_GROUPS)
 			break;
 		group = &client->groups[fb->info.first_group];
 		for (i = 0; i < fb->info.num_groups; i++, group++) {
-- 
2.25.1

