Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA277D245F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjJVQVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjJVQU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:20:56 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B04610F4;
        Sun, 22 Oct 2023 09:20:50 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-457cb7f53afso875407137.3;
        Sun, 22 Oct 2023 09:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991649; x=1698596449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Yqf8xOcyNNZs+GLw9aGZ5FbGSaK8bs1qBlvW4RYacI=;
        b=eSO/eL8boPEF/QsYprRX0Robfp0EMZ6zP2Js9SzYKr6yhAwLqXLMwgEp2PrukQOH3p
         d4SNgCR57PTqRD8bfx8t5VBBxtySeNT76NknHR+SmfJ+IxEW8NplMDiDoUFJvlso4nsr
         2lCzpVJgTSMIM+2wfbOc04gr+4XxGxiJThjVS7FPBaR1nF88c1TZr9bdXAKyVJSQShhz
         QoVzNlkiS2erMbjGCvEfS7trdgv4mm8BDnUJgL39qD5wnuC/He3oUqI/c1CU+7T6+TQ6
         Pec0YRZX4wSdpzBbJUQ3zqxtQIkh35G+oNoR/HRtB6eRcVu7x9EXD0GRLe2AosfbaQJ0
         2B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991649; x=1698596449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Yqf8xOcyNNZs+GLw9aGZ5FbGSaK8bs1qBlvW4RYacI=;
        b=dBpvbyv5amGw0BlWcv0CFC+iAk9DUybF3v4XlMoB4TeSovLe6BVZu4tEdIEmNJGHfN
         NgQFR2+DNi97H8h8FBKp7BYptrHA6qj7BwrXU4YRyIsc+xAUZemYR+VsC336c8hiz2cV
         dYkMjBF1Fk7/cCKvdLDSA7cQtW5oLoSxywh246z0Mr32LzZ6MhytqVWtJb6v/gSM1Z5k
         I6mW7beA1v84iuwBJ9HBycNjSngpUdgwRQFP/0oUCj/ZFKZhdNkyea8ydxGe6L1KsSbw
         D6t/o65Ubw07lULRgb2pKjdPnNi6HMzYg3EiM+UKjIWDEm8y93kkStACarT/lDHnYsJA
         93zA==
X-Gm-Message-State: AOJu0Yyektluw63TzDl4J11cqwsEIkBooXLGTGzvAlzbx8aMFIlHcS/Y
        n9SX1eJ5+mROJ0qnXfpSYbu1iZoOBTt8nDjN
X-Google-Smtp-Source: AGHT+IFK9DmeyDcF9/djIZteLet9zGGQFyDAxkMMHxpJMhtz1/ZTnU5DRYqWbE+uP4A1FyKGPRrrxQ==
X-Received: by 2002:a67:e156:0:b0:450:f5cb:c3ce with SMTP id o22-20020a67e156000000b00450f5cbc3cemr5758220vsl.17.1697991649192;
        Sun, 22 Oct 2023 09:20:49 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id m1-20020ae9e701000000b00767da9b6ae9sm2112629qka.11.2023.10.22.09.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:20:48 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:20:48 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 08/17] Update cork to pointer
Message-ID: <e7c4e9575bec76fc4ba6dc0e8115aa9621377f7b.1697989543.git.ozlinuxc@gmail.com>
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

Updates cork to a pointer in the __ip4_datagram_connect function in
accordance with the previous patches.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv4/datagram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index cb5dbee9e018..bb73eae9de25 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -45,7 +45,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
 	} else if (!oif) {
 		oif = inet->uc_index;
 	}
-	fl4 = &inet->cork.fl.u.ip4;
+	fl4 = &inet->cork->fl.u.ip4;
 	rt = ip_route_connect(fl4, usin->sin_addr.s_addr, saddr, oif,
 			      sk->sk_protocol, inet->inet_sport,
 			      usin->sin_port, sk);
-- 
2.42.0

