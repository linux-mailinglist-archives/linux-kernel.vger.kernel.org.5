Return-Path: <linux-kernel+bounces-102116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D3687AE89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFFA2845D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8146996A;
	Wed, 13 Mar 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVCVpYxB"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F96A034;
	Wed, 13 Mar 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349042; cv=none; b=JCu1Vuahf5rq/tmh531lxD9PGmsLpBVcguZ7Ax2Z90Y5T7sjFf2KZ6gSZAn5ZJCJeSrKVj7eyd/x+nFb77O80Xon8oX3vs1Ha6d0w50mtj3e00DEpXz23yVkHGFWjCM6vud7wlKyqHtddnoXz6R0+W5eZJKbu8dBS6IC/md+sgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349042; c=relaxed/simple;
	bh=zWkvPDSr4nWceYKN+DiHB+DpnKp//0SZn+eJKoVGCIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7qeSHNdlnYJdVRJZkx3L7TkOpB5tq+hCi9n9pamysb2gdD/ujq36B1iO6Hni20ItndkP9+F7tx49MWW9M+IaQV7gP2YQyWlFq5O+tAY8+de9mg7TbsGZG1BVgIhJPZyPwFFCbqilh7RnwxBozKdvvrE0gbY2Hli2mnVFQvWAb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVCVpYxB; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so14188a12.1;
        Wed, 13 Mar 2024 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710349040; x=1710953840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcUZAbVkq0HpTHMJX+97jvTzRlAnbhGCRg9qoOkVutc=;
        b=cVCVpYxBENyq1mPEAXl3RfaBtgUugIw2cj+o0WB8a5ZjAOrEanKUNthSGWh4w7u/EL
         SDSJmNCfPQAL68yVu3mtDWGCNCwPYb1FUUtBX4VeSHdcGomUCwWQvr2M0VFiPNNIWx2e
         pt4k28XB11xXD8qZhc0Qh3D8/2t3CmFp33DeAYucMVPvzIYPE+GTh2pXIRwwD/3SRNuL
         wo80mDW6+wwF8iQ1ssT2vqCmpPKLftNUvSV2KUv3B0yh+OEU2GmI0t/vD6wIBoJ1wYYk
         s/21OlHs9+w7qa+kn0TxntRqb86i4ywmbr2/mKAAIvh66/B0vAdmhgJG7HeWpl2tG9Ip
         F6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710349040; x=1710953840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcUZAbVkq0HpTHMJX+97jvTzRlAnbhGCRg9qoOkVutc=;
        b=sz2kdw2BsKkDP2iYnQPsdlYlzwcwaN69My/yhX+AMmmCSUCKteefjrkubFWNkADmBz
         tWx87sK1ZJgev8pDXGs8EVo+hfZ2tqiPCCTeejklnBoZAR3rv8Fj4XFx2KnXZhBntJJ/
         uWTnPF7Oj6cAr/aZeUgAlcTDfqPp/+BzzvDv9qDQHzNJ0OzOJM+HZowTbEB2nfNAO9Y9
         q7CYf/E0kRKzzKne0qLrcdyIbVzE7KcvTBXyI/UNDUE1xXwwDp0qxEZt9t2mFERNRPCJ
         KkquEqkspO3f0L/0/Es2lNzxx5izR7ZVTEFTunTzuypxYAXN+qYIrXJCANlJzDRO7xU2
         tLzg==
X-Forwarded-Encrypted: i=1; AJvYcCXVfaLKIxznNeIjr4dVXNEoyHVHg01sd1RhjgOD5lfaZ4BfRAx5thuZryXnHFRf+pIBpfVrSULAFm02oal2+D8K5UZJtm/i0YUXClAm0wLhk1MxxHtrs5aSVOXkvT4UXk4a8njkaRCR0t8f+h7MyNUrh/vSxi/G48YgrUhXmdgDNzB2J4T1
X-Gm-Message-State: AOJu0Yzm4YevQmUhk9Iu46iUBw6/K65/GGx9YqpDkz98cm6yaUKbYmOz
	RfxFfl6usAY4Qy8BbiA5no8dK1e/oxbWo3UggDbVg31dL+H4yW5KA35ZEbS0QLp7DXz6QxtrYjm
	cqS21KRAt4AssiGyW5uJGGu/cdeQ=
X-Google-Smtp-Source: AGHT+IGyGPJjOFnPQxps+GSyJhPCPCChdeziQP5s6fat3MumqhQnMduQK8qzg1G2YZ0Al3EVqKKwOuOKv4spRx6o/3g=
X-Received: by 2002:a05:6a21:6da7:b0:1a3:1255:6062 with SMTP id
 wl39-20020a056a216da700b001a312556062mr4824539pzb.1.1710349040424; Wed, 13
 Mar 2024 09:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312210233.1941599-1-andrii@kernel.org> <20240312210233.1941599-3-andrii@kernel.org>
 <20240313154716.GB25452@redhat.com>
In-Reply-To: <20240313154716.GB25452@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Mar 2024 09:57:08 -0700
Message-ID: <CAEf4BzYFzLuGB93digNwCnHZ=LEjxvyfPb4GcF3Mwqi-JP3skw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] uprobes: prepare uprobe args buffer lazily
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 8:48=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Again, looks good to me, but I have a minor nit. Feel free to ignore.
>
> On 03/12, Andrii Nakryiko wrote:
> >
> >  static void __uprobe_trace_func(struct trace_uprobe *tu,
> >                               unsigned long func, struct pt_regs *regs,
> > -                             struct uprobe_cpu_buffer *ucb,
> > +                             struct uprobe_cpu_buffer **ucbp,
> >                               struct trace_event_file *trace_file)
> >  {
> >       struct uprobe_trace_entry_head *entry;
> >       struct trace_event_buffer fbuffer;
> > +     struct uprobe_cpu_buffer *ucb;
> >       void *data;
> >       int size, esize;
> >       struct trace_event_call *call =3D trace_probe_event_call(&tu->tp)=
;
> >
> > +     ucb =3D *ucbp;
> > +     if (!ucb) {
> > +             ucb =3D prepare_uprobe_buffer(tu, regs);
> > +             *ucbp =3D ucb;
> > +     }
>
> perhaps it would be more clean to pass ucbp to prepare_uprobe_buffer()
> and change it to do
>
>         if (*ucbp)
>                 return *ucbp;
>
> at the start. Then __uprobe_trace_func() and __uprobe_perf_func() can
> simply do
>
>         ucb =3D prepare_uprobe_buffer(tu, regs, ucbp);

ok, will do

>
> > -     uprobe_buffer_put(ucb);
> > +     if (ucb)
> > +             uprobe_buffer_put(ucb);
>
> Similarly, I think the "ucb !=3D NULL" check should be shifted into
> uprobe_buffer_put().

sure, will hide it inside uprobe_buffer_put()

>
> Oleg.
>

