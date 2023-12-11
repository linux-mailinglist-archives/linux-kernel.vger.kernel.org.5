Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF5580CE5A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343683AbjLKO15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjLKO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:27:45 -0500
X-Greylist: delayed 71 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 06:27:37 PST
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:df01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6210D0;
        Mon, 11 Dec 2023 06:27:36 -0800 (PST)
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bd84:0:640:4b62:0])
        by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 571116154A;
        Mon, 11 Dec 2023 17:26:20 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:b718::1:2a])
        by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id FQiaE60IfSw0-y85DjH1F;
        Mon, 11 Dec 2023 17:26:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
        s=default; t=1702304779;
        bh=okgSQ4jSQ39ig7kfarAvRYBE8MWRoq0a2/YUSKkMo0Q=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=0keANDS6V0C7aVY3xGtXMkiaVMTvJdnVS5F3XyDJyx9XiAkgJ6M8OgSpGHth7NGnY
         NuX+yg8iQbYu4HsIpsvKwre/gFTts5MXRR1vzSU0Rk7E3DdsZU8oFspCy15oQkOo1g
         x7OUziUIHBQoOXJ6fuEr42ns6WbdTn8ctoOTyiDo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From:   Nikolay Kuratov <kniv@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     sgarzare@redhat.com, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH] vsock/virtio: Fix unsigned integer wrap around in virtio_transport_has_space()
Date:   Mon, 11 Dec 2023 17:25:05 +0300
Message-Id: <20231211142505.4076725-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to do signed arithmetic if we expect condition
`if (bytes < 0)` to be possible

Found by Linux Verification Center (linuxtesting.org) with SVACE

Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index c8e162c9d1df..6df246b53260 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -843,7 +843,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
-	bytes = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.34.1

