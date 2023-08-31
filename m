Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248F478E72C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjHaH3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjHaH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:29:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE29E1A4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77317B8214E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B408C433C9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693466936;
        bh=aAsHT2HzQhTcrO+4j0ndVmaexFGGJKnxvEIZY4yryN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=np3yit3dWU+KvMRcRuve1HYQ8szdLTgQUAV++aqlxieYYPxKTymuiRHI2MA3luxtH
         tiQvYapxG9sYlUq8uOoD0Hs+5RPOWUqDVy/+r7NexaVxPYoj2hVw5UNQ+U6mjXEop7
         buGPp9RfTcT+8N5s5eD1kyEk22YcBRYqHlwgO8Chcj3MuoR3yf+f16jTlszlmXMqIi
         1OjE0ctx7MopzU7SM1NjN2biFMQhxANFHsdWmzrm5Rc4N1irugBz3yI+EXbdcuF9wq
         jjdfMfCOFy7AqWccusNQbc+B5HbrJwfE3hLDCOVAZ2bPkaNpIHmlsdgOVrS/ze/F7G
         gXP+wTxfM1tSQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so9114351fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:28:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy8abhLfD8Zr4bmDuKctHsYGZKEsocL7i2qm2tw4phF5/TDM6wW
        P8ITmVeg7IdZXj/l+QDPQWPgtlHC0MGx42n8OZI=
X-Google-Smtp-Source: AGHT+IGgDLm30eOwMWGy981HPEL4q1aK6Ow2DA9Nzy+Mr3D7p8aTPGDoeNJPffQ7eLjODERFv3WalNMw5BXB6mpot+A=
X-Received: by 2002:a2e:a178:0:b0:2b9:f0b4:eaa1 with SMTP id
 u24-20020a2ea178000000b002b9f0b4eaa1mr3008469ljl.16.1693466934183; Thu, 31
 Aug 2023 00:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230830212238.135900-1-ardb@kernel.org> <202308301608.739BFA8@keescook>
 <20230831052009.GA1349@sol.localdomain>
In-Reply-To: <20230831052009.GA1349@sol.localdomain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 31 Aug 2023 09:28:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGmVZHW4fdYKM+pqaHGBDALXgDZQ5Tg4TiqNR5jFpTekg@mail.gmail.com>
Message-ID: <CAMj1kXGmVZHW4fdYKM+pqaHGBDALXgDZQ5Tg4TiqNR5jFpTekg@mail.gmail.com>
Subject: Re: [PATCH] pstore: Base compression input buffer size on estimated
 compressed size
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 07:20, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Aug 30, 2023 at 04:43:37PM -0700, Kees Cook wrote:
> > On Wed, Aug 30, 2023 at 11:22:38PM +0200, Ard Biesheuvel wrote:
> > > Commit 1756ddea6916 ("pstore: Remove worst-case compression size logic")
> > > removed some clunky per-algorithm worst case size estimation routines on
> > > the basis that we can always store pstore records uncompressed, and
> > > these worst case estimations are about how much the size might
> > > inadvertently *increase* due to encapsulation overhead when the input
> > > cannot be compressed at all. So if compression results in a size
> > > increase, we just store the original data instead.
> >
> > Does the Z_FINISH vs Z_SYNC_FLUSH thing need to be fixed as well, or
> > does that become a non-issue with this change?
>
> I haven't seen any real evidence that that issue actually exists.
>

Indeed. The workaround in crypto/deflate.c was added in 2003 by James
Morris, and the zlib fork was rebased onto a newer upstream at least
once since then.

> > >  void pstore_record_init(struct pstore_record *record,
> > > @@ -305,7 +314,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
> > >             record.buf = psinfo->buf;
> > >
> > >             dst = big_oops_buf ?: psinfo->buf;
> > > -           dst_size = psinfo->bufsize;
> > > +           dst_size = max_uncompressed_size ?: psinfo->bufsize;
> > >
> > >             /* Write dump header. */
> > >             header_size = snprintf(dst, dst_size, "%s#%d Part%u\n", why,
> > > @@ -326,8 +335,15 @@ static void pstore_dump(struct kmsg_dumper *dumper,
> > >                             record.compressed = true;
> > >                             record.size = zipped_len;
> > >                     } else {
> > > -                           record.size = header_size + dump_size;
> > > -                           memcpy(psinfo->buf, dst, record.size);
> > > +                           /*
> > > +                            * Compression failed, so the buffer is most
> > > +                            * likely filled with binary data that does not
> > > +                            * compress as well as ASCII text. Copy as much
> > > +                            * of the uncompressed data as possible into
> > > +                            * the pstore record, and discard the rest.
> > > +                            */
> > > +                           record.size = psinfo->bufsize;
> > > +                           memcpy(psinfo->buf, dst, psinfo->bufsize);
> >
> > I don't think this is "friendly" enough. :P
> >
> > In the compression failure case, we've got a larger dst_size (and
> > dump_size, but technically it might not be true if something else went
> > wrong) than psinfo->bufsize, so we want to take the trailing bytes
> > (i.e. panic details are more likely at the end). And we should keep
> > the header, which is already present in "dst". I think we need to do
> > something like this:
> >
> >       size_t buf_size_available = psinfo->bufsize - header_size;
> >       size_t dump_size_wanted = min(dump_size, buf_size_available);
> >
> >       record.size = header_size + dump_size_wanted;
> >       memcpy(psinfo->buf, dst, header_size);
> >       memcpy(psinfo->buf + header_size,
> >              dst + header_size + (dump_size - dump_size_wanted),
> >              dump_size_wanted);
> >
> > My eyes, my eyes.
> >
>
> How hard would it be to write two uncompressed records when compression fails to
> achieve the targeted 50% ratio?
>

It wouldn't be that hard, and this crossed my mind as well.

However, we should ask ourselves when this is ever going to happen,
and what the implications are for those records. The reason we want to
capture the dmesg output is because it contains human readable ASCII
text that explains what happened right before the system crashed.

The zlib library code uses pre-allocated buffers and so the most
likely reason for failure is that the 2x estimation does not hold for
the buffer in question. It is highly unlikely that that buffer
contains ASCII text or anything resembling it in that case, and so it
is most probably garbage that happens to compress really poorly. Do we
really need to capture all of that? And if we don't, does it really
matter whether the we capture the first bit or the last bit?
