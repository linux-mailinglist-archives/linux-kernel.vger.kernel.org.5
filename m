Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC20765BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjG0S4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjG0S4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:56:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B4BE47
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mftvSSVwDcOe5K0U7hS294Xt1J2OKrrHIwMeWQQT6Ks=; b=tMWDQtiUGJpgDlpF3S7U6o1KY9
        JYKtSpaA183F63l7Kgp9WUflGgKHQZR9uymSpooxgAaPt2EwH5NQQsS/EN4+ejDQamfGmZD8spSVc
        md3Xltr1X1PgyyPqCdsDTcBfqrn0WXLWL5EShzmG/TYuN0jhqzkA/Jhj9qGyMWBBry8k0F8krfgQB
        BqrMp9AKFK6iTDMsl6j/YPUlhqoi2lZzHoFY3K82eJrtEaghXb9xKBWkXZuhVPGEu1+qsu+/f1XbH
        jGtMRQkPl8Wtvf+Omuaq6CydhcPKIgkVLDgkqBnV9ZoECNU6U5pfycWrekk4iIcAOwLx3yn6E1M4S
        Xq+ZQxag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qP69s-007mZw-6K; Thu, 27 Jul 2023 18:56:20 +0000
Date:   Thu, 27 Jul 2023 19:56:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
Message-ID: <ZMK91N6V245iS1qu@casper.infradead.org>
References: <000000000000607ff905ffc8e477@google.com>
 <0000000000000aeb7f06015e5cbd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000aeb7f06015e5cbd@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:57:22PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit a52f58b34afe095ebc5823684eb264404dad6f7b
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Mon Jul 24 18:54:10 2023 +0000
> 
>     mm: handle faults that merely update the accessed bit under the VMA lock
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1783585ea80000
> start commit:   [unknown] 
> git tree:       linux-next

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next next-20230727

diff --git a/mm/memory.c b/mm/memory.c
index 20a2e9ed4aeb..57b271108bdc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3567,6 +3567,12 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		return 0;
 	}
 copy:
+	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma->anon_vma) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		vma_end_read(vmf->vma);
+		return VM_FAULT_RETRY;
+	}
+
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
