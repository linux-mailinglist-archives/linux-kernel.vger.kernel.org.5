Return-Path: <linux-kernel+bounces-122936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E96488FFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12AE292E90
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C4580039;
	Thu, 28 Mar 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GpCbYrLk"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B67FBBA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631041; cv=none; b=gDqe+cdByX8V1tmm1U24DTezGdB2/eSIKjxxB8QdPOocPZxuu9JG5JjFWXrNchvscJ4Nn0v8qdzJnOfdlfSLXUhufyIdocT2BZ6bwXcHH0jDLhOwCJa/UJd3rUNIqETWGLPVXhWmdQr9HLlcM9hitvFwq0wpINspfOxIHRw+32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631041; c=relaxed/simple;
	bh=0V+RuvRGf3jpxS1g7uK7AxOydCxdLV5z/H6WKNFKKl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMUDroy4e+NwLJjeUskEv9iX3kmvGcincipBXIcYFUujd9OeiIwUTx+ToSZtWOrwAj7S5RGMKT+brMV4GDCOGh2f5kehULWHcMya6OllHNNOvH8tUWTlsFcXZs0fXu9mohVrtbl0iaS9REB6jezCLz3RlOlhawc98yKNyAY08yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GpCbYrLk; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a467dae51dso288788eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711631039; x=1712235839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XaX3hd7hmwSRaUGNwS3s92AS3tUn8V75RR5Xnstjxs=;
        b=GpCbYrLkOZz0PqvGumjdTSNlcachVwHWVgD+rWFYNZPKY1e0X3o4bL3imK+oDopbwP
         UgoQ7TqQ//Kt5fj0m2NqAOnnnB1qavj/eoqsrcsdY4Dx6HUYhsp3WiL8Qal+SzR/cXSZ
         r+Xi8Sl9ZHIBzGUrEAH9Fze1Z0LDT0JISegoQmJHSFMCMREAXA1NPRYHLYEfbBcoMnIl
         3izzn3pC5+kkw+bUds40yKL+iLAN9dtHoiPE86Pv2XbcBHCrHvG80MUikNDqxzVwsb34
         YTitKbnQK4SyWDhDoO+GVxwIBKYZ2U9RMGUCB1NdFRJ/xAb1t7CIndZdNK5CkRZEeMAN
         ZgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711631039; x=1712235839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XaX3hd7hmwSRaUGNwS3s92AS3tUn8V75RR5Xnstjxs=;
        b=qqC3DqRnykF6OGQaxytknMjBHfu2uwxofrdDBV806ULY8oCDiK9NZQqYd018XghCNE
         wLYpaYo/BtHvJQEU6NK2UYUZCx9cwNS6AREraplBLLKXCVCZWRQE0dbyxTqrdITrMK3q
         GvqIO7yg9Ch653us/Cy4SF8EmacO6xQoxgA31dAS2QOZ+0WS4DEao2V4+Ns+h+jlbtUK
         3fmxu34HFAyLzum8V0+6vOGnlX77u2UN19goKbG3c/86Ps14sSdLQpTzSnfC9HCHtdh3
         vJIgWqTHTiVBh0P/TZdvVMlYftva7Wlf3+n9gkWop89fghloYZ6UyqR9c2OtEVimkRCT
         W/3w==
X-Forwarded-Encrypted: i=1; AJvYcCWdGUorY8k5JuDiUL2TLKLJ+6na+YeNdlKj/zJ6J2K8LY8mEr1Pn+KkDz/SP48x1cVf9TQ+3tQyYOBvZdnoaDl6XpKIRrHBYeO36a9o
X-Gm-Message-State: AOJu0Yzlhghb4DkEffHBl6kH6fqz/Z6wXWMf8IwcAAQBL0n5dW9IaZ7O
	Xqv0sEMZBUqYmIPFJ3y96xkiT+bRlVncMvIwIaT31X+BrHNIPGQmf/apH922zGT5sZfKJkZo9lW
	R/2CANwud2LvAzId6OM95Zx09YG4zfbZQVKYG
X-Google-Smtp-Source: AGHT+IGAwrK5RVxI1FWdhaGdJk53oz1JIu4utEj/2i2Z5bPasaIK4TuD1PGNGJfhSHVlWdkONFw134Hc6Aj0/tfXdLo=
X-Received: by 2002:a05:6359:3187:b0:183:6350:bfb7 with SMTP id
 ri7-20020a056359318700b001836350bfb7mr464536rwb.7.1711631038700; Thu, 28 Mar
 2024 06:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV> <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner> <cb267d1c7988460094dbe19d1e7bcece@huawei.com>
 <20240326-halbkreis-wegstecken-8d5886e54d28@brauner> <4a0b28ba-be57-4443-b91e-1a744a0feabf@huaweicloud.com>
 <20240328-raushalten-krass-cb040068bde9@brauner> <4ad908dc-ddc5-492e-8ed4-d304156b5810@huaweicloud.com>
 <20240328-verfrachten-geebnet-19181fb9ad65@brauner>
In-Reply-To: <20240328-verfrachten-geebnet-19181fb9ad65@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 Mar 2024 09:03:46 -0400
Message-ID: <CAHC9VhQ_w6uaOAKCj6mx7n7SNjk4d7vcUb3Bd6Wybx_1dA=ttQ@mail.gmail.com>
Subject: Re: kernel crash in mknod
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, Christian Brauner <brauner@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Steve French <smfrench@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Christian Brauner <christian@brauner.io>, 
	Mimi Zohar <zohar@linux.ibm.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:07=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Thu, Mar 28, 2024 at 01:24:25PM +0200, Roberto Sassu wrote:
> > Also, consider that the pre hook security_path_mknod() has the dentry a=
s
> > parameter. For symmetry, we could keep it in the post hook.
>
> I think that's not that important.

It is important to me.  If you change security_path_post_mknod() to
take an inode, please also change security_path_mknod() to take an
inode ... actually, looking quickly at the code it looks like at least
AppArmor and TOMOYO make use of the dentry and not just the associated
inode.  I didn't dive deeply into either so perhaps they could be
modified to use an inode instead, but that is a decision I would leave
up to John and Tetsuo.  While Landlock does make use of the hook, it
doesn't look like it cares about anything in the dentry.

With that in mind, unless Christian has a strong argument as to why
security_path_post_mknod() must change its parameter from a dentry to
an inode, I would very much prefer to have both hooks continue to take
a dentry, unless we all decide they can be safely changed to use an
inode as a parameter.  As the previous IMA/EVM hook took a dentry for
years, and Christian originally reviewed/OK'd the LSM hook, I'm
guessing there is not any significant harm in continuing to pass a
dentry, but if that isn't the case please say so ...

Of course this doesn't change anything with respect to the necessary
bugfix and/or the hook name/bikeshedding effort; no objections from me
on either.

--=20
paul-moore.com

