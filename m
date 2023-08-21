Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583D47835F9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjHUWwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHUWwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:52:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9527B11C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:52:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe655796faso5909379e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692658320; x=1693263120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dE6nYqHEQ+L2sVPS8kGSIPJdfk2Hjn75SWNwK5Pro0=;
        b=Dg76P64PwO3nG6/UvR3SJ2crar4x0BoHHXHT2WzLVI3B0KfOR0p7iPifmdvowi0DTM
         kTv+5YaHGnFjCRJDRT2wt548tL4R+2HVl1bW0VQULNYNbtlYc3k8kiymEvXSA0NcfLzu
         gM2zTb4ro68+7meBHP0IJqjDly6p71vXC27Rvst5r9iRtqpmzOGLMyKGu5JD1IP0pKMh
         u/22droJ8Jg+oUV9vzcW5LsYXaR8XaWEInDN6qFsu9GMOueLm9+9w4yT52Xc8xOcVl9Z
         ZH35XxNb/plUC7GykePEH8hnYujRj8idtY7aYXibLp9hEpPrdDKVaL0ye9TDF+W/+zv0
         eDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692658320; x=1693263120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dE6nYqHEQ+L2sVPS8kGSIPJdfk2Hjn75SWNwK5Pro0=;
        b=Qd1ZkocTRHxocoZqPabGIE6HS3Wxbo68t+ZaRtKCtYedmoWZTx2DtYUPBgOsH4rM1d
         4vDLa+jAZ2bNBpAVVzg0vfmu7scEubOxIU5DVZUlMgSv8S4ol8CuDx4bqVU5z/wl3pjx
         P7WdAnohAyAdFloyWYeqL2cZn+F71/4KrB+ChLYBvvfYJP7lTUUQ5y01IPO8me1+Wbzc
         FsQwX++93tyASUgOkjyIo6nU8DbayxVoyFKsBkpEnTWEd3kmEX6cZsT+627Gv6lHA3s4
         wQMXluVEha0mDUfE0BjzSkifv4if2aSadet4qj52hToVoQTNkxU8RtCZiiCl0ocYjqr7
         lhBw==
X-Gm-Message-State: AOJu0YyKV6I/uUHi5hXDmj9Hdqf4e51qbnfPj7PNaJHXPopmJ8z1QgIJ
        qBlrWbYHKA/CnLn3MSgePCU=
X-Google-Smtp-Source: AGHT+IGZd1jrqEw1dVkjrAJ/bDRy2K3+CfKx1zY6ZqCcI5cvFFx5BK1x2jeM2iJezypWpGy8Oc/erg==
X-Received: by 2002:a05:6512:1186:b0:4f8:752f:3722 with SMTP id g6-20020a056512118600b004f8752f3722mr5028337lfr.5.1692658319459;
        Mon, 21 Aug 2023 15:51:59 -0700 (PDT)
Received: from f.. (cst-prg-85-121.cust.vodafone.cz. [46.135.85.121])
        by smtp.gmail.com with ESMTPSA id i22-20020a170906445600b009937dbabbdasm7144044ejp.217.2023.08.21.15.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:51:58 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] maple_tree: shrink struct maple_tree from 24 to 16 bytes on LP64
Date:   Tue, 22 Aug 2023 00:51:45 +0200
Message-Id: <20230821225145.2169848-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

by plugging a padding hole.

[sounds like an obvious thing to do, am I missing something?]

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/maple_tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 295548cca8b3..5bdd3ce34cb9 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -212,8 +212,8 @@ struct maple_tree {
 		spinlock_t	ma_lock;
 		lockdep_map_p	ma_external_lock;
 	};
-	void __rcu      *ma_root;
 	unsigned int	ma_flags;
+	void __rcu      *ma_root;
 };
 
 /**
-- 
2.39.2

