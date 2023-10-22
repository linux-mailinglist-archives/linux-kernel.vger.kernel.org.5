Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1172E7D2456
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjJVQUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjJVQU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:20:28 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ABC19E;
        Sun, 22 Oct 2023 09:20:25 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d17fd450aso30380816d6.1;
        Sun, 22 Oct 2023 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991624; x=1698596424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1L1EoQYDbmiosHQzcLpjg625XGZkEv3QC1cmuWB3ELg=;
        b=DW42v0b7lCrm66DVfhHYLtnx21cyqQQNRYweMHl+0AI5MICBS8lQQLfgzUVs5CrxJy
         7l3Xvkff16E4fneyOWQkV9wKMX0YDYGSZMRNtzFSUD8VZuAtRaNj6eBdyo+At5Q0AUfJ
         YOt1Z8De9oVhLn++BrS55RCG9/i3kzT/ybp5nrMgxkyvu6tq39HUjPLYtbhEFqhOIeo5
         sM4QA2OfRLhmNlv+Sttr8+nO6d6vzMMi/9GtwdmjIVROpIb2XCJ0ogR/r29IbhpGH7Yj
         s7m1gla+KNVhXYIdKu2GtYKNl2ZrNLmEnOdKlAiI1W4one36nSUxSKmwa+ZwYdRGg0tq
         ZxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991624; x=1698596424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1L1EoQYDbmiosHQzcLpjg625XGZkEv3QC1cmuWB3ELg=;
        b=Y+Pv0xGt/kwLUZVEzpeXMNxvDGwUtUFZfoOt4e2evm+eJuhpROg66fWtFpK3dXFVyG
         5uxON0Snr6a944EuRnry4ETxYGeFkFcP+n95vyXXlIPmQMcrRrTRXAED+UfLXsiJBYuR
         D9bXs7dTUcqUmpvDTwzYKRqjaUB67Ul3T1sETd8Y8auo5J2KB8Kk4xLsQlS1tp9uHBid
         ICVEfsFbSSfAxxtN2M9QEtncDJ2v5IfralEDvyhq7xl2EcBz2WZ2OGr/MRkaqgr9IfqT
         8BZHU0+HSMHV8IoTV4LQ0/TfbAycc8liW4nMb2BpAbK5o5PZ+8U+tt64sfGFvsjzvbEn
         kL4g==
X-Gm-Message-State: AOJu0YyozcWZspFU8TgBtG3wJc2DsDvaqMSMhXxrwap0lcvCa51gAqj7
        uVAQcBfEoS7VR05cnYHrGtPqYBTdoTn8Qwxl
X-Google-Smtp-Source: AGHT+IFb0kPwpaLiBLgJJyX3vtX46tAOg6CAeZGbsVVJ+6MqCJhvlM4f4kCrAVfo7Y2dSrw3KGH7HQ==
X-Received: by 2002:a05:6214:2b97:b0:66d:995e:24f6 with SMTP id kr23-20020a0562142b9700b0066d995e24f6mr9250563qvb.10.1697991624252;
        Sun, 22 Oct 2023 09:20:24 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id j17-20020a05620a001100b0077703f31496sm2111420qki.92.2023.10.22.09.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:20:24 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:20:23 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 04/17] Allocate and free cork in inet6_sk.
Message-ID: <5e5dcbb87d4b57a347c5146373c75737967e4cd0.1697989543.git.ozlinuxc@gmail.com>
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

Allocate both the inet6_cork and inet_cork_full here, and free the
inet6_cork. (The inet_cork_full is freed in inet_release called at
the last line of inet6_release)

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv6/af_inet6.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 368824fe9719..33e92826361f 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -221,6 +221,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	np->mc_all	= 1;
 	np->pmtudisc	= IPV6_PMTUDISC_WANT;
 	np->repflow	= net->ipv6.sysctl.flowlabel_reflect & FLOWLABEL_REFLECT_ESTABLISHED;
+	np->cork	= kzalloc(sizeof(struct inet6_cork), GFP_KERNEL);
 	sk->sk_ipv6only	= net->ipv6.sysctl.bindv6only;
 	sk->sk_txrehash = READ_ONCE(net->core.sysctl_txrehash);
 
@@ -234,6 +235,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	inet->mc_index	= 0;
 	RCU_INIT_POINTER(inet->mc_list, NULL);
 	inet->rcv_tos	= 0;
+	inet->cork = kzalloc(sizeof(struct inet_cork_full), GFP_KERNEL);
 
 	if (READ_ONCE(net->ipv4.sysctl_ip_no_pmtu_disc))
 		inet->pmtudisc = IP_PMTUDISC_DONT;
@@ -481,6 +483,9 @@ int inet6_release(struct socket *sock)
 	/* Free ac lists */
 	ipv6_sock_ac_close(sk);
 
+	/* Free cork */
+	kfree(inet6_sk(sk)->cork);
+
 	return inet_release(sock);
 }
 EXPORT_SYMBOL(inet6_release);
-- 
2.42.0

