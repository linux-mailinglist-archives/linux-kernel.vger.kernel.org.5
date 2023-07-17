Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65350755B11
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjGQGAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjGQGAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:00:11 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDF6E48
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:00:08 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4BJ15vWrzBHXhP
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:00:01 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689573601; x=1692165602; bh=wcP7lTIf3z3D5ZVu9/IyX5dEDsR
        Reur3RU4MhqU9daU=; b=cTYFRAawJ7t6TaO0wfOAovUxLmAVhGcO7+/Jr7PjuC1
        rvzQpVzwNe5aZiHiMBp6MGkXxE8vwGUAJFzwmDBIRN0B/t7Od7Xn0fLs30KTwaSt
        +pLUKJB2rNybU9t24QgfavNyEFQplNB4r/OiBj7tHE+JJSdgVzKLTQBmdxGABToK
        iT/7+JMPnTP07oaozUn+Y5N+lyC+reZ1TNSOi2lf9RjH0r6ZuZ+sx5yQMwqXvcgU
        q2LxXSLufKvSn55xp8+LPJ6z3AWkOLWqzbeOq67vy2DIRljHpjEuEfxxg0tPHMjm
        FkHqv3o9RuIDtxVpQaJdhy3wR+rGFTOoQHq+i4B2MaQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id p4chhDt4zZL1 for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 14:00:01 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4BJ144FCzBHXgf;
        Mon, 17 Jul 2023 14:00:01 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 14:00:01 +0800
From:   hanyu001@208suo.com
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mm: Convert snprintf to scnprintf
In-Reply-To: <tencent_3CD0B2D4729D1F0BFC550F567E8C8312A50A@qq.com>
References: <tencent_3CD0B2D4729D1F0BFC550F567E8C8312A50A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <0d07bc2edba6e0c8c1cd130366f1b417@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the coccicheck warning:

./arch/arm/mm/cache-l2x0-pmu.c:346:8-16: WARNING: use scnprintf or 
sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  arch/arm/mm/cache-l2x0-pmu.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefdc167a..d20626451a2e 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -343,7 +343,7 @@ static ssize_t l2x0_pmu_event_show(struct device 
*dev,
      struct l2x0_event_attribute *lattr;

      lattr = container_of(attr, typeof(*lattr), attr);
-    return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
+    return scnprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
  }

  static umode_t l2x0_pmu_event_attr_is_visible(struct kobject *kobj,
