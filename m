Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EDD7A0E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjINTiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjINTiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:38:15 -0400
Received: from out-223.mta1.migadu.com (out-223.mta1.migadu.com [IPv6:2001:41d0:203:375::df])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F7526AB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:38:11 -0700 (PDT)
Date:   Thu, 14 Sep 2023 15:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694720290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N0uPCiRAY/wk+OsCSsV4Qn54HTT3/j5koYS/Evo6weg=;
        b=ndegDqVm/nPasw22OjMVjwca9VMr7jNbEtOPasd7L1k/zvw0P5Q9WzzRcZtq9GAp8lIiph
        gLp+PIslF+6Mbcp6vptFAp7HyV031HzaJcAZ78wtqC2j8fPAuMbHyoYp6onFOSpnpD8Qqv
        spmgHAiUf+blNDZy9JcwX+tQRqPhl2A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: linux-next: Tree for Sep 12 (bcachefs)
Message-ID: <20230914193807.ozcmylp6n6dsqkbi@moria.home.lan>
References: <20230912152645.0868a96a@canb.auug.org.au>
 <202309131803.6A3C1D05A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309131803.6A3C1D05A@keescook>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 06:17:00PM -0700, Kees Cook wrote:
> On Tue, Sep 12, 2023 at 03:26:45PM +1000, Stephen Rothwell wrote:
> > New tree: bcachefs
> 
> Thanks for going through and fixing all the fake flexible array members.
> It looks much nicer. :)
> 
> I have some questions about the remaining "markers", for example:
> 
> $ git grep -A8 '\bkey_start\b' -- fs/bcachefs
> fs/bcachefs/bcachefs_format.h:  __u8            key_start[0];
> ...
> fs/bcachefs/bcachefs_format.h-  __u8            pad[sizeof(struct bkey) - 3];
> --
> fs/bcachefs/bkey.c:     u8 *l = k->key_start;
> 
> Why isn't this just:
> 
> 			u8 *l = k->pad
> 
> and you can drop the marker?

In this case, it's documentation. &k->pad tells us nothing; why is pad
significant? k->key_start documents the intent better.

> And some seem entirely unused, like all of "struct bch_reflink_v".

No, those aren't unused :)

bcachefs does the "list of variable size items" a lot - see vstructs.h.
start[] is the type of the item being stored, _data is what we use for
pointer arithmetic - because we always store sizes in units of u64s, for
alignment.

> 
> And some are going to fail at runtime, since they're still zero-sized
> and being used as an actual array:
> 
> struct bch_sb_field_journal_seq_blacklist {
>         struct bch_sb_field     field;
> 
>         struct journal_seq_blacklist_entry start[0];
>         __u64                   _data[];
> };
> ...
>                 memmove(&bl->start[i],
>                         &bl->start[i + 1],
>                         sizeof(bl->start[0]) * (nr - i));
> 
> It looks like you just want a type union for the flexible array.
> This can be done like this:
> 
> struct bch_sb_field_journal_seq_blacklist {
>         struct bch_sb_field     field;
> 
> 	union {
> 		DECLARE_FLEX_ARRAY(struct journal_seq_blacklist_entry, start);
> 		DECLARE_FLEX_ARRAY(__u64, _data);
> 	};
> };

Eesh, why though?

Honestly, I'm not a fan of the change to get rid of zero size arrays,
this seems to be adding a whole lot of macro layering and indirection
for nothing.

The only thing a zero size array could possibly be is a flexible array
member or a marker, why couldn't we have just kept treating zero size
arrays like flexible array members?
