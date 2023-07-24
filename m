Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D2E7602F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGXXID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjGXXH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:07:59 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 16:07:57 PDT
Received: from tilde.club (tilde.club [IPv6:2607:5300:204:4340::114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82441700;
        Mon, 24 Jul 2023 16:07:57 -0700 (PDT)
Received: by tilde.club (Postfix, from userid 5616)
        id 443962232AA89; Mon, 24 Jul 2023 22:49:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 443962232AA89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1690238942; bh=QtqSfd3Czt7+G3Jl4KW7N8PcQYi7h4YI/wJv8N7kNV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+2hBvkKZ4PMtjW8+7HZUTVNNYd0tS442Hc1vqsImYc2aWtNKojZjXz8uJ2I3gzg9
         gEO4JDHmZcq/23qFhXX8KkWgCfe1bTUjLfVMZlEp/BgIIP14UbrMcdAKpU3rhqyEvk
         Fe0UkOWAOEU2YknoFcwPdfJ3y68UgdGn819df4CA=
From:   sel4@tilde.club
To:     kees@kernel.org
Cc:     keescook@chromium.org, Brandon Luo <sel4@tilde.club>,
        syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com,
        syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fortify: strnlen: Call fortify_panic() only if the number of bytes read is greater than maxlen
Date:   Mon, 24 Jul 2023 22:48:57 +0000
Message-ID: <20230724224857.2049906-1-sel4@tilde.club>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <4F5F9CC2-803C-4E18-968C-A46B32528F1F@kernel.org>
References: <4F5F9CC2-803C-4E18-968C-A46B32528F1F@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brandon Luo <sel4@tilde.club>

If the number of bytes read is p_size and p_size is less than maxlen,
fortify_panic() will be called incorrectly. Only panic if the number of
bytes read is greater than the minimum of p_size and maxlen since that is
 the argument to __real_strnlen().

Reported-by: syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000d8352e0600c0c804@google.com/

Reported-by: syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000de4c2c0600c02b28@google.com/

Signed-off-by: Brandon Luo <sel4@tilde.club>
---
 include/linux/fortify-string.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index da51a83b2829..cde637f735fe 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -176,8 +176,9 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	}
 
 	/* Do not check characters beyond the end of p. */
-	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
-	if (p_size <= ret && maxlen != ret)
+	maxlen = (maxlen < p_size) ? maxlen : p_size;
+	ret = __real_strnlen(p, maxlen);
+	if (maxlen < ret)
 		fortify_panic(__func__);
 	return ret;
 }
-- 
2.41.0

