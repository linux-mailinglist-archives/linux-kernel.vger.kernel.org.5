Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A2675864A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjGRUua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGRUuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B761BD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22EF560F6B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA3BC433C7;
        Tue, 18 Jul 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689713423;
        bh=U1llKZN9bzeNrf4u+gdKJoyKutM3P61zdD1PaebvrKY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=mv1be18MbNRPYlwTJtC4FF7ZDNN9ZlxlX/kc4sR1PALY9hqAmPATw+pir6oYNSOGH
         iAkvo4d5tsqnzUYwc0XNlyN/jTyzsL1FvDa/GronlzxMce97cPrH/PmifKEqruIi5B
         6bgXHdaFCmKh5m0Kl8T3JUUEQjR6kJ/JV3UakLH/DlObqOqF+oeMTOPSIU/9+uDRM2
         ka09uqYajkzCypQzi4QVIadTRnH7B6zRPLDO2FnD4Sh6sqFRCyxJIWBy7HlrP44XOS
         5t1HVJJYmD5GGW8RA52JTlmLk7NTz4cI8c/cTjbvkUEczIPp/MMUjmVgvb4zT/BIn1
         +vBViqzS/fkhg==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Tue, 18 Jul 2023 20:50:16 +0000
Subject: [PATCH v2 2/4] fs/9p: fix typo in comparison logic for cache mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v2-2-147d6b93f699@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v2-0-147d6b93f699@kernel.org>
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=U1llKZN9bzeNrf4u+gdKJoyKutM3P61zdD1PaebvrKY=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBktvsMiEBMS24QIGDx7amfXvzIA6gDZVIz5JGk1
 9UCcOkz9eeJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLb7DAAKCRCI/9X7Sl//
 mAi9EACZPCaFyixIwaKhfsBISAbZZ7dYCGXgefg/e4EIfgHCR+SMKdoaI7C0+tn4RF2NJQiKz3r
 QhemJUXk9gRiPoCk4ApRcIgNe2XErSs7A+R/i7nFTqsjSwrBWZ0VAE2YDQSQxGD+miOpR9Otzjw
 DCXGlLsRPgm4gCGH/PJMiAjMG3+cvVVvYAUS2ZZfhJLsr4WO1y9lrFGIve+/8UbBP8id3Eq+E8M
 OGY/N9Y20Enm+egiqqJkvCD7zJxIyxn+TzEjZBykD6DsQdKAmTfyyK7cIN2PznCBvsovwixTKKC
 3sxdmbWlPcZh4pT1MiP8Mlq331UzgPAgiaemmYYHhYPa0hk9CLaRuCNYQ2GmXiRZ3KrW16+BEQl
 1hJhEwvvejqMyZdP+jQ7C9+YVGu82rW+/CW4lD3iBLs++Sa2BZvVB1Uf5ma3cg1Ub0Y92hXpcQ3
 EyhpNXUMGlMNixvsOV+ZJYg9chcGY5/nJbvRJcMUoIvPXt47AceelHzLnEyoTDuMfekXJrvDFnb
 bT+eZ/3baos4A2xrlfOxxji8K4qCH78/7O2teLVCKx4iSLdI17uTsRURXHfUxQhmywtJd+wjj/i
 GRD7MJifpXU5dWQ9LKKCuJckjpNrEBJvHCPN2NOFeTyA7obL2svqUW34W+Jiv8B+UI+0q+MNORX
 BJRIshvhPOR1fkw==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be a typo in the comparison statement for the logic
which sets a file's cache mode based on mount flags.

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/fid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 0c51889a60b33..297c2c377e3dd 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -57,7 +57,7 @@ static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
 	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
 		fid->mode |= P9L_DIRECT; /* no read or write cache */
 	} else if ((!(s_cache & CACHE_WRITEBACK)) ||
-				(f_flags & O_DSYNC) | (s_flags & V9FS_SYNC)) {
+				(f_flags & O_DSYNC) || (s_flags & V9FS_SYNC)) {
 		fid->mode |= P9L_NOWRITECACHE;
 	}
 }

-- 
2.39.2

