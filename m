Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECDD801D80
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 16:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjLBPlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 10:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBPlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 10:41:45 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E6A11F;
        Sat,  2 Dec 2023 07:41:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701531674; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=II7atRkYs8DsFlatf6IG3jLHij/WBsxs9ClikySOYt9Ld+Wxut/l+lQGqFv03/QyDQkgW1/iKJV57ETeOp8eyZ5b1AnKX4Wf2rBtqwIpWYGvlNd8RIdsviMPSPLYpt0uh70vZFLlaHIVRhferCocCQ3+c68XoxAGwUkqYiioU6o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701531674; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=hsnJ/KNlUs6XiyX2XlbfSpC3bHgmAF/BmM03d8xcwm0=; 
        b=GB7rkLQU8d5MPzNqT5EFrGs6w19XCDgho+G31jgynu6FrgWPiMm2L4mS+BShCCfkLeObe4RXblrAUvVRv8oJrhbkdASnWpWmlBKYJrHRDg7Zzx3ixOe0g2kkgL7256LscGndraMp2awmPngYNR64gf9BzYDo7V8M2sYJCAAnqZk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701531674;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=hsnJ/KNlUs6XiyX2XlbfSpC3bHgmAF/BmM03d8xcwm0=;
        b=fanfBt63yWMtEPnCArLJt8IPBOtbC+KKbFKtgD2C4ukNf5RgMGkWkLDKuwnsG9mr
        WU0ca/mPoiAPjysWoRKwWEL6VjR9Gu8FtOgO5/9C7qJq8bN1RmZAIjeoj76ridGLBJR
        OfPCfPbBuKmKPfi+5921LqlKLLaPECBG/HPhiVCc=
Received: from kampyooter.. (122.170.35.155 [122.170.35.155]) by mx.zoho.in
        with SMTPS id 1701531672332946.1333406858636; Sat, 2 Dec 2023 21:11:12 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH net-next v2 2/2] nfc: Do not send datagram if socket state isn't LLCP_BOUND
Date:   Sat,  2 Dec 2023 21:10:59 +0530
Message-ID: <fed27fede2b38a190e24b0d4b53306eeece22ec4.1701530776.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701530776.git.code@siddh.me>
References: <cover.1701530776.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

