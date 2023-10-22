Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C295B7D246C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjJVQVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjJVQV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:21:27 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAFDD41;
        Sun, 22 Oct 2023 09:21:25 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-777754138bdso172322485a.1;
        Sun, 22 Oct 2023 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991684; x=1698596484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLAq6YzQjNIuqyApWRKxm5OD/P3XILlIc8qEYqCP7cA=;
        b=GnTnI8fPh8bN/9uYZ1OYptJ33BVg0Quoacfm7EY48V4V9aDp50riOJ0jYkY7FSr/S/
         YDQxgb/smb0laZglv1PX2TlsiwLhmEpJq3ZmWb9J/xSUSuL9QRF9Jd6JmfJbeSRnlJ6k
         N+KxqsS7jr5m8C5qQqfdKMwMiMpvJFVRy/V9nXWssP0uT/X899sphT7LUqrxkFwaHG1s
         b9TITtKD4Ft9amJkQTEIiw+TbluksMbxyWP1tsrls8CObwDRLLTrg1dfTV0k1P2dZ0li
         fkw5WW544lAc09xcVCFSf7WLSKrLSeTOBN+kp/C0WtNPvSgXvgrbuKlJb2kQoh/dDRzR
         BilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991684; x=1698596484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLAq6YzQjNIuqyApWRKxm5OD/P3XILlIc8qEYqCP7cA=;
        b=kX9xGEEWM/bZvnLC9Aeivrmgoj/ofetKl8WTuKvY8Rb5w3aq4WV+Qw0OQW3Ijif59+
         +Fhk3yT4zjvI5JURktmuQpYXNF5i+JcpyNiNDqZA/BqDK2uj9WduoT/IwuELbZkB6cBh
         mq+nRpBM/S/HTKeQuby6h3PnufxSyxWocUKzmWl20VttchgnoS753OVvf7rfokY2kkPR
         iz9BVA8zKYruKnJblXxvE2YOmT3Thh2mKkeTstf2IvEqLKLSdEn+j4WhawfySu4lpWDq
         +c0xKMqbIilChXrM9jHy7YFKd9LL33/R/LQ2+NnDYWjeKjfjpV0JP+sqPEiZlhfKwcUR
         jiuw==
X-Gm-Message-State: AOJu0YwxeZnN2i9qhQjWoWGI6UZtM1LW4ZyyXuwihaLEDKi+6z4O6mlO
        99zkEkAcIl0KRN/h1lCga1ySi9e3llFfF8mU
X-Google-Smtp-Source: AGHT+IE5IiulELRmSlGWmVhwVSPdboggCU/VckqEFpuH0InhLH3SnHDDOMbC9BKDxG381WohsPDzsQ==
X-Received: by 2002:a05:620a:22a2:b0:770:72c3:dbbc with SMTP id p2-20020a05620a22a200b0077072c3dbbcmr6394314qkh.18.1697991683933;
        Sun, 22 Oct 2023 09:21:23 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id a1-20020a05620a16c100b0077411a459a8sm2126191qkn.4.2023.10.22.09.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:21:23 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:21:23 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 14/17] Update usages of cork to a pointer
Message-ID: <6b6cc028300b69b1f201b02e67e4fcf68aa7fff1.1697989543.git.ozlinuxc@gmail.com>
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

Modify a few instances of cork to be a pointer

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv6/ip6_output.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 54fc4c711f2c..5f24087bc9e2 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1878,12 +1878,12 @@ int ip6_append_data(struct sock *sk,
 		 * setup for corking
 		 */
 		dst_hold(&rt->dst);
-		err = ip6_setup_cork(sk, &inet->cork, &np->cork,
+		err = ip6_setup_cork(sk, inet->cork, np->cork,
 				     ipc6, rt);
 		if (err)
 			return err;
 
-		inet->cork.fl.u.ip6 = *fl6;
+		inet->cork->fl.u.ip6 = *fl6;
 		exthdrlen = (ipc6->opt ? ipc6->opt->opt_flen : 0);
 		length += exthdrlen;
 		transhdrlen += exthdrlen;
@@ -1891,8 +1891,8 @@ int ip6_append_data(struct sock *sk,
 		transhdrlen = 0;
 	}
 
-	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
-				 &np->cork, sk_page_frag(sk), getfrag,
+	return __ip6_append_data(sk, &sk->sk_write_queue, inet->cork,
+				 np->cork, sk_page_frag(sk), getfrag,
 				 from, length, transhdrlen, flags, ipc6);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
@@ -2058,7 +2058,7 @@ static void __ip6_flush_pending_frames(struct sock *sk,
 void ip6_flush_pending_frames(struct sock *sk)
 {
 	__ip6_flush_pending_frames(sk, &sk->sk_write_queue,
-				   &inet_sk(sk)->cork, &inet6_sk(sk)->cork);
+				   inet_sk(sk)->cork, inet6_sk(sk)->cork);
 }
 EXPORT_SYMBOL_GPL(ip6_flush_pending_frames);
 
-- 
2.42.0

