Return-Path: <linux-kernel+bounces-36760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127FB83A621
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B099A284B48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9061182D8;
	Wed, 24 Jan 2024 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2YwMxYI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0F18049
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090352; cv=none; b=SPrEHfiyAqIijIyXs2VEIvKc9RQFsiusdAow/1jIB5EFETRlCqdVQjyQSZwXdbc2obCMIznWklxUUFL7nhEWVVCzlnamC3FK6IUccxfqu7AGAi0rEPPw+Deweuyge7SUHIl+tga9h8LzcC9rh7/PN2iNX7gDHVejudoWKclUwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090352; c=relaxed/simple;
	bh=15Q4F0kE4qahoEyJ6HulrWZpeQdJz1QfwlrrMXu0l60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umrmPzys09nO0tssAsASNHuz+nriLy4Qr0FgiWis0hWyQ5H8x/kORBRhHHZ97gYqx6/7sRBl7ZHrLtmxhGBSH7ErIWPAix+2NpEmn5v4JPV6zfuhm04YR5QCptcJkmThjs2GOTcfh1QgZ0p/SjICiMhBbFqsWrksCvWhN4ssRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2YwMxYI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706090349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ycwyiuq6MSu6fJ8T9ykxWOzW0MDrM+yl5NgqcP5LEEo=;
	b=Q2YwMxYIKaMhNNdhbUbK5IAMH4BTuo3eUZZZKhdvWyFz+fkX24v3gJQp0WatAQqidiMUVi
	N4GB15dtlHOKOJL6WVQLrx/8rxZ3/SpdvLBWJCQH13MBNBKWTV0DJiZqLDACorxOJGQUcg
	UNgydm6hrayvuYvevW6L5qE55fTybrw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-Ys-px2dtOqOlbc5ocZcr_Q-1; Wed, 24 Jan 2024 04:59:07 -0500
X-MC-Unique: Ys-px2dtOqOlbc5ocZcr_Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a309495ba10so129813166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706090346; x=1706695146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ycwyiuq6MSu6fJ8T9ykxWOzW0MDrM+yl5NgqcP5LEEo=;
        b=wwvhARirx2NL70sz6JZhTc9Hvxx2aeFEzkVLQHKA3XATQWscy7326m29nS+7RWeRPw
         gu6V63mrAezk12f5BSqLJ35ZJVQk1jrcKOO9nVBuGEWWKM5Oqo+aefhhWhxgeOxwbzf9
         2Vvqb4/aKBwMdjUfkUlhucAfn2d+FReo73z2dtww/PYe1GgG1pN0EWEVALDKaLOwQZfp
         SwyDbzOygzSm41Zekqle1rA4nzb3HKdRU3pSAHrFc+k7t3vVBXtgfC5yHzos3rtcJiht
         7mUMAA0fxaUnUPjsEbOUs/jUul5Ufo7kJPbkrRsuW2Vste67nPPh7BQr0FxpM6FuP0pR
         j29Q==
X-Gm-Message-State: AOJu0YxVs5bsZKFBloTjbRFKb/4eA1QLtQhh0BF+8WeYeGyba6QgRwLW
	biUnSEn9C5kKeUUGOqZENTk8tFDro9KkpdDn6b23ZaEpTaEDXnJE5jHjXXMP2C2fvinO7s730Ke
	XOVWj9/iuyw/8JDHz5Q4u1k5ZioTigWVFNpquh8PipGDt4ofUBAjcUw4qx1dlgxoTpPWlLOFSUN
	NFYDw0IyT+R8+SHG/XKagho4Tt/yilgU9MTtsd
X-Received: by 2002:a17:907:8748:b0:a28:c217:ce8e with SMTP id qo8-20020a170907874800b00a28c217ce8emr759043ejc.124.1706090346420;
        Wed, 24 Jan 2024 01:59:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPu5nlNtWGHZaLtZ37i6pNs7lvberqRiX4p3cwtvFz0zIWKs9cFdhli4kiokFcEr5hYFR3LhDmpONRZqAnA+A=
X-Received: by 2002:a17:907:8748:b0:a28:c217:ce8e with SMTP id
 qo8-20020a170907874800b00a28c217ce8emr759038ejc.124.1706090346097; Wed, 24
 Jan 2024 01:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-b4-hid-bpf-fixes-v1-0-aa1fac734377@kernel.org>
 <20240123-b4-hid-bpf-fixes-v1-2-aa1fac734377@kernel.org> <CAEf4BzbE-YHR1FuXfG7ryi_77H=nzF0XBoppqrbG4Uh1uPz8Lg@mail.gmail.com>
In-Reply-To: <CAEf4BzbE-YHR1FuXfG7ryi_77H=nzF0XBoppqrbG4Uh1uPz8Lg@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 24 Jan 2024 10:58:53 +0100
Message-ID: <CAO-hwJL4UMQMOC-CQKXZ_Np2b7H2rSnAji=Yypc62k_+GejwcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: bpf: use __bpf_kfunc instead of noinline
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jan 23, 2024 at 8:46=E2=80=AFAM Benjamin Tissoires <bentiss@kerne=
l.org> wrote:
> >
> > Follow the docs at Documentation/bpf/kfuncs.rst:
> > - declare the function with `__bpf_kfunc`
> > - disables missing prototype warnings, which allows to remove them from
> >   include/linux/hid-bpf.h
> >
> > Removing the prototypes is not an issue because we currently have to
> > redeclare them when writing the BPF program. They will eventually be
> > generated by bpftool directly AFAIU.
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> >  drivers/hid/bpf/hid_bpf_dispatch.c | 22 +++++++++++++++++-----
> >  include/linux/hid_bpf.h            | 11 -----------
> >  2 files changed, 17 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_b=
pf_dispatch.c
> > index 5111d1fef0d3..119e4f03df55 100644
> > --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> > +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> > @@ -143,6 +143,11 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hd=
ev, u8 *rdesc, unsigned int *s
> >  }
> >  EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
> >
> > +/* Disables missing prototype warnings */
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +                 "Global kfuncs as their definitions will be in BTF");
> > +
>
> would it be possible to use __bpf_kfunc_start_defs() and
> __bpf_kfunc_end_defs() macros instead of explicit __diag push/pop
> pairs? It's defined in include/linux/btf.h

Sure, I'll use them in v2.

I also realized that I had some memory leaks because I never called
put_device() after bus_find_device(), so I need to add another fix to
this series.

Cheers,
Benjamin

>
> >  /**
> >   * hid_bpf_get_data - Get the kernel memory pointer associated with th=
e context @ctx
> >   *
> > @@ -152,7 +157,7 @@ EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
> >   *
> >   * @returns %NULL on error, an %__u8 memory pointer on success
> >   */
> > -noinline __u8 *
> > +__bpf_kfunc __u8 *
> >  hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const s=
ize_t rdwr_buf_size)
> >  {
> >         struct hid_bpf_ctx_kern *ctx_kern;
> > @@ -167,6 +172,7 @@ hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned =
int offset, const size_t rdwr
> >
> >         return ctx_kern->data + offset;
> >  }
> > +__diag_pop(); /* missing prototype warnings */
> >
> >  /*
> >   * The following set contains all functions we agree BPF programs
> > @@ -274,6 +280,11 @@ static int do_hid_bpf_attach_prog(struct hid_devic=
e *hdev, int prog_fd, struct b
> >         return fd;
> >  }
> >
> > +/* Disables missing prototype warnings */
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +                 "Global kfuncs as their definitions will be in BTF");
> > +
> >  /**
> >   * hid_bpf_attach_prog - Attach the given @prog_fd to the given HID de=
vice
> >   *
> > @@ -286,7 +297,7 @@ static int do_hid_bpf_attach_prog(struct hid_device=
 *hdev, int prog_fd, struct b
> >   * is pinned to the BPF file system).
> >   */
> >  /* called from syscall */
> > -noinline int
> > +__bpf_kfunc int
> >  hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
> >  {
> >         struct hid_device *hdev;
> > @@ -328,7 +339,7 @@ hid_bpf_attach_prog(unsigned int hid_id, int prog_f=
d, __u32 flags)
> >   *
> >   * @returns A pointer to &struct hid_bpf_ctx on success, %NULL on erro=
r.
> >   */
> > -noinline struct hid_bpf_ctx *
> > +__bpf_kfunc struct hid_bpf_ctx *
> >  hid_bpf_allocate_context(unsigned int hid_id)
> >  {
> >         struct hid_device *hdev;
> > @@ -359,7 +370,7 @@ hid_bpf_allocate_context(unsigned int hid_id)
> >   * @ctx: the HID-BPF context to release
> >   *
> >   */
> > -noinline void
> > +__bpf_kfunc void
> >  hid_bpf_release_context(struct hid_bpf_ctx *ctx)
> >  {
> >         struct hid_bpf_ctx_kern *ctx_kern;
> > @@ -380,7 +391,7 @@ hid_bpf_release_context(struct hid_bpf_ctx *ctx)
> >   *
> >   * @returns %0 on success, a negative error code otherwise.
> >   */
> > -noinline int
> > +__bpf_kfunc int
> >  hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
> >                    enum hid_report_type rtype, enum hid_class_request r=
eqtype)
> >  {
> > @@ -448,6 +459,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *b=
uf, size_t buf__sz,
> >         kfree(dma_data);
> >         return ret;
> >  }
> > +__diag_pop(); /* missing prototype warnings */
> >
> >  /* our HID-BPF entrypoints */
> >  BTF_SET8_START(hid_bpf_fmodret_ids)
> > diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
> > index 840cd254172d..7118ac28d468 100644
> > --- a/include/linux/hid_bpf.h
> > +++ b/include/linux/hid_bpf.h
> > @@ -77,17 +77,6 @@ enum hid_bpf_attach_flags {
> >  int hid_bpf_device_event(struct hid_bpf_ctx *ctx);
> >  int hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx);
> >
> > -/* Following functions are kfunc that we export to BPF programs */
> > -/* available everywhere in HID-BPF */
> > -__u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, c=
onst size_t __sz);
> > -
> > -/* only available in syscall */
> > -int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)=
;
> > -int hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf_=
_sz,
> > -                      enum hid_report_type rtype, enum hid_class_reque=
st reqtype);
> > -struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id);
> > -void hid_bpf_release_context(struct hid_bpf_ctx *ctx);
> > -
> >  /*
> >   * Below is HID internal
> >   */
> >
> > --
> > 2.43.0
> >
> >
>


