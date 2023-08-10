Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901B5777442
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjHJJS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbjHJJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2803A30DB;
        Thu, 10 Aug 2023 02:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A1B654F7;
        Thu, 10 Aug 2023 09:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0130FC433CB;
        Thu, 10 Aug 2023 09:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691659001;
        bh=EAzZvqV0DX/6MdQG6V3byUfhXhjqmaV2PFwGoLqDg8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gkoej6iSFauNlE7dWSTp1xK+Zil0fHVbrGDyfXRIZcijG+8mFqs2KZCGDVZk1BNIg
         2BrkFE3DAyzqQBjSzwWnPHgT7lHoDPYh93Zvnvb2knmm72I3zNXWyiCbTQz7nRxzyc
         c1gn51OWjpJvxPhVY+qxUSfMoPktrsWQPxaJeYlQPVdxqw2ByFU7E2Zu2QFOOMsCqm
         iEJu0oUE+1M0zV7e5YclMNchhoe72pqshhn9Xg0meohMdAK6zy0R8a/OXG7OskOXcy
         eYLZGtok45f5+lS0LYVZXOCfiiDUzdgwarHg7S+zdd6Dqp+1PbS0iK6E3PkM99+et0
         G0Qm8ToQVqDGA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 36/36] tty: rfcomm: convert counts to size_t
Date:   Thu, 10 Aug 2023 11:15:10 +0200
Message-ID: <20230810091510.13006-37-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify the type of tty_operations::write() counters with the 'count'
parameter. I.e. use size_t for them.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
---
 net/bluetooth/rfcomm/tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 33b135ed59c4..94ec913dfb76 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -785,12 +785,12 @@ static ssize_t rfcomm_tty_write(struct tty_struct *tty, const u8 *buf,
 	struct rfcomm_dev *dev = tty->driver_data;
 	struct rfcomm_dlc *dlc = dev->dlc;
 	struct sk_buff *skb;
-	int sent = 0, size;
+	size_t sent = 0, size;
 
 	BT_DBG("tty %p count %zu", tty, count);
 
 	while (count) {
-		size = min_t(uint, count, dlc->mtu);
+		size = min_t(size_t, count, dlc->mtu);
 
 		skb = rfcomm_wmalloc(dev, size + RFCOMM_SKB_RESERVE, GFP_ATOMIC);
 		if (!skb)
-- 
2.41.0

