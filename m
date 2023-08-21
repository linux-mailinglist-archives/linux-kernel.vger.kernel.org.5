Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3427178212F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjHUB1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjHUB1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:27:43 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768779D;
        Sun, 20 Aug 2023 18:27:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RTZbW2s3Wz4f3p1H;
        Mon, 21 Aug 2023 09:27:35 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
        by APP4 (Coremail) with SMTP id gCh0CgCHXJ+AveJkpS7TBA--.56653S2;
        Mon, 21 Aug 2023 09:27:36 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Chris Snook <chris.snook@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        gongruiqi1@huawei.com
Subject: [PATCH RESEND net-next] alx: fix OOB-read compiler warning
Date:   Mon, 21 Aug 2023 09:32:18 +0800
Message-Id: <20230821013218.1614265-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHXJ+AveJkpS7TBA--.56653S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1kJr1DGr45KrW3GrWrGrg_yoW8Aw4xpF
        WDGayDCa48urnrZa1UXay8Zry5ZanIq3yjkFyxA3yrZF1UtrZ8CF17Kryjkr1UJ3y09r1F
        qr1DAF9rJFZ8ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

The following message shows up when compiling with W=1:

In function ‘fortify_memcpy_chk’,
    inlined from ‘alx_get_ethtool_stats’ at drivers/net/ethernet/atheros/alx/ethtool.c:297:2:
./include/linux/fortify-string.h:592:4: error: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Werror=attribute-warning]
  592 |    __read_overflow2_field(q_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to get alx stats altogether, alx_get_ethtool_stats() reads
beyond hw->stats.rx_ok. Fix this warning by directly copying hw->stats,
and refactor the unnecessarily complicated BUILD_BUG_ON btw.

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---

RESEND: forget to cc netdev mail list

 drivers/net/ethernet/atheros/alx/ethtool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/alx/ethtool.c b/drivers/net/ethernet/atheros/alx/ethtool.c
index b716adacd815..7f6b69a52367 100644
--- a/drivers/net/ethernet/atheros/alx/ethtool.c
+++ b/drivers/net/ethernet/atheros/alx/ethtool.c
@@ -292,9 +292,8 @@ static void alx_get_ethtool_stats(struct net_device *netdev,
 	spin_lock(&alx->stats_lock);
 
 	alx_update_hw_stats(hw);
-	BUILD_BUG_ON(sizeof(hw->stats) - offsetof(struct alx_hw_stats, rx_ok) <
-		     ALX_NUM_STATS * sizeof(u64));
-	memcpy(data, &hw->stats.rx_ok, ALX_NUM_STATS * sizeof(u64));
+	BUILD_BUG_ON(sizeof(hw->stats) != ALX_NUM_STATS * sizeof(u64));
+	memcpy(data, &hw->stats, sizeof(hw->stats));
 
 	spin_unlock(&alx->stats_lock);
 }
-- 
2.25.1

