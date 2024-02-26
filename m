Return-Path: <linux-kernel+bounces-82072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEBC867EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF401F27F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E193A12EBC4;
	Mon, 26 Feb 2024 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dCTdkQL0"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2D12DDBB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968813; cv=none; b=ZPKOduFK2sC1gTqT29Q9tp7kyl7xXoM0A3YlWVzDruKWF1ZPVAVaqK2tc8GWjmEsZ0iT9HBVddx/5lDZ9TuPw6jkuoY2onJW32xWSXcTru65ibecOJbUI/ZYKWAu+eNVez2tv45wVlVlhcxm2oJecWO3w63szVyxeR6gfdjPzKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968813; c=relaxed/simple;
	bh=jGHNHxme5qjpR55RWTekjqcx02Y2QJMOPfL+qTuvjKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZNyCkjaXrNwf6WA2PTvF23RXnz+fY+ZEPWSeZNAGBZHcInO6UeQTtbeo5bazqAz3jRzHQB10JWJfnnc2Av0iuxRhOfQtMUmgmqPpiyaOyK/beoV7GbSVaKS899MP1016hMS6FOAfHtknKbtSBu0cK09TOTRFjm43BuBx7FuGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dCTdkQL0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-565d1656c12so2789239a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708968809; x=1709573609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B+DSV5t8g8pZijgxO3dOQk/2ugtI+XLO7xzncKpdXFs=;
        b=dCTdkQL0P3XHGaZlrPaZyyM4HvfIsF9PhGA2IPGa5/D0Du5epTB8pn7m+8VcsPwAQp
         l9dLaVpWR/NFZ553DCfiIgdPFhL2Qd6o+dr69NPk6NIN9NFjRt7VFK0cHs/6hW5CA4qb
         SAOdTDnCnsx8mChdrPHBbUrJZLjSk44S6/lFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968809; x=1709573609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+DSV5t8g8pZijgxO3dOQk/2ugtI+XLO7xzncKpdXFs=;
        b=j6HSk6duCX52yZfjvpZPmXWE9jhFoDU0ABELhBRQbLG9ohFpU/RbAmmjmdVJzCncSM
         oFqOR8e2szVR1SsmrO1J27ju9DuEQpK8Y69euzR2+nzFh18nWKnZSKKjMR6g8yKGPu/H
         LuphFA5GPwD9MxTW59OpM1urGhA29z2aFPSVSSqE/VO9LLMGL49tqe+jnY2sZXlTBzj8
         afGScZgMnA7ACKGMKyecwKGG41yq68/cwnw4ICasGI/npLWw6iUE/UPwTUtV00FfFjUL
         rprU2R1xNTIKtkaY0wK848W38s7DiUnVsR/F4zQGRiZQmuPtQedOe+0ZRHV6+ia1aW+C
         L/TQ==
X-Gm-Message-State: AOJu0YxRU0a6ZWrifGdt7opHs9hYfixRZ4didnha/MVbTTrsImfFY993
	i+FGX+iG7Bila/7Tl36pjjOI4PTpocdtprNxO7tqS5H5EKLMF64nF5E8FNoyeWT0JBjz/d1sHXI
	3zDz0pA==
X-Google-Smtp-Source: AGHT+IE2zgwGXOAeWgeRSaODsbzDbqzpAx5SrR9h5N3X/b3lNVQFe06IjAGG6fvOpyVqCPzvjyGBsw==
X-Received: by 2002:a05:6402:181a:b0:565:6b76:3140 with SMTP id g26-20020a056402181a00b005656b763140mr7413115edy.18.1708968809353;
        Mon, 26 Feb 2024 09:33:29 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id l10-20020aa7d94a000000b00565f06856casm1108465eds.89.2024.02.26.09.33.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:33:28 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso589435266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:33:28 -0800 (PST)
X-Received: by 2002:a17:906:3b0e:b0:a42:f194:9cd9 with SMTP id
 g14-20020a1709063b0e00b00a42f1949cd9mr5608776ejf.5.1708968807997; Mon, 26 Feb
 2024 09:33:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170886726066.1516351.14377022830495300698@leemhuis.info> <5ffb73e0-4b00-4bbb-857a-30a48945758d@leemhuis.info>
In-Reply-To: <5ffb73e0-4b00-4bbb-857a-30a48945758d@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Feb 2024 09:33:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHmYxCP36ngovZimX9sixWxMrGA_WZdYyE8JPqBQ6ysw@mail.gmail.com>
Message-ID: <CAHk-=wiHmYxCP36ngovZimX9sixWxMrGA_WZdYyE8JPqBQ6ysw@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2024-02-25]
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, ntfs3@lists.linux.dev, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 06:21, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Sorry, forgot something: there is a patch to fix a ntfs3 build problem
> that was posted 10+ days ago[1] that didn't get any reaction from the
> ntfs3 maintainer at all. Given the history of occasional slow responses
> for that subsystem I thought I'd let you know in case you want to pick
> the fix up directly; but if you do, consider using v2 of the patch[2].

Ack. Picked up directly.

               Linus

