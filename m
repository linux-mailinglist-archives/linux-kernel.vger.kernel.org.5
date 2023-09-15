Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498227A27E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbjIOUQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbjIOUP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:15:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F372D67
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:15:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c337aeefbdso23591845ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808912; x=1695413712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DD0PB0X4P5RpnzepdYBK20P6YgyKEeTbO8VvW3SzPE0=;
        b=bj9GANvp8YMMDuzcyMnE4zefjLBFuDD33Jq2y3Phwq7y9R7lwZIczNSCqX4LThWcOJ
         9Khb33XoLSMbUtZdO4wfd5q2Lw9YSy5Df2WV5q8aYt8f0ZwUulF2JbFrucv2Q/e8E689
         +oCl9AIiLj3uEQFpgJZkCDRVN/JRnzz86fj2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808912; x=1695413712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DD0PB0X4P5RpnzepdYBK20P6YgyKEeTbO8VvW3SzPE0=;
        b=RS7DSWI6VLiClN7TPxMEoLC/k2rJb6oxwJPbg4piPDbbvO8CqwU96J6HtOPnYm0fJN
         qCbRhEH6C5uiDyGkZkUCtZOXxZi1UsLw7BAshs7EwaRc4Ok4unqbsq6qh9du+UjPJ5E0
         6uJuufPd9Hrvp30H2WvBDtOxDcDTB5d1z3hbhk2A2XimHUNk6gbtjBpEwgp60UIgAs0J
         34XA3USfaSbSpxW7J3J1SPq3L+9OPdnhquYPXKIhQc6c//u3U0s52915RXF8s62qj2rr
         bzLH0k1zCQWImqRvalE4Ent2sTtYFdO8c0ZYL/n7bfWfskjWNywiGXzpdSEKJI239KNg
         GMBw==
X-Gm-Message-State: AOJu0YznuPtOZ8B9nXQzpHjKnYW9Cr4Le0QehkMrVEShHQ6afAdinCKb
        MgEONULAImcyt4iHtU8EexILGg==
X-Google-Smtp-Source: AGHT+IFr13PLzk1XhNPHi5wQPBvpKN+JrCaS1AIy+WjDkGW+MxaOGCJr4sl9jUsUrz+Gxv7u4wWN9Q==
X-Received: by 2002:a17:902:dac7:b0:1bf:4582:90d with SMTP id q7-20020a170902dac700b001bf4582090dmr3499033plx.46.1694808912608;
        Fri, 15 Sep 2023 13:15:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902b28500b001bb750189desm3860366plr.255.2023.09.15.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:15:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] ceph: Annotate struct ceph_monmap with __counted_by
Date:   Fri, 15 Sep 2023 13:15:10 -0700
Message-Id: <20230915201510.never.365-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263; i=keescook@chromium.org;
 h=from:subject:message-id; bh=459xt744zpKd86AyMgpOkR51nqx31Cb+Bg+uK/o0T7M=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLtO5BRclquwJun9hzXP0EWlZ+GoTdZhGJ3lG
 aGjx/Zz1HyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS7TgAKCRCJcvTf3G3A
 JsmGEACL2A1XKUQWibswLmpq3EltVpG/A8eKgv6ea2LwVOAXy0x4SXG4cHd9Cu0nk/qHBUbSafm
 /LRlD5lO/9C+ATYOdVAn9t0V3au/VIjn21sAW1gMsSMXTEBt4RYva6+8ekRrcCE6zJyxKRcZ8FV
 1TP0oLZ+aZEmq83/afsOUMhAKZ73EU1YJrP2y7qEuhd9AasIKJxUVGM7DVcfrya6r/JmudEniQ/
 slYEzs/iOWTdsEj98u6gHbxVZWi3l4+Z2chqEOmaA47jYTbgLzIPmPYPYPcWB1kjzGWo7sTENSL
 snWzCkLtSJUMzl4dC2P8qEjNTs9Z97Zfy+yyMAePSR5RQLGtIWKXITcZgFCekUIF7vLjevaPaV1
 +LaCKf+sOzA2EWId/vEIG/kxz8h8dHLkrY/QRUmyY/uVFzbwLiOZE7DHTIBX2RKoIZGZEJUzBeR
 WNBaLF/w+lrRYldhG58wFjnEbGbgvVMya2tw0RpvwrbwceT8tHUcSV7MEFW5AduNfn/W80+XcU3
 WDRvge5QEdCUPgTXx/dF6CwMbzLuJM8bVq/JMoDpnZhUBciUwbOy/Mj2aVFC17+IUS36d5chuol
 RHp8X04Aun56SGx2HOl8Y46SbRFH50UsjBo4xWwVLeRAjb1uW/Qjq7Ps3DWovxlJ5RdT/+l0n1p
 IJga5Lu zADa1NNA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ceph_monmap.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: ceph-devel@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/ceph/mon_client.h | 2 +-
 net/ceph/mon_client.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index b658961156a0..7a9a40163c0f 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -19,7 +19,7 @@ struct ceph_monmap {
 	struct ceph_fsid fsid;
 	u32 epoch;
 	u32 num_mon;
-	struct ceph_entity_inst mon_inst[];
+	struct ceph_entity_inst mon_inst[] __counted_by(num_mon);
 };
 
 struct ceph_mon_client;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index faabad6603db..f263f7e91a21 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1136,6 +1136,7 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
 			       GFP_KERNEL);
 	if (!monc->monmap)
 		return -ENOMEM;
+	monc->monmap->num_mon = num_mon;
 
 	for (i = 0; i < num_mon; i++) {
 		struct ceph_entity_inst *inst = &monc->monmap->mon_inst[i];
@@ -1147,7 +1148,6 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
 		inst->name.type = CEPH_ENTITY_TYPE_MON;
 		inst->name.num = cpu_to_le64(i);
 	}
-	monc->monmap->num_mon = num_mon;
 	return 0;
 }
 
-- 
2.34.1

