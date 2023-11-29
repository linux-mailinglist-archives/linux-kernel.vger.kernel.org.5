Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC937FDDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjK2Q5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjK2Q5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:57:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFDED1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:57:35 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4079ed65582so52155025e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701277054; x=1701881854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1xPXn0VYaTrAb1Nt5Hiecyvp9SYb9ivj7o6hsBOhvw=;
        b=Pv4S8DPZMX5/yJB6NyJjYkxlQmb6aEawoms8eFOetLImorKodqBHQbb4dRD9ES12ua
         xxEkrlFkMLaEGLDY4ygW5OAE68wVYm3/cGKPZR3qCE1r0nspXmSlgEKKR2+lge3lcpjq
         aOXEwW5xrcvf45wyHz5L1MzvN0U9mcipwT/PF3jBPiM+k5vb1S0NuwWb1A1y7TINcZF6
         aOzeNVzSFw+VRIn8pUYuPsV0D5whxrSE/skGnNEB5X2+dQH/pO5FEVRI26iWXlU+ZTrg
         nY6nilz2Ewl5HUk7Bm6BZ/sDAQYVo2Tc459NTJN2h7bQXnP7fqSZtAeNKYqi+ZDSP0XP
         6CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277054; x=1701881854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1xPXn0VYaTrAb1Nt5Hiecyvp9SYb9ivj7o6hsBOhvw=;
        b=nyZ4z1u15VnQ+T9YWQy1uz+0a/Nk2jtLs42kg5dsyyts6rmNQpNqlai2uZT+aaJQa8
         PZ0gxjL53P181ckY+aPQPwxEEvahpot9KxjJneQbQynAJ+5N3QqDRgi/m4dlwBaGe5AL
         ihQoYIZJUz/9WyXej8E6gHmvz+hIdK6ELUxc35IZnFApOp53Rt2EIhbUxe9a1zFRQWDp
         y7wJfEY8vpt+J6+zZ2t8Yy53+3kuamCDw47xhaGYdqW7a7kCsQwNqMGoO4sC6HpE4G3a
         4LRKFAjIrWhimFtlM9EmNKCvhbxcfNEahoTMs6w//UoPIUYogI55WMD9J1ANorHw22eZ
         U1Yw==
X-Gm-Message-State: AOJu0YwTreJDc1O+J0GKi6KsFcI9q3WfB4K9M+fuPgBNXP3M+WRVWWC1
        VK/fj751MPCaGYVykqX5DXr9KKFQVd3BaL5PgKc=
X-Google-Smtp-Source: AGHT+IFv98Y4Evt6w+wZRYZ89u3q4f4c2LuS+DT8e2Kj7frzoOkMGoBzs8DH8FfxGqGxmfUrJaLBlg==
X-Received: by 2002:a05:600c:4507:b0:40b:338b:5f10 with SMTP id t7-20020a05600c450700b0040b338b5f10mr14391772wmo.32.1701277054520;
        Wed, 29 Nov 2023 08:57:34 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b003fe1fe56202sm2876823wmo.33.2023.11.29.08.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:57:33 -0800 (PST)
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
Subject: [PATCH v4 4/7] net/tcp: Allow removing current/rnext TCP-AO keys on TCP_LISTEN sockets
Date:   Wed, 29 Nov 2023 16:57:18 +0000
Message-ID: <20231129165721.337302-5-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129165721.337302-1-dima@arista.com>
References: <20231129165721.337302-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

