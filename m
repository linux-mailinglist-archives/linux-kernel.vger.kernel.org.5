Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E08F7AF1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjIZRlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjIZRlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:41:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1ECE5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:40:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668C9C433C8;
        Tue, 26 Sep 2023 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695750054;
        bh=qFXQCm4wpcI+yE6fWi21khMp5yp/w8GEwvQJeve1l4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZqrKXQ/29eH0ORwoNR/vO2H3ERnP5dsLMynI8cR7r+gTzuLcsmsy7IZ9wpHf4XbU
         oQ2pdsG+FlHra08pFeMLIv9TtF/pwkpfodsVCrJ3eQDTUgv34dDdAGe27af+etrrVx
         +JvN/rnMKtWyDzHNmgwPT6KbghH+d2Wp9g4Tf6wXd8pIkpM3N2lZM0eHpcvwe0A6vs
         PWp17ammmMcGK3hHt8hfQJE8rWRMTeO6EzjBkUD10DmdSg2qeyTDaclZgmsKMVJTwT
         dMhjd21cdkuFqrsQAEj+VMWPXQGKxIy+V4Hev3PX6TbwAfd8iMpz5FqJSNYJOwmgHS
         5k0HxdNT47OLQ==
Date:   Tue, 26 Sep 2023 10:40:52 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2] f2fs: preload extent_cache for POSIX_FADV_WILLNEED
Message-ID: <ZRMXpLyT7OcQ/jYf@google.com>
References: <20230920004645.1462354-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920004645.1462354-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to preload extent_cache given POSIX_FADV_WILLNEED, which is
more useful for generic usecases.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
  - load it at offset=0 once to avoid reloading for all the calls

 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 09716127e107..161826c6e200 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4858,6 +4858,9 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
 		filp->f_mode &= ~FMODE_RANDOM;
 		spin_unlock(&filp->f_lock);
 		return 0;
+	} else if (advice == POSIX_FADV_WILLNEED && offset == 0) {
+		/* Load extent cache at the first readahead. */
+		f2fs_precache_extents(inode);
 	}
 
 	err = generic_fadvise(filp, offset, len, advice);
-- 
2.42.0.515.g380fc7ccd1-goog
