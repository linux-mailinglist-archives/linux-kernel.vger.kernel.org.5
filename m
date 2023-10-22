Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897147D2458
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjJVQUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjJVQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:20:34 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAB6D66;
        Sun, 22 Oct 2023 09:20:31 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-778a47bc09aso177757185a.3;
        Sun, 22 Oct 2023 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991630; x=1698596430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fXs6PiW1BKOBdRQHF7f3ZT2KL9Y+20rzJRl4mqpCX+E=;
        b=kcMYC5v84Txjr+6+AUT8RDyjoUTIZ+0q57/Pb60T51hueGw6J9wd2rUjrYdN4ezyXd
         4jIM31n0AraA1kJ/39NOcgYnONUO7yro15NUUDGYlnTYhXcLd90dKwfiHvznF0UrSIjF
         gKkXjPX+5/B8c8QImaCrUuB+R7MPNMj5rp8AoxoHP76mAuyJ97m2uk99IzE/xgvJVYjy
         tV193nBuTkq9/ZR8WTXZXjeuiOSlYcoB/xp8bDzxS5KaK0u5I7U0vEL04598JI8HuGUy
         +vmZJpua6UgQG9jCmi1Ghn1dSTyJ5uLN37CVfuaBjm1TwgmdcBv37V6S25SrFdq8n3jV
         eJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991630; x=1698596430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXs6PiW1BKOBdRQHF7f3ZT2KL9Y+20rzJRl4mqpCX+E=;
        b=aNn+Dzo0BtlcMe+2gBdr5r38YmNuXpOXSY1FuQ5lrSTU/vSvlKZg0uqswVGt0gCkZt
         sDuAErteVA0Wt8CgvkSUABAhl9dAWZRiFugeTAxhCm6TV7EA3M+wc7DBQLhw9htrfNKm
         /bHf0Qd9zDpXSdbb4KnTeoAIFjwT2KsjWls9WcZS0xcZX53HzhWGauoQkzxq+AQzsxS0
         Q4g5arq3RhlaqQskP83du/i+ULZG2Oi8S6KTxY/50l5KUGwl2TGorTkB/v3bbFBhPYLA
         lPz0+nm6hQcLQJVFYyn6MahOBdVAu9Jz63va/KehXQHGAl2k1tQ2MhIjljIRld7UHa6m
         HCkQ==
X-Gm-Message-State: AOJu0Yx9FPEYT37pK4p2/MPx5T2XxUByifTRr/dyO3UUVjclGdpbeu4b
        iZ2Lm4Z6bqYnvGmGQA++gq8v3N3w7Za3B1hE
X-Google-Smtp-Source: AGHT+IFgB41PrKC5dlf1Z+oPh4jtjow0wgXREW6fioYQKsycaiERm1tohtnuEDj224wnpUXJ66gQ8g==
X-Received: by 2002:a05:6214:1c44:b0:66d:3474:a93b with SMTP id if4-20020a0562141c4400b0066d3474a93bmr7830628qvb.59.1697991630066;
        Sun, 22 Oct 2023 09:20:30 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id f8-20020a0cf7c8000000b006564afc5908sm2244755qvo.111.2023.10.22.09.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:20:29 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:20:29 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 05/17] Change occurence of cork to pointer
Message-ID: <288d695cc29e46c24d750c9897f5443e7bf65717.1697989543.git.ozlinuxc@gmail.com>
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

Change cork to pointer in accordance with the previous patches in the
set.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 include/net/ip.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 3489a1cca5e7..30bef1828a7d 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -240,7 +240,7 @@ int ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl);
 
 static inline struct sk_buff *ip_finish_skb(struct sock *sk, struct flowi4 *fl4)
 {
-	return __ip_make_skb(sk, fl4, &sk->sk_write_queue, &inet_sk(sk)->cork.base);
+	return __ip_make_skb(sk, fl4, &sk->sk_write_queue, &inet_sk(sk)->cork->base);
 }
 
 /* Get the route scope that should be used when sending a packet. */
-- 
2.42.0

