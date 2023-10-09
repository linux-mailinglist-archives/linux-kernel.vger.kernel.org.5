Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029A67BED88
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378801AbjJIVq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378682AbjJIVqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:46:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A737EA9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:46:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416FBC433C8;
        Mon,  9 Oct 2023 21:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696887983;
        bh=hOV1TPaxRK6lKBeU8FkupnPDNPfBklnFK2iqPujS67E=;
        h=Date:From:To:Cc:Subject:From;
        b=DbzY3biDgO4mfCIA4qPzupLl+uX9GQuhb11X3aVuywb+Bl5IiANsNQ87Dq6LSmK2G
         N+NCZxZ6Io0Elk4NgT8Tu4MX/Wbc/Zlyh+3yaAk2picUd7NwkzG2epTTBf92SeO7Zn
         H+iQ5RERpBZ9vTb3eOW5ELre2i0mPtM7mA2AkKXShWbogN5G9ftpllRSnRVZDjiX+u
         Z6gHzuzsir9EofnMs4F0iGxxpYt+rRTCLF4k2fA0rHNG8r99DhPaFICqWsqKebAfxR
         EltoEEpdN8DY7vzaPZL+x8Im429T6LSYjnYmhGiioMo6fjMsYsbjcQft4CvhkJ7dap
         wytsDX0E0V9tg==
Date:   Mon, 9 Oct 2023 15:46:18 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: wwan: t7xx: Add __counted_by for struct
 t7xx_fsm_event and use struct_size()
Message-ID: <ZSR0qh5dEV5qoBW4@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 3 ++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 80edb8e75a6a..0bc97430211b 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -445,7 +445,8 @@ int t7xx_fsm_append_event(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_event_state ev
 		return -EINVAL;
 	}
 
-	event = kmalloc(sizeof(*event) + length, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
+	event = kmalloc(struct_size(event, data, length),
+			in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 	if (!event)
 		return -ENOMEM;
 
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.h b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
index b6e76f3903c8..b0b3662ae6d7 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.h
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
@@ -102,7 +102,7 @@ struct t7xx_fsm_event {
 	struct list_head	entry;
 	enum t7xx_fsm_event_state event_id;
 	unsigned int		length;
-	unsigned char		data[];
+	unsigned char		data[] __counted_by(length);
 };
 
 struct t7xx_fsm_command {
-- 
2.34.1

