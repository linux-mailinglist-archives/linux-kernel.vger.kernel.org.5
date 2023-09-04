Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2F0791CBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbjIDSWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbjIDSWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:22:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A213E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:22:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E2604CE0E30
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23D0C433C7;
        Mon,  4 Sep 2023 18:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693851756;
        bh=plSadGikF5SVB6fcGNEoFCniaaqZVESV2r2w8EO8OLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AS8b2VTuL1498D+vCpK6FGEStRPcO0ZZGAldikbShf2FjQodPosI8qTcReUdxEqo9
         vpnBmg1fcoKlXEjpNhe+lKB0Y7XISjNs0vd+I7UWq4WgOUdvIVg7WqKFC4E0llbCso
         v26MxNCM+R/WC0VxyiAxOyMsmAbaZAJYG0zFGoL6B5GvTgybZ26fPQabTbplckcpVs
         mC7IOobtcb1u0jbZZulbQqU5evOVbl2x+VBsaMhioEH7gAuqmt0NqS+aJg2JjyRzwe
         h3jg5neiEN3VVWh6V87hYYdnN1nguT/cJPed0O0U5WFXQouFhsSSCg1XSkMysGQV33
         4M9X0m/xSsF1g==
Date:   Mon, 4 Sep 2023 11:22:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm: make __GFP_SKIP_ZERO visible to skip zero operation
Message-ID: <20230904182234.GB30774@sol.localdomain>
References: <20230831105252.1385911-1-zhaoyang.huang@unisoc.com>
 <ZPCEim0AZG5hTSYH@casper.infradead.org>
 <CAGWkznGAJVZtn49zNHsMAjRSfTRR707QXYY0m8Q+yABTsiig2Q@mail.gmail.com>
 <CAG_fn=VJrO3e9q0M6KA9nopqyDuRO4g7SBak6YptiEvzdE+nkA@mail.gmail.com>
 <ZPWNTiAxZZh/kzew@dhcp22.suse.cz>
 <CAHk-=wh2s26=Hj03cJXBWELmgCY=z5=mhTTDNVVKDAbda8g7Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh2s26=Hj03cJXBWELmgCY=z5=mhTTDNVVKDAbda8g7Xw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 10:34:25AM -0700, Linus Torvalds wrote:
> On Mon, 4 Sept 2023 at 00:55, Michal Hocko <mhocko@suse.com> wrote:
> >
> >       Sooner or later this will become an
> > unreviewable mess so the value of init_on_alloc will become very
> > dubious.
> 
> The value of init_on_alloc is *already* very dubious.
> 
> Exactly because people will turn it off, because it hurts performance
> so much - and in pointless ways.
> 
> You do realize that distributions - well, at least Fedora - simply
> don't turn INIT_ON_ALLOC_DEFAULT_ON on at all?
> 
> So the current state of init_on_alloc is that nobody sane uses it. You
> have to think you're special to enable it, because it is *so* bad.
> 
> Security people need to realize that the primary point of computing is
> NEVER EVER security. Security is entirely pointless without a usable
> system.
> 
> Unless security people realize that they are always secondary, they
> aren't security people, they are just random wankers.
> 
> And people who state this truism had better not get shamed for
> standing up to stupidity.
> 

Android and Ubuntu both set CONFIG_INIT_ON_ALLOC_DEFAULT_ON.  I think this makes
it clear that the init-on-alloc feature is useful for a substantial amount of
users even in its current form.

I would caution against checking the kernel config for the distro you happen to
be using and extrapolating that to all Linux systems.

Regardless, I'm in favor of a per allocation opt-out flag like GFP_SKIP_ZERO.
There are clear cases where it makes sense, for example some places in the VFS
where the performance impact is large and the code has been carefully reviewed.

I don't really like the idea
(https://lore.kernel.org/lkml/CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com/)
of making the system administrator have to opt out allocation sites individually
via a kernel command-line parameter.  Yes, it makes the opt out less likely to
be abused as two parties (developer and system administrator) have to consent to
each individual opt out.  So it theory it sounds good.  But I feel that doesn't
outweigh the fact that it would be complicated and hard to use.  How about just
having two options: one to always honor GFP_SKIP_ZERO in the code and one to
always ignore it.

- Eric
