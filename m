Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1013C7F69CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjKXA1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjKXA1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:27:32 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC4D10DD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:27:37 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b2fa4ec5eso9570365e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700785656; x=1701390456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1zqOorwszBSy7715/FfAd+B6Hz5TxCnBSal1fxWdU4=;
        b=etBESr/f2VjgTzn3inyxg6UneJVdC7Fa4+ZseWqcIoQa8GewJeDwQDA3HYFuxRB7fI
         0LAxLNIUbwvexclfq8uBGaPwZSXlEiuzScqSyw//F7FjpdlRZ+ClBQ6nNQX/bos2V9j/
         JT5/CP6QKt1OJPinehlPoykwSwpt7MBEm/tr/WicarrcBYpV07aZYvetxz/EB98bYH/Z
         gQMQvCHBY8ldHRySoSojBfgwt3XCJsSrcltFcNMcpxB+Fs/xfF+vQdM2leIW3bTKD8tY
         95pj82MZTo9+nwfz8PYDV8HNfDBKrrUY2ozWng3VIafR0GYcaS2BdLZ+Hu/3dwtcmsEp
         gT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785656; x=1701390456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1zqOorwszBSy7715/FfAd+B6Hz5TxCnBSal1fxWdU4=;
        b=Wujxzv3y+wE8Nmd6L0RmvONKWViSwTo5SbrdWJtV9sEb0dyMH8rr2/1XdiHnWBmI0k
         p1JbGeTSVBr8F9mtFUBQRE9XXOswj3FPGfTGesZDH04ubT5X5pAmxIe0BjYHD1HyWSRW
         E45BYLY0GTUpmK7K5Sdv40lT94kQ6tGSz9eYgmiBV2NpxhC26agHq84sQm3NvAMq6dhe
         /CUg5qeEkPG+kTNawlWSz8uhDZKHqzaUqMYzUe9ILd+F1Cg902uaalvEWI9bCgZZQ7RG
         7tVIygTDnFh3z2EtQWJ5OIR4P3HhWMnBaeRJErms5Yf6iKnTVAwBjUrMzTRKdzr6acX2
         OO4g==
X-Gm-Message-State: AOJu0YwmBUsUTnMX1A1j1XYIjIrlDI6yBQm848RWOv+OiazS9r7I7KFr
        uW8FQ01ow5CkzWrYgi/jBYP7yw==
X-Google-Smtp-Source: AGHT+IGZzgd8txvbEnx/qem7XVY1WoQcmi+WWFOs5wKmthWsn/NDewmniq56CwG6us8dLSqITcBg2w==
X-Received: by 2002:a05:600c:3ba5:b0:409:325:e499 with SMTP id n37-20020a05600c3ba500b004090325e499mr957416wms.32.1700785656074;
        Thu, 23 Nov 2023 16:27:36 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm3453230wmo.23.2023.11.23.16.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:27:35 -0800 (PST)
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
Subject: [PATCH v2 5/7] net/tcp: Don't add key with non-matching VRF on connected sockets
Date:   Fri, 24 Nov 2023 00:27:18 +0000
Message-ID: <20231124002720.102537-6-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124002720.102537-1-dima@arista.com>
References: <20231124002720.102537-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the connection was established, don't allow adding TCP-AO keys that
don't match the peer. Currently, there are checks for ip-address
matching, but L3 index check is missing. Add it to restrict userspace
shooting itself somewhere.

Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_ao.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bf41be6d4721..2d000e275ce7 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1608,6 +1608,9 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 		if (!dev || !l3index)
 			return -EINVAL;
 
+		if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
+			return -EINVAL;
+
 		/* It's still possible to bind after adding keys or even
 		 * re-bind to a different dev (with CAP_NET_RAW).
 		 * So, no reason to return error here, rather try to be
-- 
2.43.0

