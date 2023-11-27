Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B02D7FA78D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjK0RJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbjK0RI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:08:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C9FD4B;
        Mon, 27 Nov 2023 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z3F6jPflKA7CV9g/z0Zysna6Er1+ye9+ehS/jCO/u4o=; b=fEADOI60am2EtmgBMr4NHsf+CQ
        D6KT4KK0fLG/Jd21lGQdivwm6oKcmRDEBg6RE2iezvel/kA1Z6nOuxlPPIo24z85kaJNpPr8G2xBf
        Ci7FiLFFafGhSadep+fLJUwuEN0CSb28b7DjZ0lNiITKWWlM+2uoJ7VRkbm34pgfSGdFCKva/idGn
        g6EA+LIvvbBpTiyda3n/vu93lUzg2mvkUnzKl2FOoxs6DKm8RCehzQdso3Ce6nkjUk2GyUooobm9R
        FH7Gfih40SyUZ+W1SaMzndW3kcynMVC8yU7A9PnXJ3PLQ/PE5F2ZAjAN+DXg1CRNAA1Zrf6+r+Afc
        YcJzLnMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r7f5i-00BZzD-3Q; Mon, 27 Nov 2023 17:08:14 +0000
Date:   Mon, 27 Nov 2023 17:08:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] nilfs2: move page release outside of
 nilfs_delete_entry and nilfs_set_link
Message-ID: <ZWTM/tns2JTd1YrQ@casper.infradead.org>
References: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
 <20231127143036.2425-2-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127143036.2425-2-konishi.ryusuke@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:30:20PM +0900, Ryusuke Konishi wrote:
> In a few directory operations, the call to nilfs_put_page() for a page
> obtained using nilfs_find_entry() or nilfs_dotdot() is hidden in
> nilfs_set_link() and nilfs_delete_entry(), making it difficult to track
> page release and preventing change of its call position.
> 
> By moving nilfs_put_page() out of these functions, this makes the page
> get/put correspondence clearer and makes it easier to swap
> nilfs_put_page() calls (and kunmap calls within them) when modifying
> multiple directory entries simultaneously in nilfs_rename().
> 
> Also, update comments for nilfs_set_link() and nilfs_delete_entry() to
> reflect changes in their behavior.
> 
> To make nilfs_put_page() visible from namei.c, this moves its definition
> to nilfs.h and replaces existing equivalents to use it, but the exposure
> of that definition is temporary and will be removed on a later
> kmap -> kmap_local conversion.
> 
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>

Ah; I see.  This makes it more like ext2, so I approve!

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
