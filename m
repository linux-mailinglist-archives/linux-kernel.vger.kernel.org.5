Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A25755FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGQJuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGQJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:50:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8811A3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:50:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so4066852f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689587408; x=1692179408;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UHlCYgjw3sGv5X4Rh41zT7Cz0UApml3bPiXbTYKgKB4=;
        b=uZn+r1p4QIZuoah4Ce+XfaOMOBX6Cm212+xmfzaNY9nI8ClKQQPurJnYlgHvkb2plk
         LkjcTRNlRA7v7NCsFrWp+bnH+BK8MPMzELnviSYlipTvbJqwcoLxFkYugBaiwDelsHlj
         7CKb5gU9vlyhzAlf4EbGFTIu4SXAA322IHFEYLMfk4WM5TUEZ39i6mTf9tcxXZP7eg5E
         socjfxUGHfJN0z0bTdDTit2Ckx7aMR0BvSQxK6FtRqERMajXK+hZQY3P8e4lR+qZObAc
         WsI2v+K5GMGWY/CyiWrdquwtW5OzYiXDDAL4ewaAsu49fuGY7+dBFM2wllJy9xZdE7t+
         g0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689587408; x=1692179408;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHlCYgjw3sGv5X4Rh41zT7Cz0UApml3bPiXbTYKgKB4=;
        b=UYtYZ7DdvRGBYPG4M7EOZ6FLhlBaU/8IdQJcUkATowRoAgUeAxZk7NXLbnX7ohusOv
         XuKhqeyL+vUSgJTHmJ+ESrC68vPsCWq0lfSBWdYkYwfeMisdtNjWo++cuDZlTv1WrrDE
         Wj9ZmRWY1Tws1xySIO0GoExhZ+ypIEJ7hbCwSzJ2+DG6SOH/9hMkntYbTt3MKujtX0a2
         uAFpDblvNY+WsgTcbMveRgUPz9rKUly58MUOOeWUSC6lPKA/EAj9x3RqQ85VV2kdAjgK
         BInVCKVkf6HuY7onn4pDdZVrKYoQVXAjBuM2afmPna+davOdyscqCtq5s+KUXlWKdC0e
         iUGA==
X-Gm-Message-State: ABy/qLYlcNPyne1nqW7R9bbV4RaxeLwFmzKj1OmIrtseCfXuzgIVp8Aa
        zu8sz3TuDDAHZkPihPBVi4YPLA==
X-Google-Smtp-Source: APBJJlEHj8jCF+PkdN/BQGzBoi07gP3rBR7YQ7C285CjbtyZLwYfRuqMJGOiSRTSk2SWV3gcvBoynA==
X-Received: by 2002:adf:f044:0:b0:313:efed:9162 with SMTP id t4-20020adff044000000b00313efed9162mr8459155wro.59.1689587407918;
        Mon, 17 Jul 2023 02:50:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r7-20020a5d6947000000b00313fd294d6csm19002391wrw.7.2023.07.17.02.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 02:50:06 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:50:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] firewire: core: put GFP_ATOMIC back in fw_node_create()
Message-ID: <e300faf3-ad5c-4702-a022-128c8c983e21@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was recently changed from GFP_ATOMIC to GFP_KERNEL, but it
needs to be GFP_ATOMIC so change it back.  The problematic
call tree is:

fw_core_handle_bus_reset() <- spin_lock_irqsave(&card->lock, flags);
-> build_tree()
   -> fw_node_create() <- sleeping allocation

Fixes: 06f45435d985 ("firewire: core: obsolete usage of GFP_ATOMIC at building node tree")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/firewire/core-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 88466b663482..f40c81534381 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -101,7 +101,7 @@ static struct fw_node *fw_node_create(u32 sid, int port_count, int color)
 {
 	struct fw_node *node;
 
-	node = kzalloc(struct_size(node, ports, port_count), GFP_KERNEL);
+	node = kzalloc(struct_size(node, ports, port_count), GFP_ATOMIC);
 	if (node == NULL)
 		return NULL;
 
-- 
2.39.2

