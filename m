Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2A7F2372
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjKUCBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjKUCBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:01:31 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F01D8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3316bb1303bso2239622f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700532085; x=1701136885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRv390KZg85B3wbZ2TCp60L17ZYyL9mQWzXIk/oqbtw=;
        b=dm8J7qBSgjKUheRrTjDGEdwDRR/0fWw05/DnqQugslvUNkacXpJtXUS0IT8iJGb1Mw
         1NSHzihLf9h6y3oKNygxigaS+wqy+P7IfFZ5kQX25qvz+AiAkYNd3IvEXpoGpoh5koW3
         Q/rrR9Ewb+2LZXEW5MeTh29mNYU2aKzou37pHVDBhKXUUZMNb6djJT+7abDGihCC1fep
         2637JzWf+8cf+ob/GQlJoNi+XY5C3jbXXFE6/S8hMYBWjCqMYmw1DkfWTi5lOaQWNR/Y
         XDYY0OozDJO4W2axIBtzrn7D/aDzbSV5U4bzk+VYWrYcijdJ3ePqxtW4oPRm/BoWBMyP
         uocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532085; x=1701136885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRv390KZg85B3wbZ2TCp60L17ZYyL9mQWzXIk/oqbtw=;
        b=dbn1DiTPe+BUDZNxI6d/HUVVTVbH02lizeipnWcoUTDKhOB2Hxe7T3rm8T2Ctozo1m
         rY7f7eKthu6KwXwF9Mzt9ETiV0l+JBNsK5MMo+ctC5i6i7QrRzKJfteu/0MAo731BW7k
         5l/JpliKCLvWaJ9wEFldcKNaLztGkBJ9aBcX7KtLSqf4P+5+5UYI7MqFf+MOSapGB3jM
         FyAAEiMTA6cebRVbigsIYSdX9jNG8GTVbcNWK3qm2Nsn3+GRv++vxV5pcayhPIcV+A7T
         arpWYlYSUMdR7YH0JoBaFmsnwh7axYnvviNHyTda6RlfaHu2FuLORjJxUU1n1O28TmSm
         G6iA==
X-Gm-Message-State: AOJu0Yzwj+/47wcJaKhruPtSRYZg8z0lT7bjwagKmFSaHquW/GwV5Iy4
        MbGNkwQeApNUboBnghvn63TH9Q==
X-Google-Smtp-Source: AGHT+IHmAhpILijZy4DBKFQ50xDkp/1JWygHEaw2KLxD4bp3sk2gYc+RAFu6ZFb9Q4bdj006JBHNtg==
X-Received: by 2002:a05:6000:1147:b0:32d:a476:5285 with SMTP id d7-20020a056000114700b0032da4765285mr6146461wrx.31.1700532085689;
        Mon, 20 Nov 2023 18:01:25 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000184d00b00332cb846f21sm2617105wri.27.2023.11.20.18.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:01:25 -0800 (PST)
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
Subject: [PATCH 5/7] net/tcp: Don't add key with non-matching VRF on connected sockets
Date:   Tue, 21 Nov 2023 02:01:09 +0000
Message-ID: <20231121020111.1143180-6-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121020111.1143180-1-dima@arista.com>
References: <20231121020111.1143180-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 71c8c9c59642..122ff58168ee 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1622,6 +1622,9 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 		if (!dev || !l3index)
 			return -EINVAL;
 
+		if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
+			return -EINVAL;
+
 		/* It's still possible to bind after adding keys or even
 		 * re-bind to a different dev (with CAP_NET_RAW).
 		 * So, no reason to return error here, rather try to be
-- 
2.42.0

