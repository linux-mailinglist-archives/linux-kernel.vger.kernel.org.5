Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDEA7A688C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjISQDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjISQDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:03:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF809F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dZMuR0d3fMuzTTg9AbhRGR2xkVbdfI0ojr0EnSeYVZs=; b=nNc6yhOtVNP+puR0lYFU0ZIT0s
        0XPpHQJ/LVJwC13oib4Qqkf3m8XKUagH7maED5JTQb786bFBCmxX3SqbkCk8UK4PZyaiceOf96NLi
        keLbH+TfFQNorG6OTLMcfZCwjxtLeechmefl7gvPQ6XARJjNcMJQPUqrc++9JfWafDIu5gODO+M6o
        ViopTh0QbLShwC3C+onnAmVxezWMNRXpLGEvPi2Wb7JhPwM+fjGtTIJupOd9pWkmeiFACxEQCdqPp
        cxVIwioSzdha0hIz2vp2TFnaGfF8CbCX0AyHBQJ77A5glt5Ty4nGvJfnwrj/pe8HFiSx4yGieBKAs
        l/6a7d2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qidBi-000VvE-KN; Tue, 19 Sep 2023 16:02:58 +0000
Date:   Tue, 19 Sep 2023 17:02:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
        Fei Yang <fei.yang@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [REGRESSION] [BISECTED] Panic in gen8_ggtt_insert_entries() with
 v6.5
Message-ID: <ZQnGMtm7zJ9E9a8R@casper.infradead.org>
References: <4857570.31r3eYUQgx@natalenko.name>
 <6287208.lOV4Wx5bFT@natalenko.name>
 <ZQnBrLCPnZfG0A1s@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQnBrLCPnZfG0A1s@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 04:43:41PM +0100, Matthew Wilcox wrote:
> Could I ask you to try this patch?  I'll follow up with another patch
> later because I think I made another assumption that may not be valid.

Ah, no, never mind.  I thought we could start in the middle of a folio,
but we always start constructing the sg list from index 0 of the file,
so we always start at the first page of a folio.  If this patch solves
your problem, then I think we're done.
