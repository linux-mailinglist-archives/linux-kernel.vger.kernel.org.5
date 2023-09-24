Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2107AC71C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 10:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjIXIDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 04:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjIXIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 04:03:19 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38C110A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 01:03:11 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id kK56qpUBLqQHikK57qsa0Q; Sun, 24 Sep 2023 10:03:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695542590;
        bh=u45atJv1BtkgA8BuqIIa8D3M4GDg5T72SV54ytqq6ds=;
        h=From:To:Cc:Subject:Date;
        b=dQ3XcACW9ta7AnZyfPgpVGsN/g48nPB37c5JGi9GvpVYsFrpFjdO3OTZN4CzJ1nzA
         1WMkzjKVtrJvAGKEDVaq1JhOpmVdcfnBvbFkjNAJfftslP/W2DaK5q1inEuYNQC6J7
         EcMvq5v392XkUSM5/xqcpcDoeZeoY7YKsuk3sv/+VRG89QXWLYJKBC5QRGPJXS302P
         8nNQP4YCqnkVrPsLeeKPmJf190vFld8wMUYk1uIppsZZkW9+wg2aRD9JcUxuQwR8in
         X62S8P5I9mcWHDADcalieY0iQwPweHBJmoplO47U3BZMJYZV7ldR+wUKNxZ3lAwu4q
         8kqZYZHGGqi7A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 24 Sep 2023 10:03:10 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: [PATCH net-next] udp_tunnel: Use flex array to simplify code
Date:   Sun, 24 Sep 2023 10:03:07 +0200
Message-Id: <4a096ba9cf981a588aa87235bb91e933ee162b3d.1695542544.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'n_tables' is small, UDP_TUNNEL_NIC_MAX_TABLES	= 4 as a maximum. So there
is no real point to allocate the 'entries' pointers array with a dedicate
memory allocation.

Using a flexible array for struct udp_tunnel_nic->entries avoids the
overhead of an additional memory allocation.

This also saves an indirection when the array is accessed.

Finally, __counted_by() can be used for run-time bounds checking if
configured and supported by the compiler.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/ipv4/udp_tunnel_nic.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 029219749785..b6d2d16189c0 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -47,7 +47,7 @@ struct udp_tunnel_nic {
 
 	unsigned int n_tables;
 	unsigned long missed;
-	struct udp_tunnel_nic_table_entry **entries;
+	struct udp_tunnel_nic_table_entry *entries[] __counted_by(n_tables);
 };
 
 /* We ensure all work structs are done using driver state, but not the code.
@@ -725,16 +725,12 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info *info,
 	struct udp_tunnel_nic *utn;
 	unsigned int i;
 
-	utn = kzalloc(sizeof(*utn), GFP_KERNEL);
+	utn = kzalloc(struct_size(utn, entries, n_tables), GFP_KERNEL);
 	if (!utn)
 		return NULL;
 	utn->n_tables = n_tables;
 	INIT_WORK(&utn->work, udp_tunnel_nic_device_sync_work);
 
-	utn->entries = kmalloc_array(n_tables, sizeof(void *), GFP_KERNEL);
-	if (!utn->entries)
-		goto err_free_utn;
-
 	for (i = 0; i < n_tables; i++) {
 		utn->entries[i] = kcalloc(info->tables[i].n_entries,
 					  sizeof(*utn->entries[i]), GFP_KERNEL);
@@ -747,8 +743,6 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info *info,
 err_free_prev_entries:
 	while (i--)
 		kfree(utn->entries[i]);
-	kfree(utn->entries);
-err_free_utn:
 	kfree(utn);
 	return NULL;
 }
@@ -759,7 +753,6 @@ static void udp_tunnel_nic_free(struct udp_tunnel_nic *utn)
 
 	for (i = 0; i < utn->n_tables; i++)
 		kfree(utn->entries[i]);
-	kfree(utn->entries);
 	kfree(utn);
 }
 
-- 
2.34.1

