Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC518798EB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344228AbjIHTHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245427AbjIHTHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:07:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78D6A9;
        Fri,  8 Sep 2023 12:07:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BE7C433C8;
        Fri,  8 Sep 2023 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197207;
        bh=vl8D4oQAw0mqM40vnYFpYuKkvUGrTYB/DPxTsm85OTM=;
        h=From:To:Cc:Subject:Date:From;
        b=RfvdqMRXJ1IAH4P1cPqpDoBD3HP+zaaoEgEp99cDBjhzGNTTXk50/EYIHEkLGuBII
         ja2LQMigvknmeby1Hxkdta5cq/SM8kpKQNa1Ove4o7XH01oQ9Qxn4j3HbkSoobxRLi
         FwNAtRFAVcXip97hXhO/XnOJ9OaL3gi3Fm8lwNdGA7aEVC1DCkqRNkaHBUKf/MG300
         ihb1hvMqfE5cjIAuzlbquz9vzcVQ26GfoNFwh8/84VnkFfBSmJkCP+WTS2CHkGJQyW
         s+1BzbXK0poBh0emN+1IP3SKZ5wTbMyAVjCpNASnb5MH79rvGLfyoYWvv6pPaKOupz
         +k2+83nq2eKdQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, edumazet@google.com,
        pabeni@redhat.com, jiri@resnulli.us, jacob.e.keller@intel.com,
        michal.wilczynski@intel.com, shayd@nvidia.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 01/14] devlink: remove reload failed checks in params get/set callbacks
Date:   Fri,  8 Sep 2023 14:19:48 -0400
Message-Id: <20230908182003.3460721-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Pirko <jiri@nvidia.com>

[ Upstream commit 633d76ad01ad0321a1ace3e5cc4fed06753d7ac4 ]

The checks in question were introduced by:
commit 6b4db2e528f6 ("devlink: Fix use-after-free after a failed reload").
That fixed an issue of reload with mlxsw driver.

Back then, that was a valid fix, because there was a limitation
in place that prevented drivers from registering/unregistering params
when devlink instance was registered.

It was possible to do the fix differently by changing drivers to
register/unregister params in appropriate places making sure the ops
operate only on memory which is allocated and initialized. But that,
as a dependency, would require to remove the limitation mentioned above.

Eventually, this limitation was lifted by:
commit 1d18bb1a4ddd ("devlink: allow registering parameters after the instance")

Also, the alternative fix (which also fixed another issue) was done by:
commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").

Therefore, the checks are no longer relevant. Each driver should make
sure to have the params registered only when the memory the ops
are working with is allocated and initialized.

So remove the checks.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/devlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index 00c6944ed6342..38666dde89340 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -3620,7 +3620,7 @@ static int devlink_param_get(struct devlink *devlink,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx)
 {
-	if (!param->get || devlink->reload_failed)
+	if (!param->get)
 		return -EOPNOTSUPP;
 	return param->get(devlink, param->id, ctx);
 }
@@ -3629,7 +3629,7 @@ static int devlink_param_set(struct devlink *devlink,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx)
 {
-	if (!param->set || devlink->reload_failed)
+	if (!param->set)
 		return -EOPNOTSUPP;
 	return param->set(devlink, param->id, ctx);
 }
-- 
2.40.1

