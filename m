Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940487604C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjGYBhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGYBho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:37:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633341737;
        Mon, 24 Jul 2023 18:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABECB614A0;
        Tue, 25 Jul 2023 01:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A2BC433C7;
        Tue, 25 Jul 2023 01:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690249052;
        bh=56b5kXnejQjCHe2JxyM6/FN8IqjBfg03Kg+93ShB/SM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkywLUpT5IUmYfg5rewkx3z978JM7HselXR+8lyXsG/PnXfRLEAmSjTM1hReDqYZQ
         9dc3lkl/WKKd6WKw5jvvQHfroBXPP0VWBeP/n5KHyYhfAT+8NyDOih24HtUswm6RUc
         4UHlOBcJwEK3KMC/rg9lyU0stJB9AV8H0JL0Rymb8cB9PPAa1cGl61kZ5SLwbKH0Ry
         z+lBBTxgA/T82UAxeEO73nf6VH53eXWplyYJMxxd1hH7HjTq45jyX5A/j679LyR0oH
         6qeTw8CMFjoUauN4IXMytDNyGxbOAyXNFU1fS2FDVrXm5uGb3snWMRUMSdcgB5uH6h
         9ptCSgLHOeLqg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: [PATCH 2/2] selftests/ftrace: Fix to check fprobe event eneblement
Date:   Tue, 25 Jul 2023 10:37:29 +0900
Message-Id: <169024904889.395371.17998733386857387118.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169024903018.395371.1006584451160707296.stgit@devnote2>
References: <169024903018.395371.1006584451160707296.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix to check the availability of fprobe and kprobes for
add_remove_btfarg.tc.
Only if both kprobe and fprobe are not supported, it should return
"unsupported".

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
index b89de1771655..f34b14ef9781 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
@@ -13,7 +13,7 @@ if grep -qF "f[:[<group>/][<event>]] <func-name>[%return] [<args>]" README ; the
   FPROBES=yes
 fi
 
-if [ -z "$KPROBES" -a "$FPROBES" ] ; then
+if [ -z "$KPROBES" -a -z "$FPROBES" ] ; then
   exit_unsupported
 fi
 

