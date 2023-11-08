Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13B37E5909
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjKHOcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjKHOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:32:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5411FEA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699453901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=azIbl1Q1WqNmKg9b8mJ71uv7iO05rT+1/ZNIY0Tg9BA=;
        b=fY5/054OnbUqtOW/PHZ9Rwg/+xKJ7MjM1czlWvZ12lo9WsKBEa0+L4F+X1PV2iaKJ6ECx0
        /1BQoDhO3rmcAVXXZ+d0mPd/DcrqOrbVv4XUv3xMNnLl4j5c1RL/UOj3UpOf/wTM/LGtiG
        vKw9KO9zoGgoYZ7KflWUuVYLOqRLiBE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-43wWSZ7-MKC7ArlKG_N6Sg-1; Wed, 08 Nov 2023 09:31:39 -0500
X-MC-Unique: 43wWSZ7-MKC7ArlKG_N6Sg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b8d4a559ddso5184510a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699453879; x=1700058679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azIbl1Q1WqNmKg9b8mJ71uv7iO05rT+1/ZNIY0Tg9BA=;
        b=K4/KHvL3dXtwk5AYEjiqzEtX7XaWarQzFwXK67w+kBgB3wT36QV1FVKyJNdK1i8toQ
         c3O3dhPSQnP/MZlMT5yvQRsqDgEmC8FTrOqIUIb7D3Dt/ZQgoQB4cqL7L8D1OQKeXrdI
         S8uQh6cKs27GXnZtfZlFcHjPD9j2h/GA2+sHN2gkaw96JrJKW8gmabn5QBZo4jgOx+jU
         3sKc76qN98lbnDKbdQQR8EMEpn5LLvjIozvGj0I6C+1T9G6n7kKI9wt2lRAfG4PIidKh
         ydHxA+GVvgREWa4mhl6ms1QwYtrTtIn6P1+o9k8rZ/4ziD9PpcwHd66ggQAs7Tlx/Kjj
         fUbg==
X-Gm-Message-State: AOJu0YzeYa3rVdbOh9N0GM6UY5kXqxUNBziDbqC9JgJyf3Yeie01xB6i
        mLrAnRbT/QkBpdIhSx8tKVRjjIjVMugTICWS3RHu+lmjj3Rd/W5TwrPJozUUhM8fjyifALYr7HQ
        mBo+ggtFheNb7mWZzJwpTlJWQ
X-Received: by 2002:a05:6a21:9995:b0:13a:6bca:7a84 with SMTP id ve21-20020a056a21999500b0013a6bca7a84mr2262098pzb.44.1699453878769;
        Wed, 08 Nov 2023 06:31:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqrJPnHz/nJrv9l7swE+wMaUgWvY5AKVfvvgJjJ7U5bwsv2B1/wyIpa1xSW/12Gps+eRiLLg==
X-Received: by 2002:a05:6a21:9995:b0:13a:6bca:7a84 with SMTP id ve21-20020a056a21999500b0013a6bca7a84mr2262080pzb.44.1699453878412;
        Wed, 08 Nov 2023 06:31:18 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903120e00b001c9d6923e7dsm1805369plh.222.2023.11.08.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:31:18 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] RDMA/core: Fix uninit-value access in ib_get_eth_speed()
Date:   Wed,  8 Nov 2023 23:31:13 +0900
Message-ID: <20231108143113.1360567-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN reported the following uninit-value access issue:

lo speed is unknown, defaulting to 1000
=====================================================
BUG: KMSAN: uninit-value in ib_get_width_and_speed drivers/infiniband/core/verbs.c:1889 [inline]
BUG: KMSAN: uninit-value in ib_get_eth_speed+0x546/0xaf0 drivers/infiniband/core/verbs.c:1998
 ib_get_width_and_speed drivers/infiniband/core/verbs.c:1889 [inline]
 ib_get_eth_speed+0x546/0xaf0 drivers/infiniband/core/verbs.c:1998
 siw_query_port drivers/infiniband/sw/siw/siw_verbs.c:173 [inline]
 siw_get_port_immutable+0x6f/0x120 drivers/infiniband/sw/siw/siw_verbs.c:203
 setup_port_data drivers/infiniband/core/device.c:848 [inline]
 setup_device drivers/infiniband/core/device.c:1244 [inline]
 ib_register_device+0x1589/0x1df0 drivers/infiniband/core/device.c:1383
 siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
 siw_newlink+0x129e/0x13d0 drivers/infiniband/sw/siw/siw_main.c:490
 nldev_newlink+0x8fd/0xa60 drivers/infiniband/core/nldev.c:1763
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0xe8a/0x1120 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0xf4b/0x1230 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x1242/0x1420 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x997/0xd60 net/socket.c:2588
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2642
 __sys_sendmsg net/socket.c:2671 [inline]
 __do_sys_sendmsg net/socket.c:2680 [inline]
 __se_sys_sendmsg net/socket.c:2678 [inline]
 __x64_sys_sendmsg+0x2fa/0x4a0 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable lksettings created at:
 ib_get_eth_speed+0x4b/0xaf0 drivers/infiniband/core/verbs.c:1974
 siw_query_port drivers/infiniband/sw/siw/siw_verbs.c:173 [inline]
 siw_get_port_immutable+0x6f/0x120 drivers/infiniband/sw/siw/siw_verbs.c:203

CPU: 0 PID: 11257 Comm: syz-executor.1 Not tainted 6.6.0-14500-g1c41041124bd #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
=====================================================

If __ethtool_get_link_ksettings() fails, `netdev_speed` is set to the
default value, SPEED_1000. In this case, if `lanes` field of struct
ethtool_link_ksettings is not initialized, an uninitialized value is passed
to ib_get_width_and_speed(). This causes the above issue. This patch
resolves the issue by initializing `lanes` to 0.

Fixes: cb06b6b3f6cb ("RDMA/core: Get IB width and speed from netdev")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/infiniband/core/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 8a6da87f464b..4fb585c23a2e 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1971,7 +1971,7 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 	int rc;
 	u32 netdev_speed;
 	struct net_device *netdev;
-	struct ethtool_link_ksettings lksettings;
+	struct ethtool_link_ksettings lksettings = { .lanes = 0 };
 
 	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
 		return -EINVAL;
-- 
2.41.0

