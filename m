Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845CE75C5C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGULSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjGULSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205E61715;
        Fri, 21 Jul 2023 04:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 768BC61A32;
        Fri, 21 Jul 2023 11:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961CAC433CA;
        Fri, 21 Jul 2023 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689938290;
        bh=+1pRznIJZVGaXfyHrneWrC6bYAtsOlit/tS0KrtG2yM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZkemUooeRUEBMXoT+eZuwXtiItz8nm/fDLuhMM6XoA0+EU916wGv+BgIRm9/xgMuX
         SHioymbBApSyxanIRzsRJlh1H1xIrmrEecxMCb2eiIpMa2MDza+a4Lq7s8MEmglIDe
         ez4c8dEMJ4yU8fNNE27hJRQDS67tU5s8hkkkchIZQ2TJUr2H0Pp5kPNTLBrZ7BE1tE
         XtM4lvoh9Le7pYU5tDl1ZWsi1wmd04lf2V4ROGk/Ku3L6+VkMgVjYdls3FN1H/kiR2
         xtTShhij+hbZh33BcJIHIG5mmO1W021HSeM9yzvPFkgCtgYQYflWAvK86K6XkJEDCq
         e88ULpSvyQglQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so2891849e87.3;
        Fri, 21 Jul 2023 04:18:10 -0700 (PDT)
X-Gm-Message-State: ABy/qLb6/q4WRjT4XwdfpkRnqdmVnGhq3BwMzyUEwNPjp3RI6y+k+JvW
        V37nq1skh4rnl+G7VU76euusfgRNlpu94+0Gjsk=
X-Google-Smtp-Source: APBJJlGgzNV4bS4ZImEmRoMMfW0jhmUui+8qThAJBRzr+dpV1Qj1REJCRGaubl5KmDySuU4gh04KMBTQZciuHQWvik4=
X-Received: by 2002:a05:6512:6d4:b0:4f9:58ed:7bba with SMTP id
 u20-20020a05651206d400b004f958ed7bbamr1221034lff.16.1689938288556; Fri, 21
 Jul 2023 04:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230718125847.3869700-1-ardb@kernel.org> <20230718125847.3869700-21-ardb@kernel.org>
 <ZLpoDumeF/+xax/V@corigine.com>
In-Reply-To: <ZLpoDumeF/+xax/V@corigine.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 21 Jul 2023 13:17:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE4BFjracdzsM87Kq40t683RnT4VXEZjU0d0gRVwso=vA@mail.gmail.com>
Message-ID: <CAMj1kXE4BFjracdzsM87Kq40t683RnT4VXEZjU0d0gRVwso=vA@mail.gmail.com>
Subject: Re: [RFC PATCH 20/21] crypto: deflate - implement acomp API directly
To:     Simon Horman <simon.horman@corigine.com>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 at 13:12, Simon Horman <simon.horman@corigine.com> wrote:
>
> On Tue, Jul 18, 2023 at 02:58:46PM +0200, Ard Biesheuvel wrote:
>
> ...
>
> > -static int deflate_comp_init(struct deflate_ctx *ctx)
> > +static int deflate_process(struct acomp_req *req, struct z_stream_s *stream,
> > +                        int (*process)(struct z_stream_s *, int))
> >  {
> > -     int ret = 0;
> > -     struct z_stream_s *stream = &ctx->comp_stream;
> > +     unsigned int slen = req->slen;
> > +     unsigned int dlen = req->dlen;
> > +     struct scatter_walk src, dst;
> > +     unsigned int scur, dcur;
> > +     int ret;
> >
> > -     stream->workspace = vzalloc(zlib_deflate_workspacesize(
> > -                             -DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL));
> > -     if (!stream->workspace) {
> > -             ret = -ENOMEM;
> > -             goto out;
> > -     }
> > +     stream->avail_in = stream->avail_out = 0;
> > +
> > +     scatterwalk_start(&src, req->src);
> > +     scatterwalk_start(&dst, req->dst);
> > +
> > +     scur = dcur = 0;
> > +
> > +     do {
> > +             if (stream->avail_in == 0) {
> > +                     if (scur) {
> > +                             slen -= scur;
> > +
> > +                             scatterwalk_unmap(stream->next_in - scur);
> > +                             scatterwalk_advance(&src, scur);
> > +                             scatterwalk_done(&src, 0, slen);
> > +                     }
> > +
> > +                     scur = scatterwalk_clamp(&src, slen);
> > +                     if (scur) {
> > +                             stream->next_in = scatterwalk_map(&src);
> > +                             stream->avail_in = scur;
> > +                     }
> > +             }
> > +
> > +             if (stream->avail_out == 0) {
> > +                     if (dcur) {
> > +                             dlen -= dcur;
> > +
> > +                             scatterwalk_unmap(stream->next_out - dcur);
> > +                             scatterwalk_advance(&dst, dcur);
> > +                             scatterwalk_done(&dst, 1, dlen);
> > +                     }
> > +
> > +                     dcur = scatterwalk_clamp(&dst, dlen);
> > +                     if (!dcur)
> > +                             break;
>
> Hi Ard,
>
> I'm unsure if this can happen. But if this break occurs in the first
> iteration of this do loop, then ret will be used uninitialised below.
>
> Smatch noticed this.
>

Thanks.

This should not happen - it would mean req->dlen == 0, which is
rejected before this function is even called.

Whether or not it might ever happen in practice is a different matter,
of course, so I should probably initialize 'ret' to something sane.



> > +
> > +                     stream->next_out = scatterwalk_map(&dst);
> > +                     stream->avail_out = dcur;
> > +             }
> > +
> > +             ret = process(stream, (slen == scur) ? Z_FINISH : Z_SYNC_FLUSH);
> > +     } while (ret == Z_OK);
> > +
> > +     if (scur)
> > +             scatterwalk_unmap(stream->next_in - scur);
> > +     if (dcur)
> > +             scatterwalk_unmap(stream->next_out - dcur);
> > +
> > +     if (ret != Z_STREAM_END)
> > +             return -EINVAL;
> > +
> > +     req->dlen = stream->total_out;
> > +     return 0;
> > +}
>
> ...
