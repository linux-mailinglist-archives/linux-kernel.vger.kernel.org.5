Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF67DE1F9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbjKANf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbjKANfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:35:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86E410C;
        Wed,  1 Nov 2023 06:35:49 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SL7LT2QCqzVlG4;
        Wed,  1 Nov 2023 21:35:45 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 1 Nov
 2023 21:35:46 +0800
From:   Ren Mingshuai <renmingshuai@huawei.com>
To:     <davem@davemloft.net>
CC:     <edumazet@google.com>, <kuba@kernel.org>, <jirislaby@kernel.org>,
        <caowangbao@huawei.com>, <yanan@huawei.com>, <liaichun@huawei.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tty: hso: Fix potential null pointer dereference
Date:   Wed, 1 Nov 2023 21:35:44 +0800
Message-ID: <20231101133544.246961-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500011.china.huawei.com (7.185.36.110)
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

Generally, the old always points to the address of a ktermios structure,
so old is unlikely to be NULL. Still check it before dereference as
elsewhere.

Signed-off-by: Ren Mingshuai <renmingshuai@huawei.com>
---
 drivers/net/usb/hso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index ce1f6081d582..4ad829ab54d3 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -1396,7 +1396,8 @@ static void hso_serial_set_termios(struct tty_struct *tty,
 	if (serial->port.count)
 		_hso_serial_set_termios(tty);
 	else
-		tty->termios = *old;
+		if (old)
+			tty->termios = *old;
 	spin_unlock_irqrestore(&serial->serial_lock, flags);
 
 	/* done */
-- 
2.33.0

