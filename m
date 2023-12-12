Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B3880F5BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376691AbjLLStx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376623AbjLLStu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:49:50 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C31CF;
        Tue, 12 Dec 2023 10:49:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702406967; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=XpzMMmouJS+8v/yHAlGE+Vj0dS7q19omTsyt9qq81XP91R//5rD+1t86xedine7cqif/Nq0aOuXshoneQ9G7tgDrHYqmK9+DsX3pV8+dYuAodaA/wJA6geCRnPBYTu/2Fc2xdIZBrf3DFXPD8TPCxRLgOBzRYO8BN482GlestYI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1702406967; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=Scp3IrJnE67ltgIhAprfULm6HsQ/s5KxrhhmK7w7AQs=; 
        b=YlEi3Tx5nLg4cA0rF76WQsConbJT/jLXHHC0VjA4KY45oHiqQXyM5SRuQMJc0UK8+FwF4VFyHB8sUZ7Z3QqK7Tx+CdQkkSOck2jiW2FoJ29EB7rpZmL2Iw/oA7tmoa3woKo67DHNGLXWT7S5oFn5nxNxToqjh2zy1Qi5JvvlUxE=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702406967;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Scp3IrJnE67ltgIhAprfULm6HsQ/s5KxrhhmK7w7AQs=;
        b=k0wHo+mshJJqA16AI3bcFJ/7cbLuMAXKkpgdSDg5+800Pq4Dqtac8nanoCvjXxoa
        bTyb6S6oc0RmxKM4qHgU0UyhJRY/bYQ/zL6N49CZ3L2J3Xg7jHHUd3J8mOLsA9fQSsk
        SCRBvYdf3vgFvgEtvAZLj5bgT3/YYrKuhlnY4g5c=
Received: from kampyooter.. (182.69.31.144 [182.69.31.144]) by mx.zoho.in
        with SMTPS id 1702406966251239.8701045805791; Wed, 13 Dec 2023 00:19:26 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Suman Ghosh <sumang@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/2] nfc: Do not send datagram if socket state isn't LLCP_BOUND
Date:   Wed, 13 Dec 2023 00:19:20 +0530
Message-ID: <8a44ed2afb2f02be34d57d56c6836a5b911bffb0.1702404519.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702404519.git.code@siddh.me>
References: <cover.1702404519.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we know we cannot send the datagram (state can be set to LLCP_CLOSED
by nfc_llcp_socket_release()), there is no need to proceed further.

Thus, bail out early from llcp_sock_sendmsg().

Signed-off-by: Siddh Raman Pant <code@siddh.me>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Suman Ghosh <sumang@marvell.com>
---
 net/nfc/llcp_sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 645677f84dba..819157bbb5a2 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -796,6 +796,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (sk->sk_type == SOCK_DGRAM) {
+		if (sk->sk_state != LLCP_BOUND) {
+			release_sock(sk);
+			return -ENOTCONN;
+		}
+
 		DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
 				 msg->msg_name);
 
-- 
2.42.0

