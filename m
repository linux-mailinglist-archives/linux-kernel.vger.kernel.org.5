Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872367912A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbjIDHzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351912AbjIDHzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:55:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489BF139
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:54:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E62CF1F894;
        Mon,  4 Sep 2023 07:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693814094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOnx8wPwAU6ZtQY/cwgSOda0bqHjX/X+RJnXB9nkeWQ=;
        b=ZOjnzXSMw1ajlWF/XmhC/3SFT1d5SdS8SQfBbAoVNc+jGOItNFq7LD6Cp6yeh738PYwYEL
        d1jwA9DF774bz2mSjejWdq47ryyxONVwupslsJ4E5wmmhFrxZugad95vC8DeRWDh5rG+KY
        Akf9bDzkvynu2L0S5zPjCnLhehjUUmI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7F1213425;
        Mon,  4 Sep 2023 07:54:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8sy1LU6N9WQ1SgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 04 Sep 2023 07:54:54 +0000
Date:   Mon, 4 Sep 2023 09:54:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm: make __GFP_SKIP_ZERO visible to skip zero operation
Message-ID: <ZPWNTiAxZZh/kzew@dhcp22.suse.cz>
References: <20230831105252.1385911-1-zhaoyang.huang@unisoc.com>
 <ZPCEim0AZG5hTSYH@casper.infradead.org>
 <CAGWkznGAJVZtn49zNHsMAjRSfTRR707QXYY0m8Q+yABTsiig2Q@mail.gmail.com>
 <CAG_fn=VJrO3e9q0M6KA9nopqyDuRO4g7SBak6YptiEvzdE+nkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=VJrO3e9q0M6KA9nopqyDuRO4g7SBak6YptiEvzdE+nkA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-09-23 14:55:17, Alexander Potapenko wrote:
> On Fri, Sep 1, 2023 at 12:29 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > loop alex
> 
> (adding more people who took part in the previous discussions)
> 
> >
> > On Thu, Aug 31, 2023 at 8:16 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Aug 31, 2023 at 06:52:52PM +0800, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > There is no explicit gfp flags to let the allocation skip zero
> > > > operation when CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y. I would like to make
> > > > __GFP_SKIP_ZERO be visible even if kasan is not configured.
> 
> Hi all,
> 
> This is a recurring question, as people keep encountering performance
> problems on systems with init_on_alloc=1
> (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1862822 being
> one of the examples).
> 
> Brad Spengler has also pointed out
> (https://twitter.com/spendergrsec/status/1296461651659694082) that
> there are cases where there is no security vs. performance tradeoff
> (e.g. kmemdup() and kstrdup()).
> 
> An opt-out flag was included in the initial init_on_alloc series, but
> back then Michal Hocko has noted that it might easily get out of
> control: https://patchwork.kernel.org/project/linux-hardening/patch/20190418154208.131118-2-glider@google.com/#22600229.

I still maintain my opinion. I really do not like the idea of mixing
concepts of init_on_alloc (which is pretty much security oriented) and
an opt out flag which bypasses it. Sooner or later this will become an
unreviewable mess so the value of init_on_alloc will become very
dubious.

> Now that init_on_alloc is actually being used by people which may have
> different preferences wrt. security and performance (in the cases
> where this tradeoff exists), we must be very careful with the opt-out
> GFP flag. Not initializing a particular allocation site in the
> upstream kernel will affect every downstream user, and some may
> consider this a security regression.

Fully agreed!

> Another problematic case is an OS vendor mandating init_on_alloc
> everywhere, but a third party driver vendor doing kmalloc(...,
> __GFP_SKIP_ZERO) for their allocations.

Exactly. This allows to sniff into driver unrelated proper and allow a
whole class of isssues.

> So I think a working opt-out scheme for the heap initialization should
> be two-step:
> 1. The code owner may decide that a particular allocation site needs
> an opt-out, and make the upstream code change;
> 2. The OS vendor has the ability to override that decision for the
> kernel they ship without the need to patch the source.

Practically speaking this would require a new mode
init_on_alloc_but_potentially_unsafe

Another option would be to provide a simple page allocator wrapper that
would allow to recycle pages for a particular user or providing a slab
cache that would achieve the same thing. This would be still a bit
quetiongable because the user could be seeing stale data but less of a
problem than crossing propers and potentially security domains.
-- 
Michal Hocko
SUSE Labs
