Return-Path: <linux-kernel+bounces-106542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C487F01D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094011C22248
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D362A59146;
	Mon, 18 Mar 2024 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGk3Tsn5"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9338958ABA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788472; cv=none; b=m/Oc599OO2VnpudYzdT5j/gnEIf7qxRKCSal4jwnxIolaWZ0icynl7aN87/hzmasR6W7zWUUlAr9nXxqQixaN6xPer1rCX4/JZeG4BHsNdEzmjk4Fp+yTmyU1v19reVchkF4lDf34NTHcnfWARsNTZ3kc2/IDb9mwOAE6dXeVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788472; c=relaxed/simple;
	bh=rur/NpMfQ5E+JK8zLSnV25zMNQtg/qbyVnSWbDsjCXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xx0agrnD9kTaURvfO+fGvNf+IyFefdx6M6Wv6r5X7rroP65qPOpaHUUrZujzpOW7lcZhIeaeeLvCXHNNxwSwmafzAIsokWlkq26dhGSOXCB5KucifmpMU/yckPawh/S2vtZPiIVUm4B3VM563S6CgMWPMMUtvnhGPG6yDGskZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGk3Tsn5; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430d3fcc511so42911cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710788469; x=1711393269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3a9+/zCGjuSa4QQGh70luzmUtKh7fCOOBHF2Uqxv3is=;
        b=oGk3Tsn5i9eX27J6tGY1bOZlF1IqWzEr45nLeYS9Mze5knC0otvIfqwAG5p0ls4vpP
         HUOvhTkfC5KE9PzrR7VxHwjrVL73zPdviHqzwYBSaCe+alJ74DN782OaB54ARrcNriOa
         WsdyChwOz90epSGM33q1TRO1grJj11CDp39swTDM8PqEP11Z5aV4Fuyn/cASYTBPOpCO
         a3S1h+WTGgse2my99yzA4IoHBVTgfttV8kTZSs1NzxB3Pgmoi9aE1dQ665iiKciNu1xv
         ulmMUpLIYQJQS1BUj7UolXnzOr/chxBAN2ADAg/2PJzMoWZdU0TTfakZ2Sy3+QCTrgc+
         fYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710788469; x=1711393269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3a9+/zCGjuSa4QQGh70luzmUtKh7fCOOBHF2Uqxv3is=;
        b=hBfHGI9dog5Xmx9+870F/V1m4vxPmITrxv/HR77zIt0Jsc6LQb6YMR7IcICM+FUOyV
         kyVNvCtN7p/xoG1Cprsokes0KywotedK5TuOq2xET69Pr5kAG/VP3+NRAHNQPvTxcl1A
         AmhkteCO9OKZkRBdsUPeuZR5mvof93M1mw/ikcwBD4nv2Hnl7DKbMmsG/HA0VP/B5ACg
         f+FkqKDhBk1+/OOLtelhL5ibNEejC+32NC5AhaEfElaOuv576kymXnA9czEVu7g1QudL
         679TgtUG/YdHjyUi4cBWzCWG096x+zWNLvt3GTKi/NCWIsMZXt6nUq3QCn8ETzDOTykx
         CMcg==
X-Forwarded-Encrypted: i=1; AJvYcCXr7k30ruFSPuwG2+nTI9meTb6BoCMQuyoNFHxpmWqFzHTAV0AxpdcnDxAabljUfTW7dYdHyM9S1H+xE2zEkH2KPmoaLPlW4g0aAsMp
X-Gm-Message-State: AOJu0YzLjOwb4nQMP0H3iUuGhVYwjf1q7VljHAnW2VtcEIKrpUwza6zo
	vazZ5iyBjs+84SuoL8B2rEghDY0RQP/NNknhGt/C6ZMiUMApj78JgZ9RXH+sYZDIODrZ5MBwORG
	d4vlhEHRTVWzOYcWGjOtizfDMB+e732fKMcbJ
X-Google-Smtp-Source: AGHT+IFY/yfGJUeP8KNPEPbLvVSiXsA+krK9uGNKfXk2Mkf/JprWlaA1RL309jU2CTF9ByR2EIGqP7dAnUMvEay1uBM=
X-Received: by 2002:a05:622a:294:b0:430:b7dd:c175 with SMTP id
 z20-20020a05622a029400b00430b7ddc175mr40522qtw.23.1710788469338; Mon, 18 Mar
 2024 12:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240317221522.896040-1-jsperbeck@google.com> <252d1ba7-0ae0-4616-9ee7-f7c204531eaa@infradead.org>
In-Reply-To: <252d1ba7-0ae0-4616-9ee7-f7c204531eaa@infradead.org>
From: John Sperbeck <jsperbeck@google.com>
Date: Mon, 18 Mar 2024 12:00:56 -0700
Message-ID: <CAFNjLiVws+mCrMp4wMZuWTjaryK+-cKtNR9yFzVdqGf2u44oLg@mail.gmail.com>
Subject: Re: [PATCH] init: open /initrd.image with O_LARGEFILE
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	"ndesaulniers@google.com" <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, 
	Nazerke Turtayeva <nturtayeva@ucsb.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 4:47=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi,
>
> On 3/17/24 15:15, John Sperbeck wrote:
> > If initrd data is larger than 2Gb, we'll eventually fail to write to
> > the /initrd.image file when we hit that limit, unless O_LARGEFILE is se=
t.
> >
>
> Could this be related to
> https://lore.kernel.org/lkml/CAHY78BqCpMQptPN0SMaXuRqHOhYi+wnMEUSTYt7OHDZ=
ih4e7yQ@mail.gmail.com/
> ?
>
> Thanks.
>

I think there's a separate problem that this patch doesn't address.
If an individual component of a CPIO file is larger than 2Gb, then
there will be an EFBIG error when processing it.  The backtrace where
this occurs would be:

    generic_write_checks_count
    generic_write_checks
    generic_file_write_iter
    __kernel_write_iter
    kernel_write
    xwrite
    do_copy
    unpack_to_rootfs
    do_populate_rootfs
    async_run_entry_fn
    process_scheduled_works
    worker_thread
    kthread
    ret_from_fork
    ret_from_fork_asm

I think that could be dealt with by a patch to add O_LARGEFILE to
'openflags' in initramfs:do_name().

