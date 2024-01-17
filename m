Return-Path: <linux-kernel+bounces-29268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77456830BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCC428BB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473F5225DD;
	Wed, 17 Jan 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D7oJnCpW"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318121A0E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512107; cv=none; b=iWbI7CzZyNOlNibn4gMSC0LoTlscO0yXLgCr8KoDC3Hz+VKIQGOtRBqqgtMgPgV+Kux1IXeaUZF5AET2gXB8nkYDUL8DzC3DhLFsSdtHDKmldDbYrF9IsayPuHLhicgrSeSszfYhlnWp35XP3cNyMmvUmZORbdEND7u5RFCvUTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512107; c=relaxed/simple;
	bh=vwJ72PoSiCDBjaA+okTI+Kg6BS/K0JeEgtI4ljotfO8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=S3LHxyyC3+QFcYHVugX0pCrxvzYDCZL4/vh1DYl1F7PSjzyL5oGM0RQEdOxwyLA5w2rtb77a33jSeYX6YC0UAS44BzkWka4ndsbomovQvotV/zI37fkum5nGiEMvj5UTwiNaw1NciimC2j5/q4y9CldNICMHpaM5XyyuMmtHlLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D7oJnCpW; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc21ad8266fso2162329276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705512105; x=1706116905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYBsFknY3ImOfYB9kfT3cJP7oPzr41NJL3MolYvO8iw=;
        b=D7oJnCpWLLSScdHKsCX1VyinMzCXFtN7H/X9PflUT8LNPpjaI+PGqExWzh6bXyC/H6
         6WmmEPjcmN3LmZ6cTW6iPJK27Y3Nc9JiWMbDZpfAHLsZTEGcSQMXmEqmr0R0FXltQJd9
         HI4hNAaGZ+l8bg0UFonZa9kQytxrtgE5la2Gm/WHOFkbd7a4TRGXR2KOAVWeUJMYjoyB
         pJkh/0lAHa2t6KbkMELM8+DMWefo4HKMwR1ifn3ir20cDdPjzkylPs9vaHGOPAouORZZ
         mz8X9la/zvxDyE2kVAyA5vcDO2kk8wVnuh8GOhc6KwTSs8YtTS/mB4L9vyUbTJP9S7B4
         bPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705512105; x=1706116905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYBsFknY3ImOfYB9kfT3cJP7oPzr41NJL3MolYvO8iw=;
        b=W9fsrFyiOjX6Qj7Ihvf0HIN72Snes5H2RGwGvtXQtyjlCpaprY/YVOb3UqTP4vCl2E
         SDPEYMLyoiZEugezTTQ7L9obMVTjwV2vKOMTZQI8atLod4siv/sQgjPV4FjoJDpSXVF1
         Q+nAAfyumagwxnSxE6b3F3to79K/ZAJ4JxZla2aMxvU/usLX1bAoceWFR58TSPwbGlXM
         5ZT4TfRvXlI96DrvPO/ivMDc9quoFmGa7in8syKNJkHuVyyXpDFOoygV4MgF35DSsqrm
         HHCMQE6ARSyXeiNej6I/0d/tCwDmBUjy38mxUKyccvLb8CMEDm/erQi+swFFXTlWHarx
         R3SA==
X-Gm-Message-State: AOJu0YzeEr1e3b5FgDjMgXG1g9Ysa35IfBZzNdknt313lA182HI/yF4j
	LdQRWLgvyr7+0L1jnzMqiifzL2lm56VXnuGcC1RSTCmqPyeDG3NUXcyIZQmHAw==
X-Google-Smtp-Source: AGHT+IG6SMszqj8Rj/+FepNscBvBOV165ohTDgWM4Jvgop99GANV8DfAT+GlkdJZ3m7gHND/DyfhY11N2rW9VckdwJY=
X-Received: by 2002:a25:9703:0:b0:dc2:36d7:1a79 with SMTP id
 d3-20020a259703000000b00dc236d71a79mr1436789ybo.20.1705512104633; Wed, 17 Jan
 2024 09:21:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a33440f33d42aab66ad4120303ecbe8dca401d5c.1705490349.git.escape@linux.alibaba.com>
 <20240117170743.GD939255@cmpxchg.org>
In-Reply-To: <20240117170743.GD939255@cmpxchg.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jan 2024 09:21:30 -0800
Message-ID: <CAJuCfpEp2fawtqX7WkSJ0iB2V2_ANWWJRvOcQ7kyzPCnFB7UbA@mail.gmail.com>
Subject: Re: [PATCH] sched/psi: Fix the bug where the last character is overwritten
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yi Tao <escape@linux.alibaba.com>, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 9:07=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Jan 17, 2024 at 07:26:01PM +0800, Yi Tao wrote:
> > The buffer buf in psi_write has only 32 bytes, and to ensure the correc=
t
> > parsing of the string, it needs to be terminated with '\0', which means
> > users can input no more than 31 characters. When the user inputs fewer
> > than 31 characters, buf_size equals nbytes, which causes the last
> > character entered by the user to be overwritten by '\0', affecting the
> > parsing results.
> >
> > Here is a specific example.
> >
> > $echo -n "some 500000 1000000" > /proc/pressure/cpu
> > $bash: echo: write error: Invalid argument
> >
> > Because the last character is overwritten, the value obtained by sscanf
> > parsing is 500000 and 100000; window_us is missing a zero, hence the
> > return of -EINVAL.
> >
> > The reason 'echo' without the '-n' flag can be parsed correctly is
> > because the last character that gets overwritten is '\n', so it won't
> > return an error.
>
> Good catch. There is actually a history of this code changing back and
> forth. However, it's always assumed the last byte to be \n and cut
> that off. The original version was this:
>
> char buf[32];
> buf_size =3D min(nbytes, (sizeof(buf) - 1) /* 31 */);
> if (copy_from_user(buf, user_buf, buf_size))
>         return -EFAULT;
> buf[buf_size - 1 /* 30 */] =3D '\0';
>
> Which expected \n and actually cut off the last copied character. So
> without a newline, the window would have been truncated then already.
>
> It also didn't use the full buffer, which Miles fixed in 4adcdcea717c
> ("sched/psi: Correct overly pessimistic size calculation"):
>
> char buf[32];
> buf_size =3D min(nbytes, (sizeof(buf)) /* 32 */);
> if (copy_from_user(buf, user_buf, buf_size))
>         return -EFAULT;
> buf[buf_size - 1 /* 31 */] =3D '\0';
>
> but it still cut off that last character, which is either newline or,
> welp, the last character of the window spec. Bad, bad.

Indeed, nice catch! Thanks!

>
> It also copies the last input byte just to overwrite it again, which
> is a bit odd.
>
> > Limiting buf_size to no more than 31 and writing '\0' at the position o=
f
> > buf_size can fix this bug.
> >
> > Signed-off-by: Yi Tao <escape@linux.alibaba.com>
> > ---
> >  kernel/sched/psi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 7b4aa5809c0f..5ae336e1c2d8 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -1523,11 +1523,11 @@ static ssize_t psi_write(struct file *file, con=
st char __user *user_buf,
> >       if (!nbytes)
> >               return -EINVAL;
> >
> > -     buf_size =3D min(nbytes, sizeof(buf));
> > +     buf_size =3D min(nbytes, sizeof(buf) - 1);
> >       if (copy_from_user(buf, user_buf, buf_size))
> >               return -EFAULT;
> >
> > -     buf[buf_size - 1] =3D '\0';
> > +     buf[buf_size] =3D '\0';
>
> This looks right. It'll leave a newline in the buffer if present, but
> the sscanf() that follows is happy to ignore that.
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> I'm thinking we should also CC stable. A truncated window is pretty
> difficult to debug, and may not even result in the (ominous) -EINVAL
> if the resulting value is still a valid size. It'll quietly poll for
> very different parameters than requested.

Agree.

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> Cc: stable@vger.kernel.org

