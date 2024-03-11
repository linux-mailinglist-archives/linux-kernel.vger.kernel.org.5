Return-Path: <linux-kernel+bounces-99334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8C88786CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CD42810F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780B7535AF;
	Mon, 11 Mar 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1JQeV7b"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4334C631;
	Mon, 11 Mar 2024 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179771; cv=none; b=bv0KeSgCCJn+FiuRRv4NsBK5uf2SMI2IX/flaXGw4l/HO8ZqPUEkAJKjGGTwTWVBUDGLo5hGDOjobXvVUQIQlUKOco6ER2v9+oWQuAoMTFgqkPyTSfXOVkEH0h8Pe04XYSFhgfWomZX4HaxAILGY7RIbOafb+5o8o89em95txL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179771; c=relaxed/simple;
	bh=2sHTM97y6Ae9lduC17X4CVIj9RmYErbw28IMnyPzK8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYDf2Xz2FaQnBtqXXDNONAr3odqzh/gs5TVud+BEGKaAXK1oyw6mjBxHzfSZO56GywcaXMSceGhqW5rAYsVuugA18DVfIQQ67b5g9wyYCWHK0r+EYKW7tY3fD2WNpmZhRyn2uKGZ0LhflbcoNdZdzjszChEJ1HB9xVe2RHufNuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1JQeV7b; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so3042826a12.1;
        Mon, 11 Mar 2024 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710179770; x=1710784570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yA5M5kpASFinQzBucQIe6R0OuQDkEP28n5sfVDn4lPc=;
        b=N1JQeV7buFwUk5r48st+Ef1KwXH8aIbNNv0Un9zEV4zCtewyMMMEYWMdFQXl7b5rNU
         TymjHNpn5nAeIWhH51Qj62Px1dr/h22Ozy8kJXRtMszXe9s4w6L1k2O+wsIhQm4STNkT
         qCeS17FQW0f8HhqVyfm00zKHnvKCgLGXYdrHviO1sY2IV33iQYTqiwYRTO5nK1pliX8I
         A/hJF8N53Aq9y4u5+1E7YIe0r8Q9+QXcDhjsk8KC8ujVsPZaG3LD6dvCVq6J8wAARMOT
         Ox5WW0MDb9SzuljqJESN50FSHcXnfIWn8kVhpU4jLev43THqHw2Unr6MWiUTLeFIYnqk
         EfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710179770; x=1710784570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yA5M5kpASFinQzBucQIe6R0OuQDkEP28n5sfVDn4lPc=;
        b=YrFxn6nIc/G59mH3ch/eAfG4nYMzrCQ5GXqDh9tM/mphGTAVqdNTORl68hRPFvfQeJ
         jVkCaIeaZSlU+FT5O6o7yZZDL/jsUkdWgF8yJbBCtELfshvb3SKGGTzTuDO1UF0BBPmZ
         b93uLNnPUukqaY3iAM7gvkoCDdoeHW7whYYcfSFdSyFaR7v1gZlPKxfY6sLy7cOWmu1U
         XA+uVtszxGNb2+zvdcuc6nTu/fNr0teQ49QS+Vow+D2CnNg+d2AjV62DinWCP2vGFiXM
         yOlKA0FOiji/BqeEL4p5lQs4lQAGqo+AJ1O7GyezpvUecLrM2G7jJnFfM4HagBxvETyT
         Wl+w==
X-Forwarded-Encrypted: i=1; AJvYcCXCBYC9KZHqZdFvmORL9D1cuTxlrIELBPkDH1xY0WxQXICTfijI2Bbiy+hFQeF2HuN6X2/LE74pRlswtqT5kCTRzvhugUwAiwTApHhtEFmavIPpWq7PzhCpKcS6PhVpvID+
X-Gm-Message-State: AOJu0Yxk25N+y6SmuO7BIDf5SF26JiaOMI9M48Fa6g80QKDfEt2gl/Ut
	bnkSmo76WJKBIKoY6rtEiqMfNZo6cgYLRRCmPHhwec4Nho6yeHZQeHN1nzxOE7x7bN3OF+uUafH
	9HHUGji721/Cl5qEGqC6mzyRJk6Q=
X-Google-Smtp-Source: AGHT+IGmceLJx9agIv6BGQlFZEwEv807foK6FXOon+/fe1VfiZLBlWJjK50x0/uje3HacOpp0lRoQlNZsZCEy7Zs7UA=
X-Received: by 2002:a17:90b:4007:b0:29c:e1b:f9e2 with SMTP id
 ie7-20020a17090b400700b0029c0e1bf9e2mr2261232pjb.25.1710179769736; Mon, 11
 Mar 2024 10:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310154726.734289-1-andrea.righi@canonical.com>
In-Reply-To: <20240310154726.734289-1-andrea.righi@canonical.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Mar 2024 10:55:57 -0700
Message-ID: <CAEf4BzYrwRQu1eNMACfXtsac+=psnNGr+=WQz3zUPP+2DPA2Rg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: ringbuf: allow to partially consume items
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 8:47=E2=80=AFAM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> Instead of always consuming all items from a ring buffer in a greedy
> way, allow to stop when the callback returns a value > 0.
>
> This allows to distinguish between an error condition and an intentional
> stop condition by returning a non-negative non-zero value from the ring
> buffer callback.
>
> This can be useful, for example, to consume just a single item from the
> ring buffer.
>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  tools/lib/bpf/ringbuf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index aacb64278a01..dd8908eb3204 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -265,6 +265,14 @@ static int64_t ringbuf_process_ring(struct ring *r)
>                                         return err;
>                                 }
>                                 cnt++;
> +                               if (err > 0) {

So libbpf already stops at any err < 0 (and sets correct consumer
pos). So you could already get desired behavior by just returning your
own error code. If you need count, you'd have to count it yourself
through custom context, that's a bit of inconvenience.

But on the other hand, currently if user callback returns anything > 0
they keep going and that return value is ignored. Your change will
break any such user pretty badly. So I'm a bit hesitant to do this.

Is there any reason you can't just return error code (libbpf doesn't
do anything with it, just passes it back, so it might as well be
`-cnt`, if you need that).

pw-bot: cr

> +                                       /* update consumer pos and return=
 the
> +                                        * total amount of items consumed=
.
> +                                        */
> +                                       smp_store_release(r->consumer_pos=
,
> +                                                         cons_pos);
> +                                       goto done;
> +                               }
>                         }
>
>                         smp_store_release(r->consumer_pos, cons_pos);
> --
> 2.43.0
>
>

