Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB00803DF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjLDTBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjLDTAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:00:54 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A408D5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:01:00 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ca00dffc23so19271501fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701716458; x=1702321258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUFbq/Bpf84kUYD5hi1tJcGjiTvsxTjhBSB3X6vJDoM=;
        b=Ix+CWGjfoTnPi0Reh4LiZJRzUanU1j1VSgXwMAXwBsLOzc5Ruoq6VPwlo7IPiZ7XN7
         NiZr2eJdX5AsY63Ob7RAqm+vcLFSogBYR414/9FxwRmlIjcY/L1gcqncqlcBD+Ct3B5l
         mv0o8CDjQVhsG8R62J8pXbnM9KHBuyEIAUYe7NcvZw9zNITb8WaJt6d+E2ytgdYVQu3X
         5Y+5r5Sm8lkj9mVQshWVUdsiDiUhus/MCGEMmJk9Vi0bxzvSWTvkGvucaZmSKlOcMeA7
         ClIs4X7dWVdjVc/gn91LNlJsiHPtX/2roqSLG0ATOK4Dsps+clazXrUrcLz0H6Y0JPGm
         6eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716458; x=1702321258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUFbq/Bpf84kUYD5hi1tJcGjiTvsxTjhBSB3X6vJDoM=;
        b=hSpYKiO9qUz0dZNxMpKR1+uSgrvV8NM/zHSGpewuRYBL+Iux9iFsgLiGZzZxkcECBv
         HajgGQF/iUwefB//5HxjBm9RaBxgoxrkzMVN5mVNioY3aaOkGnTguEqHwEz5A/rSOWwL
         m0nZ16djW42Qj2ehqIA18Y8Gu81e1bBVKAMPT5Hq2Scf1P9lLn1KmiHTEJX2DnE8Ao6x
         mHLhHQbgIBXsew0AzueRpLlpUebTtoHUBD7hdZBbka14m+3HeuyOK0gkahYfLs+YPR9t
         gImufQufLqnF8ueoVu4zH577X5iQhFmbHxsKoMlnLY+4VflflDWHwGcWTvOR0l5zUtH7
         YrKA==
X-Gm-Message-State: AOJu0YyAZ+93ph0TW8hcTvxA7zpm5iNA48Sg3xuZBxuxj0W14f9pS2ro
        4DDRtv5l9/Rk3NPcILay0yxsLA==
X-Google-Smtp-Source: AGHT+IHYuOp6qqMq4tE1HhzSjBMzbnrKfodkZP1F+YHS+F6QHGdAXtt1lesJrgvunHJzsUHFUkmhAw==
X-Received: by 2002:a2e:b348:0:b0:2c9:f727:7e65 with SMTP id q8-20020a2eb348000000b002c9f7277e65mr1332068lja.38.1701716458691;
        Mon, 04 Dec 2023 11:00:58 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id dx9-20020a170906a84900b009fbc655335dsm5577614ejb.27.2023.12.04.11.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:00:57 -0800 (PST)
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
Subject: [PATCH v5 3/5] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
Date:   Mon,  4 Dec 2023 19:00:42 +0000
Message-ID: <20231204190044.450107-4-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204190044.450107-1-dima@arista.com>
References: <20231204190044.450107-1-dima@arista.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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

