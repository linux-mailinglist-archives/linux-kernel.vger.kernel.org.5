Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5C3803400
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344294AbjLDNJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbjLDNJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:09:04 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B8FD6C;
        Mon,  4 Dec 2023 05:09:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701695310; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=KYKagfJwLJR/l2o8XdfQVvnTVoHBVbs/XFi1NE+ZFOzvPe9C3MeySQ6dsR7fuVze0enMACOpYdyse/VXY4TQOpztCd15R/HQt1dFpQo+0PIaRIxYhokDzi8H+w1lZpMeLsUZuZa3OirrMlDF+P5attVlRK71URPWgknHGqceuo4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701695310; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=hsnJ/KNlUs6XiyX2XlbfSpC3bHgmAF/BmM03d8xcwm0=; 
        b=JD6UklVpZawlW1B9bazsFAdMttK/iEEh6W47YGXECq1gfQzXSDbz1EBzeCpM4FEi1z8o5Fa4P3EEhV/F+7RmIzy+b8eVYQphWBZZfcHGX8CvAb3kuIsvfL2LT/a2Mps3WTcwiz8MsVO/k/K52uxBmGW9nBnB7aUjljZLjLgLoaA=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701695310;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=hsnJ/KNlUs6XiyX2XlbfSpC3bHgmAF/BmM03d8xcwm0=;
        b=fZFzcVqId17iVSznukaO7vQYfftfVedXOqu0E3Xx9IHvtMr1JZUQVWuFZBWeRZwc
        JDm8i+f3I+w0UvjU6WCKAjd/Kv5aHQMZ1sSRBM3uAqdnv+VSNFM2Ba+MpSsrPPRgSEM
        PlFcAHRQGxUy4LMsKZ+VcWT4Z4zOv06xCvGfCt/M=
Received: from kampyooter.. (223.229.148.242 [223.229.148.242]) by mx.zoho.in
        with SMTPS id 1701695308912849.1027651405482; Mon, 4 Dec 2023 18:38:28 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Suman Ghosh <sumang@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/2] nfc: Do not send datagram if socket state isn't LLCP_BOUND
Date:   Mon,  4 Dec 2023 18:38:22 +0530
Message-ID: <727e1ff5df5e8d36e19b25155b1555ed3fd0cdfe.1701627492.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701627492.git.code@siddh.me>
References: <cover.1701627492.git.code@siddh.me>
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

