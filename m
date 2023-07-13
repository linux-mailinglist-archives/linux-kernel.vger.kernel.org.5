Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9028751E61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjGMKHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjGMKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:06:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3E72D5B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:06:22 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1qy405w8zBJk45
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 18:06:20 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689242779; x=1691834780; bh=ncUx3bKyS7035EAFy8RC7xO/6X+
        epe2D4nv1czWvXSQ=; b=ue0HLEeWvv8fuyLGX513zfZgUo902qQiUxvZy/N5Z04
        U9zvfjxOKoTV1FAWkhNOq4qXBfwSLe57CjFOa2PoRIRowL6kVcVrdxsyJ4xN+FGy
        eJiakKn/X7irY7OErRS2fur2csjUmolBnRfjCjOOVV7mNzKY2Z+wg6Hd58wg6bUz
        05kwJpfg9bs/jdBtxME3BhNpWNYnSyicfhy6Gq4HmawgIfL1NtD5qGtrxTr2vtwZ
        FngWF41NLhT5LsOkqzvkpCYOyq1zKAkTGmfYByNjvOkdzuQvetsHEhHTj5E6aWvq
        hc8RYkk0s6X4+7TGhIv6MA/ulDli0Hlx8aAArq7fFqw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H53y4JKs0BYL for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 18:06:19 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1qy35WxVzBJ96K;
        Thu, 13 Jul 2023 18:06:19 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 18:06:15 +0800
From:   hanyu001@208suo.com
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] arm: mm: replace snprintf in show functions with
 sysfs_emit
In-Reply-To: <tencent_EFB5DEE75502CBD51C95CFE33D443DB41608@qq.com>
References: <tencent_EFB5DEE75502CBD51C95CFE33D443DB41608@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <72204230a061f7d5bf19f09d524203ce@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show 
functions.

Fix the coccicheck warning:
WARNING: use scnprintf or sprintf.

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
