Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DB181206E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442703AbjLMVJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjLMVJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:09:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D516E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:09:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A876C433C8;
        Wed, 13 Dec 2023 21:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1702501764;
        bh=KvJdE+vcgyzrY9CE/Gn1fMHnjGdlBGiiEGOdz1tMHOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TxhwHStiJ6vjUpNeQd6IktbzfLDlYCaZ9vCy/xQL+pIRycRkseI6XOharCy+N6fJs
         q7CdmxfSSbDv+QCOosKIiCRMYeJBWMvhfUsCrxtZLOlUOMUJo8xTDhjTNzGQYY461L
         yi8HAI7M+zYMHUZYf8sVog9ArE3wrFcp0t4lSdn4=
Date:   Wed, 13 Dec 2023 13:09:23 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, willy@infradead.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com,
        stable@vger.kernel.org
Subject: Re: [PATCH V2] maple_tree: do not preallocate nodes for slot stores
Message-Id: <20231213130923.cc00317b4ebab1b0864d8b42@linux-foundation.org>
In-Reply-To: <31d24c29-5b7c-328c-b830-276acab43203@oracle.com>
References: <20231213205058.386589-1-sidhartha.kumar@oracle.com>
        <31d24c29-5b7c-328c-b830-276acab43203@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 13:03:29 -0800 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

> On 12/13/23 12:50 PM, Sidhartha Kumar wrote:
> > mas_preallocate() defaults to requesting 1 node for preallocation and then
> > ,depending on the type of store, will update the request variable. There
> > isn't a check for a slot store type, so slot stores are preallocating the
> > default 1 node. Slot stores do not require any additional nodes, so add a
> > check for the slot store case that will bypass node_count_gfp(). Update
> > the tests to reflect that slot stores do not require allocations.
> > 
> > User visible effects of this bug include increased memory usage from the
> > unneeded node that was allocated.
> > 
> > Fixes: 0b8bb544b1a7 ("maple_tree: update mas_preallocate() testing")
> > Cc: <stable@vger.kernel.org> # 6.6+
> > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > ---
> > v1->v2:
> > 	fix coding style per Matthew and Andrew
> > 	use wr_mas->node_end to fix build error
> > 
> 
> When this is merged to mm-unstable could the following fixlet be applied to be 
> compatible with Liam's series[1]:
> 

Yup, already on it.  Liam's series is now in mm-stable so for now I'll
leave a bisection hole.  Maybe I'll fold it later if an mm-stable
rebase/rebuild is needed,

From: Andrew Morton <akpm@linux-foundation.org>
Subject: lib/maple_tree.c: fix build error due to hotfix alteration
Date: Wed Dec 13 12:59:49 PM PST 2023

Commit 0de56e38b307 ("maple_tree: use maple state end for write
operations") was broken by a later patch "maple_tree: do not preallocate
nodes for slot stores".  But the later patch was scheduled ahead of
0de56e38b307, for 6.7-rc.

This fixlet undoes the damage.

Fixes: 0de56e38b307 ("maple_tree: use maple state end for write operations")
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/maple_tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/maple_tree.c~lib-maple_treec-fix-build-error-due-to-hotfix-alteration
+++ a/lib/maple_tree.c
@@ -5477,7 +5477,7 @@ int mas_preallocate(struct ma_state *mas
 	node_size = mas_wr_new_end(&wr_mas);
 
 	/* Slot store, does not require additional nodes */
-	if (node_size == wr_mas.node_end) {
+	if (node_size == mas->end) {
 		/* reuse node */
 		if (!mt_in_rcu(mas->tree))
 			return 0;
_

