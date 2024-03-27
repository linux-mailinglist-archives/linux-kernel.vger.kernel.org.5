Return-Path: <linux-kernel+bounces-122106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D588F1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B5529712F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9814EC70;
	Wed, 27 Mar 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ooxdOHdk"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91D219E4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578895; cv=none; b=bTojW9+n/ik5qu3q7XElnBO9Z2dhf9mFwyzE+fLI8RJpQqI+dAkVcU+NbkKnIBGaJ2hBh6cUxHFWiotBHbBTSALjEIY/quiiBDQP8mNJWs3KcfTCGXZFpMtltay5umoykFLqUaj6a3I88dxpzJjjGf+k2UT+tmK7S6vJkQm+K4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578895; c=relaxed/simple;
	bh=VGIRL0u/W/qPO6wlvUFvCQGLo4EDnsNdwhLSr7NSVes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWrftYMIVcI2lAyNYgoq+XaEYGoo5P8UefXcx5EiRY3sB57Uu16DjNTh0W02dBcEa7VXpzuvVn9FIIb1dVF2is2MrfhuH18CW8YRpeyh4N/xpgvcpnTm4IlVOuBOjQW3ogH/QBieCwQdoGgZWU/aOkCYxRnirtk0Jd5J/4DOaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ooxdOHdk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4a393b699fso60332466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711578892; x=1712183692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGIRL0u/W/qPO6wlvUFvCQGLo4EDnsNdwhLSr7NSVes=;
        b=ooxdOHdkmb20zz/9FpwxkCspTyWm5K4iDaylVImYAjNkBJcbdLHnH+r0a/Rkn8DAoq
         JK7cpvOWlvOGo+HxhE+DSt8np34fiarZtu5j5aGp6ZxiM7rIEEqHmQjv1TC0hJNTbfbA
         QfTa8qy6+ETjcabv6Dn9uUHkco2UkuMm0h8FhLrZohifOi+2idGN5r+pIxswyTkqv2CN
         QtVdV76BaykTf7kRfJj8j1SQze5x+oO4Se8rY+w4wE9CnZY8gn9KAT9f5pKJimLjm0b5
         xB53hQyisSVhpZ/dMvsOEhGwHPnM4Vn1qeZW03wwW2geUF2wNEs43fJC5TJF9CgNNJXq
         84ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711578892; x=1712183692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGIRL0u/W/qPO6wlvUFvCQGLo4EDnsNdwhLSr7NSVes=;
        b=P1baZQI3FBna1yMupwH/JAxjP6ItkIrZEwU1k5ghuHPOJMbcdVgMX75Sp65qF0PO0x
         teCBorvNqDm4om5mHEIovmkJf63mrp5XXsENNiZ3HtANzbyK04aCFBE1laM4AQtIat4k
         Tw0Bd/k148mWMQ45XLAxZLF7bHEnew0b6KYmvAI+h7Ajsm3xDIMm6et8/iyqsg3mTXG6
         bbv4gM64kgsvA9H0zczMrdU+I/t30xulW7j3aXdplWq2lWmazG3Slstt/jIerfbJxoHx
         Peec6uBr/nR1gwnspG+3FZbKueMDjLjQhEeXdShPXsPwRBBTR3LZIa6syvB0dQnkyN+N
         9G2A==
X-Forwarded-Encrypted: i=1; AJvYcCXJLairvEW+trFMFJFjmFtTlnmWUcxVV5BwyfaW7z1rKbPw1EDiy3sXqMq9WZoxNgARPhxVpk0NZRKo4wrfGukR9Yhw3qGCGSYrrUSM
X-Gm-Message-State: AOJu0Yzlxn5K/cr2LfGNlJ2EO40EdO1Ow0Fj35Av8lglwglg1PdDAddb
	i8SawpbNu0bgRcZNN2bzaugHXE4BZ+2yMryRwvTZuiP983AWtnvqtEiaE2vaWsiljY4h9sFXRaE
	m+qSkZoFAFaTaO3ufLXyQUJD39chdkHORTVfN8ft/mOnw7YtVlQ==
X-Google-Smtp-Source: AGHT+IE4oRCJhxC13l4jo2VHG6Ts0gkVfAyq5pMdu2T2ldxiEy9xYYVSHonq23TOooasGj1h62r0AK2RzYTkIYuAPmE=
X-Received: by 2002:a17:906:4ace:b0:a45:f209:d2cb with SMTP id
 u14-20020a1709064ace00b00a45f209d2cbmr542481ejt.28.1711578891882; Wed, 27 Mar
 2024 15:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-6-yosryahmed@google.com> <3e1eedef-5e4c-448f-95ea-d50b431c4265@linux.dev>
In-Reply-To: <3e1eedef-5e4c-448f-95ea-d50b431c4265@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 27 Mar 2024 15:34:15 -0700
Message-ID: <CAJD7tkZFU-xr_xfEmnaYbatyCz09Re31dAYbLHV9K_XQLqoWaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] mm: zswap: remove zswap_same_filled_pages_enabled
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:44=E2=80=AFPM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2024/3/26 07:50, Yosry Ahmed wrote:
> > There is no logical reason to refuse storing same-filled pages more
> > efficiently and opt for compression. Remove the userspace knob.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> LGTM, should we also remove zswap_non_same_filled_pages_enabled?
> Not sure if it has real usage...

I am not aware of usages, but in theory you can use it if you
exclusively use zswap to optimize swapping zero-filled pages. Not sure
if anyone actually does that though. We can remove it if everyone else
agrees.

>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

