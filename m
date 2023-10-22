Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BADE7D2451
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjJVQUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjJVQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:20:15 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6AD98;
        Sun, 22 Oct 2023 09:20:13 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778940531dbso154238685a.0;
        Sun, 22 Oct 2023 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991612; x=1698596412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=11Lp+yVZvF+OP07qRE75BniQsajVFgOyx716K7LaebY=;
        b=hW8QlV67rumG7PpjyXs3gdlg824oNs6ZAKUFvC3nkIlZpdgjGwgZnvfogKapVJhuUV
         yY8pt/4KiembWGpsN7gvG6nMrYtmdzhKCQ9E0OMCp8ctdTHiOZBfXscif6x26h9KIDAw
         AXfDKRpK8HKIGMzZ50XDhmjGBWHh9lFzxpT9yJ/Tx4UZv+DeboaGoV3EcYspzcIVGHak
         yA1ba5q2pPsQGHPVw05fqPzjEM4vO/2qLYp8Ld7cXcro5jN2p3qQuPrdoGOMqgiuvqvl
         i7S3c3pxfe9jSvZZFcF7+YQsEBkJ5XM5SZiksmM47kVY5ShiPSM0e9FgnTL6Pm/SHSnh
         N52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991612; x=1698596412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11Lp+yVZvF+OP07qRE75BniQsajVFgOyx716K7LaebY=;
        b=duj3XTCn+stu8jZ7zKBF1d1WhQxEYyrBI8rwHLScqQsfTYc7i9CAtwCehJv80+YDU6
         ab7pMkv+dgD17DEGehQy8+tQiWcVkZRVzzqquOl2nyStgHtNanwbjRvAKxnRb5/aROjT
         WMxoo6qNYBj0wmPBJFGG5Nj6J1aQUkA2b2D3yGmoyMIcDAPu5a3nbb1ydgs3vMDlCmxP
         3Hd/PAnIQywk/w5yncwI81Mcu69SR7GeUZqXZGi8blQDxzqWvjRb8UyH6oaPaE24QdFX
         P+p8eP3Hq8ZOHHGR3f4P+MlJNUDMH7XuYGrvxrjSJkSOtBTG8udymNWKscxg6m0U1x/M
         6G3w==
X-Gm-Message-State: AOJu0Yx3rV6PFcDRc/UagbxQWoLDfYf8DAckuJ4yZM56KizsJObfU03k
        uJXwAmeAYqhCFIzovWyxhWmJRJtos3wtZDhc
X-Google-Smtp-Source: AGHT+IEQJnmUzDnge2qbQCpFbnw9CngnNQ+P0Ycn1bly7sDhxOCq9mANyOcw81dLekHAfsm+qSKHWw==
X-Received: by 2002:ad4:594d:0:b0:668:ecf4:d9b7 with SMTP id eo13-20020ad4594d000000b00668ecf4d9b7mr7255656qvb.8.1697991611838;
        Sun, 22 Oct 2023 09:20:11 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id g19-20020ad457b3000000b0066cfbe4e0f4sm2243863qvx.26.2023.10.22.09.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:20:11 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:20:10 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 02/17] Allocate and free cork for ipv4 and ipv6
Message-ID: <ad861230877bd6d8b200aafde330c41afd67bd68.1697989543.git.ozlinuxc@gmail.com>
References: <cover.1697989543.git.ozlinuxc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697989543.git.ozlinuxc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allocates the cork for ipv4, and frees it for both ipv4 and ipv6
(ipv6 inet_cork_full is allocated in a different function)

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv4/af_inet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 2713c9b06c4c..3edfd8737715 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -362,6 +362,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	inet->mc_index	= 0;
 	inet->mc_list	= NULL;
 	inet->rcv_tos	= 0;
+	inet->cork = kzalloc(sizeof(struct inet_cork_full), GFP_KERNEL);
 
 	if (inet->inet_num) {
 		/* It assumes that any protocol which allows
@@ -431,6 +432,7 @@ int inet_release(struct socket *sock)
 		    !(current->flags & PF_EXITING))
 			timeout = sk->sk_lingertime;
 		sk->sk_prot->close(sk, timeout);
+		kfree(inet_sk(sk)->cork);
 		sock->sk = NULL;
 	}
 	return 0;
-- 
2.42.0

