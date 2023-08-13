Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CBF77A9FF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjHMQ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjHMQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8347E449E;
        Sun, 13 Aug 2023 09:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C56663CDA;
        Sun, 13 Aug 2023 16:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A90C433C8;
        Sun, 13 Aug 2023 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943312;
        bh=/zpPF214Fv93fyfiVP9v3cH37LRpq22auAxVvW+W0QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmlAa+mgFMNrJtMCuyrTOUKyUGV6rWlMvqs9nGinlCbxFR8h8zCz56x8Trm/OCiEM
         SYx+CvpZVqtlULVALSOJj/7KhFFdVrK92OurLHsYbJQP6NZKs9STwaCQy0Cn8JlbgQ
         MuX0Eb5es9tN21UxeEymegDdKhL3JqYQKPS0qtU6Ta06druGzCleVHRaDqOQsK7KVf
         hP7m0+fNFabYEZ/i5ddaxfAwVn5E6RGkapFlqNBMITEZJhEarcAdzGNkkpjUStOsQQ
         tAkh6TaXb1E1H+CxuRZoh2guTzBTdsbg7TxEYQdkQA4SQyBHvuq1D473OIY6tE+TYv
         lxq5Q0vog66gQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Winston Wen <wentao@uniontech.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paulo Alcantara <pc@manguebit.com>,
        Christian Brauner <brauner@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 7/9] fs/nls: make load_nls() take a const parameter
Date:   Sun, 13 Aug 2023 12:14:25 -0400
Message-Id: <20230813161427.1089101-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813161427.1089101-1-sashal@kernel.org>
References: <20230813161427.1089101-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.322
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Winston Wen <wentao@uniontech.com>

[ Upstream commit c1ed39ec116272935528ca9b348b8ee79b0791da ]

load_nls() take a char * parameter, use it to find nls module in list or
construct the module name to load it.

This change make load_nls() take a const parameter, so we don't need do
some cast like this:

        ses->local_nls = load_nls((char *)ctx->local_nls->charset);

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Winston Wen <wentao@uniontech.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nls/nls_base.c   | 4 ++--
 include/linux/nls.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 52ccd34b1e792..a026dbd3593f6 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -272,7 +272,7 @@ int unregister_nls(struct nls_table * nls)
 	return -EINVAL;
 }
 
-static struct nls_table *find_nls(char *charset)
+static struct nls_table *find_nls(const char *charset)
 {
 	struct nls_table *nls;
 	spin_lock(&nls_lock);
@@ -288,7 +288,7 @@ static struct nls_table *find_nls(char *charset)
 	return nls;
 }
 
-struct nls_table *load_nls(char *charset)
+struct nls_table *load_nls(const char *charset)
 {
 	return try_then_request_module(find_nls(charset), "nls_%s", charset);
 }
diff --git a/include/linux/nls.h b/include/linux/nls.h
index 499e486b3722d..e0bf8367b274a 100644
--- a/include/linux/nls.h
+++ b/include/linux/nls.h
@@ -47,7 +47,7 @@ enum utf16_endian {
 /* nls_base.c */
 extern int __register_nls(struct nls_table *, struct module *);
 extern int unregister_nls(struct nls_table *);
-extern struct nls_table *load_nls(char *);
+extern struct nls_table *load_nls(const char *charset);
 extern void unload_nls(struct nls_table *);
 extern struct nls_table *load_nls_default(void);
 #define register_nls(nls) __register_nls((nls), THIS_MODULE)
-- 
2.40.1

