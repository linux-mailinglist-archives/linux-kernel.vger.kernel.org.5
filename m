Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E76D7643A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjG0CCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjG0CCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:02:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CEA2139
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bba48b0bd2so2755565ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690423348; x=1691028148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muQcnaFQ3olJEak0NF0aGgOvQeQ9I+wuFJc+tIo+YJ8=;
        b=nwe4+YEyQi6i81SK443t1/Qsn/z061kBXYrrc9wWsp2XZVh+dpDEKIvJbGfFHEWiXc
         GmJE8pnFxzerOhmlcQYicoLDU/VHlfdJNzUyWEIScWyRMQs/BcW00EVDRAHqio49haYu
         pkVKq4DouMbxV41Q7Q/0QecLESEV7VHmJbiM05GoX2JobOurogfXEWv2g2SyU74GttxT
         4iq8xyBJRjjXZKOKATP2yGR+8L7IVJcncsrTSIqWD1NApmUa7M6RCo9hSnR0orjcdQ4K
         SkQl48rDBM3ZlwuZaxAHsHf2EMw1v5DAzH/O+edPlKQboymulN7Z3Gn0T3AXCiFQZXW5
         bAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690423348; x=1691028148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muQcnaFQ3olJEak0NF0aGgOvQeQ9I+wuFJc+tIo+YJ8=;
        b=NTntw00u59STTNvHxzwPlvT4eVh/sBd34phAr5a7IwOzPQdeM7l2tXhzcsyVFnK546
         EXK2KIFOeT3MGcXE3n1tKZ+g5ANwfzYO9AOabwwluePzGo6goX16C1WgpRrtcQzeEFbP
         CIb6oL8noGNI1fDtqbdqzfiTDkPfm9iN7EwvoPwQyRl+F4/GUMUToRIGhxrM4Gp1gcOn
         6eNUl+6+gW2IO9xdQ4Oqygc7ylkHp6fCSYMPywhnQuOWRap3Kle4oSMa/y8IiTiFI288
         mbffTaLX4/evBACwyXDyNq65NjnH2GJi7lfP3qFGmJ7i11/nNsdOz2i+H464heZmKKzC
         5UvQ==
X-Gm-Message-State: ABy/qLawE+4nHnTiI1lqfuVEGX9hW82uCQpb8CdFgGbaOWDvNDKPiZ1v
        QfKe6k6YNCgGKKnRI5wsyg0S8y4CmFX7+g==
X-Google-Smtp-Source: APBJJlFU97S+aZxoKJH6Zgy5xOHnLIpAArSTuQ/RqxKIU+ltvE0/QEIcplLyfATaOYZGgXZqAhCDaQ==
X-Received: by 2002:a17:902:b694:b0:1bb:25bd:d09c with SMTP id c20-20020a170902b69400b001bb25bdd09cmr2723224pls.1.1690423347650;
        Wed, 26 Jul 2023 19:02:27 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902b78400b001bb7a736b46sm230990pls.104.2023.07.26.19.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 19:02:27 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 4/6] bitmap: replace _reg_op(REG_OP_ISFREE) with find_next_bit()
Date:   Wed, 26 Jul 2023 19:02:05 -0700
Message-Id: <20230727020207.36314-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727020207.36314-1-yury.norov@gmail.com>
References: <20230727020207.36314-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_reg_op(REG_OP_ISFREE) can be trivially replaced with find_next_bit().
Drop it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 9be083ad71bf..e0c3bba79181 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1354,7 +1354,7 @@ int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
 	unsigned int nbits = pos + BIT(order);
 
-	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
+	if (find_next_bit(bitmap, pos, nbits) < nbits)
 		return -EBUSY;
 	bitmap_set(bitmap, pos, nbits);
 	return 0;
-- 
2.39.2

