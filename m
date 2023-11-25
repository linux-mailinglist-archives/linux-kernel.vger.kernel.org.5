Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5F7F8F7F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 22:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjKYVd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 16:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYVd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 16:33:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E2FFF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 13:34:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676D7C433C8;
        Sat, 25 Nov 2023 21:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700948043;
        bh=3PJWnPCtKl6PvabTELl1ZdWeU0rVXun3osxxXR2Cv+U=;
        h=Date:From:To:Cc:Subject:From;
        b=bDyPWWzFS+Iqm5I3epM/lwGJhMeAsCxIjgyskeMt0jEuMbAGth62cljmUcdWUx9iM
         JypYTyhoJ6iMx/wb6yoVWr8kUxaw5+e9neIAfbqcI57AFbhhZeoY76b7n/ibdcnwm7
         EzlNYKuzwVi5Eu8L6FPM1BokSaXvhnAwypKVM5RTLy9xuvrzv4Ez0gQXYXz3CgBGN6
         Z93kxIJJyn9HpcCWkX1GK512DeV76WomS7TNJtK6J+3gF9o9x1YKSktir9jHDuEt1R
         DDFvFUP68E+VPd2/l30IqiSlq/mri3uSxbRIMnPfQA8ncyroAzsaB8Vfg7pdyx4C7x
         NvVCTXUDY8IZQ==
Date:   Sat, 25 Nov 2023 15:33:58 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Joey Gouly <joey.gouly@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH] neighbour: Fix __randomize_layout crash in struct neighbour
Message-ID: <ZWJoRsJGnCPdJ3+2@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, one-element and zero-length arrays were treated as true
flexible arrays, even though they are actually "fake" flex arrays.
The __randomize_layout would leave them untouched at the end of the
struct, similarly to proper C99 flex-array members.

However, this approach changed with commit 1ee60356c2dc ("gcc-plugins:
randstruct: Only warn about true flexible arrays"). Now, only C99
flexible-array members will remain untouched at the end of the struct,
while one-element and zero-length arrays will be subject to randomization.

Fix a `__randomize_layout` crash in `struct neighbour` by transforming
zero-length array `primary_key` into a proper C99 flexible-array member.

Fixes: 1ee60356c2dc ("gcc-plugins: randstruct: Only warn about true flexible arrays")
Closes: https://lore.kernel.org/linux-hardening/20231124102458.GB1503258@e124191.cambridge.arm.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/net/neighbour.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 07022bb0d44d..0d28172193fa 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -162,7 +162,7 @@ struct neighbour {
 	struct rcu_head		rcu;
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
-	u8			primary_key[0];
+	u8			primary_key[];
 } __randomize_layout;
 
 struct neigh_ops {
-- 
2.34.1

