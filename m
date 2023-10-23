Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880487D3853
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjJWNoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJWNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:44:22 -0400
X-Greylist: delayed 2264 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 06:44:19 PDT
Received: from janet.servers.dxld.at (mail.servers.dxld.at [IPv6:2001:678:4d8:200::1a57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0321891
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:44:18 -0700 (PDT)
Received: janet.servers.dxld.at; Mon, 23 Oct 2023 15:06:26 +0200
From:   =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
Subject: [PATCH] wireguard: Fix leaking sockets in wg_socket_init error paths
Date:   Mon, 23 Oct 2023 15:06:09 +0200
Message-Id: <20231023130609.595122-1-dxld@darkboxed.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't seem to be reachable normally, but while working on a patch
for the address binding code I ended up triggering this leak and had to
reboot to get rid of the leaking wg sockets.
---
 drivers/net/wireguard/socket.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 0414d7a6ce74..c35163f503e7 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -387,7 +387,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 	ret = udp_sock_create(net, &port4, &new4);
 	if (ret < 0) {
 		pr_err("%s: Could not create IPv4 socket\n", wg->dev->name);
-		goto out;
+		goto err;
 	}
 	set_sock_opts(new4);
 	setup_udp_tunnel_sock(net, new4, &cfg);
@@ -402,7 +402,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 				goto retry;
 			pr_err("%s: Could not create IPv6 socket\n",
 			       wg->dev->name);
-			goto out;
+			goto err;
 		}
 		set_sock_opts(new6);
 		setup_udp_tunnel_sock(net, new6, &cfg);
@@ -414,6 +414,11 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 out:
 	put_net(net);
 	return ret;
+
+err:
+	sock_free(new4 ? new4->sk : NULL);
+	sock_free(new6 ? new6->sk : NULL);
+	goto out;
 }
 
 void wg_socket_reinit(struct wg_device *wg, struct sock *new4,
-- 
2.39.2

