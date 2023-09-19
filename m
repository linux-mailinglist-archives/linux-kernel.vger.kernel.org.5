Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FE07A6B49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjISTPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjISTPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:15:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4829D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mtuH2w3GgKbuTZlNeOSy72cGHogSsKnbkktpBiLKKzQ=; b=WPBKNjv+cN0N06hRNxRWfKuikF
        MeTj9F0doLhLJAMbL+0JKSgbX02n3Z4uzWUTW8pymxXwNYU+JrbYNhNK3KBCfea85Sleu4J1qv2s7
        +7q6WEFM3IFN1rz1pchFHlt/Rxl7wimI5+hxLjAAkU0dcuvuoy86DNOc1I56vK7DVpg97On1atJWo
        JTJ+a40iN4Av25ZvSc8CG9k+3m38X6LgUOT9W2xV6wQisahd88K4lCnTTBHLKMH3hMJLsOZQ69j2m
        QM/CP6tFYeVy2e84YyZ+7KsyHj5s45XNqG9NHNTCHERay5zlmU1EdfakUC5d8HKCRMqbIEBoVpZWl
        u6IffTNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qigBt-001KcU-F0; Tue, 19 Sep 2023 19:15:21 +0000
Date:   Tue, 19 Sep 2023 20:15:21 +0100
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
Message-ID: <ZQnzSQzspy6kejo4@casper.infradead.org>
References: <4857570.31r3eYUQgx@natalenko.name>
 <6287208.lOV4Wx5bFT@natalenko.name>
 <ZQnBrLCPnZfG0A1s@casper.infradead.org>
 <2554845.iZASKD2KPV@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2554845.iZASKD2KPV@natalenko.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 08:11:47PM +0200, Oleksandr Natalenko wrote:
> I can confirm this one fixes the issue for me on T460s laptop. Thank you!

Yay!

> Should you submit it, please add:
> 
> Fixes: 0b62af28f2 ("i915: convert shmem_sg_free_table() to use a folio_batch")

Thanks for collecting all these; you're making my life really easy.
One minor point is that the standard format for Fixes: is 12 characters,
not 10.  eg,

Documentation/process/5.Posting.rst:    Fixes: 1f2e3d4c5b6a ("The first line of the commit specified by the first 12 characters of its SHA-1 ID")

I have this in my .gitconfig:

[pretty]
        fixes = Fixes: %h (\"%s\")

and in .git/config,

[core]
        abbrev = 12

I'm working on the commit message now.
