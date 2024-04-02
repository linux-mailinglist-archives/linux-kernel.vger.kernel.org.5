Return-Path: <linux-kernel+bounces-128163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083378957CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58B9B2A865
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B71D134759;
	Tue,  2 Apr 2024 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FUj9vSFk"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5B12D201
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068697; cv=none; b=r4xlV9DNKwEX9d0NCzKuqfuces92dbVAz7RtudOaaaOgCpZ1S2THVGhTI3TKDWDi/bnqm9dSkNB5HbL//7axK5B3xyc5qSbBZSayjiY+KzATzXl8m+f4JBOGxyssC+50SFZ/Qd25pQXl4w6lOs6x5lGvYQxYTLuD9RGiYSSWYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068697; c=relaxed/simple;
	bh=2liQMgFhs1uF1gMOxPK4tNugi0SQ9cf6bRsgJvSmtMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtEIoT9HnRQZnBMvTMVOV5nfiq97ehSOiHiEXmTyqBEvoCaZ3UmB9PYbBdIB7QIRwPlfwd0vQia7KoyNaDdhyAmTgaudDc10TburwAH9w6Alfika7JCkJJj4bE+Ag6LHEfGRAiRawzpc1jS7dwbRlX5QbSZj9luqg4HhlFt+/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FUj9vSFk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44ad785a44so594723666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712068694; x=1712673494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hz/Mdo0iRGzhuMR/T3gMDlAelTTxPLxaDcQNsEu4FEQ=;
        b=FUj9vSFkzQruhef2ShpiAhVnwTUCv3Ix/j5tlyPC7r91AJqU45m6O8MyD2Giq0CN3K
         qy5+Zi2mKbEaokzsYpa1POhpR5nTwFRT19eZ/rAyaGSFf+a4clO3W+c4NI1aDabGe4Gy
         /ptzfHgnKLKhk9PyoVfsLdVKo/J08SFRZQE14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068694; x=1712673494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hz/Mdo0iRGzhuMR/T3gMDlAelTTxPLxaDcQNsEu4FEQ=;
        b=jcW55ipQhUDFvZsgY0dFWExeE5T5L0qEu9PgVACaHtAPSt1DQdVOO1gjiI0gkZfLsS
         T+eBRX6/Y+aF9VzjdR8UnwUEj2yb8JQ8vBML2vZ+3SkaDWiqeq4iiBA7LaHm/cXKqDEL
         7FH+O8K2nIpr0cCSpRSlO+wf2K0m0IFs9usZfIV89xH5rzQZVG1Wow2RCsu7nQgFQDUc
         Vf9d4fKXVJUMvNj8oPAkUo6a9L1AA2/E92Jj6jDWVbcBQ3jFdt6v6IuwQOzJFfm2XYj1
         dkY0CF5kS3QyAHCyrPdyeF01gdbJV7E8n7zDw9P68wmKJB7gPSVWQxgTgX/VJmNmeL38
         cckA==
X-Forwarded-Encrypted: i=1; AJvYcCWqbN9Tw9ok0ObDxeEAd9itHVeFh4Dw2auEphsbmBYs71nn0/gTxY26Yg28aLv7fZnmxNKeErqx3JCeUhZ/s5RW9GR8GyiVzTnZfo0o
X-Gm-Message-State: AOJu0YyUxsXStzQY7KT9cXQHHMbJsxlRTW1xDdBvogJWKvQyXXCRzOQ/
	aw9YLlgtkrhiShX9BtFDbk9BrMuBTPn4qLgMuReA1LwCNHAiz/aJKI+U75w1mimgWSoROlrQPzT
	bOKBa4fFaEjJk6Dp4X3r/LRhCvgfG96kKQ5qXXg==
X-Google-Smtp-Source: AGHT+IHmxxCpwgwF3hnzyNbzsGB5t5T5fVSlhRpp2CpMLMDO7WzzO7pNWgMwuJm/aiQER8vQk54meZZya8gxARCsRMQ=
X-Received: by 2002:a17:907:72c6:b0:a47:5171:8d61 with SMTP id
 du6-20020a17090772c600b00a4751718d61mr10050686ejc.60.1712068693719; Tue, 02
 Apr 2024 07:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-setlease-v2-1-b098a5f9295d@kernel.org>
 <8a8e8c0d-7878-4289-b490-cb9bf17e56b9@fastmail.fm> <f6bbdf158f0ca7a12de9b9f980d4d7fa31399ed9.camel@kernel.org>
 <CAOQ4uxiv7xSUS7RDK3esa1Crp8reYXewxkr5fFbhG623P20PwA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiv7xSUS7RDK3esa1Crp8reYXewxkr5fFbhG623P20PwA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 2 Apr 2024 16:38:02 +0200
Message-ID: <CAJfpegvRDKS1kKrMPyqzmuSs8KXZ2ohpwp0nEzEf7e3vv940xg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: allow FUSE drivers to declare themselves free
 from outside changes
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Apr 2024 at 16:02, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Apr 2, 2024 at 4:29=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >
> > On Tue, 2024-04-02 at 15:23 +0200, Bernd Schubert wrote:

> > > Could you please add something like below?
> > >
> > > FUSE_NO_OUTSIDE_CHANGES: No file changes through other mounts / clien=
ts
> > >

"through other mounts" is confusing, since one instance of the fuse
filesystem can have many mounts, and changes can be done through all
of them.   The issue is if changes are spontaneous from the viewpoint
of the fuse client.

> >
> > Definitely. I've added that in my local branch. I can either resend
> > later, or maybe Miklos can just add that if he's otherwise OK with this
> > patch.
>
> Don't love the name but don't have any suggestions either.
>
> I am wondering out loud, if we have such a mode for the fs,
> if and how should it affect caching configuration?

IMO it should enable all caching and override any conflicting options.
That's a separate patch, but should be done within the next cycle.
I'll look into that.

Thanks,
Miklos

