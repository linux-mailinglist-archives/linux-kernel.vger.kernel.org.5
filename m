Return-Path: <linux-kernel+bounces-73992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD5E85CE96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AB01C2295F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7D538DCC;
	Wed, 21 Feb 2024 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="F+iWiP11"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552042BAE7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484985; cv=none; b=AyDi24eJWHyuSDsZegIxdlljBk3bm+7WxCo0g6wVO/B26KouI07rTxnQNemKxYyrznYh7uk9+1oo2BrR39T/QJ93CTLh3/k5z/j9V9aR4ToIx0pVrty48ZZ7POgTN8Ef4Ntz52mX/jqxKv5HXNpJmtrDrSi+Vi0INVFVGi706So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484985; c=relaxed/simple;
	bh=eVJKhbDl282YAD6eGBJ0Hq2ZAxNMnXe/FenergvqHCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsoJxRSkXHKSucvhzktMgShg82hWgdQAyOtW41F26ZxLFG5ESAncZ0N27S9JcYXyxwdKU/UAfJbDfL7tFGW8Ar14xFMEIAvvvQEng6KiTWCtP3HEph/TPFXM/3ZYdOsr5DtwHCrq2D6RDWcK6MdN5jMYekeNQZt586XOe3jxWgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=F+iWiP11; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2906bcae4feso3010754a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708484982; x=1709089782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9JAFBuaoAQzz3cyLyvinoNXI6OgqQmkxSp6hvS7uuM=;
        b=F+iWiP11UzbATIZcY9YbBis4FhL24Y55sas7sPp86vUNLLwY007kVdYlOKxmdiGVik
         aNAKormAJ2MBinZY+5XYh6L6ct6K/rC/4Nxh5Gz5zC8Gd6WzLRPvvWMq2NXAEgXCWL3B
         272IhMv5Mv5CeTsqozMWFSuRhRne7f1HAB0oQgkDmr4rdE5VwXkOPdILJ1MHuWS326sN
         9Bgx5UUI2K1fk1wKrKTXyskbgeABdAPlu9Y59SZ2yjz6k79ivQ3KmBdlugVKqzM+ujM/
         TU020vEcYxjHfQPKSRnMDLibmMcZ84OqvNSmt3DWlsInwvhiyBbzol/4DXqva89fdApL
         zBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484982; x=1709089782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9JAFBuaoAQzz3cyLyvinoNXI6OgqQmkxSp6hvS7uuM=;
        b=M/sxZJjspV/NdNZqyM9WZdoCGGHRBdC62nziErmqKNuqC1lbIR9QshlSsZdJnOqB/J
         7RHIO69qORBK6ZLMB10h/YcrMYLtm7KPilsJsvo6iY8N3b61W9ZO+iqg7sX2cgK2jXd7
         pjDgv+zdfLlLkrf0q+ts2fe4QS5BdyP1WLgLeBCDROJvmqHWYDnBQDRmQozBxypbplS5
         VhQnXLH7b2CfMN2tjnsFxG1mCYNglw1mHwVF7Q9K8XDL4Z6QMWjaoxgMGC6gQAfDb5/e
         x4NBM1Aa5oZ1KNtbgEOphD5wF7RHwZ+LieBg8RJ2B4g3M47fkJt0LmEyKPiwV3FPcNrk
         dwSg==
X-Forwarded-Encrypted: i=1; AJvYcCUOOWahIbBVxmFg8jOv/v7xP+xLDUU6E18TOkPlTj5sAM8O3i83/NjTPwk0YfJM8n2BQGmwb7tE10VVHpy94V6YfpDtQ8NMj1QhxzoN
X-Gm-Message-State: AOJu0Yw3m0uM9JToCyjRuQdUns8vo0zWscjKFlI1oigjBKsq5NaZ1IBm
	USr/pWCcfezM5UZ0VCpdDN6Q9YrtWD56OkpP7L7/AaxQhDquy3V6MXNyP/rsdmkosyByV1UbTtC
	gWjlUMJXDOoVk1tZBRLwlIBhXL7gnjpkFSRGdqQ==
X-Google-Smtp-Source: AGHT+IGz6pr/9xNn3AU5WmkiQvLLrCB/3YS0FkJtcuzGRfTXJQty26y06k1HPX8yIQMnSm9glOLnmX0UnQT9ooeohxs=
X-Received: by 2002:a17:90a:d197:b0:299:7848:7193 with SMTP id
 fu23-20020a17090ad19700b0029978487193mr5707892pjb.45.1708484982682; Tue, 20
 Feb 2024 19:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
 <20240220035105.34626-2-dongmenglong.8@bytedance.com> <81431b5d-0e0f-485a-a3ce-af8e63169552@gmail.com>
In-Reply-To: <81431b5d-0e0f-485a-a3ce-af8e63169552@gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Wed, 21 Feb 2024 11:09:31 +0800
Message-ID: <CALz3k9io7c6oGvCjfYr=1kb6Ndrh6RVgR5pHC5DzW-F_YGqjxA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next 1/5] bpf: tracing: add support to
 record and check the accessed args
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	thinker.li@gmail.com, zhoufeng.zf@bytedance.com, davemarchevsky@fb.com, 
	dxu@dxuuu.xyz, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:22=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 2/19/24 19:51, Menglong Dong wrote:
> > In this commit, we add the 'accessed_args' field to struct bpf_prog_aux=
,
> > which is used to record the accessed index of the function args in
> > btf_ctx_access().
> >
> > Meanwhile, we add the function btf_check_func_part_match() to compare t=
he
> > accessed function args of two function prototype. This function will be
> > used in the following commit.
> >
> > Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> > ---
> >   include/linux/bpf.h |   4 ++
> >   kernel/bpf/btf.c    | 121 +++++++++++++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 125 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index c7aa99b44dbd..0225b8dbdd9d 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1464,6 +1464,7 @@ struct bpf_prog_aux {
> >       const struct btf_type *attach_func_proto;
> >       /* function name for valid attach_btf_id */
> >       const char *attach_func_name;
> > +     u64 accessed_args;
> >       struct bpf_prog **func;
> >       void *jit_data; /* JIT specific data. arch dependent */
> >       struct bpf_jit_poke_descriptor *poke_tab;
> > @@ -2566,6 +2567,9 @@ struct bpf_reg_state;
> >   int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog);
> >   int btf_check_type_match(struct bpf_verifier_log *log, const struct b=
pf_prog *prog,
> >                        struct btf *btf, const struct btf_type *t);
> > +int btf_check_func_part_match(struct btf *btf1, const struct btf_type =
*t1,
> > +                           struct btf *btf2, const struct btf_type *t2=
,
> > +                           u64 func_args);
> >   const char *btf_find_decl_tag_value(const struct btf *btf, const stru=
ct btf_type *pt,
> >                                   int comp_idx, const char *tag_key);
> >   int btf_find_next_decl_tag(const struct btf *btf, const struct btf_ty=
pe *pt,
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 6ff0bd1a91d5..3a6931402fe4 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6203,6 +6203,9 @@ bool btf_ctx_access(int off, int size, enum bpf_a=
ccess_type type,
> >               /* skip first 'void *__data' argument in btf_trace_##name=
 typedef */
> >               args++;
> >               nr_args--;
> > +             prog->aux->accessed_args |=3D (1 << (arg + 1));
> > +     } else {
> > +             prog->aux->accessed_args |=3D (1 << arg);
> >       }
> >
> >       if (arg > nr_args) {
> > @@ -7010,6 +7013,124 @@ int btf_check_type_match(struct bpf_verifier_lo=
g *log, const struct bpf_prog *pr
> >       return btf_check_func_type_match(log, btf1, t1, btf2, t2);
> >   }
> >
> > +static u32 get_ctx_arg_total_size(struct btf *btf, const struct btf_ty=
pe *t)
> > +{
> > +     const struct btf_param *args;
> > +     u32 size =3D 0, nr_args;
> > +     int i;
> > +
> > +     nr_args =3D btf_type_vlen(t);
> > +     args =3D (const struct btf_param *)(t + 1);
> > +     for (i =3D 0; i < nr_args; i++) {
> > +             t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> > +             size +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
> > +     }
> > +
> > +     return size;
> > +}
> > +
> > +static int get_ctx_arg_idx_aligned(struct btf *btf, const struct btf_t=
ype *t,
> > +                                int off)
> > +{
> > +     const struct btf_param *args;
> > +     u32 offset =3D 0, nr_args;
> > +     int i;
> > +
> > +     nr_args =3D btf_type_vlen(t);
> > +     args =3D (const struct btf_param *)(t + 1);
> > +     for (i =3D 0; i < nr_args; i++) {
> > +             if (offset =3D=3D off)
> > +                     return i;
> > +
> > +             t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> > +             offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
> > +             if (offset > off)
> > +                     return -1;
> > +     }
> > +     return -1;
> > +}
>
> This one is very similar to get_ctx_arg_idx().
> How about to refactor get_ctx_arg_idx() and share the code
> between get_ctx_arg_idx() and get_ctx_arg_idx_aligned().
>

This seems to work, I'll combine them in the next version.

Thanks for the example code!
Menglong Dong

> For example,
>
> -static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type
> *func_proto,
> -                          int off)
> +static u32 _get_ctx_arg_idx(struct btf *btf, const struct btf_type
> *func_proto,
> +                          int off, u32 *arg_off)
>   {
>          const struct btf_param *args;
>          const struct btf_type *t;
>          u32 offset =3D 0, nr_args;
>          int i;
>
>          if (!func_proto)
>                  return off / 8;
>
>          nr_args =3D btf_type_vlen(func_proto);
>          args =3D (const struct btf_param *)(func_proto + 1);
>          for (i =3D 0; i < nr_args; i++) {
> +               if (arg_off)
> +                       *arg_off =3D offset;
>                  t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
>                  offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8)=
;
>                  if (off < offset)
>                          return i;
>          }
>
> +       if (arg_off)
> +               *arg_off =3D offset;
>          t =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
>          offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
>          if (off < offset)
>                  return nr_args;
>
>          return nr_args + 1;
>   }
>
> +static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type
> *func_proto,
> +                          int off)
> +{
> +       return _get_ctx_arg_idx(btf, func_proto, off, NULL);
> +}
> +
> +static u32 get_ctx_arg_idx_aligned(struct btf *btf,
> +                                  const struct btf_type *func_proto,
> +                                  int off)
> +{
> +       u32 arg_off;
> +       u32 arg_idx =3D _get_ctx_arg_idx(btf, func_proto, off, &arg_off);
> +       return arg_off =3D=3D off ? arg_idx : -1;
> +}
> +
>
> > +
> > +/* This function is similar to btf_check_func_type_match(), except tha=
t it
> > + * only compare some function args of the function prototype t1 and t2=
.
> > + */
> > +int btf_check_func_part_match(struct btf *btf1, const struct btf_type =
*func1,
> > +                           struct btf *btf2, const struct btf_type *fu=
nc2,
> > +                           u64 func_args)
> > +{
> > +     const struct btf_param *args1, *args2;
> > +     u32 nargs1, i, offset =3D 0;
> > +     const char *s1, *s2;
> > +
> > +     if (!btf_type_is_func_proto(func1) || !btf_type_is_func_proto(fun=
c2))
> > +             return -EINVAL;
> > +
> > +     args1 =3D (const struct btf_param *)(func1 + 1);
> > +     args2 =3D (const struct btf_param *)(func2 + 1);
> > +     nargs1 =3D btf_type_vlen(func1);
> > +
> > +     for (i =3D 0; i <=3D nargs1; i++) {
> > +             const struct btf_type *t1, *t2;
> > +
> > +             if (!(func_args & (1 << i)))
> > +                     goto next;
> > +
> > +             if (i < nargs1) {
> > +                     int t2_index;
> > +
> > +                     /* get the index of the arg corresponding to args=
1[i]
> > +                      * by the offset.
> > +                      */
> > +                     t2_index =3D get_ctx_arg_idx_aligned(btf2, func2,
> > +                                                        offset);
> > +                     if (t2_index < 0)
> > +                             return -EINVAL;
> > +
> > +                     t1 =3D btf_type_skip_modifiers(btf1, args1[i].typ=
e, NULL);
> > +                     t2 =3D btf_type_skip_modifiers(btf2, args2[t2_ind=
ex].type,
> > +                                                  NULL);
> > +             } else {
> > +                     /* i =3D=3D nargs1, this is the index of return v=
alue of t1 */
> > +                     if (get_ctx_arg_total_size(btf1, func1) !=3D
> > +                         get_ctx_arg_total_size(btf2, func2))
> > +                             return -EINVAL;
> > +
> > +                     /* check the return type of t1 and t2 */
> > +                     t1 =3D btf_type_skip_modifiers(btf1, func1->type,=
 NULL);
> > +                     t2 =3D btf_type_skip_modifiers(btf2, func2->type,=
 NULL);
> > +             }
> > +
> > +             if (t1->info !=3D t2->info ||
> > +                 (btf_type_has_size(t1) && t1->size !=3D t2->size))
> > +                     return -EINVAL;
> > +             if (btf_type_is_int(t1) || btf_is_any_enum(t1))
> > +                     goto next;
> > +
> > +             if (btf_type_is_struct(t1))
> > +                     goto on_struct;
> > +
> > +             if (!btf_type_is_ptr(t1))
> > +                     return -EINVAL;
> > +
> > +             t1 =3D btf_type_skip_modifiers(btf1, t1->type, NULL);
> > +             t2 =3D btf_type_skip_modifiers(btf2, t2->type, NULL);
> > +             if (!btf_type_is_struct(t1) || !btf_type_is_struct(t2))
> > +                     return -EINVAL;
> > +
> > +on_struct:
> > +             s1 =3D btf_name_by_offset(btf1, t1->name_off);
> > +             s2 =3D btf_name_by_offset(btf2, t2->name_off);
> > +             if (strcmp(s1, s2))
> > +                     return -EINVAL;
> > +next:
> > +             if (i < nargs1) {
> > +                     t1 =3D btf_type_skip_modifiers(btf1, args1[i].typ=
e, NULL);
> > +                     offset +=3D btf_type_is_ptr(t1) ? 8 : roundup(t1-=
>size, 8);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf=
_type *t)
> >   {
> >       const char *name;

