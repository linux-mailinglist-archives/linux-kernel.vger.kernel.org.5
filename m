Return-Path: <linux-kernel+bounces-71500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CF785A642
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73E8285185
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DB337141;
	Mon, 19 Feb 2024 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QSE3iKHm"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D471EA7D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353772; cv=none; b=fV3f2oMwmuym8L55VwEcA350xbVCoqxHfINlqP43+OY5aZJcBT7jcY3ApcYyF6m1UIWlwBJsNkMqZDDe7Sm9uGIqyDGHhw8rCLnZ+bnf8nG3yRlH0H/Wl2QxvomXphWnYy3N8xkyrACAOwh6MmsC/eSv23L8U0VUBg7GYogcADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353772; c=relaxed/simple;
	bh=pAQ36Mouu5LBU9w/qPkLQEX9p2kwmTFAJ2rFQbxWzyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8P/KpOi9MFoUdjDYaittWQR5dV/opeoBVCBJXnf3UCiYQfBdrubCD1tJILDLtJjNN/Ut84aMULOxpSfkyLRRk1w5iEXL8yt8uf98aYhQhAfl+aZSx3i4RIzInTWI0Ng8UIRCWu791QjNmW0J/tMzEfGpTShFCGKJgpVC4sH2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSE3iKHm; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso13745a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708353769; x=1708958569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QK6TJ1NiFtkG4ibJWHZitNlZraEYM47hN7HesdXjSmk=;
        b=QSE3iKHmoGpXseBVKAYWaMMwr41vY9ifkCHKdzm5WGSeedcwHNIL1QSLMtyn6dyUkm
         SwYqRkY5iJU9X6PQnsQgQloOskR3MkfKDEJkRvWom61X34cVgH65ecqQ4HHUhVHHSteC
         9b7MU9htDrwUXtF0edX1FZzmwduIJyDE+xA8SuN8A1Cq61wZznvsNJMwzn4f/+g3RqLg
         KUHZY/hSeuWJjcX6jYzbQC3MLN0tzK9mrwV+wHTGHOxES9J6hOuUV92VIXGv2XRbFx+H
         7cM5D/TgmqOZH//tsrWNwHSTPIuBRx1xnykvLlKcNnMDZ4KJnkOr3FK9nJ+J/+81ASXH
         9jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708353769; x=1708958569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QK6TJ1NiFtkG4ibJWHZitNlZraEYM47hN7HesdXjSmk=;
        b=K2CiaIzQUtDcw59DDrX79m3HDanQW60bzxMHtHCmHiIjdNizr+/tcTpKLGImMxqxtK
         OYYBTd/it00K98japqmDgyunbs7NbBi2zYtcQf+xREZLPon6qZTu3b8LOAP0PbIl/1Vx
         B+UtUleyy1+q2jblQvJtvCUfmVK9CrTQNxy7ehiMa3fegNQXPMzL6n0qTLwzDlWRyPdY
         RW86PT3EicC4fOBqPHAa3cND9xzpypi7jch6l8/9en1hMftGBasR7RJChSFXYNs4wfje
         0IQeF0B4dt/EryMcL3Nwi8oCfzS+pl/enCgBF3hXE/3lVHOS4I+gciChN10WSMm6iBom
         5QuA==
X-Forwarded-Encrypted: i=1; AJvYcCVanmOsPzvMgcl8srSBaYQY9vO8bDC7zQI0Ls6gQ2CIXoxbyoEKanQEQDPleMfVuPnXbFzSTuSeYq4o8iGWbU1aoihTdxuUuRJXMLzt
X-Gm-Message-State: AOJu0Ywwr1JhV9FqSx+BhA7RjjGmgNyDwBmWK3ypKzMcjp1Yl9NgFDsk
	HgiXU5OT6RrA9NXxmGYsj1G+HWX0xFRFzz/GhXyyW6EN/AxaGo8evYpCfUgca6l+js3GUHZFpLD
	Y8Aiu/0G/gh2vc1qgc16WSmuwvy07dgrg4OGB
X-Google-Smtp-Source: AGHT+IETr5Fg0KJAZlnaeDsbnQhKIQl70L4uyU1bEvQGzZr716e4ct6UKPj1TKwF25G19fVSf9HT3kKxRf0iELr+aGg=
X-Received: by 2002:a50:a697:0:b0:563:ff57:b7e8 with SMTP id
 e23-20020a50a697000000b00563ff57b7e8mr298755edc.1.1708353768955; Mon, 19 Feb
 2024 06:42:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219095729.2339914-1-vschneid@redhat.com> <20240219095729.2339914-2-vschneid@redhat.com>
In-Reply-To: <20240219095729.2339914-2-vschneid@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Feb 2024 15:42:37 +0100
Message-ID: <CANn89i+3-zgAkWukFavu1wgf1XG+K9U4BhJWw7H+QKwsfYL4WA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
To: Valentin Schneider <vschneid@redhat.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, mleitner@redhat.com, 
	David Ahern <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 10:57=E2=80=AFAM Valentin Schneider <vschneid@redha=
t.com> wrote:
>
> The TCP timewait timer is proving to be problematic for setups where sche=
duler
> CPU isolation is achieved at runtime via cpusets (as opposed to staticall=
y via
> isolcpus=3Ddomains).
>

..

>  void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
>  {
> +       /* This can race with tcp_time_wait() and dccp_time_wait(), as th=
e timer
> +        * is armed /after/ adding it to the hashtables.
> +        *
> +        * If this is interleaved between inet_twsk_hashdance() and inet_=
twsk_put(),
> +        * then this is a no-op: the timer will still end up armed.
> +        *
> +        * Conversely, if this successfully deletes the timer, then we kn=
ow we
> +        * have already gone through {tcp,dcpp}_time_wait(), and we can s=
afely
> +        * call inet_twsk_kill().
> +        */
>         if (del_timer_sync(&tw->tw_timer))
>                 inet_twsk_kill(tw);

I really do not think adding a comment will prevent races at netns dismantl=
e.

We need to make sure the timer is not rearmed, we want to be absolutely
sure that after inet_twsk_purge() we have no pending timewait sockets,
otherwise UAF will happen on the netns structures.

I _think_ that you need timer_shutdown_sync() here, instead of del_timer_sy=
nc()

