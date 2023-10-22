Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983187D245D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjJVQVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjJVQUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:20:49 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D62CD52;
        Sun, 22 Oct 2023 09:20:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-777719639adso153413685a.3;
        Sun, 22 Oct 2023 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991643; x=1698596443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3w20SDE19R7M/DBYsehJexNI3rG7cUtG/NhFavJbLJk=;
        b=aPNL8Wmdv02ptk8uFNKKJwbRENvPKZkD40/cnEH5tGvRyaiLqFEchMzU+96w5QrYSO
         GQHhly9jbhNw0+V0XAEp9EQVmZMR6xDwTmDmQNkwPMgpwtSoboJTh7HzqAM6muGBBMPo
         OA8FP7gIsb/0kTkAWPojR3Oi+n8ChV42Q8nLyR77s0/DUCbA0+9iM8M+vElasDn+J9hT
         IyJAT9ugS9vyv3qIoLjLpjnD+oeqhfWtztSeBcn+t9FSOG99jBrRhyPhVcL2mI0+k2he
         LJUyRIb+kUcJtivDpq9dP0zM9l5qSIdONc0dSwaVxmnRCz/lK3Rc10rpqDCEOJZlhBnK
         tsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991643; x=1698596443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w20SDE19R7M/DBYsehJexNI3rG7cUtG/NhFavJbLJk=;
        b=C/b1fD3mevJvgHfpm3KN9J2WabrbHOvuMEX7dfdSbvqDQ2c12ooGv5DoPeswBcrxYa
         /COx66KLoKjROKGue+GQ+IA5T9lrYzsyu0R1U1u+UhHRPRLfXe/J1xToiyzEwqzZ4ax+
         YSQRMRs7BBGwnrk4sk6UXEyMK2zQeDR1WaIfnR2NcOlcsUevOS1pzLv/zR3FgEV6h0Or
         CR3nHGzkrK3GlwMNX0N0v59VJZefpTFodO1bB2GIS6HHNoX78cW218zdQSzdIG/dq/LC
         Cnp2hkI7XA0ooRhJcvG2i1LAyi+7RWVx4abQ2cUWa/qY0hn0TOrBQkQB+Yvna/ZGDIzF
         DxNQ==
X-Gm-Message-State: AOJu0YyOFFozDDYW1rsYd/nuiujbKAR6qkzBpsFT8qbjdRiIVPHZFKD3
        RsJ6TqTy19xyvsqGA4qUWZ2f4wSn4UyU+3Vv
X-Google-Smtp-Source: AGHT+IFb3mPFsKXlmy2504j3v32BlEM08891YzAj9B5vYF2FFIWtYf/PfpZxRZ2LfxsgmGhNX4eD8w==
X-Received: by 2002:ae9:e912:0:b0:774:3235:4e6d with SMTP id x18-20020ae9e912000000b0077432354e6dmr6496497qkf.21.1697991643257;
        Sun, 22 Oct 2023 09:20:43 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id vq6-20020a05620a558600b0076e672f535asm2095914qkn.57.2023.10.22.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:20:43 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:20:42 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 07/17] Change occurences of cork to pointer
Message-ID: <f2ebee0285828524243efc13c157007327c2277a.1697989543.git.ozlinuxc@gmail.com>
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

Change two occurences of cork to a pointer in both inet_sk_reselect_saddr,
and inet_sk_rebuild_header.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv4/af_inet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3edfd8737715..60f693040a2c 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1263,7 +1263,7 @@ static int inet_sk_reselect_saddr(struct sock *sk)
 		daddr = inet_opt->opt.faddr;
 
 	/* Query new route. */
-	fl4 = &inet->cork.fl.u.ip4;
+	fl4 = &inet->cork->fl.u.ip4;
 	rt = ip_route_connect(fl4, daddr, 0, sk->sk_bound_dev_if,
 			      sk->sk_protocol, inet->inet_sport,
 			      inet->inet_dport, sk);
@@ -1321,7 +1321,7 @@ int inet_sk_rebuild_header(struct sock *sk)
 	if (inet_opt && inet_opt->opt.srr)
 		daddr = inet_opt->opt.faddr;
 	rcu_read_unlock();
-	fl4 = &inet->cork.fl.u.ip4;
+	fl4 = &inet->cork->fl.u.ip4;
 	rt = ip_route_output_ports(sock_net(sk), fl4, sk, daddr, inet->inet_saddr,
 				   inet->inet_dport, inet->inet_sport,
 				   sk->sk_protocol, RT_CONN_FLAGS(sk),
-- 
2.42.0

