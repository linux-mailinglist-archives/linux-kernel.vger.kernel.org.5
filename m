Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD53E7FDDBB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjK2Q5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjK2Q52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:57:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94985B6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:57:34 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b4c2ef5cdso17684885e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701277053; x=1701881853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH55LyAvyZzawnq9+CybIblcEgwIvM5k9Dss3KgMZik=;
        b=j8pc+UZDa62f/c+qFGBN5Mz3r305vAeUpt+nQs/rEajQI0OBe0Lj3D97baonnDOx+Z
         NS4Gc8kKoqJJN9MH39t9F9v3n0hPHyeVmWAYKytsaReDiBvBzyvKYXMWXjAgpqVABa4u
         QOYIxo6bdySjZJS/ZTzo/1G2QcyD3fsu29NKbgpUJiNgRogtzD4SNqeeGQfa/4MuiShV
         2rEGFviYteUyBPOgtsNoVxNQppAtgRSKDefibt7Cl9hv634x1GoopC7B+veQ+oqgmVFs
         XnAQc+8C2Z9TLeJfk+PaqGI0T4zW2Z04ZLOcjWVS65tJdK4r8LO6CT/rcs+y93x0jFF6
         y6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277053; x=1701881853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH55LyAvyZzawnq9+CybIblcEgwIvM5k9Dss3KgMZik=;
        b=LRfigpOkNOMV7H9dzqIcTvfJYK+k+iTq5Pt+T6+MkAGh3/MRKFoLW+gZ/7hW82mvHl
         aHXI3ehFxhnTrdS+RsDVsDEB+ItLZn7v9ljKNG5+vO+iUXm/aA0Bp3frTxocGPn0s2A/
         jE/OEMSY1kfbTAyVXe0uxAAB7rYxz3kYcE6UayD7Y9zbm3UM0TZJBUqHKuGraSigPvVy
         r9uy+Hrz5jt2GzpvrYBVlokSRQr1/aPDxW88Xxpb6fH3T+hvZlCs9fOIOYPEeMUekwWz
         VuQYLJFf36LRAfS2WoXKNXyYQepbn7CYi5mvoPAz+9oNSD5TJdJsgcEFYAktnqARBEYe
         hfjA==
X-Gm-Message-State: AOJu0YxDLAZSJzf7vux3MQrla6uw7z4MoUDoJVaNbGb2nSznS/ZmIXGF
        u9ef2KhpuJFrTHh+bYqipdHm6A==
X-Google-Smtp-Source: AGHT+IE0qW6+CGImPLkSMdoP6jUwi6RitG/CiFlOiEI5qiKsdgyQfjlYJD5XpTFWDPXVSoi7ktogYQ==
X-Received: by 2002:a05:600c:548f:b0:40b:4a7f:c9ca with SMTP id iv15-20020a05600c548f00b0040b4a7fc9camr4714881wmb.34.1701277053177;
        Wed, 29 Nov 2023 08:57:33 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b003fe1fe56202sm2876823wmo.33.2023.11.29.08.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:57:32 -0800 (PST)
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
Subject: [PATCH v4 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
Date:   Wed, 29 Nov 2023 16:57:17 +0000
Message-ID: <20231129165721.337302-4-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129165721.337302-1-dima@arista.com>
References: <20231129165721.337302-1-dima@arista.com>
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

