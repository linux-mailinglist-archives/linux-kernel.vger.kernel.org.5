Return-Path: <linux-kernel+bounces-133580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8389889A5F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F171C20C97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D814D174EF9;
	Fri,  5 Apr 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G63PNHE2"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A84171E41
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351353; cv=none; b=IBnBtybSXXmBVh2lm5iOgsHONXvZC3vg2d/MsbpMGU80bi+2UX887PclXum7ZEDlX4jAGxPq736yj46IGm/Enem9pjP+Q5iDFLAIA+1MzCaaRIK2N9Lsx2RxyqdX81iWw154q7UGwwevlTQf6S0NVzo8W/ii4CA9SjcHGsjgjvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351353; c=relaxed/simple;
	bh=2YOecpYsyh+vm9vBQZX0fTyz2T1YdsNL1F7SgfXoFyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDT5UdAJJ3hrv7+Kw0QWZkJTYclXwMo92rqhZggXmGnE60v1xYbtJh7TRBYP971PIlitvkX5dqwwYUwP4Y0cuREMVGDtz2cknB/owSTQLs4j82Se/3/cfB3ZWjS2NyxcDBEwvsfDg8l73dhqvr80EU2E2t8TZTnVbfGDveU88GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G63PNHE2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e2e94095cso4177a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 14:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712351350; x=1712956150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1nP8K+fSotDuy4QoPEUBun3bv7r+0pyJXy5f5RUr3M=;
        b=G63PNHE2+v/cjL8lkE996f1U73UqfHbP3S9n3QaS3HZWOZma5SlVc3D8VFNiCJSHa/
         MmeikFakqJPFr8N0vXa+ZB5TsMi34GdvqF2p+9p6yepnqlpVSAjx/TECNWUqxpynKn3v
         v4O+lMQdicjfQ0oMA80fIjnAIfyFEyI/eBYJMZUrNJxkREZcCe+aMKcg9vyYPP/KyuLn
         ZzXqYtomqY+/HyD9sYUOOBMfc+hwu6jwhaG74NIs0YABfAPBU8iLmbfay0FWI66a5R+r
         XTeIGAmYI+arsz2eP60cMmV4QYOoXauqEei+ew92LK1zTE1hN+TxGQIU2TLVREp9qFrZ
         YGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712351350; x=1712956150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1nP8K+fSotDuy4QoPEUBun3bv7r+0pyJXy5f5RUr3M=;
        b=DkqUBC3X1MUPTjkI6p5rb6tVY0yNPHzg5GDKRrI2Ry7gnBVBxI0PxcG8i45J75TuF7
         1o49vK7pqwpM+ZJLP0GfyXrhMj5V6Vunl32/owhBefdgZjOtWVCA+8KB49OmNTxSSq62
         0lAZmyJ+ahMmABhN3ckhOGMz6GLh70ZJCzhEepn+JOv0kE3VBHP7qHk8KHeHy7uCa0g0
         1e2wJUvuT4xl/8+KJvrZYKaofmotrjPyKobTCNXB5dc8I6hRsL0zw4wPDm4JWjO1u3rY
         0GOA8nmpEY7GTrPEZ94MesxHjLvZFDjYMyN3q2w8BSTQmDErV7ELBsTG74hLkRxK7qaN
         uaPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcbuLBRcZptWUj/gaWlwp6i9w0hCGR1p+9c2jFaHeQ0DqsXX7167vUiYhtSz1ztGe6gZxIda2zqOR4pb0XnT5dR4qD4uh5V7324ncB
X-Gm-Message-State: AOJu0YyM5oehKbeKK6179s4mBnJADF2djEOmNAS5AkYQ2zAlZV4OSugh
	QjJfnzfQUqHBbFJQo5flAEKKCE16WlK3wPjneypiBl73p5k4MD3g8AoFauc70sb5TdaigLgZXYs
	DS49n/Ln52P3uVRmPrmHGhdQKrX5VIwgZoKlw
X-Google-Smtp-Source: AGHT+IH6IwdzbaNmHE9q05G7M8OOFo6JwqXRFkysioKrnXxqk9sxeJ5AYEGVY6iQXgSOlVBzeAMeOTtELpWyHpXZPT0=
X-Received: by 2002:a05:6402:27d0:b0:56e:76e:6ea9 with SMTP id
 c16-20020a05640227d000b0056e076e6ea9mr45888ede.6.1712351349505; Fri, 05 Apr
 2024 14:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404075740.30682-1-petr@tesarici.cz>
In-Reply-To: <20240404075740.30682-1-petr@tesarici.cz>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 23:08:58 +0200
Message-ID: <CANn89iLZ9rkSpT6crP89RV-GPSnSxhUkjPSSh3PmiLNDH103yQ@mail.gmail.com>
Subject: Re: [PATCH net] u64_stats: fix u64_stats_init() for lockdep when used
 repeatedly in one file
To: Petr Tesarik <petr@tesarici.cz>
Cc: "David S. Miller" <davem@davemloft.net>, open list <netdev@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 9:58=E2=80=AFAM Petr Tesarik <petr@tesarici.cz> wrot=
e:
>
> Fix bogus lockdep warnings if multiple u64_stats_sync variables are
> initialized in the same file.
>
> With CONFIG_LOCKDEP, seqcount_init() is a macro which declares:
>
>         static struct lock_class_key __key;
>
> Since u64_stats_init() is a function (albeit an inline one), all calls
> within the same file end up using the same instance, effectively treating
> them all as a single lock-class.
>
> Fixes: 9464ca650008 ("net: make u64_stats_init() a function")
> Closes: https://lore.kernel.org/netdev/ea1567d9-ce66-45e6-8168-ac40a47d18=
21@roeck-us.net/
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>

I thought I gave a Reviewed-by: tag already...

Reviewed-by: Eric Dumazet <edumazet@google.com>

