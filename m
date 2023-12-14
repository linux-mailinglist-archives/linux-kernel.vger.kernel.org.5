Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FDB81315E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjLNNZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573302AbjLNNZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:25:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFA210F;
        Thu, 14 Dec 2023 05:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LREzFOiIV3fjDw34Jpih46a+FLwDl5jbzLHg7aSD75g=; b=msTwUCdvMHb/A7UZZVc4eJcwh8
        Rg0CdLaGQkHv71MLerQ3i16FSDMF/Ai6tyMaxiCaM5BEDwKP4Gqll992eRMuqwt71Jx8zumA+UG4O
        JcRee4RYP9MvyVu4ZEgNZ52P7eIGxvmrnZgzl5zQL79PU85dZ+JTD4ri0YY0nucSK6oyPoHGgBDHe
        Fi5FyVjmUg0asyhaG4lC3vY7TYdptWnvjCi3QFK+FR+q1HfAv8mZ19y8gi+rC/v4buCm9w4OEg1J1
        W5R6hAHk/WC+auX7wcV5GzH24haPOpXdrd/Z3lxW80kvt9ULJoV0bolRfcORbOf69ppwCN5PwrrUe
        3SpeRZiQ==;
Received: from [88.128.88.27] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rDlil-000N0X-2K;
        Thu, 14 Dec 2023 13:25:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: Convert write_cache_pages() to an iterator v2
Date:   Thu, 14 Dec 2023 14:25:33 +0100
Message-Id: <20231214132544.376574-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is basically a report of willy's series of the same name for June.
I picked the lastest version from his (now apparently defunct) git tree,
rebased it to mainline (no coflict, neither for linux-next), reordered
the new fields in struct writeback_control to document what is interface
vs internal, and temporarily dropped the iomap patch due to a conflict
in the VFS tree.

willy: let me know if me reposting it like this is fine, or if you
want me to stop.  I'd just really like to see it merged :)
Note that patch 4 is missing your signoff, so we'd need that before
proceeding anyway.

The original cover letter is below:

Dave Howells doesn't like the indirect function call imposed by
write_cache_pages(), so refactor it into an iterator.  I took the
opportunity to add the ability to iterate a folio_batch without having
an external variable.

This is against next-20230623.  If you try to apply it on top of a tree
which doesn't include the pagevec removal series, IT WILL CRASH because
it won't reinitialise folio_batch->i and the iteration will index out
of bounds.

I have a feeling the 'done' parameter could have a better name, but I
can't think what it might be.

Diffstat:
 include/linux/pagevec.h   |   18 ++
 include/linux/writeback.h |   24 +++
 mm/page-writeback.c       |  313 +++++++++++++++++++++++++---------------------
 3 files changed, 211 insertions(+), 144 deletions(-)
