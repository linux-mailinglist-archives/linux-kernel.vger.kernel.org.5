Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B7678F5A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbjHaWjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjHaWjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:39:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49EE65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:39:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26f3e26e55aso1013847a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693521549; x=1694126349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5C93ShUAQJdbWhmcDSSeEctnZZ6hfSTIk6ij7roG6Q=;
        b=gR9uDJlWulrGWSA4N/IG7mGXiariXReXigoBerUuzMkSkP1AvtfOM9axjiZRhYTwBg
         eqgD1OXmIHZwx2KRPbRMl65+xA6ZiGDnOWcXHfRbMya40G4gqeC6AhWGTec39Xm9g1VV
         OAzv5AMprU/NeOzBBXolIOofv4OwWyOYhTN6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693521549; x=1694126349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5C93ShUAQJdbWhmcDSSeEctnZZ6hfSTIk6ij7roG6Q=;
        b=kQw/z1DzyDve3a8tJnjZUxF/6lObEmV95lQSPiKSo8DheZYmhkNst/qPij+oYNuA21
         ncKDmzV4DZXqK7AmkYm21fYJZ8IhPCGq1j5OCT3tEZ48kDiJy45CtTTY+pEKsIeiN2T1
         f3XZVgpesvNPmuPurHtGyQYiLT5w25bwnAYvZZf2BWGdTiTIv1wk1v1mdg71ltRu6eS+
         6ts+PaV3Cx8+73JcHwU3r6ryzRB0xJMCwzsE8kaRrTentjge51LVzb5Ah0awIgOrx+MW
         WSIlXAGc257t2iQHRW7L8aOwXTzhzHUBt9u7SAGkxYNL34/wofZGetGy/rJ56CqdrOXh
         9Aqw==
X-Gm-Message-State: AOJu0Ywm4OuSwuJBUZUSW6Ki/EWsREN8s2MoCgRc8EIRJ7PxTqJkemJi
        h9ephKoAIr8x0wK/VCWOaa1Z+w==
X-Google-Smtp-Source: AGHT+IEjV9HAbVVTP4HHayfcKDshqiKuBeHQR01S10RLV6D50ErdDs12lZF/jBw3I3fgHz1G8q+k9w==
X-Received: by 2002:a17:90a:3003:b0:259:466:940f with SMTP id g3-20020a17090a300300b002590466940fmr659783pjb.22.1693521549595;
        Thu, 31 Aug 2023 15:39:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i3-20020a17090a65c300b00263b4b1255esm3331953pjs.51.2023.08.31.15.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 15:39:09 -0700 (PDT)
Date:   Thu, 31 Aug 2023 15:39:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] pstore: Base compression input buffer size on
 estimated compressed size
Message-ID: <202308311538.2BD3826FD@keescook>
References: <20230831210125.gonna.173-kees@kernel.org>
 <CAMj1kXE2kz1raOSy+ethim7YyFvKs+_uP2xhvndXDAbLdJDLdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE2kz1raOSy+ethim7YyFvKs+_uP2xhvndXDAbLdJDLdA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 11:34:17PM +0200, Ard Biesheuvel wrote:
> On Thu, 31 Aug 2023 at 23:01, Kees Cook <keescook@chromium.org> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Commit 1756ddea6916 ("pstore: Remove worst-case compression size logic")
> > removed some clunky per-algorithm worst case size estimation routines on
> > the basis that we can always store pstore records uncompressed, and
> > these worst case estimations are about how much the size might
> > inadvertently *increase* due to encapsulation overhead when the input
> > cannot be compressed at all. So if compression results in a size
> > increase, we just store the original data instead.
> >
> > However, it seems that the original code was misinterpreting these
> > calculations as an estimation of how much uncompressed data might fit
> > into a compressed buffer of a given size, and it was using the results
> > to consume the input data in larger chunks than the pstore record size,
> > relying on the compression to ensure that what ultimately gets stored
> > fits into the available space.
> >
> > One result of this, as observed and reported by Linus, is that upgrading
> > to a newer kernel that includes the given commit may result in pstore
> > decompression errors reported in the kernel log. This is due to the fact
> > that the existing records may unexpectedly decompress to a size that is
> > larger than the pstore record size.
> >
> > Another potential problem caused by this change is that we may
> > underutilize the fixed sized records on pstore backends such as ramoops.
> > And on pstore backends with variable sized records such as EFI, we will
> > end up creating many more entries than before to store the same amount
> > of compressed data.
> >
> > So let's fix both issues, by bringing back the typical case estimation of
> > how much ASCII text captured from the dmesg log might fit into a pstore
> > record of a given size after compression. The original implementation
> > used the computation given below for zlib:
> >
> >   switch (size) {
> >   /* buffer range for efivars */
> >   case 1000 ... 2000:
> >         cmpr = 56;
> >         break;
> >   case 2001 ... 3000:
> >         cmpr = 54;
> >         break;
> >   case 3001 ... 3999:
> >         cmpr = 52;
> >         break;
> >   /* buffer range for nvram, erst */
> >   case 4000 ... 10000:
> >         cmpr = 45;
> >         break;
> >   default:
> >         cmpr = 60;
> >         break;
> >   }
> >
> >   return (size * 100) / cmpr;
> >
> > We will use the previous worst-case of 60% for compression. For
> > decompression go extra large (3x) so we make sure there's enough space
> > for anything.
> >
> > While at it, rate limit the error message so we don't flood the log
> > unnecessarily on systems that have accumulated a lot of pstore history.
> >
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Link: https://lore.kernel.org/r/20230830212238.135900-1-ardb@kernel.org
> > Co-developed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v2:
> >  - reduce compression buffer size to 1.67x from 2x
> >  - raise decompression buffer size to 3x
> 
> LGTM
> 
> Thanks for picking this up.

You bet! :) I've pushed it out, and if the bots don't yell at me I'll
send a PR to Linus tomorrow.

-- 
Kees Cook
