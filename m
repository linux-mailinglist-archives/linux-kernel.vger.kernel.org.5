Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF8376020F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGXWPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjGXWPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:15:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383F710CB;
        Mon, 24 Jul 2023 15:15:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso71614301fa.1;
        Mon, 24 Jul 2023 15:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690236908; x=1690841708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VR5kr5/P9TZGbX0T3kYzKuPMSI9rX/Q6fFU/FogHPdo=;
        b=K7TpzLZSFTbsm+Zv7HTkwil6Z+M7WziaM9XD+4kQ3KbFBS+CPxNzQrS+qIdDt0xqjD
         ZhGlG7k4TswErdRWQr7kCaIbWRNbpdXCncvvhqnzcXjaYffiry/TwVlxasM+tMlTdHgr
         qv/H794OC21k3pldfu4o5v58DYcOGMwGjBqGDcATYR4s2vL/xxG0Zj+SZF7QW8RyVuYH
         gduR5At2PuMloDYbL/jjtySnPlkyb3YNhm89qFF68cu9gckTzkp5tboSnfRnAfmfUuxo
         lZHOf6lrOj+0h38jW1l+s+gB9LeY4cCWviRw1w+z3u23YshK5fPkSaE0SlbInmZmf2Ii
         bJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690236908; x=1690841708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VR5kr5/P9TZGbX0T3kYzKuPMSI9rX/Q6fFU/FogHPdo=;
        b=KRUWh54Dr2fU/k4sokE/V7f9u+62lwpAbnL1PZxH+KdzrkoiBIOf2ypyL1gAcLe48i
         5PKOKZOhb1KE5JExhC84/BASh9euNjugqD25nQcVHYBLZgFbXXUroTwXOkJvhzOmJKto
         hxhUYURcH6QHG5ME5QFZzdTiBa0lVae0i8L0UXdE8mglMS8V662ASa1YXHmLUs6wC12U
         QB6UvAWdV0q4b0ffiUdLG1guZclXjd/M5YsEQMV7cMXflPVdL0kXBahuH0b/zx7ghp8X
         mt5Avrsy0deVfODqXyk+Z8vu8OjUv35+JWGPOTEYuM5tsIbhRFlE4rW7I5hLLczrUP9Y
         BT8g==
X-Gm-Message-State: ABy/qLYAGv0EKBN8wSN1CKiznm1TPLIx8Ix1501a7ByHIJ01+/Z1g6Hu
        E36wiyCKasvovHw4YLjJqFc=
X-Google-Smtp-Source: APBJJlHb1Go1ALd4vfaDEL4yOJa8bVJ3Xvjgg/THhW+h1vUVM31EjGe8IiZLRMQz7JoQxb2F7Oqutw==
X-Received: by 2002:a05:6512:3b84:b0:4fd:f84f:a729 with SMTP id g4-20020a0565123b8400b004fdf84fa729mr3185178lfv.11.1690236908188;
        Mon, 24 Jul 2023 15:15:08 -0700 (PDT)
Received: from localhost.localdomain ([77.222.25.78])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512048200b004fba077e654sm2401130lfq.194.2023.07.24.15.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 15:15:07 -0700 (PDT)
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org,
        brouer@redhat.com, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH 2/2] drivers: net: prevent tun_can_build_skb() to exceed xdp size limits
Date:   Tue, 25 Jul 2023 01:13:26 +0300
Message-Id: <20230724221326.384-2-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230724221326.384-1-andrew.kanner@gmail.com>
References: <20230724221326.384-1-andrew.kanner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with syzkaller repro with reduced packet size. It was
discovered that XDP_PACKET_HEADROOM is not checked in
tun_can_build_skb(), although pad may be incremented in
tun_build_skb().

Fixes: 7df13219d757 ("tun: reserve extra headroom only when XDP is set")
Link: https://syzkaller.appspot.com/text?tag=ReproC&x=12b2593ea80000
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---
 drivers/net/tun.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 18ccbbe9830a..cdf2bd85b383 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1582,7 +1582,13 @@ static void tun_rx_batched(struct tun_struct *tun, struct tun_file *tfile,
 static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 			      int len, int noblock, bool zerocopy, int *skb_xdp)
 {
-	if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
+	int pad = TUN_RX_PAD;
+	struct bpf_prog *xdp_prog = rcu_dereference(tun->xdp_prog);
+
+	if (xdp_prog)
+		pad += XDP_PACKET_HEADROOM;
+
+	if (SKB_DATA_ALIGN(len + pad) +
 	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE) {
 		*skb_xdp = 0;
 		return false;
-- 
2.39.3

