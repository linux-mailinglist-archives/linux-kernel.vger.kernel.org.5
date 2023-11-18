Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3517F005D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKRPvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRPvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:51:05 -0500
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85766182;
        Sat, 18 Nov 2023 07:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1700322646;
        bh=+4tkXT2Y0ZJNldwcYbIGmHyE8OJNqApK4fyYv38niwQ=;
        h=From:To:Cc:Subject:Date;
        b=Ph7IJCtdffearbam84VOXcy9Cr4E1x26MWaX/sorrGBpPdDkvUzx2oeVFdE1F+8QW
         VMmHOxdM/M2+irGIqdplAjEuBi14dLYzChlYnLZLRk22EPxI7VPLmuMxMPj6wZmtkP
         qa4WgpgxnX/SFY9ebzLdly2c05YGxi7OLRz8jbpU=
Received: from KernelDevBox.byted.org ([180.184.51.70])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id A7591AC6; Sat, 18 Nov 2023 23:41:53 +0800
X-QQ-mid: xmsmtpt1700322113t5fkws5zs
Message-ID: <tencent_6BA2BE4A64DD6CD5B66D9D8079789829000A@qq.com>
X-QQ-XMAILINFO: NfADz11w1YkvGFaZejPHtoEFsxSTRk8Iq0ST/4MclPPTXeprz1fCG8iAMPVEp1
         KE2E8eDpie5P8qZOM6eWcNst1uuqvVq7Sf/q0RUHWJ/dEt/c7xicWKmNcnPmKxXAjbP8vp8qZqyG
         FPVktayu0ZmNo/oj/41i2AcE+dJRvpch65kHf1xw4TWxpr60hSdp/GidOLQsBqspPOTvIRpf1Vus
         Az8lnCJc+p9m/MvGp32KJ9nWfoPPln7LvBUIbWl3Izm5pZSCqoAd/bgLwSU4Uwev6G4PyVj/BzpG
         0HY+67f4Q/KpBtlNwd/6Q6E4NG7617GydjeqSh9EYDhMVkITjPrkICJWaGdGHOhK2kdFIytw/H14
         7OprbTyPXOkCoXitWTKY91Fpaf8ZFA0JaIQ+ogRuE2IiQW3vSCIbK471H7pfEjzAei6EkTab4JBO
         LltpLgx27Pbc8jnjOyG0F5qDfN5WhZinuFs5IxJWnaUdSsab93vwn6UT7Cv2c3Cx3M3yYrM0pnJL
         9j2c+q0O9+H5h91Xo3CMvKyNnKUpT2bSewVAc3B8MedXtJ1lmPXSkHt9pBZ7MQOL4yEA7FEDErB8
         NhcjnR02GVPka7qmy7JV5bJEicpFQcQcC9GpRn58Doy/O0o4p7OQHOZu+mnFgsTZBrox3GFiUmXk
         nTZ0S4LwjIU3+6r9ooZ/5hnmilYXW0NbnfT07CdoCPPWoDJQpZy9ZJdMaKZwZOMNPrilvrO/81Xg
         5EI30fr8BxBSETW+NfeuRH7snQH/tIvFooS7V4eIk2f/kUFcU+wIIJQ+Qf3sjx4h4jH3FUS7Rn5D
         EZC6xItuOV025OyUAdqqHX/82KT0pk6FYJz7rUUIQGydw7aBws1wBGQ6el+PUCx8H/+pEccNvBHC
         ApURqEatnWSbgopuN+GZ/ez8Ig7tBvlzgO8PEXQ8X4iMuh/VyilH19LD7GyAJPfUjzALOuJhvdql
         mbU4Lpj2CyvNmVI8ku6e7halg4cYLYw1m/0dFpCDmnJNAob6mJjT2ivEpVAP/Gj0RJJZXl578=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     alex.aring@gmail.com
Cc:     stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        harperchen1110@gmail.com, Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] mac802154: Fix uninit-value access in ieee802154_hdr_push_sechdr
Date:   Sat, 18 Nov 2023 23:41:50 +0800
X-OQ-MSGID: <20231118154150.1450251-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syzkaller reported an issue:

BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
BUG: KMSAN: uninit-value in ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
 ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
 ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
 ieee802154_header_create+0x9c0/0xc00 net/mac802154/iface.c:396
 wpan_dev_hard_header include/net/cfg802154.h:494 [inline]
 dgram_sendmsg+0xd1d/0x1500 net/ieee802154/socket.c:677
 ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg net/socket.c:748 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2494
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2548
 __sys_sendmsg+0x225/0x3c0 net/socket.c:2577
 __compat_sys_sendmsg net/compat.c:346 [inline]
 __do_compat_sys_sendmsg net/compat.c:353 [inline]
 __se_compat_sys_sendmsg net/compat.c:350 [inline]

We found hdr->key_id_mode is uninitialized in mac802154_set_header_security()
which indicates hdr.fc.security_enabled should be 0. However, it is set to be cb->secen before.
Later, ieee802154_hdr_push_sechdr is invoked, causing KMSAN complains uninit-value issue.
Since mac802154_set_header_security() sets hdr.fc.security_enabled based on the variables
ieee802154_sub_if_data *sdata and ieee802154_mac_cb *cb in a collaborative manner.
Therefore, we should not set security_enabled prior to mac802154_set_header_security().

Fixed it by removing the line that sets the hdr.fc.security_enabled.

Syzkaller don't provide repro, and I provide a syz repro like:
r0 = syz_init_net_socket$802154_dgram(0x24, 0x2, 0x0)
setsockopt$WPAN_SECURITY(r0, 0x0, 0x1, &(0x7f0000000000)=0x2, 0x4)
setsockopt$WPAN_SECURITY(r0, 0x0, 0x1, &(0x7f0000000080), 0x4)
sendmsg$802154_dgram(r0, &(0x7f0000000100)={&(0x7f0000000040)={0x24, @short}, 0x14, &(0x7f00000000c0)={0x0}}, 0x0)

Fixes: 32edc40ae65c ("ieee802154: change _cb handling slightly")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 net/mac802154/iface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..c99b6e40a5db 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -368,7 +368,6 @@ static int ieee802154_header_create(struct sk_buff *skb,
 
 	memset(&hdr.fc, 0, sizeof(hdr.fc));
 	hdr.fc.type = cb->type;
-	hdr.fc.security_enabled = cb->secen;
 	hdr.fc.ack_request = cb->ackreq;
 	hdr.seq = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
 
-- 
2.30.2

