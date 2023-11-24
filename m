Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B07F6C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjKXGKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjKXGJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:09:43 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B2719B9;
        Thu, 23 Nov 2023 22:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Q9X3xgtg/XP2tqHjPVSI8SGKsJDTk1SufhPE4ojFnAg=; b=N2Pdj2k2ZjGr/gAcl9j3TTB4Eh
        e+TxRob6A3skYTInmQxQfpvzQJ+CI860MBRvUXt6YeA4lh4PRt48rIujQ+vFur4iq5th2DAHXQGWB
        bMkilc8khBMAW4NvpFVQs2roMlulq1V6UZd06cDDcsBm/i3NwvHaymzPHTtDOWGmywRteoYWNN/jG
        Au98BB2XxjpvdP9WoJI4GxxJrLfoXX8O/iXEmOpfnR3Ri8+C0cKMpfdUXqvpllGRnS0Gx05wqRy1J
        C95+ozK6Ac4hRVKK2YjxW/hYWloDYyyUktNiost976oa6cQQ1Wl22c99pftAyzTNDxfjSTK7CjE7D
        HXFFGkUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PKu-002Q0Q-31;
        Fri, 24 Nov 2023 06:06:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/20] struct dentry: get rid of randomize_layout idiocy
Date:   Fri, 24 Nov 2023 06:06:27 +0000
Message-Id: <20231124060644.576611-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is beyond ridiculous.  There is a reason why that thing is
cacheline-aligned...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/dcache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 3da2f0545d5d..1d9f7f132055 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -111,7 +111,7 @@ struct dentry {
 		struct hlist_bl_node d_in_lookup_hash;	/* only for in-lookup ones */
 	 	struct rcu_head d_rcu;
 	} d_u;
-} __randomize_layout;
+};
 
 /*
  * dentry->d_lock spinlock nesting subclasses:
-- 
2.39.2

