Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E0C7E2F17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjKFVkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjKFVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:40:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D11BB;
        Mon,  6 Nov 2023 13:40:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F6DC433C7;
        Mon,  6 Nov 2023 21:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699306825;
        bh=+FlwfuDUvVPFaF514DQDx020nBoDR412BR5BhhOaIUU=;
        h=Date:From:To:Cc:Subject:From;
        b=i6oviTFNJJgL/F00kQA4tzkaef5Fij8X9EzWV19SYaqbwwMj2i8HshOtWuNJ8JmFe
         TbNFqqv7X2bwjOjYkj64yT6jfJ4qz6Eei9JM7+cxH6HXRQGahfzG1owbxhgZnH+oBA
         ROZsbQGOFtmGEEmmUHZhgRpdMinJ7IFw1B9J6a/SUPht0bfjsA78aIiga3xEY6BnmV
         dBR32BmRWkmoPiVUYJRLnWA6ePf7AM2b201vNla+z8msEbeEAMxOv8/nH3y0n7Gdc2
         AG0X/gLfyq7DHfU6CVwNp5HFe2VRdreC9c9IWDkGnGiY0AKSNqxHg+9GbGwi//FXTY
         EAtQtVW0bMRLg==
Date:   Mon, 6 Nov 2023 15:40:22 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] bcachefs: Fix multiple -Warray-bounds warnings
Message-ID: <ZUldRv35EXKHAt3L@work>
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

Transform zero-length array `entries` into a proper flexible-array
member in `struct journal_seq_blacklist_table`; and fix the following
-Warray-bounds warnings:

fs/bcachefs/journal_seq_blacklist.c:148:26: warning: array subscript idx is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
fs/bcachefs/journal_seq_blacklist.c:150:30: warning: array subscript idx is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
fs/bcachefs/journal_seq_blacklist.c:154:27: warning: array subscript idx is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
fs/bcachefs/journal_seq_blacklist.c:176:27: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
fs/bcachefs/journal_seq_blacklist.c:177:27: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
fs/bcachefs/journal_seq_blacklist.c:297:34: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
fs/bcachefs/journal_seq_blacklist.c:298:34: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
fs/bcachefs/journal_seq_blacklist.c:300:31: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]

This results in no differences in binary output.

This helps with the ongoing efforts to globally enable -Warray-bounds.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/bcachefs/bcachefs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 53ffa88cae16..e42f2977f7aa 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -612,7 +612,7 @@ struct journal_seq_blacklist_table {
 		u64		start;
 		u64		end;
 		bool		dirty;
-	}			entries[0];
+	}			entries[];
 };
 
 struct journal_keys {
-- 
2.34.1

