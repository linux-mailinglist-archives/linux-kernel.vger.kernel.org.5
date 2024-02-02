Return-Path: <linux-kernel+bounces-49460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F33846A99
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBE228ED2A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D718027;
	Fri,  2 Feb 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZvHXQxx"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2217C7B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861988; cv=none; b=F4eKcW5Ibat4zjISZnK3XHFdQ9nWTihug/7gC4QH8D4OL2cwNh3+0b5nQ+83vFn43r65Y//S0pJmmHLiLtC+qw9sWbKzpX4Xtu18K4WLv797gBw53iyQuZ+gHIcUdQ6879yOTbaGJmH5ZLaDxoWX2XFhyPakpYHDky2uDz/7lVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861988; c=relaxed/simple;
	bh=KCsjQBd7D+/STxOIIlSlKn0jsyFI2QoqvOhT12/xnwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXcfdLcNxxoNPW331LKDbnjl4QY7GaCpQBqmaglRGvyEhd4q6N4wO9azvaV1yzMfulmWkg2U07NP5ycfqZpdSDHobva0J2ntsJYOGYdCUiJg4uoZR/qY95zBv30bGwrA7jSOSNeHtQEzsfHdM1MHniB71cLw17UC1GJXzYhNrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZvHXQxx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55ff4dbe6a8so363217a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706861985; x=1707466785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCsjQBd7D+/STxOIIlSlKn0jsyFI2QoqvOhT12/xnwo=;
        b=HZvHXQxxEFGJcQ7gDAEgnqm5Jxjw3OCbkiyIa5r7VR9S4HH0CNguaF5vK9PjDHRYxy
         vAx24sgV0Mu0w1iq9RMfmq/NIq2/HK8Ub9CU1Fo+RmJc8YF+xfFwCSY7p4TzyWYJjp0W
         a6e7/XFfvc8H1K32B7/FvtWcTL68rnjHk8kFSD4Z6igDrqbQrdSxJgIc1oTGxkngHCxW
         +Z6OBc9y3V2S1FUgXeY4u0la/aw9b618vEeCRQL5Uxw7cV71KMDywGSsAu/5tLPIzrvR
         m0Ao1NRsAd/tDTUsA/oYpA6pCgy8lmPaK+d6HkRQP6+io04v+9ztK879CInZguytGjvC
         6jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706861985; x=1707466785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCsjQBd7D+/STxOIIlSlKn0jsyFI2QoqvOhT12/xnwo=;
        b=ga79h51zfNmjr6hqv3YUyrBYJAtxWhuEckyBlxSfVQCu8QUveluWxBE04Fc4Qk8NmR
         KBY7JvWRTUN/o/ZgXTd1glnAhObk6VgICMQwEhwCHUfPTakR3m5eviwvLe8WjRSfb+yH
         3PXESHaEvOQpmSAX1NlosgXYst8TuupQdhCal9XvDoPAheJesRqLLBXFmujx9PGtDryU
         WhANjoiYOTgUDUZ2WhETZ3L96yDwOjB9DzeCHGQ/a1LVVFuNw09fsJCeUeRf8bCRVRvK
         yyQTgjnGlTar9rXtwRDVMzBX0CuYtKzliFLPZseMGBej2400bfqcoTa9JuEwO3VMz7QY
         PjUA==
X-Forwarded-Encrypted: i=0; AJvYcCVjFPnZqGfUO0k+F6HedjlFYyPQrN23uqFq1chBMRCkecR+hANmUflFKlodDynQ1edQgIWR6/i0RAOb8fTgRSZ0csLG3ybtPpOcWgwi
X-Gm-Message-State: AOJu0Ywp58ZQuTfWQhL2/idt0I9+WvK+otjC7qUoD8u3jBNImNYKkZu8
	Em8RGk25m4Kb+o1djAqaXSUOV6E5xo05vgMLEp60N5zJfiHWTfGvqoYWHJOvnsoPEDTkX+hDDPP
	S4D/HS63xwRW7hh0rNIMa2bYjIKE=
X-Google-Smtp-Source: AGHT+IHht3wWoQS5QR76BSF9oJUVoGYCV25I993xLX28kJy3p/FAHUc9uVIAFL7sBOcKi29OzFnCX5kuAXKsZbucud4=
X-Received: by 2002:aa7:d842:0:b0:55f:c55f:f022 with SMTP id
 f2-20020aa7d842000000b0055fc55ff022mr2438214eds.2.1706861985288; Fri, 02 Feb
 2024 00:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
 <2d1f4f16-6d66-4449-a7b7-5e2b2a4eaeb3@acm.org> <Zbv31aq6aZuSXpY1@boqun-archlinux>
 <c485e96c-6aed-4c4c-bbba-de5c8784be69@acm.org> <ZbwSxGpySa8RBt9A@boqun-archlinux>
 <891016e2-0f3a-4617-bb8e-a2a3af0f78c8@acm.org>
In-Reply-To: <891016e2-0f3a-4617-bb8e-a2a3af0f78c8@acm.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 2 Feb 2024 16:19:34 +0800
Message-ID: <CAHJ8P3+wCaUWkCshgEPYu8Bdjchp4m2F62X1fabw=5Fiogzu+g@mail.gmail.com>
Subject: Re: [PATCH V2] lockdep: fix deadlock issue between lockdep and rcu
To: Bart Van Assche <bvanassche@acm.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, longman@redhat.com, 
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com, xuewen.yan@unisoc.com, 
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear All,
Thanks for your discussion and suggestions , I update and send patch
version3 according to your comments.
thanks!

On Fri, Feb 2, 2024 at 10:13=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 2/1/24 13:53, Boqun Feng wrote:
> > Have you checked the change in the patch? Now call_rcu_zapped() has bee=
n
> > splitted into two parts: preparing the callback and calling call_rcu(),
> > the preparing part checks and sets the delayed_free.scheduled under
> > graph_lock(), so only one CPU/thread will win and do the actual
> > call_rcu(). And the RCU callback free_zapped_rcu() will unset
> > delayed_free.scheduled, again under graph_lock().
> >
> > If you think it's still possible, could you provide a case where the
> > race may happen?
>
> Yes, I noticed that call_rcu_zapped() has been split but the first time
> I took a look at this patch I wasn't sure that the new code is correct.
> After having taken a second look, the new mechanism for deciding whether
> or not to invoke call_rcu() seems fine to me.
>
> Bart.

