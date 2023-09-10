Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD2799C5B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbjIJDCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjIJDCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:02:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B384FFE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 20:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BDaxoltn3/UZiOrwW4Wv/EpuuPmh9gcWTTnPbzfAnLs=; b=hDFo2iqpTUgigrRKVdsPNJTzIG
        2fQPelSUwOxxNzBfKNaOgBo89JptFra0YyvK91cc/0Ff2LGvtUMTl+MCPYLNZj1MS7uR6aMNcpkCe
        1o1xwlpJv/vAnlBaexk0EOaIndxYXrDiRbmEaPnzGkGjWa1ToNPZTwE4wBXo/tAlg3dp6PwDZlI8f
        KPYsk7C6KUnBqgMOYa0ttSGyWUmpfyzHbGB6+O4vOjD2VsDlYAXpoTL8C93E5dwZmFmGdZJW7WQNu
        QN1D2xHDZKswW7TEnfysJY8BB9+49cCt7GL8GWEc+zYhHNVBmhvE6W0USvjmJxH71628iGilQMVAE
        wIyOAgiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfAiW-009vBp-Js; Sun, 10 Sep 2023 03:02:32 +0000
Date:   Sun, 10 Sep 2023 04:02:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, fengwei.yin@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Message-ID: <ZP0xyFnnghM42GcW@casper.infradead.org>
References: <000000000000d099fa0604f03351@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d099fa0604f03351@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 10:12:48AM -0700, syzbot wrote:
> commit 617c28ecab22d98a3809370eb6cb50fa24b7bfe1
> Author: Yin Fengwei <fengwei.yin@intel.com>
> Date:   Wed Aug 2 15:14:05 2023 +0000
> 
>     filemap: batch PTE mappings

Hmm ... I don't know if this is the bug, but ...

#syz test

diff --git a/mm/filemap.c b/mm/filemap.c
index 582f5317ff71..580d0b2b1a7c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3506,7 +3506,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 		if (count) {
 			set_pte_range(vmf, folio, page, count, addr);
 			folio_ref_add(folio, count);
-			if (in_range(vmf->address, addr, count))
+			if (in_range(vmf->address, addr, count * PAGE_SIZE))
 				ret = VM_FAULT_NOPAGE;
 		}
 
@@ -3520,7 +3520,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	if (count) {
 		set_pte_range(vmf, folio, page, count, addr);
 		folio_ref_add(folio, count);
-		if (in_range(vmf->address, addr, count))
+		if (in_range(vmf->address, addr, count * PAGE_SIZE))
 			ret = VM_FAULT_NOPAGE;
 	}
 

