Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CA777783C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjHJMZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjHJMZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:25:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EC02136
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A8065161
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B8FC433C7;
        Thu, 10 Aug 2023 12:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691670342;
        bh=OloAD6QmGKnXstqvq00Y+1wIzRiY4JGxfjab4MiA+Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UCUG+UaKbFVMZ9rgnD2AroLE1C9PsQ8Q1mvArgMkR/ncOGxxpBmvZ2n55P2acCo+v
         rBlTdyWGsxBjjTwfPMv7TdJpnM9bqYSBI6I19btGwMDjXaNy6gzwdC3HMhPb2hB3Uh
         3TRtdzVVIwWLO+6cz8EJRN95g8zzhn5A4ckz1abhvlZjSS6N725Xo9dch1PNvke7v2
         rJwNyEPg/+fdgzCVxyNi9f7xkqaNvDo3Cz8Xrgr0GGCXssSaIjdnDm0fVm215fSvy4
         3864eGhUBbvDZ4I9ivPs0llLT5X1c5KREGx3hi1kD/C6vTyMlnja8v6a1EiGz2DNwN
         AJlljoPSntnHA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Haoyue Xu <xuhaoyue1@hisilicon.com>,
        Guofeng Yue <yueguofeng@hisilicon.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ethernet: atarilance: mark init function static
Date:   Thu, 10 Aug 2023 14:25:16 +0200
Message-Id: <20230810122528.1220434-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810122528.1220434-1-arnd@kernel.org>
References: <20230810122528.1220434-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The init function is only referenced locally, so it should be static to
avoid this warning:

drivers/net/ethernet/amd/atarilance.c:370:28: error: no previous prototype for 'atarilance_probe' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/amd/atarilance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/atarilance.c b/drivers/net/ethernet/amd/atarilance.c
index ec704222925d8..751454d305c64 100644
--- a/drivers/net/ethernet/amd/atarilance.c
+++ b/drivers/net/ethernet/amd/atarilance.c
@@ -367,7 +367,7 @@ static void *slow_memcpy( void *dst, const void *src, size_t len )
 }
 
 
-struct net_device * __init atarilance_probe(void)
+static struct net_device * __init atarilance_probe(void)
 {
 	int i;
 	static int found;
-- 
2.39.2

