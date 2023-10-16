Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A13E7CA020
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjJPHLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjJPHLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:11:46 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CF4DC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:11:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdf4752c3cso22695835ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697440305; x=1698045105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YLGlADbqxnWAYarOFVSTI3AQVPhPYl3xWfz7Wse3mA=;
        b=tC4LY86rkiKKI7EWqWKJsM+GwVlT0koeey0qgnh+rLEx0ghY2KWqiaoXsmuQlR7Cer
         /w4edLT7YNscZrKIYirqOHJYjeeAjXU8pgeJGctnszKI5dmYBQ8alBTgjvVTf5rT2aAa
         FereKhnBmdGh5Bxl8Kr0re/2owSQrYwOHapsx0LMMwXzeoX/vdYNhmO3TvirB2OP7ZM1
         thudmuzodLd010dITKY/2ldyztJ0cE/HzNmPD4URCDLleVVVG128nk+EXfhrS4kOAh1u
         OaM/LgHUnq/Oq38lFbTDwk1IO4CjscHjZicfjatgj+jC+b6bseDWUqHCSfMqhluQzmNH
         AACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440305; x=1698045105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YLGlADbqxnWAYarOFVSTI3AQVPhPYl3xWfz7Wse3mA=;
        b=uZD5xOn1MmgIl/sq+tk1Tr1SReVjOppHL5Cs7BDJtisIS+qoriHTdVHJY5njXxthEc
         i062f/ytUkkDjgZEktojl5xNLXUhSYMGChX06GTVDi/P2msXcdmvGAcRE0waQlU2Mou1
         +gkysxOyAZ5gHrMTuD4Xjwxi0haiT6M8F3l08zE0e1+3jdIIFN28MWUfptD6SKxVu/HN
         Hfx0BOeHf2ep9WUseeSh3VmfoHuB9rGZMmdUSQdI8J9c0TIGV00hVWFo1bK/GtRJU3t3
         Sq6klhWq95b/gWsdGAET18wR0w84J+zDmyy6olgxwSJ/ZWLHHPdWUd9P/dpa3tczCTk9
         be9w==
X-Gm-Message-State: AOJu0YwFoA0SgIF9JBAnp3tD3VZaeQLG4XiXQMEP8M6PbyT43D4X5W3l
        oXhdrNCobTXYchKpl9axhaopLg==
X-Google-Smtp-Source: AGHT+IFiZfXVWLAwWVoc8OY1PxB2vC251spWed6E+sNY8zWNiPL3CrOKRidkLrTNfWcwaUPdKETYTg==
X-Received: by 2002:a17:902:ec8c:b0:1c9:b187:4d84 with SMTP id x12-20020a170902ec8c00b001c9b1874d84mr18099691plg.14.1697440304700;
        Mon, 16 Oct 2023 00:11:44 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902778b00b001b9dab0397bsm7770391pll.29.2023.10.16.00.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:11:44 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/4] xen: Make struct privcmd_irqfd's layout architecture independent
Date:   Mon, 16 Oct 2023 12:41:24 +0530
Message-Id: <a4ef0d4a68fc858b34a81fd3f9877d9b6898eb77.1697439990.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1697439990.git.viresh.kumar@linaro.org>
References: <cover.1697439990.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using indirect pointers in an ioctl command argument means that the
layout is architecture specific, in particular we can't use the same one
from 32-bit compat tasks. The general recommendation is to have __u64
members and use u64_to_user_ptr() to access it from the kernel if we are
unable to avoid the pointers altogether.

Fixes: f8941e6c4c71 ("xen: privcmd: Add support for irqfd")
Reported-by: Arnd Bergmann <arnd@kernel.org>
Closes: https://lore.kernel.org/all/268a2031-63b8-4c7d-b1e5-8ab83ca80b4a@app.fastmail.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/xen/privcmd.c      | 2 +-
 include/uapi/xen/privcmd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 120af57999fc..5095bd1abea5 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -935,7 +935,7 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 		return -ENOMEM;
 	dm_op = kirqfd + 1;
 
-	if (copy_from_user(dm_op, irqfd->dm_op, irqfd->size)) {
+	if (copy_from_user(dm_op, u64_to_user_ptr(irqfd->dm_op), irqfd->size)) {
 		ret = -EFAULT;
 		goto error_kfree;
 	}
diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index 375718ba4ab6..b143fafce84d 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -102,7 +102,7 @@ struct privcmd_mmap_resource {
 #define PRIVCMD_IRQFD_FLAG_DEASSIGN (1 << 0)
 
 struct privcmd_irqfd {
-	void __user *dm_op;
+	__u64 dm_op;
 	__u32 size; /* Size of structure pointed by dm_op */
 	__u32 fd;
 	__u32 flags;
-- 
2.31.1.272.g89b43f80a514

