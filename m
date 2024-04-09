Return-Path: <linux-kernel+bounces-137075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E889DC06
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C286B281F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84A12FF69;
	Tue,  9 Apr 2024 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5m0cUey"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9F12FB0F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672280; cv=none; b=iedue2Bs72Ee3LXvp7yRYIQQJiPlsoDNPsH/DkHjdtSc/Sdxz15JBQZ7L7EijPa56H9uS/pI07mS4l0ou1lVqZZNc6Er5ZxExf+f2mDs3Xij2ZkTbpTkXRUhzJHTZaUbb5n9yxdnJv2k8A6eAWesUCJES0JRwTyuNavoHmD3EbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672280; c=relaxed/simple;
	bh=CQJJ+EXkS8vzXDSQGCdhZzOcQSnJl9LGsjKU2h6iW4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFq9wdBLtKG9+HDMpMleoA8oH2J8rZ654kUjJMUCnnbqIElD7zFBq66zTLj1keYjmi4jLPGTmxbOCwtwwXH/c7OXqAEBZrybqYOLGYKs5f4QsKKjhJprDQqcAlJ+ZlFxrgpJkWhUs/ATWkArpcUV+obMxxMNQh8LV0KsHoeytSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5m0cUey; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e67402a3fso14988a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712672277; x=1713277077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmZzs0VOF7pCa24C6qKP0DzgKs89B6zI1lNihOdcCC8=;
        b=g5m0cUeyt3OPmYkjeSaCYLiqKCKoOiiJTSs8Hmnilp+hftyUFIBS1fVNM/3U1waNh1
         jufjXbupOQXE7izYYd2czwgvfM+BH8UiDEnRT6+891cKMjOLoJF6C7tGfkz4A3Kn7/yn
         FAF1Spp8EgkxJ/B/UNYkXLq4F11OdyBLFTD26Ejp/vbnqjqOc0Y51THJ94qjUs5s7bT1
         Nzgwn3/2S6/2LdD8G/5xS8Y59feo2Mvj2fRQeoju8BmsHHvYUULBLbVmypi458U+FmNE
         3wQ+UUU+//UXMxgFXw+QdH6D/CcAddYcSkk106wULLqMkvVgvarBxFak6a9OG/LVXzfy
         Douw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672277; x=1713277077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmZzs0VOF7pCa24C6qKP0DzgKs89B6zI1lNihOdcCC8=;
        b=I25rBVkiTyVJ490qQPXi+rlTEtB7GTTY4czuLeVHLt0Z/9AeAGGZhnhLSTJx8TTHXS
         xn5O7PNjSd/G5xnAPZvEfthTTpXv55hA0BLzQqsuZ+jyvtID2Jhmk+RntT3w58cZCclO
         tt8hcZeRBvUgQN7kAv34T8N+UdygvE6uU7ybrwDWn1xNjuwoA8b/cEVtvWgr3ddbpxnI
         ANpzGWCZuGUR/fJpT2qtHTYllst1qNdSfq/VJBjVDsuON+bFLR15Z0AHtqGuAJLzXqcF
         jLawGUeHciLnzQ+1rPZsEnA809ZDept1ueXLWxSVmJO1CDU5GQgtEUs0xB+DJFCFKlKn
         AqXw==
X-Forwarded-Encrypted: i=1; AJvYcCWp6cvuRSDW7V8aMs861+N4a6Dvehall3O/tYJYPHwvkncDfmAwjF+0PsN6Ul0pRPt14xl02j48efb407jEgpvDaW+w6fbYWKCoQJ2N
X-Gm-Message-State: AOJu0Yw20OBJZU6inMAGPUIBF1kvnsfXXOjVFotk2lLMDx3XzbtMqy/z
	zqY5RhS6uumIq8vACQrQWIZmxeUXkxG2ZjGwy4BObAPDWRvqzL0ioj97z3mJxl068jlFJ106PQr
	j3sU65WNgyEmsMkN2yovsNZrtxY54dZ4UkuFW
X-Google-Smtp-Source: AGHT+IEotRWbGGi6bZ2X7QllsriEs5XuAfrmYSsR3+QQhN3IykwUSZgSv9+89fLvM1ymkT3RaeWYlpR5hL6VjU0ap8U=
X-Received: by 2002:a05:6402:40cc:b0:56e:72a3:e5a8 with SMTP id
 z12-20020a05640240cc00b0056e72a3e5a8mr161277edb.3.1712672276490; Tue, 09 Apr
 2024 07:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7cf0848b-f44c-42ad-848a-369a249bff77@gmail.com> <tencent_88401767377846C9736D0363C96C23BB4405@qq.com>
In-Reply-To: <tencent_88401767377846C9736D0363C96C23BB4405@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Apr 2024 16:17:42 +0200
Message-ID: <CANn89iJAyCKbL1Gx9mbBMuEvDB7nr-Ao6vB7KbtOK5D0UhiQNQ@mail.gmail.com>
Subject: Re: [PATCH] net/socket: Ensure length of input socket option param >= sizeof(int)
To: Edward Adam Davis <eadavis@qq.com>
Cc: eric.dumazet@gmail.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	pmenzel@molgen.mpg.de, syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 4:02=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> On Tue, 9 Apr 2024 15:07:41 +0200, Eric Dumazet wrote:
> > > The optlen value passed by syzbot to _sys_setsockopt() is 2, which re=
sults in
> > > only 2 bytes being allocated when allocating memory to kernel_optval,=
 and the
> > > optval size passed when calling the function copy_from_sockptr() is 4=
 bytes.
> > > Here, optlen is determined uniformly in the entry function __sys_sets=
ockopt().
> > > If its value is less than 4, the parameter is considered invalid.
> > >
> > > Reported-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com
> > > Reported-by: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com
> > > Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> >
> >
> > I think I gave my feedback already.
> >
> > Please do not ignore maintainers feedback.
> >
> > This patch is absolutely wrong.
> >
> > Some setsockopt() deal with optlen =3D=3D 1 just fine, thank you very m=
uch.
> It's better to use evidence to support your claim, rather than your "main=
tainer" title.

I will answer since you ask so nicely,
but if you plan sending linux kernel patches, I suggest you look in
the source code.

Look at do_ip_setsockopt(), which is one of the most used setsockopt()
in the world.

The code is at least 20 years old.

It even supports optlen =3D=3D 0

               if (optlen >=3D sizeof(int)) {
                       if (copy_from_sockptr(&val, optval, sizeof(val)))
                               return -EFAULT;
               } else if (optlen >=3D sizeof(char)) {
                       unsigned char ucval;

                       if (copy_from_sockptr(&ucval, optval, sizeof(ucval))=
)
                               return -EFAULT;
                       val =3D (int) ucval;
               }
       }

       /* If optlen=3D=3D0, it is equivalent to val =3D=3D 0 */

