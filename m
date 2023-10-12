Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36A37C7771
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbjJLTyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344135AbjJLTyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:54:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3150D9;
        Thu, 12 Oct 2023 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ctit0g3xmBxqIlEE5heLhfikUMFekXqmU9Lrzt91HNc=; b=FF4MctXiCN19+WdsrcaqnDJjY7
        q7kfn9N9cNxkAnbt6SSwHCHaaaT814w/gMu0ManCBR6ur6Ow3wnKbodDFWPUMm/DIJOp1v7e7WppC
        EGbQILu1QwUXE7C9Ddeg6W8EjP5O1CL00M2EWB5Pi4pXyXG4gI/7KIz3mUvCdME6bbfbEhoPobSz/
        pxNwKSQpdsNE2XoXlyHgaYewbOf2tL6Rj7ZMgwIyMMVwkO7NKWX2xxijpI1eJbLtxuZ9DLm+0Xol4
        Ju/yceufWyjpBoJ83wKe+vfPoOHVccvEtt8rDBfP4A4pYw1/+Ng2kcZWGqEohJHzhJvmNtWUYgt33
        /j4PdAKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qr1lA-001BSV-AV; Thu, 12 Oct 2023 19:54:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-sparc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Erhard Furtner <erhard_f@mailbox.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 0/2] Allow nesting of lazy MMU mode
Date:   Thu, 12 Oct 2023 20:54:13 +0100
Message-Id: <20231012195415.282357-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Woodhouse reported that we now nest calls to
arch_enter_lazy_mmu_mode().  That was inadvertent, but in principle we
should allow it.  On further investigation, Juergen already fixed it
for Xen, but didn't tell anyone.  Fix it for Sparc & PowerPC too.
This may or may not help fix the problem that Erhard reported.

Matthew Wilcox (Oracle) (2):
  powerpc: Allow nesting of lazy MMU mode
  sparc: Allow nesting of lazy MMU mode

 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h | 5 ++---
 arch/sparc/mm/tlb.c                                | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.40.1

