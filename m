Return-Path: <linux-kernel+bounces-102110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974AE87AE80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538D22840F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70485F858;
	Wed, 13 Mar 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2SmWq1g"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674A5F541;
	Wed, 13 Mar 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348792; cv=none; b=P/FnVOQTz6D03c5s37f7HxqX0hyhh3+Qfbwmm88IhqCnLNpzO6ge3rRgwRjLmPqh4wSh2JDNje1IvoeWZzh/ESLrKHRpsY8GSfJThdCbN7xZepJlt7sfJRJIISSy60WFHX5IWWOtrOjOwVTh52FttHxaPrQypWv676wK7/B9Kl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348792; c=relaxed/simple;
	bh=xCzpgaA+HTbALS3/kwZcZ+auovGGgbqRsKa38fzJmHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYyziY+f4Czq2eDiX+rBM9o8IoVIVui4SwjsPDIY5tCf5B2dy6K+8KDHJuaGTX9su0PZ4387xaKKpyCr9AnRzSJcvdXEhNYj7tl5GxxKROubYTUJO+QBcCyqu+OVTyBpPKH11QYGSd7J24vM5uzZ0Z/FfxjYP78D533BeeULh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2SmWq1g; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29bbff1505dso103129a91.0;
        Wed, 13 Mar 2024 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710348789; x=1710953589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u8ZrY8sdFo2g+CmoHjb0TtVHcvA+5O3rJ7eccy6sco=;
        b=f2SmWq1gAhW3BbvQQgboyimm+ZMdmYja/LyNaR85Ff/koVW57VgPhehnbLBk6CBHjT
         6TacvkWrj8w6g719vbnzvvN0UIae3JqigehFM+ZBgyH6hEq0+o0eqUXcjH8Nf31cP/vz
         XipVLr/AuKcm/dB31jQMlverAw+AUIRTN5frs37Hro/EurIuAlY/KAQfMz+ospO6s8Ug
         Yqoz0sEqX457qL5C7NafgvnxQ0LYT6RZY4qczJyR1Kevp77BtLZt/56dOy30wwCKX881
         nZgFSjjO7kPg6vS4rtTpUIrQLzdSNm1bZxQT3hzi7kXeTRPRLCJ2j1C6kOGetfwcYFam
         xf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710348789; x=1710953589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u8ZrY8sdFo2g+CmoHjb0TtVHcvA+5O3rJ7eccy6sco=;
        b=JfI5K+M/4xj+IOs+JhEtxgEpgRBRd4vOsVrvUWvMmVg/WDE9MjDi/1UR8y0lSfC7dR
         Q+zS6lZ0A0uvyMnLKyxvBVtVbLzRWxFWuyroDM0+zKi8ARFqLxictjBPfGumlO1mO0Vx
         HdspDIEneXwbVLd2GsR8Qj3raDbeQp3kCgz4JvbdrHEG/VGZBXUw7mSp5Adzv27rBNd9
         XWfL8rAkzEYS+d3YPvtEHnaQKMcanwcVj9f/Fmb5gRQR7MClB+iCg97v8R0dAUm7aHRH
         Ad1cP43W9UPt6yyL1MQEoIT3zuMnWZgwQP+E7e8v4Bmr8tZVXQX29fLWHnOuw41jpsYj
         F5ag==
X-Forwarded-Encrypted: i=1; AJvYcCX7b59aSF4ADjWzvgz2/m1Y/zDYQ7XAPGL2xWK1xGImjuP4Ytp1Ac1LZsRYEfYkLC42mMERYxW9tv28lYYQJLfoLDVQmbtSNl0u2TICJ3FQQHA7Xy+xtb1M9LyPMsVKRtNwTiGOgOv50nalMdWhZ4Bt5aai/epT9Hce4y9uN0gMwR+aZKzg
X-Gm-Message-State: AOJu0YxPmISrHVHEgv9yPEH1y02NgXqHIS/5BMwhVMhxkOSUf9eUCE86
	I53lC7vzdsXi2hXU2nPe+iULtK3JugJs7PDKn3vUut+u1wIkCcRfQ4JieVztB3Ftp0a2H8HYl4+
	ecxTkYWinKq2uY9FopbXWV7djQIhtr6Ss
X-Google-Smtp-Source: AGHT+IEKjZFpcEzhNIwyrlO8/dl5vFNshA/6fBoRE3yJXIKiK1GOk90qYsxtCTPxpE386HMmh5WhBrtUik7VqjarrqE=
X-Received: by 2002:a17:90a:a407:b0:29b:ab0e:4f03 with SMTP id
 y7-20020a17090aa40700b0029bab0e4f03mr10231243pjp.37.1710348789075; Wed, 13
 Mar 2024 09:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312210233.1941599-1-andrii@kernel.org> <20240312210233.1941599-2-andrii@kernel.org>
 <20240313151507.GA25452@redhat.com>
In-Reply-To: <20240313151507.GA25452@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Mar 2024 09:52:56 -0700
Message-ID: <CAEf4BzbXew_qC4NaA7vtqS5fFwkh6Hw-uKLq3UDD7GjGAP6UeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] uprobes: encapsulate preparation of uprobe
 args buffer
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 8:16=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> LGTM, one nit below.
>
> On 03/12, Andrii Nakryiko wrote:
> >
> > +static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_up=
robe *tu,
> > +                                                    struct pt_regs *re=
gs)
> > +{
> > +     struct uprobe_cpu_buffer *ucb;
> > +     int dsize, esize;
> > +
> > +     esize =3D SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
> > +     dsize =3D __get_data_size(&tu->tp, regs);
> > +
> > +     ucb =3D uprobe_buffer_get();
> > +     ucb->dsize =3D dsize;
> > +
> > +     store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
> > +
> > +     return ucb;
> > +}
>
> OK, but note that every user of ->dsize adds tp.size. So I think you can
> simplify this code a bit more if you change prepare_uprobe_buffer() to do
>
>         ucb->dsize =3D tu->tp.size + dsize;
>
> and update the users.
>

makes sense, done

> Oleg.
>

