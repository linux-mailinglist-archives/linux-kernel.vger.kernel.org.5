Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5175B7F69CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjKXA1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjKXA12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:27:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9696C10D9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:27:34 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32f737deedfso789465f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700785653; x=1701390453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH55LyAvyZzawnq9+CybIblcEgwIvM5k9Dss3KgMZik=;
        b=KyTb8XJFTur8dPrC3de1g8Vk/S8ze/Uv/lZ9Ot5vHOscxuoGloR0ffhdznpFeJteLy
         xMQ56X+X3N8xIhQxt/JaW4WVq73I22bhI0CUC/3ZfPKZ+6VxQO8qVS4K/SXTLKM8eHsQ
         jrpBsB/0nsoJujnM2XDhnZ3euMZ0RfT2n/nuxm0r7gH2aXNJuBy7bKJ55JJFyP8dvG4p
         d6A0U7KtoOCTjSLJ/nHbILwtCBXzaBTmAC9CyeBN8yWhJ6A4L0CR1u/npMkvGyH+gaYj
         b98Vfx+3vZ2kP+1VaxlciXo1sDZC71eZbIIdNTq/i0Bi4E6wI1qsNjwOze7EWSerJWkD
         SEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785653; x=1701390453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH55LyAvyZzawnq9+CybIblcEgwIvM5k9Dss3KgMZik=;
        b=PmQ1TIwkbrIp7soSKQXG3aiQQmrSwLSfov3FDwFqtsEh1Zp0edpxIjkuDfYKf42c0h
         7fqlxGPSo+vYc9cwWuDzgDI+gY0X3snzPFTYrr51rt6HbZeds23l7uGLtg10pBvX8GRw
         NRJfdIcY4vaYpr0inr68UzmlSt9As35fVg1wFAcgwXvBui77Gh5vtxuSpAn1DiIWzX8n
         3CZPqKinRAIwyuG+eFiRYHc70MTl9kSc4hGESZXhAUso+cbDpT6srAueu4FbH4Q2envF
         uT92J13XUNudOVjfe4s/wxPF01CXAElCAI8TV+qJ2BXiAnG5mABQwOQdyG+ISALdEH4a
         op3g==
X-Gm-Message-State: AOJu0YwZUtcP2zEY727zgRHcFaKiDjPJJAS9WiDp4Rs8dnscJPLs5ZKT
        MrHX1EbzQ9DbcK41qzHMsCaqsA==
X-Google-Smtp-Source: AGHT+IFT357fLdv+9VPLUo9JyrvYwmlakZqhgzZ1DUTRUDGIr00buQXKS16JWd7Hv3B31+VpUgT0Qg==
X-Received: by 2002:adf:e6c9:0:b0:32f:e1a2:526a with SMTP id y9-20020adfe6c9000000b0032fe1a2526amr649526wrm.67.1700785653098;
        Thu, 23 Nov 2023 16:27:33 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm3453230wmo.23.2023.11.23.16.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:27:32 -0800 (PST)
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
Subject: [PATCH v2 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
Date:   Fri, 24 Nov 2023 00:27:16 +0000
Message-ID: <20231124002720.102537-4-dima@arista.com>
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

