Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2AD7DEA89
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348229AbjKBCJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBCJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:09:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C81E4;
        Wed,  1 Nov 2023 19:09:14 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SLRz60VLBzPnZs;
        Thu,  2 Nov 2023 10:05:06 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 2 Nov
 2023 10:09:11 +0800
From:   Ren Mingshuai <renmingshuai@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <caowangbao@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <jirislaby@kernel.org>, <kuba@kernel.org>,
        <liaichun@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <renmingshuai@huawei.com>,
        <yanan@huawei.com>
Subject: Re: [PATCH] tty: hso: Fix potential null pointer dereference.
Date:   Thu, 2 Nov 2023 10:09:08 +0800
Message-ID: <20231102020908.692325-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <2023110139-spearmint-throttle-ed90@gregkh>
References: <2023110139-spearmint-throttle-ed90@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Generally, the old always points to the address of a ktermios structure,
>> so old is unlikely to be NULL. Still check it before dereference as
>> elsewhere.
>
>If it can not happen, there is no need to check it.  So unless you can
>prove that this ever could happen, this change isn't needed, right?
>
>thanks,
>
>greg k-h
Thanks for reply. I agree with you. The reason for checking old there
is that it is checked at the beginning in hso_serial_set_termios(). It is
better to check it both or not, right?
Delete it to avoid smatch complaints.
drivers/net/usb/hso.c:1399 hso_serial_set_termios() error: we previously assumed 'old' could be null (see line 1389).

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 4ad829ab54d3..383ff8b04473 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -1386,10 +1386,9 @@ static void hso_serial_set_termios(struct tty_struct *tty,
        struct hso_serial *serial = tty->driver_data;
        unsigned long flags;

-       if (old)
-               hso_dbg(0x16, "Termios called with: cflags new[%u] - old[%u]\n",
-                       (unsigned int)tty->termios.c_cflag,
-                       (unsigned int)old->c_cflag);
+       hso_dbg(0x16, "Termios called with: cflags new[%u] - old[%u]\n",
+               (unsigned int)tty->termios.c_cflag,
+               (unsigned int)old->c_cflag);

        /* the actual setup */
        spin_lock_irqsave(&serial->serial_lock, flags);
