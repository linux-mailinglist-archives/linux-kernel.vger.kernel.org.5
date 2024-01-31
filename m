Return-Path: <linux-kernel+bounces-47225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8611C844AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F9F1F29918
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6357039AFE;
	Wed, 31 Jan 2024 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aR4LrGii"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3D39AE3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738674; cv=none; b=kjYhE9C86yDQxFmY6y4t83eGlshKZi2zLW7DuE1/LLAm4HlCjBuXuzFWEzeTwUmUuru/KhDj2o/vD65iM49vK5JlJAppmMi7rCTcoeGGj2sjxJcdzlM89OpqShxpxxTnR9bBFrhhGQSlV9OnG4I8zpjYW7Hal79K0N0tokt0AAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738674; c=relaxed/simple;
	bh=xlAN2QLDnWTPrzGA96Nc3PWumrZqgEr6+/uaJjDOMBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufXbTFrQNeM+vBS2lmmP/+rwXElSeQHmrfX9lBBYn4tzceP0/d780M9iuHBI66tFyMEMqcbb8quvlRmuZ4QNhbbJhF4GYbcmRjFve71jyVUzab1AF6k0hNWKWKXKen4GzflKfugDjmUrw9eJBExWnt0Xrlk9E2NR7yNqVT4qb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aR4LrGii; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706738671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2B+y4zcCSl6e8cZoEf8NGUQNYqPAkNPFv+7JRkypuQ=;
	b=aR4LrGiiVXxAWsaoN52kyaJ3z8sIkEcvhETIv7Jvtv+SKRMoVRYFRrLeXf8ze5nk7VUKF3
	DyzzpbVbOfPIsDrbgn2qKHTpxiARna900X/BU/0tgiGY+Gagzzc6gVsb972hGZdZFtGuPY
	pE3h3v04jqv1e/biCOqu4mwTAtYocMk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-RVFZnAT3NGWRLmEri1ej-w-1; Wed, 31 Jan 2024 17:04:29 -0500
X-MC-Unique: RVFZnAT3NGWRLmEri1ej-w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40fa6610ddfso1809845e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706738668; x=1707343468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2B+y4zcCSl6e8cZoEf8NGUQNYqPAkNPFv+7JRkypuQ=;
        b=rOFqabnDi1MDWEyAwFjTTYIPnhSlrtkeSg7ozzQJxwMyVxPyVjneBYQWF2KyduReCj
         /qws3cDPYljoG5807BodIAl28ahlcHId/NF1j6TiI2E7lMPQEWDqeiPR+Xz5MuZPF4Fv
         EHgwpnuPr5fjvvZxLA8NLnYGuyZI484udMiunkbtBuVcYvLdp1RnHvwhA/zIg47hnn7n
         xqiLdy3AKz4ixEUSs1EPefDNlnS+LZRjL8CPGp6NwZ+kKDTAeoweon8M6MiV5EU+4krG
         byyc2SyUWaNG5wz6CsFxlNYVqCLZfTuqFQBpS2wWKFEPgEWX22eAA/XriSZ1vsGVk1Vz
         4Upw==
X-Gm-Message-State: AOJu0YwtlH7QDIzmurACSA5Wp18lqOhVTEEXIi+Ll1xVxpcy8C/ve+l3
	jlDO3yGXSSvCOMZ6rJufV5h7orjcQHIA4LTOL+uRmenXnfm12zwxNCcs2FaPvYmFCw5aEQakFMT
	st0Vwu47NpsR8SWyxO8TdHq7b2cl10q1KqH+AC6j6EwFRM0i4a+YDTNQ0zhWwDy0WUrLUT8eDML
	Qh8KxrrMCcU0n9POBLTicXAhPMiKHS5Mbp2k6p
X-Received: by 2002:a5d:4e83:0:b0:33a:e52b:b70a with SMTP id e3-20020a5d4e83000000b0033ae52bb70amr1797952wru.52.1706738668722;
        Wed, 31 Jan 2024 14:04:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUSR+gKqKBrSwFxjGQplhODAFtwIlGGnvArNv3hse5pGus1FlrI6TWmmcrVEpdOnaHl9kI7lavlY04wu9cQHU=
X-Received: by 2002:a5d:4e83:0:b0:33a:e52b:b70a with SMTP id
 e3-20020a5d4e83000000b0033ae52bb70amr1797935wru.52.1706738668099; Wed, 31 Jan
 2024 14:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170561158585.591793.15929255265114320850@demetrius> <20240124094843.K-b1_mn7@linutronix.de>
In-Reply-To: <20240124094843.K-b1_mn7@linutronix.de>
From: Clark Williams <williams@redhat.com>
Date: Wed, 31 Jan 2024 22:04:17 +0000
Message-ID: <CAMLffL8qyNCocBGtxfDO49dORs_QFdv-6ZrvBEbhxjoBBk4rrw@mail.gmail.com>
Subject: Re: [ANNOUNCE] 6.6.12-rt20
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>, 
	Daniel Wagner <daniel.wagner@suse.com>, Tom Zanussi <tom.zanussi@linux.intel.com>, 
	Pavel Machek <pavel@denx.de>, Joseph Salisbury <joseph.salisbury@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll revert that commit and re-release the 6.6.14 I just pushed

On Wed, Jan 24, 2024 at 9:48=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-01-18 20:59:45 [-0000], Clark Williams wrote:
> > Hello RT-list!
> Hi Clark,
>
> > I'm pleased to announce the 6.6.12-rt20 stable release.
>
> I've been looking over it and it looks okay. Then I compared how it
> would do it vs your outcome and noticed this:
>
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -575,12 +575,6 @@ static int check_unaligned_access(void *param)
>         if (per_cpu(misaligned_access_speed, cpu) !=3D RISCV_HWPROBE_MISA=
LIGNED_UNKNOWN)
>                 return;
>
> -       page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE=
));
> -       if (!page) {
> -               pr_warn("Can't alloc pages to measure memcpy performance"=
);
> -               return;
> -       }
> -
>         /* Make an unaligned destination buffer. */
>         dst =3D (void *)((unsigned long)page_address(page) | 0x1);
>         /* Unalign src as well, but differently (off by 1 + 2 =3D 3). */
>
> You shouldn't allocate that page. Nobody will free it, that page is
> passed via an argument now. Please drop hunk.
>
> While at it, do you think you can drop patch
>    preempt-Put-preempt_enable-within-an-instrumentation.patch
>
> or revert commit
>    c15abad8f7159 ("preempt: Put preempt_enable() within an instrumentatio=
n*() section.")
>
> I've been looking over it and it is fixed as of v6.6 so this patch is no
> longer needed.
>
> > Enjoy!
> > Clark
>
> Sebastian
>


