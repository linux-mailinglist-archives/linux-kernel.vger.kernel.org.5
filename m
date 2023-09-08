Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E52C798DFE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbjIHSZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344250AbjIHSZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:25:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7924EC6;
        Fri,  8 Sep 2023 11:22:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3964C433AB;
        Fri,  8 Sep 2023 18:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196812;
        bh=pMkhEstu43qy8Que5iiJYlb5UEJhEWzkJHRsgYkoJBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjllrNQh1iCxTMN4/3XaLbr0JsQ3TIrjFRF2CWguysvc5XMIFJc1M5f79XWtb5nGz
         q9rzxgf+Qu1pPFvEl/C2utlgbByLpS2qYgGlYmj+vI78O8M4x9VVPlfaeku9w4OTIn
         HYHL3FFOKQNnEvBnmmJGriOJzTQSPY+O2Zbl9lJhxIqZvWLwWtNkuUOcpfvRXdCo0v
         p2dovlliC91MOyIFoX3Akd5R5k6yKvEyDCFR9nGhSDcSe8Z9QFPkwGk1pQy+A/1gPz
         xOjKGPN51rh3NH7Lye5DIIn70mHt5n/mnloSvi/jSs/s0Ut1YRMb1qNpMk2zIxNKOH
         h3YNgeaAPD90g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, jiri@resnulli.us,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 02/45] devlink: remove reload failed checks in params get/set callbacks
Date:   Fri,  8 Sep 2023 14:12:43 -0400
Message-Id: <20230908181327.3459042-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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
 net/devlink/leftover.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index bfed7929a904f..5277eb3c7d0a1 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -3946,7 +3946,7 @@ static int devlink_param_get(struct devlink *devlink,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx)
 {
-	if (!param->get || devlink->reload_failed)
+	if (!param->get)
 		return -EOPNOTSUPP;
 	return param->get(devlink, param->id, ctx);
 }
@@ -3955,7 +3955,7 @@ static int devlink_param_set(struct devlink *devlink,
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

