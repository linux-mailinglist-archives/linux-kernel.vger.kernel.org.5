Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303B775EE97
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjGXJBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjGXJAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:00:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB4F10C7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:00:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35A7360FF8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40843C433C7;
        Mon, 24 Jul 2023 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690189249;
        bh=zu3C9iFBll2v0WdGfx7jp6XrySSQzyIf+EHmsquer/E=;
        h=From:To:Cc:Subject:Date:From;
        b=g1QXd6543W4mZPZh8Ciqd/276N+0FLtV6KrVWBsvENZ5/lWRnL7GyYBjaxxxIvuV7
         xUkmoGHWVIbkH32urpyamGJOkI8coIorpIXeU2LENsMT3TbKsuBJnEgZA0Z3s1G1ho
         aUTWUTqiUJGE3YG4ZnjCmKsub9sqXvi5Dc5TpV95yv0iTJpccNntJ3IfkWL7UUEq4s
         /R9b+WL95ehxHAyU3GfTgn3II4GPUm13fZoh+uxiyKDv/Okaw4gd26NC+6a0FTficH
         LhBqB9bcfdN6u3jppDtGBalA/3t5vXaktF/rcKbwyYGm3V3SbbbeeqFJJMb5IRU6Tj
         LBhiLhFBNp99g==
From:   Ilia Lin <ilia.lin@kernel.org>
To:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com
Subject: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
Date:   Mon, 24 Jul 2023 12:00:44 +0300
Message-Id: <20230724090044.2668064-1-ilia.lin@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If XFRM_OFFLOAD is configured, but XFRM is not, it will cause
compilation error on include xfrm.h:
 C 05:56:39 In file included from /src/linux/kernel_platform/msm-kernel/net/core/sock.c:127:
 C 05:56:39 /src/linux/kernel_platform/msm-kernel/include/net/xfrm.h:1932:30: error: no member named 'xfrm' in 'struct dst_entry'
 C 05:56:39         struct xfrm_state *x = dst->xfrm;
 C 05:56:39                                ~~~  ^

Making the XFRM_OFFLOAD select the XFRM.

Fixes: 48e01e001da31 ("ixgbe/ixgbevf: fix XFRM_ALGO dependency")
Reported-by: Ilia Lin <ilia.lin@kernel.org>
Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
---
 net/xfrm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index 3adf31a83a79a..3fc2c1bcb5bbe 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -10,6 +10,7 @@ config XFRM

 config XFRM_OFFLOAD
 	bool
+	select XFRM

 config XFRM_ALGO
 	tristate
--
2.25.1

