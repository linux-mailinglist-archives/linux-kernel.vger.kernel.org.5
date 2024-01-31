Return-Path: <linux-kernel+bounces-45769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA8C84360B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7E9289EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3EE3D97D;
	Wed, 31 Jan 2024 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XIqAVIrW"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4443E48E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706678752; cv=none; b=AH9fC8kW2gtG/QVSek0pfDxYd6XUReLPHq+SMwa7ylU+Ug72RXbzQ+4u/K6502AFc0Ikb4ac7VW0GadCY03EisJUZkNY0uWYrqSms7n4C49SrIznBxpPrtgJjVo17xx9Tf2LWmiLmjxcnlzuFTvvNFRDoQx1TPeKExbEjf1u7OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706678752; c=relaxed/simple;
	bh=q3CZgihMakOv5ir/cwu7ZTqBpONwkqg3zIDu0G6t0DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qg98BE7ym35o/zizIa6YpK8eqBkYnq1A1S48Lwa0UNtxbWYPPYKV8m/EGdnQOuJXG412R3b5W2EQnB1JhHdDADRZ7+6WS3UooxskR66PPhGupkGQM4w2oQ1Ho0YMm8Ik70w1i3PVUd6sZx1izFqbmghC3VqM841ihsjnrI5W0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XIqAVIrW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso921247a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706678748; x=1707283548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNeDtEUcLcTdeQG2/4dUYEpMxn73/e37bLelySYVlAM=;
        b=XIqAVIrWJIsxPYX+dnw0C9veB5lqSKYLRFjp4DPQBmpQX6/UgUR+sZ4VqtRlV5ebjx
         euMPUOzB+eXRvRqe4sH2zWuoUUV1fTF4i4uNHhbgShcApUc7YMTnf5+j89xAFksN7Zsz
         elAsW7WH1T3p7P9lLoNxz+9cZi6tK1aURrneI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706678748; x=1707283548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNeDtEUcLcTdeQG2/4dUYEpMxn73/e37bLelySYVlAM=;
        b=A2TWZNn9PfdmISs1c53i7yK4/L2kq2FCB4bzDXSZmjIXnXAxSrwzilmSX4ue2hirrD
         9TDZhMgcntWWPH8Hu3N0ZtlQc+t5w+6Bf6P3Ik/9Nkm1Jpzdr9GOnVgD0Xi7u/k4RCzF
         Y+nv9cPxhrcmDh7KVArKkvaX+oXVU94oqsOUbd1aGaDoa1CAQsLNzXyyYoI/NZ51ACpX
         +UW/l29jQEzaQQoVk3ETPAGTU0CFPDW/Glspd2gyZ6HM53MTdS18sCpSMUOii3x8hzRu
         RSrODYG2zxvl8mhhz9rMd4bqtov4lXNF6830JQjs4kTqiXyZb9e9r+dPMOTjkt0AU3N+
         S86Q==
X-Gm-Message-State: AOJu0YwWtAo1mQ6XlH4IX4M22WQAaoroCUiZRA6pgnfoeYkExIk/HJfd
	oUb0vnFVF8YQdhm8mhDpYmAraX81qgVvIVItSGI4c+NrBbFqvxu/y1//2rY3Yb7BDA6SFeHwGdF
	ps3dF7Q==
X-Google-Smtp-Source: AGHT+IHA+9pYTKoX4sOnnnAkq02LfvyDYLKejxJ4fb0mJbFxdKcV9lCZbNejEP9EIZy5L3dISH1LJg==
X-Received: by 2002:a17:906:8413:b0:a36:5924:77e0 with SMTP id n19-20020a170906841300b00a36592477e0mr537136ejx.10.1706678748000;
        Tue, 30 Jan 2024 21:25:48 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906040700b00a35d7b6cb63sm2493126eja.28.2024.01.30.21.25.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 21:25:47 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55eed368b0bso1062975a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:25:47 -0800 (PST)
X-Received: by 2002:a05:6402:310a:b0:55c:93c1:4a50 with SMTP id
 dc10-20020a056402310a00b0055c93c14a50mr540016edb.13.1706678747043; Tue, 30
 Jan 2024 21:25:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240131000956.3dbc0fc0@gandalf.local.home>
In-Reply-To: <20240131000956.3dbc0fc0@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 21:25:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com>
Message-ID: <CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 21:09, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I would think that the last "put" would always have the "is_freed" set. The
> WARN_ON is to catch things doing too many put_ei().

Yes, that looks sane to me.

> > +     simple_recursive_removal(dentry, NULL);
>
> Actually, this doesn't work.

Yes, note how the next patch just removed it entirely.


> Does this work:
>
>         d_invalidate(dentry);

It does, but it's basically irrelevant with the d_revalidate approach.

Basically, once you have d_revalidate(), the unhashing happens there,
and it's just extra work and pointless to do it elsewhere.

So if you look at the "clean up dentry ops and add revalidate
function" patch, you'll see that it just does

-       simple_recursive_removal(dentry, NULL);

and the thing is just history.

So really, that final patch is the one that fixes the whole eventfs
mess for good (knock wood). But you can't do it first, because it
basically depends on all the refcount fixes.

It might be possible to re-organize the patches so that the refcount
changes go first, then the d_revalidate(), and then the rest. But I
suspect they all really end up depending on each other some way,
because the basic issue was that the whole "keep unrefcounted dentry
pointers around" was just wrong.  So it doesn't end up right until
it's _all_ fixed, because every step of the way exposes some problem.

At least that was my experience. Fix one thing, and it exposes the
hack that another thing depended on.

This is actually something that Al is a master at. You sometimes see
him send one big complicated patch where he talks about all the
problems in some area and it's one huge "fix up everything patch" that
looks very scary.

And then a week later he sends a series of 19 patches that all make
sense and all look "obvious" and all make small progress.

And magically they end up matching that big cleanup patch in the end.
And you just *know* that it didn't start out as that beautiful logical
series, because you saw the big messy patch first...

            Linus

