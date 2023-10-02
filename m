Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F07B581C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbjJBQOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbjJBQOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:14:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E72B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:14:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA69BC433C7;
        Mon,  2 Oct 2023 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696263271;
        bh=z2fk8YtqV+V10VoyiNxtWZBlzYiMUwqKV/e12y8Dpx0=;
        h=Date:From:To:Cc:Subject:From;
        b=GbwsDYRm+UDgIYREREAZP0jTTQBCIV4CJJHH7wEetdjC+jxysZa0rBH8QzAwzAFwZ
         v7lxoCioIVK/r5zbt1IOpNUptgXs7b3khb6v3d7hOAEGjrnJJ4yvcESo7MtDHwXTDP
         VdkN1SdElzRobMstfIArea3xeRsFkk8p+DIIEkIFGhJ/oqwOipzgGy0oLPoMTcuM8S
         3u67P2ISVpF4mDi/QhrtiiQdxlSnVoCP0S6B8GM98iE4Yse5HtdyRDf1Ljk5oPm8N+
         6V8OiI3ER7Dx0VnidTST7wrI//SY7+4gj1/0fHBNLzT2sbyzOLUScUS1vNSaxojfOO
         bwl94dkd8l2sw==
Date:   Mon, 2 Oct 2023 18:14:26 +0200
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] udf: Fix undefined behavior bug in struct
 udf_fileident_iter
Message-ID: <ZRrsYkKIQe8K6F/t@work>
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

`struct fileIdentDesc` is a flexible structure, which means that it
contains a flexible-array member at the bottom. This could potentially
lead to an overwrite of the objects following `fi` in `struct
udf_fileident_iter` at run-time.

Fix this by placing the declaration of object `fi` at the end of
`struct udf_fileident_iter`.

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Fixes: d16076d9b684 ("udf: New directory iteration code")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/udf/udfdecl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 88692512a466..736f591abc89 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -93,11 +93,11 @@ struct udf_fileident_iter {
 	sector_t loffset;		/* Block offset of 'pos' within above
 					 * extent */
 	struct extent_position epos;	/* Position after the above extent */
-	struct fileIdentDesc fi;	/* Copied directory entry */
 	uint8_t *name;			/* Pointer to entry name */
 	uint8_t *namebuf;		/* Storage for entry name in case
 					 * the name is split between two blocks
 					 */
+	struct fileIdentDesc fi;	/* Copied directory entry */
 };
 
 struct udf_vds_record {
-- 
2.34.1

