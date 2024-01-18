Return-Path: <linux-kernel+bounces-30455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA34831EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D531C22797
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A4E2D614;
	Thu, 18 Jan 2024 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JcjMZ42p"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233E02D608
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601027; cv=none; b=YnMkDCUFYlNceJEymlJ1/QQVF7bv1i6RUBDq7wUHCNqzEvIT3D5WDty036n/8Jd3VZKanEbALJVZSQKLQPOuxQ7JP6DsoCz+tngu/n7dTPIcKzu8J3qZhLmPg19kXuokV4YDBsz51B4TjTJpMUPRrGM0INHEKWtNQEmaMvM4Jv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601027; c=relaxed/simple;
	bh=u++TN5BQM52YhlIwy5f1ecRhphCfx1QpfCF4yCVI41k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiHSpipe8r4uBgP7L+tnoCTxTtKxUmA+h9hRxlkiXK4AZVECvNhaQXw+e5wNoJXaOwvB/uiCNYd8B15fkihWLVP1xWSGbVFE8YoJqmygoTbYu/SX5pwcRXBl1NhL6Q6CJvKmaF2LlEc+vnzWH5/a+eQLXg7VD68nuXxX5T24sB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JcjMZ42p; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-559edcee47eso1926833a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705601024; x=1706205824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u++TN5BQM52YhlIwy5f1ecRhphCfx1QpfCF4yCVI41k=;
        b=JcjMZ42pc7Jf4c35KkNDBjcZO/x/z29AFn7OdfwtR+YW6Oqi5/MK5L0sfKHfgrg3U+
         x5DPwzjZm030E7dmnJIFOCt64PjGygK7772C0kF6FzvbswLcoZrLJx4zrGAWATvmZ8ge
         5u2CJwe3Bv7iCFDPM4RCxbJz8KNF/eGtPemq5MyGi+W50DSP0VySYMDz9UBW+dgW7clU
         CFE8wF6xxPSsLzS3bE5DAvO12e1LhInyRa2JNKsZ74wi1PalXOEMW7elyrx4GiX9DuYk
         jlhi7Ify0Ypr1NC23UXYzetCuXB1XsU3yIrivKN/Zm/867eYtgOCnvD0dPXObf6fb5qu
         fptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601024; x=1706205824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u++TN5BQM52YhlIwy5f1ecRhphCfx1QpfCF4yCVI41k=;
        b=rMKIFBzvxc8CpQnYGrc60eeTI25t6IHImKMf2EG/VK9/aYu1HL7saxE0Tdj3bBA9Ln
         03zlKUNaDka/YnSRN1h9jDq7cwVf+v2WXmluryPZ4rKZWfW5yd7+nZk7ml5sAZnZjAzC
         I8na7PSL8HJAT2xzKhfkjZOnkgZlYleNh0bSKSabBdMibNjbmFpzkJiPfgu5u7Gwpeir
         kdcfTP7GfUuIcBJ8pNX60cDqAXNrJB/zv4YOPokTtfaAB9hx9Ps2a27A0rY4CBq2jxnq
         s90aPGUf1Ai4WApBVpyVyXSXXda7PKXU9wLYRZ1M2z8A9KlJD+/nFZT5ZOg/o/RxxFLC
         3/7w==
X-Gm-Message-State: AOJu0YzAObKenB+vcsu6eTT2JwXDkuuivWQcHpbNqI3pQQ/Z2GtZxZOk
	87ePkHbSFlte3uaTAMmduFcHcvnvy3p1hVthu0AsylrPAnVZx/wv79WUGpXLzrwGHZsvWCnc6zG
	yI2iyJwvtflMyEJhqTMwU7d6Ezm2DaYe/9iW8
X-Google-Smtp-Source: AGHT+IFFxNo0QBZ3dkHrHTVeVHtZ+aGP7jjC3zZHGDsLV4nXDLTUNFpcRoU3k/2BzzO32sYG5iTc0+Vw5TQdAXS4448=
X-Received: by 2002:a17:907:6d13:b0:a27:f2c8:acd3 with SMTP id
 sa19-20020a1709076d1300b00a27f2c8acd3mr937430ejc.94.1705601024112; Thu, 18
 Jan 2024 10:03:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
 <20240116133145.12454-1-debug.penguin32@gmail.com> <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
 <CAJD7tkb_uC_K7+C3GjVqg1rDRCmUkbHcEw950CkUHG66yokbcg@mail.gmail.com>
 <20240118161601.GJ939255@cmpxchg.org> <CAJD7tkb+NCocjpjvM08Nv2fPMDqm4t-YH05TJckz8m1AYFNWUg@mail.gmail.com>
 <20240118173927.GL939255@cmpxchg.org>
In-Reply-To: <20240118173927.GL939255@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Jan 2024 10:03:06 -0800
Message-ID: <CAJD7tkZVYo7a57NeVkWABVbdbaD05c_+wBEiyUzsdTg88vaPgw@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Ronald Monthero <debug.penguin32@gmail.com>, sjenning@redhat.com, 
	ddstreet@ieee.org, vitaly.wool@konsulko.com, akpm@linux-foundation.org, 
	chrisl@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 9:39=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Jan 18, 2024 at 09:06:43AM -0800, Yosry Ahmed wrote:
> > > > > On a different note, I wonder if it would help to perform synchro=
nous
> > > > > reclaim here instead. With our current design, the zswap store fa=
ilure
> > > > > (due to global limit hit) would leave the incoming page going to =
swap
> > > > > instead, creating an LRU inversion. Not sure if that's ideal.
> > > >
> > > > The global shrink path keeps reclaiming until zswap can accept agai=
n
> > > > (by default, that means reclaiming 10% of the total limit). I think
> > > > this is too expensive to be done synchronously.
> > >
> > > That thresholding code is a bit weird right now.
> > >
> > > It wakes the shrinker and rejects at the same time. We're guaranteed
> > > to see rejections, even if the shrinker has no trouble flushing some
> > > entries a split second later.
> > >
> > > It would make more sense to wake the shrinker at e.g. 95% full and
> > > have it run until 90%.
> > >
> > > But with that in place we also *should* do synchronous reclaim once w=
e
> > > hit 100%. Just enough to make room for the store. This is important t=
o
> > > catch the case where reclaim rate exceeds swapout rate. Rejecting and
> > > going to swap means the reclaimer will be throttled down to IO rate
> > > anyway, and the app latency isn't any worse. But this way we keep the
> > > pipeline alive, and keep swapping out the oldest zswap entries,
> > > instead of rejecting and swapping what would be the hottest ones.
> >
> > I fully agree with the thresholding code being weird, and with waking
> > up the shrinker before the pool is full. What I don't understand is
> > how we can do synchronous reclaim when we hit 100% and still respect
> > the acceptance threshold :/
> >
> > Are you proposing we change the semantics of the acceptance threshold
> > to begin with?
>
> I kind of am. It's worth looking at the history of this knob.
>
> It was added in 2020 by 45190f01dd402112d3d22c0ddc4152994f9e1e55, and
> from the changelogs and the code in this patch I do not understand how
> this was supposed to work.
>
> It also *didn't* work for very basic real world applications. See
> Domenico's follow-up (e0228d590beb0d0af345c58a282f01afac5c57f3), which
> effectively reverted it to get halfway reasonable behavior.
>
> If there are no good usecases for this knob, then I think it makes
> sense to phase it out again.

I am always nervous about removing/altering user visible knobs, but if
you think it's fine then I am all for it. I think it makes more sense
to start writeback early to avoid the whole situation if possible, and
synchronously reclaim a little bit if we hit 100%. I think the
proactive writeback should reduce the amount of synchronous IO we need
to do in reclaim as well, so we may see some latency improvements.

