Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0954E7FC698
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346565AbjK1U6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346346AbjK1U56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:57:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F319A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:58:03 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f737deedfso3763549f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701205082; x=1701809882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1xPXn0VYaTrAb1Nt5Hiecyvp9SYb9ivj7o6hsBOhvw=;
        b=GQqnu53nPxiuqc3wQMp+V2lZtUgSOi0g+3mNyKCM1V8SDSE7PxTVxwIfazl8iRCjIL
         xF11Wge8ndNxRD6aQ5aaHbTSHnAZehAzej7r13XTzUJUSZZnfzm7k89GSL3Lp5OUjN6w
         bNGN215Sgf3azVHXwNjs6OYFeF1i1W6IuxYZB2Z9C9I7D1V2A7Bvekhfm+hahNfpQYz4
         1Lz2bpclrAcy3G2QZabStSPfUdjCMGrMY1/lV7sORLvSrV+PbXCorxMrMKeiX7DQDv9d
         R4x+zxN4Me1dbasSKhz5v7dd7B4F7ER4KBwDRWmgWO0D73pOBDTG5jtFVJSnSrKrImO1
         RhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205082; x=1701809882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1xPXn0VYaTrAb1Nt5Hiecyvp9SYb9ivj7o6hsBOhvw=;
        b=ldiupr78hOgtzOPdD7OJJ92n42n3nmIq//BnrOdFA/NK4zTGXitqyxZFcxYqdlEQOL
         4chDOpRbYj1E84l7A+C0g58rOqp5nZ+IDWHeChwXp49YeP1J9qeB0BzQmS/Gpj6osaM4
         BY2y9tgi3WLabQbFuSqfcYZ4KpQCrICQC/Zlpumy5WmBQj/NpmuSW6WcWW4esPbE5YAR
         SzTKZWfs/1fAPPU9uF6scB0D6s2QOeH8MVYC+ng+7SBk3V6XbPFNYtocoyFzM1exHQ/v
         gNFOGODTj9xgUy92u2wjM/5BtSrL4bp+ysBbcUIlcq7XC6PaZGD+OBHFnGtt2nDIrdsB
         SehQ==
X-Gm-Message-State: AOJu0YwgR7LisnNSzNo3Nx16L6AJI7JFc0JPo4fz4F7osOAOs0aDAOGr
        grUMa6m74OraeDnH5CrKtkqwYQ==
X-Google-Smtp-Source: AGHT+IFOwJBMZz5KpTnXbkRb6NrPG/IC/IH8dzG88Ydc9UIUlFjnbR4D5Y+Sl4qmFwxh+Y33lgZUzg==
X-Received: by 2002:a5d:6309:0:b0:333:85e:a11c with SMTP id i9-20020a5d6309000000b00333085ea11cmr3785785wru.16.1701205082440;
        Tue, 28 Nov 2023 12:58:02 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0040b45356b72sm9247423wmq.33.2023.11.28.12.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:58:01 -0800 (PST)
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
Subject: [PATCH v3 4/7] net/tcp: Allow removing current/rnext TCP-AO keys on TCP_LISTEN sockets
Date:   Tue, 28 Nov 2023 20:57:46 +0000
Message-ID: <20231128205749.312759-5-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128205749.312759-1-dima@arista.com>
References: <20231128205749.312759-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

