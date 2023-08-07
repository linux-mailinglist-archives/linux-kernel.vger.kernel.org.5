Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A867E7723DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjHGM0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjHGM0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:26:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E678E40
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:26:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2682e33509bso3159121a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691411160; x=1692015960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNrm/+UjyC6jP3361KhAbnju37DBvc3v6PBY22LsM1M=;
        b=Odnl2d6AHR7ogYVyv84kmmRDuNN7Vvc8M1lxAGL/9SCtE8gHIBmwbmyFXKM7CN9Rkf
         JKPZEPqCQCJsPTJby+TWzuGXVRJ+9Os/MtyWrrdLUWnjEs4BawArO56hkttB55w2dErK
         J+TauWM3HwymzxXmo7DiQ9A42ST+R+ZHesio4jdC+bBQgOwVWzhsyi4Vp8Bkb2zWpMsl
         bEGZAqNJsuvNiDrYd6xQlQckLprWYLNH2o6YGhQpQEKjHx1QSz1RYYr5zhUivra3nVZl
         islSdvbVhzPERIcFIF2bm64hXl5QwV9y9khT4Gx+uYXyUm8XlXMBixz4dY4y3bTA+w5t
         7Zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411160; x=1692015960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNrm/+UjyC6jP3361KhAbnju37DBvc3v6PBY22LsM1M=;
        b=CJq+RAJoMWtbBj9BDw84y7BmCDmSmMBlqggdgjiSZCz5upxyoiHKb19sHtdDtcCf37
         S/1WPv6+hOboR2nYZCjtmeqIxcOqjM9XFAhbwHk5c5bwsoRz/37k7JdJf5/2tdAbdVfW
         0NUPDeXf608adEf5mf5hyAWzA58lH+KTB71Ebe9JeDu7rSFGg2Hp9Ec7x54/fWoAgzIR
         dkmS2vgC6GLFeymFmHX8f/K8eSPjCx5SJFFYxrja96pvKoa/V+3XkAWiYrOqucyJGH54
         HvebEJPtUZFVYFTxRqd6JGz5rw0IgFz16zXNJ7I5dJ8lHo6PWoZa/Vx/UHEBPXAgfraJ
         LE2Q==
X-Gm-Message-State: AOJu0YytM464bvy5z7vssm/0BkSv00U+8QxO3YQmTKDTon0egoMJfPhz
        WH15MoBXMDskExqbwZzOZFQdqQ==
X-Google-Smtp-Source: AGHT+IF3LxE1BYmeL4wHmCVTiyMcfTz9ktdm8nicKW9MyWNCAQDGZmAAnefpDM5lmUtEPvUN7N7moA==
X-Received: by 2002:a17:90a:6f44:b0:267:fb26:32bd with SMTP id d62-20020a17090a6f4400b00267fb2632bdmr8759628pjk.7.1691411159784;
        Mon, 07 Aug 2023 05:25:59 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a588d00b00267f7405a3csm5925808pji.32.2023.08.07.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:25:59 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 Optimizing veth xsk performance 7/9] sk_buff: add destructor_arg_xsk_pool for zero copy
Date:   Mon,  7 Aug 2023 20:25:45 +0800
Message-Id: <20230807122549.85841-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230807120434.83644-1-huangjie.albert@bytedance.com>
References: <20230807120434.83644-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this member is add for dummy dev to suppot zero copy

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/linux/skbuff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 16a49ba534e4..db999056022e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -592,6 +592,8 @@ struct skb_shared_info {
 	/* Intermediate layers must ensure that destructor_arg
 	 * remains valid until skb destructor */
 	void *		destructor_arg;
+	/* just for dummy device xsk zero copy */
+	void		*destructor_arg_xsk_pool;
 
 	/* must be last field, see pskb_expand_head() */
 	skb_frag_t	frags[MAX_SKB_FRAGS];
-- 
2.20.1

