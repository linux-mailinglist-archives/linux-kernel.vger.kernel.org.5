Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C47D2466
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjJVQVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjJVQVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:21:14 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51011114;
        Sun, 22 Oct 2023 09:21:10 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b7205bc5a3so785633241.2;
        Sun, 22 Oct 2023 09:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991669; x=1698596469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ+QqSzcJMgWzu6ORVRR0lMQFkEKfiANjxuAOwUhzpk=;
        b=HcHKJrAeifV9gPbuBKQNY32Df0f1W1ZHZBsooxe84eZnUVRoXwWuUWFQJ/fPGNXk6w
         gqn7Ki1rsWlP19hZLrheo0TD8hog2RP7JsldEwVnMX6zQSo1RjuoGF33hwoPG0TFxq4N
         5HS6jdtxnhTq2HPcr61kZqXoL6X7GX1PmImEqtu+QbBgSzQmI1y+DMmJVGe43m061TwC
         PwdsIcYWm1Qye6IMVWllxviIirrAHNGEHP/Br5kkzswAlMUQooBegmnDrwLWToQJoY35
         asVAFtH3+HD2GkjBLfJcJOdody2WVqGIlAVvI6M2UAyTUreZzuyKBYwiSUKWwap8HKdg
         aGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991669; x=1698596469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ+QqSzcJMgWzu6ORVRR0lMQFkEKfiANjxuAOwUhzpk=;
        b=sMkwPfPl8kDsbqo75wlzKD7srMf6qnTFyOlbiLSyRKyWeP4GoQcE2/g1ks/EFrsvqw
         IL7nfWaeIWQnPzytAOpdkp8yh63dBXLpZJrggcfR2cOwmiFNq+HP9lp753V5bvm2JhyY
         E0iIHa5su2VRYyzbzIGrfohd0jmb/gVf2L2yimuyyBLYkKcSeP1AiXWrSDW4TmMenoxD
         jyFg578kZb2Uq4Ve4m/XZtku/gO2iJl2c9+nwnUJGxpXRHwx/PnkKCSHzj/TiBy9aQR1
         jkta0Zd9JsLw2JoYd0jT2IJZYx8tVlO3HLFkutUj2KgywlzjcXzW8H0Zs+3rkPc8wO2B
         WfdQ==
X-Gm-Message-State: AOJu0YxpjMkbbTqA6TWCyuzaW/0FDbledgLJ9wmbo8wf21LAxfHWjk1B
        /yE4h8qXwcDNc17zvl//KtYzgLQDDfBpKiZY
X-Google-Smtp-Source: AGHT+IFdSRakpjndt17kmN9wGByOEDeWPpuoz+iuZITGl5/KtnjcPjrrPjzPI+8tbuX6muvGGUDidQ==
X-Received: by 2002:a05:6102:204e:b0:457:d3ef:cbe5 with SMTP id q14-20020a056102204e00b00457d3efcbe5mr6410944vsr.20.1697991669465;
        Sun, 22 Oct 2023 09:21:09 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id g2-20020ad45142000000b0066d23395d27sm2240698qvq.123.2023.10.22.09.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:21:09 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:21:08 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 12/17] Change an occurence of cork to pointer
Message-ID: <51d5932025b92446e63c72192194fc2ffe9f30a0.1697989543.git.ozlinuxc@gmail.com>
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

Changes this occurence of cork to a pointer

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f0723460753c..9672eaeb3ec1 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1414,7 +1414,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 
 	err = INDIRECT_CALL_INET(icsk->icsk_af_ops->queue_xmit,
 				 inet6_csk_xmit, ip_queue_xmit,
-				 sk, skb, &inet->cork.fl);
+				 sk, skb, &inet->cork->fl);
 
 	if (unlikely(err > 0)) {
 		tcp_enter_cwr(sk);
-- 
2.42.0

