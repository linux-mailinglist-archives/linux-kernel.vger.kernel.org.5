Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18737F69CF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjKXA1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjKXA13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:27:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F3810C8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:27:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-331733acbacso927869f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700785654; x=1701390454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1xPXn0VYaTrAb1Nt5Hiecyvp9SYb9ivj7o6hsBOhvw=;
        b=kNX70Na8pKjSa3xGst8Rpujm+GWUhvSGTclIDfRRCyNe8VAGiC0kCFDs2LgBC6QAsi
         PWMlwGHQjC3/9UhgOpfCnlPzbv5+NDyJY3iVHirdie19HeFLHKsh9i8zgZ4eHaSPHSSs
         6LQjHDwNHnX+P0JXGGG2Rfx/NqwuN/9fxgwmMaGq1aruqptUAM6zZM2Mt6IrXe51po3q
         6coH0/w8jZrLHxlulDYTy6OLgTPJ4zjybVb6atjr3bOoiIXxlFbTktzWj4cV4v3DWXIw
         9JwVYh0yZhKk0cUt0NhoYd8alsx5EMEy4yKs16bvC9Wsmg8wsDazytOou2f5CqFFrC2D
         DuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785654; x=1701390454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1xPXn0VYaTrAb1Nt5Hiecyvp9SYb9ivj7o6hsBOhvw=;
        b=W3974M5aXnYQ+4PPEZa6UHoNYb0v7DhA28d5NaAWRDejzdRHOUiYWunrMPkCxwpbbF
         82mPGHWrh3K70gsRZjZeMO1cYGx0SW/RJIDtpU9BFV4iovQjZ4bS8XVuk6SD9FD0pKXM
         DAA74RrPXqVnJJ7w03SNNKTsksZbGHTbK8WjeUmMv8vJAxvNN+vYfE6feowEmsI7EgSu
         I7eM554FLQ+mJnssKb37GvY/ECqvP0Y2tTE6GWNfBRgUm3aKNHU+VnCPqYNS5RH4B0Fh
         t/8gPMvwM2Il+/GApfw/AVsKAU0xNM8A/zlj5YQCpJIJNKk7G5W94MUgM2oJWDjrhLhj
         HLnQ==
X-Gm-Message-State: AOJu0Ywy8hzX0561kkMT96MV+khj17wToizz1cw1sF57q9RCSJYfs4e+
        Dnet58diBWfNZpouyontlySLDg==
X-Google-Smtp-Source: AGHT+IG6PXq1iNo8Vk7aSZGEmmqJsJVa5x8rz0czmMerFM1PyZtMnYrAhUZ5YJhqhvDh+LrGls+v7w==
X-Received: by 2002:a5d:5488:0:b0:32f:83e4:50e7 with SMTP id h8-20020a5d5488000000b0032f83e450e7mr596208wrv.12.1700785654680;
        Thu, 23 Nov 2023 16:27:34 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm3453230wmo.23.2023.11.23.16.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:27:34 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH v2 4/7] net/tcp: Allow removing current/rnext TCP-AO keys on TCP_LISTEN sockets
Date:   Fri, 24 Nov 2023 00:27:17 +0000
Message-ID: <20231124002720.102537-5-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124002720.102537-1-dima@arista.com>
References: <20231124002720.102537-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCP_LISTEN sockets are not connected to any peer, so having
current_key/rnext_key doesn't make sense.

The userspace may falter over this issue by setting current or rnext
TCP-AO key before listen() syscall. setsockopt(TCP_AO_DEL_KEY) doesn't
allow removing a key that is in use (in accordance to RFC 5925), so
it might be inconvenient to have keys that can be destroyed only with
listener socket.

Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_ao.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index c8be1d526eac..bf41be6d4721 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1818,8 +1818,16 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 		if (!new_rnext)
 			return -ENOENT;
 	}
-	if (cmd.del_async && sk->sk_state != TCP_LISTEN)
-		return -EINVAL;
+	if (sk->sk_state == TCP_LISTEN) {
+		/* Cleaning up possible "stale" current/rnext keys state,
+		 * that may have preserved from TCP_CLOSE, before sys_listen()
+		 */
+		ao_info->current_key = NULL;
+		ao_info->rnext_key = NULL;
+	} else {
+		if (cmd.del_async)
+			return -EINVAL;
+	}
 
 	if (family == AF_INET) {
 		struct sockaddr_in *sin = (struct sockaddr_in *)&cmd.addr;
-- 
2.43.0

