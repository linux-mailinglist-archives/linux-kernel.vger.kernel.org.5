Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C217F8F8C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 22:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjKYVtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 16:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYVtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 16:49:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C15101
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 13:49:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BBFC433C7;
        Sat, 25 Nov 2023 21:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700948956;
        bh=p01SNS2qZBDCVzSPkDLOFpFyded+GzvCX/9pasvl/5c=;
        h=Date:From:To:Cc:Subject:From;
        b=p5EdWPOv9u1qJKMRE6lTDg9F6QiT6VyEGHnF+Dw7bajfbIxE1aBNMa0pu3hCgJeHy
         uO+wXDbs6TC7LsZfDiQK/yGaL77QXcrH0ik5rJdbdFiVnjTTqLKfne2hQcV8UIBQZ3
         1Cp5pPT+FXaP7AgvT7AnRJLgVhz4tQIzFu/X8j7NzTVP9jPKEFjrMgjm53gHDg1xxG
         SV/6GuBLu3j1u9jjN+/yNHvMrU2t3zSHRMHlFgfrm1WvX/C+LsRDKN1hv+TrJ0GHfm
         xnsIBiTzc5m8Nrn9GWPiXQvp89uCxZm00UmC7mMUQI+a8pnSPZOHzlPWgf6LohPEmS
         HFwZaNWeT8Zzg==
Date:   Sat, 25 Nov 2023 15:49:12 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] gcc-plugins: randstruct: Update code comment in
 relayout_struct()
Message-ID: <ZWJr2MWDjXLHE8ap@work>
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

Update code comment to clarify that the only element whose layout is
not randomized is a proper C99 flexible-array member. This update is
complementary to commit 1ee60356c2dc ("gcc-plugins: randstruct: Only
warn about true flexible arrays")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 910bd21d08f4..746ff2d272f2 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -339,8 +339,7 @@ static int relayout_struct(tree type)
 
 	/*
 	 * enforce that we don't randomize the layout of the last
-	 * element of a struct if it's a 0 or 1-length array
-	 * or a proper flexible array
+	 * element of a struct if it's a proper flexible array
 	 */
 	if (is_flexible_array(newtree[num_fields - 1])) {
 		has_flexarray = true;
-- 
2.34.1

