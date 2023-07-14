Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C297530C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjGNE4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjGNE4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:56:35 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259FE2D5F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:56:33 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2K255mDwzBJk54
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:56:29 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689310589; x=1691902590; bh=kH8GnE+sm/V63Y/8cHTnasFldhq
        gzlUbCDGfR2vkAeM=; b=ZeEWpyRWgvhCJoyEQGJITA3WVMyvKmE64MnvzWjMhDZ
        2h4d7zuK2vcpNN5Q08sqsg+suzY9YCIWPSonDwZDjYrCDC5ZOWuaae6DAOfjP0aj
        A22E2WJ59bAQXrYwdrFyucO5E83OEfdkwd2a4YKCWnnKUi3xAtl+S9GG1kqxWt5n
        Yygc137bnX9GyQgEM05T8KqPSB2PGDS1rE3BM84hXoCL+7TqehzSAyjEz/aoYruZ
        vq2UQ2Wa+HzvosRDO24ey+Z6IJFrzP4zGqwZVvfauhVj0BiwHueGcyu6HzM94QF5
        XrdFm8WN2S9rcamYEQt739Okb4VOeZRbeXY3zRxD+nA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yZ3x4ra0qtKh for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 12:56:29 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2K253rp3zBHXhN;
        Fri, 14 Jul 2023 12:56:29 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 12:56:29 +0800
From:   liubin001@208suo.com
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] floppy:ERROR: missing put_device; call of_find_device_by_node
 on line 589, but without a corresponding object release within this function.
 Add the put_device function before return to release memory
In-Reply-To: <tencent_0C9506095848D9427102ED415071D0F3420A@qq.com>
References: <tencent_0C9506095848D9427102ED415071D0F3420A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <0f4dc280605c4700556d88d6f59cd1c4@208suo.com>
X-Sender: liubin001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: LiuBin <liubin001@208suo.com>
---
  arch/sparc/include/asm/floppy_64.h | 1 +
  1 file changed, 1 insertion(+)

diff --git a/arch/sparc/include/asm/floppy_64.h 
b/arch/sparc/include/asm/floppy_64.h
index 070c8c1f5c8f..c4c51f494f25 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -588,6 +588,7 @@ static unsigned long __init sun_floppy_init(void)

          op = of_find_device_by_node(dp);
          if (!op)
+            put_device(op);
              return 0;

          state_prop = of_get_property(op->dev.of_node, "status", NULL);
