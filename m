Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68A775A7E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjGTHf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGTHfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:35:25 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60721BC0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:35:23 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R64Gb3hvrzBRDsR
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:35:19 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689838519; x=1692430520; bh=1iZb7zRA8PkkBk45qpdnV0JsWhC
        I8t4li5D97yw5kxA=; b=H+z2ERjQlyQONBYnelCkdUXHQJDLKNgXAcnVQ4O0m7A
        d9U42ufB7dgcbtp2txb4hOfpB/O6APt0vdq9ZFuqktN0+whBcpsUtW1mUXdcc+7G
        hGFBgf4Mf32MBGteMAcxVhgN8r+odFfoLZhineG31hXTW2vafMpvw5XMVxnxtKYj
        u/2jEYkY3/R875tg8S27DsAbeO/isxuqJ8vY3CbXeJh5mSAT/Wm+H42CkgPWhbBl
        HBcZcStePOSVnYlzHcpqri0BqsEY4KUe6E+I1xEMyO5IrbnunRriQSrVKzBmEowY
        FQlW7nc2ayrQcYnS739WW3zzUcgAnphSRGTpy5iXFxQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lWUJIvI0JzgI for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 15:35:19 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R64Gb2794zBRDs1;
        Thu, 20 Jul 2023 15:35:19 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 15:35:19 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: fix application of sizeof to pointer
In-Reply-To: <20230720073355.3196-1-xujianghui@cdjrlc.com>
References: <20230720073355.3196-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <442918910b90b9a8e2e5f8a3874fdb44@208suo.com>
X-Sender: sunran001@208suo.com
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

The coccinelle check report:
./drivers/scsi/csiostor/csio_mb.c:1554:46-52: ERROR: application
of sizeof to pointer

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/i915/i915_syncmap.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_syncmap.c 
b/drivers/gpu/drm/i915/i915_syncmap.c
index 60404dbb2e9f..4eeaf12be72d 100644
--- a/drivers/gpu/drm/i915/i915_syncmap.c
+++ b/drivers/gpu/drm/i915/i915_syncmap.c
@@ -282,7 +282,7 @@ static noinline int __sync_set(struct i915_syncmap 
**root, u64 id, u32 seqno)
  			unsigned int above;

  			/* Insert a join above the current layer */
-			next = kzalloc(sizeof(*next) + KSYNCMAP * sizeof(next),
+			next = kzalloc(sizeof(*next) + KSYNCMAP * sizeof(*next),
  				       GFP_KERNEL);
  			if (unlikely(!next))
  				return -ENOMEM;
