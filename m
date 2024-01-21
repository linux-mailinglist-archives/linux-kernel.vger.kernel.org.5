Return-Path: <linux-kernel+bounces-32150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D79E835748
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F051F21AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10BA38391;
	Sun, 21 Jan 2024 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fq04HTL0"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003EC381D3
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705862937; cv=none; b=YJrza5hyPDJscNTjaXfpoNl1aAJVpoBlWmF4/6oENFNbNufvdK+E3iIiiiNzhVcVxEamyzcIHvmj+ylQAvD4YKq9D9NzT/N6ByRbHAtp7kyXMIBp0P756WqoD2Z/PQeVrX6IDMTpxk6nZZ05Yof48W25/tDx3XOpJyRDvruMM70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705862937; c=relaxed/simple;
	bh=mokMqXTKDj1fI/PtJ7lX1OLlIpz3PU0kbOQ4wDgKN4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4AkEF62k4kvmr3v4uxGIb83Cjg26mJfyWCGGRuqn+qAOL08adwgCPX4p7EsMp2pXpWx5g2iRJPr3hJQZ18WpADy2ahM0pu5Hkxk7s77uh8wQc0HRV/+URs4nSLDbVNymHDO9MbFUlbnK/m2xjEmtJkkEn4mqso/QLv1Ru9BCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fq04HTL0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so2018643a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 10:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705862933; x=1706467733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CHSltJkcMvkqyQ9k+dJ9VRM/sk8FyM1fdG5DA1EXits=;
        b=Fq04HTL0SSZPn5uF37jwXwcrzMu8SajsNyAbIHpXZPgh5MicwdmH8oFM3ZJebMMcRW
         7gREgEj8OOihw2yS50W+9xOcOC8f1hcBEcc2PhP6XF32FBZgHVPXMt4ojJPp2gQFmh4C
         ApzaSN45qf1nszSCv2K7ndG6XbIFrwjgpiSFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705862933; x=1706467733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHSltJkcMvkqyQ9k+dJ9VRM/sk8FyM1fdG5DA1EXits=;
        b=j/kg8pAscyUKNHFM6v6fwNcZwZWqV/RVGM+C2ArIuE628LhuGXpZ1Uow/nGzhTFjDF
         FSxoQfqQL+iElDyDVm6rhUjThMZsTsnOMXu04jDCoUW0knrCfRLoh+qFnHtLXE5aPIcR
         kZPDWyTs569/MYauLWIkBWHSxfhjiRH8uHItD6HEkrYwJz1YYfdKS+tM0XdRgVrDz6xO
         8q45C2VALotnWzpsC5kQWihdbmFeK2XG/MuQXgsCK4vGRrTDapSe6kRv+7QUzZJODNlI
         MeCa//jJz45Vmhbr06F13FRCjuJBZ1vRdXaCjoKuWcFDiIu62NXIJyyk/U6vhjRmDjos
         Bx3g==
X-Gm-Message-State: AOJu0YxaTxMV5J1alQB7twk0LWLErWgGnRJv/4w76jqHEIAI07t4rj/P
	NPgQpk0gYzIvT36bDBpwYABzV+oPffW7mgTzDiLlH63ehGHiPWJG7l+vK7gsOXCQeB43I5me4Iy
	JGto2mg==
X-Google-Smtp-Source: AGHT+IGVr9Mj0tiGHOci03qh3D2nEk2Jo/pqgfUyLHG92SP0TDQNeFgrWmxHedX1e1GHiBdBa41WHA==
X-Received: by 2002:aa7:d496:0:b0:559:d389:9fce with SMTP id b22-20020aa7d496000000b00559d3899fcemr1509146edr.49.1705862932937;
        Sun, 21 Jan 2024 10:48:52 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id q25-20020a056402041900b0055c104274e7sm1285431edv.78.2024.01.21.10.48.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 10:48:52 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33924df7245so1412222f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 10:48:51 -0800 (PST)
X-Received: by 2002:a05:600c:26c1:b0:40e:9e3b:8f with SMTP id
 1-20020a05600c26c100b0040e9e3b008fmr1802625wmv.78.1705862931599; Sun, 21 Jan
 2024 10:48:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2ce7bc75cadd3d39858c02f7f6f0b4286e6319b.camel@HansenPartnership.com>
 <CAHk-=wi8-9BCn+KxwtwrZ0g=Xpjin_D3p8ZYoT+4n2hvNeCh+w@mail.gmail.com>
 <7b104abd42691c3e3720ca6667f5e52d75ab6a92.camel@HansenPartnership.com>
 <CAHk-=wi03SZ4Yn9FRRsxnMv1ED5Qw25Bk9-+ofZVMYEDarHtHQ@mail.gmail.com> <20240121063038.GA1452899@mit.edu>
In-Reply-To: <20240121063038.GA1452899@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 10:48:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whhvPKxpRrZPOnjiKPVqWYC3OVKdGy5Z3joEk4vjbTh6Q@mail.gmail.com>
Message-ID: <CAHk-=whhvPKxpRrZPOnjiKPVqWYC3OVKdGy5Z3joEk4vjbTh6Q@mail.gmail.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.7+ merge window
To: "Theodore Ts'o" <tytso@mit.edu>, Alexander Gordeev <agordeev@linux.ibm.com>
Cc: G@mit.edu, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Jan 2024 at 22:30, Theodore Ts'o <tytso@mit.edu> wrote:
>
> Linus, you haven't been complaining about my key, which hopefully
> means that I'm not causing you headaches

Well, honestly, while I pointed out that if everybody was expiring
keys, I'd have this headache once or twice a week, the reality is that
pretty much nobody is. There's James, you, and a handful of others.

So in practice, I hit this every couple of months, not weekly. And if
I can pick up updates from the usual sources, it's all fine. James'
setup just doesn't match anybody elses, so it's grating.

I do end up having a fair number of signatures that show up as expired
for me in the tree. Some may well be because it's literally an old key
that has been left behind - it may have been fine at the time, but now
it shows as expired. It is what it is, and I'm not going to worry
about it.

But every time I do a pull, and the key doesn't verify, my git hook
gives me a warning, and so those things are a somewhat regular
annoyance just because then I have to go and check.

And I just checked: with James key now fixed, it's currently just
Alexander Gordeev that shows up as recently expired with me not
knowing where to get an update.

That key expired two days ago - I'm pretty sure it was fine last pull.

Alexander?

              Linus

