Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6181B7A0647
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbjINNlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbjINNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:41:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D2C1AE;
        Thu, 14 Sep 2023 06:41:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A938C433C7;
        Thu, 14 Sep 2023 13:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694698906;
        bh=FHetZaKaZn2ZR7ZQqXKrAYm/1XbjR0eweWVZ37cVWzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgK0m8RltbKGbgkOn23y8NLRz0FtNFKWivm4s52sLiBCCV/1MF4BUAfZ4lcL4KzvD
         uzQSOF0fjQsJAcDxE45TVbeWohe5J6pZeGCZjgCuiOJSeTf2GGq29CB5q1xuYb+Keq
         6iiodhVTk0Q6/PA8//B3Olc8EIyphnqk2aKlxsGMJ+9m2a6cZ8SIdXKRiGOpXS8q55
         2miqYY1EsS6vHg9HTsKW0bceT4Ho0mOIFLQSBktRrHtxFnkpK6bbftcWP1LnNn9DEA
         ENO8subd6GjGeg3Fud+eGRVhDKs2pTpeQl+yl1PnRwkjdqhWbqflPNv5FF33Y5/jKW
         hg70tvcqU0dnA==
Date:   Thu, 14 Sep 2023 15:41:42 +0200
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Sep 12 (bcachefs, objtool)
Message-ID: <20230914134142.lndfpgqahgkqca5k@treble>
References: <20230912152645.0868a96a@canb.auug.org.au>
 <d60dac60-1e38-4a8c-98ad-a769ab1dfccd@infradead.org>
 <20230913210829.zkxv6qqlamymhatr@treble>
 <20230913230626.mu764axueko6ccta@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230913230626.mu764axueko6ccta@moria.home.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 07:06:26PM -0400, Kent Overstreet wrote:
> On Wed, Sep 13, 2023 at 11:08:29PM +0200, Josh Poimboeuf wrote:
> > On Tue, Sep 12, 2023 at 04:36:55PM -0700, Randy Dunlap wrote:
> > > 
> > > 
> > > On 9/11/23 22:26, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > Changes since 20230911:
> > > > 
> > > > New tree: bcachefs
> > > > 
> > > > The bcachefs tree gained a semantic conflict against Linus' tree for
> > > > which I applied a patch.
> > > > 
> > > > The wireless-next tree gaind a conflict against the wireless tree.
> > > > 
> > > > Non-merge commits (relative to Linus' tree): 4095
> > > >  1552 files changed, 346893 insertions(+), 22945 deletions(-)
> > > > 
> > > > ----------------------------------------------------------------------------
> > > 
> > > on x86_64:
> > > 
> > > vmlinux.o: warning: objtool: bch2_dev_buckets_reserved.part.0() is missing an ELF size annotation
> > 
> > Here ya go:
> > 
> > ---8<---
> > 
> > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > Subject: [PATCH] bcachefs: Remove undefined behavior in bch2_dev_buckets_reserved()
> > 
> > In general it's a good idea to avoid using bare unreachable() because it
> > introduces undefined behavior in compiled code.  In this case it even
> > confuses GCC into emitting an empty unused
> > bch2_dev_buckets_reserved.part.0() function.
> > 
> > Use BUG() instead, which is nice and defined.  While in theory it should
> > never trigger, if something were to go awry and the BCH_WATERMARK_NR
> > case were to actually hit, the failure mode is much more robust.
> 
> Thanks, want to do the other two cases too? :)

Hm, which cases are you referring to?

-- 
Josh
