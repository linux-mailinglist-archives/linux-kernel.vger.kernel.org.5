Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4432B75988F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGSOii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjGSOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1A3C7;
        Wed, 19 Jul 2023 07:38:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 292816171E;
        Wed, 19 Jul 2023 14:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A69AC433C8;
        Wed, 19 Jul 2023 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689777506;
        bh=GezNb42kEpgmegboqOOBAyzMgqyuAvFtS/mLgu3jRUg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JQGGh5TFecokR/YKhLaMZWg52yo4ZZ3M1avMllGsOMgEUKzc/OUk3I392cKcffGbF
         OMwzv1r99z3uGG/O+qT0B88iGlu5vx56jVkkni5i8KUC2HPPZ3p90oE1s4nYFjg/0L
         yhZ34YIsrHnwHZH6L6D59sGcRpi1RG33m+tXVrMD6gDQlHRQMf1wAKXtKsQoF683rg
         dVYJ9CKiNUKdy92GNh8DmNn8MpQZoqlGhP5kq2k8jJR36tDit2xDdksKkszaf/mOpu
         JjZQdo5olGWa1rCh677vPUAak9wQVdTqxZdO2AyOyg9Hobi8BzRyS9L781CjQ/Edy1
         ibmQ54otiiz/A==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so108065781fa.1;
        Wed, 19 Jul 2023 07:38:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLaNdY6QrmIO68C8tGl5L7tBqy01RaI07ts6nY0vsB+JPSmd6VNJ
        DuEWA6HxIdx4LguZDAA2VYb1Jpn2NKbAbyx+VQo=
X-Google-Smtp-Source: APBJJlED2jiKRWrm/tbkjsu0sNov4aKWyhqBk9Z1aEui4cjKtLxhvU+nz2Q0ttRwt0rpd3EDFIeTI764n9rYrpoAI4M=
X-Received: by 2002:a2e:7a09:0:b0:2b5:95a8:4126 with SMTP id
 v9-20020a2e7a09000000b002b595a84126mr23133ljc.52.1689777504291; Wed, 19 Jul
 2023 07:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230718125847.3869700-1-ardb@kernel.org> <20230718125847.3869700-6-ardb@kernel.org>
 <20230718223813.GC1005@sol.localdomain> <CAMj1kXE1fND2h8ts6Xtfn19wkt=vAnj1TumxvoBCuEn7z3V4Aw@mail.gmail.com>
 <3330004f-acac-81b4-e382-a17221a0a128@huawei.com>
In-Reply-To: <3330004f-acac-81b4-e382-a17221a0a128@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Jul 2023 16:38:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGq=WiJXsQG6R0jEFYu_Mdom_KY+DE=NGqVSF6QmqhKeA@mail.gmail.com>
Message-ID: <CAMj1kXGq=WiJXsQG6R0jEFYu_Mdom_KY+DE=NGqVSF6QmqhKeA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/21] ubifs: Pass worst-case buffer size to
 compression routines
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 16:23, Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> =E5=9C=A8 2023/7/19 16:33, Ard Biesheuvel =E5=86=99=E9=81=93:
> > On Wed, 19 Jul 2023 at 00:38, Eric Biggers <ebiggers@kernel.org> wrote:
> >>
> >> On Tue, Jul 18, 2023 at 02:58:31PM +0200, Ard Biesheuvel wrote:
> >>> Currently, the ubifs code allocates a worst case buffer size to
> >>> recompress a data node, but does not pass the size of that buffer to =
the
> >>> compression code. This means that the compression code will never use
>
> I think you mean the 'out_len' which describes the lengh of 'buf' is
> passed into ubifs_decompress, which effects the result of
> decompressor(eg. lz4 uses length to calculate the buffer end pos).
> So, we should pass the real lenghth of 'buf'.
>

Yes, that is what I meant.

But Eric makes a good point, and looking a bit more closely, there is
really no need for the multiplication here: we know the size of the
decompressed data, so we don't need the additional space.

I intend to drop this patch, and replace it with the following:

----------------8<--------------

Currently, when truncating a data node, a decompression buffer is
allocated that is twice the size of the data node's uncompressed size.
However, the fact that this space is available is not communicated to
the compression routines, as out_len itself is not updated.

The additional space is not needed even in the theoretical worst case
where compression might lead to inadvertent expansion: first of all,
increasing the size of the input buffer does not help mitigate that
issue. And given the truncation of the data node and the fact that the
original data compressed well enough to pass the UBIFS_MIN_COMPRESS_DIFF
test, there is no way on this particular code path that compression
could result in expansion beyond the original decompressed size, and so
no mitigation is necessary to begin with.

So let's just drop WORST_COMPR_FACTOR here.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index dc52ac0f4a345f30..0b55cbfe0c30505e 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1489,7 +1489,7 @@ static int truncate_data_node(const struct
ubifs_info *c, const struct inode *in
        int err, dlen, compr_type, out_len, data_size;

        out_len =3D le32_to_cpu(dn->size);
-       buf =3D kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
+       buf =3D kmalloc(out_len, GFP_NOFS);
        if (!buf)
                return -ENOMEM;
