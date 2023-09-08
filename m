Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C03798EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbjIHTMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244751AbjIHTMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:12:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAEAE43;
        Fri,  8 Sep 2023 12:12:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFDDC32778;
        Fri,  8 Sep 2023 18:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197036;
        bh=liMbP5RMQjvARMjT61+20zvhPE+McbXIwRmdFix/leU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KShTskjBSEmHNHrVnu90QULPrg5EIsel2UXzzyfZjMKSA5CA3XN661LFfPsUict/5
         yis3u2+gekFo8iaoKCWnqhxxDMTYUmRz6YunVmKD6nIy/Pjy0EujYdyibBfZ8PUTU7
         INCLaxBVzZFQXjbdLFYcxjEt1SSOysjlUiGZHENiTFZ/okAVhUenSRdGdS4iLWyHxu
         0d3aBC3yj//H6G/otagM7OjhXP85RJO2k7FNXhU8IAUIuIkiUiKSG2VVt7iO9C44X9
         aak4P+WCNvngeKMzCSBAmYkmfP+eXmmQD+bNo2aQNhVNOf3XpzogasHildHJrRTF/h
         nAM8hIrB9Bd5g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "GONG, Ruiqi" <gongruiqi1@huawei.com>, GONG@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>, pablo@netfilter.org,
        kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 30/41] netfilter: ebtables: fix fortify warnings in size_entry_mwt()
Date:   Fri,  8 Sep 2023 14:15:44 -0400
Message-Id: <20230908181555.3459640-30-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

[ Upstream commit a7ed3465daa240bdf01a5420f64336fee879c09d ]

When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
warning appears:

In function ‘fortify_memcpy_chk’,
    inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Werror=attribute-warning]
  592 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The compiler is complaining:

memcpy(&offsets[1], &entry->watchers_offset,
                       sizeof(offsets) - sizeof(offsets[0]));

where memcpy reads beyong &entry->watchers_offset to copy
{watchers,target,next}_offset altogether into offsets[]. Silence the
warning by wrapping these three up via struct_group().

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter_bridge/ebtables.h | 14 ++++++++------
 net/bridge/netfilter/ebtables.c                |  3 +--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
index a494cf43a7552..b0caad82b6937 100644
--- a/include/uapi/linux/netfilter_bridge/ebtables.h
+++ b/include/uapi/linux/netfilter_bridge/ebtables.h
@@ -182,12 +182,14 @@ struct ebt_entry {
 	unsigned char sourcemsk[ETH_ALEN];
 	unsigned char destmac[ETH_ALEN];
 	unsigned char destmsk[ETH_ALEN];
-	/* sizeof ebt_entry + matches */
-	unsigned int watchers_offset;
-	/* sizeof ebt_entry + matches + watchers */
-	unsigned int target_offset;
-	/* sizeof ebt_entry + matches + watchers + target */
-	unsigned int next_offset;
+	__struct_group(/* no tag */, offsets, /* no attrs */,
+		/* sizeof ebt_entry + matches */
+		unsigned int watchers_offset;
+		/* sizeof ebt_entry + matches + watchers */
+		unsigned int target_offset;
+		/* sizeof ebt_entry + matches + watchers + target */
+		unsigned int next_offset;
+	);
 	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 757ec46fc45a0..aa23479b20b2a 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2115,8 +2115,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
 		return ret;
 
 	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
-	memcpy(&offsets[1], &entry->watchers_offset,
-			sizeof(offsets) - sizeof(offsets[0]));
+	memcpy(&offsets[1], &entry->offsets, sizeof(entry->offsets));
 
 	if (state->buf_kern_start) {
 		buf_start = state->buf_kern_start + state->buf_kern_offset;
-- 
2.40.1

