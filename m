Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7E7E2FD1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjKFW1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjKFW1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:27:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABDAD71;
        Mon,  6 Nov 2023 14:27:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E783C433C8;
        Mon,  6 Nov 2023 22:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699309625;
        bh=OsFOBVxFJvsI/uYfcFoJ/iuijJol3ip7nWPD89kIj7w=;
        h=Date:From:To:Cc:Subject:From;
        b=LJNtc0SCBRgrlXe9i7WinH43s6BN62vqpq0jBsRmbjYjUQ10dmyFxffqoAkOPTujA
         x9KpU3bL4vQxmAna3pwHcrNu4HyqNKvCBuZATQPM/zJdE8RhfVVKfsmdRxyprCCIwW
         zpUCgsSkexes4U7+l8Ws3DkuMD16cA+R/ddC14mmV8j9xLCH8ed/6DZOgQUgVpS169
         RJPGeVn3NuceU8OKi1EnDMszJ3YqD5Zxd2zu5hP+/hv1T94Jb6YIVEKuFYD/5NuCZg
         DcdWRXPRY7Iigop7zvgsz1pv3Z3uScg25tF52dNbpLk1QtA5Kjg6qpkBaQ32j8CVLr
         KSlPEjWXmQEiQ==
Date:   Mon, 6 Nov 2023 16:27:02 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] bcachefs: Use DECLARE_FLEX_ARRAY() helper and fix
 multiple -Warray-bounds warnings
Message-ID: <ZUloNt0HSulJgZNH@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transform zero-length array `s` into a proper flexible-array
member in `struct snapshot_table` via the DECLARE_FLEX_ARRAY()
helper; and fix tons of the following -Warray-bounds warnings:

fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
fs/bcachefs/snapshot.c:135:70: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]

This helps with the ongoing efforts to globally enable -Warray-bounds.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/bcachefs/subvolume_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/subvolume_types.h b/fs/bcachefs/subvolume_types.h
index 86833445af20..2d2e66a4e468 100644
--- a/fs/bcachefs/subvolume_types.h
+++ b/fs/bcachefs/subvolume_types.h
@@ -20,7 +20,7 @@ struct snapshot_t {
 };
 
 struct snapshot_table {
-	struct snapshot_t	s[0];
+	DECLARE_FLEX_ARRAY(struct snapshot_t, s);
 };
 
 typedef struct {
-- 
2.34.1

