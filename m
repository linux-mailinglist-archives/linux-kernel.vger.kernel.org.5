Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6D75905C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjGSIeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGSIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476B4171D;
        Wed, 19 Jul 2023 01:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D48B56130B;
        Wed, 19 Jul 2023 08:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0F4C433A9;
        Wed, 19 Jul 2023 08:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689755649;
        bh=WMX//Zd4vQHTl2wSNqngG3i/KSedW7bESZCEVdywQQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=npivonAoU/JLz34y+sU/NQYHPvNpLVQT+U0/+j+878TThXUt2K/EknBClxtbnhFJS
         GgrvtoIgMqCqeZGw7UEkZRjZzrsr5BhPFx3T8EdDuxBipmyDyGB+J1ClvT1lOAsDgr
         l5rDJbQBqAualqYJ7CgBqQKBilcA8larUuWgBBWmi4RO7OMatAn8VPgF7/bNLiAq9E
         S5HIMsTnGT0sdXVOVV1YkwWJl72Whv/nA8r38/EWZNq9VEjelxvff1tKjzTSSewPmh
         yorAW1NVYQIVtHiKYhZZKK8eyOcxMZhZfC43m6ucmTjEhDqTWGtIEiLMM7Q9gcFSrC
         bEYx1FSSR02sQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so10747014e87.1;
        Wed, 19 Jul 2023 01:34:08 -0700 (PDT)
X-Gm-Message-State: ABy/qLZQxaAo2aRTG1tPmJJrznKOb0zoMb9tC5ONuZ5Bd0FnPWdk5VlO
        3hehMzVw/e4Vv9DdPYaYR2gv9J8DQtDGcIHsAWA=
X-Google-Smtp-Source: APBJJlGeSF5V0ZncchYeqcmkqwpUY28YQJ5DiF5w2vBv40Stfz5hfjtiPkQFB2dDWAAbFdheF+NmWD6HTwZKJ8tR1ic=
X-Received: by 2002:ac2:4db2:0:b0:4fd:c8dc:2f55 with SMTP id
 h18-20020ac24db2000000b004fdc8dc2f55mr3519001lfe.66.1689755647078; Wed, 19
 Jul 2023 01:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230718125847.3869700-1-ardb@kernel.org> <20230718125847.3869700-6-ardb@kernel.org>
 <20230718223813.GC1005@sol.localdomain>
In-Reply-To: <20230718223813.GC1005@sol.localdomain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Jul 2023 10:33:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE1fND2h8ts6Xtfn19wkt=vAnj1TumxvoBCuEn7z3V4Aw@mail.gmail.com>
Message-ID: <CAMj1kXE1fND2h8ts6Xtfn19wkt=vAnj1TumxvoBCuEn7z3V4Aw@mail.gmail.com>
Subject: Re: [RFC PATCH 05/21] ubifs: Pass worst-case buffer size to
 compression routines
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        Haren Myneni <haren@us.ibm.com>,
        Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Richard Weinberger <richard@nod.at>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        qat-linux@intel.com, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 00:38, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jul 18, 2023 at 02:58:31PM +0200, Ard Biesheuvel wrote:
> > Currently, the ubifs code allocates a worst case buffer size to
> > recompress a data node, but does not pass the size of that buffer to the
> > compression code. This means that the compression code will never use
> > the additional space, and might fail spuriously due to lack of space.
> >
> > So let's multiply out_len by WORST_COMPR_FACTOR after allocating the
> > buffer. Doing so is guaranteed not to overflow, given that the preceding
> > kmalloc_array() call would have failed otherwise.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  fs/ubifs/journal.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> > index dc52ac0f4a345f30..4e5961878f336033 100644
> > --- a/fs/ubifs/journal.c
> > +++ b/fs/ubifs/journal.c
> > @@ -1493,6 +1493,8 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
> >       if (!buf)
> >               return -ENOMEM;
> >
> > +     out_len *= WORST_COMPR_FACTOR;
> > +
> >       dlen = le32_to_cpu(dn->ch.len) - UBIFS_DATA_NODE_SZ;
> >       data_size = dn_size - UBIFS_DATA_NODE_SZ;
> >       compr_type = le16_to_cpu(dn->compr_type);
>
> This looks like another case where data that would be expanded by compression
> should just be stored uncompressed instead.
>
> In fact, it seems that UBIFS does that already.  ubifs_compress() has this:
>
>         /*
>          * If the data compressed only slightly, it is better to leave it
>          * uncompressed to improve read speed.
>          */
>         if (in_len - *out_len < UBIFS_MIN_COMPRESS_DIFF)
>                 goto no_compr;
>
> So it's unclear why the WORST_COMPR_FACTOR thing is needed at all.
>

It is not. The buffer is used for decompression in the truncation
path, so none of this logic even matters. Even if the subsequent
recompression of the truncated data node could result in expansion
beyond the uncompressed size of the original data (which seems
impossible to me), increasing the size of this buffer would not help
as it is the input buffer for the compression not the output buffer.
