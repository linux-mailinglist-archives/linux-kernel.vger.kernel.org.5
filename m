Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702D67737A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjHHDXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjHHDWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:22:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDDD213F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:21:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68783b2e40bso3598456b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 20:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464888; x=1692069688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZBR/L7n+c0K4+2jvj2qF9IKHrGGr2P5oMHLWIibsdA=;
        b=P/V9ljiS+RZV06sSAc2COBIOCp251sZvy3FmMZoG/OkNXoyMAnbNe24EKZNrbifKu0
         TMw9/bIBHlaHnzbtUtWzPHTqYsy2sFGtkRs+xt8vbZzsiS0x7Rc9mKFj2RktzhmElS+2
         SIeHhQhwHgkVPUcIXzdkakUQs/PkxTbSAUA2zU2DOYbE+GTmiLeGsM6DB34oY7IioJoX
         u8Jqfm2ETyE34gqRs7naQ2o/4eL8Sh9ZBIOH/9/XmQWQmnyKbBt5QKI6jrWVjEbTDSob
         NWueoCvGAVQgsnFEvyZJztfQr+58ypf9d4mbmvIy2JWUjfWc7DNBUg9/MfRu1XPR5mvw
         xldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464888; x=1692069688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZBR/L7n+c0K4+2jvj2qF9IKHrGGr2P5oMHLWIibsdA=;
        b=OCa4MA9DgRDH/apv7O2ve7JZrjxfhZnJroy5CaxhAq8CyAanvDiCtp/C9rBtWpIOHg
         77InA7nLPCOsfqL9eJQBii94VN4a5Y/Fbv8Uy9BlffLiuSzk7X0FANNTA8fJPek/7+jm
         3N5BKBxAe4ymqHoEwDa1HCngoMT4qdHMdvUrENxQK6Mk8xfofRPejqPwoIIjAKHq4YcG
         tvdJaq6YaOJJxShDIf2iNrWKtgshbxmbOxvLiL98q7bawiA25eA3MBZnh6x0oIerJKdB
         kyYMzzaIf2Dv4Iy6po48r2XeOvpRymA2aaIqDyy0YLYP8Mi1Nz9/fWpn/EAuBi8a+dgb
         WOvQ==
X-Gm-Message-State: AOJu0YyZx9ZxiWDodKmb0u2xQgkBtBfZj+O00fIYRlEzt8b9dpuFPwxx
        37vZVS1L6SEe0qr4aQsi3UG3/Q==
X-Google-Smtp-Source: AGHT+IFOa9auvTw+52jDK1Q58QGt14PBhuKoWVXpCxAriS0oNTmVYC/tpubsf59++3sdyZXGMGacNA==
X-Received: by 2002:a05:6a20:9193:b0:140:d536:d424 with SMTP id v19-20020a056a20919300b00140d536d424mr6753584pzd.53.1691464887689;
        Mon, 07 Aug 2023 20:21:27 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:21:27 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 9/9] veth: add support for AF_XDP tx need_wakup feature
Date:   Tue,  8 Aug 2023 11:19:13 +0800
Message-Id: <20230808031913.46965-10-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch only support for tx need_wakup feature.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 70489d017b51..7c60c64ef10b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1447,9 +1447,9 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 
 	memset(&tuple, 0, sizeof(tuple));
 
-	/* set xsk wake up flag, to do: where to disable */
+	/* clear xsk wake up flag */
 	if (xsk_uses_need_wakeup(xsk_pool))
-		xsk_set_tx_need_wakeup(xsk_pool);
+		xsk_clear_tx_need_wakeup(xsk_pool);
 
 	while (budget-- > 0) {
 		unsigned int truesize = 0;
@@ -1539,12 +1539,15 @@ static int veth_poll_tx(struct napi_struct *napi, int budget)
 	if (pool)
 		done  = veth_xsk_tx_xmit(sq, pool, budget);
 
-	rcu_read_unlock();
-
 	if (done < budget) {
+		/* set xsk wake up flag */
+		if (xsk_uses_need_wakeup(pool))
+			xsk_set_tx_need_wakeup(pool);
+
 		/* if done < budget, the tx ring is no buffer */
 		napi_complete_done(napi, done);
 	}
+	rcu_read_unlock();
 
 	return done;
 }
-- 
2.20.1

