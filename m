Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5E7D2471
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjJVQWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjJVQVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:21:40 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0612AD70;
        Sun, 22 Oct 2023 09:21:37 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-778af1b5b1eso146346885a.2;
        Sun, 22 Oct 2023 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991697; x=1698596497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1t3NzgvnykrzyWG2jYSDsYGX1rxwy4sDeziu8k461s=;
        b=DmX2Vy6hFVAF3ml5Kz7nH7lQW8nCz01AHZ/kJHGvNgYwBkjPG3YF53Bq9n0mZnMdQV
         OMRTqI+muTDO0mUdvlqZw7TeixHVSu/HL0ykx0emU8cDYSBDx8cDKzFBvLrPWo1prynW
         BbgvIFFLC+WXCe1nYyrARgQsLA+oBq7S/9PHvs4xv+qeE6kkbSQCSNCiS665rT47Mymy
         zqZvtxqaZnR7Hf7IRH/ZPatjvjGKL9t8TPBh43BeMdMlwCbjjF0X1q7ud9M9m2sI4UEB
         IKGRvb+PoI5D1vHMYPlefQ27YuGntBg7u/wXti2B/BjD2dOsq73rHWTU8alFQKm8zZWZ
         jVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991697; x=1698596497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1t3NzgvnykrzyWG2jYSDsYGX1rxwy4sDeziu8k461s=;
        b=MZgfsm3Qzjwe++kD7wi17BlCPBBgK7w+6PXE2RZUYHEy7d7YsNe/z7GUS2tV2BNxTN
         8c1/BoNPFpRo12pqWT6thnWdj6Et/yW/cMJi7t7GA5pcWi1QA7mjtBX877BH5hF6ROFW
         BKg3EJKlyL++ltXaTJ0MfrQtE0QagdRD+gyoQAZrK0PrF3LZbEUpVMCE9b8RRtzzWkLh
         tSOEHlAoIQJDrtIcnRSapwt+wMqJcrJ/+Fb8ZKknBRxFfjyTm9fhp9zsJzwqaRukAZM5
         Y6lFh/36OYlrI9A7FlSEAL4WoByazZM1nmOikjo6DS6iuqh75eRqGdD1kyYOrrYXZgNC
         iAkg==
X-Gm-Message-State: AOJu0YzYTOuAV+Z371OGNfB/XRgpnTWExsiJokkhHa/NxOKtFspJxxR+
        POs3aV3m2wAUt+YDgu+46HwSLTd3yUJtyd2m
X-Google-Smtp-Source: AGHT+IEbmLedX93X6TS8ILzheGBkn/hRMPiZ2m6Ay1UxyKFXbiuT77Bzapwooct4iMc9lQatJy8hqw==
X-Received: by 2002:a05:620a:8292:b0:778:953e:3433 with SMTP id ox18-20020a05620a829200b00778953e3433mr6198102qkn.31.1697991696808;
        Sun, 22 Oct 2023 09:21:36 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id g27-20020a05620a13db00b00767d8e12ce3sm2116768qkl.49.2023.10.22.09.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:21:36 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:21:35 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 16/17] Change a usage of cork to pointer
Message-ID: <5d0e218ee92a742a9a8e77690b0fc9f0079b6dc7.1697989543.git.ozlinuxc@gmail.com>
References: <cover.1697989543.git.ozlinuxc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697989543.git.ozlinuxc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change an instance of cork to a pointer in accordance with the other
patches in this set

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv6/udp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 86b5d509a468..191d21d12a98 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1306,8 +1306,8 @@ static int udp_v6_push_pending_frames(struct sock *sk)
 	if (!skb)
 		goto out;
 
-	err = udp_v6_send_skb(skb, &inet_sk(sk)->cork.fl.u.ip6,
-			      &inet_sk(sk)->cork.base);
+	err = udp_v6_send_skb(skb, &inet_sk(sk)->cork->fl.u.ip6,
+			      &inet_sk(sk)->cork->base);
 out:
 	up->len = 0;
 	up->pending = 0;
-- 
2.42.0

