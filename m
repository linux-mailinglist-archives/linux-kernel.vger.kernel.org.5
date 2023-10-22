Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6AD7D246F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjJVQWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjJVQVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:21:36 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC51D73;
        Sun, 22 Oct 2023 09:21:31 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7789a4c01ddso178163785a.1;
        Sun, 22 Oct 2023 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991691; x=1698596491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B42kI3To7XoU3GKwYbYl8vB8ggJa0kdJgAmvrJnzDMo=;
        b=O3q+6Bn3rOx07jtmBxKm/7MhBSDDyxqyc3t3vQcbwRkanpUGJhJDVoakYl9goRufJ+
         ItJaH5V/AtPrn5l+8rNoW4FlqIreK3i131ZjuWoMneFnhmIeaNBYxkfiWPF+SsIIG0aW
         TNZOLXtPnmkA+xslOJ8nBNOH45tlKqFvJZDGV4q2Ce8DavXWAE+95VeVI7nDxO1Ui59U
         rxV3oyVcZrjeXtxEik1XBf/CVAT5pGyyBo0umc+1hlbcnVYE+baUXBo3xY6FT4TTpyCn
         V7YcrMxZxwZWYHWafzpGNFjghUQ8TqIbvy79zwHnGouO4xIBkcpfdEa1H7sBKszCLXrA
         4Zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991691; x=1698596491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B42kI3To7XoU3GKwYbYl8vB8ggJa0kdJgAmvrJnzDMo=;
        b=e4BPgrkFVVsWsWhU2H4Pz+NTUSPXG5IpfSUfomXu34TgYDB9EEwNDBc+l6PYuZ+Aot
         bGEpa4G84MpWh1sxtOObwkhToTedK+jV6H4chj4PoIJ8WpaTsaNRJZUJqcMNgeqZhwj+
         NIdgdfWCYQwjzsMb0LA4riTUkoQyOYztClxN6Gw0S5jx0qgPnfACygjuClh4KRfY89Wk
         9a/qAd33r8/E51l5nm9RHLkIp/pNhogRC6UqW+Gu58sTThFbLDI2YdTKmNnqC/Zai60y
         On5qNaPdyqtOcEG4iat9OPRlZpAgSfvY0/LDGOCvMq9sZWuRxwiJ5ZDy9uFk98WxlJ/q
         QTzw==
X-Gm-Message-State: AOJu0YwR8Ecnf9407CnEG0Hoa1zq/xv9+QbdEv67QC6ffZeeaMeM3mN+
        XFRqRpTLABnew4MnkDS1ZG/uoOvYRtuGOK9B
X-Google-Smtp-Source: AGHT+IHmvRLBHeZI5aUo/C1NZtg677fSDmy3Nqw1az7AFAfhNxGiDeFVp9rm3helVhVt3ayDzdXrzA==
X-Received: by 2002:a05:620a:27d4:b0:777:ac06:ed91 with SMTP id i20-20020a05620a27d400b00777ac06ed91mr6766124qkp.23.1697991690683;
        Sun, 22 Oct 2023 09:21:30 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a14a900b0076f1d8b1c2dsm2107244qkj.12.2023.10.22.09.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:21:30 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:21:29 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 15/17] Modify occurences of cork to make it a pointer
Message-ID: <e4dc390bf9089de925348d9ed81605956e65ad93.1697989543.git.ozlinuxc@gmail.com>
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

Update an occurence of ockr to make it a pointer, just like all the
previous patches

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv6/raw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 42fcec3ecf5e..3ef5a75dcb79 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -520,8 +520,8 @@ static int rawv6_push_pending_frames(struct sock *sk, struct flowi6 *fl6,
 		goto out;
 
 	offset = rp->offset;
-	total_len = inet_sk(sk)->cork.base.length;
-	opt = inet6_sk(sk)->cork.opt;
+	total_len = inet_sk(sk)->cork->base.length;
+	opt = inet6_sk(sk)->cork->opt;
 	total_len -= opt ? opt->opt_flen : 0;
 
 	if (offset >= total_len - 1) {
-- 
2.42.0

