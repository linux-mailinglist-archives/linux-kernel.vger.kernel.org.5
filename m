Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EB07FA793
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjK0RJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbjK0RJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:09:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131661B5;
        Mon, 27 Nov 2023 09:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P99EmKb4CapbHLKU/m7jH61AXQCv185cerJCelU8Tkc=; b=bh1p6YKUVaMZU1UXxX75PJ5pJd
        Kpt4PCHwleFCJKWQvMAJnka35xkf8igrqA7udG64iX5akAd7ewYwNVf8DIa46ttmKkubyREJEEqsa
        APaHcb1jLHmtSoBgNafcfPrA5tKj0xujCw7C5k8lYJvkLnnqxRacT0rHL1LWEpWhKyeacOpxjCjlv
        Gbri0WJTkS92HNMGbEview6G8gs+nbJILS3r3BqxSbOskP57tCdPTJY0wi7KO2Sc1NUCRcPuw9sQn
        Ht+PqBy2Xo/mXg7vwW+TwWYAz1EDrYlhCugbdQVAn+AcE/KRcKlgR5ZfxSl4ZZCXPlH6R5EXOQ+Wb
        5JWsZefA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r7f6Q-00Ba0a-QH; Mon, 27 Nov 2023 17:08:58 +0000
Date:   Mon, 27 Nov 2023 17:08:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] nilfs2: eliminate staggered calls to kunmap in
 nilfs_rename
Message-ID: <ZWTNKhFukc+ZxRJA@casper.infradead.org>
References: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
 <20231127143036.2425-3-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127143036.2425-3-konishi.ryusuke@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:30:21PM +0900, Ryusuke Konishi wrote:
> In nilfs_rename(), calls to nilfs_put_page() to release pages obtained
> with nilfs_find_entry() or nilfs_dotdot() are alternated in the normal
> path.
> 
> When replacing the kernel memory mapping method from kmap to
> kmap_local_{page,folio}, this violates the constraint on the calling
> order of kunmap_local().
> 
> Swap the order of nilfs_put_page calls where the kmap sections of
> multiple pages overlap so that they are nested, allowing direct
> replacement of nilfs_put_page() -> unmap_and_put_page().
> 
> Without this reordering, that replacement will cause a kernel WARNING
> in kunmap_local_indexed() on architectures with high memory mapping.
> 
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks for catching this!

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
