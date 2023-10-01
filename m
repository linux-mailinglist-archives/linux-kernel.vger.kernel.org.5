Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF637B45C8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 09:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjJAHZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 03:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbjJAHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 03:25:13 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE81BF;
        Sun,  1 Oct 2023 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ojMGvfX4EQDBSjYC40hfQgCdDjoAMF7YsfOIfh6s8Lo=;
  b=uHY2qLaZzbaNayyA7pb/uFAQ6qNO5z1SEJna0zofg4j98bZOCu9vtqD5
   PMHTQAQkGKCrMNBCDSx45A5wgw6UrNQQCaQ4tJEqH5DBk7iExxGqDkFN4
   8/QFdqwXsC0o8mHsskDDRfOJQhweB/n6LpsyZl9dXFUaw28hhjI+eyKeV
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,191,1694728800"; 
   d="scan'208";a="67430614"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 09:25:09 +0200
Date:   Sun, 1 Oct 2023 09:25:07 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Kees Cook <keescook@chromium.org>
cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] comedi: Annotate struct comedi_lrange with
 __counted_by
In-Reply-To: <202309301342.5B5BED40A1@keescook>
Message-ID: <alpine.DEB.2.22.394.2310010922250.3166@hadrien>
References: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr> <202309301342.5B5BED40A1@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2023, Kees Cook wrote:

> On Sat, Sep 30, 2023 at 11:14:47AM +0200, Christophe JAILLET wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > This patch is part of a work done in parallel of what is currently worked
> > on by Kees Cook.
> >
> > My patches are only related to corner cases that do NOT match the
> > semantic of his Coccinelle script[1].
>
> Nice!
>
> struct comedi_lrange {
>         int length;
>         struct comedi_krange range[];
> };
> ...
> static const struct comedi_lrange range_rti800_ai_10_bipolar = {
>         4, {
>                 BIP_RANGE(10),
>                 BIP_RANGE(1),
>                 BIP_RANGE(0.1),
>                 BIP_RANGE(0.02)
>         }
> };
>
> I'm struggling to come up with a way for Coccinelle to find this kind of
> thing in other places...
>
> > In this case, it is been spotted because of comedi_alloc_spriv().
> > All other usages of struct comedi_lrange seem to be static definition of
> > the structure that explicitly set the .length field.
>
> Ah-ha, I found it in drivers/comedi/drivers/das16.c das16_ai_range():
>
>                 lrange = comedi_alloc_spriv(s,
>                                             struct_size(lrange, range, 1));

This is not found due to the regular expression used for the name of the
alloc function.  Maybe you could drop it entirely?  Maybe you could just
check for alloc somewhere in the string?

identifier ALLOC =~ "alloc";

works in this case.

Also, I see in the link that you have:

// Options: --all-includes

You can actually force this by putting

#spatch --all-includes

and any other options you want.

julia


>
> I was also able to find this:
>
> union jr3_pci_single_range {
>         struct comedi_lrange l;
>         char _reserved[offsetof(struct comedi_lrange, range[1])];
> };
>
> Which looks a lot like DEFINE_FLEX:
> https://lore.kernel.org/linux-hardening/20230912115937.1645707-2-przemyslaw.kitszel@intel.com/
> But that above for stack varaibles rather than globals. But I'm way off
> topic now. ;)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> >
> > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> > ---
> >  include/linux/comedi/comedidev.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/comedi/comedidev.h b/include/linux/comedi/comedidev.h
> > index 0a1150900ef3..c08416a7364b 100644
> > --- a/include/linux/comedi/comedidev.h
> > +++ b/include/linux/comedi/comedidev.h
> > @@ -633,7 +633,7 @@ extern const struct comedi_lrange range_unknown;
> >   */
> >  struct comedi_lrange {
> >  	int length;
> > -	struct comedi_krange range[];
> > +	struct comedi_krange range[] __counted_by(length);
> >  };
> >
> >  /**
> > --
> > 2.34.1
> >
>
> --
> Kees Cook
>
