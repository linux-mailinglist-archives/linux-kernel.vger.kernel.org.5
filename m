Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9907FC691
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346382AbjK1U6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346311AbjK1U54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:57:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7A11735
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:58:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-332e3ad436cso3850757f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701205081; x=1701809881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH55LyAvyZzawnq9+CybIblcEgwIvM5k9Dss3KgMZik=;
        b=HmmdyVicb+Gio2HiMJd3tUHpYD3UtHGuqKbmpQVFPS0yO3lwH9qDwS44Q400nL4smB
         GOM1kyxi5Xp8PCCvvGSCxj2c1Qcoeg6n1a78/oazpyYTV6+/4238Mf7D4t3edqVf0Y4x
         UDzrcnzq/Ebg3G40kFNWjevQ1eYwBZP60A9b0ENrNMzFHCxnyhjg7jj66duuQdtiIf7/
         j2mljug07ay4d53v+pyLlDvINSHD8vPIDXvV5UB8u1us6fxGTX5w0BDVu01Nvh1g6ia4
         /OUW9QIR4UlJC52wpTTEQPVXpaj24E3H7xE0yjD+q1FYx0zs6v6wsWbFdsD/XiFx7gdg
         EPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205081; x=1701809881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH55LyAvyZzawnq9+CybIblcEgwIvM5k9Dss3KgMZik=;
        b=LOI2ioKT8Ztws10kywyh86lt0faMAvyO/yYRZqt38w975vGAOL6EK96WH+FjAHVXs4
         zOA0VDM5LtPvcMVeL61o6Q7KrfA1hddhVHk58A1F1hRY9IeDJeH/LdKpqUWeiCACDINV
         5FRyQ7PTYv2jkLQmRkHsLk2Hah1bCjxdpj2n5Ljo/X0S3FHb3P1lgsxk9fbS0X5ZjfpK
         WluSk28bzB1mbP4kQGH0Olk/0TNjvt9/rAGL/ywHqHhe5YqT4sW+vrcJSBr7hNd/rkVA
         uspXXRURI4IzsMled9vtcnIchjnVEuFHRBocQVtNEV6M58hHbXPXtiJpdDTsM2qlUC4j
         pmLA==
X-Gm-Message-State: AOJu0Yy3IhQeNo8BxoTdFilzf9KmmbKP4FZWFaoOZ7YoZnFuUxrd7Tx5
        QQJDYAZ8oENhdWoVF1P2Tdo1YQ==
X-Google-Smtp-Source: AGHT+IEEw9yaLxtyh/n9vNZ50WJjGGVyxYA3jZ7C+dAdpxv6LW5qIRnZ1+iYhFS7TM0h/xhRc489sg==
X-Received: by 2002:a5d:638d:0:b0:332:eeba:ee8f with SMTP id p13-20020a5d638d000000b00332eebaee8fmr9647295wru.11.1701205081195;
        Tue, 28 Nov 2023 12:58:01 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0040b45356b72sm9247423wmq.33.2023.11.28.12.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:58:00 -0800 (PST)
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
Subject: [PATCH v3 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
Date:   Tue, 28 Nov 2023 20:57:45 +0000
Message-ID: <20231128205749.312759-4-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128205749.312759-1-dima@arista.com>
References: <20231128205749.312759-1-dima@arista.com>
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

Listen socket is not an established TCP connection, so
setsockopt(TCP_AO_REPAIR) doesn't have any impact.

Restrict this uAPI for listen sockets.

Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53bcc17c91e4..b1fe4eb01829 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3594,6 +3594,10 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case TCP_AO_REPAIR:
+		if (!tcp_can_repair_sock(sk)) {
+			err = -EPERM;
+			break;
+		}
 		err = tcp_ao_set_repair(sk, optval, optlen);
 		break;
 #ifdef CONFIG_TCP_AO
@@ -4293,6 +4297,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	}
 #endif
 	case TCP_AO_REPAIR:
+		if (!tcp_can_repair_sock(sk))
+			return -EPERM;
 		return tcp_ao_get_repair(sk, optval, optlen);
 	case TCP_AO_GET_KEYS:
 	case TCP_AO_INFO: {
-- 
2.43.0

