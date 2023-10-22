Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31367D2450
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjJVQUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjJVQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:20:08 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F2C112;
        Sun, 22 Oct 2023 09:20:05 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d11fec9a5so14089236d6.1;
        Sun, 22 Oct 2023 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991605; x=1698596405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvEMV92Y7IGxOW7ep+lKkBzNSVWQ3OvimPsEysx6x70=;
        b=O3AhVLMKPtO93JimthaJkAQ4a7yAcNF6luxKSs92oLDzVut6tri2eDEEGTNWsyZr3t
         YZ+RQBQSQWX7jLCW8FfULT41Nbp6D/2TXXsArJN0pcZJTa/BExJs/nKPij3JeJieExS1
         Rto34+WCtAHgs8fvq2EDUoboekLdiLybZ0KnNcMNwmlqILiNipgB+OFr6sbaE6tNmxdb
         /5Sikr8dTaD9qnAFZjaT/4gido7v+2yV1g8xFFm98uQvFG3uxYzRtgppgFvkph0p4wT7
         iGracaewlwo4gC2ukCpDfNRvl/1RosUGXUsFRFd6wsj8bmpINIcV45Z3S/sWrapft5oJ
         hhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991605; x=1698596405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvEMV92Y7IGxOW7ep+lKkBzNSVWQ3OvimPsEysx6x70=;
        b=w+h0RBwHsCLtNd82nqxiD1Evh+N6CdSCUiCyk6QA07WSRKSmkEDwAmyBWKQGtl+teq
         NEV/4ldj0TH3uQsMtJlqYYUP1n98f1L/97j4onnJjstrFS5VAivkviVgSC9RcxXgsQfS
         gX5LqBqmnERUPiJqSIud5EDsHYN2j9sV/CaPiVoCdb3EKyoEgMZN5hLROcxrgHXxtUM9
         mN5NEQCWO8XstJxzTSynvG3iUYfsOTGxm3YGDRLG8/baNCKZS+GhOurJsT3TkzaIhFeT
         Yl40hCAv1LQE3EJIoFEsbP91SeqRwsb+HldOCIF6tjHzUfKmxCI7lzE2UJmZahEKbrOz
         Bi1Q==
X-Gm-Message-State: AOJu0YxQGN8bLUEbDCFmMOVx6z5jRTeRIdwIn8YO2xsP+Om7hzLZgebO
        c9WCsCdYcWt/myjIUfOBFJ8lOFW1MM/y6Z7e
X-Google-Smtp-Source: AGHT+IGQD1JmttgBzVvn7s4Kd7LlGNkAEo/7yLcO5ljrQzOxV6XH4Bvjh2RY1myycy/NxQ7zUpPl/A==
X-Received: by 2002:a05:6214:5012:b0:651:66c4:cf4e with SMTP id jo18-20020a056214501200b0065166c4cf4emr9143878qvb.23.1697991604672;
        Sun, 22 Oct 2023 09:20:04 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id di12-20020ad458ec000000b0065b229ecb8dsm2281042qvb.3.2023.10.22.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:20:04 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:20:03 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 01/17] Make cork in inet_sock a pointer.
Message-ID: <1a849abd2f67545bc99988c5f18de46e6b273618.1697989543.git.ozlinuxc@gmail.com>
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

Change the cork in inet_sock to a pointer. This is the actual change
to the struct itself for ipv4.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 include/net/inet_sock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 2de0e4d4a027..335cd6b2d472 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -240,7 +240,7 @@ struct inet_sock {
 	}			local_port_range;
 
 	struct ip_mc_socklist __rcu	*mc_list;
-	struct inet_cork_full	cork;
+	struct inet_cork_full	*cork;
 };
 
 #define IPCORK_OPT	1	/* ip-options has been held in ipcork.opt */
-- 
2.42.0

