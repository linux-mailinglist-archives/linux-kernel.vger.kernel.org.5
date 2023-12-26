Return-Path: <linux-kernel+bounces-11721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8A581EAC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFC51C214DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 23:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3BDD2E8;
	Tue, 26 Dec 2023 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPyX7EMP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13685687
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 23:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC8CC43397
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 23:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703633406;
	bh=O9IaDrxHq9SjvzKERZJT4A7J8GqGRiJcTzkr1ij/nJM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LPyX7EMPgofZzYLBSwcDOAdWq6dC+dm+CYrdkg0HL9abqKq4zHVuOR2xxRoyxMPfr
	 4CSf3J87S3MqMOypqlEXJoDr4tuxb/AKwid76f/fb5s2i8JxHnVaDJXUqDEZFeSmhP
	 9973nOe+ny0uPiCeg/4n92Jnk6IRDzYceMaZP5hsMbfp3DKDfCRBm394z8+Fm7HFsu
	 KQTh0m//YC2fc5477O5n2I0CNYXJSj7CxpPB1M2sIm90UGjFuxrEnCw5iqb35SnsCb
	 lTXtsW9zqNZXk7Id5QGV99QSDXUgpNLXDhAUZvHd43z7rqV/L0SMiMx8o+vDzTbTby
	 JYONeNjn56M+w==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28bc7155755so1765802a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 15:30:06 -0800 (PST)
X-Gm-Message-State: AOJu0Yxw67WQ+SGfGQ6ZH9m0MlGjZadYTPTtmhOUKhNs25pXe0KxnC79
	mqbdx4B0KcEBaksvGt6EM2eahOeCypeNHGv51AB6Q0pxIHdi
X-Google-Smtp-Source: AGHT+IGvyFSG2mcsXemDZQSc9d5PFVn1+t/eYGiZvOIFTGn8rokzkdfbRuptYjFXTmgtrQa7GzLI/sMfHNG5hgZTO00=
X-Received: by 2002:a17:90a:d711:b0:28c:8910:d45d with SMTP id
 y17-20020a17090ad71100b0028c8910d45dmr321101pju.17.1703633405585; Tue, 26 Dec
 2023 15:30:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000b05cd060d6b5511@google.com> <CAKEwX=OmWYivf7dg_izW8pn5s5q15+nx-vRMsV47T_qG=dep_Q@mail.gmail.com>
 <CAF8kJuPLEXEXG+4esR6MbRa3iirTrJ7-w3YCorB9iD=gnQ+G3A@mail.gmail.com> <CAKEwX=PaFmreqmNrisatSN1=k2kRiYgDksgDze-t=GBD=0iJDg@mail.gmail.com>
In-Reply-To: <CAKEwX=PaFmreqmNrisatSN1=k2kRiYgDksgDze-t=GBD=0iJDg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Dec 2023 15:29:54 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPF5ACu8o1P7GqEQRb6p8QShyTVNuzrrY557g+SsddzWA@mail.gmail.com>
Message-ID: <CAF8kJuPF5ACu8o1P7GqEQRb6p8QShyTVNuzrrY557g+SsddzWA@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
To: Nhat Pham <nphamcs@gmail.com>
Cc: syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com, 
	zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nhat,

On Tue, Dec 26, 2023 at 3:11=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:

> > The decompressed output can be bigger than input. However, here we
> > specify the output size limit to be one page. The decompressor should
> > not output more than the 1 page of the dst buffer.
> >
> > I did check the  lzo1x_decompress_safe() function.
>
> I think you meant lzo1x_1_do_compress() right? This error happens on
> the zswap_store() path, so it is a compression bug.

Ah, my bad. I don't know why I am looking at the decompression rather
than compression.
Thanks for catching that.

>
> > It is supposed to use the  NEED_OP(x) check before it stores the output=
 buffer.
>
> I can't seem to find any check in compression code. But that function
> is 300 LoC, with no comment :)

It seems the compression side does not have a safe version of the
function which respects the output buffer size. I agree with you there
seems to be no check on the output buffer size before writing to the
output buffer. The "size_t *out_len" seems to work as an output only
pointer. It does not respect the output size limit.

The only place use the output_len is at lzo1x_compress.c:298
*out_len =3D op - out;

So confirm it is output only :-(

>
> > However I do find one place that seems to be missing that check, at
> > least it is not obvious to me how that check is effective. I will
> > paste it here let other experts take a look as well:
> > Line 228:
> >
> > if (op - m_pos >=3D 8) {
> > unsigned char *oe =3D op + t;
> > if (likely(HAVE_OP(t + 15))) {
> > do {
> > COPY8(op, m_pos);
> > op +=3D 8;
> > m_pos +=3D 8;
> > COPY8(op, m_pos);
> > op +=3D 8;
> > m_pos +=3D 8;
> > } while (op < oe);
> > op =3D oe;
> > if (HAVE_IP(6)) {
> > state =3D next;
> > COPY4(op, ip); <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D This COPY4 does not have
> > obvious NEED_OP() check. As far as I can tell, this output is not
> > converted by the above HAVE_OP(t + 15)) check, which means to protect
> > the unaligned two 8 byte stores inside the "do while" loops.
> > op +=3D next;
> > ip +=3D next;
> > continue;
> > }
> > } else {
> > NEED_OP(t);
> > do {
> > *op++ =3D *m_pos++;
> > } while (op < oe);
> > }
> > } else
> >
> >
> > >
> > > Not 100% sure about linux kernel's implementation though. I'm no
> > > compression expert :)
> >
> > Me neither. Anyway, if it is a decompression issue. For this bug, it
> > is good to have some debug print assert to check that after
> > decompression, the *dlen is not bigger than the original output
> > length. If it does blow over the decompression buffer, it is a bug
> > that needs to be fixed in the decompression function side, not the
> > zswap code.
>
> But regardless, I agree. We should enforce the condition that the
> output should not exceed the given buffer's size, and gracefully fails
> if it does (i.e returns an interpretable error code as opposed to just
> walking off the cliff like this).

Again, sorry I was looking at the decompression side rather than the
compression side. The compression side does not even offer a safe
version of the compression function.
That seems to be dangerous. It seems for now we should make the zswap
roll back to 2 page buffer until we have a safe way to do compression
without overwriting the output buffers.

>
> I imagine that many compression use-cases are best-effort
> optimization, i.e it's fine to fail. zswap is exactly this - do your
> best to compress the data, but if it's too incompressible, failure is
> acceptable (we have plenty of fallback options - swapping, keeping the
> page in memory, etc.).
>
> Furthermore, this is a bit of a leaky abstraction - currently there's
> no contract on how much bigger can the "compressed" output be with
> respect to the input. It's compression algorithm-dependent, which
> defeats the point of the abstraction. In zswap case, 2 * PAGE_SIZE is
> just a rule of thumb - now imagine we use a compression algorithm that
> behaves super well in most of the cases, but would output 3 *
> PAGE_SIZE in some edge cases. This will still break the code. Better
> to give the caller the ability to bound the output size, and
> gracefully fail if that bound cannot be respected for a particular
> input.

Agree.

Chris

