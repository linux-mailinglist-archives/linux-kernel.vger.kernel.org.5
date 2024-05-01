Return-Path: <linux-kernel+bounces-165741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CCF8B9072
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FDD1F219AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23451635A2;
	Wed,  1 May 2024 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aP/dGSQJ"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7CC42A96
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594533; cv=none; b=B56GfYo8NpIfh2W5KIItFqzdlZ4la9IRQfK+UcIvVvoFvcOB2exh6sm+A4dFNHUfex5VfRSxVk10iaZqRzb4iTaFj4NKEcHlCriNPYq149E/OA+MxTVEVPOdGa7v2F16H+WeZSid/NHIM5zt9XC839UMJmM3wqIDme6oK9I2N2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594533; c=relaxed/simple;
	bh=wiC/qwp1tn2QtLPL49mOBk5DgvjRW0eTkk2FnvD2dvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTXt211GmbHkCbM8See0px+blpciyKIku9biJipy12Y+8V2xEn/vIYMQBK3seOpNkkb+4OtM32RBKxD3DYFUJG30izUbVN3Zd/lJ7yFsDzX/B89AYFamy3Ut/F9JO5JmjnQD9+Q1aOh3sbXEH2u7BCFgshtWm89LB8at+trQnKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aP/dGSQJ; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7f395ac5b16so482308241.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714594531; x=1715199331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+i1KmeojcJt62XLl7CnlLSmsjOhDVR/E3EtOZ1fd9k8=;
        b=aP/dGSQJ4L/wfBCOPwmR7uwjmqJ0pYAvN8cwCfriOLcmB05o3R9JNtx6/rq2LLUsq9
         C14y9X2yvLqLOSuTt5pkjy7j5I1VDNlrAj1q8T+LLmDWGl99mqUfW5+zvfKqSK68x0n6
         h58nuXZNflEgYq1IAehgXLntTeLTIUt5sM9nRDLweu1HL6KgLO9enVWKp36XogS4Prlb
         zuuxoOnebsIlWXzNFhlNi2Grxyxc5yCiCQLWSPrnhoE1IpoZKcU8BFl5E2DVV0JoJUQE
         IQLLfxklnDaFKWWbrsFU3q6moX6GzzHPnX3iWHjqGK9pVtL/rKF6nzSwrjA+HpZp0vVY
         ff8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594531; x=1715199331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+i1KmeojcJt62XLl7CnlLSmsjOhDVR/E3EtOZ1fd9k8=;
        b=LmVI/yJcOcWMnVD56Su833igz1KYegJNEoKB2ZUhfXZSWD4SUcU9TpkvIsHOK5sh4I
         2CYyOxP8WBSNORzA5mqgvEzyPyXDTLMwDkoYAIjJUBqezaWKa5hdb1feTRB7KuDtsvkh
         dqiXwX8scxkZ9qoFkB21mvxWPwSrvG8ed5/rce6azmcZkir//L/FcaLHw+ASWZjk0a+a
         mX+fda2nhhal656rtXgUMTs3BKH0+PSXtTTiJbD8x6G0/KuIA3EbvNIPro/PGtFmHt+r
         KFHwf+RL+LaxwEnFpjw2n6mGh0tP6TsF9oasujzuRWyHpp8l1hN9WYzYgBZWAM11A2pG
         Mglg==
X-Forwarded-Encrypted: i=1; AJvYcCXJKp6sGWf0Dp5/E2f627ik7ZdsWDY+PH7JbD6owyfK2qUVl1EALjrnq4MiH/YjX/OowgQwYq74ckwtBeARM9497Mq+ddOSOe0JLXvo
X-Gm-Message-State: AOJu0YwYKhGMQgeHyDU5pBLQcD5qE4tUpWT1SBlNsjvpnpsFdIsxqnm0
	XWcFF1/U1v+ZsWyfMUuG49pYxqJ/DY9iLlkMtBnwElVwGaFB7Df1QNNTpxTjFeCfh8gkHJy+Dto
	nANzpVVOyFrhyKAtqPTMngTNc2sUDa7wkNKNA
X-Google-Smtp-Source: AGHT+IFhpQb9UqMdO0uNQVh8XPqKDU0xHEW+aQEOpdYTs8DjimUSAduAwteLZCVHPiCOLjyGRKMOgGsbqxKF59nSe14=
X-Received: by 2002:a05:6122:d9d:b0:4da:a788:cad5 with SMTP id
 bc29-20020a0561220d9d00b004daa788cad5mr1334566vkb.5.1714594530088; Wed, 01
 May 2024 13:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh> <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
 <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
 <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
 <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop> <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop>
In-Reply-To: <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Wed, 1 May 2024 22:14:51 +0200
Message-ID: <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: paulmck@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 May 2024 at 21:02, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, May 01, 2024 at 11:56:26AM -0700, Linus Torvalds wrote:
> > On Wed, 1 May 2024 at 11:46, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > In short, I for one do greatly value KCSAN's help.  Along with that of
> > > a great many other tools, none of which are perfect, but all of which
> > > are helpful.
> >
> > It's not that I don't value what KCSAN does, but I really think this
> > is a KCSAN issue.
> >
> > I absolutely *detest* these crazy "randomly add data race annotations".
> >
> > Could we instead annotate particular structure fields? I don't want to
> > mark things actually "volatile", because that then causes the compiler
> > to generate absolutely horrendous code. But some KCSAN equivalent of
> > "this field has data races, and we don't care" kind of annotation
> > would be lovely..
>
> That would give the poor sleep-deprived innocent bystander some way
> to figure out which fields were shared, so that does sound like a good
> improvement!
>
> I would naively expect that KCSAN's ability to handle volatile fields
> would make this doable, but there is much that I do not know about
> KCSAN internals.  So I must defer to Marco on this one.

This is relatively trivial:

#ifdef __SANITIZE_THREAD__
#define __data_racy volatile
#endif

KCSAN will just ignore racy access to them (it will pretend they are "marked").

In some cases it might cause the compiler to complain if converting a
volatile pointer to a non-volatile pointer, but I suspect that the
corresponding pointer should then similarly be marked as __data_racy.
The fact that without casting the attribute is "viral" is probably WAI
even in this case.

Do we want this kind of attribute?

Thanks,
-- Marco

