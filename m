Return-Path: <linux-kernel+bounces-110544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C062488605A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E334A1C21C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD351332BE;
	Thu, 21 Mar 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O/ak81zL"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590D85938
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044644; cv=none; b=Tt75/ojXNPk/gEAmeb8tB4hT6/f/olr0RmQk6AqxPrVAUpD3OGsY8A/SQ0RXdzRWwGZGjIddHNnTKYuOZXl+cRPYJQnzoEldb/xsGsnb6xsLjhQeKiwNZyGdJLSU3/8MMbU9r3IgEFQdT/rtSWbgZROFJoOvZJqBT1IRu5t756A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044644; c=relaxed/simple;
	bh=XgzMJ/XjredShNEfVbHnEUIphui6pHeLgNGgZLuPtKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdPKI+tTIBHV19lwt3s4TFe5ArT51jmnNNUUwlWeYRiQeOrhE03sXZ3iJNMJyec5swivEj0thnqiBVCHDXLl7jAp1o9iur7ldQ0cNu+hhNogbvoStoGY15yz3WVeyjdsa1E2JHC4E5HSL8KVNCtVJ8yctU01CeWhinwmjCHqatU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O/ak81zL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a471f86dcd3so50900966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711044641; x=1711649441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4emHCf80OrxsdWiLJNpRLTTX2dJ/UHkZ+YLYB2p4Nto=;
        b=O/ak81zL2heK3yoSvfT7KxWDThH/Xl35wfWuOjbWVosGi6dAfXr0lwjZ+L3BFoQ4zW
         psebRHsxcjeMVILv9TY471etwFsyw4uTfG46P3gBDWLq0VQMQSSK9NKpliSOxiDWuCKH
         h0lwXC2iDqlGsKG4UvIbtmQQ6iUBIv3jV2rrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711044641; x=1711649441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4emHCf80OrxsdWiLJNpRLTTX2dJ/UHkZ+YLYB2p4Nto=;
        b=bYuFlprOnoVlok+vtFsktuJh8rI1dHr/PF8K4HbsgxS841Bm+r9YS/uPyfPOyO9fsj
         gu/3AlTPZj/2OERFteq+zhcPvEgaRS6T/FCFH9jengRkrcguTd5+P3/2cc9TfNSHhIqE
         1V7zottJ9zCpAoWwWT5t4ypz1Y60XLz3DWOVtv+1bF98WNpt/WrA96ah66DzWI3n+oNP
         oilxDAQQtOkyu3M5GtOuTUd2im5N6sDseAF39B/bsIJU10sYeuh9hIMbHax9fmC5jUJR
         nPhOfFrJGKpp8jxm1cZ8ODTPdLz3wtF16EDc2XVhmXrZ3a0ydTGGvEi4GiRm51v/BbIA
         LwaA==
X-Forwarded-Encrypted: i=1; AJvYcCXrpdTyRC0Z+V3zy8ao81mxe45IDL+4bJhXjMUy1YVj31Xxc3XqcxQMpJCR8XTLK2uaCaQJOw37zYArM8Dp3wDVraEgZyPOEtC7SKP+
X-Gm-Message-State: AOJu0YwTWtze6/j95+pQx6qjxJA8Nd9H5CDKfKwPdbaRBbU0DJ1Sz/K1
	JslZnNYvv3l1Nr9OkxvEEEJOFhOLzj9DuB1oosqNlGzDVz0RyvAMtDHdUORdVN9dzOX6H6DRtRx
	5xDP+vw==
X-Google-Smtp-Source: AGHT+IFpjAWTi12YnJ+OxU2nawosJ0LbnHPnE4JFEN0BcgNu3SCkoqOCKGF/2FoJ/vXj/ysAvL7xfQ==
X-Received: by 2002:a17:906:7fd0:b0:a46:22fc:74d3 with SMTP id r16-20020a1709067fd000b00a4622fc74d3mr114243ejs.72.1711044640687;
        Thu, 21 Mar 2024 11:10:40 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id bg25-20020a170906a05900b00a46bdc6278csm172095ejb.71.2024.03.21.11.10.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 11:10:39 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a471f86dcd3so50898866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:10:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyJ/bdz6Zb88677/SrLujzhbdHKInNT4fORzTA7xasXzhK48YEqYtNnamfzTawZ9cUOuJIXQBw1ITW6AnnANkDYe547XVW5E44mNVZ
X-Received: by 2002:a17:906:3509:b0:a46:aa67:ab12 with SMTP id
 r9-20020a170906350900b00a46aa67ab12mr156355eja.9.1711044639518; Thu, 21 Mar
 2024 11:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfwv2y7P7BneKqMZ@kroah.com> <20240321134831.GA2762840@dev-arch.thelio-3990X>
In-Reply-To: <20240321134831.GA2762840@dev-arch.thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Mar 2024 11:10:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGhgkEngBBureLRLKe7mQ-sRhYngUQNvxEUqR9mmc60w@mail.gmail.com>
Message-ID: <CAHk-=wgGhgkEngBBureLRLKe7mQ-sRhYngUQNvxEUqR9mmc60w@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.9-rc1
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 06:48, Nathan Chancellor <nathan@kernel.org> wrote:
>
> That build warning actually happens with clang, not GCC as far as I am
> aware, and it is actually a hard build error with older versions of
> clang

So the "labels without a statement" thing is not only a long-time gcc
behavior (admittedly due to a parsing bug), afaik it's becoming
"standard C" in C23.

Does clang have a flag to allow this?

Considering that gcc doesn't warn for it, and that it will become
official at some point anyway, I think this might be a thing that we
might be better off just accepting, rather than be in the situation
where people write code that compiles fine with gcc and don't notice
that clang will error out.

So yes, clang is being correct, but in this case it only causes problems.

              Linus

