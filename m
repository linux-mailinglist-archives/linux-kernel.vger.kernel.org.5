Return-Path: <linux-kernel+bounces-29565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437DE831047
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4200282570
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEED28DA1;
	Thu, 18 Jan 2024 00:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Don1Kece"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D32288CE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536187; cv=none; b=fgoTSdx/Fi80N7QoHh8X2P5qT8LAfXqPqK2FRDpKcTl0HdCCygqNeFFakyehhMBdn36icKpMsM2JM5fAfpDWyI5MWY7fUJxb0NNgVYOc9ppowYzg/khMXtqqprwOdoUOD7QrxJbqkvLMnlYnmArJhaC/1/zO61mhhJbX3Uw7fto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536187; c=relaxed/simple;
	bh=NEZVzybzPmNdcNoWNoKOGDd68kDR5PZhrPaw6Fk3lrc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Content-Type; b=USxPMx2IqS8fr6dx6ChFeSZgvga1mII//O0MiuTOlTKyk7/Pq68VC9veiIGvlv//u5qF04h1yDbk4hBSi6Np/5E+8AOjm5un2YMoeigcaTMCvWX6heWtL+bqE5IBPjFY+LPsLCapCwbsr6K2zvqMFN9x+eN38nV18kvwFTOlcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Don1Kece; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso14584016e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705536183; x=1706140983; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tTFhSt6TuecBRZDSOhTGNO151it+ibIw2r69xqrYOE=;
        b=Don1KeceorH36+j7gLF8O6nfdj0G4gk6LJKEQMceSy+a0TM/vtB3whGH1rUNfEmlhf
         tQiV7HwXvaysjBbj7/ViJXloDqfH1GCyjjUISkl9/E99kgMplN8s92AakwI0Z6tw1i+i
         /wFbla3XYHivgdlORLkOVroYK4Qq8fZOXNmCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705536183; x=1706140983;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tTFhSt6TuecBRZDSOhTGNO151it+ibIw2r69xqrYOE=;
        b=a9GwQzEiMDZIbbskRkJ2KHnhkP6ryyZTrVtETQtB1BTSZYn8TpZ0N+96VSmqlRSvb9
         KjLwoZEFKy7UyUoXm5vkhsBUycAV0EICj38A4qhkaHO1k7AM7yQR4sQmkqwY1HEJ0My4
         ZtX9lTbMijpVa3R+gB+UVRXn8E4VKeleeF2ylAhmaiNBXOF9CGOKSteOsdZXJ/3n1zon
         2kSM5QbLJHqNkq9AGCflfoL8TUCySQwIhYbGlfFW+sFnMKFWNYVuNY4KbGG+p0HW6zrf
         +I6ErNrhnCaOk61LRP94QuunDseLKiRyUatg/Ha3+Y/GPc+pjMTNJk7L4KQly1lIgA17
         Vtww==
X-Gm-Message-State: AOJu0YzHXtTIT/Tem2Vom86Z490vmYgJcP3vAvKcwmXsNQd+u5or4Q/S
	PdsSFSVmIQtR3e948m7LKcmt/w7ldJSF8TOJdvvN60XrnbXzunRxE6kIX4mnkYRptG5e1f+Gp3G
	ZmOHdIw==
X-Google-Smtp-Source: AGHT+IF26RhYnZl8hF+h/qdalFlfobs5d1wil4BzZVHsiMb11xg1lvrTSHj5okDMZS1VqILfV5UfKA==
X-Received: by 2002:ac2:5218:0:b0:50e:9343:64df with SMTP id a24-20020ac25218000000b0050e934364dfmr794lfl.70.1705536183201;
        Wed, 17 Jan 2024 16:03:03 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id ce2-20020a170906b24200b00a26a0145c5esm8340287ejb.116.2024.01.17.16.03.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 16:03:02 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-559dbeba085so1532112a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:03:02 -0800 (PST)
X-Received: by 2002:aa7:c48b:0:b0:559:b870:e868 with SMTP id
 m11-20020aa7c48b000000b00559b870e868mr50225edq.12.1705536182387; Wed, 17 Jan
 2024 16:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZahG7xgHJ4Tf8mHI@shikoro>
In-Reply-To: <ZahG7xgHJ4Tf8mHI@shikoro>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jan 2024 16:02:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSF9zaUCMWe8FuLrfwS0PxJXyxQxFGn7_W22C0rTaQXQ@mail.gmail.com>
Message-ID: <CAHk-=wgSF9zaUCMWe8FuLrfwS0PxJXyxQxFGn7_W22C0rTaQXQ@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c-for-6.8-rc1-fixed
To: Wolfram Sang <wsa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
	Kim Phillips <kim.phillips@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 13:30, Wolfram Sang <wsa@kernel.org> wrote:
>
>  And a big series for the
> designware-driver needed to be reverted because issues have been
> reported late in the cycle and no incremental fix has been found yet.
> This is the fixed pull requested with a missing revert added.

Honestly, with three quarters of the commits being the broken series,
followed by reverting it, I get the feeling that this would be better
rebased.

I don't like rebasing, but I also don't like "look, we had most of
these commits broken, so we just reverted them all" all noticed before
it even hits my tree.

So I really feel like at that point you go "this branch was a failure"
and start anew - aka rebase. Along with a big explanation of why a
recent rebase ended up happening, so that there is no confusion about
it.

              Linus

