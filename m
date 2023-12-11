Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7798680C4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjLKJjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKJjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:39:46 -0500
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58637CE;
        Mon, 11 Dec 2023 01:39:52 -0800 (PST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5d40c728fc4so30926507b3.1;
        Mon, 11 Dec 2023 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702287591; x=1702892391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/PILXw+sfhUyZ9V8GULOr4bqu2Prc7VK3XM3govllA=;
        b=Abto7qIif+7Nnjp5qHSn01Rv/nK1cidsFPW8W5thIf4wEleR/BirTS1K5NJ8ZSFXop
         jFodXpz5zTwEAqW+P1/Q+rqYbiBhF/ssTLS57H+leiRvtQ+qFWbQSPeztnhP2CTzfbJu
         A628P9ZyK9fBIkxU6+p1l1WvxuB50Jm5xeZ+89ktAXDSBzu/CPZI45/W4kUaskobbnlK
         GgPYXtuBkfRIajIWB8zJTDaSxB1heNf/aX+se/9n0ovFEq+LmTj1Et6A++TT822GiaZk
         qo2arHkJpiHcNUjTgEaE8/JKIQFVOrzgyHYgWtOYFP8QSUtjnoM+42fCQn1NUiaLVHiP
         pdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702287591; x=1702892391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/PILXw+sfhUyZ9V8GULOr4bqu2Prc7VK3XM3govllA=;
        b=lgrvRDshJWaCk1Izho5KvPbk3wV2DYFwn2tX7JY7rsXx4BYq9PSeO3YQQOK44vGNDV
         9VnxGwSWcXHoJMrkNvNP+YaIjWiAJ6jTRMOZDL5Q7GL4Bin7ylQ92O8bniUNvqG0WhT5
         j/46065p+vrfqeIfalOl4RmvmWXxvFiItVnfZP0/BT2XoNxPfMQXCKGcAZycX39Lz1EQ
         IfYfugMbAxnwrbuSgt+6Xeuk0TyTBMQAaBQa0Ts7Tergz+Q0ZCJZDvdzsWnXmU+LnzRb
         rOP/J5Y1+IkgvV9ekpjM5OHudRU17FbIG1JwqrA5MVBxGlWTTkgSZcG4DpKp7/Yr0eVm
         sQdg==
X-Gm-Message-State: AOJu0YwyP6Ks+qAy8cCWaZVYPY+3YPI74nxaaZw3W6D5MVvN12YycfL2
        sE66fzJxjLzryg6R0i6khgvoGRSpjdp156m8D2Y=
X-Google-Smtp-Source: AGHT+IHWXV1aFeHBoOIC2oRFWxaeE8TReO+CB83PEsQT8b6QoYhLkVki7spj4oL79aW6VkprG1mY32hPRJlcnXs+GL0=
X-Received: by 2002:a0d:d743:0:b0:5d3:6042:ced9 with SMTP id
 z64-20020a0dd743000000b005d36042ced9mr2712396ywd.5.1702287591324; Mon, 11 Dec
 2023 01:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20231210130001.2050847-1-menglong8.dong@gmail.com> <4457e84f-4417-4a60-a814-9288b0756d91@linux.dev>
In-Reply-To: <4457e84f-4417-4a60-a814-9288b0756d91@linux.dev>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Mon, 11 Dec 2023 17:39:40 +0800
Message-ID: <CADxym3bNJXWZRfcGWpD7YW1rFe93vSOastmGrLvAcG3U2SaUdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make the verifier trace the "not qeual" for regs
To:     Yonghong Song <yonghong.song@linux.dev>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Dec 11, 2023 at 1:09=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 12/10/23 5:00 AM, Menglong Dong wrote:
> > We can derive some new information for BPF_JNE in regs_refine_cond_op()=
.
> > Take following code for example:
> >
> >    /* The type of "a" is u16 */
> >    if (a > 0 && a < 100) {
> >      /* the range of the register for a is [0, 99], not [1, 99],
> >       * and will cause the following error:
> >       *
> >       *   invalid zero-sized read
> >       *
> >       * as a can be 0.
> >       */
> >      bpf_skb_store_bytes(skb, xx, xx, a, 0);
> >    }
>
> Could you have a C test to demonstrate this example?
> Also, you should have a set of inline asm code (progs/verifier*.c)
> to test various cases as in mark_reg32_not_equal() and
> mark_reg_not_equal().
>

Yeah! I found that this part is tested in the test_progs/reg_bounds_crafted
too, and this commit failed that test case, which I should fix in the next
version.

> >
> > In the code above, "a > 0" will be compiled to "jmp xxx if a =3D=3D 0".=
 In the
> > TRUE branch, the dst_reg will be marked as known to 0. However, in the
> > fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> > the [min, max] for a is [0, 99], not [1, 99].
> >
> > For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
> > const and is exactly the edge of the dst reg.
> >
> > Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> > ---
> >   kernel/bpf/verifier.c | 45 ++++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 727a59e4a647..7b074ac93190 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1764,6 +1764,40 @@ static void __mark_reg_const_zero(struct bpf_reg=
_state *reg)
> >       reg->type =3D SCALAR_VALUE;
> >   }
> >
> > +#define CHECK_REG_MIN(value)                 \
> > +do {                                         \
> > +     if ((value) =3D=3D (typeof(value))imm)      \
> > +             value++;                        \
> > +} while (0)
> > +
> > +#define CHECK_REG_MAX(value)                 \
> > +do {                                         \
> > +     if ((value) =3D=3D (typeof(value))imm)      \
> > +             value--;                        \
> > +} while (0)
> > +
> > +static void mark_reg32_not_equal(struct bpf_reg_state *reg, u64 imm)
> > +{
>
> What if reg->s32_min_value =3D=3D imm and reg->s32_max_value =3D=3D imm?
> Has this been handled in previous verifier logic?

Will such a case happen? In current code path, the src reg is a const,
and the is_branch_taken() will return 0 or 1 if the
dst_reg->s32_min_value =3D=3D dst_reg->s32_max_value.

Enn......maybe we can do more checking here in case that someone
calls this function in another place.

Thanks!
Menglong Dong

>
> > +             CHECK_REG_MIN(reg->s32_min_value);
> > +             CHECK_REG_MAX(reg->s32_max_value);
> > +             CHECK_REG_MIN(reg->u32_min_value);
> > +             CHECK_REG_MAX(reg->u32_max_value);
> > +}
> > +
> > +static void mark_reg_not_equal(struct bpf_reg_state *reg, u64 imm)
> > +{
> > +             CHECK_REG_MIN(reg->smin_value);
> > +             CHECK_REG_MAX(reg->smax_value);
> > +
> > +             CHECK_REG_MIN(reg->umin_value);
> > +             CHECK_REG_MAX(reg->umax_value);
> > +
> > +             CHECK_REG_MIN(reg->s32_min_value);
> > +             CHECK_REG_MAX(reg->s32_max_value);
> > +             CHECK_REG_MIN(reg->u32_min_value);
> > +             CHECK_REG_MAX(reg->u32_max_value);
> > +}
> > +
> >   static void mark_reg_known_zero(struct bpf_verifier_env *env,
> >                               struct bpf_reg_state *regs, u32 regno)
> >   {
> > @@ -14332,7 +14366,16 @@ static void regs_refine_cond_op(struct bpf_reg=
_state *reg1, struct bpf_reg_state
> >               }
> >               break;
> >       case BPF_JNE:
> > -             /* we don't derive any new information for inequality yet=
 */
> > +             /* try to recompute the bound of reg1 if reg2 is a const =
and
> > +              * is exactly the edge of reg1.
> > +              */
> > +             if (is_reg_const(reg2, is_jmp32)) {
> > +                     val =3D reg_const_value(reg2, is_jmp32);
> > +                     if (is_jmp32)
> > +                             mark_reg32_not_equal(reg1, val);
> > +                     else
> > +                             mark_reg_not_equal(reg1, val);
> > +             }
> >               break;
> >       case BPF_JSET:
> >               if (!is_reg_const(reg2, is_jmp32))
