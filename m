Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B852768FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjGaIVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjGaIVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:21:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A0FA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:20:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8073A1F45F;
        Mon, 31 Jul 2023 08:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690791641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lcqkPyNuGvb+x3SXfQDkaOxh3KnSlIJc1HaZt8923Q=;
        b=HjjDW8EIxdfZHArVLsCu1zI481/CkE0IKDgKG/j5prhI35M9o3U17rAB2XB8cagxO8Rrrw
        IJj8A/v/PsHFR5jswJbXzWgGmaFfZHYwUJXZCdfPFQOtb+LHqtX82uzd1XDfH0rWc0QxsU
        vAl2q/5nmxXdgqyp/TRnNuxepqF9p4g=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0F4EF2C142;
        Mon, 31 Jul 2023 08:20:41 +0000 (UTC)
Date:   Mon, 31 Jul 2023 10:20:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: arm32 build warnings in workqueue.c
Message-ID: <ZMdu1YqUI7VIEq1y@alley>
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
 <ZJX27JDyrgvdeCe4@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJX27JDyrgvdeCe4@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-06-23 09:47:56, Tejun Heo wrote:
> Hello,
> 
> On Fri, Jun 23, 2023 at 11:24:16AM -0700, Linus Torvalds wrote:
> ...
> >   enum {
> >         [..]
> >         WORK_STRUCT_FLAG_BITS   = WORK_STRUCT_COLOR_SHIFT +
> >                 WORK_STRUCT_COLOR_BITS,
> >         [..]
> >         WORK_STRUCT_FLAG_MASK   = (1UL << WORK_STRUCT_FLAG_BITS) - 1,
> >         WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
> >   }
> > 
> > Anyway, that code absolutely has to be fixed. Using enums for types is
> > wrong, wrong, wrong. You should consider an enum to be a weakly typed
> > integer expression with some specific advantages (the automatic
> > incrementing at definition time, and the compiler being able to limit
> > ranges in switch() statements and maybe doing limited type warnings
> > elsewhere)
> 
> The only benefit I care about is it being visible in the type system and
> thus in debug info whether that's the usual one or BTF. This makes a huge
> difference in tracing, monitoring and debugging. For one off's, it's fine to
> track down the define values. For something more sophisticated (e.g.
> non-trivial drgn, bcc and other BPF programs), the macro constants are a
> source of sadness and a really dumb and insidious one.

Would it help to use const variables?

> > +/* Convenience constants - of type 'unsigned long', not 'enum'! */
> > +#define WORK_OFFQ_CANCELING	(1ul << __WORK_OFFQ_CANCELING)

static const WORK_OFFQ_CANCELING = 1ul << __WORK_OFFQ_CANCELING;

It is kind of nasty as well. But it defines the right type and should
be visible in debuginfo. Well, it is usable only for local variables.

Best Regards,
Petr
