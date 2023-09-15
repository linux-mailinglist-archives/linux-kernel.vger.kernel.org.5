Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B407A267C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbjIOSq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbjIOSp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:45:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936D52D5F;
        Fri, 15 Sep 2023 11:43:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BA0C433C7;
        Fri, 15 Sep 2023 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694803346;
        bh=gNFALD/z17jDo7dWYiHKFKrb9ITT5wkuRQ8TLtfc84k=;
        h=Date:From:To:Cc:Subject:From;
        b=XFdl61V6dPWFIZAe1SZcvAqCiTByQo6msIs/RunUOGVbM+9UmWtKYpGeybnSZ8SOf
         XuiSlgD5sCBzwnqHs7ik7/vc5/PTkdlj0EPs8VmgAdpMuq87WmrxvUSxaQxMJH+iaT
         qiJRPa3lgh0bTwDxTfqf3UmfuUA2yjEcq6afHwUcZY2nlqnkgGZ6Vq3J9s4iw0kVpa
         inOeiOkkHnuWQnLsGOlzfTemYM6cdxxwkgNAT12dU+bAf7hl+xs3f21SDfO4ENO9Fu
         eYlxuGC0AAFoNB38MzF0yTAwrmcxgyZuFuSOX5PmOr04cb3YiUORxnc5AqRRUaKlHk
         x17yPmOSkJiuA==
Date:   Fri, 15 Sep 2023 12:43:20 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Peter Stuge <peter@stuge.se>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/gud: Use size_add() in call to struct_size()
Message-ID: <ZQSlyHKPdw/zsy4c@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If, for any reason, the open-coded arithmetic causes a wraparound, the
protection that `struct_size()` adds against potential integer overflows
is defeated. Fix this by hardening call to `struct_size()` with `size_add()`.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/gud/gud_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index d2f199ea3c11..a02f75be81f0 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -503,7 +503,7 @@ int gud_pipe_check(struct drm_simple_display_pipe *pipe,
 		return -ENOENT;
 
 	len = struct_size(req, properties,
-			  GUD_PROPERTIES_MAX_NUM + GUD_CONNECTOR_PROPERTIES_MAX_NUM);
+			  size_add(GUD_PROPERTIES_MAX_NUM, GUD_CONNECTOR_PROPERTIES_MAX_NUM));
 	req = kzalloc(len, GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
-- 
2.34.1

