Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB16762FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjGZIYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjGZIWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:22:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1187293
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26814e27a9eso1424339a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690359046; x=1690963846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIXSYqX84CuSmVFU1GzkCcpfMb+I1xPBZiIvC+Oh4rg=;
        b=Xb1tm6ZvxlWzJvqX93uwzRGpsT6PZkoFfclMBbf+N88CMfcBjpcHzy22/Q5ZUk0yeM
         RV0oqyIVZs7GGUtS6u9+54GAmKmAszOPceUrYzTN/evSZuCOY1j1CwfyHGvPZwK53pU2
         7s9z/roqFedDZiv2JrBeiw4ENhNrUyKYhyjZoyd5ua4VqSKD/QkVWdJTEGiLlwYku4+D
         ziMxOcBUKQ5S4q1OVBLPBKmtZsvIlwQAtRpQ9SeL7B+VSGC0WZ81Bc1dctqe9DXiVAaX
         QPuMR+EtJiiNUa4Ac6SX9im67+cS4XerefidUFH3BFkltVwrclITfqsrZQd/2LB18kzE
         RCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359046; x=1690963846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIXSYqX84CuSmVFU1GzkCcpfMb+I1xPBZiIvC+Oh4rg=;
        b=Z7whO3wjFjmhOSFup48HchiHOm1Dx1nVHJu/v/mbDs5+LS0gvHjceokOJ/21O91qGQ
         z2w97bYAbwcR071+OvXHSn7KinzgxSfu/klnHPpMtb680ij6YWpAmBldr0DrE5WS7Itc
         Kf+4V6NIZsLY+gszQkGiYit9eMZnqeJDQ/yx9jciS6AJ9cTJxP0WfPtzVErnug0r/AGx
         qlEt1v/t14ChX8qPakZLD9UHfaoGABZHd13Fn7qYWuu4j0DAUr1XotyrC2rFdW6uH2Ix
         VSJIEtqpbPAbDoXQZTrGO37jNql2bg3A3c7GNhq+2+9s7Tnk1KBkyPlQuwkPbNQjI7IF
         D9SA==
X-Gm-Message-State: ABy/qLaIgQWERJ3BB7UNg3pbjEtq8WgfMZxiLfRQdYuNgKXhUYUNfJ2/
        2Umu1NkrTuQd4toEUy0wuBBGDw==
X-Google-Smtp-Source: APBJJlEHomf/FPMiQ187RwZDxLz38AsGu02tOBeqsit032eLLBERo7jna6rKcRr9i0zDxFPbS5SMig==
X-Received: by 2002:a17:90a:e281:b0:263:5d25:150c with SMTP id d1-20020a17090ae28100b002635d25150cmr974204pjz.29.1690359046624;
        Wed, 26 Jul 2023 01:10:46 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.10.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:10:46 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 10/11] MAINTAINERS: Add co-maintainer for maple tree
Date:   Wed, 26 Jul 2023 16:09:15 +0800
Message-Id: <20230726080916.17454-11-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as co-maintainer for maple tree. I would like to assist
Liam R. Howlett in maintaining maple tree. I will continue to contribute
to the development of maple tree in the future.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc71b815791..8cfedd492509 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12526,6 +12526,7 @@ F:	net/mctp/
 
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
+M:	Peng Zhang <zhangpeng.00@bytedance.com>
 L:	linux-mm@kvack.org
 S:	Supported
 F:	Documentation/core-api/maple_tree.rst
-- 
2.20.1

